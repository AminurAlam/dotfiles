#!/bin/env python
# pyright: basic

import json
import os
import socket
import sys
from typing import override

SOCKET = os.environ["NIRI_SOCKET"]


class Window:
    """Represents a Niri window."""

    def __init__(
        self,
        id: int,
        title: str,
        app_id: str,
        layout: dict | None = None,
        is_focused: bool = False,
    ):
        self.id = id
        self.title = title
        self.app_id = app_id
        self.layout = layout
        self.is_focused = is_focused

    @override
    def __str__(self):
        return f"{self.app_id}: {self.title}"


class Workspace:
    """Represents a Niri workspace, tracks state."""

    def __init__(self, id: int, output: str):
        self.id = id
        self.output = output
        self.windows: dict[int, Window] = {}
        self.columns: list[dict[str, int]] = []
        self.focused_column: int | None = None

    def update_columns(self):
        """Computes the active column and total columns in this workspace."""
        new_cols = []
        for w in self.windows.values():
            pos = w.layout and w.layout.get("pos_in_scrolling_layout")
            size = w.layout and w.layout.get("window_size")
            if pos and size:
                new_cols.append({"pos": pos[0], "width": size[0]})
        self.columns = new_cols

    def add_window(self, w: Window):
        self.windows[w.id] = w

    def remove_window(self, win_id: int):
        self.windows.pop(win_id, None)

    def get_windows(self):
        return list(self.windows.values())

    def __str__(self):
        return str(list(self.windows))


class State:
    """Overall Niri state. Tracks workspaces."""

    def __init__(self):
        self.focused_workspace: int = 0
        self.active_workspaces: dict[str, int] = {}
        self.workspaces: dict[int, Workspace] = {}

    def get_workspace(self, output: str | None = None) -> Workspace | None:
        ws_id = self.active_workspaces.get(output) if output else self.focused_workspace
        return self.workspaces.get(ws_id) if ws_id else None

    def update_workspaces(self, workspaces: list[dict]):
        """Takes a new list of 'canonical' workspaces and updates the internal list to match it."""
        current_ids = set()
        for ws_info in workspaces:
            ws_id = ws_info["id"]
            output = ws_info["output"]
            if ws_id not in self.workspaces:
                self.workspaces[ws_id] = Workspace(ws_id, output)
            if ws_info.get("is_focused"):
                self.focused_workspace = ws_id
            if ws_info.get("is_active"):
                self.active_workspaces[output] = ws_id
            current_ids.add(ws_id)
        # Drop removed workspaces
        for ws_id in list(self.workspaces.keys()):
            if ws_id not in current_ids:
                self.workspaces.pop(ws_id)

    def update_window(self, win: dict):
        """Takes a window, finds it by ID in internal tracking and updates its attributes."""
        ws_id = win["workspace_id"]
        w = Window(
            id=win["id"],
            title=win.get("title") or "",
            app_id=win.get("app_id") or "",
            layout=win.get("layout"),
            is_focused=win.get("is_focused", False),
        )
        if ws_id in self.workspaces:
            self.workspaces[ws_id].add_window(w)

    def remove_window(self, win_id: int):
        for ws in self.workspaces.values():
            if win_id in ws.windows:
                ws.remove_window(win_id)
                break

    def refresh_layout_state(self):
        """Update column information for all workspaces."""
        for ws in self.workspaces.values():
            ws.update_columns()
        self.update_focused_column()

    def update_focused_column(self):
        for ws in self.workspaces.values():
            ws.focused_column = None
            for w in ws.windows.values():
                if w.is_focused:
                    pos = w.layout and w.layout.get("pos_in_scrolling_layout")
                    if pos:
                        ws.focused_column = pos[0]


state = State()


def gen_json(output=None) -> dict:
    """Generates display text for Waybar in JSON format."""
    ws = state.get_workspace(output)
    if not ws:
        return {"text": ""}

    ws.update_columns()

    icons = ""
    for col in sorted(ws.columns, key=lambda x: x["pos"]):
        char = "█" if ws.focused_column == col["pos"] else "🮘"
        content = char * round(col["width"] / 480)
        icons += f"{content} "

    return {"text": icons, "class": "win"}


def handle_message(event: dict) -> bool:
    """Handle events from Niri stream."""
    if not event:
        return False
    event_type = next(iter(event))
    payload = event[event_type]
    should_display = True

    match event_type:
        case "WorkspacesChanged":
            state.update_workspaces(payload["workspaces"])

        case "WindowsChanged":
            for win in payload["windows"]:
                state.update_window(win)
            state.refresh_layout_state()

        case "WorkspaceActivated":
            if payload.get("focused"):
                state.focused_workspace = payload["id"]
            state.active_workspaces[state.workspaces[payload["id"]].output] = payload["id"]

        case "WindowOpenedOrChanged":
            win = payload["window"]
            state.remove_window(win["id"])
            state.update_window(win)
            state.refresh_layout_state()

        case "WindowClosed":
            state.remove_window(payload["id"])
            state.refresh_layout_state()

        case "WindowFocusChanged":
            focused_id = payload["id"]
            for ws in state.workspaces.values():
                for w in ws.windows.values():
                    w.is_focused = w.id == focused_id
            state.update_focused_column()

        case "WindowLayoutsChanged":
            for win_id, layout in payload["changes"]:
                for ws in state.workspaces.values():
                    if win_id in ws.windows:
                        ws.windows[win_id].layout = layout
            state.refresh_layout_state()

        case _:
            should_display = False

    return should_display


def main():
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as client:
        client.connect(SOCKET)
        client.sendall(b'"EventStream"\n')
        client.shutdown(socket.SHUT_WR)

        while True:
            data = client.recv(4096)
            if not data:
                continue
            for line in data.split(b"\n"):
                if not line.strip():
                    continue
                event = json.loads(line)
                handle_message(event)
                print(json.dumps(gen_json(), ensure_ascii=False), flush=True)


if __name__ == "__main__":
    main()

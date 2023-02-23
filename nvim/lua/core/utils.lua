local M = {}

M.map = function(mode)
    return function(lhs, rhs, opts)
        vim.keymap.set(
            mode,
            lhs,
            rhs,
            vim.tbl_extend('force', {
                noremap = true,
                silent = true,
            }, opts or {})
        )
    end
end

M.rsplit = function(str, sep)
    local str_parts = vim.fn.split(str, sep) ---@type table
    return str_parts[#str_parts] ---@type string
end

M.fish_path = function(path)
    local mod_path = vim.fn.fnamemodify(path, ':~')
    return string.gsub(mod_path, '/(%.?.)[^/]*', '/%1', vim.fn.count(mod_path, '/') - 1)
end

M.rsplit_alt = function(str, sep)
    local match = str:match('^.+(' .. sep .. '.+)$')
    local ext = ''
    if match ~= nil then ext = match:sub(2) end
    print(ext)
    return ext
end

M.git = function() return #vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';') > 0 end

M.icons = {
    kind = {
        Text = '',
        Method = 'm',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
        Key = '',
        Namespace = '',
        Package = '',
    },
    type = {
        Array = '',
        Number = '',
        String = '',
        Boolean = '蘒',
        Object = '',
        Null = 'ﳠ',
    },
    documents = {
        File = '',
        Files = '',
        Folder = '',
        OpenFolder = '',
    },
    git = {
        Add = '',
        Mod = '',
        Remove = '',
        Ignore = '',
        Rename = '',
        Diff = '',
        Repo = '',
        Octoface = '',
        LineAdded = '',
        LineModified = '',
        LineRemoved = '',
        FileDeleted = '',
        FileIgnored = '◌',
        FileRenamed = '➜',
        FileStaged = 'S',
        FileUnmerged = '',
        FileUnstaged = '',
        FileUntracked = 'U',
        Branch = '',
    },
    ui = {
        Rotate = '',
        RoundClose = '',
        Close = '',
        ArrowClosed = '',
        ArrowOpen = '',
        Lock = '',
        Lock2 = '',
        Circle = '',
        BigCircle = '',
        BigUnfilledCircle = '',
        NewFile = '',
        Search = '',
        Search2 = '',
        Lightbulb = '',
        Project = '',
        Dashboard = '',
        History = '',
        Comment = '',
        Bug = '',
        Code = '',
        Telescope = '',
        Gear = '',
        Package = '',
        List = '',
        SignIn = '',
        SignOut = '',
        Check = '',
        Fire = '',
        Note = '',
        BookMark = '',
        Pencil = '',
        ChevronRight = '',
        Table = '',
        Calendar = '',
        CloudDownload = '',
        ArrowCircleDown = '',
        ArrowCircleLeft = '',
        ArrowCircleRight = '',
        ArrowCircleUp = '',
        BoldArrowDown = '',
        BoldArrowLeft = '',
        BoldArrowRight = '',
        BoldArrowUp = '',
        BoldClose = '',
        BoldDividerLeft = '',
        BoldDividerRight = '',
        BoldLineLeft = '▎',
        BoxChecked = '',
        Stacks = ' ',
        Scopes = '',
        Watches = '',
        Keyboard = '',
        DebugConsole = ' ',
        ChevronShortDown = '',
        ChevronShortLeft = '',
        ChevronShortRight = '',
        ChevronShortUp = '',
        DividerLeft = '',
        DividerRight = '',
        DoubleChevronRight = '»',
        Ellipsis = '…',
        EmptyFolder = '',
        EmptyFolderOpen = '',
        File = '',
        FileSymlink = '',
        Files = '',
        FindFile = '',
        FindText = '',
        Folder = '',
        FolderOpen = '',
        FolderSymlink = '',
        Forward = '',
        LineLeft = '▏',
        LineMiddle = '│',
        Plus = '',
        Tab = '',
        Target = '',
        Text = '',
        Tree = '',
        Triangle = '契',
        TriangleShortArrowDown = '',
        TriangleShortArrowLeft = '',
        TriangleShortArrowRight = '',
        TriangleShortArrowUp = '',
        Recent = '',
    },
    diagnostics = {
        BoldError = '',
        Error = '',
        BoldWarning = '',
        Warning = '',
        BoldInformation = '',
        Information = '',
        BoldQuestion = '',
        Question = '',
        BoldHint = '',
        Hint = '',
        Debug = '',
        Trace = '✎',
    },
    misc = {
        Robot = 'ﮧ',
        Squirrel = '',
        Tag = '',
        Watch = '',
        Smiley = 'ﲃ',
        Package = '',
        CircuitBoard = '',
    },
}

return M
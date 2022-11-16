-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet
-- vim.g.use_nerd_icons = false
-- if vim.fn.has "mac" == 1 or vim.g.use_nerd_icons then
-- elseif vim.fn.has "mac" == 1 then
return {
    kind = {
        Text = '',
        Method = 'm',
        Function = '',
        Constructor = '',
        -- Method = '',
        -- Function = '',
        -- Constructor = '',
        Field = '',
        -- Variable = "",
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        -- Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        -- Keyword = '',
        Snippet = '',
        -- Snippet = '',
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
        -- ChevronRight = '>',
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
-- else
--   --   פּ ﯟ   蘒練 some other good icons
--   return {
--     kind = {
--       Text = " ",
--       Method = " ",
--       Function = " ",
--       Constructor = " ",
--       Field = " ",
--       Variable = " ",
--       Class = " ",
--       Interface = " ",
--       Module = " ",
--       Property = " ",
--       Unit = " ",
--       Value = " ",
--       Enum = " ",
--       Keyword = " ",
--       Snippet = " ",
--       Color = " ",
--       File = " ",
--       Reference = " ",
--       Folder = " ",
--       EnumMember = " ",
--       Constant = " ",
--       Struct = " ",
--       Event = " ",
--       Operator = " ",
--       TypeParameter = " ",
--       Misc = " ",
--     },
--     type = {
--       Array = " ",
--       Number = " ",
--       String = " ",
--       Boolean = " ",
--       Object = " ",
--     },
--     documents = {
--       File = " ",
--       Files = " ",
--       Folder = " ",
--       OpenFolder = " ",
--     },
--     git = {
--       Add = " ",
--       Mod = " ",
--       Remove = " ",
--       Ignore = " ",
--       Rename = " ",
--       Diff = " ",
--       Repo = " ",
--       Octoface = " ",
--     },
--     ui = {
--       ArrowClosed = "",
--       ArrowOpen = "",
--       Lock = " ",
--       Circle = " ",
--       BigCircle = " ",
--       BigUnfilledCircle = " ",
--       Close = " ",
--       NewFile = " ",
--       Search = " ",
--       Lightbulb = " ",
--       Project = " ",
--       Dashboard = " ",
--       History = " ",
--       Comment = " ",
--       Bug = " ",
--       Code = " ",
--       Telescope = " ",
--       Gear = " ",
--       Package = " ",
--       List = " ",
--       SignIn = " ",
--       SignOut = " ",
--       NoteBook = " ",
--       Check = " ",
--       Fire = " ",
--       Note = " ",
--       BookMark = " ",
--       Pencil = " ",
--       ChevronRight = "",
--       Table = " ",
--       Calendar = " ",
--       CloudDownload = " ",
--     },
--     diagnostics = {
--       Error = " ",
--       Warning = " ",
--       Information = " ",
--       Question = " ",
--       Hint = " ",
--     },
--     misc = {
--       Robot = " ",
--       Squirrel = " ",
--       Tag = " ",
--       Watch = " ",
--       Smiley = " ",
--       Package = " ",
--       CircuitBoard = " ",
--     },
--   }
-- end

if vim.g.loaded_undotree_nvim then
    return
end
vim.g.loaded_undotree_nvim = true

--=================================================
--Options:

-- Window layout
-- style 1
-- +----------+------------------------+
-- |          |                        |
-- |          |                        |
-- | undotree |                        |
-- |          |                        |
-- |          |                        |
-- +----------+                        |
-- |          |                        |
-- |   diff   |                        |
-- |          |                        |
-- +----------+------------------------+
-- Style 2
-- +----------+------------------------+
-- |          |                        |
-- |          |                        |
-- | undotree |                        |
-- |          |                        |
-- |          |                        |
-- +----------+------------------------+
-- |                                   |
-- |   diff                            |
-- |                                   |
-- +-----------------------------------+
-- Style 3
-- +------------------------+----------+
-- |                        |          |
-- |                        |          |
-- |                        | undotree |
-- |                        |          |
-- |                        |          |
-- |                        +----------+
-- |                        |          |
-- |                        |   diff   |
-- |                        |          |
-- +------------------------+----------+
-- Style 4
-- +-----------------------++----------+
-- |                        |          |
-- |                        |          |
-- |                        | undotree |
-- |                        |          |
-- |                        |          |
-- +------------------------+----------+
-- |                                   |
-- |                            diff   |
-- |                                   |
-- +-----------------------------------+
if !vim.g.undotree_WindowLayout then
    vim.g.undotree_WindowLayout = 1
end

-- e.g. using 'd' instead of 'days' to save some space.
if !vim.g.undotree_ShortIndicators then
    vim.g.undotree_ShortIndicators = 0
end

-- undotree window width
if !vim.g.undotree_SplitWidth then
    if vim.g.undotree_ShortIndicators == 1 then
        vim.g.undotree_SplitWidth = 24
    else
        vim.g.undotree_SplitWidth = 30
    end
end

-- diff window height
if !vim.g.undotree_DiffpanelHeight then
    vim.g.undotree_DiffpanelHeight = 10
end

--auto open diff window
if !vim.g.undotree_DiffAutoOpen then
    vim.g.undotree_DiffAutoOpen = 1
end

--if set, let undotree window get focus after being opened, otherwise
--focus will stay in current window.
if !vim.g.undotree_SetFocusWhenToggle then
    vim.g.undotree_SetFocusWhenToggle = 0
end

--tree node shape.
if !vim.g.undotree_TreeNodeShape then
    vim.g.undotree_TreeNodeShape = '*'
end

--tree vertical shape.
if !vim.g.undotree_TreeVertShape then
    vim.g.undotree_TreeVertShape = '|'
end

--tree split shape.
if !vim.g.undotree_TreeSplitShape then
    vim.g.undotree_TreeSplitShape = '/'
end

--tree return shape.
if !vim.g.undotree_TreeReturnShape then
    vim.g.undotree_TreeReturnShape = '\''
end

if !vim.g.undotree_DiffCommand then
    vim.g.undotree_DiffCommand = "diff"
end

--relative timestamp
if !vim.g.undotree_RelativeTimestamp then
    vim.g.undotree_RelativeTimestamp = 1
end

--Highlight changed text
if !vim.g.undotree_HighlightChangedText then
    vim.g.undotree_HighlightChangedText = 1
end

--Highlight changed text using signs in the gutter
if !vim.g.undotree_HighlightChangedWithSign then
    vim.g.undotree_HighlightChangedWithSign = 1
end

--Highlight linked syntax type.
--You may chose your favorite through ":hi" command
if !vim.g.undotree_HighlightSyntaxAdd then
    vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"
end
if !vim.g.undotree_HighlightSyntaxChange then
    vim.g.undotree_HighlightSyntaxChange = "DiffChange"
end
if !vim.g.undotree_HighlightSyntaxDel then
    vim.g.undotree_HighlightSyntaxDel = "DiffDelete"
end

--Deprecates the old style configuration.
if vim.g.undotree_SplitLocation then
    vim.notify("g:undotree_SplitLocation is deprecated, please use g:undotree_WindowLayout instead.")
end

--Show help line
if !vim.g.undotree_HelpLine then
    vim.g.undotree_HelpLine = 1
end

--Show cursorline
if !vim.g.undotree_CursorLine then
    vim.g.undotree_CursorLine = 1
end

--Define the default persistence undo directory if not defined in vim/nvim
--startup script.
if !vim.g.undotree_UndoDir then
    vim.s.undoDir = &undodir
    vim.s.subdir = has('nvim then ? 'nvim' : 'vim'')
    if vim.s.undoDir == "." then
        vim.s.undoDir = os.getenv("HOME") .. '/.local/state/' .. vim.s.subdir .. '/undo/'
    end
    vim.g.undotree_UndoDir = vim.s.undoDir
end

augroup undotreeDetectPersistenceUndo
    au!
    au BufReadPost * call undotree#UndotreePersistUndo(0)
augroup END

"=================================================
--User commands.
command! -nargs=0 -bar UndotreeToggle      :call undotree#UndotreeToggle()
command! -nargs=0 -bar UndotreeHide        :call undotree#UndotreeHide()
command! -nargs=0 -bar UndotreeShow        :call undotree#UndotreeShow()
command! -nargs=0 -bar UndotreeFocus       :call undotree#UndotreeFocus()
command! -nargs=0 -bar UndotreePersistUndo :call undotree#UndotreePersistUndo(1)

--vim: set et fdm=marker sts=4 sw=4:

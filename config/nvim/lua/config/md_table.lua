local M = {}

-- テーブル範囲（開始/終了行）を取得
local function find_table_range()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local buf = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local start_line, end_line

    for i = row, 1, -1 do
        if not buf[i]:match("^|") then break end
        start_line = i
    end
    for i = row, #buf do
        if not buf[i]:match("^|") then break end
        end_line = i
    end

    return start_line, end_line
end

-- 1 行をセル配列に
local function split_cells(line)
    local cells = {}


    local matched = {}
    for v in line:gmatch("|%s*([^|]*)%s*") do
        local text = v

        if v == "" then
            text = "       "
        end

        table.insert(matched,text)
    end

    --print(vim.inspect(matched))

    for i =1, #matched -1  do
        table.insert(cells, matched[i])
    end
    return cells
end

-- セル配列を Markdown 行に
local function build_line(cells)
    return "| " .. table.concat(cells, "| ") .. "|"
end

-- テーブル全体をセル配列の配列に
local function parse_table(start_row, end_row)
    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
    local parsed = {}
    for _, line in ipairs(lines) do
        table.insert(parsed, split_cells(line))
    end
    return parsed
end

-- 変更後を書き込む
local function write_table(start_row, end_row, cells)
    local out = {}
    for _, row_cells in ipairs(cells) do
        table.insert(out, build_line(row_cells))
    end
    vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, out)
end

-- 行追加（カーソル行の下に空行を追加）
function M.insert_row_below()
    local s, e = find_table_range()
    if not s or not e then
        vim.notify("Not in a markdown table", vim.log.levels.WARN)
        return
    end
    -- ヘッダー/区切り行は追加しない
    if cursor == s or cursor == s + 1 then
        vim.notify("Cannot add header or separator", vim.log.levels.WARN)
        return
    end

    local cursor = vim.api.nvim_win_get_cursor(0)[1]
    local cells = parse_table(s, e)

    local base_cols = #cells[1]  -- ヘッダーの列数
    local new_row = {}
    for _ = 1, base_cols do
        table.insert(new_row, "       ")
    end

    -- カーソル行の下に挿入
    local insert_idx = cursor - s + 2
    table.insert(cells, insert_idx, new_row)

    write_table(s, e, cells)
end

-- 行削除（現在行）
function M.delete_row()
    local s, e = find_table_range()
    if not s or not e then
        vim.notify("Not in a markdown table", vim.log.levels.WARN)
        return
    end

    local cursor = vim.api.nvim_win_get_cursor(0)[1]
    -- ヘッダー/区切り行は消さない
    if cursor == s or cursor == s + 1 then
        vim.notify("Cannot delete header or separator", vim.log.levels.WARN)
        return
    end

    vim.api.nvim_buf_set_lines(0, cursor - 1, cursor, false, {})
end

-- 列追加（カーソル列の右）
function M.insert_col_right()
    local s, e = find_table_range()
    if not s or not e then
        vim.notify("Not in a markdown table", vim.log.levels.WARN)
        return
    end

    local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
    local cells = parse_table(s, e)

    -- セルインデックス推定
    local idx = 1
    local acc = 0
    for i, text in ipairs(cells[1]) do
        acc = acc + #text + 3
        if cursor_col < acc then
            idx = i + 1
            break
        end
    end

    -- 全行で idx 列右に空列追加
    for i, row in ipairs(cells) do
        local text = "       "

        if i == 1 then
            text = "Header "
        elseif i == 2 then
            text = "------ "
        end

        table.insert(row, idx, text)
    end

    write_table(s, e, cells)
end

-- 列削除（カーソル列）
function M.delete_col()
    local s, e = find_table_range()
    if not s or not e then
        vim.notify("Not in a markdown table", vim.log.levels.WARN)
        return
    end

    local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
    local cells = parse_table(s, e)

    -- セルインデックス推定
    local idx = 1
    local acc = 0
    for i, text in ipairs(cells[1]) do
        acc = acc + #text + 3
        if cursor_col < acc then
            idx = i
            break
        end
    end

    -- 全行で idx 列を削除（存在すれば）
    for _, row in ipairs(cells) do
        if #row >= idx then
            table.remove(row, idx)
        end
    end

    write_table(s, e, cells)
end

-- n 行 m 列のテーブルを生成
function M.insert_table_dynamic()
    -- ユーザーに行数・列数を聞く
    local rows = tonumber(vim.fn.input("Rows: "))
    local cols = tonumber(vim.fn.input("Cols: "))
    if not (rows and cols) or rows < 1 or cols < 1 then
        vim.notify("Invalid size", vim.log.levels.ERROR)
        return
    end

    -- ヘッダー行
    local header = {}
    for _ = 1, cols do
        table.insert(header, "Header")
    end

    -- 区切り行
    local sep = {}
    for _ = 1, cols do
        table.insert(sep, "------")
    end

    -- テーブル本体
    local lines = {
        "| " .. table.concat(header, " | ") .. " |",
        "| " .. table.concat(sep, " | ") .. " |"
    }

    -- データ行
    for _ = 1, rows do
        local row = {}
        for _ = 1, cols do
            table.insert(row, "      ")
        end
        table.insert(lines, "| " .. table.concat(row, " | ") .. " |")
    end

    -- カーソル位置に挿入
    vim.api.nvim_buf_set_lines(0,
    vim.api.nvim_win_get_cursor(0)[1],
    vim.api.nvim_win_get_cursor(0)[1],
    false,
    lines
)
end

return M
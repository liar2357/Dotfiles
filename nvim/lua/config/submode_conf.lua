-- lua/config/submode_conf.lua
local M = {}

-- toggleterm を開いてコマンド実行する共通関数
local function exec_in_toggleterm(cmd, cwd)
  vim.cmd("TermExec cmd='" .. cmd .. "'")
end

-- 言語ごとの実行ロジック
function M.run_for_ft()
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")

  if ft == "rust" then
    exec_in_toggleterm("cargo run")
  elseif ft == "javascript" or ft == "typescript" then
    exec_in_toggleterm("node " .. file)
  elseif ft == "typescriptreact" or ft == "javascriptreact" then
    exec_in_toggleterm("npm start")
  elseif ft == "c" then
    exec_in_toggleterm("gcc " .. file .. " -o /tmp/a.out && /tmp/a.out")
  elseif ft == "cpp" then
    exec_in_toggleterm("g++ " .. file .. " -o /tmp/a.out && /tmp/a.out")
  elseif ft == "cs" then
    exec_in_toggleterm("dotnet run")
  elseif ft == "java" then
    local base = vim.fn.expand("%:t:r")
    exec_in_toggleterm("javac " .. file .. " && java " .. base)
  elseif ft == "php" then
    exec_in_toggleterm("php " .. file)
  elseif ft == "ruby" then
    exec_in_toggleterm("ruby " .. file)
  elseif ft == "python" then
    exec_in_toggleterm("python3 " .. file)
  elseif ft == "bash" then
    exec_in_toggleterm("bash " .. file)
  else
    print("No run action for filetype: " .. ft)
  end
end

return M
local hostname = io.popen("hostname"):read("*l")

if hostname == "ALPG-2512" then
  require("host.ALPG-2512")
elseif hostname == "NLCP-2602" then
  require("host.NLCP-2602")
end

-- ############################################################
-- ### LINK CONFIG FILES
-- ############################################################

require("common.look_and_feel")
require("common.window_rule")
require("common.window_and_workspaces")
require("common.key_bindings")

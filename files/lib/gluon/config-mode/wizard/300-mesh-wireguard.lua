local cbi = require "luci.cbi"
local i18n = require "luci.i18n"
local uci = luci.model.uci.cursor()

local M = {}

function M.section(form)
  local msg = i18n.translate('Your internet connection can be used to establish an ' ..
                             'encrypted connection with other nodes. ' ..
                             'Enable this option if there are no other nodes reachable ' ..
                             'over WLAN in your vicinity or you want to make a part of ' ..
                             'your connection\'s bandwidth available for the network. ')
  local s = form:section(cbi.SimpleSection, nil, msg)

  local o

  o = s:option(cbi.Flag, "_meshvpn", i18n.translate("Use internet connection (wireguard mesh VPN)"))
  o.default = uci:get_bool("wireguard", "mesh_vpn", "enabled") and o.enabled or o.disabled
  o.rmempty = false

end

function M.handle(data)
  uci:set("wireguard", "mesh_vpn", "enabled", uci:get_bool("wireguard", "mesh_vpn", "enabled") )
  uci:save("wireguard")
  uci:commit("wireguard")

end

return M
--[[
    Jericho's system.print() extension -- https://github.com/Jericho1060
    Display content in lua chat channel with colors
    Source : https://github.com/Jericho1060/DualUniverse/blob/master/tools/console%20text%20colors.lua
]]
system.printColor = function(message, color) system.print('<span style="color:' .. color .. ';">' .. message .. '</span>') end
system.printPrimary = function(message) system.printColor(message, "#007bff") end
system.printSecondary = function(message) system.printColor(message, "#6c757d") end
system.printSuccess = function (message) system.printColor(message, "#28a745") end
system.printDanger = function (message) system.printColor(message, "#dc3545") end
system.printWarning = function (message) system.printColor(message, "#ffc107") end
system.printInfo = function (message) system.printColor(message, "#17a2b8") end
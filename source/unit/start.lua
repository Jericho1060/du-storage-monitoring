--[[
	LUA PARAMETERS
]]

containerMonitoringPrefix_screen1 = "MONIT_" --export: the prefix used to enable container monitoring and display on the 1st screen
containerMonitoringPrefix_screen2 = "s2_" --export: the prefix used to enable container monitoring and display on the 2nd screen
containerMonitoringPrefix_screen3 = "s3_" --export: the prefix used to enable container monitoring and display on the 3rd screen
containerMonitoringPrefix_screen4 = "s4_" --export: the prefix used to enable container monitoring and display on the 4th screen
containerMonitoringPrefix_screen5 = "s5_" --export: the prefix used to enable container monitoring and display on the 5th screen
containerMonitoringPrefix_screen6 = "s6_" --export: the prefix used to enable container monitoring and display on the 6th screen
containerMonitoringPrefix_screen7 = "s7_" --export: the prefix used to enable container monitoring and display on the 7th screen
containerMonitoringPrefix_screen8 = "s8_" --export: the prefix used to enable container monitoring and display on the 8th screen
containerMonitoringPrefix_screen9 = "s9_" --export: the prefix used to enable container monitoring and display on the 9th screen

container_proficiency_lvl = 3 --export: Talent level for Container Proficiency
container_fill_red_level = 10 --export: The percent fill below gauge will be red
container_fill_yellow_level = 50 --export: The percent fill below gauge will be yellow
groupByItemName = true --export: if enabled, this will group all entries with the same item name

--[[
	INIT
]]
prefixes = {
    containerMonitoringPrefix_screen1,
    containerMonitoringPrefix_screen2,
    containerMonitoringPrefix_screen3,
    containerMonitoringPrefix_screen4,
    containerMonitoringPrefix_screen5,
    containerMonitoringPrefix_screen6,
    containerMonitoringPrefix_screen7,
    containerMonitoringPrefix_screen8,
    containerMonitoringPrefix_screen9
}
core = nil
screens = {}
for slot_name, slot in pairs(unit) do
    if
    type(slot) == "table"
            and type(slot.export) == "table"
            and slot.getElementClass
    then
        if slot.getElementClass():lower():find("coreunit") then
            core = slot
        end
        if slot.getElementClass():lower() == 'screenunit' then
            slot.slotname = slot_name
            table.insert(screens,slot)
        end
    end
end
if #screens == 0 then
    system.printDanger("No Screen Detected")
else
    --sorting screens by slotname to be sure the display is not changing
    table.sort(screens, function(a,b) return a.slotname < b.slotname end)
    local plural = ""
    if #screens > 1 then plural = "s" end
    system.printSuccess(#screens .. " screen" .. plural .. " Connected")
end
if core == nil then
    system.printDanger("No Core Detected")
else
    system.printSuccess("Core Connected")
end
elementsIdList = {}
if core ~= nil then
    elementsIdList = core.getElementIdList()
    system.printInfo(#elementsIdList .. " elements on the construct")
end

unit.setTimer("screenRefresh", 1)

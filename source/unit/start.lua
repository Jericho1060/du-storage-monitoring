--[[
	LUA PARAMETERS
]]

containerMonitoringPrefix = "MONIT_" --export: the prefix used to enable container monitoring
container_proficiency_lvl = 3 --export: Talent level for Container Proficiency
container_fill_red_level = 10 --export: The percent fill below gauge will be red
container_fill_yellow_level = 50 --export: The percent fill below gauge will be yellow
groupByItemName = true --export: if enabled, this will group all entries with the same item name

--[[
	INIT
]]
core = nil
screen = nil
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
            screen = slot
        end
    end
end
if screen == nil then
    system.printDanger("No Screen Detected")
else
    system.printSuccess("Screen Connected")
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

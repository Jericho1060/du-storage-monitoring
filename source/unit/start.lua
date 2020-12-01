--[[
	LUA PARAMETERS
]]
useDatabankValues = true --export: if checked and if values were saved in databank, parmaters will be loaded from the databank, if not, following ones will be used

containerMonitoringPrefix_screen1 = "MONIT_" --export: the prefix used to enable container monitoring and display on the 1st screen
containerMonitoringPrefix_screen2 = "s2_" --export: the prefix used to enable container monitoring and display on the 2nd screen
containerMonitoringPrefix_screen3 = "s3_" --export: the prefix used to enable container monitoring and display on the 3rd screen
containerMonitoringPrefix_screen4 = "s4_" --export: the prefix used to enable container monitoring and display on the 4th screen
containerMonitoringPrefix_screen5 = "s5_" --export: the prefix used to enable container monitoring and display on the 5th screen
containerMonitoringPrefix_screen6 = "s6_" --export: the prefix used to enable container monitoring and display on the 6th screen
containerMonitoringPrefix_screen7 = "s7_" --export: the prefix used to enable container monitoring and display on the 7th screen
containerMonitoringPrefix_screen8 = "s8_" --export: the prefix used to enable container monitoring and display on the 8th screen
containerMonitoringPrefix_screen9 = "s9_" --export: the prefix used to enable container monitoring and display on the 9th screen

screenTitle1 = "title screen 1" --export: the title display on the 1st screen, not displayed if empty or equal to "-"
screenTitle2 = "title screen 2" --export: the title display on the 2nd screen, not displayed if empty or equal to "-"
screenTitle3 = "title screen 3" --export: the title display on the 3rd screen, not displayed if empty or equal to "-"
screenTitle4 = "title screen 4" --export: the title display on the 4th screen, not displayed if empty or equal to "-"
screenTitle5 = "title screen 5" --export: the title display on the 5th screen, not displayed if empty or equal to "-"
screenTitle6 = "title screen 6" --export: the title display on the 6th screen, not displayed if empty or equal to "-"
screenTitle7 = "title screen 7" --export: the title display on the 7th screen, not displayed if empty or equal to "-"
screenTitle8 = "title screen 8" --export: the title display on the 8th screen, not displayed if empty or equal to "-"
screenTitle9 = "title screen 9" --export: the title display on the 9th screen, not displayed if empty or equal to "-"

container_proficiency_lvl = 3 --export: Talent level for Container Proficiency
container_optimization_lvl = 0 --export: Talent level for Container Optimization
container_fill_red_level = 10 --export: The percent fill below gauge will be red
container_fill_yellow_level = 50 --export: The percent fill below gauge will be yellow
groupByItemName = true --export: if enabled, this will group all entries with the same item name

QuantityRoundedDecimals = 2 --export: maximum of decimals displayed for the quantity value
PercentRoundedDecimals = 2 --export: maximum of decimals displayed for the percent fill value
fontSize = 2 --export: the size of the text for all the screen
borderColor = "orange" --export: the color of the table border
verticalMode = false --export: enable to use on a vertical screen (not yet ready)
showGreen = true --export: if not enable, line with green gauge will be hidden
showYellow = true --export: if not enable, line with yellow gauge will be hidden
showRed = true --export: if not enable, line with red gauge will be hidden
showContainerNameColumn = false --export: show or not the column "Container Name"
showContainerCapacityColumn = false --export: show or not the column "Container Total Capacity"

--[[
	INIT
]]
options = {}
options.containerMonitoringPrefix_screen1 = containerMonitoringPrefix_screen1
options.containerMonitoringPrefix_screen2 = containerMonitoringPrefix_screen2
options.containerMonitoringPrefix_screen3 = containerMonitoringPrefix_screen3
options.containerMonitoringPrefix_screen4 = containerMonitoringPrefix_screen4
options.containerMonitoringPrefix_screen5 = containerMonitoringPrefix_screen5
options.containerMonitoringPrefix_screen6 = containerMonitoringPrefix_screen6
options.containerMonitoringPrefix_screen7 = containerMonitoringPrefix_screen7
options.containerMonitoringPrefix_screen8 = containerMonitoringPrefix_screen8
options.containerMonitoringPrefix_screen9 = containerMonitoringPrefix_screen9
options.screenTitle1 = screenTitle1
options.screenTitle2 = screenTitle2
options.screenTitle3 = screenTitle3
options.screenTitle4 = screenTitle4
options.screenTitle5 = screenTitle5
options.screenTitle6 = screenTitle6
options.screenTitle7 = screenTitle7
options.screenTitle8 = screenTitle8
options.screenTitle9 = screenTitle9
options.container_proficiency_lvl = container_proficiency_lvl
options.container_optimization_lvl = container_optimization_lvl
options.container_fill_red_level = container_fill_red_level
options.container_fill_yellow_level = container_fill_yellow_level
options.groupByItemName = groupByItemName
options.QuantityRoundedDecimals = QuantityRoundedDecimals
options.PercentRoundedDecimals = PercentRoundedDecimals
options.fontSize = fontSize
options.borderColor = borderColor
options.verticalMode = verticalMode
options.showGreen = showGreen
options.showYellow = showYellow
options.showRed = showRed
options.showContainerNameColumn = showContainerNameColumn
options.showContainerCapacityColumn = showContainerCapacityColumn

core = nil
databank = nil
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
        if slot.getElementClass():lower() == 'databankunit' then
            databank = slot
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
if databank == nil then
    system.printWarning("No Databank Detected")
else
    system.printSuccess("Databank Connected")
    if (databank.hasKey("options")) and (useDatabankValues == true) then
        local db_options = json.decode(databank.getStringValue("options"))
        for key, value in pairs(options) do
            if db_options[key] then options[key] = db_options[key] end
        end
        system.printSuccess("Options Loaded From Databank")
    else
        system.printWarning("Options Loaded From LUA Parameters")
    end
end
prefixes = {
    options.containerMonitoringPrefix_screen1,
    options.containerMonitoringPrefix_screen2,
    options.containerMonitoringPrefix_screen3,
    options.containerMonitoringPrefix_screen4,
    options.containerMonitoringPrefix_screen5,
    options.containerMonitoringPrefix_screen6,
    options.containerMonitoringPrefix_screen7,
    options.containerMonitoringPrefix_screen8,
    options.containerMonitoringPrefix_screen9
}
titles = {
    options.screenTitle1,
    options.screenTitle2,
    options.screenTitle3,
    options.screenTitle4,
    options.screenTitle5,
    options.screenTitle6,
    options.screenTitle7,
    options.screenTitle8,
    options.screenTitle9
}
elementsIdList = {}
if core ~= nil then
    elementsIdList = core.getElementIdList()
    system.printInfo(#elementsIdList .. " elements on the construct")
end

unit.setTimer("screenRefresh", 1)

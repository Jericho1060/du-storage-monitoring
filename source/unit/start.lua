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

system.print("---------------------------------")
system.print("DU-Storage-Monitoring version 2.0")
system.print("---------------------------------")

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
    system.print("No Screen Detected")
else
    --sorting screens by slotname to be sure the display is not changing
    table.sort(screens, function(a,b) return a.slotname < b.slotname end)
    local plural = ""
    if #screens > 1 then plural = "s" end
    system.print(#screens .. " screen" .. plural .. " Connected")
end
if core == nil then
    system.print("No Core Detected")
else
    system.print("Core Connected")
end
if databank == nil then
    system.print("No Databank Detected")
else
    system.print("Databank Connected")
    if (databank.hasKey("options")) and (useDatabankValues == true) then
        local db_options = json.decode(databank.getStringValue("options"))
        for key, value in pairs(options) do
            if db_options[key] then options[key] = db_options[key] end
        end
        system.print("Options Loaded From Databank")
    else
        system.print("Options Loaded From LUA Parameters")
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
end
storageIdList= {}
initIndex = 0
initFinished = false

--Nested Coroutines by Jericho
coroutinesTable  = {}
--all functions here will become a coroutine
MyCoroutines = {
    function()
        if not initFinished then
            system.print("Loading contructs elements (" .. #elementsIdList .. " elements detected)")
            for i = 0, #elementsIdList, 1 do
                initIndex = i
                local id = elementsIdList[i]
                local elementType = core.getElementTypeById(id):lower()
                if elementType:lower():find("container") then
                    table.insert(storageIdList, id)
                end
            end
            if initIndex == #elementsIdList then
                system.print(#storageIdList .. " storage elements identified")
                initFinished = true
            end
        end
    end,
    function()
        local storage_elements = {}
        for _,id in pairs(storageIdList) do
            local elementType = core.getElementTypeById(id)
            if elementType:lower():find("container") then
                local elementName = core.getElementNameById(id)
                if
                    elementName:lower():find(prefixes[1]:lower())
                    or elementName:lower():find(prefixes[2]:lower())
                    or elementName:lower():find(prefixes[3]:lower())
                    or elementName:lower():find(prefixes[4]:lower())
                    or elementName:lower():find(prefixes[5]:lower())
                    or elementName:lower():find(prefixes[6]:lower())
                    or elementName:lower():find(prefixes[7]:lower())
                    or elementName:lower():find(prefixes[8]:lower())
                    or elementName:lower():find(prefixes[9]:lower())
                    then
                    local container = {}
                    local splitted = strSplit(elementName, '_')
                    local name = splitted[2]
                    local ingredient = getIngredient(cleanName(name))
                    local container_size = "XS"
                    local container_amount = 1
                    local container_empty_mass = 0
                    local container_volume = 0
                    local contentQuantity = 0
                    local percent_fill = 0
                    if not elementType:lower():find("hub") then
                        local containerMaxHP = core.getElementMaxHitPointsById(id)
                        if containerMaxHP > 68000 then
                            container_size = "XXL"
                            container_empty_mass = getIngredient("Expanded Container XL").mass
                            container_volume = 512000 * (options.container_proficiency_lvl * 0.1) + 512000
                        elseif containerMaxHP > 33000 then
                            container_size = "XL"
                            container_empty_mass = getIngredient("Container XL").mass
                            container_volume = 256000 * (options.container_proficiency_lvl * 0.1) + 256000
                        elseif containerMaxHP > 17000 then
                            container_size = "L"
                            container_empty_mass = getIngredient("Container L").mass
                            container_volume = 128000 * (options.container_proficiency_lvl * 0.1) + 128000
                        elseif containerMaxHP > 7900 then
                            container_size = "M"
                            container_empty_mass = getIngredient("Container M").mass
                            container_volume = 64000 * (options.container_proficiency_lvl * 0.1) + 64000
                        elseif containerMaxHP > 900 then
                            container_size = "S"
                            container_empty_mass = getIngredient("Container S").mass
                            container_volume = 8000 * (options.container_proficiency_lvl * 0.1) + 8000
                        else
                            container_size = "XS"
                            container_empty_mass = getIngredient("Container XS").mass
                            container_volume = 1000 * (options.container_proficiency_lvl * 0.1) + 1000
                        end
                    else
                        if splitted[3] then
                            container_size = splitted[3]
                        end
                        if splitted[4] then
                            container_amount = splitted[4]
                        end
                        local volume = 0
                        if container_size:lower() == "xxl" then volume = 512000
                        elseif container_size:lower() == "xl" then volume = 256000
                        elseif container_size:lower() == "l" then volume = 128000
                        elseif container_size:lower() == "m" then volume = 64000
                        elseif container_size:lower() == "s" then volume = 8000
                        elseif container_size:lower() == "xs" then volume = 1000
                        end
                        container_volume = volume * (options.container_proficiency_lvl * 0.1) + volume
                        container_volume = container_volume * tonumber(container_amount)
                        container_empty_mass = getIngredient("Container Hub").mass
                    end
                    local totalMass = core.getElementMassById(id)
                    local contentMassKg = totalMass - container_empty_mass
                    container.id = id
                    container.realName = elementName
                    container.prefix = splitted[1] .. "_"
                    container.name = name
                    container.ingredient = ingredient
                    container.quantity = contentMassKg / (ingredient.mass - (ingredient.mass * (options.container_optimization_lvl * 0.05)))
                    container.volume = container_volume
                    container.percent = utils.round((ingredient.volume * container.quantity) * 100 / container_volume)
                    if ingredient.name == "unknown" then
                        container.percent = 0
                    end
                    table.insert(storage_elements, container)
                end
            end
        end

        -- group by name and screen
        local groupped = {}
        if groupByItemName then
            for _,v in pairs(storage_elements) do
                local prefix = v.prefix:lower()
                if groupped[prefix .. cleanName(v.ingredient.name)] then
                    groupped[prefix .. cleanName(v.ingredient.name)].quantity = groupped[prefix .. cleanName(v.ingredient.name)].quantity + v.quantity
                    groupped[prefix .. cleanName(v.ingredient.name)].volume = groupped[prefix .. cleanName(v.ingredient.name)].volume + v.volume
                    groupped[prefix .. cleanName(v.ingredient.name)].percent = (v.ingredient.volume * groupped[prefix .. cleanName(v.ingredient.name)].quantity) * 100 / groupped[prefix .. cleanName(v.ingredient.name)].volume
                else
                    groupped[prefix .. cleanName(v.ingredient.name)] = v
                end
            end
        else
            groupped = storage_elements
        end

        -- sorting by tier
        local tiers = {}
        tiers[1] = {} --tier 0 (thx to Belorion#3127 for pointing Oxygen and Hydrogen are Tier 0 and not 1)
        tiers[2] = {} --tier 1
        tiers[3] = {} --tier 2
        tiers[4] = {} --tier 3
        tiers[5] = {} --tier 4
        tiers[6] = {} --tier 5
        for _,v in pairs(groupped) do
            table.insert(tiers[v.ingredient.tier+1],v)
        end

        -- sorting by name
        for k,v in pairs(tiers) do
            table.sort(tiers[k], function(a,b) return a.ingredient.name:lower() < b.ingredient.name:lower() end)
        end

        if #screens > 0 then
            local widthUnit = "vw"
            local heightUnit = "vh"
            if options.verticalMode then
                widthUnit = "vh"
                heightUnit = "vw"
            end
            local css = [[
            <style>
            * {
            text-shadow: 1px 0 0 #000, -1px 0 0 #000, 0 1px 0 #000, 0 -1px 0 #000, 1px 1px #000, -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000;
        }
            ]]
            if options.verticalMode then
                css = css .. [[
                .container{
                width:100]] .. widthUnit .. [[;
                transform:rotate(-90deg);
                transform-origin:0% 0%;
                margin-top:100vh;
            }
                ]]
            end
            css = css .. [[
            .row {
            border-bottom:2px solid ]] .. options.borderColor .. [[;
            font-size: ]] .. tostring(options.fontSize) .. [[vw;
            width:100]] .. widthUnit .. [[;
        }
            </style>
            ]]
            for index, screen in pairs(screens) do
                local prefix = prefixes[index]
                local title = titles[index]
                local html = [[<div class="container">]]
                if (title:len() > 0) and (title ~= "-") then
                    html = html .. [[
                    <div class="row">
                    <div class="col text-center" style="font-size:5vw;">
                    ]] .. title .. [[
                    </div>
                    </div>
                    ]]
                end
                html = html .. [[
                <div class="row">
                <div class="col-1 text-center">Tier</div>
                ]]
                if options.showContainerNameColumn then
                    html = html .. [[<div class="col">Container Name</div>]]
                end
                if options.showContainerCapacityColumn then
                    html = html .. [[<div class="col">Capacity</div>]]
                end
                html = html .. [[
                <div class="col">Item Name</div>
                <div class="col">Amount</div>
                <div class="col-2 text-center">Percent Fill</div>
                </div>
                ]]

                for tier_k,tier in pairs(tiers) do
                    for _,container in pairs(tier) do
                        if container.prefix:lower():find(prefix:lower()) then
                            local gauge_color_class = "bg-success"
                            local text_color_class = "text-success"
                            local show = showGreen
                            if container.percent < options.container_fill_red_level then
                                gauge_color_class = "bg-danger"
                                text_color_class = "text-danger"
                                show = showRed
                            elseif  container.percent < options.container_fill_yellow_level then
                                gauge_color_class = "bg-warning"
                                text_color_class = "text-warning"
                                show = showYellow
                            end
                            if show == true then
                                html = html .. [[
                                <div class="row ]] .. text_color_class ..[[">
                                <div class="]] .. gauge_color_class .. [[" style="width:]] .. container.percent .. [[%;position:absolute;height:100%;">&nbsp;</div>
                                <div class="col-1 text-center">]] .. tier_k-1 .. [[</div>
                                ]]
                                if options.showContainerNameColumn then
                                    html = html .. [[<div class="col">]] .. container.realName .. "</div>"
                                end
                                if options.showContainerCapacityColumn then
                                    html = html .. [[<div class="col">]] .. format_number(utils.round(container.volume)) .. "</div>"
                                end
                                html = html .. [[
                                <div class="col">]] .. container.ingredient.name .. [[</div>
                                <div class="col">]] .. format_number(utils.round(container.quantity * (10 ^ options.QuantityRoundedDecimals)) / (10 ^ options.QuantityRoundedDecimals)) .. [[</div>
                                <div class="col-2 text-center">]] .. format_number(utils.round(container.percent * (10 ^ options.PercentRoundedDecimals)) / (10 ^ options.PercentRoundedDecimals)) .. [[%</div>
                                </div>
                                ]]
                            end
                        end
                    end
                end
                html = html .. [[</div>]]
                screen.setHTML(css .. bootstrap_css .. html)
            end
        end
    end
}

function initCoroutines()
    for _,f in pairs(MyCoroutines) do
        local co = coroutine.create(f)
        table.insert(coroutinesTable, co)
    end
end

initCoroutines()

runCoroutines = function()
    for i,co in ipairs(coroutinesTable) do
        if coroutine.status(co) == "dead" then
            coroutinesTable[i] = coroutine.create(MyCoroutines[i])
        end
        if coroutine.status(co) == "suspended" then
            assert(coroutine.resume(co))
        end
    end
end

MainCoroutine = coroutine.create(runCoroutines)
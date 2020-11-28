local storage_elements = {}
for _,id in pairs(elementsIdList) do
    local elementType = core.getElementTypeById(id)
    if elementType:lower():find("container") then
        local elementName = core.getElementNameById(id)
        if
        elementName:lower():find(containerMonitoringPrefix_screen1:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen2:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen3:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen4:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen5:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen6:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen7:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen8:lower())
                or elementName:lower():find(containerMonitoringPrefix_screen9:lower())
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
                if containerMaxHP > 17000 then
                    container_size = "L"
                    container_empty_mass = getIngredient("Container L").mass
                    container_volume = 128000 * (container_proficiency_lvl * 0.1) + 128000
                elseif containerMaxHP > 7900 then
                    container_size = "M"
                    container_empty_mass = getIngredient("Container M").mass
                    container_volume = 64000 * (container_proficiency_lvl * 0.1) + 64000
                elseif containerMaxHP > 900 then
                    container_size = "S"
                    container_empty_mass = getIngredient("Container S").mass
                    container_volume = 8000 * (container_proficiency_lvl * 0.1) + 8000
                else
                    container_size = "XS"
                    container_empty_mass = getIngredient("Container XS").mass
                    container_volume = 1000 * (container_proficiency_lvl * 0.1) + 1000
                end
            else
                if splitted[3] then
                    container_size = splitted[3]
                end
                if splitted[4] then
                    container_amount = splitted[4]
                end
                local volume = 0
                if container_size:lower() == "l" then volume = 128000
                elseif container_size:lower() == "m" then volume = 64000
                elseif container_size:lower() == "s" then volume = 8000
                elseif container_size:lower() == "xs" then volume = 1000
                end
                container_volume = volume * (container_proficiency_lvl * 0.1) + volume
                container_volume = container_volume * container_amount
                container_empty_mass = getIngredient("Container Hub").mass
            end
            local totalMass = core.getElementMassById(id)
            local contentMassKg = totalMass - container_empty_mass
            container.id = id
            container.realName = elementName
            container.prefix = splitted[1] .. "_"
            container.name = name
            container.ingredient = ingredient
            container.quantity = contentMassKg / ingredient.mass
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
tiers[1] = {}
tiers[2] = {}
tiers[3] = {}
tiers[4] = {}
tiers[5] = {}
for _,v in pairs(groupped) do
    table.insert(tiers[v.ingredient.tier],v)
end

-- sorting by name
for k,v in pairs(tiers) do
    table.sort(tiers[k], function(a,b) return a.ingredient.name:lower() < b.ingredient.name:lower() end)
end

if #screens > 0 then
    local widthUnit = "vw"
    local heightUnit = "vh"
    if verticalMode then
        widthUnit = "vh"
        heightUnit = "vw"
    end
    local css = [[
        <style>
    	   * {
    		  text-shadow: 1px 0 0 #000, -1px 0 0 #000, 0 1px 0 #000, 0 -1px 0 #000, 1px 1px #000, -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000;
    	   }
    ]]
    if verticalMode then
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
    		border-bottom:2px solid ]] .. borderColor .. [[;
    		font-size: ]] .. tostring(fontSize) .. [[vw;
    		width:100]] .. widthUnit .. [[;
		}
        </style>
    ]]
    for index, screen in pairs(screens) do
        local prefix = prefixes[index]
        local html = [[
            <div class="container">
                <div class="row">
                    <div class="col-1 text-center">Tier</div>
        ]]
        if showContainerNameColumn then
            html = html .. [[<div class="col">Container Name</div>]]
        end
        if showContainerCapacityColumn then
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
                    if container.percent < container_fill_red_level then
                        gauge_color_class = "bg-danger"
                        text_color_class = "text-danger"
                        show = showRed
                    elseif  container.percent < container_fill_yellow_level then
                        gauge_color_class = "bg-warning"
                        text_color_class = "text-warning"
                        show = showYellow
                    end
                    if show == true then
                        html = html .. [[
                        	<div class="row ]] .. text_color_class ..[[">
                        		<div class="]] .. gauge_color_class .. [[" style="width:]] .. container.percent .. [[%;position:absolute;height:100%;">&nbsp;</div>
                        		<div class="col-1 text-center">]] .. tier_k .. [[</div>
                        ]]
                        if showContainerNameColumn then
                            html = html .. [[<div class="col">]] .. container.realName .. "</div>"
                        end
                        if showContainerCapacityColumn then
                            html = html .. [[<div class="col">]] .. format_number(utils.round(container.volume)) .. "</div>"
                        end
                        html = html .. [[
                        		<div class="col">]] .. container.ingredient.name .. [[</div>
                        		<div class="col">]] .. format_number(utils.round(container.quantity * (10 ^ QuantityRoundedDecimals)) / (10 ^ QuantityRoundedDecimals)) .. [[</div>
                        		<div class="col-2 text-center">]] .. format_number(utils.round(container.percent * (10 ^ PercentRoundedDecimals)) / (10 ^ PercentRoundedDecimals)) .. [[%</div>
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
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
    local gaugePercentWidth = (gaugeWidth/1920)*100
    local widthUnit = "vw"
    local heightUnit = "vh"
    if verticalMode then
        gaugePercentWidth = ((gaugeWidth*1080/1920)/1080)*100
        widthUnit = "vh"
        heightUnit = "vw"
    end
    local css = [[
        <style>
    	   * {
    		  font-size: ]] .. tostring(fontSize) .. [[vw;
    		  text-shadow: 1px 0 0 #000, -1px 0 0 #000, 0 1px 0 #000, 0 -1px 0 #000, 1px 1px #000, -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000;
    	   }
    	   table { width:100]] .. widthUnit .. [[; ]]
    if verticalMode then
        css = css .. [[
        	transform:rotate(-90deg);
        	transform-origin:0% 0%;
        	margin-top:100vh;
        ]]
    end
    css = css .. [[}
    	   th, td { border:2px solid orange; }
            .text-orange{color:orange;}
    	   .text-red{color:red;}
            .bg-success{background-color: #28a745;}
            .bg-danger{background-color:#dc3545;}
            .bg-warning{background-color:#ffc107;}
            .bg-info{background-color:#17a2b8;}
            .bg-primary{background-color:#007bff;}
        </style>
    ]]
    for index, screen in pairs(screens) do
        local prefix = prefixes[index]
        local html = [[
            <table>
                <thead>
                    <tr>
                        <th>Tier</th>
        ]]
        if showContainerNameColumn then html = html .. "<th>Container Name</th>" end
        if showContainerCapacityColumn then html = html .. "<th>Capacity</th>" end
        html = html .. [[<th>Item Name</th>
        			 <th>Amount</th>
                        <th>Percent Fill</th>
                    </tr>
                </thead>
                <tbody>
        ]]

        for tier_k,tier in pairs(tiers) do
            for _,container in pairs(tier) do
                if container.prefix:lower():find(prefix:lower()) then
                    local gauge_color_class = "bg-success"
                    local text_color_class = ""
                    if container.percent < container_fill_red_level then
                        gauge_color_class = "bg-danger"
                        text_color_class = "text-red"
                    elseif  container.percent < container_fill_yellow_level then
                        gauge_color_class = "bg-warning"
                        text_color_class = "text-orange"
                    end
                    html = html .. [[
                        <tr>
                            <th>]] .. tier_k .. [[</th>
                        ]]
                    if showContainerNameColumn then
                        html = html .. "<th>" .. container.realName .. "</th>"
                    end
                    if showContainerCapacityColumn then
                        html = html .. "<th>" .. format_number(utils.round(container.volume)) .. "</th>"
                    end
                    html = html .. [[<th>]] .. container.ingredient.name .. [[</th>
                            <th>]] .. format_number(utils.round(container.quantity * (10 ^ QuantityRoundedDecimals)) / (10 ^ QuantityRoundedDecimals)) .. [[</th>
                            <th style="position:relative;width: ]] .. tostring(gaugePercentWidth) .. widthUnit .. [[;">
                                <div class="]] .. gauge_color_class .. [[" style="width:]] .. container.percent .. [[%;">&nbsp;</div>
                                <div class="]] .. text_color_class .. [[" style="position:absolute;width:100%;top:50%;font-weight:bold;transform:translateY(-50%);">
                                    ]] .. format_number(utils.round(container.percent * (10 ^ PercentRoundedDecimals)) / (10 ^ PercentRoundedDecimals)) .. [[%
                                </div>
                            </th>
                        </tr>
                    ]]
                end
            end
        end
        html = html .. [[</tbody></table>]]
        screen.setHTML(css .. html)
    end
end
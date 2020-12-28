--load all the machines from the core step by step to avoid CPU Load Errors

local maxForLoop = initIndex + maxAmountOfElementsLoadedBySecond
if maxForLoop > #elementsIdList then maxForLoop = #elementsIdList end
system.print("Loading elements from " .. initIndex .. " to " .. maxForLoop .. " on " .. #elementsIdList)

for i = initIndex, maxForLoop, 1 do
    initIndex = i
    local id = elementsIdList[i]
    local elementType = core.getElementTypeById(id):lower()
    if elementType:lower():find("container") then
        table.insert(storageIdList, id)
    end
end
if initIndex == #elementsIdList then
    unit.stopTimer("init")
end
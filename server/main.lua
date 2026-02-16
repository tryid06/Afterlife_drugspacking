GlobalState.Items = {}
local Inventory = exports[Config.Inventory]

local MAX_PACK_DISTANCE = 3.0

local function getRecipe(drugName, bagName)
	for i = 1, #Config.Items do
		local item = Config.Items[i]
		if item.name == drugName then
			for j = 1, #item.outputitems do
				local bag = item.outputitems[j]
				if bag.requireitem == bagName then
					return item, bag
				end
			end
		end
	end

	return nil, nil
end

local function isNearPlacedScale(playerId)
	local ped = GetPlayerPed(playerId)
	if ped <= 0 then
		return false
	end

	local playerCoords = GetEntityCoords(ped)
	local items = GlobalState.Items or {}

	for i = 1, #items do
		if #(playerCoords - items[i].coords) <= MAX_PACK_DISTANCE then
			return true
		end
	end

	return false
end

RegisterNetEvent('susidrugpack:AddItem', function(coords)
	if type(coords) ~= 'vector3' then
		return
	end

	local items = GlobalState.Items
	local key = #items + 1
	items[key] = {
		id = ('%s:%s'):format(source, key),
		coords = coords
	}
	GlobalState.Items = items
	Inventory:RemoveItem(source, Config.Scaleitem, 1)
end)

RegisterNetEvent('susidrugpack:RemoveItem', function(id)
	local items = GlobalState.Items
	for i = 1, #items do
		if items[i].id == id then
			Inventory:AddItem(source, Config.Scaleitem, 1)
			TriggerClientEvent('susidrugpack:RemoveLocalItem', -1, id)
			table.remove(items, i)
			break
		end
	end
	GlobalState.Items = items
end)

RegisterNetEvent('susidrugpack:PackItem', function(drugName, removeCount, bagName)
	if type(drugName) ~= 'string' or type(removeCount) ~= 'number' or type(bagName) ~= 'string' then
		return
	end

	if not isNearPlacedScale(source) then
		return
	end

	local recipe, bagRecipe = getRecipe(drugName, bagName)
	if not recipe or not bagRecipe then
		return
	end

	if removeCount ~= recipe.amountneeded then
		return
	end

	if Inventory:RemoveItem(source, drugName, removeCount) and Inventory:RemoveItem(source, bagName, 1) then
		for i = 1, #bagRecipe.rewarditem do
			Inventory:AddItem(source, bagRecipe.rewarditem[i].name, bagRecipe.rewarditem[i].amount)
		end
	end
end)

AddEventHandler('ox_inventory:usedItem', function(playerId, name)
	if name == Config.Scaleitem then
		TriggerClientEvent('susidrugpack:PlaceItem', playerId)
	end
end)

if Config.Inventory == 'qb-inventory' then
	local QBCore = exports['qb-core']:GetCoreObject()
	QBCore.Functions.CreateUseableItem(Config.Scaleitem, function(source)
		TriggerClientEvent('susidrugpack:PlaceItem', source)
	end)
end

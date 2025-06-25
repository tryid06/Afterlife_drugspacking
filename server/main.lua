GlobalState.Items = {}
local Inventory = exports[Config.Inventory]


RegisterNetEvent('ResourceName:AddItem', function (coords)
	local items = GlobalState.Items
	local key = #items+1
	items[key] = {
		id = tostring(source)..tostring(key),
		coords = coords
	}
	GlobalState.Items = items
	Inventory:RemoveItem(source, Config.Scaleitem, 1)
end)


RegisterNetEvent('ResourceName:RemoveItem', function (id)
	local items = GlobalState.Items
	for i = 1,#items do
		if items[i].id == id then
			Inventory:AddItem(source, Config.Scaleitem, 1)
			TriggerClientEvent('ResourceName:RemoveLocalItem',-1,id)
			table.remove(items,i)
			break;
		end
	end
	GlobalState.Items = items
end)


RegisterNetEvent('resourceName:PackItem', function (removename,removecount,removeitem2,rewarditem)
	if Inventory:RemoveItem(source, removename, removecount) and Inventory:RemoveItem(source, removeitem2, 1) then
	    for i = 1,#rewarditem do
		    Inventory:AddItem(source, rewarditem[i].name, rewarditem[i].amount)	
		end
	end
end)


AddEventHandler('ox_inventory:usedItem', function(playerId, name, slotId, metadata)
	if name == Config.Scaleitem then
		TriggerClientEvent('resourceName:PlaceItem', playerId)
	end
end)

if Config.Inventory == 'qb-inventory' then
	local QBCore = exports['qb-core']:GetCoreObject()
	QBCore.Functions.CreateUseableItem(Config.Scaleitem, function(source, item)
		TriggerClientEvent('resourceName:PlaceItem', source)
	end)
end

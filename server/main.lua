GlobalState.Items = {}



RegisterNetEvent('ResourceName:AddItem', function (coords)
	local items = GlobalState.Items
	local key = #items+1
	items[key] = {
		id = tostring(source)..tostring(key),
		coords = coords
	}
	GlobalState.Items = items
end)


RegisterNetEvent('ResourceName:RemoveItem', function (id)
	local items = GlobalState.Items
	for i = 1,#items do
		if items[i].id == id then
			TriggerClientEvent('ResourceName:RemoveLocalItem',-1,id)
			table.remove(items,i)
			break;
		end
	end
	GlobalState.Items = items
end)


RegisterNetEvent('resourceName:PackItem', function (removename,removecount,removeitem2,rewarditem)
	if exports.ox_inventory:RemoveItem(source, removename, removecount) and exports.ox_inventory:RemoveItem(source, removeitem2, 1) then
	    exports.ox_inventory:AddItem(source, rewarditem, 1)	
	end
end)
local state = 'none'
local globaldata

local PackingMenu = function(cdata)
	local options = {}
	state = 'packingmenu'

	for i = 1, #cdata.outputitems do
		local data = cdata.outputitems[i]

		local count = exports.ox_inventory:Search('count', data.requireitem)
		local weight = exports.ox_inventory:Items(data.requireitem).weight
		if count > 0 then count = false else count = true end

		options[#options + 1] = {
			disabled = count,
			id = { data = cdata, key = i },
			label = data.label,
			weight = weight / 1000,
			image = '../images/' .. data.requireitem .. '.png',
		}
	end

	NuiMessage('SendData', options)
end


OpenMenu = function()
	local options = {}
	state = 'mainmenu'

	local items = Config.Items
	for i = 1, #items do
		local data = items[i]
		local count = exports.ox_inventory:Search('count', data.name)

		if count >= data.amountneeded then
			local itemsdata = exports.ox_inventory:Items(data.name)

			options[#options + 1] = {
				id = data,
				label = data.label,
				weight = itemsdata.weight / 1000,
				image = '../images/' .. data.name .. '.png',
			}
		end
	end


	SetNuiFocus(true, true)
	NuiMessage('SendData', options)
end

RegisterNuiCallback('ReturnData', function(data, cb)
	if state == 'mainmenu' then
		PackingMenu(data)
	else
		SetNuiFocus(false,false)
		NuiMessage('SendData', false)
		if lib.progressBar({
				duration = 2000,
				label = 'Packing Item',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
					move = true,
					combat = true,
				}
			}) then
			local key = data.key
			local data = data.data
			TriggerServerEvent('resourceName:PackItem', data.name, data.amountneeded, data.outputitems[key].requireitem,
				data.outputitems[key].rewarditem)
		end
	end
	cb({})
end)


RegisterNuiCallback('resetnuifocus', function(data, cb)
	SetNuiFocus(false,false);
	cb({})
end)



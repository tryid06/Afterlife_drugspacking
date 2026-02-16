local state = 'none'

local function getAnimationConfig()
	return Config.animation or Config.animtion
end

local PackingMenu = function(cdata)
	local options = {}
	state = 'packingmenu'

	for i = 1, #cdata.outputitems do
		local data = cdata.outputitems[i]

		local count = exports.ox_inventory:Search('count', data.requireitem)
		local reqitem = exports.ox_inventory:Items(data.requireitem)
		local weight = 0
		if reqitem then
			weight = reqitem.weight
		end
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

	local animation = getAnimationConfig()
    RequestAnimDict(animation.animDict)
	while (not HasAnimDictLoaded(animation.animDict)) do Wait(0) end
	TaskPlayAnim(PlayerPedId(), animation.animDict, animation.anim, 1.0, 1.0, -1, 1, 1.0, true, true, true)

	PlaySoundFrontend(-1, 'Put_Away', 'Phone_SoundSet_Michael', 1)
	SetNuiFocus(true, true)
	NuiMessage('SendData', options)
end

RegisterNuiCallback('ReturnData', function(data, cb)
	PlaySoundFrontend(-1, 'Menu_Accept', 'Phone_SoundSet_Default', 1)

	if state == 'mainmenu' then
		PackingMenu(data)
	else
		SetNuiFocus(false, false)
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
			local selectedData = data.data
			TriggerServerEvent('susidrugpack:PackItem', selectedData.name, selectedData.amountneeded, selectedData.outputitems[key].requireitem)
		end
		ClearPedTasks(PlayerPedId())
	end
	cb({})
end)

RegisterNuiCallback('resetnuifocus', function(_, cb)
	ClearPedTasks(PlayerPedId())
	PlaySoundFrontend(-1, 'Put_Away', 'Phone_SoundSet_Michael', 1)
	SetNuiFocus(false, false)
	cb({})
end)

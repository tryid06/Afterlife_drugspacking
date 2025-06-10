local PackingMenu = function(cdata)
	local options = {}

	for i = 1, #cdata.outputitems do
		local data = cdata.outputitems[i]
		local count = exports.ox_inventory:Search('count', data.requireitem)
		if count > 0 then count = false else count = true end

		options[#options + 1] = {
			title = data.label,
			disabled = count,
			onSelect = function()

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
					TriggerServerEvent('resourceName:PackItem', cdata.name, cdata.amountneeded, data.requireitem,data.rewarditem)
				end
			end

		}
	end

	lib.registerContext({
		id = 'packingmenu',
		title = 'Packing Menu',
		options = options
	})

	lib.showContext('packingmenu')
end


OpenMenu = function()
	local options = {}

	local items = Config.Items
	for i = 1, #items do
		local data = items[i]
		local count = exports.ox_inventory:Search('count', data.name)

		if count >= data.amountneeded then
			options[#options + 1] = {
				title = data.label,
				onSelect = function()
					PackingMenu(data)
				end
			}
		end
	end

	lib.registerContext({
		id = 'weightscale',
		title = 'Weight Scale',
		options = options
	})
	lib.showContext('weightscale')
end

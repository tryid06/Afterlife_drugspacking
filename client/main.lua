---@param action string
---@param data any
NuiMessage = function(action, data)
    SendNUIMessage({
        action = action,
        data = data,
    })
end


local PlaceObject = function(coords)
	local modelHash = `bkr_prop_coke_scale_01`

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Wait(0)
		end
	end


	local obj = CreateObject(modelHash, coords, false)
	return obj
end
local PlaceItem = function()
	local Coords = false

	local obj = PlaceObject(GetEntityCoords(PlayerPedId()))
	SetEntityCollision(obj, false, false)

	NuiMessage("Instructions", true)
	while true do
		local hit, entityhit, endcoords, surfacenormal, materialhash = lib.raycast.fromCamera(511, 4, 4)
		SetEntityCoords(obj, endcoords.x, endcoords.y, endcoords.z)
		PlaceObjectOnGroundProperly(obj)
		CreateObject()

		if IsControlPressed(0, 38) then
			Coords = endcoords
			NuiMessage("Instructions", false)
			break
		end

		if IsControlPressed(0, 202) then
			NuiMessage("Instructions", false)
			break
		end
		Wait(0)
	end

	DeleteObject(obj)
	if Coords then
		TriggerServerEvent('ResourceName:AddItem', Coords)
	end
end


-- RegisterCommand('test', function()
-- 	OpenMenu()
-- end)



local localentities = {}



local AddLocalEntity = function(id, coords)
	if (not localentities[id]) then
		local entity = PlaceObject(coords)
		localentities[id] = entity

		local options = {
			{
				label = 'Use Scale',
				icon = 'weight-scale',
				onSelect = OpenMenu
			},
			{
				label = 'Remove Scale',
				icon = 'xmark',
				onSelect = function()
					TriggerServerEvent('ResourceName:RemoveItem',id)
				end
			}
		}
		exports.ox_target:addLocalEntity(entity, options)
	end
end

local RemoveLocalEntity = function(id)
	local entity = localentities[id]
	localentities[id] = nil
	if DoesEntityExist(entity) then
		DeleteObject(entity)
	end
end

local alreadyinzone = false

CreateThread(function()
	while true do
		local sleep = 500
		local items = GlobalState.Items
		local playercoords = GetEntityCoords(PlayerPedId())

		for i = 1, #items do
			local inzone = false
			local coords = items[i].coords

			local distance = #(playercoords - coords)

			if (distance < 20) then
				AddLocalEntity(items[i].id, items[i].coords)
				-- inzone = true
			else
				RemoveLocalEntity(items[i].id)
			end

			-- if inzone and not alreadyinzone then

			-- 	alreadyinzone = true
			-- end

			-- if not inzone and alreadyinzone then

			-- 	alreadyinzone = false
			-- end
		end
		Wait(sleep)
	end
end)




RegisterNetEvent('ResourceName:RemoveLocalItem', RemoveLocalEntity)
RegisterNetEvent('resourceName:PlaceItem', PlaceItem)

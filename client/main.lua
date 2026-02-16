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
	SetEntityAsMissionEntity(obj, true, true)
	return obj
end

local PlaceItem = function()
	local Coords = false

	local obj = PlaceObject(GetEntityCoords(PlayerPedId()))
	SetEntityCollision(obj, false, false)
	SetEntityDrawOutlineColor(10, 170, 210, 200)
	SetEntityDrawOutlineShader(1)
	SetEntityDrawOutline(obj, true)

	NuiMessage('Instructions', true)
	while true do
		local _, _, endcoords = lib.raycast.fromCamera(511, 4, 4)
		SetEntityCoords(obj, endcoords.x, endcoords.y, endcoords.z)

		if IsControlPressed(0, 38) then
			Coords = endcoords
			break
		end

		if IsControlPressed(0, 202) then
			break
		end
		Wait(0)
	end

	NuiMessage('Instructions', false)
	DeleteObject(obj)
	if Coords then
		PlaySoundFrontend(-1, 'Place_Prop_Success', 'DLC_Dmod_Prop_Editor_Sounds', 1)
		TriggerServerEvent('susidrugpack:AddItem', Coords)
	end
end

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
					PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
					TriggerServerEvent('susidrugpack:RemoveItem', id)
				end
			}
		}
		exports.ox_target:addLocalEntity(entity, options)
	end
end

local RemoveLocalEntity = function(id)
	local entity = localentities[id]
	localentities[id] = nil
	if entity and DoesEntityExist(entity) then
		DeleteObject(entity)
	end
end

CreateThread(function()
	while true do
		local items = GlobalState.Items or {}
		local playercoords = GetEntityCoords(PlayerPedId())

		for i = 1, #items do
			local coords = items[i].coords
			local distance = #(playercoords - coords)

			if (distance < 20) then
				AddLocalEntity(items[i].id, coords)
			else
				RemoveLocalEntity(items[i].id)
			end
		end

		Wait(500)
	end
end)

RegisterNetEvent('susidrugpack:RemoveLocalItem', RemoveLocalEntity)
RegisterNetEvent('susidrugpack:PlaceItem', PlaceItem)

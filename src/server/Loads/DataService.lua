local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Signal = require(ReplicatedStorage.Packages.Signal)
local ProfileService = require(ReplicatedStorage.Packages.ProfileService)
local Actions = require(ServerScriptService.Modules.Actions)
local ReplicateInitialData = ReplicatedStorage.Remotes.ReplicateInitialData
local ReplicateData = ReplicatedStorage.Remotes.ReplicateData

local PROFILE_TEMPLATE = {
	Money = 0,
	Air = 0,

	Stats = {
		ExchangeRate = 1,
		InventorySize = 20,
	},

	Equipped = {
		Lung = { Id = 1 },
		Slot1 = 0,
		Slot2 = 0,
		Slot3 = 0,
		Slot4 = 0,
	},
	Inventory = {},
}

local DataService = {}
DataService.ProfileStore = ProfileService.GetProfileStore("PlayerData", PROFILE_TEMPLATE)
DataService.ProfileLoaded = Signal.new()
DataService.Profiles = {}

function DataService.Init()
	for _, player in ipairs(Players:GetChildren()) do
		coroutine.wrap(DataService.LoadPlayer)(player)
	end

	Players.PlayerAdded:Connect(DataService.LoadPlayer)
	Players.PlayerRemoving:Connect(DataService.UnloadPlayer)
end

function DataService.LoadPlayer(player)
	local profile = DataService.ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile ~= nil then
		profile:AddUserId(player.UserId)
		profile:Reconcile()
		profile:ListenToRelease(function()
			DataService.Profiles[player] = nil
			player:Kick()
		end)
		if player:IsDescendantOf(Players) == true then
			DataService.InitProfile(player, profile)
		else
			profile:Release()
		end
	else
		player:Kick()
	end
end
function DataService.UnloadPlayer(player)
	local profile = DataService.Profiles[player]
	if profile ~= nil then
		profile:Release()
	end
end
function DataService.InitProfile(player, profile)
	DataService.Profiles[player] = profile
	DataService.ProfileLoaded:Fire(profile.Data)
	ReplicateInitialData:FireClient(player, profile.Data)
	print(player, profile.Data)
end

function DataService.GetData(player)
	return DataService.Profiles[player].Data
end
function DataService.ChangeData(player, actionName, actionData)
	local data = DataService.Profiles[player].Data
	local newData = Actions[actionName](data, actionData)
	player.Profiles[player].Data = newData
	ReplicateData:FireClient(player, newData)
	return newData
end

return DataService

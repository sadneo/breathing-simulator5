local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)
local ReplicateInitialData = ReplicatedStorage.Remotes.ReplicateInitialData
local ReplicateData = ReplicatedStorage.Remotes.ReplicateData

local DataManager = {}
DataManager.DataUpdated = Signal.new()
DataManager.Data = {}

function DataManager.Init()
	DataManager.Data = ReplicateInitialData.OnClientEvent:Wait()
	DataManager.DataUpdated:Fire(DataManager.Data)

	ReplicateData.OnClientEvent:Connect(function(data)
		DataManager.Data = data
		DataManager.DataUpdated:Fire(data)
	end)
end

function DataManager.GetData()
	return DataManager.Data
end

return DataManager

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Loader = require(ReplicatedStorage.Packages.Loader)
Loader.Load(ServerScriptService.Loads:GetChildren())

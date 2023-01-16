local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Router = require(ServerScriptService.Modules.Router)
local Routes = require(ServerScriptService.Modules.Routes)
local Remotes = ReplicatedStorage.Remotes

local RemoteService = {}
function RemoteService.Start()
	Router.SetFolder(Remotes)
	Router.AddRoutes(Routes)
end

return RemoteService
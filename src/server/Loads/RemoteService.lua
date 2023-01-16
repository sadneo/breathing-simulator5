local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")

local Loader = require(ReplicatedStorage.Packages.Loader)
local Router = require(ServerScriptService.Modules.Router)
local Routes = require(ServerScriptService.Modules.Routes)
local Remotes = ReplicatedStorage.Remotes

local RemoteService = {}
function RemoteService.Start()
	Router.SetFolder(Remotes)
	Router.AddRoutes(Routes)

	local DataService = Loader.GetLoad("DataService")
	for _, prompt in CollectionService:GetTagged("SellPrompt") do
		prompt.Triggered:Connect(function(player)
			DataService.ChangeData(player, "Sell")
		end)
	end
end

return RemoteService
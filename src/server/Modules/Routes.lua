local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Loader = require(ReplicatedStorage.Packages.Loader)

local Routes = {}
Routes.Breathe = function(player)
	local DataService = Loader.GetLoad("DataService")
	DataService.ChangeData(player, "Breathe")
end

return Routes

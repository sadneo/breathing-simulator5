local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Loader = require(ReplicatedStorage.Packages.Loader)

local Routes = {}
Routes.Breathe = function(player)
	local DataService = Loader.GetLoad("DataService")
	DataService.ChangeData(player, "Breathe")
end
Routes.EquipItem = function(player, index)
	local DataService = Loader.GetLoad("DataService")
	DataService.ChangeData(player, "EquipItem", {
		index = index,
	})
end
Routes.UnequipItem = function(player, slot)
	local DataService = Loader.GetLoad("DataService")
	DataService.ChangeData(player, "UnequipItem", {
		slot = slot,
	})
end
Routes.BuyItem = function(player, listingIndex)
	local DataService = Loader.GetLoad("DataService")
	DataService.ChangeData(player, "BuyItem", {
		listingIndex = listingIndex,
	})
end

return Routes

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EquipItem = ReplicatedStorage.Remotes.EquipItem
local UnequipItem = ReplicatedStorage.Remotes.UnequipItem
local BuyItem = ReplicatedStorage.Remotes.BuyItem

local ItemModule = {}
ItemModule.Context = {
	Lung = {
		Equipment = { "Unequip" },
		Inventory = { "Equip" },
		Shop = { "Buy" },
	},
}
ItemModule.ClientActions = {
	Equip = function(itemIndex)
		EquipItem:FireServer(itemIndex)
	end,
	Unequip = function(itemSlot)
		UnequipItem:FireServer(itemSlot)
	end,
	Buy = function(listingIndex) -- later, also send in the shop that you're buying from
		BuyItem:FireServer(listingIndex)
	end,
}
ItemModule.Item = {
	[1] = {
		Type = "Lung",
		Description = "Your lungs",
		Stats = {
			Air = 1,
		},
	},
	[2] = {
		Type = "Lung",
		Description = "Some better lungs",
		Stats = {
			Air = 3,
		},
	},
}

return ItemModule

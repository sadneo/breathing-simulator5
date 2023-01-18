local ItemModule = {}
ItemModule.Context = {
	Lung = {
		Equipped = { "Unequip" },
		Inventory = { "Equip" },
		Shop = { "Buy" },
	},
}
ItemModule.Item = {
	[1] = {
		Type = "Lung",
		Description = "Your lungs",
		Stats = {
			Air = 1,
		},
	},
	[1] = {
		Type = "Lung",
		Description = "Some better lungs",
		Stats = {
			Air = 3,
		},
	},
}

return ItemModule

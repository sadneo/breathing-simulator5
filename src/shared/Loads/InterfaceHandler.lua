local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Loader = require(ReplicatedStorage.Packages.Loader)
local Roact = require(ReplicatedStorage.Packages.Roact)
local ScreenGui = require(ReplicatedStorage.Components.ScreenGui)
local MenuMenu = require(ReplicatedStorage.Components.MenuMenu)
local Inventory = require(ReplicatedStorage.Components.Inventory)
local SelectContainer = ReplicatedStorage.Signals.SelectContainer

local InterfaceHandler = {}
function InterfaceHandler.Start()
	local DataManager = Loader.GetLoad("DataManager")
	local data = DataManager.GetData()

	local children = {}
	children.Inventory = Roact.createElement(Inventory, {
		equipment = data.Equipment,
		inventory = data.Inventory,
	})
	children.MenuMenu = Roact.createElement(MenuMenu, {
		buttons = {
			{
				name = "Inventory",
				mainText = "Items",
				bottomText = "C", -- TODO: make these keybinds automatic
				onClick = function()
					SelectContainer:Fire("Inventory")
				end,
			},
			{
				name = "Shop",
				mainText = "Shop",
				bottomText = "V",
				onClick = function()
					SelectContainer:Fire("Inventory")
				end,
			},
		},
	})

	local screenGui = Roact.createElement(ScreenGui, { children = children })
	Roact.mount(screenGui, Players.LocalPlayer.PlayerGui, "MainGui")
end

return InterfaceHandler

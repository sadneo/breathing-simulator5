local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local ScreenGui = require(ReplicatedStorage.Components.ScreenGui)
local MenuMenu = require(ReplicatedStorage.Components.MenuMenu)
local SelectContainer = ReplicatedStorage.Signals.SelectContainer

local InterfaceHandler = {}
function InterfaceHandler.Start()
	local children = {}
	children.MenuMenu = Roact.createElement(MenuMenu, {
		buttons = {
			{
				name = "Inventory",
				mainText = "Items",
				bottomText = "C",
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

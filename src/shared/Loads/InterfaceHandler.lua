local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local ScreenGui = require(ReplicatedStorage.Components.ScreenGui)

local InterfaceHandler = {}
function InterfaceHandler.Start()
	local children = {}

	local screenGui = Roact.createElement(ScreenGui, children)
	Roact.mount(screenGui, Players.LocalPlayer.PlayerGui, "MainGui")
end

return InterfaceHandler
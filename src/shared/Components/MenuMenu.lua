local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Panel = require(ReplicatedStorage.Components.Base.Panel)
local KeybindItem = require(ReplicatedStorage.Components.Item.KeybindItem)

local BUTTON_SIZE = 50
local GAP_SIZE = 5

local MenuMenu = function(props)
	props.buttons = props.buttons or {}

	local children = {}
	for _, button in ipairs(props.buttons) do
		local element = Roact.createElement(KeybindItem, {
			mainText = button.mainText,
			bottomText = button.bottomText,
			onClick = button.onClick,
		})
		children[button.name] = element
	end

	local h = #props.buttons * (BUTTON_SIZE + GAP_SIZE) + GAP_SIZE
	return Roact.createElement(Panel, {
		anchorPoint = Vector2.new(0, 1),
		position = UDim2.new(0, 10, 1, -10),
		size = UDim2.new(0, h, 0, 60),
		children = children,
	})
end

return MenuMenu

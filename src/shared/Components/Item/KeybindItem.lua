local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Item = require(ReplicatedStorage.Components.Item.Item)

local KeybindItem = function(props)
	local mainText = props.mainText
	local bottomText = props.bottomText
	local layoutOrder = props.layoutOrder
	local onClick = props.onClick

	return Roact.createElement(Item, {
		text = mainText,
		onClick = onClick,
		layoutOrder = props.layoutOrder,
		children = {
			TextLabel = Roact.createElement("TextLabel", {
				Text = bottomText,

				Font = Enum.Font.Roboto,
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 14,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(0.5, 0, 1, -5),
				Size = UDim2.fromOffset(15, 15),
				ZIndex = 2,
			}),
		},
	})
end

return KeybindItem

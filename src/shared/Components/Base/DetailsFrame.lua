local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Container = require(ReplicatedStorage.Components.Base.Container)
local Panel = require(ReplicatedStorage.Components.Base.Panel)
local Item = require(ReplicatedStorage.Components.Item.Item)
local ItemModule = require(ReplicatedStorage.Modules.ItemModule)

local DEFAULT_TEXT = "nothing"
local BUTTON_SIZE = 50
local GAP_SIZE = 5

local function generateText(data)
	return string.format("Type: %s\nDescription: %s", data.Type, data.Description)
end

local DetailsFrame = function(props)
	local anchorPoint = props.anchorPoint
	local position = props.position
	local size = props.size

	local context = props.context
	local item = props.item
	local location = props.location

	local text = DEFAULT_TEXT
	local buttons = {}
	if item then
		local data = ItemModule.Item[item.Id]
		text = generateText(data)

		local actions = ItemModule.Context[data.Type][context]
		for index, action in actions do
			buttons[index] = Roact.createElement(Item, {
				size = UDim2.fromOffset(BUTTON_SIZE, 30),
				text = action,
				layoutOrder = index,
				onClick = function()
					ItemModule.ClientActions[action](location)
				end,
			})
		end
	end

	local panelLength = BUTTON_SIZE * #buttons + GAP_SIZE * 2

	return Roact.createElement(Container, {
		anchorPoint = anchorPoint,
		position = position,
		size = size,
		children = {
			ActionPanel = Roact.createElement(Panel, {
				anchorPoint = Vector2.new(1, 0),
				position = UDim2.new(1, 0, 1, 10),
				size = UDim2.fromOffset(panelLength, 40),
				children = buttons,
			}),
			TextLabel = Roact.createElement("TextLabel", {
				Text = text,

				RichText = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, -10, 1, -10),
			}),
		},
	})
end

return DetailsFrame

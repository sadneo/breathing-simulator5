local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local MainContainer = require(ReplicatedStorage.Components.Base.MainContainer)
local ItemContainer = require(ReplicatedStorage.Components.Base.ItemContainer)
local Item = require(ReplicatedStorage.Components.Item.Item)
local DetailsFrame = require(ReplicatedStorage.Components.Base.DetailsFrame)
local ShopModule = require(ReplicatedStorage.Modules.ShopModule)

local Inventory = Roact.Component:extend("Inventory")

function Inventory:init(props)
	self:setState({
		shop = props.shop,
		selectedIndex = 1,
	})
end

-- Inventory:didMount() for changing the selectedShop and setting the selectedItem to 1

function Inventory:render()
	local selectedListing = ShopModule[self.state.shop][self.state.selectedIndex]

	local function selectItem(slot)
		self:setState({
			selectedIndex = slot,
		})
	end

	local items = {}
	for slot, item in ShopModule[self.state.shop] do
		items[slot] = Roact.createElement(Item, {
			text = item.Id,
			onClick = function()
				selectItem(slot)
			end,
		})
	end

	local children = {}
	children.MainContainer = Roact.createElement(ItemContainer, {
		anchorPoint = Vector2.new(0.5, 0.5),
		position = UDim2.fromScale(0.5, 0.5),
		size = UDim2.new(1, -20, 1, -20),
		scrollingEnabled = true,
		children = items,
	})
	children.DetailsFrame = Roact.createElement(DetailsFrame, {
		anchorPoint = Vector2.new(0, 0.5),
		position = UDim2.new(1, 20, 0.5, 0),
		size = UDim2.fromOffset(150, 300),
		item = selectedListing,
		context = "Shop",
		location = self.state.selectedIndex,
	})

	return Roact.createElement(MainContainer, {
		anchorPoint = Vector2.new(0.5, 0.5),
		position = UDim2.fromScale(0.5, 0.5),
		size = UDim2.fromOffset(400, 300),
		name = "Shop",
		children = children,
	})
end

return Inventory

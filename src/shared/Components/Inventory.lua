local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Loader = require(ReplicatedStorage.Packages.Loader)
local Roact = require(ReplicatedStorage.Packages.Roact)
local MainContainer = require(ReplicatedStorage.Components.Base.MainContainer)
local ItemContainer = require(ReplicatedStorage.Components.Base.ItemContainer)
local Item = require(ReplicatedStorage.Components.Item.Item)
local DetailsFrame = require(ReplicatedStorage.Components.Base.DetailsFrame)

local EQUIPMENT_ORDER = { "Lung", "Slot1", "Slot2", "Slot3", "Slot4" }

local Inventory = Roact.Component:extend("Inventory")

function Inventory:init(props)
	self:setState({
		selectedItem = nil,
		selectedCategory = nil,
		equipment = props.equipment,
		inventory = props.inventory,
	})
end

function Inventory:didMount()
	local DataManager = Loader.GetLoad("DataManager")
	DataManager.DataUpdated:Connect(function(data)
		self:setState({
			equipment = data.Equipment,
			inventory = data.Inventory,
		})
	end)
end

function Inventory:render()
	local selectedItem = nil
	if self.state.selectedItem then
		selectedItem = self.state[self.state.selectedCategory][self.state.selectedItem]
	end

	local context = (self.state.selectedCategory == "equipment" and "Equipment")
		or (self.state.selectedCategory == "inventory" and "Inventory")
		or "Nothing"

	local function selectItem(category, slot)
		self:setState({
			selectedItem = slot,
			selectedCategory = category,
		})
	end

	local equipment = {}
	for index, slot in EQUIPMENT_ORDER do
		local item = self.state.equipment[slot]
		if type(item) ~= "table" then
			equipment[slot] = Roact.createElement(Item, { text = "nothing", layoutOrder = index })
			continue
		end

		equipment[slot] = Roact.createElement(Item, {
			text = item.Id,
			layoutOrder = index,
			onClick = function()
				selectItem("equipment", slot)
			end,
		})
	end

	local inventory = {}
	for slot, item in self.state.inventory do
		inventory[slot] = Roact.createElement(Item, {
			text = item.Id,
			onClick = function()
				selectItem("inventory", slot)
			end,
		})
	end

	local children = {}
	children.EquipmentContainer = Roact.createElement(ItemContainer, {
		position = UDim2.fromOffset(10, 10),
		size = UDim2.new(0, 60, 1, -20),
		scrollingEnabled = false,
		children = equipment,
	})
	children.InventoryContainer = Roact.createElement(ItemContainer, {
		position = UDim2.fromOffset(80, 10),
		size = UDim2.new(1, -90, 1, -20),
		scrollingEnabled = true,
		children = inventory,
	})
	children.DetailsFrame = Roact.createElement(DetailsFrame, {
		anchorPoint = Vector2.new(0, 0.5),
		position = UDim2.new(1, 20, 0.5, 0),
		size = UDim2.fromOffset(150, 300),
		item = selectedItem,
		context = context,
		location = {
			Category = self.state.selectedCategory,
			Item = self.state.selectedItem,
		},
	})

	return Roact.createElement(MainContainer, {
		anchorPoint = Vector2.new(0.5, 0.5),
		position = UDim2.fromScale(0.5, 0.5),
		size = UDim2.fromOffset(400, 300),
		name = "Inventory",
		children = children,
	})
end

return Inventory

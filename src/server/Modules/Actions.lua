local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ItemModule = require(ReplicatedStorage.Modules.ItemModule)
local ShopModule = require(ReplicatedStorage.Modules.ShopModule)

local Actions = {}
Actions.Breathe = function(data, action)
	local air = ItemModule.Item[data.Equipment.Lung.Id].Stats.Air
	data.Air += air
	return data
end
Actions.Sell = function(data, action)
	local air = math.floor(data.Air / 2)
	data.Air -= air
	data.Money += air * data.Stats.ExchangeRate
	return data
end

Actions.AddItem = function(data, action)
	local id = action.id

	if not ItemModule.Item[id] then
		error(string.format("Actions.AddItem needs a valid item index, it was passed %i.", id))
		return
	end
	table.insert(data.Inventory, {
		Id = id,
	})
	return data
end
Actions.RemoveItem = function(data, action)
	local location = action.location
	local index = action.index

	local VALID_LOCATIONS = { "Equipment", "Inventory" }
	if not table.find(VALID_LOCATIONS, location) then
		error(string.format("Actions.RemoveItem needs a valid item location, it was passed %s.", location))
		return
	end

	data[location][index] = nil
	return data
end
Actions.UnequipItem = function(data, action)
	local slot = action.slot

	if not data.Equipment[slot] then
		error(string.format("Actions.UnequipItem requires a valid equipment slot to unequip, it was passed %s", slot))
		return
	end

	local item = data.Equipment[slot]
	data.Equipment[slot] = nil
	table.insert(data.Inventory, item)
	return data
end
Actions.EquipItem = function(data, action)
	local index = action.index

	if not data.Inventory[index] then
		error(string.format("Actions.EquipItem requires a valid equipment index to equip, it was passed %i", index))
		return
	end

	local TYPED_SLOTS = {
		Lung = { "Lung" },
		Accessory = { "Slot1", "Slot2", "Slot3", "Slot4" },
	}
	local item = data.Inventory[index]
	local itemData = ItemModule.Item[item.Id]
	local slots = TYPED_SLOTS[itemData.Type]

	local avaliableSlot
	if #slots == 1 then
		local slot = slots[1]
		if data.Equipment[slot] then
			Actions.UnequipItem(data, { slot = slot })
		end
		avaliableSlot = slot
	else
		for _, slot in slots do
			if not data.Equipment[slot] then
				avaliableSlot = slot
				break
			end
		end
	end

	if not avaliableSlot then
		return
	end

	table.remove(data.Inventory, index)
	data.Equipment[avaliableSlot] = item

	return data
end
Actions.BuyItem = function(data, action)
	local listingIndex = action.listingIndex

	if not ShopModule.Shop[listingIndex] then
		error(string.format("Actions.BuyItem needs a valid shop index, it was passed %i.", listingIndex))
		return
	end

	local listing = ShopModule.Shop[listingIndex]
	local price = listing.Price
	if data.Money < price then
		return
	end

	data.Money -= price
	Actions.AddItem(data, { id = listing.Id })
	return data
end

return Actions

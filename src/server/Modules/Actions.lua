local Actions = {}
Actions.Breathe = function(data, action)
	local air = 1 -- TODO: make this use the equipped lung's ItemData instead
	data.Air += air
	return data
end
Actions.Sell = function(data, action) end

Actions.AddItem = function(data, action) end
Actions.RemoveItem = function(data, action) end
Actions.EquipItem = function(data, action) end
Actions.UnequipItem = function(data, action) end

return Actions
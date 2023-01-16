local Actions = {}
Actions.Breathe = function(data, action)
	local air = 1 -- TODO: make this use the equipped lung's ItemData instead
	data.Air += air
	return data
end
Actions.Sell = function(data, action)
	local air = math.floor(data.Air / 2)
	data.Air -= air
	data.Money += air * data.Stats.ExchangeRate
	return data
end

Actions.AddItem = function(data, action) end
Actions.RemoveItem = function(data, action) end
Actions.EquipItem = function(data, action) end
Actions.UnequipItem = function(data, action) end

return Actions
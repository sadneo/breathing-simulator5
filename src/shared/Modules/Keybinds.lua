local Keybinds = {}
Keybinds.Breathe = {
	InputTypes = { Enum.KeyCode.F, Enum.UserInputType.Touch },
	TouchButton = false,
	Callback = function(_actionName, inputState, _inputObject)
		if inputState == Enum.UserInputState.Begin then
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Breathe = ReplicatedStorage.Remotes.Breathe
			Breathe:FireServer()
		end
		return Enum.ContextActionResult.Pass
	end,
}
Keybinds.Inventory = {
	InputTypes = { Enum.KeyCode.C },
	TouchButton = false,
	Callback = function(_actionName, inputState, _inputObject)
		if inputState == Enum.UserInputState.Begin then
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Breathe = ReplicatedStorage.Signals.SelectContainer
			Breathe:Fire("Inventory")
		end
		return Enum.ContextActionResult.Pass
	end,
}
Keybinds.Shop = {
	InputTypes = { Enum.KeyCode.V },
	TouchButton = false,
	Callback = function(_actionName, inputState, _inputObject)
		if inputState == Enum.UserInputState.Begin then
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Breathe = ReplicatedStorage.Signals.SelectContainer
			Breathe:Fire("Shop")
		end
		return Enum.ContextActionResult.Pass
	end,
}

return Keybinds

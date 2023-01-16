local ContextActionService = game:GetService("ContextActionService")

local KeybindManager = {}
function KeybindManager.Start()
	print('hi')
	ContextActionService:BindAction("Breathe", function(_actionName, inputState, _inputObject)
		if inputState == Enum.UserInputState.Begin then
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Breathe = ReplicatedStorage.Remotes.Breathe
			Breathe:FireServer()
		end
	end, false, Enum.KeyCode.F, Enum.UserInputType.Touch)
end

return KeybindManager
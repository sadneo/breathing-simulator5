local ContextActionService = game:GetService("ContextActionService")

local KeybindManager = {}
function KeybindManager.Start()
	ContextActionService:BindAction("Breathe", function(_actionName, inputState, _inputObject)
		if inputState == Enum.UserInputState.Begin then
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Breathe = ReplicatedStorage.Remotes.Breathe
			Breathe:FireServer()
		end
	end, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch)
end

return KeybindManager
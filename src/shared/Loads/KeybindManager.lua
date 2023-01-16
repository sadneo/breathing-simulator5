local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")

local Keybinds = require(ReplicatedStorage.Modules.Keybinds)

local KeybindManager = {}
KeybindManager.Keybinds = Keybinds -- TODO: later, get keybinds from DataManager instead

function KeybindManager.Start()
	for name, object in KeybindManager.Keybinds do
		ContextActionService:BindAction(name, object.Callback, object.TouchButton, unpack(object.InputTypes))
	end
end

return KeybindManager

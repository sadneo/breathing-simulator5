local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local ScreenGui = function(props)
	local children = props.children

	return Roact.createElement("ScreenGui", {
		ResetOnSpawn = false,
	}, children)
end

return ScreenGui

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local Container = function(props)
	local anchorPoint = props.anchorPoint
	local position = props.position
	local size = props.size

	local visible = props.visible
	local children = props.children

	return Roact.createElement("Frame", {
		AnchorPoint = anchorPoint,
		Position = position,
		Size = size,
		Visible = visible,

		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.5,
	}, {
		Roact.createFragment(children),
		UIStroke = Roact.createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(255, 255, 255),
		}),
	})
end

return Container

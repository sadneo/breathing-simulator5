local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local Item = function(props)
	local text = props.text
	local onClick = props.onClick
	local children = props.children

	return Roact.createElement("Frame", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.fromOffset(50, 50),
	}, {
		Roact.createFragment(children),
		TextButton = Roact.createElement("TextButton", {
			Text = text,
			[Roact.Event.MouseButton1Click] = onClick,

			Font = Enum.Font.Gotham,
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.fromScale(1, 1),
		}),
	})
end

return Item

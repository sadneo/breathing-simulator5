local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Container = require(ReplicatedStorage.Components.Base.Container)

local Panel = function(props)
	local anchorPoint = props.anchorPoint
	local position = props.position
	local size = props.size

	local children = {
		Roact.createFragment(props.children),
		UIListLayout = Roact.createElement("UIListLayout", {
			Padding = UDim.new(0, 5),
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
		UIPadding = Roact.createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 5),
			PaddingLeft = UDim.new(0, 5),
			PaddingRight = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		}),
	}

	return Roact.createElement(Container, {
		anchorPoint = anchorPoint,
		position = position,
		size = size,
		children = children,
	})
end

return Panel

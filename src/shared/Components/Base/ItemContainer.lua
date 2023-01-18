local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local Container = function(props)
	local anchorPoint = props.anchorPoint
	local position = props.position
	local size = props.size
	local scrollingEnabled = props.scrollingEnabled or false
	local children = props.children

	return Roact.createElement("ScrollingFrame", {
		AnchorPoint = anchorPoint,
		Position = position,
		Size = size,

		Active = true,
		ScrollingEnabled = scrollingEnabled,
		ScrollBarImageTransparency = scrollingEnabled and 0 or 1,
		-- ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
	}, {
		Roact.createFragment(children),
		UIStroke = Roact.createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(255, 255, 255),
		}),
		UIPadding = Roact.createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 5),
			PaddingLeft = UDim.new(0, 5),
			PaddingRight = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		}),
		UIGridLayout = Roact.createElement("UIGridLayout", {
			CellSize = UDim2.fromOffset(50, 50),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
end

return Container

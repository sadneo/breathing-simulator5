local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Container = require(ReplicatedStorage.Components.Base.Container)
local SelectContainer = ReplicatedStorage.Signals.SelectContainer

local MainContainer = Roact.Component:extend("MainContainer")

function MainContainer:init(props)
	self:setState({ visible = props.visible or false })
end

function MainContainer:didMount()
	SelectContainer.Event:Connect(function(name)
		print(self.props.name == name)
		self:setState({
			visible = name == self.props.name and not self.state.visible or false,
		})
	end)
end

function MainContainer:render()
	local anchorPoint = self.props.anchorPoint
	local position = self.props.position
	local size = self.props.size
	local children = self.props.children

	print(self.state.visible)
	return Roact.createElement(Container, {
		anchorPoint = anchorPoint,
		position = position,
		size = size,
		visible = self.state.visible,
		children = children,
	})
end

return MainContainer

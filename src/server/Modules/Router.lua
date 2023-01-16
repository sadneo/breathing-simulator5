local Router = {}
Router.Folder = nil

function Router.SetFolder(folder)
	Router.Folder = folder
end
function Router.AddRoutes(routes)
	for key, route in routes do
		Router.Folder[key].OnServerEvent:Connect(route)
	end
end

return Router

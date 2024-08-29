local CommandLoader = {}
local fs = require("@lune/fs")
function CommandLoader:LoadCommands(client)
	self.client = client
	for _, entry in fs.readDir("CommandLoader/Commands") do
		local a = require(`Commands/{entry}`)
		local cmd = a.command()
		client.discordApplication:setSlashCommandsAsync({ cmd }):after(function(data)
			print("Registering slash commands...")
			client.discordApplication:fetchSlashCommandsAsync():after(function(...)
				print(...)
			end)
		end)
	end
end

return CommandLoader

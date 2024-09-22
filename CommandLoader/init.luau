local CommandLoader = {}
local fs = require("@lune/fs")
function CommandLoader:LoadCommands(client)
	self.client = client
	self.client.commandExecutors = {}
	self.loadingCmds = {}

	for _, entry in fs.readDir("CommandLoader/Commands") do
		local command = require(`Commands/{entry}`)
		local cmd = command[1]
		local executor = command[2]
		self.loadingCmds[entry] = cmd[1]
		-- print(require("../Utilities/dump.luau")(self.loadingCmds))

		-- Add command to client registry
		self.client.commandExecutors[cmd.commandName] = executor
	end

	-- client.discordApplication:setSlashCommandsAsync({ self.loadingCmds }):after(function()
	--  print("Registering slash commands...")
	--  client.discordApplication:fetchSlashCommandsAsync():after(function(...)
	--      print(...)
	--  end)
	-- end)
end

return CommandLoader

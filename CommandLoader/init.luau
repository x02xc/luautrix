local CommandLoader = {}
local fs = require("@lune/fs")
function CommandLoader:LoadCommands(client)
	self.client = client
	self.client.commandExecutors = {}
	self.loadingCmds = {}

	for _, entry in fs.readDir("CommandLoader/Commands") do
		local cmd = require(`Commands/{entry}`)
		assert(cmd.executor, "Missing executor in command " .. tostring(entry))
		self.loadingCmds[entry] = cmd
		-- print(require("../Utilities/dump.luau")(self.loadingCmds))

		-- Add command to client registry
		self.client.commandExecutors[cmd.commandName] = cmd.executor
	end

	-- client.discordApplication:setSlashCommandsAsync({ self.loadingCmds }):after(function()
	--  print("Registering slash commands...")
	--  client.discordApplication:fetchSlashCommandsAsync():after(function(...)
	--      print(...)
	--  end)
	-- end)
end

return CommandLoader

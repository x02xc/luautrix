local discordLuau = require("DiscordLuau/init.luau")
local commandLoader = require("CommandLoader")

local dump = require("Utilities/dump.luau")
local MessageBuilder = discordLuau.MessageBuilder

local parser = require("Utilities/parser")
local TOKEN = parser:readEnvFile(".env")
-- interaction.new(client)
local logger = require("DiscordLuau/Package/Vendor/Console").new("DEBUG")
local discordSettings = discordLuau.SettingsBuilder.new(TOKEN)

local client = discordLuau.DiscordClient.new(discordSettings)

-- client:setVerbose(true) // dev logging only
client.eventManager.onReady:connect(function()
	print(`{client.discordUser.username} is online!`)
	commandLoader:LoadCommands(client)
	logger:warn("test")
end)

client.eventManager.onInteraction:connect(function(interaction)
	-- Locate command in registry
	local foundCommand = client.commandExecutors[interaction.data.name]
	if foundCommand then
		foundCommand(interaction)
	else
		print("Command not found: " .. tostring(interaction.data.name)) -- exception for when command isnt found lol
	end
end)
client.eventManager.onMessage:connect(function(message)
	if message.author.id ~= client.discordUser.id then
		message:replyAsync(MessageBuilder.new():setContent("hiii"))
	end
end)
--[=[
	after the client connects ( whats different from onReady? mysteries of the universe we may never uncover ;) )
]=]
client:connectAsync():after(function()
	print(client)
end)

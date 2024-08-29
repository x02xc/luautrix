local discordLuau = require("DiscordLuau/init.luau")
local commandLoader = require("CommandLoader")
local TOKEN = "MTI3NDIyMDQ4NDE5NTc3ODYyMw.GeIaTV.8XOmrTJPQuaOeXNgnkHQTEW-lNmdZskjdxhQFs"
local MessageBuilder = discordLuau.MessageBuilder
-- interaction.new(client)

local discordSettings = discordLuau.SettingsBuilder.new(TOKEN)

local client = discordLuau.DiscordClient.new(discordSettings)

-- client:setVerbose(true)

client.eventManager.onReady:connect(function(a)
	print(`{client.discordUser.username} is online!`)
	-- commandLoader:LoadCommands(client)
end)

client.eventManager.onInteraction:connect(function(interaction)
	local data = interaction.data
	if data.name == "ping" and data.type == 1 then
		local message = MessageBuilder.new():setContent("Calculating...")
		interaction:sendMessageAsync(message)
		print(interaction:getReplyAsync():getTimestampAsync())
		interaction:editMessageAsync(message)
	end
end)

client.eventManager.onMessage:connect(function(message)
	if message.author.id ~= client.discordUser.id then
		print(message)
		local msgbuilder = MessageBuilder.new()
		msgbuilder:setContent("test")
		message:replyAsync(msgbuilder, message)
	end
end)
client:connectAsync():after(function() end)

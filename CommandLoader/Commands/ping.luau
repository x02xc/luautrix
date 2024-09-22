local ping = {}
local DiscordLuau = require("../../DiscordLuau")
local MessageBuilder = DiscordLuau.MessageBuilder
local permissions = DiscordLuau.PermissionsBuilder
	.new()
	:addPermission(DiscordLuau.PermissionsBuilder.Permissions.UseApplicationCommands)
function ping.command()
	local command = DiscordLuau.CommandBuilder
		.new()
		:setName("ping")
		:setDescription("Pong?")
		:setGuildPermissions(permissions)
		:addContext(DiscordLuau.CommandBuilder.Context.Guild)
		:addIntegration(DiscordLuau.CommandBuilder.IntegrationType.GuildCommand)
		:setExecutor(function(interaction)
			interaction:sendMessageAsync(MessageBuilder.new():setContent("hi"))
		end)

	return command
end
return ping.command()

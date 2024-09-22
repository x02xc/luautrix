local ping = {}
local DiscordLuau = require("../../DiscordLuau")
local MessageBuilder = DiscordLuau.MessageBuilder
local permissions = DiscordLuau.PermissionsBuilder
	.new()
	:addPermission(DiscordLuau.PermissionsBuilder.Permissions.UseApplicationCommands)
function ping.command()
	local command = {
		DiscordLuau.CommandBuilder
			.new()
			:setName("ping")
			:setDescription("er?")
			:setGuildPermissions(permissions)
			:addContext(DiscordLuau.CommandBuilder.Context.Guild)
			:addIntegration(DiscordLuau.CommandBuilder.IntegrationType.GuildCommand),
		function(interaction)
			interaction:sendMessageAsync(MessageBuilder.new():setContent("Pong!"))
		end,
	}

	return command
end
return ping.command()

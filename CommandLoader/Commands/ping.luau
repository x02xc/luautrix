local ping = {}
local DiscordLuau = require("../../DiscordLuau")
local permissions = DiscordLuau.PermissionsBuilder
	.new()
	:addPermission(DiscordLuau.PermissionsBuilder.Permissions.UseApplicationCommands)
function ping.command()
	local pingCommand = DiscordLuau.CommandBuilder
		.new()
		:setName("ping")
		:setDescription("Pong?")
		:setGuildPermissions(permissions)
		:addContext(DiscordLuau.CommandBuilder.Context.Guild)
		:addIntegration(DiscordLuau.CommandBuilder.IntegrationType.GuildCommand)

	return pingCommand
end
return ping

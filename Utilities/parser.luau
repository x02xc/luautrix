local fs = require("@lune/fs")
local parser = {}
--[=[
	@function readEnvFile
	@param path string
	@within Utilities.parser
	@return table<string, string>
	Reads an ENV file and returns the token from the key-value pairs.
	EXPECTS: TOKEN="YOURTOKENHERE"
]=]
function parser:readEnvFile(path: string): string | nil
	local contents = fs.readFile(path)
	if not contents then
		return nil
	end

	local parsed = {} :: { [string]: string }
	for LINE in contents:gmatch("[^\r\n]+") do
		local name, value = LINE:match('^%s*(%w+)%s*=%s*"(.-)"%s*$')
		if name and value then
			parsed[name] = value
		end
	end

	local token = parsed["TOKEN"]
	assert(token, 'TOKEN is not set in your ENV file, please set it with the following format:\nTOKEN="YOURTOKENHERE"')
	return token
end

return parser

--- Package provider that does nothing.
local provider = {}

-- selene: allow(unused_variable)
function provider.install(...) end

return provider

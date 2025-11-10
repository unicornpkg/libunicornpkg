local startup_dir = "/etc/startup"

if fs.exists(startup_dir) and fs.isDir(startup_dir) then
	local files = fs.list(startup_dir)
	for _, file in ipairs(files) do
		if string.sub(file, 1, 1) ~= "." then
			local path = fs.combine(startup_dir, file)
			if not fs.isDir(path) then
				shell.run(path)
			end
		end
	end
end

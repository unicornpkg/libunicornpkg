local unicorn = {}
unicorn.constants = {}

unicorn.constants.projectName = "libunicornpkg"
unicorn.constants.version = "1.5.0"
unicorn.constants.infoLink = "https://unicornpkg.github.io/libunicornpkg/information-for-websites"
unicorn.constants.userAgent =
	table.concat({ unicorn.constants.projectName, unicorn.constants.version, unicorn.constants.infoLink }, " ")

return unicorn.constants

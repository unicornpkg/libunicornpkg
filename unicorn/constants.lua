local unicorn = {}
unicorn.constants = {}

unicorn.constants.projectName = "libunicornpkg"
unicorn.constants.version = "1.4.0"
unicorn.constants.infoLink = "https://unicornpkg.github.io/libunicornpkg/information-for-websites"
unicorn.constants.userAgent = table.concat({ projectName, version, infoLink }, " ")

return unicorn.constants

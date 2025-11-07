# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = "libunicornpkg"
copyright = "2025, Tomodachi94"
author = "Tomodachi94"
release = "1.2.1"

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ["myst_parser", "sphinx_lua_ls"]

templates_path = ["_templates"]
exclude_patterns = []

primary_domain = "lua"
default_role = "lua:obj"
highlight_language = "lua"

# -- Theme configuration -----------------------------------------------------

html_theme_options = {
    "github_user": "unicornpkg",
    "github_repo": "libunicornpkg",
    "github_banner": True,
}

# -- sphinx-lua-ls configuration ---------------------------------------------

lua_ls_project_root = ".."
lua_ls_backend = "luals"
lua_ls_apidoc_default_options = {
    "undoc-members": "",
    "protected-members": "",
    "globals": "",
}
lua_ls_apidoc_roots = {
    "unicorn": "api",
}

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "alabaster"
html_static_path = ["_static"]

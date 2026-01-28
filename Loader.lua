--[[ 
  Simple Loader
  Author: You
--]]

local repo = "https://raw.githubusercontent.com/USERNAME/REPO/main/"

local function load(file)
    local success, err = pcall(function()
        loadstring(game:HttpGet(repo .. file))()
    end)

    if not success then
        warn("Failed to load:", file)
        warn(err)
    end
end

-- Anti double execute
if getgenv()._MY_HUB_LOADED then
    return
end
getgenv()._MY_HUB_LOADED = true

-- Load main GUI
load("main.lua")

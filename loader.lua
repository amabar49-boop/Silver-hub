-- Silver Hub Loader
-- Repo: amabar49-boop / Silver-hub

local BASE_URL = "https://raw.githubusercontent.com/amabar49-boop/Silver-hub/main/"

-- Anti double execute
if getgenv()._SILVER_HUB_LOADED then
    return
end
getgenv()._SILVER_HUB_LOADED = true

local function loadFile(file)
    local success, err = pcall(function()
        loadstring(game:HttpGet(BASE_URL .. file))()
    end)

    if not success then
        warn("[Silver Hub] Gagal load:", file)
        warn(err)
    end
end

-- Load Main GUI
loadFile("Main.lua")

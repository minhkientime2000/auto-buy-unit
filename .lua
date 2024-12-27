repeat wait() until game:IsLoaded() and game.ReplicatedStorage and game.ReplicatedStorage:FindFirstChild("MultiboxFramework")
repeat wait() until require(game:GetService("ReplicatedStorage").MultiboxFramework).Loaded
local dataunit = require(game:GetService("ReplicatedStorage").MultiboxFramework).Inventory.GetAllCopies({ "Troops",
    "Crates" })
local plr = game.Players.LocalPlayer

local save = require(game:GetService("ReplicatedStorage"):WaitForChild("MultiboxFramework"));
local Inventory = save.Inventory

if game.PlaceId == 13775256536 then
    game:GetService("TeleportService"):Teleport(14682939953)
else
    local save = require(game:GetService("ReplicatedStorage"):WaitForChild("MultiboxFramework"));
    local data = save.Inventory;
    local datamarket = save:WaitForModule("Replicate"):WaitForReplica("Marketplace_Listings")
    local a = getsenv(game:GetService("Players").LocalPlayer.PlayerGui.Lobby.MarketplaceFrame.MarketplaceHandler)
    local b = require(game:GetService("ReplicatedStorage").MultiboxFramework).Inventory.GetAllCopies({ "Troops", "Crates" });
    local getdatamarket = datamarket:GetData();
    local l_Inventory_0 = save.Inventory;
    local l_FrameworkGui_0 = save.FrameworkGui;
    addCommas = function(v212) --[[ Line: 786 ]]
        --[[ Name: addCommas ]]
        local v213 = tostring(v212);
        repeat
            local _ = nil;
            local v215, v216 = string.gsub(v213, "^(-?%d+)(%d%d%d)", "%1,%2");
            v213 = v215;
        until v216 == 0;
        return v213;
    end;
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' ..
                game.PlaceId .. '/servers/0?sortOrder=5&excludeFullGames=true&limit=100'))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i, v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _, Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID,
                            game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end

    function Teleport()
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end

    while wait() do
        if not game:GetService("Players").LocalPlayer.PlayerGui.Lobby.MarketplaceFrame.Visible then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(1438, 113, 2545)
            task.wait(1)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(1438, 113, 2558)
            task.wait(1)
        end

        for i, v in next, getdatamarket do
            for i1, v1 in next, getgenv().data do
                local v60 = l_Inventory_0.GetItemConfig(v.Category, v.ItemId);
                if string.find(v60.DisplayName, i1) and v.GemPrice <= v1.GemBuy then
                    local saved = game:GetService("ReplicatedStorage").IdentifiersContainer
                        .RF_f738402c005be62deb6d6f2d01260f9f19bf5592274bb4967eed55702a193d21_S.Value
                    game:GetService("ReplicatedStorage"):WaitForChild("NetworkingContainer"):WaitForChild("DataRemote")
                        :FireServer({ { saved, "Honglamx", v.UID, v.GemPrice } })
                    wait(1)
                    print(v.GemPrice, v.Seller, v.UID, v.Rarity, v60.DisplayName, v.ItemId)
                    wait(1)
                end
            end
        end
        Teleport()
    end
end

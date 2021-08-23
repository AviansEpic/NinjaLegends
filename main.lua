local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Ninja Legends Is Gay")
local main = window:NewTab("Main")
local mainsec = main:NewSection("Main")
local teleport = window:NewTab("Teleports")
local teleportsec = teleport:NewSection("Teleports")
local buttons = window:NewTab("Buttons")
local buttonsec = buttons:NewSection("Buttons")
local player = window:NewTab("Player")
local playersec = player:NewSection("Player")

getgenv().AutoSell = false
getgenv().AutoSwing = false
getgenv().AutoBuySwords = false
getgenv().AutoBuyBelts = false
getgenv().AntiStats = false

mainsec:NewToggle("Auto Sell", "Auto sells your ninjitsu",function(state)
    getgenv().AutoSell = state
end)

mainsec:NewToggle("Auto Swing", "Auto swings your sword",function(state)
    getgenv().AutoSwing = state
end)

mainsec:NewToggle("Auto Buy Swords","Automatically buys swords", function(state)
    getgenv().AutoBuySwords = state
end)

mainsec:NewToggle("Auto Buy Belts", "Automatically buys belts", function(state)
    getgenv().AutoBuyBelts = state
end)

mainsec:NewToggle("Anti Stats Effect","Gets rid of the + Coins and stuff effects", function(state)
    getgenv().AntiStats = state
end)

mainsec:NewToggle("Anti AFK", "Won't kick you for being AFK", function(state)
    getgenv().AntiAfk = state
end)

for i,v in pairs(game.Workspace.islandUnlockParts:GetChildren()) do
    teleportsec:NewButton(v.Name, "Teleports to "..v.Name, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
    end)
end


mainsec:NewButton("Unlock All Islands","Unlocks All Islands", function()
    local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    wait(0.01)
    
    for i,v in pairs(game.Workspace.islandUnlockParts:GetChildren()) do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        wait(0.01)
    end
    
    game.Players.LocalPlayer.HumanoidRootPart.CFrame = pos
end)

buttonsec:NewButton("Sell Ninjitsu","Sells your Ninjitsu",function()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner, 1)
end)

buttonsec:NewButton("Swing Sword","Swings your sword", function()
    game.Players.LocalPlayer.ninjaEvent:FireServer("swingKatana")
end)

buttonsec:NewButton("Swing then Sell","Swings your sword then sells it", function()
    game.Players.LocalPlayer.ninjaEvent:FireServer("swingKatana")
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner, 1)
end)

buttonsec:NewButton("Grab All Coins", "Grabs all the coins around the map", function()
    for i,v in pairs(game:GetService("Workspace").spawnedCoins.Valley:GetChildren()) do
        if v.Name:split(" ")[2] == "Coin" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
        end
        
        wait(0.1)
    end
end)

playersec:NewTextBox("WalkSpeed", "Sets WalkSpeed", function(txt)
    if tonumber(txt) then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(txt)
    end
end)

playersec:NewTextBox("JumpPower", "Sets JumpPower", function(txt)
    if tonumber(txt) then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(txt)
    end
end)

--Main Loop
while wait() do
    pcall(function()
    local amount = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.currencyFrame.strengthFrame.amountLabel
    if getgenv().AutoSell then
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner, 1)
    end
    
    if getgenv().AutoSwing then
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.Character
        end
        game.Players.LocalPlayer.ninjaEvent:FireServer("swingKatana")
    end
    
    if getgenv().AutoBuySwords then
        game.Players.LocalPlayer.ninjaEvent:FireServer("buyAllSwords", "Blazing Vortex Island")
    end
    
    if getgenv().AutoBuyBelts then
        game.Players.LocalPlayer.ninjaEvent:FireServer("buyAllBelts", "Blazing Vortex Island")
    end
    
    if getgenv().AntiStats then
        game.Players.LocalPlayer.PlayerGui.statEffectsGui.Enabled = false
    else
        game.Players.LocalPlayer.PlayerGui.statEffectsGui.Enabled = true
    end
    
    if getgenv().AntiAfk then
        local ss = game:GetService('VirtualUser')
    game:GetService('Players').LocalPlayer.Idled:connect(function()
        ss:CaptureController()
        ss:ClickButton2(Vector2.new())
    end)
    end
    end)
end

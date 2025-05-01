-- Lelouch Script | Работает на Xeno
-- Insert для открытия/закрытия GUI

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- GUI создание
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "LelouchGUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 350, 0, 400)
Frame.Position = UDim2.new(0.5, -175, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.Visible = true
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🌌 Lelouch Script 🌌"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(45,45,60)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Тянка (визуально)
local AnimeGirl = Instance.new("ImageLabel", Frame)
AnimeGirl.Size = UDim2.new(0, 150, 0, 200)
AnimeGirl.Position = UDim2.new(1, -160, 0, 50)
AnimeGirl.Image = "rbxassetid://11799204353" -- Аниме-тянка
AnimeGirl.BackgroundTransparency = 1

-- Кнопки
local function createButton(name, yPos, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(0, 150, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.MouseButton1Click:Connect(callback)
end

-- Автофарм
local AutoFarm = false
createButton("⚔ Автофарм", 50, function()
	AutoFarm = not AutoFarm
end)

-- Телепорт на острова
local islands = {
	["Starter Island"] = Vector3.new(206, 17, 1447),
	["Marine"] = Vector3.new(-2500, 25, 3900),
	["Middle Town"] = Vector3.new(260, 6, 427),
}

createButton("🚢 Телепорт: Middle Town", 90, function()
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(islands["Middle Town"])
end)

createButton("🏝️ Телепорт: Starter", 130, function()
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(islands["Starter Island"])
end)

-- Insert key toggle
UIS.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Insert then
		Frame.Visible = not Frame.Visible
	end
end)

-- Автофарм логика
RunService.RenderStepped:Connect(function()
	if AutoFarm and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		local nearestEnemy = nil
		local shortest = math.huge
		for _, mob in pairs(workspace.Enemies:GetChildren()) do
			if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
				local dist = (plr.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
				if dist < shortest then
					shortest = dist
					nearestEnemy = mob
				end
			end
		end
		if nearestEnemy then
			plr.Character.HumanoidRootPart.CFrame = nearestEnemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
		end
	end
end)

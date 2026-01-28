print("Fish It Module Loaded")

-- taruh autofarm / auto fish di sini
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "LuckyBlockGui"
ScreenGui.Parent = game:GetService("CoreGui") 

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60) 
ToggleButton.Position = UDim2.new(0.5, -60, 0.05, 0) 
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "AUTO BREAK: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14.0

UICorner.Parent = ToggleButton

local _G = _G or {}
_G.AutoBreak = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Event = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DamageBlockEvent")
local LuckyBlocksFolder = Workspace:WaitForChild("LuckyBlocks")

local function getTargetPos(obj)
    if obj:IsA("BasePart") then
        return obj.Position
    elseif obj:IsA("Model") then
        if obj.PrimaryPart then
            return obj.PrimaryPart.Position
        else
            local part = obj:FindFirstChildWhichIsA("BasePart", true)
            return part and part.Position
        end
    end
    return nil
end

ToggleButton.MouseButton1Click:Connect(function()
    _G.AutoBreak = not _G.AutoBreak
    
    if _G.AutoBreak then
        ToggleButton.Text = "AUTO BREAK: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 255, 60) 
    else
        ToggleButton.Text = "AUTO BREAK: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60) 
    end
end)

task.spawn(function()
    while true do
        task.wait(0.01)
        
        if _G.AutoBreak then
            local targets = LuckyBlocksFolder:GetChildren()
            
            for _, block in ipairs(targets) do
                if not _G.AutoBreak then break end -- 
                
                local char = Player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local pos = getTargetPos(block)
                
                if root and pos and block:IsDescendantOf(LuckyBlocksFolder) then
                    root.CFrame = CFrame.new(pos + Vector3.new(0, 0, 0))
                    
                    repeat
                        if not _G.AutoBreak then break end
                        Event:FireServer(block)
                        task.wait(0)
                    until not block:IsDescendantOf(LuckyBlocksFolder) or not block.Parent
                end
            end
        end
    end
end)

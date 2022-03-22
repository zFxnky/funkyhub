if not game:IsLoaded() then
	local loadedcheck = Instance.new("Message",workspace)
	loadedcheck.Text = 'Loading...'
	game.Loaded:Wait()
	loadedcheck:Destroy()
end
local VirtualUser=game:service'VirtualUser'
	game:service'Players'.LocalPlayer.Idled:connect(function()
	warn("anti-afk")
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)
local plr = game.Players.LocalPlayer
game.Workspace:WaitForChild("Live")
game.Workspace.Live:WaitForChild(plr.Name)
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zFxnky/zFxnky-Hub-/main/theme.lua"))()
game:GetService("RunService").RenderStepped:connect(function()
end)
local plrs = game:GetService("Players")
local TeamBased = false ; local teambasedswitch = "p"
local presskeytoaim = true; local aimkey = "u"
local raycast = false

local espupdatetime = 5; autoesp = false



local lockaim = true; local lockangle = 5



--function findwat(folder, what)
--	for i, smth in pairs(folder:GetChildren()) do
--		if string.find(string.lower(tostring(smth)), string.lower(what)) then
--			return smth
--		end
--	end
--end
--
--local plrs = findwat(game, "Players")




local Gui = Instance.new("ScreenGui")
local Move = Instance.new("Frame")
local Main = Instance.new("Frame")
local st1 = Instance.new("TextLabel")
local st1_2 = Instance.new("TextLabel")
local st1_3 = Instance.new("TextLabel")
local Name = Instance.new("TextLabel")
--Properties:

-- Scripts:


local plrsforaim = {}

local lplr = game:GetService("Players").LocalPlayer
Move.Draggable = true
Gui.ResetOnSpawn = false
Gui.Name = "Chat"


	Gui.Parent = plrs.LocalPlayer.PlayerGui


f = {}



local cam = game.Workspace.CurrentCamera

local mouse = lplr:GetMouse()
local switch = false
local key = "k"
local aimatpart = nil
mouse.KeyDown:Connect(function(a)
	if a == "t" then
		print("worked1")
		f.addesp()
	elseif a == "u" then
		if raycast == true then
			raycast = false
		else
			raycast = true
		end
	elseif a == "l" then
		if autoesp == false then
			autoesp = true
		else
			autoesp = false
		end
	end
	if a == "j" then
		if mouse.Target then
			mouse.Target:Destroy()
		end
	end
	if a == key then
		if switch == false then
			switch = true
		else
			switch = false
			if aimatpart ~= nil then
				aimatpart = nil
			end
		end
	elseif a == teambasedswitch then
		if TeamBased == true then
			TeamBased = false
			teambasedstatus.Text = tostring(TeamBased)
		else
			TeamBased = true
			teambasedstatus.Text = tostring(TeamBased)
		end
	elseif a == aimkey then
		if not aimatpart then
			local maxangle = math.rad(20)
			for i, plr in pairs(plrs:GetChildren()) do
				if plr.Name ~= lplr.Name and plr.Character and plr.Character.Head and plr.Character.Humanoid and plr.Character.Humanoid.Health > 1 then
					if TeamBased == true then
						if plr.Team.Name ~= lplr.Team.Name then
							local an = checkfov(plr.Character.Head)
							if an < maxangle then
								maxangle = an
								aimatpart = plr.Character.Head
							end
						end
					else
						local an = checkfov(plr.Character.Head)
							if an < maxangle then
								maxangle = an
								aimatpart = plr.Character.Head
							end
							print(plr)
					end
					plr.Character.Humanoid.Died:Connect(function()
						if aimatpart.Parent == plr.Character or aimatpart == nil then
							aimatpart = nil
						end
					end)
				end
			end
		else
			aimatpart = nil
		end
	end
end)

function getfovxyz (p0, p1, deg)
	local x1, y1, z1 = p0:ToOrientation()
	local cf = CFrame.new(p0.p, p1.p)
	local x2, y2, z2 = cf:ToOrientation()
	--local d = math.deg
	if deg then
		--return Vector3.new(d(x1-x2), d(y1-y2), d(z1-z2))
	else
		return Vector3.new((x1-x2), (y1-y2), (z1-z2))
	end
end

function getaimbotplrs()
	plrsforaim = {}
	for i, plr in pairs(plrs:GetChildren()) do
		if plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 and plr.Name ~= lplr.Name and plr.Character.Head then
			
			if TeamBased == true then
				if plr.Team.Name ~= lplr.Team.Name then
					local cf = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, plr.Character.Head.CFrame.p)
					local r = Ray.new(cf, cf.LookVector * 10000)
					local ign = {}
					for i, v in pairs(plrs.LocalPlayer.Character:GetChildren()) do
						if v:IsA("BasePart") then
							table.insert(ign , v)
						end
					end
					local obj = game.Workspace:FindPartOnRayWithIgnoreList(r, ign)
					if obj.Parent == plr.Character and obj.Parent ~= lplr.Character then
						table.insert(plrsforaim, obj)
					end
				end
			else
				local cf = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, plr.Character.Head.CFrame.p)
				local r = Ray.new(cf, cf.LookVector * 10000)
				local ign = {}
				for i, v in pairs(plrs.LocalPlayer.Character:GetChildren()) do
					if v:IsA("BasePart") then
						table.insert(ign , v)
					end
				end
				local obj = game.Workspace:FindPartOnRayWithIgnoreList(r, ign)
				if obj.Parent == plr.Character and obj.Parent ~= lplr.Character then
					table.insert(plrsforaim, obj)
				end
			end
			
			
		end
	end
end

function aimat(part)
	cam.CFrame = CFrame.new(cam.CFrame.p, part.CFrame.p)
end
function checkfov (part)
	local fov = getfovxyz(game.Workspace.CurrentCamera.CFrame, part.CFrame)
	local angle = math.abs(fov.X) + math.abs(fov.Y)
	return angle
end

game:GetService("RunService").RenderStepped:Connect(function()
	if aimatpart then
		aimat(aimatpart)
		if aimatpart.Parent == plrs.LocalPlayer.Character then
			aimatpart = nil
		end
	end
	
	
--	if switch == true then
--		local maxangle = 99999
--		
--		--print("Loop")
--		if true and raycast == false then
--			for i, plr in pairs(plrs:GetChildren()) do
--				if plr.Name ~= lplr.Name and plr.Character and plr.Character.Head and plr.Character.Humanoid and plr.Character.Humanoid.Health > 1 then
--					if TeamBased then
--						if plr.Team.Name ~= lplr.Team.Name or plr.Team.TeamColor ~= lplr.Team.TeamColor then
--							local an = checkfov(plr.Character.Head)
--							if an < maxangle then
--								maxangle = an
--								aimatpart = plr.Character.Head
--								if an < lockangle then
--									break
--								end
--							end
--						end
--					else
--						local an = checkfov(plr.Character.Head)
--							if an < maxangle then
--								maxangle = an
--								aimatpart = plr.Character.Head
--								if an < lockangle then
--									break
--								end
--							end
--					end
--					
--					
--					
--					
--				end
--			end
--		elseif raycast == true then
--			
--		end
		
		if raycast == true and switch == false and not aimatpart then
			getaimbotplrs()
			aimatpart = nil
			local maxangle = 999
			for i, v in ipairs(plrsforaim) do
				if v.Parent ~= lplr.Character then
					local an = checkfov(v)
					if an < maxangle and v ~= lplr.Character.Head then
						maxangle = an
						aimatpart = v
						print(v:GetFullName())
						v.Parent.Humanoid.Died:connect(function()
							aimatpart = nil
						end)
					end
				end
			end
		
	end
end)
delay(0, function()
	while wait(espupdatetime) do
		if autoesp == true then
			pcall(function()
			f.addesp()
			end)
		end
	end
end)
local funkyhub = library.new("Funky Hub", 5013109572)

-- themes
local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(127,0,255),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(127, 0, 255)
}

-- first page
local Misc = funkyhub:addPage("Misc", 5012544693)
local Misc1 = Misc:addSection("Misc")
Misc1:addSlider("Tele Speed", 300, 100, 2000, function(telespeed)
            _G.TeleSpeed_Bind = "Q"
					down = false
					velocity = Instance.new("BodyVelocity")
					velocity.maxForce = Vector3.new(10000000, 0, 10000000)
										local speed = telespeed
					gyro = Instance.new("BodyGyro")
					gyro.maxTorque = Vector3.new(10000000, 0, 10000000)
					local hum = game.Players.LocalPlayer.Character.Humanoid
					function onButton1Down(mouse)
						down = true
						velocity.Parent = game.Players.LocalPlayer.Character.UpperTorso
						velocity.velocity = (hum.MoveDirection) * speed
						gyro.Parent = game.Players.LocalPlayer.Character.UpperTorso
						while down do
							if not down then
								break
							end
							velocity.velocity = (hum.MoveDirection) * speed
							local refpos = gyro.Parent.Position + (gyro.Parent.Position - workspace.CurrentCamera.CoordinateFrame.p).unit * 5
							gyro.cframe = CFrame.new(gyro.Parent.Position, Vector3.new(refpos.x, gyro.Parent.Position.y, refpos.z))
							wait(0.1)
						end
					end
					function onButton1Up(mouse)
						velocity.Parent = nil
						gyro.Parent = nil
						down = false
					end
					function onSelected(mouse)
						mouse.KeyDown:connect(function(k)
							if k:upper() == _G.TeleSpeed_Bind then
								onButton1Down(mouse)
							end
						end)
						mouse.KeyUp:connect(function(k)
							if k:upper() == _G.TeleSpeed_Bind then
								onButton1Up(mouse)
							end
						end)
					Misc1:addSlider("Custom Speed", 0, 1, 25000, function(CustomSpeed)
							lmao = {CustomSpeed}
						
						while wait() do
						function setSpeed(walkspeedSet)
						local plr = game:GetService"Players".LocalPlayer
						local serverTraits = plr.Backpack:WaitForChild'ServerTraits'
						
						for i,v in next, getconnections(serverTraits.Input.OnClientEvent) do
						   local speed = ((walkspeedSet))
						   v:Fire({speed})
						   break
						end 
						end 
						setSpeed(lmao[1])
						end
							end)
					
						
					end
					onSelected(game.Players.LocalPlayer:GetMouse())
end)
Misc1:addSlider("Custom Speed", 0, 1, 25000, function(CustomSpeed)
	lmao = {CustomSpeed}

while wait() do
function setSpeed(walkspeedSet)
local plr = game:GetService"Players".LocalPlayer
local serverTraits = plr.Backpack:WaitForChild'ServerTraits'

for i,v in next, getconnections(serverTraits.Input.OnClientEvent) do
   local speed = ((walkspeedSet))
   v:Fire({speed})
   break
end 
end 
setSpeed(lmao[1])
end
	end)

Misc1:addButton("Character Slot Changer", function()
game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Character Slot Changer"])
end)
Misc1:addButton("TOP Respawn", function()
							if game.Players.LocalPlayer.Character:FindFirstChild("SuperAction") then
								game.Players.LocalPlayer.Character:FindFirstChild("SuperAction"):Destroy()
							end
end)
Misc1:addButton("Dragon Throw Grab", function()
						game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Dragon Throw"])
if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Throw") then
game.Players.LocalPlayer.Character["Dragon Throw"].Activator.Flip:Destroy()
end
end)
Misc1:addToggle("Bean Spam", nil, function(BeanSpamT)
    if BeanSpamT == true then
        BeanSpamR = game:GetService("RunService").RenderStepped:connect(function()
    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.EatSenzu:FireServer(true)
        end)
else
    BeanSpamR:Disconnect()
    end
end)
Misc1:addToggle("Anti Glitch", nil, function(AntiGlitchT)
    if AntiGlitchT == true then
game.Players.LocalPlayer.Character.Humanoid.Animator:Destroy()
else
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
end)
Misc1:addKeybind("HardReset", Enum.KeyCode.RightAlt, function()
game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)
Misc1:addKeybind("Fast Reset(Earth)", Enum.KeyCode.Home, function ()
    local plr = game.Players.LocalPlayer
    local race = game:GetService("Workspace").Live[plr.Name]:FindFirstChild("Race")

    local hair = workspace.FriendlyNPCs:FindFirstChild("Hair Stylist")
    local hair_Arg = {
        [1] = "Yes"
    }
    local hair_args = {
        [1] = "woah"
    }
    if game.PlaceId == 536102540 then
        if race.Value == "Saiyan" or race.Value == "Human" or race.Value == "Android" then
            print("works2")
            game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(hair)
            wait(.4)
            game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer(hair_Arg)
            wait(.4)
            game:GetService("Players").LocalPlayer.Backpack.HairScript.RemoteEvent:FireServer(unpack(hair_args))
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "that didn't work";
                Text = "you need hair dumb ass";
                Duration = 2;
            }) 
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "that didn't work ";
            Text = "are you in earth you dumb ass";
            Duration = 2;
            })
        end
    end)
Misc1:addButton("More Features Coming Soon", function()
end)
local Character = funkyhub:addPage("Character", 5012544693)
local Character1 = Character:addSection("Character")
Character1:addButton("Wing Remove", function()
    
	local Live = game:WaitForChild("Workspace").Live
	local Char = Live:WaitForChild(game.Players.LocalPlayer.Name)
	
	while wait() do
		pcall(function()
			Char["RebirthWings"].Handle.AccessoryWeld:Destroy()
		end)
	end
	end)
		
	Character1:addButton("Halo Remove", function()
	local plr = game.Players.LocalPlayer
	game.Workspace.Live[plr.name].RealHalo["Handle"]:Destroy()
	end)
	
end)
Character1:addButton("Level Remove", function()
            					local player = game:GetService("Players").LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					for i, model in pairs(character:GetChildren()) do
						if string.match(model.Name, "Lvl") then
							model:Destroy()
							break
						end
						end
end)
Character1:addButton("Accessory", function()
                					local player = game:GetService("Players").LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					for i, model in pairs(character:GetChildren()) do
    if model:IsA("Accessory") then
							model:Destroy()
							break
    end
					end
end)
Character1:addButton("Naked", function()
    game.Players.LocalPlayer.Character.Shirt:Destroy()
    game.Players.LocalPlayer.Character.Pants:Destroy()
    game.Players.LocalPlayer.Character.Head.Mesh:Destroy()
end)
Character1:addButton("Remove Aura", function()
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("TempAura") or game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Lightning") then
    game.Players.LocalPlayer.Character.HumanoidRootPart.TempAura:Destroy()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Lightning:Destroy()
    end
end)
Character1:addButton("Invisibility", function()
    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Flash Strike"])
if game.Players.LocalPlayer.Character:FindFirstChild("Flash Strike") then
game.Players.LocalPlayer.Character["Flash Strike"].Activator.Animation:Destroy()
end
game.Players.LocalPlayer.Character["Flash Strike"]:Activate()
end)
Character1:addButton("Super Dragon Fist Aura", function()
						local Players = game:GetService("Players")
						local player = Players:FindFirstChildOfClass("Player")
						if Players:FindFirstChildOfClass("Player") and player.Character then
							local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
							if humanoid then
								local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Super Dragon Fist")
								if tool then
									humanoid:EquipTool(tool)
								end
							end
						end
						wait(0.5)
						if game.Players.LocalPlayer.Character:FindFirstChild("Super Dragon Fist") then
							game.Players.LocalPlayer.Character["Super Dragon Fist"].Activator.Forward:Destroy()
						end
end)
Character1:addButton("Super Rush Aura", function()
						local Players = game:GetService("Players")
						local player = Players:FindFirstChildOfClass("Player")
						if Players:FindFirstChildOfClass("Player") and player.Character then
							local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
							if humanoid then
								local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Super Rush")
								if tool then
									humanoid:EquipTool(tool)
								end
							end
						end
						wait(0.5)
						if game.Players.LocalPlayer.Character:FindFirstChild("Super Rush") then
							game.Players.LocalPlayer.Character["Super Rush"].Activator.Forward:Destroy()
						end
end)
Character1:addButton("Kaioken Assault Aura", function()
    						local Players = game:GetService("Players")
						local player = Players:FindFirstChildOfClass("Player")
						if Players:FindFirstChildOfClass("Player") and player.Character then
							local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
							if humanoid then
								local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Kaioken Assault")
								if tool then
									humanoid:EquipTool(tool)
								end
							end
						end
						wait(0.5)
						if game.Players.LocalPlayer.Character:FindFirstChild("Kaioken Assault") then
							game.Players.LocalPlayer.Character["Kaioken Assault"].Activator.Forward:Destroy()
						end
end)
Character1:addButton("Wrathful Charge Aura", function()
						local Players = game:GetService("Players")
						local player = Players:FindFirstChildOfClass("Player")
						if Players:FindFirstChildOfClass("Player") and player.Character then
							local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
							if humanoid then
								local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Wrathful Charge")
								if tool then
									humanoid:EquipTool(tool)
								end
							end
						end
						wait(0.5)
						if game.Players.LocalPlayer.Character:FindFirstChild("Wrathful Charge") then
							game.Players.LocalPlayer.Character["Wrathful Charge"].Activator.Forward:Destroy()
end
end)
Character1:addToggle("Better Walking Anim", nil, function(WalkingAnimation)
       					if WalkingAnimation == true then
						if game.Players.LocalPlayer.Character.Animate.walk:FindFirstChild("RunAnim") then
							game.Players.LocalPlayer.Character.Animate.walk:FindFirstChild("RunAnim").AnimationId = "rbxassetid://2625673611"
						end
					else
						if game.Players.LocalPlayer.Character.Animate.walk:FindFirstChild("RunAnim") then
							game.Players.LocalPlayer.Character.Animate.walk:FindFirstChild("RunAnim").AnimationId = "rbxassetid://669161051"
						end
					end 
end)
Character1:addButton("More Features Coming Soon", function()
end)
local Visuals = funkyhub:addPage("Visuals", 5012544693)
local Visuals1 = Visuals:addSection("Visuals")
Visuals1:addSlider("FOV", 70, 1, 120, function(FOV)
    game.Workspace.Camera.FieldOfView = FOV
end)
Visuals1:addSlider("Saturation", 25, -25, 0, function(Saturation)
    game.Lighting.ColorCorrection.Saturation = Saturation
end)
Visuals1:addToggle("Drugs", nil, function(Drugs)
        _G.high = true
					if Drugs == true then
						while _G.high do
							game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								FieldOfView = 120
							}):Play()
							game:GetService("TweenService"):Create(game:GetService("Lighting").ColorCorrection, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								Saturation = 35
							}):Play()
							wait(1.1)
							game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								FieldOfView = 50
							}):Play()
							game:GetService("TweenService"):Create(game:GetService("Lighting").ColorCorrection, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								Saturation = -35
							}):Play()
							wait(1.1)
						end
					else
						_G.high = false
						wait(3)
						game.Workspace.Camera.FieldOfView = 70
						game.Lighting.ColorCorrection.Saturation = 0.2;
					end
end)
Visuals1:addToggle("FullBright", nil, function(FullBright)
        					if FullBright == true then
						FB = game:GetService("RunService").RenderStepped:Connect(function()
							game.Lighting.FogEnd = (99999999)
						end)
					else
						FB:Disconnect()
						game.Lighting.FogEnd = (2000)
					end
    end)
Visuals1:addToggle("First Person", nil, function(FirstPerson)
			    					if FirstPerson == true then
						game.Players.LocalPlayer.CameraMaxZoomDistance = 0.5
						game.Players.LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 0, -1)
						for childIndex, child in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if child:IsA("BasePart") and child.Name ~= "Head" then
								child:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
									child.LocalTransparencyModifier = child.Transparency
								end)
							end
						end
					else
						game.Players.LocalPlayer.CameraMaxZoomDistance = 20;
						game.Players.LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(2, 2, 0);
    					end
end)
			Visuals1:addToggle("ESP", nil, function(ESPT)
			    if ESPT == true then
    backupesp1 = game:GetService("Players").LocalPlayer.NameDisplayDistance
backupesp2 = game:GetService("Players").LocalPlayer.HealthDisplayDistance
    local Holder = Instance.new("Folder", game.CoreGui)
Holder.Name = "ESP"

local UpdateFuncs = {}

local Box = Instance.new("BoxHandleAdornment")
Box.Name = "nilBox"
Box.Size = Vector3.new(4, 7, 4)
Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
Box.Transparency = 0.7
Box.ZIndex = 0
Box.AlwaysOnTop = true
Box.Visible = true

local NameTag = Instance.new("BillboardGui")
NameTag.Name = "nilNameTag"
NameTag.Enabled = false
NameTag.Size = UDim2.new(0, 200, 0, 50)
NameTag.AlwaysOnTop = true
NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
local Tag = Instance.new("TextLabel", NameTag)
Tag.Name = "Tag"
Tag.BackgroundTransparency = 1
Tag.Position = UDim2.new(0, -50, 0, 0)
Tag.Size = UDim2.new(0, 300, 0, 20)
Tag.TextSize = 20
Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
Tag.TextStrokeTransparency = 0.4
Tag.Text = "nil"
Tag.Font = Enum.Font.SourceSansBold
Tag.TextScaled = false

local LoadCharacter = function(v)
	repeat wait() until v.Character ~= nil
	v.Character:WaitForChild("Humanoid")
	local vHolder = Holder:FindFirstChild(v.Name)
	vHolder:ClearAllChildren()
	local b = Box:Clone()
	b.Name = v.Name .. "Box"
	b.Adornee = v.Character
	b.Parent = vHolder
	local t = NameTag:Clone()
	t.Name = v.Name .. "NameTag"
	t.Enabled = true
	t.Parent = vHolder
	t.Adornee = v.Character:WaitForChild("Head", 5)
	if not t.Adornee then
		return UnloadCharacter(v)
	end
	t.Tag.Text = v.Name
	b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
	t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
	local UpdateNameTag = function()
		if not pcall(function()
			--v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			local maxh = math.floor(v.Character.Humanoid.MaxHealth)
			local h = math.floor(v.Character.Humanoid.Health)
			t.Tag.Text = v.Name .. "\n" .. ((maxh ~= 0 and tostring(math.floor((h / maxh) * 100))) or "0") .. "%  " .. tostring(h) .. "/" .. tostring(maxh)
		end) then
			UpdateFuncs[v] = nil
		end
	end
	UpdateNameTag()
	UpdateFuncs[v] = UpdateNameTag
end

local UnloadCharacter = function(v)
	local vHolder = Holder:FindFirstChild(v.Name)
	if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then
		vHolder:ClearAllChildren()
	end
end

local LoadPlayer = function(v)
	local vHolder = Instance.new("Folder", Holder)
	vHolder.Name = v.Name
	v.CharacterAdded:Connect(function()
		pcall(LoadCharacter, v)
	end)
	v.CharacterRemoving:Connect(function()
		pcall(UnloadCharacter, v)
	end)
	LoadCharacter(v)
end

local UnloadPlayer = function(v)
	UnloadCharacter(v)
	local vHolder = Holder:FindFirstChild(v.Name)
	if vHolder then
		vHolder:Destroy()
	end
end

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	spawn(function() pcall(LoadPlayer, v) end)
end

game:GetService("Players").PlayerAdded:Connect(function(v)
	pcall(LoadPlayer, v)
end)

game:GetService("Players").PlayerRemoving:Connect(function(v)
	pcall(UnloadPlayer, v)
end)

game.ItemChanged:Connect(function(i, v)
	if i:IsA("Player") and v == "TeamColor" then
		if Holder:FindFirstChild(i.Name) then
			UnloadCharacter(i)
			wait()
			LoadCharacter(i)
		end
	elseif i:IsA("Humanoid") and i.Parent then
		local p = game:GetService("Players"):GetPlayerFromCharacter(i.Parent)
		if p and Holder:FindFirstChild(p.Name) then
			UpdateFuncs[p]()
		end
	end
end)
game:GetService("Players").LocalPlayer.NameDisplayDistance = 0
game:GetService("Players").LocalPlayer.HealthDisplayDistance = 0
else
    game:GetService("CoreGui").ESP:Destroy()
game:GetService("Players").LocalPlayer.NameDisplayDistance = backupesp1
game:GetService("Players").LocalPlayer.HealthDisplayDistance = backupesp2
    end
			end)
		    Visuals1:addButton("More Features Coming Soon", function()
end)
local PvP = funkyhub:addPage("PvP", 5012544693)
local PvP1 = PvP:addSection("PvP")
			PvP1:addToggle("Ranked/HTC GodMode", nil, function(GodModeN)
			            if GodModeN == true then
game.Players.LocalPlayer.Character.Stats["Phys-Resist"]:Destroy()
game.Players.LocalPlayer.Character.Stats["Ki-Resist"]:Destroy()
					else
game.Players.LocalPlayer.Character.Humanoid.Health = 0
					end
			    end)
		 PvP1:addToggle("GodMode Earth", nil, function(GodModeE)
		         if GodModeE == true then
					local God = game.Workspace.Touchy.Part
						local Root = game.Players.LocalPlayer.Character.HumanoidRootPart
						EGod = game:GetService("RunService").RenderStepped:Connect(function()
							firetouchinterest(Root, God, 0)
							firetouchinterest(Root, God, 1)
							if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Popup") then
								game.Players.LocalPlayer.PlayerGui.Popup:Destroy()
							end
						end)
					else
						EGod:Disconnect()
						if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Popup") then
							game.Players.LocalPlayer.PlayerGui.Popup:Destroy()
						end
					end
			  end)  			    
		PvP1:addToggle("No Slow", nil, function(NoSlowT)
		    if NoSlowT == true then
						Slow = game:GetService('RunService').Stepped:Connect(function()
							if game.Players.LocalPlayer.Character:FindFirstChild("Action") then
								game.Players.LocalPlayer.Character:FindFirstChild("Action"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("Attacking") then
								game.Players.LocalPlayer.Character:FindFirstChild("Attacking"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("Using") then
								game.Players.LocalPlayer.Character:FindFirstChild("Using"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("hyper") then
								game.Players.LocalPlayer.Character:FindFirstChild("hyper"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("Hyper") then
								game.Players.LocalPlayer.Character:FindFirstChild("Hyper"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("heavy") then
								game.Players.LocalPlayer.Character:FindFirstChild("heavy"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("KiBlasted") then
								game.Players.LocalPlayer.Character:FindFirstChild("KiBlasted"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("Tele") then
								game.Players.LocalPlayer.Character:FindFirstChild("Tele"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("tele") then
								game.Players.LocalPlayer.Character:FindFirstChild("tele"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("Killed") then
								game.Players.LocalPlayer.Character:FindFirstChild("Killed"):Destroy()
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("Slow") then
								game.Players.LocalPlayer.Character:FindFirstChild("Slow"):Destroy()
							end
						end)
					else
						Slow:Disconnect()
					end
		end)
	    		    PvP1:addButton("Lock On [U]", function()
end)
PvP1:addKeybind("Toxic Clap", Enum.KeyCode.LeftAlt, function()
    local randommessagenumber = math.random(1,4)
        if randommessagenumber == 1 then
local args = {
    [1] = "Ur Trash Kid",
    [2] = "All"
}
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end
        if randommessagenumber == 2 then
local args = {
    [1] = "Noob",
    [2] = "All"
}
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end
        if randommessagenumber == 3 then
local args = {
    [1] = "I had Lag and still won Noob",
    [2] = "All"
}
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end
        if randommessagenumber == 4 then
local args = {
    [1] = "Go Back to Fortnite",
    [2] = "All"
}
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end
end)
		    PvP1:addButton("More Features Coming Soon", function()
end)
local Shop = funkyhub:addPage("Shop", 5012544693)
local beanstojar = Shop:addSection("Beans&Jars")
beanstojar:addDropdown("Beans", {
	"Stop Buying",
	"Red Beans",
	"Green Beans",
	"Blue Beans",
	"Yellow Beans"
}, function(Beans)
	if Beans == "Red Beans" then
		_G.BeanBuy1 = true
		_G.BeanBuy2 = false
		_G.BeanBuy3 = false
		_G.BeanBuy4 = false
		while _G.BeanBuy1 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Beans"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Red"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	elseif Beans == "Green Beans" then
		_G.BeanBuy1 = false
		_G.BeanBuy2 = true
		_G.BeanBuy3 = false
		_G.BeanBuy4 = false
		while _G.BeanBuy2 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Beans"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Green"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	elseif Beans == "Blue Beans" then
		_G.BeanBuy1 = false
		_G.BeanBuy2 = false
		_G.BeanBuy3 = true
		_G.BeanBuy4 = false
		while _G.BeanBuy3 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Beans"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Blue"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	elseif Beans == "Yellow Beans" then
		_G.BeanBuy1 = false
		_G.BeanBuy2 = false
		_G.BeanBuy3 = false
		_G.BeanBuy4 = true
		while _G.BeanBuy4 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Beans"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yellow"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	else
		_G.BeanBuy1 = false
		_G.BeanBuy2 = false
		_G.BeanBuy3 = false
		_G.BeanBuy4 = false
	end
end)
beanstojar:addDropdown("Jars", {
	"Stop Buying",
	"Red Jars",
	"Green Jars",
	"Blue Jars",
	"Yellow Jars"
}, function(Jars)
	if Jars == "Red Jars" then
		_G.JarBuy1 = true
		_G.JarBuy2 = false
		_G.JarBuy2 = false
		_G.JarBuy4 = false
		while _G.JarBuy1 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Jars"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Red"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	elseif Jars == "Green Jars" then
		_G.JarBuy1 = false
		_G.JarBuy2 = true
		_G.JarBuy3 = false
		_G.JarBuy4 = false
		while _G.JarBuy2 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Jars"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Green"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	elseif Jars == "Blue Jars" then
		_G.JarBuy1 = false
		_G.JarBuy2 = false
		_G.JarBuy3 = true
		_G.JarBuy4 = false
		while _G.JarBuy3 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Jars"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Blue"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	elseif Jars == "Yellow Jars" then
		_G.JarBuy1 = false
		_G.JarBuy2 = false
		_G.JarBuy3 = false
		_G.JarBuy4 = true
		while _G.JarBuy4 and wait() do
			local A_1 = game:GetService("Workspace").FriendlyNPCs["Korin BEANS"]
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Jars"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "80"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yellow"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "Yes"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
			local A_1 = {
				[1] = "k"
			}
			local Event = game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance
			Event:FireServer(A_1)
			wait(0.3)
		end
	else
		_G.JarBuy1 = false
		_G.JarBuy2 = false
		_G.JarBuy3 = false
		_G.JarBuy4 = false
	end
end)
		local Others1 = Shop:addSection("Others")
				Others1:addToggle("Auto Elder Kai", nil, function(ElderKaiT)
				        ElderKaiTT = ElderKaiT
    local ohInstance11 = workspace.FriendlyNPCs["Elder Kai"]
local ohTable11 = {
	[1] = "k"
}
local ohTable22 = {
	[1] = "Yes"
}
    repeat wait() if ElderKaiTT == true then
    Zenni = tonumber((string.gsub((game.Players.LocalPlayer.PlayerGui.HUD.FullSize.Money.Text:sub(2)),",","")))
if Zenni >= 10000 then
game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(ohInstance11)
wait(0.3)
game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer(ohTable11)
wait(0.3)
game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer(ohTable22)
wait(0.3)
game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer(ohTable11)
wait(0.3)
end
end
until ElderKaiTT == false
				end)
			    Others1:addButton("Aqua Gi", function()
			            game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Aqua Gi"])
end)
			    Others1:addButton("TC Armor", function()
			            game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["TC Armor"])
end)
local saiyans = Shop:addSection("Saiyans")
local arcosians = Shop:addSection("Arcosian")
local humans = Shop:addSection("Human")
local jirens = Shop:addSection("Jirens")
local namekian = Shop:addSection("Namekians")
local majins = Shop:addSection("Majins")
local otherbs = Shop:addSection("Other")
local heavenbullshit = Shop:addSection("Heaven Moves")
saiyans:addButton("MSSJB, CSSJB, SSJBE", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Complete Super Saiyan Blue")
end)
saiyans:addButton("SSJ4", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("SSJ4")
end)
arcosians:addButton("Cooler Form", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Cooler Form")
end)
arcosians:addButton("Golden Cooler Form", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Golden Cooler")
end)
humans:addButton("KKX100, Kaioken x 100", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("KaioKenx100")
end)
humans:addButton("Dark Human", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Dark Human")
end)
jirens:addButton("Despair", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Despair")
end)
namekian:addButton("Demon Namekian", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Demon Namekian")
end)
namekian:addButton("White Namekian", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("White Namek")
end)
majins:addButton("Dark Majin", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Dark Majin")
end)
majins:addButton("Unstable Majin", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Unstable")
end)
otherbs:addButton("MUI", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Mastered Ultra Instinct")
end)
heavenbullshit:addButton("God Evade", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("God Evade")
end)
heavenbullshit:addButton("God Punch", function()
	game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("God Punch")
end)
local AutoFarmPage = funkyhub:addPage("AutoFarm", 5012544693)
local AutoFarm = AutoFarmPage:addSection("AutoFarm")
AutoFarm:addButton("Recommended Farm", function()
	game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC1.Button.Textbox.Text = "Saiba"
	game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC2.Button.Textbox.Text = "Saiyan"
	game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC3.Button.Textbox.Text = "Chi"
	game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC4.Button.Textbox.Text = "Boxer"
end)
AutoFarm:addTextbox("NPC1", "", function(a)
	NPCS1 = a;
end)
AutoFarm:addTextbox("NPC2", "", function(a)
	NPC2 = a;
end)
AutoFarm:addTextbox("NPC3", "", function(a)
	NPCS3 = a;
end)
AutoFarm:addTextbox("NPC4", "", function(a)
	NPCS4 = a;
end)
game.CoreGui["Funky Hub"].Main.AutoFarm.AutoFarm.Container.Textbox.Name = "NPC1"
game.CoreGui["Funky Hub"].Main.AutoFarm.AutoFarm.Container.Textbox.Name = "NPC2"
game.CoreGui["Funky Hub"].Main.AutoFarm.AutoFarm.Container.Textbox.Name = "NPC3"
game.CoreGui["Funky Hub"].Main.AutoFarm.AutoFarm.Container.Textbox.Name = "NPC4"

AutoFarm:addToggle("Auto Attack", nil, function(AutoAttack)
	if AutoAttack then
		Auto_Attack = true
		while Auto_Attack == true do
			wait(.3)
			if Auto_Attack == true and Target then
				if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Target.HumanoidRootPart.Position).magnitude < 13 and game.PlaceId == 536102540 then
					game.Players.LocalPlayer.Backpack.ServerTraits.Input:FireServer({
						[1] = "md"
					}, CFrame.new(0, 0, 0), nil, false)
				elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Target.HumanoidRootPart.Position).magnitude < 13 and game.PlaceId ~= 536102540 then
					game.Players.LocalPlayer.Backpack.ServerTraits.Input:FireServer({
						[1] = "md"
					}, CFrame.new(0, 0, 0), nil, false)
				end
			end
		end
	else
		Auto_Attack = false
	end
end)
AutoFarm:addToggle("Reset Ki", nil, function(a)
	if a == true then
		_G.RESETSTAM = true
		repeat
			wait()
			if game:GetService("Players").LocalPlayer.Character.Ki.Value <= 100 and Target then
				game:GetService("ReplicatedStorage").ResetChar:FireServer()
			end
		until _G.RESETSTAM == false
	else
		_G.RESETSTAM = false
	end
end)
local fuckufuckingskidassskidnig
AutoFarm:addToggle("Start Auto Farm", nil, function(a)
	fuckufuckingskidassskidnig = a
	if a then
		local NPCS = {
			game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC1.Button.Textbox.Text,
			game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC2.Button.Textbox.Text,
			game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC3.Button.Textbox.Text,
			game:GetService("CoreGui")["Funky Hub"].Main.AutoFarm.AutoFarm.Container.NPC4.Button.Textbox.Text
		}
		local NPCNUMBER = 1
		while fuckufuckingskidassskidnig == true and wait() do
			for _, v in pairs(game.Workspace.Live:GetChildren()) do
				if v.Name:find(NPCS[NPCNUMBER]) and string.len(NPCS[NPCNUMBER]) > 2 and v.Humanoid.Health > 1 then
					Target = v
					repeat
						game:GetService("RunService").RenderStepped:Wait()
						if fuckufuckingskidassskidnig == true then
							if 1 >= game.Players.LocalPlayer.Character.Humanoid.Health then
								repeat
									wait()
								until 1 < game.Players.LocalPlayer.Character.Humanoid.Health
							end
							game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
							local Time
							game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(v.HumanoidRootPart.Position.X, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y, v.HumanoidRootPart.Position.Z)) * CFrame.new(0, 2, 10)
							Time = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude / 5000
							game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
							}):Play()
						end
					until v.Humanoid.Health <= 0.01 or fuckufuckingskidassskidnig == false
				end
			end
			if NPCNUMBER ~= 4 then
				NPCNUMBER = NPCNUMBER + 1
			elseif NPCNUMBER == 4 then
				NPCNUMBER = 1
			end
		end
	else
		Target = nil
	end
end)
local Moves = AutoFarmPage:addSection("Moves")
Moves:addButton("Recommended Melee Moves", function()
	m_1.Button.Textbox.Text = "Wolf Fang Fist"
	m_2.Button.Textbox.Text = "Deadly Dance"
	m_3.Button.Textbox.Text = "Mach Kick"
	m_4.Button.Textbox.Text = "Anger Rush"
	m_5.Button.Textbox.Text = "Neo Wolf Fang Fist"
	m_6.Button.Textbox.Text = "Meteor Crash"
	m_7.Button.Textbox.Text = "Spirit Bomb Sword"
	m_7.Button.Textbox.Text = "Flash Skewer"
	m_8.Button.Textbox.Text = "TS Molotov"
	m_9.Button.Textbox.Text = "Sweep Kick"
end)
m_1 = Moves:addTextbox("Move1", "", function(a)
	va = a
end)
m_2 = Moves:addTextbox("Move2", "", function(a)
	va = a
end)
m_3 = Moves:addTextbox("Move3", "", function(a)
	va = a
end)
m_4 = Moves:addTextbox("Move4", "", function(a)
	va = a
end)
m_5 = Moves:addTextbox("Move5", "", function(a)
	va = a
end)
m_6 = Moves:addTextbox("Move6", "", function(a)
	va = a
end)
m_7 = Moves:addTextbox("Move7", "", function(a)
	va = a
end)
m_8 = Moves:addTextbox("Move8", "", function(a)
	va = a
end)
m_9 = Moves:addTextbox("Move9", "", function(a)
	va = a
end)
Moves:addToggle("Use Moves", nil, function(a)
	if a then
		va = true
		repeat
			while va do
				for fe, fg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if fg.Name == nil then
					elseif fg.Name == vb or fg.Name == vc or fg.Name == vd or fg.Name == ve or fg.Name == vg or fg.Name == vh or fg.Name == vj or fg.Name == vk or fg.Name == vl then
						fg.Parent = game.Players.LocalPlayer.Character
						fg:Activate()
						fg:Deactivate()
						wait(0.2)
						fg.Parent = game.Players.LocalPlayer.Backpack
					end
				end
			end
		until va == true and not a and game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Target.HumanoidRootPart.Position.magnitude <= 40
	else
		va = false
	end
end)
local AutoRedQuest = AutoFarmPage:addSection("Auto Red Quests")
AutoRedQuest:addButton("Do Bulma Quest", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/StepSisSnow/StepSisSnowsScripts/main/BulmaQuest.lua"))()
end)
AutoRedQuest:addButton("Do Trunks Quest", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/StepSisSnow/StepSisSnowsScripts/main/TrunksFuture.lua"))()
end)
AutoRedQuest:addButton("Do Namek Ship Quest", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/StepSisSnow/StepSisSnowsScripts/main/NamekSpaceShip.lua"))()
end)
AutoRedQuest:addButton("Do Korin Tower Quest", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/StepSisSnow/StepSisSnowsScripts/main/KorinDrink.lua"))()
end)
AutoRedQuest:addButton("Get Elder Kai Once", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/StepSisSnow/StepSisSnowsScripts/main/ElderKaiOnce.lua"))()
end)
local AutoStatsPage = Library:addPage("Auto Stats", 5012544693)
local AutoStat = AutoStatsPage:addSection("Auto Stats")
AutoStat:addToggle("Health Max", nil, function(a)
	if a == true then
		_G.stat1 = true
		repeat
			wait()
			game:GetService("Players").LocalPlayer.Backpack.ServerTraits.AttemptUpgrade:FireServer(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bottom.Stats["Health-Max"])
		until _G.stat1 == false
	else
		_G.stat1 = false
	end
end)
AutoStat:addToggle("Ki Max", nil, function(a)
	if a == true then
		_G.stat2 = true
		repeat
			wait()
			game:GetService("Players").LocalPlayer.Backpack.ServerTraits.AttemptUpgrade:FireServer(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bottom.Stats["Ki-Max"])
		until _G.stat2 == false
	else
		_G.stat2 = false
	end
end)
AutoStat:addToggle("Melee Damage", nil, function(a)
	if a == true then
		_G.stat3 = true
		wait()
		game:GetService("Players").LocalPlayer.Backpack.ServerTraits.AttemptUpgrade:FireServer(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bottom.Stats["Phys-Damage"])
	elseif _G.stat3 ~= false then
		_G.stat3 = false
	end
end)
AutoStat:addToggle("Ki Damage", nil, function(a)
	if a == true then
		_G.stat4 = true
		wait()
		game:GetService("Players").LocalPlayer.Backpack.ServerTraits.AttemptUpgrade:FireServer(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bottom.Stats["Ki-Damage"])
	elseif _G.stat4 ~= false then
		_G.stat4 = false
	end
end)
AutoStat:addToggle("Melee Resistance", nil, function(a)
	if a == true then
		_G.stat5 = true
		wait()
		game:GetService("Players").LocalPlayer.Backpack.ServerTraits.AttemptUpgrade:FireServer(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bottom.Stats["Phys-Resist"])
	elseif _G.stat5 ~= false then
		_G.stat5 = false
	end
end)
AutoStat:addToggle("Ki Resistance", nil, function(a)
	if a == true then
		_G.stat6 = true
		repeat
			wait()
			game:GetService("Players").LocalPlayer.Backpack.ServerTraits.AttemptUpgrade:FireServer(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bottom.Stats["Ki-Resist"])
		until _G.stat6 == false
	else
		_G.stat6 = false
	end
end)
AutoStat:addToggle("Speed", nil, function(a)
	if a == true then
		_G.stat7 = true
		wait()
		game:GetService("Players").LocalPlayer.Backpack.ServerTraits.AttemptUpgrade:FireServer(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bottom.Stats.Speed)
	elseif _G.stat7 ~= false then
		_G.stat7 = false
	end
end)

local Teleports = funkyhub:addPage("Teleports", 5012544693)
local Teleports1 = Teleports:addSection("Teleports")
Teleports1:addButton("Broly Pad", function()
	game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2, Enum.EasingStyle.Quad), {
		CFrame = CFrame.new(2751.67725, 3944.85986, -2272.62622)
	}):Play()
end)
Teleports1:addButton("TOP Pad", function()
	game:GetService("TweenService"):Create(game:GetService("Players").Localplayer.Character.HumanoidRootPart, TweenInfo.new(2, Enum.EasingStyle.Quad), {
		CFrame = CFrame.new(2508.15, 3945.41, -2029.8)
	}):Play()
end)
Teleports1:addButton("Hard TOP Pad", function()
	game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2, Enum.EasingStyle.Quad), {
		CFrame = CFrame.new(2510.97656, 3944.75, -2527.53125)
	}):Play()
end)
			    Teleports1:addButton("Earth", function()
			        game:GetService("TeleportService"):Teleport(536102540, game.Players.LocalPlayer)
end)
			    Teleports1:addButton("Namek", function()
			        game:GetService("TeleportService"):Teleport(882399924, game.Players.LocalPlayer)
end)
			    Teleports1:addButton("Space", function()
			        game:GetService("TeleportService"):Teleport(478132461, game.Players.LocalPlayer)
end)
			    Teleports1:addButton("Future", function()
			        game:GetService("TeleportService"):Teleport(569994010, game.Players.LocalPlayer)
end)
			    Teleports1:addButton("Secret World", function()
			        game:GetService("TeleportService"):Teleport(2046990924, game.Players.LocalPlayer)
end)
			    Teleports1:addButton("Queue World", function()
			        game:GetService("TeleportService"):Teleport(3565304751, game.Players.LocalPlayer)
end)
			    Teleports1:addButton("HTC", function()
			        game:GetService("TeleportService"):Teleport(882375367, game.Players.LocalPlayer)
end)
			    Teleports1:addButton("Heaven", function()
			     game:GetService("TeleportService"):Teleport(3552157537, game.Players.LocalPlayer)   
end)

local StatChecker = funkyhub:addPage("Stat Checker", 5012544693)
local StatChecker1 = StatChecker:addSection("Stat Checker")
StatChecker1:addTextbox("Target Name", "", function(Target, focusLost)
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["2"].Button.Textbox.Text = game.Workspace.Live[Target].Race.Value 
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["3"].Button.Textbox.Text = game.Workspace.Live[Target].Stats["Health-Max"].Value
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["4"].Button.Textbox.Text = game.Workspace.Live[Target].Stats["Ki-Max"].Value
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["5"].Button.Textbox.Text = game.Workspace.Live[Target].Stats["Phys-Damage"].Value
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["6"].Button.Textbox.Text = game.Workspace.Live[Target].Stats["Ki-Damage"].Value
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["7"].Button.Textbox.Text = game.Workspace.Live[Target].Stats["Phys-Resist"].Value
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["8"].Button.Textbox.Text = game.Workspace.Live[Target].Stats["Ki-Resist"].Value
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["9"].Button.Textbox.Text = game.Workspace.Live[Target].Stats["Speed"].Value
    						if game:GetService("Workspace").Live[Target]:FindFirstChild("RebirthWings") then
    						    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["10"].Button.Textbox.Text = "Rebirth"
						elseif game:GetService("Workspace").Live[Target]:FindFirstChild("RealHalo") then
						game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["10"].Button.Textbox.Text = "Heaven"
						else
						        game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["10"].Button.Textbox.Text = "Pure"
						end
    game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container["2"].Button.Textbox.Text = ExtraThing
end)
StatChecker1:addTextbox("1. Race:", "", function(Health, focusLost)
end)
StatChecker1:addTextbox("2. Health Max:", "", function(Health, focusLost)
end)
StatChecker1:addTextbox("3. Ki Max:", "", function(Ki, focusLost)
end)
StatChecker1:addTextbox("4. Melee Damage:", "", function(MeleeDmg, focusLost)
end)
StatChecker1:addTextbox("5. Ki Damage:", "", function(KiDmg, focusLost)
end)
StatChecker1:addTextbox("6. Melee Resistance:", "", function(MeleeRes, focusLost)
end)
StatChecker1:addTextbox("7. Ki Resistance:", "", function(KiRes, focusLost)
end)
StatChecker1:addTextbox("8. Speed:", "", function(Speed, focusLost)
end)
StatChecker1:addTextbox("9. Extra:", "", function(Extra, focusLost)
end)
statcheckthing = 1
for i, v in pairs(game.CoreGui["Funky Hub"].Main["Stat Checker"]["Stat Checker"].Container:GetDescendants()) do
if v:IsA("ImageButton") then
    v.Name = statcheckthing
    statcheckthing = statcheckthing + 1
end
end
local Settings = funkyhub:addPage("Settings", 5012544693)
local Settings1 = Settings:addSection("Settings")
for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
Settings1:addColorPicker(theme, color, function(color3)
funkyhub:setTheme(theme, color3)
end)
end
Settings1:addKeybind("Toggle Keybind", Enum.KeyCode.RightShift, function()
funkyhub:toggle()
end, function()
end)


funkyhub:SelectPage(funkyhub.pages[1], true)  

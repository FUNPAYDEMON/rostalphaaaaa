

--//status ^^\\--
--//library ^^\\--
local L_1_                 = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local L_2_              = loadstring(game:HttpGet(L_1_ .. 'Library.lua'))()
local L_3_         = loadstring(game:HttpGet('https://pastefy.app/nFt5k9mK/raw'))()
local L_4_          = loadstring(game:HttpGet(L_1_ .. 'addons/SaveManager.lua'))()
--//enviroment ^^\\--
local L_5_               = cloneref(workspace.CurrentCamera)
local L_6_              = cloneref(game:GetService("Players"))
local L_7_           = cloneref(game:GetService("RunService"))
local L_8_     = cloneref(game:GetService("UserInputService"))
local L_9_             = cloneref(game:GetService("Lighting"))
local L_10_    = cloneref(game:GetService("ReplicatedStorage"))
local L_11_          = L_6_.LocalPlayer
local L_12_           = L_6_.GetPlayers
local L_13_ = L_5_.WorldToViewportPoint
local L_14_       = game.FindFirstChild
local L_15_        = L_7_.RenderStepped
local L_16_     = L_8_.GetMouseLocation
local L_17_               = coroutine.resume
local L_18_               = coroutine.create
--//incel variables ^^\\--
local L_19_ = {
	aim = {
		enabled        =     false,
		type           =     "silent",
		fov_circle     =     false,
		target_line    =     false,
		fov_radius     =     50,
		player_info    =     false,
		aim_bone       =     "Head",
		fov_color      =     Color3.fromRGB(255, 255, 255),
		snapline_color =     Color3.fromRGB(255, 255, 255)
	},
	mods = {
		no_recoil      =    false,
		no_spread      =    false
	},
	esp = {
		enabled        =    false,
		box            =    false,
		name           =    false,
		weapon         =    false,
		distance       =    false,
		max_distance   =    800
	},
	world = {
		time           =    false,
		time_value     =    12,
		ambient        =    false,
		amb_color      =    Color3.fromRGB(255, 255, 255),
		remove_grass   =    false
	},
	misc = {
		custom_tool    =    false,
		tool_color     =    Color3.fromRGB(128, 0, 128),
		material       =    "ForceField"
	}
}

local L_20_ = {
	TimeOfDay = L_9_.TimeOfDay
}
local L_21_ = {
	Ambient = L_9_.Ambient
}

local L_22_
L_22_ = hookmetamethod(game, "__index", function(L_77_arg0, L_78_arg1)
	if not checkcaller() and L_77_arg0 == L_9_ then
		if L_78_arg1 == "TimeOfDay" and L_19_.world.time then
			return L_19_.world.time_value
		elseif L_78_arg1 == "Ambient" and L_19_.world.ambient then
			return L_19_.world.amb_color
		end
	end
	return L_22_(L_77_arg0, L_78_arg1)
end)

local L_23_
L_23_ = hookmetamethod(game, "__newindex", function(L_79_arg0, L_80_arg1, L_81_arg2)
	if not checkcaller() and L_79_arg0 == L_9_ then
		if L_80_arg1 == "TimeOfDay" then
			L_20_.TimeOfDay = L_81_arg2
			if L_19_.world.time then
				return
			end
		elseif L_80_arg1 == "Ambient" then
			L_21_.Ambient = L_81_arg2
			if L_19_.world.ambient then
				return
			end
		end
	end
	return L_23_(L_79_arg0, L_80_arg1, L_81_arg2)
end)

local L_24_ = Drawing.new("Circle")
L_24_.Thickness = 1
L_24_.NumSides = 100
L_24_.Radius = L_19_.aim.fov_radius
L_24_.Filled = false
L_24_.Visible = L_19_.aim.fov_circle
L_24_.ZIndex = 999
L_24_.Transparency = 1
L_24_.Color = L_19_.aim.fov_color

local L_25_ = Drawing.new("Line")
L_25_.Visible = L_19_.aim.target_line
L_25_.Color = L_19_.aim.snapline_color
L_25_.Thickness = 1
L_25_.Transparency = 1

local L_26_ = {}

local L_27_ = {}
local L_28_ = {
	"Scope",
	"Sights",
	"Aim",
	"Crosshair",
	"Reticle",
	"Sight",
	"sight"
}

local function L_29_func(L_82_arg0)
	return Vector2.new(math.floor(L_82_arg0.X + 0.5), math.floor(L_82_arg0.Y + 0.5))
end

local function L_30_func(L_83_arg0)
	local L_84_, L_85_ = L_83_arg0.CFrame, L_83_arg0.Size
	local L_86_, L_87_, L_88_ = L_85_.X, L_85_.Y, L_85_.Z
	return {
		TBRC = L_84_ * CFrame.new(L_86_, L_87_ * 1.3, L_88_),
		TBLC = L_84_ * CFrame.new(-L_86_, L_87_ * 1.3, L_88_),
		TFRC = L_84_ * CFrame.new(L_86_, L_87_ * 1.3, -L_88_),
		TFLC = L_84_ * CFrame.new(-L_86_, L_87_ * 1.3, -L_88_),
		BBRC = L_84_ * CFrame.new(L_86_, -L_87_ * 1.6, L_88_),
		BBLC = L_84_ * CFrame.new(-L_86_, -L_87_ * 1.6, L_88_),
		BFRC = L_84_ * CFrame.new(L_86_, -L_87_ * 1.6, -L_88_),
		BFLC = L_84_ * CFrame.new(-L_86_, -L_87_ * 1.6, -L_88_)
	}
end

local function L_31_func(L_89_arg0, L_90_arg1)
	local L_91_ = Drawing.new(L_89_arg0)
	for L_92_forvar0, L_93_forvar1 in pairs(L_90_arg1) do
		L_91_[L_92_forvar0] = L_93_forvar1
	end
	return L_91_
end

local function L_32_func(L_94_arg0)
	local L_95_ = L_94_arg0.Character
	if L_95_ then
		local L_96_ = L_95_:FindFirstChildOfClass("Tool")
		return L_96_ and L_96_.Name or "Hands"
	end
	return "Hands"
end

local function L_33_func(L_97_arg0)
	return L_97_arg0:IsA("BasePart") or L_97_arg0:IsA("MeshPart") or L_97_arg0:IsA("UnionOperation") or 
           L_97_arg0:IsA("WedgePart") or L_97_arg0:IsA("CornerWedgePart") or L_97_arg0:IsA("TrussPart")
end

local function L_34_func(L_98_arg0)
	local L_99_ = L_98_arg0
	while L_99_ and L_99_.Parent do
		if L_99_:IsA("Model") then
			local L_100_ = L_99_.Name:lower()
			for L_101_forvar0, L_102_forvar1 in ipairs(L_28_) do
				if L_100_:find(L_102_forvar1:lower()) then
					return true
				end
			end
		end
		L_99_ = L_99_.Parent
	end
	return false
end

local function L_35_func(L_103_arg0)
	for L_104_forvar0, L_105_forvar1 in ipairs(L_103_arg0:GetChildren()) do
		if L_105_forvar1:IsA("SurfaceAppearance") then
			L_105_forvar1:Destroy()
		end
	end
end

local function L_36_func(L_106_arg0)
	if L_27_[L_106_arg0] then
		L_106_arg0.Material = L_27_[L_106_arg0].Material
		L_106_arg0.Color = L_27_[L_106_arg0].Color
		L_27_[L_106_arg0] = nil
	else
		L_106_arg0.Material = Enum.Material.Plastic
		L_106_arg0.Color = Color3.fromRGB(163, 162, 165)
	end
end

local function L_37_func(L_107_arg0)
	if not L_107_arg0 then
		for L_108_forvar0, L_109_forvar1 in pairs(L_27_) do
			L_36_func(L_108_forvar0)
		end
		L_27_ = {}
		return
	end
	for L_110_forvar0, L_111_forvar1 in ipairs(L_107_arg0:GetDescendants()) do
		if L_33_func(L_111_forvar1) and not L_34_func(L_111_forvar1) then
			if not L_27_[L_111_forvar1] then
				L_27_[L_111_forvar1] = {
					Material = L_111_forvar1.Material,
					Color = L_111_forvar1.Color
				}
			end
			L_35_func(L_111_forvar1)
			L_111_forvar1.Material = Enum.Material.ForceField
			L_111_forvar1.Color = L_19_.misc.tool_color
		elseif L_27_[L_111_forvar1] then
			L_36_func(L_111_forvar1)
		end
	end
end

local L_38_
local function  L_39_func(L_112_arg0)
	L_19_.misc.custom_tool = L_112_arg0
	if L_112_arg0 then
		L_38_ = L_7_.RenderStepped:Connect(function()
			local L_113_ = L_11_.Character
			if not L_113_ then
				for L_115_forvar0, L_116_forvar1 in pairs(L_27_) do
					L_36_func(L_115_forvar0)
				end
				L_27_ = {}
				return
			end
			local L_114_ = L_113_:FindFirstChildOfClass("Tool") or L_11_.Backpack:FindFirstChildOfClass("Tool")
			L_37_func(L_114_)
		end)
	else
		if L_38_ then
			L_38_:Disconnect()
			L_38_ = nil
		end
		for L_117_forvar0, L_118_forvar1 in pairs(L_27_) do
			L_36_func(L_117_forvar0)
		end
		L_27_ = {}
	end
end

local function L_40_func()
	for L_119_forvar0, L_120_forvar1 in pairs(L_26_) do
		if not L_19_.esp.enabled then
			for L_136_forvar0, L_137_forvar1 in pairs(L_120_forvar1) do
				L_137_forvar1.Visible = false
			end
			continue
		end
		local L_121_ = L_119_forvar0.Character
		if not L_121_ then
			for L_138_forvar0, L_139_forvar1 in pairs(L_120_forvar1) do
				L_139_forvar1.Visible = false
			end
			continue
		end
		local L_122_ = L_121_:FindFirstChild("HumanoidRootPart")
		local L_123_ = L_121_:FindFirstChild("Head")
		local L_124_ = L_121_:FindFirstChildOfClass("Humanoid")
		if not (L_122_ and L_123_ and L_124_ and L_124_.Health > 0) then
			for L_140_forvar0, L_141_forvar1 in pairs(L_120_forvar1) do
				L_141_forvar1.Visible = false
			end
			continue
		end
		local L_125_ = (L_11_.Character and L_11_.Character:FindFirstChild("HumanoidRootPart") and (L_11_.Character.HumanoidRootPart.Position - L_122_.Position).Magnitude) or math.huge
		if L_125_ > L_19_.esp.max_distance then
			for L_142_forvar0, L_143_forvar1 in pairs(L_120_forvar1) do
				L_143_forvar1.Visible = false
			end
			continue
		end
		local L_126_, L_127_ = L_5_:WorldToViewportPoint(L_122_.Position)
		local L_128_ = math.floor(L_125_ + 0.5)
		if not L_127_ then
			for L_144_forvar0, L_145_forvar1 in pairs(L_120_forvar1) do
				L_145_forvar1.Visible = false
			end
			continue
		end
		local L_129_ = L_30_func(L_122_)
		local L_130_, L_131_, L_132_, L_133_ = L_5_.ViewportSize.X, 0, L_5_.ViewportSize.X, 0
		for L_146_forvar0, L_147_forvar1 in pairs(L_129_) do
			local L_148_ = L_5_:WorldToViewportPoint(L_147_forvar1.Position)
			L_130_ = math.min(L_130_, L_148_.X)
			L_131_ = math.max(L_131_, L_148_.X)
			L_132_ = math.min(L_132_, L_148_.Y)
			L_133_ = math.max(L_133_, L_148_.Y)
		end
		local L_134_ = L_29_func(Vector2.new(L_130_ - L_131_, L_132_ - L_133_))
		local L_135_ = L_29_func(Vector2.new(L_131_ + L_134_.X / L_130_, L_133_ + L_134_.Y / L_132_))
		L_120_forvar1.box.Visible = L_19_.esp.box
		if L_19_.esp.box then
			L_120_forvar1.box.Size = L_134_
			L_120_forvar1.box.Position = L_135_
		end
		L_120_forvar1.name.Visible = L_19_.esp.name
		if L_19_.esp.name then
			L_120_forvar1.name.Text = L_119_forvar0.Name
			L_120_forvar1.name.Position = Vector2.new(L_131_ + L_134_.X / 2, L_135_.Y) - Vector2.new(0, L_120_forvar1.name.TextBounds.Y - L_134_.Y + 3)
		end
		L_120_forvar1.distance.Visible = L_19_.esp.distance
		if L_19_.esp.distance then
			L_120_forvar1.distance.Text = L_128_ .. "m"
			L_120_forvar1.distance.Position = Vector2.new(L_134_.X / 2 + L_135_.X, L_133_ + 1)
		end
		L_120_forvar1.weapon.Visible = L_19_.esp.weapon
		if L_19_.esp.weapon then
			L_120_forvar1.weapon.Text = L_32_func(L_119_forvar0)
			L_120_forvar1.weapon.Position = Vector2.new(L_131_ + L_134_.X + 3 + L_120_forvar1.weapon.TextBounds.X / 2, L_135_.Y + 2) - Vector2.new(L_134_.X, -(100 * (L_134_.Y - 4) / 100) + 2)
		end
	end
end

local function L_41_func(L_149_arg0)
	if L_149_arg0 == L_11_ then
		return
	end
	L_26_[L_149_arg0] = {
		box = L_31_func("Square", {
			Thickness = 1,
			Color = Color3.new(1, 1, 1),
			Filled = false
		}),
		name = L_31_func("Text", {
			Text = L_149_arg0.Name,
			Font = 2,
			Size = 13,
			Outline = true,
			Center = true,
			Color = Color3.new(1, 1, 1)
		}),
		distance = L_31_func("Text", {
			Font = 2,
			Size = 13,
			Outline = true,
			Center = true,
			Color = Color3.new(1, 1, 1)
		}),
		weapon = L_31_func("Text", {
			Font = 2,
			Size = 13,
			Outline = true,
			Center = true,
			Color = Color3.new(1, 1, 1)
		})
	}
end

local function L_42_func(L_150_arg0)
	if L_26_[L_150_arg0] then
		for L_151_forvar0, L_152_forvar1 in pairs(L_26_[L_150_arg0]) do
			L_152_forvar1:Remove()
		end
		L_26_[L_150_arg0] = nil
	end
end

for L_153_forvar0, L_154_forvar1 in pairs(L_6_:GetPlayers()) do
	L_41_func(L_154_forvar1)
end

L_6_.PlayerAdded:Connect(L_41_func)
L_6_.PlayerRemoving:Connect(L_42_func)

local L_43_ = Instance.new("ScreenGui")
local L_44_ = Instance.new("Frame")
local L_45_ = Instance.new("TextLabel")
local L_46_ = Instance.new("ImageLabel")
local L_47_ = Instance.new("TextLabel")
local L_48_ = Instance.new("TextLabel")
local L_49_ = Instance.new("TextLabel")

L_43_.Name = "Gui"
L_43_.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
L_43_.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
L_43_.ResetOnSpawn = false

L_44_.Name = "Main"
L_44_.Parent = L_43_
L_44_.BackgroundColor3 = Color3.new(0.101961, 0.101961, 0.101961)
L_44_.BackgroundTransparency = 0.699999988079071
L_44_.BorderColor3 = Color3.new(0, 0, 0)
L_44_.BorderSizePixel = 0
L_44_.Position = UDim2.new(0.607047856, 0, 0.694723606, 0)
L_44_.Size = UDim2.new(0, 104, 0, 68)
L_44_.Visible = false

L_45_.Name = "target_name"
L_45_.Parent = L_44_
L_45_.BackgroundColor3 = Color3.new(1, 1, 1)
L_45_.BackgroundTransparency = 1
L_45_.BorderColor3 = Color3.new(0, 0, 0)
L_45_.BorderSizePixel = 0
L_45_.Position = UDim2.new(0.413210928, 0, 0, 0)
L_45_.Size = UDim2.new(0, 60, 0, 15)
L_45_.Font = Enum.Font.Oswald
L_45_.Text = "player"
L_45_.TextColor3 = Color3.new(1, 0.941177, 0.894118)
L_45_.TextSize = 18
L_45_.TextXAlignment = Enum.TextXAlignment.Left
L_45_.ClipsDescendants = true

L_46_.Name = "skin"
L_46_.Parent = L_44_
L_46_.BackgroundColor3 = Color3.new(1, 1, 1)
L_46_.BackgroundTransparency = 1
L_46_.BorderColor3 = Color3.new(0, 0, 0)
L_46_.BorderSizePixel = 0
L_46_.Position = UDim2.new(0.0835060701, 0, 0.215355366, 0)
L_46_.Size = UDim2.new(0, 49, 0, 41)
L_46_.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

L_47_.Name = "holding"
L_47_.Parent = L_44_
L_47_.BackgroundColor3 = Color3.new(1, 1, 1)
L_47_.BackgroundTransparency = 1
L_47_.BorderColor3 = Color3.new(0, 0, 0)
L_47_.BorderSizePixel = 0
L_47_.Position = UDim2.new(0.592050433, 0, 0.230061248, 0)
L_47_.Size = UDim2.new(0, 0, 0, 0)
L_47_.Font = Enum.Font.Nunito
L_47_.Text = "ak1"
L_47_.TextColor3 = Color3.new(0.780392, 0.780392, 0.780392)
L_47_.TextStrokeColor3 = Color3.new(1, 0, 0)
L_47_.TextXAlignment = Enum.TextXAlignment.Left
L_47_.ClipsDescendants = true

L_48_.Name = "hp"
L_48_.Parent = L_44_
L_48_.BackgroundColor3 = Color3.new(1, 1, 1)
L_48_.BackgroundTransparency = 1
L_48_.BorderColor3 = Color3.new(0, 0, 0)
L_48_.BorderSizePixel = 0
L_48_.Position = UDim2.new(0.562637389, 0, 0.509473026, 0)
L_48_.Size = UDim2.new(0, 40, 0, 12)
L_48_.Font = Enum.Font.Nunito
L_48_.Text = "100"
L_48_.TextColor3 = Color3.new(0.14902, 1, 0.0196078)
L_48_.TextSize = 14
L_48_.TextXAlignment = Enum.TextXAlignment.Left
L_48_.ClipsDescendants = true

L_49_.Name = "dist"
L_49_.Parent = L_44_
L_49_.BackgroundColor3 = Color3.new(1, 1, 1)
L_49_.BackgroundTransparency = 1
L_49_.BorderColor3 = Color3.new(0, 0, 0)
L_49_.BorderSizePixel = 0
L_49_.Position = UDim2.new(0.562637389, 0, 0.833002448, 0)
L_49_.Size = UDim2.new(0, 40, 0, 12)
L_49_.Font = Enum.Font.Nunito
L_49_.Text = "1000"
L_49_.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
L_49_.TextSize = 14
L_49_.TextXAlignment = Enum.TextXAlignment.Left
L_49_.ClipsDescendants = true

local L_50_ = {
	Raycast = {
		ArgCountRequired = 3,
		Args = {
			"Instance",
			"Vector3",
			"Vector3",
			"RaycastParams"
		}
	}
}

local function L_51_func(L_155_arg0)
	if not L_5_ then
		return Vector2.new(0, 0), false
	end
	local L_156_, L_157_ = L_13_(L_5_, L_155_arg0)
	return Vector2.new(L_156_.X, L_156_.Y), L_157_
end

local function L_52_func(L_158_arg0, L_159_arg1)
	local L_160_ = 0
	if #L_158_arg0 < L_159_arg1.ArgCountRequired then
		return false
	end
	for L_161_forvar0, L_162_forvar1 in next, L_158_arg0 do
		if typeof(L_162_forvar1) == L_159_arg1.Args[L_161_forvar0] then
			L_160_ = L_160_ + 1
		end
	end
	return L_160_ >= L_159_arg1.ArgCountRequired
end

local function L_53_func(L_163_arg0, L_164_arg1)
	return (L_164_arg1 - L_163_arg0).Unit * 1000
end

local function L_54_func()
	return L_16_(L_8_)
end

local function L_55_func()
	if not L_5_ then
		return nil, nil
	end
	local L_165_
	local L_166_
	local L_167_ = L_19_.aim.fov_radius or 2000
	for L_168_forvar0, L_169_forvar1 in next, L_12_(L_6_) do
		if L_169_forvar1 == L_11_ then
			continue
		end
		local L_170_ = L_169_forvar1.Character
		if not L_170_ then
			continue
		end
		local L_171_ = L_14_(L_170_, L_19_.aim.aim_bone)
		local L_172_ = L_14_(L_170_, "Humanoid")
		if not L_171_ or not L_172_ or L_172_.Health <= 0 then
			continue
		end
		local L_173_, L_174_ = L_51_func(L_171_.Position)
		if not L_174_ then
			continue
		end
		local L_175_ = (L_54_func() - L_173_).Magnitude
		if L_175_ < L_167_ then
			L_165_ = L_171_
			L_166_ = L_169_forvar1
			L_167_ = L_175_
		end
	end
	return L_165_, L_166_
end

local L_56_
L_56_ = hookmetamethod(game, "__namecall", newcclosure(function(...)
	if not L_5_ then
		return L_56_(...)
	end
	local L_176_ = getnamecallmethod()
	local L_177_ = {
		...
	}
	local L_178_ = L_177_[1]
	if L_19_.aim.enabled and L_19_.aim.type == "silent" and L_178_ == workspace and not checkcaller() then
		if L_176_ == "Raycast" then
			if L_52_func(L_177_, L_50_.Raycast) then
				local L_179_ = L_177_[2]
				local L_180_, L_181_ = L_55_func()
				if L_180_ then
					L_177_[3] = L_53_func(L_179_, L_180_.Position)
					return L_56_(unpack(L_177_))
				end
			end
		end
	end
	return L_56_(...)
end))

local L_57_
local L_58_ = false

L_8_.InputBegan:Connect(function(L_182_arg0, L_183_arg1)
	if L_183_arg1 then
		return
	end
	if L_182_arg0.UserInputType == Enum.UserInputType.MouseButton2 and L_19_.aim.enabled and L_19_.aim.type == "aimlock" then
		L_58_ = true
		L_57_ = L_15_:Connect(function()
			if not L_58_ then
				return
			end
			local L_184_, L_185_ = L_55_func()
			if L_184_ then
				local L_186_, L_187_ = L_51_func(L_184_.Position)
				if L_187_ then
					mousemoverel((L_186_.X - L_54_func().X) / 5, (L_186_.Y - L_54_func().Y) / 5)
				end
			end
		end)
	end
end)

L_8_.InputEnded:Connect(function(L_188_arg0)
	if L_188_arg0.UserInputType == Enum.UserInputType.MouseButton2 then
		L_58_ = false
		if L_57_ then
			L_57_:Disconnect()
			L_57_ = nil
		end
	end
end)

local L_59_
L_7_.RenderStepped:Connect(function()
	if L_19_.mods.no_recoil then
		local L_189_ = nil
		pcall(function()
			L_189_ = require(L_10_:WaitForChild("Gun"):WaitForChild("Scripts"):WaitForChild("RecoilHandler"))
		end)
		if L_189_ then
			pcall(function()
				L_189_.nextStep = function()
				end
				L_189_.setRecoilMultiplier = function()
				end
			end)
		end
	end
	if L_19_.world.time then
		L_9_.TimeOfDay = L_19_.world.time_value
	else
		L_9_.TimeOfDay = L_20_.TimeOfDay
	end
	if L_19_.world.ambient then
		L_9_.Ambient = L_19_.world.amb_color
	else
		L_9_.Ambient = L_21_.Ambient
	end
end)

local L_60_
L_17_(L_18_(function()
	L_60_ = L_15_:Connect(function()
		if not L_5_ then
			L_24_.Visible = false
			L_25_.Visible = false
			L_44_.Visible = false
			return
		end
		local L_190_ = L_54_func()
		L_24_.Radius = L_19_.aim.fov_radius
		local L_191_, L_192_ = L_55_func()
		if L_19_.aim.player_info and L_19_.aim.enabled and L_191_ and L_192_ then
			L_44_.Visible = true
			L_45_.Text = L_192_.Name
			L_48_.Text = tostring(math.floor(L_192_.Character.Humanoid.Health))
			local L_193_ = (L_11_.Character.HumanoidRootPart.Position - L_192_.Character.HumanoidRootPart.Position).Magnitude
			L_49_.Text = tostring(math.floor(L_193_))
			local L_194_ = L_192_.Character:FindFirstChildWhichIsA("Tool")
			L_47_.Text = L_194_ and L_194_.Name or "None"
			L_46_.Image = "rbxthumb://type=Avatar&id=" .. L_192_.UserId .. "&w=150&h=150"
		else
			L_44_.Visible = false
		end
		if L_19_.aim.target_line and L_19_.aim.enabled and L_191_ then
			local L_195_, L_196_ = L_13_(L_5_, L_191_.Position)
			if L_196_ then
				L_25_.Visible = true
				L_25_.From = L_190_
				L_25_.To = Vector2.new(L_195_.X, L_195_.Y)
			else
				L_25_.Visible = false
			end
		else
			L_25_.Visible = false
		end
		if L_19_.aim.fov_circle then
			L_24_.Visible = true
			L_24_.Position = L_190_
		else
			L_24_.Visible = false
		end
		if L_24_.Color ~= L_19_.aim.fov_color then
			L_24_.Color = L_19_.aim.fov_color
		end
		if L_25_.Color ~= L_19_.aim.snapline_color then
			L_25_.Color = L_19_.aim.snapline_color
		end
		L_40_func()
	end)
end))

--// ui ^^\\--
local L_61_ = L_2_:CreateWindow({
	Title = 'Incel.cc',
	Center = true,
	AutoShow = true,
	TabPadding = 8,
	MenuFadeTime = 0.2
})
local L_62_ = {
	Rage = L_61_:AddTab('Rage'),
	Visuals = L_61_:AddTab('Visuals'),
	['UI Settings'] = L_61_:AddTab('Settings'),
}
local L_63_ = L_62_.Rage:AddLeftGroupbox('Aim')
local L_64_ = L_62_.Rage:AddRightGroupbox('Mods')
local L_65_ = L_62_.Visuals:AddLeftGroupbox('Esp')
local L_66_ = L_62_.Visuals:AddRightGroupbox('World')
local L_67_ = L_62_.Visuals:AddLeftGroupbox('Misc')

local L_68_ = L_67_:AddToggle('custom_tool', {
	Text = 'custom tool',
	Default = false,
	Tooltip = 'tool',
	Callback = function(L_197_arg0)
		L_19_.misc.custom_tool = L_197_arg0
		L_39_func(L_197_arg0)
	end
})

L_68_:AddColorPicker("tool_color", {
	Default = Color3.fromRGB(128, 0, 128),
	Title = "Tool Color",
	Callback = function(L_198_arg0)
		L_19_.misc.tool_color = L_198_arg0
		if L_19_.misc.custom_tool then
			local L_199_ = L_11_.Character and L_11_.Character:FindFirstChildOfClass("Tool") or 
                         L_11_.Backpack:FindFirstChildOfClass("Tool")
			L_37_func(L_199_)
		end
	end
})


L_66_:AddToggle('time_change', {
	Text = 'time',
	Default = false,
	Tooltip = 'time',
	Callback = function(L_200_arg0)
		L_19_.world.time = L_200_arg0
	end
})

L_66_:AddSlider('time_val', {
	Text = 'time value',
	Default = 12,
	Min = 1,
	Max = 24,
	Rounding = 0,
	Compact = false,
	Callback = function(L_201_arg0)
		L_19_.world.time_value = L_201_arg0
	end
})

local L_69_ = L_66_:AddToggle('world_ambient', {
	Text = 'world ambient',
	Default = false,
	Tooltip = 'enable_ambient',
	Callback = function(L_202_arg0)
		L_19_.world.ambient = L_202_arg0
	end
})

L_69_:AddColorPicker("ambient", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "ambient",
	Callback = function(L_203_arg0)
		L_19_.world.amb_color = L_203_arg0
	end
})

L_66_:AddToggle('remove_grass', {
	Text = 'remove grass',
	Default = false,
	Tooltip = 'remove_grass',
	Callback = function(L_204_arg0)
		L_19_.world.remove_grass = L_204_arg0
		sethiddenproperty(workspace.Terrain, "Decoration", not L_204_arg0)
	end
})

L_65_:AddToggle('enable', {
	Text = 'enable',
	Default = false,
	Tooltip = 'enable_esp',
	Callback = function(L_205_arg0)
		L_19_.esp.enabled = L_205_arg0
	end
})

L_65_:AddToggle('box_esp', {
	Text = 'box',
	Default = false,
	Tooltip = 'box_esp',
	Callback = function(L_206_arg0)
		L_19_.esp.box = L_206_arg0
	end
})

L_65_:AddToggle('name_esp', {
	Text = 'name',
	Default = false,
	Tooltip = 'name_Esp',
	Callback = function(L_207_arg0)
		L_19_.esp.name = L_207_arg0
	end
})

L_65_:AddToggle('weapon_esp', {
	Text = 'weapon',
	Default = false,
	Tooltip = 'weapon_esp',
	Callback = function(L_208_arg0)
		L_19_.esp.weapon = L_208_arg0
	end
})

L_65_:AddToggle('distance_esp', {
	Text = 'distance',
	Default = false,
	Tooltip = 'distance_esp',
	Callback = function(L_209_arg0)
		L_19_.esp.distance = L_209_arg0
	end
})

L_65_:AddSlider('max_distance', {
	Text = 'max distance',
	Default = 800,
	Min = 100,
	Max = 2000,
	Rounding = 0,
	Compact = false,
	Callback = function(L_210_arg0)
		L_19_.esp.max_distance = L_210_arg0
	end
})

L_63_:AddToggle('enabl', {
	Text = 'enable',
	Default = false,
	Tooltip = 'enable aim',
	Callback = function(L_211_arg0)
		L_19_.aim.enabled = L_211_arg0
	end
})

L_63_:AddDropdown("type", {
	Text = "Aim assist type",
	Default = "silent",
	Values = {
		"silent",
		"aimlock"
	},
	Callback = function(L_212_arg0)
		L_19_.aim.type = L_212_arg0
	end
})

local L_70_ = L_63_:AddToggle('fov_circle', {
	Text = 'fov circle',
	Default = false,
	Tooltip = 'fov_circle',
	Callback = function(L_213_arg0)
		L_19_.aim.fov_circle = L_213_arg0
		L_24_.Visible = L_213_arg0
	end
})

local L_71_ = L_63_:AddToggle('target', {
	Text = 'target line',
	Default = false,
	Tooltip = 'target_line',
	Callback = function(L_214_arg0)
		L_19_.aim.target_line = L_214_arg0
		L_25_.Visible = L_214_arg0
	end
})

L_63_:AddSlider('fov', {
	Text = 'fov radius',
	Default = 50,
	Min = 5,
	Max = 500,
	Rounding = 1,
	Compact = false,
	Callback = function(L_215_arg0)
		L_19_.aim.fov_radius = L_215_arg0
		L_24_.Radius = L_215_arg0
	end
})

L_63_:AddDropdown("part", {
	Text = "aim bone",
	Default = "Head",
	Values = {
		"Head",
		"Torso"
	},
	Callback = function(L_216_arg0)
		L_19_.aim.aim_bone = L_216_arg0
	end
})

L_63_:AddToggle('info', {
	Text = 'info',
	Default = false,
	Tooltip = 'player_info',
	Callback = function(L_217_arg0)
		L_19_.aim.player_info = L_217_arg0
	end
})

L_70_:AddColorPicker("fov_color", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "FOV Circle Color",
	Callback = function(L_218_arg0)
		L_19_.aim.fov_color = L_218_arg0
		L_24_.Color = L_218_arg0
	end
})

L_71_:AddColorPicker("snapline_color", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "Snapline Color",
	Callback = function(L_219_arg0)
		L_19_.aim.snapline_color = L_219_arg0
		L_25_.Color = L_219_arg0
	end
})

L_64_:AddToggle('no_recoil', {
	Text = 'remove recoil',
	Default = false,
	Tooltip = 'no_recoil',
	Callback = function(L_220_arg0)
		L_19_.mods.no_recoil = L_220_arg0
	end
})

L_64_:AddToggle('no_spread', {
	Text = 'remove spread',
	Default = false,
	Tooltip = 'no_spread',
	Callback = function(L_221_arg0)
		L_19_.mods.no_spread = L_221_arg0
	end
})
L_2_:SetWatermarkVisibility(true)
local L_72_ = tick()
local L_73_ = 0
local L_74_ = 60

local L_75_ = game:GetService('RunService').RenderStepped:Connect(function()
	L_73_ = L_73_ + 1
	if (tick() - L_72_) >= 1 then
		L_74_ = L_73_
		L_72_ = tick()
		L_73_ = 0
	end
	L_2_:SetWatermark(('Incel.cc | Game: Rost Alpha'):format(
        math.floor(L_74_),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

L_2_.KeybindFrame.Visible = false

L_2_:OnUnload(function()
	L_75_:Disconnect()
	L_24_:Remove()
	L_25_:Remove()
	if L_57_ then
		L_57_:Disconnect()
	end
	if L_60_ then
		L_60_:Disconnect()
	end
	if L_59_ then
		L_59_:Disconnect()
	end
	if L_38_ then
		L_38_:Disconnect()
	end
	for L_222_forvar0, L_223_forvar1 in pairs(L_26_) do
		for L_224_forvar0, L_225_forvar1 in pairs(L_223_forvar1) do
			L_225_forvar1:Remove()
		end
	end
	for L_226_forvar0, L_227_forvar1 in pairs(L_27_) do
		L_36_func(L_226_forvar0)
	end
	L_27_ = {}
	L_43_:Destroy()
	L_9_.TimeOfDay = L_20_.TimeOfDay
	L_9_.Ambient = L_21_.Ambient
	L_2_.Unloaded = true
end)

local L_76_ = L_62_['UI Settings']:AddLeftGroupbox('Menu')

L_76_:AddButton('Unload', function()
	L_2_:Unload()
end)
L_76_:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
	Default = 'RightShift',
	NoUI = true,
	Text = 'Menu keybind'
})

L_2_.ToggleKeybind = Options.MenuKeybind
L_3_:SetLibrary(L_2_)
L_4_:SetLibrary(L_2_)
L_4_:IgnoreThemeSettings()
L_4_:SetIgnoreIndexes({
	'MenuKeybind'
})
L_3_:SetFolder('Incel')
L_4_:SetFolder('Incel/Rost')
L_4_:BuildConfigSection(L_62_['UI Settings'])
L_3_:ApplyToTab(L_62_['UI Settings'])
L_4_:LoadAutoloadConfig()

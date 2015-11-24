local K, C, L = unpack(select(2, ...));

-- Backdrops
K.Backdrop = { bgFile = C["media"].blank, edgeFile = C["media"].blizz, edgeSize = 14, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5 }}
K.BasicBackdrop = { bgFile = C["media"].blank, tile = true, tileSize = 16, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.SimpleBackdrop = { bgFile = C["media"].blank}
K.ModBackdrop = { bgFile = C["media"].blank, tile = true, tileSize = 16, insets = { left = 8, right = 8, top = 8, bottom = 8}}
K.EdgeBackdrop = { edgeFile = C["media"].blizz, edgeSize = 14, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.BlizBackdrop = { bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11}}

-- Blizz Style
local style = {	bgFile =  C["media"].blank, edgeFile = C["media"].blizz, edgeSize = 14, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5 }}
function CreateStyle(f, size, level, alpha, alphaborder) 
	if f.BlizzBorder then return end
	local BlizzBorder = CreateFrame("Frame", nil, f)
	BlizzBorder:SetFrameLevel(level or 0)
	BlizzBorder:SetFrameStrata(f:GetFrameStrata())
	BlizzBorder:SetPoint("TOPLEFT", -size, size)
	BlizzBorder:SetPoint("BOTTOMRIGHT", size, -size)
	BlizzBorder:SetBackdrop(style)
	BlizzBorder:SetBackdropColor(0.05, 0.05, 0.05, .9)
	BlizzBorder:SetBackdropBorderColor(.7, .7, .7, 1)
	f.BlizzBorder = BlizzBorder
	return BlizzBorder
end

-- Shadow Style
local style2 = { bgFile =  C["media"].blank, edgeFile = C["media"].glow, edgeSize = 4, insets = { left = 3, right = 3, top = 3, bottom = 3 }}
function CreateStyle2(f, size, level, alpha, alphaborder) 
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(level or 0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -size, size)
	shadow:SetPoint("BOTTOMRIGHT", size, -size)
	shadow:SetBackdrop(style2)
	shadow:SetBackdropColor(0.05, 0.05, 0.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

-- ShortValue
K.ShortValue = function(value)
	if value >= 1e8 then
		return format("%.1fG", value / 1e9);
	elseif value >= 1e6 then
		return format("%.1fM", value / 1e6);
	elseif value >= 1e3 then
		return format("%.1fk", value / 1e3);
	else
		return format("%d", value);
	end
end

K.UTF = function(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while (pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then
			return string:sub(1, pos - 1)..(dots and "..." or "")
		else
			return string
		end
	end
end

-- Rounding
K.Round = function(num, idp)
	if(idp and idp > 0) then
		local mult = 10 ^ idp;
		return floor(num * mult + 0.5) / mult;
	end
	return floor(num + 0.5);
end

-- RGBToHex Color
K.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0;
	g = g <= 1 and g >= 0 and g or 0;
	b = b <= 1 and b >= 0 and b or 0;
	return format("|cff%02x%02x%02x", r*255, g*255, b*255);
end

-- Check Player's Role
local RoleUpdater = CreateFrame("Frame")
local function CheckRole(self, event, unit)
	if event == "UNIT_AURA" and unit ~= "player" then return end
	if (K.Class == "PALADIN" and UnitBuff("player", GetSpellInfo(25780))) and GetCombatRatingBonus(CR_DEFENSE_SKILL) > 100 or 
	(K.Class == "WARRIOR" and GetBonusBarOffset() == 2) or 
	(K.Class == "DEATHKNIGHT" and UnitBuff("player", GetSpellInfo(48263))) or
	(K.Class == "DRUID" and GetBonusBarOffset() == 3) then
		K.Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;
		
		if ((playerap > playerint) or (playeragi > playerint)) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139))) then
			K.Role = "Melee"
		else
			K.Role = "Caster"
		end
	end
	
	-- Unregister useless events
	if event == "PLAYER_ENTERING_WORLD" then
		if K.Class ~= "WARRIOR" and K.Class ~= "DRUID" then
			RoleUpdater:UnregisterEvent("UPDATE_BONUS_ACTIONBAR")	
		end
		RoleUpdater:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end	
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("UNIT_AURA")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:SetScript("OnEvent", CheckRole)
CheckRole()
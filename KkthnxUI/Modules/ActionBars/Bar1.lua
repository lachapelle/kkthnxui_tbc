local K, C, L, _ = select(2, KKaddonInfo()):unpack()
if C["ActionBar"].Enable ~= true then return end

local _G = _G
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown
local HasOverrideActionBar = HasOverrideActionBar

--	Setup Main Action Bar by Tukz
local bar = CreateFrame("Frame", "Bar1Holder", ActionBarAnchor, "SecureActionButtonTemplate")
bar:SetAllPoints(ActionBarAnchor)

for i = 1, 12 do
	local button = _G["ActionButton"..i]
	button:SetWidth(C["ActionBar"].Button_Size)
	button:SetHeight(C["ActionBar"].Button_Size)
	button:ClearAllPoints()
	button:SetParent(Bar1Holder)
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", Bar1Holder, 0, 0)
	else
		local previous = _G["ActionButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", C["ActionBar"].Button_Space, 0)
	end
end

local Page = {
	["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
	["WARRIOR"] = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;",
	["PRIEST"] = "[bonusbar:1] 7;",
	["ROGUE"] = "[bonusbar:1] 7; [form:3] 7;",
	["WARLOCK"] = "[form:2] 10;",
	["DEFAULT"] = "[bonusbar:5] 11; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
}

local function GetBar()
	local condition = Page["DEFAULT"]
	local class = K.Class
	local page = Page[class]
	if page then
		condition = condition.." "..page
	end
	condition = condition.." 1"
	return condition
end

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("KNOWN_CURRENCY_TYPES_UPDATE")
bar:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
bar:RegisterEvent("BAG_UPDATE")
bar:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
bar:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR")
bar:SetScript("OnEvent", MainMenuBar_OnEvent)
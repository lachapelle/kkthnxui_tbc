local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true then return end

local _G = _G
local pairs = pairs
local select = select
local format = string.format
local CreateFrame, UIParent = CreateFrame, UIParent
local InCombatLockdown = InCombatLockdown
local IsAltKeyDown, IsShiftKeyDown = IsAltKeyDown, IsShiftKeyDown

-- Show empty buttons
local ShowGrid = CreateFrame("Frame")
ShowGrid:RegisterEvent("PLAYER_ENTERING_WORLD")
ShowGrid:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if C["actionbar"].showgrid == true then
		SetCVar("alwaysShowActionBars", 0)
		ActionButton_HideGrid = K.Dummy
		for i = 1, 12 do
			local button = _G[format("ActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("BonusActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("MultiBarBottomRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarBottomLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
		end
	end
end)

-- Moveable Bars
for _, frame in pairs({
	_G["PetActionBarFrame"],
	_G["ShapeshiftBarFrame"],
	_G["PossessBarFrame"],
	_G["MultiCastActionBarFrame"],
}) do
	frame:EnableMouse(false)
end

-- Left-Alt + Left Click Move
for _, button in pairs({
	_G["PossessButton1"],
	_G["PetActionButton1"],
	_G["ShapeshiftButton1"],
}) do
	button:ClearAllPoints()
	button:SetPoint("CENTER", UIParent, -100)

	if InCombatLockdown() then
		button:SetMovable(false)
		button:SetUserPlaced(true)
	else
		button:SetMovable(true)
		button:SetUserPlaced(true)
	end

	button:RegisterForDrag("LeftButton")
	button:HookScript("OnDragStart", function(self)
		if (IsShiftKeyDown() and IsAltKeyDown()) then
			if InCombatLockdown() then return end
			self:StartMoving()
		end
	end)

	button:HookScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)
end

-- Totembar
-- Left-Alt + Left Click Move
local f = CreateFrame("Frame", "MultiCastActionBarFrameAnchor")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetSize(10, 10)
f:ClearAllPoints()
f:SetPoint("CENTER", UIParent)

if InCombatLockdown() then
	f:SetMovable(false)
	f:SetUserPlaced(true)
else
	f:SetMovable(true)
	f:SetUserPlaced(true)
end
f:SetScript("OnEvent", function(self, event)
	MultiCastActionBarFrame:ClearAllPoints()
	MultiCastActionBarFrame:SetPoint("CENTER", MultiCastActionBarFrameAnchor)
	MultiCastActionBarFrame.SetPoint = K.Dummy
end)

for i = 1, 12 do
	for _, button in pairs({
		_G["MultiCastSlotButton1"],
		_G["MultiCastSlotButton2"],
		_G["MultiCastSlotButton3"],
		_G["MultiCastSlotButton4"],

		_G["MultiCastActionBarFrame"],
		_G["MultiCastActionButton"..i],

		_G["MultiCastRecallSpellButton"],
		_G["MultiCastSummonSpellButton"],
	}) do
		button:RegisterForDrag("LeftButton")
		button:HookScript("OnDragStart", function()
			if (IsControlKeyDown()) then
				if InCombatLockdown() then return end
				MultiCastActionBarFrameAnchor:StartMoving()
			end
		end)

		button:HookScript("OnDragStop", function()
			if InCombatLockdown() then return end
			MultiCastActionBarFrameAnchor:StopMovingOrSizing()
		end)
	end
end

MultiCastActionButton1:ClearAllPoints()
MultiCastActionButton1:SetPoint("CENTER", MultiCastSlotButton1)

MultiCastActionButton5:ClearAllPoints()
MultiCastActionButton5:SetPoint("CENTER", MultiCastSlotButton1)

MultiCastActionButton9:ClearAllPoints()
MultiCastActionButton9:SetPoint("CENTER", MultiCastSlotButton1)

hooksecurefunc("MultiCastFlyoutFrame_LoadSlotSpells", function(self, slot, ...)
	local numSpells = select("#", ...)

	if (numSpells == 0) then
		return false
	end

	numSpells = numSpells + 1

	for i = 2, numSpells do
		_G["MultiCastFlyoutButton"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end
end)

-- fix main bar keybind not working after a talent switch. :X
hooksecurefunc('TalentFrame_LoadUI', function()
	PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
end)
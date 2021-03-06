local K, C, L, _ = select(2, KKaddonInfo()):unpack()

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
local SetCVar = SetCVar

-- Kill all stuff on default UI that we don't need
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon, ...)

	if addon == "Blizzard_AchievementUI" then
		if C["Tooltip"].enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	CharacterModelFrameRotateLeftButton:Kill()
	CharacterModelFrameRotateRightButton:Kill()
	if addon == "Blizzard_InspectUI" then
		if InspectFrame then
			InspectModelRotateLeftButton:Kill()
			InspectModelRotateRightButton:Kill()
		end
	end

	if C["Unitframe"].enable then
		PartyMemberBackground:Kill()
	end

	if C["Minimap"].enable then
		InterfaceOptionsDisplayPanelRotateMinimap:Kill()
	end

	if C["ActionBar"].Enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
	end

	if C["Unitframe"].enhancedframes then
		SetCVar("fullSizeFocusFrame", 1)
		InterfaceOptionsUnitFramePanelFullSizeFocusFrame:Kill()
	end

	if C["Nameplate"].enable then
		InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates:Kill()
	end
	
	if addon == "MikScrollingBattleText" then
		InterfaceOptionsCombatTextPanelFCTDropDown:Kill()
		SetCVar("CombatLogPeriodicSpells", 0)
		SetCVar("PetMeleeDamage", 0)
		SetCVar("CombatDamage", 0)
		SetCVar("CombatHealing", 0)
		InterfaceOptionsCombatTextPanelTargetDamage:Kill()
		InterfaceOptionsCombatTextPanelPeriodicDamage:Kill()
		InterfaceOptionsCombatTextPanelPetDamage:Kill()
		InterfaceOptionsCombatTextPanelHealing:Kill()
	end
end)
local K, C, L, _ = select(2, ...):unpack()
if C["misc"].hattrick ~= true then return end

local CreateFrame = CreateFrame
local GameTooltip = GameTooltip

local hcheck = CreateFrame("CheckButton", "HelmCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
hcheck:ClearAllPoints()
hcheck:SetSize(22, 22)
hcheck:SetPoint( "TOPLEFT", CharacterHeadSlot, "TOPRIGHT", 5, 0)
hcheck:SetFrameLevel(PaperDollFrame:GetFrameLevel() + 10)
hcheck:SetScript("OnClick", function() ShowHelm(not ShowingHelm()) end)
hcheck:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(OPTION_TOOLTIP_SHOW_HELM)
end)
hcheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
hcheck:SetScript("OnEvent", function() hcheck:SetChecked(ShowingHelm()) end)
hcheck:RegisterEvent("UNIT_MODEL_CHANGED")
hcheck:SetToplevel(true)

local ccheck = CreateFrame("CheckButton", "CloakCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
ccheck:ClearAllPoints()
ccheck:SetSize(22, 22)
ccheck:SetPoint( "TOPLEFT", CharacterBackSlot, "TOPRIGHT", 5, 0)
ccheck:SetFrameLevel(PaperDollFrame:GetFrameLevel() + 10)
ccheck:SetScript("OnClick", function() ShowCloak(not ShowingCloak()) end)
ccheck:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(OPTION_TOOLTIP_SHOW_CLOAK)
end)
ccheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
ccheck:SetScript("OnEvent", function() ccheck:SetChecked(ShowingCloak()) end)
ccheck:RegisterEvent("UNIT_MODEL_CHANGED")
ccheck:SetToplevel(true)

hcheck:SetChecked(ShowingHelm())
ccheck:SetChecked(ShowingCloak())
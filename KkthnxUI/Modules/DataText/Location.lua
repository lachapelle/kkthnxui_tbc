local K, C, L, _ = select(2, KKaddonInfo()):unpack()
if IsAddOnLoaded("Carbonite") then return end

local MinimapZone = CreateFrame("Frame", "MinimapZone", Minimap)
MinimapZone:CreateBackdrop()
MinimapZone:SetWidth(0)
MinimapZone:SetHeight(20)
MinimapZone:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 2, -2)
MinimapZone:SetFrameLevel(Minimap:GetFrameLevel() + 3)
MinimapZone:SetFrameStrata(Minimap:GetFrameStrata())
MinimapZone:SetPoint("TOPRIGHT", Minimap, -2, -2)
MinimapZone:SetAlpha(0)

local MinimapZone_Text = MinimapZone:CreateFontString("MinimapZoneText", "Overlay")
MinimapZone_Text:SetFont(C["font"].stats_font, C["font"].stats_font_size, C["font"].stats_font_style)
MinimapZone_Text:SetPoint("TOP", 0, -1)
MinimapZone_Text:SetPoint("BOTTOM")
MinimapZone_Text:SetHeight(12)
MinimapZone_Text:SetWidth(MinimapZone:GetWidth() -6)
MinimapZone_Text:SetAlpha(0)

Minimap:SetScript("OnEnter",function()
	MinimapZone:SetAlpha(1)
	MinimapZone_Text:SetAlpha(1)
end)

Minimap:SetScript("OnLeave",function()
	MinimapZone:SetAlpha(0)
	MinimapZone_Text:SetAlpha(0)
end)
 
local Zone_Update = function()
	local PvP = GetZonePVPInfo()
	MinimapZone_Text:SetText(GetMinimapZoneText())
	if PvP == "friendly" then
		MinimapZone_Text:SetTextColor(0.1, 1.0, 0.1)
	elseif PvP == "sanctuary" then
		MinimapZone_Text:SetTextColor(0.41, 0.8, 0.94)
	elseif PvP == "arena" or PvP == "hostile" then
		MinimapZone_Text:SetTextColor(1.0, 0.1, 0.1)
	elseif PvP == "contested" then
		MinimapZone_Text:SetTextColor(1.0, 0.7, 0.0)
	else
		MinimapZone_Text:SetTextColor(1.0, 1.0, 1.0)
	end
end
 
MinimapZone:RegisterEvent("PLAYER_ENTERING_WORLD")
MinimapZone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
MinimapZone:RegisterEvent("ZONE_CHANGED")
MinimapZone:RegisterEvent("ZONE_CHANGED_INDOORS")
MinimapZone:SetScript("OnEvent", Zone_Update)
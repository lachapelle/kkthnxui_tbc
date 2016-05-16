local K, C, L, _ = select(2, ...):unpack()
if C["skins"].minimap_buttons ~= true or C["minimap"].enable ~= true then return end

--	Skin addons icons on minimap
local buttons = {
	"MiniMapBattlefieldFrame",
	"MiniMapTrackingButton",
	"MiniMapMailFrame",
	"HelpOpenTicketButton",
	"GatherMatePin",
	"HandyNotesPin",
	"TimeManagerClockButton",
	"Archy",
	"GatherNote",
	"MinimMap",
	"Spy_MapNoteList_mini",
	"ZGVMarker",
	"poiWorldMapPOIFrame",
	"WorldMapPOIFrame",
	"QuestMapPOI"
}

local function SkinButton(f)
	if not f or f:GetObjectType() ~= "Button" then return end

	for i, buttons in pairs(buttons) do
		if f:GetName() ~= nil then
			if f:GetName():match(buttons) then return end
		end
	end

	f:SetPushedTexture(nil)
	f:SetHighlightTexture(nil)
	f:SetDisabledTexture(nil)
	f:SetSize(20, 20)

	for i = 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			local tex = region:GetTexture()

			if tex and (tex:find("Border") or tex:find("Background") or tex:find("AlphaMask")) then
				region:SetTexture(nil)
			else
				region:ClearAllPoints()
				region:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
				region:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
				region:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				region:SetDrawLayer("ARTWORK")
				if f:GetName() == "PS_MinimapButton" then
					region.SetPoint = K.Dummy
				end
			end
		end
	end

	K.AddBorder(f)
	f:SetBackdrop(K.BasicBackdrop)
	f:SetBorderColor(unpack(C["media"].border_color))
	f:SetBackdropColor(unpack(C["media"].backdrop_color))
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		for i = 1, Minimap:GetNumChildren() do
			SkinButton(select(i, Minimap:GetChildren()))
		end
	end

	if WIM3MinimapButton and WIM3MinimapButton:GetNumRegions() < 9 then
		SkinButton(WIM3MinimapButton)
		SkinButton(WIM3MinimapButton)
	end
	self = nil
end)
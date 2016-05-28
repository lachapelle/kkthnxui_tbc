local K, C, L, _ = select(2, ...):unpack()
if C["skins"].spy ~= true then return end

local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("Spy") then return end

	local function Skin_Spy()
		Spy_MainWindow:StripTextures()
		BarTexture = C["media"].texture
		Spy:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
		Spy_MainWindow:CreateBlizzBorder(2)
		Spy_MainWindow:SetBackdropColor(unpack(C["media"].backdrop_color))
		end
		Skin_Spy()
end)
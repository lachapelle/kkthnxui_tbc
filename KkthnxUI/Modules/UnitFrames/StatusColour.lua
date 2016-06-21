local K, C, L, _ = select(2, KKaddonInfo()):unpack()
if C["Unitframe"].classhealth ~= true then return end

local hooksecurefunc = hooksecurefunc
local UnitIsPlayer, UnitClass = UnitIsPlayer, UnitClass
local UnitIsConnected = UnitIsConnected
local CUSTOM_CLASS_COLORS, RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS, RAID_CLASS_COLORS

local function colorHealthBar(statusbar, unit)
	local _, class, color
	if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
		_, class = UnitClass(unit)
		color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
		statusbar:SetStatusBarColor(color.r, color.g, color.b)
	end
end

hooksecurefunc("UnitFrameHealthBar_Update", colorHealthBar)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
	colorHealthBar(self, self.unit)
end)
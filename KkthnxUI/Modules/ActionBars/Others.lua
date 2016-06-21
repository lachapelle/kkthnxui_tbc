local K, C, L, _ = select(2, KKaddonInfo()):unpack()
if C["ActionBar"].Enable ~= true then return end

local _G = _G
local GetCVarBool = GetCVarBool
local SetCVar = SetCVar
local CreateFrame = CreateFrame
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

-- Show empty buttons
local ShowGrid = CreateFrame("Frame")
ShowGrid:RegisterEvent("PLAYER_ENTERING_WORLD")
ShowGrid:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("ACTIONBAR_SHOWGRID")
	self:UnregisterEvent("ACTIONBAR_HIDEGRID")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if C["ActionBar"].Show_Grid == true then
		SetCVar("alwaysShowActionBars", 1)
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			local Button

			Button = _G[format("ActionButton%d", i)]
			Button:SetAttribute("showgrid", 1)
			Button:SetAttribute("statehidden", true)
			Button:Show()
			ActionButton_ShowGrid(Button)

			Button = _G[format("MultiBarRightButton%d", i)]
			Button:SetAttribute("showgrid", 1)
			Button:SetAttribute("statehidden", true)
			Button:Show()
			ActionButton_ShowGrid(Button)

			Button = _G[format("MultiBarBottomRightButton%d", i)]
			Button:SetAttribute("showgrid", 1)
			Button:SetAttribute("statehidden", true)
			Button:Show()
			ActionButton_ShowGrid(Button)

			Button = _G[format("MultiBarLeftButton%d", i)]
			Button:SetAttribute("showgrid", 1)
			Button:SetAttribute("statehidden", true)
			Button:Show()
			ActionButton_ShowGrid(Button)

			Button = _G[format("MultiBarBottomLeftButton%d", i)]
			Button:SetAttribute("showgrid", 1)
			Button:SetAttribute("statehidden", true)
			Button:Show()
			ActionButton_ShowGrid(Button)
		end
	else
		SetCVar("alwaysShowActionBars", 0)
	end
end)

if not GetCVarBool("lockActionBars") then
	SetCVar("lockActionBars", 1)
end
local K, C, L, _ = select(2, KKaddonInfo()):unpack()
if C["Automation"].autocollapse ~= true or IsAddOnLoaded("QuestHelper") == true then return end

local CreateFrame = CreateFrame
local IsInInstance = IsInInstance
local InCombatLockdown = InCombatLockdown

-- Auto collapse WatchFrame
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if IsInInstance() then
		QuestWatchFrame_CollapseExpandButton_OnClick(QuestWatchFrame_CollapseExpandButton)
	elseif QuestWatchFrame.collapsed and not InCombatLockdown() then
		QuestWatchFrame_CollapseExpandButton_OnClick(QuestWatchFrame_CollapseExpandButton)
	end
end)
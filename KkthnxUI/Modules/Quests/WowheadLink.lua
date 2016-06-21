local K, C, L, _ = select(2, KKaddonInfo()):unpack()
if IsAddOnLoaded("QuestHelper") then return end

local format = string.format
local IsControlKeyDown = IsControlKeyDown
local CreateFrame = CreateFrame
local GetQuestLogTitle = GetQuestLogTitle
local GetQuestIndexForWatch = GetQuestIndexForWatch
local hooksecurefunc = hooksecurefunc

-- Add quest/achievement OpenWow link
local linkQuest, linkAchievement
if K.Client == "ruRU" then
	linkQuest = "http://ru.wowhead.com/quest=%d"
	linkAchievement = "http://ru.wowhead.com/achievement=%d"
elseif K.Client == "frFR" then
	linkQuest = "http://fr.wowhead.com/quest=%d"
	linkAchievement = "http://fr.wowhead.com/achievement=%d"
elseif K.Client == "deDE" then
	linkQuest = "http://de.wowhead.com/quest=%d"
	linkAchievement = "http://de.wowhead.com/achievement=%d"
elseif K.Client == "esES" or K.Client == "esMX" then
	linkQuest = "http://es.wowhead.com/quest=%d"
	linkAchievement = "http://es.wowhead.com/achievement=%d"
elseif K.Client == "ptBR" or K.Client == "ptPT" then
	linkQuest = "http://pt.wowhead.com/quest=%d"
	linkAchievement = "http://pt.wowhead.com/achievement=%d"
else
	linkQuest = "http://www.wowhead.com/quest=%d"
	linkAchievement = "http://www.wowhead.com/achievement=%d"
end

StaticPopupDialogs.WATCHFRAME_URL = {
	text = L_WATCH_WOWHEAD_LINK,
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	hasWideEditBox = 1,
	OnShow = function(self, ...) self.wideEditBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	preferredIndex = 3,
}
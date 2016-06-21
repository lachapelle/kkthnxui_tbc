local K, C, L, _ = select(2, KKaddonInfo()):unpack()
if IsAddOnLoaded("QuestHelper") then return end

local _G = _G
local unpack = unpack
local CreateFrame = CreateFrame
local GetName, GetText = GetName, GetText
local GetNumQuestWatches = GetNumQuestWatches
local GetDifficultyColor = GetDifficultyColor
local GetQuestIndexForWatch = GetQuestIndexForWatch
local GetQuestLogTitle = GetQuestLogTitle
local InCombatLockdown = InCombatLockdown
local UIParent = UIParent
local hooksecurefunc = hooksecurefunc

-- Move WatchFrame
local frame = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
frame:SetPoint(unpack(C["position"].quest))
frame:SetHeight(150)
frame:SetWidth(224)

QuestWatchFrame:ClearAllPoints()
QuestWatchFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
QuestWatchFrame:SetHeight(K.ScreenHeight / 1.6)

hooksecurefunc(QuestWatchFrame, "SetPoint", function(_, _, parent)
	if parent ~= frame then
		QuestWatchFrame:ClearAllPoints()
		QuestWatchFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
	end
end)
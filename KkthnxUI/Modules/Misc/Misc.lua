local K, C, L, _ = select(2, ...):unpack()

local _G = _G
local unpack = unpack
local PlaySound, PlaySoundFile = PlaySound, PlaySoundFile
local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame
local MAX_BATTLEFIELD_QUEUES = MAX_BATTLEFIELD_QUEUES
local GetBattlefieldStatus = GetBattlefieldStatus
local UnitIsAFK = UnitIsAFK
local GetZoneText = GetZoneText
local GetLFGDungeonRewards = GetLFGDungeonRewards
local GetLFGDungeonInfo = GetLFGDungeonInfo
local GetLFGRandomDungeonInfo = GetLFGRandomDungeonInfo
local GetNumRandomDungeons = GetNumRandomDungeons
local isHoliday = isHoliday

-- Move some frames.
MirrorTimer1:ClearAllPoints()
MirrorTimer1:SetPoint("TOP", 0, -55)

UIErrorsFrame:ClearAllPoints()
UIErrorsFrame:SetPoint("TOP", UIParent, 0, -300)

RaidWarningFrame:ClearAllPoints()
RaidWarningFrame:SetPoint("TOP", UIParent, 0, -130)

WorldStateAlwaysUpFrame:ClearAllPoints()
WorldStateAlwaysUpFrame:SetPoint("TOP", UIParent, 0, -10)

hooksecurefunc("WorldStateAlwaysUpFrame_Update", function()
	for i = 1, NUM_ALWAYS_UP_UI_FRAMES do
		local frame = _G["AlwaysUpFrame"..i]

		if frame == AlwaysUpFrame1 then
			local _, _, _, _, y = frame:GetPoint()
			frame:SetPoint("TOP", WorldStateAlwaysUpFrame, "TOP", 0, 0)
		end

		local text = _G["AlwaysUpFrame"..i.."Text"]
		text:ClearAllPoints()
		text:SetPoint("CENTER", frame, "CENTER", 0, 0)
		text:SetJustifyH("CENTER")
		text:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
		text:SetShadowOffset(0, 0)

		local icon = _G["AlwaysUpFrame"..i.."Icon"]
		icon:ClearAllPoints()
		icon:SetPoint("RIGHT", text, "LEFT", 12, -8)

		local dynamicIcon = _G["AlwaysUpFrame"..i.."DynamicIconButton"]
		dynamicIcon:ClearAllPoints()
		dynamicIcon:SetPoint("LEFT", text, "RIGHT", 0, 0)
	end
end)

-- Vehicle indicator
hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(_, _, parent)
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:SetPoint(unpack(C["position"].vehicle))
    end
end)

-- Move TicketStatusFrame (Shestak)
TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint(unpack(C["position"].ticket))

-- Force readycheck warning
local ShowReadyCheckHook = function(self, initiator)
	if initiator ~= "player" then
		PlaySound("ReadyCheck", "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

-- Force other warning
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("BATTLEFIELD_MGR_ENTRY_INVITE")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("RESURRECT_REQUEST")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status = GetBattlefieldStatus(i)
			if status == "confirm" then
				PlaySound("PVPTHROUGHQUEUE", "Master")
				break
			end
			i = i + 1
		end
	elseif event == "BATTLEFIELD_MGR_ENTRY_INVITE" then
		PlaySound("PVPTHROUGHQUEUE", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" then
		PlaySound("ReadyCheck", "Master")
	elseif event == "RESURRECT_REQUEST" then
		PlaySoundFile("Sound\\Spells\\Resurrection.wav", "Master")
	end
end)

-- Misclicks for some popups
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
StaticPopupDialogs.CONFIRM_BATTLEFIELD_ENTRY.button2 = nil

--[[ Spin camera while afk(by Telroth and Eclipse)
if C["misc"].afk_spin_camera == true then
	local SpinCam = CreateFrame("Frame")

	local OnEvent = function(self, event, unit)
		if event == "PLAYER_FLAGS_CHANGED" then
			if unit == "player" then
				if UnitIsAFK(unit) then
					SpinStart()
				else
					SpinStop()
				end
			end
		elseif event == "PLAYER_LEAVING_WORLD" then
			SpinStop()
		end
	end
	SpinCam:RegisterEvent("PLAYER_ENTERING_WORLD")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", OnEvent)

	function SpinStart()
		spinning = true
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		UIParent:Show()
	end
end
]]
-- Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

-- Remove Boss Emote spam during BG(ArathiBasin SpamFix by Partha)
if C["misc"].hide_bg_spam == true then
	local Fixer = CreateFrame("Frame")
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame

	local function DisableSpam()
		if GetZoneText() == L_ZONE_ARATHIBASIN then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = false
		end
	end

	Fixer:RegisterEvent("PLAYER_ENTERING_WORLD")
	Fixer:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	Fixer:SetScript("OnEvent", DisableSpam)
end

-- Undress button in auction dress-up frame(by Nefarion)
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetHeight(22)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(self, button)
	if button == "RightButton" then
		self.model:UndressSlot(19)
	else
		self.model:Undress()
	end
	PlaySound("gsTitleOptionOK")
end)
strip.model = DressUpModel

strip:RegisterEvent("AUCTION_HOUSE_SHOW")
strip:RegisterEvent("AUCTION_HOUSE_CLOSED")
strip:SetScript("OnEvent", function(self)
	if AuctionFrame:IsVisible() and self.model ~= SideDressUpModel then
		self:SetParent(SideDressUpModel)
		self:ClearAllPoints()
		self:SetPoint("TOP", SideDressUpModelResetButton, "BOTTOM", 0, -3)
		self.model = SideDressUpModel
	elseif self.model ~= DressUpModel then
		self:SetParent(DressUpModel)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
		self.model = DressUpModel
	end
end)

-- Force quit
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

-- Old achievements filter
function AchievementFrame_GetCategoryNumAchievements_OldIncomplete(categoryID)
	local numAchievements, numCompleted = GetCategoryNumAchievements(categoryID)
	return numAchievements - numCompleted, 0, numCompleted
end

function old_nocomplete_filter_init()
	AchievementFrameFilters = {
		{text = ACHIEVEMENTFRAME_FILTER_ALL, func = AchievementFrame_GetCategoryNumAchievements_All},
		{text = ACHIEVEMENTFRAME_FILTER_COMPLETED, func = AchievementFrame_GetCategoryNumAchievements_Complete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE, func = AchievementFrame_GetCategoryNumAchievements_Incomplete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE.." ("..ALL.." )", func = AchievementFrame_GetCategoryNumAchievements_OldIncomplete}
	}
end

local filter = CreateFrame("Frame")
filter:RegisterEvent("ADDON_LOADED")
filter:SetScript("OnEvent", function(self, event, addon, ...)
	if addon == "Blizzard_AchievementUI" then
		if AchievementFrame then
			old_nocomplete_filter_init()
			filter:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

-- Change UIErrorsFrame strata
UIErrorsFrame:SetFrameLevel(0)
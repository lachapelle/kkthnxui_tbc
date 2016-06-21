local K, C, L, _ = select(2, KKaddonInfo()):unpack()

local _G = _G
local format = format
local min, max = math.min, math.max
local match = string.match
local unpack, select = unpack, select
local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local SetCVar = SetCVar
local ReloadUI = ReloadUI
local ChatFrame_AddMessageGroup = ChatFrame_AddMessageGroup
local ChatFrame_RemoveAllMessageGroups = ChatFrame_RemoveAllMessageGroups
local ChatFrame_AddChannel = ChatFrame_AddChannel
local ChatFrame_RemoveChannel = ChatFrame_RemoveChannel
local ChangeChatColor = ChangeChatColor
local ToggleChatColorNamesByClassGroup = ToggleChatColorNamesByClassGroup
local FCF_ResetChatWindows = FCF_ResetChatWindows
local FCF_SetLocked = FCF_SetLocked
local FCF_DockFrame, FCF_UnDockFrame = FCF_DockFrame, FCF_UnDockFrame
local FCF_OpenNewWindow = FCF_OpenNewWindow
local FCF_SavePositionAndDimensions = FCF_SavePositionAndDimensions
local FCF_GetChatWindowInfo = FCF_GetChatWindowInfo
local FCF_SetWindowName = FCF_SetWindowName
local FCF_StopDragging = FCF_StopDragging
local FCF_SetChatWindowFontSize = FCF_SetChatWindowFontSize
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS
local LOOT, GENERAL, TRADE = LOOT, GENERAL, TRADE

-- Simple Install
local function InstallUI()
	local ActionBars = C["ActionBar"].Enable

	SetCVar("RotateMinimap", 0)
	SetCVar("SpamFilter", 0)
	SetCVar("UberTooltips", 1)
	SetCVar("alwaysShowActionBars", 1)
	SetCVar("autoDismount", 1)
	SetCVar("autoQuestWatch", 1)
	SetCVar("buffDurations", 1)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("gameTip", 0)
	SetCVar("lockActionBars", 1)
	SetCVar("lootUnderMouse", 0)
	SetCVar("maxfpsbk", 0)
	SetCVar("removeChatDelay", 1)
	SetCVar("screenshotQuality", 10)
	SetCVar("scriptErrors", 0)
	SetCVar("showLootSpam", 1)
	SetCVar("showNewbieTips", 0)
	SetCVar("taintLog", 0)
	SetCVar("violenceLevel", 5)

	if (ActionBars) then
		SetActionBarToggles(1, 1, 1, 1)
	end

	InterfaceOptionsControlsPanelAutoLootKeyDropDown:SetValue("SHIFT")

	if K.Name == "Kkthnx" or K.Name == "Rollndots" or K.Name == "Broflex" then
		SetCVar("scriptErrors", 1)
	end

	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)

	FCF_OpenNewWindow(LOOT)
	FCF_DockFrame(ChatFrame3)
	FCF_SetLocked(ChatFrame3, 1)
	ChatFrame3:Show()

	-- Setting chat frames
	if C["Chat"].enable == true and not (IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			-- Move general chat to bottom left
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint(unpack(C["position"].chat))
			end
		end

		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_INLINE_TOAST_ALERT")

		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame3, "SKILL")
		ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_GUILD_XP_GAIN")
		ChatFrame_AddChannel(ChatFrame1, GENERAL)
		ChatFrame_RemoveChannel(ChatFrame1, TRADE)
		ChatFrame_AddChannel(ChatFrame3, TRADE)

		-- Adjust Chat Colors
		ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255) -- General
		ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255) -- Trade
		ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255) -- Local Defense
	end

	-- Reset saved variables on char
	SavedPositions = {}
	SavedOptionsPerChar = {}

	SavedOptionsPerChar.Install = true
	SavedOptionsPerChar.AutoInvite = false
	SavedOptionsPerChar.BarsLocked = false
	SavedOptionsPerChar.SplitBars = true
	SavedOptionsPerChar.RightBars = C["ActionBar"].RightBars
	SavedOptionsPerChar.BottomBars = C["ActionBar"].BottomBars

	StaticPopup_Show("RELOAD_UI")
end

local function DisableUI()
	DisableAddOn("KkthnxUI")
	ReloadUI()
end

-- Install Popups
StaticPopupDialogs.INSTALL_UI = {
	text = L_POPUP_INSTALLUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = false end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 3,
}

StaticPopupDialogs.RELOAD_UI = {
	text = L_POPUP_RELOADUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() ReloadUI() end,
	OnCancel = function() SavedOptionsPerChar.Install = false end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 3,
}

StaticPopupDialogs.DISABLE_UI = {
	text = L_POPUP_DISABLEUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableUI,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 3,
}

StaticPopupDialogs.RESET_UI = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = true end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 3,
}

SLASH_INSTALLUI1 = "/installui"
SlashCmdList.INSTALLUI = function() StaticPopup_Show("INSTALL_UI") end

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("RESET_UI") end

-- On login function
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	-- Create empty CVar if they don't exist
	if not SavedOptions then SavedOptions = {} end
	if not SavedPositions then SavedPositions = {} end
	if not SavedOptionsPerChar then SavedOptionsPerChar = {} end
	if SavedOptionsPerChar.AutoInvite == nil then SavedOptionsPerChar.AutoInvite = false end
	if SavedOptionsPerChar.BarsLocked == nil then SavedOptionsPerChar.BarsLocked = false end
	if SavedOptionsPerChar.SplitBars == nil then SavedOptionsPerChar.SplitBars = true end
	if SavedOptionsPerChar.RightBars == nil then SavedOptionsPerChar.RightBars = C["ActionBar"].RightBars end
	if SavedOptionsPerChar.BottomBars == nil then SavedOptionsPerChar.BottomBars = C["ActionBar"].BottomBars end

	if IsAddOnLoaded("KkthnxUI_Config") then
		if not GUIConfig then GUIConfig = {} end
	end

	if K.ScreenWidth < 1024 and GetCVar("gxMonitor") == "0" then
		SetCVar("useUiScale", 0)
		StaticPopup_Show("DISABLE_UI")
	else

	-- Install default if we never ran KkthnxUI on this character
	if not SavedOptionsPerChar.Install then
		StaticPopup_Show("INSTALL_UI")
	end
end

	-- Welcome message
	if C["General"].welcome_message == true then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffe02e"..L_WELCOME_LINE_1..K.Version.." "..K.Client..", "..format("|cff%02x%02x%02x%s|r", K.Color.r * 255, K.Color.g * 255, K.Color.b * 255, K.Name)..".|r")
		DEFAULT_CHAT_FRAME:AddMessage("|cffffe02e"..L_WELCOME_LINE_2_1.."|cffffe02e"..L_WELCOME_LINE_2_2.."|r")
	end
end)

-- Help translate
if C["General"].translate_message == true then
	if GetLocale() == "esES" or GetLocale() == "koKR" or GetLocale() == "esMX" or GetLocale() == "deDE" or GetLocale() == "frFR" or GetLocale() == "koKR" or GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffe02ePlease help us translate the text settings for |cff2eb6ffKkthnxUI|r. |cffffe02eYou can post a commit to|r |cff2eb6ffgithub.com/Kkthnx/KkthnxUI_WotLK|r")
	end
end
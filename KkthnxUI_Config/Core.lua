-- GUI for KkthnxUI (by Fernir, Tukz and Tohveli, Shestak)

local realm = GetRealmName()
local name = UnitName("player")

local ALLOWED_GROUPS = {
	["general"] = 1,
	["announcements"] = 2,
	["automation"] = 3,
	["blizzard"] = 4,
	["buffs"] = 5,
	["reminder"] = 6,
	["chat"] = 7,
	["cooldown"] = 8,
	["error"] = 9,
	["filger"] = 10,
	["actionbar"] = 11,
	["loot"] = 12,
	["map"] = 13,
	["minimap"] = 14,
	["misc"] = 15,
	["nameplate"] = 16,
	["skins"] = 17,
	["tooltip"] = 18,
	["unitframe"] = 19,
}

local function Local(o)
	local K, C, L = unpack(KkthnxUI);
	-- Actionbar Settings
	if o == "UIConfigactionbar" then o = ACTIONBAR_LABEL end
	if o == "UIConfigactionbarbagsbar" then o = L_GUI_ACTIONBAR_BAGS_BAR end
	if o == "UIConfigactionbarbagshide" then o = L_GUI_ACTIONBAR_BAGS_BAR_HIDE end
	if o == "UIConfigactionbarbagsmouseover" then o = L_GUI_ACTIONBAR_BAGS_BAR_MOUSEOVER end
	if o == "UIConfigactionbarenable" then o = L_GUI_ACTIONBAR_ENABLE end
	if o == "UIConfigactionbarmicromenu" then o = L_GUI_ACTIONBAR_MICRO_MENU end
	if o == "UIConfigactionbarmicromenuhide" then o = L_GUI_ACTIONBAR_MICRO_MENU_HIDE end
	if o == "UIConfigactionbarmicromenumouseover" then o = L_GUI_ACTIONBAR_MICRO_MENU_MOUSEOVER end
	if o == "UIConfigactionbarout_of_mana" then o = L_GUI_ACTIONBAR_OUT_OF_MANA end
	if o == "UIConfigactionbarout_of_range" then o = L_GUI_ACTIONBAR_OUT_OF_RANGE end
	if o == "UIConfigactionbarremovetextures" then o = L_GUI_ACTIONBAR_REMOVE_TEXTRES end
	if o == "UIConfigactionbarscale" then o = L_GUI_ACTIONBAR_SCALE end
	if o == "UIConfigactionbarshowgrid" then o = L_GUI_ACTIONBAR_SHOW_GRID end
	if o == "UIConfigactionbarshowhotkeys" then o = L_GUI_ACTIONBAR_SHOW_HOTKEYS end
	if o == "UIConfigactionbarshowmacroname" then o = L_GUI_ACTIONBAR_SHOW_MACRONAME end
	if o == "UIConfigactionbarskinbuttons" then o = L_GUI_ACTIONBAR_SKIN_BUTTONS end
	-- Announcement Settings
	if o == "UIConfigannouncements" then o = L_GUI_ANNOUNCEMENTS end
	if o == "UIConfigannouncementssaysapped" then o = L_GUI_ANNOUNCEMENTS_SAYSAPPED end
	if o == "UIConfigannouncementsdrinking" then o = L_GUI_ANNOUNCEMENTS_DRINKING end
	if o == "UIConfigannouncementsspells" then o = L_GUI_ANNOUNCEMENTS_SPELLS end
	if o == "UIConfigannouncementsinterrupt" then o = L_GUI_ANNOUNCEMENTS_INTERRUPT end
	if o == "UIConfigannouncementsspells_from_all" then o = L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL end
	-- Automation Settings
	if o == "UIConfigautomation" then o = L_GUI_AUTOMATION end
	if o == "UIConfigautomationautocollapse" then o = L_GUI_AUTOMATION_AUTOCOLLAPSE end
	if o == "UIConfigautomationautoinvite" then o = L_GUI_AUTOMATION_ACCEPTINVITE end
	if o == "UIConfigautomationcollectgarbage" then o = L_GUI_AUTOMATION_COLLECTGARBAGE end
	if o == "UIConfigautomationdeclineduel" then o = L_GUI_AUTOMATION_DECLINEDUEL end
	if o == "UIConfigautomationsellgrey_n_repair" then o = L_GUI_AUTOMATION_SELLGREY_N_REPAIR end
	if o == "UIConfigautomationresurrection" then o = L_GUI_AUTOMATION_RESURRECTION end
	if o == "UIConfigautomationcancel_bad_buffs" then o = L_GUI_AUTOMATION_CANCEL_BAD_BUFFS end
	if o == "UIConfigautomationtab_binder" then o = L_GUI_AUTOMATION_TAB_BINDER end
	if o == "UIConfigautomationwatchframebutton" then o = L_GUI_AUTOMATION_WATCHFRAME_BUTTON end
	-- Blizzard Settings
	if o == "UIConfigblizzard" then o = L_GUI_BLIZZARD end
	if o == "UIConfigblizzardcapturebar" then o = L_GUI_BLIZZARD_CAPTUREBAR end
	if o == "UIConfigblizzardclasscolor" then o = L_GUI_BLIZZARD_CLASSCOLOR end
	if o == "UIConfigblizzarddurability" then o = L_GUI_BLIZZARD_DURABILITY end
	if o == "UIConfigblizzardmoveachievements" then o = L_GUI_BLIZZARD_ACHIEVEMENTS end
	if o == "UIConfigblizzardmoveblizzard" then o = L_GUI_BLIZZARD_MOVE_BLIZZARD end
	if o == "UIConfigblizzardquestbuttonsize" then o = L_GUI_BLIZZARD_QUESTBUTTON_SIZE end
	if o == "UIConfigblizzardrepreward" then o = L_GUI_BLIZZARD_REPREWARD end
	if o == "UIConfigblizzarddark_textures" then o = L_GUI_BLIZZARD_DARK_TEXTURES end
	if o == "UIConfigblizzarddark_textures_color" then o = L_GUI_BLIZZARD_DARK_TEXTURES_COLOR end
	-- Buffs & Debuffs Settings
	if o == "UIConfigbuffs" then o = L_GUI_BUFFS end
	if o == "UIConfigbuffsaurasperrow" then o = L_GUI_BUFFS_BUFFPERROW end
	if o == "UIConfigbuffsbuffsize" then o = L_GUI_BUFFS_BUFFSIZE end
	if o == "UIConfigbuffsdebuffsize" then o = L_GUI_BUFFS_DEBUFFSIZE end
	if o == "UIConfigbuffsenable" then o = L_GUI_BUFFS_ENABLE end
	if o == "UIConfigbuffspaddingx" then o = L_GUI_BUFFS_PADDINGX end
	if o == "UIConfigbuffspaddingy" then o = L_GUI_BUFFS_PADDINGY end
	if o == "UIConfigbuffsclass_color" then o = L_GUI_BUFFS_CLASS_COLOR end
	-- Chat Settings
	if o == "UIConfigchat" then o = CHAT end
	if o == "UIConfigchatcombatlog" then o = L_GUI_CHAT_CL_TAB end
	if o == "UIConfigchatenable" then o = L_GUI_CHAT_ENABLE end
	if o == "UIConfigchatfilter" then o = L_GUI_CHAT_SPAM end
	if o == "UIConfigchatheight" then o = L_GUI_CHAT_HEIGHT end
	if o == "UIConfigchatoutline" then o = L_GUI_CHAT_OUTLINE end
	if o == "UIConfigchatspam" then o = L_GUI_CHAT_GOLD end
	if o == "UIConfigchatsticky" then o = L_GUI_CHAT_STICKY end
	if o == "UIConfigchattabmouseover" then o = L_GUI_CHAT_TABS_MOUSEOVER end
	if o == "UIConfigchattabsoutline" then o = L_GUI_CHAT_TABS_OUTLINE end
	if o == "UIConfigchattime_color" then o = L_GUI_CHAT_TIMESTAMP end
	if o == "UIConfigchatwhisp_sound" then o = L_GUI_CHAT_WHISP end
	if o == "UIConfigchatwidth" then o = L_GUI_CHAT_WIDTH end
	-- Cooldown Settings
	if o == "UIConfigcooldown" then o = L_GUI_COOLDOWN end
	if o == "UIConfigcooldownenable" then o = L_GUI_COOLDOWN_ENABLE end
	if o == "UIConfigcooldownfont_size" then o = L_GUI_COOLDOWN_FONT_SIZE end
	if o == "UIConfigcooldownthreshold" then o = L_GUI_COOLDOWN_THRESHOLD end
	-- Error Settings
	if o == "UIConfigerror" then o = L_GUI_ERROR end
	if o == "UIConfigerrorblack" then o = L_GUI_ERROR_BLACK end
	if o == "UIConfigerrorcombat" then o = L_GUI_ERROR_HIDE_COMBAT end
	if o == "UIConfigerrorwhite" then o = L_GUI_ERROR_WHITE end
	-- Filger
	if o == "UIConfigfilger" then o = L_GUI_FILGER end
	if o == "UIConfigfilgerenable" then o = L_GUI_FILGER_ENABLE end
	if o == "UIConfigfilgertest_mode" then o = L_GUI_FILGER_TEST_MODE end
	if o == "UIConfigfilgermax_test_icon" then o = L_GUI_FILGER_MAX_TEST_ICON end
	if o == "UIConfigfilgershow_tooltip" then o = L_GUI_FILGER_SHOW_TOOLTIP end
	if o == "UIConfigfilgerbuffs_size" then o = L_GUI_FILGER_BUFFS_SIZE end
	if o == "UIConfigfilgercooldown_size" then o = L_GUI_FILGER_COOLDOWN_SIZE end
	if o == "UIConfigfilgerpvp_size" then o = L_GUI_FILGER_PVP_SIZE end
	-- General Settings
	if o == "UIConfiggeneral" then o = GENERAL_LABEL end
	if o == "UIConfiggeneralauto_scale" then o = L_GUI_GENERAL_AUTOSCALE end
	if o == "UIConfiggeneraltranslate_message" then o = L_GUI_GENERAL_TRANSLATE_MESSAGE end
	if o == "UIConfiggeneraluiscale" then o = L_GUI_GENERAL_UISCALE end
	if o == "UIConfiggeneralwelcome_message" then o = L_GUI_GENERAL_WELCOME_MESSAGE end
	-- Loot Settings
	if o == "UIConfigloot" then o = LOOT end
	if o == "UIConfiglootauto_confirm_de" then o = L_GUI_LOOT_AUTODE end
	if o == "UIConfiglootauto_greed" then o = L_GUI_LOOT_AUTOGREED end
	if o == "UIConfiglootbetterlootfilter" then o = L_GUI_LOOT_BETTER_LOOTFILTER end
	if o == "UIConfiglooticon_size" then o = L_GUI_LOOT_ICON_SIZE end
	if o == "UIConfiglootlootframe" then o = L_GUI_LOOT_ENABLE end
	if o == "UIConfiglootrolllootframe" then o = L_GUI_LOOT_ROLL_ENABLE end
	if o == "UIConfiglootwidth" then o = L_GUI_LOOT_WIDTH end
	-- WorldMap Settings
	if o == "UIConfigmap" then o = WORLD_MAP end
	if o == "UIConfigmapenable" then o = L_GUI_MAP_ENABLE end
	if o == "UIConfigmapgroup_icons" then o = L_GUI_MAP_ICON end
	if o == "UIConfigmapscale" then o = L_GUI_MAP_SCALE end
	if o == "UIConfigmapbg_map_stylization" then o = L_GUI_MAP_BG_STYLIZATION end
	-- Minimap Settings
	if o == "UIConfigminimap" then o = L_GUI_MINIMAP end
	if o == "UIConfigminimapcollectbuttons" then o = L_GUI_MINIMAP_COLLECTBUTTONS end
	if o == "UIConfigminimapenable" then o = L_GUI_MINIMAP_ENABLEMINIMAP end
	if o == "UIConfigminimapnodeflash" then o = L_GUI_MINIMAP_NODEFLASH end
	if o == "UIConfigminimapsize" then o = L_GUI_MINIMAP_MINIMAPSIZE end
	if o == "UIConfigminimapclasscolor" then o = L_GUI_MINIMAP_CLASSCOLOR end
	-- Misc Settings
	if o == "UIConfigmisc" then o = L_GUI_MISC end
	if o == "UIConfigmiscalreadyknown" then o = L_GUI_MISC_ALREADY_KNOWN end
	if o == "UIConfigmiscafk_spin_camera" then o = L_GUI_MISC_SPIN_CAMERA end
	if o == "UIConfigmischide_bg_spam" then o = L_GUI_MISC_HIDE_BG_SPAM end
	if o == "UIConfigmiscarmory_link" then o = L_GUI_MISC_ARMORY_LINK end
	if o == "UIConfigmiscenhancedmail" then o = L_GUI_MISC_ENCHANCED_MAIL end
	if o == "UIConfigmiscfadegamemenu" then o = L_GUI_MISC_FADE_GAME_MENU end
	if o == "UIConfigmischattrick" then o = L_GUI_MISC_HATTRICK end
	-- Buffs Reminder Settings
	if o == "UIConfigreminder" then o = L_GUI_REMINDER end
	if o == "UIConfigremindersolo_buffs_enable" then o = L_GUI_REMINDER_SOLO_ENABLE end
	if o == "UIConfigremindersolo_buffs_sound" then o = L_GUI_REMINDER_SOLO_SOUND end
	if o == "UIConfigremindersolo_buffs_size" then o = L_GUI_REMINDER_SOLO_SIZE end
	if o == "UIConfigreminderraid_buffs_enable" then o = L_GUI_REMINDER_RAID_ENABLE end
	if o == "UIConfigreminderraid_buffs_always" then o = L_GUI_REMINDER_RAID_ALWAYS end
	if o == "UIConfigreminderraid_buffs_size" then o = L_GUI_REMINDER_RAID_SIZE end
	if o == "UIConfigreminderraid_buffs_alpha" then o = L_GUI_REMINDER_RAID_ALPHA end
	-- Nameplates Settings
	if o == "UIConfignameplate" then o = L_GUI_NAMEPLATES end
	if o == "UIConfignameplateenhancethreat" then o = L_GUI_NAMEPLATE_ENHANCE_THREAT end
	if o == "UIConfignameplateshowhealth" then o = L_GUI_NAMEPLATE_SHOW_HEALTH end
	if o == "UIConfignameplatecombat" then o = L_GUI_NAMEPLATE_COMBAT end
	if o == "UIConfignameplatetrackdebuffs" then o = L_GUI_NAMEPLATE_TRACK_DEBUFFS end
	if o == "UIConfignameplatetrackcc" then o = L_GUI_NAMEPLATE_TRACK_CC end
	if o == "UIConfignameplateenable" then o = L_GUI_NAMEPLATE_ENABLE end
	if o == "UIConfignameplategoodcolor" then o = L_GUI_NAMEPLATE_GOOD_COLOR end
	if o == "UIConfignameplatebadcolor" then o = L_GUI_NAMEPLATE_BAD_COLOR end
	if o == "UIConfignameplatetransitioncolor" then o = L_GUI_NAMEPLATE_TRANSITION_COLOR end
	if o == "UIConfignameplatehp_height" then o = L_GUI_NAMEPLATE_HP_HEIGHT end
	if o == "UIConfignameplatehp_width" then o = L_GUI_NAMEPLATE_HP_WIDTH end
	if o == "UIConfignameplateicon_size" then o = L_GUI_NAMEPLATE_ICON_SIZE end
	if o == "UIConfignameplatecb_height" then o = L_GUI_NAMEPLATE_CP_HEIGHT end
	if o == "UIConfignameplatecb_width" then o = L_GUI_NAMEPLATE_CP_WIDTH end	
	-- Skins Settings
	if o == "UIConfigskins" then o = L_GUI_SKINS end
	if o == "UIConfigskinsbigwigs" then o = L_GUI_SKINS_BW end
	if o == "UIConfigskinsminimap_buttons" then o = L_GUI_SKINS_MINIMAP_BUTTONS end
	if o == "UIConfigskinsclcret" then o = L_GUI_SKINS_CLCR end
	if o == "UIConfigskinschatbubble" then o = L_GUI_SKINS_CHAT_BUBBLE end
	if o == "UIConfigskinsdbm" then o = L_GUI_SKINS_DBM end
	if o == "UIConfigskinsskada" then o = L_GUI_SKINS_SKADA end
	if o == "UIConfigskinsweakauras" then o = L_GUI_SKINS_WEAKAURAS end
	-- Tooltip Settings
	if o == "UIConfigtooltip" then o = L_GUI_TOOLTIP end
	if o == "UIConfigtooltipachievements" then o = L_GUI_TOOLTIP_ACHIEVEMENTS end
	if o == "UIConfigtooltiparenaexperience" then o = L_GUI_TOOLTIP_ARENA_EXPERIENCE end
	if o == "UIConfigtooltipcursor" then o = L_GUI_TOOLTIP_CURSOR end
	if o == "UIConfigtooltipenable" then o = L_GUI_TOOLTIP_ENABLE end
	if o == "UIConfigtooltipfontoutline" then o = L_GUI_TOOLTIP_OUTLINE end
	if o == "UIConfigtooltiphidebuttons" then o = L_GUI_TOOLTIP_HIDE end
	if o == "UIConfigtooltiphideincombat" then o = L_GUI_TOOLTIP_HIDE_IN_COMBAT end
	if o == "UIConfigtooltipitemicon" then o = L_GUI_TOOLTIP_ICONS end
	if o == "UIConfigtooltipmouseovertarget" then o = L_GUI_TOOLTIP_MOUSEOVER_TARGET end
	if o == "UIConfigtooltipqualitybordercolor" then o = L_GUI_TOOLTIP_QUALITY_BORDER end
	if o == "UIConfigtooltiprank" then o = L_GUI_TOOLTIP_RANK end
	if o == "UIConfigtooltipshiftmodifer" then o = L_GUI_TOOLTIP_SHIFT end
	if o == "UIConfigtooltipshowtitles" then o = L_GUI_TOOLTIP_SHOW_TITLES end
	if o == "UIConfigtooltipspellid" then o = L_GUI_TOOLTIP_SPELLID end
	if o == "UIConfigtooltiptalents" then o = L_GUI_TOOLTIP_TALENTS end
	if o == "UIConfigtooltiptarget" then o = L_GUI_TOOLTIP_TARGET end
	if o == "UIConfigtooltiptitle" then o = L_GUI_TOOLTIP_TITLE end
	if o == "UIConfigtooltiphealth_value" then o = L_GUI_TOOLTIP_HEALTH end
	-- Unitframe Settings
	if o == "UIConfigunitframe" then o = L_GUI_UNITFRAME end
	if o == "UIConfigunitframeauraoffsety" then o = L_GUI_UNITFRAME_AURA_OFFSETY end
	if o == "UIConfigunitframebetterpowercolor" then o = L_GUI_UNITFRAME_BETTER_POWER_COLOR end
	if o == "UIConfigunitframecbscale" then o = L_GUI_UNITFRAME_CASTBAR_SCALE end
	if o == "UIConfigunitframepercent_health" then o = L_GUI_UNITFRAME_PERCENT_HEALTH end
	if o == "UIConfigunitframeclasshealth" then o = L_GUI_UNITFRAME_CLASS_HEALTH end
	if o == "UIConfigunitframeclassicon" then o = L_GUI_UNITFRAME_CLASS_ICON end
	if o == "UIConfigunitframecombatfeedback" then o = L_GUI_UNITFRAME_COMBAT_FEEDBACK end
	if o == "UIConfigunitframeenable" then o = L_GUI_UNITFRAME_ENABLE end
	if o == "UIConfigunitframeenhancedframes" then o = L_GUI_UNITFRAME_ENHANCED_UNITFRAMES end
	if o == "UIConfigunitframegroupnumber" then o = L_GUI_UNITFRAME_GROUP_NUMBER end
	if o == "UIConfigunitframelargeaura" then o = L_GUI_UNITFRAME_LARGE_AURA end
	if o == "UIConfigunitframeoutline" then o = L_GUI_UNITFRAME_OUTLINE end
	if o == "UIConfigunitframepartyscale" then o = L_GUI_UNITFRAME_PARTY_SCALE end
	if o == "UIConfigunitframescale" then o = L_GUI_UNITFRAME_SCALE end
	if o == "UIConfigunitframesmallaura" then o = L_GUI_UNITFRAME_SMALL_AURA end
	if o == "UIConfigunitframetradeskill_cast" then o = L_GUI_UNITFRAME_TRADESKILL_CAST end
	
	K.option = o
end

local NewButton = function(text, parent)
	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetText(text)
	result:SetWidth(label:GetWidth())
	result:SetHeight(label:GetHeight())
	result:SetFontString(label)
	result:SetNormalTexture("")
	result:SetHighlightTexture("")
	result:SetPushedTexture("")
	
	return result
end

local NormalButton = function(text, parent)
	local K, C, L = unpack(KkthnxUI);
	
	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetJustifyH("LEFT")
	label:SetText(text)
	result:SetWidth(100)
	result:SetHeight(23)
	result:SetFontString(label)
	
	return result
end

StaticPopupDialogs.PERCHAR = {
	text = L_GUI_PER_CHAR,
	OnAccept = function()
		if UIConfigAllCharacters:GetChecked() then
			GUIConfigAll[realm][name] = true
		else
			GUIConfigAll[realm][name] = false
		end
		ReloadUI()
	end,
	OnCancel = function()
		UIConfigCover:Hide()
		if UIConfigAllCharacters:GetChecked() then
			UIConfigAllCharacters:SetChecked(false)
		else
			UIConfigAllCharacters:SetChecked(true)
		end
	end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs.RESET_PERCHAR = {
	text = L_GUI_RESET_CHAR,
	OnAccept = function()
		GUIConfig = GUIConfigSettings
		ReloadUI()
	end,
	OnCancel = function() if UIConfig and UIConfig:IsShown() then UIConfigCover:Hide() end end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs.RESET_ALL = {
	text = L_GUI_RESET_ALL,
	OnAccept = function()
		GUIConfigSettings = nil
		GUIConfig = nil
		ReloadUI()
	end,
	OnCancel = function() UIConfigCover:Hide() end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

local function SetValue(group, option, value)
	local mergesettings
	if GUIConfig == GUIConfigSettings then
		mergesettings = true
	else
		mergesettings = false
	end
	
	if GUIConfigAll[realm][name] == true then
		if not GUIConfig then GUIConfig = {} end
		if not GUIConfig[group] then GUIConfig[group] = {} end
		GUIConfig[group][option] = value
	else
		if mergesettings == true then
			if not GUIConfig then GUIConfig = {} end
			if not GUIConfig[group] then GUIConfig[group] = {} end
			GUIConfig[group][option] = value
		end
		
		if not GUIConfigSettings then GUIConfigSettings = {} end
		if not GUIConfigSettings[group] then GUIConfigSettings[group] = {} end
		GUIConfigSettings[group][option] = value
	end
end

local VISIBLE_GROUP = nil
local lastbutton = nil
local function ShowGroup(group, button)
	local K, C, L = unpack(KkthnxUI);
	
	if lastbutton then
		lastbutton:SetText(lastbutton:GetText().sub(lastbutton:GetText(), 11, -3))
	end
	if VISIBLE_GROUP then
		_G["UIConfig"..VISIBLE_GROUP]:Hide()
	end
	if _G["UIConfig"..group] then
		local o = "UIConfig"..group
		Local(o)
		_G["UIConfigTitle"]:SetText(K.option)
		local height = _G["UIConfig"..group]:GetHeight()
		_G["UIConfig"..group]:Show()
		local scrollamntmax = 400
		local scrollamntmin = scrollamntmax - 10
		local max = height > scrollamntmax and height-scrollamntmin or 1
		
		if max == 1 then
			_G["UIConfigGroupSlider"]:SetValue(1)
			_G["UIConfigGroupSlider"]:Hide()
		else
			_G["UIConfigGroupSlider"]:SetMinMaxValues(0, max)
			_G["UIConfigGroupSlider"]:Show()
			_G["UIConfigGroupSlider"]:SetValue(1)
		end
		_G["UIConfigGroup"]:SetScrollChild(_G["UIConfig"..group])
		
		local x
		if UIConfigGroupSlider:IsShown() then
			_G["UIConfigGroup"]:EnableMouseWheel(true)
			_G["UIConfigGroup"]:SetScript("OnMouseWheel", function(self, delta)
				if UIConfigGroupSlider:IsShown() then
					if delta == -1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x + 10)
					elseif delta == 1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x - 30)
					end
				end
			end)
		else
			_G["UIConfigGroup"]:EnableMouseWheel(false)
		end
		
		VISIBLE_GROUP = group
		lastbutton = button
	end
end

local loaded
function CreateUIConfig()
	if InCombatLockdown() and not loaded then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
	local K, C, L = unpack(KkthnxUI);
	
	if UIConfigMain then
		ShowGroup("general")
		UIConfigMain:Show()
		return
	end
	
	-- Main Frame
	local UIConfigMain = CreateFrame("Frame", "UIConfigMain", UIParent)
	UIConfigMain:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 200)
	UIConfigMain:SetWidth(780)
	UIConfigMain:SetHeight(520)
	K.SetBlizzBorder(UIConfigMain, 2)
	UIConfigMain:SetBackdropBorderColor(unpack(C["media"].border_color))
	UIConfigMain:SetFrameStrata("DIALOG")
	UIConfigMain:SetFrameLevel(20)
	tinsert(UISpecialFrames, "UIConfigMain")
	
	-- Version Title
	local TitleBoxVer = CreateFrame("Frame", "TitleBoxVer", UIConfigMain)
	TitleBoxVer:SetWidth(180)
	TitleBoxVer:SetHeight(24)
	TitleBoxVer:SetPoint("TOPLEFT", UIConfigMain, "TOPLEFT", 23, -15)
	
	local TitleBoxVerText = TitleBoxVer:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	TitleBoxVerText:SetPoint("CENTER")
	TitleBoxVerText:SetText("|cff69ccf0Kkthnx|r|cffffa500UI|r "..K.Version)
	
	-- Main Frame Title
	local TitleBox = CreateFrame("Frame", "TitleBox", UIConfigMain)
	TitleBox:SetWidth(540)
	TitleBox:SetHeight(24)
	TitleBox:SetPoint("TOPLEFT", TitleBoxVer, "TOPRIGHT", 15, 0)
	
	local TitleBoxText = TitleBox:CreateFontString("UIConfigTitle", "OVERLAY", "GameFontNormal")
	TitleBoxText:SetPoint("LEFT", TitleBox, "LEFT", 15, 0)
	
	-- Options Frame
	local UIConfig = CreateFrame("Frame", "UIConfig", UIConfigMain)
	UIConfig:SetPoint("TOPLEFT", TitleBox, "BOTTOMLEFT", 10, -15)
	UIConfig:SetWidth(520)
	UIConfig:SetHeight(400)
	
	local UIConfigBG = CreateFrame("Frame", "UIConfigBG", UIConfig)
	UIConfigBG:SetPoint("TOPLEFT", -10, 10)
	UIConfigBG:SetPoint("BOTTOMRIGHT", 10, -10)
	
	-- Group Frame
	local groups = CreateFrame("ScrollFrame", "UIConfigCategoryGroup", UIConfig)
	groups:SetPoint("TOPLEFT", TitleBoxVer, "BOTTOMLEFT", 10, -15)
	groups:SetWidth(160)
	groups:SetHeight(400)
	
	local groupsBG = CreateFrame("Frame", "groupsBG", UIConfig)
	groupsBG:SetPoint("TOPLEFT", groups, -10, 10)
	groupsBG:SetPoint("BOTTOMRIGHT", groups, 10, -10)
	
	local UIConfigCover = CreateFrame("Frame", "UIConfigCover", UIConfigMain)
	UIConfigCover:SetPoint("TOPLEFT", 0, 0)
	UIConfigCover:SetPoint("BOTTOMRIGHT", 0, 0)
	UIConfigCover:SetFrameLevel(UIConfigMain:GetFrameLevel() + 20)
	UIConfigCover:EnableMouse(true)
	UIConfigCover:SetScript("OnMouseDown", function(self) print(L_GUI_MAKE_SELECTION) end)
	UIConfigCover:Hide()
	
	-- Group Scroll
	local slider = CreateFrame("Slider", "UIConfigCategorySlider", groups)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) groups:SetVerticalScroll(value) end)
	
	if not slider.bg then
		slider.bg = CreateFrame("Frame", nil, slider)
		slider.bg:SetPoint("TOPLEFT", slider:GetThumbTexture(), "TOPLEFT", 7, -7)
		slider.bg:SetPoint("BOTTOMRIGHT", slider:GetThumbTexture(), "BOTTOMRIGHT", -7, 7)
	end
	
	local function sortMyTable(a, b)
		return ALLOWED_GROUPS[a] < ALLOWED_GROUPS[b]
	end
	local function pairsByKey(t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, sortMyTable)
		local i = 0
		local iter = function()
			i = i + 1
			if a[i] == nil then return nil
			else return a[i], t[a[i]]
			end
		end
		return iter
	end
	
	local GetOrderedIndex = function(t)
		local OrderedIndex = {}
		
		for key in pairs(t) do table.insert(OrderedIndex, key) end
		table.sort(OrderedIndex)
		return OrderedIndex
	end
	
	local OrderedNext = function(t, state)
		local Key
		
		if (state == nil) then
			t.OrderedIndex = GetOrderedIndex(t)
			Key = t.OrderedIndex[1]
			return Key, t[Key]
		end
		
		Key = nil
		for i = 1, #t.OrderedIndex do
			if (t.OrderedIndex[i] == state) then Key = t.OrderedIndex[i + 1] end
		end
		
		if Key then return Key, t[Key] end
		t.OrderedIndex = nil
		return
	end
	
	local PairsByKeys = function(t) return OrderedNext, t, nil end
	
	local child = CreateFrame("Frame", nil, groups)
	child:SetPoint("TOPLEFT")
	local offset = 5
	for i in pairsByKey(ALLOWED_GROUPS) do
		local o = "UIConfig"..i
		Local(o)
		local button = NewButton(K.option, child)
		button:SetHeight(16)
		button:SetWidth(125)
		button:SetPoint("TOPLEFT", 5, -offset)
		button:SetScript("OnClick", function(self) ShowGroup(i, button) self:SetText(format("|cff%02x%02x%02x%s|r", K.Color.r*255, K.Color.g*255, K.Color.b*255, K.option)) end)
		offset = offset + 20
	end
	child:SetWidth(125)
	child:SetHeight(offset)
	--slider:SetMinMaxValues(0, (offset == 0 and 1 or offset - 12 * 33))
	slider:SetValue(1)
	groups:SetScrollChild(child)
	
	local x
	_G["UIConfigCategoryGroup"]:EnableMouseWheel(true)
	_G["UIConfigCategoryGroup"]:SetScript("OnMouseWheel", function(self, delta)
		if _G["UIConfigCategorySlider"]:IsShown() then
			if delta == -1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x + 10)
			elseif delta == 1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x - 20)
			end
		end
	end)
	
	local group = CreateFrame("ScrollFrame", "UIConfigGroup", UIConfig)
	group:SetPoint("TOPLEFT", 0, 5)
	group:SetWidth(520)
	group:SetHeight(400)
	
	-- Options Scroll
	local slider = CreateFrame("Slider", "UIConfigGroupSlider", group)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) group:SetVerticalScroll(value) end)
	
	for i in pairs(ALLOWED_GROUPS) do
		local frame = CreateFrame("Frame", "UIConfig"..i, UIConfigGroup)
		frame:SetPoint("TOPLEFT")
		frame:SetWidth(225)
		
		local offset = 5
		
		if type(C[i]) ~= "table" then error(i.." GroupName not found in config table.") return end
		for j, value in PairsByKeys(C[i]) do
			if type(value) == "boolean" then
				local button = CreateFrame("CheckButton", "UIConfig"..i..j, frame, "InterfaceOptionsCheckButtonTemplate")
				local o = "UIConfig"..i..j
				Local(o)
				_G["UIConfig"..i..j.."Text"]:SetText(K.option)
				_G["UIConfig"..i..j.."Text"]:SetFontObject(GameFontHighlight)
				_G["UIConfig"..i..j.."Text"]:SetWidth(460)
				_G["UIConfig"..i..j.."Text"]:SetJustifyH("LEFT")
				button:SetChecked(value)
				button:SetScript("OnClick", function(self) SetValue(i, j, (self:GetChecked() and true or false)) end)
				button:SetPoint("TOPLEFT", 5, -offset)
				offset = offset + 25
			elseif type(value) == "number" or type(value) == "string" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..i..j
				Local(o)
				label:SetText(K.option)
				label:SetWidth(460)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -offset)
				
				local editbox = CreateFrame("EditBox", nil, frame)
				editbox:SetAutoFocus(false)
				editbox:SetMultiLine(false)
				editbox:SetWidth(220)
				editbox:SetHeight(22)
				editbox:SetMaxLetters(255)
				editbox:SetTextInsets(3, 0, 0, 0)
				editbox:SetFontObject(GameFontHighlight)
				editbox:SetPoint("TOPLEFT", 8, -(offset + 20))
				editbox:SetText(value)
				editbox:SetBackdrop(K.Backdrop)
				editbox:SetBackdropColor(0.08, 0.08, 0.08, 1)
				
				local okbutton = CreateFrame("Button", nil, frame)
				okbutton:SetHeight(editbox:GetHeight())
				okbutton:SetPoint("LEFT", editbox, "RIGHT", 2, 0)
				
				local oktext = okbutton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				oktext:SetText(OKAY)
				oktext:SetPoint("CENTER", okbutton, "CENTER", -1, 0)
				okbutton:SetWidth(oktext:GetWidth() + 5)
				okbutton:Hide()
				
				if type(value) == "number" then
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(i, j, tonumber(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(i, j, tonumber(editbox:GetText())) end)
				else
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(i, j, tostring(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(i, j, tostring(editbox:GetText())) end)
				end
				
				offset = offset + 45
			elseif type(value) == "table" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..i..j
				Local(o)
				label:SetText(K.option)
				label:SetWidth(440)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -offset)
				
				colorbuttonname = (label:GetText().."ColorPicker")
				
				local colorbutton = CreateFrame("Button", colorbuttonname, frame)
				colorbutton:SetHeight(20)
				colorbutton:SetBackdrop(K.Backdrop)
				colorbutton:SetBackdropBorderColor(unpack(value))
				colorbutton:SetBackdropColor(value[1], value[2], value[3], 0.3)
				colorbutton:SetPoint("LEFT", label, "RIGHT", 2, 0)
				
				local colortext = colorbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				colortext:SetText(COLOR)
				colortext:SetPoint("CENTER")
				colortext:SetJustifyH("CENTER")
				colorbutton:SetWidth(colortext:GetWidth() + 5)
				
				local oldvalue = value
				
				local function round(number, decimal)
					return (("%%.%df"):format(decimal)):format(number)
				end
				
				colorbutton:SetScript("OnMouseDown", function(self)
					if ColorPickerFrame:IsShown() then return end
					local newR, newG, newB, newA
					local fired = 0
					
					local r, g, b, a = self:GetBackdropBorderColor();
					r, g, b, a = round(r, 2), round(g, 2), round(b, 2), round(a, 2)
					local originalR, originalG, originalB, originalA = r, g, b, a
					
					local function ShowColorPicker(r, g, b, a, changedCallback)
						ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, changedCallback
						ColorPickerFrame:SetColorRGB(r, g, b)
						a = tonumber(a)
						ColorPickerFrame.hasOpacity = (a ~= nil and a ~= 1)
						ColorPickerFrame.opacity = a
						ColorPickerFrame.previousValues = {originalR, originalG, originalB, originalA}
						ColorPickerFrame:Hide()
						ColorPickerFrame:Show()
					end
					
					local function myColorCallback(restore)
						fired = fired + 1
						if restore ~= nil then
							-- The user bailed, we extract the old color from the table created by ShowColorPicker
							newR, newG, newB, newA = unpack(restore)
						else
							-- Something changed
							newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
						end
						
						value = {newR, newG, newB, newA}
						SetValue(i, j, (value))
						self:SetBackdropBorderColor(newR, newG, newB, newA)
						self:SetBackdropColor(newR, newG, newB, 0.3)
					end
					
					ShowColorPicker(originalR, originalG, originalB, originalA, myColorCallback)
				end)
				
				offset = offset + 25
			end
		end
		
		frame:SetHeight(offset)
		frame:Hide()
	end
	
	local reset = NormalButton(DEFAULT, UIConfigMain)
	reset:SetPoint("TOPLEFT", UIConfig, "BOTTOMLEFT", -10, -25)
	reset:SetScript("OnClick", function(self)
		UIConfigCover:Show()
		if GUIConfigAll[realm][name] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end)
	
	local close = NormalButton(CLOSE, UIConfigMain)
	close:SetPoint("TOPRIGHT", UIConfig, "BOTTOMRIGHT", 10, -25)
	close:SetScript("OnClick", function(self) PlaySound("igMainMenuOption") UIConfigMain:Hide() end)
	
	local load = NormalButton(APPLY, UIConfigMain)
	load:SetPoint("RIGHT", close, "LEFT", -4, 0)
	load:SetScript("OnClick", function(self) ReloadUI() end)
	
	local totalreset = NormalButton(L_GUI_BUTTON_RESET, UIConfigMain)
	totalreset:SetWidth(120)
	totalreset:SetPoint("TOPLEFT", groupsBG, "BOTTOMLEFT", 0, -15)
	totalreset:SetScript("OnClick", function(self)
		StaticPopup_Show("RESET_UI")
		GUIConfig = {}
		if GUIConfigAll[realm][name] == true then
			GUIConfigAll[realm][name] = {}
		end
		GUIConfigSettings = {}
	end)
	
	if GUIConfigAll then
		local button = CreateFrame("CheckButton", "UIConfigAllCharacters", TitleBox, "InterfaceOptionsCheckButtonTemplate")
		button:SetScript("OnClick", function(self) StaticPopup_Show("PERCHAR") UIConfigCover:Show() end)
		button:SetPoint("RIGHT", TitleBox, "RIGHT", -3, 0)
		button:SetHitRectInsets(0, 0, 0, 0)
		
		local label = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		label:SetText(L_GUI_SET_SAVED_SETTTINGS)
		label:SetPoint("RIGHT", button, "LEFT")
		
		if GUIConfigAll[realm][name] == true then
			button:SetChecked(true)
		else
			button:SetChecked(false)
		end
	end
	
	local bgskins = {TitleBox, TitleBoxVer, UIConfigBG, groupsBG}
	for _, sb in pairs(bgskins) do
		sb:SetBackdrop(K.Backdrop)
		sb:SetBackdropColor(0, 0, 0, 1)
		sb:SetBackdropBorderColor(.3, .3, .3)
	end
	
	ShowGroup("general")
	loaded = true
end

do
	function SlashCmdList.CONFIG(msg, editbox)
		if not UIConfigMain or not UIConfigMain:IsShown() then
			PlaySound("igMainMenuOption")
			CreateUIConfig()
			HideUIPanel(GameMenuFrame)
		else
			PlaySound("igMainMenuOption")
			UIConfigMain:Hide()
		end
	end
	SLASH_CONFIG1 = "/config"
	SLASH_CONFIG2 = "/cfg"
	SLASH_CONFIG3 = "/configui"
	
	function SlashCmdList.RESETCONFIG()
		if UIConfigMain and UIConfigMain:IsShown() then UIConfigCover:Show() end
		
		if GUIConfigAll[realm][name] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end
	SLASH_RESETCONFIG1 = "/resetconfig"
end

do
	local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
	frame:Hide()
	
	frame.name = "|cff69ccf0Kkthnx|r|cffffa500UI|r"
	frame:SetScript("OnShow", function(self)
		if self.show then return end
		local K, C, L = unpack(KkthnxUI);
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText("Info:")
		
		local subtitle = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle:SetWidth(380)
		subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
		subtitle:SetJustifyH("LEFT")
		subtitle:SetText("GitHub: |cff69ccf0https://github.com/Kkthnx/KkthnxUI-3.3.5|r")
		
		local title2 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title2:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -16)
		title2:SetText("Credits:")
		
		local subtitle2 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle2:SetWidth(380)
		subtitle2:SetPoint("TOPLEFT", title2, "BOTTOMLEFT", 0, -8)
		subtitle2:SetJustifyH("LEFT")
		subtitle2:SetText("ALZA, AcidWeb, Aezay, Affli, Ailae, Allez, Ammo, Astromech, Beoko, Bitbyte, Blamdarot, Bozo, Bunny67, Caellian, Califpornia, Camealion, Chiril, CrusaderHeimdall, Cybey, Dawn, Don Kaban, Dridzt, Duffed, Durcyn, Eclipse, Egingell, Elv22, Evilpaul, Evl, Favorit, Fernir, Foof, Freebaser, Gorlasch, Gsuz, Haleth, Haste, Hoochie, Hungtar, HyPeRnIcS, Hydra, Ildyria, Jaslm, Karl_w_w, Karudon, Katae, Kellett, Kemayo, Killakhan, Kraftman, Kunda, Leatrix, Magdain, |cFFFF69B4Magicnachos|r, Meurtcriss, Monolit, MrRuben5, Myrilandell of Lothar, Nathanyel, Nefarion, Nightcracker, Nils Ruesch, Partha, Phanx, Rahanprout, Renstrom, RustamIrzaev, SDPhantom, Safturento, Sara.Festung, Sildor, Silverwind, SinaC, Slakah, Soeters, Starlon, Suicidal Katt, Syzgyn, Tekkub, Telroth, Thalyra, Thizzelle, Tia Lynn, Tohveli, Tukz, Tuller, Veev, Villiv, Wetxius, Woffle of Dark Iron, Wrug, Xuerian, Yleaf, Zork, g0st, gi2k15, iSpawnAtHome, m2jest1c, p3lim, sticklord")
		
		local title3 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title3:SetPoint("TOPLEFT", subtitle2, "BOTTOMLEFT", 0, -16)
		title3:SetText("Translation:")
		
		local subtitle3 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle3:SetWidth(380)
		subtitle3:SetPoint("TOPLEFT", title3, "BOTTOMLEFT", 0, -8)
		subtitle3:SetJustifyH("LEFT")
		subtitle3:SetText("")
		
		local title4 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title4:SetPoint("TOPLEFT", subtitle3, "BOTTOMLEFT", 0, -16)
		title4:SetText("Supporters")
		
		local subtitle4 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle4:SetWidth(380)
		subtitle4:SetPoint("TOPLEFT", title4, "BOTTOMLEFT", 0, -8)
		subtitle4:SetJustifyH("LEFT")
		subtitle4:SetText("XploitNT, jChirp, |cFFFF69B4Magicnachos|r")
		
		local version = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		version:SetPoint("BOTTOMRIGHT", -16, 16)
		version:SetText("Version: "..K.Version)
		
		self.show = true
	end)
	
	InterfaceOptions_AddCategory(frame)
end

-- Button in GameMenuButton frame
local button = CreateFrame("Button", "GameMenuButtonContinue", GameMenuFrame, "GameMenuButtonTemplate")
button:SetText("|cff69ccf0Kkthnx|r|cffffa500UI|r")
button:SetPoint("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -24)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + button:GetHeight())
GameMenuButtonSoundOptions:SetPoint("TOP", button, "BOTTOM", 0, -1)

button:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not UIConfigMain or not UIConfigMain:IsShown() then
		CreateUIConfig()
	else
		UIConfigMain:Hide()
	end
end)
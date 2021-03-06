-- Initiation / Engine of KkthnxUI
if IsAddOnLoaded("BuffLib") then
	DisableAddOn("BuffLib");
	ReloadUI();
end

function GetCVarBool(cvar)
	local var = GetCVar(cvar)
	if var == "1" then
		return true
	end
 
	return false;
end

function LocalizedClassNames()
	local locale = GetLocale()
-- Localized class names.  Index == enUS, value == localized
local classnames = locale == "deDE" and {
        ["Warlock"] = "Hexenmeister",
        ["Warrior"] = "Krieger",
        ["Hunter"] = "Jäger",
        ["Mage"] = "Magier",
        ["Priest"] = "Priester",
        ["Druid"] = "Druide",
        ["Paladin"] = "Paladin",
        ["Shaman"] = "Schamane",
        ["Rogue"] = "Schurke",
} or locale == "frFR" and {
        ["Warlock"] = "D\195\169moniste",
        ["Warrior"] = "Guerrier",
        ["Hunter"] = "Chasseur",
        ["Mage"] = "Mage",
        ["Priest"] = "Pr\195\170tre",
        ["Druid"] = "Druide",
        ["Paladin"] = "Paladin",
        ["Shaman"] = "Chaman",
        ["Rogue"] = "Voleur",
} or {
        ["Warlock"] = "Warlock",
        ["Warrior"] = "Warrior",
        ["Hunter"] = "Hunter",
        ["Mage"] = "Mage",
        ["Priest"] = "Priest",
        ["Druid"] = "Druid",
        ["Paladin"] = "Paladin",
        ["Shaman"] = "Shaman",
        ["Rogue"] = "Rogue",
}
end

local AddOn, Engine = "KkthnxUI", {}
KKaddonInfo = function() return AddOn, Engine end
Engine[1] = CreateFrame("Frame")
Engine[2] = {}
Engine[3] = {}
Engine[4] = {}

function Engine:unpack()
	return self[1], self[2], self[3], self[4]
end

Engine[1].Noop = function() return end
Engine[1].Unit = UnitGUID("player")
Engine[1].Name = UnitName("player")
Engine[1].Class = select(2, UnitClass("player"))
Engine[1].Race = select(2, UnitRace("player"))
Engine[1].Level = UnitLevel("player")
Engine[1].Client = GetLocale()
Engine[1].Realm = GetRealmName()
Engine[1].Resolution = GetCVar("gxResolution")
Engine[1].Color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[Engine[1].Class]
Engine[1].Version = GetAddOnMetadata(AddOn, "Version")
Engine[1].ScreenHeight = tonumber(string.match(Engine[1].Resolution, "%d+x(%d+)"))
Engine[1].ScreenWidth = tonumber(string.match(Engine[1].Resolution, "(%d+)x+%d"))
Engine[1].WoWPatch, Engine[1].WoWBuild, Engine[1].WoWPatchReleaseDate, Engine[1].TocVersion = GetBuildInfo()
SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

KkthnxUI = Engine

--[[
-- ** KkthnxUI Engine Documentation ** --

This should be at the top of every file inside of the KkthnxUI AddOn.
local K, C, L, _ = select(2, ...):unpack()
You can also do local K, C, _ = select(2, ...):unpack()
As well as K, _ = select(2, ...):unpack()
This is going to depend on what you are going to be using in the file.

This is how another addon imports the KkthnxUI engine.
local K, C, L, _ = KkthnxUI:unpack()
You can also do local K, C, _ = KkthnxUI:unpack()
As well as K, _ = select(2, ...):unpack()
This is going to depend on what you are going to be using in the file.

We put an ,_ for taint prevention.
]]
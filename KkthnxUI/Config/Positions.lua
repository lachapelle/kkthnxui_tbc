local K, C, L = unpack(select(2, ...));

C["position"] = {
	["achievements"] = {"TOP", UIParent, "TOP", 0, -21},
	["bgscore"] = {"BOTTOMLEFT", "ActionButton12", "BOTTOMRIGHT", 100, -2},
	["bn_popup"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 21, 20},
	["capturebar"] = {"TOP", UIParent, "TOP", 0, -170},
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 5},
	["expframe"] = {"TOP", "Minimap", "BOTTOM", 0, -30},
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -238, 700},
	["locframe"] = {"TOP", "Minimap", "BOTTOM", 0, 0},
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},
	["minimap"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -7, -7},
	["minimap_buttons"] = {"TOPRIGHT", "Minimap", "TOPLEFT", -3, 2},
	["playercastbar"] = {"CENTER", UIParent, "CENTER", 0, -146},
	["targetcastbar"] = {"CENTER", UIParent, "CENTER", 0, 200},
	["playerframe"] = {"CENTER", UIParent, "CENTER", -210, -160},
	["pulsecooldown"] = {"CENTER", UIParent, "CENTER", -210, 20},
	["quest"] = {"RIGHT", UIParent, "RIGHT", -120, 220},
	["statsframe"] = {"TOP", "Minimap", "BOTTOM", 0, -15},
	["targetframe"] = {"CENTER", UIParent, "CENTER", 210, -160},
	["partyframe"] = {"LEFT", UIParent, "LEFT", 120, 125},
	["actionbarextras"] = {"BOTTOM", "MultiBarBottomRightButton1", "TOP", -3, 7},
	["tooltip"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -3, 3},
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},
	["micromenu"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2},
	["bagsbar"] = {"TOPLEFT", UIParent, "TOPLEFT", 270, -2},
	-- Filger positions
filger = {
		["player_buff_icon"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 173},	-- "P_BUFF_ICON"
		["player_proc_icon"] = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 173},	-- "P_PROC_ICON"
		["special_proc_icon"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 213},	-- "SPECIAL_P_BUFF_ICON"
		["target_debuff_icon"] = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 213},	-- "T_DEBUFF_ICON"
		["target_buff_icon"] = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 253},	-- "T_BUFF"
		["pve_debuff"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 253},			-- "PVE/PVP_DEBUFF"
		["pve_cc"] = {"TOPLEFT", "PlayerFrame", "BOTTOMLEFT", -2, -44},				-- "PVE/PVP_CC"
		["cooldown"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 63, 17},	-- "COOLDOWN"
		["target_bar"] = {"BOTTOMLEFT", "TargetFrame", "BOTTOMRIGHT", 9, -41},	-- "T_DE/BUFF_BAR"
	},
}
local K, C, L, _ = select(2, ...):unpack()
if C["tooltip"].enable ~= true or C["tooltip"].unit_role ~= true then return end

-- Displays a players LFD role(gTooltipRoles by g0st)
local function GetLFDRole(unit)
	local role = UnitGroupRolesAssigned(unit)

	if role == "NONE" then
		return "|cFFB5B5B5"..NO_ROLE.."|r"
	elseif role == "TANK" then
		return "|cFF0070DE"..TANK.."|r"
	elseif role == "HEALER" then
		return "|cFF00CC12"..HEALER.."|r"
	else
		return "|cFFFF3030"..DAMAGER.."|r"
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local _, instanceType = IsInInstance()
	local _, unit = GameTooltip:GetUnit()
	if unit and UnitIsPlayer(unit) and ((UnitInParty(unit) or UnitInRaid(unit)) and GetNumPartyMembers() > 0) then
		GameTooltip:AddLine(ROLE..": "..GetLFDRole(unit))
	end
end)
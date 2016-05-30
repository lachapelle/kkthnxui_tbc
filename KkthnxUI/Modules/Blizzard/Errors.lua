local K, C, L, _ = select(2, ...):unpack()
if C["error"].enable ~= true then return end

local KkthnxUIError = CreateFrame("Frame")

-- Set messages to allow
KkthnxUIError.Filter = {
	[ERR_INV_FULL] = true,
	[ERR_ITEM_MAX_COUNT] = true,
	[ERR_LOOT_MASTER_INV_FULL] = true,
	[ERR_LOOT_MASTER_OTHER] = true,
	[ERR_LOOT_MASTER_UNIQUE_ITEM] = true,
	[ERR_NOT_ENOUGH_MONEY] = true,
	[ERR_QUEST_LOG_FULL] = true
}

function KkthnxUIError:OnEvent(event, msg)
	if self.Filter[msg] then
		UIErrorsFrame:AddMessage(msg, 1, 0, 0)
	end
end

UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
KkthnxUIError:RegisterEvent("UI_ERROR_MESSAGE")
KkthnxUIError:SetScript("OnEvent", KkthnxUIError.OnEvent)
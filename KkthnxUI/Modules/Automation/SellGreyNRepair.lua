local K, C, L, _ = unpack(select(2, ...))
if C["automation"].sellgrey_n_repair ~= true then return end

local format = string.format
local format, strsub = string.format, string.sub
local select = select
local CanGuildBankRepair = CanGuildBankRepair
local CanMerchantRepair = CanMerchantRepair
local CreateFrame = CreateFrame
local GetContainerItemLink, GetContainerNumSlots = GetContainerItemLink, GetContainerNumSlots
local GetGuildBankWithdrawMoney = GetGuildBankWithdrawMoney
local GetItemInfo, GetItemCount = GetItemInfo, GetItemCount
local GetMoney = GetMoney
local GetNumPartyMembers = GetNumPartyMembers
local GetRepairAllCost = GetRepairAllCost
local RepairAllItems = RepairAllItems
local UseContainerItem = UseContainerItem

-- Auto repair and sell grey item
local itemCount, sellValue = 0, 0

local SellnRepair = CreateFrame("frame")
SellnRepair:RegisterEvent("MERCHANT_SHOW")
SellnRepair:SetScript("OnEvent", function(self, event)
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local item = GetContainerItemLink(bag, slot)
			if item then
				local itemValue = select(11, GetItemInfo(item)) * GetItemCount(item)

				if select(3, GetItemInfo(item)) == 0 then
					ShowMerchantSellCursor(1)
					UseContainerItem(bag, slot)

					itemCount = itemCount + GetItemCount(item)
					sellValue = sellValue + itemValue
				end
			end
		end
	end

	if sellValue > 0 then
		K.Print(format("Sold %d trash item%s for %s", itemCount, itemCount ~= 1 and "s" or "", K.FormatMoney(sellValue)))
		itemCount, sellValue = 0, 0
	end

	if CanMerchantRepair() then
		local cost, needed = GetRepairAllCost()
		if needed then
			local GuildWealth = CanGuildBankRepair() and GetGuildBankWithdrawMoney() > cost
			if GuildWealth and GetNumPartyMembers() > 5 then
				RepairAllItems(1)
				K.Print(format("Guild bank repaired for %s.", K.FormatMoney(cost)))
			elseif cost < GetMoney() then
				RepairAllItems()
				K.Print(format("Repaired for %s.", K.FormatMoney(cost)))
			else
				K.Print("Repairs were unaffordable.")
			end
		end
	end
end)
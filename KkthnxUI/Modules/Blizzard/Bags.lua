local K, C, L, _ = select(2, ...):unpack()
if C["bag"].enable ~= true then return end

local match = string.match
local tonumber = tonumber
local select = select
local ipairs = ipairs
local floor = math.floor
local setmetatable = setmetatable
local collectgarbage = collectgarbage
local GetCoinTextureString = GetCoinTextureString
local CreateFrame, UIParent = CreateFrame, UIParent
local GetContainerItemCooldown = GetContainerItemCooldown
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetName = GetName
local GetContainerNumFreeSlots = GetContainerNumFreeSlots

--[[
A featureless, 'pure' version of Stuffing.
This version should work on absolutely everything,
but I've removed pretty much all of the options.

All credits of this bags script is by Stuffing and his author Hungtar.
--]]

local BAGS_BACKPACK = {0, 1, 2, 3, 4}
local BAGS_BANK = {-1, 5, 6, 7, 8, 9, 10, 11}
local ST_NORMAL = 1
local ST_SOULBAG = 2
local ST_SPECIAL = 3
local ST_QUIVER = 4
local bag_bars = 0
local hide_soulbag = 0
local quest_glow = 1

-- Hide bags options in default interface
InterfaceOptionsDisplayPanelShowFreeBagSpace:Hide()

Stuffing = CreateFrame("Frame", nil, K.UIParent)
Stuffing:RegisterEvent("ADDON_LOADED")
Stuffing:RegisterEvent("PLAYER_ENTERING_WORLD")
Stuffing:SetScript("OnEvent", function(this, event, ...)
	if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") then return end
	Stuffing[event](this, ...)
end)

local function Stuffing_Sort(args)
	if not args then
		args = ""
	end

	Stuffing.itmax = 0
	Stuffing:SetBagsForSorting(args)
	Stuffing:SortBags()
end

local function Stuffing_OnShow()
	Stuffing:PLAYERBANKSLOTS_CHANGED(29)

	for i = 0, #BAGS_BACKPACK - 1 do
		Stuffing:BAG_UPDATE(i)
	end

	Stuffing:Layout()
	Stuffing:SearchReset()
	PlaySound("igBackPackOpen")
	collectgarbage("collect")
end

local function StuffingBank_OnHide()
	CloseBankFrame()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	end
end

local function Stuffing_OnHide()
	if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
		Stuffing.bankFrame:Hide()
	end
end

local function Stuffing_Open()
	if not Stuffing.frame:IsShown() then
		Stuffing.frame:Show()
	end
end

local function Stuffing_Close()
	Stuffing.frame:Hide()
end

local function Stuffing_Toggle()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	else
		Stuffing.frame:Show()
	end
end

local function Stuffing_ToggleBag(id)
	if id == -2 then
		ToggleKeyRing()
		return
	end
	Stuffing_Toggle()
end

-- bag slot stuff
local trashButton = {}
local trashBag = {}

-- for the tooltip frame used to scan item tooltips
local StuffingTT = nil

-- mostly from carg.bags_Aurora
local QUEST_ITEM_STRING = nil

function Stuffing:SlotUpdate(b)
	local texture, count, locked = GetContainerItemInfo(b.bag, b.slot)
	local clink = GetContainerItemLink(b.bag, b.slot)

	if b.cooldown and StuffingFrameBags and StuffingFrameBags:IsShown() then
		local start, duration, enable = GetContainerItemCooldown(b.bag, b.slot)
		CooldownFrame_SetTimer(b.cooldown, start, duration, enable)
	end

	if(clink) then
		local iType
		b.name, _, b.rarity, _, _, iType = GetItemInfo(clink)

		if QUEST_ITEM_STRING == nil then
			-- GetItemInfo returns a localized item type.
			-- this is to figure out what that string is.
			local t = {GetAuctionItemClasses()}
			QUEST_ITEM_STRING = t[#t]	-- #t == 12
		end

		if iType and iType == QUEST_ITEM_STRING then
			--K.Print(iType .. " " .. b.name)
			b.qitem = true
		else
			b.qitem = nil
		end

	else
		b.name, b.rarity, b.qitem = nil, nil, nil
	end

	SetItemButtonTexture(b.frame, texture)
	SetItemButtonCount(b.frame, count)
	SetItemButtonDesaturated(b.frame, locked)

	if b.Glow then
		b.Glow:Hide()
		if b.rarity then
			if b.rarity > 1 then
				b.Glow:SetVertexColor(GetItemQualityColor(b.rarity))
				b.Glow:Show()
			elseif b.qitem and quest_glow == 1 then
				b.Glow:SetVertexColor(1, 1, 0)
				b.Glow:Show()
			end
		end
	end

	b.frame:Show()
end

function Stuffing:BagSlotUpdate(bag)
	if not self.buttons then
		return
	end

	for _, v in ipairs(self.buttons) do
		if v.bag == bag then
			self:SlotUpdate(v)
		end
	end
end

function Stuffing:BagFrameSlotNew(slot, p)
	for _, v in ipairs(self.bagframe_buttons) do
		if v.slot == slot then
			return v, false
		end
	end

	local ret = {}

	if slot > 3 then
		ret.slot = slot
		slot = slot - 4
		ret.frame = CreateFrame("CheckButton", "StuffingBBag"..slot, p, "BankItemButtonBagTemplate")
		ret.frame:SetID(slot)
		table.insert(self.bagframe_buttons, ret)

		BankFrameItemButton_Update(ret.frame)
		BankFrameItemButton_UpdateLocked(ret.frame)

		if not ret.frame.tooltipText then
			ret.frame.tooltipText = ""
		end
	else
		ret.frame = CreateFrame("CheckButton", "StuffingFBag"..slot.."Slot", p, "BagSlotButtonTemplate")
		ret.slot = slot
		table.insert(self.bagframe_buttons, ret)
	end

	return ret
end

function Stuffing:SlotNew(bag, slot)
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			v.lock = false
			return v, false
		end
	end

	local tpl = "ContainerFrameItemButtonTemplate"

	if bag == -1 then
		tpl = "BankItemButtonGenericTemplate"
	end

	local ret = {}

	if #trashButton > 0 then
		local f = -1
		for i, v in ipairs(trashButton) do
			local b, s = v:GetName():match("(%d+)_(%d+)")

			b = tonumber(b)
			s = tonumber(s)

			if b == bag and s == slot then
				f = i
				break
			else
				v:Hide()
			end
		end

		if f ~= -1 then
			ret.frame = trashButton[f]
			table.remove(trashButton, f)
			ret.frame:Show()
		end
	end

	if not ret.frame then
		ret.frame = CreateFrame("Button", "StuffingBag"..bag.."_"..slot, self.bags[bag], tpl)

		local c = _G[ret.frame:GetName().."Count"]
		c:SetFont(C["font"].bags_font, C["font"].bags_font_size, C["font"].bags_font_style)
		c:SetShadowOffset(K.mult, -K.mult)
		c:SetPoint("BOTTOMRIGHT", 1, 1)
	end

	if 1 == 1 and not ret.Glow then
		-- from carg.bags_Aurora
		local glow = ret.frame:CreateTexture(nil, "OVERLAY")
		glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
		glow:SetBlendMode("ADD")
		glow:SetAlpha(.8)
		glow:SetPoint("CENTER", ret.frame)
		ret.Glow = glow
	end

	ret.bag = bag
	ret.slot = slot
	ret.frame:SetID(slot)

	ret.cooldown = _G[ret.frame:GetName().."Cooldown"]
	ret.cooldown:Show()

	self:SlotUpdate(ret)

	return ret, true
end

-- from OneBag
local BAGTYPE_QUIVER = 0x0001 + 0x0002
local BAGTYPE_SOUL = 0x004
local BAGTYPE_PROFESSION = 0x0008 + 0x0010 + 0x0020 + 0x0040 + 0x0080 + 0x0200 + 0x0400

function Stuffing:BagType(bag)
	local bagType = select(2, GetContainerNumFreeSlots(bag))

	if bit.band(bagType, BAGTYPE_QUIVER) > 0 then
		return ST_QUIVER
	elseif bit.band(bagType, BAGTYPE_SOUL) > 0 then
		return ST_SOULBAG
	elseif bit.band(bagType, BAGTYPE_PROFESSION) > 0 then
		return ST_SPECIAL
	end

	return ST_NORMAL
end

function Stuffing:BagNew(bag, f)
	for i, v in pairs(self.bags) do
		if v:GetID() == bag then
			v.bagType = self:BagType(bag)
			return v
		end
	end

	local ret

	if #trashBag > 0 then
		local f = -1
		for i, v in pairs(trashBag) do
			if v:GetID() == bag then
				f = i
				break
			end
		end

		if f ~= -1 then
			--K.Print("found bag " .. bag)
			ret = trashBag[f]
			table.remove(trashBag, f)
			ret:Show()
			ret.bagType = self:BagType(bag)
			return ret
		end
	end

	--K.Print("new bag " .. bag)
	ret = CreateFrame("Frame", "StuffingBag" .. bag, f)
	ret.bagType = self:BagType(bag)

	ret:SetID(bag)
	return ret
end

function Stuffing:SearchUpdate(str)
	str = string.lower(str)

	for _, b in ipairs(self.buttons) do
		if b.name then
			if not string.find(string.lower(b.name), str) then
				SetItemButtonDesaturated(b.frame, true)
				if b.Glow then
					b.Glow:Hide()
				end
			else
				SetItemButtonDesaturated(b.frame, false)
				if b.Glow then
					b.Glow:Show()
					b.Glow:SetVertexColor(0.8, 0.8, 0.3)
				end
			end
		end
	end
end

function Stuffing:SearchReset()
	for _, b in ipairs(self.buttons) do
		SetItemButtonDesaturated(b.frame, false)
		if b.Glow then
			b.Glow:Hide()
			if b.rarity then
				if b.rarity > 1 then
					b.Glow:SetVertexColor(GetItemQualityColor(b.rarity))
					b.Glow:Show()
				elseif b.qitem and quest_glow == 1 then
					b.Glow:SetVertexColor(1, 1, 0)
					b.Glow:Show()
				end
			end
		end
	end
end

-- drop down menu stuff from Postal
local Stuffing_DDMenu = CreateFrame("Frame", "Stuffing_DropDownMenu")
Stuffing_DDMenu.displayMode = "MENU"
Stuffing_DDMenu.info = {}
Stuffing_DDMenu.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == Stuffing_DDMenu then
		CloseDropDownMenus()
	end
end

local function DragFunction(self, mode)
	for index = 1, select("#", self:GetChildren()) do
		local frame = select(index, self:GetChildren())
		if frame:GetName() and frame:GetName():match("StuffingBag") then
			if mode then
				frame:Hide()
			else
				frame:Show()
			end
		end
	end
end

function Stuffing:CreateBagFrame(w)
	local n = "StuffingFrame" .. w
	local f = CreateFrame("Frame", n, K.UIParent)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(5)
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", function(self)
		if IsShiftKeyDown() then
			self:StartMoving()
			DragFunction(self, true)
		end
	end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		DragFunction(self, false)
	end)

	if w == "Bank" then
		f:SetPoint(unpack(C["position"].bank))
	else
		f:SetPoint(unpack(C["position"].bag))
	end

	if w == "Bank" then
		-- Buy button
		f.b_purchase = CreateFrame("Button", "StuffingPurchaseButton"..w, f)
		f.b_purchase:SetSize(80, 20)
		f.b_purchase:SetPoint("TOPLEFT", 10, -4)
		f.b_purchase:RegisterForClicks("AnyUp")
		f.b_purchase:SetScript("OnClick", function(self) StaticPopup_Show("CONFIRM_BUY_BANK_SLOT") end)
		f.b_purchase:FontString("text", C["font"].bags_font, C["font"].bags_font_size, C["font"].bags_font_style)
		f.b_purchase.text:SetPoint("CENTER")
		f.b_purchase.text:SetText("|cff2eb6ff"..BANKSLOTPURCHASE.."|r")
		f.b_purchase:SetFontString(f.b_purchase.text)
		local _, full = GetNumBankSlots()
		if full then
			f.b_purchase:Hide()
		else
			f.b_purchase:Show()
		end
	end

	-- close button
	f.b_close = CreateFrame("Button", "Stuffing_CloseButton"..w, f, "UIPanelCloseButton")
	f.b_close:SetSize(32, 32)
	f.b_close:RegisterForClicks("AnyUp")
	f.b_close:SetPoint("TOPRIGHT", -3, -3)
	f.b_close:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(nil, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		end
		self:GetParent():Hide()
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT", 19, 7)
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_CLOSE)
	end

	f.b_close:HookScript("OnEnter", tooltip_show)
	f.b_close:HookScript("OnLeave", tooltip_hide)

	-- create the bags frame
	local fb = CreateFrame("Frame", n.."BagsFrame", f)
	fb:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 3)
	fb:SetFrameStrata("MEDIUM")
	f.bags_frame = fb

	return f
end

function Stuffing:InitBank()
	if self.bankFrame then
		return
	end

	local f = self:CreateBagFrame("Bank")
	f:SetScript("OnHide", StuffingBank_OnHide)
	self.bankFrame = f
end

function Stuffing:InitBags()
	if self.frame then return end

	self.buttons = {}
	self.bags = {}
	self.bagframe_buttons = {}

	local f = self:CreateBagFrame("Bags")
	f:SetScript("OnShow", Stuffing_OnShow)
	f:SetScript("OnHide", Stuffing_OnHide)

	-- search editbox(tekKonfigAboutPanel.lua)
	local editbox = CreateFrame("EditBox", nil, f)
	editbox:Hide()
	editbox:SetAutoFocus(true)
	editbox:SetHeight(32)

	local left = editbox:CreateTexture(nil, "BACKGROUND")
	left:SetSize(8, 20)
	left:SetPoint("LEFT", -5, 0)
	left:SetTexture("Interface\\Common\\Common-Input-Border")
	left:SetTexCoord(0, 0.0625, 0, 0.625)

	local right = editbox:CreateTexture(nil, "BACKGROUND")
	right:SetSize(8, 20)
	right:SetPoint("RIGHT", 0, 0)
	right:SetTexture("Interface\\Common\\Common-Input-Border")
	right:SetTexCoord(0.9375, 1, 0, 0.625)

	local center = editbox:CreateTexture(nil, "BACKGROUND")
	center:SetHeight(20)
	center:SetPoint("RIGHT", right, "LEFT", 0, 0)
	center:SetPoint("LEFT", left, "RIGHT", 0, 0)
	center:SetTexture("Interface\\Common\\Common-Input-Border")
	center:SetTexCoord(0.0625, 0.9375, 0, 0.625)

	local resetAndClear = function(self)
		self:GetParent().detail:Show()
		self:GetParent().gold:Show()
		self:ClearFocus()
		Stuffing:SearchReset()
	end

	local updateSearch = function(self, t)
		if t == true then
			Stuffing:SearchUpdate(self:GetText())
		end
	end

	editbox:SetScript("OnEscapePressed", resetAndClear)
	editbox:SetScript("OnEnterPressed", resetAndClear)
	editbox:SetScript("OnEditFocusLost", editbox.Hide)
	editbox:SetScript("OnEditFocusGained", editbox.HighlightText)
	editbox:SetScript("OnTextChanged", updateSearch)
	editbox:SetText(SEARCH)

	local detail = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	detail:SetPoint("TOPLEFT", f, 11, -10)
	detail:SetPoint("RIGHT", f, -140, -10)
	detail:SetHeight(13)
	detail:SetJustifyH("LEFT")
	detail:SetText("|cff2eb6ff"..SEARCH.."|r")
	editbox:SetAllPoints(detail)

	local gold = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	gold:SetJustifyH("RIGHT")
	gold:SetPoint("RIGHT", f.b_close, "LEFT", -10, 0)

	f:SetScript("OnEvent", function(self)
		self.gold:SetText(K.FormatMoney(GetMoney()))
	end)
	f:RegisterEvent("PLAYER_MONEY")
	f:RegisterEvent("PLAYER_LOGIN")
	f:RegisterEvent("PLAYER_TRADE_MONEY")
	f:RegisterEvent("TRADE_MONEY_CHANGED")

	local OpenEditbox = function(self)
		self:GetParent().detail:Hide()
		self:GetParent().gold:Hide()
		self:GetParent().editbox:Show()
		self:GetParent().editbox:HighlightText()
	end

	local button = CreateFrame("Button", nil, f)
	button:EnableMouse(1)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetAllPoints(detail)
	button:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			OpenEditbox(self)
		else
			if self:GetParent().editbox:IsShown() then
				self:GetParent().editbox:Hide()
				self:GetParent().editbox:ClearFocus()
				self:GetParent().detail:Show()
				self:GetParent().gold:Show()
				Stuffing:SearchReset()
			end
		end
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -12, 11)
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_SEARCH)
	end

	button:SetScript("OnEnter", tooltip_show)
	button:SetScript("OnLeave", tooltip_hide)

	f.editbox = editbox
	f.detail = detail
	f.button = button
	f.gold = gold
	self.frame = f
	f:Hide()
end

function Stuffing:Layout(lb)
	local slots = 0
	local rows = 0
	local off = 26
	local cols, f, bs

	if lb then
		bs = BAGS_BANK
		cols = C["bag"].bank_columns
		f = self.bankFrame
		f:SetAlpha(1)
	else
		bs = BAGS_BACKPACK
		cols = C["bag"].bag_columns
		f = self.frame

		f.gold:SetText(K.FormatMoney(GetMoney(), C["font"].bags_font_size))
		f.editbox:SetFont(C["font"].bags_font, C["font"].bags_font_size, C["font"].bags_font_style)
		f.detail:SetFont(C["font"].bags_font, C["font"].bags_font_size, C["font"].bags_font_style)
		f.gold:SetFont(C["font"].bags_font, C["font"].bags_font_size, C["font"].bags_font_style)

		f.detail:ClearAllPoints()
		f.detail:SetPoint("TOPLEFT", f, 12, -8)
		f.detail:SetPoint("RIGHT", f, -140, 0)
	end

	f:SetClampedToScreen(1)
	f:SetBackdrop(K.Backdrop)
	f:SetBackdropColor(unpack(C["media"].backdrop_color))
	f:SetBackdropBorderColor(unpack(C["media"].border_color))

	-- bag frame stuff
	local fb = f.bags_frame
	if bag_bars == 1 then
		fb:SetClampedToScreen(1)
		fb:SetBackdrop(K.Backdrop)
		fb:SetBackdropColor(unpack(C["media"].backdrop_color))
		fb:SetBackdropBorderColor(unpack(C["media"].border_color))

		local bsize = C["bag"].button_size

		local w = 2 * 10
		w = w +((#bs - 1) * bsize)
		w = w +((#bs - 2) * 4)

		fb:SetHeight(2 * 10 + bsize)
		fb:SetWidth(w)
		fb:Show()
	else
		fb:Hide()
	end

	local idx = 0
	for _, v in ipairs(bs) do
		if(not lb and v <= 3 ) or(lb and v ~= -1) then
			local bsize = C["bag"].button_size
			local b = self:BagFrameSlotNew(v, fb)
			local xoff = 10

			xoff = xoff +(idx * bsize) -- 31)
			xoff = xoff +(idx * 4)

			b.frame:ClearAllPoints()
			b.frame:SetPoint("LEFT", fb, "LEFT", xoff, 0)
			b.frame:SetSize(bsize, bsize)

			-- Lets see what bag we are hovering over.
			local btns = self.buttons
			b.frame:HookScript("OnEnter", function(self)
				local bag
				if isBank then bag = v else bag = v + 1 end

				for ind, val in ipairs(btns) do
					if val.bag == bag then
						val.frame:SetAlpha(1)
					else
						val.frame:SetAlpha(0.2)
					end
				end
			end)

			b.frame:HookScript("OnLeave", function(self)
				for _, btn in ipairs(btns) do
					btn.frame:SetAlpha(1)
				end
			end)

			b.frame:SetScript("OnClick", nil)

			idx = idx + 1
		end
	end

	for _, i in ipairs(bs) do
		local x = GetContainerNumSlots(i)
		if x > 0 then
			if not self.bags[i] then
				self.bags[i] = self:BagNew(i, f)
			end

			if not(hide_soulbag == 1 and self.bags[i].bagType == ST_SOULBAG) then
				slots = slots + GetContainerNumSlots(i)
			end
		end
	end

	rows = floor(slots / cols)
	if(slots % cols) ~= 0 then
		rows = rows + 1
	end

	f:SetWidth(cols * C["bag"].button_size +(cols - 1) * C["bag"].button_space + 10 * 2)
	f:SetHeight(rows * C["bag"].button_size +(rows - 1) * C["bag"].button_space + off + 10 * 2)

	local idx = 0
	for _, i in ipairs(bs) do
		local bag_cnt = GetContainerNumSlots(i)
		local specialType = select(2, GetContainerNumFreeSlots(i))
		if bag_cnt > 0 then
			self.bags[i] = self:BagNew(i, f)
			local bagType = self.bags[i].bagType

			if not(hide_soulbag == 1 and bagType == ST_SOULBAG) then
				self.bags[i]:Show()
				--K.Print(i .. ": " .. GetContainerNumSlots(i) .. " slots.")
				for j = 1, bag_cnt do
					local b, isnew = self:SlotNew(i, j)
					local xoff
					local yoff
					local x =(idx % cols)
					local y = floor(idx / cols)

					if isnew then
						table.insert(self.buttons, idx + 1, b)
					end

					xoff = 10 +(x * C["bag"].button_size) +(x * C["bag"].button_space)
					yoff = off + 10 +(y * C["bag"].button_size) +((y - 1) * C["bag"].button_space)
					yoff = yoff * -1

					b.frame:ClearAllPoints()
					b.frame:SetPoint("TOPLEFT", f, "TOPLEFT", xoff, yoff)
					b.frame:SetSize(C["bag"].button_size, C["bag"].button_size)
					b.frame.lock = false
					b.frame:SetAlpha(1)

					local normalTex = _G[b.frame:GetName() .. "NormalTexture"]
					normalTex:SetSize(C["bag"].button_size / 37 * 64, C["bag"].button_size / 37 * 64)
					b.normalTex = normalTex

					if bagType == ST_QUIVER then
						normalTex:SetVertexColor(0.8, 0.8, 0.2)
					elseif bagType == ST_SOULBAG then
						normalTex:SetVertexColor(0.8, 0.2, 0.2)
					elseif bagType == ST_NORMAL then
						normalTex:SetVertexColor(unpack(C["media"].border_color))
					elseif bagType == ST_SPECIAL then
						if specialType == 0x0008 then -- Leatherworking
							normalTex:SetVertexColor(0.8, 0.7, 0.3)
						elseif specialType == 0x0010 then -- Inscription
							normalTex:SetVertexColor(0.3, 0.3, 0.8)
						elseif specialType == 0x0020 then -- Herbs
							normalTex:SetVertexColor(0.3, 0.7, 0.3)
						elseif specialType == 0x0040 then -- Enchanting
							normalTex:SetVertexColor(0.6, 0, 0.6)
						elseif specialType == 0x0080 then -- Engineering
							normalTex:SetVertexColor(0.9, 0.4, 0.1)
						elseif specialType == 0x0200 then -- Gems
							normalTex:SetVertexColor(0, 0.7, 0.8)
						elseif specialType == 0x0400 then -- Mining
							normalTex:SetVertexColor(0.4, 0.3, 0.1)
						end
						b.frame.lock = true
					end

					local iconTex = _G[b.frame:GetName() .. "IconTexture"]

					iconTex:Show()
					b.iconTex = iconTex

					if b.Glow then
						b.Glow:SetSize(C["bag"].button_size / 37 * 64, C["bag"].button_size / 37 * 64)
					end

					idx = idx + 1
				end
			end
		end
	end
end

function Stuffing:SetBagsForSorting(c)
	Stuffing_Open()

	self.sortBags = {}

	local cmd =((c == nil or c == "") and {"d"} or {strsplit("/", c)})

	for _, s in ipairs(cmd) do
		if s == "c" then
			self.sortBags = {}
		elseif s == "d" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(BAGS_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			else
				for _, i in ipairs(BAGS_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		elseif s == "p" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(BAGS_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			else
				for _, i in ipairs(BAGS_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		else
			table.insert(self.sortBags, tonumber(s))
		end
	end

	local bids = L_BAG_BAGS_BIDS
	for _, i in ipairs(self.sortBags) do
		bids = bids .. i .. " "
	end

	K.Print(bids)
end

function Stuffing:ADDON_LOADED(addon)
	if addon ~= "KkthnxUI" then return nil end

	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("GUILDBANKFRAME_OPENED")
	self:RegisterEvent("GUILDBANKFRAME_CLOSED")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	self:RegisterEvent("BAG_CLOSED")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN")

	self:InitBags()

	tinsert(UISpecialFrames, "StuffingFrameBags")

	-- hook functions
	ToggleBackpack = Stuffing_Toggle
	ToggleBag = Stuffing_Toggle
	ToggleAllBags = Stuffing_Toggle
	OpenAllBags = Stuffing_Open
	OpenBackpack = Stuffing_Open
	CloseAllBags = Stuffing_Close
	CloseBackpack = Stuffing_Close

	--BankFrame:UnregisterAllEvents()
	BankFrame:SetScale(0.00001)
	BankFrame:SetAlpha(0)
	BankFrame:SetPoint("TOPLEFT")
end

function Stuffing:PLAYER_ENTERING_WORLD()
	Stuffing:UnregisterEvent("PLAYER_ENTERING_WORLD")
	ToggleBackpack()
	ToggleBackpack()
end

function Stuffing:PLAYERBANKSLOTS_CHANGED(id)
	if id > 28 then
		for _, v in ipairs(self.bagframe_buttons) do
			if v.frame and v.frame.GetInventorySlot then

				BankFrameItemButton_Update(v.frame)
				BankFrameItemButton_UpdateLocked(v.frame)

				if not v.frame.tooltipText then
					v.frame.tooltipText = ""
				end
			end
		end
	end

	if self.bankFrame and self.bankFrame:IsShown() then
		self:BagSlotUpdate(-1)
	end
end

function Stuffing:BAG_UPDATE(id)
	self:BagSlotUpdate(id)
end

function Stuffing:ITEM_LOCK_CHANGED(bag, slot)
	if slot == nil then return end
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			self:SlotUpdate(v)
			break
		end
	end
end

function Stuffing:BANKFRAME_OPENED()
	if not self.bankFrame then
		self:InitBank()
	end

	self:Layout(true)
	for _, x in ipairs(BAGS_BANK) do
		self:BagSlotUpdate(x)
	end

	self.bankFrame:Show()
	Stuffing_Open()
end

function Stuffing:BANKFRAME_CLOSED()
	if StuffingFrameBank then
		StuffingFrameBank:Hide()
	end
	if self.bankFrame then
		self.bankFrame:Hide()
	end
end

function Stuffing:GUILDBANKFRAME_OPENED()
	Stuffing_Open()
end

function Stuffing:GUILDBANKFRAME_CLOSED()
	Stuffing_Close()
end

function Stuffing:BAG_CLOSED(id)
	local b = self.bags[id]
	if b then
		table.remove(self.bags, id)
		b:Hide()
		table.insert(trashBag, #trashBag + 1, b)
	end

	while true do
		local changed = false

		for i, v in ipairs(self.buttons) do
			if v.bag == id then
				v.frame:Hide()
				v.normalTex:Hide()
				v.iconTex:Hide()

				if v.Glow then
					v.Glow:Hide()
				end

				table.insert(trashButton, #trashButton + 1, v.frame)
				table.remove(self.buttons, i)

				v = nil
				changed = true
			end
		end

		if not changed then
			break
		end
	end
end

function Stuffing:SortOnUpdate(e)
	if not self.elapsed then
		self.elapsed = 0
	end

	if not self.itmax then
		self.itmax = 0
	end

	self.elapsed = self.elapsed + e

	if self.elapsed < 0.1 then
		return
	end

	self.elapsed = 0
	self.itmax = self.itmax + 1

	local changed, blocked = false, false

	if self.sortList == nil or next(self.sortList, nil) == nil then
		-- wait for all item locks to be released.
		local locks = false

		for i, v in pairs(self.buttons) do
			local _, _, l = GetContainerItemInfo(v.bag, v.slot)
			if l then
				locks = true
			else
				v.block = false
			end
		end

		if locks then
			-- something still locked. wait some more.
			return
		else
			-- all unlocked. get a new table.
			self:SetScript("OnUpdate", nil)
			self:SortBags()

			if self.sortList == nil then
				return
			end
		end
	end

	-- go through the list and move stuff if we can.
	for i, v in ipairs(self.sortList) do
		repeat
			if v.ignore then
				blocked = true
				break
			end

			if v.srcSlot.block then
				changed = true
				break
			end

			if v.dstSlot.block then
				changed = true
				break
			end

			local _, _, l1 = GetContainerItemInfo(v.dstSlot.bag, v.dstSlot.slot)
			local _, _, l2 = GetContainerItemInfo(v.srcSlot.bag, v.srcSlot.slot)

			if l1 then
				v.dstSlot.block = true
			end

			if l2 then
				v.srcSlot.block = true
			end

			if l1 or l2 then
				break
			end

			if v.sbag ~= v.dbag or v.sslot ~= v.dslot then
				if v.srcSlot.name ~= v.dstSlot.name then
					v.srcSlot.block = true
					v.dstSlot.block = true
					PickupContainerItem(v.sbag, v.sslot)
					PickupContainerItem(v.dbag, v.dslot)
					changed = true
					break
				end
			end
		until true
	end

	self.sortList = nil

	if(not changed and not blocked) or self.itmax > 250 then
		self:SetScript("OnUpdate", nil)
		self.sortList = nil
		K.Print(L_BAG_SORTING_BAGS)
	end
end

function Stuffing:BAG_UPDATE_COOLDOWN()
	for i, v in pairs(self.buttons) do
		self:SlotUpdate(v)
	end
end

local function InBags(x)
	if not Stuffing.bags[x] then
		return false
	end

	for _, v in ipairs(Stuffing.sortBags) do
		if x == v then
			return true
		end
	end
	return false
end

function Stuffing:SortBags()
	local bs = self.sortBags
	if #bs < 1 then
		K.Print(L_BAG_NOTHING_SORT)
		return
	end

	local st = {}
	local bank = false

	Stuffing_Open()

	for i, v in pairs(self.buttons) do
		if InBags(v.bag) then
			self:SlotUpdate(v)

			if v.name then
				local tex, cnt, _, _, _, _, clink = GetContainerItemInfo(v.bag, v.slot)
				local n, _, q, iL, rL, c1, c2, _, Sl = GetItemInfo(clink)
				table.insert(st, {srcSlot = v, sslot = v.slot, sbag = v.bag, sort = q..c1..c2..rL..n..iL..Sl..(#self.buttons - i)})
			end
		end
	end

	-- sort them
	table.sort(st, function(a, b)
		return a.sort > b.sort
	end)

	-- for each button we want to sort, get a destination button
	local st_idx = 1
	local dbag = bs[st_idx]
	local dslot = 1
	local max_dslot = GetContainerNumSlots(dbag)

	for i, v in ipairs(st) do
		v.dbag = dbag
		v.dslot = dslot
		v.dstSlot = self:SlotNew(dbag, dslot)

		dslot = dslot + 1

		if dslot > max_dslot then
			dslot = 1

			while true do
				st_idx = st_idx + 1

				if st_idx > #bs then
					break
				end

				dbag = bs[st_idx]

				if Stuffing:BagType(dbag) == ST_NORMAL or Stuffing:BagType(dbag) == ST_SPECIAL or dbag > 4 then
					break
				end
			end

			max_dslot = GetContainerNumSlots(dbag)
		end
	end

	-- throw various stuff out of the search list
	local changed = true
	while changed do
		changed = false
		-- XXX why doesn't this remove all x->x moves in one pass?

		for i, v in ipairs(st) do

			-- source is same as destination
			if(v.sslot == v.dslot) and(v.sbag == v.dbag) then
				table.remove(st, i)
				changed = true
			end
		end
	end

	-- kick off moving of stuff, if needed.
	if st == nil or next(st, nil) == nil then
		K.Print(L_BAG_SORTING_BAGS)
		self:SetScript("OnUpdate", nil)
	else
		self.sortList = st
		self:SetScript("OnUpdate", Stuffing.SortOnUpdate)
	end
end

function Stuffing:RestackOnUpdate(e)
	if not self.elapsed then
		self.elapsed = 0
	end

	self.elapsed = self.elapsed + e

	if self.elapsed < 0.1 then
		return
	end

	self.elapsed = 0
	self:Restack()
end

function Stuffing:Restack()
	local st = {}

	Stuffing_Open()

	for i, v in pairs(self.buttons) do
		if InBags(v.bag) then
			local tex, cnt, _, _, _, _, clink = GetContainerItemInfo(v.bag, v.slot)
			if clink then
				local n, _, _, _, _, _, _, s = GetItemInfo(clink)

				if cnt ~= s then
					if not st[n] then
							st[n] = {{
								item = v,
								size = cnt,
								max = s
						}}
					else
						table.insert(st[n], {
							item = v,
							size = cnt,
							max = s
						})
					end
				end
			end
		end
	end

	local did_restack = false

	for i, v in pairs(st) do
		if #v > 1 then
			for j = 2, #v, 2 do
				local a, b = v[j - 1], v[j]
				local _, _, l1 = GetContainerItemInfo(a.item.bag, a.item.slot)
				local _, _, l2 = GetContainerItemInfo(b.item.bag, b.item.slot)

				if l1 or l2 then
					did_restack = true
				else
					PickupContainerItem(a.item.bag, a.item.slot)
					PickupContainerItem(b.item.bag, b.item.slot)
					did_restack = true
				end
			end
		end
	end

	if did_restack then
		self:SetScript("OnUpdate", Stuffing.RestackOnUpdate)
	else
		self:SetScript("OnUpdate", nil)
		K.Print(L_BAG_STACK_END)
	end
end

function Stuffing:PLAYERBANKBAGSLOTS_CHANGED()
	if not StuffingPurchaseButtonBank then return end
	local _, full = GetNumBankSlots()
	if full then
		StuffingPurchaseButtonBank:Hide()
	else
		StuffingPurchaseButtonBank:Show()
	end
end

function Stuffing.Menu(self, level)
	if not level then
		return
	end

	local info = self.info

	wipe(info)

	if level ~= 1 then
		return
	end

	wipe(info)
	info.text = L_BAG_SORT_MENU
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			K.Print("|cffffe02e"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing_Sort("d")
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_SORT_SPECIAL
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			K.Print("|cffffe02e"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing_Sort("c/p")
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_STACK_MENU
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			K.Print("|cffffe02e"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing:SetBagsForSorting("d")
		Stuffing:Restack()
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_STACK_SPECIAL
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			K.Print("|cffffe02e"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing:SetBagsForSorting("c/p")
		Stuffing:Restack()
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_SHOW_BAGS
	info.checked = function()
		return bag_bars == 1
	end

	info.func = function()
		if bag_bars == 1 then
			bag_bars = 0
		else
			bag_bars = 1
		end
		Stuffing:Layout()
		if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
			Stuffing:Layout(true)
		end

	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.disabled = nil
	info.notCheckable = 1
	info.text = CLOSE
	info.func = self.HideMenu
	info.tooltipTitle = CLOSE
	UIDropDownMenu_AddButton(info, level)
end

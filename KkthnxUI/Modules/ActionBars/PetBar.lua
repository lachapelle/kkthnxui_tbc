local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true then return end

local _G = _G
local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame
local UIParent = UIParent

--	Setup PetActionBar by Tukz
-- Hide bar
if C["actionbar"].petbar_hide then PetActionBarAnchor:Hide() return end

-- Create bar
local bar = CreateFrame("Frame", "PetHolder", K.UIParent, "SecureHandlerStateTemplate")
bar:SetAllPoints(PetActionBarAnchor)
bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_CONTROL_LOST")
bar:RegisterEvent("PLAYER_CONTROL_GAINED")
bar:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
bar:RegisterEvent("PET_BAR_UPDATE")
bar:RegisterEvent("PET_BAR_UPDATE_USABLE")
bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
bar:RegisterEvent("PET_BAR_HIDE")
bar:RegisterEvent("UNIT_PET")
bar:RegisterEvent("UNIT_FLAGS")
bar:RegisterEvent("UNIT_AURA")
bar:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_LOGIN" then
		K.StylePet()
		PetActionBar_ShowGrid = K.dummy
		PetActionBar_HideGrid = K.dummy
		PetActionBarFrame.showgrid = nil
		for i = 1, 10 do
			local button = _G["PetActionButton"..i]
			button:ClearAllPoints()
			button:SetParent(PetHolder)
			button:SetSize(C["actionbar"].button_size, C["actionbar"].button_size)
			if i == 1 then
				if C["actionbar"].petbar_horizontal == true then
					button:SetPoint("BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", 0, 0)
				end
			else
				if C["actionbar"].petbar_horizontal == true then
					button:SetPoint("LEFT", _G["PetActionButton"..i-1], "RIGHT", C["actionbar"].button_space, 0)
				else
					button:SetPoint("TOP", _G["PetActionButton"..i-1], "BOTTOM", 0, -C["actionbar"].button_space)
				end
			end
			button:Show()
			self:SetAttribute("addchild", button)
		end
		RegisterStateDriver(self, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")
		hooksecurefunc("PetActionBar_Update", K.PetBarUpdate)
	elseif event == "PET_BAR_UPDATE" or event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED"
	or event == "UNIT_FLAGS" or (event == "UNIT_PET" and arg1 == "player") or (arg1 == "pet" and event == "UNIT_AURA") then
		K.PetBarUpdate()
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		PetActionBar_UpdateCooldowns()
	end
end)
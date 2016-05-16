local K, C, L, _ = select(2, ...):unpack()

local UIFrameFadeIn, UIFrameFadeOut = UIFrameFadeIn, UIFrameFadeOut
local UIParent = UIParent
local hooksecurefunc = hooksecurefunc

-- Fade in/out world when GameMenu is opened
if C["misc"].fadegamemenu == true then
	local GMFade = UIParent:CreateTexture(nil, 'ARTWORK')
	GMFade:SetAllPoints(UIParent)
	GMFade:SetTexture(0, 0, 0)
	GMFade:Hide()

	hooksecurefunc(GameMenuFrame, 'Show', function()
		GMFade:SetAlpha(0)
		securecall('UIFrameFadeIn', GMFade, 0.235, GMFade:GetAlpha(), 0.7)
	end)

	hooksecurefunc(GameMenuFrame, 'Hide', function()
		securecall('UIFrameFadeOut', GMFade, 0.235, GMFade:GetAlpha(), 0)
	end)
end
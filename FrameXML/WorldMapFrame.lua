local _, private = ...

-- [[ Lua Globals ]]
local select, pairs, tinsert = _G.select, _G.pairs, _G.tinsert

-- [[ Core ]]
local F, C = _G.unpack(private.Aurora)

_G.tinsert(C.themes["Aurora"], function()
	local r, g, b = C.r, C.g, C.b

	local WorldMapFrame = _G.WorldMapFrame
	local BorderFrame = WorldMapFrame.BorderFrame

	WorldMapFrame.UIElementsFrame.CloseQuestPanelButton:GetRegions():Hide()
	WorldMapFrame.UIElementsFrame.OpenQuestPanelButton:GetRegions():Hide()
	BorderFrame.Bg:Hide()
	select(2, BorderFrame:GetRegions()):Hide()
	BorderFrame.portrait:SetTexture("")
	BorderFrame.portraitFrame:SetTexture("")
	for i = 5, 7 do
		select(i, BorderFrame:GetRegions()):SetAlpha(0)
	end
	BorderFrame.TopTileStreaks:SetTexture("")
	for i = 10, 14 do
		select(i, BorderFrame:GetRegions()):Hide()
	end
	BorderFrame.ButtonFrameEdge:Hide()
	BorderFrame.InsetBorderTop:Hide()
	BorderFrame.Inset.Bg:Hide()
	BorderFrame.Inset:DisableDrawLayer("BORDER")

	F.SetBD(BorderFrame, 1, 0, -3, 2)
	F.ReskinClose(BorderFrame.CloseButton)
	F.ReskinArrow(WorldMapFrame.UIElementsFrame.CloseQuestPanelButton, "left")
	F.ReskinArrow(WorldMapFrame.UIElementsFrame.OpenQuestPanelButton, "right")
	F.ReskinDropDown(_G.WorldMapLevelDropDown)
	F.ReskinNavBar(_G.WorldMapFrameNavBar)

	BorderFrame.CloseButton:SetPoint("TOPRIGHT", -9, -6)

	_G.WorldMapLevelDropDown:SetPoint("TOPLEFT", -7, 2)
	_G.WorldMapLevelDropDown.Text:SetPoint("LEFT", 14, 2)
	_G.WorldMapLevelDropDown.Text:SetPoint("RIGHT", -38, 2)

	-- [[ Size up / down buttons ]]

	for _, buttonName in pairs{"WorldMapFrameSizeUpButton", "WorldMapFrameSizeDownButton"} do
		local button = _G[buttonName]

		button:SetSize(17, 17)
		button:ClearAllPoints()
		button:SetPoint("RIGHT", BorderFrame.CloseButton, "LEFT", -1, 0)

		F.Reskin(button)

		local function colourArrow(f)
			if f:IsEnabled() then
				for _, pixel in pairs(f.pixels) do
					pixel:SetColorTexture(r, g, b)
				end
			end
		end

		local function clearArrow(f)
			for _, pixel in pairs(f.pixels) do
				pixel:SetColorTexture(1, 1, 1)
			end
		end

		button.pixels = {}

		local lineOfs = 2.5
		local line = button:CreateLine()
		line:SetColorTexture(1, 1, 1)
		line:SetThickness(0.5)
		line:SetStartPoint("TOPRIGHT", -lineOfs, -lineOfs)
		line:SetEndPoint("BOTTOMLEFT", lineOfs, lineOfs)
		tinsert(button.pixels, line)

		local hline = button:CreateTexture()
		hline:SetColorTexture(1, 1, 1)
		hline:SetSize(7, 1)
		tinsert(button.pixels, hline)

		local vline = button:CreateTexture()
		vline:SetColorTexture(1, 1, 1)
		vline:SetSize(1, 7)
		tinsert(button.pixels, vline)

		if buttonName == "WorldMapFrameSizeUpButton" then
			hline:SetPoint("TOP", 1, -4)
			vline:SetPoint("RIGHT", -4, 1)
		else
			hline:SetPoint("BOTTOM", -1, 4)
			vline:SetPoint("LEFT", 4, -1)
		end

		button:SetScript("OnEnter", colourArrow)
		button:SetScript("OnLeave", clearArrow)
	end

	-- [[ Misc ]]

	_G.WorldMapFrameTutorialButton.Ring:Hide()
	_G.WorldMapFrameTutorialButton:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", -12, 12)

	do
		local topLine = WorldMapFrame.UIElementsFrame:CreateTexture()
		topLine:SetColorTexture(0, 0, 0)
		topLine:SetHeight(1)
		topLine:SetPoint("TOPLEFT", 0, 1)
		topLine:SetPoint("TOPRIGHT", 1, 1)

		local rightLine = WorldMapFrame.UIElementsFrame:CreateTexture()
		rightLine:SetColorTexture(0, 0, 0)
		rightLine:SetWidth(1)
		rightLine:SetPoint("BOTTOMRIGHT", 1, 0)
		rightLine:SetPoint("TOPRIGHT", 1, 1)
	end

	-- [[ Tracking options ]]

	local TrackingOptions = WorldMapFrame.UIElementsFrame.TrackingOptionsButton

	TrackingOptions:GetRegions():Hide()
	TrackingOptions.Background:Hide()
	TrackingOptions.IconOverlay:SetTexture("")
	TrackingOptions.Button.Border:Hide()
end)

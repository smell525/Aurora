local _, private = ...

-- [[ Lua Globals ]]
local next, tinsert = _G.next, _G.tinsert

-- [[ Core ]]
local Aurora = private.Aurora
local Base, Hook, Skin = Aurora.Base, Aurora.Hook, Aurora.Skin

do -- ExpandOrCollapse - BlizzWTF: Not a template, but it should be
    local function Hook_SetNormalTexture(self, texture)
        if self.settingTexture then return end
        self.settingTexture = true
        self:SetNormalTexture("")

        if texture and texture ~= "" then
            if texture:find("Plus") then
                self._auroraBG.plus:Show()
            elseif texture:find("Minus") then
                self._auroraBG.plus:Hide()
            end
            self._auroraBG:Show()
        else
            self._auroraBG:Hide()
        end
        self.settingTexture = nil
    end

    function Skin.ExpandOrCollapse(button)
        button:SetHighlightTexture("")
        button:SetPushedTexture("")

        local bg = _G.CreateFrame("Frame", nil, button)
        bg:SetSize(13, 13)
        bg:SetPoint("TOPLEFT", button:GetNormalTexture(), 0, -2)
        Base.SetBackdrop(bg, private.buttonColor:GetRGBA())
        button._auroraBG = bg

        button._auroraHighlight = {}
        bg.minus = bg:CreateTexture(nil, "OVERLAY")
        bg.minus:SetSize(7, 1)
        bg.minus:SetPoint("CENTER")
        bg.minus:SetColorTexture(1, 1, 1)
        _G.tinsert(button._auroraHighlight, bg.minus)

        bg.plus = bg:CreateTexture(nil, "OVERLAY")
        bg.plus:SetSize(1, 7)
        bg.plus:SetPoint("CENTER")
        bg.plus:SetColorTexture(1, 1, 1)
        _G.tinsert(button._auroraHighlight, bg.plus)

        Base.SetHighlight(button, "color")
        _G.hooksecurefunc(button, "SetNormalTexture", Hook_SetNormalTexture)
    end
end

do --[[ SharedXML\SharedUIPanelTemplates.lua ]]
    function Hook.PanelTemplates_DeselectTab(tab)
        local text = tab.Text or _G[tab:GetName().."Text"]
        text:SetPoint("CENTER", tab, "CENTER")
    end
    function Hook.PanelTemplates_SelectTab(tab)
        local text = tab.Text or _G[tab:GetName().."Text"]
        text:SetPoint("CENTER", tab, "CENTER")
    end
end

do --[[ SharedXML\SharedUIPanelTemplates.xml ]]
    function Skin.UIPanelCloseButton(button)
        local size = private.is730 and 16.5 or 17
        button:SetSize(size, size)
        button:SetNormalTexture("")
        button:SetHighlightTexture("")
        button:SetPushedTexture("")

        local dis = button:GetDisabledTexture()
        dis:SetColorTexture(0, 0, 0, .4)
        dis:SetDrawLayer("OVERLAY")
        dis:SetAllPoints()

        Base.SetBackdrop(button, private.buttonColor:GetRGBA())

        button._auroraHighlight = {}
        local lineOfs = private.is730 and 4 or 2.5
        for i = 1, 2 do
            local line = button:CreateLine()
            line:SetColorTexture(1, 1, 1)
            line:SetThickness(private.is730 and 0.7 or 0.5)
            if i == 1 then
                line:SetStartPoint("TOPLEFT", lineOfs, -lineOfs)
                line:SetEndPoint("BOTTOMRIGHT", -lineOfs, lineOfs)
            else
                line:SetStartPoint("TOPRIGHT", -lineOfs, -lineOfs)
                line:SetEndPoint("BOTTOMLEFT", lineOfs, lineOfs)
            end
            _G.tinsert(button._auroraHighlight, line)
        end

        Base.SetHighlight(button, "color")
    end
    function Skin.UIPanelButtonTemplate(button)
        button.Left:SetAlpha(0)
        button.Right:SetAlpha(0)
        button.Middle:SetAlpha(0)
        button:SetHighlightTexture("")

        Base.SetBackdrop(button, private.buttonColor:GetRGBA())
        Base.SetHighlight(button, "backdrop")
    end
    function Skin.PortraitFrameTemplate(frame, noCloseButton)
        local name = frame:GetName()

        frame.Bg:Hide()
        _G[name.."TitleBg"]:Hide()
        frame.portrait:SetAlpha(0)
        frame.portraitFrame:SetTexture("")
        _G[name.."TopRightCorner"]:Hide()
        frame.topLeftCorner:Hide()
        frame.topBorderBar:SetTexture("")

        local titleText = frame.TitleText
        titleText:ClearAllPoints()
        titleText:SetPoint("TOPLEFT")
        titleText:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -private.FRAME_TITLE_HEIGHT)

        frame.TopTileStreaks:SetTexture("")
        _G[name.."BotLeftCorner"]:Hide()
        _G[name.."BotRightCorner"]:Hide()
        _G[name.."BottomBorder"]:Hide()
        frame.leftBorderBar:Hide()
        _G[name.."RightBorder"]:Hide()

        Base.SetBackdrop(frame)
        if not noCloseButton then
            Skin.UIPanelCloseButton(frame.CloseButton)
            frame.CloseButton:SetPoint("TOPRIGHT", -3, -3)
        end
    end
    function Skin.InsetFrameTemplate(frame)
        frame.Bg:Hide()

        frame.InsetBorderTopLeft:Hide()
        frame.InsetBorderTopRight:Hide()

        frame.InsetBorderBottomLeft:Hide()
        frame.InsetBorderBottomRight:Hide()

        frame.InsetBorderTop:Hide()
        frame.InsetBorderBottom:Hide()
        frame.InsetBorderLeft:Hide()
        frame.InsetBorderRight:Hide()
    end
    function Skin.ButtonFrameTemplate(frame)
        Skin.PortraitFrameTemplate(frame)
        local name = frame:GetName()

        _G[name.."BtnCornerLeft"]:SetTexture("")
        _G[name.."BtnCornerRight"]:SetTexture("")
        _G[name.."ButtonBottomBorder"]:SetTexture("")
        Skin.InsetFrameTemplate(frame.Inset)
    end

    function Skin.UIPanelScrollBarButton(button)
        button:SetSize(17, 17)
        button:SetNormalTexture("")
        button:SetPushedTexture("")
        button:SetHighlightTexture("")

        local disabled = button:GetDisabledTexture()
        disabled:SetVertexColor(0, 0, 0, .3)
        disabled:SetDrawLayer("OVERLAY")
        disabled:SetAllPoints()

        Base.SetBackdrop(button, private.buttonColor:GetRGBA())
    end
    function Skin.UIPanelScrollUpButtonTemplate(button)
        Skin.UIPanelScrollBarButton(button)

        local arrow = button:CreateTexture(nil, "ARTWORK")
        arrow:SetPoint("TOPLEFT", 4, -6)
        arrow:SetPoint("BOTTOMRIGHT", -5, 7)
        Base.SetTexture(arrow, "arrowUp")

        button._auroraHighlight = {arrow}
        Base.SetHighlight(button, "texture")
    end
    function Skin.UIPanelScrollDownButtonTemplate(button)
        Skin.UIPanelScrollBarButton(button)

        local arrow = button:CreateTexture(nil, "ARTWORK")
        arrow:SetPoint("TOPLEFT", 4, -7)
        arrow:SetPoint("BOTTOMRIGHT", -5, 6)
        Base.SetTexture(arrow, "arrowDown")

        button._auroraHighlight = {arrow}
        Base.SetHighlight(button, "texture")
    end
    function Skin.UIPanelScrollBarTemplate(slider)
        Skin.UIPanelScrollUpButtonTemplate(slider.ScrollUpButton)
        Skin.UIPanelScrollDownButtonTemplate(slider.ScrollDownButton)

        slider.ThumbTexture:SetAlpha(0)
        slider.ThumbTexture:SetWidth(17)

        local thumb = _G.CreateFrame("Frame", nil, slider)
        thumb:SetPoint("TOPLEFT", slider.ThumbTexture, 0, -2)
        thumb:SetPoint("BOTTOMRIGHT", slider.ThumbTexture, 0, 2)
        Base.SetBackdrop(thumb, private.buttonColor:GetRGBA())
        slider._auroraThumb = thumb
    end
    function Skin.UIPanelStretchableArtScrollBarTemplate(slider)
        Skin.UIPanelScrollBarTemplate(slider)

        slider.Top:Hide()
        slider.Bottom:Hide()
        slider.Middle:Hide()

        slider.Background:Hide()
    end
    function Skin.UIPanelScrollFrameTemplate(scrollframe)
        Skin.UIPanelScrollBarTemplate(scrollframe.ScrollBar)
        scrollframe.ScrollBar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 2, -17)
        scrollframe.ScrollBar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 2, 17)
    end
    function Skin.FauxScrollFrameTemplate(scrollframe)
        Skin.UIPanelScrollFrameTemplate(scrollframe)
    end
    function Skin.ListScrollFrameTemplate(scrollframe)
        Skin.FauxScrollFrameTemplate(scrollframe)
        local name = scrollframe:GetName()
        _G[name.."Top"]:Hide()
        _G[name.."Bottom"]:Hide()
        _G[name.."Middle"]:Hide()
    end

    function Skin.MaximizeMinimizeButtonFrameTemplate(frame)
        for _, name in next, {"MaximizeButton", "MinimizeButton"} do
            local button = frame[name]
            button:SetSize(17, 17)
            button:SetNormalTexture("")
            button:SetPushedTexture("")
            button:SetHighlightTexture("")

            Base.SetBackdrop(button, private.buttonColor:GetRGBA())

            button:ClearAllPoints()
            button:SetPoint("CENTER")

            button._auroraHighlight = {}

            local lineOfs = 4
            local line = button:CreateLine()
            line:SetColorTexture(1, 1, 1)
            line:SetThickness(0.5)
            line:SetStartPoint("TOPRIGHT", -lineOfs, -lineOfs)
            line:SetEndPoint("BOTTOMLEFT", lineOfs, lineOfs)
            tinsert(button._auroraHighlight, line)

            local hline = button:CreateTexture()
            hline:SetColorTexture(1, 1, 1)
            hline:SetSize(7, 1)
            tinsert(button._auroraHighlight, hline)

            local vline = button:CreateTexture()
            vline:SetColorTexture(1, 1, 1)
            vline:SetSize(1, 7)
            tinsert(button._auroraHighlight, vline)

            if name == "MaximizeButton" then
                hline:SetPoint("TOP", 1, -4)
                vline:SetPoint("RIGHT", -4, 1)
            else
                hline:SetPoint("BOTTOM", -1, 4)
                vline:SetPoint("LEFT", 4, -1)
            end

            Base.SetHighlight(button, "color")
        end
    end
end

function private.SharedXML.SharedUIPanelTemplates()
    _G.hooksecurefunc("PanelTemplates_DeselectTab", Hook.PanelTemplates_DeselectTab)
    _G.hooksecurefunc("PanelTemplates_SelectTab", Hook.PanelTemplates_SelectTab)
end

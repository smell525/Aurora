local _, private = ...

-- [[ Lua Globals ]]
local select = _G.select

-- [[ Core ]]
local F = _G.unpack(private.Aurora)
local Skin = private.Aurora.Skin

function private.FrameXML.DressUpFrames()
    -- SideDressUp
    for i = 1, 4 do
        select(i, _G.SideDressUpFrame:GetRegions()):Hide()
    end
    select(5, _G.SideDressUpModelCloseButton:GetRegions()):Hide()

    _G.SideDressUpModel:HookScript("OnShow", function(self)
        self:ClearAllPoints()
        self:SetPoint("LEFT", self:GetParent():GetParent(), "RIGHT", 1, 0)
    end)

    F.Reskin(_G.SideDressUpModelResetButton)
    F.ReskinClose(_G.SideDressUpModelCloseButton)

    _G.SideDressUpModel.bg = _G.CreateFrame("Frame", nil, _G.SideDressUpModel)
    _G.SideDressUpModel.bg:SetPoint("TOPLEFT", 0, 1)
    _G.SideDressUpModel.bg:SetPoint("BOTTOMRIGHT", 1, -1)
    _G.SideDressUpModel.bg:SetFrameLevel(_G.SideDressUpModel:GetFrameLevel()-1)
    F.CreateBD(_G.SideDressUpModel.bg)


    -- Dressup Frame
    if private.is730 then
        local DressUpFrame = _G.DressUpFrame
        F.ReskinPortraitFrame(DressUpFrame, true)

        F.ReskinDropDown(_G.DressUpFrameOutfitDropDown)
        F.Reskin(_G.DressUpFrameOutfitDropDown.SaveButton)

        Skin.MaximizeMinimizeButtonFrameTemplate(DressUpFrame.MaxMinButtonFrame)

        F.Reskin(_G.DressUpFrameCancelButton)
        F.Reskin(_G.DressUpFrameResetButton)
        _G.DressUpFrameResetButton:SetPoint("RIGHT", _G.DressUpFrameCancelButton, "LEFT", -1, 0)

        DressUpFrame.ModelBackground:SetDrawLayer("BACKGROUND", 3)
    else
        _G.DressUpFramePortrait:Hide()
        _G.DressUpBackgroundTopLeft:Hide()
        _G.DressUpBackgroundTopRight:Hide()
        _G.DressUpBackgroundBotLeft:Hide()
        _G.DressUpBackgroundBotRight:Hide()
        for i = 2, 5 do
            select(i, _G.DressUpFrame:GetRegions()):Hide()
        end

        F.SetBD(_G.DressUpFrame, 10, -12, -34, 74)
        F.Reskin(_G.DressUpFrameOutfitDropDown.SaveButton)
        F.Reskin(_G.DressUpFrameCancelButton)
        F.Reskin(_G.DressUpFrameResetButton)
        F.ReskinDropDown(_G.DressUpFrameOutfitDropDown)
        F.ReskinClose(_G.DressUpFrameCloseButton, "TOPRIGHT", _G.DressUpFrame, "TOPRIGHT", -38, -16)

        _G.DressUpFrameOutfitDropDown:SetHeight(32)
        _G.DressUpFrameOutfitDropDown.SaveButton:SetPoint("LEFT", _G.DressUpFrameOutfitDropDown, "RIGHT", -13, 2)
        _G.DressUpFrameResetButton:SetPoint("RIGHT", _G.DressUpFrameCancelButton, "LEFT", -1, 0)
    end

end

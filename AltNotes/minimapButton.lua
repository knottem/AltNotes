local AN = AltNotes

local MINIMAP_BUTTON_RADIUS = 80

local function UpdateMinimapButtonPosition(button)
    if not button then
        return
    end

    AN.EnsureDB()

    local angle = (AltNotesDB.minimap and AltNotesDB.minimap.angle) or 45
    local radians = math.rad(angle)

    local x = math.cos(radians) * MINIMAP_BUTTON_RADIUS
    local y = math.sin(radians) * MINIMAP_BUTTON_RADIUS

    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function AN.CreateMinimapButton()
    if AN.minimapButton then
        return
    end

    AN.EnsureDB()

    local button = CreateFrame("Button", "AltNotesMinimapButton", Minimap)
    AN.minimapButton = button

    button:SetSize(32, 32)
    button:SetFrameStrata("MEDIUM")
    button:SetMovable(true)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:RegisterForDrag("LeftButton")

    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER")
    icon:SetTexture("Interface\\Icons\\INV_Misc_Note_01")
    button.icon = icon

    local border = button:CreateTexture(nil, "OVERLAY")
    border:SetSize(53, 53)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    button.border = border

    local highlight = button:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetSize(50, 50)
    highlight:SetPoint("CENTER")
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    button.highlight = highlight

    button:SetScript("OnClick", function(_, mouseButton)
        if mouseButton == "LeftButton" then
            AN.ToggleMainFrame()
        elseif mouseButton == "RightButton" then
            AN.UpdateCharacterData()
            RequestTimePlayed()
            print("AltNotes: requested played time refresh.")
        end
    end)

    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("AltNotes", 1, 0.82, 0)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Left-click: Toggle window", 1, 1, 1)
        GameTooltip:AddLine("Right-click: Refresh played time", 1, 1, 1)
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    button:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function(btn)
            local mx, my = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()

            mx = mx / scale
            my = my / scale

            local cx, cy = Minimap:GetCenter()
            local angle = math.deg(math.atan2(my - cy, mx - cx))

            AltNotesDB.minimap.angle = angle
            UpdateMinimapButtonPosition(btn)
        end)
    end)

    button:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    if AltNotesDB.minimap.hide then
        button:Hide()
    else
        button:Show()
    end

    UpdateMinimapButtonPosition(button)
end

function AN.ShowMinimapButton()
    AN.EnsureDB()

    AltNotesDB.minimap.hide = false

    if AN.minimapButton then
        AN.minimapButton:Show()
    end
end

function AN.HideMinimapButton()
    AN.EnsureDB()

    AltNotesDB.minimap.hide = true

    if AN.minimapButton then
        AN.minimapButton:Hide()
    end
end

function AN.ToggleMinimapButton()
    AN.EnsureDB()

    if AltNotesDB.minimap.hide then
        AN.ShowMinimapButton()
        print("AltNotes: minimap button shown.")
    else
        AN.HideMinimapButton()
        print("AltNotes: minimap button hidden.")
    end
end
local AN = AltNotes

function AN.CreateMainFrame()
    if AN.mainFrame then return end

    local f = CreateFrame("Frame", "AltNotesMainFrame", UIParent, "BackdropTemplate")
    AN.mainFrame = f

    f:SetSize(420, 500)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:Hide()

    f:SetBackdrop({
        bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 24,
        insets = { left = 8, right = 8, top = 8, bottom = 8 },
    })

    local title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", 0, -16)
    title:SetText("AltNotes")

    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)

    -- Scroll list
    local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 16, -50)
    scroll:SetPoint("BOTTOMRIGHT", -30, 80)

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(360, 1)
    scroll:SetScrollChild(content)

    f.listContent = content

    -- Bottom summary
    local gold = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    gold:SetPoint("BOTTOMLEFT", 16, 50)
    f.totalGoldLabel = gold

    local played = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    played:SetPoint("BOTTOMLEFT", 16, 30)
    f.totalPlayedLabel = played
end
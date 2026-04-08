local AN = AltNotes

function AN.OpenNotePopup(key)
    local char = AN.SafeCharacters()[key]
    if not char then return end

    if not AN.popup then
        local f = CreateFrame("Frame", "AltNotesPopup", UIParent, "BackdropTemplate")
        AN.popup = f

        f:SetSize(400, 400)
        f:SetPoint("CENTER")

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
        f.title = title

        local info = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        info:SetPoint("TOP", title, "BOTTOM", 0, -4)
        f.info = info

        local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -4, -4)

        local edit = CreateFrame("EditBox", nil, f, "BackdropTemplate")
        edit:SetMultiLine(true)
        edit:SetPoint("TOPLEFT", 16, -80)
        edit:SetPoint("BOTTOMRIGHT", -16, 50)
        edit:SetFontObject("ChatFontNormal")
        edit:SetAutoFocus(true)
        edit:SetTextInsets(8, 8, 8, 8)
        edit:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
        })
        edit:SetBackdropColor(0, 0, 0, 0.9)

        f.edit = edit

        local save = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        save:SetSize(80, 24)
        save:SetPoint("BOTTOMRIGHT", -16, 16)
        save:SetText("Save")

         save:SetScript("OnClick", function()
            AN.SaveCharacterNote(f.key, f.edit:GetText())
            AN.RefreshUI()
            f:Hide()
        end)
    end

    local f = AN.popup
    f.key = key

    f.title:SetText(char.name or key)
    f.info:SetText(
        "Level " .. (char.level or "?")
        .. " • " .. GetMoneyString(char.money or 0)
        .. " • " .. AN.FormatPlayedTime(char.timePlayed or 0)
    )

    f.edit:SetText(AN.GetCharacterNote(key))
    f:Show()
end
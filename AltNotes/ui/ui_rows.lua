local AN = AltNotes

AN.rows = AN.rows or {}

function AN.RefreshRows()
    if not AN.mainFrame then return end

    local parent = AN.mainFrame.listContent

    for _, row in ipairs(AN.rows) do
        row:Hide()
    end

    local keys = AN.GetSortedCharacterKeys()

    for i, key in ipairs(keys) do
        local row = AN.rows[i]

        if not row then
            row = CreateFrame("Button", nil, parent)
            row:SetSize(340, 24)

            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", 4, 0)

            row.highlight = row:CreateTexture(nil, "BACKGROUND")
            row.highlight:SetAllPoints()
            row.highlight:SetColorTexture(1, 1, 1, 0.08)
            row.highlight:Hide()

            row:SetScript("OnEnter", function(self)
                self.highlight:Show()
            end)

            row:SetScript("OnLeave", function(self)
                self.highlight:Hide()
            end)

            row:SetScript("OnClick", function(self)
                if self.key then
                    AN.OpenNotePopup(self.key)
                end
            end)

            AN.rows[i] = row
        end

        local char = AN.SafeCharacters()[key]

        row.key = key
        row:SetPoint("TOPLEFT", 0, -(i - 1) * 26)
        row:Show()

        row.text:SetText(AN.GetClassColoredName(char))
    end

    parent:SetHeight(#keys * 26)
end
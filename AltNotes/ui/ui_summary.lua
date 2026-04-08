local AN = AltNotes

local function SafeCharacters()
    return AN.SafeCharacters()
end

function AN.UpdateSummaryLabels()
    if not AN.mainFrame then
        return
    end

    local totalGold = 0
    local totalPlayed = 0

    for _, char in pairs(SafeCharacters()) do
        totalGold = totalGold + (tonumber(char.money) or 0)
        totalPlayed = totalPlayed + (tonumber(char.timePlayed) or 0)
    end

    AN.mainFrame.totalGoldLabel:SetText("Total Gold: " .. GetMoneyString(totalGold))
    AN.mainFrame.totalPlayedLabel:SetText("Total Played: " .. AN.FormatPlayedTime(totalPlayed))
end

function AN.RefreshUI()
    if not AN.mainFrame then
        return
    end

    AN.RefreshRows()
    AN.UpdateSummaryLabels()
end

function AN.ToggleMainFrame()
    if not AN.mainFrame then
        return
    end

    if AN.mainFrame:IsShown() then
        AN.mainFrame:Hide()
    else
        AN.RefreshUI()
        AN.mainFrame:Show()
    end
end
AltNotes = AltNotes or {}
local AN = AltNotes

AltNotesDB = AltNotesDB or {}

AN.frame = CreateFrame("Frame")
AN.frame:RegisterEvent("PLAYER_LOGIN")
AN.frame:RegisterEvent("PLAYER_MONEY")
AN.frame:RegisterEvent("PLAYER_LEVEL_UP")
AN.frame:RegisterEvent("TIME_PLAYED_MSG")

AN.frame:SetScript("OnEvent", function(_, event, ...)
    if event == "PLAYER_LOGIN" then
        AN.EnsureDB()
        AN.UpdateCharacterData()
        AN.CreateMainFrame()
        AN.CreateMinimapButton()
        RequestTimePlayed()
        AN.RefreshUI()

    elseif event == "PLAYER_MONEY" then
        AN.UpdateCharacterData()
        AN.RefreshUI()

    elseif event == "PLAYER_LEVEL_UP" then
        AN.UpdateCharacterData()
        AN.RefreshUI()

    elseif event == "TIME_PLAYED_MSG" then
        local totalTimePlayed = ...
        local char = AN.EnsureCharacter()
        char.timePlayed = totalTimePlayed or 0
        char.lastUpdate = time()
        AN.RefreshUI()
    end
end)
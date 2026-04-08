local AN = AltNotes

local function Trim(text)
    return (text or ""):match("^%s*(.-)%s*$")
end

SLASH_ALTNOTES1 = "/altnotes"
SLASH_ALTNOTES2 = "/an"

SLASH_ALTNOTESDEBUG1 = "/andebug"

SlashCmdList["ALTNOTES"] = function(msg)
    msg = string.lower(Trim(msg))

    if msg == "" then
        AN.ToggleMainFrame()
        return
    end

    if msg == "show" then
        if AN.mainFrame and not AN.mainFrame:IsShown() then
            AN.ToggleMainFrame()
        else
            print("AltNotes: window is already shown.")
        end
        return
    end

    if msg == "hide" then
        if AN.mainFrame and AN.mainFrame:IsShown() then
            AN.ToggleMainFrame()
        else
            print("AltNotes: window is already hidden.")
        end
        return
    end

    if msg == "minimap" then
        AN.ToggleMinimapButton()
        return
    end

    if msg == "minimap show" then
        AN.ShowMinimapButton()
        print("AltNotes: minimap button shown.")
        return
    end

    if msg == "minimap hide" then
        AN.HideMinimapButton()
        print("AltNotes: minimap button hidden.")
        return
    end

    if msg == "refresh" then
        AN.UpdateCharacterData()
        RequestTimePlayed()
        AN.RefreshUI()
        print("AltNotes: refresh requested.")
        return
    end

    print("|cff00ccffAltNotes commands:|r")
    print("/altnotes or /an - Toggle the main window")
    print("/an show - Show the main window")
    print("/an hide - Hide the main window")
    print("/an refresh - Refresh current character data")
    print("/an minimap - Toggle minimap button")
    print("/an minimap show - Show minimap button")
    print("/an minimap hide - Hide minimap button")
end


SlashCmdList["ALTNOTESDEBUG"] = function()
    AN.EnsureDB()

    print("AltNotes character data:")
    for key, char in pairs(AltNotesDB.characters or {}) do
        print(
            key,
            "name=", char.name or "nil",
            "gold=", tostring(char.money or 0),
            "level=", tostring(char.level or 0),
            "played=", tostring(char.timePlayed or 0)
        )
    end
end
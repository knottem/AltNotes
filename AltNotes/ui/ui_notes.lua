local AN = AltNotes

AN.rows = AN.rows or {}

local function SafeCharacters()
    AltNotesDB = AltNotesDB or {}
    AltNotesDB.characters = AltNotesDB.characters or {}
    return AltNotesDB.characters
end

AN.SafeCharacters = SafeCharacters

function AN.TruncateNotePreview(text, maxLength)
    text = tostring(text or "")
    text = text:gsub("[\r\n]+", " ")

    if string.len(text) <= maxLength then
        return text
    end

    return string.sub(text, 1, maxLength - 3) .. "..."
end

function AN.SaveCharacterNote(key, text)
    if not key then
        return
    end

    local char = SafeCharacters()[key]
    if not char then
        return
    end

    char.note = text or ""
    char.lastUpdate = time()
end

function AN.GetCharacterNote(key)
    if not key then
        return ""
    end

    local char = SafeCharacters()[key]
    if not char then
        return ""
    end

    return char.note or ""
end
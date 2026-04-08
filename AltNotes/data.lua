local AN = AltNotes

function AN.GetCharacterKey()
    local name = UnitName("player") or "Unknown"
    local realm = GetRealmName() or "UnknownRealm"
    return name .. "-" .. realm
end

function AN.EnsureDB()
    AltNotesDB = AltNotesDB or {}
    AltNotesDB.characters = AltNotesDB.characters or {}
    AltNotesDB.minimap = AltNotesDB.minimap or {
        angle = 45,
        hide = false,
    }
end

function AN.EnsureCharacter()
    AN.EnsureDB()

    local key = AN.GetCharacterKey()

    AltNotesDB.characters[key] = AltNotesDB.characters[key] or {
        key = key,
        note = "",
        name = UnitName("player") or "Unknown",
        realm = GetRealmName() or "UnknownRealm",
        class = select(2, UnitClass("player")),
        level = UnitLevel("player"),
        money = GetMoney() or 0,
        timePlayed = 0,
        lastUpdate = time(),
    }

    return AltNotesDB.characters[key]
end

function AN.UpdateCharacterData()
    local char = AN.EnsureCharacter()

    char.key = AN.GetCharacterKey()
    char.name = UnitName("player") or "Unknown"
    char.realm = GetRealmName() or "UnknownRealm"
    char.class = select(2, UnitClass("player"))
    char.level = UnitLevel("player")
    char.money = GetMoney() or 0
    char.lastUpdate = time()
end

function AN.GetSortedCharacterKeys()
    AN.EnsureDB()

    local keys = {}

    for key in pairs(AltNotesDB.characters) do
        table.insert(keys, key)
    end

    table.sort(keys, function(a, b)
        local charA = AltNotesDB.characters[a] or {}
        local charB = AltNotesDB.characters[b] or {}

        local nameA = (charA.name or a):lower()
        local nameB = (charB.name or b):lower()

        if nameA == nameB then
            return a < b
        end

        return nameA < nameB
    end)

    return keys
end

function AN.GetTotalGold()
    AN.EnsureDB()

    local total = 0

    for _, char in pairs(AltNotesDB.characters) do
        total = total + (tonumber(char.money) or 0)
    end

    return total
end
local AN = AltNotes

function AN.FormatPlayedTime(seconds)
    if not seconds then
        return "?"
    end

    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)

    if days > 0 then
        return string.format("%dd %dh %dm", days, hours, minutes)
    elseif hours > 0 then
        return string.format("%dh %dm", hours, minutes)
    else
        return string.format("%dm", minutes)
    end
end

function AN.GetClassColoredName(char)
    local color = RAID_CLASS_COLORS and RAID_CLASS_COLORS[char.class or ""]
    if color then
        return string.format(
            "|cff%02x%02x%02x%s|r",
            color.r * 255,
            color.g * 255,
            color.b * 255,
            char.name or "?"
        )
    end

    return char.name or "?"
end
local fishtrack = CreateFrame("Frame")
print("Garca Detector v1.1 by Wachiwonga")
print("Ximuelo se la come, coch se la da")
fishtrack:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
fishtrack.num = {}
fishtrack:SetScript("OnEvent", function(self, event, ...)
    local arg = {...}
    if arg[9] == 57426 and arg[2] == "SPELL_CAST_START" then
        droppedAt = GetTime()
        table.wipe(self.num)
        print("Festin tirado, se reinicia el conteo")
    end
    if droppedAt ~= null and GetTime() - droppedAt > 180 then
		table.wipe(self.num)
        droppedAt = null;
        print("Pasaron 3 minutos del ultimo festin, se reinicia")
	end
    if arg[9]==57397 and arg[2] == "SPELL_CAST_SUCCESS" then
        local name = arg[7]
        if UnitExists(name) --[[e.g. is in raid or party--]] then
            self.num[name] = (self.num[name] or 0) + 1
            if self.num[name] >= 2 then
                SendChatMessage(name.." comio pescado "..self.num[name].." veces!")
            end
        end
    end
end)
-- 57426 casteo pez
-- 57397 spell al clickear pez  
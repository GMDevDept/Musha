-- Register musha to official character list to enable skin panel
AddClassPostConstruct("widgets/widget", function(self)
    if self.name == "LoadoutSelect" then -- add to chara list before LoadoutSelect
        if not table.contains(DST_CHARACTERLIST,"musha") then
            table.insert(DST_CHARACTERLIST,"musha")
        end
    elseif	self.name == "LoadoutRoot" then -- delete from list after LoadoutRoot
        if table.contains(DST_CHARACTERLIST,"musha") then
            RemoveByValue(DST_CHARACTERLIST,"musha")
        end
    end
end)

-- Skin list
GLOBAL.PREFAB_SKINS["musha"] = {
    "musha_none",
}
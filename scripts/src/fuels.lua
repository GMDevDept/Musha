FUELTYPE.MUSHA = "MUSHA"

local fuel_list = {
    "goldnugget",
    "thulecite",
    "rocks",
    "flint",
    "marble",
    "moonrocknugget",
    "thulecite_pieces",
    "boneshard",
    "stinger",
    "spidergland",
    "houndstooth",
    "snakeskin",
    "slurtle_shellpieces",
    "silk",
    "tentaclespots",
    "tentaclespike",
    "ice",
    "minotaurhorn",
}

local function fuelsetup(inst)
    if not inst.components.fuel then
        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
    end
    inst.components.fuel.fueltype = "MUSHA"
end

for _, v in pairs(fuel_list) do
    AddPrefabPostInit(v, fuelsetup)
end

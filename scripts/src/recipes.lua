-- Add to character tab: AddCharacterRecipe = function(name, ingredients, tech, config, extra_filters)

AddCharacterRecipe("frosthammer",
    { Ingredient("hammer", 1) },
    TECH.NONE,
    { builder_tag = "musha", atlas = "images/inventoryimages/frosthammer.xml" })

-- Add to mod menu or workstation: AddRecipe2 = function(name, ingredients, tech, config, filters)
AddRecipe2("shadowmusha_builder",
    { Ingredient("reviver", 1), Ingredient("nightsword", 1) },
    TECH.SHADOW_TWO,
    { builder_tag = "musha", atlas = "images/inventoryimages/musha_inventoryimages2.xml", nounlock = true })

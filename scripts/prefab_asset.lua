PrefabFiles = {
    "musha",
}

Assets = {
    -- Doesn't change anything ,but if not then error occurs:
    -- [string "scripts/widgets/redux/clothingexplorerpanel..."]:32: attempt to index field 'header' (a nil value)
    -- also occurs when skin related strings are not defined
    Asset( "IMAGE", "bigportraits/musha.tex" ),
    Asset( "ATLAS", "bigportraits/musha.xml" ),

    -- Character full portrait (oval) on selecting screen (default skin)
    Asset( "IMAGE", "bigportraits/musha_none.tex" ),  
    Asset( "ATLAS", "bigportraits/musha_none.xml" ),

    -- Map icon
    Asset( "IMAGE", "images/map_icons/musha_mapicon.tex" ),
    Asset( "ATLAS", "images/map_icons/musha_mapicon.xml" ),

    -- Character craft tab icon (doesn't affect tab menu)
    Asset( "IMAGE", "images/avatars/avatar_musha.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_musha.xml" ),

    Asset( "IMAGE", "images/avatars/avatar_ghost_musha.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_musha.xml" ),

    -- Portrait on the right side of toolbar
    Asset( "IMAGE", "images/avatars/self_inspect_musha.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_musha.xml" ),

    -- Name tag on selection screen
    Asset( "IMAGE", "images/names_musha.tex" ),
    Asset( "ATLAS", "images/names_musha.xml" ),
}
    
AddMinimapAtlas("images/map_icons/musha_mapicon.xml")

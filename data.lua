-- Initialize Globals
-- ******************
HW_Global = {}



-- Initialize Global Variables
-- ***************************
require("prototypes/lib/HW_Global-initialize")



-- Include Libraries
-- *****************
require("prototypes/lib/lib-general")
require("prototypes/lib/lib-technology")
require("prototypes/lib/lib-item")



-- Initialize Factorio
-- *******************
hide_all_tech()
require("prototypes/hw_anootations")



-- Primitive
-- *********
require("prototypes/domains/woods/woods-const")
require("prototypes/domains/woods/woods-fuel-categories")
require("prototypes/domains/woods/woods-item-subgroups")
require("prototypes/domains/woods/woods-items")
require("prototypes/domains/woods/woods-fluids")
require("prototypes/domains/woods/woods-recipe-categories")
require("prototypes/domains/woods/woods-recipes")
require("prototypes/domains/woods/woods-infinity-pipe")
require("prototypes/domains/woods/woods-entities")


-- Places
-- ******
require("prototypes/places/landable-surfaces/vanilla-planets/nauvis/nauvis_caldera")

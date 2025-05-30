-- Initialize Globals
-- ******************
HW_Global = {}



-- Initialize Global Variables
-- ***************************
require("scripts/lib-prototype/HW_Global-initialize")



-- Include Libraries
-- *****************
require("scripts/lib-prototype/lib-general")
require("scripts/lib-prototype/lib-technology")
require("scripts/lib-prototype/lib-item")



-- Initialize Factorio
-- *******************
hide_all_tech()
require("prototypes/hw_anootations")



-- Primitive
-- *********
require("prototypes/domains/woods/woods-const")
require("prototypes/domains/woods/woods-supplementary")
require("prototypes/domains/woods/woods-items")
require("prototypes/domains/woods/woods-recipes")
require("prototypes/domains/woods/woods-machines")
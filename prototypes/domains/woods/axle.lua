---@type data.RecipeCategory
local axleRecipeCategory = {
    name = "axle",
    type = "recipe-category"
}

---@type data.RecipePrototype
local axleTorqueRecipe = {
    name = "axle-torque-recipe",
    type = "recipe",
    category = axleRecipeCategory.name,
    ingredients = {
        {type = "fluid", name="torque", amount=100}
    },
    results = {
        {type = "fluid", name = "torque", amount = 90}
    }
}

---@type data.AssemblingMachinePrototype
local axleEntity = {
    name = "axle",
    type = "assembling-machine",
    fixed_recipe = axleTorqueRecipe.name,
    crafting_speed = 1,
    crafting_categories = {"axle"},
    energy_usage = "1W",
    energy_source = {type = "void"},
    minable = {mining_time = 0.2, result = "axle"},

    collision_box = {{-0.4, -2.4}, {0.4, 2.4}},
    selection_box = {{-0.5, -2.5}, {0.5, 2.5}},
    fluid_boxes = {
        {
            volume = 100,
            filter = "torque",
            production_type = "input",
            pipe_connections = {
                {
                    flow_direction = "input-output",
                    direction = defines.direction.north --[[@as data.Direction]],
                    position = {0, -2}
                }, {
                    flow_direction = "input-output",
                    direction = defines.direction.south --[[@as data.Direction]],
                    position = {0, 2}
                }
            }

        }, {
            volume = 100,
            filter = "torque",
            production_type = "output",
            pipe_connections = {
                {
                    flow_direction = "output",
                    direction = defines.direction.west --[[@as data.Direction]],
                    position = {0, -2}
                }, {
                    flow_direction = "output",
                    direction = defines.direction.east --[[@as data.Direction]],
                    position = {0, -2}
                }, {
                    flow_direction = "output",
                    direction = defines.direction.west --[[@as data.Direction]],
                    position = {0, 2}
                }, {
                    flow_direction = "output",
                    direction = defines.direction.east --[[@as data.Direction]],
                    position = {0, 2}
                }
            }
        }
    },
    icon = "__hidden-worlds__/graphics/icons/entity/axle.png",
    graphics_set = {
        animation = {
            north = {
                filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-1x5.png",
                width = 64,
                height = 320,
                scale = 0.5
            },
            west = {
                filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-5x1.png",
                width = 320,
                height = 64,
                scale = 0.5
            }
        }
    }
}
axleEntity.graphics_set.animation.south = axleEntity.graphics_set.animation.north
axleEntity.graphics_set.animation.east = axleEntity.graphics_set.animation.west

---@type data.ItemPrototype
local axleItem = {
    type = "item",
    name = axleEntity.name,
    icon = axleEntity.icon,
    icon_size = 64,
    flags = {},
    subgroup = "extraction-machine",
    --order = "za"..name,
    place_result = axleEntity.name,
    stack_size = 50
}

---@type data.RecipePrototype
local axleRecipe = {
    name = "axle-recipe",
    type = "recipe",
    category = "basic-crafting",
    ingredients = {
        -- TODO
    },
    results = {
        {type = "item", name = axleItem.name, amount = 1}
    }
}

---@diagnostic disable-next-line: assign-type-mismatch
data:extend{axleEntity, axleRecipeCategory, axleTorqueRecipe, axleItem, axleRecipe}
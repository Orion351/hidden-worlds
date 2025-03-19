local function dispatcher_init()
  storage.dispatcher_handler = storage.dispatcher_handler or {}
end

script.on_init(dispatcher_init)

local function on_built_entity()
  game.print("flarble")
end

script.on_event(defines.events.on_built_entity, on_built_entity, {{filter = "name", name = "dispatcher"}})

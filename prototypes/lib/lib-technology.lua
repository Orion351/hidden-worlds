-- This doesn't work yet; tinker with it only if it's needed for some specific reason
function remove_all_technolgies_but_one()
  -- Remove all technologies
  data.raw.technology = {}

  -- Add in a dummy technology
  data:extend{
    {
      type = "technology",
      name = "dummy-tech",
      unit = {ingredients = {{"automation-science-pack", 1}}, time = 1, count = 1},
      icon = "__hidden-worlds__/thumbnail.png",
      icon_size = 144
    }
  }

  -- Remove TechnologyID references throughout the game
  for _, shortcut in pairs(data.raw.shortcut) do -- shortcuts
    shortcut.technology_to_unlock = nil
  end
  for _, recipe in pairs(data.raw.recipe) do -- recipe references
    recipe.alternative_unlock_methods = nil
  end
  data.raw["research-achievement"] = {}
  for _, research_achievemnt in pairs(data.raw["research-achievement"]) do -- research_achievements
    research_achievemnt.technology = nil
    research_achievemnt.research_all = false
  end

  -- TipTriggers
  ---@param tiptrigger data.TipTrigger
  local function remove_tip_trigger_research(tiptrigger)
    if tiptrigger.type == "research" then
      tiptrigger = nil
      goto continue
    end
    if not (tiptrigger.type == "or" or tiptrigger.type == "and" or tiptrigger.type == "sequence") then goto continue end
    for _, trigger_item in pairs (tiptrigger) do
      if trigger_item.type == "research" then tiptrigger = nil end
    end
    ::continue::
  end

  for _, tips_and_tricks_item in pairs(data.raw["tips-and-tricks-item"]) do
    if not tips_and_tricks_item.trigger then goto trigger_done end
    remove_tip_trigger_research(tips_and_tricks_item.trigger)
    ::trigger_done::
    if not tips_and_tricks_item.skip_trigger then goto skip_trigger_done end
    remove_tip_trigger_research(tips_and_tricks_item.skip_trigger)
    ::skip_trigger_done::
  end

end

function hide_all_tech()
  for _, tech in pairs(data.raw.technology) do
    if not tech.hw_prototype_data then
      tech.hidden = true
    end
  end
end
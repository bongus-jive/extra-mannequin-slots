require "/scripts/util.lua"

local SLOTS = { 13, 14, 15, 16, 9, 10, 11, 12, 5, 6, 7, 8 }
local STATES = { headarmor = "head", chestarmor = "body", legsarmor = "legs", backarmor = "back" }

local _updateImages = updateImages
function updateImages(...)
  _updateImages(...)
  
  local contents = world.containerItems(entity.id())
  for i, slot in ipairs(SLOTS) do
    pat_setExtraArmor(contents[slot], i)
  end
end

function pat_setExtraArmor(item, index)
  local slot = "pat_extraslots:"..index
  local state = item and STATES[root.itemType(item.name)] or "hide"
  animator.setAnimationState(slot, state)

  if state == "hide" then return end

  local cfg = root.itemConfig(item.name)
  local frameSet = cfg.config[storage.gender.."Frames"]
  local directives = buildDirectives(item, cfg)

  if state == "body" then
    local front, back = slot.."f", slot.."b"
    animator.setPartTag(slot, "frameSet", util.absolutePath(cfg.directory, frameSet.body))
    animator.setPartTag(back, "frameSet", util.absolutePath(cfg.directory, frameSet.backSleeve))
    animator.setPartTag(front, "frameSet", util.absolutePath(cfg.directory, frameSet.frontSleeve))
    animator.setPartTag(slot, "directives", directives)
    animator.setPartTag(back, "directives", directives)
    animator.setPartTag(front, "directives", directives)
  else
    animator.setPartTag(slot, "frameSet", util.absolutePath(cfg.directory, frameSet))
    animator.setPartTag(slot, "directives", directives)
  end
end

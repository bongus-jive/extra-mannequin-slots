require "/interface/scripted/mannequin/mannequingui.lua"

local validTypes = { headarmor = 0, chestarmor = 0, legsarmor = 0, backarmor = 0 }

local _init = init
function init()
  _init()

  self.extraSlots = {
    cosmetic1 = { slot = 13 },
    cosmetic2 = { slot = 14 },
    cosmetic3 = { slot = 15 },
    cosmetic4 = { slot = 16 },
    cosmetic5 = { slot = 9 },
    cosmetic6 = { slot = 10 },
    cosmetic7 = { slot = 11 },
    cosmetic8 = { slot = 12 },
    cosmetic9 = { slot = 5 },
    cosmetic10 = { slot = 6 },
    cosmetic11 = { slot = 7 },
    cosmetic12 = { slot = 8 }
  }

  local hasSlots = pcall(player.equippedItem, "cosmetic1")
  widget.setButtonEnabled("equipExtra", hasSlots)
end

function equipExtra()
  local contents = widget.itemGridItems("itemGrid")

  for _, v in pairs(self.extraSlots) do
    local item = contents[v.slot]
    if item then
      local t = root.itemType(item.name)
      if validTypes[t] then v.validType = t end
    end
  end

  equip(self.extraSlots)
end

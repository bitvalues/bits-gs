include("bits-gs/common/logging");

local spells_to_cancel = {
  ["Stoneskin"] = { ["Stoneskin"] = 37 },
  ["Sneak"] = { ["Sneak"] = 71 },
}

local delays_for_cancels = {
  ["71"] = "1.5",
}

function bgs_cancel_buffs(spell)
  if 'SELF' ~= spell.target.type then
    return false
  end

  tmp = spells_to_cancel[spell.english];
  if tmp == nil then
    return false
  end

  for name, id in pairs(tmp) do
    if buffactive[name] then
      delay = delays_for_cancels["" .. id]
      if delay == nil then
        delay = "0"
      end

      bgs_log_info('Canceling Buff: ' .. name .. " in " .. delay .. " seconds...")
      send_command("@wait " .. delay .."; cancel " .. id)
      return true
    end
  end

  return false;
end

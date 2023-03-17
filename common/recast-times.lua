state.recasts = {}

function bgs_add_recast_timer(name, time)
  state.recasts[name] = time
end

function bgs_decrement_recast_timers()
  for key, value in pairs(state.recasts) do
    if value ~= nil then
      state.recasts[key] = (value - 1)

      if state.recasts[key] < 0 then
        state.recasts[key] = nil
      end
    end
  end
end

function bgs_get_recast_time(spell)
  local time = state.recasts[spell]

  if time == nil then
    return 0
  end

  return time
end

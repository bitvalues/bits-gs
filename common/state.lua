local res = require("resources")

state = {
  debug_mode = false,
  in_party = false,
  city = "",
  status = "",
  moon = {
    phase = "",
    percent = 0,
  },
}

function bgs_is_casting()
  return midaction()
end

function bgs_update_player_status_change(new, old)
  if "Idle" == new then
    state.status = "idle"
  elseif "Resting" == new then
    state.status = "resting"
  elseif "Engaged" == new then
    state.status = "engaged"
  else
    state.status = ""
  end
end

function bgs_get_player_status()
  return state.status
end

function bgs_is_idle()
  return bgs_get_player_status() == "idle"
end

function bgs_is_resting()
  return bgs_get_player_status() == "resting"
end

function bgs_is_engaged()
  return bgs_get_player_status() == "engaged"
end

function bgs_update_player_party_status()
  party_count = windower.ffxi.get_party().party1_count

  if party_count > 1 then
    state.in_party = true
  else
    state.in_party = false
  end
end

function bgs_in_party()
  if state.in_party == true then
    return true
  end

  return false
end

function bgs_update_city()
  local zone_table = res.zones[windower.ffxi.get_info().zone]
  local zone = ""

  if zone_table ~= nil then
    zone = string.lower(zone_table.en)
  end

  if zone:contains("dynamis") then
    state.city = "dynamis"
  elseif zone:contains("windurst") or zone:contains("heavens tower") then
    state.city = "windurst"
  elseif zone:contains("bastok") or zone:contains("metalworks") then
    state.city = "bastok"
  elseif zone:contains("san d'oria") or zone:contains("d'oraguille") then
    state.city = "sandoria"
  elseif zone:contains("jeuno") or zone:contains("ru'lude") then
    state.city = "jeuno"
  else
    state.city = ""
  end
end

function bgs_in_windurst()
  return state.city == "windurst"
end

function bgs_in_bastok()
  return state.city == "bastok"
end

function bgs_in_sandoria()
  return state.city == "sandoria"
end

function bgs_in_jeuno()
  return state.city == "jeuno"
end

function bgs_in_town()
  return bgs_in_windurst() or bgs_in_bastok() or bgs_in_jeuno() or bgs_in_sandoria()
end

function bgs_update_moon()
  local info = windower.ffxi.get_info()

  state.moon.phase = res.moon_phases[info.moon_phase].english
  state.moon.percent = info.moon
end

function bgs_get_moon_phase()
  return state.moon.phase
end

function bgs_get_moon_percent()
  return state.moon.percent
end

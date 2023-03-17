-------------------------------------------------------
-- Windower Reference
-- https://docs.windower.net/addons/gearswap/reference/
-- https://github.com/Windower/Lua/wiki/Events
-------------------------------------------------------

include("bits-gs/common/state")
include("bits-gs/common/cancel-buffs")
include("bits-gs/common/debug")
include("bits-gs/common/logging")
include("bits-gs/common/recast-times")
include("bits-gs/common/weather")

bgs_log_info("Loaded!")

-- variables
local lastTime = os.time()

-----------------------
-- PREDEFINED FUNCTIONS
-----------------------

function get_sets()
  send_command("bind f10 input /heal")
  send_command("bind f11 fillmode")

  bgs_get_sets()
end

function pretarget(spell)
  bgs_pretarget(spell)
end

function precast(spell, position)
  bgs_cancel_buffs(spell)
  bgs_precast(spell, position)
end

function midcast(spell)
  bgs_midcast(spell)
end

function aftercast(spell)
  bgs_aftercast(spell)
end

function status_change(new, old)
  bgs_update_player_status_change(new, old)
  bgs_status_change(new, old)
end

function pet_change(pet, gain)
  bgs_pet_change(pet, gain)
end

function pet_midcast(spell)
  bgs_pet_midcast(spell)
end

function pet_aftercast(spell)
  bgs_pet_aftercast(spell)
end

function pet_status_change(new, old)
  bgs_pet_status_change(new, old)
end

function filtered_action(spell)
  bgs_filtered_action(spell)
end

function sub_job_change(new, old)
  bgs_sub_job_change(new, old)
end

function buff_change(name, gain, buff_details)
  bgs_buff_change(name, gain, buff_details)
end

function buff_refresh(name, buff_details)
  bgs_buff_refresh(name, buff_details)
end

function self_command(command)
  bgs_self_command(command)
end

---------------
-- EVENTS FIRED
---------------

windower.register_event('prerender', function()
  local tempTime = os.time()

  if tempTime > lastTime then
    bgs_decrement_recast_timers()
    bgs_update_player_party_status()
    bgs_update_city()
    bgs_update_moon()
    bgs_time_change()

    -- make sure lastTime is updated
    lastTime = tempTime
  end
end)

-------------------------
-- USER DEFINED OVERRIDES
-------------------------

function bgs_get_sets()
  bgs_log_debug("bgs_get_sets()")
end

function bgs_pretarget(spell)
  bgs_log_debug("bgs_pretarget(): " .. spell.english)
  -- cancel_spell()
  -- change_target()
end

function bgs_precast(spell, position)
  bgs_log_debug("bgs_precast(): " .. spell.english)
  -- cancel_spell()
  -- verify_equip()
  -- force_send()
  -- cast_delay()
end

function bgs_midcast(spell)
  bgs_log_debug("bgs_midcast(): " .. spell.english)
end

function bgs_aftercast(spell)
  bgs_log_debug("bgs_aftercast(): " .. spell.english)
end

function bgs_status_change(new, old)
  bgs_log_debug("bgs_status_change(): new: " .. new .. " old: " .. old)
end

function bgs_pet_change(pet, gain)
  bgs_log_debug("bgs_pet_change()")
  -- pet is a table
  -- gain = summoned (true) or dismissed (false)
end

function bgs_pet_midcast(spell)
  bgs_log_debug("bgs_pet_midcast(): " .. spell.english)
end

function bgs_pet_aftercast(spell)
  bgs_log_debug("bgs_pet_aftercast(): " .. spell.english)
end

function bgs_pet_status_change(new, old)
  bgs_log_debug("bgs_pet_status_change(): new: " .. new .. " old: " .. old)
end

function bgs_filtered_action(spell)
  bgs_log_debug("bgs_filtered_action(): " .. spell.english)
  -- cancel_spell()
end

function bgs_sub_job_change(new, old)
  bgs_log_debug("bgs_sub_job_change(): new: " .. new .. " old: " .. old)
end

function bgs_buff_change(name, gain, buff_details)
  bgs_log_debug("bgs_buff_change(): " .. name)
  -- gain = true or false
  -- buff_details = table
end

function bgs_buff_refresh(name, buff_details)
  bgs_log_debug("bgs_buff_refresh(): " .. name)
  -- buff_details = table
end

function bgs_self_command(command)
  -- command = //gs c <command>
  bgs_log_debug("bgs_self_command(): " .. command)
end

function bgs_time_change()
  bgs_log_debug("bgs_time_change()")
end

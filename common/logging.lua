function bgs_log_error(msg)
  bgs_log_base(123, msg)
end

function bgs_log_warning(msg)
  bgs_log_base(67, msg)
end

function bgs_log_debug(msg)
  if state.debug_mode then
    bgs_log_base(67, msg)
  end
end

function bgs_log_info(msg)
  bgs_log_base(15, msg)
end

function bgs_log_base(color, msg)
  add_to_chat(color, "[BGS] ".. msg)
end

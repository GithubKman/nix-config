function mute()
  local win = hl.get_active_window()
  if not win then
    return
  end
  local pid = win.pid
  local cmd = string.format(
    "tree() { for c in $(pgrep -P \"$1\" 2>/dev/null); do printf '%%s\\n' \"$c\"; tree \"$c\"; done; }\n"
    .. "for p in $(printf '%%s\\n' %d; tree %d); do wpctl set-mute -p \"$p\" toggle 2>/dev/null; done",
    pid, pid
  )
  hl.exec_cmd(cmd)
end
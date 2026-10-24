#!/bin/bash
set -euo pipefail

export DISPLAY=:1

readonly BROWSER_USER='browser'
readonly BROWSER_HOME="/home/$BROWSER_USER"
readonly NOVNC_PORT=6080
readonly PROFILE_DIR="$BROWSER_HOME/.mozilla/firefox/bb"
readonly VNC_PASSWORD_FILE="$BROWSER_HOME/.vnc/passwd"
readonly VNC_PORT=5900
readonly WARSAW_CORE='/usr/local/bin/warsaw/core'

apply_host_ids() {
  groupmod -g "$USER_GID" "$BROWSER_USER"
  usermod -u "$USER_UID" -g "$USER_GID" "$BROWSER_USER"
}

as_user() {
  runuser -u "$BROWSER_USER" -- env HOME="$BROWSER_HOME" DISPLAY="$DISPLAY" LANG="$LANG" \
    XDG_RUNTIME_DIR="$(runtime_dir)" "$@"
}

create_runtime_dir() {
  install -d -o "$BROWSER_USER" -g "$BROWSER_USER" -m 700 "$(runtime_dir)"
}

main() {
  remove_stale_locks
  apply_host_ids
  create_runtime_dir
  write_vnc_password
  start_vnc
  as_user openbox &
  as_user mkdir -p "$PROFILE_DIR"
  start_warsaw
  start_novnc
  run_browser
}

remove_stale_locks() {
  rm -f "/tmp/.X${DISPLAY#:}-lock" "/tmp/.X11-unix/X${DISPLAY#:}" "$PROFILE_DIR/lock" \
    "$PROFILE_DIR/.parentlock"
}

run_browser() {
  as_user firefox-esr --profile "$PROFILE_DIR" "$START_URL"
}

runtime_dir() {
  echo "/run/user/$(id -u "$BROWSER_USER")"
}

start_novnc() {
  websockify --web /usr/share/novnc "$NOVNC_PORT" "localhost:$VNC_PORT" > /dev/null 2>&1 &
}

start_vnc() {
  as_user Xvnc "$DISPLAY" -geometry "$RESOLUTION" -depth 24 -rfbport "$VNC_PORT" -localhost \
    -SecurityTypes VncAuth -PasswordFile "$VNC_PASSWORD_FILE" -AlwaysShared &
  wait_for_display
}

start_warsaw() {
  "$WARSAW_CORE"
  as_user "$WARSAW_CORE"
}

wait_for_display() {
  local attempt
  for attempt in $(seq 50); do
    [ -S "/tmp/.X11-unix/X${DISPLAY#:}" ] && return 0
    sleep 0.2
  done
  echo 'X server did not start' >&2
  return 1
}

write_vnc_password() {
  : "${VNC_PASSWORD:?VNC_PASSWORD must be set}"
  install -d -o "$BROWSER_USER" -g "$BROWSER_USER" -m 700 "$(dirname "$VNC_PASSWORD_FILE")"
  printf '%s\n' "$VNC_PASSWORD" | vncpasswd -f > "$VNC_PASSWORD_FILE"
  chown "$BROWSER_USER:$BROWSER_USER" "$VNC_PASSWORD_FILE"
  chmod 600 "$VNC_PASSWORD_FILE"
}

main

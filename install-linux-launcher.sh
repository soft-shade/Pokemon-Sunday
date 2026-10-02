#!/bin/sh
# Adds the game to the Linux app menu / dock with its own icon, and gives the launcher file the
# game icon in the file manager. Run it from anywhere:
#     sh install-linux-launcher.sh               install
#     sh install-linux-launcher.sh --pin-class   install, with a window class of its own
#     sh install-linux-launcher.sh --remove      undo
#
# Why it is needed: the engine's "iconPath" (mkxp.json) is only an X11 window-icon hint. Under
# Wayland the app menu, dock and taskbar take the icon from a .desktop file whose StartupWMClass
# matches the window's class, and the file manager takes it from a per-user attribute.
# The game's window class is the launcher's file name, however it was started (app menu, file
# manager, a shell alias), so by default the entry claims exactly that class. Two copies of the
# game share the file name, so only one of them can own it; give the other one --pin-class: its
# menu entry then starts the game with a class of its own (SDL_VIDEO_X11_WMCLASS) and keeps its
# own icon, for launches from the app menu.
set -e
ROOT=$(cd "$(dirname "$0")" && pwd)
LAUNCHER="$ROOT/Pokemon Sunday (Linux)"
ICON="$ROOT/Graphics/Icon.png"
ID=$(basename "$ROOT" | tr 'A-Z ' 'a-z-')
TITLE=$(sed -n 's/^Title=//p' "$ROOT/Game.ini" 2>/dev/null | tr -d '\r' | head -n 1)
[ -n "$TITLE" ] || TITLE="Pokemon Sunday"
# The folder name is part of the menu entry so two installed copies can be told apart.
LABEL="$TITLE ($(basename "$ROOT"))"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
APPS="$DATA/applications"
ICONS="$DATA/icons/hicolor/256x256/apps"
PIN=no
[ "$1" = "--pin-class" ] && PIN=yes
if [ "$1" = "--remove" ]; then
  rm -f "$APPS/$ID.desktop" "$ICONS/$ID.png"
  command -v gio >/dev/null && gio set -t unset "$LAUNCHER" metadata::custom-icon 2>/dev/null || true
  echo "removed $ID"; exit 0
fi
[ -f "$LAUNCHER" ] || { echo "no launcher at $LAUNCHER" >&2; exit 1; }
[ -f "$ICON" ] || { echo "no icon at $ICON" >&2; exit 1; }
mkdir -p "$APPS" "$ICONS"
cp "$ICON" "$ICONS/$ID.png"
if [ "$PIN" = yes ]; then
  EXEC="env SDL_VIDEO_X11_WMCLASS=$ID \"$LAUNCHER\""
  WMCLASS="$ID"
else
  EXEC="\"$LAUNCHER\""
  WMCLASS=$(basename "$LAUNCHER")
fi
cat > "$APPS/$ID.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=$LABEL
Exec=$EXEC
Path=$ROOT
Icon=$ICONS/$ID.png
Terminal=false
Categories=Game;RolePlaying;
StartupWMClass=$WMCLASS
DESKTOP
command -v gio >/dev/null && gio set "$LAUNCHER" metadata::custom-icon "file://$ICON" || true
command -v gtk-update-icon-cache >/dev/null && gtk-update-icon-cache -f -t "$DATA/icons/hicolor" >/dev/null 2>&1 || true
command -v update-desktop-database >/dev/null && update-desktop-database "$APPS" >/dev/null 2>&1 || true
echo "installed $APPS/$ID.desktop"

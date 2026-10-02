#!/bin/sh
# Adds the game to the Linux app menu / dock with its own icon, and gives the launcher file the
# game icon in the file manager. Run it from anywhere:
#     sh install-linux-launcher.sh            install
#     sh install-linux-launcher.sh --remove   undo
#
# Why it is needed: the engine's "iconPath" (mkxp.json) is only an X11 window-icon hint. Under
# Wayland the app menu, dock and taskbar take the icon from a .desktop file whose StartupWMClass
# matches the window's class, and the file manager takes it from a per-user attribute. The entry
# pins the window class (SDL_VIDEO_X11_WMCLASS), so two copies of the game installed side by side
# keep their own icons.
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
if [ "$1" = "--remove" ]; then
  rm -f "$APPS/$ID.desktop" "$ICONS/$ID.png"
  command -v gio >/dev/null && gio set -t unset "$LAUNCHER" metadata::custom-icon 2>/dev/null || true
  echo "removed $ID"; exit 0
fi
[ -f "$LAUNCHER" ] || { echo "no launcher at $LAUNCHER" >&2; exit 1; }
[ -f "$ICON" ] || { echo "no icon at $ICON" >&2; exit 1; }
mkdir -p "$APPS" "$ICONS"
cp "$ICON" "$ICONS/$ID.png"
cat > "$APPS/$ID.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=$LABEL
Exec=env SDL_VIDEO_X11_WMCLASS=$ID "$LAUNCHER"
Path=$ROOT
Icon=$ICONS/$ID.png
Terminal=false
Categories=Game;RolePlaying;
StartupWMClass=$ID
DESKTOP
command -v gio >/dev/null && gio set "$LAUNCHER" metadata::custom-icon "file://$ICON" || true
command -v gtk-update-icon-cache >/dev/null && gtk-update-icon-cache -f -t "$DATA/icons/hicolor" >/dev/null 2>&1 || true
command -v update-desktop-database >/dev/null && update-desktop-database "$APPS" >/dev/null 2>&1 || true
echo "installed $APPS/$ID.desktop"

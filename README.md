# Pokémon Sunday 3.0.3

A fan game built on Pokémon Essentials v21.1, with Elite Battle: DX and
Following Pokémon EX. Kiraki is its own region: sixteen routes, eight gyms,
an Elite Four, a Battle Tower, and twenty-three Pokémon original to the game
alongside the full national dex through Generation 9.

This is the **play** repository. It holds only what the game reads when it
runs. The project itself — the PBS data, the plugin sources and the tools —
lives separately.

## Playing

Windows only for now.

**Just want to play:** click the green **Code** button above, then
**Download ZIP**, and unzip it. Then run the launcher for your system, all
three of which sit in the folder beside the game:

| | |
|---|---|
| Windows | **Pokémon Sunday (Windows).exe** |
| Linux | **Pokemon Sunday (Linux)** |
| macOS | **Pokemon Sunday (macOS).app** |

**macOS, first run only.** The app is not signed, so macOS refuses it and says
it is damaged. It is not. Open **System Settings → Privacy & Security**, scroll
to the bottom and press **Open Anyway**. Also move the folder somewhere other
than Downloads first — the app deliberately will not start from there.

**Want quick updates:** clone it instead, and updates become a `git pull`
that downloads only what changed rather than the whole game again.

```
git clone --depth 1 https://github.com/soft-shade/Pokemon-Sunday.git
```

Then to update, from inside that folder:

```
git pull
```

## Your saves are safe

Saves are not kept in this folder, so updating never touches them. They live in

```
%APPDATA%\Pokemon Sunday 3.0\
```

The game keeps every past save. Saving archives the file it replaces under the
character's own name and the time it was written, and **Load Game** on the
title screen lists them by character. Starting a new game over an old one does
not destroy it any more.

There is an optional **Autosave** in Options, off by default. It saves after
battles, which does mean a battle can overwrite the file you were relying on —
the state it replaces is kept as that character's autosave slot.

## Reporting a problem

Open an issue here, and say what you were doing and where. If the game raised
an error, the text of it helps enormously; there is also an `errorlog.txt` in
the save folder above.

## Credits

`credits.txt` in this folder lists everyone whose work is in the game — the
Essentials community, the plugin authors, the sprite and animation projects,
and the music. Pokémon is Nintendo / Creatures / GAME FREAK's. This is a free
fan project, not affiliated with them, and is not for sale.

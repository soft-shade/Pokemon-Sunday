# Pokémon Sunday 3.1.11

A fan game built on Pokémon Essentials v21.1, 

# Playing

Runs on Windows, Mac, Linux and Android.

Just want to play: click the green Code button above, then
Download ZIP, and unzip it. Then run the launcher for your system. The
three desktop launchers sit in the folder beside the game:

| | |
|---|---|
| Windows | **Pokémon Sunday (Windows).exe** |
| Linux | **Pokemon Sunday (Linux)** |
| macOS | **Pokemon Sunday (macOS).app** |
| Android | open the unzipped folder in **JoiPlay** |

macOS, first time you run: The app is not signed, so macOS refuses it and says
it is damaged. It is not. Open System Settings; Privacy & Security, scroll
to the bottom and press Open Anyway. Also move the folder somewhere other
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


Saves are not kept in this folder, so updating never breaks them. They live in

```
%APPDATA%\Pokemon Sunday 3.0\
```

The game keeps every past save. Saving archives the file it replaces under the
character's own name and the time it was written, and Load Game on the
title screen lists them by character. Starting a new game over an old one does
not destroy it any more.

There is an optional Autosave in Options, off by default. It saves after
battles, which does mean a battle can overwrite the file you were relying on —
the state it replaces is kept as that character's autosave slot.

## Reporting a problem

You can open an issue here or report on Discord. Say what you were doing and where when you ran into a bug. If the game raised
an error, the text of it helps enormously; there is also an `errorlog.txt` in
the save folder above.

## Credits

`credits.txt` in this folder lists everyone whose work is in the game. Thank you to the
Essentials community, the plugin authors, the sprite and animation projects, and friends who contributed sprites and music. Pokémon is Nintendo / Creatures / GAME FREAK's. This is a free
fan project, not affiliated with them, and is not for sale.

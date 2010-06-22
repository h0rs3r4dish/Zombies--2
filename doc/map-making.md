Zombies! 2 Map Making
=====================

Maps are easy to make, being only linked rooms described in plain text. This
chapter will describe the options availible to a mapmaker.

Before you begin, every map must be in some kind of campaign. All this requires
is for the map to be stored in a subfolder of `data/maps/`; for example, all of
the legacy maps from Zombies! 1 are in the "legacy" campaign, which can be
found at `data/maps/legacy/`. Maps should be saved as plain text with the `.map`
extension.

The map format is fairly simple, and reads very much like YAML:

	attribute: value
	
For areas, the value is more sets of attributes. You could honestly do that
any way you wanted, but it would be best to indent the sub-elements:

	area XX:
		attribute: value

Maps are described by two main blocks: the map description and a list of areas.

Map Metadata
------------

All of these must be present:

* `start-text` Introductory text for the map. Could be story, or just yelling
  incoherently at the players. Shown before anything happens.
* `objective` Should display the objectives required to win the game in plain
  English.
* `start-location` An area name that the players start in.
* `conditions` Another attribute that has more attributes as values. It should
  contain a list of condition attributes (see below).
  
### Conditions ###

At least one of these is required if you want the players to win. Otherwise,
they will lose eventually and/or get bored. Note that if there are multiple win
conditions, all of them must be true for the players to win.

* `no-zombies-in` A comma-separated list of areas that no zombies may be in for
  the players to win. All of the areas must be cleared at the same time for
  victory to occur.
* `spawn-frequency` A number that determines how many turns it takes for a new
  set of zombies to spawn (in the "spawn-zombies" areas). 5 would mean every 5th
  turn, a new zombie is created.
* `spawn-zombies` A comma-separated list of areas to create a zombie in. They
  spawn as often as specified by the "spawn-frequency" attribute.
* `time-limit` A number that represents the number of player turns the game will
  last. Players cannot win before this many turns pass.

Areas
-----

These should be prefaced by an `area XX` attribute, where XX is a number (of
any length). Only the tags marked by "required" are needed in the description;
all others may be omitted.

* `name` *(required)* Name of the area for the players to read.
* `desc` *(required)* The text to show for the area; a description.
* `zombies` A number (or "none") describing how many zombies should start the
  game in that location.
* `items` A list of items that should be generated in the area. Acceptable
  values are `gun`, `melee`, `ammo`, `gun with ammo` and `weapon`. These item
  types can be prefaced with a number (the 1 is implied), and separated by a
  comma if you want more than one.

Any other attribute is treated as an exit; the value for it should be the
number of another area. Examples include:

	east: 02
	up: 23

Zombies! 2
==========

The successor to the Zombies! IRC game (run by the Quander bot), this is a more
advanced and platform-independant derivative.

If you want to get a feel for the game or learn how to play, see the included
`handbook.md`, which contains the text of "Zombies! 2 Survival Handbook."

Usage
-----

This project isn't meant to be used as-is. Maps should be added, as well as
a decent frontend. There *is* a simple console that can be run via:

	$ ruby bin/console
	
This provides a simple wrapper for the Zombies::Game class, and can be seen as
an example on which to build your own. As long as the provider has access to the
object, any sort of medium can be used for play.


Changes from Zombies! 1
-----------------------

This is by no means a complete list, but it does strive to give an accurate
overview of what you'll be looking at.

* __Revamped damage system__ that is both more concise ("right arm is gone"
  instead of a lot of subparts) and more parts
* __New items__ that you have never seen before -- including automatic weapons!
* __Updated map files__ that are easier to write and read, while still holding
  all the features needed.


Tests
-----

There are some unit tests included that were used while writing the classes. The
code can be found in the `tests/` directory, and they can be run via the `test`
script:

	$ ruby bin/test [name]
	
...Where `name` is one of the tests, or just "all" to run the whole directory.

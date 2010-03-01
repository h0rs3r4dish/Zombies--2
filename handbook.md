Zombies! 2 Survivor's Handbook
==============================

Table of Contents
-----------------

* Introduction
* Day-To-Day Basics
* Equipment
* Appendix A: Preferences
* Appendix B: Map Making


Introduction
------------

Zombies! 2 is a weird kind of game. This guide can't tell you exactly how to
play or how to win. There are a few reasons for this, the biggest being that
there are different ways to play: you could be by yourself at a console, or on-
line via IRC, or on some graphical UI that has yet to be invented. The point is
that while there are no *specific* commands that will work across all of the
clients. This handbook can only give directions and suggestions; refer to the
manual or README for whatever fronted you use.

Maps are another story alltogether. Each map and campaign is different, coded
by some person in a faraway land. There's no way to predict how each one will
need to be won, but there's one sure strategy that holds true across every game.
Zombies! is a *survival* game, which means that you will most certainly lose
if your characters die. Staying alive is one step in the right direction.


Day-To-Day Basics
-----------------

Dealing with zombies is not for the faint of heart. You'll have to encounter a
whole lot of them thoughout your adventures, and it's likely you'll lose a piece
of yourself fighting them. You have to prepare for the worst, which is an idea
you should grasp tightly at all times. This entails:

* Keep yourself well-stocked. This means both ammo (you can never have too much)
  and weapons (why have on machete when you can have two?)
* Watch your entrances and exits. Keep an escape route in mind so when you start
  getting overwhelmed by zombies.
  

Equipment
---------

This is a comprehensive list of all the weapons and items included in the core
backend of Zombies! 2. Modified copies might not stick to this list.

### Melee Weapons

* __Switchblade__ Pretty much a joke of a knife. Don't expect to do any real
  damage with it.
* __Machete__ *This* is a real knife. Decent blade that's a good backup weapon.
* __Axe__ A heftier weapon that hits more often, but with a low critical.
* __Chainsaw__ The ultimate zombie-killing device. High chance of hitting, and
  the highest critical range for any weapon

### Ranged Weapons

* __Pistol__ Your basic weapon, a good sidearm. Not very impressive by any means.
  Fires 9mm bullets.
* __Uzi__ Basically an automatic Pistol, slightly less accurate. Shares 9mm
  rounds with its cousin.
* __Hunting Rifle__ A high-power and accurate rifle that fires .308 Winchester
  bullets.
* __Assualt Rifle__ Less accurate and powerful than the hunting version, this
  rifle is at least automatic. Fires 5.56mm NATO rounds.
* __Shotgun__ The classic gun for any wannabe zombie hunter. High damage and a
  critical that rivals the Chainsaw.
  
### Ammunition

* __9mm rounds__ Low-impact pistol rounds. Used by the Pistol and the Uzi.
* __.308 Winchester rounds__ Low-caliber but high-velocity hunting bullets. The
  Hunting Rifle fires them.
* __5.56mm NATO rounds__ Standard-issue combat ammunition. Fired by the Assault
  Rifle.
* __Buckshot__ 12-gauge shotgun shells that pack a lot of damage into a little
  casing. Only used by the Shotgun.


Appendicies
-----------

### Appendix A: Preferences

Players can set the following preferences for their characters:

* `starting-weapon-class` determines what kind of weapon you want to start with.
  Accepts `random` (default), `melee`, or `ranged`.
  

### Appendix B: Map Making

Maps are easy to make, being only linked rooms described in plain text. This
chapter will describe the options availible to a mapmaker.

Before you begin, every map must be in some kind of campaign. All this requires
is for the map to be stored in a subfolder of `data/maps/`; for example, all of
the legacy maps from Zombies! 1 are in the "legacy" campaign, which can be
found at `data/maps/legacy/`. Maps should be saved as plain text with the `.map`
extension.

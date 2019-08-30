This file holds the tests that you create. Remember to import the python file(s)
you wish to test, along with any other modules you may need.
Run your tests with "python3 ok -t --suite SUITE_NAME --case CASE_NAME -v"

--------------------------------------------------------------------------------
Suite ants
    >>> from ants import *
    >>> hive, layout = Hive(AssaultPlan()), dry_layout
    >>> dimensions = (1, 9)
    >>> colony = AntColony(None, hive, ant_types(), layout, dimensions)
    >>> #

    Case NinjaAnt
        >>> # Testing NinjaAnts do not block bees
        >>> p0 = colony.places["tunnel_0_0"]
        >>> p1 = colony.places["tunnel_0_1"]  # p0 is p1's exit
        >>> bee = Bee(2)
        >>> ninja = NinjaAnt()
        >>> thrower = ThrowerAnt()
        >>> p0.add_insect(thrower)            # Add ThrowerAnt to p0
        >>> p1.add_insect(bee)
        >>> p1.add_insect(ninja)              # Add the Bee and NinjaAnt to p1
        >>> ninja.action(colony)
        >>> bee.armor                         # Did NinjaAnt damage the Bee by 1 armor?
        1
        >>> bee.blocked()                     # Did NinjaAnt block the Bee from moving?
        False
        >>> bee.action(colony)
        >>> bee.place is ninja.place
        False
        >>> bee.place is p0
        True
        >>> ninja.armor
        1
        >>> bee.action(colony)
        >>> bee.place is p0                   # Did ThrowerAnt block the Bee from moving?
        True

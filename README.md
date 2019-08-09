# RimWorld-PatchSpeedTest

RimWorld uses xpath for xml patching.  The xpath documentation seems to specify that using /Defs/etc should be faster than Defs/etc - both of which should be faster than */etc.

But the common policy on the Ludeon Studios forum and in mods in general is that Defs/etc is the way to go.  So, I ask, is this  correct?  Let's find out: I wrote up a little patch speed test.

# Testing!

This is a quick little mod that does 10,000 xpath Replace operations.

# Use

Optionally use the enclosed perl script (probably on Linux) to generate a large number of xpath operations.

Load the mod.

# Results

What *I* found:

 1. Whichever operation is done 10000 times second is generally slower.
 2. /Defs/etc tends to be faster han Defs/etc.
 3. It's a very very small difference.
 4. Even */etc is only a small difference on my system (10%?).

# Conclusions

Use /Defs/

Don't worry about it if you used Defs/




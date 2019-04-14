"SHADOW for
		     Zork III: The Dungeon Master 
		 The Great Underground Empire (Part 3)
	(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.
"

<ROOM CREEPY-CRAWL
      (IN ROOMS)
      (DESC "Creepy Crawl")
      (LDESC
"You are in a dark and quite creepy crawlway with passages leaving to the
north, east, south, and southwest.")
      (FLAGS RLANDBIT)
      (NORTH TO JUNCTION)
      (SOUTH TO FOGGY-ROOM)
      (SW TO SHADOW-1)
      (EAST TO TIGHT-SQUEEZE)
      (ACTION CREEPY-CRAWL-F)>

<ROOM SHADOW-1
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are at the eastern end of a dark, featureless landscape of shallow
hills. Paths to the east and southeast re-enter the rock.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NE "Towering walls of rock bar your way.")
      (NORTH "Towering walls of rock bar your way.")
      (SOUTH TO SHADOW-5)
      (EAST TO CREEPY-CRAWL)
      (NW TO SHADOW-2)
      (WEST TO SHADOW-3)
      (SW TO SHADOW-4)
      (SE TO FOGGY-ROOM)>

<ROOM SHADOW-2
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are in a shadowy land of low, rolling hills stretching out to the west
and south. The land is bordered to the north by a massive stone wall.
Ancient and weathered, the wall has crumbled enough at one point to permit
passage.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NE "A stone wall blocks the way.")
      (NORTH TO CLEARING)
      (NW "A stone wall blocks the way.")
      (SE TO SHADOW-1)
      (SW TO SHADOW-7)
      (SOUTH TO SHADOW-3)
      (WEST TO SHADOW-8)
      (EAST TO SHADOW-1)
      (GLOBAL RUBBLE STONE-WALL)>

<ROOM SHADOW-3
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are in a dark and shadowy land. All around you are gentle hills and
eerie shadows. Far above, shrouded in mist, you can barely make out the
ceiling of the enormous cavern that spans this entire land.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (PSEUDO "MIST" MIST-PSEUDO)
      (NW TO SHADOW-8)
      (NE TO SHADOW-1)
      (SE TO SHADOW-1)
      (SW TO SHADOW-6)
      (NORTH TO SHADOW-2)
      (SOUTH TO SHADOW-4)
      (WEST TO SHADOW-7)
      (EAST TO SHADOW-1)>

<ROOM SHADOW-4
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are in an ominously dark land of rolling hills. The ground becomes
softer to the south.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NORTH TO SHADOW-3)
      (EAST TO SHADOW-1)
      (NE TO SHADOW-1)
      (SE TO SHADOW-5)
      (SOUTH TO SHADOW-5)
      (SW "The ground becomes too soft to walk on in that direction.")
      (WEST TO SHADOW-6)
      (NW TO SHADOW-7)>

<ROOM SHADOW-5
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are at the southern end of a shadowy land. The ground here is quite
soft, and the area is surrounded by quicksand on most sides. North of here
is a terrain of shallow hills.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (PSEUDO "QUICKS" QUICKSAND-PSEUDO)
      (NORTH TO SHADOW-4)
      (NW TO SHADOW-6)
      (NE TO SHADOW-1)
      (SE "The quicksand prevents movement in that direction.")
      (WEST "The quicksand prevents movement in that direction.")
      (SOUTH "The quicksand prevents movement in that direction.")
      (SW "The quicksand prevents movement in that direction.")
      (EAST "The quicksand prevents movement in that direction.")>

<ROOM SHADOW-6
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are near the southern end of the land of shadow. The ground here is
soft and spongy, and it becomes quicksand to the south. North and east of here
are gentle, rolling hills. A gentle sea breeze wafts over a steeply sloping
path to the west.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NORTH TO SHADOW-7)
      (NW TO FLATHEAD-OCEAN)
      (WEST TO FLATHEAD-OCEAN)
      (DOWN TO FLATHEAD-OCEAN)
      (SE TO SHADOW-5)
      (EAST TO SHADOW-4)
      (NE TO SHADOW-3)
      (SOUTH "The quicksand prevents movement in that direction.")
      (SW "The quicksand prevents movement in that direction.")
      (PSEUDO "QUICKS" QUICKSAND-PSEUDO)>

<ROOM SHADOW-7
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are in a land of dark shadows and shallow hills, which stretch out in all
directions. To the west, the land dips sharply.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (NE TO SHADOW-2)
      (EAST TO SHADOW-3)
      (SE TO SHADOW-4)
      (SOUTH TO SHADOW-6)
      (NORTH TO SHADOW-8)
      (DOWN TO FLATHEAD-OCEAN)
      (NW TO FLATHEAD-OCEAN)
      (WEST TO FLATHEAD-OCEAN)
      (SW TO FLATHEAD-OCEAN)>

<ROOM SHADOW-8
      (IN ROOMS)
      (DESC "Land of Shadow")
      (LDESC
"You are standing atop a steep cliff, looking west over a vast ocean.
Far below, the surf pounds at a sandy beach. To the south and east are
rolling hills filled with eerie shadows. A path cut into the face of the
cliff descends toward the beach. To the north is a tall stone wall,
which ends at the cliff edge. It was obviously built long ago, and
directly north is a spot where you could climb over the rubble of the
decaying wall.")
      (FLAGS RLANDBIT)
      (ACTION SHADOW-ROOMS)
      (SOUTH TO SHADOW-7)
      (EAST TO SHADOW-2)
      (SE TO SHADOW-3)
      (SW TO FLATHEAD-OCEAN)
      (WEST TO FLATHEAD-OCEAN)
      (NE "A stone wall blocks the way.")
      (NW "A stone wall blocks the way.")
      (DOWN TO FLATHEAD-OCEAN)
      (NORTH TO CLIFF)
      (GLOBAL RUBBLE STONE-WALL)>

<ROOM FLATHEAD-OCEAN
      (IN ROOMS)
      (DESC "Flathead Ocean")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO CLIFF-BASE)
      (ENTER"Between the rocks, wind, and waves, you wouldn't last a minute.")
      (WEST "Between the rocks, wind, and waves, you wouldn't last a minute.")
      (SW "Between the rocks, wind, and waves, you wouldn't last a minute.")
      (NW "Between the rocks, wind, and waves, you wouldn't last a minute.")
      (ACTION FLATHEAD-OCEAN-F)
      (SE TO SHADOW-6)
      (NE TO SHADOW-8)
      (EAST TO SHADOW-7)
      (SOUTH "The quicksand prevents movement here.")
      (PSEUDO "QUICKS" QUICKSAND-PSEUDO "MIST" MIST-PSEUDO)>

<OBJECT SHADOW
	(DESC "hooded figure")
	(SYNONYM SHADOW FIGURE MAN WOMAN)
	(ADJECTIVE HOODED CLOAKED)
	(FLAGS ACTORBIT TRANSBIT CONTBIT OPENBIT)
	(ACTION SHADOW-F)
	(DESCFCN SHADOW-F)>

<OBJECT HOOD
	(IN SHADOW)
	(DESC "hood")
	(SYNONYM HOOD)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT WEARBIT)
	(ACTION HOOD-F)>

<OBJECT CLOAK
	(IN SHADOW)
	(DESC "cloak")
	(SYNONYM CLOAK)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT WEARBIT)
	(ACTION CLOAK-F)>
	
<GLOBAL DIRS
	<LTABLE P?NORTH "north" P?SOUTH "south" P?EAST "east" P?WEST "west"
		P?NW "northwest" P?NE "northeast" P?SE "southeast"
		P?SW "southwest" P?UP "stairs" P?DOWN "stairs">>

<GLOBAL DIR-TBL <TABLE 0 0 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE PICK-DIRECTION (RM "AUX" (NXT 0) (CNT 0) (OFFS 0))
	 <REPEAT ()
		 <COND (<==? <SET NXT <NEXTP .RM .NXT>> 0>
			<RETURN>)
		       (<NOT <L? .NXT ,LOW-DIRECTION>>
			<COND (<NOT <EQUAL? .NXT ,P?UP ,P?DOWN>>
			       <SET OFFS <+ .OFFS 1>>
			       <PUT ,DIR-TBL .OFFS .NXT>
			       <SET CNT <+ .CNT 1>>)>)>>
	 <GET ,DIR-TBL <RANDOM .CNT>>>
	
<ROUTINE SHADOW-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<NOT ,BLOCKED-DIR>
		       <SETG BLOCKED-DIR <PICK-DIRECTION ,HERE>>)>
		<TELL
"A cloaked and hooded person, carrying a sword not unlike your own,">
		<COND (<G? ,S-STRENGTH 3>
		       <TELL "
is standing blocking the way to the ">
		       <TELL <LKP ,BLOCKED-DIR ,DIRS> "." CR>)
		      (T <TELL "
is here." CR>)>
		<TELL "The hooded figure" <GET ,SHADOW-DIAG ,S-STRENGTH> CR>)
	       (<AND <VERB? GIVE> <==? ,PRSI ,SHADOW>>
		<TELL
"The hooded figure isn't interested in your gifts." CR>)
	       (<HELLO? ,SHADOW>
		<TELL
"The hooded figure does not respond to your words." CR>)
	       (<AND <VERB? ATTACK> <==? ,PRSI ,SWORD>>
		<COND (<NOT ,SHADOW-POINT-2>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG SHADOW-POINT-2 T>)>
		<SHADOW-ATTACK>)
	       (<VERB? ATTACK>
		<TELL
"The hooded figure ignores your feeble attack." CR>
		<SETG ATTACK-MODE T>
		<ENABLE <QUEUE I-CURE 10>>
		<ENABLE <QUEUE I-SHADOW-REPLY -1>>)>>

<GLOBAL SHADOW-DIAG
	<TABLE
"?"
" appears to be badly hurt and defenseless."
" is hurt, and its strength appears to be fading."
" has some wounds and is probably not capable of hindering your movement."
" has a light wound which hasn't affected its seemingly great strength."
" has a great deal of strength, perhaps matching your own.">>

<GLOBAL P-STRENGTH 5>
<GLOBAL S-STRENGTH 5>

<GLOBAL ATTACK-MODE <>>
<GLOBAL SHADOW-GONE <>>

<ROUTINE I-CURE ()
	 <COND (<NOT <==? ,P-STRENGTH 5>>
		<SETG P-STRENGTH <+ ,P-STRENGTH 1>>)>
	 <COND (<NOT <==? ,S-STRENGTH 5>>
		<SETG S-STRENGTH <+ ,S-STRENGTH 1>>)>
	 <COND (<NOT <==? <+ ,P-STRENGTH ,S-STRENGTH> 10>>
		<QUEUE I-CURE 10>)>
	 <RFALSE>>
		      
<ROUTINE SHADOW-ATTACK ()
	 <COND (<NOT ,ATTACK-MODE>
		<ENABLE <QUEUE I-CURE 10>>
		<SETG ATTACK-MODE T>
		<ENABLE <QUEUE I-SHADOW-REPLY -1>>)>
	 <COND (<PROB <+ <* ,P-STRENGTH 10> 10>>
		<COND (<PROB 85>
		       <SETG S-STRENGTH <- ,S-STRENGTH 1>>
		       <COND (<0? ,S-STRENGTH>
			      <SHADOW-DIES>
			      <RTRUE>)>
		       <TELL <RANDOM-ELEMENT ,P-HITS> CR>
		       <TELL "The figure" <GET ,SHADOW-DIAG ,S-STRENGTH> CR>)
		      (T
		       <SETG S-STRENGTH <- ,S-STRENGTH 2>>
		       <COND (<0? ,S-STRENGTH> <SETG S-STRENGTH 1>)
			     (<L? ,S-STRENGTH 1>
			      <SHADOW-DIES>
			      <RTRUE>)>
		       <TELL
"A sharp thrust and the hooded figure is badly wounded!" CR>
		       <TELL "The figure" <GET ,SHADOW-DIAG ,S-STRENGTH> CR>)>)
	       (T
		<COND (<L? ,S-STRENGTH 2>
		       <TELL
"Your opponent blocks your attack with its sword." CR>)
		      (T <TELL <RANDOM-ELEMENT ,P-MISSES> CR>)>)>>

<GLOBAL P-HITS <LTABLE
"A good parry! Your sword wounds the hooded figure!"
"A quick stroke catches the hooded figure off guard! Blood trickles
down the figure's arm!"
"The hooded figure is hit with a quick slash!">>

<GLOBAL P-MISSES <LTABLE
"Your move was not quick enough and misses the mark."
"A quick stroke, but the hooded figure is on guard."
"A good stroke, but it's too slow."
"A good slash, but it misses by a mile."
"You charge, but the hooded figure jumps nimbly aside.">>

<GLOBAL S-HITS <LTABLE
"The hooded figure catches you off guard and wounds you!"
"You are wounded by a lightning thrust!"
"Your quick reflexes cannot stop the hooded figure's stroke! You are hit!">>

<ROUTINE I-SHADOW-REPLY ()
	 <COND (<OR <NOT ,ATTACK-MODE> <NOT <IN? ,SHADOW ,HERE>>>
                <QUEUE I-SHADOW-REPLY 0>
		<SETG ATTACK-MODE <>>
		<RFALSE>)>
	 <COND (<AND <PROB <+ <* ,S-STRENGTH 10> 10>> <G? ,S-STRENGTH 1>>
		<COND (<PROB 90>
		       <COND (<L? <SETG P-STRENGTH <- ,P-STRENGTH 1>> 1>
			      <SETG P-STRENGTH 1>
			      <TELL
"The hooded figure swings its sword and sends yours flying to the ground.
Although you are defenseless, the figure reaches for your sword and hands it
back to you, nodding grimly." CR>)
			     (T
			      <TELL <RANDOM-ELEMENT ,S-HITS> CR>)>)
		      (T
		       <COND (<L? <SETG P-STRENGTH <- ,P-STRENGTH 2>> 1>
			      <JIGS-UP
"In your wounded state, you cannot defend yourself against your still-quick
opponent. Slowly and carefully, the figure starts to remove its hood as you
fall to the ground, dead.">)
			     (T
			      <TELL
"A brilliant feint puts you off guard, and the hooded figure slips its
sword between your ribs. You are hurt very badly." CR>)>)>)
	       (<L? ,S-STRENGTH 3>
		<TELL
"The hooded figure attempts a thrust, but its weakened state prevents
hitting you." CR>)
	       (T
		<TELL <RANDOM-ELEMENT ,S-MISSES> CR>)>>

<GLOBAL S-MISSES <LTABLE
"The hooded figure stabs nonchalantly with its sword and misses."
"You dodge as the hooded figure comes in low."
"The hooded figure tries to sneak past your guard, but you twist away."
"The hooded figure thrusts, but you fight back and send it
flying to the ground!">>

<ROUTINE SHADOW-DIES ()
	 <TELL
"The hooded figure, fatally wounded, slumps to the ground. It gazes up at
you once, and you catch a brief glimpse of deep and sorrowful eyes. Before
you can react, the figure vanishes in a cloud of fetid vapor." CR>
	 <REMOVE ,SHADOW>
	 <SETG SHADOW-GONE T>
	 <SETG BLOCKED-DIR <>>>

<ROUTINE HOOD-F ()
	 <COND (<AND <VERB? LOOK-UNDER> <IN? ,HOOD ,SHADOW>>
		<TELL
"The figure's hood casts a dark shadow over its face. There is no way from
where you stand to look beneath it." CR>)
	       (<AND <VERB? TAKE PUT> <IN? ,HOOD ,SHADOW>>
		<COND (<==? ,S-STRENGTH 1>
		       <TELL
"You slowly remove the hood from your badly wounded opponent and recoil
in horror at the sight of your own face, weary and wounded. A faint
smile comes to the lips and then the face starts to change, very slowly,
into that of an old, wizened person. The image fades and with it the body
of your hooded opponent. The cloak remains on the ground." CR>
		       <REMOVE ,SHADOW>
		       <SETG SHADOW-GONE T>
		       <MOVE ,HOOD ,WINNER>
		       <FCLEAR ,HOOD ,NDESCBIT>
		       <MOVE ,CLOAK ,HERE>
		       <FCLEAR ,CLOAK ,NDESCBIT>)
		      (<==? ,S-STRENGTH 2>
		       <TELL
"The hooded figure, though recovering from wounds, is strong enough to
force you back." CR>)
		      (T
		       <TELL
"You cannot get close enough to the hooded figure to remove the hood." CR>)>)>>

<ROUTINE CLOAK-F ()
	 <COND (<AND <VERB? LOOK-UNDER> <IN? ,CLOAK ,SHADOW>>
		<TELL
"You cannot get close enough to look underneath the cloak." CR>)
	       (<AND <VERB? TAKE> <IN? ,CLOAK ,SHADOW>>
		<TELL
"The cloak is fastened around the neck of the hooded figure. It would be
difficult to remove." CR>)>>

<GLOBAL BLOCKED-DIR <>>

<ROUTINE SHADOW-ROOMS (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? WALK>
		     <==? ,PRSO ,BLOCKED-DIR>>
		<TELL "Your way is blocked by the hooded figure." CR>)
	       (<==? .RARG ,M-END>
		<COND (<NOT <IN? ,SHADOW ,HERE>>
		       <SETG BLOCKED-DIR <>>
		       <REMOVE ,SHADOW>)>
		<COND (,SHADOW-GONE <RFALSE>)
		      (<IN? ,SHADOW ,HERE>
		       <COND (<AND <PROB 30> <NOT ,ATTACK-MODE>>
			      <SETG ATTACK-MODE T>
			      <ENABLE <QUEUE I-CURE 10>>
			      <ENABLE <QUEUE I-SHADOW-REPLY -1>>)>)
		      (<PROB 30>
		       <TELL
"You can hear quiet footsteps nearby." CR>)
		      (<AND <PROB 30> ,LIT <G? ,S-STRENGTH 3>>
		       <SETG BLOCKED-DIR <PICK-DIRECTION ,HERE>>
		       <TELL
"Through the shadows, a cloaked and hooded figure appears before you,
blocking the ">
		       <TELL <LKP ,BLOCKED-DIR ,DIRS>
			     "ern exit from the room and carrying a
brightly glowing sword." CR>
		       <SHADOW-ARRIVAL>
		       <RTRUE>)>)>>

<ROUTINE SHADOW-ARRIVAL ()
	 <MOVE ,SHADOW ,HERE>
	 <COND (<NOT ,SHADOW-POINT-1>
		<SETG SCORE <+ ,SCORE 1>>
		<SETG SHADOW-POINT-1 T>)>
	 <COND (<NOT <IN? ,SWORD ,WINNER>>
		<MOVE ,SWORD ,WINNER>
		<COND (,SWORD-IN-STONE?
		       <TELL
"From nowhere, the sword from the junction appears in your hand, wildly
glowing!" CR>)
		      (T
		       <TELL
"Your sword, glowing wildly, appears in your hand!" CR>)>
		<SETG SWORD-IN-STONE? <>>)>>

<GLOBAL SHADOW-POINT-1 <>>
<GLOBAL SHADOW-POINT-2 <>>

<ROUTINE CREEPY-CRAWL-F (RARG)
	 <COND (<==? .RARG ,M-END>
		<SETG BLOCKED-DIR <>>
		<RTRUE>)>>

;" Cooperative Problem"

<ROOM ZORK2-STAIR
      (IN ROOMS)
      (DESC "Endless Stair")
      (LDESC
"You are at the bottom of a seemingly endless stair, winding its way
upward beyond your vision. An eerie light, coming from all around you,
casts strange shadows on the walls. To the south is a dark and winding
trail.")
      (FLAGS ONBIT RLANDBIT)
      (NORTH "The stairs are endless.")
      (UP "The stairs are endless.")
      (SOUTH TO JUNCTION)
      (GLOBAL STAIRS)>

<ROOM JUNCTION
      (IN ROOMS)
      (DESC "Junction")
      (LDESC
"You are at the junction of a north-south passage and an east-west
passage. To the north, you can make out the bottom of a stairway. The
ways to the east and south are relatively cramped, but a wider trail
leads to the west.")
      (FLAGS RLANDBIT)
      (WEST TO CLEARING)
      (NORTH TO ZORK2-STAIR)
      (SOUTH TO CREEPY-CRAWL)
      (EAST TO DAMP-PASSAGE)>

<ROOM CLEARING
      (IN ROOMS)
      (DESC "Barren Area")
      (LDESC
"You are west of the junction, where the rock-bound passage widens out
into a large, flat area. Although the land here is barren, you can see
vegetation to the west. South of here is a mighty wall of stone, ancient
and crumbling. To the southwest the wall has decayed enough to form an
opening, through which seeps a thin mist. A trail dips sharply into
rocky terrain to the northwest.")
      (FLAGS RLANDBIT)
      (SW TO SHADOW-2)
      (NW TO SLOPE)
      (SOUTH "A stone wall blocks your way.")
      (SE "A stone wall blocks your way.")
      (WEST TO CLIFF)
      (EAST TO JUNCTION)
      (GLOBAL RUBBLE STONE-WALL)
      (PSEUDO "MIST" MIST-PSEUDO)>

<ROOM SLOPE
      (IN ROOMS)
      (DESC "Hairpin Loop")
      (LDESC
"You are at a sharp turn on a narrow and steeply sloping path, strewn
with boulders of various sizes. The path climbs sharply toward a
desolate plain to the southeast. Southwest of here the path winds down
to the base of a cliff.")
      (SE TO CLEARING)
      (UP TO CLEARING)
      (SW TO CLIFF-BASE)
      (DOWN TO CLIFF-BASE)
      (GLOBAL RUBBLE)
      (FLAGS RLANDBIT)>

<ROOM CLIFF-BASE
      (IN ROOMS)
      (DESC "Cliff Base")
      (LDESC
"You are at the base of a steep cliff. Directly above you is a wide
ledge and far above that some natural sunlight can be seen. To the
northeast is a steeply climbing path and the ground becomes sandy toward
the south.")
      (FLAGS ONBIT RLANDBIT)
      (UP "You can't get up the rock face.")
      (SOUTH TO FLATHEAD-OCEAN)
      (NE TO SLOPE)
      (GLOBAL LEDGE)>

<ROOM CLIFF
      (IN ROOMS)
      (DESC "Cliff")
      (FLAGS ONBIT RLANDBIT)
      (DOWN TO CLIFF-LEDGE IF ROPE-FLAG ELSE "The drop would kill you.")
      (UP "There's no tree here suitable for climbing.")
      (SW TO SHADOW-8)
      (EAST TO CLEARING)
      (ACTION CLIFF-F)
      (GLOBAL GLOBAL-MAN RUBBLE STONE-WALL CLIFF-OBJECT)
      (PSEUDO "MIST" MIST-PSEUDO)>

<ROOM CLIFF-LEDGE
      (IN ROOMS)
      (DESC "Cliff Ledge")
      (FLAGS ONBIT RLANDBIT)
      (UP "You attempt the climb but slide back down.")
      (DOWN TO CLIFF-BASE)
      (ACTION CLIFF-LEDGE-F)
      (GLOBAL RUBBLE GLOBAL-ROPE GLOBAL-MAN LEDGE CLIFF-OBJECT)>

<ROOM FOGGY-ROOM
      (IN ROOMS)
      (DESC "Foggy Room")
      (LDESC
"You are in a dank passage filled with a wispy fog. A spooky passageway
leads north and a wider path heads off to the south. To the west, the
path leaves the rock and enters an eerie, shadowy land.")
      (NORTH TO CREEPY-CRAWL)
      (SOUTH TO LAKE-SHORE)
      (WEST TO SHADOW-1)
      (FLAGS RLANDBIT)>

<ROOM LAKE-SHORE
      (IN ROOMS)
      (DESC "Lake Shore")
      (LDESC
"You are in a wide cavern on the north shore of a small lake. Some
polished stone steps lead to the southeast and a sheer rock face
prevents any movement around the lake to the southwest. The cavern is
dimly lit from above.")
      (SE TO AQ-VIEW)
      (DOWN TO AQ-VIEW)
      (SOUTH "If you really want to enter the lake, you should say so.")
      (SW "The sheer rock face prevents movement along the lake shore.")
      (NORTH TO FOGGY-ROOM)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL LAKE STAIRS)
      (PSEUDO "SHORE" SHORE-PSEUDO "BEACH" SHORE-PSEUDO)>

<ROOM AQ-VIEW
      (IN ROOMS)
      (DESC "Aqueduct View")
      (LDESC
"This is a small balcony carved into a near-vertical cliff. To the east,
stretching from north to south, stands a monumental aqueduct supported by
mighty stone pillars, some of which are starting to crumble from age. You
feel a sense of loss and sadness as you ponder this once-proud structure and
the failure of the Empire which created this and other engineering marvels.
Some stone steps lead up to the northwest.")
      (NW TO LAKE-SHORE)
      (UP TO LAKE-SHORE)
      (DOWN "The drop would be fatal.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AQUEDUCT STAIRS)>
     
<ROOM ON-LAKE
      (IN ROOMS)
      (DESC "On the Lake")
      (LDESC
"You are floating on the surface of the lake. The water is ice cold and
your ability to survive here for long is very questionable. A swim north
puts you at your starting point. Conditions to the east are poor where
the lake turns into swamp. The west and south shores are suitable for
walking, however.")
      (NORTH TO LAKE-SHORE)
      (SOUTH TO SOUTH-SHORE)
      (PSEUDO "SWAMP" SWAMP-PSEUDO)
      (SE "The swamp is impassable.")
      (EAST "The swamp is impassable.")
      (NE "The swamp is impassable.")
      (WEST TO FAR-SHORE)
      (NW TO FAR-SHORE)
      (SW TO SOUTH-SHORE)
      (DOWN TO IN-LAKE)
      (FLAGS RLANDBIT ONBIT)
      (ACTION ON-LAKE-F)
      (GLOBAL LAKE FISH)>

<ROOM IN-LAKE
      (IN ROOMS)
      (DESC "Underwater")
      (LDESC
"You are below the surface of the lake. It turns out that the lake is quite
shallow and the bottom is only a few feet below you. Considering the frigid
temperature of the water, you should probably not plan an extended stay.
The lake bottom is sandy and a few hearty plants and algae live there.")
      (UP TO ON-LAKE)
      (DOWN "You are already at the bottom of the lake.")
      (NORTH TO IN-LAKE)
      (SOUTH TO IN-LAKE)
      (EAST TO IN-LAKE)
      (WEST TO IN-LAKE)
      (NE TO IN-LAKE)
      (NW TO IN-LAKE)
      (SE TO IN-LAKE)
      (SW TO IN-LAKE)
      (FLAGS RLANDBIT ONBIT)
      (ACTION IN-LAKE-F)
      (GLOBAL LAKE FISH)>

<ROOM FAR-SHORE
      (IN ROOMS)
      (DESC "Western Shore")
      (LDESC
"You are on the western shore of the lake. The ground here is quite
hard, but a few sickly reeds manage to grow near the water's edge. The
only path leads into the rock to the south.")
      (EAST "If you want to enter the lake, you should say so.")
      (SOUTH TO VIEW-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LAKE)
      (PSEUDO "SHORE" SHORE-PSEUDO "BEACH" SHORE-PSEUDO)>

<OBJECT REEDS
      (IN FAR-SHORE)
      (SYNONYM REEDS)
      (ADJECTIVE SICKLY)
      (DESC "reeds")
      (FLAGS NDESCBIT)>

<ROOM VIEW-ROOM
      (IN ROOMS)
      (DESC "Scenic Vista")
      (LDESC "")
      (FLAGS ONBIT RLANDBIT)
      (NORTH TO FAR-SHORE)
      (ACTION VIEW-ROOM-F)>

<OBJECT VIEWING-TABLE
	(IN VIEW-ROOM)
	(DESC "viewing table")
	(SYNONYM TABLE SURFACE)
	(ADJECTIVE VIEWING)
	(FLAGS NDESCBIT)
	(ACTION VIEWING-TABLE-F)>

<OBJECT TORCH
	(IN VIEW-ROOM)
	(DESC "torch")
	(FDESC
"Mounted on one wall is a flaming torch, which fills the room with a flickering
light.")
	(SYNONYM TORCH)
	(FLAGS LIGHTBIT TAKEBIT ONBIT FLAMEBIT)
	(ACTION TORCH-F)>

<OBJECT FRIED-TORCH
	(DESC "burned-out torch")
	(SYNONYM TORCH)
	(ADJECTIVE BURNED DEAD)
	(FLAGS TAKEBIT)
	(ACTION FRIED-TORCH-F)>

<OBJECT CLIFF-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "cliff")
	(SYNONYM CLIFF)
	(ACTION CLIFF-OBJECT-F)>

<OBJECT STONE-WALL
	(IN LOCAL-GLOBALS)
	(DESC "stone wall")
	(SYNONYM WALL)
	(ADJECTIVE STONE MASSIVE)
	(FLAGS NDESCBIT)>

<OBJECT LAKE
	(IN LOCAL-GLOBALS)
	(DESC "lake")
	(SYNONYM LAKE WATER SURFACE)
	(ACTION LAKE-F)>

<OBJECT AMULET
	(DESC "golden amulet")
	(SYNONYM AMULET OBJECT)
	(ADJECTIVE GOLD GOLDEN SHINY)
	(FLAGS TAKEBIT WEARBIT NDESCBIT)>

<OBJECT SAND
	(IN IN-LAKE)
	(DESC "sand")
	(SYNONYM SAND FLOOR BOTTOM)
	(FLAGS NDESCBIT)
	(ACTION SAND-F)>

<OBJECT FRIED-LAMP
	(DESC "lamp")
	(SYNONYM LAMP LANTERN)
	(ADJECTIVE BRASS)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION FRIED-LAMP-F)>

<OBJECT ALGAE
	(IN IN-LAKE)
	(DESC "plants and algae")
	(SYNONYM PLANT PLANTS ALGAE)
	(FLAGS NDESCBIT)
	(ACTION ALGAE-F)>

<OBJECT SHINY-OBJECT
	(IN IN-LAKE)
	(DESC "shiny object")
	(SYNONYM OBJECT AMULET)
	(ADJECTIVE SHINY)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION SHINY-OBJECT-F)>

<OBJECT LEDGE
	(IN LOCAL-GLOBALS)
	(DESC "ledge")
	(SYNONYM LEDGE)
	(ADJECTIVE WIDE)
	(FLAGS NDESCBIT)
	(ACTION LEDGE-F)>

<ROUTINE LEDGE-F ()
	 <COND (<AND <==? ,HERE ,CLIFF-LEDGE>
		     <VERB? THROW-OFF>
		     <==? ,PRSI ,LEDGE>>
		<COND (<NOT <IN? ,PRSO ,WINNER>>
		       <TELL "You're not holding that!" CR>
		       <RTRUE>)>
		<MOVE ,PRSO ,CLIFF-BASE>
		<TELL
"The " D ,PRSO " falls to the base of the cliff below." CR>)>> 

<OBJECT WAYBREAD
	(IN CLIFF)
	(DESC "piece of waybread")
	(LDESC "A piece of bread is on the ground here.")
	(FDESC
"It seems as if somebody has been here recently, as there is some fresh
bread lying beneath one of the other trees.")
	(SYNONYM BREAD WAYBREAD PIECE)
	(ADJECTIVE WAY FRESH)
	(FLAGS TAKEBIT FOODBIT)
	(SIZE 3)
	(ACTION WAYBREAD-F)>

<ROUTINE WAYBREAD-F ()
	 <COND (<AND <VERB? CUT> <==? ,PRSI ,SWORD>>
		<TELL
"The bread is crushed rather than cut by your sword, and the crumbs scatter to
the wind." CR>
		<REMOVE ,WAYBREAD>)>>

<OBJECT ROPE
	(IN CLIFF)
	(DESC "rope")
	(SYNONYM ROPE)
	(ADJECTIVE LONG)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION ROPE-F)>

<OBJECT GLOBAL-ROPE
	(IN LOCAL-GLOBALS)
	(DESC "rope")
	(SYNONYM ROPE)
	(ADJECTIVE DANGLING)
	(ACTION GLOBAL-ROPE-F)>

<OBJECT TREE
	(IN CLIFF)
	(DESC "tree")
	(SYNONYM TREE TREES)
	(ADJECTIVE LARGE TALL)
	(FLAGS NDESCBIT)
	(ACTION TREE-F)>
	
<OBJECT STAFF
	(DESC "wooden staff")
	(SYNONYM STAFF)
	(ADJECTIVE WOODEN)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION STAFF-F)>
	
<OBJECT BROKEN-STAFF
	(DESC "broken staff")
	(SYNONYM STAFF)
	(ADJECTIVE BROKEN)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION STAFF-F)>
	
<ROUTINE STAFF-F ()
	 <COND (<AND <VERB? BURN> <==? ,PRSI ,TORCH>>
		<REMOVE ,PRSO>
		<JIGS-UP
"The staff is instantly consumed in a ball of flame. You along with it.">)>>

<OBJECT CHEST
	(IN CLIFF-LEDGE)
	(DESC "chest")
	(FDESC
"A large chest, closed and locked, is lying among the boulders.")
	(SYNONYM CHEST)
	(ADJECTIVE LOCKED)
	(FLAGS TAKEBIT CONTBIT)
	(SIZE 40)
	(CAPACITY 20)
	(ACTION CHEST-F)>

<OBJECT GLOBAL-MAN
	(IN LOCAL-GLOBALS)
	(DESC "man")
	(SYNONYM MAN FRIEND)
	(FLAGS ACTORBIT)
	(ACTION GLOBAL-MAN-F)>
	
<OBJECT VALUABLES
	(IN MAN)
	(DESC "pile of assorted valuables")
       	(SYNONYM VALUABLES TREASURE PILE)
	(ADJECTIVE ASSORTED)
	(FLAGS NDESCBIT TAKEBIT)
	(ACTION VALUABLES-F)>

<OBJECT MAN
	(SYNONYM MAN FRIEND)
	(DESC "man")
	(FLAGS ACTORBIT OPENBIT CONTBIT)
	(ACTION MAN-F)>

<GLOBAL CHEST-LIFTED <>>

<ROUTINE I-MAN-APPEARS ()
	 <COND (<OR <NOT <==? ,HERE ,CLIFF-LEDGE>>
		    <NOT <EQUAL? <LOC ,CHEST> ,CLIFF-LEDGE ,WINNER>>>
		<RFALSE>)
	       (,CHEST-TIED
		<SETG MAN-SEEN T>
		<TELL
"All at once, the chest is lifted from you. Looking up, you see a
man at the top of the cliff, pulling intently at the rope. \"That is
uncommonly good of you, I do say!\" He chuckles unpleasantly. \"Oh,
you are stuck, aren't you. Well, I'll be right back to get you!\"
He leaves your sight." CR>
		<SETG CHEST-LIFTED T>
		<MOVE ,CHEST ,MAN>
		<FSET ,CHEST ,TOUCHBIT>
		<SETG ROPE-FLAG <>>
		<SETG CHEST-TIED <>>
		<ENABLE <QUEUE I-MAN-RETURNS 10>>
		<RTRUE>)
	       (T
		<TELL
"At the edge of the cliff above you, a man appears. He looks down at
you and speaks. \"Hello, down there! You seem to have a problem. Maybe I
can help you.\" He chuckles in an unsettling sort of way. \"Perhaps if you
tied that chest to the end of the rope I might be able to drag it up for you.
Then, I'll be more than happy to help you up!\" He laughs again." CR>
		<SETG MAN-FLAG T>
		<SETG MAN-SEEN T>
		<ENABLE <QUEUE I-MAN-PRESENT -1>>)>>

<GLOBAL MAN-SEEN <>>

<ROUTINE I-MAN-PRESENT ()
	 <COND (<OR <NOT <==? ,HERE ,CLIFF-LEDGE>>
		    <NOT ,MAN-FLAG>
		    <IN? ,CHEST ,MAN>>
		<QUEUE I-MAN-PRESENT 0>
		<SETG MAN-FLAG <>>
		<RFALSE>)
	       (<G? <SETG MAN-WAITING <+ ,MAN-WAITING 1>> 10>
		<TELL
"The man looks quite displeased. \"All right, then. I guess someone else
can always help me! See you around, sport!\" He disappears." CR>
		<QUEUE I-MAN-PRESENT 0>
		<SETG MAN-FLAG <>>
		<RTRUE>)
	       (T <TELL <RANDOM-ELEMENT ,MAN-WAITS> CR>)>>

<ROUTINE CLIFF-BASE-F (RARG)
	 <COND (<AND <==? .RARG ,M-ENTER>
		     ,CHEST-TIED>
		<SETG CHEST-TIED <>>
		<SETG ROPE-FLAG <>>
		<QUEUE I-MAN-APPEARS 0>)>>

<GLOBAL MAN-WAITS <LTABLE
"The man appears to be getting somewhat impatient."
"Your friend at the cliff top has started pacing nervously around."
"\"Yoo hoo!\" calls the man at the brink of the cliff. \"Remember me?\""
"The man on the cliff waves at you. \"It would just take a moment to tie that
rope to the chest. I'd be much obliged, and there might even be something in
it for you!\""
"A few small stones fall near your feet. You look up and see your friend
waving. \"I haven't got all day, fella. Be a pal and pass up the chest!\""
"The man on the cliff clears his throat loudly. \"I don't mean to be rushing
you, but I do have some pressing engagements....\"">>

<GLOBAL MAN-WAITING 0>
<GLOBAL MAN-FLAG <>>
<GLOBAL MAN-POINT <>>
<GLOBAL MAN-GONE <>>

<ROUTINE CLIFF-LEDGE-F (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? WALK>
		     <IN? ,CHEST ,WINNER>
		     ,CHEST-TIED>
		<TELL
"You can't go anywhere holding that chest. The rope is tied around it!" CR>)
	       (<AND <==? .RARG ,M-ENTER>
		     <NOT ,MAN-SEEN>
		     <NOT ,MAN-FLAG>
		     <NOT ,MAN-GONE>>
		<COND (<NOT ,MAN-POINT>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG MAN-POINT T>)>
		<ENABLE <QUEUE I-MAN-APPEARS 5>>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"This is a rock-strewn ledge near the base of a tall cliff. The bottom of the
cliff is another fifteen feet below. You have little hope of climbing up the
cliff face, but you might be able to scramble down from here (though it's
doubtful you could return)." CR>
		<COND (,ROPE-FLAG
		       <TELL
"A long piece of rope is dangling down from the top of the cliff and
is within your reach." CR>)>
		<RTRUE>)>>

<ROUTINE CLIFF-F (RARG)
	 <COND (<AND <==? .RARG ,M-ENTER> <IN? ,CHEST ,MAN>>
		<QUEUE I-MAN-RETURNS 0>
		<MOVE ,CHEST ,HERE>
		<FSET ,CHEST ,OPENBIT>
		<SETG ROPE-FLAG T>
		<SETG CHEST-TIED <>>
		<SETG CHEST-OPENED T>
		<RFALSE>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"This is a remarkable spot in the dungeon. Perhaps two hundred feet above
you is a gaping hole in the earth's surface through which pours bright
sunshine! A few seedlings from the world above, nurtured by the sunlight
and occasional rains, have grown into giant trees, making this a virtual oasis
in the desert of the Underground Empire. To the west is a sheer precipice,
dropping nearly fifty feet to jagged rocks below. The way south is barred by
a forbidding stone wall, crumbling from age. There is a jagged opening in the
wall to the southwest, through which leaks a fine mist. The land to the east
looks lifeless and barren." CR>
		<COND (,ROPE-FLAG
		       <TELL
"A rope is tied to one of the large trees here and is dangling over
the side of the cliff, reaching down to the shelf below." CR>)>
		<RTRUE>)
	       (<AND <==? .RARG ,M-END>
		     <PROB 15>
		     <NOT <FSET? ,CLIFF-LEDGE ,TOUCHBIT>>>
		<TELL
"You catch, out of the corner of your eye, some movement among the
trees." CR>)
	       (<AND <==? .RARG ,M-END>
		     <PROB 20>>
		<TELL
"You seem to hear, from the southwest, the sounds of the sea." CR>)>>

<ROUTINE GLOBAL-ROPE-F ()
	 <COND (<NOT ,ROPE-FLAG>
		<TELL "You can't see any rope here." CR>)
	       (<VERB? CLIMB-FOO>
		<V-CLIMB-UP ,P?DOWN T>)
	       (<VERB? TAKE MOVE CLIMB-ON>
		<COND (<NOT ,MAN-FLAG>
		       <TELL
"A short tug on the rope convinces you that it is securely fastened
from above." CR>)
		      (<IN? ,CHEST ,MAN>
		       <SETG HOLDING-ROPE T>
		       <TELL
"You grab securely on to the rope." CR>)
		      (T
		       <TELL
"The man scowls. \"I may help you up, but not before I have that chest.\" He
points to the chest near you on the ledge." CR>)>)
	       (<VERB? CLIMB-UP>
		<TELL
"You try to climb the rope, but you cannot reach the top even with your best
effort." CR>)
	       (<VERB? TIE>
		<COND (<EQUAL? ,CHEST ,PRSO ,PRSI>
		       <TELL
"The chest is now tied to the rope." CR>
		       <SETG CHEST-TIED T>
		       <COND (<AND ,MAN-FLAG <NOT ,MAN-GONE>>
			      <TELL
"The man above you looks pleased. \"Now there's a good friend! Thank
you very much, indeed!\" He pulls on the rope and the chest is lifted
to the top of the cliff and out of sight. With a short laugh, he
disappears. \"I'll be back in a short while!\" are his last words." CR>
			      <MOVE ,CHEST ,MAN>
			      <FSET ,CHEST ,TOUCHBIT>
			      <SETG CHEST-TIED <>>
			      <SETG ROPE-FLAG <>>
			      <ENABLE <QUEUE I-MAN-RETURNS 10>>
			      <SETG MAN-FLAG <>>
			      <RTRUE>)>
		       <RTRUE>)
		      (<EQUAL? ,ME ,PRSI ,PRSO>
		       <COND (<AND ,MAN-FLAG <IN? ,CHEST ,MAN>>
			      <TELL
"\"Just grab onto it!\", the man bellows." CR>)
			     (,MAN-FLAG
			      <TELL
"The man looks cross. \"I want the chest, not you!\" he snaps. \"Now stop
fooling around and pass it up!\"" CR>)
			     (T
			      <TELL
"You're unable to tie the rope around yourself." CR>)>)
		      (T
		       <TELL
"You're unable to tie the rope to that." CR>)>)
	       (<VERB? UNTIE>
		<COND (,CHEST-TIED
		       <SETG CHEST-TIED <>>
		       <TELL
"The chest is now disconnected from the rope." CR>)
		      (T
		       <TELL
"The rope isn't tied to anything." CR>)>)>>

<GLOBAL CHEST-TIED <>>
<GLOBAL HOLDING-ROPE <>>

<ROUTINE I-MAN-RETURNS ()
	 <SETG ROPE-FLAG T>
	 <COND (<==? ,HERE ,CLIFF-LEDGE>
		<TELL
"A familiar voice calls down to you. \"Are you still there?\" he bellows with a
coarse laugh. \"Well, then, grab onto the rope and we'll see what we can do.\"
The rope drops to within your reach." CR>
		<SETG MAN-FLAG T>
		<ENABLE <QUEUE I-MAN-LIFT -1>>
		<RTRUE>)>>

<GLOBAL LIFT-WAIT 0>

<ROUTINE I-MAN-LIFT ()
	 <COND (<NOT <==? ,HERE ,CLIFF-LEDGE>>
		<QUEUE I-MAN-LIFT 0>
		<MOVE ,CHEST ,CLIFF>
		<FSET ,CHEST ,OPENBIT>
		<SETG CHEST-OPENED T>
		<REMOVE ,MAN>
		<RFALSE>)
	       (,HOLDING-ROPE
		<TELL
"The man starts to heave on the rope and within a few moments you arrive at
the top of the cliff. The man removes the last few valuables from the chest
and prepares to leave. \"You've been a good sport! Here, take this, for
whatever good it is! I can't see that I'll be needing one!\" He hands you a
plain wooden staff from the bottom of the chest and begins examining his
valuables." CR>
		<QUEUE I-MAN-LIFT 0>
		<MOVE ,STAFF ,WINNER>
		<SETG HOLDING-ROPE <>>
		<SETG ROPE-FLAG T>
		<MOVE ,WINNER ,CLIFF>
		<MOVE ,CHEST ,CLIFF>
		<FSET ,CHEST ,OPENBIT>
		<TELL
"The chest, open and empty, is at your feet." CR>
		<SETG CHEST-OPENED T>
		<MOVE ,MAN ,CLIFF>
		<ENABLE <QUEUE I-MAN-LEAVES -1>>
		<RTRUE>)
	       (<G? <SETG LIFT-WAIT <+ ,LIFT-WAIT 1>> 4>
		<TELL
"\"Well, I don't have all day. See you around sometime.\" Showering you with
gravel, he disappears from sight." CR>
		<SETG MAN-FLAG <>>
		<MOVE ,CHEST ,CLIFF>
		<FSET ,CHEST ,OPENBIT>
		<SETG CHEST-OPENED T>
		<QUEUE I-MAN-LIFT 0>)
	       (T
		<TELL
"The man appears impatient. \"Are you coming up then, or not?\"" CR>)>>

<GLOBAL CHEST-OPENED <>>

<ROUTINE CHEST-F ()
	 <COND (,CHEST-OPENED
		<COND (<AND <VERB? TIE> <==? ,ROPE ,PRSO ,PRSI>>
		       <TELL "What's the point?" CR>)
		      (<AND <VERB? PUT> <EQUAL? ,PRSO ,STAFF ,LAMP ,TORCH>>
		       <TELL "It doesn't fit.">
		       <COND (<EQUAL? ,PRSO ,STAFF>
			      <TELL
" Awfully peculiar, though, since it's where the staff came from.">)>
		       <CRLF>)
		      (T <RFALSE>)>)
	       (<VERB? OPEN UNLOCK>
		<COND (,MAN-FLAG
		       <TELL
"The man calls down to you. \"Is this what you're looking for?\" he cackles,
waving a small key over his head. You try to open the chest, but it is
locked." CR>)
		      (T <TELL
"The chest is locked and cannot be opened." CR>)>)>>

<GLOBAL ROPE-FLAG T>

<ROUTINE I-MAN-LEAVES ()
	 <COND (<NOT <==? ,HERE ,CLIFF>>
		<REMOVE ,MAN>
		<SETG MAN-GONE T>
		<SETG MAN-FLAG <>>
		<SETG ROPE-FLAG T>
		<QUEUE I-MAN-LEAVES 0>
		<RFALSE>)
	       (<PROB 40>
		<TELL
"Your \"friend\", moving quickly, dodges behind some trees and is lost from
sight." CR>
		<REMOVE ,MAN>
		<SETG MAN-FLAG <>>
		<SETG MAN-GONE T>
		<SETG ROPE-FLAG T>
		<QUEUE I-MAN-LEAVES 0>
		<RTRUE>)
	       (T
		<TELL
"Your \"friend\" examines his valuables with great pride." CR>)>>

<ROUTINE MAN-F ()
	 <COND (<VERB? HELLO>
		<TELL
"He responds cheerfully. \"It is a wonderful day, isn't it?\"" CR>)
	       (<HELLO? ,MAN>
		<TELL
"The man is thoroughly engrossed in the examination of his booty and
doesn't seem to hear you." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The man is stocky and of medium height, with several days' growth of stubble
on his face. He is carrying a number of valuables under his arm, presumably
from the now-open chest." CR>)
	       (<VERB? ATTACK>
		<COND (<==? ,PRSI ,SWORD>
		       <TELL
"The man is taken by surprise and is hit with the sword. He grabs you
and throws you to the ground">
		       <COND (<EQUAL? <LOC ,STAFF> ,WINNER ,HERE>
			      <TELL ", breaking the staff in the process">
			      <REMOVE ,STAFF>
			      <MOVE ,BROKEN-STAFF ,HERE>)>
		       <TELL ", but you
finish him off with a quick thrust to the chest. He dies, and disappears
without ceremony in the usual style of the Great Underground Empire.
His assorted valuables remain behind." CR>
		       <REMOVE ,MAN>
		       <MOVE ,VALUABLES ,HERE>
		       <FCLEAR ,VALUABLES ,NDESCBIT>
		       <QUEUE I-MAN-LEAVES 0>
		       <SETG MAN-GONE T>)
		      (T <TELL "You wouldn't hurt him with that!" CR>)>)>>

<ROUTINE VALUABLES-F ()
	 <COND (<AND <VERB? TAKE PUT MOVE> <IN? ,MAN ,CLIFF>>
		<TELL
"The man recoils sharply. \"These here things are mine. It's my chest and
they're my valuables. You've a lot of nerve trying to take them from me
after me saving you like that!\"" CR>)>>

<ROUTINE ROPE-F ()
	 <COND (<VERB? TAKE MOVE>
		<COND (,ROPE-FLAG
		       <TELL
"The rope is tied to a tree." CR>)>)
	       (<VERB? CLIMB-FOO>
		<V-CLIMB-UP ,P?DOWN T>)
	       (<VERB? BURN>
		<TELL
"The rope won't catch fire." CR>)
	       (<VERB? UNTIE>
		<TELL
"The rope is very securely tied and cannot be undone." CR>)
	       (<AND <VERB? CUT> <==? ,PRSI ,SWORD>>
		<TELL
"The rope is made of pretty tough stuff and won't cut." CR>)>>
		     
<ROUTINE GLOBAL-MAN-F ()
	 <COND (<==? ,HERE ,CLIFF>
		<COND (,MAN-GONE
		       <TELL
"You've lost him among the trees." CR>)
		      (T
		       <TELL
"You can't see any man here." CR>)>)
	       (<NOT ,MAN-FLAG>
		<TELL
"You can't see any man here." CR>)
	       (<VERB? GIVE>
		<TELL
"You aren't even close to him!" CR>)
	       (<VERB? HELLO>
		<TELL
"The man waves back in a friendly way." CR>)
	       (<HELLO? ,GLOBAL-MAN>
		<TELL
"He yells back, \"What's that you say? I can't hear you very well.">
		<COND (<NOT ,CHEST-LIFTED>
		       <TELL
" Just tie the rope to the chest and we can chat afterwards!\" He smiles
broadly.">)
		      (T <TELL "\"">)>
		<CRLF>)
	       (<VERB? ATTACK MUNG>
		<TELL
"I don't think you'll succeed at this distance." CR>)
	       (<AND <VERB? THROW> <==? ,PRSI ,GLOBAL-MAN> <IN? ,PRSO ,WINNER>>
		<TELL
"The " D ,PRSO " flies upward, but not nearly far enough to hit the man. It
does seem to amuse him, however, especially as it passes within inches of
your head. \"We're wasting time now. Be a good fellow and tie the rope!\"" CR>
		<MOVE ,PRSO ,HERE>)>>

<ROUTINE LAKE-F ()
	 <COND (<VERB? THROUGH LEAP>
		<COND (<EQUAL? ,HERE ,LAKE-SHORE ,FAR-SHORE ,SOUTH-SHORE>
		       <GO-ON-LAKE>)
		      (<==? ,HERE ,ON-LAKE>
		       <GOTO ,IN-LAKE>)
		      (T
		       <TELL "Just where do you think you are?" CR>)>)
	       (<VERB? LOOK-UNDER>
		<COND (<==? ,HERE ,ON-LAKE>
		       <TELL
"You can't quite make out the bottom of the lake from here..." CR>)
		      (T <TELL
"You can't see under the surface from here." CR>)>)>>

<ROUTINE IN-LAKE-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-IN-LAKE 3>>)
	       (<AND <==? .RARG ,M-BEG>
		     <VERB? TAKE>
		     <NOT <EQUAL? ,PRSO ,SHINY-OBJECT>>>
		<COND (<G? <WEIGHT ,WINNER> 25>
		       <TELL "You can't carry that much underwater." CR>)
		      (<NOT <FSET? ,PRSO ,TAKEBIT>>
		       <TELL "You can't take that!" CR>)
		      (<PROB 30>
		       <TELL "The " D ,PRSO
" is yours for a moment, but drops from your grasp." CR>)>)
	       (<==? .RARG ,M-END>
		<COND (<PROB 10>
		       <TELL
"A large and hungry-looking fish is swimming in the neighborhood." CR>)
		      (<AND <PROB 4> <NOT ,INVIS>>
		       <QUEUE I-ROC 0>
		       <QUEUE I-ON-LAKE 0>
		       <JIGS-UP
"Oh, no! A tremendous fish just swallowed you whole!">)
		      (<IN? ,SHINY-OBJECT ,HERE>
		       <COND (<==? ,MOVES ,LAST-MOVES> <RTRUE>)
			     (<PROB 40>
			      <TELL
"Out of the corner of your eye, a small, shiny object appears in the
sand. A moment later, it is gone!" CR>)
			     (<PROB 70>
			      <TELL
"You catch a brief glimpse of something shiny in the sand." CR>)
			     (T
			      <TELL
"Something sparkling in the sand catches your eye for a moment." CR>)>
		       <SETG LAST-MOVES ,MOVES>)>)>>

<GLOBAL LAST-MOVES 0>

<ROUTINE I-IN-LAKE ()
	 <COND (<==? ,HERE ,IN-LAKE>
		<TELL
"You run out of air and return to the surface." CR>
		<GOTO ,ON-LAKE>)>>

<GLOBAL LAKE-POINT <>>

<ROUTINE ON-LAKE-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<QUEUE I-IN-LAKE 0>
		<COND (<NOT ,LAKE-POINT>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG LAKE-POINT T>)>)
	       (<AND <==? .RARG ,M-BEG> <VERB? LEAP> <NOT ,PRSO>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>>

<GLOBAL CURRENT-LAMP LAMP>

<ROUTINE GO-ON-LAKE ("AUX" F N (TOLD <>))
	 <COND (<SET F <FIRST? ,WINNER>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (<NOT <FSET? .F ,WEARBIT>>
			       <MOVE .F ,IN-LAKE>
			       <COND (<==? .F ,TORCH>
				      <REMOVE ,TORCH>
				      <MOVE ,FRIED-TORCH ,IN-LAKE>)
				     (<EQUAL? .F ,LAMP>
				      <MOVE ,LAMP ,LOCAL-GLOBALS>
				      <MOVE ,FRIED-LAMP ,IN-LAKE>
				      <SETG CURRENT-LAMP ,FRIED-LAMP>)
				     (<==? .F ,WAYBREAD>
				      <REMOVE ,WAYBREAD>)>
			       <COND (<NOT .TOLD>
				      <SET TOLD T>
				      <TELL
"The shock of entering the frigid water has made you drop all your
possessions into the lake!" CR>)>)>
			<COND (<NOT .N> <RETURN>)
			      (T <SET F .N>)>>)>
	 <COND (<NOT .TOLD>
		<TELL
"You are nearly paralyzed by the icy waters as you swim into the
center of the lake." CR>)>
	 <CRLF>
	 <GOTO ,ON-LAKE>
	 <SETG LAKE-TIME 0>
	 <ENABLE <QUEUE I-ON-LAKE -1>>>

<GLOBAL LAKE-TIME <>>

<ROUTINE I-ON-LAKE ()
	 <SETG LAKE-TIME <+ ,LAKE-TIME 1>>
	 <COND (<AND <PROB 10> <==? ,HERE ,ON-LAKE> <NOT ,INVIS>>
		<TELL
"A giant roc, previously hidden among the rocks, is heading right toward you,
its mouth gaping wide!" CR>
		<ENABLE <QUEUE I-ROC 2>>)
	       (<NOT <EQUAL? ,HERE ,ON-LAKE ,IN-LAKE>>
		<QUEUE I-ON-LAKE 0>
		<QUEUE I-IN-LAKE 0>
		<QUEUE I-ROC 0>
		<RFALSE>)
	       (<==? ,LAKE-TIME 4>
		<TELL
"The icy waters are taking their toll. You will not be able to hold out
much longer." CR>)
	       (<==? ,LAKE-TIME 6>
		<TELL
"You are becoming very weak. You had better leave the water before you
drown!" CR>)
	       (<==? ,LAKE-TIME 8>
		<QUEUE I-ON-LAKE 0>
		<QUEUE I-IN-LAKE 0>
		<QUEUE I-ROC 0>
		<JIGS-UP
"Your strength gives out, and you drown in the frigid waters.">)>>

<ROUTINE I-ROC ()
	 <COND (<AND <==? ,HERE ,ON-LAKE> <NOT ,INVIS>>
		<QUEUE I-ON-LAKE 0>
		<QUEUE I-IN-LAKE 0>
		<JIGS-UP
"The roc snatches you in its jaws and has you for lunch.">)>>

<ROUTINE SHINY-OBJECT-F ()
	 <COND (<AND <VERB? TAKE FIND> <NOT <IN? ,AMULET ,WINNER>>>
		<COND (<PROB 50>
		       <REMOVE ,SHINY-OBJECT>
		       <MOVE ,AMULET ,WINNER>
		       <THIS-IS-IT ,AMULET>
		       <FCLEAR ,AMULET ,NDESCBIT>
		       <TELL
"You reach the shiny object. It is a simple golden amulet!" CR>)
		      (T
		       <TELL
"The shiny object slips from your grasp and back onto the floor of
the lake, where it is covered in sand." CR>)>)>>

<ROUTINE SAND-F ()
	 <COND (<VERB? DIG>
		<TELL "You don't come across anything unusual." CR>)
	       (<VERB? EXAMINE>
		<TELL
"There is nothing notable on the floor of the lake, except some plants
and algae." CR>)
	       (<VERB? TAKE>
		<TELL "It slips through your fingers." CR>)>>

<ROUTINE ALGAE-F ()
	 <COND (<VERB? EAT> <TELL "Yeecchhhh!" CR>)>>

<ROUTINE FRIED-LAMP-F ()
	 <COND (<VERB? LAMP-ON>
		<TELL
"The lamp isn't functioning (probably from having gotten wet)." CR>)>>

<GLOBAL VIEW-POINT 1>

<ROUTINE I-VIEW-SNAP ()
	 <TELL "You suddenly find yourself back in the viewing room!" CR>
	 <GOTO ,VIEW-ROOM <>>
	 <RTRUE>>

<ROUTINE VIEWING-TABLE-F ("AUX" L)
	 <COND (<VERB? RUB>
		<SETG SCORE <+ ,SCORE ,VIEW-POINT>>
		<SETG VIEW-POINT 0>
		<TELL
"You touch the table and are instantly transported to another place!" CR>
		<CRLF>
		<ENABLE <QUEUE I-VIEW-SNAP 3>>
		<GOTO <GET ,VIEW-ROOMS ,ACTIVE-VIEW>>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The surface is pale and featureless, but slowly, an image takes shape!" CR>
	        <TELL <GET ,VIEWS ,ACTIVE-VIEW> CR>
		<TELL
"The image slowly fades." CR>)>>

<ROUTINE I-VIEW-CHANGE ()
	 <SETG ACTIVE-VIEW <+ ,ACTIVE-VIEW 1>>
	 <COND (<==? ,ACTIVE-VIEW 5> <SETG ACTIVE-VIEW 1>)>
	 <QUEUE I-VIEW-CHANGE 4>
	 <COND (<==? ,HERE ,VIEW-ROOM>
		<TELL
"The indicator above the table flickers briefly, then changes to \"">
		<TELL <GET ,VIEW-ROMANS ,ACTIVE-VIEW> "\"." CR>)>>

<ROUTINE VIEW-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are in a small chamber carved in the rock, with the sole exit to the
north. Mounted on one wall is a table labelled \"Scenic Vista,\" whose
featureless surface is angled toward you. One might believe that the table
was used to indicate points of interest in the view from this spot, like those
found in many parks. On the other hand, your surroundings are far from
spacious and by no stretch of the imagination could this spot be considered
scenic. An indicator above the table reads \"">
		<TELL <GET ,VIEW-ROMANS ,ACTIVE-VIEW> "\"." CR>)>>
		
<GLOBAL VIEW-ROMANS <TABLE 0 "I" "II" "III" "IV">>

<GLOBAL ACTIVE-VIEW 1>

<GLOBAL VIEW-ROOMS <LTABLE TIMBER-ROOM ROOM-8 DAMP-PASSAGE ZORK-IV>>

<GLOBAL VIEWS <LTABLE
"You see a passage cluttered with broken timbers. An extremely narrow opening
can be seen at the end of the room."
"You see a tiny room with rough walls. Chiseled crudely on one wall is the
number \"8\". The only apparent exit seems to be a blur."
"You see a wide room with two nearly identical passages leading east and
northeast. A wide channel descends steeply into the room and seems to be
blocked by rubble."
"You see the interior of a huge temple rudely constructed of basalt blocks.
Flickering torches cast a sallow illumination over an altar still wet with the
blood of human sacrifice, its velvet covers stained and encrusted with gore.">>

<ROUTINE CLIFF-OBJECT-F ()
	 <COND (<==? ,HERE ,CLIFF>
		<COND (<VERB? LEAP>
		       <JIGS-UP
"You should have looked before you leaped.">)
		      (<VERB? CLIMB-DOWN>
		       <COND (,ROPE-FLAG
			      <GOTO ,CLIFF-LEDGE>
			      <RTRUE>)
			     (T <TELL "The fall would kill you." CR>)>)
		      (<AND <VERB? THROW-OFF> <==? ,PRSI ,CLIFF-OBJECT>>
		       <COND (<==? ,PRSO ,ROPE>
			      <TELL
"The rope is dangling over the side of the cliff already." CR>
			      <RTRUE>)
			     (<NOT <IN? ,PRSO ,WINNER>>
			      <TELL
"You aren't holding the " D ,PRSO "." CR>
			      <RTRUE>)>
		       <MOVE ,PRSO ,CLIFF-LEDGE>
		       <TELL
"The " D ,PRSO " goes over the cliff and lands among the rocks below." CR>
		       <COND (<==? ,PRSO ,LAMP>
			      <REMOVE ,PRSO>
			      <MOVE ,BROKEN-LAMP ,CLIFF-LEDGE>
			      <SETG CURRENT-LAMP ,BROKEN-LAMP>)
			     (<==? ,PRSO ,STAFF>
			      <REMOVE ,PRSO>
			      <MOVE ,BROKEN-STAFF ,CLIFF-LEDGE>)>
		       <RTRUE>)>)
	       (<VERB? CLIMB-UP>
		<TELL "You haven't enough strength to climb the cliff." CR>)
	       (T <TELL "The cliff is above you!" CR>)>>

<ROUTINE TREE-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<TELL "The trunks are too large for you to climb them." CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE> <NOT ,MAN-SEEN>>
		<TELL
"There seems to be nobody there, but it's hard to tell." CR>)
	       (<VERB? BURN>
		<JIGS-UP
"Smokey the Bear puts out both the fire and you.">)>>

<ROUTINE FRIED-TORCH-F ()
	 <COND (<VERB? LAMP-ON>
		<TELL "It's hopeless. The torch is wet." CR>)>>

<ROUTINE TORCH-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (<FSET? ,TORCH ,ONBIT> <TELL "It's already lit." CR>)
		      (T <TELL "You have nothing to light it with." CR>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,TORCH ,ONBIT>
		       <TELL "You manage to extinguish the flame." CR>
		       <FCLEAR ,TORCH ,ONBIT>)
		      (T <TELL "It has already been extinguished." CR>)>)>>

;"Here's some ZORK I"

<OBJECT TIMBERS	;"was OTIMB"
	(IN TIMBER-ROOM)
	(SYNONYM TIMBERS PILE)
	(ADJECTIVE WOODEN BROKEN)
	(DESC "broken timber")
	(FLAGS TAKEBIT)
	(SIZE 50)>

<ROOM LADDER-TOP	;"was TLADD"
      (IN ROOMS)
      (LDESC
"This is a very small room. In the corner is a rickety wooden
ladder, leading downward. It might be safe to descend. There is
also a staircase leading upward.")
      (DESC "Ladder Top")
      (DOWN TO LADDER-BOTTOM)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER STAIRS)>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN RICKETY NARROW)
	(DESC "wooden ladder")
	(FLAGS NDESCBIT CLIMBBIT)>

<ROOM LADDER-BOTTOM	;"was BLADD"
      (IN ROOMS)
      (LDESC
"This is a rather wide room. On one side is the bottom of a
narrow wooden ladder. To the west and the south are passages
leaving the room.")
      (DESC "Ladder Bottom")
      (SOUTH TO DEAD-END-5)
      (WEST TO TIMBER-ROOM)
      (UP TO LADDER-TOP)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER)>

<ROOM DEAD-END-5	;"was DEAD7"
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the mine.|
There is a small pile of coal here.")
      (NORTH TO LADDER-BOTTOM)
      (FLAGS RLANDBIT)>

<ROOM TIMBER-ROOM	;"was TIMBE"
      (IN ROOMS)
      (LDESC
"This is a long and narrow passage, which is cluttered with broken
timbers. A wide passage comes from the east and turns at the
west end of the room into a very narrow passageway. From the west
comes a strong draft.")
      (DESC "Timber Room")
      (EAST TO LADDER-BOTTOM)
      (WEST TO LOWER-SHAFT
       IF EMPTY-HANDED
       ELSE "You cannot fit through this passage with that load.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT)>

<ROOM LOWER-SHAFT	;"was BSHAF"
      (IN ROOMS)
      (DESC "Drafty Room")
      (SOUTH TO MACHINE-ROOM)
      (OUT TO TIMBER-ROOM)
      (EAST TO TIMBER-ROOM)
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT)>

<ROOM MACHINE-ROOM
      (IN ROOMS)
      (DESC "Machine Room")
      (FLAGS RLANDBIT)>

<GLOBAL EMPTY-HANDED <>>

<ROUTINE NO-OBJS (RARG "AUX" F)
	 <COND (<==? .RARG ,M-BEG>
		<SET F <FIRST? ,WINNER>>
		<SETG EMPTY-HANDED T>
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)
			      (<G? <WEIGHT .F> 4>
			       <SETG EMPTY-HANDED <>>
			       <RETURN>)>
			<SET F <NEXT? .F>>>
		<RFALSE>)>>

;"Stuff from ZORK II"

<ROOM ROOM-8
      (IN ROOMS)
      (LDESC
"This is a small chamber carved out of the rock at the end of a short crawl.
On the wall is crudely chiseled the number \"8\". The only apparent exit,
to the east, seems to be a blur and a loud, whirring sound resounds through
the rock.")
      (DESC "Room 8")
      (FLAGS RLANDBIT)
      (EAST "You are repelled from the exit by a fierce wind.")>

<OBJECT REPELLENT
	(IN ROOM-8)
	(SYNONYM REPELLENT CAN)
	(ADJECTIVE GRUE MAGIC)
	(DESC "Frobozz Magic Grue Repellent")
	(FLAGS TAKEBIT READBIT)
	(ACTION REPELLENT-FCN)
	(FDESC
"A spray can is in the corner. In large type is the legend \"Frobozz Magic
Grue Repellent.\"")
	(TEXT
"!!! FROBOZZ MAGIC GRUE REPELLENT !!!|
|
Instructions for use: Apply liberally to creature to be protected.
Duration of effect is unpredictable. Use only in place of death!|
|
(No warranty expressed or implied)")>

<ROUTINE REPELLENT-FCN ()
	 <COND (<VERB? SHAKE>
		<COND (,SPRAY-USED? <TELL "The can seems empty." CR>)
		      (T <TELL "There is a sloshing sound from inside." CR>)>)
	       (<VERB? BURN>
		<JIGS-UP
"The can explodes and you die a horribly smelly death.">)
	       (<AND <VERB? SPRAY PUT> <==? ,PRSO ,REPELLENT>>
		<COND (,SPRAY-USED?
		       <TELL
"The repellent is all gone." CR>)
		      (<NOT ,PRSI>
		       <SETG SPRAY-USED? T>
		       <TELL
"The spray stinks amazingly for a few moments, then drifts away." CR>)
		      (ELSE
		       <COND (<==? ,PRSI ,ME>
			      <ENABLE <QUEUE I-SPRAY 5>>
			      <SETG SPRAYED? T>)>
		       <SETG SPRAY-USED? T>
		       <TELL
"The spray smells like a mixture of old socks and burning rubber. If
I were a grue I'd sure stay clear!" CR>)>)>>

<GLOBAL SPRAY-USED? <>>

<ROUTINE I-SPRAY ()
	 <SETG SPRAYED? <>>
	 <TELL "That horrible smell is much less pungent now." CR>>

;"Stuff from ZORK IV"

<ROOM ZORK-IV
      (IN ROOMS)
      (DESC "Sacrificial Altar")
      (FLAGS ONBIT RLANDBIT)
      (ACTION ZORK-IV-F)>

<ROUTINE ZORK-IV-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<JIGS-UP
"Sacrificial Altar|
This is the interior of a huge temple of primitive construction. A few
flickering torches cast a sallow illumination over the altar, which is
still drenched with the blood of human sacrifice. Behind the altar is an
enormous statue of a demon which seems to reach towards you with
dripping fangs and razor-sharp talons. A low noise begins behind you,
and you turn to see hundreds of hunched and hairy shapes. A guttural
chant issues from their throats. Near you stands a figure draped in a
robe of deepest black, brandishing a huge sword. The chant grows louder
as the robed figure approaches the altar. The large figure spots you and
approaches menacingly. It reaches into its cloak and pulls out a great,
glowing dagger. It pulls you onto the altar and, with a murmur of
approval from the throng, slices you neatly across your abdomen.">)>>

;"Last Section"

<ROOM SOUTH-SHORE
      (IN ROOMS)
      (DESC "Southern Shore")
      (LDESC
"You are on the south shore of the lake. Rock formations prevent
movement to the west and thickening swamp to the east makes the going
all but impossible. To the south, where the beach meets a rock
formation, you can make out a dark passage sloping steeply upward into the
rock.")
      (EAST "The swamp is too thick.")
      (UP TO DARK-1)
      (NORTH "If you want to go into the lake, you should say so.")
      (SOUTH TO DARK-1)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LAKE)
      (PSEUDO "BEACH" SHORE-PSEUDO "SWAMP" SWAMP-PSEUDO)>

<ROOM DARK-1
      (IN ROOMS)
      (DESC "Dark Place")
      (NORTH TO SOUTH-SHORE)
      (SOUTH TO DARK-2)
      (UP TO DARK-2)
      (DOWN TO SOUTH-SHORE)
      (FLAGS RLANDBIT)>

<ROOM DARK-2
      (IN ROOMS)
      (DESC "Dark Place")
      (NORTH TO DARK-1)
      (EAST TO KEY-ROOM)
      (UP TO KEY-ROOM)
      (DOWN TO DARK-1)
      (FLAGS RLANDBIT)>

<ROOM KEY-ROOM
      (IN ROOMS)
      (DESC "Key Room")
      (WEST TO DARK-2)
      (DOWN TO AQ-1 IF COVER-MOVED
       		    ELSE "You can't walk through a piece of metal.")
      (ACTION KEY-ROOM-F)
      (FLAGS RLANDBIT ONBIT)>

<ROOM AQ-1
      (IN ROOMS)
      (DESC "Aqueduct")
      (UP "The hole is too far above your head.")
      (LDESC
"You are in a wide stone channel, part of the water supply system for the
Great Underground Empire. The source of water was a waterfall to the south,
which has long since dried up. Water flowed along the aqueduct to the north.
This region is lit from above, although the source of light is not apparent.")
      (SOUTH "You can't climb the dried-up waterfall.")
      (NORTH TO AQ-2)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AQUEDUCT WATER-CHANNEL MOSS)
      (PSEUDO "WATERF" WATERFALL-PSEUDO)>

<ROOM AQ-2
      (IN ROOMS)
      (DESC "High Arch")
      (NORTH TO AQ-3 IF AQ-FLAG ELSE "The arch before you is broken.")
      (SOUTH TO AQ-1)
      (DOWN "It's a long way down....")
      (FLAGS RLANDBIT ONBIT)
      (ACTION AQ-2-F)
      (GLOBAL AQUEDUCT WATER-CHANNEL MOSS)
      (PSEUDO "ARCH" ARCH-PSEUDO)>

<ROOM AQ-3
      (IN ROOMS)
      (DESC "Water Slide")
      (NORTH TO DAMP-PASSAGE)
      (DOWN TO DAMP-PASSAGE)
      (SOUTH TO AQ-2 IF AQ-FLAG ELSE "The arch to the south is broken.")
      (FLAGS RLANDBIT ONBIT)
      (ACTION AQ-3-F)
      (GLOBAL AQUEDUCT WATER-CHANNEL MOSS)
      (PSEUDO "ARCH" ARCH-PSEUDO)>

<OBJECT AQUEDUCT
	(IN LOCAL-GLOBALS)
	(DESC "aqueduct")
	(SYNONYM AQUEDUCT DUCT CHASM)
	(ADJECTIVE STONE)
	(ACTION AQUEDUCT-F)>

<OBJECT WATER-CHANNEL
	(IN LOCAL-GLOBALS)
	(DESC "channel")
	(SYNONYM CHANNEL)
	(ADJECTIVE WATER)
	(ACTION WATER-CHANNEL-F)>

<OBJECT MOSS
	(IN LOCAL-GLOBALS)
	(DESC "moss and lichen")
	(SYNONYM MOSS LICHEN)
	(ACTION MOSS-F)>

<ROUTINE AQUEDUCT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The aqueduct is large and impressive. It was probably the major method
of water transport in the Empire." CR>)
	       (<VERB? LEAP>
		<JIGS-UP
"You execute a perfect swan dive into the rocks below!">)>>

<ROUTINE WATER-CHANNEL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The channel is a few feet deep and ten feet wide, rounded on the bottom." CR>)
	       (<VERB? BOARD>
		<COND (<==? ,HERE ,DAMP-PASSAGE>
		       <TELL
"Getting into the channel wouldn't be of much use." CR>)
		      (T
		       <TELL
"You're standing in it. Otherwise, you would be floating in midair above some
very nasty rocks." CR>)>)>>

<ROUTINE MOSS-F ()
	 <COND (<VERB? TAKE MOVE>
		<TELL "Don't be silly." CR>)>>

<ROUTINE AQ-2-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are now on one of the tallest arches of the aqueduct, hundreds of feet
above a rocky chasm. The immensity of the aqueduct project is apparent from
here. Stone supports rise from the rock floor to form massive arches, which
traverse the region from north to south. The water-carrying channel here is
wide and deep. To the west and far below, you can make out a balcony which
must command a wide view of the aqueduct." CR>
		<COND (<NOT ,AQ-FLAG>
		       <TELL
"The channel ends abruptly to your north where a supporting pillar has
crumbled, casting the arch into the chasm." CR>)>)>> 

<ROUTINE AQ-3-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are near the northern end of this segment of the aqueduct system. To the
south and slightly uphill, the bulk of the aqueduct looms ominously, towering
above a gorge. To the north, the water channel drops precipitously and enters
a rocky hole. The damp moss and lichen would certainly make that a one-way
trip." CR>
		<COND (<NOT ,AQ-FLAG>
		       <TELL
"The southern part of the aqueduct system is inaccessable due to the
collapse of one of the water-bearing arches." CR>)>)>>

<GLOBAL AQ-FLAG T>

<GLOBAL COVER-MOVED <>>

<OBJECT COVER
	(IN KEY-ROOM)
	(DESC "manhole cover")
	(SYNONYM COVER)
	(ADJECTIVE MANHOLE LARGE)
	(FLAGS NDESCBIT)
	(ACTION COVER-F)>

<ROUTINE COVER-F ()
	 <COND (<VERB? MOVE RAISE OPEN>
		<TELL
"The cover is moved a bit to one side, revealing a small hole leading into
darkness." CR>
		<SETG COVER-MOVED T>)
	       (<VERB? TAKE>
		<TELL
"The cover is far too heavy to take." CR>)>>

<ROUTINE KEY-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are between some rock and a dark place. The room is lit dimly from
above, revealing a lone, dark path sloping down to the west." CR>
		<COND (,COVER-MOVED
		       <TELL
"A heavy manhole cover has been moved to reveal a dark passage below." CR>)
		      (T
		       <TELL
"To one side of the room is a large manhole cover." CR>)>)>>

<OBJECT KEY
	(IN KEY-ROOM)
	(DESC "strange key")
	(FDESC
"The light from above seems to be focused in the center of the room, where
a single key is lying in the dust.")
	(SYNONYM KEY)
	(ADJECTIVE STRANGE RUSTY LONG SHORT HEAVY THIN SHARP POINTED)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION KEY-F)>

<ROUTINE KEY-F ()
	 <COND (<AND <VERB? UNLOCK> <==? ,PRSI ,KEY>>
		<COND (<AND <==? ,PRSO ,BRONZE-DOOR> <==? ,HERE ,GOOD-CELL>>
		       <COND (,BRONZE-DOOR-LOCKED
			      <TELL
"The key seems to mold itself to the shape of the lock. With a mere
twist of your hand, the massive bolt gives way." CR>)
			     (T <TELL "It already is." CR>)>
		       <SETG BRONZE-DOOR-LOCKED <>>
		       <RTRUE>)
		      (<==? ,PRSO ,BRONZE-DOOR>
		       <TELL
"The key molds itself to the lock but will not turn." CR>)
		      (<OR <EQUAL? ,PRSO ,CHEST>
			   <FSET? ,PRSO ,DOORBIT>>
		       <TELL
"The key, which initially seemed certain to fit the lock, seems to change
shape and will not enter the keyhole." CR>)>)
	       (<VERB? EXAMINE>
		<TELL <RANDOM-ELEMENT ,KEY-DESCS> CR>
		<TELL
"Strange, though. The key seems to change shape constantly." CR>)>>

<GLOBAL KEY-DESCS <LTABLE
"The key is a long and heavy skeleton key."
"The key is short and stubby, shaped like no lock you have ever seen."
"The key is round and thin, more like a pencil than a key."
"The key is shiny with many prongs."
"The key is sharp as an awl, and rusted badly.">>

<OBJECT VIEW-INDICATOR
	(IN VIEW-ROOM)
	(DESC "indicator")
	(SYNONYM INDICATOR DIAL)
	(FLAGS NDESCBIT READBIT)
	(ACTION VIEW-INDICATOR-F)>

<ROUTINE VIEW-INDICATOR-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL "The indicator reads \""
		      <GET ,VIEW-ROMANS ,ACTIVE-VIEW>
		      "\"." CR>)>>

<GLOBAL BOAT-SEEN <>>

<ROUTINE FLATHEAD-OCEAN-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are at the shore of an amazing underground sea, the topic of many a
legend among adventurers. Few were known to have arrived at this spot, and
fewer to return. There is a heavy surf and a breeze is blowing on-shore.
The land rises steeply to the east and quicksand prevents movement to the
south. A thick mist covers the ocean and extends over the hills to the east.
A path heads north along the beach." CR>
		<COND (<NOT <FSET? ,VIKING-SHIP ,INVISIBLE>>
		       <TELL
"An ancient Viking ship is passing along the shore, an old and crusty
sailor at the helm." CR>)>
		<RTRUE>)
	       (<AND <==? .RARG ,M-END>
		     <PROB 20>
		     <NOT ,BOAT-SEEN>
		     ,LIT>
		<SETG BOAT-SEEN T>
		<ENABLE <QUEUE I-BOAT-DISAPPEAR 2>>
		<TELL
"Passing alongside the shore now is an old boat, reminiscent of an ancient
Viking ship. Standing on the prow of the ship is an old and crusty sailor,
peering out over the misty ocean." CR>
		<FCLEAR ,VIKING-SHIP ,INVISIBLE>)>>

<GLOBAL SHIP-GONE <>>

<ROUTINE I-BOAT-DISAPPEAR ()
	 <FSET ,VIKING-SHIP ,INVISIBLE>
	 <SETG SHIP-GONE T>
	 <COND (<==? ,HERE ,FLATHEAD-OCEAN>
		<TELL
"The boat sails silently through the mist and out of sight." CR>)>>

<OBJECT VIKING-SHIP
	(IN FLATHEAD-OCEAN)
	(DESC "Viking Ship")
	(FLAGS NDESCBIT INVISIBLE)
	(ADJECTIVE VIKING)
	(SYNONYM BOAT SHIP CRAFT)>

<OBJECT VIAL
	(DESC "vial")
	(SYNONYM VIAL ODOR GIFT)
	(FLAGS TAKEBIT CONTBIT)
	(SIZE 3)
	(CAPACITY 3)
	(ACTION VIAL-F)>

<OBJECT POTION
	(IN VIAL)
	(DESC "heavy but invisible liquid")
	(SYNONYM POTION LIQUID CONTENTS FLUID)
	(ADJECTIVE HEAVY SWEET INVISIBLE SMELLING)
	(SIZE 2)
	(FLAGS)
	(ACTION POTION-F)>

<ROUTINE I-VISIBLE ()
	 <SETG INVIS <>>
	 <COND (<EQUAL? ,HERE ,MRG ,MRGE ,MRGW>
		<JIGS-UP
"One of the stone figures (or maybe both, it's hard to tell) suddenly springs
to life and crushes you with his stone bludgeon.">)>
	 <RFALSE>>

<ROUTINE POTION-F ()
	 <COND (<VERB? DRINK>
		<REMOVE ,POTION>
		<SETG INVIS T>
		<ENABLE <QUEUE I-VISIBLE 3>>
		<TELL
"You \"drink\" the contents in one gulp, but nothing unusual seems to have
happened as a result." CR>)
	       (<AND <VERB? POUR-ON> <==? ,PRSO ,POTION>>
		<REMOVE ,POTION>
		<TELL "It spills onto the " D ,PRSI " and vanishes." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It feels like there's something inside, but you can't see anything even
though the vial is transparent." CR>)
	       (<VERB? SMELL>
		<TELL
"The vial (or something in it) smells sweet." CR>)
	       (<VERB? DROP TAKE>
		<TELL
"Nothing seems to come out, although the sweet smell disappears from
the vial, seeming to permeate the air briefly before fading entirely." CR>
		<REMOVE ,POTION>)>>

<GLOBAL INVIS <>>

<ROUTINE VIAL-F ()
	 <COND (<VERB? FILL> <TELL "You can't seem to put anything in it." CR>)
	       (<AND <VERB? DRINK-FROM> <IN? ,POTION ,VIAL>>
		<PERFORM ,V?DRINK ,POTION>
		<RTRUE>)
	       (<AND <VERB? SMELL> <IN? ,POTION ,VIAL>>
		<PERFORM ,V?SMELL ,POTION>
		<RTRUE>)
	       (<AND <VERB? SHAKE> <IN? ,POTION ,VIAL> <FSET? ,VIAL ,OPENBIT>>
		<TELL
"Nothing seems to come out, although the vial is lighter now." CR>
		<REMOVE ,POTION>)
	       (<VERB? OPEN>
		<FSET ,VIAL ,OPENBIT>
		<TELL
"The vial is open.">
		<COND (<IN? ,POTION ,VIAL>
		       <TELL
" There is a sweet odor from within the vial, apparently coming from a heavy
but invisible liquid.">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<TELL "It is a small, transparent vial ">
		<COND (<IN? ,POTION ,VIAL>
		       <TELL
"which looks empty but is strangely heavy." CR>)
		      (T
		       <TELL
"which is light and empty." CR>)>)>>

<OBJECT OCEAN
	(IN GLOBAL-OBJECTS)
	(DESC "Flathead Ocean")
	(SYNONYM OCEAN WATER)
	(ADJECTIVE FLATHEAD)
	(FLAGS NDESCBIT)
	(ACTION OCEAN-F)>

<ROUTINE OCEAN-F ()
	 <COND (<NOT <==? ,HERE ,FLATHEAD-OCEAN>>
		<TELL "There is no ocean here." CR>)
	       (<VERB? THROUGH BOARD>
		<TELL "You would be killed by the pounding surf!" CR>)
	       (<AND <VERB? PUT THROW> <==? ,PRSI ,OCEAN>>
		<TELL
"The " D ,PRSO " falls into the ocean and is lost forever." CR>
		<REMOVE ,PRSO>)>>

<OBJECT STONE
	(DESC "great rock")
	(SYNONYM ROCK STONE)
	(ADJECTIVE GREAT)
	(IN JUNCTION)
	(DESCFCN STONE-DESC)
	(FLAGS CONTBIT OPENBIT)
	(CAPACITY 30)
	(ACTION STONE-F)>

<GLOBAL SWORD-IN-STONE? T>

<ROUTINE STONE-DESC (FOO)
	 <TELL
"Standing before you is a great rock.">
	 <COND (,SWORD-IN-STONE?
		<TELL " Imbedded within it is an Elvish sword.">)>
	 <CRLF>>

<ROUTINE STONE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "You can't be serious." CR>)
	       (<AND <VERB? PUT> <==? ,PRSI ,STONE>>
		<TELL "You can't force anything into the stone." CR>)
	       (<AND <VERB? MOVE TAKE PUSH> <==? ,PRSO ,STONE>>
		<TELL
"The stone is far too massive to be moved." CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"Since it can't be moved, it's hard to know what's there." CR>)>>

<OBJECT FISH
	(IN LOCAL-GLOBALS)
	(DESC "fish")
	(SYNONYM FISH)
	(FLAGS NDESCBIT)
	(ACTION FISH-F)>

<ROUTINE FISH-F ()
	 <TELL "There is no fish visible now." CR>>
	 
<ROUTINE QUICKSAND-PSEUDO ()
	 <COND (<VERB? THROUGH LEAP>
		<JIGS-UP
"You enter the quicksand and slowly sink to a new low in adventuring.">)
	       (<VERB? RUB>
		<TELL "It's quicksand all right!" CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "It's hard to tell what's in there." CR>)>>

<ROUTINE SWAMP-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<TELL "Yucko." CR>)>>

<ROUTINE MIST-PSEUDO ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "You can't make anything out through the mist." CR>)
	       (<VERB? SMELL>
		<TELL "It smells vaguely salty." CR>)>>

<ROUTINE SHORE-PSEUDO ()
	 <COND (<VERB? DIG>
		<TELL "There's nothing there." CR>)>>
	       

<ROUTINE WATERFALL-PSEUDO ()
	 <COND (<VERB? CLIMB-UP>
		<TELL "It's much too slippery." CR>)>>

<ROUTINE ARCH-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<COND (,AQ-FLAG
		       <TELL
"The arches all show some signs of decay." CR>)
		      (T
		       <TELL
"The arch before you is broken. The others show signs of decay." CR>)>)>>
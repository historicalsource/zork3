;"Copyright 1982 by Infocom, Inc."

;"Incredibly bizarre Time Machine Problem"

<OBJECT VOICES
	(IN GLOBAL-OBJECTS)
	(DESC "voices")
	(SYNONYM VOICE VOICES GUARDS OFFICI)
	(ADJECTIVE ARMED)
	(FLAGS NDESCBIT)
	(ACTION VOICES-F)>

<ROOM TIGHT-SQUEEZE
      (IN ROOMS)
      (DESC "Tight Squeeze")
      (LDESC
"This is a very low and narrow passage leading east to west.")
      (WEST TO CREEPY-CRAWL)
      (EAST TO ROCKY-ROOM)
      (FLAGS RLANDBIT)>

<ROOM ROCKY-ROOM
      (IN ROOMS)
      (DESC "Crystal Grotto")
      (LDESC
"This is a chamber of breathtaking beauty. Mighty stalagmites form
structured shapes of rock, encrusted with crystalline formations.
Phosphorescent mosses, fed by a trickle of water from some unseen source
above, make the crystals glow and sparkle with every color of the rainbow.
There is an opening to the west, and a man-made passage heads south.")
      (SOUTH TO WIDE-HALL)
      (WEST TO TIGHT-SQUEEZE)
      (GLOBAL MOSS CRYSTALS)
      (FLAGS ONBIT RLANDBIT)>

<OBJECT CRYSTALS
	(IN ROCKY-ROOM)
	(DESC "rock structure")
	(SYNONYM CRYSTAL STALAG)
	(FLAGS NDESCBIT)>

<ROOM WIDE-HALL
      (IN ROOMS)
      (DESC "Royal Hall")
      (LDESC
"This is the north end of a large hall with a vaulted ceiling.  A long, tiled
hallway leads north through a tall arch.  Although the origin or purpose of
this room is unclear, there is a large rendering of the Royal Seal of Lord
Dimwit Flathead carved on the wall.")
      (NORTH TO ROCKY-ROOM)
      (SOUTH TO MUSEUM-ANTE)
      (FLAGS RLANDBIT)>     

<OBJECT ROYAL-SEAL
	(IN WIDE-HALL)
	(DESC "Royal Seal of Dimwit Flathead")
	(SYNONYM SEAL CARVIN RENDER)
	(ADJECTIVE LARGE ROYAL)
	(FLAGS NDESCBIT READBIT)
	(TEXT
"The Seal is vintage Flathead, with signs of excess nearly everywhere.
It consists of a curiously flat-headed figure wearing a gaudy crown,
surrounded by the Crown Jewels of the Empire.")> 

<ROOM MUSEUM-ANTE
      (IN ROOMS)
      (DESC "Great Door")
      (NORTH TO WIDE-HALL)
      (EAST TO MUSEUM-ENTRANCE
       	    IF CLEFT-FLAG ELSE "The great iron door is rusted shut.")
      (FLAGS RLANDBIT)
      (ACTION MUSEUM-ANTE-F)
      (GLOBAL IRON-DOOR CLEFT)>

<ROOM MUSEUM-ENTRANCE
      (IN ROOMS)
      (DESC "Museum Entrance")
      (EAST TO JEWEL-ROOM IF JEWEL-DOOR IS OPEN)
      (WEST TO MUSEUM-ANTE IF CLEFT-FLAG ELSE "The iron door is rusted shut.")
      (SOUTH TO CP-ANTE)
      (DOWN TO CP-ANTE)
      (NORTH TO TECH-MUSEUM IF WOODEN-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION MUSEUM-ENTRANCE-F)
      (GLOBAL IRON-DOOR JEWEL-DOOR WOODEN-DOOR STAIRS CLEFT)>

<OBJECT CLEFT
	(IN LOCAL-GLOBALS)
	(DESC "cleft")
	(SYNONYM CLEFT)
	(ACTION CLEFT-F)
	(FLAGS DOORBIT OPENBIT INVISIBLE)>

<ROOM JEWEL-ROOM
      (IN ROOMS)
      (DESC "Jewel Room")
      (WEST TO MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (OUT TO MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION JEWEL-ROOM-F)
      (GLOBAL JEWEL-DOOR)>

<ROOM TECH-MUSEUM
      (IN ROOMS)
      (DESC "Technology Museum")
      (SOUTH TO MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (OUT TO MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (ACTION TECH-MUSEUM-F)
      (GLOBAL WOODEN-DOOR)>

<ROOM MID-CP-ANTE
      (IN ROOMS)
      (DESC "Royal Puzzle Entrance")
      (WEST TO MID-CP-OUT)
      (NORTH TO MID-MUSEUM-ENTRANCE)
      (UP TO MID-MUSEUM-ENTRANCE)
      (DOWN PER CPENTER)
      (FLAGS RLANDBIT ONBIT)
      (ACTION CPANT-ROOM)
      (GLOBAL STAIRS)>

<ROOM MID-CP-OUT
      (IN ROOMS)
      (DESC "Side Room")
      (NORTH TO MID-CP-ANTE)
      (EAST "The steel door is closed.")
      (FLAGS RLANDBIT ONBIT)
      (ACTION CPOUT-ROOM)
      (GLOBAL CPDOOR STAIRS)>

<ROOM MID-MUSEUM-ENTRANCE
      (IN ROOMS)
      (DESC "Museum Entrance")
      (EAST TO MID-JEWEL-ROOM IF JEWEL-DOOR IS OPEN)
      (WEST "The iron door is rusted shut.")
      (SOUTH TO MID-CP-ANTE)
      (DOWN TO MID-CP-ANTE)
      (NORTH TO MID-TECH-MUSEUM IF WOODEN-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION MUSEUM-ENTRANCE-F)
      (GLOBAL IRON-DOOR JEWEL-DOOR WOODEN-DOOR STAIRS)>

<ROOM MID-JEWEL-ROOM
      (IN ROOMS)
      (DESC "Jewel Room")
      (WEST TO MID-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (OUT TO MID-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (ACTION JEWEL-ROOM-F)
      (GLOBAL JEWEL-DOOR)>

<ROOM MID-TECH-MUSEUM
      (IN ROOMS)
      (DESC "Technology Museum")
      (SOUTH TO MID-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (OUT TO MID-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (ACTION TECH-MUSEUM-F)
      (GLOBAL WOODEN-DOOR)>

<ROOM OLD-TECH-MUSEUM
      (IN ROOMS)
      (DESC "Technology Museum")
      (FLAGS ONBIT RLANDBIT)
      (ACTION OLD-TECH-MUSEUM-F)
      (SOUTH TO OLD-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (OUT TO OLD-MUSEUM-ENTRANCE IF WOODEN-DOOR IS OPEN)
      (GLOBAL WOODEN-DOOR ROBOT)>

<ROOM OLD-JEWEL-ROOM
      (IN ROOMS)
      (DESC "Jewel Room")
      (FLAGS ONBIT RLANDBIT)
      (ACTION OLD-TECH-MUSEUM-F)
      (WEST TO OLD-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (OUT TO OLD-MUSEUM-ENTRANCE IF JEWEL-DOOR IS OPEN)
      (GLOBAL JEWEL-DOOR ROBOT)>

<ROOM OLD-MUSEUM-ENTRANCE
      (IN ROOMS)
      (DESC "Museum Entrance")
      (FLAGS ONBIT RLANDBIT)
      (ACTION OLD-TECH-MUSEUM-F)
      (EAST TO OLD-JEWEL-ROOM IF JEWEL-DOOR IS OPEN)
      (WEST "The guards locked the iron door behind them.")
      (NORTH TO OLD-TECH-MUSEUM IF WOODEN-DOOR IS OPEN)
      (SOUTH "The stairs end blindly to the south.")
      (GLOBAL WOODEN-DOOR JEWEL-DOOR IRON-DOOR ROBOT)>
     
<OBJECT TIME-MACHINE
	(IN TECH-MUSEUM)
	(DESC "gold machine")
	(SYNONYM MACHINE TEMPORIZER)
	(ADJECTIVE TIME GOLD GOLDEN)
	(FLAGS VEHBIT OPENBIT CONTBIT)
	(CAPACITY 100)
	(DESCFCN TIME-MACHINE-F)
	(ACTION TIME-MACHINE-F)>

<OBJECT PRESSURIZER
	(IN TECH-MUSEUM)
	(DESC "grey machine")
	(SYNONYM MACHINE DRYER PRESSURIZER)
	(ADJECTIVE GRAY GREY WASHING)
	(ACTION MUSEUM-PIECES)
	(DESCFCN MUSEUM-PIECES)>

<OBJECT SPINNER
	(IN TECH-MUSEUM)
	(DESC "black machine")
	(SYNONYM MACHINE PIPES WIRES MOTORS)
	(ADJECTIVE BLACK)
	(DESCFCN MUSEUM-PIECES)
	(ACTION MUSEUM-PIECES)>

<OBJECT TM-BUTTON
	(IN TIME-MACHINE)
	(DESC "button")
	(SYNONYM BUTTON)
	(FLAGS NDESCBIT)
	(ACTION TM-BUTTON-F)>

<OBJECT TM-SEAT
	(IN TIME-MACHINE)
	(DESC "seat")
	(SYNONYM SEAT CHAIR)
	(FLAGS NDESCBIT OPENBIT CONTBIT SURFACEBIT VEHBIT)
	(CAPACITY 20)
	(ACTION TM-SEAT-F)>

<OBJECT TM-DIAL
	(IN TIME-MACHINE)
	(DESC "dial")
	(SYNONYM DIAL CONSOLE DISPLAY)
	(FLAGS NDESCBIT TURNBIT)
	(ACTION TM-DIAL-F)>

<OBJECT IRON-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "iron door")
	(SYNONYM DOOR)
	(ADJECTIVE IRON)
	(FLAGS DOORBIT CONTBIT)
	(ACTION IRON-DOOR-F)>

<OBJECT JEWEL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "stone door")
	(SYNONYM DOOR)
	(ADJECTIVE STONE EAST)
	(ACTION JEWEL-DOOR-F)
	(FLAGS DOORBIT CONTBIT)>

<OBJECT WOODEN-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "wooden door")
	(SYNONYM DOOR)
	(ADJECTIVE WOODEN WOOD NORTH)
	(FLAGS DOORBIT CONTBIT OPENBIT)
	(ACTION WOODEN-DOOR-F)>

<OBJECT SCEPTRE
	(IN PEDESTAL)
	(DESC "sceptre")
	(SYNONYM SCEPTRE JEWELS)
	(ADJECTIVE CROWN)
	(FLAGS TAKEBIT NDESCBIT)
	(SIZE 30)
	(ACTION CROWN-JEWELS-F)>

<OBJECT JEWELLED-KNIFE
	(IN PEDESTAL)
	(DESC "jewelled knife")
	(SYNONYM KNIFE JEWELS)
	(ADJECTIVE JEWELLED CROWN)
	(FLAGS TAKEBIT NDESCBIT)
	(SIZE 20)
	(ACTION CROWN-JEWELS-F)>

<OBJECT RING
	(IN PEDESTAL)
	(DESC "golden ring")
	(SYNONYM RING JEWELS)
	(ADJECTIVE GOLDEN CROWN)
	(FLAGS TAKEBIT NDESCBIT WEARBIT)
	(SIZE 5)
	(ACTION CROWN-JEWELS-F)>

<OBJECT PEDESTAL
	(IN JEWEL-ROOM)
	(DESC "pedestal")
	(SYNONYM PEDESTAL)
	(FLAGS NDESCBIT OPENBIT CONTBIT SURFACEBIT)
	(CAPACITY 50)
	(ACTION PEDESTAL-F)>

<OBJECT CAGE
	(IN JEWEL-ROOM)
	(DESC "steel cage")
	(SYNONYM CAGE)
	(ADJECTIVE STEEL)
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 5)
	(ACTION CAGE-F)>

<OBJECT TECH-PLAQUE
	(IN TECH-MUSEUM)
	(DESC "plaque")
	(SYNONYM PLAQUE TEXT)
	(FLAGS NDESCBIT READBIT)
	(ACTION TECH-PLAQUE-F)>

<OBJECT PLAQUE
	(IN CAGE)
	(DESC "bronze plaque")
	(SYNONYM PLAQUE TEXT)
	(ADJECTIVE BRONZE)
	(FLAGS NDESCBIT READBIT)
	(ACTION PLAQUE-F)>

;"The present year using the GUE calendar."

<GLOBAL MACHINE-DAMAGED <>>

<GLOBAL YEAR 948>

<CONSTANT YEAR-BUILT 776>

<CONSTANT YEAR-CAGED 777>

<GLOBAL YEAR-CLOSED 883>

<CONSTANT REAL-YEAR-CLOSED 883>

<CONSTANT YEAR-PRESENT 948>

<ROUTINE IRON-DOOR-F ()
	 <COND (<VERB? OPEN UNLOCK THROUGH>
	        <COND (<L? ,YEAR ,YEAR-PRESENT>
		       <TELL
"The iron door appears to be locked from the outside." CR>)
		      (T
		       <TELL
"The iron door is rusted shut and cannot be opened." CR>)>)>>

<GLOBAL CLEFT-FLAG <>>

<ROUTINE I-CLEFT ()
	 <COND (<OR <EQUAL? ,HERE ,ZORK-IV ,ROOM-8 ,TIMBER-ROOM>
		    <EQUAL? ,HERE ,LOWER-SHAFT ,LADDER-BOTTOM ,LADDER-TOP>>
		<TELL
"You feel a mild tremor from within the earth which passes quickly." CR>)
	       (T
		<TELL
"There is a great tremor from within the earth.  The entire dungeon shakes
violently and loose debris starts to fall from above you." CR>)>
	 <COND (<==? ,HERE ,MUSEUM-ANTE>
		<TELL
"To the east, to the right of the great iron door, a large cleft opens up,
revealing an open area behind!" CR>)
	       (<==? ,HERE ,AQ-VIEW>
		<TELL
"One of the giant pillars supporting the aqueduct collapses in a pile
of smoke and rubble!" CR>)
	       (<EQUAL? ,HERE ,AQ-2 ,AQ-3>
		<TELL
"The channel beneath your feet trembles.  At once, the channel directly
to the ">
		<COND (<==? ,HERE ,AQ-2> <TELL "north">)
		      (T <TELL "south">)>
		<TELL " of you collapses with its supporting pillar and falls
into the chasm!" CR>)>
	 <SETG CLEFT-FLAG T>
	 <FCLEAR ,CLEFT ,INVISIBLE>
	 <SETG AQ-FLAG <>>
	 <RTRUE>>

<ROUTINE CLEFT-F ()
	 <COND (<NOT <==? ,YEAR ,YEAR-PRESENT>>
		<TELL "There is no cleft here." CR>)>>

<ROUTINE MUSEUM-ANTE-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (,CLEFT-FLAG
		       <TELL
"This is the south end of a monumental hall, full of dust and debris from
a recent earthquake.  To the east is a great iron door, rusted shut.  To its
right, however, is a gaping cleft in the rock and behind, a cleared area." CR>)
		      (T
		       <TELL
"You are in the southern half of a monumental hall.  To the east lies
a tremendous iron door which appears to be rusted shut." CR>)>)>>
		
<ROUTINE DDESC (STR1 DOOR STR2)
	 #DECL ((STR1) STRING (DOOR) OBJECT (STR2) <OR FALSE STRING>)
	 <TELL .STR1>
	 <COND (<FSET? .DOOR ,OPENBIT> <TELL "open">)
	       (T <TELL "closed">)>
	 <TELL .STR2 CR>>

<ROUTINE MUSEUM-ENTRANCE-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (<FSET? ,CAGE ,INVISIBLE>
		       <TELL
"This seems to be an entrance hall of some sort, judging by the grand iron
door to the west, and the ornate stone and wooden doors which lead to the east
and north, respectively.  A few wide steps lead south." CR>)
		      (T
		       <TELL
"This is the entrance to the Royal Museum, the finest and grandest in the
Great Underground Empire.  To the south, down a few steps, is the entrance
to the Royal Puzzle and to the east, through a stone door, is the Royal
Jewel Collection.  A wooden door to the north is ">
		      <TELL <COND (<FSET? ,WOODEN-DOOR ,OPENBIT> "open")
		                  (T "closed")> "
and leads to the Museum of Technology. ">
		      <COND (<==? ,YEAR ,YEAR-PRESENT>
			     <TELL
"To the west is a great iron door, rusted shut.  To its left, however, is a
cleft in the rock providing a western route away from the museum." CR>)
			    (<L? ,YEAR ,YEAR-PRESENT>
			     <TELL
"To the west is a great iron door, which is rusted shut." CR>)
			    (T
			     <TELL
"To the west is a great iron door, rusted shut.  The cleft in the rock,
present when you started, has filled in with rubble." CR>)>)>)>>

<GLOBAL TM-YEAR 948>

<ROUTINE TIME-MACHINE-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<TELL
"Directly in front of you is a large golden machine, which has a seat with a
console in front.  On the console is a single button and a dial connected to
a three-digit display which reads " N ,TM-YEAR
". The machine is suprisingly shiny and shows few signs of age." CR>)
	       (<AND <==? .RARG ,M-END> <VERB? PUT> <==? ,PRSI ,TIME-MACHINE>>
		<TELL
"You can't put anything on or inside the machine itself." CR>)
	       (<AND <==? .RARG ,M-BEG> <VERB? MOVE>>
		<TELL
"You might be able to move the machine by pushing it." CR>)
	       (<AND <==? .RARG ,M-BEG>
		     <VERB? PUSH-TO>
		     <==? ,PRSO ,TIME-MACHINE>>
		<TELL "That would be a good trick from inside it." CR>)
	       (<AND <==? .RARG ,M-END> <==? ,PRSO ,TIME-MACHINE>>
		<COND (<VERB? EXAMINE>
		       <TELL
"The machine consists of a seat and a console containing one small button
and a dial connected to a display which reads " N ,TM-YEAR "." CR>)
		      (<AND <VERB? BOARD> <FIRST? ,TM-SEAT>>
		       <TELL
"That will be somewhat uncomfortable!" CR>)
		      (<VERB? TAKE RAISE>
		       <TELL
"The machine must weigh hundreds of pounds and cannot be carried." CR>)
		      (<VERB? PUSH>
		       <TELL
"You should specify in which direction to push the machine." CR>)
		      (<VERB? PUSH-TO>
		       <COND (<NOT <==? <DO-WALK ,P-DIRECTION> ,M-FATAL>>
			      <TELL
"With some effort, you push the machine into the room with you." CR>
			      <COND (<EQUAL? ,HERE ,CP-ANTE ,MID-CP-ANTE>
				     <TELL
"However, the machine seems to have sustained some damage as a result
of going over the stairs." CR>
				     <SETG MACHINE-DAMAGED T>)
				    (<==? ,HERE ,MUSEUM-ANTE>
				     <TELL
"Pushing the machine through the cleft seems to have damaged it." CR>
				     <SETG MACHINE-DAMAGED T>)>
			      <MOVE ,TIME-MACHINE ,HERE>)>
		       <RTRUE>)>)
	       (<NOT <==? .RARG ,M-BEG>> <RFALSE>)
	       (<VERB? WALK>
		<TELL "You're not going anywhere in this heap." CR>)
	       (<AND <VERB? TAKE PUT MOVE PUSH OPEN CLOSE>
		     <NOT <HELD? ,PRSO>>
		     <NOT <IN? ,PRSO ,TIME-MACHINE>>>
		<TELL "You can't do that from inside the machine." CR>)>>

<GLOBAL RING-CONCEALED <>>

<ROUTINE TM-SEAT-F ()
	 <COND (<VERB? CLIMB-ON BOARD>
		<PERFORM ,V?BOARD ,TIME-MACHINE>
		<RTRUE>)
	       (<AND <VERB? PUT-UNDER PUT-BEHIND> <==? ,PRSI ,TM-SEAT>>
		<COND (<==? ,PRSO ,RING>
		       <TELL "The ring is concealed underneath the seat." CR>
		       <SETG RING-CONCEALED T>
		       <REMOVE ,RING>)
		      (T
		       <TELL
"It's too big to hide under the seat." CR>)>)
	       (<VERB? RUB>
		<TELL "There's nothing odd about the feel of the seat." CR>)
	       (<VERB? LOOK-UNDER RAISE MOVE>
		<COND (,RING-CONCEALED
		       <TELL
"You find the ring under the seat and put it on your finger." CR>
		       <MOVE ,RING ,WINNER>
		       <SETG RING-CONCEALED <>>
		       <RTRUE>)
		      (T <TELL
"You notice a small hollow area under the seat." CR>)>)>>

<ROUTINE TM-DIAL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The dial is set to " N ,TM-YEAR "." CR>)
	       (<VERB? TURN>
		<COND (<==? ,PRSI ,INTNUM>
		       <COND (<G? ,P-NUMBER 999>
			      <TELL "You can't set it beyond 999." CR>)
			     (T
			      <SETG TM-YEAR ,P-NUMBER>
			      <TELL "The dial is set to " N ,TM-YEAR "." CR>)>)
		      (<NOT ,PRSI>
		       <TELL "You have to say what to turn it to!" CR>)
		      (T <TELL "You can't do that!" CR>)>)>>

<GLOBAL TM-POINT <>>

<ROUTINE TM-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<AND <==? ,TM-YEAR ,YEAR-BUILT> <NOT ,TM-POINT>>
		       <SETG SCORE <+ ,SCORE 1>>
		       <SETG TM-POINT T>)>
		<COND (<OR ,MACHINE-DAMAGED
		           <NOT <IN? ,WINNER ,TIME-MACHINE>>>
		       <TELL "Nothing seems to have happened." CR>)
		      (<L? ,TM-YEAR ,YEAR-BUILT>
		       <REALLY-DEAD
"You experience a brief period of disorientation. The area around you seems
to be solidifying! Rock formations close in on you and before you can react
you are engulfed in stone!">)
		      (<==? ,YEAR ,TM-YEAR>
		       <TELL "Nothing seems to have happened." CR>)
		      (<L? ,TM-YEAR ,YEAR-CLOSED>
		       <TELL
"You experience a brief period of disorientation.  When your vision returns,">
		       <COND (<EQUAL? ,HERE ,MUSEUM-ENTRANCE
				      ,MID-MUSEUM-ENTRANCE
				      ,OLD-MUSEUM-ENTRANCE>
			      <COND (<==? ,TM-YEAR ,YEAR-CAGED>
				     <TELL "
you are surrounded by a number of heavily armed guards, the dress and
speech of which seem strange and unfamiliar.  A commotion starts at a door
to the east and a person with a flat head, wearing a gaudy crown and a purple
robe, bursts into the room." CR>
				     <FLATHEAD-SENTENCE>)
				    (T
				     <GUARDS-KILL>)>)
			     (<EQUAL? ,HERE ,JEWEL-ROOM ,MID-JEWEL-ROOM
				            ,OLD-JEWEL-ROOM>
			      <COND (<==? ,TM-YEAR ,YEAR-CAGED>
				     <TELL "
you find yourself in the middle of some kind of ceremony, with a strange
flat-headed man wearing royal vestments about to break a bottle on the bars
of an iron cage containing magnificent jewels.  He appears somewhat pleased
by your presence. ">
				     <FLATHEAD-SENTENCE>)
				    (<G? ,TM-YEAR ,YEAR-CAGED>
				     <GUARDS-KILL>)
				    (T
				     <TELL "
your surroundings appear to have changed.  From outside the door
you hear the sounds of guards talking." CR>
				     <TGOTO ,OLD-JEWEL-ROOM>)>)
			     (<EQUAL? ,HERE ,TECH-MUSEUM ,MID-TECH-MUSEUM
				            ,OLD-TECH-MUSEUM>
			      <COND (<NOT <==? ,TM-YEAR ,YEAR-BUILT>>
				     <GUARDS-KILL>)
				    (T
				     <TELL "
your surroundings appear to have changed.  From outside the door
you hear the sounds of guards talking." CR>
				     <TGOTO ,OLD-TECH-MUSEUM>)>)>)
		      (T
		       <HAPPY-NEW-YEAR>)>)>>

<ROUTINE HAPPY-NEW-YEAR ()
	 <TELL
"You experience a brief period of disorientation.  When your vision returns,
your surroundings appear somewhat altered." CR>
	 <COND (<EQUAL? ,HERE ,OLD-JEWEL-ROOM ,MID-JEWEL-ROOM ,JEWEL-ROOM>
		<COND (<L? ,TM-YEAR ,YEAR-PRESENT> <TGOTO ,MID-JEWEL-ROOM>)
		      (T <TGOTO ,JEWEL-ROOM>)>)
	       (<EQUAL? ,HERE ,OLD-TECH-MUSEUM ,MID-TECH-MUSEUM
			      ,TECH-MUSEUM>
		<COND (<L? ,TM-YEAR ,YEAR-PRESENT> <TGOTO ,MID-TECH-MUSEUM>)
		      (T <TGOTO ,TECH-MUSEUM>)>)
	       (<L? ,TM-YEAR ,YEAR-PRESENT> <TGOTO ,MID-MUSEUM-ENTRANCE>)
	       (T <TGOTO ,MUSEUM-ENTRANCE>)>>

<GLOBAL SNAP-LOC <>>

<ROUTINE I-SNAP ()
	 <COND (<==? ,YEAR ,YEAR-PRESENT>
		<RFALSE>)>
	 <SETG TM-YEAR ,YEAR-PRESENT>
	 <TELL
"You start to feel light-headed and, before you can even think, you become
completely disoriented.  When you regain your faculties, you realize that
your surroundings have changed." CR>
	 <TGOTO ,SNAP-LOC T>>

<ROUTINE MOVE-JEWELS ()
	 <COND (,RING-STOLEN <RTRUE>)>
	 <COND (<==? ,TM-YEAR ,YEAR-BUILT>
		<MOVE ,PEDESTAL ,OLD-JEWEL-ROOM>)
	       (<L? ,TM-YEAR ,YEAR-PRESENT>
		<MOVE ,PEDESTAL ,MID-JEWEL-ROOM>)
	       (T <MOVE ,PEDESTAL ,JEWEL-ROOM>)>
	 <MOVE ,SCEPTRE ,PEDESTAL>
	 <FSET ,SCEPTRE ,NDESCBIT>
	 <MOVE ,JEWELLED-KNIFE ,PEDESTAL>
	 <FSET ,JEWELLED-KNIFE ,NDESCBIT>
	 <COND (<NOT ,RING-CONCEALED>
		<MOVE ,RING ,PEDESTAL>
		<FSET ,RING ,NDESCBIT>)>>

<ROUTINE TGOTO ("OPTIONAL" (RM <>) (SNAP <>))
	 <SETG MOVES <+ ,MOVES 1>>
	 <QUEUE I-GUARDS-LEAVE 0>
	 <SETG INVIS <>>
	 <COND (<G? ,YEAR ,YEAR-BUILT>
		<SETG GUARDS-PRESENT T>)>
	 <COND (<==? ,YEAR ,YEAR-PRESENT>
		<SETG SNAP-LOC ,HERE>
		<ENABLE <QUEUE I-SNAP 40>>)>
	 <COND (<==? ,TM-YEAR ,YEAR-PRESENT>
		<SETG CLEFT-FLAG T>)
	       (T <SETG CLEFT-FLAG <>>)>
	 <FCLEAR ,JEWEL-DOOR ,OPENBIT>
	 <FCLEAR ,WOODEN-DOOR ,OPENBIT>
	 <FCLEAR ,IRON-DOOR ,OPENBIT>
	 <COND (<==? ,YEAR ,YEAR-BUILT>
		<COND (<AND ,RING-CONCEALED
			    <IN? ,TIME-MACHINE ,OLD-TECH-MUSEUM>
			    <IN? ,SCEPTRE ,PEDESTAL>
			    <IN? ,JEWELLED-KNIFE ,PEDESTAL>>
		       <SETG RING-STOLEN T>
		       <FSET ,CAGE ,INVISIBLE>
		       <FSET ,PEDESTAL ,INVISIBLE>
		       <REMOVE ,SCEPTRE>
		       <REMOVE ,JEWELLED-KNIFE>)
		      (<OR <NOT <IN? ,TIME-MACHINE ,OLD-TECH-MUSEUM>>
			   ,RING-CONCEALED>
		       <SETG CLUMSY-ROBBERY T>
		       <REMOVE ,TIME-MACHINE>)
		      (<OR <NOT <IN? ,RING ,PEDESTAL>>
			   <NOT <IN? ,SCEPTRE ,PEDESTAL>>
			   <NOT <IN? ,JEWELLED-KNIFE ,PEDESTAL>>>
		       <SETG MYSTERY T>)>)>
	 <COND (<==? ,TM-YEAR ,YEAR-BUILT>
		<SETG MYSTERY <>>
		<SETG CLUMSY-ROBBERY <>>)>
	 <SETG YEAR ,TM-YEAR>
	 <MOVE-TM-OBJECTS>
	 <MOVE-JEWELS>
	 <MOVE ,WINNER ,HERE>
	 <GOTO .RM <>>
	 <COND (<==? ,YEAR ,YEAR-BUILT>
		<MOVE ,TIME-MACHINE ,OLD-TECH-MUSEUM>
		<MOVE ,SPINNER ,OLD-TECH-MUSEUM>
		<MOVE ,PRESSURIZER ,OLD-TECH-MUSEUM>
		<MOVE ,TECH-PLAQUE ,OLD-TECH-MUSEUM>)
	       (<L? ,YEAR ,YEAR-PRESENT>
		<COND (<NOT ,CLUMSY-ROBBERY>
		       <MOVE ,TIME-MACHINE ,MID-TECH-MUSEUM>)>
		<MOVE ,SPINNER ,MID-TECH-MUSEUM>
		<MOVE ,PRESSURIZER ,MID-TECH-MUSEUM>
		<MOVE ,TECH-PLAQUE ,MID-TECH-MUSEUM>
		<MOVE ,CAGE ,MID-JEWEL-ROOM>)
	       (T
		<MOVE ,TIME-MACHINE ,TECH-MUSEUM>
		<MOVE ,SPINNER ,TECH-MUSEUM>
		<MOVE ,PRESSURIZER ,TECH-MUSEUM>
		<MOVE ,TECH-PLAQUE ,TECH-MUSEUM>
		<MOVE ,CAGE ,JEWEL-ROOM>)>
	 <COND (<OR ,CLUMSY-ROBBERY
		    <NOT <EQUAL? ,HERE ,TECH-MUSEUM
				 ,MID-TECH-MUSEUM
				 ,OLD-TECH-MUSEUM>>>
		<COND (<NOT .SNAP>
		       <TELL
"You notice that the golden machine has disappeared!" CR>)>)
	       (T <MOVE ,WINNER ,TIME-MACHINE>)>
	 <COND (,CLUMSY-ROBBERY <REMOVE ,TIME-MACHINE>)>
	 <RTRUE>>

<ROUTINE MOVE-TM-OBJECTS ("AUX" F (MFLG <>) (WFLG <>) N)
	 <SET F <FIRST? ,TIME-MACHINE>>
	 <COND (.F
	        <REPEAT ()
			<COND (<OR <EQUAL? .F ,TM-DIAL ,TM-SEAT ,TM-BUTTON>
				   <EQUAL? .F ,PLAYER>> T)
			      (<NOT .MFLG>
			       <SET MFLG T>
			       <TELL
"You notice that everything in the machine is gone">)>
			<SET N <NEXT? .F>>
			<COND (<NOT <EQUAL? .F ,TM-DIAL ,TM-SEAT ,TM-BUTTON>>
			       <MOVE .F ,HERE>)>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>
	 <SET F <FIRST? ,WINNER>>
	 <COND (.F
		<REPEAT ()
			<COND (<NOT .WFLG>
			       <SET WFLG T>
			       <COND (.MFLG
				      <TELL ": come to mention
it, everything you were holding has vanished too">)
				     (T <TELL
"You notice that everything you were holding is gone">)>)>
			<SET N <NEXT? .F>>
			<MOVE .F ,HERE>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>
	 <COND (<OR .MFLG .WFLG> <TELL "!" CR>)>>

<ROUTINE GUARDS-KILL ()
	 <TELL <PICK-ONE ,GUARD-KILLERS> CR>
	 <REALLY-DEAD " ">>

<GLOBAL GUARD-KILLERS <LTABLE
"
you are surrounded by heavily armed guards who seem awed by your presence.
One, whose IQ could not possibly be above 15, aims a strange waffle-like
instrument in your direction and all goes black."
"
you are confronted with a goodly number of particularly stupid-looking
people dressed in peculiar uniform and pointing waffle-like objects in
your general direction.  One twists his waffle and you slump
to the ground, dead."
"
you see before you a row of military people who, if appearances do not
deceive, have the cumulative intelligence of a not yet ripe grapefruit.  One
of them aims a waffle-shaped implement in your direction and you become numb
and then paralyzed and then dead.">>

<ROUTINE FLATHEAD-SENTENCE ()
	 <REALLY-DEAD "He speaks very loudly,
nearly deafening the poor civil servant whose duty it is to see that
his wishes are carried out. \"Aha! A thief! Didn't I tell you that
we needed more security! But, no! You all said my idea to build the museum
under two miles of mountain and surrounded by five hundred feet of steel was
impractical! Now, what to do with this ... intruder? I have it! We'll build a
tremendous fortress on the highest mountain peak, with one narrow ladder
stretching thousands of feet to the pinnacle. There he will stay for the rest
of his life!\" His brow-beaten assistant hesitates. \"Don't you think, Your
Lordship, that your plan is a bit, well, a bit much?\" Flathead gives it a
second's thought. \"No, not really.\" he says, and you are led away.  A few
years later, your prison is finished.  You are taken there, and spend
the rest of your life in misery.">>

<ROUTINE REALLY-DEAD (STR)
	 <TELL .STR CR "||

  **  You have died  **||

">
	 <QUIT>>

<GLOBAL FLATHEAD-HEARD <>>

<GLOBAL RING-STOLEN <>>
<GLOBAL CLUMSY-ROBBERY <>>
<GLOBAL MYSTERY <>>

<GLOBAL GUARDS-PRESENT T>

<ROUTINE HEAR-FLATHEAD ()
	 <SETG FLATHEAD-HEARD T>
	 <TELL
"One particularly loud and grating voice can now be heard above the
others outside the room. \"Very nice! Very nice! Not enough security, but
very nice! Now, Lord Feepness, pay attention! I've been thinking and what
we need is a dam, a tremendous dam to control the Frigid River, with
thousands of gates. Yes! I can see it now. We shall call it ... Flood
Control Dam #2. No, not quite right. Aha! It will be Flood Control
Dam #3.\" \"Pardon me, my Lord, but wouldn't that be just a tad excessive?\"
\"Nonsense! Now, let me tell you my idea for hollowing out volcanoes...\" With
that, the voices trail out into nothingness." CR>>

<ROUTINE OLD-TECH-MUSEUM-F (RARG)
	 <COND (<AND <==? .RARG ,M-LOOK> <==? ,HERE ,OLD-JEWEL-ROOM>>
		<TELL
"You are in a high-ceilinged chamber, in the center of which
is a pedestal which ">
		<COND (<NOT ,RING-STOLEN>
		       <TELL "is the intended home of the Crown
Jewels of the Great Underground Empire: a jewelled knife, a golden ring, and
the royal sceptre.">
		       <COND (<OR <NOT <IN? ,SCEPTRE ,PEDESTAL>>
				  <NOT <IN? ,RING ,PEDESTAL>>
				  <NOT <IN? ,JEWELLED-KNIFE ,PEDESTAL>>>
			      <TELL
" Not all of the jewels are in place, however.">)>)
		      (T <TELL "is bare.">)>
		<TELL "
The room is, by appearances, unfinished." CR>
		<COND (,GUARDS-PRESENT
		       <TELL
"Through the door you can hear voices which, from their
sound, belong to military or police personnel." CR>)>
		<RTRUE>)
	       (<==? .RARG ,M-LOOK>
		<COND (<==? ,HERE ,OLD-TECH-MUSEUM>
		       <TELL
"You are in a large, unfinished room, probably intended to be a
part of the Royal Museum." CR>)
		      (T
		       <TELL
"This appears to be an unfinished entranceway to the Royal Museum.  There are
doors to the east and north, and a blind stairway to the south.  A heavy iron
door to the west is closed and locked." CR>)>
		<COND (,GUARDS-PRESENT
		       <TELL
"Through the door you can hear voices which, from their
sound, belong to military or police personnel." CR>)>
		<RTRUE>)
	       (<AND <==? .RARG ,M-END>
		     <NOT ,FLATHEAD-HEARD>
		     ,GUARDS-PRESENT
		     <PROB 6>>
		<HEAR-FLATHEAD>)
	       (<AND <==? .RARG ,M-ENTER> ,GUARDS-PRESENT>
		<ENABLE <QUEUE I-GUARDS-LEAVE <+ 3 <RANDOM 12>>>>)
	       (<AND <==? .RARG ,M-BEG>
		     <VERB? OPEN>
		     <EQUAL? ,PRSO ,WOODEN-DOOR ,JEWEL-DOOR>
		     ,GUARDS-PRESENT>
		<TELL
"You open the door ever so slightly and see dozens of armed officials.
You shut the door quickly and quietly, realizing that you would be killed
in an instant if you left the room." CR>)
	       (<AND <==? .RARG ,M-BEG> ,GUARDS-PRESENT <PROB 3>>
		<GUARD-CAUGHT>)>>

<ROUTINE I-GUARDS-LEAVE ()
	 <SETG GUARDS-PRESENT <>>
	 <TELL
"You hear, from outside the door, guards marching away, their voices fading. 
After a few moments, a booming crash signals the close of what must be a
tremendous door. Then there is silence." CR>>

<ROUTINE GUARD-CAUGHT ()
	 <REALLY-DEAD
"A particularly vicious-looking guard enters the room and eyes you.
He grinds his teeth in a most unpleasant way, pulls a waffle out of his
garment, and vaporizes you with a flick of his finger.">>

<OBJECT ROBOT
	(IN LOCAL-GLOBALS)
	(DESC "robot")
	(SYNONYM ROBOT DEVICE)
	(ACTION ROBOT-F)>

<ROUTINE ROBOT-F ()
	 <COND (<VERB? FOLLOW>
		<TELL "It moved very quickly and left the door closed." CR>)
	       (T <TELL "There is no robot here." CR>)>>

<ROUTINE JEWEL-ROOM-F (RARG)
	 <COND (<AND <==? .RARG ,M-END>
		     <IN? ,TIME-MACHINE ,HERE>
		     <PROB 4>>
		<TELL
"An odd robot-like device glides into the room, dusting the floor as it
moves.  Its head gyrates briefly as it scans the machine. \"Shame. Shame,\"
it says, rather tinnily. \"Someone has been tampering with the machines
again.\" Six beady mechanical eyes focus on you as the robot picks up the
gold machine. \"Hands off, adventurer!\" are its last words as it leaves the
room, closing the door behind it." CR>
		<FCLEAR ,JEWEL-DOOR ,OPENBIT>
		<FCLEAR ,WOODEN-DOOR ,OPENBIT>
		<MOVE ,TIME-MACHINE ,TECH-MUSEUM>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"You are in a high-ceilinged chamber">
		<COND (<NOT <FSET? ,CAGE ,INVISIBLE>>
		       <TELL " in the middle of which
sits a tall, round steel cage, which is securely locked.  In the
middle of the cage is a pedestal on which sit the Crown Jewels
of the Great Underground Empire: a sceptre, a jewelled knife, and a golden
ring.  A small bronze plaque, now tarnished, is on the cage." CR>)
		      (T
		       <TELL " in the middle of which
is a bare pedestal.  The room is unfinished with no
indication of its purpose.  A small plaque is fastened to a wall."  CR>)>)>>

;"You can take the jewels in YEAR-BUILT; otherwise, it is enclosed.
  If you take it, YEAR-CLOSED is updated to YEAR-CAGED (history changes)"

<ROUTINE CROWN-JEWELS-F ()
	 <COND (<VERB? TAKE>
		<COND (<HELD? ,PRSO> <RFALSE>)
		      (<OR <==? ,YEAR ,YEAR-BUILT>
			   <FSET? ,CAGE ,INVISIBLE>>
		       <FCLEAR ,PRSO ,NDESCBIT>
		       <RFALSE>)
		      (T
		       <TELL
"The jewels are inside a locked cage." CR>)>)
	       (<AND <VERB? PUT>
		     <==? ,PRSI ,PEDESTAL>
		     <IN? ,PRSO ,WINNER>>
		<TELL "The " D ,PRSO " is now resting on the pedestal." CR>
		<MOVE ,PRSO ,PEDESTAL>
		<FSET ,PRSO ,NDESCBIT>
		<RTRUE>)
	       (<AND <VERB? PUT> <NOT <HELD? ,PRSO>>>
		<TELL "You don't have the " D ,PRSO "." CR>)>>
		
<ROUTINE TECH-MUSEUM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (<FSET? ,CAGE ,INVISIBLE>
		       <DDESC
"This is an exhibit of Empire technology.  A wooden door to the
south is " ,WOODEN-DOOR ".">)
		      (T
		       <DDESC
"This is a large hall which hosted the technological exhibits of the
Great Underground Empire.  A door to the south is "
,WOODEN-DOOR ".">)>)>>
		      
<ROUTINE PLAQUE-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (,RING-STOLEN
		       <TELL
"The plaque explains that this room was to be the home of the Crown Jewels
of the Great Underground Empire. However, following the unexplained
disappearance of a priceless ring during the final stages of construction,
Lord Flathead decided to place the remaining jewels in a safer location. 
Interestingly enough, he distrusted museum security enough to place his prized
possesion, an incredibly gaudy crown, within a locked safe in a volcano
specifically hollowed out for that purpose." CR>
		       <RTRUE>)>
		<PUT 0 8 <BOR <GET 0 8> 2>>
		<TELL
"|
         Crown Jewels|
|
  Presented To The Royal Museum|
      By His Gracious Lord|
|
        DIMWIT FLATHEAD|
|
|
          Dedicated|
         * 777 GUE *|
|">
		<PUT 0 8 <BAND <GET 0 8> -3>>
		<COND (,CLUMSY-ROBBERY
		       <TELL
"Underneath the plaque, in small lettering, is a description of a clumsy
attempt to steal the jewels using a time travel device from the Technological
Museum which the curators were surprised to discover was not a non-working
model.  After the attempt, the machine was removed from the exhibit." CR>)
		      (,MYSTERY
		       <TELL
"Underneath the plaque, in small lettering, is a description of
a mysterious happening during the final stages of construction of
the Museum, in which some of the crown jewels were found displaced
from their proper positions.  Fortunately, nothing was missing.
The mystery was never solved and the museum was opened despite the objections
of Lord Flathead that security was too lax." CR>)>
		<RTRUE>)>>

<ROUTINE WOODEN-DOOR-F ()
	 <COND (<AND <VERB? LISTEN> ,GUARDS-PRESENT>
		<PERFORM ,V?LISTEN ,VOICES>
		<RTRUE>)
	       (<AND <VERB? KNOCK> ,GUARDS-PRESENT>
		<TELL
"You realize that calling attention to yourself would be fatal." CR>)>>

<ROUTINE JEWEL-DOOR-F ()
	 <COND (<AND <VERB? KNOCK> ,GUARDS-PRESENT>
	        <PERFORM ,V?KNOCK ,WOODEN-DOOR>
		<RTRUE>)
	       (<VERB? OPEN UNLOCK>
		<COND (<FSET? ,JEWEL-DOOR ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (<AND <==? ,YEAR ,YEAR-BUILT>
			    <==? ,HERE ,OLD-MUSEUM-ENTRANCE>>
		       <TELL
"The door is locked, probably by the guards on their way out." CR>)
		      (T
		       <TELL "The door is now open." CR>
		       <FSET ,JEWEL-DOOR ,OPENBIT>)>)>>
		

<ROUTINE CAGE-F ()
	 <COND (<VERB? OPEN> <TELL "The cage is locked." CR>)
	       (<VERB? CLOSE> <TELL "The cage is already closed." CR>)>>

<ROUTINE VOICES-F ()
	 <COND (<AND ,GUARDS-PRESENT <==? ,YEAR ,YEAR-BUILT>>
		<TELL
"The voices are muffled by the door which (fortunately for you) separates
you.  They seem to be in heated debate on the topic of
">
		<TELL <PICK-ONE ,BLATHER> "." CR>)
	       (T <TELL "Are you hearing things now?" CR>)>>

<GLOBAL BLATHER
	<LTABLE "wage scales for guards"
		"the excessive nature of the Royal Government"
		"the soon to be constructed Royal Puzzle"
		"the proper way to execute trespassers"
		"torture as the preferred punishment for thieves"
		"the banishment of the Wizard of Frobozz">>

<ROUTINE MUSEUM-PIECES ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<==? ,DESC-OBJECT ,SPINNER>
		       <RTRUE>)>
		<TELL
"A strange grey machine, shaped somewhat like a clothes dryer, is on one side
of the room.  On the other side of the hall is a powerful-looking black
machine, a tight tangle of wires, pipes, and motors.|
A plaque is mounted near the door.">
		<COND (<L? ,YEAR ,YEAR-CLOSED>
		       <TELL
" The grey machine, it turns out, is a Frobozz
Magic Pressurizer, used in the coal mines of the Empire.  The black machine is
a Frobozz Magic Room Spinner.  The golden machine is referred to as a
Temporizer.  All are non-working models donated by Frobozzco president John
D. Flathead." CR>)
		      (T <TELL
" The writing is faded, however, and cannot be
made out clearly. The two machines seem to be in bad shape, rusting in many
spots." CR>)>)
	       (<VERB? TAKE MOVE>
		<TELL "It's massive and cannot even be moved." CR>)
	       (<VERB? PUSH PUSH-TO>
		<TELL "It's too heavy to be pushed." CR>)
	       (<VERB? MUNG>
		<TELL "It seems quite indestructible." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,SPINNER ,PRESSURIZER>>
		<TELL "There's no good place to put anything there." CR>)>>

<ROUTINE TECH-PLAQUE-F ()
	 <COND (<VERB? TAKE>
		<TELL "It's bolted to the wall." CR>)
	       (<VERB? EXAMINE READ>
		<COND (<L? ,YEAR ,YEAR-CLOSED>
		       <TELL
"The plaque merely identifies the machines and names their donor.  They are
non-working models of existing state-of-the-art machinery." CR>)
		      (T <TELL "The words cannot be made out." CR>)>)>>

<ROUTINE PEDESTAL-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FIRST? ,PEDESTAL>
		       <TELL
"The Royal Jewels are on the pedestal." CR>)>)
	       (<AND <VERB? PUT PUT-ON TAKE> <NOT <FSET? ,CAGE ,INVISIBLE>>>
		<TELL "You can't reach it through the cage." CR>)>>
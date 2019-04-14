"ACTIONS3 for
		     ZORK III: The Dungeon Master
		 The Great Underground Empire (Part 3)
	(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.
"

<GLOBAL YUKS
	<LTABLE
	 "A valiant attempt."
	 "You can't be serious."
	 "An interesting idea..."
	 "What a concept!">>

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<EQUAL? .W ,SWORD>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

<ROUTINE SWORD-FCN ()
	 <COND (,SWORD-IN-STONE?
		<COND (<VERB? TAKE MOVE>
		       <COND (<PROB 10>
			      <TELL
"Who do you think you are? Arthur?" CR>)
			     (T <TELL
"The sword is deeply imbedded in the rock. You can't budge it." CR>)>)>)
	       (<AND <VERB? TAKE> <==? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<>)>>

<GLOBAL LAMP-TABLE
	<TABLE 300
	       "The lamp appears a bit dimmer."
	       100
	       "The lamp is definitely dimmer now."
	       50
	       "The lamp is nearly out."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<VERB? THROW>
		<TELL "The lamp smashes. The light is now out." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE ,LAMP>
		<SETG CURRENT-LAMP ,BROKEN-LAMP>
		<MOVE ,BROKEN-LAMP ,HERE>)
	       (<VERB? LAMP-ON>
		<COND (<NOT <FSET? ,LAMP ,LIGHTBIT>>
		       <TELL "A burned-out lamp won't light." CR>)
		      (ELSE
		       <ENABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? LAMP-OFF>
		<COND (<NOT <FSET? ,LAMP ,LIGHTBIT>>
		       <TELL "The lamp has already burned out." CR>)
		      (ELSE
		       <DISABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? EXAMINE>
		<COND (<NOT <FSET? ,LAMP ,LIGHTBIT>>
		       <TELL "The lamp has burned out.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "The lamp is on.">)
		      (ELSE
		       <TELL "The lamp is turned off.">)>
		<CRLF>)>>

<ROUTINE LIGHT-INT (OBJ TBL TICK)
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,ONBIT>
		<FSET .OBJ ,RMUNGBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"You'd better have more light than from the " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>>

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
		(TICK) FIX)
	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,LIGHTBIT>
		<FCLEAR .OBJ ,ONBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"I hope you have more light than from the " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>
	 <COND (<NOT <0? .TICK>>
		<SETG .TBLNAM <REST .TBL 4>>)>>

<ROUTINE CHASM-FCN ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <==? ,PRSO ,ME>>>
		<TELL
"You look before leaping and realize you would never survive." CR>)
	       (<VERB? CROSS>
		<TELL "You'll have to find a bridge." CR>)
	       (<AND <VERB? PUT> <==? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"The " D ,PRSO " drops out of sight into the chasm." CR>
		<REMOVE ,PRSO>)>>

<ROUTINE TUNNEL-OBJECT ()
	 <COND (<AND <VERB? THROUGH> <GETP ,HERE ,P?IN>>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (T <PATH-OBJECT>)>>

\

"SUBTITLE CHINESE PUZZLE SECTION (COURTESY OF WILL WENG)"

<GLOBAL CPHERE 1>

<GLOBAL CPOBJS <ITABLE NONE <* 8 2 36>>>

<GLOBAL CPTABLE
      <TABLE   1
	       0
	       -1
	       0
	       0
	       -1
	       0
	       -1
	       0
	       1
	       0
	       -2
	       0
	       0
	       0
	       0
	       0
	       1
	       0
	       -3
	       0
	       0
	       -1
	       -1
	       0
	       0
	       0
	       -1
	       0
	       0
	       0
	       1
	       1
	       0
	       0
	       0
	       1>>

;" 0 is no wall
    1 is fixed wall
   -1 is movable wall (-2 is good ladder, -3 bad ladder)"

<GLOBAL CPWALLS <LTABLE CPSWL 6 CPNWL -6 CPEWL 1 CPWWL -1>>

<GLOBAL CPEXITS <LTABLE
       P?NORTH
       -6
       P?SOUTH
       6
       P?EAST
       1
       P?WEST
       -1
       P?NE
       -5
       P?NW
       -7
       P?SE
       7
       P?SW
       5>>

<GLOBAL CP-MOVED <>>

<ROUTINE CPEXIT ("AUX" FX NFX)
	#DECL ((FX NFX) FIX)
	<SETG CP-MOVED <>>
	<COND (<==? ,PRSO ,P?UP>
	       <COND (<==? ,CPHERE 1>
		      <COND (<==? <GET ,CPTABLE 2> -2>
			     <TELL
"With the help of the ladder, you exit the puzzle." CR>
			     ,CP-ANTE)
			    (T
			     <TELL
			      "The exit is too far above your head." CR>
			     <RFALSE>)>)
		     (T
		      <TELL "There is no way up." CR>
		      <RFALSE>)>)
	      (<AND <==? ,CPHERE 33>
		    <==? ,PRSO ,P?WEST>
		    ,CP-FLAG>
	       <FCLEAR ,CP ,TOUCHBIT>
	       ,CP-OUT)
	      (<==? ,PRSO ,P?DOWN>
	       <TELL "There's no way down here." CR>
	       <RFALSE>)
	      (<AND <==? ,CPHERE 33>
		    <==? ,PRSO ,P?WEST>>
	       <TELL "The metal door bars the way." CR>
	       <RFALSE>)
	      (T
	       <SET FX <LKP ,PRSO ,CPEXITS>>
	       <COND (<OR <G? <SET NFX <+ .FX ,CPHERE>> 36>
			  <L? .NFX 0>
			  <ILLCP ,CPHERE .FX>>
		      <TELL "There is a wall there." CR>
		      <RFALSE>)
		     (<EQUAL? <ABS .FX> 1 6>
		      <CPMOVE .FX>)
		     (<AND <G? .FX 0> ; "SW AND SE"
			   <EQUAL? 0
				   <GET ,CPTABLE <+ ,CPHERE 6>>
				   <GET ,CPTABLE <+ ,CPHERE <- .FX 6>>>>>
		      <CPMOVE .FX>)
		     (<AND <L? .FX 0>
			   <EQUAL? 0
				   <GET ,CPTABLE <- ,CPHERE 6>>
				   <GET ,CPTABLE <+ <+ ,CPHERE 6> .FX>>>>
		      <CPMOVE .FX>)
		     (T
		      <TELL "There is a wall there." CR>)>
	       <RFALSE>)>>

<GLOBAL MINUS-SEVEN -7>
<GLOBAL MINUS-FIVE -5>
<GLOBAL MINUS-FOUR -4>
<GLOBAL MINUS-ONE -1>

<ROUTINE ILLCP (ONE TWO)
	 <COND (<AND <==? <MOD .ONE 6> 0>
		     <EQUAL? .TWO ,MINUS-FIVE 1 7>> <RTRUE>)
	       (<AND <==? <MOD .ONE 6> 1>
		     <EQUAL? .TWO ,MINUS-SEVEN ,MINUS-ONE 5>> <RTRUE>)
	       (<AND <L? .ONE 7> <L? .TWO ,MINUS-FOUR>> <RTRUE>)
	       (<AND <G? .ONE 30> <G? .TWO 4>> <RTRUE>)>>

<ROUTINE CPMOVE (FX)
	 <COND (<0? <GET ,CPTABLE <SET FX <+ ,CPHERE .FX>>>>
	        <CPGOTO .FX>)
	       (T
	        <TELL "There is a wall there." CR>)>>

<ROUTINE CPENTER ()
	<COND (<OR <NOT <==? ,YEAR ,YEAR-PRESENT>> ,CPBLOCK-FLAG>
	       <TELL "The hole is blocked by sandstone." CR>
	       <RFALSE>)
	      (T
	       <SETG CPHERE 1>
	       ,CP)>>

<ROUTINE CPANT-ROOM (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is a small square room, in the middle of which is a round hole">
		<COND (<OR ,CPBLOCK-FLAG <NOT <==? ,YEAR ,YEAR-PRESENT>>>
		       <TELL
			" which is blocked by smooth sandstone." CR>)
		      (T
		       <TELL
" through which you can discern the floor some ten feet below.
The area under the hole is dark, but it appears to be completely enclosed
in rock. In any event, it doesn't seem likely that you could climb back up.
Exits are west and, up a few steps, north." CR>)>)>>

<GLOBAL CPPUSH-FLAG <>>  

<GLOBAL CPSOLVE-FLAG <>>

<ROUTINE CPLADDER-OBJECT ()
	 <COND (<==? <GET ,CPTABLE <- ,CPHERE 1>> -3>
		<CPLADDER-JUNK <>>)
	       (<==? <GET ,CPTABLE <+ ,CPHERE 1>> -2>
		<CPLADDER-JUNK T>)
	       (T <TELL "I can't see any ladder here." CR>)>>

<ROUTINE CPLADDER-JUNK (FLG)
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (<AND .FLG <==? ,CPHERE 1>>
		       <SETG CPSOLVE-FLAG T>
		       <GOTO ,CP-ANTE>)
		      (T
		       <TELL
"You hit your head on the ceiling and fall off the ladder." CR>)>)
	       (T <TELL "Come, come!" CR>)>> 

<ROUTINE CPWALL-OBJECT ("AUX" WL NWL NXT NNXT CNT TOP (SNAP <>))
	#DECL ((NXT WL NNXT NWL) FIX (UVEC) <UVECTOR [REST FIX]>)
	<COND (<VERB? MOVE> <TELL "You can't grab the wall to pull it." CR>)
	      (<VERB? PUSH>
	       <SET NXT <CPNEXT ,CPHERE ,PRSO>>
	       <COND (<0? .NXT>
		      <TELL "The wall doesn't budge." CR>
		      <RTRUE>)>
	       <SET WL <GET ,CPTABLE .NXT>>
	       <COND (<0? .WL>
		      <TELL "There is only a passage in that direction." CR>)
		     (<1? .WL>
		      <TELL "The wall doesn't budge." CR>)
		     (<0? <SET NNXT <CPNEXT .NXT ,PRSO>>>
		      <TELL "The wall barely gives." CR>)
		     (<NOT <0? <SET NWL <GET ,CPTABLE .NNXT>>>>
		      <TELL "The wall barely gives." CR>)
		     (T
		      <TELL
"The wall slides forward and you follow it">
	   	      <COND (,CPPUSH-FLAG <TELL " to this position:" CR>)
			    (T
			     <SETG SCORE <+ ,SCORE 1>>
			     <TELL
"....|
The architecture of this region is getting complex, so that further
descriptions will be diagrams of the immediate vicinity in a 3x3
grid. The walls here are rock, but of two different types - sandstone
and marble. The following notations will be used:|
">
			     <FIXED-FONT-ON>
			     <TELL
"|
  ..  = your position (middle of grid)|
  MM  = marble wall|
  SS  = sandstone wall|
  ??  = unknown (blocked by walls)|
|
">
			     <FIXED-FONT-OFF>)>
		      <SETG CPPUSH-FLAG T>
		      <PUT ,CPTABLE .NXT 0>
		      <PUT ,CPTABLE .NNXT .WL>
		      <COND (<NOT <EQUAL? .NNXT 0>>
			     <SET TOP <* 8 <- .NNXT 1>>>
			     <SET CNT <GET ,CPOBJS .TOP>>
			     <REPEAT ()
				     <COND (<0? .CNT> <RETURN>)
					   (T
					    <SET TOP <+ .TOP 1>>
					    <MOVE <GET ,CPOBJS .TOP> ,CP-OUT>
					    <COND (<NOT .SNAP>
						   <SET SNAP T>
						   <TELL
"You hear a soft \"snap\" from behind the wall you were pushing." CR>)>
					    <SET CNT <- .CNT 1>>)>>)>
		      <COND (<==? .NNXT 1>
			     <SETG CPBLOCK-FLAG T>)>
		      <CPGOTO .NXT>)>)>>

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

"Flag for blocking of main entrance"

<GLOBAL CPBLOCK-FLAG <>>

<CONSTANT GCARDLOC 168>	;"8*(22-1)"

<ROUTINE CPGOTO (FX "AUX" F X CNT TOP)
	#DECL ((FX CNT TOP) FIX (F X) <OR FALSE OBJECT>)
	<SETG CP-MOVED T>
	<FCLEAR ,HERE ,TOUCHBIT>
	<SET TOP <* 8 <- ,CPHERE 1>>>
	<SET CNT <+ .TOP 1>>
	<SET F <FIRST? ,CP>>
	<REPEAT ()
		<SET X <NEXT? .F>>
		<COND (<NOT .F> <RETURN>)
		      (<==? .F ,ADVENTURER> T)
		      (T
		       <PUT ,CPOBJS .CNT .F>
		       <REMOVE .F>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<NOT .X> <RETURN>)
		      (T <SET F .X>)>>
	<PUT ,CPOBJS .TOP <- <- .CNT .TOP> 1>>
	<SETG CPHERE .FX>
	<SET TOP <* 8 <- ,CPHERE 1>>>
	<SET CNT <GET ,CPOBJS .TOP>>
	<REPEAT ()
		<COND (<0? .CNT> <RETURN>)
		      (T
		       <SET TOP <+ .TOP 1>>
		       <MOVE <GET ,CPOBJS .TOP> ,CP>
		       <SET CNT <- .CNT 1>>)>>
	<PERFORM ,V?LOOK>
	<RTRUE>> 

<ROUTINE CPNEXT (RM OBJ "AUX" FX)
	#DECL ((RM) FIX (OBJ) OBJECT)
	<SET FX <LKP .OBJ ,CPWALLS>>
	<COND (<ILLCP .RM .FX> 0)
	      (T <+ .RM .FX>)>>

<ROUTINE CPDOOR-F ()
	 <COND (<AND <==? ,HERE ,CP> <NOT <==? ,CPHERE 33>>>
		<TELL "I can't see any steel door here." CR>)
	       (<VERB? OPEN>
		<COND (,CP-FLAG <TELL "The steel door has already opened." CR>)
		      (T <TELL "You can't force it open." CR>)>)
	       (<VERB? CLOSE>
		<COND (,CP-FLAG <TELL
"There doesn't seem to be any way to close it." CR>)
		      (T <TELL "Do you think it isn't already?" CR>)>)
	       (<VERB? MUNG>
		<TELL
"The door is, to a first approximation, indestructible." CR>)
	       (<VERB? KNOCK>
		<TELL
"Besides a great amount of reverberation, nothing happens." CR>)>>

<ROUTINE CP-ROOM (RARG)
	<COND (<==? .RARG ,M-ENTER>
	       <SETG CPHERE
		     <COND (<==? ,PRSO ,P?DOWN> 1)
		     	   (T 33)>>)
	      (<==? .RARG ,M-LOOK>
	       <COND (,CPPUSH-FLAG <CPWHERE>)
		     (T
		      <TELL
"You are in a small square room bounded to the north and west with
marble walls and to the east and south with sandstone walls." CR>)>)>>   

<ROUTINE CPNS (NUM)
	 #DECL ((NUM) FIX)
	 <COND (<OR <G? .NUM 36> <L? .NUM 1>> 1)
	       (T <GET ,CPTABLE .NUM>)>>

<ROUTINE CPEW (NUM FOO)
	 #DECL ((NUM FOO) FIX)
	 <COND (<==? <MOD .NUM 6> .FOO> 1)
	       (T <GET ,CPTABLE .NUM>)>>

<ROUTINE CPWHERE ("AUX"  (N <CPNS <+ ,CPHERE -6>>)
			 (S <CPNS <+ ,CPHERE 6>>)
			 (E <CPEW <+ ,CPHERE 1> 1>)
			 (W <CPEW <+ ,CPHERE -1> 0>))
	#DECL ((N S E W) FIX)
	<FIXED-FONT-ON>
	<TELL "      +">			      ;"Top Row"
	<CP-CORNER ,MINUS-SEVEN .N .W>
	<TELL " ">
	<CP-ORTHO .N>
	<TELL " ">
	<CP-CORNER ,MINUS-FIVE .N .E>
	<TELL "+" CR>
	<TELL "West  +">			   ;"Middle Row"
	<CP-ORTHO .W>
	<TELL " .. ">
	<CP-ORTHO .E>
	<TELL "+  East" CR>
	<TELL "      +">			   ;"Bottom Row"
	<CP-CORNER 5 .S .W>
	<TELL " ">
	<CP-ORTHO .S>
	<TELL " ">
	<CP-CORNER 7 .S .E>
	<TELL "+" CR>
	<FIXED-FONT-OFF>
	<COND (<==? ,CPHERE 1>
	       <TELL
"In the ceiling above you is a large circular opening." CR>)
	      (<==? ,CPHERE 22>
	       <TELL
"The center of the floor here is noticeably depressed." CR>)
	      (<==? ,CPHERE 33>
	       <TELL
"In the center of the west wall is a steel door which is ">
	       <COND (,CP-FLAG <TELL "open">)
		     (T <TELL "closed">)>
	       <TELL
".
On one side of the door is a narrow slot." CR>)>
	<COND (<==? .E -2>
	       <TELL
"There is a ladder here, firmly attached to the east wall." CR>)>
	<COND (<==? .W -3>
	       <TELL
"There is a ladder here, firmly attached to the west wall." CR>)>>

"Show where the eight nearest neighbors are located" 

<ROUTINE CP-ORTHO (CONTENTS)
	#DECL ((CONTENTS) FIX)
	<COND (<0? .CONTENTS> <TELL "  ">)
	      (<1? .CONTENTS> <TELL "MM">)
	      (T <TELL "SS">)>>

;"Show an orthogonal neighbor"

<ROUTINE CP-CORNER (DIR COL ROW "AUX" LOCN)
	#DECL ((DIR COL ROW) FIX)
	<SET LOCN <+ ,CPHERE .DIR>>
	<COND (<AND <NOT <==? .COL 0>> <NOT <==? .ROW 0>>> <TELL "??">)
	      (<ILLCP ,CPHERE .DIR> <TELL "MM">)
	      (<0? <SET COL
			<COND (<OR <L? .LOCN 1> <G? .LOCN 36>> 1)
			      (T <GET ,CPTABLE .LOCN>)>>>
	       <TELL "  ">)
	      (<1? .COL> <TELL "MM">)
	      (T <TELL "SS">)>>

<ROUTINE CP-SLOT-FCN ()
	<COND (<VERB? PUT>
	       <COND (<G? <GETP ,PRSO ,P?SIZE> 10>
		      <TELL "It doesn't fit." CR>
		      <RTRUE>)>
	       <REMOVE ,PRSO>
	       <COND (<==? ,PRSO ,LORE-BOOK>
	       	      <SETG CP-FLAG T>
	              <TELL
"The book drops into the slot and vanishes. The metal door slides
open, revealing a passageway to the west, and a sign flashes:|
    \"Royal Puzzle Exit Fee Paid|
          Item Confiscated\"" CR>)
		     (<FSET? ,PRSO ,ACTORBIT>
		      <TELL <RANDOM-ELEMENT ,YUKS> CR>)
		     (T
		      <TELL
"The item vanishes into the slot. A moment later, a previously
unseen sign flashes \"Garbage In, Garbage Out\" and spews out
the " D ,PRSO " (now atomized)." CR>)>)>>
	     
<ROUTINE CPOUT-ROOM (RARG)
	<COND (<==? .RARG ,M-LOOK>
	       <TELL
"You are in a narrow room, lit from above. A flight of steps leads up
to the north, and a ">
	       <COND (,CP-FLAG <TELL "passage">)
		     (T <TELL "metal door">)>
	       <TELL " leads to the east." CR>)>>

"Old end-game stuff"

;"SUBTITLE It's All Done with Mirrors"

<GLOBAL MLOC <>>

<GLOBAL MR1-FLAG T>

<GLOBAL MR2-FLAG T>

<GLOBAL MIRROR-OPEN-FLAG <>>

<GLOBAL WOOD-OPEN-FLAG <>>

<GLOBAL MRSWPUSH-FLAG <>>

<GLOBAL R-SOUTHS <LTABLE FRONT-DOOR MRD MRG MRC MRB MRA MREYE>>
<GLOBAL R-NORTHS <LTABLE MREYE MRA MRB MRC MRG MRD>>

<ROUTINE MRGO ("AUX" TORM)
	 <COND (<EQUAL? ,PRSO ,P?NORTH ,P?NW ,P?NE>
		<SET TORM <LKP ,HERE ,R-NORTHS>>)
	       (T <SET TORM <LKP ,HERE ,R-SOUTHS>>)>
	 <COND (<EQUAL? ,PRSO ,P?NORTH ,P?SOUTH>
	        <COND (<==? ,MLOC .TORM>
		       <COND (<0? <MOD ,MDIR 180>>
			      <TELL
 "There is a wooden wall blocking your way." CR>
			      <RFALSE>)
			     (<MIRIN <>> ,IN-MIRROR)
			     (T <MIRBLOCK> <RFALSE>)>)
		     (T .TORM)>)
	       (<==? ,MLOC .TORM>
	        <COND (<0? <MOD ,MDIR 180>> <GO-E-W .TORM>)
		      (T <MIRBLOCK> <RFALSE>)>)
	       (T .TORM)>>

<ROUTINE MIRBLOCK ("AUX" MD)
	 <SET MD ,MDIR>
	 <COND (<==? ,PRSO ,P?SOUTH>
	        <SET MD <MOD <+ ,MDIR 180> 360>>)>
	 <COND (<OR <AND <==? .MD 270> <NOT ,MR1-FLAG>>
		    <AND <==? .MD 90> <NOT ,MR2-FLAG>>>
	        <TELL "There is a large broken mirror blocking your way." CR>)
	       (T
	        <TELL "There is a large mirror blocking your way." CR>)>>

<ROUTINE GO-E-W (RM)
	<COND (<EQUAL? ,PRSO ,P?NE ,P?SE>
	       <LKP .RM ,R-EASTS>)
	      (T <LKP .RM ,R-WESTS>)>>

<GLOBAL R-EASTS <LTABLE MRA MRAE MRB MRBE MRC MRCE MRG MRGE MRD MRDE>>
<GLOBAL R-WESTS <LTABLE MRA MRAW MRB MRBW MRC MRCW MRG MRGW MRD MRDW>>

<DEFMAC N-S () '<0? <MOD ,MDIR 180>>>

<DEFMAC E-W ('FX) <FORM OR <FORM ==? .FX 90> <FORM ==? .FX 270>>>

<ROUTINE EWTELL (RM "AUX" (EAST? <>) (M1? <>) MWIN)
	 <COND (<OR <EQUAL? .RM ,MRAE ,MRBE ,MRCE>
		    <EQUAL? .RM ,MRGE ,MRCE>>
		<SET EAST? T>)>
	 <COND (<==? <+ ,MDIR <COND (.EAST? 0) (T 180)>> 180>
		<SET M1? T>)>
	 <COND (.M1? <SET MWIN ,MR1-FLAG>) (T <SET MWIN ,MR2-FLAG>)>
	 <TELL "You are in a narrow room, whose "
	       <COND (.EAST? "west") (T "east")>
	       " wall is a large "
	       <COND (.MWIN "mirror.")
		     (T "wooden panel
which once contained a mirror.")>
	       CR>
	 <COND (<AND .M1? ,MIRROR-OPEN-FLAG>
		<TELL <COND (.MWIN
"The mirror is mounted on a panel which has been opened outward.")
			    (T "The panel has been opened outward.")>
		      CR>)>
	 <TELL "The opposite wall is solid rock." CR>>

<GLOBAL GUARDIANS-SEEN <>>

<ROUTINE MRDEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Somewhat to the south" ,GUARDSTR CR>)>>

<ROUTINE MRCEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Somewhat to the north" ,GUARDSTR CR>)>>

<ROUTINE MRBEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <TELL "To the north and south are large hallways." CR>)>>

<ROUTINE MRAEW ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <EWTELL ,HERE>
	        <TELL "To the north is a large hallway." CR>)>>

<GLOBAL GUARDSTR
", identical stone statues face each other from
pedestals on opposite sides of the corridor. The statues represent
Guardians of Zork, a military order of ancient lineage. They are
portrayed as heavily armored warriors clasping formidable bludgeons.">

<ROUTINE LOOK-TO (RMN RMS "AUX" (NORTH? <>) (NTELL <>) (STELL <>)
		  		MIR? (M1? <>) DIR)
	 <COND (<NOT <EQUAL? ,HERE ,MREYE ,FRONT-DOOR>>
		<TELL
"This is a part of the long hallway. The east and west walls are
dressed stone. In the center of the hall is a shallow stone channel.
In the center of the room the channel widens into a large hole around
which is engraved a compass rose." CR>)>
	 <COND (<==? ,HERE ,MRG>
		<SETG GUARDIANS-SEEN T>
		<TELL
"On either side of you are identical stone statues holding bludgeons. They
appear ready to strike, though, for the moment, they remain impassive." CR>)
	       (<==? ,HERE ,MRC>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Somewhat to the north" ,GUARDSTR CR>
		<SET NTELL T>)
	       (<==? ,HERE ,FRONT-DOOR>
		<TELL
"You are in a north-south hallway which ends, to the north, at a large wooden
door." CR>
		<SET NTELL T>)
	       (<==? ,HERE ,MRD>
	        <SETG GUARDIANS-SEEN T>
		<TELL "Somewhat to the south" ,GUARDSTR CR>
		<SET STELL T>)
	       (<==? ,HERE ,MRA>
		<TELL "The hallway continues to the south." CR>
		<SET STELL T>)>
	 <COND (<EQUAL? ,MLOC .RMN .RMS>
	        <COND (<==? ,MLOC .RMN>
		       <SET NORTH? T>
		       <SET NTELL T>
		       <SET DIR "nor">)
		      (T
		       <SET STELL T>
		       <SET DIR "sou">)>
	        <SET MIR?
		    <COND (<AND .NORTH? <G? ,MDIR 180> <L? ,MDIR 359>>
			   <SET M1? T>
			   ,MR1-FLAG)
			  (<AND <NOT .NORTH?> <G? ,MDIR 0> <L? ,MDIR 179>>
			   <SET M1? T>
			   ,MR1-FLAG)
			  (T ,MR2-FLAG)>>
	        <COND (<0? <MOD ,MDIR 180>>
		       <TELL "The "
			     .DIR
"th side of the room is divided by a wooden wall into small
hallways to the ">
		       <TELL .DIR "theast and ">
		       <TELL .DIR "thwest." CR>)
		      (T
		       <TELL <COND (.MIR? "A large mirror fills the ")
				   (T "A large panel fills the ")>
			     .DIR
			     "th side of the hallway." CR>
		       <COND (<AND .M1? ,MIRROR-OPEN-FLAG>
			      <TELL <COND (.MIR?
"The mirror is mounted on a panel which has been opened outward.")
					  (T
"The panel has been opened outward.")> CR>)>)>)>
	 <COND (<AND <NOT .NTELL> <NOT .STELL>>
		<TELL "The corridor continues north and south." CR>)
	       (<NOT .NTELL>
		<TELL "The corridor continues north." CR>)
	       (<NOT .STELL>
		<TELL "The corridor continues south." CR>)>
	 <RTRUE>>

<ROUTINE MRDF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,FRONT-DOOR ,MRG>)>>

<ROUTINE MRCF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,MRG ,MRB>)>>

<ROUTINE MRBF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,MRC ,MRA>)>>

<ROUTINE MRAF ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <LOOK-TO ,MRB <>>)>>

"Infestation function for Sword-glow demon, tailored for end game"

<ROUTINE EG-INFESTED? (R)
	 <OR <AND <==? ,MLOC ,MRG> <==? .R ,IN-MIRROR>>
	     <EQUAL? .R ,MRGE ,MRG ,MRGW>>>

<ROUTINE GUARDIANS ("OPTIONAL" (RARG <>))
   	 <COND (<==? .RARG ,M-LOOK>
		<COND (<==? ,HERE ,MRG>
		       <LOOK-TO ,MRD ,MRC>)
		      (T
		       <EWTELL ,HERE>
		       <TELL
"To the east and west are the Guardians of Zork, in perfect symmetry.
From here, it's hard to tell which of the two is a reflection!" CR>)>)
	       (<AND <==? .RARG ,M-ENTER> <NOT ,INVIS>>
	        <JIGS-UP
"The Guardians awake, and in perfect unison, pulverize you with
their bludgeons. Satisfied, they resume their posts.">)
	       (<NOT <==? .RARG ,M-END>> <RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<==? ,HERE ,IN-MIRROR>
		       <TELL "You can't see them from here." CR>)
		      (T <TELL
"The Guardians are quite impressive. I wouldn't get in their way if
I were you!" CR>)>)
	       (<AND <VERB? THROW> <==? ,PRSI ,GUARDIAN>>
		<COND (<EQUAL? ,PRSO ,ME>
		       <TELL "You step">)
		      (T
		       <TELL "The " D ,PRSO " falls">
		       <REMOVE ,PRSO>)>
		<TELL
" in front of the Guardians, who ">
		<COND (<EQUAL? ,PRSO ,ME>
		       <TELL "decimate you">)
		      (T <TELL "destroy it">)>
		<TELL " in perfect
unison. Satisfied, they resume their posts." CR>)
	       (<VERB? ATTACK>
	        <TELL
"You aren't close enough, and even if you were, the fight
would be a bit one-sided." CR>)
	       (<VERB? HELLO>
	        <TELL "The statues are impassive." CR>)>>

<ROUTINE MIRROR-DIR? (DIR RM "AUX" TBL)
         <SET TBL <COND (<==? .DIR ,P?NORTH> ,R-NORTHS) (T ,R-SOUTHS)>>
	 <COND (<AND <GETPT .RM .DIR>
		     <==? ,MLOC <LKP .RM .TBL>>>
		<COND (<AND <==? .DIR ,P?NORTH>
			    <G? ,MDIR 180>
			    <L? ,MDIR 360>>
		       1)
		      (<AND <==? .DIR ,P?SOUTH>
			    <G? ,MDIR 0>
			    <L? ,MDIR 180>>
		       1)
		      (T 2)>)>>

<ROUTINE WOODEN-WALL-F ()
	 <COND (<AND <0? <MOD ,MDIR 180>>
		     <OR <MIRROR-DIR? ,P?NORTH ,HERE>
			 <MIRROR-DIR? ,P?SOUTH ,HERE>>>
		<COND (<VERB? PUSH>
		       <TELL "The structure won't budge." CR>)>)
	       (T <TELL "I can't see any wooden wall here." CR>)>>

<ROUTINE MIRROR-HERE? (RM "AUX" TMP)
	 <COND (<OR <EQUAL? ,HERE ,MRAE ,MRAW ,MRBE>
		    <EQUAL? ,HERE ,MRBW ,MRCE ,MRCW>
		    <EQUAL? ,HERE ,MRGE ,MRGW ,MRDE>
		    <EQUAL? ,HERE ,MRDW>>
		<COND (<==? 180
			    <+ ,MDIR <COND (<OR <EQUAL? .RM ,MRAE ,MRBE ,MRCE>
						<EQUAL? .RM ,MRGE ,MRDE>> 0)
					   (T 180)>>>
		       1)
		      (T 2)>)
	       (<0? <MOD ,MDIR 180>> <RFALSE>)
	       (<SET TMP <MIRROR-DIR? ,P?NORTH .RM>> .TMP)
	       (<SET TMP <MIRROR-DIR? ,P?SOUTH .RM>> .TMP)
	       (T <RFALSE>)>>

<ROUTINE MIRROR-FUNCTION ("AUX" MIRROR)
 	 <COND (<NOT <SET MIRROR <MIRROR-HERE? ,HERE>>>
	        <TELL "I can't see any mirror here." CR>)
	       (<VERB? OPEN MOVE>
	        <TELL
"I don't see a way to open the mirror here." CR>)
	       (<VERB? LOOK-INSIDE>
	        <COND (<OR <AND <==? .MIRROR 1> ,MR1-FLAG> ,MR2-FLAG>
		       <COND (,INVIS
			      <TELL
"Amazingly, you have no reflection!" CR>)
			     (T
			      <TELL
"A disheveled adventurer stares back at you." CR>)>)
		      (T
		       <TELL
"You have destroyed the mirror, or have you forgotten?" CR>)>)
	       (<VERB? MUNG>
	        <COND (<1? .MIRROR>
		       <COND (,MR1-FLAG
			      <SETG MR1-FLAG <>>
			      <TELL
"The mirror breaks, revealing a wooden panel behind it. The glistening
fragments of mirror quietly sparkle into nonexistance." CR>)
			     (T <TELL "The mirror has already been broken."
				      CR>)>)
		      (,MR2-FLAG
		       <SETG MR2-FLAG <>>
		       <TELL
"The mirror breaks, revealing a wooden panel behind it. The glistening
fragments of mirror quietly sparkle into nonexistance." CR>)
		      (T <TELL "The mirror has already been broken." CR>)>)
	       (<OR <AND <==? .MIRROR 1> <NOT ,MR1-FLAG>> <NOT ,MR2-FLAG>>
	        <TELL
"There's no mirror left." CR>)
	       (<VERB? PUSH>
	        <TELL <COND (<==? .MIRROR 1>
"The mirror is mounted on a wooden panel which moves slightly inward
as you push, and back out when you let go. It feels fragile.")
			    (T
"The mirror is unyielding, but seems fragile.")> CR>)>>

<ROUTINE PANEL-FUNCTION ("AUX" MIRROR)
 	 <COND (<NOT <SET MIRROR <MIRROR-HERE? ,HERE>>>
	        <TELL "I can't see any panel here." CR>)
	       (<VERB? OPEN MOVE>
	        <TELL "I don't see a way to open the panel here." CR>)
	       (<VERB? MUNG>
	        <COND (<==? .MIRROR 1>
		       <COND (,MR1-FLAG
			      <TELL ,MIRROR-FIRST CR>)
			     (T <TELL
"The panel is not that easily destroyed." CR>)>)
		      (,MR2-FLAG
		       <TELL ,MIRROR-FIRST CR>)
		      (T <TELL "The panel is not that easily destroyed." CR>)>)
	       (<VERB? PUSH>
	        <TELL <COND (<==? .MIRROR 1>
"The wooden panel moves slightly inward as you push, and back out
when you let go.")
			    (T
"The panel is unyielding.")> CR>)>>

<GLOBAL MIRROR-FIRST
"To break the panel you would have to break the mirror first.">

<GLOBAL DIRVEC <LTABLE P?NORTH 0 P?NE 45 P?EAST 90 P?SE 135
		       P?SOUTH 180 P?SW 225 P?WEST 270 P?NW 315>>

<ROUTINE MIROUT ("AUX" DIR RM)
	 <COND (<==? ,PRSO ,P?OUT> <SET DIR 1>)
	       (T <SET DIR <LKP ,PRSO ,DIRVEC>>)>
	 <COND (,MIRROR-OPEN-FLAG
	        <COND (<OR <==? .DIR 1>
			   <==? <MOD <+ ,MDIR 270> 360> .DIR>>
		       <COND (<0? <MOD ,MDIR 180>>
			      <MIREW>)
			     (T <MIRNS <L? ,MDIR 180> T>)>)
		      (T
		       <TELL "There's a wall there.">
		       <RFALSE>)>)
	       (,WOOD-OPEN-FLAG
	        <COND (<OR <==? .DIR 1>
			   <==? <MOD <+ ,MDIR 180> 360> .DIR>>
		       <COND (<0? ,MDIR> <SET RM <>>) (T <SET RM T>)>
		       <COND (<SET RM <MIRNS .RM T>>
		              <TELL "As you leave, the door swings shut." CR>
			      <SETG WOOD-OPEN-FLAG <>>
			      .RM)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFALSE>)>)
		      (T
		       <TELL "You would hit one of the panels." CR>
		       <RFALSE>)>)
	       (T
		<TELL "You are inside a closed box!" CR>
		<RFALSE>)>>

"MIRNS -- returns room in a given direction from the mirror (north or
south as indicated by first argument).  If second arg is T, then we
are exiting, not moving the mirror, so don't worry about ends."

<ROUTINE MIRNS (NORTH? "OPTIONAL" (EXIT? <>) "AUX" S T)
	 <COND (<NOT .EXIT?>
		<COND (<AND .NORTH? <==? ,MLOC ,MRD>>
	               <RFALSE>)
		      (<AND <NOT .NORTH?> <==? ,MLOC ,MRA>>
		       <RFALSE>)>)>
	 <COND (<SET T <GETPT ,MLOC <COND (.NORTH? ,P?NORTH)
					  (T ,P?SOUTH)>>>
		<COND (<==? <SET S <PTSIZE .T>> ,UEXIT>
		       <GETB .T 0>)
		      (.NORTH?
		       <LKP ,MLOC ,R-NORTHS>)
		      (T
		       <LKP ,MLOC ,R-SOUTHS>)>)>>

<ROUTINE MIREW ()
    	 <COND (<0? ,MDIR> <LKP ,MLOC ,R-WESTS>)
	       (T <LKP ,MLOC ,R-EASTS>)>>

<ROUTINE MIRIN ("OPTIONAL" (VRB T))
         <COND (<AND <==? <MIRROR-HERE? ,HERE> 1> ,MIRROR-OPEN-FLAG>
		,IN-MIRROR)
	       (<NOT .VRB> <RFALSE>)
	       (<==? <MIRROR-HERE? ,HERE> 1>
	        <COND (<AND <NOT ,MIRROR-OPENED> ,MR1-FLAG>
		       <TELL "A mirror blocks your way." CR>
		       <RFALSE>)
		      (T <TELL "The panel is closed." CR> <RFALSE>)>)
	       (T <TELL "The structure blocks your way." CR> <RFALSE>)>>

<ROUTINE MREYE-ROOM ("OPTIONAL" (RARG <>) "AUX" O)
         <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? DROP>
		     <IN? ,PRSO ,WINNER>
		     <NOT <BEAM-STOPPED?>>>
		<MOVE ,PRSO ,HERE>
		<TELL
"You conveniently drop the " D ,PRSO " in position to block the
beam of light." CR>)
	       (<==? .RARG ,M-LOOK>
	        <TELL
"You are in the middle of a long north-south corridor whose walls are
polished stone. A narrow red beam of light crosses the room at the north
end, inches above the floor." CR>
	        <COND (<SET O <BEAM-STOPPED?>>
		       <TELL
"The beam is blocked by a " D .O " lying on the floor." CR>)>
		<LOOK-TO ,MRA <>>)>>

<ROUTINE BEAM-STOPPED? ("AUX" N)
	 <SET N <FIRST? ,MREYE>>
	 <REPEAT ()
		 <COND (<NOT <EQUAL? .N ,PLAYER ,BEAM>>
			<SETG BEAM-BREAKER .N>
			<RETURN .N>)
		       (<NOT <SET N <NEXT? .N>>> <RFALSE>)>>>

; "This function cannot have its .PRSI and .PRSO's changed to ,PRSI etc!!"

<GLOBAL BEAM-BREAKER <>>

<ROUTINE BEAM-FUNCTION ("AUX" PRO PRI)
	 <COND (<VERB? LEAP>
		<TELL
"You jump over the beam and into the hallway." CR>
		<GOTO ,MRA>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<TELL 
"It simply crosses the northern end of the room, so there's nowhere to
follow it." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The red beam of light crosses the north end of the room only an inch or so
above the floor.">
		<COND (<BEAM-STOPPED?>
		       <TELL " The beam is broken by a " D ,BEAM-BREAKER
			     " lying on the ground.">)>
		<CRLF>)
	       (<VERB? PUT MUNG>
	        <COND (<VERB? PUT>
		       <SET PRI ,PRSO>
		       <SET PRO ,PRSI>)
		      (T
		       <SET PRI ,PRSI>
		       <SET PRO ,PRSO>)>
	        <COND (<OR <NOT .PRI> <NOT <==? .PRO ,BEAM>>> <RFALSE>)
		      (<IN? .PRI ,WINNER>
		       <MOVE .PRI ,HERE>
		       <SETG BEAM-BREAKER .PRI>
		       <TELL
"The beam is now interrupted by a " D .PRI " lying on the floor." CR>)
		      (<IN? .PRI ,HERE>
		       <TELL
"The " D .PRI " already breaks the beam." CR>)
		      (<==? .PRI ,HANDS>
		       <TELL
"The beam is broken briefly as it passes through." CR>)
		      (T <TELL
"You're not holding the " D .PRI "." CR>)>)
	       (<AND <VERB? TAKE> <==? ,PRSO ,BEAM>>
	        <TELL
"No doubt you have a bottle of moonbeams as well." CR>)>>

<GLOBAL MIRROR-OPENED <>>

<ROUTINE MRSWITCH ()
	 <COND (<VERB? PUSH>
	        <COND (,MRSWPUSH-FLAG
		       <TELL "Click." CR>)
		      (T
		       <COND (<BEAM-STOPPED?>
			      <TELL "Click. Snap!" CR>
			      <ENABLE <QUEUE I-MRINT 7>>
			      <SETG MRSWPUSH-FLAG T>
			      <SETG MIRROR-OPEN-FLAG T>
			      <SETG MIRROR-OPENED T>
			      <FCLEAR ,MRA ,TOUCHBIT>)
			     (T <TELL "Click." CR>)>)>)>>

<ROUTINE I-MRINT ()
	 <SETG MRSWPUSH-FLAG <>>
	 <SETG MIRROR-OPEN-FLAG <>>
	 <COND (<OR <==? <MIRROR-HERE? ,HERE> 1>
		    <==? ,HERE ,IN-MIRROR>>
		<TELL "The mirror quietly swings shut." CR>)
	       (<==? ,HERE ,MR-ANTE>
		<TELL "The button pops back to its original position." CR>)>>

<GLOBAL MDIR 270>

;"mirror points... 0 = north"

<GLOBAL POLEUP-FLAG 0>

;"pole raised?: 0 -- in hole or channel, 1 -- foor level, 2 -- in air"

<ROUTINE MAGIC-MIRROR ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"You are inside a rectangular box of wood whose structure is rather
complicated. Four sides and the roof are filled in, and the floor is
open.|
|
As you face the side opposite the entrance, two short sides of
carved and polished wood are to your left and right. The left panel
is mahogany, the right pine. The wall you face is red on its left
half and black on its right. On the entrance side, the wall is white
opposite the red part of the wall it faces, and yellow opposite the
black section. The painted walls are at least twice the length of
the unpainted ones. The ceiling is painted blue.|
|
In the floor is a stone channel about six inches wide and a foot
deep. The channel is oriented in a north-south direction. In the
exact center of the room the channel widens into a circular
depression perhaps two feet wide. Incised in the stone around this
area is a compass rose.|
|
Running from one short wall to the other at about waist height
is a wooden bar, carefully carved and drilled. This bar is pierced
in two places. The first hole is in the center of the bar (and thus
the center of the room). The second is at the left end of the room
(as you face opposite the entrance). Through each hole runs a wooden
pole.|
|
The pole at the left end of the bar is short, extending about a foot
above the bar, and ends in a hand grip. The pole ">
	        <COND (<AND <==? ,MLOC ,MRB> <==? ,MDIR 270>>
		       <COND (<NOT <0? ,POLEUP-FLAG>>
			      <TELL
"has been lifted out
of a hole carved in the stone floor. There is evidently enough
friction to keep the pole from dropping back down.">)
			     (T
			      <TELL "has been dropped
into a hole carved in the stone floor.">)>)
		      (<EQUAL? ,MDIR 0 180>
		       <COND (<NOT <0? ,POLEUP-FLAG>>
			      <TELL "is positioned above
the stone channel in the floor.">)
			     (T
			      <TELL "has been dropped
into the stone channel incised in the floor.">)>)
		      (T
		       <TELL "is resting on the
stone floor.">)>
	       <TELL
"|
|
The long pole at the center of the bar extends from the ceiling
through the bar to the circular area in the stone channel. This
bottom end of the pole has a T-bar a bit less than two feet long
attached to it, and on the T-bar is carved an arrow. The arrow and
T-bar are pointing "
		     <GET ,LONGDIRS </ ,MDIR 45>>
		     ".">
	       <COND (,WOOD-OPEN-FLAG
		      <TELL
"|
The pine panel has been opened outward.">)>
	       <CRLF>)>>

<GLOBAL LONGDIRS <TABLE "north" "northeast" "east" "southeast"
			"south" "southwest" "west" "northwest">>

;"MOVEMENT"

<ROUTINE MPANELS ("AUX" MD)
         <COND (<VERB? PUSH>
	        <COND (<NOT <0? ,POLEUP-FLAG>>
		       <COND (<==? ,MLOC ,MRG>
			      <COND (,GUARDIANS-SEEN
				     <JIGS-UP
"The Guardians awake, and in perfect unison, utterly destroy you with
their stone bludgeons. Satisfied, they resume their posts.">
				     <RTRUE>)
				    (T
				     <JIGS-UP
"All at once, two immense stone bludgeons come through the top of the
structure, crushing you.">
				     <RTRUE>)>)>
		       <COND (<EQUAL? ,PRSO ,RED-PANEL ,YELLOW-PANEL>
			      <SET MD <MOD <+ ,MDIR 45> 360>>
			      <TELL "The structure rotates clockwise." CR>)
			     (T
			      <SET MD <MOD <+ ,MDIR 315> 360>>
			      <TELL
"The structure rotates counterclockwise." CR>)>
		       <TELL "The arrow on the compass rose now indicates "
			     <GET ,LONGDIRS </ .MD 45>>
			     "." CR>
		       <COND (,WOOD-OPEN-FLAG
			      <SETG WOOD-OPEN-FLAG <>>
			      <TELL "The pine wall closes quietly." CR>)>
		       <SETG MDIR .MD>)
		      (<0? <MOD ,MDIR 180>>
		       <TELL
 "The short pole prevents the structure from rotating." CR>)
		      (T
		       <TELL
 "The structure shakes slightly but doesn't move." CR>)>)>>

<ROUTINE MENDS ("AUX" RM)
	 <COND (<VERB? CLOSE> <TELL "You can't do that to the panel." CR>)
	       (<OR <VERB? PUSH>
		    <AND <VERB? OPEN> <==? ,PRSO ,PINE-PANEL>>>
	        <COND (<NOT <0? <MOD ,MDIR 180>>>
		       <TELL
"The structure rocks back and forth slightly but doesn't move." CR>)
		      (<==? ,PRSO ,MAHOGANY-PANEL>
		       <COND (<SET RM <MIRNS <L? ,MDIR 180>>>
			      <MIRMOVE <0? ,MDIR> .RM>)
			     (T
			      <TELL
"The structure has reached the end of the stone channel and won't
budge." CR>)>)
		      (T
		       <TELL "The pine wall swings open." CR>
		       <COND (<OR <AND <==? ,MLOC ,MRD>
				       <==? ,MDIR 0>>
				  <AND <==? ,MLOC ,MRC>
				       <==? ,MDIR 180>>
				  <==? ,MLOC ,MRG>>
			      <COND (,GUARDIANS-SEEN
				     <TELL
"The pine door opens into the field of view of the Guardians." CR>)
				    (T
				     <TELL
"The pine door opens into the field of view of the Guardians of
Zork, represented by two identical stone statues carrying bludgeons." CR>)>
			      <JIGS-UP
"The Guardians awake, and in perfect unison, utterly destroy you with
their stone bludgeons. Satisfied, they resume their posts.">
			      <RTRUE>)>
		       <SETG WOOD-OPEN-FLAG T>
		       <ENABLE <QUEUE I-PININ 5>>)>)>>

<ROUTINE I-PININ ()
	 <COND (,WOOD-OPEN-FLAG
		<SETG WOOD-OPEN-FLAG <>>
		<TELL "The pine wall closes quietly." CR>)>>

<ROUTINE MIRMOVE (NORTH? RM "AUX" (PU? <>) (LOSE <>))
	 <COND (<NOT <0? ,POLEUP-FLAG>> <SET PU? T>)>
	 <TELL <COND (.PU? "The structure sways unsteadily ")
		     (T "The structure slides ")>
	       <COND (.NORTH? "north") (T "south")>
	       " and stops over another compass rose." CR>
	 <SETG MLOC .RM>
	 <COND (<AND <==? .RM ,MRG> <==? ,HERE ,IN-MIRROR>>
	        <COND (.PU?
		       <SET LOSE T>)
		      (<OR <NOT ,MR1-FLAG> <NOT ,MR2-FLAG>>
		       <SET LOSE T>)
		      (<OR ,MIRROR-OPEN-FLAG ,WOOD-OPEN-FLAG>
		       <SET LOSE T>)>
	        <COND (.LOSE
		       <COND (,GUARDIANS-SEEN
			      <JIGS-UP
"Suddenly the Guardians realize someone is trying to sneak by them in
the structure. They awake and, in perfect unison, hammer the contents
of the box (in other words you) to pulp. They then resume their posts,
satisfied.">)
			     (T
			      <JIGS-UP
"Suddenly, two identical stone bludgeons come through the roof and
hammer the contents of the box to pulp. That includes you.">)>)>
		<RTRUE>)>
	 T>	

<ROUTINE SHORT-POLE-F ()
         <COND (<VERB? RAISE MOVE>
	        <COND (<==? ,POLEUP-FLAG 2>
		       <TELL "The pole cannot be raised further." CR>)
		      (T
		       <SETG POLEUP-FLAG 2>
		       <TELL "The pole is now slightly above the floor." CR>)>)
	       (<OR <AND <VERB? PUT> <==? ,PRSI ,CHANNEL>>
		    <VERB? PUSH LOWER>>
	        <COND (<0? ,POLEUP-FLAG>
		       <TELL "The pole cannot be lowered further." CR>)
		      (<0? <MOD ,MDIR 180>>
		       <TELL "The pole is lowered into the channel." CR>
		       <SETG POLEUP-FLAG 0>
		       T)
		      (<AND <==? ,MDIR 270> <==? ,MLOC ,MRB>>
		       <SETG POLEUP-FLAG 0>
		       <TELL "The pole is lowered into the stone hole." CR>)
		      (<==? ,POLEUP-FLAG 1>
		       <TELL "The pole is already resting on the floor." CR>)
		      (T
		       <SETG POLEUP-FLAG 1>
		       <TELL "The pole now rests on the stone floor." CR>)>)>>

\

<ROUTINE DUNGEON-MASTER-F ("OPTIONAL" (RARG <>)) 
	 <COND (<==? .RARG ,M-OBJDESC> <RFALSE>)
	       (<==? ,WINNER ,DUNGEON-MASTER>
		<COND (<VERB? FOLLOW>
		       <COND (<IN? ,DUNGEON-MASTER ,HERE>
			      <ENABLE <QUEUE I-FOLIN -1>>
			      <TELL
"The dungeon master answers, \"I will follow.\"" CR>)
			     (T
			      <TELL
"The dungeon master's voice replies, \"You must come here first!\"" CR>)>)
		      (<VERB? STAY WAIT>
		       <QUEUE I-FOLIN 0>
		       <TELL
"The dungeon master answers, \"I will stay.\"" CR>)
		      (<VERB? WALK>
		       <COND (<AND <EQUAL? ,PRSO ,P?SOUTH ,P?ENTER>
				   <==? ,HERE ,NORTH-CORRIDOR>>
			      <TELL
"\"I am not permitted to enter the prison cell.\"" CR>)
			     (<AND <==? ,PRSO ,P?NORTH>
				   <==? ,HERE ,NORTH-CORRIDOR>>
			      <MOVE ,DUNGEON-MASTER ,PARAPET>
			      <TELL
"\"Very well. I am at the parapet!\"" CR>
			      <QUEUE I-FOLIN 0>)
			     (<AND <EQUAL? ,PRSO ,P?NORTH ,P?ENTER>
				   <==? ,HERE ,SOUTH-CORRIDOR>>
			      <TELL
"\"I am not permitted to enter the prison cell.\"" CR>)
			     (T
			      <TELL
"\"I prefer to stay where I am, thank you.\"" CR>)>)
		      (<AND <VERB? WALK-TO> <==? ,PRSO ,PARAPET-OBJ>>
		       <MOVE ,DUNGEON-MASTER ,PARAPET>
		       <QUEUE I-FOLIN 0>
		       <TELL
"\"Very well!\"" CR>)
		      (<VERB? TAKE>
		       <TELL
"\"I will have no use for that, I am afraid.\"" CR>)
		      (<AND <VERB? OPEN> <==? ,PRSO ,DUNGEON-DOOR>>
		       <TELL
"The dungeon master appears angered. \"Do not run from your quest: you are
nearing the end!\"" CR>)
		      (<VERB? PUSH TURN SPIN FOLLOW STAY OPEN CLOSE WAIT
			      ATTACK WALK-TO>
		       <COND (<VERB? STAY FOLLOW WAIT> T)
			     (T <TELL "\"If you wish,\" he replies." CR>)>
		       <RFALSE>)
		      (T <TELL
"\"Do not be foolish! Consider the end of your quest!\"" CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"He is dressed simply in a hood and cloak, wearing an amulet and ring,
carrying an old book under one arm, and leaning on a wooden staff. A single
key, as if to a prison cell, hangs from his belt." CR>)
	       (<VERB? ATTACK MUNG>
		<REALLY-DEAD
"The dungeon master is taken by surprise. He dodges your blow, and
with a disappointed expression on his face, traces a complicated
pattern in the air with his staff. You crumble into dust.">)
	       (<VERB? TAKE>
		<TELL
"\"I'm willing to accompany you, but not ride in your pocket!\"" CR>)
	       (<AND <VERB? GIVE> <==? ,PRSI ,DUNGEON-MASTER>>
		<TELL
"\"I have no need for those things.\"" CR>)>>

<ROUTINE MASTER-F () 
	 <COND (<EQUAL? ,HERE ,PRISON-CELL ,GOOD-CELL>
		<COND (<HELLO? ,MASTER>
		       <TELL "He can't hear you." CR>)
		      (T <TELL "He is not here." CR>)>)
	       (<VERB? TELL> <SETG PRSO ,DUNGEON-MASTER> <RFALSE>)
	       (<AND <VERB? GIVE SGIVE> <IN? ,DUNGEON-MASTER ,HERE>>
		<TELL
"He politely refuses your offer." CR>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,CELL ,NORTH-CORRIDOR>
		     <IN? ,DUNGEON-MASTER ,PARAPET>>
		<TELL "The dungeon master is standing on the parapet." CR>)
	       (T <TELL "The dungeon master isn't here." CR>)>>

<GLOBAL DM-SEEN <>>

<ROUTINE BEHIND-DOOR-F ("OPTIONAL" (RARG <>))
         <COND (<AND <==? .RARG ,M-ENTER> <NOT ,DM-SEEN>>
		<ENABLE <QUEUE I-FOLIN -1>>
		<SETG DM-SEEN T>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"You are in a narrow north-south corridor. At the south end is a door
and at the north end is an east-west corridor. The door is ">
		<DPR ,DUNGEON-DOOR>)>>

<ROUTINE FRONT-DOOR-F ("OPTIONAL" (RARG <>))
    	 <COND (<==? .RARG ,M-ENTER>
		<QUEUE I-FOLIN 0>)
	       (<==? .RARG ,M-LOOK>
		<LOOK-TO <> ,MRD>
		<TELL
"The wooden door has a barred panel in it at about head height. The
door itself is ">
	        <DPR ,DUNGEON-DOOR>)>>

<ROUTINE LOOK-LIKE-DM? ()
	 <AND <IN? ,CLOAK ,WINNER>
	      <IN? ,HOOD ,WINNER>
	      <IN? ,AMULET ,WINNER>
	      <IN? ,STAFF ,WINNER>
	      <IN? ,RING ,WINNER>
	      <IN? ,LORE-BOOK ,WINNER>
	      <IN? ,KEY ,WINNER>>>

<ROUTINE DUNGEON-PANEL-F ()
	 <COND (<VERB? OPEN>
		<TELL "You can't open the panel. It's set into the door." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "There's not much to be seen." CR>)>>

<ROUTINE DUNGEON-DOOR-F ()
    	 <COND (<VERB? OPEN CLOSE>
		<TELL "The door won't budge." CR>)
	       (<AND <VERB? KNOCK> <EQUAL? ,HERE ,FRONT-DOOR>>
		<TELL
"The knock reverberates along the hall. For a time it seems there
will be no answer. Then you hear someone unlatching the small
panel. Through the bars of the great door, the wrinkled
face of an old man appears.">
		<COND (,INVIS
		       <TELL " He seems not to notice you
for a brief moment, then recovers.">)>
		<COND (<LOOK-LIKE-DM?>
		       <TELL " He starts to smile broadly and opens the
massive door without a sound. The old man motions and you feel yourself
drawn toward him.|
\"I am the Master of the Dungeon!\" he booms. \"I have been watching
you closely during your journey through the Great Underground Empire.
Yes!,\" he says, as if recalling some almost forgotten time, \"we have
met before, although I may not appear as I did then.\" You look
closely into his deeply lined face and see the faces of the old man by the
secret door, your \"friend\" at the cliff, and the hooded figure. \"You have
shown kindness to the old man, and compassion toward the hooded one. You
displayed patience in the puzzle and trust at the cliff. You have
demonstrated strength, ingenuity, and valor. However, one final test awaits
you. Now! Command me as you will, and complete your quest!\"|" CR>
		       <GOTO ,BEHIND-DOOR>
		       <SETG IN-DUNGEON T>)
		      (T
		       <TELL " He looks you over with a piercing gaze
and then speaks gravely. \"I have been waiting a long time for you, ">
		       <TELL <GET ,DM-REASONS <DMISH>>>
		       <TELL "
I will remain here. When you feel you are ready, go to the
secret door and 'SAY \"FROTZ OZMOO\"'! Go, now!\" He wags his finger
in warning. \"Do not forget the double
quotes!\" A moment later, you find yourself in the Button Room." CR>
		       <GOTO ,MR-ANTE <>>
		       <RTRUE>)>)>>

<GLOBAL IN-DUNGEON <>>

<GLOBAL DM-REASONS <TABLE
"but I fear my waiting may be in vain."
"but you have far to go before you are ready."
"and you seem to have made slight some progress."
"and your journey is half complete. Be of good cheer!"
"and you are nearing the end of your long quest!"
"and it will not be long before you are ready!"
"and you are nearly ready for the last test!">>

<ROUTINE DMISH ("AUX" (CNT 0))
	 <COND (<IN? ,AMULET ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,LORE-BOOK ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,HOOD ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,CLOAK ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,RING ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,KEY ,WINNER> <SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,STAFF ,WINNER> <SET CNT <+ .CNT 1>>)>
	 .CNT>
	
<GLOBAL FOLFLAG T>	;"Following?"

<ROUTINE I-FOLIN ()
	 <COND (<IN? ,DUNGEON-MASTER ,HERE> <RFALSE>)
	       (<AND <EQUAL? ,HERE ,PRISON-CELL ,CELL> ,FOLFLAG>
		<TELL
"You notice that the dungeon master doesn't follow you." CR>
		<SETG FOLFLAG <>>
		<RTRUE>)
	       (<EQUAL? ,HERE ,PRISON-CELL ,CELL> <RFALSE>)
	       (<NOT ,FOLFLAG>
		<SETG FOLFLAG T>
		<TELL "The dungeon master rejoins you." CR>
		<MOVE ,DUNGEON-MASTER ,HERE>
		<RTRUE>)
	       (T
		<TELL "The dungeon master follows you." CR>
		<MOVE ,DUNGEON-MASTER ,HERE>
		<RTRUE>)>>

\

;"SUBTITLE
 'The end had come, and this was it; he dropped her in the Flaming Pit.'"

<GLOBAL LCELL 1> ;"cell in slot"

<GLOBAL PNUMB 1> ;"cell pointed at"

<GLOBAL CELLOBJS <ITABLE NONE <* 8 2 8>>>

<ROUTINE MOVE-CELL-OBJECTS ("AUX" TOP CNT F X)
	 <SET TOP <* 8 <- ,LCELL 1>>>
	 <SET CNT <+ .TOP 1>>
	 <SET F <FIRST? ,CELL>>
	 <COND (.F
		<REPEAT ()
			<SET X <NEXT? .F>>
			<COND (<NOT .F> <RETURN>)
			      (T
			       <PUT ,CELLOBJS .CNT .F>
			       <REMOVE .F>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT .X> <RETURN>)
			      (T <SET F .X>)>>)>
	 <PUT ,CELLOBJS .TOP <- <- .CNT .TOP> 1>>
	 <SET TOP <* 8 <- ,PNUMB 1>>>
	 <SET CNT <GET ,CELLOBJS .TOP>>
	 <REPEAT ()
		 <COND (<0? .CNT> <RETURN>)
		       (T
			<SET TOP <+ .TOP 1>>
			<MOVE <GET ,CELLOBJS .TOP> ,CELL>
			<SET CNT <- .CNT 1>>)>>>

<ROUTINE CELL-MOVE ("AUX" F X)
	 <FCLEAR ,CELL-DOOR ,OPENBIT>
	 <FCLEAR ,BRONZE-DOOR ,OPENBIT>
	 <COND (<NOT <==? ,PNUMB ,LCELL>>
	        <COND (<==? ,PNUMB 4> <FCLEAR ,BRONZE-DOOR ,INVISIBLE>)
		      (ELSE <FSET ,BRONZE-DOOR ,INVISIBLE>)>
	        <COND (<IN? ,PLAYER ,CELL>
		       <SETG WINNER ,PLAYER>
		       <FCLEAR ,GOOD-CELL ,TOUCHBIT>
		       <FCLEAR ,PRISON-CELL ,TOUCHBIT>
		       <GOTO <COND (<==? ,LCELL 4>
				    <FCLEAR ,BRONZE-DOOR ,INVISIBLE>
				    ,GOOD-CELL)
				   (ELSE ,PRISON-CELL)>>
		       <SET F <FIRST? ,CELL>>
		       <COND (.F
			      <REPEAT ()
				      <SET X <NEXT? .F>>
				      <COND (<NOT .F> <RETURN>)
					    (T <MOVE .F ,HERE>)>
				      <COND (<NOT .X> <RETURN>)
					    (T <SET F .X>)>>)>)
		      (T <MOVE-CELL-OBJECTS>)>
	        <SETG LCELL ,PNUMB>)>>

<ROUTINE PARAPET-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"You are standing behind a stone retaining wall which rims a parapet
overlooking a fiery pit. It is difficult to see through the
smoke and flame which fills the pit, but it seems to be bottomless.
The pit itself is circular, about two hundred feet in diameter,
and is fashioned of roughly hewn stone. The flames generate considerable
heat, so it is rather uncomfortable standing here.|
There is an object here which looks like a sundial. On it are an
indicator arrow surrounding a large button. On the face of
the dial are numbers 1 through 8. The indicator points to the number "
N ,PNUMB "." CR>
		<TELL
"To the south, across a narrow corridor, is a prison cell." CR>)>>

<ROUTINE DIAL ("AUX" N)
	 <COND (<VERB? EXAMINE>
		<TELL "The dial points to " N ,PNUMB "." CR>)
	       (<VERB? TURN>
	        <COND (<==? ,PRSI ,INTNUM>
		       <COND (<OR <0? ,P-NUMBER>
				  <G? ,P-NUMBER 8>>
			      <TELL "There is no such setting." CR>
			      <RTRUE>)>
		       <SETG PNUMB ,P-NUMBER>
		       <COND (<==? ,WINNER ,PLAYER>
			      <TELL
"The dial now points to " N ,PNUMB "." CR>)>
		       <RTRUE>)
		      (<NOT ,PRSI>
		       <TELL "You must specify what to set the dial to." CR>)
		      (T <TELL "The dial face only contains numbers." CR>)>)
	       (<VERB? SPIN>
	        <SETG PNUMB <RANDOM 8>>
	        <COND (<==? ,WINNER ,PLAYER>
		       <TELL
"The dial spins and comes to a stop pointing at " N ,PNUMB ".">)>
		<RTRUE>)>>

<ROUTINE DIALBUTTON ("AUX" C)
	 <SET C <FSET? ,CELL-DOOR ,OPENBIT>>
	 <FCLEAR ,CELL ,TOUCHBIT>
	 <COND (<VERB? PUSH>
	        <COND (<==? ,WINNER ,PLAYER>
		       <TELL
"The button depresses with a slight click, and pops back." CR>)>
		<CELL-MOVE>
		<COND (.C <TELL
"You notice that the cell door is now closed." CR>)>
		<RTRUE>)>>

<ROUTINE CELL-ROOM (RARG)
         <COND (<==? .RARG ,M-LOOK>
	        <TELL
"You are in a featureless prison cell. You can see ">
		<COND (<FSET? ,CELL-DOOR ,OPENBIT>
		       <TELL "an east-west
corridor outside the cell door. Your view also takes in the parapet and
a large, fiery pit." CR>)
		      (T
		       <TELL "through the small window
in the closed door the parapet, and, behind that,
smoke and flames rising from a fiery pit." CR>)>
		<COND (<IN? ,DUNGEON-MASTER ,PARAPET>
		       <TELL
"The dungeon master is at the parapet, leaning on his
staff. His keen gaze is fixed on you and he looks tense,
as if waiting for something to happen." CR>)> 
	        <COND (<==? ,LCELL 4>
		       <TELL
"Behind you, to the south, is a bronze door which is ">
		       <DPR ,BRONZE-DOOR>)>
		<RTRUE>)>>
		
<ROUTINE NCELL-ROOM (RARG)
         <COND (<==? .RARG ,M-LOOK>
	        <TELL
"You are in a bare prison cell. Its wooden door is securely fastened,
and you can see only flames and smoke through its small window. On the
south wall is a bronze door which seems to be ">
	        <DPR ,BRONZE-DOOR>)>>

<ROUTINE DPR (OBJ)
	 <COND (<FSET? .OBJ ,OPENBIT> <TELL "open." CR>)
	       (T <TELL "closed." CR>)>>

<ROUTINE NORTH-CORRIDOR-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"This is a wide east-west corridor which opens onto a northern
parapet at its center. You can see flames and smoke as you peer
towards the parapet. The corridor turns south at either end, and in
the center of the south wall is a heavy wooden door with a small
barred window. The door is ">
		<DPR ,CELL-DOOR>)>>

<ROUTINE SOUTH-CORRIDOR-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"You are in an east-west corridor which turns north at its eastern
and western ends. The walls are made of the finest marble. Another
hall leads south at the center of the corridor." CR>
	       <COND (<==? ,LCELL 4>
		      <TELL
"In the center of the north wall is a bronze door which is ">
		      <DPR ,BRONZE-DOOR>)>
	       <RTRUE>)>>

<GLOBAL BRONZE-DOOR-LOCKED T>

<ROUTINE BRONZE-DOOR-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,BRONZE-DOOR ,OPENBIT>>
		     <==? ,HERE ,GOOD-CELL>
		     <NOT ,BRONZE-DOOR-LOCKED>>
		<TELL
"On the other side of the bronze door is a narrow passage which opens out
into a larger area." CR>
		<FSET ,BRONZE-DOOR ,OPENBIT>)
	       (<AND <VERB? OPEN> ,BRONZE-DOOR-LOCKED>
		<TELL
"The bronze door is locked." CR>)>>

<ROUTINE LOCKED-DOOR-F ()
	 <COND (<VERB? OPEN UNLOCK>
	        <TELL "The door is securely fastened." CR>)>>

\

"========== The Ultimate Winnage =========="

<ROUTINE NIRVANA-F (RARG)
	 <COND (<==? .RARG ,M-END>
	        <TELL
"As you examine your new-found riches, the Dungeon Master
materializes beside you, and says, \"Now that you have solved all the
mysteries of the Dungeon, it is time for you to assume your rightly-earned
place in the scheme of things. Long have I waited for one capable of
releasing me from my burden!\" He taps you lightly on the head with his
staff, mumbling a few well-chosen spells, and you feel yourself changing,
growing older and more stooped. For a moment there are two identical mages
standing among the treasure, then your counterpart dissolves into a
mist and disappears, a sardonic grin on his face.|
|
For a moment you are relieved, safe in the knowledge that you have
at last completed your quest in ZORK. You begin to feel the vast powers
and lore at your command and thirst for an opportunity to use them.|
|
">
	       <FINISH>)>>

<ROUTINE BRONZE-DOOR-EXIT ()
	 <COND (<FSET? ,BRONZE-DOOR ,INVISIBLE>
		<TELL "You can't go that way." CR>
		<RFALSE>)
	       (<FSET? ,BRONZE-DOOR ,OPENBIT>
		,CELL)
	       (T
		<TELL "The bronze door is closed." CR>
		<RFALSE>)>>

;<ROUTINE MASTER-F ()
	 <PERFORM ,PRSA ,DUNGEON-MASTER>
	 <RTRUE>>

<GLOBAL OLD-MAN-GONE <>>
<GLOBAL OLD-MAN-FED <>>

<GLOBAL SECRET-DOOR-DESC
"Beyond the secret door are dark, forbidding stairs leading down to
a passage below. Flickering torchlight illuminates the passage.">

<ROUTINE SECRET-DOOR-F ()
	 <COND (<AND <VERB? OPEN> <NOT <FSET? ,SECRET-DOOR ,OPENBIT>>>
		<TELL "The massive stone door opens noiselessly. "
		      ,SECRET-DOOR-DESC CR>
		<FSET ,SECRET-DOOR ,OPENBIT>)>>

<ROUTINE MSTAIRS-F (RARG)
	 <COND (<AND <==? .RARG ,M-ENTER>
		     <PROB 30>
		     <NOT ,OLD-MAN-FED>
		     <NOT ,OLD-MAN-GONE>>
		<MOVE ,OLD-MAN ,HERE>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"You are in a room with passages heading southwest and southeast. The
north wall is ornately carved, filled with strange runes and writing in
an unfamiliar language." CR>
		<COND (<FSET? ,SECRET-DOOR ,OPENBIT>
		       <TELL ,SECRET-DOOR-DESC CR>)
		      (<NOT <FSET? ,SECRET-DOOR ,INVISIBLE>>
		       <TELL
"The outline of a door is barely visible among the runes." CR>)>)>>

<ROUTINE HELLO? (WHO)
	 <COND (<OR <==? ,WINNER .WHO>
		    <VERB? TELL ANSWER REPLY SAY HELLO INCANT>>
		<COND (<VERB? TELL ANSWER SAY INCANT REPLY>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>)>
		<RTRUE>)>>

<ROUTINE OLD-MAN-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (,OLD-MAN-AWAKE
		       <TELL
"There is an old man huddled in the corner, eyeing you cautiously.
He looks weak and tired." CR>)
		      (T
		       <TELL
"An old and wizened man is huddled, asleep, in the corner. He is snoring
loudly, and looks quite weak and frail." CR>)>)
	       (<AND <VERB? GIVE> <==? ,PRSI ,OLD-MAN>>
		<COND (,OLD-MAN-AWAKE
		       <COND (<==? ,PRSO ,WAYBREAD>
			      <REMOVE ,WAYBREAD>
			      <TELL
"He looks up at you and takes the waybread. Slowly, he eats the
bread and pauses when he is finished. He starts to speak: \"Perhaps what you
seek is through there!\" He points at the carved wall to the north, where you
now notice the bare outline of a secret door. When you turn back, the old
man is gone!" CR>
			      <FCLEAR ,SECRET-DOOR ,INVISIBLE>
			      <SETG OLD-MAN-GONE T>
			      <REMOVE ,OLD-MAN>)
			     (<IN? ,WAYBREAD ,WINNER>
			      <TELL
"He refuses your offer but motions with his arm to the waybread in your
hand." CR>)
			     (T
			      <TELL
"The old man refuses the " D ,PRSO " with a wave of his hand." CR>)>)
		      (T <TELL "He is asleep!" CR>)>)
	       (<VERB? EXAMINE>
		<COND (,OLD-MAN-AWAKE
		       <TELL
"The old man is barely awake and appears to nod off every few moments.
He has bright eyes, which appear to see right through your body." CR>)
		      (T
		       <TELL
"The man is very, very old and wizened. He has a long, stringy
beard and is snoring quite loudly." CR>)>)
	       (<VERB? LISTEN>
		<COND (,OLD-MAN-AWAKE <TELL "He isn't talking." CR>)
		      (T
		       <TELL
"He is snoring like a buzz saw." CR>)>)
	       (<HELLO? ,OLD-MAN>
		<COND (,OLD-MAN-AWAKE
		       <TELL
"He nods at you without seeming to have understood." CR>)
		      (T
		       <TELL
"He is sleeping soundly and does not respond." CR>)>)
	       (<VERB? SHAKE ALARM>
		<TELL
"The old man is roused to consciousness. He peers at you through eyes which
appear much younger and stronger than his frail body and waits, as if expecting
something to happen." CR>
		<SETG OLD-MAN-AWAKE T>
		<ENABLE <QUEUE I-OLD-MAN-SLEEPS 3>>)
	       (<VERB? ATTACK MUNG>
		<TELL
"The attack seems to have left the old man unharmed! You watch in awe as he
rises to his feet and seems to tower above you. He peers down menacingly,
then sadly and wearily. \"Not yet,\" he mourns, and vanishes in a puff of
smoke." CR>
		<SETG OLD-MAN-GONE T>
		<REMOVE ,OLD-MAN>)>>

<GLOBAL OLD-MAN-AWAKE <>>

<ROUTINE I-OLD-MAN-SLEEPS ()
	 <SETG OLD-MAN-AWAKE <>>
	 <COND (<IN? ,OLD-MAN ,HERE>
		<TELL "You notice that the old man has fallen asleep." CR>)>>

<ROUTINE RUNES-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The runes are in an ancient language. Some pictures among the runes depict
flames, stone statues, and an old man." CR>)>>

<ROUTINE T-BAR-F ()
	 <COND (<VERB? TURN>
		<TELL
"You don't have enough leverage to turn the T-bar. You might be able
to turn the whole structure, however." CR>)>>

<ROUTINE FLAMING-PIT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The flaming pit is a seemingly bottomless abyss filled with smoke and
flame." CR>)
	       (<AND <VERB? PUT> <==? ,PRSI ,FLAMING-PIT>>
		<COND (<EQUAL? ,HERE ,PARAPET ,NORTH-CORRIDOR>
		       <COND (<==? ,PRSO ,ME>
			      <TELL
"It would be a pity to end your life so near the end of your quest!" CR>)
			     (T
			      <TELL
"You cast the " D ,PRSO " into the pit, where it is lost forever." CR>
			      <REMOVE ,PRSO>)>)
		      (T <TELL "You're not close enough." CR>)>)>>

<ROUTINE PARAPET-OBJ-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,CELL ,NORTH-CORRIDOR>
		       <TELL
"You can see the parapet and sundial from here.">
		       <COND (<IN? ,DUNGEON-MASTER ,PARAPET>
			      <TELL " The dungeon master is there
also, leaning on his staff.">)>
		       <CRLF>)
		      (T <V-LOOK>)>)>>

<ROUTINE ROSE-F ()
	  <COND (<VERB? TURN MOVE>
		 <TELL
"The compass rose is made of stone and is imbedded in the ground.
You could not possibly turn it or move it." CR>)>>

<ROUTINE CELL-DOOR-F ()
	 <COND (<AND <VERB? PUT> <==? ,PRSI ,CELL-DOOR>>
		<TELL "You will have to enter the cell first." CR>)
	       (<VERB? THROUGH>
		<COND (<==? ,HERE ,CELL>
		       <TELL "Look around." CR>)
		      (T
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)>)>>

<ROUTINE LORE-BOOK-F ()
	 <COND (<AND <VERB? BURN> <NOT <IN? ,LORE-BOOK ,WINNER>>>
		<TELL
"The book is consumed in a dazzling display of color." CR>
		<REMOVE ,PRSO>
		<RTRUE>)
	       (<AND ,IN-DUNGEON <VERB? OPEN EXAMINE READ>>
		<TELL
"The book seems to will itself open to a specific page. It shows a picture of
eight small rooms located around a great circle of flame. All are identical
save one, which has a bronze door leading to a room bathed in golden light.
A legend beneath the picture says \"The Dungeon and Treasury of Zork.\"" CR>)
	       (<VERB? OPEN>
		<TELL
"The book can be perused but not left open." CR>)>>

<ROUTINE CP-HOLE-F ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>>

<ROUTINE TORCH-PSEUDO ()
	 <TELL "The torches are out of reach." CR>>

<ROUTINE WATER-FCN ("AUX" AV PI?)
	 #DECL ((AV) <OR OBJECT FALSE> (PI?) <OR ATOM FALSE>)
	 <COND (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO ,GLOBAL-WATER>
		<SET PI? <>>)
	       (<EQUAL? ,PRSO ,GLOBAL-WATER>
		<SET PI? <>>)
	       (,PRSI
		<SET PI? T>)>
	 <COND (.PI? <SETG PRSI ,GLOBAL-WATER>)
	       (T <SETG PRSO ,GLOBAL-WATER>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<TELL "The water slips through your fingers." CR>)
	       (.PI? <TELL "You can't do that." CR>)
	       (<VERB? DROP GIVE THROW>
		<TELL "You don't have any water." CR>)>>

<ROUTINE RANDOM-WALL ()
	 <COND (<VERB? PUSH>
		<COND (<==? ,HERE ,IN-MIRROR>
		       <TELL
"You should specify which panel you want to push." CR>)
		      (T <TELL
"You can't budge it; at least from here." CR>)>)>>

^/L

;"special-cased routines"

;"put GO here, eventually"

<ROUTINE V-DIAGNOSE ()
	 <TELL <GET ,DIAG ,P-STRENGTH> CR>>

<GLOBAL DIAG <TABLE
"You are dead."
"You are very seriously wounded. One more wound would very likely do you in."
"You are hurt quite badly. One major wound would probably kill you."
"You have a few wounds, which do not seriously impair your strength."
"You are wounded lightly. You have a good deal of strength in reserve."
"You are in perfect health.">>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 #DECL ((DESC) STRING (PLAYER?) <OR ATOM FALSE>)
 	 <SETG SWORD-STATE 0>
	 <SETG P-STRENGTH 5>
	 <SETG S-STRENGTH 5>
	 <TELL .DESC CR>
	 <COND (<NOT <==? ,YEAR ,YEAR-PRESENT>> <QUIT>)>
	 <COND (<NOT <==? ,ADVENTURER ,WINNER>>
		<TELL "
|    ****  The " D ,WINNER " has died  ****
|
|">
		<REMOVE ,WINNER>
		<SETG WINNER ,ADVENTURER>
		<SETG HERE <LOC ,WINNER>>
		<RFATAL>)>
	 <TELL "
|    ****  You have died  ****
|
|">
	 <COND (<G? <SETG DEATHS <+ ,DEATHS 1>> 3>
		<TELL
"You feel yourself disembodied in a deep blackness. A voice from the void
speaks:  \"I have waited a long age for you, my friend, but perhaps it has been
another that I have been seeking. Good night, oh worthy adventurer!\" It is
the last you hear." CR>
		<QUIT>)
	       (T
		<TELL
"You find yourself deep within the earth in a barren prison cell.
Outside the iron-barred window, you can see a great, fiery pit. Flames
leap up and very nearly sear your flesh. After a while, footfalls can
be heard in the distance, then closer and closer.... The door swings
open, and in walks an old man.|
|
He is dressed simply in a hood and cloak,
wearing a few simple jewels, carrying something under one arm, and
leaning on a wooden staff. A single key, as if to a massive prison cell,
hangs from his belt.|
|
He raises the staff toward you and you hear
him speak, as if in a dream: \"I await you, though your journey be long
and full of peril. Go then, and let me not wait long!\" You feel some
great power well up inside you and you fall to the floor. The next
moment, you are awakening, as if from a deep slumber." CR>)>
	 <MOVE ,CURRENT-LAMP ,ZORK2-STAIR>
	 <COND (<AND <IN? ,KEY ,WINNER>
		     <OR <EQUAL? ,HERE ,DARK-1 ,DARK-2 ,KEY-ROOM>
			 <EQUAL? ,HERE ,AQ-1 ,AQ-2>>>
		<MOVE ,KEY ,KEY-ROOM>)>
	 <CRLF>
	 <GOTO ,ZORK2-STAIR>
	 <SETG P-CONT <>>
	 <RANDOMIZE-OBJECTS>
	 <KILL-INTERRUPTS>
	 <RFATAL>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <SET N <FIRST? ,WINNER>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <MOVE .F <RANDOM-ELEMENT ,DEAD-OBJ-LOCS>>>>

<GLOBAL DEAD-OBJ-LOCS
	<LTABLE JUNCTION CLEARING DAMP-PASSAGE CREEPY-CRAWL TIGHT-SQUEEZE
		FOGGY-ROOM DEAD-END>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-MAN-LEAVES>>
	 <DISABLE <INT I-MAN-RETURNS>>
	 <DISABLE <INT I-VIEW-SNAP>>
	 <DISABLE <INT I-FOLIN>>
	 <RTRUE>>

<GLOBAL SCORE-MAX 7>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your potential is " N ,SCORE>
	 <TELL " of a possible " N ,SCORE-MAX ", in ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " move.">) (ELSE <TELL " moves.">)>
	 <CRLF>
	 ,SCORE>

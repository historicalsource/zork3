"ACTIONS3 for
		     ZORK III: The Dungeon Master
		 The Great Underground Empire (Part 3)
	(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.
"

"SWORD demon"

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) P T L)
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<AND <==? ,HERE ,CLIFF> <NOT ,MAN-GONE>> <SET NG 1>)
		      (<AND <==? ,HERE ,CLIFF-LEDGE> ,MAN-FLAG> <SET NG 1>)
		      (<INFESTED? ,HERE> <SET NG 2>)
		      (<OR <AND <==? ,MLOC ,MRG> <==? ,HERE ,IN-MIRROR>>
			   <EQUAL? ,HERE ,MRGE ,MRG ,MRGW>>
		       <SET NG 1>)
		      (ELSE
		       <SET P 0>
		       <REPEAT ()
			       <COND (<0? <SET P <NEXTP ,HERE .P>>>
				      <RETURN>)
				     (<NOT <L? .P ,LOW-DIRECTION>>
				      <SET T <GETPT ,HERE .P>>
				      <SET L <PTSIZE .T>>
				      <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					     <COND (<INFESTED? <GETB .T 0>>
						    <SET NG 1>
						    <RETURN>)>)>)>>)>
		<COND (<==? .NG ,SWORD-STATE> <RFALSE>)
		      (<==? .NG 2>
		       <TELL "Your sword has begun to glow very brightly." CR>)
		      (<1? .NG>
		       <TELL "Your sword is glowing with a faint blue glow."
			     CR>)
		      (<0? .NG>
		       <TELL "Your sword is no longer glowing." CR>)>
		<SETG SWORD-STATE .NG>
		<RTRUE>)
	       (ELSE <DISABLE .DEM> <RFALSE>)>>

<GLOBAL SWORD-STATE 0>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>)) 
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN <>>)
		       (<AND <FSET? .F ,ACTORBIT> <NOT <FSET? .F ,INVISIBLE>>>
			<RETURN .F>)
		       (<NOT <SET F <NEXT? .F>>> <RETURN <>>)>>>

"old ACTIONS.ZIL"

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
	       (T <TELL "You can't see any ladder here." CR>)>>

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
  .. = your position (middle of grid)|
  MM = marble wall|
  SS = sandstone wall|
  ?? = unknown (blocked by walls)|
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
		<TELL "You can't see any steel door here." CR>)
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
		      <TELL <PICK-ONE ,YUKS> CR>)
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
	       (T <TELL "You can't see any wooden wall here." CR>)>>

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
	        <TELL "You can't see any mirror here." CR>)
	       (<VERB? OPEN MOVE>
	        <TELL
"You don't see a way to open the mirror here." CR>)
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
	        <TELL "You can't see any panel here." CR>)
	       (<VERB? OPEN MOVE>
	        <TELL "You don't see a way to open the panel here." CR>)
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
		       <TELL "There's a wall there." CR>
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
		       <SETG MDIR .MD>
		       <RTRUE>)
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
		       <COND (<IN? ,DUNGEON-MASTER <LOC ,PLAYER>>
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
			      <SETG HERE ,PARAPET>
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
		       <SETG HERE ,PARAPET>
		       <QUEUE I-FOLIN 0>
		       <TELL
"\"Very well!\"" CR>)
		      (<VERB? TAKE>
		       <TELL
"\"I will have no use for that, I am afraid.\"" CR>)
		      (<AND <VERB? OPEN>
			    <==? ,PRSO ,DUNGEON-DOOR>
			    ,IN-DUNGEON>
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
	       (<VERB? TELL>
		<COND (,IN-DUNGEON
		       <SETG PRSO ,DUNGEON-MASTER>
		       <RFALSE>)
		      (ELSE
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>
		       <TELL "The dungeon master isn't here." CR>)>)
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
	       (<EQUAL? <LOC ,PLAYER> ,PRISON-CELL ,CELL> <RFALSE>)
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
mysteries of the Dungeon, it is time for you to assume your rightly earned
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
	 <TELL "|
    ****  You have died  ****|
|
">
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
He is dressed simply in a hood and cloak, wearing an amulet and ring,
carrying an old book under one arm, and leaning on a wooden staff. A single
key, as if to a massive prison cell, hangs from his belt.|
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

\

"old TM.ZIL"

"Incredibly bizarre Time Machine Problem"

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
crystalline-encrusted rock formations. Phosphorescent mosses, fed by
a trickle of water from above, make the crystals glow and sparkle with
every color of the rainbow. There is an opening to the west, and a
man-made passage heads south.")
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
"This is the north end of a large hall with a vaulted ceiling. A long, tiled
hallway leads north through a tall arch. Although the purpose of
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
It shows a curiously flat-headed figure wearing a gaudy crown,
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

<OBJECT TM-HOLLOW
	(IN TIME-MACHINE)
	(DESC "seat")
	(SYNONYM AREA)
	(ADJECTIVE SMALL HOLLOW)
	(FLAGS NDESCBIT OPENBIT CONTBIT)
	(CAPACITY 20)
	(ACTION TM-HOLLOW-F)>

<ROUTINE TM-HOLLOW-F ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,TM-HOLLOW>>
		<PERFORM ,V?PUT-UNDER ,PRSO ,TM-SEAT>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK-UNDER ,TM-SEAT>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,TM-HOLLOW>
		<PERFORM ,PRSA ,TM-SEAT ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,PRSI ,TM-HOLLOW>
		<PERFORM ,PRSA ,PRSO ,TM-SEAT>
		<RTRUE>)>>

<OBJECT TM-SEAT
	(IN TIME-MACHINE)
	(DESC "seat")
	(SYNONYM SEAT CHAIR)
	(FLAGS NDESCBIT OPENBIT CONTBIT SURFACEBIT)
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
	(FLAGS TAKEBIT NDESCBIT TRYTAKEBIT)
	(SIZE 30)
	(ACTION CROWN-JEWELS-F)>

<OBJECT JEWELLED-KNIFE
	(IN PEDESTAL)
	(DESC "jewelled knife")
	(SYNONYM KNIFE JEWELS)
	(ADJECTIVE JEWELLED CROWN)
	(FLAGS TAKEBIT NDESCBIT TRYTAKEBIT)
	(SIZE 20)
	(ACTION CROWN-JEWELS-F)>

<OBJECT RING
	(IN PEDESTAL)
	(DESC "golden ring")
	(SYNONYM RING JEWELS)
	(ADJECTIVE GOLDEN CROWN)
	(FLAGS TAKEBIT NDESCBIT TRYTAKEBIT WEARBIT)
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
"The iron door is locked from the outside." CR>)
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
"There is a great tremor from within the earth. The entire dungeon shakes
violently and loose debris falls from above you." CR>)>
	 <COND (<==? ,HERE ,MUSEUM-ANTE>
		<TELL
"To the east, next to the great iron door, a cleft opens up,
revealing an open area behind!" CR>)
	       (<==? ,HERE ,AQ-VIEW>
		<TELL
"One of the giant pillars supporting the aqueduct collapses in a pile
of smoke and rubble!" CR>)
	       (<EQUAL? ,HERE ,AQ-2 ,AQ-3>
		<TELL
"The channel beneath your feet trembles. Then the channel just to the ">
		<COND (<==? ,HERE ,AQ-2> <TELL "north">)
		      (T <TELL "south">)>
		<TELL " collapses and falls into the chasm!" CR>)>
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
"This is the south end of a monumental hall, full of debris from
a recent earthquake. To the east is a great iron door, rusted shut. To its
right, however, is a gaping cleft in the rock and behind, a cleared area." CR>)
		      (T
		       <TELL
"You are in the southern half of a monumental hall. To the east lies
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
"This is an entrance hall of some sort, judging by the grand iron
door to the west, and the ornate stone and wooden doors which lead to the east
and north, respectively. A few wide steps lead south." CR>)
		      (T
		       <TELL
"This is the entrance to the Royal Museum, the finest and grandest in the
Great Underground Empire. To the south, down a few steps, is the entrance
to the Royal Puzzle and to the east, through a stone door, is the Royal
Jewel Collection. A wooden door to the north is ">
		      <TELL <COND (<FSET? ,WOODEN-DOOR ,OPENBIT> "open")
		                  (T "closed")> "
and leads to the Museum of Technology. ">
		      <COND (<==? ,YEAR ,YEAR-PRESENT>
			     <TELL
"To the west is a great iron door, rusted shut. To its left, however, is a
cleft in the rock providing an exit from the museum." CR>)
			    (<L? ,YEAR ,YEAR-PRESENT>
			     <TELL
"To the west is a great iron door, rusted shut." CR>)
			    (T
			     <TELL
"To the west is a great iron door, rusted shut. The cleft in the rock,
present when you started, has filled in with rubble." CR>)>)>)>>

<GLOBAL TM-YEAR 948>

<ROUTINE TIME-MACHINE-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<TELL
"Directly in front of you is a large golden machine, which has a seat with a
console in front. On the console is a single button and a dial connected to
a three-digit display which reads " N ,TM-YEAR
". The machine is surprisingly shiny and shows few signs of age." CR>)
	       (<==? .RARG ,M-BEG>
		<COND (<VERB? MOVE>
		       <TELL
"You might be able to move the machine by pushing it." CR>)
		      (<AND <VERB? PUSH-TO>
			    <==? ,PRSO ,TIME-MACHINE>>
		       <TELL
"That would be a good trick from inside it." CR>)
		      (<VERB? WALK>
		       <TELL
"You're not going anywhere in this heap." CR>)
		      (<AND <VERB? TAKE PUT MOVE PUSH OPEN CLOSE>
			    <NOT <HELD? ,PRSO>>
			    <NOT <IN? ,PRSO ,TIME-MACHINE>>>
		       <TELL
"You can't do that from inside the machine." CR>)>)
	       (<NOT .RARG>
		<COND (<AND <VERB? PUT> <==? ,PRSI ,TIME-MACHINE>>
		       <TELL
"You can't put anything on or inside the machine itself." CR>)
		      (<==? ,PRSO ,TIME-MACHINE>
		       <COND (<VERB? OPEN CLOSE>
			      <TELL "This is a machine, not a box." CR>)
			     (<VERB? EXAMINE>
			      <TELL
"The machine consists of a seat and a console containing one small button
and a dial connected to a display which reads " N ,TM-YEAR "." CR>)
			     (<AND <VERB? BOARD> <FIRST? ,TM-SEAT>>
			      <TELL
"That will be somewhat uncomfortable!" CR>)
			     (<VERB? TAKE RAISE>
			      <TELL
"The machine must weigh hundreds of pounds and cannot be carried." CR>)
			     (<VERB? PUSH MOVE>
			      <TELL
"You should specify in which direction to push the machine." CR>)
			     (<VERB? PUSH-TO>
			      <COND (<NOT <==? <DO-WALK ,P-DIRECTION>
					       ,M-FATAL>>
				     <TELL
"With some effort, you push the machine into the room with you." CR>
				     <COND (<EQUAL? ,HERE
						    ,CP-ANTE ,MID-CP-ANTE>
					    <TELL
"However, the machine seems to have sustained some damage as a result
of going over the stairs." CR>
					    <SETG MACHINE-DAMAGED T>)
					   (<==? ,HERE ,MUSEUM-ANTE>
					    <TELL
"Pushing the machine through the cleft seems to have damaged it." CR>
					    <SETG MACHINE-DAMAGED T>)>
				     <MOVE ,TIME-MACHINE ,HERE>)>
			      <RTRUE>)>)>)>>

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
"You experience a period of disorientation. The area around you seems
to be solidifying! Rock formations close in on you and you become
engulfed in stone!">)
		      (<==? ,YEAR ,TM-YEAR>
		       <TELL "Nothing seems to have happened." CR>)
		      (<L? ,TM-YEAR ,YEAR-CLOSED>
		       <TELL
"You experience a brief period of disorientation. When your vision returns, ">
		       <COND (<EQUAL? ,HERE ,MUSEUM-ENTRANCE
				      ,MID-MUSEUM-ENTRANCE
				      ,OLD-MUSEUM-ENTRANCE>
			      <COND (<==? ,TM-YEAR ,YEAR-CAGED>
				     <TELL
"you are surrounded by a number of heavily armed guards, the dress and
speech of which seem strange and unfamiliar. A commotion starts at a door
to the east and a person with a flat head, wearing a gaudy crown and a purple
robe, bursts into the room." CR>
				     <FLATHEAD-SENTENCE>)
				    (T
				     <GUARDS-KILL>)>)
			     (<EQUAL? ,HERE ,JEWEL-ROOM ,MID-JEWEL-ROOM
				            ,OLD-JEWEL-ROOM>
			      <COND (<==? ,TM-YEAR ,YEAR-CAGED>
				     <TELL
"you find yourself in the middle of some kind of ceremony, with a strange
flat-headed man wearing royal vestments about to break a bottle on the bars
of an iron cage containing magnificent jewels. He appears pleased
by your presence. ">
				     <FLATHEAD-SENTENCE>)
				    (<G? ,TM-YEAR ,YEAR-CAGED>
				     <GUARDS-KILL>)
				    (T
				     <TELL ,SURROUNDINGS-CHANGED CR>
				     <TGOTO ,OLD-JEWEL-ROOM>)>)
			     (<EQUAL? ,HERE ,TECH-MUSEUM ,MID-TECH-MUSEUM
				            ,OLD-TECH-MUSEUM>
			      <COND (<NOT <==? ,TM-YEAR ,YEAR-BUILT>>
				     <GUARDS-KILL>)
				    (T
				     <TELL ,SURROUNDINGS-CHANGED CR>
				     <TGOTO ,OLD-TECH-MUSEUM>)>)>)
		      (T
		       <HAPPY-NEW-YEAR>)>)>>

<GLOBAL SURROUNDINGS-CHANGED
"your surroundings appear to have changed. From outside the door
you hear the sounds of guards talking.">

<ROUTINE HAPPY-NEW-YEAR ()
	 <TELL
"You experience a brief period of disorientation. When your vision returns,
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
"You start to feel light-headed and quickly become completely disoriented.
When your head clears, you realize that your surroundings have changed." CR>
	 <TGOTO ,SNAP-LOC T>>

<ROUTINE MOVE-JEWELS ()
	 <COND (<==? ,TM-YEAR ,YEAR-BUILT>
		<MOVE ,PEDESTAL ,OLD-JEWEL-ROOM>)
	       (<L? ,TM-YEAR ,YEAR-PRESENT>
		<MOVE ,PEDESTAL ,MID-JEWEL-ROOM>)
	       (T
		<MOVE ,PEDESTAL ,JEWEL-ROOM>)>
	 <COND (,RING-STOLEN <RTRUE>)>
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
		       ;<FSET ,PEDESTAL ,INVISIBLE>
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

<GLOBAL GUARD-KILLERS <LTABLE 0
"you are surrounded by heavily armed guards who seem awed by your presence.
One, whose IQ might be 15, aims a strange waffle-like
instrument in your direction and all goes black."
"you are confronted with many particularly stupid-looking
people dressed in peculiar uniforms and pointing waffle-like objects in
your direction. One twists his waffle and you slump
to the ground, dead."
"you see a row of military people who, if appearances do not
deceive, have the cumulative intelligence of an unripe grapefruit. One
of them aims a waffle-shaped implement in your direction and you become numb
and then paralyzed and then dead.">>

<ROUTINE FLATHEAD-SENTENCE ()
	 <REALLY-DEAD "He speaks loudly, nearly deafening the poor civil
servant whose duty it is to see that his wishes are carried out. \"Aha! A
thief! Didn't I tell you that we needed more security! But, no! You all
said my idea to build the museum under two miles of mountain and surrounded
by five hundred feet of steel was impractical! Now, what to do with this ...
intruder? I have it! We'll build a tremendous fortress on the highest mountain
peak, with one narrow ladder stretching thousands of feet to the pinnacle.
There he will stay for the rest of his life!\" His brow-beaten assistant
hesitates. \"Don't you think, Your Lordship, that your plan is a bit, well,
a bit much?\" Flathead gives it a second's thought. \"No, not really.\" he
says, and you are led away. A few years later, your prison is finished. You
are taken there, and spend the rest of your life in misery.">>

<ROUTINE REALLY-DEAD (STR)
	 <TELL .STR "|
|
****  You have died  ****|
|
">
	 <FINISH>>

<GLOBAL FLATHEAD-HEARD <>>

<GLOBAL RING-STOLEN <>>
<GLOBAL CLUMSY-ROBBERY <>>
<GLOBAL MYSTERY <>>

<GLOBAL GUARDS-PRESENT T>

<ROUTINE HEAR-FLATHEAD ()
	 <SETG FLATHEAD-HEARD T>
	 <TELL
"One particularly loud and grating voice can be heard above the
others outside the room. \"Very nice! Very nice! Not enough security, but
very nice! Now, Lord Feepness, pay attention! I've been thinking that what
we need is a dam, a tremendous dam to control the Frigid River, with
thousands of gates. We shall call it ... Flood Control Dam #2. No, not
quite right. Aha! Flood Control Dam #3.\" \"Pardon me, my Lord, but wouldn't
that be just a tad excessive?\" \"Nonsense! Now, let me tell you my idea for
hollowing out volcanoes...\" With that, the voices trail out nothingness." CR>>

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
		       <TELL ,HEAR-VOICES CR>)>
		<RTRUE>)
	       (<==? .RARG ,M-LOOK>
		<COND (<==? ,HERE ,OLD-TECH-MUSEUM>
		       <TELL
"You are in a large, unfinished room, probably intended to be a
part of the Royal Museum." CR>)
		      (T
		       <TELL
"This appears to be an unfinished entranceway to the Royal Museum. There are
doors to the east and north, and a blind stairway to the south. A heavy iron
door to the west is closed and locked." CR>)>
		<COND (,GUARDS-PRESENT
		       <TELL ,HEAR-VOICES CR>)>
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
You shut the door quickly, realizing that you would be killed
in an instant if you left the room." CR>)
	       (<AND <==? .RARG ,M-BEG> ,GUARDS-PRESENT <PROB 3>>
		<GUARD-CAUGHT>)>>

<GLOBAL HEAR-VOICES
"Through the door you can hear voices which, from their
sound, belong to military or police personnel.">

<ROUTINE I-GUARDS-LEAVE ()
	 <SETG GUARDS-PRESENT <>>
	 <TELL
"You hear, from outside the door, guards marching away, their voices fading.
After a few moments, a booming crash signals the close of what must be a
tremendous door. Then there is silence." CR>>

<ROUTINE GUARD-CAUGHT ()
	 <REALLY-DEAD
"A particularly vicious-looking guard enters the room and sees you.
He grinds his teeth unpleasantly, pulls a waffle out of his
garment, and vaporizes you with a flick of his finger.">>

<OBJECT ROBOT
	(IN LOCAL-GLOBALS)
	(DESC "robot")
	(SYNONYM ROBOT DEVICE)
	(ACTION ROBOT-F)>

<ROUTINE ROBOT-F ()
	 <COND (<VERB? FOLLOW>
		<TELL "It moved quickly and left the door closed." CR>)
	       (T <TELL "There is no robot here." CR>)>>

<ROUTINE JEWEL-ROOM-F (RARG)
	 <COND (<AND <==? .RARG ,M-END>
		     <IN? ,TIME-MACHINE ,HERE>
		     <PROB 4>>
		<TELL
"An odd robot-like device glides in, dusting the floor as it moves. Its
head gyrates briefly as it scans the machine. \"Shame. Shame,\"
it says, rather tinnily. \"Someone has been tampering with the machines
again.\" Six beady mechanical eyes focus on you as the robot picks up the
gold machine. \"Hands off, adventurer!\" it says as it leaves the
room, closing the door behind it." CR>
		<FCLEAR ,JEWEL-DOOR ,OPENBIT>
		<FCLEAR ,WOODEN-DOOR ,OPENBIT>
		<MOVE ,TIME-MACHINE ,TECH-MUSEUM>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"You are in a high-ceilinged chamber">
		<COND (<NOT <FSET? ,CAGE ,INVISIBLE>>
		       <TELL " in the middle of which
sits a tall, round steel cage, which is securely locked. In the
middle of the cage is a pedestal on which sit the Crown Jewels
of the Great Underground Empire: a sceptre, a jewelled knife, and a golden
ring. A small bronze plaque, now tarnished, is on the cage." CR>)
		      (T
		       <TELL " in the middle of which is a bare
pedestal. The room is unfinished with no
indication of its purpose. A small plaque is fastened to a wall." CR>)>)>>

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
"This is an exhibit of Empire technology. A wooden door to the
south is " ,WOODEN-DOOR ".">)
		      (T
		       <DDESC
"This is a large hall which hosted the technological exhibits of the
Great Underground Empire. A door to the south is "
,WOODEN-DOOR ".">)>)>>
		      
<ROUTINE PLAQUE-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (,RING-STOLEN
		       <TELL
"The plaque explains that this room was to be the home of the Crown Jewels
of the Empire. However, following the unexplained disappearance of a
priceless ring during the final stages of construction, Lord Flathead
decided to place the remaining jewels in a safer location.
Interestingly, he placed his most prized possesion, an incredibly gaudy
crown, in a locked safe in a volcano specifically hollowed out for that
purpose." CR>
		       <RTRUE>)>
		<FIXED-FONT-ON>
		<TELL
"|
         Crown Jewels|
|
  Presented To The Royal Museum|
      By His Gracious Lord|
|
        DIMWIT FLATHEAD|
|
          Dedicated|
         * 777 GUE *">
		<FIXED-FONT-OFF>
		<COND (,CLUMSY-ROBBERY
		       <TELL CR CR
"Underneath the plaque, in small lettering, is a description of a clumsy
attempt to steal the jewels using a time machine from the Technological
Museum which the curators were surprised to discover was not a nonworking
model. After the attempt, the machine was removed from the exhibit.">)
		      (,MYSTERY
		       <TELL CR CR
"Underneath the plaque, in small lettering, is a description of
a mysterious happening during the final stages of construction of
the Museum, in which some of the crown jewels were found displaced
from their proper positions. Fortunately, nothing was missing.
The mystery was never solved and the museum was opened despite the objections
of Lord Flathead that security was too lax.">)>
		<CRLF>
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
you. They seem to be in heated debate on the topic of
">
		<TELL <PICK-ONE ,BLATHER> "." CR>)
	       (T <TELL "Are you hearing things now?" CR>)>>

<GLOBAL BLATHER
	<LTABLE 0
		"wage scales for guards"
		"the excessive nature of the Royal Government"
		"the soon to be constructed Royal Puzzle"
		"the proper way to execute trespassers"
		"torturing thieves"
		"the banishment of the Wizard of Frobozz">>

<ROUTINE MUSEUM-PIECES ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<==? ,DESC-OBJECT ,SPINNER>
		       <RTRUE>)>
		<TELL
"A strange grey machine, shaped somewhat like a clothes dryer, is on one side
of the room. On the other side of the hall is a powerful-looking black
machine, a tight tangle of wires, pipes, and motors.|
A plaque is mounted near the door.">
		<COND (<L? ,YEAR ,YEAR-CLOSED>
		       <TELL
" The grey machine, it turns out, is a Frobozz
Magic Pressurizer, used in the coal mines of the Empire. The black machine is
a Frobozz Magic Room Spinner. The golden machine is referred to as a
Temporizer. All are nonworking models donated by Frobozzco president John
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
"The plaque merely identifies the machines and names their donor. They are
nonworking models of existing state-of-the-art machinery." CR>)
		      (T <TELL "The words cannot be made out." CR>)>)>>

<ROUTINE PEDESTAL-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<COND (<FIRST? ,PEDESTAL>
		       <TELL
"The Royal Jewels are on the pedestal." CR>)>)
	       (<AND <VERB? PUT PUT-ON TAKE> <NOT <FSET? ,CAGE ,INVISIBLE>>>
		<TELL "You can't reach it through the cage." CR>)>>

\

"old SHADOW.ZIL"

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
hills. Paths to the east and southeast reenter the rock.")
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
		       <TELL <PICK-ONE ,P-HITS> CR>
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
		      (T <TELL <PICK-ONE ,P-MISSES> CR>)>)>>

<GLOBAL P-HITS <LTABLE 0
"A good parry! Your sword wounds the hooded figure!"
"A quick stroke catches the hooded figure off guard! Blood trickles
down the figure's arm!"
"The hooded figure is hit with a quick slash!">>

<GLOBAL P-MISSES <LTABLE 0
"Your move was not quick enough and misses the mark."
"A quick stroke, but the hooded figure is on guard."
"A good stroke, but it's too slow."
"A good slash, but it misses by a mile."
"You charge, but the hooded figure jumps nimbly aside.">>

<GLOBAL S-HITS <LTABLE 0
"The hooded figure catches you off guard and wounds you!"
"You are wounded by a lightning thrust!"
"Your quick reflexes cannot stop the hooded figure's stroke! You are hit!">>

<ROUTINE I-SHADOW-REPLY ()
	 <COND (<OR <NOT ,ATTACK-MODE> <NOT <IN? ,SHADOW ,HERE>>>
                <QUEUE I-SHADOW-REPLY 0>
		<SETG ATTACK-MODE <>>
		<RFALSE>)>
	 <COND (<NOT <IN? ,SWORD ,WINNER>>
		<MOVE ,SWORD ,WINNER>
		<TELL
"Your sword, glowing wildly, leaps into your hand!" CR>)>
	 <COND (<AND <PROB <+ <* ,S-STRENGTH 10> 10>> <G? ,S-STRENGTH 1>>
		<COND (<PROB 90>
		       <COND (<L? <SETG P-STRENGTH <- ,P-STRENGTH 1>> 1>
			      <SETG P-STRENGTH 1>
			      <TELL
"The hooded figure swings its sword and sends yours flying to the ground.
Although you are defenseless, the figure reaches for your sword and hands it
back to you, nodding grimly." CR>)
			     (T
			      <TELL <PICK-ONE ,S-HITS> CR>)>)
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
		<TELL <PICK-ONE ,S-MISSES> CR>)>>

<GLOBAL S-MISSES <LTABLE 0
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
      (ACTION CLIFF-BASE-F)
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
      (FLAGS RLANDBIT NONLANDBIT ONBIT)
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
      (FLAGS RLANDBIT NONLANDBIT ONBIT)
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
	       (T <TELL <PICK-ONE ,MAN-WAITS> CR>)>>

<ROUTINE CLIFF-BASE-F (RARG)
	 <COND (<AND <==? .RARG ,M-ENTER>
		     ,CHEST-TIED>
		<SETG CHEST-TIED <>>
		<SETG ROPE-FLAG <>>
		<QUEUE I-MAN-APPEARS 0>)>>

<GLOBAL MAN-WAITS <LTABLE 0
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
		      (T
		       <TELL
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
after me saving you like that!\"" CR>)
	       (<AND ,MAN-GONE <IN? ,VALUABLES ,MAN>>
		<TELL
"What valuables?" CR>)>>

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
"It's unlikely you'll succeed at this distance." CR>)
	       (<AND <VERB? THROW> <==? ,PRSI ,GLOBAL-MAN> <IN? ,PRSO ,WINNER>>
		<TELL
"The " D ,PRSO " flies upward, but not nearly far enough to hit the man. It
does seem to amuse him, however, especially as it passes within inches of
your head. \"We're wasting time now. Be a good fellow and tie the rope!\"" CR>
		<MOVE ,PRSO ,HERE>)>>

<ROUTINE LAKE-F ()
	 <COND (<VERB? THROUGH LEAP BOARD>
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
	       (<AND <VERB? SPRAY PUT-ON> <==? ,PRSO ,REPELLENT>>
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
		<TELL <PICK-ONE ,KEY-DESCS> CR>
		<TELL
"Strange, though. The key seems to change shape constantly." CR>)>>

<GLOBAL KEY-DESCS <LTABLE 0
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
fewer to return. There is a heavy surf and a breeze is blowing onshore.
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


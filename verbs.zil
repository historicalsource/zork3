"VERBS3 for
		  ZORK III: The Dungeon Master
	Copyright 1982 Infocom, Inc.  All Rights Reserved.
"

"SUBTITLE DESCRIBE THE UNIVERSE"

"SUBTITLE SETTINGS FOR VARIOUS LEVELS OF DESCRIPTION"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

\

"SUBTITLE DESCRIBERS"

;<ROUTINE V-RNAME ()
	 <TELL D ,HERE CR>>

;<ROUTINE V-OBJECTS ()
	 <DESCRIBE-OBJECTS T>>

;<ROUTINE V-ROOM ()
	 <DESCRIBE-ROOM T>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF> <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (ELSE
		<TELL "I see nothing special about the "
		      D ,PRSO "." CR>)>>

<GLOBAL LIT <>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL
"It is pitch black.">
		<COND (<NOT ,SPRAYED?>
		       <TELL " You are likely to be eaten by a grue.">)>
		<CRLF>
		<COND (<==? ,HERE ,DARK-2>
		       <TELL
"The ground continues to slope upwards away from the lake. You can barely
detect a dim light from the east." CR>)>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS> <TELL D ,HERE CR>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,WINNER>>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in the " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <==? ,HERE .AV>> <FSET .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (ELSE
		<TELL "I can't see anything in the dark." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There is a " D .OBJ " here.">)
	       (ELSE
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL "A " D .OBJ>
		<COND (<FSET? .OBJ ,WEARBIT> <TELL " (being worn)">)>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? AV STR (PV? <>) (INV? <>))
	 #DECL ((OBJ) OBJECT (LEVEL) FIX)
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND (<NOT .Y> <RETURN <NOT .1ST?>>)
			      (<==? .Y .AV> <SET PV? T>)
			      (<==? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<==? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ
			     " is:" CR>)
		      (ELSE
		       <TELL "The " D .OBJ
			     " contains:" CR>)>)>>

\

"SUBTITLE SCORING"

<GLOBAL MOVES 0>
<GLOBAL SCORE 0>
<GLOBAL BASE-SCORE 0>

<GLOBAL WON-FLAG <>>

<GLOBAL SCORE-MAX 7>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your potential is " N ,SCORE>
	 <TELL " of a possible " N ,SCORE-MAX ", in ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " move.">) (ELSE <TELL " moves.">)>
	 <CRLF>
	 ,SCORE>

<ROUTINE FINISH ()
	 <V-SCORE>
	 <QUIT>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 #DECL ((ASK?) <OR ATOM <PRIMTYPE LIST>> (SCOR) FIX)
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL
"Do you wish to leave the game? (Y is affirmative): ">
			 <YES?>>
		    <NOT .ASK?>>
		<QUIT>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL
"ZORK III: The Dungeon Master|
Infocom interactive fiction - a fantasy story|
Copyright 1982, 1983, 1984 by Infocom, Inc.  All rights reserved.|
ZORK is a registered trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<ROUTINE IN-HERE? (OBJ)
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>

<ROUTINE V-AGAIN ("AUX" OBJ)
	 <COND (<==? ,L-PRSA ,V?WALK>
		<PERFORM ,L-PRSA ,L-PRSO>)
	       (T
		<SET OBJ
		     <COND (<AND ,L-PRSO <NOT <LOC ,L-PRSO>>>
			    ,L-PRSO)
			   (<AND ,L-PRSI <NOT <LOC ,L-PRSO>>>
			    ,L-PRSI)>>
		<COND (.OBJ
		       <TELL "I can't see the " D .OBJ " anymore." CR>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

\

"SUBTITLE DEATH AND TRANSFIGURATION"

<GLOBAL DEAD <>>
<GLOBAL DEATHS 0>
<GLOBAL LUCKY 1>

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
		 <MOVE .F <PICK-ONE ,DEAD-OBJ-LOCS>>>>

<GLOBAL DEAD-OBJ-LOCS
	<LTABLE JUNCTION CLEARING DAMP-PASSAGE CREEPY-CRAWL TIGHT-SQUEEZE
		FOGGY-ROOM DEAD-END>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-MAN-LEAVES>>
	 <DISABLE <INT I-MAN-RETURNS>>
	 <DISABLE <INT I-VIEW-SNAP>>
	 <DISABLE <INT I-FOLIN>>
	 <RTRUE>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Use directions for movement here." CR>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "You can't launch that by saying \"launch\"!" CR>)
	       (T <TELL "How in blazes does one launch that?" CR>)>>

<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 #DECL ((TBL) TABLE (VAL) ANY)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<GOTO .VAL>)>>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 #DECL ((ITM) ANY (TBL) TABLE (CNT LEN) FIX)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<==? <GET .TBL .CNT> .ITM>
			<COND (<==? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 #DECL ((PT) <OR FALSE TABLE> (PTS) FIX (STR) <OR STRING FALSE>
		(OBJ) OBJECT (RM) <OR FALSE OBJECT>)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<==? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<==? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (<AND <==? ,HERE ,CP> ,CP-MOVED> <RTRUE>)
			     (T
			      <RFATAL>)>)
		      (<==? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFATAL>)>)
		      (<==? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT> <PROB 90>>
		<COND (,SPRAYED?
		       <TELL
"There are odd noises in the darkness, and there is no exit in that
direction." CR>
		       <RFATAL>)
		      (<EQUAL? ,HERE ,DARK-1 ,DARK-2>
		       <JIGS-UP
"Oh, no! You have walked into a den of hungry grues and it's dinner time!">)
		      (T
		       <JIGS-UP
"Oh, no! You have walked into the slavering fangs of a lurking grue!">)>)
	       (T
		<TELL "You can't go that way." CR>
		<RFATAL>)>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 <SETG P-IT-LOC ,HERE>>

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>>

<GLOBAL INDENTS
	<TABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

\

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are already wearing it." CR>)
		      (T <TELL "You already have it." CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "You can't reach that." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<NOT <==? ,PRSI <LOC ,PRSO>>>
		       <TELL "The " D ,PRSO " isn't in the " D ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<==? ,PRSO <LOC ,WINNER>> <TELL "You are in it, loser!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<==? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are now wearing the " D ,PRSO "." CR>)
		      (T <TELL "Taken." CR>)>)>>

<GLOBAL FUMBLE-NUMBER 7>
<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL
", especially in light of your condition.">)
			     (ELSE <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<SET OBJ <FIRST? ,WINNER>>
		<REPEAT ()
			<SET OBJ <NEXT? .OBJ>>
			<COND (<NOT <FSET? .OBJ ,WEARBIT>>
			       <RETURN>)>>
		;"This must go!  Chomping compiler strikes again"
		<TELL "Oh, no. The " D .OBJ
		      " slips from your arms while taking the "
		      D ,PRSO "
and both tumble to the ground." CR>
		<PERFORM ,V?DROP .OBJ>
		<RFATAL>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<RTRUE>)>>

<ROUTINE V-PUT-ON ()
	 <COND (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T <TELL "There's no good surface on the " D ,PRSI "." CR>)>>

<ROUTINE PRE-PUT ()
	 <COND (<==? ,PRSO ,SHORT-POLE> <RFALSE>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "I can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "The " D ,PRSI " isn't open." CR>)
	       (<==? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "The " D ,PRSO " is already in the " D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE PRE-DROP ()
	 <COND (<==? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have it." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE HELD? (OBJ)
	 <COND (<IN? .OBJ ,WINNER> <RTRUE>)
	       (<IN? .OBJ ,ROOMS> <RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS> <RFALSE>)
	       (<EQUAL? .OBJ 0> <RFALSE>)
	       (T <HELD? <LOC .OBJ>>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,VICBIT>>
		<TELL "You can't give a " D ,PRSO " to a " D ,PRSI "!" CR>)
	       (T <TELL "The " D ,PRSI " refuses it politely." CR>)>>

<ROUTINE V-SGIVE ()
	 <TELL "Foo!" CR>>

<ROUTINE V-DROP () <COND (<IDROP> <TELL "Dropped." CR>)>>

<ROUTINE V-THROW () <COND (<IDROP> <TELL "Thrown." CR>)>>

<ROUTINE IDROP
	 ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>> <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "You're not carrying the " D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "The " D ,PRSO " is closed." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

\

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL "You must tell me how to do that to a " D ,PRSO "." CR>)
	       (<NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL "It is already open." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "The " D ,PRSO " opens." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening the " D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <TELL "The " D ,PRSO " opens." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T <TELL "The " D ,PRSO " fails to open." CR>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T))
	 #DECL ((OBJ) OBJECT (F N) <OR FALSE OBJECT>)
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<TELL "a " D .F>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>>

<ROUTINE V-CLOSE ()
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL "You must tell me how to do that to a " D ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T <TELL "It is already closed." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The " D ,PRSO " is now closed." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T <TELL "It is already closed." CR>)>)
	       (ELSE
		<TELL "You cannot close that." CR>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

"WEIGHT:  Get sum of SIZEs of supplied object, recursing to the nth level."

<ROUTINE WEIGHT
	 (OBJ "AUX" CONT (WT 0))
	 #DECL ((OBJ) OBJECT (CONT) <OR FALSE OBJECT> (WT) FIX)
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <==? .OBJ ,PLAYER> <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

<ROUTINE V-BUG ()
	 <TELL
"If there is a problem here, it is unintentional. You may report
your problem to the address provided in your documentation." CR>>

<GLOBAL COPR-NOTICE
" a transcript of interaction with ZORK III.|
ZORK is a trademark of Infocom, Inc.|
Copyright (c) 1982 Infocom, Inc. All rights reserved.|">

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" ,COPR-NOTICE CR>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE PRE-MOVE
	 ()
	 <COND (<HELD? ,PRSO> <TELL "I don't juggle objects!" CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving the " D ,PRSO " reveals nothing." CR>)
	       (T <TELL "You can't move the " D ,PRSO "." CR>)>>

<ROUTINE V-LAMP-ON
	 ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT> <TELL "It is already on." CR>)
		      (ELSE
		       <FSET ,PRSO ,ONBIT>
		       <TELL "The " D ,PRSO " is now on." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (T
		<TELL "You can't turn that on." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-OFF
	 ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL "It is already off." CR>)
		      (ELSE
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL "The " D ,PRSO " is now off." CR>
		       <COND (<NOT <SETG LIT <LIT? ,HERE>>>
			      <TELL "It is now pitch black." CR>)>)>)
	       (ELSE <TELL "You can't turn that off." CR>)>
	 <RTRUE>>

<ROUTINE V-$WAIT ()
	 <COND (<==? ,PRSO ,INTNUM> <V-WAIT <- ,P-NUMBER 1>>)
	       (T <TELL "No." CR>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 #DECL ((NUM) FIX)
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <RETURN>)>
		 <SETG MOVES <+ ,MOVES 1>>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE PRE-BOARD
	 ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<==? ,PRSO ,WATER-CHANNEL> <RFALSE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in the " D .AV "!" CR>)
		      (T <RFALSE>)>)
	       (T
		<TELL "I suppose you have a theory on boarding a "
		      D
		      ,PRSO
		      "." CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD
	 ("AUX" AV)
	 #DECL ((AV) OBJECT)
	 <TELL "You are now in the " D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-DISEMBARK
	 ()
	 <COND (<NOT <==? <LOC ,WINNER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<TELL "You are on your own feet again." CR>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
"You realize that getting out here would be fatal." CR>
		<RFATAL>)>>

<ROUTINE V-BLAST ()
	 <TELL "You can't blast anything by using words." CR>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT)
	 #DECL ((RM WLOC) OBJECT (LB) <OR ATOM FALSE> (AV) <OR FALSE FIX>)
	 <SET OLIT ,LIT>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND (<OR <AND <NOT .LB> <OR <NOT .AV> <NOT <FSET? .RM .AV>>>>
		    <AND <FSET? ,HERE ,RLANDBIT>
			 .LB
			 .AV
			 <NOT <==? .AV ,RLANDBIT>>
			 <NOT <FSET? .RM .AV>>>>
		<COND (.AV <TELL "You can't go there in a " D .WLOC ".">)
		      (T <TELL "You can't go there without a vehicle.">)>
		<CRLF>
		<RFALSE>)
	       (<FSET? .RM ,RMUNGBIT> <TELL <GETP .RM ,P?LDESC> CR> <RFALSE>)
	       (T
		<COND (.AV <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 85>>
		       <COND (,SPRAYED?
			      <TELL
"There are sinister gurgling noises in the darkness all around you!" CR>)
			     (<EQUAL? ,HERE ,DARK-1 ,DARK-2>
			      <JIGS-UP
"Oh, no! Dozens of lurking grues attack and devour you! You must have
stumbled into an authentic grue lair!">)
			     (ELSE
			      <JIGS-UP
"Oh, no! A lurking grue slithered into the room and devoured you!">
			      <RTRUE>)>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<COND (<NOT <==? ,HERE .RM>> <RTRUE>)
		      (<NOT <==? ,ADVENTURER ,WINNER>>
		       <TELL "The " D ,WINNER " leaves the room." CR>)
		      (.V? <V-FIRST-LOOK>)>
		<RTRUE>)>>

<ROUTINE V-BACK
	 ()
	 <TELL
"Sorry, my memory is poor. Please give a direction." CR>>

<ROUTINE PRE-POUR-ON ()
	 <TELL "You can't pour that on anything." CR>>

<ROUTINE V-POUR-ON () <TELL "Foo!" CR>>

<ROUTINE V-SPRAY () <V-SQUEEZE>>
<ROUTINE V-SSPRAY () <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-SQUEEZE
	 ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "The " D ,PRSO " does not understand this.">)
	       (ELSE <TELL "How singularly useless.">)>
	 <CRLF>>

<ROUTINE PRE-OIL ()
	 <TELL "You probably put spinach in your gas tank, too." CR>>

<ROUTINE V-OIL () <TELL "That's not very useful." CR>>

<ROUTINE PRE-FILL
	 ("AUX" T)
	 #DECL ((T) <OR FALSE TABLE>)
	 <COND (<AND <NOT ,PRSI> <SET T <GETPT ,HERE ,P?GLOBAL>>>
		<COND (<ZMEMQB ,GLOBAL-WATER .T <PTSIZE .T>>
		       <SETG PRSI ,GLOBAL-WATER>
		       <RFALSE>)
		      (T
		       <TELL "There is nothing to fill it with." CR>
		       <RTRUE>)>)>
	 <COND (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>)
		      (T
		       <TELL "There's nothing to fill it with." CR>)>)
	       (T <TELL "You may know how to do that, but I don't." CR>)>>

<ROUTINE V-ADVENT () <TELL "A hollow voice says \"Fool.\"" CR>>

<ROUTINE V-DRINK ()
	 <V-EAT>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 #DECL ((NOBJ) <OR OBJECT FALSE> (EAT? DRINK?) <OR ATOM FALSE>)
	 <COND (<AND <SET EAT? <FSET? ,PRSO ,FOODBIT>> <IN? ,PRSO ,WINNER>>
		<COND (<VERB? DRINK> <TELL "How can I drink that?">)
		      (ELSE
		       <TELL "Thank you very much. It really hit the spot.">
		       <REMOVE ,PRSO>)>
		<CRLF>)
	       (<SET DRINK? <FSET? ,PRSO ,DRINKBIT>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <AND <SET NOBJ <LOC ,PRSO>>
				<IN? .NOBJ ,WINNER>
				<FSET? .NOBJ ,OPENBIT>>>
		       <TELL
"Thank you very much. I was rather thirsty (from all this talking,
probably)." CR>
		       <REMOVE ,PRSO>)
		      (T <TELL 
"I'd like to, but it's in a closed container." CR>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL "I don't think that the "
		      D
		      ,PRSO
		      " would agree with you." CR>)>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,VILLAIN>
		       <TELL "Insults of this nature won't help you." CR>)
		      (T
		       <TELL "What a loony!" CR>)>)
	       (T
		<TELL
"Such language in a high-class establishment like this!" CR>)>>

<ROUTINE V-LISTEN ()
	 <TELL "The " D ,PRSO " makes no sound." CR>>

<ROUTINE V-FOLLOW ()
	 <TELL "You're nuts!" CR>>

<ROUTINE V-STAY ()
	 <TELL "You will be lost without me!" CR>>

<ROUTINE V-PRAY ()
	 <TELL "If you pray enough, your prayers may be answered." CR>>

<ROUTINE V-LEAP
	 ("AUX" T S)
	 #DECL ((T) <OR FALSE TABLE>)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,VILLAIN>
			      <TELL "The "
				    D
				    ,PRSO
				    " is too big to jump over." CR>)
			     (T <V-SKIP>)>)
		      (T <TELL "That would be a good trick." CR>)>)
	       (<SET T <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .T>>
		<COND (<OR <==? .S 2>					 ;NEXIT
			   <AND <==? .S 4>				 ;CEXIT
				<NOT <VALUE <GETB .T 1>>>>>
		       <TELL
"This was not a very safe place to try jumping." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      (T <V-SKIP>)>)
	       (ELSE <V-SKIP>)>>

<ROUTINE V-SKIP () <TELL <PICK-ONE ,WHEEEEE> CR>>

<ROUTINE V-LEAVE () <DO-WALK ,P?OUT>>

<GLOBAL HS 0>

<ROUTINE V-HELLO
	 ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,VILLAIN>
		       <TELL "The "
			     D
			     ,PRSO
			     " bows his head to you in greeting." CR>)
		      (ELSE
		       <TELL
"I think that only schizophrenics say \"Hello\" to a "
			     D
			     ,PRSO
			     "." CR>)>)
	       (ELSE <TELL <PICK-ONE ,HELLOS> CR>)>>

<GLOBAL HELLOS
	<LTABLE "Hello."
	       "Nice weather we've been having lately."
	       "Goodbye.">>

<GLOBAL WHEEEEE
	<LTABLE "Very good. Now you can go to the second grade."
	       "Are you enjoying yourself?"
	       "Wheeeeeeeeee!!!!!"
	       "Do you expect me to applaud?">>

<GLOBAL JUMPLOSS
	<LTABLE "You should have looked before you leaped."
	       "I'm afraid that leap was a bit much for your weak frame."
	       "In the movies, your life would be passing before your eyes."
	       "Geronimo...">>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT> <TELL "It is impossible to read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through a " D ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "How can I read a " D ,PRSO "?" CR>)
	       (ELSE <TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-LOOK-UNDER () <TELL "There is nothing but dust there." CR>>

<ROUTINE V-LOOK-BEHIND () <TELL "There is nothing behind the " D ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE
	 ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The "
			     D
			     ,PRSO
			     " is open.">)
		      (ELSE <TELL "The " D ,PRSO " is closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "There is nothing special to be seen." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO> <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (<FSET? ,PRSO ,SURFACEBIT>
			      <TELL "There is nothing on the " D ,PRSO "." CR>)
			     (T
			      <TELL "The " D ,PRSO " is empty." CR>)>)
		      (ELSE <TELL "The " D ,PRSO " is closed." CR>)>)
	       (ELSE <TELL "I don't know how to look inside a " D ,PRSO "." CR>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE V-REPENT () <TELL "It could very well be too late!" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<FLAMING? ,PRSI> <RFALSE>)
	       (T <TELL "With a " D ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND (<FSET? ,PRSO ,BURNBIT>
		<COND (<IN? ,PRSO ,WINNER>
		       <REMOVE ,PRSO>
		       <TELL "The " D ,PRSO " catches fire." CR>
		       <JIGS-UP
"Unfortunately, you were holding it at the time.">)
		      (T
		       <REMOVE ,PRSO>
		       <TELL "The " D ,PRSO
" catches fire and is consumed." CR>)
		      (ELSE <TELL "You don't have that." CR>)>)
	       (T <TELL "I don't think you can burn a " D ,PRSO "." CR>)>>

<ROUTINE PRE-TURN ()
	 <COND (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "You can't turn that!" CR>)>>

<ROUTINE V-TURN () <TELL "This has no effect." CR>>

<ROUTINE V-PUMP ()
	 <TELL "I really don't see how." CR>>

<ROUTINE V-INFLATE () <TELL "How can you inflate that?" CR>>

<ROUTINE V-DEFLATE () <TELL "Come on, now!" CR>>

<ROUTINE V-LOCK () <TELL "It doesn't seem to work." CR>>

<ROUTINE V-PICK () <TELL "You can't pick that." CR>>

<ROUTINE V-UNLOCK () <V-LOCK>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<PERFORM ,V?KILL ,PRSO ,PRSI>)
	       (<AND <FSET? ,PRSO ,BURNBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<REMOVE ,PRSO>
		<TELL "Your skillful "
		      D
		      ,PRSI
		      "smanship slices the "
		      D
		      ,PRSO
		      " into innumerable slivers which blow away."
		      CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"I doubt that the \"cutting edge\" of a " D ,PRSI " is adequate." CR>)
	       (T
		<TELL "Strange concept, cutting the " D ,PRSO "...." CR>)>>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 #DECL ((STR) STRING)
	 <COND (<NOT ,PRSO> <TELL "There is nothing here to " .STR "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,VILLAIN>>
		     <NOT <FSET? ,PRSO ,VICBIT>>>
		<TELL "I've known strange people, but fighting a "
		      D
		      ,PRSO
		      "?" CR>)
	       (<OR <NOT ,PRSI> <==? ,PRSI ,HANDS>>
		<TELL "Trying to "
		      .STR
		      " a "
		      D
		      ,PRSO
		      " with your bare hands is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "You aren't even holding the " D ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to "
		      .STR
		      " the "
		      D
		      ,PRSO
		      " with a "
		      D
		      ,PRSI
		      " is suicidal." CR>)
	       (ELSE <TELL "You can't." CR>)>>

<ROUTINE V-ATTACK () <IKILL "attack">>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T <PERFORM ,V?ATTACK ,PRSI ,PRSO>)>>

<ROUTINE V-KICK () <HACK-HACK "Kicking the ">>

<ROUTINE V-WAVE () <HACK-HACK "Waving the ">>

<ROUTINE V-RAISE () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-LOWER () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-RUB () <HACK-HACK "Fiddling with the ">>

<ROUTINE V-PUSH () <HACK-HACK "Pushing the ">>

<ROUTINE V-PUSH-TO () <TELL "You can't push things to that." CR>>

<ROUTINE PRE-MUNG ()
	 <COND (<==? ,PRSO ,BEAM> <RFALSE>)
	       (<NOT <FSET? ,PRSO ,VICBIT>>
		<HACK-HACK "Trying to destroy the ">)
	       (<NOT ,PRSI>
		<TELL "Trying to destroy the "
		      D
		      ,PRSO
		      " with your bare hands is suicidal." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to destroy the "
		      D
		      ,PRSO
		      " with a "
		      D
		      ,PRSI
		      " is quite self-destructive." CR>)>>

<ROUTINE V-MUNG () <TELL "You can't." CR>>

<ROUTINE HACK-HACK
	 (STR)
	 #DECL ((STR) STRING)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS> <VERB? WAVE RAISE LOWER>>
		<TELL "The " D ,PRSO " isn't here!" CR>)
	       (T <TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 " doesn't seem to work."
	 " isn't notably helpful."
	 " has no effect.">>

<ROUTINE WORD-TYPE
	 (OBJ WORD "AUX" SYNS)
	 #DECL ((OBJ) OBJECT (WORD SYNS) TABLE)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE V-KNOCK
	 ()
	 <COND (<WORD-TYPE ,PRSO ,W?DOOR>
		<TELL "I don't think that anybody's home." CR>)
	       (ELSE <TELL "Why knock on a " D ,PRSO "?" CR>)>>

<ROUTINE V-CHOMP ()
	 <TELL "I don't know how to do that. I win in all cases!" CR>>

<ROUTINE V-FROBOZZ
	 ()
	 <TELL
"The FROBOZZ Corporation created, owns, and operates this dungeon." CR>>

<ROUTINE V-WIN () <TELL "Naturally!" CR>>

<ROUTINE V-YELL () <TELL "Aarrrrrgggggghhhhhhhhh!" CR>>

<ROUTINE V-PLUG () <TELL "This has no effect." CR>>

<ROUTINE V-EXORCISE () <TELL "What a bizarre concept!" CR>>

\

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "This seems to have no effect." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
		     <FIRST? ,PRSO>>
		<TELL "It sounds like there is something inside the "
		      D
		      ,PRSO
		      "."
		      CR>)
	       (<AND <FSET? ,PRSO ,OPENBIT> <FIRST? ,PRSO>>
		<TELL "Shaking the " D ,PRSO " isn't very useful." CR>)
	       (T <TELL "Shaking the " D ,PRSO " proves uninteresting." CR>)>>

<ROUTINE PRE-DIG
	 ()
	 <COND (<NOT ,PRSI> <SETG PRSI ,HANDS>)>
	 <COND (<FSET? ,PRSI ,TOOLBIT> <RFALSE>)
	       (ELSE
		<TELL "Digging with the " D ,PRSI " is very silly." CR>)>>

<ROUTINE V-DIG () <TELL "The ground is too hard here." CR>>

<ROUTINE V-SMELL () <TELL "It smells just like a " D ,PRSO "." CR>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" T)
	 #DECL ((OBJ1 OBJ2) OBJECT (T) <OR FALSE TABLE>)
	 <COND (<SET T <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .T <- <PTSIZE .T> 1>>)>>

<ROUTINE V-SWIM ()
	 <COND (<EQUAL? ,HERE ,ON-LAKE ,IN-LAKE>
		<TELL "What do you think you're doing?" CR>)
	       (<==? ,HERE ,FLATHEAD-OCEAN>
		<TELL
"Between the rocks and waves, you wouldn't last a minute!" CR>)
	       (T <TELL "Go jump in a lake!" CR>)>>

<ROUTINE V-UNTIE () <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE PRE-TIE
	 ()
	 <COND (<==? ,PRSI ,WINNER>
		<TELL "You can't tie it to yourself." CR>)>>

<ROUTINE V-TIE () <TELL "You can't tie the " D ,PRSO " to that." CR>>

<ROUTINE V-TIE-UP () <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-MELT () <TELL "I'm not sure that a " D ,PRSO " can be melted." CR>>

<ROUTINE V-MUMBLE
	 ()
	 <TELL "You'll have to speak up if you expect me to hear you!" CR>>

<ROUTINE V-ALARM ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "He's wide awake, or haven't you noticed..." CR>)
	       (ELSE
		<TELL "The " D ,PRSO " isn't sleeping." CR>)>>

<ROUTINE V-ZORK () <TELL "At your service!" CR>>

\

<ROUTINE MUNG-ROOM (RM STR)
	 #DECL ((STR) STRING)
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "The " D ,PRSO " pays no attention." CR>)
	       (ELSE
		<TELL "You cannot talk to that!" CR>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<V-CLIMB-UP ,P?UP T>)
	       (T
		<TELL "You can't climb onto the " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-FOO ()
	 <V-CLIMB-UP <COND (<EQUAL? ,PRSO ,ROPE ,GLOBAL-ROPE> ,P?DOWN)
			   (T ,P?UP)> T>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X)
	 #DECL ((DIR) FIX (OBJ) <OR ATOM FALSE> (X) TABLE)
	 <COND (<GETPT ,HERE .DIR>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<NOT .OBJ>
		<TELL "You can't go that way." CR>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Climbing the walls is to no avail." CR>)
	       (ELSE <TELL "Bizarre!" CR>)>>

<ROUTINE V-CLIMB-DOWN () <V-CLIMB-UP ,P?DOWN>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "Why would you send for the " D ,PRSO "?" CR>)
	       (ELSE <TELL "That doesn't make sends." CR>)>>

<ROUTINE V-WIND ()
	 <TELL "You cannot wind up a " D ,PRSO "." CR>>

<ROUTINE V-COUNT ("AUX" OBJS CNT)
    #DECL ((CNT) FIX)
    <COND (<==? ,PRSO ,BLESSINGS>
	   <TELL "Well, for one, you are playing ZORK..." CR>)
	  (T
	   <TELL "You have lost your mind." CR>)>>

<ROUTINE V-PUT-UNDER ()
         <TELL "You can't do that." CR>>

<ROUTINE V-PLAY ()
         <COND (<FSET? ,PRSO ,VILLAIN>
	        <TELL
"You are so engrossed in the role of the " D ,PRSO " that
you kill yourself, just as he would have done!" CR>
	        <JIGS-UP "">)
	       (T <TELL "How peculiar!" CR>)>>

<ROUTINE V-MAKE ()
    	<TELL "You can't do that." CR>>

<ROUTINE V-ENTER ()
	 <DO-WALK ,P?IN>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-CROSS ()
	 <TELL "You can't cross that!" CR>>

<ROUTINE V-SEARCH ()
	 <TELL "You find nothing unusual." CR>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS>
		<TELL
"Within six feet of your head, assuming you haven't left that
somewhere." CR>)
	       (<==? ,PRSO ,ME>
		<TELL "You're around here somewhere..." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "You find it." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <==? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "It's right here." CR>)
	       (<FSET? .L ,VILLAIN>
		<TELL "The " D .L " has it." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's in the " D .L "." CR>)
	       (ELSE
		<TELL "Beats me." CR>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL "The " D ,PRSO
" pauses for a moment, perhaps thinking that you should re-read
the manual." CR>)>)
	       (T
		<TELL "You can't talk to the " D ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that the " D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-IS-IN ()
	 <COND (<IN? ,PRSO ,PRSI>
		<TELL "Yes, it is ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T <TELL "in">)>
		<TELL " the " D ,PRSI "." CR>)
	       (T <TELL "No, it isn't." CR>)>>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a pig." CR>>

<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W> <RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT> <RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RETURN <>>)>>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<AND <FSET? ,FRONT-DOOR ,TOUCHBIT>
		     <==? <GET ,P-LEXV ,P-CONT> ,W?FROTZ>
		     <==? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?OZMOO>>
		<SETG P-CONT <>>
		<COND (<==? ,HERE ,MSTAIRS>
		       <CRLF>
		       <GOTO ,FRONT-DOOR>)
		      (T
		       <TELL "Nothing happens." CR>)>)
	       (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address the " D .V " directly." CR>)
	       (<==? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (ELSE
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>)>>

<ROUTINE V-INCANT ()
	 <TELL
"The incantation echoes back faintly, but nothing else happens." CR>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL "You hit your head against the "
			    D ,PRSO
			    " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (ELSE <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "You can't wear the " D ,PRSO "." CR>)
	       (T <PERFORM ,V?TAKE ,PRSO> <RTRUE>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "You can't throw anything off of that!" CR>>

<ROUTINE V-$VERIFY ()
	 <TELL "Verifying game..." CR>
	 <COND (<VERIFY> <TELL "Game correct." CR>)
	       (T <TELL CR "** Game File Failure **" CR>)>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (ELSE
		<TELL "You are already standing, I think." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "It's here!" CR>)
	       (T <TELL "You should supply a direction!" CR>)>>

;"Finds the room on the other side of a door"

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) T)
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET T <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .T> ,DEXIT>
				    <EQUAL? <GETB .T ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE V-DRINK-FROM ()
	 <TELL "How peculiar!" CR>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Are you so tired?" CR>>
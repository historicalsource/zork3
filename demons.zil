"DEMONS for
		     Zork III: The Dungeon Master 
		 The Great Underground Empire (Part 3)
	(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.
"

"SWORD demon"

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) P T L)
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<AND <==? ,HERE ,CLIFF> <NOT ,MAN-GONE>> <SET NG 1>)
		      (<AND <==? ,HERE ,CLIFF-LEDGE> ,MAN-FLAG> <SET NG 1>)
		      (<INFESTED? ,HERE> <SET NG 2>)
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

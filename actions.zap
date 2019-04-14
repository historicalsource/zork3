

	.FUNCT	SWORD-FCN
	ZERO?	SWORD-IN-STONE? /?ELS5
	EQUAL?	PRSA,V?MOVE,V?TAKE \FALSE
	RANDOM	100
	GRTR?	10,STACK \?ELS16
	PRINTR	"Who do you think you are? Arthur?"
?ELS16:	PRINTR	"The sword is deeply imbedded within the rock. You can't even begin to budge it."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	WINNER,ADVENTURER \FALSE
	CALL	QUEUE,I-SWORD,-1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	LANTERN
	EQUAL?	PRSA,V?THROW \?ELS5
	PRINTI	"The lamp has smashed into the floor, and the light has gone out."
	CRLF	
	CALL	INT,I-LANTERN
	PUT	STACK,0,0
	REMOVE	LAMP
	SET	'CURRENT-LAMP,BROKEN-LAMP
	MOVE	BROKEN-LAMP,HERE
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LAMP-ON \?ELS9
	FSET?	LAMP,LIGHTBIT /?ELS14
	PRINTR	"A burned-out lamp won't light."
?ELS14:	CALL	INT,I-LANTERN
	PUT	STACK,0,1
	RFALSE	
?ELS9:	EQUAL?	PRSA,V?LAMP-OFF \?ELS20
	FSET?	LAMP,LIGHTBIT /?ELS25
	PRINTR	"The lamp has already burned out."
?ELS25:	CALL	INT,I-LANTERN
	PUT	STACK,0,0
	RFALSE	
?ELS20:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	LAMP,LIGHTBIT /?ELS34
	PRINTI	"The lamp has burned out."
	JUMP	?CND32
?ELS34:	FSET?	LAMP,ONBIT \?ELS38
	PRINTI	"The lamp is on."
	JUMP	?CND32
?ELS38:	PRINTI	"The lamp is turned off."
?CND32:	CRLF	
	RTRUE	


	.FUNCT	I-LANTERN,TICK,TBL
	VALUE	'LAMP-TABLE >TBL
	GET	TBL,0 >TICK
	CALL	QUEUE,I-LANTERN,TICK
	PUT	STACK,0,1
	CALL	LIGHT-INT,LAMP,TBL,TICK
	ZERO?	TICK /TRUE
	ADD	TBL,4 >LAMP-TABLE
	RTRUE	


	.FUNCT	LIGHT-INT,OBJ,TBL,TICK
	ZERO?	TICK \?CND1
	FCLEAR	OBJ,LIGHTBIT
	FCLEAR	OBJ,ONBIT
?CND1:	CALL	HELD?,OBJ
	ZERO?	STACK \?THN9
	IN?	OBJ,HERE \FALSE
?THN9:	ZERO?	TICK \?ELS15
	PRINTI	"You'd better have more light than from the "
	PRINTD	OBJ
	PRINTR	"."
?ELS15:	GET	TBL,1
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	CRETIN
	EQUAL?	PRSA,V?GIVE \?ELS5
	CALL	PERFORM,V?TAKE,PRSO
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EAT \?ELS7
	PRINTR	"Auto-cannibalism is not the answer."
?ELS7:	EQUAL?	PRSA,V?MUNG,V?KILL \?ELS11
	CALL	JIGS-UP,STR?65
	RSTACK	
?ELS11:	EQUAL?	PRSA,V?TAKE \?ELS13
	PRINTR	"How romantic!"
?ELS13:	EQUAL?	PRSA,V?DISEMBARK \?ELS17
	PRINTR	"You'll have to do that on your own."
?ELS17:	EQUAL?	PRSA,V?EXAMINE \?ELS21
	PRINTR	"That's difficult unless your eyes are prehensile."
?ELS21:	EQUAL?	PRSA,V?MAKE \FALSE
	PRINTR	"Only you can do that."


	.FUNCT	CHASM-FCN
	EQUAL?	PRSA,V?LEAP /?THN6
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSO,ME \?ELS5
?THN6:	PRINTR	"You look before leaping and realize you would never survive."
?ELS5:	EQUAL?	PRSA,V?CROSS \?ELS13
	PRINTR	"You'll have to find a bridge."
?ELS13:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" drops out of sight into the chasm."
	CRLF	
	REMOVE	PRSO
	RTRUE	


	.FUNCT	PATH-OBJECT
	EQUAL?	PRSA,V?FOLLOW,V?TAKE \?ELS5
	PRINTR	"You must specify a direction to go."
?ELS5:	EQUAL?	PRSA,V?FIND \FALSE
	PRINTR	"I can't help you there...."


	.FUNCT	TUNNEL-OBJECT
	EQUAL?	PRSA,V?THROUGH \?ELS5
	GETP	HERE,P?IN
	ZERO?	STACK /?ELS5
	CALL	DO-WALK,P?IN
	RTRUE	
?ELS5:	CALL	PATH-OBJECT
	RSTACK	


	.FUNCT	GROUND-FCN
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSI,GROUND \?ELS5
	CALL	PERFORM,V?DROP,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?DIG \FALSE
	PRINTR	"The ground is too hard for digging here."


	.FUNCT	GRUE-FUNCTION
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The grue is a sinister, lurking presence in the dark places of the earth. Its favorite diet is adventurers, but its insatiable appetite is tempered by its fear of light. No grue has ever been seen by the light of day, and few have survived its fearsome jaws to tell the tale."
?ELS5:	EQUAL?	PRSA,V?FIND \?ELS9
	PRINTR	"There is no grue here, but I'm sure there is at least one lurking in the darkness nearby. I wouldn't let my light go out if I were you!"
?ELS9:	EQUAL?	PRSA,V?LISTEN \FALSE
	PRINTR	"It makes no sound but is always lurking in the darkness nearby."


	.FUNCT	CPEXIT,FX,NFX,?TMP1
	SET	'CP-MOVED,FALSE-VALUE
	EQUAL?	PRSO,P?UP \?ELS5
	EQUAL?	CPHERE,1 \?ELS10
	GET	CPTABLE,2
	EQUAL?	STACK,-2 \?ELS15
	PRINTI	"With the help of the ladder, you exit the puzzle."
	CRLF	
	RETURN	CP-ANTE
?ELS15:	PRINTI	"The exit is too far above your head."
	CRLF	
	RFALSE	
?ELS10:	PRINTI	"There is no way up."
	CRLF	
	RFALSE	
?ELS5:	EQUAL?	CPHERE,33 \?ELS27
	EQUAL?	PRSO,P?WEST \?ELS27
	ZERO?	CP-FLAG /?ELS27
	FCLEAR	CP,TOUCHBIT
	RETURN	CP-OUT
?ELS27:	EQUAL?	PRSO,P?DOWN \?ELS31
	PRINTI	"There's no way down here."
	CRLF	
	RFALSE	
?ELS31:	EQUAL?	CPHERE,33 \?ELS35
	EQUAL?	PRSO,P?WEST \?ELS35
	PRINTI	"The metal door bars the way."
	CRLF	
	RFALSE	
?ELS35:	CALL	LKP,PRSO,CPEXITS >FX
	ADD	FX,CPHERE >NFX
	GRTR?	NFX,36 /?THN45
	LESS?	NFX,0 /?THN45
	CALL	ILLCP,CPHERE,FX
	ZERO?	STACK /?ELS44
?THN45:	PRINTI	"There is a wall there."
	CRLF	
	RFALSE	
?ELS44:	LESS?	FX,0 \?ELS55
	SUB	0,FX
	JUMP	?CND51
?ELS55:	PUSH	FX
?CND51:	EQUAL?	STACK,1,6 \?ELS50
	CALL	CPMOVE,FX
	RFALSE	
?ELS50:	GRTR?	FX,0 \?ELS59
	ADD	CPHERE,6
	GET	CPTABLE,STACK >?TMP1
	SUB	FX,6
	ADD	CPHERE,STACK
	GET	CPTABLE,STACK
	EQUAL?	0,?TMP1,STACK \?ELS59
	CALL	CPMOVE,FX
	RFALSE	
?ELS59:	LESS?	FX,0 \?ELS63
	SUB	CPHERE,6
	GET	CPTABLE,STACK >?TMP1
	ADD	CPHERE,6
	ADD	STACK,FX >STACK
	GET	CPTABLE,STACK
	EQUAL?	0,?TMP1,STACK \?ELS63
	CALL	CPMOVE,FX
	RFALSE	
?ELS63:	PRINTI	"There is a wall there."
	CRLF	
	RFALSE	


	.FUNCT	ILLCP,ONE,TWO
	MOD	ONE,6
	ZERO?	STACK \?ELS5
	EQUAL?	TWO,MINUS-FIVE,1,7 /TRUE
?ELS5:	MOD	ONE,6
	EQUAL?	STACK,1 \?ELS9
	EQUAL?	TWO,MINUS-SEVEN,MINUS-ONE,5 /TRUE
?ELS9:	LESS?	ONE,7 \?ELS13
	LESS?	TWO,MINUS-FOUR /TRUE
?ELS13:	GRTR?	ONE,30 \FALSE
	GRTR?	TWO,4 /TRUE
	RFALSE


	.FUNCT	CPMOVE,FX
	ADD	CPHERE,FX >FX
	GET	CPTABLE,FX
	ZERO?	STACK \?ELS5
	CALL	CPGOTO,FX
	RSTACK	
?ELS5:	PRINTR	"There is a wall there."


	.FUNCT	CPENTER
	EQUAL?	YEAR,YEAR-PRESENT \?THN6
	ZERO?	CPBLOCK-FLAG /?ELS5
?THN6:	PRINTI	"The hole is blocked by sandstone."
	CRLF	
	RFALSE	
?ELS5:	SET	'CPHERE,1
	RETURN	CP


	.FUNCT	CPANT-ROOM,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a small square room, in the middle of which is a perfectly round hole"
	ZERO?	CPBLOCK-FLAG \?THN13
	EQUAL?	YEAR,YEAR-PRESENT /?ELS12
?THN13:	PRINTR	" which is blocked by smooth sandstone."
?ELS12:	PRINTR	" through which you can discern the floor some ten feet below. The place under the hole is dark, but it appears to be completely enclosed in rock. In any event, it doesn't seem likely that you could climb back up. Exits are west and, up a few steps, north."


	.FUNCT	CPLADDER-OBJECT,FLG=0
	SUB	CPHERE,1
	GET	CPTABLE,STACK
	EQUAL?	STACK,-3 /?THN6
	ADD	CPHERE,1
	GET	CPTABLE,STACK
	EQUAL?	STACK,-2 \?ELS5
	SET	'FLG,TRUE-VALUE
	ZERO?	FLG /?ELS5
?THN6:	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \?ELS14
	ZERO?	FLG /?ELS19
	EQUAL?	CPHERE,1 \?ELS19
	SET	'CPSOLVE-FLAG,TRUE-VALUE
	CALL	GOTO,CP-ANTE
	RSTACK	
?ELS19:	PRINTR	"You hit your head on the ceiling and fall off the ladder."
?ELS14:	PRINTR	"Come, come!"
?ELS5:	PRINTR	"I can't see any ladder here."


	.FUNCT	CPWALL-OBJECT,WL,NWL,NXT,NNXT,CNT,TOP,SNAP=0
	EQUAL?	PRSA,V?MOVE \?ELS5
	PRINTR	"You can't grab the wall to pull it."
?ELS5:	EQUAL?	PRSA,V?PUSH \FALSE
	CALL	CPNEXT,CPHERE,PRSO >NXT
	ZERO?	NXT \?CND10
	PRINTR	"The wall doesn't budge."
?CND10:	GET	CPTABLE,NXT >WL
	ZERO?	WL \?ELS19
	PRINTR	"There is only a passage in that direction."
?ELS19:	EQUAL?	WL,1 \?ELS23
	PRINTR	"The wall doesn't budge."
?ELS23:	CALL	CPNEXT,NXT,PRSO >NNXT
	ZERO?	NNXT \?ELS27
	PRINTR	"The wall barely gives."
?ELS27:	GET	CPTABLE,NNXT >NWL
	ZERO?	NWL /?ELS31
	PRINTR	"The wall barely gives."
?ELS31:	PRINTI	"The wall slides forward and you follow it"
	ZERO?	CPPUSH-FLAG /?ELS40
	PRINTI	" to this position:"
	CRLF	
	JUMP	?CND38
?ELS40:	INC	'SCORE
	PRINTI	"....
The architecture of this region is getting complex, so that further descriptions will be diagrams of the immediate vicinity in a 3x3 grid. The walls here are rock, but of two different types - sandstone and marble. The following notations will be used:
"
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"
  .. = your position (middle of grid)
  MM  = marble wall
  SS  = sandstone wall
  ??  = unknown (blocked by walls)

"
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
?CND38:	SET	'CPPUSH-FLAG,TRUE-VALUE
	PUT	CPTABLE,NXT,0
	PUT	CPTABLE,NNXT,WL
	ZERO?	NNXT /?CND50
	SUB	NNXT,1
	MUL	8,STACK >TOP
	GET	CPOBJS,TOP >CNT
?PRG53:	ZERO?	CNT \?ELS57
	JUMP	?CND50
?ELS57:	INC	'TOP
	GET	CPOBJS,TOP
	MOVE	STACK,CP-OUT
	ZERO?	SNAP \?CND60
	SET	'SNAP,TRUE-VALUE
	PRINTI	"You hear a soft ""snap"" from behind the wall you were pushing."
	CRLF	
?CND60:	DEC	'CNT
	JUMP	?PRG53
?CND50:	EQUAL?	NNXT,1 \?CND65
	SET	'CPBLOCK-FLAG,TRUE-VALUE
?CND65:	CALL	CPGOTO,NXT
	RSTACK	


	.FUNCT	CPGOTO,FX,F,X,CNT,TOP
	SET	'CP-MOVED,TRUE-VALUE
	FCLEAR	HERE,TOUCHBIT
	SUB	CPHERE,1
	MUL	8,STACK >TOP
	ADD	TOP,1 >CNT
	FIRST?	CP >F /?KLU22
?KLU22:	
?PRG1:	NEXT?	F >X /?KLU23
?KLU23:	ZERO?	F \?ELS5
	JUMP	?REP2
?ELS5:	EQUAL?	F,ADVENTURER \?ELS7
	JUMP	?CND3
?ELS7:	PUT	CPOBJS,CNT,F
	REMOVE	F
	INC	'CNT
?CND3:	ZERO?	X \?ELS12
	JUMP	?REP2
?ELS12:	SET	'F,X
	JUMP	?PRG1
?REP2:	SUB	CNT,TOP
	SUB	STACK,1
	PUT	CPOBJS,TOP,STACK
	SET	'CPHERE,FX
	SUB	CPHERE,1
	MUL	8,STACK >TOP
	GET	CPOBJS,TOP >CNT
?PRG15:	ZERO?	CNT \?ELS19
	JUMP	?REP16
?ELS19:	INC	'TOP
	GET	CPOBJS,TOP
	MOVE	STACK,CP
	DEC	'CNT
	JUMP	?PRG15
?REP16:	CALL	PERFORM,V?LOOK
	RTRUE	


	.FUNCT	CPNEXT,RM,OBJ,FX
	CALL	LKP,OBJ,CPWALLS >FX
	CALL	ILLCP,RM,FX
	ZERO?	STACK \FALSE
	ADD	RM,FX
	RSTACK	


	.FUNCT	CPDOOR-F
	EQUAL?	HERE,CP \?ELS5
	EQUAL?	CPHERE,33 /?ELS5
	PRINTR	"I can't see any steel door here."
?ELS5:	EQUAL?	PRSA,V?OPEN \?ELS11
	ZERO?	CP-FLAG /?ELS16
	PRINTR	"The steel door has already opened."
?ELS16:	PRINTR	"You can't force it open."
?ELS11:	EQUAL?	PRSA,V?CLOSE \?ELS25
	ZERO?	CP-FLAG /?ELS30
	PRINTR	"There doesn't seem to be any way to close it."
?ELS30:	PRINTR	"Do you think it isn't already?"
?ELS25:	EQUAL?	PRSA,V?MUNG \?ELS39
	PRINTR	"The door is, to a first approximation, indestructible."
?ELS39:	EQUAL?	PRSA,V?KNOCK \FALSE
	PRINTR	"Besides a great amount of reverberation, nothing happens."


	.FUNCT	CP-ROOM,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	EQUAL?	PRSO,P?DOWN \?ELS10
	PUSH	1
	JUMP	?CND6
?ELS10:	PUSH	33
?CND6:	SET	'CPHERE,STACK
	RETURN	CPHERE
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	CPPUSH-FLAG /?ELS19
	CALL	CPWHERE
	RSTACK	
?ELS19:	PRINTR	"You are in a small square room bounded to the north and west with marble walls and to the east and south with sandstone walls."


	.FUNCT	CPNS,NUM
	GRTR?	NUM,36 /TRUE
	LESS?	NUM,1 /TRUE
	GET	CPTABLE,NUM
	RSTACK	


	.FUNCT	CPEW,NUM,FOO
	MOD	NUM,6
	EQUAL?	STACK,FOO /TRUE
	GET	CPTABLE,NUM
	RSTACK	


	.FUNCT	CPWHERE,N,S,E,W
	ADD	CPHERE,-6
	CALL	CPNS,STACK >N
	ADD	CPHERE,6
	CALL	CPNS,STACK >S
	ADD	CPHERE,1
	CALL	CPEW,STACK,1 >E
	ADD	CPHERE,-1
	CALL	CPEW,STACK,0 >W
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"      +"
	CALL	CP-CORNER,MINUS-SEVEN,N,W
	PRINTI	" "
	CALL	CP-ORTHO,N
	PRINTI	" "
	CALL	CP-CORNER,MINUS-FIVE,N,E
	PRINTI	"+"
	CRLF	
	PRINTI	"West  +"
	CALL	CP-ORTHO,W
	PRINTI	" .. "
	CALL	CP-ORTHO,E
	PRINTI	"+  East"
	CRLF	
	PRINTI	"      +"
	CALL	CP-CORNER,5,S,W
	PRINTI	" "
	CALL	CP-ORTHO,S
	PRINTI	" "
	CALL	CP-CORNER,7,S,E
	PRINTI	"+"
	CRLF	
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	EQUAL?	CPHERE,1 \?ELS25
	PRINTI	"In the ceiling above you is a large circular opening."
	CRLF	
	JUMP	?CND23
?ELS25:	EQUAL?	CPHERE,22 \?ELS29
	PRINTI	"The center of the floor here is noticeably depressed."
	CRLF	
	JUMP	?CND23
?ELS29:	EQUAL?	CPHERE,33 \?CND23
	PRINTI	"In the center of the west wall is a steel door which is "
	ZERO?	CP-FLAG /?ELS38
	PRINTI	"open"
	JUMP	?CND36
?ELS38:	PRINTI	"closed"
?CND36:	PRINTI	". On one side of the door is a narrow slot."
	CRLF	
?CND23:	EQUAL?	E,-2 \?CND48
	PRINTI	"There is a ladder here, firmly attached to the east wall."
	CRLF	
?CND48:	EQUAL?	W,-3 \FALSE
	PRINTR	"There is a ladder here, firmly attached to the west wall."


	.FUNCT	CP-ORTHO,CONTENTS
	ZERO?	CONTENTS \?ELS5
	PRINTI	"  "
	RTRUE	
?ELS5:	EQUAL?	CONTENTS,1 \?ELS9
	PRINTI	"MM"
	RTRUE	
?ELS9:	PRINTI	"SS"
	RTRUE	


	.FUNCT	CP-CORNER,DIR,COL,ROW,LOCN
	ADD	CPHERE,DIR >LOCN
	ZERO?	COL /?ELS5
	ZERO?	ROW /?ELS5
	PRINTI	"??"
	RTRUE	
?ELS5:	CALL	ILLCP,CPHERE,DIR
	ZERO?	STACK /?ELS11
	PRINTI	"MM"
	RTRUE	
?ELS11:	LESS?	LOCN,1 /?THN21
	GRTR?	LOCN,36 \?ELS20
?THN21:	PUSH	1
	JUMP	?CND16
?ELS20:	GET	CPTABLE,LOCN
?CND16:	SET	'COL,STACK
	ZERO?	COL \?ELS15
	PRINTI	"  "
	RTRUE	
?ELS15:	EQUAL?	COL,1 \?ELS28
	PRINTI	"MM"
	RTRUE	
?ELS28:	PRINTI	"SS"
	RTRUE	


	.FUNCT	CP-SLOT-FCN
	EQUAL?	PRSA,V?PUT \FALSE
	GETP	PRSO,P?SIZE
	GRTR?	STACK,10 \?CND6
	PRINTR	"It doesn't fit."
?CND6:	REMOVE	PRSO
	EQUAL?	PRSO,LORE-BOOK \?ELS15
	SET	'CP-FLAG,TRUE-VALUE
	PRINTR	"The book drops easily into the slot and vanishes. The metal door slides open, revealing a passageway to the west, as a previously unseen sign flashes:
    ""Royal Puzzle Exit Fee Paid
          Item Confiscated"""
?ELS15:	FSET?	PRSO,VICBIT /?THN20
	FSET?	PRSO,VILLAIN \?ELS19
?THN20:	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS19:	PRINTI	"The item vanishes into the slot. A moment later, a previously unseen sign flashes ""Garbage In, Garbage Out"" and spews the "
	PRINTD	PRSO
	PRINTR	" (now atomized) through the slot."


	.FUNCT	CPOUT-ROOM,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a narrow room, lit from above. A flight of steps leads up toward the north, and a "
	ZERO?	CP-FLAG /?ELS10
	PRINTI	"passage"
	JUMP	?CND8
?ELS10:	PRINTI	"metal door"
?CND8:	PRINTR	" leads to the east."


	.FUNCT	MRGO,TORM
	EQUAL?	PRSO,P?NORTH,P?NW,P?NE \?ELS3
	CALL	LKP,HERE,R-NORTHS >TORM
	JUMP	?CND1
?ELS3:	CALL	LKP,HERE,R-SOUTHS >TORM
?CND1:	EQUAL?	PRSO,P?NORTH,P?SOUTH \?ELS10
	EQUAL?	MLOC,TORM \?ELS15
	MOD	MDIR,180
	ZERO?	STACK \?ELS20
	PRINTI	"There is a wooden wall blocking your way."
	CRLF	
	RFALSE	
?ELS20:	CALL	MIRIN,FALSE-VALUE
	ZERO?	STACK /?ELS24
	RETURN	IN-MIRROR
?ELS24:	CALL	MIRBLOCK
	RFALSE	
?ELS15:	RETURN	TORM
?ELS10:	EQUAL?	MLOC,TORM \?ELS30
	MOD	MDIR,180
	ZERO?	STACK \?ELS35
	CALL	GO-E-W,TORM
	RSTACK	
?ELS35:	CALL	MIRBLOCK
	RFALSE	
?ELS30:	RETURN	TORM


	.FUNCT	MIRBLOCK,MD
	SET	'MD,MDIR
	EQUAL?	PRSO,P?SOUTH \?CND1
	ADD	MDIR,180
	MOD	STACK,360 >MD
?CND1:	EQUAL?	MD,270 \?ELS12
	ZERO?	MR1-FLAG /?THN9
?ELS12:	EQUAL?	MD,90 \?ELS8
	ZERO?	MR2-FLAG \?ELS8
?THN9:	PRINTR	"There is a large broken mirror blocking your way."
?ELS8:	PRINTR	"There is a large mirror blocking your way."


	.FUNCT	GO-E-W,RM
	EQUAL?	PRSO,P?NE,P?SE \?ELS5
	CALL	LKP,RM,R-EASTS
	RSTACK	
?ELS5:	CALL	LKP,RM,R-WESTS
	RSTACK	


	.FUNCT	EWTELL,RM,EAST?=0,M1?=0,MWIN
	EQUAL?	RM,MRAE,MRBE,MRCE /?THN4
	EQUAL?	RM,MRGE,MRCE \?CND1
?THN4:	SET	'EAST?,TRUE-VALUE
?CND1:	ZERO?	EAST? /?ELS13
	PUSH	0
	JUMP	?CND9
?ELS13:	PUSH	180
?CND9:	ADD	MDIR,STACK
	EQUAL?	STACK,180 \?CND6
	SET	'M1?,TRUE-VALUE
?CND6:	ZERO?	M1? /?ELS19
	SET	'MWIN,MR1-FLAG
	JUMP	?CND17
?ELS19:	SET	'MWIN,MR2-FLAG
?CND17:	PRINTI	"You are in a narrow room, whose "
	ZERO?	EAST? /?ELS29
	PUSH	STR?66
	JUMP	?CND25
?ELS29:	PUSH	STR?67
?CND25:	PRINT	STACK
	PRINTI	" wall is a large "
	ZERO?	MWIN /?ELS37
	PUSH	STR?68
	JUMP	?CND33
?ELS37:	PUSH	STR?69
?CND33:	PRINT	STACK
	CRLF	
	ZERO?	M1? /?CND41
	ZERO?	MIRROR-OPEN-FLAG /?CND41
	ZERO?	MWIN /?ELS52
	PUSH	STR?70
	JUMP	?CND48
?ELS52:	PUSH	STR?71
?CND48:	PRINT	STACK
	CRLF	
?CND41:	PRINTR	"The opposite wall is solid rock."


	.FUNCT	MRDEW,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	EWTELL,HERE
	SET	'GUARDIANS-SEEN,TRUE-VALUE
	PRINTI	"Somewhat to the south"
	PRINT	GUARDSTR
	CRLF	
	RTRUE	


	.FUNCT	MRCEW,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	EWTELL,HERE
	SET	'GUARDIANS-SEEN,TRUE-VALUE
	PRINTI	"Somewhat to the north"
	PRINT	GUARDSTR
	CRLF	
	RTRUE	


	.FUNCT	MRBEW,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	EWTELL,HERE
	PRINTR	"To the north and south are large hallways."


	.FUNCT	MRAEW,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	EWTELL,HERE
	PRINTR	"To the north is a large hallway."


	.FUNCT	LOOK-TO,RMN,RMS,NORTH?=0,NTELL=0,STELL=0,MIR?,M1?=0,DIR
	EQUAL?	HERE,MREYE,FRONT-DOOR /?CND1
	PRINTI	"This is a part of the long hallway. The east and west walls are dressed stone. In the center of the hall is a shallow stone channel. In the center of the room the channel widens into a large hole around which is engraved a compass rose."
	CRLF	
?CND1:	EQUAL?	HERE,MRG \?ELS8
	SET	'GUARDIANS-SEEN,TRUE-VALUE
	PRINTI	"On either side of you are identical stone statues holding bludgeons. They appear ready to strike, though, for the moment, they remain impassive."
	CRLF	
	JUMP	?CND6
?ELS8:	EQUAL?	HERE,MRC \?ELS12
	SET	'GUARDIANS-SEEN,TRUE-VALUE
	PRINTI	"Somewhat to the north"
	PRINT	GUARDSTR
	CRLF	
	SET	'NTELL,TRUE-VALUE
	JUMP	?CND6
?ELS12:	EQUAL?	HERE,FRONT-DOOR \?ELS16
	PRINTI	"You are in a north-south hallway which ends, to the north, at a large wooden door."
	CRLF	
	SET	'NTELL,TRUE-VALUE
	JUMP	?CND6
?ELS16:	EQUAL?	HERE,MRD \?ELS20
	SET	'GUARDIANS-SEEN,TRUE-VALUE
	PRINTI	"Somewhat to the south"
	PRINT	GUARDSTR
	CRLF	
	SET	'STELL,TRUE-VALUE
	JUMP	?CND6
?ELS20:	EQUAL?	HERE,MRA \?CND6
	PRINTI	"The hallway continues to the south."
	CRLF	
	SET	'STELL,TRUE-VALUE
?CND6:	EQUAL?	MLOC,RMN,RMS \?CND27
	EQUAL?	MLOC,RMN \?ELS32
	SET	'NORTH?,TRUE-VALUE
	SET	'NTELL,TRUE-VALUE
	SET	'DIR,STR?73
	JUMP	?CND30
?ELS32:	SET	'STELL,TRUE-VALUE
	SET	'DIR,STR?74
?CND30:	ZERO?	NORTH? /?ELS39
	GRTR?	MDIR,180 \?ELS39
	LESS?	MDIR,359 \?ELS39
	SET	'M1?,TRUE-VALUE
	PUSH	MR1-FLAG
	JUMP	?CND35
?ELS39:	ZERO?	NORTH? \?ELS43
	GRTR?	MDIR,0 \?ELS43
	LESS?	MDIR,179 \?ELS43
	SET	'M1?,TRUE-VALUE
	PUSH	MR1-FLAG
	JUMP	?CND35
?ELS43:	PUSH	MR2-FLAG
?CND35:	SET	'MIR?,STACK
	MOD	MDIR,180
	ZERO?	STACK \?ELS50
	PRINTI	"The "
	PRINT	DIR
	PRINTI	"th side of the room is divided by a wooden wall into small hallways to the "
	PRINT	DIR
	PRINTI	"theast and "
	PRINT	DIR
	PRINTI	"thwest."
	CRLF	
	JUMP	?CND27
?ELS50:	ZERO?	MIR? /?ELS65
	PUSH	STR?75
	JUMP	?CND61
?ELS65:	PUSH	STR?76
?CND61:	PRINT	STACK
	PRINT	DIR
	PRINTI	"th side of the hallway."
	CRLF	
	ZERO?	M1? /?CND48
	ZERO?	MIRROR-OPEN-FLAG /?CND48
	ZERO?	MIR? /?ELS80
	PUSH	STR?70
	JUMP	?CND76
?ELS80:	PUSH	STR?71
?CND76:	PRINT	STACK
	CRLF	
?CND48:	
?CND27:	ZERO?	NTELL \?ELS86
	ZERO?	STELL \?ELS86
	PRINTR	"The corridor continues north and south."
?ELS86:	ZERO?	NTELL \?ELS92
	PRINTR	"The corridor continues north."
?ELS92:	ZERO?	STELL \TRUE
	PRINTR	"The corridor continues south."


	.FUNCT	MRDF,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LOOK-TO,FRONT-DOOR,MRG
	RSTACK	


	.FUNCT	MRCF,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LOOK-TO,MRG,MRB
	RSTACK	


	.FUNCT	MRBF,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LOOK-TO,MRC,MRA
	RSTACK	


	.FUNCT	MRAF,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LOOK-TO,MRB,FALSE-VALUE
	RSTACK	


	.FUNCT	EG-INFESTED?,R
	EQUAL?	MLOC,MRG \?ELS5
	EQUAL?	R,IN-MIRROR /?THN1
?ELS5:	EQUAL?	R,MRGE,MRG,MRGW \FALSE
	PUSH	1
?THN1:	RSTACK	


	.FUNCT	GUARDIANS,RARG=0
	EQUAL?	RARG,M-LOOK \?ELS5
	EQUAL?	HERE,MRG \?ELS10
	CALL	LOOK-TO,MRD,MRC
	RSTACK	
?ELS10:	CALL	EWTELL,HERE
	PRINTR	"To the east and west are the Guardians of Zork, in perfect symmetry. From here, it's hard to tell which of the two is a reflection!"
?ELS5:	EQUAL?	RARG,M-ENTER \?ELS16
	ZERO?	INVIS \?ELS16
	CALL	JIGS-UP,STR?77
	RSTACK	
?ELS16:	EQUAL?	RARG,M-END \FALSE
	EQUAL?	PRSA,V?EXAMINE \?ELS22
	EQUAL?	HERE,IN-MIRROR \?ELS27
	PRINTR	"You can't see them from here."
?ELS27:	PRINTR	"The guardians are quite impressive. I wouldn't get in their way if I were you!"
?ELS22:	EQUAL?	PRSA,V?THROW \?ELS35
	EQUAL?	PRSI,GUARDIAN \?ELS35
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" flies within sight of the guardians, who, in perfect unison, destroy it utterly. Satisfied, they resume their posts."
	CRLF	
	REMOVE	PRSO
	RTRUE	
?ELS35:	EQUAL?	PRSA,V?ATTACK \?ELS41
	PRINTR	"You aren't close enough to fight them and even if you were, the contest would be a bit one-sided."
?ELS41:	EQUAL?	PRSA,V?HELLO \FALSE
	PRINTR	"The statues are impassive."


	.FUNCT	MIRROR-DIR?,DIR,RM,TBL
	EQUAL?	DIR,P?NORTH \?ELS5
	PUSH	R-NORTHS
	JUMP	?CND1
?ELS5:	PUSH	R-SOUTHS
?CND1:	SET	'TBL,STACK
	GETPT	RM,DIR
	ZERO?	STACK /FALSE
	CALL	LKP,RM,TBL
	EQUAL?	MLOC,STACK \FALSE
	EQUAL?	DIR,P?NORTH \?ELS19
	GRTR?	MDIR,180 \?ELS19
	LESS?	MDIR,360 /TRUE
?ELS19:	EQUAL?	DIR,P?SOUTH \?ELS23
	GRTR?	MDIR,0 \?ELS23
	LESS?	MDIR,180 /TRUE
?ELS23:	RETURN	2


	.FUNCT	WOODEN-WALL-F
	MOD	MDIR,180
	ZERO?	STACK \?ELS5
	CALL	MIRROR-DIR?,P?NORTH,HERE
	ZERO?	STACK \?THN8
	CALL	MIRROR-DIR?,P?SOUTH,HERE
	ZERO?	STACK /?ELS5
?THN8:	EQUAL?	PRSA,V?PUSH \FALSE
	PRINTR	"The structure won't budge."
?ELS5:	PRINTR	"I can't see any wooden wall here."


	.FUNCT	MIRROR-HERE?,RM,TMP
	EQUAL?	HERE,MRAE,MRAW,MRBE /?THN6
	EQUAL?	HERE,MRBW,MRCE,MRCW /?THN6
	EQUAL?	HERE,MRGE,MRGW,MRDE /?THN6
	EQUAL?	HERE,MRDW \?ELS5
?THN6:	EQUAL?	RM,MRAE,MRBE,MRCE /?THN18
	EQUAL?	RM,MRGE,MRDE \?ELS17
?THN18:	PUSH	0
	JUMP	?CND13
?ELS17:	PUSH	180
?CND13:	ADD	MDIR,STACK
	EQUAL?	180,STACK /TRUE
	RETURN	2
?ELS5:	MOD	MDIR,180
	ZERO?	STACK /FALSE
	CALL	MIRROR-DIR?,P?NORTH,RM >TMP
	ZERO?	TMP /?ELS27
	RETURN	TMP
?ELS27:	CALL	MIRROR-DIR?,P?SOUTH,RM >TMP
	ZERO?	TMP /FALSE
	RETURN	TMP


	.FUNCT	MIRROR-FUNCTION,MIRROR
	CALL	MIRROR-HERE?,HERE >MIRROR
	ZERO?	MIRROR \?ELS5
	PRINTR	"I can't see any mirror here."
?ELS5:	EQUAL?	PRSA,V?MOVE,V?OPEN \?ELS9
	PRINTR	"I don't see a way to open the mirror here."
?ELS9:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS13
	EQUAL?	MIRROR,1 \?ELS22
	ZERO?	MR1-FLAG \?THN19
?ELS22:	ZERO?	MR2-FLAG /?ELS18
?THN19:	ZERO?	INVIS /?ELS27
	PRINTR	"Amazingly, you have no reflection!"
?ELS27:	PRINTR	"A disheveled adventurer stares back at you."
?ELS18:	PRINTR	"You have destroyed the mirror, or have you forgotten?"
?ELS13:	EQUAL?	PRSA,V?MUNG \?ELS40
	EQUAL?	MIRROR,1 \?ELS45
	ZERO?	MR1-FLAG /?ELS50
	SET	'MR1-FLAG,FALSE-VALUE
	PRINTR	"The mirror breaks, revealing a wooden panel behind it. The glistening fragments of mirror quietly sparkle into nonexistance."
?ELS50:	PRINTR	"The mirror has already been broken."
?ELS45:	ZERO?	MR2-FLAG /?ELS59
	SET	'MR2-FLAG,FALSE-VALUE
	PRINTR	"The mirror breaks, revealing a wooden panel behind it. The glistening fragments of mirror quietly sparkle into nonexistance."
?ELS59:	PRINTR	"The mirror has already been broken."
?ELS40:	EQUAL?	MIRROR,1 \?ELS72
	ZERO?	MR1-FLAG /?THN69
?ELS72:	ZERO?	MR2-FLAG \?ELS68
?THN69:	PRINTR	"There's no mirror left."
?ELS68:	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	MIRROR,1 \?ELS83
	PUSH	STR?78
	JUMP	?CND79
?ELS83:	PUSH	STR?79
?CND79:	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	PANEL-FUNCTION,MIRROR
	CALL	MIRROR-HERE?,HERE >MIRROR
	ZERO?	MIRROR \?ELS5
	PRINTR	"I can't see any panel here."
?ELS5:	EQUAL?	PRSA,V?MOVE,V?OPEN \?ELS9
	PRINTR	"I don't see a way to open the panel here."
?ELS9:	EQUAL?	PRSA,V?MUNG \?ELS13
	EQUAL?	MIRROR,1 \?ELS18
	ZERO?	MR1-FLAG /?ELS23
	PRINTR	"To break the panel you would have to break the mirror first."
?ELS23:	PRINTR	"The panel is not that easily destroyed."
?ELS18:	ZERO?	MR2-FLAG /?ELS32
	PRINTR	"To break the panel you would have to break the mirror first."
?ELS32:	PRINTR	"The panel is not that easily destroyed."
?ELS13:	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	MIRROR,1 \?ELS48
	PUSH	STR?80
	JUMP	?CND44
?ELS48:	PUSH	STR?81
?CND44:	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	MIROUT,DIR,RM
	EQUAL?	PRSO,P?OUT \?ELS3
	SET	'DIR,1
	JUMP	?CND1
?ELS3:	CALL	LKP,PRSO,DIRVEC >DIR
?CND1:	ZERO?	MIRROR-OPEN-FLAG /?ELS10
	EQUAL?	DIR,1 /?THN17
	ADD	MDIR,270
	MOD	STACK,360
	EQUAL?	STACK,DIR \FALSE
?THN17:	MOD	MDIR,180
	ZERO?	STACK \?ELS23
	CALL	MIREW
	RSTACK	
?ELS23:	LESS?	MDIR,180 /?PRD26
	PUSH	0
	JUMP	?PRD27
?PRD26:	PUSH	1
?PRD27:	CALL	MIRNS,STACK,TRUE-VALUE
	RSTACK	
?ELS10:	ZERO?	WOOD-OPEN-FLAG /?ELS31
	EQUAL?	DIR,1 /?THN38
	ADD	MDIR,180
	MOD	STACK,360
	EQUAL?	STACK,DIR \?ELS37
?THN38:	ZERO?	MDIR \?ELS42
	SET	'RM,FALSE-VALUE
	JUMP	?CND40
?ELS42:	SET	'RM,TRUE-VALUE
?CND40:	CALL	MIRNS,RM,TRUE-VALUE >RM
	ZERO?	RM /?ELS49
	PRINTI	"As you leave, the door swings shut."
	CRLF	
	SET	'WOOD-OPEN-FLAG,FALSE-VALUE
	RETURN	RM
?ELS49:	PRINTI	"You can't go that way."
	CRLF	
	RFALSE	
?ELS37:	PRINTI	"You would hit one of the panels."
	CRLF	
	RFALSE	
?ELS31:	PRINTI	"You are inside a closed box!"
	CRLF	
	RFALSE	


	.FUNCT	MIRNS,NORTH?,EXIT?=0,S,T
	ZERO?	EXIT? \?CND1
	ZERO?	NORTH? /?ELS6
	EQUAL?	MLOC,MRD /FALSE
?ELS6:	ZERO?	NORTH? \?CND1
	EQUAL?	MLOC,MRA /FALSE
?CND1:	ZERO?	NORTH? /?ELS22
	PUSH	P?NORTH
	JUMP	?CND18
?ELS22:	PUSH	P?SOUTH
?CND18:	GETPT	MLOC,STACK >T
	ZERO?	T /FALSE
	PTSIZE	T >S
	EQUAL?	S,UEXIT \?ELS30
	GETB	T,0
	RSTACK	
?ELS30:	ZERO?	NORTH? /?ELS32
	CALL	LKP,MLOC,R-NORTHS
	RSTACK	
?ELS32:	CALL	LKP,MLOC,R-SOUTHS
	RSTACK	


	.FUNCT	MIREW
	ZERO?	MDIR \?ELS5
	CALL	LKP,MLOC,R-WESTS
	RSTACK	
?ELS5:	CALL	LKP,MLOC,R-EASTS
	RSTACK	


	.FUNCT	MIRIN,VRB=1
	CALL	MIRROR-HERE?,HERE
	EQUAL?	STACK,1 \?ELS5
	ZERO?	MIRROR-OPEN-FLAG /?ELS5
	RETURN	IN-MIRROR
?ELS5:	ZERO?	VRB /FALSE
	CALL	MIRROR-HERE?,HERE
	EQUAL?	STACK,1 \?ELS11
	ZERO?	MIRROR-OPENED \?ELS16
	ZERO?	MR1-FLAG /?ELS16
	PRINTI	"A mirror blocks your way."
	CRLF	
	RFALSE	
?ELS16:	PRINTI	"The panel is closed."
	CRLF	
	RFALSE	
?ELS11:	PRINTI	"The structure blocks your way."
	CRLF	
	RFALSE	


	.FUNCT	MREYE-ROOM,RARG=0,O
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?DROP \?ELS5
	IN?	PRSO,WINNER \?ELS5
	CALL	BEAM-STOPPED?
	ZERO?	STACK \?ELS5
	MOVE	PRSO,HERE
	PRINTI	"You conveniently drop the "
	PRINTD	PRSO
	PRINTR	" in position to block the beam of light."
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in the middle of a long north-south corridor whose walls are polished stone. A narrow red beam of light crosses the room at the north end, inches above the floor."
	CRLF	
	CALL	BEAM-STOPPED? >O
	ZERO?	O /?CND14
	PRINTI	"The beam is stopped halfway across the room by a "
	PRINTD	O
	PRINTI	" lying on the floor."
	CRLF	
?CND14:	CALL	LOOK-TO,MRA,FALSE-VALUE
	RSTACK	


	.FUNCT	BEAM-STOPPED?,N
	FIRST?	MREYE >N /?KLU8
?KLU8:	
?PRG1:	EQUAL?	N,PLAYER,BEAM /?ELS5
	SET	'BEAM-BREAKER,N
	RETURN	N
?ELS5:	NEXT?	N >N /?PRG1
	RFALSE	


	.FUNCT	BEAM-FUNCTION,PRO,PRI
	EQUAL?	PRSA,V?LEAP \?ELS5
	PRINTI	"You jump over the beam and into the hallway."
	CRLF	
	CALL	GOTO,MRA
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?FOLLOW \?ELS9
	PRINTR	"It simply crosses the northern end of the room, so there's nowhere to follow it."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	PRINTI	"The red beam of light crosses the north end of the room only an inch or so above the floor."
	CALL	BEAM-STOPPED?
	ZERO?	STACK /?CND16
	PRINTI	" The beam is broken by a "
	PRINTD	BEAM-BREAKER
	PRINTI	" lying on the ground."
?CND16:	CRLF	
	RTRUE	
?ELS13:	EQUAL?	PRSA,V?MUNG,V?PUT \?ELS22
	EQUAL?	PRSA,V?PUT \?ELS25
	SET	'PRI,PRSO
	SET	'PRO,PRSI
	JUMP	?CND23
?ELS25:	SET	'PRI,PRSI
	SET	'PRO,PRSO
?CND23:	ZERO?	PRI /FALSE
	EQUAL?	PRO,BEAM \FALSE
	IN?	PRI,WINNER \?ELS36
	MOVE	PRI,HERE
	SET	'BEAM-BREAKER,PRI
	PRINTI	"The beam is now interrupted by a "
	PRINTD	PRI
	PRINTR	" lying on the floor."
?ELS36:	IN?	PRI,HERE \?ELS40
	PRINTI	"The "
	PRINTD	PRI
	PRINTR	" already breaks the beam."
?ELS40:	EQUAL?	PRI,HANDS \?ELS44
	PRINTR	"The beam is broken briefly as it passes through."
?ELS44:	PRINTI	"You're not holding the "
	PRINTD	PRI
	PRINTR	"."
?ELS22:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSO,BEAM \FALSE
	PRINTR	"No doubt you have a bottle of moonbeams as well."


	.FUNCT	MRSWITCH
	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	MRSWPUSH-FLAG /?ELS10
	PRINTR	"Click."
?ELS10:	CALL	BEAM-STOPPED?
	ZERO?	STACK /?ELS20
	PRINTI	"Click. Snap!"
	CRLF	
	CALL	QUEUE,I-MRINT,7
	PUT	STACK,0,1
	SET	'MRSWPUSH-FLAG,TRUE-VALUE
	SET	'MIRROR-OPEN-FLAG,TRUE-VALUE
	SET	'MIRROR-OPENED,TRUE-VALUE
	FCLEAR	MRA,TOUCHBIT
	RTRUE	
?ELS20:	PRINTR	"Click."


	.FUNCT	I-MRINT
	SET	'MRSWPUSH-FLAG,FALSE-VALUE
	SET	'MIRROR-OPEN-FLAG,FALSE-VALUE
	CALL	MIRROR-HERE?,HERE
	EQUAL?	STACK,1 /?THN6
	EQUAL?	HERE,IN-MIRROR \?ELS5
?THN6:	PRINTR	"The mirror quietly swings shut."
?ELS5:	EQUAL?	HERE,MR-ANTE \FALSE
	PRINTR	"The button pops back to its original position."


	.FUNCT	MAGIC-MIRROR,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are inside a rectangular box of wood whose structure is rather complicated. Four sides and the roof are filled in, and the floor is open.

As you face the side opposite the entrance, two short sides of carved and polished wood are to your left and right. The left panel is mahogany, the right pine. The wall you face is red on its left half and black on its right. On the entrance side, the wall is white opposite the red part of the wall it faces, and yellow opposite the black section. The painted walls are at least twice the length of the unpainted ones. The ceiling is painted blue.

In the floor is a stone channel about six inches wide and a foot deep. The channel is oriented in a north-south direction. In the exact center of the room the channel widens into a circular depression perhaps two feet wide. Incised in the stone around this area is a compass rose.

Running from one short wall to the other at about waist height is a wooden bar, carefully carved and drilled. This bar is pierced in two places. The first hole is in the center of the bar (and thus the center of the room). The second is at the left end of the room (as you face opposite the entrance). Through each hole runs a wooden pole.

The pole at the left end of the bar is short, extending about a foot above the bar, and ends in a hand grip. The pole "
	EQUAL?	MLOC,MRB \?ELS10
	EQUAL?	MDIR,270 \?ELS10
	ZERO?	POLEUP-FLAG /?ELS15
	PRINTI	"has been lifted out of a hole carved in the stone floor. There is evidently enough friction to keep the pole from dropping back down."
	JUMP	?CND8
?ELS15:	PRINTI	"has been dropped into a hole carved in the stone floor."
	JUMP	?CND8
?ELS10:	EQUAL?	MDIR,0,180 \?ELS23
	ZERO?	POLEUP-FLAG /?ELS26
	PRINTI	"is positioned above the stone channel in the floor."
	JUMP	?CND8
?ELS26:	PRINTI	"has been dropped into the stone channel incised in the floor."
	JUMP	?CND8
?ELS23:	PRINTI	"is resting on the stone floor."
?CND8:	PRINTI	"

The long pole at the center of the bar extends from the ceiling through the bar to the circular area in the stone channel. This bottom end of the pole has a T-bar a bit less than two feet long attached to it, and on the T-bar is carved an arrow. The arrow and T-bar are pointing "
	DIV	MDIR,45
	GET	LONGDIRS,STACK
	PRINT	STACK
	PRINTI	"."
	ZERO?	WOOD-OPEN-FLAG /?CND39
	PRINTI	"
The pine panel has been opened outward."
?CND39:	CRLF	
	RTRUE	


	.FUNCT	MPANELS,MD
	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	POLEUP-FLAG /?ELS10
	EQUAL?	MLOC,MRG \?CND11
	ZERO?	GUARDIANS-SEEN /?ELS16
	CALL	JIGS-UP,STR?77
	RTRUE	
?ELS16:	CALL	JIGS-UP,STR?88
	RTRUE	
?CND11:	EQUAL?	PRSO,RED-PANEL,YELLOW-PANEL \?ELS22
	ADD	MDIR,45
	MOD	STACK,360 >MD
	PRINTI	"The structure rotates clockwise."
	CRLF	
	JUMP	?CND20
?ELS22:	ADD	MDIR,315
	MOD	STACK,360 >MD
	PRINTI	"The structure rotates counterclockwise."
	CRLF	
?CND20:	PRINTI	"The arrow on the compass rose now indicates "
	DIV	MD,45
	GET	LONGDIRS,STACK
	PRINT	STACK
	PRINTI	"."
	CRLF	
	ZERO?	WOOD-OPEN-FLAG /?CND31
	SET	'WOOD-OPEN-FLAG,FALSE-VALUE
	PRINTI	"The pine wall closes quietly."
	CRLF	
?CND31:	SET	'MDIR,MD
	RETURN	MDIR
?ELS10:	MOD	MDIR,180
	ZERO?	STACK \?ELS38
	PRINTR	"The short pole prevents the structure from rotating."
?ELS38:	PRINTR	"The structure shakes slightly but doesn't move."


	.FUNCT	MENDS,RM
	EQUAL?	PRSA,V?CLOSE \?ELS5
	PRINTR	"You can't do that to the panel."
?ELS5:	EQUAL?	PRSA,V?PUSH /?THN10
	EQUAL?	PRSA,V?OPEN \FALSE
	EQUAL?	PRSO,PINE-PANEL \FALSE
?THN10:	MOD	MDIR,180
	ZERO?	STACK /?ELS18
	PRINTR	"The structure rocks back and forth slightly but doesn't move."
?ELS18:	EQUAL?	PRSO,MAHOGANY-PANEL \?ELS22
	LESS?	MDIR,180 /?PRD28
	PUSH	0
	JUMP	?PRD29
?PRD28:	PUSH	1
?PRD29:	CALL	MIRNS,STACK >RM
	ZERO?	RM /?ELS27
	ZERO?	MDIR /?PRD30
	PUSH	0
	JUMP	?PRD31
?PRD30:	PUSH	1
?PRD31:	CALL	MIRMOVE,STACK,RM
	RSTACK	
?ELS27:	PRINTR	"The structure has reached the end of the stone channel and won't budge."
?ELS22:	PRINTI	"The pine wall swings open."
	CRLF	
	EQUAL?	MLOC,MRD \?ELS46
	ZERO?	MDIR /?THN43
?ELS46:	EQUAL?	MLOC,MRC \?ELS48
	EQUAL?	MDIR,180 /?THN43
?ELS48:	EQUAL?	MLOC,MRG \?CND40
?THN43:	ZERO?	GUARDIANS-SEEN /?ELS51
	PRINTI	"The pine door opens into the field of view of the Guardians."
	CRLF	
	JUMP	?CND49
?ELS51:	PRINTI	"The pine door opens into the field of view of the Guardians of Zork, represented by two identical stone statues carrying bludgeons."
	CRLF	
?CND49:	CALL	JIGS-UP,STR?77
	RTRUE	
?CND40:	SET	'WOOD-OPEN-FLAG,TRUE-VALUE
	CALL	QUEUE,I-PININ,5
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-PININ
	ZERO?	WOOD-OPEN-FLAG /FALSE
	SET	'WOOD-OPEN-FLAG,FALSE-VALUE
	PRINTR	"The pine wall closes quietly."


	.FUNCT	MIRMOVE,NORTH?,RM,PU?=0,LOSE=0
	ZERO?	POLEUP-FLAG /?CND1
	SET	'PU?,TRUE-VALUE
?CND1:	ZERO?	PU? /?ELS10
	PUSH	STR?89
	JUMP	?CND6
?ELS10:	PUSH	STR?90
?CND6:	PRINT	STACK
	ZERO?	NORTH? /?ELS18
	PUSH	STR?82
	JUMP	?CND14
?ELS18:	PUSH	STR?85
?CND14:	PRINT	STACK
	PRINTI	" and stops over another compass rose."
	CRLF	
	SET	'MLOC,RM
	EQUAL?	RM,MRG \TRUE
	EQUAL?	HERE,IN-MIRROR \TRUE
	ZERO?	PU? /?ELS29
	SET	'LOSE,TRUE-VALUE
	JUMP	?CND27
?ELS29:	ZERO?	MR1-FLAG /?THN33
	ZERO?	MR2-FLAG \?ELS32
?THN33:	SET	'LOSE,TRUE-VALUE
	JUMP	?CND27
?ELS32:	ZERO?	MIRROR-OPEN-FLAG \?THN37
	ZERO?	WOOD-OPEN-FLAG /?CND27
?THN37:	SET	'LOSE,TRUE-VALUE
?CND27:	ZERO?	LOSE /TRUE
	ZERO?	GUARDIANS-SEEN /?ELS45
	CALL	JIGS-UP,STR?91
	RTRUE	
?ELS45:	CALL	JIGS-UP,STR?92
	RTRUE	


	.FUNCT	SHORT-POLE-F
	EQUAL?	PRSA,V?RAISE \?ELS5
	EQUAL?	POLEUP-FLAG,2 \?ELS10
	PRINTR	"The pole cannot be raised further."
?ELS10:	SET	'POLEUP-FLAG,2
	PRINTR	"The pole is now slightly above the floor."
?ELS5:	EQUAL?	PRSA,V?PUT \?ELS22
	EQUAL?	PRSI,CHANNEL /?THN19
?ELS22:	EQUAL?	PRSA,V?LOWER,V?PUSH \FALSE
?THN19:	ZERO?	POLEUP-FLAG \?ELS27
	PRINTR	"The pole cannot be lowered further."
?ELS27:	MOD	MDIR,180
	ZERO?	STACK \?ELS31
	PRINTI	"The pole is lowered into the channel."
	CRLF	
	SET	'POLEUP-FLAG,0
	RTRUE	
?ELS31:	EQUAL?	MDIR,270 \?ELS35
	EQUAL?	MLOC,MRB \?ELS35
	SET	'POLEUP-FLAG,0
	PRINTR	"The pole is lowered into the stone hole."
?ELS35:	EQUAL?	POLEUP-FLAG,1 \?ELS41
	PRINTR	"The pole is already resting on the floor."
?ELS41:	SET	'POLEUP-FLAG,1
	PRINTR	"The pole now rests on the stone floor."


	.FUNCT	DUNGEON-MASTER-F,RARG=0
	EQUAL?	RARG,M-OBJDESC /FALSE
	EQUAL?	WINNER,DUNGEON-MASTER \?ELS7
	EQUAL?	PRSA,V?FOLLOW \?ELS12
	IN?	DUNGEON-MASTER,HERE \?ELS17
	CALL	QUEUE,I-FOLIN,-1
	PUT	STACK,0,1
	PRINTR	"The dungeon master answers, ""I will follow."""
?ELS17:	PRINTR	"The dungeon master's voice replies, ""You must come here first!"""
?ELS12:	EQUAL?	PRSA,V?WAIT,V?STAY \?ELS25
	CALL	QUEUE,I-FOLIN,0
	PRINTR	"The dungeon master answers, ""I will stay."""
?ELS25:	EQUAL?	PRSA,V?WALK \?ELS29
	EQUAL?	PRSO,P?SOUTH,P?ENTER \?ELS34
	EQUAL?	HERE,NORTH-CORRIDOR \?ELS34
	PRINTR	"""I am not permitted to enter the prison cell."""
?ELS34:	EQUAL?	PRSO,P?NORTH \?ELS40
	EQUAL?	HERE,NORTH-CORRIDOR \?ELS40
	MOVE	DUNGEON-MASTER,PARAPET
	PRINTI	"""Very well. I am at the parapet!"""
	CRLF	
	CALL	QUEUE,I-FOLIN,0
	RSTACK	
?ELS40:	EQUAL?	PRSO,P?NORTH,P?ENTER \?ELS46
	EQUAL?	HERE,SOUTH-CORRIDOR \?ELS46
	PRINTR	"""I am not permitted to enter the prison cell."""
?ELS46:	PRINTR	"""I prefer to stay where I am, thank you."""
?ELS29:	EQUAL?	PRSA,V?WALK-TO \?ELS56
	EQUAL?	PRSO,PARAPET-OBJ \?ELS56
	MOVE	DUNGEON-MASTER,PARAPET
	CALL	QUEUE,I-FOLIN,0
	PRINTR	"""Very well!"""
?ELS56:	EQUAL?	PRSA,V?TAKE \?ELS62
	PRINTR	"""I will have no use for that, I am afraid."""
?ELS62:	EQUAL?	PRSA,V?OPEN \?ELS66
	EQUAL?	PRSO,DUNGEON-DOOR \?ELS66
	PRINTR	"The dungeon master appears angered. ""Do not run from your quest: you are nearing the end!"""
?ELS66:	EQUAL?	PRSA,V?WALK-TO /?THN73
	EQUAL?	PRSA,V?WAIT,V?KILL,V?CLOSE /?THN73
	EQUAL?	PRSA,V?OPEN,V?STAY,V?FOLLOW /?THN73
	EQUAL?	PRSA,V?SPIN,V?TURN,V?PUSH \?ELS72
?THN73:	EQUAL?	PRSA,V?WAIT,V?FOLLOW,V?STAY /FALSE
	PRINTI	"""If you wish,"" he replies."
	CRLF	
	RFALSE	
?ELS72:	PRINTR	"""Do not be foolish! Consider the end of your quest!"""
?ELS7:	EQUAL?	PRSA,V?EXAMINE \?ELS87
	PRINTR	"He is dressed simply in a hood and cloak, wearing an amulet and ring, carrying an old book under one arm, and leaning on a wooden staff. A single key, as if to a prison cell, hangs from his belt."
?ELS87:	EQUAL?	PRSA,V?MUNG,V?KILL,V?ATTACK \?ELS91
	CALL	REALLY-DEAD,STR?93
	RSTACK	
?ELS91:	EQUAL?	PRSA,V?TAKE \?ELS93
	PRINTR	"""I'm willing to accompany you, but not ride in your pocket!"""
?ELS93:	EQUAL?	PRSA,V?GIVE \FALSE
	EQUAL?	PRSI,DUNGEON-MASTER \FALSE
	PRINTR	"""I have no need for those things."""


	.FUNCT	MASTER-F
	EQUAL?	HERE,PRISON-CELL,GOOD-CELL \?ELS5
	CALL	HELLO?,MASTER
	ZERO?	STACK /?ELS10
	PRINTR	"He can't hear you."
?ELS10:	PRINTR	"He is not here."
?ELS5:	EQUAL?	PRSA,V?TELL \?ELS18
	SET	'PRSO,DUNGEON-MASTER
	RFALSE	
?ELS18:	EQUAL?	PRSA,V?SGIVE,V?GIVE \?ELS20
	IN?	DUNGEON-MASTER,HERE \?ELS20
	PRINTR	"He politely refuses your offer."
?ELS20:	EQUAL?	PRSA,V?EXAMINE \?ELS26
	EQUAL?	HERE,CELL,NORTH-CORRIDOR \?ELS26
	IN?	DUNGEON-MASTER,PARAPET \?ELS26
	PRINTR	"The dungeon master is standing on the parapet."
?ELS26:	PRINTR	"The dungeon master isn't here."


	.FUNCT	BEHIND-DOOR-F,RARG=0
	EQUAL?	RARG,M-ENTER \?ELS5
	ZERO?	DM-SEEN \?ELS5
	CALL	QUEUE,I-FOLIN,-1
	PUT	STACK,0,1
	SET	'DM-SEEN,TRUE-VALUE
	RETURN	DM-SEEN
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a narrow north-south corridor. At the south end is a door and at the north end is an east-west corridor. The door is "
	CALL	DPR,DUNGEON-DOOR
	RSTACK	


	.FUNCT	FRONT-DOOR-F,RARG=0
	EQUAL?	RARG,M-ENTER \?ELS5
	CALL	QUEUE,I-FOLIN,0
	RSTACK	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LOOK-TO,FALSE-VALUE,MRD
	PRINTI	"The wooden door has a barred panel in it at about head height. The door itself is "
	CALL	DPR,DUNGEON-DOOR
	RSTACK	


	.FUNCT	LOOK-LIKE-DM?
	IN?	CLOAK,WINNER \FALSE
	IN?	HOOD,WINNER \FALSE
	IN?	AMULET,WINNER \FALSE
	IN?	STAFF,WINNER \FALSE
	IN?	RING,WINNER \FALSE
	IN?	LORE-BOOK,WINNER \FALSE
	IN?	KEY,WINNER /TRUE
	RFALSE	


	.FUNCT	DUNGEON-DOOR-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	PRINTR	"The door won't budge."
?ELS5:	EQUAL?	PRSA,V?KNOCK \FALSE
	EQUAL?	HERE,FRONT-DOOR \FALSE
	PRINTI	"The knock reverberates along the hall. For a time it seems there will be no answer. Then you hear someone unlatching the small wooden panel. Through the bars of the great door, the wrinkled face of an old man appears."
	ZERO?	INVIS /?CND14
	PRINTI	" He seems not to take notice of you for for a brief moment, then recovers."
?CND14:	CALL	LOOK-LIKE-DM?
	ZERO?	STACK /?ELS24
	PRINTI	" After a moment, he starts to smile broadly. He disappears for an instant and the massive door opens without a sound. The old man motions and you feel yourself drawn toward him.
""I am the Master of the Dungeon!"" he booms. ""I have been watching you closely during your journey through the Great Underground Empire. Yes!,"" he says, as if recalling some almost forgotten time, ""we have met before, although I may not appear as I did then.""  You look closely into his deeply lined face and see the faces of the old man by the secret door, your ""friend"" at the cliff, and the hooded figure. ""You have shown kindness to the old man, and compassion toward the hooded one. I have seen you display patience in the puzzle and trust at the cliff. You have demonstrated strength, ingenuity, and valor. However, one final test awaits you. Now!  Command me as you will, and complete your quest!""
"
	CRLF	
	CALL	GOTO,BEHIND-DOOR
	SET	'IN-DUNGEON,TRUE-VALUE
	RETURN	IN-DUNGEON
?ELS24:	PRINTI	" He looks you over with his keen, piercing gaze and then speaks gravely. ""I have been waiting a long time for you, "
	CALL	DMISH
	GET	DM-REASONS,STACK
	PRINT	STACK
	PRINTI	" I will remain here. When you feel you are ready, go to the secret door and 'SAY ""FROTZ OZMOO""'!  Go, now!"" He starts to leave but turns back briefly and wags his finger in warning. ""Do not forget the double quotes!"" A moment later, you find yourself in the Button Room."
	CRLF	
	CALL	GOTO,MR-ANTE,FALSE-VALUE
	RTRUE	


	.FUNCT	DMISH,CNT=0
	IN?	AMULET,WINNER \?CND1
	INC	'CNT
?CND1:	IN?	LORE-BOOK,WINNER \?CND4
	INC	'CNT
?CND4:	IN?	HOOD,WINNER \?CND7
	INC	'CNT
?CND7:	IN?	CLOAK,WINNER \?CND10
	INC	'CNT
?CND10:	IN?	RING,WINNER \?CND13
	INC	'CNT
?CND13:	IN?	KEY,WINNER \?CND16
	INC	'CNT
?CND16:	IN?	STAFF,WINNER \?CND19
	INC	'CNT
	RETURN	CNT
?CND19:	RETURN	CNT


	.FUNCT	I-FOLIN
	IN?	DUNGEON-MASTER,HERE /FALSE
	EQUAL?	HERE,PRISON-CELL,CELL \?ELS7
	ZERO?	FOLFLAG /?ELS7
	PRINTI	"You notice that the dungeon master doesn't follow you."
	CRLF	
	SET	'FOLFLAG,FALSE-VALUE
	RTRUE	
?ELS7:	EQUAL?	HERE,PRISON-CELL,CELL /FALSE
	ZERO?	FOLFLAG \?ELS15
	SET	'FOLFLAG,TRUE-VALUE
	PRINTI	"The dungeon master rejoins you."
	CRLF	
	MOVE	DUNGEON-MASTER,HERE
	RTRUE	
?ELS15:	PRINTI	"The dungeon master follows you."
	CRLF	
	MOVE	DUNGEON-MASTER,HERE
	RTRUE	


	.FUNCT	MOVE-CELL-OBJECTS,TOP,CNT,F,X
	SUB	LCELL,1
	MUL	8,STACK >TOP
	ADD	TOP,1 >CNT
	FIRST?	CELL >F /?KLU24
?KLU24:	ZERO?	F /?CND1
?PRG5:	NEXT?	F >X /?KLU25
?KLU25:	ZERO?	F \?ELS9
	JUMP	?CND1
?ELS9:	PUT	CELLOBJS,CNT,F
	REMOVE	F
	INC	'CNT
?CND7:	ZERO?	X \?ELS14
	JUMP	?CND1
?ELS14:	SET	'F,X
	JUMP	?PRG5
?CND1:	SUB	CNT,TOP
	SUB	STACK,1
	PUT	CELLOBJS,TOP,STACK
	SUB	PNUMB,1
	MUL	8,STACK >TOP
	GET	CELLOBJS,TOP >CNT
?PRG17:	ZERO?	CNT /TRUE
	INC	'TOP
	GET	CELLOBJS,TOP
	MOVE	STACK,CELL
	DEC	'CNT
	JUMP	?PRG17


	.FUNCT	CELL-MOVE,F,X
	FCLEAR	CELL-DOOR,OPENBIT
	FCLEAR	BRONZE-DOOR,OPENBIT
	EQUAL?	PNUMB,LCELL /FALSE
	EQUAL?	PNUMB,4 \?ELS8
	FCLEAR	BRONZE-DOOR,INVISIBLE
	JUMP	?CND6
?ELS8:	FSET	BRONZE-DOOR,INVISIBLE
?CND6:	IN?	PLAYER,CELL \?ELS13
	SET	'WINNER,PLAYER
	FCLEAR	GOOD-CELL,TOUCHBIT
	FCLEAR	PRISON-CELL,TOUCHBIT
	EQUAL?	LCELL,4 \?ELS18
	FCLEAR	BRONZE-DOOR,INVISIBLE
	PUSH	GOOD-CELL
	JUMP	?CND14
?ELS18:	PUSH	PRISON-CELL
?CND14:	CALL	GOTO,STACK
	FIRST?	CELL >F /?KLU39
?KLU39:	ZERO?	F /?CND11
?PRG25:	NEXT?	F >X /?KLU40
?KLU40:	ZERO?	F \?ELS29
	JUMP	?CND11
?ELS29:	MOVE	F,HERE
?CND27:	ZERO?	X \?ELS34
	JUMP	?CND11
?ELS34:	SET	'F,X
	JUMP	?PRG25
?ELS13:	CALL	MOVE-CELL-OBJECTS
?CND11:	SET	'LCELL,PNUMB
	RETURN	LCELL


	.FUNCT	PARAPET-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are standing behind a stone retaining wall which rims a large parapet overlooking a fiery pit. It is difficult to see through the smoke and flame which fills the pit, but it seems to be more or less bottomless. The pit itself is circular, about two hundred feet in diameter, and is fashioned of roughly hewn stone. The flames generate considerable heat, so it is rather uncomfortable standing here.
There is an object here which looks like a sundial. On it are an indicator arrow and (in the center) a large button. On the face of the dial are numbers 1 through 8. The indicator points to the number "
	PRINTN	PNUMB
	PRINTI	"."
	CRLF	
	PRINTR	"To the south, across a narrow corridor, is a prison cell."


	.FUNCT	DIAL,N
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The dial points to "
	PRINTN	PNUMB
	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?TURN \?ELS9
	EQUAL?	PRSI,INTNUM \?ELS14
	ZERO?	P-NUMBER /?THN18
	GRTR?	P-NUMBER,8 \?CND15
?THN18:	PRINTR	"There is no such setting."
?CND15:	SET	'PNUMB,P-NUMBER
	EQUAL?	WINNER,PLAYER \TRUE
	PRINTI	"The dial now points to "
	PRINTN	PNUMB
	PRINTR	"."
?ELS14:	ZERO?	PRSI \?ELS28
	PRINTR	"You must specify what to set the dial to."
?ELS28:	PRINTR	"The dial face only contains numbers."
?ELS9:	EQUAL?	PRSA,V?SPIN \FALSE
	RANDOM	8 >PNUMB
	EQUAL?	WINNER,PLAYER \TRUE
	PRINTI	"The dial spins and comes to a stop pointing at "
	PRINTN	PNUMB
	PRINTI	"."
	RTRUE	


	.FUNCT	DIALBUTTON,C
	FSET?	CELL-DOOR,OPENBIT /?PRD1
	PUSH	0
	JUMP	?PRD2
?PRD1:	PUSH	1
?PRD2:	SET	'C,STACK
	FCLEAR	CELL,TOUCHBIT
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	WINNER,PLAYER \?CND8
	PRINTI	"The button depresses with a slight click, and pops back."
	CRLF	
?CND8:	CALL	CELL-MOVE
	ZERO?	C /TRUE
	PRINTR	"You notice that the cell door is now closed."


	.FUNCT	CELL-ROOM,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a featureless prison cell. You can see "
	FSET?	CELL-DOOR,OPENBIT \?ELS10
	PRINTI	"an east-west corridor outside the open wooden door in front of you. Your view also takes in the parapet, and behind, a large, fiery pit."
	CRLF	
	JUMP	?CND8
?ELS10:	PRINTI	"through the small window in the closed door in front of you the parapet, and, behind that, smoke and flames rising from a fiery pit."
	CRLF	
?CND8:	IN?	DUNGEON-MASTER,PARAPET \?CND17
	PRINTI	"The dungeon master is standing on the parapet, leaning on his wooden staff. His keen gaze is fixed on you and he looks somewhat tense, as if waiting for something to happen."
	CRLF	
?CND17:	EQUAL?	LCELL,4 \TRUE
	PRINTI	"Behind you, to the south, is a bronze door which is "
	CALL	DPR,BRONZE-DOOR
	RTRUE	


	.FUNCT	NCELL-ROOM,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a bare prison cell. Its wooden door is securely fastened, and you can see only flames and smoke through its small window. On the south wall is a bronze door which seems to be "
	CALL	DPR,BRONZE-DOOR
	RSTACK	


	.FUNCT	DPR,OBJ
	FSET?	OBJ,OPENBIT \?ELS5
	PRINTR	"open."
?ELS5:	PRINTR	"closed."


	.FUNCT	NORTH-CORRIDOR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a wide east-west corridor which opens onto a northern parapet at its center. You can see flames and smoke as you peer towards the parapet. The corridor turns south at either end, and in the center of the south wall is a heavy wooden door with a small window barred with iron. The door is "
	CALL	DPR,CELL-DOOR
	RSTACK	


	.FUNCT	SOUTH-CORRIDOR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in an east-west corridor which turns north at its eastern and western ends. The walls are made of the finest marble. An additional passage leads south at the center of the corridor."
	CRLF	
	EQUAL?	LCELL,4 \TRUE
	PRINTI	"In the center of the north wall is a bronze door which is "
	CALL	DPR,BRONZE-DOOR
	RTRUE	


	.FUNCT	BRONZE-DOOR-F
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	BRONZE-DOOR,OPENBIT /?ELS5
	EQUAL?	HERE,GOOD-CELL \?ELS5
	ZERO?	BRONZE-DOOR-LOCKED \?ELS5
	PRINTI	"On the other side of the bronze door is a narrow passage which opens out into a larger area."
	CRLF	
	FSET	BRONZE-DOOR,OPENBIT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?OPEN \FALSE
	ZERO?	BRONZE-DOOR-LOCKED /FALSE
	PRINTR	"The bronze door is locked."


	.FUNCT	LOCKED-DOOR-F
	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	PRINTR	"The door is securely fastened."


	.FUNCT	NIRVANA-F,RARG
	EQUAL?	RARG,M-END \FALSE
	PRINTI	"As you gleefully examine your new-found riches, the Dungeon Master materializes beside you, and says, ""Now that you have solved all the mysteries of the Dungeon, it is time for you to assume your rightly-earned place in the scheme of things. Long have I waited for one capable of releasing me from my burden!"" He taps you lightly on the head with his staff, mumbling a few well-chosen spells, and you feel yourself changing, growing older and more stooped. For a moment there are two identical mages standing among the treasure, then your counterpart dissolves into a mist and disappears, a sardonic grin on his face.

For a moment you are relieved, safe in the knowledge that you have at last completed your quest in ZORK. You begin to feel the vast powers and lore at your command and thirst for an opportunity to use them.

"
	CALL	FINISH
	RSTACK	


	.FUNCT	BRONZE-DOOR-EXIT
	FSET?	BRONZE-DOOR,INVISIBLE \?ELS5
	PRINTI	"You can't go that way."
	CRLF	
	RFALSE	
?ELS5:	FSET?	BRONZE-DOOR,OPENBIT \?ELS9
	RETURN	CELL
?ELS9:	PRINTI	"The bronze door is closed."
	CRLF	
	RFALSE	


	.FUNCT	SECRET-DOOR-F
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	SECRET-DOOR,OPENBIT /FALSE
	PRINTI	"The massive stone door opens noiselessly. "
	PRINT	SECRET-DOOR-DESC
	CRLF	
	FSET	SECRET-DOOR,OPENBIT
	RTRUE	


	.FUNCT	MSTAIRS-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	RANDOM	100
	GRTR?	30,STACK \?ELS5
	ZERO?	OLD-MAN-FED \?ELS5
	ZERO?	OLD-MAN-GONE \?ELS5
	MOVE	OLD-MAN,HERE
	RTRUE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a room with passages heading southwest and southeast. The north wall is ornately carved, filled with strange runes and writing in an unfamiliar language."
	CRLF	
	FSET?	SECRET-DOOR,OPENBIT \?ELS16
	PRINT	SECRET-DOOR-DESC
	CRLF	
	RTRUE	
?ELS16:	FSET?	SECRET-DOOR,INVISIBLE /FALSE
	PRINTR	"The outline of a door is barely visible on the surface of the rock."


	.FUNCT	HELLO?,WHO
	EQUAL?	WINNER,WHO /?THN8
	EQUAL?	PRSA,V?INCANT,V?HELLO,V?SAY /?THN8
	EQUAL?	PRSA,V?REPLY,V?ANSWER,V?TELL \FALSE
?THN8:	EQUAL?	PRSA,V?REPLY,V?INCANT /?THN13
	EQUAL?	PRSA,V?SAY,V?ANSWER,V?TELL \TRUE
?THN13:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RTRUE	


	.FUNCT	OLD-MAN-F,RARG=0
	EQUAL?	RARG,M-OBJDESC \?ELS5
	ZERO?	OLD-MAN-AWAKE /?ELS10
	PRINTR	"There is an old man huddled in the corner, eyeing you cautiously. He seems weak and tired, and nods off frequently."
?ELS10:	PRINTR	"An old and wizened man is huddled, asleep, in the corner. He is snoring loudly. From his appearance, he is weak and frail."
?ELS5:	EQUAL?	PRSA,V?GIVE \?ELS19
	EQUAL?	PRSI,OLD-MAN \?ELS19
	ZERO?	OLD-MAN-AWAKE /?ELS26
	EQUAL?	PRSO,WAYBREAD \?ELS32
	REMOVE	WAYBREAD
	PRINTI	"He looks up at you and takes the waybread from you. Slowly, he eats the bread and pauses when he is finished. He starts to speak: ""Perhaps what you seek is through there!"" He points at the carved wall to the north, where you now notice the bare outline of a secret door. When you turn back to the old man, you notice that he has gone!"
	CRLF	
	FCLEAR	SECRET-DOOR,INVISIBLE
	SET	'OLD-MAN-GONE,TRUE-VALUE
	REMOVE	OLD-MAN
	RTRUE	
?ELS32:	IN?	WAYBREAD,WINNER \?ELS36
	PRINTR	"He refuses your offer but motions with his arm to the waybread in your hand."
?ELS36:	PRINTI	"The old man refuses the "
	PRINTD	PRSO
	PRINTR	" with a wave of his hand."
?ELS26:	PRINTR	"He is asleep!"
?ELS19:	EQUAL?	PRSA,V?EXAMINE \?ELS48
	ZERO?	OLD-MAN-AWAKE /?ELS53
	PRINTR	"The old man is barely awake and appears to nod off every few moments. He has bright eyes, which, when open, appear to see right through your body."
?ELS53:	PRINTR	"The man is very, very old and wizened. He has a long, stringy beard and is snoring quite loudly."
?ELS48:	EQUAL?	PRSA,V?LISTEN \?ELS62
	ZERO?	OLD-MAN-AWAKE /?ELS67
	PRINTR	"He isn't talking."
?ELS67:	PRINTR	"He is snoring like a buzz saw."
?ELS62:	CALL	HELLO?,OLD-MAN
	ZERO?	STACK /?ELS76
	ZERO?	OLD-MAN-AWAKE /?ELS81
	PRINTR	"He nods at you without seeming to have understood."
?ELS81:	PRINTR	"He is sleeping soundly and does not respond."
?ELS76:	EQUAL?	PRSA,V?ALARM,V?SHAKE \?ELS90
	PRINTI	"The old man is roused to consciousness. He peers at you through eyes which appear much younger and stronger than his frail body and waits, as if expecting something to happen."
	CRLF	
	SET	'OLD-MAN-AWAKE,TRUE-VALUE
	CALL	QUEUE,I-OLD-MAN-SLEEPS,3
	PUT	STACK,0,1
	RTRUE	
?ELS90:	EQUAL?	PRSA,V?MUNG,V?ATTACK,V?KILL \FALSE
	PRINTI	"The attack seems to have left the old man unharmed! You watch in awe as he rises to his feet and seems to tower above you. He peers down menacingly, then sadly and wearily. ""Not yet,"" he mourns, and vanishes in a puff of smoke."
	CRLF	
	SET	'OLD-MAN-GONE,TRUE-VALUE
	REMOVE	OLD-MAN
	RTRUE	


	.FUNCT	I-OLD-MAN-SLEEPS
	SET	'OLD-MAN-AWAKE,FALSE-VALUE
	IN?	OLD-MAN,HERE \FALSE
	PRINTR	"You notice that the old man has fallen asleep."


	.FUNCT	RUNES-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTR	"The runes are in an ancient language. Some pictures, among the runes, depict flames, stone statues, and figures of old men."


	.FUNCT	T-BAR-F
	EQUAL?	PRSA,V?TURN \FALSE
	PRINTR	"You don't have enough leverage to turn the T-bar itself. You might cause the whole structure to turn, however."


	.FUNCT	FLAMING-PIT-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The flaming pit is a seemingly bottomless abyss filled with smoke and flame."
?ELS5:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,FLAMING-PIT \FALSE
	EQUAL?	HERE,PARAPET,NORTH-CORRIDOR \?ELS16
	EQUAL?	PRSO,ME \?ELS21
	PRINTR	"It would be a pity to end your life so near the end of your quest!"
?ELS21:	PRINTI	"You cast the "
	PRINTD	PRSO
	PRINTI	" into the pit, where it is lost forever."
	CRLF	
	REMOVE	PRSO
	RTRUE	
?ELS16:	PRINTR	"You're not close enough."


	.FUNCT	PARAPET-OBJ-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,CELL,NORTH-CORRIDOR \?ELS10
	PRINTI	"You can see the parapet and sundial from here."
	IN?	DUNGEON-MASTER,PARAPET \?CND13
	PRINTI	" The dungeon master is there also, leaning on his staff."
?CND13:	CRLF	
	RTRUE	
?ELS10:	CALL	V-LOOK
	RSTACK	


	.FUNCT	ROSE-F
	EQUAL?	PRSA,V?MOVE,V?TURN \FALSE
	PRINTR	"The compass rose is made of stone and is imbedded in the ground. You could not possibly turn it or move it."


	.FUNCT	CELL-DOOR-F
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSI,CELL-DOOR \?ELS5
	PRINTR	"You will have to enter the cell first."
?ELS5:	EQUAL?	PRSA,V?THROUGH \FALSE
	EQUAL?	HERE,CELL \?ELS16
	PRINTR	"Look around."
?ELS16:	CALL	DO-WALK,P?SOUTH
	RTRUE	


	.FUNCT	LORE-BOOK-F
	EQUAL?	PRSA,V?BURN \?ELS5
	IN?	LORE-BOOK,WINNER /?ELS5
	PRINTI	"The book is consumed in a dazzling display of color."
	CRLF	
	REMOVE	PRSO
	RTRUE	
?ELS5:	ZERO?	IN-DUNGEON /?ELS11
	EQUAL?	PRSA,V?READ,V?EXAMINE,V?OPEN \?ELS11
	PRINTR	"The book seems to will itself open to a specific page. On it is a picture of eight small rooms located around a great circle of flame. All are identical save one, which has a bronze door leading to a magnificent room bathed in golden light. A legend beneath the picture says only ""The Dungeon and Treasury of Zork."""
?ELS11:	EQUAL?	PRSA,V?OPEN \FALSE
	PRINTR	"The book can be perused but not left open."


	.FUNCT	CP-HOLE-F
	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	DO-WALK,P?DOWN
	RTRUE	


	.FUNCT	TORCH-PSEUDO
	PRINTR	"The torches are out of reach."


	.FUNCT	WATER-FCN,AV,PI?
	EQUAL?	PRSA,V?SGIVE /FALSE
	EQUAL?	PRSA,V?THROUGH \?ELS5
	CALL	PERFORM,V?SWIM,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?FILL \?ELS7
	SET	'PRSA,V?PUT
	SET	'PRSI,PRSO
	SET	'PRSO,GLOBAL-WATER
	SET	'PI?,FALSE-VALUE
	JUMP	?CND1
?ELS7:	EQUAL?	PRSO,GLOBAL-WATER \?ELS9
	SET	'PI?,FALSE-VALUE
	JUMP	?CND1
?ELS9:	ZERO?	PRSI /?CND1
	SET	'PI?,TRUE-VALUE
?CND1:	ZERO?	PI? /?ELS15
	SET	'PRSI,GLOBAL-WATER
	JUMP	?CND13
?ELS15:	SET	'PRSO,GLOBAL-WATER
?CND13:	EQUAL?	PRSA,V?PUT,V?TAKE \?ELS23
	ZERO?	PI? \?ELS23
	PRINTR	"The water slips through your fingers."
?ELS23:	ZERO?	PI? /?ELS29
	PRINTR	"You can't do that."
?ELS29:	EQUAL?	PRSA,V?THROW,V?GIVE,V?DROP \FALSE
	PRINTR	"You don't have any water."


	.FUNCT	RANDOM-WALL
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	HERE,IN-MIRROR \?ELS10
	PRINTR	"You should specify which panel you want to push."
?ELS10:	PRINTR	"You can't budge it; at least from here."

	.ENDI

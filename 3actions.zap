

	.FUNCT	I-SWORD,DEM,NG=0,P,T,L
	CALL	INT,I-SWORD >DEM
	IN?	SWORD,ADVENTURER \?ELS5
	EQUAL?	HERE,CLIFF \?ELS8
	ZERO?	MAN-GONE \?ELS8
	SET	'NG,1
	JUMP	?CND6
?ELS8:	EQUAL?	HERE,CLIFF-LEDGE \?ELS12
	ZERO?	MAN-FLAG /?ELS12
	SET	'NG,1
	JUMP	?CND6
?ELS12:	CALL	INFESTED?,HERE
	ZERO?	STACK /?ELS16
	SET	'NG,2
	JUMP	?CND6
?ELS16:	EQUAL?	MLOC,MRG \?ELS22
	EQUAL?	HERE,IN-MIRROR /?THN19
?ELS22:	EQUAL?	HERE,MRGE,MRG,MRGW \?ELS18
?THN19:	SET	'NG,1
	JUMP	?CND6
?ELS18:	SET	'P,0
?PRG25:	NEXTP	HERE,P >P
	ZERO?	P \?ELS29
	JUMP	?CND6
?ELS29:	LESS?	P,LOW-DIRECTION /?PRG25
	GETPT	HERE,P >T
	PTSIZE	T >L
	EQUAL?	L,UEXIT,CEXIT,DEXIT \?PRG25
	GETB	T,0
	CALL	INFESTED?,STACK
	ZERO?	STACK /?PRG25
	SET	'NG,1
?CND6:	EQUAL?	NG,SWORD-STATE /FALSE
	EQUAL?	NG,2 \?ELS42
	PRINTI	"Your sword has begun to glow very brightly."
	CRLF	
	JUMP	?CND38
?ELS42:	EQUAL?	NG,1 \?ELS46
	PRINTI	"Your sword is glowing with a faint blue glow."
	CRLF	
	JUMP	?CND38
?ELS46:	ZERO?	NG \?CND38
	PRINTI	"Your sword is no longer glowing."
	CRLF	
?CND38:	SET	'SWORD-STATE,NG
	RTRUE	
?ELS5:	PUT	DEM,0,0
	RFALSE	


	.FUNCT	INFESTED?,R,F
	FIRST?	R >F /?KLU12
?KLU12:	
?PRG1:	ZERO?	F /FALSE
	FSET?	F,ACTORBIT \?ELS7
	FSET?	F,INVISIBLE /?ELS7
	RETURN	F
?ELS7:	NEXT?	F >F /?PRG1
	RFALSE	


	.FUNCT	FIND-WEAPON,O,W
	FIRST?	O >W /?KLU11
?KLU11:	ZERO?	W /FALSE
?PRG4:	EQUAL?	W,SWORD \?ELS8
	RETURN	W
?ELS8:	NEXT?	W >W /?PRG4
	RFALSE	


	.FUNCT	SWORD-FCN
	ZERO?	SWORD-IN-STONE? /?ELS5
	EQUAL?	PRSA,V?MOVE,V?TAKE \FALSE
	RANDOM	100
	GRTR?	10,STACK \?ELS16
	PRINTR	"Who do you think you are? Arthur?"
?ELS16:	PRINTR	"The sword is deeply imbedded in the rock. You can't budge it."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	WINNER,ADVENTURER \FALSE
	CALL	QUEUE,I-SWORD,-1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	LANTERN
	EQUAL?	PRSA,V?THROW \?ELS5
	PRINTI	"The lamp smashes. The light is now out."
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


	.FUNCT	LIGHT-INT,OBJ,TBL,TICK
	ZERO?	TICK \?CND1
	FCLEAR	OBJ,ONBIT
	FSET	OBJ,RMUNGBIT
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


	.FUNCT	I-LANTERN,TICK,TBL
	VALUE	'LAMP-TABLE >TBL
	GET	TBL,0 >TICK
	CALL	QUEUE,I-LANTERN,TICK
	PUT	STACK,0,1
	CALL	LIGHT-INT,LAMP,TBL,TICK
	ZERO?	TICK /FALSE
	ADD	TBL,4 >LAMP-TABLE
	RETURN	LAMP-TABLE


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


	.FUNCT	TUNNEL-OBJECT
	EQUAL?	PRSA,V?THROUGH \?ELS5
	GETP	HERE,P?IN
	ZERO?	STACK /?ELS5
	CALL	DO-WALK,P?IN
	RTRUE	
?ELS5:	CALL	PATH-OBJECT
	RSTACK	


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
	ADD	STACK,FX
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
	PRINTI	"This is a small square room, in the middle of which is a round hole"
	ZERO?	CPBLOCK-FLAG \?THN13
	EQUAL?	YEAR,YEAR-PRESENT /?ELS12
?THN13:	PRINTR	" which is blocked by smooth sandstone."
?ELS12:	PRINTR	" through which you can discern the floor some ten feet below. The area under the hole is dark, but it appears to be completely enclosed in rock. In any event, it doesn't seem likely that you could climb back up. Exits are west and, up a few steps, north."


	.FUNCT	CPLADDER-OBJECT
	SUB	CPHERE,1
	GET	CPTABLE,STACK
	EQUAL?	STACK,-3 \?ELS5
	CALL	CPLADDER-JUNK,FALSE-VALUE
	RSTACK	
?ELS5:	ADD	CPHERE,1
	GET	CPTABLE,STACK
	EQUAL?	STACK,-2 \?ELS7
	CALL	CPLADDER-JUNK,TRUE-VALUE
	RSTACK	
?ELS7:	PRINTR	"You can't see any ladder here."


	.FUNCT	CPLADDER-JUNK,FLG
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \?ELS5
	ZERO?	FLG /?ELS10
	EQUAL?	CPHERE,1 \?ELS10
	SET	'CPSOLVE-FLAG,TRUE-VALUE
	CALL	GOTO,CP-ANTE
	RSTACK	
?ELS10:	PRINTR	"You hit your head on the ceiling and fall off the ladder."
?ELS5:	PRINTR	"Come, come!"


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
	CALL	FIXED-FONT-ON
	PRINTI	"
  .. = your position (middle of grid)
  MM = marble wall
  SS = sandstone wall
  ?? = unknown (blocked by walls)

"
	CALL	FIXED-FONT-OFF
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


	.FUNCT	FIXED-FONT-ON
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	FIXED-FONT-OFF
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	RTRUE	


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
	PRINTR	"You can't see any steel door here."
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
	CALL	FIXED-FONT-ON
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
	CALL	FIXED-FONT-OFF
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
	PRINTR	"The book drops into the slot and vanishes. The metal door slides open, revealing a passageway to the west, and a sign flashes:
    ""Royal Puzzle Exit Fee Paid
          Item Confiscated"""
?ELS15:	FSET?	PRSO,ACTORBIT \?ELS19
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS19:	PRINTI	"The item vanishes into the slot. A moment later, a previously unseen sign flashes ""Garbage In, Garbage Out"" and spews out the "
	PRINTD	PRSO
	PRINTR	" (now atomized)."


	.FUNCT	CPOUT-ROOM,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a narrow room, lit from above. A flight of steps leads up to the north, and a "
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
	PUSH	STR?65
	JUMP	?CND25
?ELS29:	PUSH	STR?66
?CND25:	PRINT	STACK
	PRINTI	" wall is a large "
	ZERO?	MWIN /?ELS37
	PUSH	STR?67
	JUMP	?CND33
?ELS37:	PUSH	STR?68
?CND33:	PRINT	STACK
	CRLF	
	ZERO?	M1? /?CND41
	ZERO?	MIRROR-OPEN-FLAG /?CND41
	ZERO?	MWIN /?ELS52
	PUSH	STR?69
	JUMP	?CND48
?ELS52:	PUSH	STR?70
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
	SET	'DIR,STR?72
	JUMP	?CND30
?ELS32:	SET	'STELL,TRUE-VALUE
	SET	'DIR,STR?73
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
	PUSH	STR?74
	JUMP	?CND61
?ELS65:	PUSH	STR?75
?CND61:	PRINT	STACK
	PRINT	DIR
	PRINTI	"th side of the hallway."
	CRLF	
	ZERO?	M1? /?CND48
	ZERO?	MIRROR-OPEN-FLAG /?CND48
	ZERO?	MIR? /?ELS80
	PUSH	STR?69
	JUMP	?CND76
?ELS80:	PUSH	STR?70
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


	.FUNCT	GUARDIANS,RARG=0
	EQUAL?	RARG,M-LOOK \?ELS5
	EQUAL?	HERE,MRG \?ELS10
	CALL	LOOK-TO,MRD,MRC
	RSTACK	
?ELS10:	CALL	EWTELL,HERE
	PRINTR	"To the east and west are the Guardians of Zork, in perfect symmetry. From here, it's hard to tell which of the two is a reflection!"
?ELS5:	EQUAL?	RARG,M-ENTER \?ELS16
	ZERO?	INVIS \?ELS16
	CALL	JIGS-UP,STR?76
	RSTACK	
?ELS16:	EQUAL?	RARG,M-END \FALSE
	EQUAL?	PRSA,V?EXAMINE \?ELS22
	EQUAL?	HERE,IN-MIRROR \?ELS27
	PRINTR	"You can't see them from here."
?ELS27:	PRINTR	"The Guardians are quite impressive. I wouldn't get in their way if I were you!"
?ELS22:	EQUAL?	PRSA,V?THROW \?ELS35
	EQUAL?	PRSI,GUARDIAN \?ELS35
	EQUAL?	PRSO,ME \?ELS40
	PRINTI	"You step"
	JUMP	?CND38
?ELS40:	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" falls"
	REMOVE	PRSO
?CND38:	PRINTI	" in front of the Guardians, who "
	EQUAL?	PRSO,ME \?ELS51
	PRINTI	"decimate you"
	JUMP	?CND49
?ELS51:	PRINTI	"destroy it"
?CND49:	PRINTR	" in perfect unison. Satisfied, they resume their posts."
?ELS35:	EQUAL?	PRSA,V?ATTACK \?ELS61
	PRINTR	"You aren't close enough, and even if you were, the fight would be a bit one-sided."
?ELS61:	EQUAL?	PRSA,V?HELLO \FALSE
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
?ELS5:	PRINTR	"You can't see any wooden wall here."


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
	PRINTR	"You can't see any mirror here."
?ELS5:	EQUAL?	PRSA,V?MOVE,V?OPEN \?ELS9
	PRINTR	"You don't see a way to open the mirror here."
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
	PUSH	STR?77
	JUMP	?CND79
?ELS83:	PUSH	STR?78
?CND79:	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	PANEL-FUNCTION,MIRROR
	CALL	MIRROR-HERE?,HERE >MIRROR
	ZERO?	MIRROR \?ELS5
	PRINTR	"You can't see any panel here."
?ELS5:	EQUAL?	PRSA,V?MOVE,V?OPEN \?ELS9
	PRINTR	"You don't see a way to open the panel here."
?ELS9:	EQUAL?	PRSA,V?MUNG \?ELS13
	EQUAL?	MIRROR,1 \?ELS18
	ZERO?	MR1-FLAG /?ELS23
	PRINT	MIRROR-FIRST
	CRLF	
	RTRUE	
?ELS23:	PRINTR	"The panel is not that easily destroyed."
?ELS18:	ZERO?	MR2-FLAG /?ELS32
	PRINT	MIRROR-FIRST
	CRLF	
	RTRUE	
?ELS32:	PRINTR	"The panel is not that easily destroyed."
?ELS13:	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	MIRROR,1 \?ELS48
	PUSH	STR?79
	JUMP	?CND44
?ELS48:	PUSH	STR?80
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
	EQUAL?	STACK,DIR \?ELS16
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
?ELS16:	PRINTI	"There's a wall there."
	CRLF	
	RFALSE	
?ELS10:	ZERO?	WOOD-OPEN-FLAG /?ELS33
	EQUAL?	DIR,1 /?THN40
	ADD	MDIR,180
	MOD	STACK,360
	EQUAL?	STACK,DIR \?ELS39
?THN40:	ZERO?	MDIR \?ELS44
	SET	'RM,FALSE-VALUE
	JUMP	?CND42
?ELS44:	SET	'RM,TRUE-VALUE
?CND42:	CALL	MIRNS,RM,TRUE-VALUE >RM
	ZERO?	RM /?ELS51
	PRINTI	"As you leave, the door swings shut."
	CRLF	
	SET	'WOOD-OPEN-FLAG,FALSE-VALUE
	RETURN	RM
?ELS51:	PRINTI	"You can't go that way."
	CRLF	
	RFALSE	
?ELS39:	PRINTI	"You would hit one of the panels."
	CRLF	
	RFALSE	
?ELS33:	PRINTI	"You are inside a closed box!"
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
	PRINTI	"The beam is blocked by a "
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
	CALL	JIGS-UP,STR?88
	RTRUE	
?ELS16:	CALL	JIGS-UP,STR?89
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
	RTRUE	
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
?CND49:	CALL	JIGS-UP,STR?88
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
	PUSH	STR?90
	JUMP	?CND6
?ELS10:	PUSH	STR?91
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
	CALL	JIGS-UP,STR?92
	RTRUE	
?ELS45:	CALL	JIGS-UP,STR?93
	RTRUE	


	.FUNCT	SHORT-POLE-F
	EQUAL?	PRSA,V?MOVE,V?RAISE \?ELS5
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
	LOC	PLAYER
	IN?	DUNGEON-MASTER,STACK \?ELS17
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
	SET	'HERE,PARAPET
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
	SET	'HERE,PARAPET
	CALL	QUEUE,I-FOLIN,0
	PRINTR	"""Very well!"""
?ELS56:	EQUAL?	PRSA,V?TAKE \?ELS62
	PRINTR	"""I will have no use for that, I am afraid."""
?ELS62:	EQUAL?	PRSA,V?OPEN \?ELS66
	EQUAL?	PRSO,DUNGEON-DOOR \?ELS66
	ZERO?	IN-DUNGEON /?ELS66
	PRINTR	"The dungeon master appears angered. ""Do not run from your quest: you are nearing the end!"""
?ELS66:	EQUAL?	PRSA,V?SPIN,V?TURN,V?PUSH /?THN73
	EQUAL?	PRSA,V?OPEN,V?STAY,V?FOLLOW /?THN73
	EQUAL?	PRSA,V?ATTACK,V?WAIT,V?CLOSE /?THN73
	EQUAL?	PRSA,V?WALK-TO \?ELS72
?THN73:	EQUAL?	PRSA,V?WAIT,V?FOLLOW,V?STAY /FALSE
	PRINTI	"""If you wish,"" he replies."
	CRLF	
	RFALSE	
?ELS72:	PRINTR	"""Do not be foolish! Consider the end of your quest!"""
?ELS7:	EQUAL?	PRSA,V?EXAMINE \?ELS87
	PRINTR	"He is dressed simply in a hood and cloak, wearing an amulet and ring, carrying an old book under one arm, and leaning on a wooden staff. A single key, as if to a prison cell, hangs from his belt."
?ELS87:	EQUAL?	PRSA,V?MUNG,V?ATTACK \?ELS91
	CALL	REALLY-DEAD,STR?94
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
	ZERO?	IN-DUNGEON /?ELS23
	SET	'PRSO,DUNGEON-MASTER
	RFALSE	
?ELS23:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	PRINTR	"The dungeon master isn't here."
?ELS18:	EQUAL?	PRSA,V?SGIVE,V?GIVE \?ELS30
	IN?	DUNGEON-MASTER,HERE \?ELS30
	PRINTR	"He politely refuses your offer."
?ELS30:	EQUAL?	PRSA,V?EXAMINE \?ELS36
	EQUAL?	HERE,CELL,NORTH-CORRIDOR \?ELS36
	IN?	DUNGEON-MASTER,PARAPET \?ELS36
	PRINTR	"The dungeon master is standing on the parapet."
?ELS36:	PRINTR	"The dungeon master isn't here."


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


	.FUNCT	DUNGEON-PANEL-F
	EQUAL?	PRSA,V?OPEN \?ELS5
	PRINTR	"You can't open the panel. It's set into the door."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"There's not much to be seen."


	.FUNCT	DUNGEON-DOOR-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	PRINTR	"The door won't budge."
?ELS5:	EQUAL?	PRSA,V?KNOCK \FALSE
	EQUAL?	HERE,FRONT-DOOR \FALSE
	PRINTI	"The knock reverberates along the hall. For a time it seems there will be no answer. Then you hear someone unlatching the small panel. Through the bars of the great door, the wrinkled face of an old man appears."
	ZERO?	INVIS /?CND14
	PRINTI	" He seems not to notice you for a brief moment, then recovers."
?CND14:	CALL	LOOK-LIKE-DM?
	ZERO?	STACK /?ELS24
	PRINTI	" He starts to smile broadly and opens the massive door without a sound. The old man motions and you feel yourself drawn toward him.
""I am the Master of the Dungeon!"" he booms. ""I have been watching you closely during your journey through the Great Underground Empire. Yes!,"" he says, as if recalling some almost forgotten time, ""we have met before, although I may not appear as I did then."" You look closely into his deeply lined face and see the faces of the old man by the secret door, your ""friend"" at the cliff, and the hooded figure. ""You have shown kindness to the old man, and compassion toward the hooded one. You displayed patience in the puzzle and trust at the cliff. You have demonstrated strength, ingenuity, and valor. However, one final test awaits you. Now! Command me as you will, and complete your quest!""
"
	CRLF	
	CALL	GOTO,BEHIND-DOOR
	SET	'IN-DUNGEON,TRUE-VALUE
	RETURN	IN-DUNGEON
?ELS24:	PRINTI	" He looks you over with a piercing gaze and then speaks gravely. ""I have been waiting a long time for you, "
	CALL	DMISH
	GET	DM-REASONS,STACK
	PRINT	STACK
	PRINTI	" I will remain here. When you feel you are ready, go to the secret door and 'SAY ""FROTZ OZMOO""'! Go, now!"" He wags his finger in warning. ""Do not forget the double quotes!"" A moment later, you find yourself in the Button Room."
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
?ELS7:	LOC	PLAYER
	EQUAL?	STACK,PRISON-CELL,CELL /FALSE
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
	PRINTI	"You are standing behind a stone retaining wall which rims a parapet overlooking a fiery pit. It is difficult to see through the smoke and flame which fills the pit, but it seems to be bottomless. The pit itself is circular, about two hundred feet in diameter, and is fashioned of roughly hewn stone. The flames generate considerable heat, so it is rather uncomfortable standing here.
There is an object here which looks like a sundial. On it are an indicator arrow surrounding a large button. On the face of the dial are numbers 1 through 8. The indicator points to the number "
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
	PRINTI	"an east-west corridor outside the cell door. Your view also takes in the parapet and a large, fiery pit."
	CRLF	
	JUMP	?CND8
?ELS10:	PRINTI	"through the small window in the closed door the parapet, and, behind that, smoke and flames rising from a fiery pit."
	CRLF	
?CND8:	IN?	DUNGEON-MASTER,PARAPET \?CND17
	PRINTI	"The dungeon master is at the parapet, leaning on his staff. His keen gaze is fixed on you and he looks tense, as if waiting for something to happen."
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
	PRINTI	"This is a wide east-west corridor which opens onto a northern parapet at its center. You can see flames and smoke as you peer towards the parapet. The corridor turns south at either end, and in the center of the south wall is a heavy wooden door with a small barred window. The door is "
	CALL	DPR,CELL-DOOR
	RSTACK	


	.FUNCT	SOUTH-CORRIDOR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in an east-west corridor which turns north at its eastern and western ends. The walls are made of the finest marble. Another hall leads south at the center of the corridor."
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
	PRINTI	"As you examine your new-found riches, the Dungeon Master materializes beside you, and says, ""Now that you have solved all the mysteries of the Dungeon, it is time for you to assume your rightly earned place in the scheme of things. Long have I waited for one capable of releasing me from my burden!"" He taps you lightly on the head with his staff, mumbling a few well-chosen spells, and you feel yourself changing, growing older and more stooped. For a moment there are two identical mages standing among the treasure, then your counterpart dissolves into a mist and disappears, a sardonic grin on his face.

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
	PRINTR	"The outline of a door is barely visible among the runes."


	.FUNCT	HELLO?,WHO
	EQUAL?	WINNER,WHO /?THN6
	EQUAL?	PRSA,V?REPLY,V?ANSWER,V?TELL /?THN6
	EQUAL?	PRSA,V?INCANT,V?HELLO,V?SAY \FALSE
?THN6:	EQUAL?	PRSA,V?SAY,V?ANSWER,V?TELL /?THN11
	EQUAL?	PRSA,V?REPLY,V?INCANT \TRUE
?THN11:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RTRUE	


	.FUNCT	OLD-MAN-F,RARG=0
	EQUAL?	RARG,M-OBJDESC \?ELS5
	ZERO?	OLD-MAN-AWAKE /?ELS10
	PRINTR	"There is an old man huddled in the corner, eyeing you cautiously. He looks weak and tired."
?ELS10:	PRINTR	"An old and wizened man is huddled, asleep, in the corner. He is snoring loudly, and looks quite weak and frail."
?ELS5:	EQUAL?	PRSA,V?GIVE \?ELS19
	EQUAL?	PRSI,OLD-MAN \?ELS19
	ZERO?	OLD-MAN-AWAKE /?ELS26
	EQUAL?	PRSO,WAYBREAD \?ELS32
	REMOVE	WAYBREAD
	PRINTI	"He looks up at you and takes the waybread. Slowly, he eats the bread and pauses when he is finished. He starts to speak: ""Perhaps what you seek is through there!"" He points at the carved wall to the north, where you now notice the bare outline of a secret door. When you turn back, the old man is gone!"
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
	PRINTR	"The old man is barely awake and appears to nod off every few moments. He has bright eyes, which appear to see right through your body."
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
?ELS90:	EQUAL?	PRSA,V?MUNG,V?ATTACK \FALSE
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
	PRINTR	"The runes are in an ancient language. Some pictures among the runes depict flames, stone statues, and an old man."


	.FUNCT	T-BAR-F
	EQUAL?	PRSA,V?TURN \FALSE
	PRINTR	"You don't have enough leverage to turn the T-bar. You might be able to turn the whole structure, however."


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
	PRINTR	"The book seems to will itself open to a specific page. It shows a picture of eight small rooms located around a great circle of flame. All are identical save one, which has a bronze door leading to a room bathed in golden light. A legend beneath the picture says ""The Dungeon and Treasury of Zork."""
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


	.FUNCT	V-DIAGNOSE
	GET	DIAG,P-STRENGTH
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	JIGS-UP,DESC,PLAYER?=0
	SET	'SWORD-STATE,0
	SET	'P-STRENGTH,5
	SET	'S-STRENGTH,5
	PRINT	DESC
	CRLF	
	EQUAL?	YEAR,YEAR-PRESENT /?CND3
	QUIT	
?CND3:	EQUAL?	ADVENTURER,WINNER /?CND6
	PRINTI	" 
    ****  The "
	PRINTD	WINNER
	PRINTI	" has died  **** 

"
	REMOVE	WINNER
	SET	'WINNER,ADVENTURER
	LOC	WINNER >HERE
	RETURN	2
?CND6:	PRINTI	"
    ****  You have died  ****

"
	IGRTR?	'DEATHS,3 \?ELS17
	PRINTI	"You feel yourself disembodied in a deep blackness. A voice from the void speaks:  ""I have waited a long age for you, my friend, but perhaps it has been another that I have been seeking. Good night, oh worthy adventurer!"" It is the last you hear."
	CRLF	
	QUIT	
	JUMP	?CND15
?ELS17:	PRINTI	"You find yourself deep within the earth in a barren prison cell. Outside the iron-barred window, you can see a great, fiery pit. Flames leap up and very nearly sear your flesh. After a while, footfalls can be heard in the distance, then closer and closer.... The door swings open, and in walks an old man.

He is dressed simply in a hood and cloak, wearing an amulet and ring, carrying an old book under one arm, and leaning on a wooden staff. A single key, as if to a massive prison cell, hangs from his belt.

He raises the staff toward you and you hear him speak, as if in a dream: ""I await you, though your journey be long and full of peril. Go then, and let me not wait long!"" You feel some great power well up inside you and you fall to the floor. The next moment, you are awakening, as if from a deep slumber."
	CRLF	
?CND15:	MOVE	CURRENT-LAMP,ZORK2-STAIR
	IN?	KEY,WINNER \?CND24
	EQUAL?	HERE,DARK-1,DARK-2,KEY-ROOM /?THN29
	EQUAL?	HERE,AQ-1,AQ-2 \?CND24
?THN29:	MOVE	KEY,KEY-ROOM
?CND24:	CRLF	
	CALL	GOTO,ZORK2-STAIR
	SET	'P-CONT,FALSE-VALUE
	CALL	RANDOMIZE-OBJECTS
	CALL	KILL-INTERRUPTS
	RETURN	2


	.FUNCT	RANDOMIZE-OBJECTS,R=0,F,N,L
	FIRST?	WINNER >N /?KLU6
?KLU6:	
?PRG1:	SET	'F,N
	ZERO?	F /TRUE
	NEXT?	F >N /?KLU7
?KLU7:	CALL	RANDOM-ELEMENT,DEAD-OBJ-LOCS
	MOVE	F,STACK
	JUMP	?PRG1


	.FUNCT	KILL-INTERRUPTS
	CALL	INT,I-MAN-LEAVES
	PUT	STACK,0,0
	CALL	INT,I-MAN-RETURNS
	PUT	STACK,0,0
	CALL	INT,I-VIEW-SNAP
	PUT	STACK,0,0
	CALL	INT,I-FOLIN
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	V-SCORE,ASK?=1
	PRINTI	"Your potential is "
	PRINTN	SCORE
	PRINTI	" of a possible "
	PRINTN	SCORE-MAX
	PRINTI	", in "
	PRINTN	MOVES
	EQUAL?	MOVES,1 \?ELS9
	PRINTI	" move."
	JUMP	?CND7
?ELS9:	PRINTI	" moves."
?CND7:	CRLF	
	RETURN	SCORE


	.FUNCT	TM-HOLLOW-F
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSI,TM-HOLLOW \?ELS5
	CALL	PERFORM,V?PUT-UNDER,PRSO,TM-SEAT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS9
	CALL	PERFORM,V?LOOK-UNDER,TM-SEAT
	RTRUE	
?ELS9:	EQUAL?	PRSO,TM-HOLLOW \?ELS11
	CALL	PERFORM,PRSA,TM-SEAT,PRSI
	RTRUE	
?ELS11:	EQUAL?	PRSI,TM-HOLLOW \FALSE
	CALL	PERFORM,PRSA,PRSO,TM-SEAT
	RTRUE	


	.FUNCT	IRON-DOOR-F
	EQUAL?	PRSA,V?THROUGH,V?UNLOCK,V?OPEN \FALSE
	LESS?	YEAR,YEAR-PRESENT \?ELS10
	PRINTR	"The iron door is locked from the outside."
?ELS10:	PRINTR	"The iron door is rusted shut and cannot be opened."


	.FUNCT	I-CLEFT
	EQUAL?	HERE,ZORK-IV,ROOM-8,TIMBER-ROOM /?THN4
	EQUAL?	HERE,LOWER-SHAFT,LADDER-BOTTOM,LADDER-TOP \?ELS3
?THN4:	PRINTI	"You feel a mild tremor from within the earth which passes quickly."
	CRLF	
	JUMP	?CND1
?ELS3:	PRINTI	"There is a great tremor from within the earth. The entire dungeon shakes violently and loose debris falls from above you."
	CRLF	
?CND1:	EQUAL?	HERE,MUSEUM-ANTE \?ELS14
	PRINTI	"To the east, next to the great iron door, a cleft opens up, revealing an open area behind!"
	CRLF	
	JUMP	?CND12
?ELS14:	EQUAL?	HERE,AQ-VIEW \?ELS18
	PRINTI	"One of the giant pillars supporting the aqueduct collapses in a pile of smoke and rubble!"
	CRLF	
	JUMP	?CND12
?ELS18:	EQUAL?	HERE,AQ-2,AQ-3 \?CND12
	PRINTI	"The channel beneath your feet trembles. Then the channel just to the "
	EQUAL?	HERE,AQ-2 \?ELS27
	PRINTI	"north"
	JUMP	?CND25
?ELS27:	PRINTI	"south"
?CND25:	PRINTI	" collapses and falls into the chasm!"
	CRLF	
?CND12:	SET	'CLEFT-FLAG,TRUE-VALUE
	FCLEAR	CLEFT,INVISIBLE
	SET	'AQ-FLAG,FALSE-VALUE
	RTRUE	


	.FUNCT	CLEFT-F
	EQUAL?	YEAR,YEAR-PRESENT /FALSE
	PRINTR	"There is no cleft here."


	.FUNCT	MUSEUM-ANTE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	CLEFT-FLAG /?ELS10
	PRINTR	"This is the south end of a monumental hall, full of debris from a recent earthquake. To the east is a great iron door, rusted shut. To its right, however, is a gaping cleft in the rock and behind, a cleared area."
?ELS10:	PRINTR	"You are in the southern half of a monumental hall. To the east lies a tremendous iron door which appears to be rusted shut."


	.FUNCT	DDESC,STR1,DOOR,STR2
	PRINT	STR1
	FSET?	DOOR,OPENBIT \?ELS5
	PRINTI	"open"
	JUMP	?CND3
?ELS5:	PRINTI	"closed"
?CND3:	PRINT	STR2
	CRLF	
	RTRUE	


	.FUNCT	MUSEUM-ENTRANCE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	FSET?	CAGE,INVISIBLE \?ELS10
	PRINTR	"This is an entrance hall of some sort, judging by the grand iron door to the west, and the ornate stone and wooden doors which lead to the east and north, respectively. A few wide steps lead south."
?ELS10:	PRINTI	"This is the entrance to the Royal Museum, the finest and grandest in the Great Underground Empire. To the south, down a few steps, is the entrance to the Royal Puzzle and to the east, through a stone door, is the Royal Jewel Collection. A wooden door to the north is "
	FSET?	WOODEN-DOOR,OPENBIT \?ELS23
	PUSH	STR?117
	JUMP	?CND19
?ELS23:	PUSH	STR?118
?CND19:	PRINT	STACK
	PRINTI	" and leads to the Museum of Technology. "
	EQUAL?	YEAR,YEAR-PRESENT \?ELS30
	PRINTR	"To the west is a great iron door, rusted shut. To its left, however, is a cleft in the rock providing an exit from the museum."
?ELS30:	LESS?	YEAR,YEAR-PRESENT \?ELS34
	PRINTR	"To the west is a great iron door, rusted shut."
?ELS34:	PRINTR	"To the west is a great iron door, rusted shut. The cleft in the rock, present when you started, has filled in with rubble."


	.FUNCT	TIME-MACHINE-F,RARG=0
	EQUAL?	RARG,M-OBJDESC \?ELS5
	PRINTI	"Directly in front of you is a large golden machine, which has a seat with a console in front. On the console is a single button and a dial connected to a three-digit display which reads "
	PRINTN	TM-YEAR
	PRINTR	". The machine is suprisingly shiny and shows few signs of age."
?ELS5:	EQUAL?	RARG,M-BEG \?ELS9
	EQUAL?	PRSA,V?MOVE \?ELS14
	PRINTR	"You might be able to move the machine by pushing it."
?ELS14:	EQUAL?	PRSA,V?PUSH-TO \?ELS18
	EQUAL?	PRSO,TIME-MACHINE \?ELS18
	PRINTR	"That would be a good trick from inside it."
?ELS18:	EQUAL?	PRSA,V?WALK \?ELS24
	PRINTR	"You're not going anywhere in this heap."
?ELS24:	EQUAL?	PRSA,V?MOVE,V?PUT,V?TAKE /?THN31
	EQUAL?	PRSA,V?CLOSE,V?OPEN,V?PUSH \FALSE
?THN31:	CALL	HELD?,PRSO
	ZERO?	STACK \FALSE
	IN?	PRSO,TIME-MACHINE /FALSE
	PRINTR	"You can't do that from inside the machine."
?ELS9:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?PUT \?ELS41
	EQUAL?	PRSI,TIME-MACHINE \?ELS41
	PRINTR	"You can't put anything on or inside the machine itself."
?ELS41:	EQUAL?	PRSO,TIME-MACHINE \FALSE
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS52
	PRINTR	"This is a machine, not a box."
?ELS52:	EQUAL?	PRSA,V?EXAMINE \?ELS56
	PRINTI	"The machine consists of a seat and a console containing one small button and a dial connected to a display which reads "
	PRINTN	TM-YEAR
	PRINTR	"."
?ELS56:	EQUAL?	PRSA,V?BOARD \?ELS60
	FIRST?	TM-SEAT \?ELS60
	PRINTR	"That will be somewhat uncomfortable!"
?ELS60:	EQUAL?	PRSA,V?RAISE,V?TAKE \?ELS66
	PRINTR	"The machine must weigh hundreds of pounds and cannot be carried."
?ELS66:	EQUAL?	PRSA,V?MOVE,V?PUSH \?ELS70
	PRINTR	"You should specify in which direction to push the machine."
?ELS70:	EQUAL?	PRSA,V?PUSH-TO \FALSE
	CALL	DO-WALK,P-DIRECTION
	EQUAL?	STACK,M-FATAL /TRUE
	PRINTI	"With some effort, you push the machine into the room with you."
	CRLF	
	EQUAL?	HERE,CP-ANTE,MID-CP-ANTE \?ELS82
	PRINTI	"However, the machine seems to have sustained some damage as a result of going over the stairs."
	CRLF	
	SET	'MACHINE-DAMAGED,TRUE-VALUE
	JUMP	?CND80
?ELS82:	EQUAL?	HERE,MUSEUM-ANTE \?CND80
	PRINTI	"Pushing the machine through the cleft seems to have damaged it."
	CRLF	
	SET	'MACHINE-DAMAGED,TRUE-VALUE
?CND80:	MOVE	TIME-MACHINE,HERE
	RTRUE	


	.FUNCT	TM-SEAT-F
	EQUAL?	PRSA,V?BOARD,V?CLIMB-ON \?ELS5
	CALL	PERFORM,V?BOARD,TIME-MACHINE
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?PUT-BEHIND,V?PUT-UNDER \?ELS7
	EQUAL?	PRSI,TM-SEAT \?ELS7
	EQUAL?	PRSO,RING \?ELS14
	PRINTI	"The ring is concealed underneath the seat."
	CRLF	
	SET	'RING-CONCEALED,TRUE-VALUE
	REMOVE	RING
	RTRUE	
?ELS14:	PRINTR	"It's too big to hide under the seat."
?ELS7:	EQUAL?	PRSA,V?RUB \?ELS22
	PRINTR	"There's nothing odd about the feel of the seat."
?ELS22:	EQUAL?	PRSA,V?MOVE,V?RAISE,V?LOOK-UNDER \FALSE
	ZERO?	RING-CONCEALED /?ELS31
	PRINTI	"You find the ring under the seat and put it on your finger."
	CRLF	
	MOVE	RING,WINNER
	SET	'RING-CONCEALED,FALSE-VALUE
	RTRUE	
?ELS31:	PRINTR	"You notice a small hollow area under the seat."


	.FUNCT	TM-DIAL-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The dial is set to "
	PRINTN	TM-YEAR
	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?TURN \FALSE
	EQUAL?	PRSI,INTNUM \?ELS14
	GRTR?	P-NUMBER,999 \?ELS19
	PRINTR	"You can't set it beyond 999."
?ELS19:	SET	'TM-YEAR,P-NUMBER
	PRINTI	"The dial is set to "
	PRINTN	TM-YEAR
	PRINTR	"."
?ELS14:	ZERO?	PRSI \?ELS27
	PRINTR	"You have to say what to turn it to!"
?ELS27:	PRINTR	"You can't do that!"


	.FUNCT	TM-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	TM-YEAR,YEAR-BUILT \?CND6
	ZERO?	TM-POINT \?CND6
	INC	'SCORE
	SET	'TM-POINT,TRUE-VALUE
?CND6:	ZERO?	MACHINE-DAMAGED \?THN16
	IN?	WINNER,TIME-MACHINE /?ELS15
?THN16:	PRINTR	"Nothing seems to have happened."
?ELS15:	LESS?	TM-YEAR,YEAR-BUILT \?ELS21
	CALL	REALLY-DEAD,STR?119
	RSTACK	
?ELS21:	EQUAL?	YEAR,TM-YEAR \?ELS23
	PRINTR	"Nothing seems to have happened."
?ELS23:	LESS?	TM-YEAR,YEAR-CLOSED \?ELS27
	PRINTI	"You experience a brief period of disorientation. When your vision returns, "
	EQUAL?	HERE,MUSEUM-ENTRANCE,MID-MUSEUM-ENTRANCE,OLD-MUSEUM-ENTRANCE \?ELS34
	EQUAL?	TM-YEAR,YEAR-CAGED \?ELS39
	PRINTI	"you are surrounded by a number of heavily armed guards, the dress and speech of which seem strange and unfamiliar. A commotion starts at a door to the east and a person with a flat head, wearing a gaudy crown and a purple robe, bursts into the room."
	CRLF	
	CALL	FLATHEAD-SENTENCE
	RSTACK	
?ELS39:	CALL	GUARDS-KILL
	RSTACK	
?ELS34:	EQUAL?	HERE,JEWEL-ROOM,MID-JEWEL-ROOM,OLD-JEWEL-ROOM \?ELS45
	EQUAL?	TM-YEAR,YEAR-CAGED \?ELS50
	PRINTI	"you find yourself in the middle of some kind of ceremony, with a strange flat-headed man wearing royal vestments about to break a bottle on the bars of an iron cage containing magnificent jewels. He appears pleased by your presence. "
	CALL	FLATHEAD-SENTENCE
	RSTACK	
?ELS50:	GRTR?	TM-YEAR,YEAR-CAGED \?ELS54
	CALL	GUARDS-KILL
	RSTACK	
?ELS54:	PRINT	SURROUNDINGS-CHANGED
	CRLF	
	CALL	TGOTO,OLD-JEWEL-ROOM
	RSTACK	
?ELS45:	EQUAL?	HERE,TECH-MUSEUM,MID-TECH-MUSEUM,OLD-TECH-MUSEUM \FALSE
	EQUAL?	TM-YEAR,YEAR-BUILT /?ELS65
	CALL	GUARDS-KILL
	RSTACK	
?ELS65:	PRINT	SURROUNDINGS-CHANGED
	CRLF	
	CALL	TGOTO,OLD-TECH-MUSEUM
	RSTACK	
?ELS27:	CALL	HAPPY-NEW-YEAR
	RSTACK	


	.FUNCT	HAPPY-NEW-YEAR
	PRINTI	"You experience a brief period of disorientation. When your vision returns, your surroundings appear somewhat altered."
	CRLF	
	EQUAL?	HERE,OLD-JEWEL-ROOM,MID-JEWEL-ROOM,JEWEL-ROOM \?ELS7
	LESS?	TM-YEAR,YEAR-PRESENT \?ELS12
	CALL	TGOTO,MID-JEWEL-ROOM
	RSTACK	
?ELS12:	CALL	TGOTO,JEWEL-ROOM
	RSTACK	
?ELS7:	EQUAL?	HERE,OLD-TECH-MUSEUM,MID-TECH-MUSEUM,TECH-MUSEUM \?ELS16
	LESS?	TM-YEAR,YEAR-PRESENT \?ELS21
	CALL	TGOTO,MID-TECH-MUSEUM
	RSTACK	
?ELS21:	CALL	TGOTO,TECH-MUSEUM
	RSTACK	
?ELS16:	LESS?	TM-YEAR,YEAR-PRESENT \?ELS25
	CALL	TGOTO,MID-MUSEUM-ENTRANCE
	RSTACK	
?ELS25:	CALL	TGOTO,MUSEUM-ENTRANCE
	RSTACK	


	.FUNCT	I-SNAP
	EQUAL?	YEAR,YEAR-PRESENT /FALSE
	SET	'TM-YEAR,YEAR-PRESENT
	PRINTI	"You start to feel light-headed and quickly become completely disoriented. When your head clears, you realize that your surroundings have changed."
	CRLF	
	CALL	TGOTO,SNAP-LOC,TRUE-VALUE
	RSTACK	


	.FUNCT	MOVE-JEWELS
	EQUAL?	TM-YEAR,YEAR-BUILT \?ELS3
	MOVE	PEDESTAL,OLD-JEWEL-ROOM
	JUMP	?CND1
?ELS3:	LESS?	TM-YEAR,YEAR-PRESENT \?ELS5
	MOVE	PEDESTAL,MID-JEWEL-ROOM
	JUMP	?CND1
?ELS5:	MOVE	PEDESTAL,JEWEL-ROOM
?CND1:	ZERO?	RING-STOLEN \TRUE
	MOVE	SCEPTRE,PEDESTAL
	FSET	SCEPTRE,NDESCBIT
	MOVE	JEWELLED-KNIFE,PEDESTAL
	FSET	JEWELLED-KNIFE,NDESCBIT
	ZERO?	RING-CONCEALED \FALSE
	MOVE	RING,PEDESTAL
	FSET	RING,NDESCBIT
	RTRUE	


	.FUNCT	TGOTO,RM=0,SNAP=0
	INC	'MOVES
	CALL	QUEUE,I-GUARDS-LEAVE,0
	SET	'INVIS,FALSE-VALUE
	GRTR?	YEAR,YEAR-BUILT \?CND1
	SET	'GUARDS-PRESENT,TRUE-VALUE
?CND1:	EQUAL?	YEAR,YEAR-PRESENT \?CND4
	SET	'SNAP-LOC,HERE
	CALL	QUEUE,I-SNAP,40
	PUT	STACK,0,1
?CND4:	EQUAL?	TM-YEAR,YEAR-PRESENT \?ELS9
	SET	'CLEFT-FLAG,TRUE-VALUE
	JUMP	?CND7
?ELS9:	SET	'CLEFT-FLAG,FALSE-VALUE
?CND7:	FCLEAR	JEWEL-DOOR,OPENBIT
	FCLEAR	WOODEN-DOOR,OPENBIT
	FCLEAR	IRON-DOOR,OPENBIT
	EQUAL?	YEAR,YEAR-BUILT \?CND12
	ZERO?	RING-CONCEALED /?ELS17
	IN?	TIME-MACHINE,OLD-TECH-MUSEUM \?ELS17
	IN?	SCEPTRE,PEDESTAL \?ELS17
	IN?	JEWELLED-KNIFE,PEDESTAL \?ELS17
	SET	'RING-STOLEN,TRUE-VALUE
	FSET	CAGE,INVISIBLE
	REMOVE	SCEPTRE
	REMOVE	JEWELLED-KNIFE
	JUMP	?CND12
?ELS17:	IN?	TIME-MACHINE,OLD-TECH-MUSEUM \?THN22
	ZERO?	RING-CONCEALED /?ELS21
?THN22:	SET	'CLUMSY-ROBBERY,TRUE-VALUE
	REMOVE	TIME-MACHINE
	JUMP	?CND12
?ELS21:	IN?	RING,PEDESTAL \?THN26
	IN?	SCEPTRE,PEDESTAL \?THN26
	IN?	JEWELLED-KNIFE,PEDESTAL /?CND12
?THN26:	SET	'MYSTERY,TRUE-VALUE
?CND12:	EQUAL?	TM-YEAR,YEAR-BUILT \?CND28
	SET	'MYSTERY,FALSE-VALUE
	SET	'CLUMSY-ROBBERY,FALSE-VALUE
?CND28:	SET	'YEAR,TM-YEAR
	CALL	MOVE-TM-OBJECTS
	CALL	MOVE-JEWELS
	MOVE	WINNER,HERE
	CALL	GOTO,RM,FALSE-VALUE
	EQUAL?	YEAR,YEAR-BUILT \?ELS33
	MOVE	TIME-MACHINE,OLD-TECH-MUSEUM
	MOVE	SPINNER,OLD-TECH-MUSEUM
	MOVE	PRESSURIZER,OLD-TECH-MUSEUM
	MOVE	TECH-PLAQUE,OLD-TECH-MUSEUM
	JUMP	?CND31
?ELS33:	LESS?	YEAR,YEAR-PRESENT \?ELS35
	ZERO?	CLUMSY-ROBBERY \?CND36
	MOVE	TIME-MACHINE,MID-TECH-MUSEUM
?CND36:	MOVE	SPINNER,MID-TECH-MUSEUM
	MOVE	PRESSURIZER,MID-TECH-MUSEUM
	MOVE	TECH-PLAQUE,MID-TECH-MUSEUM
	MOVE	CAGE,MID-JEWEL-ROOM
	JUMP	?CND31
?ELS35:	MOVE	TIME-MACHINE,TECH-MUSEUM
	MOVE	SPINNER,TECH-MUSEUM
	MOVE	PRESSURIZER,TECH-MUSEUM
	MOVE	TECH-PLAQUE,TECH-MUSEUM
	MOVE	CAGE,JEWEL-ROOM
?CND31:	ZERO?	CLUMSY-ROBBERY \?THN44
	EQUAL?	HERE,TECH-MUSEUM,MID-TECH-MUSEUM,OLD-TECH-MUSEUM /?ELS43
?THN44:	ZERO?	SNAP \?CND41
	PRINTI	"You notice that the golden machine has disappeared!"
	CRLF	
	JUMP	?CND41
?ELS43:	MOVE	WINNER,TIME-MACHINE
?CND41:	ZERO?	CLUMSY-ROBBERY /TRUE
	REMOVE	TIME-MACHINE
	RTRUE	


	.FUNCT	MOVE-TM-OBJECTS,F,MFLG=0,WFLG=0,N
	FIRST?	TIME-MACHINE >F /?KLU53
?KLU53:	ZERO?	F /?CND1
?PRG5:	EQUAL?	F,TM-DIAL,TM-SEAT,TM-BUTTON /?CND7
	EQUAL?	F,PLAYER \?ELS9
	JUMP	?CND7
?ELS9:	ZERO?	MFLG \?CND7
	SET	'MFLG,TRUE-VALUE
	PRINTI	"You notice that everything in the machine is gone"
?CND7:	NEXT?	F >N /?KLU54
?KLU54:	EQUAL?	F,TM-DIAL,TM-SEAT,TM-BUTTON /?CND16
	MOVE	F,HERE
?CND16:	SET	'F,N
	ZERO?	F \?PRG5
?CND1:	FIRST?	WINNER >F /?KLU55
?KLU55:	ZERO?	F /?CND22
?PRG26:	ZERO?	WFLG \?CND28
	SET	'WFLG,TRUE-VALUE
	ZERO?	MFLG /?ELS33
	PRINTI	": come to mention it, everything you were holding has vanished too"
	JUMP	?CND28
?ELS33:	PRINTI	"You notice that everything you were holding is gone"
?CND28:	NEXT?	F >N /?KLU56
?KLU56:	MOVE	F,HERE
	SET	'F,N
	ZERO?	F \?PRG26
?CND22:	ZERO?	MFLG \?THN49
	ZERO?	WFLG /FALSE
?THN49:	PRINTR	"!"


	.FUNCT	GUARDS-KILL
	CALL	PICK-ONE,GUARD-KILLERS
	PRINT	STACK
	CRLF	
	CALL	REALLY-DEAD,STR?10
	RSTACK	


	.FUNCT	FLATHEAD-SENTENCE
	CALL	REALLY-DEAD,STR?124
	RSTACK	


	.FUNCT	REALLY-DEAD,STR
	PRINT	STR
	PRINTI	"

****  You have died  ****

"
	CALL	FINISH
	RSTACK	


	.FUNCT	HEAR-FLATHEAD
	SET	'FLATHEAD-HEARD,TRUE-VALUE
	PRINTR	"One particularly loud and grating voice can be heard above the others outside the room. ""Very nice! Very nice! Not enough security, but very nice! Now, Lord Feepness, pay attention! I've been thinking that what we need is a dam, a tremendous dam to control the Frigid River, with thousands of gates. We shall call it ... Flood Control Dam #2. No, not quite right. Aha! Flood Control Dam #3."" ""Pardon me, my Lord, but wouldn't that be just a tad excessive?"" ""Nonsense! Now, let me tell you my idea for hollowing out volcanoes..."" With that, the voices trail out nothingness."


	.FUNCT	OLD-TECH-MUSEUM-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	EQUAL?	HERE,OLD-JEWEL-ROOM \?ELS5
	PRINTI	"You are in a high-ceilinged chamber, in the center of which is a pedestal which "
	ZERO?	RING-STOLEN \?ELS12
	PRINTI	"is the intended home of the Crown Jewels of the Great Underground Empire: a jewelled knife, a golden ring, and the royal sceptre."
	IN?	SCEPTRE,PEDESTAL \?THN18
	IN?	RING,PEDESTAL \?THN18
	IN?	JEWELLED-KNIFE,PEDESTAL /?CND10
?THN18:	PRINTI	" Not all of the jewels are in place, however."
	JUMP	?CND10
?ELS12:	PRINTI	"is bare."
?CND10:	PRINTI	" The room is, by appearances, unfinished."
	CRLF	
	ZERO?	GUARDS-PRESENT /TRUE
	PRINT	HEAR-VOICES
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	RARG,M-LOOK \?ELS35
	EQUAL?	HERE,OLD-TECH-MUSEUM \?ELS38
	PRINTI	"You are in a large, unfinished room, probably intended to be a part of the Royal Museum."
	CRLF	
	JUMP	?CND36
?ELS38:	PRINTI	"This appears to be an unfinished entranceway to the Royal Museum. There are doors to the east and north, and a blind stairway to the south. A heavy iron door to the west is closed and locked."
	CRLF	
?CND36:	ZERO?	GUARDS-PRESENT /TRUE
	PRINT	HEAR-VOICES
	CRLF	
	RTRUE	
?ELS35:	EQUAL?	RARG,M-END \?ELS52
	ZERO?	FLATHEAD-HEARD \?ELS52
	ZERO?	GUARDS-PRESENT /?ELS52
	RANDOM	100
	GRTR?	6,STACK \?ELS52
	CALL	HEAR-FLATHEAD
	RSTACK	
?ELS52:	EQUAL?	RARG,M-ENTER \?ELS56
	ZERO?	GUARDS-PRESENT /?ELS56
	RANDOM	12
	ADD	3,STACK
	CALL	QUEUE,I-GUARDS-LEAVE,STACK
	PUT	STACK,0,1
	RTRUE	
?ELS56:	EQUAL?	RARG,M-BEG \?ELS60
	EQUAL?	PRSA,V?OPEN \?ELS60
	EQUAL?	PRSO,WOODEN-DOOR,JEWEL-DOOR \?ELS60
	ZERO?	GUARDS-PRESENT /?ELS60
	PRINTR	"You open the door ever so slightly and see dozens of armed officials. You shut the door quickly, realizing that you would be killed in an instant if you left the room."
?ELS60:	EQUAL?	RARG,M-BEG \FALSE
	ZERO?	GUARDS-PRESENT /FALSE
	RANDOM	100
	GRTR?	3,STACK \FALSE
	CALL	GUARD-CAUGHT
	RSTACK	


	.FUNCT	I-GUARDS-LEAVE
	SET	'GUARDS-PRESENT,FALSE-VALUE
	PRINTR	"You hear, from outside the door, guards marching away, their voices fading. After a few moments, a booming crash signals the close of what must be a tremendous door. Then there is silence."


	.FUNCT	GUARD-CAUGHT
	CALL	REALLY-DEAD,STR?126
	RSTACK	


	.FUNCT	ROBOT-F
	EQUAL?	PRSA,V?FOLLOW \?ELS5
	PRINTR	"It moved quickly and left the door closed."
?ELS5:	PRINTR	"There is no robot here."


	.FUNCT	JEWEL-ROOM-F,RARG
	EQUAL?	RARG,M-END \?ELS5
	IN?	TIME-MACHINE,HERE \?ELS5
	RANDOM	100
	GRTR?	4,STACK \?ELS5
	PRINTI	"An odd robot-like device glides in, dusting the floor as it moves. Its head gyrates briefly as it scans the machine. ""Shame. Shame,"" it says, rather tinnily. ""Someone has been tampering with the machines again."" Six beady mechanical eyes focus on you as the robot picks up the gold machine. ""Hands off, adventurer!"" it says as it leaves the room, closing the door behind it."
	CRLF	
	FCLEAR	JEWEL-DOOR,OPENBIT
	FCLEAR	WOODEN-DOOR,OPENBIT
	MOVE	TIME-MACHINE,TECH-MUSEUM
	RTRUE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a high-ceilinged chamber"
	FSET?	CAGE,INVISIBLE /?ELS18
	PRINTR	" in the middle of which sits a tall, round steel cage, which is securely locked. In the middle of the cage is a pedestal on which sit the Crown Jewels of the Great Underground Empire: a sceptre, a jewelled knife, and a golden ring. A small bronze plaque, now tarnished, is on the cage."
?ELS18:	PRINTR	" in the middle of which is a bare pedestal. The room is unfinished with no indication of its purpose. A small plaque is fastened to a wall."


	.FUNCT	CROWN-JEWELS-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	CALL	HELD?,PRSO
	ZERO?	STACK \FALSE
	EQUAL?	YEAR,YEAR-BUILT /?THN13
	FSET?	CAGE,INVISIBLE \?ELS12
?THN13:	FCLEAR	PRSO,NDESCBIT
	RFALSE	
?ELS12:	PRINTR	"The jewels are inside a locked cage."
?ELS5:	EQUAL?	PRSA,V?PUT \?ELS20
	EQUAL?	PRSI,PEDESTAL \?ELS20
	IN?	PRSO,WINNER \?ELS20
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" is now resting on the pedestal."
	CRLF	
	MOVE	PRSO,PEDESTAL
	FSET	PRSO,NDESCBIT
	RTRUE	
?ELS20:	EQUAL?	PRSA,V?PUT \FALSE
	CALL	HELD?,PRSO
	ZERO?	STACK \FALSE
	PRINTI	"You don't have the "
	PRINTD	PRSO
	PRINTR	"."


	.FUNCT	TECH-MUSEUM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	FSET?	CAGE,INVISIBLE \?ELS10
	CALL	DDESC,STR?127,WOODEN-DOOR,STR?128
	RSTACK	
?ELS10:	CALL	DDESC,STR?129,WOODEN-DOOR,STR?128
	RSTACK	


	.FUNCT	PLAQUE-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	ZERO?	RING-STOLEN /?CND6
	PRINTR	"The plaque explains that this room was to be the home of the Crown Jewels of the Empire. However, following the unexplained disappearance of a priceless ring during the final stages of construction, Lord Flathead decided to place the remaining jewels in a safer location. Interestingly, he placed his most prized possesion, an incredibly gaudy crown, in a locked safe in a volcano specifically hollowed out for that purpose."
?CND6:	CALL	FIXED-FONT-ON
	PRINTI	"
         Crown Jewels

  Presented To The Royal Museum
      By His Gracious Lord

        DIMWIT FLATHEAD

          Dedicated
         * 777 GUE *"
	CALL	FIXED-FONT-OFF
	ZERO?	CLUMSY-ROBBERY /?ELS16
	CRLF	
	CRLF	
	PRINTI	"Underneath the plaque, in small lettering, is a description of a clumsy attempt to steal the jewels using a time machine from the Technological Museum which the curators were surprised to discover was not a nonworking model. After the attempt, the machine was removed from the exhibit."
	JUMP	?CND14
?ELS16:	ZERO?	MYSTERY /?CND14
	CRLF	
	CRLF	
	PRINTI	"Underneath the plaque, in small lettering, is a description of a mysterious happening during the final stages of construction of the Museum, in which some of the crown jewels were found displaced from their proper positions. Fortunately, nothing was missing. The mystery was never solved and the museum was opened despite the objections of Lord Flathead that security was too lax."
?CND14:	CRLF	
	RTRUE	


	.FUNCT	WOODEN-DOOR-F
	EQUAL?	PRSA,V?LISTEN \?ELS5
	ZERO?	GUARDS-PRESENT /?ELS5
	CALL	PERFORM,V?LISTEN,VOICES
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?KNOCK \FALSE
	ZERO?	GUARDS-PRESENT /FALSE
	PRINTR	"You realize that calling attention to yourself would be fatal."


	.FUNCT	JEWEL-DOOR-F
	EQUAL?	PRSA,V?KNOCK \?ELS5
	ZERO?	GUARDS-PRESENT /?ELS5
	CALL	PERFORM,V?KNOCK,WOODEN-DOOR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	FSET?	JEWEL-DOOR,OPENBIT \?ELS14
	PRINTR	"It is already open."
?ELS14:	EQUAL?	YEAR,YEAR-BUILT \?ELS18
	EQUAL?	HERE,OLD-MUSEUM-ENTRANCE \?ELS18
	PRINTR	"The door is locked, probably by the guards on their way out."
?ELS18:	PRINTI	"The door is now open."
	CRLF	
	FSET	JEWEL-DOOR,OPENBIT
	RTRUE	


	.FUNCT	CAGE-F
	EQUAL?	PRSA,V?OPEN \?ELS5
	PRINTR	"The cage is locked."
?ELS5:	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINTR	"The cage is already closed."


	.FUNCT	VOICES-F
	ZERO?	GUARDS-PRESENT /?ELS5
	EQUAL?	YEAR,YEAR-BUILT \?ELS5
	PRINTI	"The voices are muffled by the door which (fortunately for you) separates you. They seem to be in heated debate on the topic of "
	CALL	PICK-ONE,BLATHER
	PRINT	STACK
	PRINTR	"."
?ELS5:	PRINTR	"Are you hearing things now?"


	.FUNCT	MUSEUM-PIECES,RARG=0
	EQUAL?	RARG,M-OBJDESC \?ELS5
	EQUAL?	DESC-OBJECT,SPINNER /TRUE
	PRINTI	"A strange grey machine, shaped somewhat like a clothes dryer, is on one side of the room. On the other side of the hall is a powerful-looking black machine, a tight tangle of wires, pipes, and motors.
A plaque is mounted near the door."
	LESS?	YEAR,YEAR-CLOSED \?ELS15
	PRINTR	" The grey machine, it turns out, is a Frobozz Magic Pressurizer, used in the coal mines of the Empire. The black machine is a Frobozz Magic Room Spinner. The golden machine is referred to as a Temporizer. All are nonworking models donated by Frobozzco president John D. Flathead."
?ELS15:	PRINTR	" The writing is faded, however, and cannot be made out clearly. The two machines seem to be in bad shape, rusting in many spots."
?ELS5:	EQUAL?	PRSA,V?MOVE,V?TAKE \?ELS23
	PRINTR	"It's massive and cannot even be moved."
?ELS23:	EQUAL?	PRSA,V?PUSH-TO,V?PUSH \?ELS27
	PRINTR	"It's too heavy to be pushed."
?ELS27:	EQUAL?	PRSA,V?MUNG \?ELS31
	PRINTR	"It seems quite indestructible."
?ELS31:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,SPINNER,PRESSURIZER \FALSE
	PRINTR	"There's no good place to put anything there."


	.FUNCT	TECH-PLAQUE-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"It's bolted to the wall."
?ELS5:	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	LESS?	YEAR,YEAR-CLOSED \?ELS14
	PRINTR	"The plaque merely identifies the machines and names their donor. They are nonworking models of existing state-of-the-art machinery."
?ELS14:	PRINTR	"The words cannot be made out."


	.FUNCT	PEDESTAL-F
	EQUAL?	PRSA,V?LOOK-ON,V?EXAMINE \?ELS5
	FIRST?	PEDESTAL \FALSE
	PRINTR	"The Royal Jewels are on the pedestal."
?ELS5:	EQUAL?	PRSA,V?TAKE,V?PUT-ON,V?PUT \FALSE
	FSET?	CAGE,INVISIBLE /FALSE
	PRINTR	"You can't reach it through the cage."


	.FUNCT	PICK-DIRECTION,RM,NXT=0,CNT=0,OFFS=0
?PRG1:	NEXTP	RM,NXT >NXT
	ZERO?	NXT \?ELS5
	JUMP	?REP2
?ELS5:	LESS?	NXT,LOW-DIRECTION /?PRG1
	EQUAL?	NXT,P?UP,P?DOWN /?PRG1
	INC	'OFFS
	PUT	DIR-TBL,OFFS,NXT
	INC	'CNT
	JUMP	?PRG1
?REP2:	RANDOM	CNT
	GET	DIR-TBL,STACK
	RSTACK	


	.FUNCT	SHADOW-F,RARG=0
	EQUAL?	RARG,M-OBJDESC \?ELS5
	ZERO?	BLOCKED-DIR \?CND6
	CALL	PICK-DIRECTION,HERE >BLOCKED-DIR
?CND6:	PRINTI	"A cloaked and hooded person, carrying a sword not unlike your own,"
	GRTR?	S-STRENGTH,3 \?ELS13
	PRINTI	" is standing blocking the way to the "
	CALL	LKP,BLOCKED-DIR,DIRS
	PRINT	STACK
	PRINTI	"."
	CRLF	
	JUMP	?CND11
?ELS13:	PRINTI	" is here."
	CRLF	
?CND11:	PRINTI	"The hooded figure"
	GET	SHADOW-DIAG,S-STRENGTH
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?GIVE \?ELS25
	EQUAL?	PRSI,SHADOW \?ELS25
	PRINTR	"The hooded figure isn't interested in your gifts."
?ELS25:	CALL	HELLO?,SHADOW
	ZERO?	STACK /?ELS31
	PRINTR	"The hooded figure does not respond to your words."
?ELS31:	EQUAL?	PRSA,V?ATTACK \?ELS35
	EQUAL?	PRSI,SWORD \?ELS35
	ZERO?	SHADOW-POINT-2 \?CND38
	INC	'SCORE
	SET	'SHADOW-POINT-2,TRUE-VALUE
?CND38:	CALL	SHADOW-ATTACK
	RSTACK	
?ELS35:	EQUAL?	PRSA,V?ATTACK \FALSE
	PRINTI	"The hooded figure ignores your feeble attack."
	CRLF	
	SET	'ATTACK-MODE,TRUE-VALUE
	CALL	QUEUE,I-CURE,10
	PUT	STACK,0,1
	CALL	QUEUE,I-SHADOW-REPLY,-1
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-CURE
	EQUAL?	P-STRENGTH,5 /?CND1
	INC	'P-STRENGTH
?CND1:	EQUAL?	S-STRENGTH,5 /?CND4
	INC	'S-STRENGTH
?CND4:	ADD	P-STRENGTH,S-STRENGTH
	EQUAL?	STACK,10 /FALSE
	CALL	QUEUE,I-CURE,10
	RFALSE	


	.FUNCT	SHADOW-ATTACK,?TMP1
	ZERO?	ATTACK-MODE \?CND1
	CALL	QUEUE,I-CURE,10
	PUT	STACK,0,1
	SET	'ATTACK-MODE,TRUE-VALUE
	CALL	QUEUE,I-SHADOW-REPLY,-1
	PUT	STACK,0,1
?CND1:	MUL	P-STRENGTH,10
	ADD	STACK,10 >?TMP1
	RANDOM	100
	GRTR?	?TMP1,STACK \?ELS8
	RANDOM	100
	GRTR?	85,STACK \?ELS13
	DEC	'S-STRENGTH
	ZERO?	S-STRENGTH \?CND14
	CALL	SHADOW-DIES
	RTRUE	
?CND14:	CALL	PICK-ONE,P-HITS
	PRINT	STACK
	CRLF	
	PRINTI	"The figure"
	GET	SHADOW-DIAG,S-STRENGTH
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS13:	SUB	S-STRENGTH,2 >S-STRENGTH
	ZERO?	S-STRENGTH \?ELS25
	SET	'S-STRENGTH,1
	JUMP	?CND23
?ELS25:	LESS?	S-STRENGTH,1 \?CND23
	CALL	SHADOW-DIES
	RTRUE	
?CND23:	PRINTI	"A sharp thrust and the hooded figure is badly wounded!"
	CRLF	
	PRINTI	"The figure"
	GET	SHADOW-DIAG,S-STRENGTH
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS8:	LESS?	S-STRENGTH,2 \?ELS38
	PRINTR	"Your opponent blocks your attack with its sword."
?ELS38:	CALL	PICK-ONE,P-MISSES
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	I-SHADOW-REPLY,?TMP1
	ZERO?	ATTACK-MODE /?THN4
	IN?	SHADOW,HERE /?CND1
?THN4:	CALL	QUEUE,I-SHADOW-REPLY,0
	SET	'ATTACK-MODE,FALSE-VALUE
	RFALSE	
?CND1:	IN?	SWORD,WINNER /?CND6
	MOVE	SWORD,WINNER
	PRINTI	"Your sword, glowing wildly, leaps into your hand!"
	CRLF	
?CND6:	MUL	S-STRENGTH,10
	ADD	STACK,10 >?TMP1
	RANDOM	100
	GRTR?	?TMP1,STACK \?ELS15
	GRTR?	S-STRENGTH,1 \?ELS15
	RANDOM	100
	GRTR?	90,STACK \?ELS22
	DLESS?	'P-STRENGTH,1 \?ELS27
	SET	'P-STRENGTH,1
	PRINTR	"The hooded figure swings its sword and sends yours flying to the ground. Although you are defenseless, the figure reaches for your sword and hands it back to you, nodding grimly."
?ELS27:	CALL	PICK-ONE,S-HITS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS22:	SUB	P-STRENGTH,2 >P-STRENGTH
	LESS?	P-STRENGTH,1 \?ELS40
	CALL	JIGS-UP,STR?169
	RSTACK	
?ELS40:	PRINTR	"A brilliant feint puts you off guard, and the hooded figure slips its sword between your ribs. You are hurt very badly."
?ELS15:	LESS?	S-STRENGTH,3 \?ELS46
	PRINTR	"The hooded figure attempts a thrust, but its weakened state prevents hitting you."
?ELS46:	CALL	PICK-ONE,S-MISSES
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	SHADOW-DIES
	PRINTI	"The hooded figure, fatally wounded, slumps to the ground. It gazes up at you once, and you catch a brief glimpse of deep and sorrowful eyes. Before you can react, the figure vanishes in a cloud of fetid vapor."
	CRLF	
	REMOVE	SHADOW
	SET	'SHADOW-GONE,TRUE-VALUE
	SET	'BLOCKED-DIR,FALSE-VALUE
	RETURN	BLOCKED-DIR


	.FUNCT	HOOD-F
	EQUAL?	PRSA,V?LOOK-UNDER \?ELS5
	IN?	HOOD,SHADOW \?ELS5
	PRINTR	"The figure's hood casts a dark shadow over its face. There is no way from where you stand to look beneath it."
?ELS5:	EQUAL?	PRSA,V?PUT,V?TAKE \FALSE
	IN?	HOOD,SHADOW \FALSE
	EQUAL?	S-STRENGTH,1 \?ELS18
	PRINTI	"You slowly remove the hood from your badly wounded opponent and recoil in horror at the sight of your own face, weary and wounded. A faint smile comes to the lips and then the face starts to change, very slowly, into that of an old, wizened person. The image fades and with it the body of your hooded opponent. The cloak remains on the ground."
	CRLF	
	REMOVE	SHADOW
	SET	'SHADOW-GONE,TRUE-VALUE
	MOVE	HOOD,WINNER
	FCLEAR	HOOD,NDESCBIT
	MOVE	CLOAK,HERE
	FCLEAR	CLOAK,NDESCBIT
	RTRUE	
?ELS18:	EQUAL?	S-STRENGTH,2 \?ELS22
	PRINTR	"The hooded figure, though recovering from wounds, is strong enough to force you back."
?ELS22:	PRINTR	"You cannot get close enough to the hooded figure to remove the hood."


	.FUNCT	CLOAK-F
	EQUAL?	PRSA,V?LOOK-UNDER \?ELS5
	IN?	CLOAK,SHADOW \?ELS5
	PRINTR	"You cannot get close enough to look underneath the cloak."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	IN?	CLOAK,SHADOW \FALSE
	PRINTR	"The cloak is fastened around the neck of the hooded figure. It would be difficult to remove."


	.FUNCT	SHADOW-ROOMS,RARG
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?WALK \?ELS5
	EQUAL?	PRSO,BLOCKED-DIR \?ELS5
	PRINTR	"Your way is blocked by the hooded figure."
?ELS5:	EQUAL?	RARG,M-END \FALSE
	IN?	SHADOW,HERE /?CND12
	SET	'BLOCKED-DIR,FALSE-VALUE
	REMOVE	SHADOW
?CND12:	ZERO?	SHADOW-GONE \FALSE
	IN?	SHADOW,HERE \?ELS22
	RANDOM	100
	GRTR?	30,STACK \FALSE
	ZERO?	ATTACK-MODE \FALSE
	SET	'ATTACK-MODE,TRUE-VALUE
	CALL	QUEUE,I-CURE,10
	PUT	STACK,0,1
	CALL	QUEUE,I-SHADOW-REPLY,-1
	PUT	STACK,0,1
	RTRUE	
?ELS22:	RANDOM	100
	GRTR?	30,STACK \?ELS31
	PRINTR	"You can hear quiet footsteps nearby."
?ELS31:	RANDOM	100
	GRTR?	30,STACK \FALSE
	ZERO?	LIT /FALSE
	GRTR?	S-STRENGTH,3 \FALSE
	CALL	PICK-DIRECTION,HERE >BLOCKED-DIR
	PRINTI	"Through the shadows, a cloaked and hooded figure appears before you, blocking the "
	CALL	LKP,BLOCKED-DIR,DIRS
	PRINT	STACK
	PRINTI	"ern exit from the room and carrying a brightly glowing sword."
	CRLF	
	CALL	SHADOW-ARRIVAL
	RTRUE	


	.FUNCT	SHADOW-ARRIVAL
	MOVE	SHADOW,HERE
	ZERO?	SHADOW-POINT-1 \?CND1
	INC	'SCORE
	SET	'SHADOW-POINT-1,TRUE-VALUE
?CND1:	IN?	SWORD,WINNER /FALSE
	MOVE	SWORD,WINNER
	ZERO?	SWORD-IN-STONE? /?ELS11
	PRINTI	"From nowhere, the sword from the junction appears in your hand, wildly glowing!"
	CRLF	
	JUMP	?CND9
?ELS11:	PRINTI	"Your sword, glowing wildly, appears in your hand!"
	CRLF	
?CND9:	SET	'SWORD-IN-STONE?,FALSE-VALUE
	RETURN	SWORD-IN-STONE?


	.FUNCT	CREEPY-CRAWL-F,RARG
	EQUAL?	RARG,M-END \FALSE
	SET	'BLOCKED-DIR,FALSE-VALUE
	RTRUE	


	.FUNCT	LEDGE-F
	EQUAL?	HERE,CLIFF-LEDGE \FALSE
	EQUAL?	PRSA,V?THROW-OFF \FALSE
	EQUAL?	PRSI,LEDGE \FALSE
	IN?	PRSO,WINNER /?CND8
	PRINTR	"You're not holding that!"
?CND8:	MOVE	PRSO,CLIFF-BASE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" falls to the base of the cliff below."


	.FUNCT	WAYBREAD-F
	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,SWORD \FALSE
	PRINTI	"The bread is crushed rather than cut by your sword, and the crumbs scatter to the wind."
	CRLF	
	REMOVE	WAYBREAD
	RTRUE	


	.FUNCT	STAFF-F
	EQUAL?	PRSA,V?BURN \FALSE
	EQUAL?	PRSI,TORCH \FALSE
	REMOVE	PRSO
	CALL	JIGS-UP,STR?200
	RSTACK	


	.FUNCT	I-MAN-APPEARS
	EQUAL?	HERE,CLIFF-LEDGE \FALSE
	LOC	CHEST
	EQUAL?	STACK,CLIFF-LEDGE,WINNER \FALSE
	ZERO?	CHEST-TIED /?ELS9
	SET	'MAN-SEEN,TRUE-VALUE
	PRINTI	"All at once, the chest is lifted from you. Looking up, you see a man at the top of the cliff, pulling intently at the rope. ""That is uncommonly good of you, I do say!"" He chuckles unpleasantly. ""Oh, you are stuck, aren't you. Well, I'll be right back to get you!"" He leaves your sight."
	CRLF	
	SET	'CHEST-LIFTED,TRUE-VALUE
	MOVE	CHEST,MAN
	FSET	CHEST,TOUCHBIT
	SET	'ROPE-FLAG,FALSE-VALUE
	SET	'CHEST-TIED,FALSE-VALUE
	CALL	QUEUE,I-MAN-RETURNS,10
	PUT	STACK,0,1
	RTRUE	
?ELS9:	PRINTI	"At the edge of the cliff above you, a man appears. He looks down at you and speaks. ""Hello, down there! You seem to have a problem. Maybe I can help you."" He chuckles in an unsettling sort of way. ""Perhaps if you tied that chest to the end of the rope I might be able to drag it up for you. Then, I'll be more than happy to help you up!"" He laughs again."
	CRLF	
	SET	'MAN-FLAG,TRUE-VALUE
	SET	'MAN-SEEN,TRUE-VALUE
	CALL	QUEUE,I-MAN-PRESENT,-1
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-MAN-PRESENT
	EQUAL?	HERE,CLIFF-LEDGE \?THN6
	ZERO?	MAN-FLAG /?THN6
	IN?	CHEST,MAN \?ELS5
?THN6:	CALL	QUEUE,I-MAN-PRESENT,0
	SET	'MAN-FLAG,FALSE-VALUE
	RFALSE	
?ELS5:	IGRTR?	'MAN-WAITING,10 \?ELS9
	PRINTI	"The man looks quite displeased. ""All right, then. I guess someone else can always help me! See you around, sport!"" He disappears."
	CRLF	
	CALL	QUEUE,I-MAN-PRESENT,0
	SET	'MAN-FLAG,FALSE-VALUE
	RTRUE	
?ELS9:	CALL	PICK-ONE,MAN-WAITS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	CLIFF-BASE-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	ZERO?	CHEST-TIED /FALSE
	SET	'CHEST-TIED,FALSE-VALUE
	SET	'ROPE-FLAG,FALSE-VALUE
	CALL	QUEUE,I-MAN-APPEARS,0
	RSTACK	


	.FUNCT	CLIFF-LEDGE-F,RARG
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?WALK \?ELS5
	IN?	CHEST,WINNER \?ELS5
	ZERO?	CHEST-TIED /?ELS5
	PRINTR	"You can't go anywhere holding that chest. The rope is tied around it!"
?ELS5:	EQUAL?	RARG,M-ENTER \?ELS11
	ZERO?	MAN-SEEN \?ELS11
	ZERO?	MAN-FLAG \?ELS11
	ZERO?	MAN-GONE \?ELS11
	ZERO?	MAN-POINT \?CND14
	INC	'SCORE
	SET	'MAN-POINT,TRUE-VALUE
?CND14:	CALL	QUEUE,I-MAN-APPEARS,5
	PUT	STACK,0,1
	RTRUE	
?ELS11:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a rock-strewn ledge near the base of a tall cliff. The bottom of the cliff is another fifteen feet below. You have little hope of climbing up the cliff face, but you might be able to scramble down from here (though it's doubtful you could return)."
	CRLF	
	ZERO?	ROPE-FLAG /TRUE
	PRINTR	"A long piece of rope is dangling down from the top of the cliff and is within your reach."


	.FUNCT	CLIFF-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	IN?	CHEST,MAN \?ELS5
	CALL	QUEUE,I-MAN-RETURNS,0
	MOVE	CHEST,HERE
	FSET	CHEST,OPENBIT
	SET	'ROPE-FLAG,TRUE-VALUE
	SET	'CHEST-TIED,FALSE-VALUE
	SET	'CHEST-OPENED,TRUE-VALUE
	RFALSE	
?ELS5:	EQUAL?	RARG,M-LOOK \?ELS9
	PRINTI	"This is a remarkable spot in the dungeon. Perhaps two hundred feet above you is a gaping hole in the earth's surface through which pours bright sunshine! A few seedlings from the world above, nurtured by the sunlight and occasional rains, have grown into giant trees, making this a virtual oasis in the desert of the Underground Empire. To the west is a sheer precipice, dropping nearly fifty feet to jagged rocks below. The way south is barred by a forbidding stone wall, crumbling from age. There is a jagged opening in the wall to the southwest, through which leaks a fine mist. The land to the east looks lifeless and barren."
	CRLF	
	ZERO?	ROPE-FLAG /TRUE
	PRINTR	"A rope is tied to one of the large trees here and is dangling over the side of the cliff, reaching down to the shelf below."
?ELS9:	EQUAL?	RARG,M-END \?ELS19
	RANDOM	100
	GRTR?	15,STACK \?ELS19
	FSET?	CLIFF-LEDGE,TOUCHBIT /?ELS19
	PRINTR	"You catch, out of the corner of your eye, some movement among the trees."
?ELS19:	EQUAL?	RARG,M-END \FALSE
	RANDOM	100
	GRTR?	20,STACK \FALSE
	PRINTR	"You seem to hear, from the southwest, the sounds of the sea."


	.FUNCT	GLOBAL-ROPE-F
	ZERO?	ROPE-FLAG \?ELS5
	PRINTR	"You can't see any rope here."
?ELS5:	EQUAL?	PRSA,V?CLIMB-FOO \?ELS9
	CALL	V-CLIMB-UP,P?DOWN,TRUE-VALUE
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?CLIMB-ON,V?MOVE,V?TAKE \?ELS11
	ZERO?	MAN-FLAG \?ELS16
	PRINTR	"A short tug on the rope convinces you that it is securely fastened from above."
?ELS16:	IN?	CHEST,MAN \?ELS20
	SET	'HOLDING-ROPE,TRUE-VALUE
	PRINTR	"You grab securely on to the rope."
?ELS20:	PRINTR	"The man scowls. ""I may help you up, but not before I have that chest."" He points to the chest near you on the ledge."
?ELS11:	EQUAL?	PRSA,V?CLIMB-UP \?ELS28
	PRINTR	"You try to climb the rope, but you cannot reach the top even with your best effort."
?ELS28:	EQUAL?	PRSA,V?TIE \?ELS32
	EQUAL?	CHEST,PRSO,PRSI \?ELS37
	PRINTI	"The chest is now tied to the rope."
	CRLF	
	SET	'CHEST-TIED,TRUE-VALUE
	ZERO?	MAN-FLAG /TRUE
	ZERO?	MAN-GONE \TRUE
	PRINTI	"The man above you looks pleased. ""Now there's a good friend! Thank you very much, indeed!"" He pulls on the rope and the chest is lifted to the top of the cliff and out of sight. With a short laugh, he disappears. ""I'll be back in a short while!"" are his last words."
	CRLF	
	MOVE	CHEST,MAN
	FSET	CHEST,TOUCHBIT
	SET	'CHEST-TIED,FALSE-VALUE
	SET	'ROPE-FLAG,FALSE-VALUE
	CALL	QUEUE,I-MAN-RETURNS,10
	PUT	STACK,0,1
	SET	'MAN-FLAG,FALSE-VALUE
	RTRUE	
?ELS37:	EQUAL?	ME,PRSI,PRSO \?ELS48
	ZERO?	MAN-FLAG /?ELS53
	IN?	CHEST,MAN \?ELS53
	PRINTR	"""Just grab onto it!"", the man bellows."
?ELS53:	ZERO?	MAN-FLAG /?ELS59
	PRINTR	"The man looks cross. ""I want the chest, not you!"" he snaps. ""Now stop fooling around and pass it up!"""
?ELS59:	PRINTR	"You're unable to tie the rope around yourself."
?ELS48:	PRINTR	"You're unable to tie the rope to that."
?ELS32:	EQUAL?	PRSA,V?UNTIE \FALSE
	ZERO?	CHEST-TIED /?ELS77
	SET	'CHEST-TIED,FALSE-VALUE
	PRINTR	"The chest is now disconnected from the rope."
?ELS77:	PRINTR	"The rope isn't tied to anything."


	.FUNCT	I-MAN-RETURNS
	SET	'ROPE-FLAG,TRUE-VALUE
	EQUAL?	HERE,CLIFF-LEDGE \FALSE
	PRINTI	"A familiar voice calls down to you. ""Are you still there?"" he bellows with a coarse laugh. ""Well, then, grab onto the rope and we'll see what we can do."" The rope drops to within your reach."
	CRLF	
	SET	'MAN-FLAG,TRUE-VALUE
	CALL	QUEUE,I-MAN-LIFT,-1
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-MAN-LIFT
	EQUAL?	HERE,CLIFF-LEDGE /?ELS5
	CALL	QUEUE,I-MAN-LIFT,0
	MOVE	CHEST,CLIFF
	FSET	CHEST,OPENBIT
	SET	'CHEST-OPENED,TRUE-VALUE
	REMOVE	MAN
	RFALSE	
?ELS5:	ZERO?	HOLDING-ROPE /?ELS7
	PRINTI	"The man starts to heave on the rope and within a few moments you arrive at the top of the cliff. The man removes the last few valuables from the chest and prepares to leave. ""You've been a good sport! Here, take this, for whatever good it is! I can't see that I'll be needing one!"" He hands you a plain wooden staff from the bottom of the chest and begins examining his valuables."
	CRLF	
	CALL	QUEUE,I-MAN-LIFT,0
	MOVE	STAFF,WINNER
	SET	'HOLDING-ROPE,FALSE-VALUE
	SET	'ROPE-FLAG,TRUE-VALUE
	MOVE	WINNER,CLIFF
	MOVE	CHEST,CLIFF
	FSET	CHEST,OPENBIT
	PRINTI	"The chest, open and empty, is at your feet."
	CRLF	
	SET	'CHEST-OPENED,TRUE-VALUE
	MOVE	MAN,CLIFF
	CALL	QUEUE,I-MAN-LEAVES,-1
	PUT	STACK,0,1
	RTRUE	
?ELS7:	IGRTR?	'LIFT-WAIT,4 \?ELS14
	PRINTI	"""Well, I don't have all day. See you around sometime."" Showering you with gravel, he disappears from sight."
	CRLF	
	SET	'MAN-FLAG,FALSE-VALUE
	MOVE	CHEST,CLIFF
	FSET	CHEST,OPENBIT
	SET	'CHEST-OPENED,TRUE-VALUE
	CALL	QUEUE,I-MAN-LIFT,0
	RSTACK	
?ELS14:	PRINTR	"The man appears impatient. ""Are you coming up then, or not?"""


	.FUNCT	CHEST-F
	ZERO?	CHEST-OPENED /?ELS5
	EQUAL?	PRSA,V?TIE \?ELS11
	EQUAL?	ROPE,PRSO,PRSI \?ELS11
	PRINTR	"What's the point?"
?ELS11:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,STAFF,LAMP,TORCH \FALSE
	PRINTI	"It doesn't fit."
	EQUAL?	PRSO,STAFF \?CND22
	PRINTI	" Awfully peculiar, though, since it's where the staff came from."
?CND22:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	ZERO?	MAN-FLAG /?ELS35
	PRINTR	"The man calls down to you. ""Is this what you're looking for?"" he cackles, waving a small key over his head. You try to open the chest, but it is locked."
?ELS35:	PRINTR	"The chest is locked and cannot be opened."


	.FUNCT	I-MAN-LEAVES
	EQUAL?	HERE,CLIFF /?ELS5
	REMOVE	MAN
	SET	'MAN-GONE,TRUE-VALUE
	SET	'MAN-FLAG,FALSE-VALUE
	SET	'ROPE-FLAG,TRUE-VALUE
	CALL	QUEUE,I-MAN-LEAVES,0
	RFALSE	
?ELS5:	RANDOM	100
	GRTR?	40,STACK \?ELS7
	PRINTI	"Your ""friend"", moving quickly, dodges behind some trees and is lost from sight."
	CRLF	
	REMOVE	MAN
	SET	'MAN-FLAG,FALSE-VALUE
	SET	'MAN-GONE,TRUE-VALUE
	SET	'ROPE-FLAG,TRUE-VALUE
	CALL	QUEUE,I-MAN-LEAVES,0
	RTRUE	
?ELS7:	PRINTR	"Your ""friend"" examines his valuables with great pride."


	.FUNCT	MAN-F
	EQUAL?	PRSA,V?HELLO \?ELS5
	PRINTR	"He responds cheerfully. ""It is a wonderful day, isn't it?"""
?ELS5:	CALL	HELLO?,MAN
	ZERO?	STACK /?ELS9
	PRINTR	"The man is thoroughly engrossed in the examination of his booty and doesn't seem to hear you."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	PRINTR	"The man is stocky and of medium height, with several days' growth of stubble on his face. He is carrying a number of valuables under his arm, presumably from the now-open chest."
?ELS13:	EQUAL?	PRSA,V?ATTACK \FALSE
	EQUAL?	PRSI,SWORD \?ELS22
	PRINTI	"The man is taken by surprise and is hit with the sword. He grabs you and throws you to the ground"
	LOC	STAFF
	EQUAL?	STACK,WINNER,HERE \?CND25
	PRINTI	", breaking the staff in the process"
	REMOVE	STAFF
	MOVE	BROKEN-STAFF,HERE
?CND25:	PRINTI	", but you finish him off with a quick thrust to the chest. He dies, and disappears without ceremony in the usual style of the Great Underground Empire. His assorted valuables remain behind."
	CRLF	
	REMOVE	MAN
	MOVE	VALUABLES,HERE
	FCLEAR	VALUABLES,NDESCBIT
	CALL	QUEUE,I-MAN-LEAVES,0
	SET	'MAN-GONE,TRUE-VALUE
	RETURN	MAN-GONE
?ELS22:	PRINTR	"You wouldn't hurt him with that!"


	.FUNCT	VALUABLES-F
	EQUAL?	PRSA,V?MOVE,V?PUT,V?TAKE \?ELS5
	IN?	MAN,CLIFF \?ELS5
	PRINTR	"The man recoils sharply. ""These here things are mine. It's my chest and they're my valuables. You've a lot of nerve trying to take them from me after me saving you like that!"""
?ELS5:	ZERO?	MAN-GONE /FALSE
	IN?	VALUABLES,MAN \FALSE
	PRINTR	"What valuables?"


	.FUNCT	ROPE-F
	EQUAL?	PRSA,V?MOVE,V?TAKE \?ELS5
	ZERO?	ROPE-FLAG /FALSE
	PRINTR	"The rope is tied to a tree."
?ELS5:	EQUAL?	PRSA,V?CLIMB-FOO \?ELS15
	CALL	V-CLIMB-UP,P?DOWN,TRUE-VALUE
	RSTACK	
?ELS15:	EQUAL?	PRSA,V?BURN \?ELS17
	PRINTR	"The rope won't catch fire."
?ELS17:	EQUAL?	PRSA,V?UNTIE \?ELS21
	PRINTR	"The rope is very securely tied and cannot be undone."
?ELS21:	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,SWORD \FALSE
	PRINTR	"The rope is made of pretty tough stuff and won't cut."


	.FUNCT	GLOBAL-MAN-F
	EQUAL?	HERE,CLIFF \?ELS5
	ZERO?	MAN-GONE /?ELS10
	PRINTR	"You've lost him among the trees."
?ELS10:	PRINTR	"You can't see any man here."
?ELS5:	ZERO?	MAN-FLAG \?ELS19
	PRINTR	"You can't see any man here."
?ELS19:	EQUAL?	PRSA,V?GIVE \?ELS23
	PRINTR	"You aren't even close to him!"
?ELS23:	EQUAL?	PRSA,V?HELLO \?ELS27
	PRINTR	"The man waves back in a friendly way."
?ELS27:	CALL	HELLO?,GLOBAL-MAN
	ZERO?	STACK /?ELS31
	PRINTI	"He yells back, ""What's that you say? I can't hear you very well."
	ZERO?	CHEST-LIFTED \?ELS36
	PRINTI	" Just tie the rope to the chest and we can chat afterwards!"" He smiles broadly."
	JUMP	?CND34
?ELS36:	PRINTI	""""
?CND34:	CRLF	
	RTRUE	
?ELS31:	EQUAL?	PRSA,V?MUNG,V?ATTACK \?ELS44
	PRINTR	"It's unlikely you'll succeed at this distance."
?ELS44:	EQUAL?	PRSA,V?THROW \FALSE
	EQUAL?	PRSI,GLOBAL-MAN \FALSE
	IN?	PRSO,WINNER \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" flies upward, but not nearly far enough to hit the man. It does seem to amuse him, however, especially as it passes within inches of your head. ""We're wasting time now. Be a good fellow and tie the rope!"""
	CRLF	
	MOVE	PRSO,HERE
	RTRUE	


	.FUNCT	LAKE-F
	EQUAL?	PRSA,V?BOARD,V?LEAP,V?THROUGH \?ELS5
	EQUAL?	HERE,LAKE-SHORE,FAR-SHORE,SOUTH-SHORE \?ELS10
	CALL	GO-ON-LAKE
	RSTACK	
?ELS10:	EQUAL?	HERE,ON-LAKE \?ELS12
	CALL	GOTO,IN-LAKE
	RSTACK	
?ELS12:	PRINTR	"Just where do you think you are?"
?ELS5:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	EQUAL?	HERE,ON-LAKE \?ELS23
	PRINTR	"You can't quite make out the bottom of the lake from here..."
?ELS23:	PRINTR	"You can't see under the surface from here."


	.FUNCT	IN-LAKE-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	CALL	QUEUE,I-IN-LAKE,3
	PUT	STACK,0,1
	RTRUE	
?ELS5:	EQUAL?	RARG,M-BEG \?ELS7
	EQUAL?	PRSA,V?TAKE \?ELS7
	EQUAL?	PRSO,SHINY-OBJECT /?ELS7
	CALL	WEIGHT,WINNER
	GRTR?	STACK,25 \?ELS14
	PRINTR	"You can't carry that much underwater."
?ELS14:	FSET?	PRSO,TAKEBIT /?ELS18
	PRINTR	"You can't take that!"
?ELS18:	RANDOM	100
	GRTR?	30,STACK \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" is yours for a moment, but drops from your grasp."
?ELS7:	EQUAL?	RARG,M-END \FALSE
	RANDOM	100
	GRTR?	10,STACK \?ELS31
	PRINTR	"A large and hungry-looking fish is swimming in the neighborhood."
?ELS31:	RANDOM	100
	GRTR?	4,STACK \?ELS35
	ZERO?	INVIS \?ELS35
	CALL	QUEUE,I-ROC,0
	CALL	QUEUE,I-ON-LAKE,0
	CALL	JIGS-UP,STR?208
	RSTACK	
?ELS35:	IN?	SHINY-OBJECT,HERE \FALSE
	EQUAL?	MOVES,LAST-MOVES /TRUE
	RANDOM	100
	GRTR?	40,STACK \?ELS44
	PRINTI	"Out of the corner of your eye, a small, shiny object appears in the sand. A moment later, it is gone!"
	CRLF	
	JUMP	?CND40
?ELS44:	RANDOM	100
	GRTR?	70,STACK \?ELS48
	PRINTI	"You catch a brief glimpse of something shiny in the sand."
	CRLF	
	JUMP	?CND40
?ELS48:	PRINTI	"Something sparkling in the sand catches your eye for a moment."
	CRLF	
?CND40:	SET	'LAST-MOVES,MOVES
	RETURN	LAST-MOVES


	.FUNCT	I-IN-LAKE
	EQUAL?	HERE,IN-LAKE \FALSE
	PRINTI	"You run out of air and return to the surface."
	CRLF	
	CALL	GOTO,ON-LAKE
	RSTACK	


	.FUNCT	ON-LAKE-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	CALL	QUEUE,I-IN-LAKE,0
	ZERO?	LAKE-POINT \FALSE
	INC	'SCORE
	SET	'LAKE-POINT,TRUE-VALUE
	RETURN	LAKE-POINT
?ELS5:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?LEAP \FALSE
	ZERO?	PRSO \FALSE
	CALL	DO-WALK,P?DOWN
	RTRUE	


	.FUNCT	GO-ON-LAKE,F,N,TOLD=0
	FIRST?	WINNER >F \?CND1
?PRG4:	NEXT?	F >N /?KLU31
?KLU31:	FSET?	F,WEARBIT /?CND6
	MOVE	F,IN-LAKE
	EQUAL?	F,TORCH \?ELS11
	REMOVE	TORCH
	MOVE	FRIED-TORCH,IN-LAKE
	JUMP	?CND9
?ELS11:	EQUAL?	F,LAMP \?ELS13
	MOVE	LAMP,LOCAL-GLOBALS
	MOVE	FRIED-LAMP,IN-LAKE
	SET	'CURRENT-LAMP,FRIED-LAMP
	JUMP	?CND9
?ELS13:	EQUAL?	F,WAYBREAD \?CND9
	REMOVE	WAYBREAD
?CND9:	ZERO?	TOLD \?CND6
	SET	'TOLD,TRUE-VALUE
	PRINTI	"The shock of entering the frigid water has made you drop all your possessions into the lake!"
	CRLF	
?CND6:	ZERO?	N \?ELS23
	JUMP	?CND1
?ELS23:	SET	'F,N
	JUMP	?PRG4
?CND1:	ZERO?	TOLD \?CND26
	PRINTI	"You are nearly paralyzed by the icy waters as you swim into the center of the lake."
	CRLF	
?CND26:	CRLF	
	CALL	GOTO,ON-LAKE
	SET	'LAKE-TIME,0
	CALL	QUEUE,I-ON-LAKE,-1
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-ON-LAKE
	INC	'LAKE-TIME
	RANDOM	100
	GRTR?	10,STACK \?ELS5
	EQUAL?	HERE,ON-LAKE \?ELS5
	ZERO?	INVIS \?ELS5
	PRINTI	"A giant roc, previously hidden among the rocks, is heading right toward you, its mouth gaping wide!"
	CRLF	
	CALL	QUEUE,I-ROC,2
	PUT	STACK,0,1
	RTRUE	
?ELS5:	EQUAL?	HERE,ON-LAKE,IN-LAKE /?ELS11
	CALL	QUEUE,I-ON-LAKE,0
	CALL	QUEUE,I-IN-LAKE,0
	CALL	QUEUE,I-ROC,0
	RFALSE	
?ELS11:	EQUAL?	LAKE-TIME,4 \?ELS13
	PRINTR	"The icy waters are taking their toll. You will not be able to hold out much longer."
?ELS13:	EQUAL?	LAKE-TIME,6 \?ELS17
	PRINTR	"You are becoming very weak. You had better leave the water before you drown!"
?ELS17:	EQUAL?	LAKE-TIME,8 \FALSE
	CALL	QUEUE,I-ON-LAKE,0
	CALL	QUEUE,I-IN-LAKE,0
	CALL	QUEUE,I-ROC,0
	CALL	JIGS-UP,STR?209
	RSTACK	


	.FUNCT	I-ROC
	EQUAL?	HERE,ON-LAKE \FALSE
	ZERO?	INVIS \FALSE
	CALL	QUEUE,I-ON-LAKE,0
	CALL	QUEUE,I-IN-LAKE,0
	CALL	JIGS-UP,STR?210
	RSTACK	


	.FUNCT	SHINY-OBJECT-F
	EQUAL?	PRSA,V?FIND,V?TAKE \FALSE
	IN?	AMULET,WINNER /FALSE
	RANDOM	100
	GRTR?	50,STACK \?ELS12
	REMOVE	SHINY-OBJECT
	MOVE	AMULET,WINNER
	CALL	THIS-IS-IT,AMULET
	FCLEAR	AMULET,NDESCBIT
	PRINTR	"You reach the shiny object. It is a simple golden amulet!"
?ELS12:	PRINTR	"The shiny object slips from your grasp and back onto the floor of the lake, where it is covered in sand."


	.FUNCT	SAND-F
	EQUAL?	PRSA,V?DIG \?ELS5
	PRINTR	"You don't come across anything unusual."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINTR	"There is nothing notable on the floor of the lake, except some plants and algae."
?ELS9:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"It slips through your fingers."


	.FUNCT	ALGAE-F
	EQUAL?	PRSA,V?EAT \FALSE
	PRINTR	"Yeecchhhh!"


	.FUNCT	FRIED-LAMP-F
	EQUAL?	PRSA,V?LAMP-ON \FALSE
	PRINTR	"The lamp isn't functioning (probably from having gotten wet)."


	.FUNCT	I-VIEW-SNAP
	PRINTI	"You suddenly find yourself back in the viewing room!"
	CRLF	
	CALL	GOTO,VIEW-ROOM,FALSE-VALUE
	RTRUE	


	.FUNCT	VIEWING-TABLE-F,L
	EQUAL?	PRSA,V?RUB \?ELS5
	ADD	SCORE,VIEW-POINT >SCORE
	SET	'VIEW-POINT,0
	PRINTI	"You touch the table and are instantly transported to another place!"
	CRLF	
	CRLF	
	CALL	QUEUE,I-VIEW-SNAP,3
	PUT	STACK,0,1
	GET	VIEW-ROOMS,ACTIVE-VIEW
	CALL	GOTO,STACK
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTI	"The surface is pale and featureless, but slowly, an image takes shape!"
	CRLF	
	GET	VIEWS,ACTIVE-VIEW
	PRINT	STACK
	CRLF	
	PRINTR	"The image slowly fades."


	.FUNCT	I-VIEW-CHANGE
	INC	'ACTIVE-VIEW
	EQUAL?	ACTIVE-VIEW,5 \?CND1
	SET	'ACTIVE-VIEW,1
?CND1:	CALL	QUEUE,I-VIEW-CHANGE,4
	EQUAL?	HERE,VIEW-ROOM \FALSE
	PRINTI	"The indicator above the table flickers briefly, then changes to """
	GET	VIEW-ROMANS,ACTIVE-VIEW
	PRINT	STACK
	PRINTR	"""."


	.FUNCT	VIEW-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a small chamber carved in the rock, with the sole exit to the north. Mounted on one wall is a table labelled ""Scenic Vista,"" whose featureless surface is angled toward you. One might believe that the table was used to indicate points of interest in the view from this spot, like those found in many parks. On the other hand, your surroundings are far from spacious and by no stretch of the imagination could this spot be considered scenic. An indicator above the table reads """
	GET	VIEW-ROMANS,ACTIVE-VIEW
	PRINT	STACK
	PRINTR	"""."


	.FUNCT	CLIFF-OBJECT-F
	EQUAL?	HERE,CLIFF \?ELS5
	EQUAL?	PRSA,V?LEAP \?ELS10
	CALL	JIGS-UP,STR?27
	RSTACK	
?ELS10:	EQUAL?	PRSA,V?CLIMB-DOWN \?ELS12
	ZERO?	ROPE-FLAG /?ELS17
	CALL	GOTO,CLIFF-LEDGE
	RTRUE	
?ELS17:	PRINTR	"The fall would kill you."
?ELS12:	EQUAL?	PRSA,V?THROW-OFF \FALSE
	EQUAL?	PRSI,CLIFF-OBJECT \FALSE
	EQUAL?	PRSO,ROPE \?ELS29
	PRINTR	"The rope is dangling over the side of the cliff already."
?ELS29:	IN?	PRSO,WINNER /?CND27
	PRINTI	"You aren't holding the "
	PRINTD	PRSO
	PRINTR	"."
?CND27:	MOVE	PRSO,CLIFF-LEDGE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" goes over the cliff and lands among the rocks below."
	CRLF	
	EQUAL?	PRSO,LAMP \?ELS40
	REMOVE	PRSO
	MOVE	BROKEN-LAMP,CLIFF-LEDGE
	SET	'CURRENT-LAMP,BROKEN-LAMP
	RTRUE	
?ELS40:	EQUAL?	PRSO,STAFF \TRUE
	REMOVE	PRSO
	MOVE	BROKEN-STAFF,CLIFF-LEDGE
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLIMB-UP \?ELS44
	PRINTR	"You haven't enough strength to climb the cliff."
?ELS44:	PRINTR	"The cliff is above you!"


	.FUNCT	TREE-F
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \?ELS5
	PRINTR	"The trunks are too large for you to climb them."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?ELS9
	ZERO?	MAN-SEEN \?ELS9
	PRINTR	"There seems to be nobody there, but it's hard to tell."
?ELS9:	EQUAL?	PRSA,V?BURN \FALSE
	CALL	JIGS-UP,STR?219
	RSTACK	


	.FUNCT	FRIED-TORCH-F
	EQUAL?	PRSA,V?LAMP-ON \FALSE
	PRINTR	"It's hopeless. The torch is wet."


	.FUNCT	TORCH-F
	EQUAL?	PRSA,V?LAMP-ON \?ELS5
	FSET?	TORCH,ONBIT \?ELS10
	PRINTR	"It's already lit."
?ELS10:	PRINTR	"You have nothing to light it with."
?ELS5:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	FSET?	TORCH,ONBIT \?ELS23
	PRINTI	"You manage to extinguish the flame."
	CRLF	
	FCLEAR	TORCH,ONBIT
	RTRUE	
?ELS23:	PRINTR	"It has already been extinguished."


	.FUNCT	NO-OBJS,RARG,F
	EQUAL?	RARG,M-BEG \FALSE
	FIRST?	WINNER >F /?KLU13
?KLU13:	SET	'EMPTY-HANDED,TRUE-VALUE
?PRG6:	ZERO?	F /FALSE
	CALL	WEIGHT,F
	GRTR?	STACK,4 \?CND8
	SET	'EMPTY-HANDED,FALSE-VALUE
	RFALSE	
?CND8:	NEXT?	F >F /?KLU14
?KLU14:	JUMP	?PRG6


	.FUNCT	REPELLENT-FCN
	EQUAL?	PRSA,V?SHAKE \?ELS5
	ZERO?	SPRAY-USED? /?ELS10
	PRINTR	"The can seems empty."
?ELS10:	PRINTR	"There is a sloshing sound from inside."
?ELS5:	EQUAL?	PRSA,V?BURN \?ELS19
	CALL	JIGS-UP,STR?229
	RSTACK	
?ELS19:	EQUAL?	PRSA,V?PUT-ON,V?SPRAY \FALSE
	EQUAL?	PRSO,REPELLENT \FALSE
	ZERO?	SPRAY-USED? /?ELS28
	PRINTR	"The repellent is all gone."
?ELS28:	ZERO?	PRSI \?ELS33
	SET	'SPRAY-USED?,TRUE-VALUE
	PRINTR	"The spray stinks amazingly for a few moments, then drifts away."
?ELS33:	EQUAL?	PRSI,ME \?CND38
	CALL	QUEUE,I-SPRAY,5
	PUT	STACK,0,1
	SET	'SPRAYED?,TRUE-VALUE
?CND38:	SET	'SPRAY-USED?,TRUE-VALUE
	PRINTR	"The spray smells like a mixture of old socks and burning rubber. If I were a grue I'd sure stay clear!"


	.FUNCT	I-SPRAY
	SET	'SPRAYED?,FALSE-VALUE
	PRINTR	"That horrible smell is much less pungent now."


	.FUNCT	ZORK-IV-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	CALL	JIGS-UP,STR?230
	RSTACK	


	.FUNCT	AQUEDUCT-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The aqueduct is large and impressive. It was probably the major method of water transport in the Empire."
?ELS5:	EQUAL?	PRSA,V?LEAP \FALSE
	CALL	JIGS-UP,STR?241
	RSTACK	


	.FUNCT	WATER-CHANNEL-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The channel is a few feet deep and ten feet wide, rounded on the bottom."
?ELS5:	EQUAL?	PRSA,V?BOARD \FALSE
	EQUAL?	HERE,DAMP-PASSAGE \?ELS14
	PRINTR	"Getting into the channel wouldn't be of much use."
?ELS14:	PRINTR	"You're standing in it. Otherwise, you would be floating in midair above some very nasty rocks."


	.FUNCT	MOSS-F
	EQUAL?	PRSA,V?MOVE,V?TAKE \FALSE
	PRINTR	"Don't be silly."


	.FUNCT	AQ-2-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are now on one of the tallest arches of the aqueduct, hundreds of feet above a rocky chasm. The immensity of the aqueduct project is apparent from here. Stone supports rise from the rock floor to form massive arches, which traverse the region from north to south. The water-carrying channel here is wide and deep. To the west and far below, you can make out a balcony which must command a wide view of the aqueduct."
	CRLF	
	ZERO?	AQ-FLAG \FALSE
	PRINTR	"The channel ends abruptly to your north where a supporting pillar has crumbled, casting the arch into the chasm."


	.FUNCT	AQ-3-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are near the northern end of this segment of the aqueduct system. To the south and slightly uphill, the bulk of the aqueduct looms ominously, towering above a gorge. To the north, the water channel drops precipitously and enters a rocky hole. The damp moss and lichen would certainly make that a one-way trip."
	CRLF	
	ZERO?	AQ-FLAG \FALSE
	PRINTR	"The southern part of the aqueduct system is inaccessable due to the collapse of one of the water-bearing arches."


	.FUNCT	COVER-F
	EQUAL?	PRSA,V?OPEN,V?RAISE,V?MOVE \?ELS5
	PRINTI	"The cover is moved a bit to one side, revealing a small hole leading into darkness."
	CRLF	
	SET	'COVER-MOVED,TRUE-VALUE
	RETURN	COVER-MOVED
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"The cover is far too heavy to take."


	.FUNCT	KEY-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are between some rock and a dark place. The room is lit dimly from above, revealing a lone, dark path sloping down to the west."
	CRLF	
	ZERO?	COVER-MOVED /?ELS12
	PRINTR	"A heavy manhole cover has been moved to reveal a dark passage below."
?ELS12:	PRINTR	"To one side of the room is a large manhole cover."


	.FUNCT	KEY-F
	EQUAL?	PRSA,V?UNLOCK \?ELS5
	EQUAL?	PRSI,KEY \?ELS5
	EQUAL?	PRSO,BRONZE-DOOR \?ELS12
	EQUAL?	HERE,GOOD-CELL \?ELS12
	ZERO?	BRONZE-DOOR-LOCKED /?ELS17
	PRINTI	"The key seems to mold itself to the shape of the lock. With a mere twist of your hand, the massive bolt gives way."
	CRLF	
	JUMP	?CND15
?ELS17:	PRINTI	"It already is."
	CRLF	
?CND15:	SET	'BRONZE-DOOR-LOCKED,FALSE-VALUE
	RTRUE	
?ELS12:	EQUAL?	PRSO,BRONZE-DOOR \?ELS26
	PRINTR	"The key molds itself to the lock but will not turn."
?ELS26:	EQUAL?	PRSO,CHEST /?THN31
	FSET?	PRSO,DOORBIT \FALSE
?THN31:	PRINTR	"The key, which initially seemed certain to fit the lock, seems to change shape and will not enter the keyhole."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	PICK-ONE,KEY-DESCS
	PRINT	STACK
	CRLF	
	PRINTR	"Strange, though. The key seems to change shape constantly."


	.FUNCT	VIEW-INDICATOR-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTI	"The indicator reads """
	GET	VIEW-ROMANS,ACTIVE-VIEW
	PRINT	STACK
	PRINTR	"""."


	.FUNCT	FLATHEAD-OCEAN-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"You are at the shore of an amazing underground sea, the topic of many a legend among adventurers. Few were known to have arrived at this spot, and fewer to return. There is a heavy surf and a breeze is blowing onshore. The land rises steeply to the east and quicksand prevents movement to the south. A thick mist covers the ocean and extends over the hills to the east. A path heads north along the beach."
	CRLF	
	FSET?	VIKING-SHIP,INVISIBLE /TRUE
	PRINTR	"An ancient Viking ship is passing along the shore, an old and crusty sailor at the helm."
?ELS5:	EQUAL?	RARG,M-END \FALSE
	RANDOM	100
	GRTR?	20,STACK \FALSE
	ZERO?	BOAT-SEEN \FALSE
	ZERO?	LIT /FALSE
	SET	'BOAT-SEEN,TRUE-VALUE
	CALL	QUEUE,I-BOAT-DISAPPEAR,2
	PUT	STACK,0,1
	PRINTI	"Passing alongside the shore now is an old boat, reminiscent of an ancient Viking ship. Standing on the prow of the ship is an old and crusty sailor, peering out over the misty ocean."
	CRLF	
	FCLEAR	VIKING-SHIP,INVISIBLE
	RTRUE	


	.FUNCT	I-BOAT-DISAPPEAR
	FSET	VIKING-SHIP,INVISIBLE
	SET	'SHIP-GONE,TRUE-VALUE
	EQUAL?	HERE,FLATHEAD-OCEAN \FALSE
	PRINTR	"The boat sails silently through the mist and out of sight."


	.FUNCT	I-VISIBLE
	SET	'INVIS,FALSE-VALUE
	EQUAL?	HERE,MRG,MRGE,MRGW \FALSE
	CALL	JIGS-UP,STR?248
	RFALSE	


	.FUNCT	POTION-F
	EQUAL?	PRSA,V?DRINK \?ELS5
	REMOVE	POTION
	SET	'INVIS,TRUE-VALUE
	CALL	QUEUE,I-VISIBLE,3
	PUT	STACK,0,1
	PRINTR	"You ""drink"" the contents in one gulp, but nothing unusual seems to have happened as a result."
?ELS5:	EQUAL?	PRSA,V?POUR-ON \?ELS9
	EQUAL?	PRSO,POTION \?ELS9
	REMOVE	POTION
	PRINTI	"It spills onto the "
	PRINTD	PRSI
	PRINTR	" and vanishes."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS15
	PRINTR	"It feels like there's something inside, but you can't see anything even though the vial is transparent."
?ELS15:	EQUAL?	PRSA,V?SMELL \?ELS19
	PRINTR	"The vial (or something in it) smells sweet."
?ELS19:	EQUAL?	PRSA,V?TAKE,V?DROP \FALSE
	PRINTI	"Nothing seems to come out, although the sweet smell disappears from the vial, seeming to permeate the air briefly before fading entirely."
	CRLF	
	REMOVE	POTION
	RTRUE	


	.FUNCT	VIAL-F
	EQUAL?	PRSA,V?FILL \?ELS5
	PRINTR	"You can't seem to put anything in it."
?ELS5:	EQUAL?	PRSA,V?DRINK-FROM \?ELS9
	IN?	POTION,VIAL \?ELS9
	CALL	PERFORM,V?DRINK,POTION
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?SMELL \?ELS13
	IN?	POTION,VIAL \?ELS13
	CALL	PERFORM,V?SMELL,POTION
	RTRUE	
?ELS13:	EQUAL?	PRSA,V?SHAKE \?ELS17
	IN?	POTION,VIAL \?ELS17
	FSET?	VIAL,OPENBIT \?ELS17
	PRINTI	"Nothing seems to come out, although the vial is lighter now."
	CRLF	
	REMOVE	POTION
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?OPEN \?ELS23
	FSET	VIAL,OPENBIT
	PRINTI	"The vial is open."
	IN?	POTION,VIAL \?CND26
	PRINTI	" There is a sweet odor from within the vial, apparently coming from a heavy but invisible liquid."
?CND26:	CRLF	
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"It is a small, transparent vial "
	IN?	POTION,VIAL \?ELS39
	PRINTR	"which looks empty but is strangely heavy."
?ELS39:	PRINTR	"which is light and empty."


	.FUNCT	OCEAN-F
	EQUAL?	HERE,FLATHEAD-OCEAN /?ELS5
	PRINTR	"There is no ocean here."
?ELS5:	EQUAL?	PRSA,V?BOARD,V?THROUGH \?ELS9
	PRINTR	"You would be killed by the pounding surf!"
?ELS9:	EQUAL?	PRSA,V?THROW,V?PUT \FALSE
	EQUAL?	PRSI,OCEAN \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" falls into the ocean and is lost forever."
	CRLF	
	REMOVE	PRSO
	RTRUE	


	.FUNCT	STONE-DESC,FOO
	PRINTI	"Standing before you is a great rock."
	ZERO?	SWORD-IN-STONE? /?CND3
	PRINTI	" Imbedded within it is an Elvish sword."
?CND3:	CRLF	
	RTRUE	


	.FUNCT	STONE-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	PRINTR	"You can't be serious."
?ELS5:	EQUAL?	PRSA,V?PUT \?ELS9
	EQUAL?	PRSI,STONE \?ELS9
	PRINTR	"You can't force anything into the stone."
?ELS9:	EQUAL?	PRSA,V?PUSH,V?TAKE,V?MOVE \?ELS15
	EQUAL?	PRSO,STONE \?ELS15
	PRINTR	"The stone is far too massive to be moved."
?ELS15:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	PRINTR	"Since it can't be moved, it's hard to know what's there."


	.FUNCT	FISH-F
	PRINTR	"There is no fish visible now."


	.FUNCT	QUICKSAND-PSEUDO
	EQUAL?	PRSA,V?LEAP,V?THROUGH \?ELS5
	CALL	JIGS-UP,STR?249
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?RUB \?ELS7
	PRINTR	"It's quicksand all right!"
?ELS7:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"It's hard to tell what's in there."


	.FUNCT	SWAMP-PSEUDO
	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINTR	"Yucko."


	.FUNCT	MIST-PSEUDO
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	PRINTR	"You can't make anything out through the mist."
?ELS5:	EQUAL?	PRSA,V?SMELL \FALSE
	PRINTR	"It smells vaguely salty."


	.FUNCT	SHORE-PSEUDO
	EQUAL?	PRSA,V?DIG \FALSE
	PRINTR	"There's nothing there."


	.FUNCT	WATERFALL-PSEUDO
	EQUAL?	PRSA,V?CLIMB-UP \FALSE
	PRINTR	"It's much too slippery."


	.FUNCT	ARCH-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	ZERO?	AQ-FLAG /?ELS10
	PRINTR	"The arches all show some signs of decay."
?ELS10:	PRINTR	"The arch before you is broken. The others show signs of decay."

	.ENDI

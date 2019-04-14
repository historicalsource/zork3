

	.FUNCT	IRON-DOOR-F
	EQUAL?	PRSA,V?THROUGH,V?UNLOCK,V?OPEN \FALSE
	LESS?	YEAR,YEAR-PRESENT \?ELS10
	PRINTR	"The iron door appears to be locked from the outside."
?ELS10:	PRINTR	"The iron door is rusted shut and cannot be opened."


	.FUNCT	I-CLEFT
	EQUAL?	HERE,ZORK-IV,ROOM-8,TIMBER-ROOM /?THN4
	EQUAL?	HERE,LOWER-SHAFT,LADDER-BOTTOM,LADDER-TOP \?ELS3
?THN4:	PRINTI	"You feel a mild tremor from within the earth which passes quickly."
	CRLF	
	JUMP	?CND1
?ELS3:	PRINTI	"There is a great tremor from within the earth. The entire dungeon shakes violently and loose debris starts to fall from above you."
	CRLF	
?CND1:	EQUAL?	HERE,MUSEUM-ANTE \?ELS14
	PRINTI	"To the east, to the right of the great iron door, a large cleft opens up, revealing an open area behind!"
	CRLF	
	JUMP	?CND12
?ELS14:	EQUAL?	HERE,AQ-VIEW \?ELS18
	PRINTI	"One of the giant pillars supporting the aqueduct collapses in a pile of smoke and rubble!"
	CRLF	
	JUMP	?CND12
?ELS18:	EQUAL?	HERE,AQ-2,AQ-3 \?CND12
	PRINTI	"The channel beneath your feet trembles. At once, the channel directly to the "
	EQUAL?	HERE,AQ-2 \?ELS27
	PRINTI	"north"
	JUMP	?CND25
?ELS27:	PRINTI	"south"
?CND25:	PRINTI	" of you collapses with its supporting pillar and falls into the chasm!"
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
	PRINTR	"This is the south end of a monumental hall, full of dust and debris from a recent earthquake. To the east is a great iron door, rusted shut. To its right, however, is a gaping cleft in the rock and behind, a cleared area."
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
	PRINTR	"This seems to be an entrance hall of some sort, judging by the grand iron door to the west, and the ornate stone and wooden doors which lead to the east and north, respectively. A few wide steps lead south."
?ELS10:	PRINTI	"This is the entrance to the Royal Museum, the finest and grandest in the Great Underground Empire. To the south, down a few steps, is the entrance to the Royal Puzzle and to the east, through a stone door, is the Royal Jewel Collection. A wooden door to the north is "
	FSET?	WOODEN-DOOR,OPENBIT \?ELS23
	PUSH	STR?110
	JUMP	?CND19
?ELS23:	PUSH	STR?111
?CND19:	PRINT	STACK
	PRINTI	" and leads to the Museum of Technology. "
	EQUAL?	YEAR,YEAR-PRESENT \?ELS30
	PRINTR	"To the west is a great iron door, rusted shut. To its left, however, is a cleft in the rock providing a western route away from the museum."
?ELS30:	LESS?	YEAR,YEAR-PRESENT \?ELS34
	PRINTR	"To the west is a great iron door, which is rusted shut."
?ELS34:	PRINTR	"To the west is a great iron door, rusted shut. The cleft in the rock, present when you started, has filled in with rubble."


	.FUNCT	TIME-MACHINE-F,RARG=0
	EQUAL?	RARG,M-OBJDESC \?ELS5
	PRINTI	"Directly in front of you is a large golden machine, which has a seat with a console in front. On the console is a single button and a dial connected to a three-digit display which reads "
	PRINTN	TM-YEAR
	PRINTR	". The machine is suprisingly shiny and shows few signs of age."
?ELS5:	EQUAL?	RARG,M-END \?ELS9
	EQUAL?	PRSA,V?PUT \?ELS9
	EQUAL?	PRSI,TIME-MACHINE \?ELS9
	PRINTR	"You can't put anything on or inside the machine itself."
?ELS9:	EQUAL?	RARG,M-BEG \?ELS15
	EQUAL?	PRSA,V?MOVE \?ELS15
	PRINTR	"You might be able to move the machine by pushing it."
?ELS15:	EQUAL?	RARG,M-BEG \?ELS21
	EQUAL?	PRSA,V?PUSH-TO \?ELS21
	EQUAL?	PRSO,TIME-MACHINE \?ELS21
	PRINTR	"That would be a good trick from inside it."
?ELS21:	EQUAL?	RARG,M-END \?ELS27
	EQUAL?	PRSO,TIME-MACHINE \?ELS27
	EQUAL?	PRSA,V?EXAMINE \?ELS34
	PRINTI	"The machine consists of a seat and a console containing one small button and a dial connected to a display which reads "
	PRINTN	TM-YEAR
	PRINTR	"."
?ELS34:	EQUAL?	PRSA,V?BOARD \?ELS38
	FIRST?	TM-SEAT \?ELS38
	PRINTR	"That will be somewhat uncomfortable!"
?ELS38:	EQUAL?	PRSA,V?RAISE,V?TAKE \?ELS44
	PRINTR	"The machine must weigh hundreds of pounds and cannot be carried."
?ELS44:	EQUAL?	PRSA,V?PUSH \?ELS48
	PRINTR	"You should specify in which direction to push the machine."
?ELS48:	EQUAL?	PRSA,V?PUSH-TO \FALSE
	CALL	DO-WALK,P-DIRECTION
	EQUAL?	STACK,M-FATAL /TRUE
	PRINTI	"With some effort, you push the machine into the room with you."
	CRLF	
	EQUAL?	HERE,CP-ANTE,MID-CP-ANTE \?ELS60
	PRINTI	"However, the machine seems to have sustained some damage as a result of going over the stairs."
	CRLF	
	SET	'MACHINE-DAMAGED,TRUE-VALUE
	JUMP	?CND58
?ELS60:	EQUAL?	HERE,MUSEUM-ANTE \?CND58
	PRINTI	"Pushing the machine through the cleft seems to have damaged it."
	CRLF	
	SET	'MACHINE-DAMAGED,TRUE-VALUE
?CND58:	MOVE	TIME-MACHINE,HERE
	RTRUE	
?ELS27:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \?ELS70
	PRINTR	"You're not going anywhere in this heap."
?ELS70:	EQUAL?	PRSA,V?CLOSE,V?OPEN,V?PUSH /?THN77
	EQUAL?	PRSA,V?MOVE,V?PUT,V?TAKE \FALSE
?THN77:	CALL	HELD?,PRSO
	ZERO?	STACK \FALSE
	IN?	PRSO,TIME-MACHINE /FALSE
	PRINTR	"You can't do that from inside the machine."


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
	CALL	REALLY-DEAD,STR?112
	RSTACK	
?ELS21:	EQUAL?	YEAR,TM-YEAR \?ELS23
	PRINTR	"Nothing seems to have happened."
?ELS23:	LESS?	TM-YEAR,YEAR-CLOSED \?ELS27
	PRINTI	"You experience a brief period of disorientation. When your vision returns,"
	EQUAL?	HERE,MUSEUM-ENTRANCE,MID-MUSEUM-ENTRANCE,OLD-MUSEUM-ENTRANCE \?ELS34
	EQUAL?	TM-YEAR,YEAR-CAGED \?ELS39
	PRINTI	" you are surrounded by a number of heavily armed guards, the dress and speech of which seem strange and unfamiliar. A commotion starts at a door to the east and a person with a flat head, wearing a gaudy crown and a purple robe, bursts into the room."
	CRLF	
	CALL	FLATHEAD-SENTENCE
	RSTACK	
?ELS39:	CALL	GUARDS-KILL
	RSTACK	
?ELS34:	EQUAL?	HERE,JEWEL-ROOM,MID-JEWEL-ROOM,OLD-JEWEL-ROOM \?ELS45
	EQUAL?	TM-YEAR,YEAR-CAGED \?ELS50
	PRINTI	" you find yourself in the middle of some kind of ceremony, with a strange flat-headed man wearing royal vestments about to break a bottle on the bars of an iron cage containing magnificent jewels. He appears somewhat pleased by your presence. "
	CALL	FLATHEAD-SENTENCE
	RSTACK	
?ELS50:	GRTR?	TM-YEAR,YEAR-CAGED \?ELS54
	CALL	GUARDS-KILL
	RSTACK	
?ELS54:	PRINTI	" your surroundings appear to have changed. From outside the door you hear the sounds of guards talking."
	CRLF	
	CALL	TGOTO,OLD-JEWEL-ROOM
	RSTACK	
?ELS45:	EQUAL?	HERE,TECH-MUSEUM,MID-TECH-MUSEUM,OLD-TECH-MUSEUM \FALSE
	EQUAL?	TM-YEAR,YEAR-BUILT /?ELS65
	CALL	GUARDS-KILL
	RSTACK	
?ELS65:	PRINTI	" your surroundings appear to have changed. From outside the door you hear the sounds of guards talking."
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
	PRINTI	"You start to feel light-headed and, before you can even think, you become completely disoriented. When you regain your faculties, you realize that your surroundings have changed."
	CRLF	
	CALL	TGOTO,SNAP-LOC,TRUE-VALUE
	RSTACK	


	.FUNCT	MOVE-JEWELS
	ZERO?	RING-STOLEN \TRUE
	EQUAL?	TM-YEAR,YEAR-BUILT \?ELS7
	MOVE	PEDESTAL,OLD-JEWEL-ROOM
	JUMP	?CND5
?ELS7:	LESS?	TM-YEAR,YEAR-PRESENT \?ELS9
	MOVE	PEDESTAL,MID-JEWEL-ROOM
	JUMP	?CND5
?ELS9:	MOVE	PEDESTAL,JEWEL-ROOM
?CND5:	MOVE	SCEPTRE,PEDESTAL
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
	FSET	PEDESTAL,INVISIBLE
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
	CALL	REALLY-DEAD,STR?9
	RSTACK	


	.FUNCT	FLATHEAD-SENTENCE
	CALL	REALLY-DEAD,STR?116
	RSTACK	


	.FUNCT	REALLY-DEAD,STR
	PRINT	STR
	CRLF	
	PRINTI	"

   **  You have died  **

 "
	QUIT	
	RTRUE	


	.FUNCT	HEAR-FLATHEAD
	SET	'FLATHEAD-HEARD,TRUE-VALUE
	PRINTR	"One particularly loud and grating voice can now be heard above the others outside the room. ""Very nice! Very nice! Not enough security, but very nice! Now, Lord Feepness, pay attention! I've been thinking and what we need is a dam, a tremendous dam to control the Frigid River, with thousands of gates. Yes! I can see it now. We shall call it ... Flood Control Dam #2. No, not quite right. Aha! It will be Flood Control Dam #3."" ""Pardon me, my Lord, but wouldn't that be just a tad excessive?"" ""Nonsense! Now, let me tell you my idea for hollowing out volcanoes..."" With that, the voices trail out into nothingness."


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
	PRINTR	"Through the door you can hear voices which, from their sound, belong to military or police personnel."
?ELS5:	EQUAL?	RARG,M-LOOK \?ELS35
	EQUAL?	HERE,OLD-TECH-MUSEUM \?ELS38
	PRINTI	"You are in a large, unfinished room, probably intended to be a part of the Royal Museum."
	CRLF	
	JUMP	?CND36
?ELS38:	PRINTI	"This appears to be an unfinished entranceway to the Royal Museum. There are doors to the east and north, and a blind stairway to the south. A heavy iron door to the west is closed and locked."
	CRLF	
?CND36:	ZERO?	GUARDS-PRESENT /TRUE
	PRINTR	"Through the door you can hear voices which, from their sound, belong to military or police personnel."
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
	PRINTR	"You open the door ever so slightly and see dozens of armed officials. You shut the door quickly and quietly, realizing that you would be killed in an instant if you left the room."
?ELS60:	EQUAL?	RARG,M-BEG \FALSE
	ZERO?	GUARDS-PRESENT /FALSE
	RANDOM	100
	GRTR?	3,STACK \FALSE
	CALL	GUARD-CAUGHT
	RSTACK	


	.FUNCT	I-GUARDS-LEAVE
	SET	'GUARDS-PRESENT,FALSE-VALUE
	PRINTR	"You hear, from outside the door, guards marching away, their voices fading.  After a few moments, a booming crash signals the close of what must be a tremendous door. Then there is silence."


	.FUNCT	GUARD-CAUGHT
	CALL	REALLY-DEAD,STR?117
	RSTACK	


	.FUNCT	ROBOT-F
	EQUAL?	PRSA,V?FOLLOW \?ELS5
	PRINTR	"It moved very quickly and left the door closed."
?ELS5:	PRINTR	"There is no robot here."


	.FUNCT	JEWEL-ROOM-F,RARG
	EQUAL?	RARG,M-END \?ELS5
	IN?	TIME-MACHINE,HERE \?ELS5
	RANDOM	100
	GRTR?	4,STACK \?ELS5
	PRINTI	"An odd robot-like device glides into the room, dusting the floor as it moves. Its head gyrates briefly as it scans the machine. ""Shame. Shame,"" it says, rather tinnily. ""Someone has been tampering with the machines again."" Six beady mechanical eyes focus on you as the robot picks up the gold machine. ""Hands off, adventurer!"" are its last words as it leaves the room, closing the door behind it."
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
	CALL	DDESC,STR?118,WOODEN-DOOR,STR?119
	RSTACK	
?ELS10:	CALL	DDESC,STR?120,WOODEN-DOOR,STR?119
	RSTACK	


	.FUNCT	PLAQUE-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	ZERO?	RING-STOLEN /?CND6
	PRINTR	"The plaque explains that this room was to be the home of the Crown Jewels of the Great Underground Empire. However, following the unexplained disappearance of a priceless ring during the final stages of construction, Lord Flathead decided to place the remaining jewels in a safer location.  Interestingly enough, he distrusted museum security enough to place his prized possesion, an incredibly gaudy crown, within a locked safe in a volcano specifically hollowed out for that purpose."
?CND6:	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"
         Crown Jewels

  Presented To The Royal Museum
      By His Gracious Lord

        DIMWIT FLATHEAD


          Dedicated
         * 777 GUE *

"
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	ZERO?	CLUMSY-ROBBERY /?ELS16
	PRINTR	"Underneath the plaque, in small lettering, is a description of a clumsy attempt to steal the jewels using a time travel device from the Technological Museum which the curators were surprised to discover was not a non-working model. After the attempt, the machine was removed from the exhibit."
?ELS16:	ZERO?	MYSTERY /TRUE
	PRINTR	"Underneath the plaque, in small lettering, is a description of a mysterious happening during the final stages of construction of the Museum, in which some of the crown jewels were found displaced from their proper positions. Fortunately, nothing was missing. The mystery was never solved and the museum was opened despite the objections of Lord Flathead that security was too lax."


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
	PRINTR	" The grey machine, it turns out, is a Frobozz Magic Pressurizer, used in the coal mines of the Empire. The black machine is a Frobozz Magic Room Spinner. The golden machine is referred to as a Temporizer. All are non-working models donated by Frobozzco president John D. Flathead."
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
	PRINTR	"The plaque merely identifies the machines and names their donor. They are non-working models of existing state-of-the-art machinery."
?ELS14:	PRINTR	"The words cannot be made out."


	.FUNCT	PEDESTAL-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	FIRST?	PEDESTAL \FALSE
	PRINTR	"The Royal Jewels are on the pedestal."
?ELS5:	EQUAL?	PRSA,V?TAKE,V?PUT-ON,V?PUT \FALSE
	FSET?	CAGE,INVISIBLE /FALSE
	PRINTR	"You can't reach it through the cage."

	.ENDI



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
?ELS31:	EQUAL?	PRSA,V?KILL,V?ATTACK \?ELS35
	EQUAL?	PRSI,SWORD \?ELS35
	ZERO?	SHADOW-POINT-2 \?CND38
	INC	'SCORE
	SET	'SHADOW-POINT-2,TRUE-VALUE
?CND38:	CALL	SHADOW-ATTACK
	RSTACK	
?ELS35:	EQUAL?	PRSA,V?KILL,V?ATTACK \FALSE
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
?CND1:	MUL	S-STRENGTH,10
	ADD	STACK,10 >?TMP1
	RANDOM	100
	GRTR?	?TMP1,STACK \?ELS10
	GRTR?	S-STRENGTH,1 \?ELS10
	RANDOM	100
	GRTR?	90,STACK \?ELS17
	DLESS?	'P-STRENGTH,1 \?ELS22
	SET	'P-STRENGTH,1
	PRINTR	"The hooded figure swings its sword and sends yours flying to the ground. Although you are defenseless, the figure reaches for your sword and hands it back to you, nodding grimly."
?ELS22:	CALL	PICK-ONE,S-HITS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS17:	SUB	P-STRENGTH,2 >P-STRENGTH
	LESS?	P-STRENGTH,1 \?ELS35
	CALL	JIGS-UP,STR?160
	RSTACK	
?ELS35:	PRINTR	"A brilliant feint puts you off guard, and the hooded figure slips its sword between your ribs. You are hurt very badly."
?ELS10:	LESS?	S-STRENGTH,3 \?ELS41
	PRINTR	"The hooded figure attempts a thrust, but its weakened state prevents hitting you."
?ELS41:	CALL	PICK-ONE,S-MISSES
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
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
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


	.FUNCT	V-DIAGNOSE
	GET	DIAG,P-STRENGTH
	PRINT	STACK
	CRLF	
	RTRUE	


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
	CALL	JIGS-UP,STR?197
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
?ELS9:	PRINTI	"At the edge of the cliff above you, a man appears. He looks down at you and speaks. ""Hello, down there! You seem to have a problem. Maybe I can help you."" He chuckles in an unsettling sort of way. ""Perhaps if you tied that chest to the end of the rope I might be able to drag it up for you.  Then, I'll be more than happy to help you up!""  He laughs again."
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
?ELS5:	EQUAL?	PRSA,V?CLIMB-ON,V?MOVE,V?TAKE \?ELS9
	ZERO?	MAN-FLAG \?ELS14
	PRINTR	"A short tug on the rope convinces you that it is securely fastened from above."
?ELS14:	IN?	CHEST,MAN \?ELS18
	SET	'HOLDING-ROPE,TRUE-VALUE
	PRINTR	"You grab securely on to the rope."
?ELS18:	PRINTR	"The man scowls. ""I may help you up, but not before I have that chest."" He points to the chest near you on the ledge."
?ELS9:	EQUAL?	PRSA,V?CLIMB-UP \?ELS26
	PRINTR	"You try to climb the rope, but you cannot reach the top even with your best effort."
?ELS26:	EQUAL?	PRSA,V?TIE \?ELS30
	EQUAL?	CHEST,PRSO,PRSI \?ELS35
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
?ELS35:	EQUAL?	ME,PRSI,PRSO \?ELS46
	ZERO?	MAN-FLAG /?ELS51
	IN?	CHEST,MAN \?ELS51
	PRINTR	"""Just grab onto it!"", the man bellows."
?ELS51:	ZERO?	MAN-FLAG /?ELS57
	PRINTR	"The man looks cross. ""I want the chest, not you!"" he snaps. ""Now stop fooling around and pass it up!"""
?ELS57:	PRINTR	"You're unable to tie the rope around yourself."
?ELS46:	PRINTR	"You're unable to tie the rope to that."
?ELS30:	EQUAL?	PRSA,V?UNTIE \FALSE
	ZERO?	CHEST-TIED /?ELS75
	SET	'CHEST-TIED,FALSE-VALUE
	PRINTR	"The chest is now disconnected from the rope."
?ELS75:	PRINTR	"The rope isn't tied to anything."


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
	PRINTR	"It doesn't fit."
?ELS5:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	ZERO?	MAN-FLAG /?ELS30
	PRINTR	"The man calls down to you. ""Is this what you're looking for?"" he cackles, waving a small key over his head. You try to open the chest, but it is locked."
?ELS30:	PRINTR	"The chest is locked and cannot be opened."


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
?ELS13:	EQUAL?	PRSA,V?KILL,V?ATTACK \FALSE
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
	EQUAL?	PRSA,V?MOVE,V?TAKE \FALSE
	IN?	MAN,CLIFF \FALSE
	PRINTR	"The man recoils sharply. ""These here things are mine. It's my chest and they're my valuables. You've a lot of nerve trying to take them from me after me saving you like that!"""


	.FUNCT	ROPE-F
	EQUAL?	PRSA,V?MOVE,V?TAKE \?ELS5
	ZERO?	ROPE-FLAG /FALSE
	PRINTR	"The rope is tied to a tree."
?ELS5:	EQUAL?	PRSA,V?BURN \?ELS15
	PRINTR	"The rope won't catch fire."
?ELS15:	EQUAL?	PRSA,V?UNTIE \?ELS19
	PRINTR	"The rope is very securely tied and cannot be undone."
?ELS19:	EQUAL?	PRSA,V?CUT \FALSE
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
	PRINTI	" Just tie the rope to the chest and we can chat afterwards!""  He smiles broadly."
	JUMP	?CND34
?ELS36:	PRINTI	""""
?CND34:	CRLF	
	RTRUE	
?ELS31:	EQUAL?	PRSA,V?MUNG,V?ATTACK,V?KILL \?ELS44
	PRINTR	"I don't think you'll succeed at this distance."
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
	EQUAL?	PRSA,V?LEAP,V?THROUGH \?ELS5
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
	CALL	JIGS-UP,STR?205
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
	CALL	JIGS-UP,STR?206
	RSTACK	


	.FUNCT	I-ROC
	EQUAL?	HERE,ON-LAKE \FALSE
	ZERO?	INVIS \FALSE
	CALL	QUEUE,I-ON-LAKE,0
	CALL	QUEUE,I-IN-LAKE,0
	CALL	JIGS-UP,STR?207
	RSTACK	


	.FUNCT	SHINY-OBJECT-F
	EQUAL?	PRSA,V?FIND,V?TAKE \FALSE
	IN?	AMULET,WINNER /FALSE
	RANDOM	100
	GRTR?	50,STACK \?ELS12
	REMOVE	SHINY-OBJECT
	MOVE	AMULET,WINNER
	SET	'P-IT-OBJECT,AMULET
	SET	'P-IT-LOC,HERE
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
	CALL	JIGS-UP,STR?41
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
	CALL	JIGS-UP,STR?216
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
	CALL	JIGS-UP,STR?226
	RSTACK	
?ELS19:	EQUAL?	PRSA,V?PUT,V?SPRAY \FALSE
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
	CALL	JIGS-UP,STR?227
	RSTACK	


	.FUNCT	AQUEDUCT-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The aqueduct is large and impressive. It was probably the major method of water transport in the Empire."
?ELS5:	EQUAL?	PRSA,V?LEAP \FALSE
	CALL	JIGS-UP,STR?238
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
	PRINTI	"You are between some rock and a dark place, The room is lit dimly from above, revealing a lone, dark path sloping down to the west."
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
	PRINTI	"You are at the shore of an amazing underground sea, the topic of many a legend among adventurers. Few were known to have arrived at this spot, and fewer to return. There is a heavy surf and a breeze is blowing on-shore. The land rises steeply to the east and quicksand prevents movement to the south. A thick mist covers the ocean and extends over the hills to the east.  A path heads north along the beach."
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


	.FUNCT	SAILOR-F
	EQUAL?	PRSA,V?HELLO \FALSE
	FSET?	VIKING-SHIP,INVISIBLE /?ELS10
	PRINTI	"The seaman looks up and maneuvers the boat toward shore. He cries out ""I have waited three ages for someone to say those words and save me from sailing this endless ocean. Please accept this gift. You may find it useful!"" He throws something which falls near you in the sand, then sails off toward the west, singing a lively, but somewhat uncouth, sailor song."
	CRLF	
	FSET	VIKING-SHIP,INVISIBLE
	MOVE	VIAL,HERE
	RTRUE	
?ELS10:	EQUAL?	HERE,FLATHEAD-OCEAN \?ELS14
	ZERO?	SHIP-GONE /?ELS19
	PRINTR	"Nothing happens anymore."
?ELS19:	PRINTR	"Nothing happens yet."
?ELS14:	PRINTR	"Nothing happens here."


	.FUNCT	I-BOAT-DISAPPEAR
	FSET	VIKING-SHIP,INVISIBLE
	SET	'SHIP-GONE,TRUE-VALUE
	EQUAL?	HERE,FLATHEAD-OCEAN \FALSE
	PRINTR	"The boat sails silently through the mist and out of sight."


	.FUNCT	I-VISIBLE
	SET	'INVIS,FALSE-VALUE
	EQUAL?	HERE,MRG,MRGE,MRGW \FALSE
	CALL	JIGS-UP,STR?245
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
	CALL	JIGS-UP,STR?246
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?RUB \?ELS7
	PRINTR	"It's quicksand alright!"
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

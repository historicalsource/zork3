

	.FUNCT	GO
START::

?FCN:	CALL	QUEUE,I-LANTERN,200
	SET	'CURRENT-LAMP,LAMP
	MUL	8,21
	PUT	CPOBJS,STACK,1
	MUL	8,21
	ADD	STACK,1
	PUT	CPOBJS,STACK,LORE-BOOK
	MUL	8,32
	PUT	CPOBJS,STACK,1
	MUL	8,32
	ADD	STACK,1
	PUT	CPOBJS,STACK,CP-SLOT
	SET	'LIT,TRUE-VALUE
	SET	'WINNER,ADVENTURER
	SET	'PLAYER,WINNER
	SET	'MLOC,MRB
	SET	'HERE,ZORK2-STAIR
	MOVE	WINNER,HERE
	CALL	QUEUE,I-VIEW-CHANGE,4
	PUT	STACK,0,1
	SET	'P-IT-OBJECT,FALSE-VALUE
	FSET?	HERE,TOUCHBIT /?CND1
	PRINTI	"As in a dream, you see yourself tumbling down a great, dark staircase. All about you are shadowy images of struggles against fierce opponents and diabolical traps. These give way to another round of images: of imposing stone figures, a cool, clear lake, and, now, of an old, yet oddly youthful man. He turns toward you slowly, his long, silver hair dancing about him in a fresh breeze. ""You have reached the final test, my friend! You are proved clever and powerful, but this is not yet enough! Seek me when you feel yourself worthy!"" The dream dissolves around you as his last words echo through the void...."
	CRLF	
	CRLF	
	CALL	V-VERSION
	CRLF	
?CND1:	MOVE	WINNER,HERE
	MOVE	LAMP,HERE
	CALL	V-LOOK
	CALL	MAIN-LOOP
	JUMP	?FCN

	.ENDI

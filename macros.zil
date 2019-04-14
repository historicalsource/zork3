<ZSTR-OFF>

<SETG C-ENABLED? 0>
<SETG C-ENABLED 1>
<SETG C-DISABLED 0>

<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM PRINTD .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("TUPLE" ATMS "AUX" (O ()) (L ())) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				     (ELSE <FORM OR !.O>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<FORM GVAL <PARSE <STRING "V?" <SPNAME .ATM>>>>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O (<FORM EQUAL? ',PRSA !.L> !.O)>
		<SET L ()>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>

<ROUTINE ZPROB
	 (BASE)
	 <COND (,LUCKY <G? .BASE <RANDOM 100>>)
	       (ELSE <G? .BASE <RANDOM 300>>)>>

<ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC FLAMING? ('OBJ)
	<FORM AND <FORM FSET? .OBJ ',FLAMEBIT>
	          <FORM FSET? .OBJ ',ONBIT>>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>

<ZSTR-ON>

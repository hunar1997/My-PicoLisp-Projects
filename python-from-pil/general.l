(de python Arg
	(pipe
		(out '(python3 "general.py")
			(println Arg))
		(line T)))

# Currently converts (python A B C ..) into A(B, C)
# and (python '(A B C) D E) into A.B.C(D, E)
# doesnt understand list either to python or from python, but integer and string are fine

(prinl (python pow 3 2))
(prinl (python '("slaw choni bashi" split) "a") )

(bye)

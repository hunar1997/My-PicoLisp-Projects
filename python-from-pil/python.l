(de python Arg
	(pipe
		(out '(python3 "python.py")
			(println Arg))
		(let R (eval (any (line T)))
         (if (atom R) R (lit R)))))

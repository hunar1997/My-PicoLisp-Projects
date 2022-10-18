(load "python.l")

# Currently converts (python A B C ..) into A(B, C)
# and (python '(A B C) D E) into A.B.C(D, E)
# doesnt understand list either to python or from python, but integer and string are fine

(de done()
   (call 'tput "setaf" 10)
   (prin "[DONE]")
   (call 'tput "sgr0"))
(de fail()
   (call 'tput "setaf" 9)
   (prin "[FAILED]")
   (call 'tput "sgr0"))

(de test Ar
   (let (P (car Ar) PE (eval P) R (cadr Ar))
      (if (= PE R) (prog (done)
                     (prinl (sym P)))
	                (prog (fail)
                     (prinl "[FAILED] while running " (sym P) " got: "  (sym PE) " expected:" (sym R))))))

(test (python pow 3 2) 9)
(test (python '("slaw choni" split) ) '("slaw" "choni"))
(test (python '("banana" replace) "a" "o") "bonono")
(test (python pow 9 (5 . 10)) 3.0)
(test (python '((2 1 3 1) count) 1) 2)

(bye)

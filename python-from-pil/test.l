(load "python.l")

# Currently converts (python A B C) into A(B, C)
# and (python '(A B C) D E) into A.B.C(D, E)

# Just for my eyes :)
(de green()
   (call 'tput "setaf" 10)
   (prin "[DONE] ")
   (call 'tput "sgr0"))
(de red()
   (call 'tput "setaf" 9)
   (prin "[FAILED] ")
   (call 'tput "sgr0"))

# called it test2 because test is built in
(de test2 Ar
   (let (P (car Ar) PE (eval P) R (cadr Ar))
      (if (= PE R) (prog (green)
                     (prinl (sym P)))
	                (prog (red)
                     (prinl "while running " (sym P) " got: "  (sym PE) " expected:" (sym R))))))

(test2 (python pow 3 2) 9)
(test2 (python '("slaw choni" split) ) '("slaw" "choni"))
(test2 (python '("banana" replace) "a" "o") "bonono")
(test2 (python pow 9 (5 . 10)) 3.0)
(test2 (python '((2 1 3 1) count) 1) 2)
(test2 (python pow (33 . 10) 33) 129110040087760800)

(scl 27)
(test2 (python pow (4 . 10) 33) 0.000000000000078697629483834)

(test2 (python '("-" join) ("a" "b" "c")) "a-b-c")

(bye)

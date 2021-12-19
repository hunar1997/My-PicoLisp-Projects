(seed (time))

(class +Ball)

(dm T (X Y)
   (=: x X)
   (=: y Y)
   (=: dx (rand -3 3))
   (=: dy (rand -3 3))
   (=: xMax (in '(tput "cols") (read)) )
   (=: yMax (in '(tput "lines") (read))))

(dm draw> ()
   (prinl "(" (: x) " , " (: y) ")"))

(dm constrain> ()
   (cond
      ( (<= (: x) 0) (set (:: x) 0  (:: dx) (- (: dx))) )
      ( (<= (: y) 0) (set (:: y) 0  (:: dy) (- (: dy))) )
      ( (>= (: x) (: xMax)) (set (:: x) (: xMax)  (:: dx) (- (: dx))) )
      ( (>= (: y) (: yMax)) (set (:: y) (: yMax)  (:: dy) (- (: dy))) ) ) )

(dm update> ()
   (inc (:: x) (: dx))
   (inc (:: y) (: dy))
   (constrain> myBall))

(setq myBall (new '(+Ball) 5 5))

(with myBall
 (call 'clear)
 (until (key 25)
  (call 'tput "cup" (: y) (: x))
  (update> myBall)
 )
)
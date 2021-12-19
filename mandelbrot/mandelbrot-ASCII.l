# Fixed by Regenaxer

(scl 5)

(de dist (X)
   (sqrt
      (*/ (car X) (car X) 1.)
      (*/ (cdr X) (cdr X) 1.) ) )

(de rlerp (N A B X Y)
   (+
      X
      (*/
         (*/ (- N A) 1.0 (- B A))
         (- Y X)
         1.0 ) ) )

(de imgAdd (X Y)
   (cons
      (+ (car X) (car Y))
      (+ (cdr X) (cdr Y)) ) )

(de imgSq (X)
   (let (A (car X) B (cdr X))
      (cons
         (- (*/ A A 1.0) (*/ B B 1.0))
         (/ (* 2. A B) 1.0 1.0) ) ) )

(setq colors (apply circ (chop " 8$#%&/")))

(for J 45  # I and J are the resolutions
   (for I 120
      (let C
         (cons
            (rlerp (* I 1.) 0 120. -2. 1.)
            (rlerp (* J 1.) 0 45. -1.2 1.2) )
         (let Z (0.0 . 0.0)
            (let It
               (for It 100
                  (setq Z (imgAdd (imgSq Z) C))
                  (T (or (>= It 100) (> (abs (dist Z)) 2.0)) It) )
               (if (= It 100)
                  (prin " ")
                  (prin (get colors It)) ) ) ) ) )
   (prinl) )

(bye)
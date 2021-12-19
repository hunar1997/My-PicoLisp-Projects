(seed (time))

(load "@lib/simul.l")
(load "@lib/math.l")

(symbols '(simul pico))

# goal   ax+b=y   find a and b when y(5.0)=13.0
(setq X 5.0 Y 13.0)

(de function (A)
  (+ (*/ (car A) X 1.0) (cadr A)) )

(setq Population
  (make
    (do 10
      (link (list (- (rand 0 20.0) 10.0) (- (rand 0 20.0) 10.0))))) )

(de termination (A)
  (let (M (maxi fitness A) F @@ R (function M) )
  (prinl
    (pack
      (format (car M) *Scl)
      " X "
      (format (cadr M) *Scl)
      " = "
      (format (function M) *Scl)
      "\t\tError: " F ))
    (> F -5) ))

(de combine (A B)
  (if (rand T) A B) )
(de recombination (A B)
  (mapcar combine A B) )

(de mutate (A)
  (if (=0 (rand 0 10))
    (+ A (- (rand 0 4.0) 2.0))
    A) )
(de mutation (A)
  (mapcar mutate A) )

(de fitness (A)
  (- (pow (- Y (function A)) 2.0)) )

(gen
  Population
  termination
  recombination
  mutation
  fitness)

(bye)

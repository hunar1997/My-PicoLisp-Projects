(load "@lib/math.l")

(seed "test2")

(de m* (A B)
   (mapcar
      '((X)
         (apply mapcar B '(@ (sum '((A B) (*/ A B 1.0)) (rest) X))) )
      A ) )

(de m*e (A B)
	(mapcar '((A B)
	   (mapcar '((A B)
	               (*/ A B 1.)) A B))
	            A B))

(de m+ (A B)
	(mapcar '((A B)
	   (mapcar + A B))
	   A B))

(de m- (A B)
	(mapcar '((A B)
	   (mapcar - A B))
	   A B))

(de mRand (A B)
   (make (do A
      (link (make (do B
	     (link (- (rand 0 2.0) 1.0]

(de mPrint (M)
   (prinl)
   (for I M
      (prin "   ")
      (for J (mapcar round I)
         (prin J " "))
	  (prinl)))

(de relu (N)
	(max N 0))

(de sig (N)
   (*/ 1. 1. (+ 1. (exp (- N)))) )

(de sigInv (N)
   (*/ (sig N) (- 1. (sig N)) 1.))

(de reluInv (N)
	(if (ge0 N) 1.0 0))

(de mActivate (M)
   (mapcar '((N) (mapcar sig N)) M) )

(de mActivateInv (M)
   (mapcar '((N) (mapcar sigInv N)) M) )

(de addBias (M B)
   (mapcar '((I) (mapcar + I B)) M) )

(setq *Inputs '((0.0 0.0)
               (0.0 1.0)
			   (1.0 0.0)
			   (1.0 1.0)) )

(setq *Output '((0.0)
			    (1.0)
				(1.0)
				(0.0)) )

(setq *Network '(2 2 1))

(setq *Weights (make
   (mapcar '((B A) (link (mRand A B)))
      (cdr *Network) *Network) ))

(setq *Biases (make
   (for I (cdr *Network)
      (link (make (do I
	     (link (- (rand 0 2.0) 1.0]

(setq *Layers (list *Inputs))

(mapcar
   '((W B)
      (setq *Layers
	     (append (list (mActivate
	       (addBias
		       (m* (car *Layers) W)
	           B)))
		   *Layers))) 
   *Weights
   *Biases)

# Feed forwarding done

(setq *ErrorO
   (m- *Output (car *Layers)) )

(setq *DeltaO
   (m*e *ErrorO
        (mActivateInv (car *Layers)) ))

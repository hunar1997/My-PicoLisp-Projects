(load "@lib/math.l")

(symbols 'nn 'pico)

(seed "test2")

(de mDot (A B)
   (mapcar
      '((X)
         (apply mapcar B '(@ (sum '((A B) (*/ A B 1.0)) (rest) X))) )
      A ) )

(de mT (M)
   (apply mapcar M list))

(de mSumRow (M)
   (mapcar '((M) (apply + M)) M))

(de mSumCol (M)
   (apply mapcar M +))

(de mmap (F A B)
   (mapcar '((A B)
      (mapcar '((A B)
                  (F A B) ) A B))
               A B))

(de m* (A B)
   (mmap '((A B) (*/ A B 1.)) A B))

(de m*N (A N)
   (mmap '((A) (*/ A N 1.)) A))

(de m+ (A B)
   (mmap + A B))
(de m- (A B)
   (mmap - A B))

(de mRand (A B)
   (make (do A
      (link (make (do B
        (link (- (rand 0 2.0) 1.0]

(de mPrint (M)
   (prinl)
   (for I M
      (prin "   ")
      (for J
         (mapcar '((N) (align 6 (round N))) I)
         (prin J " "))
     (prinl)))

(de sig (N Inv) # Inv=T means give me the inverse
   (ifn Inv
      (*/ 1. 1. (+ 1. (exp (- N))))
      (*/ N (- 1. N) 1.)) ) # This is wrong, it shouldn't assume we have N=S(X)

(de relu (N Inv) (ifn Inv
      (max N 0)
      (if (ge0 N) 1 0)))

(de mActivate (M)
   (mmap sig M))

(de mActivateInv (M)
   (mmap '((X) (sig X T)) M))

(de addBias (M B)
   (mapcar '((I) (mapcar + I B)) M) )

(class +NN)

(dm T @
   (=: lr 0.1)
   (=: act 'sig)
   (=: stop 0.001)
   (=: every 1000)
   (=: forever NIL)
   # Read user input
   (while (args)
      (put This (next) (next)))
   (unless (: shape) (prinl "Error: you must give shape. ex. 'shape (2 2 1)"))

   (=: weights (make
      (mapcar '((B A) (link (mRand A B)))
         (cdr (: shape)) (: shape)) ))

   (=: biases (make
      (for I (cdr (: shape))
         (link (make (do I
           (link (- (rand 0 2.0) 1.0]

(dm feedForward> (Inputs)
   (=: layers (list Inputs))

   (mapc
      '((W B)
         (=: layers
         (append
            (list (mActivate
               (addBias (mDot (car (: layers)) W) B)))
            (: layers)))) 
      (: weights)
      (: biases))
)

(dm updateWeights> (dE_dL)
   (mapc
      '((Layer Weight)
         (push 'Delta 
            (mDot (mT Layer) dE_dL))
         (push 'DeltaB
            (mSumCol dE_dL))
         (setq Error
            (mDot
               dE_dL
               (mT Weight) )) 

         (setq dE_dL
            (m*
               Error
               (mActivateInv Layer) ))
      )
      (cdr (: layers)) (reverse (: weights))
   )
   (=: weights (mapcar m+ (: weights) Delta))
   (=: biases  (m+ (: biases)  DeltaB))
)

(dm train> (Goal Inputs Iterations)
   (unless Iterations (setq Iterations (: iteratoins)))
   
   (for I Iterations 
      (feedForward> This Inputs)

      (T (let (Diff   (m- Goal (car (: layers)))
               Error  (mmap '((X) (pow X 2.0)) Diff)
               Delta  NIL
               DeltaB NIL
               dE_dL (m* 
                        Diff
                        (m*N (mActivateInv
                           (car (: layers))) (: lr)))
               OutError (car (mSumCol Error)) )

         (updateWeights> This dE_dL)

         (when (=0 (% I (: every))) 
            (prinl "Error: " (format OutError *Scl)))
(prinl OutError)
         (if (: forever) NIL (< OutError (: stop)) ))) # This doesnt work since for I Iterations
   )
)


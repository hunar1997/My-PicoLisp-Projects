(load "@lib/math.l")

(symbols 'nn 'pico)

(seed "test2")

(de mDot (A B) # matrix dot product
   (mapcar
      '((X)
         (apply mapcar B '(@ (sum '((A B) (*/ A B 1.0)) (rest) X))) )
      A ) )

(de mT (M) # matrix transpose
   (apply mapcar M list))

(de mSumRow (M) # sum rows of matrix
   (mapcar '((M) (apply + M)) M))

(de mSumCol (M) # sum columns of matrix
   (apply mapcar M +))

(de mmap (F A B) # apply a function F over each element of matrix A, or A&B
   (mapcar '((A B)
      (mapcar '((A B)
                  (F A B) ) A B))
               A B))

(de m* (A B) # elementwise matrix multiplication
   (mmap '((A B) (*/ A B 1.)) A B))

(de m*N (A N) # multiply matrix by constant
   (mmap '((A) (*/ A N 1.)) A))

(de m+ (A B) # elementwise matrix summation
   (mmap + A B))
(de m- (A B) # elementwise matrix subtraction
   (mmap - A B))

(de mRand (A B) # generate a [AXB] matrix with random values between -1.0 and 1.0
   (make (do A
      (link (make (do B
        (link (- (rand 0 2.0) 1.0]

(de mPrint (M) # pretty print matrix (any 2d list)
   (prinl)
   (for I M
      (prin "   ")
      (for J
         (mapcar '((N) (align 6 (round N))) I)
         (prin J " "))
     (prinl)))

(de sig (N Inv) # sigmoid vfunction, Inv=T returns the inverse
   (ifn Inv
      (*/ 1. 1. (+ 1. (exp (- N))))
      (*/ N (- 1. N) 1.)) ) # CAREFUL: N here is S(N) so if your inverse is not in terms of S(N) it wouldn't work

(de mActivate (M)
   (mmap (: act) M))

(de mActivateInv (M)
   (mmap '((X) ((: act) X T)) M))

(de addBias (M B)
   (mapcar '((I) (mapcar + I B)) M) )

(class +NN)

(dm T @              # Shape of the network must be given (ex. 'shape (2 2 1))
   (=: lr 0.01)      # Learning Rate
   (=: act 'sig)     # Activatoin function
   (=: stop 0.001)   # Stop when error below 0.001
   (=: every 1000)   # each 1000 iteratoins, print the error
   (=: forever NIL)  # if T, keep learning until error is below stop

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
   (=: layersB (list Inputs)) #Layers before activation

   (mapc
      '((W B)
         (=: layers
         (append
            (list (mActivate
               (addBias (mDot (car (: layers)) W) B)))
            (: layers)))) 
      (: weights)
      (: biases)))

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
               (mActivateInv Layer) )))
      (cdr (: layers)) (reverse (: weights)))

   (=: weights (mapcar m+ (: weights) Delta))
   (=: biases  (m+ (: biases)  DeltaB)))

(dm train> (Goal Inputs Iterations)
   (unless Iterations (setq Iterations (: iteratoins)))
   
   (let I 1 (loop
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
         (inc 'I)
         (if (: forever) (< OutError (: stop)) (> I Iterations) ))))))

(dm results> ()
   (prinl "^JWeights:")
   (mapc mPrint (: weights))
   (prinl "^JBiases:")
   (mPrint (: biases))
   (prinl "^JOutput:^JExcepted   Result")
   (mapc
      '((A B)
         (prinl (round (car A)) "      " (round (car B))))
      *Outputs
      (car (: layers))))

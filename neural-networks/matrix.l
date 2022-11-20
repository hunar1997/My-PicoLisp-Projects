(load "@lib/math.l")

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
      (for J (mapcar '((N) (align 6 (round N))) I)
         (prin J " "))
     (prinl)))

(de relu (N)
   (max N 0))

(de sig (N)
   (*/ 1. 1. (+ 1. (exp (- N)))) )

(de sigInv (N)
   (*/ N (- 1. N) 1.))

(de reluInv (N)
   (if (ge0 N) 1.0 0))

(de mActivate (M)
   (mmap sig M))

(de mActivateInv (M)
   (mmap sigInv M))

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

(setq *LR 0.1) # Learning Rate

# End of user inputs
(setq *Weights (make
   (mapcar '((B A) (link (mRand A B)))
      (cdr *Network) *Network) ))

(setq *Biases (make
   (for I (cdr *Network)
      (link (make (do I
        (link (- (rand 0 2.0) 1.0]

# Loop begins here

(for I 100000

   (setq *Layers (list *Inputs))

   (mapcar
      '((W B)
         (setq *Layers
         (append
            (list (mActivate
               (addBias (mDot (car *Layers) W) B)))
            *Layers))) 
      *Weights
      *Biases)

   # Feed forwarding done

   (setq *Diff
      (m- *Output (car *Layers)) )

   (setq *Error
      (mmap '((X) (pow X 2.0)) *Diff))
   (when (=0 (% I 1000)) 
      (prinl "Error: " (format (car (mSumCol *Error)) *Scl)))
   (T (< (car (mSumCol *Error)) 0.001))

   (setq *dE_dL 
      (m* 
      *Diff
      (m*N (mActivateInv
           (car *Layers)) *LR)) )

   (mapcar
      '((Layer Weight)
         (push '*Delta 
            (mDot (mT Layer) *dE_dL))
         (push '*DeltaB
            (mSumCol *dE_dL))
         (setq *Error
            (mDot
               *dE_dL
               (mT (cadr *Weights)) )) 

         (setq *dE_dL
            (m*
               *Error
               (mActivateInv Layer) ))
      )
      (cdr *Layers) (reverse *Weights)
   )

   (setq *Weights (mapcar m+ *Weights *Delta))
   (setq *Biases  (m+ *Biases  *DeltaB))
)

(prinl "^JWeights:")
(mapcar mPrint *Weights)
(prinl "^JBiases:")
(mPrint *Biases)
(prinl "^JOutput:^JExcepted   Result")
(mapcar
   '((A B)
      (prinl (round (car A)) "      " (round (car B))))
   *Output
   (car *Layers))

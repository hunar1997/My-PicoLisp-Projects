(load "nn.l")        # also loads math.l if you need it
(symbols '(nn pico))   # otherwise use nn~fun to call fun 

(setq myNN
   (new '(+NN)
      'shape (2 3 1) # Shape of the network, must be given
      'lr 0.01       # Learning Rate, default=0.01
#     'act           # Activatoin function, default is sigmoid
                     # to build your oun, your function should give
                     # inverse when second parameter is T
      'stop 0.001    # Stop when error below (default=0.001)
      'every 100     # each (default=1000) iteratoins print error
      'forever T
   )
)

(setq *Inputs '((0.0 0.0)
                (0.0 1.0)
                (1.0 0.0)
                (1.0 1.0)) )

(setq *Outputs '((0.0)
                (1.0)
                (1.0)
                (0.0)) )

(train> myNN *Outputs *Inputs 10)

(with myNN
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


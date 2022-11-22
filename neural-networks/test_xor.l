(load "nn.l")         # also loads math.l if you need it
(symbols '(nn pico))  # otherwise use nn~fun to call fun

(de tanh (X Inv)
   (ifn Inv
      (- (*/ 2. 1. (+ 1. (exp (*/ -2. X 1.)) )) 1.)
      (- 1. (pow X 2.))) )

(setq myNN
   (new '(+NN)
      'shape (2 2 1) # Shape of the network, must be given
      'lr 0.01       # Learning Rate, default=0.01
      'act tanh      # Activatoin function, default is sigmoid
                     # to build your oun, your function should give
                     # inverse when second parameter is T
      'stop 0.01     # Stop when error below (default=0.001)
      'every 1000    # each (default=1000) iteratoins print error
      'forever T     # if T, keep learning until error below stop
   )
)

(setq *Inputs '((0.0 0.0) # each row contains one input example
                (0.0 1.0)
                (1.0 0.0)
                (1.0 1.0)) )

(setq *Outputs '((0.0) # each row contains one output example
                 (1.0)
                 (1.0)
                 (0.0)) )

(train> myNN *Outputs *Inputs 10000) # 10000 iterations is default, so can be omitted

(results> myNN)


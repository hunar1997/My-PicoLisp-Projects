(load "nn.l")        # also loads math.l if you need it
(symbols 'nn pico)   # otherwise use nn~fun to call fun 

(setq myNN
   (new '(+NN)
      'shape (2 2 1) # Shape of the network, must be given
      'lr 0.01       # Learning Rate, default=0.01
#     'act           # Activatoin function, default is sigmoid
                     # to build your oun, your function should give
                     # inverse when second parameter is T
   )
)

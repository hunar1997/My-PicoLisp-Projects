(load "../nn.l")         # also loads math.l if you need it
(symbols '(nn pico))  # otherwise use nn~fun to call fun

(load "data.l")

(setq myNN
   (new '(+NN)
      'shape (784 32 10)
      'lr   0.01
      'stop 0.01
      'every 10
   )
)

(setq *Outputs
   (mapcar '((X) (let N (/ (car X) 1.) (append (need N 0) (1.) (need (- 9 N) 0)) )) *Outputs))

(train> myNN *Outputs *Inputs 10000)

(results> myNN)

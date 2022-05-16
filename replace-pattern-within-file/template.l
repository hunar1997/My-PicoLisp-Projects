(out "out.in"
   (in "template.in"
      (while (echo "<Atoms>" "<Types>")
         (prin (case @
            ("<Atoms>" "8")
            ("<Types>" "2") )))))

(bye)

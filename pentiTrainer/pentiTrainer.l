(load "@lib/math.l")

(seed (time))


(prinl "Welcome to PentiTrainer :D\t\tMade by Hunar")
(prinl "Here are afew points to get you started:")
(prinl)
(prinl "* This  - ----  means press nothing.")
(prinl "* This  * -*--  means press both thumb and middle finger at the same time.")
(prinl "* This  1 2---  means press thumb then index finger right after it, but not instantly after one another. And do not hold this shape, release it as soon as you can.")
(prinl "* The small button under the middle finger (which i like to call the 6th finger) repeats the priviously pressed button.")
(prinl "* To exit at any time, press Esc (or  - 2-1- ). The enter key is  - 1-2-   ")
(prinl "* Wrong key-presses are ignored :D I was too lazy.")
(prinl "* Take a look here  https://software-lab.de/penti.html")
(prinl)


# Ranged Linear Interpolation, converts N which is between A and B
# and makes it between X and Y
(de rlerp (N A B X Y)
   (+
      X
      (*/
         (*/ (- N A) 1.0 (- B A))
         (- Y X)
         1.0 ) ) )

(de float (X)
   (* X 1.0))

# Make sure *Scl>0 because Div/0 would occur
# Returns random numbers where the result is more probable near B
(de sqrtRand (A B)
   (+ (/ (*/ (sqrt (rand 0.0 1.0) 1.0) (float (- B A)) 1.0) 1.0) A) )

(setq Space '(" " "# ----" "SPACE" "SPACE"))
(setq Letters '(("a" "# --#-" "a" "A")
      ("b" "# -##-" "b" "B")
      ("c" "- #-#-" "c" "C")
      ("d" "# ---#" "d" "D")
      ("e" "- -#--" "e" "E")
      ("f" "# #---" "f" "F")
      ("g" "- --##" "g" "G")
      ("h" "# #--#" "h" "H")
      ("i" "- --#-" "i" "I")
      ("j" "- #--#" "j" "J")
      ("k" "- ####" "k" "K")
      ("l" "- ##--" "l" "L")
      ("m" "- -###" "m" "M")
      ("n" "- ---#" "n" "N")
      ("o" "- -##-" "o" "O")
      ("p" "# ###-" "p" "P")
      ("q" "# #-#-" "q" "Q")
      ("r" "# -#--" "r" "R")
      ("s" "- #---" "s" "S")
      ("t" "# -###" "t" "T")
      ("u" "- ###-" "u" "U")
      ("v" "- #-##" "v" "V")
      ("w" "# ####" "w" "W")
      ("x" "# #-##" "x" "X")
      ("y" "# --##" "y" "Y")
      ("z" "# ##--" "z" "Z")))

# Recieves a list of characters and asks for input
(de ask (Text)
   (prin Text)
   (prinl)
   (for C Text
      (let Key NIL
         (loop
            (setq Key (key))
            (when (= Key "^[") (bye))
            (T (= Key C) (prin C)))))
   (prinl))

(de hint (L)
   (prinl "Hint:\t" (caddr L) "\tis\t" (cadr L)) )


(de level1()
   (prinl "* Level 1: Lowercase Letters:")
   (prinl)
   (prinl "* A pattern with letters will be printed and you should repeat those letters under it to proceed to the next lesson.")
   (prinl "* Each new letter is repeated to teach the muscles.")
   (prinl "* New letters will have a hint above them.")
   (prinl "* After learning three letters you will take an exam with the mixture between the letters that you learned until that point.")
   (let I NIL
      (while Letters
         (setq I (append I (cut 3 'Letters)))
         (for C (tail 3 I)
            (when (= (car C) "a") (hint '(NIL "# ----" "SPACE")) )
            (hint C)
            (ask (list (car C) " " (car C) (car C) (car C) (car C)) ))
         (let M (cdr (flip (make
                     (for J 10
                        (for C (rand 1 6)
                           (link (car (get I (sqrtRand 1 (length I))))))
                        (link " ")))))
            (ask M)))))



(de level2()
   (prinl "Level 2: Uppercase Letters")
   (prinl)
   (prinl "* To write a single uppercase letter, press SHIFT which is  1 2---   then an S would appear which indicates that the shift key is pressed, after that write any letter and it would be uppercase.")
   (prinl "* To write uppercase letters continuously, press TAB which is   2 1---   the same S would appear but it wouldn't dissapear as you type letters. Turn it off, press the same key again.")
   (prinl)
   (prinl "Now try writing these letters to get familiar with the shift key, (for the last two, use TAB instead):")
   (ask (cdr (rot (make
               (for I 6
                  (for J (rand 3 5)
                     (link (get (get Letters (rand 1 (length Letters))) (if (> I 4) 4 (rand 3 4)))))
                  (link " ")))))))




(de extraNotes()
   (prinl "Extra Notes:")
   (prinl "* To reset the location of your fingers, switch to function mode by either   - 1--2  or  - 2--1  then space  # ----"))


(de menu (Options)
   (let (S 1 Exit NIL L (length Options))
      (loop
         (for (I . V) Options
            (if (= S I)
               (call 'tput "setaf" 10) (call 'tput "setaf" 15))
            (prinl V)
            (call 'tput "setaf" 15))
         (case (key)
            (" " (inc 'S) )
            ("e" (setq Exit T))
            ("n" (dec 'S))
            ("^[" (bye)))
         (when (> S L) (one S))
         (when (=0 S) (setq S L))
         (T Exit S)
         (call 'tput "cuu" (length Options))
         )))

# Level Selector
(prinl "The Levels:")
(prinl "Since you don't know the keys yet, I made the navigation into: Thumb=GoDown, Pinkey=GoUp, MiddleFinger=GoInto")
(case (menu '("Level1" "Level2"))
   (1 (level1))
   (2 (level2)))



(prinl "Congradulations :D, I hope you don't need me again ;)")

(bye)

#{
 ╭───────────────╮
8│♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜│
7│♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟│
6│               │
5│               │
4│               │
3│               │
2│♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙│
1│♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖│
 ╰───────────────╯
  a b c d e f g h


╭───┬───╮
│ ♟ │   │
├───┼───┤
│   │   │
╰───┴───╯
}#


(setq P 1 R 2 N 3 B 4 Q 5 K 6)
(setq BL 0 WH 8)

(de getSymbol (N)
   (when (or (<= 1 N 6) (<= 9 N 14))
      (if (bit? WH N)
         (get (chop "♙♖♘♗♕♔") (- N WH))
         (get (chop "♟♜♞♝♛♚") N))))

(setq *Board
   '(
      (2   3   4   5   6   4   3   2  )
      (1   1   1   1   1   1   1   1  )
      (NIL NIL NIL NIL NIL NIL NIL NIL)
      (NIL NIL NIL NIL NIL NIL NIL NIL)
      (NIL NIL NIL NIL NIL NIL NIL NIL)
      (NIL NIL NIL NIL NIL NIL NIL NIL)
      (9   9   9   9   9   9   9   9  )
      (10  11  12  13  14  12  11  10)))

(de display ()
   (prinl " ╭───┬───┬───┬───┬───┬───┬───┬───╮")
   (for X (range 8 1)
      (prin X "│ ")
      (for Y (range 1 8)
         (unless (=1 Y) (prin " │ "))
         (prin (or (getSymbol (get *Board X Y)) " ")) )
      (prinl " │")
      (unless (=1 X) (prinl " ├───┼───┼───┼───┼───┼───┼───┼───┤")))
   (prinl " ╰───┴───┴───┴───┴───┴───┴───┴───╯")
   (prinl "   a   b   c   d   e   f   g   h") )



(display)
(bye)

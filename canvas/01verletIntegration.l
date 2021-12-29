# Following https://www.youtube.com/watch?v=3HjO_RGIjCU

(scl 4)

(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l" "@lib/canvas.l")

(load "@lib/canvas.l")

(setq *Points
   (list (100. 100. 99.5 99.4) ) )	# X Y OldX OldY 
(setq *Bounce 0.9
      *Gravity 0.005
      *Friction 0.999)

# It sets newXY-oldXY and sets newXY to oldXY to new XY
(de updatePoints ()
   (for I *Points
      (let (X I
            Y (cdr I)
            Xold (cddr I)
            Yold (cdddr I)
            Vx (*/ *Friction (- (car X) (car Xold)) 1.)
            Vy (*/ *Friction (- (car Y) (car Yold)) 1.) )
         (set Xold (car X) Yold (car Y))
         (inc X Vx)
         (inc Y Vy)
         (inc Y *Gravity)
         
         (cond ((> (car X) 1600.)
               (set X 1600.)
               (set Xold (+ (car X) (*/ Vx *Bounce 1.))))
            ((< (car X) 0)
               (set X 0)
               (set Xold (+ (car X) (*/ Vx *Bounce 1.))))
            ((> (car Y) 900.)
               (set Y 900.)
               (set Yold (+ (car Y) (*/ Vy *Bounce 1.))))
            ((< (car Y) 0)
               (set Y 0)
               (set Yold (+ (car Y) (*/ Vy *Bounce 1.))))
         )
      )
   )
)

(de renderPoints ()
   (make
      (csClearRect 0 0 1600 900)
      (csStrokeStyle "blue")
      (csStrokeRect 0 0 1600 900)
      (for I *Points
         (csBeginPath)
         (csArc (/ (car I) 1.) (/ (cadr I) 1.) 5 0 7)
         (csFill) ) ) )


(de drawCanvas (Id Dly)
   (updatePoints)
   (renderPoints)
)

(de canvasTest ()
   (action
      (html 0 "Canvas Test" "@lib.css" '((onload . "drawCanvas('$testID', 16)"))
         (form NIL
            (<canvas> "$testID" 1600 900) ) ) ) )

(de work ()
   (app)
   (redirect (baseHRef) *SesId "!canvasTest") )

#(server 8000 "!work")
# use    pil canvas.l --server 8000 "!work"
# then    (load "canvas.l")  to update

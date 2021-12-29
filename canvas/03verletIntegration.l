# Following https://www.youtube.com/watch?v=tAd7ttKbugA

(scl 4)

(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l" "@lib/canvas.l")

(load "@lib/canvas.l" "@lib/math.l")

(de dist (A B)
   (let R (head 2 (mapcar - B A))
      (sqrt (sum */ R R 1.0) 1.0) ) )

(setq *Points
   (list (100. 100. 99.5 100.5)
         (200. 100. 200. 100.)
         (200. 200. 200. 200.)
         (100. 200. 100. 200.) ) )	# X Y OldX OldY 

(de makeStick (A B Hid)
   (let R (list (get *Points A) (get *Points B) (dist (get *Points A) (get *Points B)) )
      (ifn Hid R (append R (list Hid))) ) )

(setq *Sticks
   (list (makeStick 1 2)
         (makeStick 2 3)
         (makeStick 3 4)
         (makeStick 4 1)
         (makeStick 1 3 'hidden)
 ) )

(setq *Bounce 0.9
      *Gravity 0.005
      *Friction 0.999)

(de constrainPoints ()
   (for I *Points
      (let (X I
            Y (cdr I)
            Xold (cddr I)
            Yold (cdddr I)
            Vx (*/ *Friction (- (car X) (car Xold)) 1.)
            Vy (*/ *Friction (- (car Y) (car Yold)) 1.) )
         
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
            (set Yold (+ (car Y) (*/ Vy *Bounce 1.)))) )
      )
   )
)

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
      )
   )
)

(de updateSticks ()
   (for S *Sticks
      (let (Dxy        (head 2(mapcar - (cadr S) (car S)))
            Distance   (sqrt (sum */ Dxy Dxy 1.0) 1.0)
            Difference (- (caddr S) Distance)
            Percent    (/ (*/ Difference 1.0 Distance) 2)
            OffsetXY   (mapcar */ Dxy Percent 1.0) )
         (dec (car S) (car OffsetXY))
         (dec (cdar S) (cadr OffsetXY))
         (inc (cadr S) (car OffsetXY))
         (inc (cdr (cadr S)) (cadr OffsetXY))
      )
   )
)

(de renderPoints ()
   (make
      
      
      (for I *Points
         (csBeginPath)
         (csArc (/ (car I) 1.) (/ (cadr I) 1.) 5 0 7)
         (csFill) ) ) )

(de renderSticks ()
   (make
      (csBeginPath)
      (for S *Sticks
         (unless (cdddr S)
            (csMoveTo (/ (caar S) 1.0) (/ (cadar S) 1.0))
           (csLineTo (/ (caadr S) 1.0) (/ (cadadr S) 1.0))) )
      (csStroke) ) )

(de drawCanvas (Id Dly)
   (updatePoints)
   (do 3 (updateSticks)
         (constrainPoints))
   (append (make (csClearRect 0 0 1600 900)
                 (csStrokeStyle "blue")
                 (csStrokeRect 0 0 1600 900) )
           #(renderPoints)
           (renderSticks) )
)

(de canvasTest ()
   (action
      (html 0 "Canvas Test" "@lib.css" '((onload . "drawCanvas('$testID', 33)"))
         (form NIL
            (<canvas> "$testID" 1600 900) ) ) ) )

(de work ()
   (app)
   (redirect (baseHRef) *SesId "!canvasTest") )

#(server 8000 "!work")
# use    pil canvas.l --server 8000 "!work"
# then    (load "canvas.l")  to update

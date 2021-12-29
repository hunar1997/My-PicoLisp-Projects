(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l" "@lib/canvas.l")

(load "@lib/canvas.l")

(setq *X 10 *Y 10)
(setq *Vx (rand 1 10) *Vy (rand 1 10))

(de move()
  (inc '*X *Vx)
  (inc '*Y *Vy))

(de drawCanvas (Id Dly)
   (move)
   (unless (< 0 *X 390) (setq *Vx (- *Vx)))
   (unless (< 0 *Y 290) (setq *Vy (- *Vy)))

   (make
      (csClearRect 0 0 400 300)
      (csStrokeStyle "blue")
      (csStrokeRect 0 0 400 300)
      (csFillStyle "red")
      (csBeginPath)
      (csArc *X *Y 10 0 7)
      (csFill)
   )
)

(de canvasTest ()
   (action
      (html 0 "Canvas Test" "@lib.css" '((onload . "drawCanvas('$testID', 16)"))
         (form NIL
            (<canvas> "$testID" 400 300) ) ) ) )

(de work ()
   (app)
   (redirect (baseHRef) *SesId "!canvasTest") )

#(server 8000 "!work")
# use    pil canvas.l --server 8000 "!work"
# then    (load "canvas.l")  to update

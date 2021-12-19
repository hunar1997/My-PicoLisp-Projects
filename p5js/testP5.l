(allowed ()
      "!home" setTime setLocation "@lib.css" )

   (load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

   (de setTime (H M S)
      (set> (: time) (time H M S)) )

   (de setLocation (X Y)
      (set> (: x) X)
      (set> (: y) Y) )

   (de home ()
      (app)
      (action
         (html 0 "OnClick Demo" "@lib.css" NIL
            (form NIL
               (<h3> NIL "OnClick Demo")
               (gui '(+OnClick +Button) "alert('OK')" "Alert")
               (----)
               (<grid> ".--"
                  "Browser Time" (gui 'time '(+Lock +TimeField) 10)
                  (gui '(+OnClick +Button)
                     "var t = new Date();
                        return lisp(this.form, 'setTime',
                           t.getHours(), t.getMinutes(), t.getSeconds() )"
                     "Now!" )
                  NIL NIL NIL
                  "Pos X" (gui 'x '(+Lock +FixField) 6 8)
                  (gui '(+OnClick +Button)
                     "var Form = this.form;
                        navigator.geolocation.getCurrentPosition(function(pos) {
                           lisp(Form, 'setLocation',
                              pos.coords.latitude * 1000000,
                              pos.coords.longitude * 1000000 );
                        } );
                        return false;"
                     "Set Location" )
                  "Pos Y" (gui 'y '(+Lock +FixField) 6 8) ) ) ) ) )

   (de main ())

   (de go ()
      (server 8000 "!home") )
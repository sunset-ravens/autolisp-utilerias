(defun suma (punto xx yy)
  (setq xxx (car punto))
  (setq yyy (car (cdr punto)))
  (setq xxx (+ xxx xx))
  (setq yyy (+ yyy yy))
  (list xxx yyy)
)

(defun asigna ()
  (setq xm (car (cdr (assoc 10 (entget ob)))))
  (setq xml ele2)
)

(defun ordenax ()
  (setq ele2 0)
  (setq xlm 0)
  (setq ob (ssname gpo ele2))
  (setq xm (car (cdr (assoc 10 (entget ob)))))  
  (while ob
    (if (>= (car (cdr (assoc 10 (entget ob)))) xm)
      (asigna)
    )
    (setq ele2 (+ ele2 1))
    (setq ob (ssname gpo ele2))
  )
)

(defun cadena ()
  (setq cad ob)
  (setq cadtex (cdr (assoc 1 (entget cad))))
  (setq numtxt ele)
)

(defun ordena ()
  (setq ele 0)
  (setq ob (ssname gpo ele))
  (while ob
    (if (= "LINE" (cdr (assoc 0 (entget ob))))
      (setq numli ele)
    )
    (if (= "TEXT" (cdr (assoc 0 (entget ob))))
      (cadena)
    )
    (setq ele (+ ele 1))
    (setq ob (ssname gpo ele))
  )
  (setq gpoo (ssadd (ssname gpo numtxt)))
  (setq gpoo (ssadd (ssname gpo numli)))
  (ssdel (ssname gpo numli) gpo)
  (if (> numtxt numli)
    (setq numtxt (- numtxt 1))
  )
  (ssdel (ssname gpo numtxt) gpo)

  (setq ele 0)
  (setq ele2 0)
  (setq ob (ssname gpo ele))
  (while (/= ele (- eleme 2))
    (ordenax)
    (ssadd (ssname gpo xml) gpoo)
    (ssdel (ssname gpo xml) gpo)
    (setq ele (+ ele 1))
  )
)

(defun ordena2 ()
  (setq ele 0)
  (setq ob (ssname gpo ele))
  (while ob
    (if (= "LINE" (cdr (assoc 0 (entget ob))))
      (setq numli ele)
    )
    (setq ele (+ ele 1))
    (setq ob (ssname gpo ele))
  )
  (setq gpoo (ssadd (ssname gpo numli)))
  (ssdel (ssname gpo numli) gpo)

  (setq ele 0)
  (setq ele2 0)
  (setq ob (ssname gpo ele))
  (while (/= ele (- eleme 1))
    (ordenax)
    (ssadd (ssname gpo xml) gpoo)
    (ssdel (ssname gpo xml) gpo)
    (setq ele (+ ele 1))
  )
)


(defun ver1 ()
  (setq ele 0)
  (setq ob (ssname gpoo ele))
  (while ob
    (prin1 (entget ob))
    (write-line " ")
    (setq ele (+ ele 1))
    (setq ob (ssname gpoo ele))
  )
)

(defun ver2 ()
  (setq ele 0)
  (setq ob (ssname gpo ele))
  (while ob
    (prin1 (entget ob))
    (write-line " ")
    (setq ele (+ ele 1))
    (setq ob (ssname gpo ele))
  )
)

(defun mueve ()
  (setq p11 (suma (cdr (assoc 10 (entget (ssname gpoo 0)))) 0.1 0.1))
  (setq p12 (suma (cdr (assoc 10 (entget (ssname gpoo 0)))) -0.1 -0.1))
  (command "ZOOM" "w" p11 p12)
  (command "MOVE" gpoo cad "" "mid" (cdr (assoc 10 (entget (ssname gpoo 0)))) "0,0")
  (command "ZOOM" "w" "50,50" "-50,-50")
)

(defun rota ()
  (setq p1 (cdr (assoc 10 (entget (ssname gpoo 0)))))
  (setq p2 (cdr (assoc 11 (entget (ssname gpoo 0)))))
  (setq angulo (- 360.0 (atof (angtos (angle p1 p2) 0 4))))
  (command "ROTATE" gpoo cad "" "0,0" angulo)
  (setq r1 (getstring "\n Rotar 180 <N>:"))
  (if (= (strcase r1) "S")
    (command "ROTATE" gpoo cad "" "0,0" "180")
  )
)

(defun ez (obje)
  (setq obje (entnext obje))
  (setq obje (entnext obje))
  (setq eleva (cdr (assoc 1 (entget obje))))
  (setq elev (atof eleva))
)

(defun traza ()
  (setq ele 1)
  (setq ob1 (ssname gpoo ele))
  (setq p1 (cdr (assoc 10 (entget ob1))))
  (setq ob2 ob1)
  (setq salir 1)
  (setq gpoo2 (ssadd))
  (while salir
    (setq ele (+ ele 1))
    (setq ob2 (ssname gpoo ele))
    (setq p2 (cdr (assoc 10 (entget ob2))))
    (setq x1 (car p1))
    (setq x2 (car p2))
    (setq z1 (ez ob1))
    (setq z2 (ez ob2))
    (setq p1r (list x1 z1))
    (setq p2r (list x2 z2))
    (command "LINE" p1r p2r "")
    (ssadd (entlast) gpoo2)
    (setq p1 p2)
    (setq ob1 ob2)
    (setq salir (ssname gpoo (+ ele 1)))
  )
)

(defun inserta ()
  (setq cco (ssname gpoo 1))
  (setq cco (entnext cco)) (setq cco (entnext cco))
  (setq cco (cdr (assoc 1 (entget cco))))
  (setq cco (- (atof cco) 3.5))
  (setq cco2 (- cco 5))
  (setq cco3 (- cco 10))
  (command "LINE" (strcat "0," (rtos cco3 2 2)) "@40<90" "")
  (setq linv (entlast))
  (setq pl1 (cdr (assoc 10 (entget linv))))
  (setq pl2 (cdr (assoc 11 (entget linv))))
  (setq lina (ssname gpoo2 0))
  (setq cuenta 0)
  (while (/= cuenta (sslength gpoo2))
    (setq pl3 (cdr (assoc 10 (entget lina))))
    (setq pl4 (cdr (assoc 11 (entget lina))))
    (setq nivel (inters pl1 pl2 pl3 pl4 T))
    (setq cuenta (+ cuenta 1))
    (setq lina (ssname gpoo2 cuenta))
    (if nivel
      (setq cuenta (sslength gpoo2))
    )
  )
  (setq ycco1 (+ cco 10)) (setq ycco2 (- cco 10))
  (command "ZOOM" "W" (strcat "-21," (rtos ycco1 2 2)) (strcat "21," (rtos ycco2 2 2)))
  (command "VIEW" "S" "S")
  (setq cco (strcat "0," (rtos cco 2 2)))
  (command "MOVE" gpoo cad "" "0,0" (strcat "0," (rtos cco2 2 2)))
  (command "INSERT" "texto1" nivel "" "" "")
  (command "EXPLODE" (entlast))
  (setq nivel2 (car (cdr nivel)))
  (setq nivv (entlast))
  (entdel linv)
  (entmod (subst (cons 1 (rtos nivel2 2 3)) (assoc 1 (entget nivv)) (entget nivv)))
  (command "INSERT" "texto2" nivel "" "" "")
  (command "EXPLODE" (entlast))
  (setq cadt (entlast))
  (entmod (subst (cons 1 cadtex) (assoc 1 (entget cadt)) (entget cadt)))
)

(defun bloque ()
  (command "ERASE" gpoo cad "")
  (setq nomblo (strcat (substr cadtex 1 1) "-" (substr cadtex 3 3)))
  (command "BLOCK" nomblo nivel gpoo2 cadt nivv "")
  (setq exi (open (strcat nomblo ".DWG") "r"))
  (if exi
    (close exi)
  )
  (if exi
    (command "WBLOCK" nomblo "Y" nomblo)
    (command "WBLOCK" nomblo nomblo)
  )
  (command "VIEW" "R" "C")
)

(defun borrar ()
  (setq r2 (getstring " Eliminar los datos en planta y crear bloque <S>:"))
  (if (= r2 "")
    (setq r2 "S")
  )
  (if (= (strcase r2) "S")
    (bloque)
  )
)

(defun c:se ()
  (command "OSNAP" "none")
  (print "\n Seleciona los elementos a procesar ")
  (setq gpo (ssget))
  (setq eleme (sslength gpo))
  (setq gpoo (ssadd))
  (ordena)
  (mueve)
  (rota)
  (setq eleme (- eleme 1))
  (setq gpo gpoo)
  (ordena2)
  (traza)
  (ver1)
  (inserta)
  (borrar)
)
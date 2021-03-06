(defun c:ARRM ()
  (PROMPT "Selecciona las lineas  ")
  (setq gpol (ssadd))
  (setq gpol (SSGET))
  (setq e1 (ssname gpol 0))
  (setq e2 (ssname gpol 1))
  (setq xyz (cdr (assoc 10 (entget e1))))
  (setq xyzf (cdr (assoc 11 (entget e1))))
  (setq xyz2 (cdr (assoc 10 (entget e2))))
  (setq xyz2f (cdr (assoc 11 (entget e2))))
;  (if (> (distance xyz xyzf) (distance xyz2 xyz2f))
;   (progn
;    (setq prov e1)
;    (setq e1 e2)
;    (setq e2 prov)
;   )
;  )
  (SETQ x (CAR xyz))
  (SETQ Y (CADR xyz))
  (SETQ xf (CAR xyzf))
  (SETQ Yf (CADR xyzf))
  (SETQ x2 (CAR xyz2))
  (SETQ Y2 (CADR xyz2))
  (SETQ x2f (CAR xyz2f))
  (SETQ Y2f (CADR xyz2f))
  (if (or (= x x2) (= xf x2f) (= x x2f) (= xf x2))
    (if (> Y Y2)
      (progn
        (setq Y (1+ Y))
        (setq Y2 (1- Y2))
        (setq puntof1 (strcat (rtos X 2 6) "," (rtos Y 2 6)))
        (setq puntof2 (strcat (rtos X2 2 6) "," (rtos Y2 2 6)))
      )
    )
    (if (< Y Y2)
      (progn
        (setq Y (1- Y))
        (setq Y2 (1+ Y2))
        (setq puntof1 (strcat (rtos X 2 6) "," (rtos Y 2 6)))
        (setq puntof2 (strcat (rtos X2 2 6) "," (rtos Y2 2 6)))
      )
    )
  )
  (if (or (= y y2) (= yf y2f) (= y y2f) (= yf y2))
    (if (> x x2)
      (progn
        (setq x (1+ x))
        (setq x2 (1- x2))
        (setq puntof1 (strcat (rtos X 2 6) "," (rtos Y 2 6)))
        (setq puntof2 (strcat (rtos X2 2 6) "," (rtos Y2 2 6)))
      )
    )
    (if (< x x2)
      (progn
        (setq x (1- x))
        (setq x2 (1+ x2))
        (setq puntof2 (strcat (rtos X 2 6) "," (rtos Y 2 6)))
        (setq puntof1 (strcat (rtos X2 2 6) "," (rtos Y2 2 6)))
      )
    )
  )
  (command "offset" "0.0245" e1 puntof1 e2 puntof2 "")
  (command "erase" e1 e2 "")
)

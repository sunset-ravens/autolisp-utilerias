(defun c:lp2 ()
  (setq lcr (getvar "clayer"))
  (COMMAND "UNDO" "MA")
  (command "-layer" "SET" "PUNPOLY" "")
  (SETQ TX (CAR (ENTSEL "\n SELECCIONA TEXTO DEL EJIDO")))
  (SETQ DESC (cdr (assoc 1 (entget TX))))
  (SETQ LIN (CAR (ENTSEL "\n SELECCIONA LA LINEA DEL EJIDO")))
  (SETQ X "LLAMA")
  (c:inspun)
  (c:lintopf)
  (SETQ X "")
  (command "-layer" "SET" lcr "")
;  (COMMAND "ZOOM" "E")
;  (command "block" "prov" "Y" "0,0" (ssget "P") (ssget "X" '((8 . "COTAS"))) (ssget "X" '((8 . "PUNPOLY"))) LIN "")
;  (command "wblock" (STRCAT "C:\\TOPOGRAF\\ROSARIO\\EJIDOS\\" DESC) "PROV" "")
;  (command "ERASE" (ssget "P") (ssget "X" '((8 . "COTAS"))) (ssget "X" '((8 . "PUNPOLY"))) LIN "")
)

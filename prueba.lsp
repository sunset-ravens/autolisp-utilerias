(defun c:LIS ()
    (setq PUNTO (getpoint " DAME EL PUNTO : "))
    (setq texto (car (entsel "Selecciona el texto: ")))
    (setq NOMBRE (cdr (assoc 1 (entget TEXTO))))
    (print "\n Seleciona los elementos a procesar ")
    (setq gpo (ssget))
    (setq xy (strcat "0," NOMBRE))
    (command "MOVE" gpo "" PUNTO xy)
    (COMMAND "ZOOM" "C" XY "13")
    (setq texto (car (entsel "Selecciona el texto: ")))
    (setq NOMBRE (cdr (assoc 1 (entget TEXTO))))
    (setq nomblo (strcat (substr NOMBRE 1 1) "-" (substr NOMBRE 3 3)))
    (print "\n Seleciona los elementos a procesar ")
    (setq gpo (ssget))
    (command "BLOCK" nomblo "Y" "0,0" gpo "")
    (command "zoom" "P")
)

(defun c:is ()
    (setq texto (car (entsel "estacion ")))
    (setq NOMBLO (cdr (assoc 1 (entget TEXTO))))
    (setq elev2 (car (entsel "Selecciona el cadenamiento ")))
    (setq n2 (cdr (assoc 1 (entget elev2))))
    (command "insert" (STRCAT "*" nomblo) "0,0" "" "" "")
    (COMMAND "ZOOM" "C" XY "60")
    (COMMAND "EXPLODE" L "")
    (COMMAND "INSERT" "pr" XY "" "" "")
    (command "CHANGE" texto elev "" "P" "C" "RED" "")
    (COMMAND "-LAYER" "F" "RETICULA" "")
)

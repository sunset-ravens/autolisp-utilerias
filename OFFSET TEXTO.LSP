(defun c:OF ()
    (setq texto (car (entsel "Selecciona el texto: ")))
    (setq NOMBRE (cdr (assoc 1 (entget TEXTO))))
    (COMMAND "OFFSET" NOMBRE)
)

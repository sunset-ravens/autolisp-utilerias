(defun C:cAM ()
    (setq f (getint "INICIO : " ))
    (setq T1 F)
    (REPEAT 1000
        (setq e (car (entsel "Selecciona EL BLOCK: ")))
        (SETQ BL (ENTNEXT E))
        (SETQ BL (ENTNEXT BL))
        (SETQ VALS (STRCAT "" (ITOA T1)))
        (COMMAND "attedit" "" "" "" "" bl "V" "R" VALS "")
        (setq T1(+ T1 1))
    )
)

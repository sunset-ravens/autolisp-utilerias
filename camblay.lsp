(defun C:cb ()
        (print "\n Cambio de textos")
        (setq s1 (getreal "\n Rango inferior de curvas : "))
        (setq inc (getreal "\n Incremento : "))
        (setq prov 0)
        (repeat 1000
          (setq prov (1+ prov))
          (setq NL (+ (* prov inc) s1))
          (SETQ NL (RTOS NL 2 3))
          (setq prov2 1)
          (while (/= "." (substr NL prov2 1))
            (setq prov2(1+ prov2))
          )
          (setq NL (strcat (substr NL 1 (1- prov2)) "-" (substr NL (1+ prov2) 3)))
          (setq e (car (entsel "Selecciona EL TEXTO: ")))
          (command "change" e "" "" "" "" "" "" nl)
        )
)

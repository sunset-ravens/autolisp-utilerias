(defun C:col ()
  (COMMAND "UNDO" "M")
  (setq pos (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  (SETQ PT (GETPOINT "\n Punto intermedio de la columna"))
  (command "BPOLY" PT "")
  (setq e (ENTLAST))
;  (setq pt (getpoint "\n Punto exterior para ofset"))
  (command "offset" "0.05" e pt "")
  (command "pedit" (entlast) "W" "0.035" "")
  (COMMAND "ERASE" E "")
  (setvar "OSMODE" POS)
)

(defun C:mur ()
  (COMMAND "UNDO" "M")
  (setq pos (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  (SETQ PT (GETPOINT "\n Punto intermedio del muro"))
  (command "BPOLY" PT "")
  (setq e (ENTLAST))
;  (setq pt (getpoint "\n Punto exterior para ofset"))
  (command "offset" "0.03" e pt "")
  (command "pedit" (entlast) "W" "0.025" "")
  (COMMAND "ERASE" E "")
  (setvar "OSMODE" POS)
)

(defun C:VENT ()
  (setq e (car (entsel "\n Selecciona la polylinea")))
  (setq pt (getpoint "\n Punto exterior para ofset"))
  (command "offset" "0.03" e pt "")
  (command "pedit" (entlast) "W" "0.025" "")
)

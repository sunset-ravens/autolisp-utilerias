(defun c:PTH ()
  (C:LIBRERIA "BUSCA VALOR DE ATRIBUTO")
  (setq B1 (CAR (ENTSEL "SELECCIONA BLOCK FUENTE")))
  (setq B2 (CAR (ENTSEL "SELECCIONA BLOCK DESTINO")))
  (SETQ V1 (BUSATR B1 "CODE"))
  (setq b2 (entnext b2))
  (COMMAND "ATTEDIT" "" "" "" "" B2 "V" "" V1 "")
)
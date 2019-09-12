(defun c:ppare ()
  (command "undo" "m")
  (COMMAND "VIEW" "S" "PROV")
  (SETQ OPCIONESOS (GETVAR "OSMODE"))
  (command "osnap" "none")
  (C:LIBRERIA "VERTICES DE UNA LWPOLYLINE")
  (setq poli (car (entsel "\n Selecciona la poligonal envolvente: ")))
  (SETQ PROV 1)
  (SETQ P1T (VERTICE POLI PROV))
  (SETQ XMENOR (CAR P1T))
  (SETQ YMENOR (CADR P1T))
  (SETQ XMAYOR XMENOR)
  (SETQ YMAYOR YMENOR)
  (SETQ PROVV P1T)
  (while p1t
    (SETQ X2PROV (CAR P1T))
    (SETQ Y2PROV (CADR P1T))
    (IF (AND (< X2PROV XMENOR) (/= X2PROV nil)) (SETQ XMENOR X2PROV))
    (IF (AND (< Y2PROV YMENOR) (/= Y2PROV nil)) (SETQ YMENOR Y2PROV))
    (IF (AND (> X2PROV XMAYOR) (/= X2PROV nil)) (SETQ XMAYOR X2PROV))
    (IF (AND (> Y2PROV YMAYOR) (/= Y2PROV nil)) (SETQ YMAYOR Y2PROV))
    (SETQ PROV (1+ PROV))
    (SETQ P1T (VERTICE POLI PROV))
  )

  (setq dosx (* (- xmayor xmenor) 0.30))
  (setq dosy (* (- ymayor ymenor) 0.30))
  (COMMAND "ZOOM" "W" (STRCAT (RTOS (- XMENOR dosx) 2 6) "," (RTOS (- YMENOR dosy) 2 6)) (STRCAT (RTOS (+ XMAYOR dosx) 2 6) "," (RTOS (+ YMAYOR dosy) 2 6)))
  (REDRAW POLI 3)

  (setq punver1 (list xmenor ymenor))
  (setq punver2 (list xmayor ymayor))
  (setq escgpo (ssget "C" punver1 punver2 '((0 . "INSERT"))))
  (if (= escgpo nil) 
    (progn
      (alert "faltan vertices de la clinica")
      (exit)
    )
  )

  (SETQ DIMX 0.678)
  (SETQ DIMY 0.53446)
  (if (< (/ (- ymayor ymenor) (- xmayor xmenor)) 0.788)
    (PROGN
      (setq dsten (+ (- xmayor xmenor) (/ dosx 20)))
      (setq escala (/ dsten 67.8))
    )
    (PROGN
      (setq dsten (+ (- ymayor ymenor) (/ dosy 20)))
      (setq escala (/ dsten 53.446))
    )
  )

  (setq ej (ssname escgpo 0))
  (setq t1 1)
  (while Ej
    (setq fs2 (cdr (assoc 41 (entget ej))))
    (setq FSN (/ (* escala 1) FS2))
    (setq XYZ (cdr (assoc 10 (entget Ej))))
      (if (= "PUNTO" (cdr (assoc 2 (entget Ej))))
        (command "SCALE" (cdr (assoc -1 (entget Ej))) "" XYZ fsn)
      )
      (setq Ej (ssname escgpo t1))
      (setq t1 (1+ t1))
  )
;  (SETQ OPCION (GETSTRING "\n PP de solar o plano general (s/r) <r>"))
;  (if (= opcion "") (setq opcion "r"))
  (setq nblock "ppcareas.dwg")
  (SETQ CENTROIDEY1 (+ (/ (- YMAYOR YMENOR) 2) YMENOR))
  (SETQ CENTROIDEX1 (+ (/ (- XMAYOR XMENOR) 2) XMENOR))
  (COMMAND "INSERt" (STRCAT RUTA "BLOCKS\\" nblock) "PS" ESCALA (strcat (rtos CENTROIDEX1 2 6) "," (rtos CENTROIDEY1 2 6)) ESCALA "" "")
  (COMMAND "EXPLODE" (ENTLAST) "")
  (SETQ GPOpp (SSGET "P"))
  (SETQ P2 0)  
  (SETQ PROV (SSNAME GPOPP P2))
  (SETQ AO (ENTGET PROV))
  (WHILE (/= PROV NIL)
    (IF (AND (= (cdr (assoc 0 AO)) "INSERT") (= (cdr (assoc 2 AO)) "careas"))
      (SETQ BCAREAS PROV)
    )
    (IF (AND (= (cdr (assoc 0 AO)) "INSERT") (= (cdr (assoc 2 AO)) "datosg"))
      (SETQ BDTG PROV)
    )
    (IF (AND (= (cdr (assoc 0 AO)) "INSERT") (= (cdr (assoc 2 AO)) "careas2"))
      (SETQ BCAREAS2 PROV)
    )
    (IF (= (cdr (assoc 0 AO)) "TEXT")
      (SETQ etext PROV)
    )
    (SETQ P2 (1+ P2))   
    (SETQ PROV (SSNAME GPOPP P2))
    (IF (/= PROV NIL)
      (SETQ AO (ENTGET PROV))
    )
  );WHILE
  (setq poligonoc poli)
  (command "AREA" "OB" poligonoc "")
  (SETQ AREAclinica (GETVAR "AREA"))
  (C:LIBRERIA "acota")
  (acotax poligonoc escala)
  (setq gpo (ssget "X" (list (cons 0 "INSERT") (cons 2 "datos"))))
  (if (/= gpo nil)
    (progn
      (if (> (sslength gpo) 0)
         (progn
          (SETQ PROV (SSNAME GPO 0))
           (setq en (entnext prov))
          (setq ed (entget en))
          (setq status (cdr (assoc 1 ed)))
          (setq en (entnext en))
          (setq ed (entget en))
          (setq dclin (cdr (assoc 1 ed)))
           (setq en (entnext en))
          (setq ed (entget en))
          (setq localid (cdr (assoc 1 ed)))
          (setq en (entnext en))
          (setq ed (entget en))
          (setq municip (cdr (assoc 1 ed)))
        )
      )
    )
  )
  (if (= gpo nil)
    (progn
      (setq statusx (strcase (Getstring "\n Status de la Clinica? ('E'jidal/'P'eque�a) :")))
      (if (= statusx "E") (setq status "Propiedad Ejidal"))
      (if (/= statusx "E") (setq status "Peque�a propiedad"))
      (setq dclin (Getstring PROMPT "\n Denominacion de la clinica :"))
      (setq localid (Getstring PROMPT "\n Localidad :"))
      (setq municip (Getstring PROMPT "\n Municipio :"))
    )
  )
  (print "\n Seleciona los poligonos de clinica : ")
  (setq gpocl (ssget))
  (setq atcl 0)
  (SETQ P2 0)  
  (SETQ PROV (SSNAME GPOcl P2))
  (SETQ AO (ENTGET PROV))
  (WHILE (/= PROV NIL)
    (command "hatch" "ansi31" (* 0.168 escala) "0" prov "")
    (command "Change" (entlast) prov "" "p" "c" 2 "")
    (command "AREA" "OB" prov "")
    (SETQ AREAx (GETVAR "AREA"))
    (setq atcl (+ atcl areax))
    (SETQ P2 (1+ P2))   
    (SETQ PROV (SSNAME GPOcl P2))
    (IF (/= PROV NIL)
      (SETQ AO (ENTGET PROV))
    )
  );WHILE
  (print "\n Seleciona los poligonos de cara : ")
  (setq gpoca (ssget))
  (setq atca 0)
  (SETQ P2 0)  
  (SETQ PROV (SSNAME GPOca P2))
  (SETQ AO (ENTGET PROV))
  (WHILE (/= PROV NIL)
    (command "hatch" "ansi37" (* 0.168 escala) "45" prov "")
    (command "Change" (entlast) prov "" "p" "c" 3 "")
    (command "AREA" "OB" prov "")
    (SETQ AREAx (GETVAR "AREA"))
    (setq atca (+ atca areax))
    (SETQ P2 (1+ P2))   
    (SETQ PROV (SSNAME GPOca P2))
    (IF (/= PROV NIL)
      (SETQ AO (ENTGET PROV))
    )
  );WHILE
  (print "\n Seleciona los poligonos de cisterna : ")
  (setq gpocs (ssget))
  (setq atcs 0)
  (SETQ P2 0)  
  (SETQ PROV (SSNAME GPOcs P2))
  (SETQ AO (ENTGET PROV))
  (WHILE (/= PROV NIL)
    (command "hatch" "STEEL" (* 0.168 escala) "90" prov "")
    (command "Change" (entlast) prov "" "p" "c" 4 "")
    (command "AREA" "OB" prov "")
    (SETQ AREAx (GETVAR "AREA"))
    (setq atcs (+ atcs areax))
    (SETQ P2 (1+ P2))   
    (SETQ PROV (SSNAME GPOcs P2))
    (IF (/= PROV NIL)
      (SETQ AO (ENTGET PROV))
    )
  );WHILE
  (SETQ SUPCONST (+ atcl atca atcs))                                           ;modulo modifica areas
  (SETQ SUPSCONST (- AREACLINICA SUPCONST)) 
  (setq en (entnext BCAREAS))
  (setq ed (entget en))
  (setq ed (subst (cons 1 (RTOS SUPSCONST 2 3)) (assoc 1 ed) ed)) 
  (entmod ed) 
  (setq en (entnext EN))
  (setq ed (entget en))
  (setq ed (subst (cons 1 (RTOS SUPCONST 2 3)) (assoc 1 ed) ed)) 
  (entmod ed) 
  (setq en (entnext EN))
  (setq ed (entget en))
  (setq ed (subst (cons 1 (RTOS AREACLINICA 2 3)) (assoc 1 ed) ed)) 
  (entmod ed) 								;modulo modifica areas
  (setq en (entnext Bdtg))
  (setq en (entnext EN))
  (setq ed (entget en))
  (setq ed (subst (cons 1 municip) (assoc 1 ed) ed)) 
  (entmod ed) 
  (setq en (entnext EN))
  (setq ed (entget en))
  (setq ed (subst (cons 1 localid) (assoc 1 ed) ed)) 
  (entmod ed) 
  (setq en (entnext EN))
  (setq ed (entget en))
  (setq ed (subst (cons 1 status) (assoc 1 ed) ed)) 
  (entmod ed)                                                       ;modulo modifica datos
  (setq ed (entget etext))
  (setq ed (subst (cons 1 dclin) (assoc 1 ed) ed)) 
  (entmod ed) 								;modulo modifica areas

  (setq en (entnext BCAREAS2))
  (setq ed (entget en))
  (setq ed (subst (cons 1 (RTOS ATCS 2 3)) (assoc 1 ed) ed)) 
  (entmod ed) 
  (setq en (entnext EN))
  (setq ed (entget en))
  (setq ed (subst (cons 1 (RTOS ATCL 2 3)) (assoc 1 ed) ed)) 
  (entmod ed) 
  (setq en (entnext EN))
  (setq ed (entget en))
  (setq ed (subst (cons 1 (RTOS ATCA 2 3)) (assoc 1 ed) ed)) 
  (entmod ed) 								;modulo modifica areas

  (SETQ opacota "0")             ;llamada lpf
  (SETQ ESCc 0.57)
  (SETQ OPbav "1")
  (SETQ OPpdesf "0")
  (SETQ OPip "0")
  (SETQ OPcrcu "1")
  (setq nottexto "0")
  (setq noterr "0")
  (setq notadj "0")
  (SETQ LIN POLIGONOC)
  (SETQ X "LLAMA")                        ;llamada lpf
  (C:LPF)
  (COMMAND "SCALE" "P" "" EII escala)
  (COMMAND "VIEW" "R" "PROV")
  (SETVAR "OSMODE" OPCIONESOS)
  (SETQ X NIL)
)

(defun c:insat ()
  (setq GRDFILE (getfiled "ARCHIVO GRID FUENTE" "C:\\TOPOGRAF\\" "GRD" 18))
  (SETQ FGRD (OPEN (strcat ruta "GRD.GRI") "w"))
  (WRITE-LINE GRDFILE FGRD)
  (CLOSE FGRD)
  (COMMAND "SHELL" (strcat "C:\\SURFER6\\GSMAC32.EXE /X " ruta "PERFS.BAS"))
)

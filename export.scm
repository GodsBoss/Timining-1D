(let* ((image (car (gimp-file-load RUN-NONINTERACTIVE "./gfx.xcf" "gfx.xcf"))))
	(file-png-save RUN-NONINTERACTIVE image (car (gimp-image-merge-visible-layers image EXPAND-AS-NECESSARY)) "./dist/gfx.png" "gfx.png" 0 9 0 0 0 0 0)
	(gimp-quit 0))

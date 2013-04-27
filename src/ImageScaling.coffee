class ImageScaling
	constructor:(@document)->

	# image: <img> or <canvas>
	# f: Scaling factor
	scale:(image, f)->
		w = image.width
		h = image.height
		canvas = @document.createElement 'canvas'
		canvas.width = w*f
		canvas.height = h*f
		context = canvas.getContext '2d'
		context.clearRect 0, 0, w*f, h*f
		context.drawImage image, 0, 0

		origImageData = context.getImageData 0, 0, w, h
		origImageDataArray = origImageData.data

		newImageData = context.createImageData w*f, h*f
		newImageDataArray = newImageData.data

		for x in [0..w*f-1]
			for y in [0..h*f-1]
				origPos = ((Math.floor y/f)*w + (Math.floor x/f))*4
				pos = (y*w*f + x)*4
				for offset in [0..3]
					newImageDataArray[pos+offset] = origImageDataArray[origPos+offset]

		context.clearRect 0, 0, w*f, h*f
		context.putImageData newImageData, 0, 0
		canvas

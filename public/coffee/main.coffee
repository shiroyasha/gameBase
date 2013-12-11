define (require, exports, module) ->

	App    = require('App')
	loadImages = require('Images')
	$ ->
		area = $('canvas')[0]
		c    = area.getContext '2d'

		loadImages ->
			app = new App( c )
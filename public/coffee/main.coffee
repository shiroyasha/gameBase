define (require, exports, module) ->

	$ ->
		area = $('canvas')[0];
		c    = area.getContext '2d'

		app = new App( c )


		keyDownHandler = (e) ->
			e.preventDefault()

			direction = app.model.direction


		$(document).on 'keydown', keyDownHandler 
		$(document).on 'keyup', 
		

return xxx
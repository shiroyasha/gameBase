define (require, exports, module) ->

	Keys = require('Keys')
	App  = require('App')

	$ ->
		area = $('canvas')[0];
		c    = area.getContext '2d'

		app = new App( c )

		mouseActive = false;
		keysDown = {};

		#normalize = (d) ->
		#	magnitude = Math.sqrt(d.x*d.x + d.y*d.y)
		#	if magnitude > 0
		#		d.x = Math.round((d.x/magnitude)*1000)/1000
		#		d.y = Math.round((d.y/magnitude)*1000)/1000

		# old mouse detection:
		# addMouseMotion = (x,y) ->
		# 	direction = app.model.inputDirection
		# 	position  = app.model.me.position

		# 	dx = x - position.x
		# 	dy = y - position.y

		# 	if dx != 0
		# 		direction.x = dx/Math.abs(dx)
		# 	else
		# 		direction.x = 0

		# 	if dy != 0 
		# 		direction.y = dy/Math.abs(dy)
		# 	else
		# 		direction.y = 0
		
		#	console.log "MouseMotion: ",direction.x,direction.y
		addMouseMotion = (x,y) ->
			k = 1.72; #angle of mouse forward detection
			if((y + k*x + 320*k > 0) and (y - k*x + 960*k > 0))
				console.log "Going forward"

			

		removeMouseMotion = ->
			direction = app.model.inputDirection
			direction.x = 0
			direction.y = 0

		keyDownHandler = (e) ->
			


			if keysDown[e.which]? then return e.preventDefault()
			keysDown[e.which] = true

			direction = app.model.inputDirection

			console.log 'down', e.which

			switch e.which
				when Keys.left,Keys.a  then direction.x -= 1;e.preventDefault()
				when Keys.right,Keys.d then direction.x += 1;e.preventDefault()
				when Keys.up,Keys.w    then direction.y -= 1;e.preventDefault()
				when Keys.down,Keys.s  then direction.y += 1;e.preventDefault()

			console.log "Down:",app.model.inputDirection


		keyUpHandler = (e) ->
			e.preventDefault()

			delete keysDown[e.which]

			direction = app.model.inputDirection

			switch e.which
				when Keys.left,Keys.a  then direction.x += 1;e.preventDefault()
				when Keys.right,Keys.d then direction.x -= 1;e.preventDefault()
				when Keys.up,Keys.w    then direction.y += 1;e.preventDefault()
				when Keys.down,Keys.s  then direction.y -= 1;e.preventDefault()

			#normalize( direction )

			console.log "Up:",app.model.inputDirection

		mouseDownHandler = (e) ->
			e.preventDefault()
			mouseActive = true

		mouseUpHandler = (e) ->
			e.preventDefault()
			mouseActive = false
			removeMouseMotion(e.clientX, e.clientY)

		mouseMoveHandler = (e) ->
			e.preventDefault()
			if(mouseActive)
				addMouseMotion(e.clientX, e.clientY)


		$(document).on 'keydown', keyDownHandler 
		$(document).on 'keyup', keyUpHandler
		$(document).on 'mouseup', mouseUpHandler
		$(document).on 'mousedown', mouseDownHandler
		$(document).on 'mousemove', mouseMoveHandler
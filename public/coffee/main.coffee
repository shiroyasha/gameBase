define (require, exports, module) ->

	Keys  = require('Keys')
	App   = require('App')

	$ ->
		area = $('canvas')[0];
		c    = area.getContext '2d'

		app = new App( c )

		#disable mouse events while mouse button is not pressed
		mouseActive = false

		#double touch for going fwd
		doubleTouch = false

		# based on player Y location, player.y / 320
		#k makes 'V' lean coefficient (FORWARD clickable range, Player visibility range (if needed)...)
		k = app.model.me.position.y / 320	
		
		keysDown = {}

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
			direction = app.model.inputDirection

			if doubleTouch
				direction.x = 0
				direction.y = -1
				return

			if (k*x - y - 320*k > 0) and (k*x + y - 960*k < 0)
				# Going forward
				direction.x = 0
				direction.y = -1
			else if(x < app.model.me.position.x)
				# Turning left
				direction.x = -1
				direction.y = 1
			else
				# Turning right
				direction.x = 1
				direction.y = 1		

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
				when Keys.left,Keys.a  then direction.x = -1;e.preventDefault()
				when Keys.right,Keys.d then direction.x =  1;e.preventDefault()
				when Keys.up,Keys.w    then direction.y = -1;e.preventDefault()
				#when Keys.down,Keys.s  then direction.y =  1;e.preventDefault()

			console.log "Down:",app.model.inputDirection


		keyUpHandler = (e) ->
			e.preventDefault()

			delete keysDown[e.which]

			direction = app.model.inputDirection

			switch e.which
				when Keys.left,Keys.a  then direction.x =  0;e.preventDefault()
				when Keys.right,Keys.d then direction.x =  0;e.preventDefault()
				when Keys.up,Keys.w    then direction.y =  0;e.preventDefault()
				#when Keys.down,Keys.s  then direction.y =  0;e.preventDefault()

			console.log "Up:",app.model.inputDirection

		mouseDownHandler = (e) ->
			e.preventDefault()
			mouseActive = true
			addMouseMotion(e.clientX, e.clientY)

		mouseUpHandler = (e) ->
			e.preventDefault()
			mouseActive = false
			removeMouseMotion()

		mouseMoveHandler = (e) ->
			e.preventDefault()
			if(mouseActive)
				addMouseMotion(e.clientX, e.clientY)

		touchStartHandler = (e) ->
			touchHandler(e)


		touchHandler = (e) ->
			e.preventDefault()
			if(e.originalEvent.touches[1])
				doubleTouch = true
			else
				doubleTouch = false

			addMouseMotion(e.originalEvent.touches[0].pageX, e.originalEvent.touches[0].pageY)
			
		touchEndHandler = (e) ->
			
			if e.originalEvent.touches.length == 1
				doubleTouch = false;
				addMouseMotion(e.originalEvent.touches[0].pageX, e.originalEvent.touches[0].pageY)

			if e.originalEvent.touches.length == 0
				removeMouseMotion()

		$(document).on 'keydown', keyDownHandler 
		$(document).on 'keyup', keyUpHandler
		$(document).on 'mouseup', mouseUpHandler
		$(document).on 'mousedown', mouseDownHandler
		$(document).on 'mousemove', mouseMoveHandler
		$(document).on 'touchstart', touchStartHandler
		$(document).on 'touchmove', touchHandler
		$(document).on 'touchend', touchEndHandler
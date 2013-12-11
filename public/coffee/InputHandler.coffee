define (require, exports, module) ->

	Keys = require('Keys')

	handleInput = ( model ) ->

		mouseActive = false;
		keysDown = {};

		addMouseMotion = (x,y) ->
			direction = model.inputDirection
			position  = model.me.position

			dx = x - position.x
			dy = y - position.y

			if dx != 0
				direction.x = dx/Math.abs(dx)
			else
				direction.x = 0

			if dy != 0
				direction.y = dy/Math.abs(dy)
			else
				direction.y = 0

			console.log "MouseMotion: ",direction.x,direction.y

		removeMouseMotion = ->
			direction = model.inputDirection
			direction.x = 0
			direction.y = 0

		keyDownHandler = (e) ->

			if keysDown[e.which]? then return e.preventDefault()
			keysDown[e.which] = true

			direction = model.inputDirection

			console.log 'down', e.which

			switch e.which
				when Keys.left,Keys.a  then direction.x -= 1;e.preventDefault()
				when Keys.right,Keys.d then direction.x += 1;e.preventDefault()
				when Keys.up,Keys.w    then direction.y -= 1;e.preventDefault()
				when Keys.down,Keys.s  then direction.y += 1;e.preventDefault()

			console.log "Down:", model.inputDirection


		keyUpHandler = (e) ->
			e.preventDefault()

			delete keysDown[e.which]

			direction = model.inputDirection

			switch e.which
				when Keys.left,Keys.a  then direction.x += 1;e.preventDefault()
				when Keys.right,Keys.d then direction.x -= 1;e.preventDefault()
				when Keys.up,Keys.w    then direction.y += 1;e.preventDefault()
				when Keys.down,Keys.s  then direction.y -= 1;e.preventDefault()

			#normalize( direction )

			console.log "Up:",model.inputDirection

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

	return handleInput
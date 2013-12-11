define (require, exports, module) ->

    return (callback) ->
        i = 0
        numOfImages = 2

        check = ->
            i++
            console.log "#{i}/#{numOfImages} Number Of Images Loaded"
            if i == numOfImages then callback()

        window.images = {}

        window.images.Asteroids = new Image()
        window.images.Asteroids.onload = check

        window.images.Asteroids.src = '/images/Asteroids.png'

        window.images.Planet = new Image()
        window.images.Planet.onload = check

        window.images.Planet.src = '/images/Planet.png'
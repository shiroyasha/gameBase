define (require, exports, module) ->

    NUM_OF_ASTEROIDS= 50

    MAX_DISTANCE     = 2000 #max distance between the asteroid and the player after which the asteroid is deleted
    MIN_DISTANCE     = 1000 #minimum distance at which an asteroid can be generated without the player noticing
    SPEED            = 50
    RADIUS           = 70
    RADIUS_VARIATION = 60
    MASS             = 100
    MAX_ROTATION     = 0.002 #rad/s


    AsteroidHandler = {}

    AsteroidHandler.updateAsteroids= (model) ->
        centerX = model.me.position.x
        centerY = model.me.position.y

        liveAsteroids = []

        for aster in model.asteroids
            if magnitude(aster.position.x - centerX, aster.position.y - centerY) < MAX_DISTANCE
                liveAsteroids.push(aster) #makes a list of asteroids still in the vicinity of the player
        model.asteroids = liveAsteroids

        for i in [model.asteroids.length...NUM_OF_ASTEROIDS] by 1
            model.asteroids.push(createNewAsteroid(model))

    createNewAsteroid= (model) ->
        newAsteroid = {}
        newAsteroid.position = {}
        newAsteroid.velocity = {}

        cX = model.me.position.x
        cY = model.me.position.y

        randomRadius = MIN_DISTANCE + Math.random()*( MAX_DISTANCE - MIN_DISTANCE )
        randomAngle  = Math.random() * Math.PI*2

        newAsteroid.position.x = cX + randomRadius*Math.cos( randomAngle )
        newAsteroid.position.y = cY + randomRadius*Math.sin( randomAngle )

        #newAsteroid.position.x = cX + MIN_DISTANCE + Math.random()*( MAX_DISTANCE - MIN_DISTANCE )
        #newAsteroid.position.y = cY + MIN_DISTANCE + Math.random()*( MAX_DISTANCE - MIN_DISTANCE )

        # while true
        #     newAsteroid.position.x = model.me.position.x + MAX_DISTANCE - Math.random()*MAX_DISTANCE*2 #krece se izmedju -MAX i MAX
        #     newAsteroid.position.y = model.me.position.y + MAX_DISTANCE - Math.random()*MAX_DISTANCE*2 #krece se izmedju -MAX i MAX
        #     if MIN_DISTANCE < magnitude(newAsteroid.position.x - cX, newAsteroid.position.y - cY) < MAX_DISTANCE
        #         break

        newAsteroid.velocity.x = SPEED - Math.random() * 2 * SPEED
        newAsteroid.velocity.y = SPEED - Math.random() * 2 * SPEED
        newAsteroid.radius     = RADIUS - Math.random() * RADIUS_VARIATION
        newAsteroid.mass       = newAsteroid.radius * newAsteroid.radius

        newAsteroid.orientation = Math.random() * Math.PI * 2
        newAsteroid.rotation = MAX_ROTATION -  2 * Math.random() * MAX_ROTATION

        return newAsteroid


    magnitude= (dx, dy) ->
        r = Math.sqrt(dx*dx+ dy*dy)


    return AsteroidHandler

    #body = [pX, pY, vX, vY, m, r, or, rot]
    #pozicija, brzina, masa, radius, orijentacija, rotacija
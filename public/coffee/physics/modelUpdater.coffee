
define (require, exports, module) ->

    exp = {}

    damping = 0.95 #uspori pri sudaru

    AsteroidHandler = require 'physics/AsteroidHandler'

    exp.updateModel = (model, dt) ->
        #polygoni nisu podrzani zasada
        list = model.asteroids.concat(model.me)

        updateBodies(list, dt)
        AsteroidHandler.updateAsteroids(model)
        resolveCollisions(list)

        return model

    exp.renderModel = (c, model) ->
        for ast in model.asteroids
            c.fillStyle = "red"
            c.beginPath();
            c.arc(ast.position.x, ast.position.y, ast.radius, 0, Math.PI*2, true);
            c.closePath();
            c.fill();


    #private functions

    updateBodies= (list, dt) ->
        for body in list
            body.position.x  += body.velocity.x*dt
            body.position.y  += body.velocity.y*dt
            body.orientation += body.rotation*dt

    resolveCollisions= (list) ->
        for b1 in [0...list.length]
            for b2 in [b1+1...list.length]
                collisionCheck(list[b1], list[b2])

    collisionCheck= (body1, body2) ->
        dist = Math.sqrt(Math.pow(body1.position.x-body2.position.x,2)+Math.pow(body1.position.y-body2.position.y,2))
        if dist < (body1.radius+body2.radius)
            bounce(body1, body2, dist, damping)

    bounce= (body1, body2, dist, damping=1) ->
        # NE DIRAJ. AKO HOCES DA OPTIMIZUJES, OBRATI SE MIKI. RADI. PROVERENO. KRAJ.

        dx    = body1.position.x - body2.position.x
        dy    = body1.position.y - body2.position.y
        ang   = Math.atan2(dy, dx)

        mag1  = Math.sqrt(body1.velocity.x*body1.velocity.x + body1.velocity.y*body1.velocity.y)
        mag2  = Math.sqrt(body2.velocity.x*body2.velocity.x + body2.velocity.y*body2.velocity.y)

        dir1  = Math.atan2(body1.velocity.y, body1.velocity.x)
        dir2  = Math.atan2(body2.velocity.y, body2.velocity.x)

        nSx1  = mag1*Math.cos(dir1-ang)
        nSy1  = mag1*Math.sin(dir1-ang)

        nSx2  = mag2*Math.cos(dir2-ang)
        nSy2  = mag2*Math.sin(dir2-ang)

        fSx1  = ((body1.mass-body2.mass)*nSx1+(body2.mass+body2.mass)*nSx2)/(body1.mass+body2.mass);
        fSx2  = ((body1.mass+body1.mass)*nSx1+(body2.mass-body1.mass)*nSx2)/(body1.mass+body2.mass);
        fSy1  = nSy1;
        fSy2  = nSy2;

        body1.velocity.x = Math.cos(ang)*fSx1+Math.cos(ang+Math.PI/2)*fSy1;
        body1.velocity.y = Math.sin(ang)*fSx1+Math.sin(ang+Math.PI/2)*fSy1;
        body2.velocity.x = Math.cos(ang)*fSx2+Math.cos(ang+Math.PI/2)*fSy2;
        body2.velocity.y = Math.sin(ang)*fSx2+Math.sin(ang+Math.PI/2)*fSy2;

        if damping != 1
            body1.velocity.x *= damping
            body1.velocity.y *= damping
            body2.velocity.x *= damping
            body2.velocity.y *= damping

        #razmakne ih kako bi se sprecilo vezivanje tela.

        gap = body1.r + body2.radius - dist
        gapX = gap * Math.cos(ang)
        gapY = gap * Math.sin(ang)


        massSum = body1.mass + body2.mass
        body1.px += gapX * body1.mass / massSum
        body1.py += gapY * body1.mass / massSum
        body2.px -= gapX * body2.mass / massSum
        body2.py -= gapY * body2.mass / massSum

    return exp
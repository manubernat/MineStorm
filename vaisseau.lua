VaisseauX = 400
VaisseauY = 300
VaisseauAngle = 0
VaisseauImage = love.graphics.newImage("vaisseau.png")
VaisseauOffsetX = VaisseauImage:getWidth() / 2
VaisseauOffsetY = VaisseauImage:getHeight() / 2
VaisseauDX = 0
VaisseauDY = 0
DelaiTeleportation = 0

Acceleration = 70
Decceleration = 0.95

function DessineVaisseau()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(VaisseauImage,VaisseauX,VaisseauY,VaisseauAngle,1,1,VaisseauOffsetX,VaisseauOffsetY)
end

function AccelereVaisseau()
    VaisseauDX = VaisseauDX + Acceleration * math.sin(VaisseauAngle)
    VaisseauDY = VaisseauDY + Acceleration * math.cos(VaisseauAngle+math.pi)
end

function TourneVaisseau( sens, dt )
    VaisseauAngle = VaisseauAngle + (sens * math.pi * dt)
end

function TeleporteVaisseau()
    if DelaiTeleportation<0 then
        -- Warp aléatoire
        VaisseauX = math.random(largeurEcran)
        VaisseauY = math.random(hauteurEcran)
        DelaiTeleportation = 4   -- nombre de secondes de cooldown
    end
end

function DeplaceVaisseau( dt )
        -- Déplacement du vaisseau
        VaisseauX = VaisseauX + (VaisseauDX*dt)
        VaisseauY = VaisseauY + (VaisseauDY*dt)
        -- Freinage
        VaisseauDX = VaisseauDX * Decceleration
        VaisseauDY = VaisseauDY * Decceleration
        -- Warp cooldown
        DelaiTeleportation = DelaiTeleportation - dt
        -- Ecran traversable
        if VaisseauX<0 then VaisseauX=largeurEcran end
        if VaisseauX>largeurEcran then VaisseauX=0 end
        if VaisseauY<0 then VaisseauY=hauteurEcran end
        if VaisseauY>hauteurEcran then VaisseauY=0 end
end
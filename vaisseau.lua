VaisseauX = largeurEcran/2
VaisseauY = hauteurEcran/2
VaisseauAngle = 0
VaisseauImage = love.graphics.newImage("vaisseau.png")
VaisseauOffsetX = VaisseauImage:getWidth() / 2
VaisseauOffsetY = VaisseauImage:getHeight() / 2
VaisseauDX = 0
VaisseauDY = 0
DelaiTeleportation = 0

Acceleration = 5
VMax = 400

-- Decceleration de 97% de la vitesse toutes les 0.01 secondes
Decceleration = 0.97
SeuilDec = 0.01
DelaiDec = 0

function DessineVaisseau()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(VaisseauImage,VaisseauX,VaisseauY,VaisseauAngle,1,1,VaisseauOffsetX,VaisseauOffsetY)
end

function AccelereVaisseau()
    if VaisseauDX<VMax then VaisseauDX = VaisseauDX + (Acceleration * math.sin(VaisseauAngle)) end
    if VaisseauDY<VMax then VaisseauDY = VaisseauDY + (Acceleration * math.cos(VaisseauAngle+math.pi)) end
end

function FreineVaisseau(dt)
    DelaiDec = DelaiDec + dt
    if DelaiDec>SeuilDec then
        VaisseauDX = VaisseauDX * Decceleration
        VaisseauDY = VaisseauDY * Decceleration
        DelaiDec = 0
    end
end

function TourneVaisseau( sens, dt )
    VaisseauAngle = VaisseauAngle + (sens * math.pi * dt)
end

function TeleporteVaisseau()
    if DelaiTeleportation<0 then
        -- Warp aléatoire
        VaisseauX = math.random(largeurEcran)
        VaisseauY = math.random(hauteurEcran)
        VaisseauDX = 0
        VaisseauDY = 0
        DelaiTeleportation = 4   -- nombre de secondes de cooldown
    end
end

function DeplaceVaisseau( dt )
        -- Déplacement du vaisseau
        VaisseauX = VaisseauX + (VaisseauDX*dt)
        VaisseauY = VaisseauY + (VaisseauDY*dt)
        -- Freinage
        FreineVaisseau(dt)
        -- Warp cooldown
        DelaiTeleportation = DelaiTeleportation - dt
        -- Ecran traversable
        if VaisseauX<0 then VaisseauX=largeurEcran end
        if VaisseauX>largeurEcran then VaisseauX=0 end
        if VaisseauY<0 then VaisseauY=hauteurEcran end
        if VaisseauY>hauteurEcran then VaisseauY=0 end
end
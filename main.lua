function love.load()
    largeurEcran = 600
    hauteurEcran = 800

    love.window.setMode(largeurEcran, hauteurEcran)
    love.window.setTitle("I ❤ Minestorm")

    require("vaisseau")
    require("tirs")
    require("mines")

    CreeMines()
end

function love.draw()
    DessineVaisseau()
    DessineTirs()
    DessineMines()
    --AfficheInfo()
end

function love.update( dt )
    -- Traitement des commandes
    if love.keyboard.isDown("up") then AccelereVaisseau() end
    if love.keyboard.isDown("left") then TourneVaisseau(-1, dt) end
    if love.keyboard.isDown("right") then TourneVaisseau(1, dt) end
    if love.keyboard.isDown("lalt") then TeleporteVaisseau() end
    if love.keyboard.isDown("space") then AjouteTir(VaisseauX,VaisseauY,VaisseauDX,VaisseauDY) end
    
    -- Déplacement du vaisseau
    DeplaceVaisseau( dt )
    DeplaceTirs( dt )
    DeplaceMines( dt )
end

function AfficheInfo()
    love.graphics.print("dx=" .. VaisseauDX ..
                        "\ndy=" .. VaisseauDY ..
                        "\nwcd=" .. DelaiTeleportation,10, 10)
end


function love.load()
    largeurEcran = 600
    hauteurEcran = 800

    score = 0
    lives = 3 
    highscore = 0

    etat = "debut" -- "jeu"

    love.window.setMode(largeurEcran, hauteurEcran)
    love.window.setTitle("I ❤ Minestorm")

    font = love.graphics.newFont("OpenSansEmoji.ttf",14)
    love.graphics.setFont(font)

    require("vaisseau")
    require("tirs")
    require("mines")

    CreeMines()
end

function love.draw()
    if etat=="debut" then
        DessineDebut()
    end
    if etat=="jeu" then
        DessineVaisseau()
        DessineTirs()
        DessineMines()
        AfficheInfo()
    end
end

function love.update( dt )
    if etat=="debut" then UpdateDebut(dt) end
    if etat=="jeu" then UpdateJeu(dt) end
end

function UpdateJeu(dt)
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

    -- Collisions
    Collisions()
end

function UpdateDebut( dt )
    if love.keyboard.isDown("s") then 
        score = 0
        lives = 3
        etat="jeu"
    end
end

function AfficheInfo()
    tp = "- prête -" 
    if DelaiTeleportation>0 then 
        tp = "- en charge : " .. string.format("%03d",100-DelaiTeleportation*25) .. "% -"
    end

    local vies=""
    for i=1, lives do
        vies = vies .. "🚀"
    end

    love.graphics.print("score : " .. score ..
                        "\nvies : " .. vies ..
                        "\ntéléportation : " .. tp,10, 10)
end

function DessineDebut()
    love.graphics.print("high score : "..highscore ..
                        "\npressez 's' pour commencer",10,10)
end

function Distance( x1, y1, x2, y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2)
end

function Collisions()
    for j=1, #mines do
        -- mines et tirs
        for i=1, #tirs do
            if mines[j].active and Distance(mines[j].x,mines[j].y,tirs[i].x,tirs[i].y)<mines[j].r then
                -- la mine est détruite, on la desactive et on la replace au hasard
                mines[j].active = false
                mines[j].x = math.random(largeurEcran)
                mines[j].y = math.random(hauteurEcran)
    
                score = score + mines[j].score

                -- active les mines "filles"
                if j<12 then
                    mines[2*j+3].active = true
                    mines[2*j+4].active = true
                end
            end
        end
        -- mines et vaisseau
        if mines[j].active and Distance(mines[j].x,mines[j].y,VaisseauX,VaisseauY)<mines[j].r then
            lives = lives - 1
            if lives==0 then
                if score>highscore then highscore = score end
                etat = "debut"
            else
                VaisseauX = largeurEcran/2
                VaisseauY = hauteurEcran/2
                VaisseauAngle = 0
            end
        end
    end
end
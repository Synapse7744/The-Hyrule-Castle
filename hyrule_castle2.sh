#!/bin/bash
game=1
floor=8

link=(60 15)
link_pv=60
link_str=15

boko=(5 30)
boko_pv=30
boko_str=5

ganon=(150 20)
ganon_pv=150
ganon_str=20


heal(){
    link_pv=$(($link_pv + $(($link_pv / 2))))
    if [[ $link_pv -ge 60 ]]; then
        link_pv=60
    fi
}

attack() {
    
    var=$(($1 - $2))
    if [[ $var -le 0 ]]; then
        var=0
    fi

    return $var
}

lose_game() {
    if [[ $link_pv -le 0 ]]; then
        echo "=====LOSE GAME====="
        exit 0
    fi
}


echo "\n\n\n"
echo "====== Welcome to the World of Zelda ======"
echo "\n\n\n"



echo "You are now in the Hyrule Castle.\n"
echo "You will face many Bokoblins which have 30 HP and 5 STR.\n"
echo "Until the boss floor, were you will have to defeat Ganon.\n\n"

# while [ $game -eq 1 ]; do
    
    while [[ $floor -lt 10 && $link_pv -gt 0 ]]; do
        boko_pv=30

        echo "==> Floor $floor, Un nouveau Bokoblin arrive !"
        echo ""
    
        while [[ $boko_pv -gt 0 && $link_pv -gt 0 ]]; do 

            read -p "Attack ===> Press 1 || Heal ===> Press 2 : " action
            if [[ $action == 1 ]]; then
                attack $boko_pv $link_str
                boko_pv=$?
                echo 
                echo "💥 Le bokoo a subi $link_str points de dégats 💥"
                echo "===="
                

                if [[ $boko_pv -le 0 ]]; then
                    echo "💀 Le Bokoblin est mort 💀\n"
                    echo "=================== 🏰 Hyrule Castle 🏰 ====================\n"
                    break
                else 
                    echo "boko pv : "$boko_pv"\n"
                fi

            fi

            if [[ $action == 2 ]]; then
                heal
                echo 
                echo "❤️ Link se soigne de $(($link_pv/2)) ❤️"
                echo "===="
                echo "Link pv : $link_pv\n"


            fi
            
            attack $link_pv $boko_str
            link_pv=$?
            echo "💥 Link a subi $boko_str points de dégats 💥"
            echo "===="
            echo "Link pv : "$link_pv"\n"
            echo
        
            if [[ $link_pv -le 0 ]]; then
                echo "===== 🪦 LOSE GAME 🪦 ====="
                echo $link_pv
                game=0
                break 
            fi

            

        done
        
        floor=$(($floor +1))

    done


    while [[ $ganon_pv -gt 0 && $link_pv -gt 0 ]]; do 

            read -p "Attack ===> Press 1 || Heal ===> Press 2 : " action
            
            if [[ $action == 1 ]]; then
                attack $ganon_pv $link_str
                ganon_pv=$?

                echo
                echo "💥 Ganon a subi $link_str points de dégats 💥!!"
                echo "===="

                if [[ $ganon_pv -le 0 ]]; then
                    echo "🗡💀 Ganon est mort."
                    echo
                    echo "👏👏👏 CONGRATULATIONS 👏👏👏"
                    echo
                    break
                else 
                    echo "Ganon pv : "$ganon_pv"\n"
                fi

            fi

            if [[ $action == 2 ]]; then
                heal
                echo
                echo "❤️ Link se soigne de $(($link_pv/2)) ❤️"
                echo "===="
                echo "Link pv : $link_pv"
                echo
            fi

            attack $link_pv $ganon_str
            link_pv=$?

            if [[ $link_pv -le 0 ]]; then
                echo "===== 🪦 LOSE GAME 🪦 ====="
                    game=0
                break 
            fi
            
            echo "💥 Link a subi $ganon_str points de dégats 💥"
            echo "===="
            echo "link pv: $link_pv"
            echo
                        

        done

# done


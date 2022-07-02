# VHDL-ALU
Modélisation d'une unité arithmétique et logique en VHDL

Projet réalisé en duo, avec [Jérémy Grelaud](https://github.com/jeremyGrelaud)

## UAL - Unité aithmétique et logique

L'unité arithmétique et logique est l'organe de l'ordinateur chargé d'effectuer les calculs. Le plus souvent, l'UAL est incluse dans l'unité centrale de traitement ou le microprocesseur.

![image](https://user-images.githubusercontent.com/58084848/177005766-aec36327-d121-44ec-8c13-8b4eb57c7b92.png)

Notre cœur réalise les 16 fonctions suivantes, pilotées par la valeur de SEL_FCT sur 4 bits.

![image](https://user-images.githubusercontent.com/58084848/177005748-21aa0b1e-e963-4d03-a769-5295e01fa8e5.png)


## Liste des entités de notre UAL

#### Coeur : 
L'entité qui permet de faire les calculs en prenant deux entrées 4 bits (A et B) et deux retenues d'entrées 1 bit (SR_IN_L et SR_IN_R ).
Il y a le SEL_FCT sur 4 bits (signal de sélection) qui permet de déterminer laquelle des 16 opérations réaliser. En ce qui concerne les sorties, on a le S sur 8 bits qui stocke le résultat de l'opération. Et enfin il y a deux retenues de sorties 1 bit SR_OUT_L et SR_OUT_R.


#### UALBuffers : 
Cette entité permet de modéliser tous les buffers/mémoires de notre UAL nous permettant de stocker les valeurs et les résultats de nos calculs intermédiaires avant
d'afficher le résultat en sortie de notre UAL. Il y a donc autant d'entrées que de sorties chacunes liées par 2 et de même taille. Il y a aussi un signal d'activation associé à chaque buffer (CE= cheap enabler) permettant de savoir quand on doit garder la valeur déjà stockée en mémoire ou la remplacer par la nouvelle entrée. Il y a aussi une horloge et un reset permettant de vider toutes les valeurs présentent dans les mémoires.


#### UALCMDBuffers : 
Comme l'entité précédente, on modélise des mémoires mais ici il n'y a pas de Cheap enabler. Car ces mémoires sont toujours actives.
En effet, elles permettent de stocker les valeurs de SEL_FCT et SEL_OUT pilotant les instructions à réaliser et quoi mettre en sortie de notre UAL.
Il est donc important de les conserver actifs, il y a aussi une horloge comme les autres buffers/mémoires et un reset pour supprimer/vider toutes les valeurs contenues dans les mémoires.


#### MemInstr : 
cette entité fonctionne aussi sur l'horloge de l'UAL et possède un reset mais au final on ne s'en sert pas car on a rempli en "brut" les valeurs des 128 espaces mémoires de
notre mémoire d'instruction. Il y a donc la sortie sur 10 bits qui sera une des cases mémoires choisies. Il y a aussi un signal activation (CE_instr) comme pour les buffers et enfin Instr_addr, un entier sur 7 bits très important, en effet il va de 0 à 127 et permet d'accéder au 128 cases de notre mémoire d'instruction qui est en fait un tableau. Instr_addr est donc l'indice de cette case du tableau.


#### On a ensuite 2 entités permettant de faire les interconnexions 

#### UALSELOUT : 
Cette entité a pour entrée, la sortie S du coeur, et les sorties des mémoires 1 et 2. En fonction de l'entrée SEL_OUT sur 2 bits donc 4 valeurs possibles la sortie res_out sera soit 0 soit les valeurs de S, mémoire 1 ou mémoire 2. Cela fait l'interconnexion entre la sortie de l'UAL et les résultats des opérations stockés dans les mémoires.

![image](https://user-images.githubusercontent.com/58084848/177005813-b5c4f106-d65f-43c4-b879-ad522bc03c68.png)


#### UALSELROUTE : 
C'est le même principe que le SEL_OUT sauf qu'il y a 16 possibilités car SEL_ROUTE est sur 4 bits et que le but de cette entité est de prendre les valeurs de nos 2 entrées de l'UAL (A et B), la sortie du coeur (S) et les sorties de nos buffers(buff_A_out , buff_B_out ,mem_1_out ,mem_2_out ). Afin de les stocker dans une autre mémoire/buffer en fonction de la valeur de SEL_ROUTE. Il y a aussi 4 Cheap enabler pour indiquer quand on a stocké une valeur dans une mémoire que cette dernière est désormais active.

![image](https://user-images.githubusercontent.com/58084848/177005803-b0d80774-51d7-4e8e-91dc-ee570197383a.png)



#### MCU_PRJ_2021_TopLevel : 
c'est la TopLevel entity, il y a deux versions dans notre fichier contenant les codes vhdl, la première représente le composant permettant de faire le lien entre notre coeur de l'UAL et la carte arty et la deuxième version représente notre UAL, le composant global permettant de réaliser les 3 fonctions et obtenir le résultat sur RES_OUT en fonction du boutons surlequel on a appuyé et de l'entrée défini par les switchs. Dans les deux versions c'est la même définition, juste pas les même raccordement dans l'architecure par la suite mais en tout cas il y a l'horloge (la clock), le switch permettant de définir la valeur de A et de B nos entrées sur 4 bits. Pareil avec le bouton (btn) et enfin toutes les leds avec notamment les différentes couleurs (RGD) nous permettant d'afficher les résultat de nos opérations sur la carte.


## Lancement

Ce code peut s'exécuter sur des environnements VHDL tel que EDA Playground, ou être intégré sur une carte FPGA, comme la carte de développement ARTY.

![image](https://user-images.githubusercontent.com/58084848/177005833-0a84b4cc-5572-457a-b167-bf561bd430f9.png)




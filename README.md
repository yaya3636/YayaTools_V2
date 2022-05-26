# YayaTools_V2

YayaTools_V2 et une bibliothèque de scripts qui vous aidera dans le dévelopement de vos scripts

# Prérequis
  1. Installez NodeJs
  2. Installez Python
 
# Instalation
  1. Créer un dossier nommée YayaTools a la racine d'Ankabot
  2. Télécharger les fichiers présent sur github et placer les dans le dossier YayaTools

# Utilisation
  1. Déclarer la variable Tools en haut de votre script comme ci dessous : <br>
     ```
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
     ```
   
  2. Déclarer les modules que vous allez utilisé juste en dessous de la ligne ci dessus exemple : <br>
     ```
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
     Movement = Tools.movement
     Craft = Tools.craft
     ```
     
  3. Instancier les module avec leur paramètre a la fin de votre script exemple (Le module Tools doit toujours être instancier en dernier) : <br>
     
     ```
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
     Movement = Tools.movement
     Craft = Tools.craft
     
     function move()
         blablabla
     end
     
     function bank()
         blablabla
     end
     
     Movement = Movement()
     Craft = Craft()
     Tools = Tools()
     ```
    
# Documentation

> En cours de développement regarder les exemples présent dans le dossier exemples en attendant
  
## List
  - Instanciation
  ```
  local maList = Tools.list()
  ```
  Vous pouvez passez une table ou une autre List en paramètre pour obtenir une copie de celle ci exemple :
  ```
  local table = {}
  local list1 = Tools.list()
  local copyList1 = Tools.list(list1)
  local copyTable = Tools.list(table)
  ```
  - Méthodes



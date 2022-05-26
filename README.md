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
     <sub>
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
     </sub>
     
  2. Déclarer les modules que vous allez utilisé juste en dessous de la ligne ci dessus exemple : <br>
     <sub>
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua") <br>
     Movement = Tools.movement <br>
     Craft = Tools.craft <br>
     </sub>
     
  3. Instancier les module avec leur paramètre a la fin de votre script exemple (Le module Tools doit toujours être instancier en dernier) : <br>
     <sup>
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua") <br>
     Movement = Tools.movement <br>
     Craft = Tools.craft <br>
     
     function move() <br>
         blablabla <br>
     end<br>
     
     function bank() <br>
         blablabla <br>
     end<br>
     
     Movement = Movement() <br>
     Craft = Craft() <br>
     Tools = Tools() <br>
     </sup>
     
# Documentation

  > En cours de développement regarder les exemples présent dans le dossier exemples en attendant
  
  ## List
  
    

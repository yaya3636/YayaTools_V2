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
     ```lua
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
     ```
   
  2. Déclarer les modules que vous allez utilisé juste en dessous de la ligne ci dessus exemple : <br>
     ```lua
     Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
     Movement = Tools.movement
     Craft = Tools.craft
     ```
     
  3. Instancier les module avec leur paramètre a la fin de votre script exemple (Le module Tools doit toujours être instancier en dernier) : <br>
     
     ```lua
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

<details><summary>List</summary>
<p>

- Instanciation
```lua
local maList = Tools.list()
```
Vous pouvez passez une table ou une autre List en paramètre pour obtenir une copie de celle ci exemple :
```lua
local table = {}
local list1 = Tools.list()
local copyList1 = Tools.list(list1)
local copyTable = Tools.list(table)
```
- Méthodes
  - List:CreateWith(params1)
    - Créer une copie d'une list ou d'une table
    - Params :
      1 List/Table
  - Exemple :  
  ```lua
  local uneTable = {}
  local uneList = Tools.list()
  local copieListDeUneTable = Tools.list:CreateWith(uneTable)
  local copieListDeUneList = Tools.list:CreateWith(uneList)
  ```
  
  - List:Add(params1)
    - Ajoute un élément dans la list
    - Params :
      1 N'importe
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  ```
  
</p>
</details>

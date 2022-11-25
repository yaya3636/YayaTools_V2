# YayaTools_V2

YayaTools_V2 et une bibliothèque de scripts qui vous aidera dans le dévelopement de vos scripts

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
  ---
  ### List:CreateWith(paramsA)
    > Créer une copie d'une list ou d'une table
    - Params :
      1. List/Table
  - Exemple :  
  ```lua
  local uneTable = {}
  local uneList = Tools.list()
  local copieListDeUneTable = Tools.list:CreateWith(uneTable)
  local copieListDeUneList = Tools.list:CreateWith(uneList)
  ```
  ---
    ### List:MakeCopy()
    > Créer une copie de la list 
    - Params :
  - Exemple :  
  ```lua
  local maList = Tools.list()
  local copieDeMaList = maList:MakeCopy()
  ```
  ---
  ### List:Add(paramsA)
    > Ajoute un élément dans la list
    - Params :
      1. N'importe
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  ```
  ---
  ### List:Set(paramsA, paramsB)
    > Modifie un élément dans la list
    - Params :
      1. L'index de l'élément a modifié
      2. La valeur a lui donné
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Test")
  maList:Set(2, "TestModifié")
  Tools:Print(maList:Get(2)) -- ---> TestModifié
  ```
  ---
    ### List:Insert(paramsA, paramsB)
    > Insert un élément dans la list a un index donné
    - Params :
      1. L'index ou l'on veut inserée l'élément
      2. La valeur de l'élément
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Test3")
  maList:Insert(2, "Test2")
  Tools:Print(maList:Get(1)) -- ---> Ankabot
  Tools:Print(maList:Get(2)) -- ---> Test2
  Tools:Print(maList:Get(3)) -- ---> Test3
  ```
  ---
    ### List:Get(paramsA)
    > Retourne l'élément a l'index donné
    - Params :
      1. L'index de l'élément a retourné
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  local maVar = maList:Get(1)
  Tools:Print(maVar) -- ---> Ankabot
  ```
  ---
    ### List:Clear()
    > Vide la list
    - Params :
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  maList:Add("Kamas")
  Tools:Dump(maList) -- ---> Ankabot --> Dofus -> Kamas
  maList:Clear()
  Tools:Dump(maList) -- ---> Nil
  ```
  ---
    ### List:Concatenate(paramsA)
    > Copie tout les éléments d'une autre list dans la list
    - Params :
      1. La list a copiée
  - Exemple :
  ```lua
  local maList = Tools.list()
  local maListACopie = Tools.list()
  maList:Add("Ankabot")
  maListACopie:Add("Dofus")
  maListACopie:Add("Kamas")
  Tools:Dump(maList) -- ---> Ankabot
  maList:Concatenate(maListACopie)
  Tools:Dump(maList) -- ---> Ankabot --> Dofus -> Kamas
  ```
  ---
    ### List:RemoveAt(paramsA)
    > Supprime un élément a l'index donné
    - Params :
      1. L'index de l'élément a supprimer
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  maList:Add("Kamas")
  Tools:Dump(maList) -- ---> Ankabot --> Dofus -> Kamas
  maList:RemoveAt(2)
  Tools:Dump(maList) -- ---> Ankabot --> Kamas
  ```
  ---
    ### List:Remove(paramsA)
    > Supprime un élément donné
    - Params :
      1. La valeur de l'élément a supprimer
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  maList:Add("Kamas")
  Tools:Dump(maList) -- ---> Ankabot --> Dofus -> Kamas
  maList:Remove("Dofus")
  Tools:Dump(maList) -- ---> Ankabot --> Kamas
  ```
  ---
    ### List:IndexOf(paramsA)
    > Retourne l'index d'un élément dans la list ou -1 si non trouvé
    - Params :
      1. La valeur de l'élément a rechercher, ou une fonction anonyme avec un paramètre qui sera la valeur des élément de la list a chaque itération
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  maList:Add("Kamas")
  Tools:Print(maList:IndexOf("Dofus")) -- ---> 2
  
  local maList2 = Tools.list()
  maList2:Add({test = 1})
  maList2:Add({test = "Ankabot"})
  maList2:Add({test = 3})
  local i = maList:IndexOf(function(v)
    if v.test == "Ankabot" then return true end
  end)
  Tools:Print(i) -- ---> 2 
  ```
  ---
    ### List:Contains(paramsA)
    > Retourne si la list contient un élément donné
    - Params :
      1. La valeur de l'élément a rechercher, ou une fonction anonyme avec un paramètre qui sera la valeur des élément de la list a chaque itération
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  maList:Add("Kamas")
  Tools:Print(maList:Contains("Dofus")) -- ---> True
  Tools:Print(maList:Contains("Blabla")) -- ---> False
  
  local maList2 = Tools.list()
  maList2:Add({test = 1})
  maList2:Add({test = "Ankabot"})
  maList2:Add({test = 3})
  local bool = maList:Contains(function(v)
    if v.test == "Ankabot" then return true end
  end)
  local bool2 = maList:Contains(function(v)
    if v.test == "Blabla" then return true end
  end)
  Tools:Print(bool) -- ---> True
  Tools:Print(bool2) -- ---> False
  ```
  ---
    ### List:Size()
    > Retourne la taille de la list
    - Params :
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  Tools:Print(maList:Size()) -- ---> 2
  ```
  ---
    ### List:IsEmpty()
    > Retourne si la list et vide
    - Params :
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  Tools:Print(maList:IsEmpty()) -- ---> False
  maList:Clear()
  Tools:Print(maList:IsEmpty()) -- ---> True
  ```
  ---
    ### List:Enumerate()
    > Enumére la list
    - Params :
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  for i, v in ipairs(maList:Enumerate()) do
    Tools:Print(i .. " " .. v) -- ---> 1 Ankabot --> 2 Dofus
  end
  ```
  ---
    ### List:Equal(paramsA)
    > Retourne si la list et égale a une autre list
    - Params :
      1. La list a comparée
  - Exemple :
  ```lua
  local maList = Tools.list()
  local maList2 = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  local copieMaList = maList:MakeCopy()
  Tools:Print(maList:Equal(maList2)) -- ---> False
  Tools:Print(maList:Equal(copieMaList)) -- ---> True
  ```
  ---
    ### List:Shuffle()
    > Mélange les éléments dans la list
    - Params :
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  maList:Add("Kamas")
  Tools:Dump(maList) -- ---> Ankabot --> Dofus -> Kamas
  maList:Shuffle()
  Tools:Dump(maList) -- ---> ?Kamas --> ?Dofus -> ?Ankabot
  ```
  ---
    ### List:Foreach(paramsA)
    > Parcours les élément de la list en appelant la fonction de callback
    - Params :
      1. Une fonction anonyme qui prend deux paramètre, le premier et la valeur des élément de la list a chaque itération l'autre et l'index
  - Exemple :
  ```lua
  local maList = Tools.list()
  maList:Add("Ankabot")
  maList:Add("Dofus")
  maList:Add("Kamas")
  maList:Foreach(function(v, i)
    Tools:Print(v .. " " .. i) -- ---> Ankabot 1 --> Dofus 2 -> Kamas 3
  end))
  ```
  ---
</p>
</details>

<details><summary>Dictionnary</summary>
<p>
  
</p>
</details>

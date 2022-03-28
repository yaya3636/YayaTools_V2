
const express = require("express")
const app = express()
const path = require("path")
const fs = require("fs")
const axios = require("axios")
const morgan = require("morgan")
const bodyParser = require("body-parser")
const json5 = require("json5")

const urlDofusDB = "https://api.dofusdb.fr/"
const PORT = ReadConfig()

// D2O Data

const monstersSorted = ReadMonstersData()
const recipesSorted = ReadRecipesData()
// Middlewar

app.use(morgan("dev"))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended : false }))

// StartApi

app.get("/startedAPI", (req, res) => {
    res.status(200).send('sucess')
})

// Harvestable (DofusDB)

app.post("/harvestable/getHarvestablePosition", async (req, res) => {

    var data = await GetHarvestableData(req.body.gatherId)
    if (data) {
        res.status(200).json(Success(data))
    } else {
        res.status(404).json(Error("GatherId non trouvée, [GatherId : " + req.body.gatherId + "]"))
    }

})

// Monsters

app.post("/monsters/getMonsters", async (req, res) => {
    var monster = monstersSorted.get(parseInt(req.body.monsterId))
    if (monster) {
        res.status(200).json(Success(monster))
    } else {
        res.status(404).json(Error("MonsterId non trouvée, [MonsterId : " + req.body.monsterId + "]"))
    }

})

app.post("/monsters/getMonsterIdByDropId", async (req, res) => {
    var ret = []
    monstersSorted.forEach(element => {
        element.drops.forEach(e => {
            if (e.dropId == req.body.dropId) {
                ret.push(element.id)
            }
        })
    });
    res.status(200).json(Success(ret))
})

app.post("/monsters/getAllMonstersIds", async (req, res) => {
    var allId = []

    monstersSorted.forEach(element => {
        allId.push(element.id)
    });

    res.status(200).json(Success(allId))
})

// Craft

app.post("/recipes/getRecipe", async (req, res) => {
    const recipes = recipesSorted.get(parseInt(req.body.craftId))

    if (recipes) {
        res.status(200).json(Success(recipes))
    } else {
        res.status(404).json(Error("craftId non trouvée, [craftId : " + req.body.craftId + "]"))
    }
})

app.listen(PORT, () => {
    console.log("Le serveur a démarré sur le port : " + PORT)
    console.log("Ne pas fermer l'invite de commande !")
})

// Function Harvestable

async function GetHarvestableData(gatherId) {
    const constructorMap = (map) => {
        const constructorHarvestable = (harvestable) => {
            var ret = []
            harvestable.forEach(e => {
                var ctrQty = {}
                ctrQty.gatherId = e.item
                ctrQty.quantity = e.quantity
                ret.push(ctrQty)
            })
            return ret
        }

        var ret = {}
        ret.mapId = map.id
        ret.posX = map.pos.posX
        ret.posY = map.pos.posY
        ret.subAreaId = map.pos.subAreaId
        ret.worldMap = map.pos.worldMap
        ret.harvestableElement = constructorHarvestable(map.quantities)

        return ret
    }
    var total = 10
    var data = new Map()
    var ret = []

    for (let i = 0; i < Math.ceil(total / 10); i++) {
        var skip = "&$skip=0&lang=fr"
        if (i > 0) {
            skip = "&$skip=" + i * 10 + "&lang=fr"
        }

        await axios.get(urlDofusDB + "recoltable?resources[$in][]=" + gatherId + skip)
        .then(function (response) {
            total = response.data.total

            response.data.data.forEach(e => {
                if (e.pos != null) {
                    if (!data.has(e.pos.subAreaId)) {
                        data.set(e.pos.subAreaId, [constructorMap(e)])
                    } else {
                        var tmp = data.get(e.pos.subAreaId)
                        tmp.push(constructorMap(e))
                        data.set(e.pos.subAreaId, tmp)
                    }    
                }
            })

        })
        .catch((response) => {
            console.log(response)
        })
    }

    data.forEach(e => {
        ret.push(e)
    })

    return ret
}

// Function API

function ReadConfig() {
    try {
        const data = fs.readFileSync(__dirname + '/ConfigAPI.json', 'utf8')
        var jsonOBJ = JSON.parse(data)
        return jsonOBJ.port
    } catch (err) {
        console.error(err)
    }
}

function ReadMonstersData() {
    const data = fs.readFileSync(path.dirname(__dirname) + "/Data/D2O/Monsters.json")
    const monstersData = json5.parse(data)
    var monstersSorted = new Map()
    
    for (const [_, value] of Object.entries(monstersData)) {
        for (const [k, v] of Object.entries(value)) {
            if (k == "id"){
                monstersSorted.set(v, value)
            }
        }
    }
    return monstersSorted
}

function ReadRecipesData() {
    const recipesData = json5.parse(fs.readFileSync(path.dirname(__dirname) + "/Data/D2O/Recipes.json"))
    var recipesSorted = new Map()
    
    for (const [_, value] of Object.entries(recipesData)) {
        for (const [k, v] of Object.entries(value)) {
            if (k == "resultId"){
                recipesSorted.set(v, value)
            }
        }
    }
    return recipesSorted
}


function Success(result) {
    return {
        status: "success",
        result: result
    }
}

function Error(message) {
    return {
        status: "error",
        message: message
    }
}

// Autres

function sortBy(arr, prop) {
    return arr.sort((a, b) => a[prop] - b[prop]);
}
  
function Sort(arr, fn) {
    var numArray = arr
    for (var i = 0; i < numArray.length - 1; i++) {
        var min = i;
        for (var j = i + 1; j < numArray.length; j++) {
            if (fn(numArray[j], numArray[min])) {
                min = j
            }
        }
        if (min != i) {
            var target = numArray[i]
            numArray[i] = numArray[min]
            numArray[min] = target
        }
    }
    return numArray
}

function IsStringEquals(str1, str2) {
    return new String(str1).valueOf().toLowerCase().normalize("NFC") == String(str2).valueOf().toLowerCase().normalize("NFC")
}
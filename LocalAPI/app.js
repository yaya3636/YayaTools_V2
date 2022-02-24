
const express = require("express")
const app = express()
const fs = require("fs")
const axios = require("axios")
const morgan = require("morgan")
const bodyParser = require("body-parser")

const urlDofusDB = "https://api.dofusdb.fr/"
var PORT = 0

try {
    const data = fs.readFileSync(__dirname + '/ConfigAPI.json', 'utf8')
    var jsonOBJ = JSON.parse(data)
    PORT = jsonOBJ.port
} catch (err) {
    console.error(err)
}
// API

app.use(morgan("dev"))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended : false }))


app.get("/startedAPI", (req, res) => {
    res.status(200).send('sucess')
})

// DofusDB

// Ressources

app.post("/harvestable/getHarvestablePosition", async (req, res) => {

    var data = await GetHarvestableData(req.body.gatherId)
    if (data) {
        console.log(data)
        res.status(200).json(Success(data))
    } else {
        res.status(404).json(Error("GatherId non trouvée, [GatherId : " + req.body.gatherId + "]"))
    }

})

// Chasse aux trésor 

app.post("/hunt/nextFlagPosition", async (req, res) => {
    //console.log(req.body.posX + "," + req.body.posY + " : " + req.body.dir)
    var data = await GetHuntFlagData(req.body.dir, req.body.posX, req.body.posY)
    //console.log(data)

    if (IsStringEquals(req.body.dir, "Right")) {
        data = sortBy(data, "posX")

    } else if (IsStringEquals(req.body.dir, "Left")) {
        data = sortBy(data, "posX")
        data.reverse()

    } else if (IsStringEquals(req.body.dir, "Top")) {
        data = sortBy(data, "posY")
        data.reverse()

    } else if (IsStringEquals(req.body.dir, "Bottom")) {
        data = sortBy(data, "posY")
    }     


    //console.log(data)

    var ret = SortPos(data, req.body.flagName)

    //console.log(ret)
    if (ret) {
        res.status(200).json(Success(ret))
    } else {
        res.status(404).json(Error("Indice non trouvée, [Pos : " + req.body.posX + "," + req.body.posY + "] [Dir : " + req.body.dir + "] [Indice : " + req.body.flagName + "]"))
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
        var skip = ""
        if (i > 0) {
            skip = "&$skip=" + i * 10
        }
        //console.log(urlDofusDB + GetHuntURL(dir, posX, posY) + skip)

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

// Function Hunt

async function GetHuntFlagData(dir, posX, posY) {
    var total = 10
    var data = new Map()
    var ret = []


    for (let i = 0; i < Math.ceil(total / 10); i++) {
        var skip = ""
        if (i > 0) {
            skip = "&$skip=" + i * 10
        }
        //console.log(urlDofusDB + GetHuntURL(dir, posX, posY) + skip)

        await axios.get(urlDofusDB + GetHuntURL(dir, posX, posY) + skip)
        .then(function (response) {
            total = response.data.total
            response.data.data.forEach(element => {
                const key = element.x + "," + element.y
                if (!data.has(key)) {
                    data.set(key, { 
                        posX: parseInt(element.x),
                        posY: parseInt(element.y),
                        clue: [element.clue.name.fr]
                    })
                } else {
                    var map = data.get(key)
                    if (!map.clue.includes(element.clue.name.fr)) {
                        map.clue.push(element.clue.name.fr)
                        data.set(key, map)
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

function SortPos(d, flagName) {
    for (var i = 0; i < d.length; i++) {
        var equal = false
        var flg = ""
        d[i].clue.forEach(e => {
            //console.log(flagName + " : " + e)
            if (IsStringEquals(flagName, e)) {
                //console.log("equal")
                equal = true
                flg = e
            }
        })    
        if (equal) {
            return {
                posX: d[i].posX,
                posY: d[i].posY,
                flagName: flg
            }
        }
    }
    return null
}

function GetHuntURL(dir, posX, posY) {
    if ( IsStringEquals(dir, "Right") ) {
        return "map-clue?$sort[name.fr]=1&y=" + posY + "&x[$gt]=" + posX + "&x[$lte]=" + (parseInt(posX) + 20) + "&lang=fr"
    } else if ( IsStringEquals(dir, "Left")) {
        return "map-clue?$sort[name.fr]=1&y=" + posY + "&x[$lt]=" + posX + "&x[$gte]=" + (parseInt(posX) - 20) + "&lang=fr"
    } else if ( IsStringEquals(dir, "Top")) {
        return "map-clue?$sort[name.fr]=1&x=" + posX + "&y[$lt]=" + posY + "&y[$gte]=" + (parseInt(posY) - 20) + "&lang=fr"
    } else if ( IsStringEquals(dir, "Bottom")) {
        return "map-clue?$sort[name.fr]=1&x=" + posX + "&y[$gt]=" + posY + "&y[$lte]=" + (parseInt(posY) + 20) + "&lang=fr"
    }
}

function IsStringEquals(str1, str2) {
    return new String(str1).valueOf().toLowerCase().normalize("NFC") == String(str2).valueOf().toLowerCase().normalize("NFC")
}

// Function API

function sortBy(arr, prop) {
    return arr.sort((a, b) => a[prop] - b[prop]);
}
  

function Sort(array, fn) {
    var numArray = array
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
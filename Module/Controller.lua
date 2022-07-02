Controller = {}

Controller.teamLoaded = nil

Controller.accountController = nil

function Controller:LoadTeam(teamName, configTeam)
    if not self.teamLoaded:ContainsKey(teamName) then
        self.teamLoaded:Add(teamName, self.tools.object({
            isConnected = false,
            teamName = teamName,
            team = self.tools.list()
        }))
        if configTeam.c then
            configTeam:Foreach(function(v)
                if ankabotController:accountIsLoaded(v.username) then
                    ankabotController:unloadAccountByUsername(v.username)
                end

                local accountController = ankabotController:loadAccount(v.username, false)

                if accountController == nil then
                    self.tools:Print("Impossible de chargé le compte (" .. v.username .. ")", "error")
                else
                    Tools:Print("Compte chargé avec succès (" .. v.username .. ")", "Controller")
                    self.accountController:Add(v.username, accountController)
                    v.controller = accountController
                    self.tools:Print("Séléction du personnage (" .. v.pseudoInGame .. ")", "Controller")
                    v.controller.forceChoose(v.pseudoInGame)
                    self.tools:Print("Séléction du serveur [" .. v.server .. "] pour le personnage (" .. v.pseudoInGame .. ")", "Controller")
                    v.controller.forceServer(v.server)

                    local tmp = self.teamLoaded:Get(teamName)
                    tmp.team:Add(v)
                    self.teamLoaded:Set(teamName, tmp)
                end
            end)
        else
            self.tools:Print("La config n'est pas une list !", "Controller")
        end
    else
        self.tools:Print("La team (" .. teamName .. ") et déjà chargé", "Controller")
    end
end

function Controller:LoadScript(teamName, path)
    if self.teamLoaded:ContainsKey(teamName) then
        local teamInfo = self.teamLoaded:Get(teamName)
        if teamInfo.isConnected then
            teamInfo.team:Foreach(function(v)
                v.controller.loadScript(path)
            end)
            self.tools:Print("Chargement du script terminé pour la team (" .. teamName .. ")", "Controller")
        else
            self.tools:Print("La team (" .. teamName .. ") n'est pas connecté", "Controller")
        end
    else
        self.tools:Print("La team (" .. teamName .. ") n'est pas chargé", "Controller")
    end

end

function Controller:ConnectTeam(teamName)
    if self.teamLoaded:ContainsKey(teamName) then
        local teamInfo = self.teamLoaded:Get(teamName)
        teamInfo.team:Foreach(function(v)
            v.controller.connect()
        end)

        teamInfo.team:Foreach(function(v)
            while not v.controller.isAccountFullyConnected() do
                global:delay(500)
            end
        end)

        teamInfo.isConnected = true
        self.teamLoaded:Set(teamInfo)
        self.tools:Print("La team (" .. teamName .. ") et connecté", "Controller")
    else
        self.tools:Print("La team (" .. teamName .. ") n'est pas chargé", "Controller")
    end

end

function Controller:StartScript(teamName)
    local team = self:GetTeam(teamName)
    if team then
        team.team:Foreach(function(v)
            v.controller.startScript()
        end)
        self.tools:Print("Script lancé pour la team (" .. teamName .. ")", "Controller") 
    else
        self.tools:Print("La team (" .. teamName .. ") n'est pas chargé", "Controller") 
    end
end

function Controller:GetTeam(teamName)
    return self.teamLoaded:Get(teamName)
end

return Controller
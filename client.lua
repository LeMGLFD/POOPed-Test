local PedObject = {}

function PedObject:new(pModel, pCoords)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.model = pModel
    instance.coords = pCoords
    instance.ped = nil

    lib.requestModel(pModel, 10000)
    
    instance.ped = CreatePed(1, pModel, pCoords.x, pCoords.y, pCoords.z - 1, 100, true, true)
    SetBlockingOfNonTemporaryEvents(instance.ped, true)
    SetPedDiesWhenInjured(instance.ped, false)
    SetPedCanPlayAmbientAnims(instance.ped, true)
    SetPedCanRagdollFromPlayerImpact(instance.ped, false)
    SetEntityInvincible(instance.ped, true)
    FreezeEntityPosition(instance.ped, true)    

    return instance
end

function PedObject:WolkToCoords(destination)
    FreezeEntityPosition(self.ped, false)     
    if self.ped then
        TaskGoStraightToCoord(self.ped, destination.x, destination.y, destination.z, 1.0, -1, 0.0, 0.0)
    end
end

function PedObject:PlayAnim(animDict, animName)
    lib.requestAnimDict(animDict, 10000)
    TaskPlayAnim(self.ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
end

function PedObject:PedSayHello(speechName, speedParam)
    PlayPedAmbientSpeechNative(self.ped, speechName, speedParam)
end

local monPed = PedObject:new(joaat("a_m_m_fatlatin_01") , vector3(220.3991, -856.7448, 30.2235))
local monPed2 = PedObject:new(joaat("a_m_m_fatlatin_01") , vector3(226.8354, -862.5383, 30.0550))

if monPed.ped then
    monPed:PedSayHello("GENERIC_HI", "SPEECH_PARAMS_FORCE")
    monPed:PlayAnim("mp_common", "givetake1_a")
end

monPed2:WolkToCoords(vector3(225.9667, -853.5879, 29.9754))

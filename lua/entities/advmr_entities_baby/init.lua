AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

  self:SetModel("models/props_c17/doll01.mdl")
  startPhysics(self)

end

function startPhysics(entity)
  entity:PhysicsInit(SOLID_VPHYSICS)
  entity:SetMoveType(MOVETYPE_VPHYSICS)
  entity:SetSolid(SOLID_VPHYSICS)
  
  local phys = entity:GetPhysicsObject()

  if phys:IsValid() then

  phys:Wake()

  end
end

function Explode(self)
local explosion = ents.Create("env_explosion")
explosion:SetPos(self:GetPos())
explosion:Spawn()
explosion:SetKeyValue("iMagnitude", "100")
explosion:Fire("Explode", 0, 0)

end

function ENT:OnTakeDamage(dmg)
  self:TakePhysicsDamage(dmg)
  if (self.HealthAmount <= 0) then return; end
  self.HealthAmount = self.HealthAmount - dmg:GetDamage()
  if (self.HealthAmount <= 0) then
    Explode(self)
    self:Remove()
  end
end









bubbleShooterEnityType={
eBall=1,
}


bubbleShooterEnityCfgs={
[bubbleShooterEnityType.eBall]={'baseEntity_ball',47,10},
}

local entityLookup={}
local entityLookup_update={}


function bubbleShooterController:updataAllEntities()
if entityLookup_update~=nil then
for ojbID,ent in pairs(entityLookup_update)do
ent:onUpdate()
end
end
end

function bubbleShooterController:removeAllEntitys()
if entityLookup~=nil and next(entityLookup)~=nil then
for ojbID,ent in pairs(entityLookup)do
release_bbEntity(ent)
end
entityLookup={}
entityLookup_update={}



clear_bbBallObjLookup()
end
end

function bubbleShooterController:getEntity(ojbID)
if ojbID==nil then return end
return entityLookup[ojbID]
end

function bubbleShooterController:getAllEntities()
return entityLookup
end

function bubbleShooterController:invokeFunc(ojbID,funcName,...)
if ojbID==nil then return end
local ent=bubbleShooterController:getEntity(ojbID)
if ent then
local f=ent[funcName]
if f~=nil then
return f(ent,...)
end
end
end

function bubbleShooterController:addEntity(entityType,data,parent)
local ent=new_bbEntity(entityType,data,parent)
local ojbID=ent.m_ojbID
assert(entityLookup[ojbID]==nil)
entityLookup[ojbID]=ent
if ent.onUpdate then
entityLookup_update[ojbID]=ent
end
new_bbEntityObj(ent)
return ojbID
end

function bubbleShooterController:delEntityNow(ojbID)
if ojbID==nil then return end
local ent=bubbleShooterController:getEntity(ojbID)
if ent then
release_bbEntity(ent)
entityLookup[ojbID]=nil
entityLookup_update[ojbID]=nil
end
end

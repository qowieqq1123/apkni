airHUDSystem={}


function airHUDSystem:onAppStart()

end

function airHUDSystem:onEnterState(isReconnect)

end


function airHUDSystem:onLeaveState(isReconnect)
airHUDSystem:leaveAirGame()
end

function airHUDSystem:onProtocolReq(isReconnect)

end

function airHUDSystem:enterAirGame()
self.luaIds={}
self.hudCacheLookup={}
self.hudLookup={}
self.luaGuidLookup={}
self.luaEnityLookup={}
self.isInitRoot=false
end

function airHUDSystem:leaveAirGame()
self.luaIds=nil
self.hudCacheLookup={}
self.hudLookup={}
self.luaGuidLookup={}
self.luaEnityLookup={}
self.isInitRoot=false
end


function airHUDSystem:onInitHUDRoot(widget,hudRoot,idx)
self.hudRoot=hudRoot
self.hudRootIdx=idx
self.isInitRoot=true
local mamager=airController.getHUDManager()
mamager:BindHUDRoot(widget,idx)
airActorSystem:createRoleHUD()
end


function airHUDSystem:onDeleteHUDRoot()
self.hudRootIdx=nil
self.hudRoot=nil
self.isInitRoot=false
end

function airHUDSystem:isInit()
return self.isInitRoot==true
end

function airHUDSystem:createHpHUD(entityType,handle,args)
if not self.isInitRoot then
return false
end
if entityType==eAirEntityType.TYPE_ROLE then
airHUDSystem:createRoleHpHUD(handle,args)
elseif entityType==eAirEntityType.TYPE_MONSTER_BOSS or
entityType==eAirEntityType.TYPE_MONSTER_ELITE then
airHUDSystem:createBossHpHUD(handle,args)
else
return false
end
return true
end

function airHUDSystem:createRoleHpHUD(handle,args)
args=args or{}
args.handle=handle
args.hudType=eHudType.eBlood
local luaid=self.hudRoot:createObject('UIAirHud',self.hudRootIdx,0,args,true)
end

function airHUDSystem:createBossHpHUD(handle,args)
args=args or{}
args.handle=handle
args.hudType=eHudType.eBlood
local luaid=self.hudRoot:createObject('UIAirBossHud',self.hudRootIdx,0,args,true)
end

function airHUDSystem:createTargetHUD(handle,args)
args=args or{}
args.handle=handle
args.hudType=eHudType.eTarget
local luaid=self.hudRoot:createObject('UIAirTargetHud',self.hudRootIdx,0,args,true)
end

function airHUDSystem:createHarmHUD(handle,ent,args)
args=args or{}
args.handle=handle
args.ent=ent
args.hudType=eHudType.eHarm
local luaid=self.hudRoot:createObject('UIAirHarmHud',self.hudRootIdx,0,args,true)
end

function airHUDSystem:createCirticalHUD(handle,ent,args)
args=args or{}
args.handle=handle
args.ent=ent
args.hudType=eHudType.eHarm
local luaid=self.hudRoot:createObject('UIAirCirticalHud',self.hudRootIdx,0,args,true)
end

function airHUDSystem:initCfg(guid,pivot,offset,super)
airController.getHUDManager():InitHUDConfig(guid,pivot,offset,super)
end

function airHUDSystem:bindEntityHUD(guid,handle,hud,isLookup)
local hudType=hud.hudType
assert(hudType)
if self.hudLookup[handle]==nil then self.hudLookup[handle]={}end
if self.hudLookup[handle][hudType]==nil then self.hudLookup[handle][hudType]={}end
local list=self.hudLookup[handle][hudType]

if not airHUDSystem:hasHud(list,hud)then
if isLookup then
list[guid]=hud
else
list[#list+1]=hud
end
local luaid=hud:getId()
self.luaGuidLookup[guid]=luaid
self.luaEnityLookup[luaid]=handle
else
return
end

airController.getHUDManager():SetBindEntity(guid,handle)
end


function airHUDSystem:bindHUDEvent(handle,hud,bit)
if self.hudCacheLookup[handle]==nil then self.hudCacheLookup[handle]={}end

local handleLookup=self.hudCacheLookup[handle]
for _,v in pairs(eHUDCatchType)do
if mathHelper.getBitValue(bit,v-1)then
if handleLookup[v]==nil then handleLookup[v]={}end
local list=handleLookup[v]
if not airHUDSystem:hasHud(list,hud)then
list[#list+1]=hud
end
end
end
end

function airHUDSystem:deleteHUD(guid)
local luaid=self.luaGuidLookup[guid]
if luaid==nil then return end
local luaobject=self.hudRoot:getLuaObject(luaid)
end

function airHUDSystem:deleteEntityHUD(handle,hudType)
if self.hudCacheLookup[handle]then
for _,list in pairs(self.hudCacheLookup[handle])do
if#list>0 then
for i=#list,1,-1 do
if list[i].hudType==hudType then
table.remove(list,i)
end
end
end
end
end

if self.hudLookup[handle]==nil then return end
if self.hudLookup[handle][hudType]==nil then return end
local list=self.hudLookup[handle][hudType]
if#list==0 then return end
for i=#list,1,-1 do
airHUDSystem:removeHUD(list[i])
end
self.hudLookup[handle][hudType]=nil
end

function airHUDSystem:deleteEntityAllHUD(handle)
if self.hudLookup[handle]==nil then return end
if self.hudLookup[handle][hudType]==nil then return end

local lookup=self.hudLookup[handle]
local hudList={}
for _,list in pairs(lookup)do
for i=#list,1,-1 do
hudList[#hudList+1]=list[i]
end
end
for i=#hudList,1,-1 do
airHUDSystem:removeHUD(hudList[i])
self.luaGuidLookup[guid]=nil
end
self.hudLookup[handle]=nil
self.hudCacheLookup[handle]=nil
airActorSystem:deleteRoleHUD(handle)
end

function airHUDSystem:deleteEntityHUDByGuid(handle,hudType,guid)
if self.hudLookup[handle]==nil then return end
if self.hudLookup[handle][hudType]==nil then return end
local list=self.hudLookup[handle][hudType]
if not list[guid]then return end
airHUDSystem:removeHUD(list[guid])
self.hudLookup[handle][hudType][guid]=nil
end

function airHUDSystem:clearAllHUD()
local list={}
for handle,lookup in pairs(self.hudLookup)do
for _,list in pairs(lookup)do
for i=#list,1,-1 do
hudList[#hudList+1]=list[i]
end
end
end
for i=#hudList,1,-1 do
airHUDSystem:removeHUD(hudList[i])
end
self.hudLookup=nil
self.hudCacheLookup=nil
end

function airHUDSystem:getHUDBit(list)
local flag=0
for _,v in ipairs(list)do
flag=flag+mathHelper.setbit(flag,v-1)
end
return flag
end

function airHUDSystem:hasHud(list,hud)
for i,v in ipairs(list)do
if v:getId()==hud:getId()then return true end
end
return false
end


function airHUDSystem:getPrefabid(luaid)
return self.luaGuidLookup[luaid]
end

function airHUDSystem:getHUD(handle,catchType)
if self.hudCacheLookup[handle]==nil then return end
return self.hudCacheLookup[handle][catchType]
end

function airHUDSystem:removeHUD(hud)
local luaid=hud:getId()
local guid=hud:getPrefabid()
self.luaEnityLookup[luaid]=nil
self.hudRoot:recycleItemById(luaid)

if guid then
self.luaGuidLookup[guid]=nil
airController.getHUDManager():RemoveHUD(guid)
end
end

function airHUDSystem:onRemoveEntity(handle)
airHUDSystem:deleteEntityAllHUD(handle)
end

function airHUDSystem:clearHarmEntity()
self.harmEnt=nil
end


function airHUDSystem:onDamage(ent,damage,isCirtical)
local pos=ent:getPosition()
local x=pos.x
local z=pos.z
local createHudFunc=function(harmEnt)
local args={damage=damage,x=x,y=z}
if isCirtical then
airHUDSystem:createCirticalHUD(harmEnt.handle,harmEnt,args)
else
airHUDSystem:createHarmHUD(harmEnt.handle,harmEnt,args)
end
end


if self.harmEnt then
return createHudFunc(self.harmEnt)
else
self.harmEnt=airEntitySystem:createHarmEntity(createHudFunc)
end
end


function airHUDSystem:onRestoreHP(handle,add)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eRestoreHP)
if huds then
for _,hud in ipairs(huds)do
hud:onRestoreHP(add)
end
end
end


function airHUDSystem:onRestoreSelf(handle,add)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eRestoreHP)
if huds then
for _,hud in ipairs(huds)do
hud:onRestoreHP(add)
end
end
end


function airHUDSystem:onRevive(handle,add)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eRestoreHP)
if huds then
for _,hud in ipairs(huds)do
hud:onRestoreHP(add)
end
end
end


function airHUDSystem:onDodge(handle)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eDodge)
if huds then
for _,hud in ipairs(huds)do
hud:onDodge()
end
end
end


function airHUDSystem:onStealHP(handle,add)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eStealHP)
if huds then
for _,hud in ipairs(huds)do
hud:onStealHP(add)
end
end
end


function airHUDSystem:onReflect(handle,damage)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eReflect)
if huds then
for _,hud in ipairs(huds)do
hud:onReflect(damage)
end
end
end


function airHUDSystem:onDead(handle)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eDead)
if huds then
for _,hud in ipairs(huds)do
hud:onDead()
end
end
end

function airHUDSystem:onHPChange(handle,new,max)
local huds=airHUDSystem:getHUD(handle,eHUDCatchType.eHP)
if huds then
for _,hud in ipairs(huds)do
hud:onHPChange(new,max)
end
end
end


function airHUDSystem:setStatus(handle,status,flag)

end

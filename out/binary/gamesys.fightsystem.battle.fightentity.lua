def_class('fightEntity',entity)
local stopEffect=CS.GameInterface.StopEffect

local entPrint=function(str)

end

local fightLogErr=function(...)
logErr(...)
end

















function fightEntity:__init(_battle,posType,id,baseInfo,outEffectOpen,assistantType)
self.guid=-1
self.lookAtCamera=false
self.fBChildTree=fBTBehaviorTree(self)
self.outEffectOpen=nil
self:init(_battle,posType,id,baseInfo,outEffectOpen,assistantType)

end

function fightEntity:init(_battle,posType,id,baseInfo,outEffectOpen,assistantType)
self.battle=_battle
self.posType=posType
self.id=id
self.posInfo=self:getPosInfoByTypo(self.posType,self.id)
self.baseInfo=baseInfo

self.isRunBehavior=false
self.buff={}
self.buffHideList={}
self.buffEffect={}
self.buffBehaveList={}
self.lastBuffBehave={}
self.buffAnimModelList={}
self.isAssistant=assistantType~=nil
self.assistantType=assistantType
self.isTempLingShou=nil
self.isSummonLingShou=nil
if self.isAssistant then
self.defaultColor=Color.New(1,1,1,0)
end


self.counterAttackList={}

self:initBuffBehave()
if self.posInfo.left then
self.flowDir=Vector3.New(-1,0.5,0)
else
self.flowDir=Vector3.New(1,0.5,0)
end
self.position=Vector3.New(0,0,0)
self.hudPosition=self.position+Vector3.New(0,1.5,0)

self.skillDuration=3
self.skipMode=false
self.simBebavior=false
self.name=self.baseInfo.name

self:initAttr()
self.buffEffectState={}
self.lastTime=0
self.lastNameTime=0
self.hpOffsetX=2
self.hpOffsetY=0

self.skillOffsetX=0
self.skillOffsetY=0

self.battlePosOffset=0

self.setResurrentSkill=nil
self.isShowJZAttr=nil


if outEffectOpen==nil then
outEffectOpen=false
end
local old_outEffectOpen=self.outEffectOpen
self.outEffectOpen=outEffectOpen
self:initOutEffect(baseInfo)
if old_outEffectOpen~=nil then
self:rebuildAllOutEffect()
end


end

function fightEntity:getPosInfoByTypo(typo,id)
if self.battle~=nil then
return self.battle:getPosInfoByTypo(self.posType,self.id)
else
return fightModel:getPosInfoByTypo(self.posType,self.id)
end
end

function fightEntity:initAttr()
self.typo=self.baseInfo.typo

self.name=self.baseInfo.name
self.model=self.baseInfo.model

self.hasFace=self.model.body and spineHelper.enableChangeFace(self.model.body)
or false
self.bodyID=self.model.body
self.attr=self.baseInfo.attr or{}

self.totalAttack=0
self.totalDefend=0
self.totalCue=0
self.totalTreated=0

if self.battle~=nil then
self.rcHP=self.battle.rcHPList[self.id]or 0
else
self.rcHP=0
end
if self.initHuaSe then
self:initHuaSe()
end
self:setSPHUDType()
end

function fightEntity:setSPHUDType(sp_hud_id)
self.sPHUDType=sp_hud_id
end

function fightEntity:getSPHUDType()
return self.sPHUDType
end

function fightEntity:copyAttrData()
local data={}
data.baseInfo=table.weakCopy(self.baseInfo)

data.name=data.baseInfo.name
data.model=data.baseInfo.model

data.hasFace=data.model.body and spineHelper.enableChangeFace(data.model.body)
or false
data.bodyID=data.model.body
data.attr=data.baseInfo.attr or{}

data.totalAttack=self.totalAttack
data.totalDefend=self.totalDefend
data.totalCue=self.totalCue
data.totalTreated=self.totalTreated

data.rcHP=self.rcHP

return data
end

function fightEntity:resetTotalData()
self.totalAttack=0
self.totalDefend=0
self.totalCue=0
self.totalTreated=0
end

function fightEntity:getType()
return self.typo
end

function fightEntity:getTypeEx(data)
return data.typo
end

function fightEntity:getImageInfo()
return self.baseInfo.image
end

function fightEntity:getImageInfoEx(data)
return data.baseInfo.image
end

function fightEntity:getMonsterID()
return self.baseInfo.monsterID
end

function fightEntity:getMonsterIDEx(data)
return data.baseInfo.monsterID
end

function fightEntity:getbaseInfo()
return self.baseInfo
end

function fightEntity:getClothing()
return self.baseInfo.clothingId or 0
end

function fightEntity:getXMVoc()
return self.baseInfo.xianmo_voc or 0
end

function fightEntity:enterSkipMode()
self.skipMode=true
self:stopBehavior()
end

function fightEntity:leaveSkipMode(data)
self.skipMode=false
local hp=self:getAttribute(entityAttr.hp)
local huDun=self:getAttribute(entityAttr.hudun)
local maxhp=self:getAttribute(entityAttr.max_hp)
local subMaxhp=self:getAttribute(entityAttr.sub_max_hp)
if self.battle and self.battle.isShowWindow then
self:flowText(flowObjTypo.hp,{change=0,curhp=hp,maxhp=maxhp})
end
if self.hud then
self.hud:setHP(hp,maxhp,subMaxhp,0)
self.hud:setHuDunValue(huDun,hp,maxhp,subMaxhp)
self.hud:setSubHPMax(subMaxhp,maxhp)
end

if self.buffEffect~=nil then
for guid,data in pairs(self.buffEffect)do
if data.handle then
stopEffect(data.handle)
end
end
self.buffEffect={}
end
end

function fightEntity:onComplete()
self:showHuD(false)
self:removeAllBuffEffect()
self:initBuffBehave()
self.lastBuffBehave={}
end

function fightEntity:setIndex(index)
self.id=index
local posData=self:getPosInfoByTypo(self.posType,self.id)
if posData~=nil then
self.posInfo=posData
self.isLeftTeam=posData.left
self.position=posData.pos
self.hudPosition=self.position+Vector3.New(0,self.bodySize[2],0)
if self.entObj~=nil then
self.entObj.transform.localPosition=posData.pos
end
end
end

function fightEntity:getIndex()
return self.id
end

function fightEntity:isShow()
return self.entObj~=nil
end

function fightEntity:onShow()
if self.enterBt~=nil then
self:runBehavior(self.enterBt)

self.fBTree:update(0.01)
self.enterBt=nil

end

local jzAfterAttr=self.baseInfo.jzAfterAttr
if jzAfterAttr and not self.isShowJZAttr then
self.showJZAttrDelay=1.2
self.showJZAttrDelayFunc=function()
for attrType,val in pairs(jzAfterAttr)do
local str=FMT.fmt("{0}提升",entityAttrName[attrType])
self:flowText(flowObjTypo.buff,{strPara=str,arrow=1},0.45)
end
end
self.showJZEffectDelay=function()
self:playEffect(20617,Vector3.zero,true,true,Vector3.one)
end

self.isShowJZAttr=true
end

self:rebuildAllOutEffect()
self:rebulidBuffBehave()
end

function fightEntity:setEnterBehavior(bt)
self.enterBt=bt
end

function fightEntity:onHide()
if self.skillCompleteCall~=nil then
self:createSimBehavior()
end

if self.delayHit~=nil then
self.delayHit:cancel()
self.delayHit=nil
end

if self.delayFade~=nil then
self.delayFade:cancel()
self.delayFade=nil
end

if self.buffEffect~=nil then
for guid,data in pairs(self.buffEffect)do
if data.handle then
stopEffect(data.handle)
end
end
end
self:removeAllOutEffect()
end

function fightEntity:newMon(info,isFade)
self.baseInfo=info
self:initAttr()
self.buff={}
self.buffHideList={}
self.counterAttackList={}
self:hide()

if self.battle then
if self:isLeft()then
if self.battle:getLeftTeamShield()>0 then
self:enableHUD(false)
end
else
if self.battle:getRightTeamShield()>0 then
self:enableHUD(false)
end
end
end

self:showHuD(true)
local hp=self:getAttribute(entityAttr.hp)
local huDun=self:getAttribute(entityAttr.hudun)
local maxhp=self:getAttribute(entityAttr.max_hp)
local subMaxhp=self:getAttribute(entityAttr.sub_max_hp)
if self.hud then
self.hud:setHP(hp,maxhp,subMaxhp)
self.hud:setHuDunValue(huDun,hp,maxhp,subMaxhp)
self.hud:setSubHPMax(subMaxhp,maxhp)
end
self:flushBuff()
if self.battle and self.battle.isShowWindow then
self:flowText(flowObjTypo.hp,{change=0,curhp=hp,maxhp=maxhp})
self:show(isFade)
self:runAnimator(entityStateID.stand)
end
end

function fightEntity:getBattle()
return self.battle
end

function fightEntity:getBuffInfo()
return self.buff
end

function fightEntity:isBuffProtect(buff_guid)
for i,v in pairs(self.buff)do
if v.protect_buff_lookup and v.protect_buff_lookup[buff_guid]then
return true,v.guid
end
end
end

function fightEntity:update(deltaTime)

if self.isFade then

self.isFade=self.isFade-1
if self.isFade==0 then
self:fadeToColor(Color.New(1,1,1,0),0,nil)
end
self.isFade=nil
end
if self.simBebavior then
self.simTimer=self.simTimer+deltaTime
if self.simTimer>=self.skillDuration then
self.simBebavior=false
self:onBehaviorEvent(fBTEvent.BehaviorFinish)
end
else
self.fBTree:update(deltaTime)
end

if self.simChildBebavior then
self.simChildTimer=self.simChildTimer+deltaTime
if self.simChildTimer>=self.skillDuration then
self.simChildBebavior=false
self:onChildBehaviorEvent(fBTEvent.BehaviorFinish)
end
else
self.fBChildTree:update(deltaTime)
end

if self.showJZAttrDelay then
self.showJZAttrDelay=self.showJZAttrDelay-deltaTime
if self.showJZAttrDelay<=1 and self.showJZEffectDelay then
self.showJZEffectDelay()
self.showJZEffectDelay=nil
end
if self.showJZAttrDelay<=0 then
if self.showJZAttrDelayFunc then
self.showJZAttrDelayFunc()
end
self.showJZAttrDelayFunc=nil
self.showJZAttrDelay=nil
end
end
end

function fightEntity:isLeft()
return self.posInfo.left
end

function fightEntity:getFlowDir()
return self.flowDir
end

function fightEntity:getLogicPosition()
return self.posInfo.pos+Vector3(self.posInfo.left and 0-self.battlePosOffset or self.battlePosOffset,0,0)
end

function fightEntity:setBattlePosOffset(offset)
self.battlePosOffset=offset
end

function fightEntity:getRowPostion()
return self.posInfo.rowPos
end

function fightEntity:fixOffset(offset)
if self.posInfo.left then
offset.x=0-offset.x
end
return offset
end

function fightEntity:getHitedPos()
if self.entObj~=nil then
local pos=self.entObj:GetPosition()
pos.y=pos.y+self.bodySize[2]*self.hitedPos[2]
if self.posInfo.left then
pos.x=pos.x+self.bodySize[1]*self.hitedPos[1]
else
pos.x=pos.x-self.bodySize[1]*self.hitedPos[1]
end
return pos
else
return self.position
end
end

function fightEntity:getAttackPosition(dstEnt)
local distance=self.bodySize[1]or 0
if dstEnt~=nil then
distance=distance+dstEnt.bodySize[1]
end
distance=distance*0.5
if not self.posInfo.left then
distance=-distance
end
return self:getPosition()+Vector3.New(distance,0,0)
end

function fightEntity:getFlowHpPosition()
local pass=Time.time-self.lastTime
self.lastTime=Time.time
if pass>1.0 then
self.hpOffsetX=2
self.hpOffsetY=0
else
self.hpOffsetX=self.hpOffsetX-0.5
self.hpOffsetY=self.hpOffsetY+0.55
end

return Vector3.New(self:isLeft()and-self.hpOffsetX or self.hpOffsetX,self.hpOffsetY,0)
end

function fightEntity:getFlowSkillPosition()
local pass=Time.time-self.lastTime
self.lastTime=Time.time
if pass>1.0 then
self.hpOffsetX=0
self.hpOffsetY=0
else

self.hpOffsetY=self.hpOffsetY+0.55
end

return Vector3.New(self:isLeft()and-self.hpOffsetX or self.hpOffsetX,self.hpOffsetY,0)
end

function fightEntity:getFlowSkillNamePosition()
local pass=Time.time-self.lastNameTime
self.lastNameTime=Time.time
if pass>1.0 then
self.skillOffsetX=0
self.skillOffsetY=0
else

self.skillOffsetY=self.skillOffsetY+0.5
end

return Vector3.New(self:isLeft()and-self.skillOffsetX or self.skillOffsetX,self.skillOffsetY,0)
end



function fightEntity:runBehavior(btName,targets,_onBahaviroEvent)

self:stopBehavior()
self.isRunBehavior=true

local onEventListen=function(eventTypo,args)
self:onBehaviorEvent(eventTypo,args)
end

self.onBahaviroEvent=_onBahaviroEvent

if self.skipMode then
self:onBehaviorEvent(fBTEvent.BehaviorFinish)
else
if self.entObj or(self.battle~=nil and self.battle.isShowWindow)then

self.fBTree:setSharedValue('targets',targets)
self.fBTree:setSharedValue('battle',self.battle)
self.fBTree:start(self,btName,onEventListen)
else
self:createSimBehavior()
end
end
end

function fightEntity:isShow()
return self.entObj~=nil
end

function fightEntity:onBehaviorEvent(eventTypo,args)
if self.onBahaviroEvent~=nil then
self.onBahaviroEvent(eventTypo,args)
end

if fBTEvent.BehaviorFinish==eventTypo then
self.skillCompleteCall=nil
self.isRunBehavior=false
self.targets=nil
end
end




function fightEntity:createSimBehavior()
self.simBebavior=true
self.simTimer=0
end



function fightEntity:runChildBehavior(btName,targets,_onBahaviroEvent)
self:stopChildBehavior()
self.isRunChildBehavior=true

local onEventListen=function(eventTypo,args)
if _onBahaviroEvent~=nil then
_onBahaviroEvent(eventTypo,args)
end
end

self.onChildBahaviroEvent=_onBahaviroEvent

if self.skipMode then
onEventListen(fBTEvent.BehaviorFinish)
else
if self.entObj then
self.fBChildTree:setSharedValue('targets',targets)
self.fBChildTree:setSharedValue('battle',self.battle)
self.fBChildTree:start(self,btName,onEventListen)
else
self:createChildSimBehavior()
end
end
end

function fightEntity:stopChildBehavior()
if self.isRunChildBehavior then
self.isRunChildBehavior=false
self.fBChildTree:stop()
end
end

function fightEntity:onChildBehaviorEvent(eventTypo,args)
if self.onChildBahaviroEvent~=nil then
self.onChildBahaviroEvent(eventTypo,args)
end

if fBTEvent.BehaviorFinish==eventTypo then
self.isRunChildBehavior=false
end
end

function fightEntity:createChildSimBehavior()
self.simChildBebavior=true
self.simChildTimer=0
end




function fightEntity.onGemPowerChange(self,oldVlaue,newValue)
if self.hud then
self.hud:flushGemPower(newValue,self:getAttribute(entityAttr.max_gem_power))
end
end

function fightEntity.onHuDunValueChange(self,oldVlaue,newValue)
if self.hud then
self.hud:setHuDunValue(newValue,self:getAttribute(entityAttr.hp),self:getAttribute(entityAttr.max_hp))
end
end

function fightEntity.onSubMaxHpMaxChange(self,oldVlaue,newValue)
if self.hud then
self.hud:setSubHPMax(newValue,self:getAttribute(entityAttr.max_hp))
end
end

local attrFunc={
[entityAttr.gem_power]=fightEntity.onGemPowerChange,
[entityAttr.hudun]=fightEntity.onHuDunValueChange,
[entityAttr.sub_max_hp]=fightEntity.onSubMaxHpMaxChange,
}

function fightEntity:getAttribute(typo)
return self.attr[typo]or 0
end

function fightEntity:getAttributeEx(data,typo)
return data.attr[typo]or 0
end

function fightEntity:setAttribute(typo,value)
self.attr[typo]=value
end

function fightEntity:onAttributeChange(typo,value,isChanged)
local oldValue=self:getAttribute()


if not isChanged then
self.attr[typo]=value
end
local listernFunc=attrFunc[typo]
if listernFunc~=nil then
listernFunc(self,oldValue,value)
end
end

function fightEntity:fadeToColor(color,duration,finish)
if self.entObj then

if self:isBuffHide()then
return
end

self.entObj:FadeToColor(color,duration,finish or nil)
if color.a==0 then
if self.hud then
self.hud:fade(duration,0)
end
self:activeOutEffect(false,true)
else
if self.hud then
self.hud:fade(duration,1)
end
self:activeOutEffect(true,true)
end
end
end

function fightEntity:fadeToColor_selfLingShou(color,duration,finish)
local selfEntId=self.id
local lsEntId=selfEntId+stagePosWeight.assist
local battle=self.battle
if battle~=nil then
local ent=battle:getEntity(lsEntId)
if ent~=nil then
ent:fadeToColor(color,duration,finish)
end
end
end

function fightEntity:getBuff(guid)
return self.buff[guid]
end

function fightEntity:getAllBuff()
return self.buff
end



function fightEntity:checkBuffRound(buffInfo)
if buffInfo.round>0 and(buffInfo.srcID==self.id)and(not buffInfo.cfg.actionSelfMore)and buffInfo.cfg.checkType==buffCheckType.actionEnd then
buffInfo.round=buffInfo.round+1
end
end


function fightEntity:updateBuffEffectState(buffInfo,add)
local stateCount=self.buffEffectState[buffInfo.cfg.buffType]or 0
stateCount=stateCount+add
if stateCount<0 then
stateCount=0
end
self.buffEffectState[buffInfo.cfg.buffType]=stateCount
end


function fightEntity:updateBuffEffect(buffInfo)
if buffInfo.cfg.layer_buff_id~=nil then
if buffInfo.curLayerEffect==nil then
buffInfo.curLayerEffect={}
end

local curEffectID=buffInfo.cfg.layer_buff_id[buffInfo.layer]
if buffInfo.curLayerEffect.id~=curEffectID then
if buffInfo.curLayerEffect.handle~=nil then
stopEffect(buffInfo.curLayerEffect.handle)
buffInfo.curLayerEffect.handle=nil
end
if curEffectID~=nil then
buffInfo.curLayerEffect.handle=self:playEffect(curEffectID,Vector3.zero,true,true)
end
buffInfo.curLayerEffect.id=curEffectID
end
end
end

function fightEntity:removeBuffEffect(buffInfo)
if buffInfo.curLayerEffect~=nil and buffInfo.curLayerEffect.handle~=nil then
stopEffect(buffInfo.curLayerEffect.handle)
end
end

function fightEntity:removeAllBuffEffect()
if self.buff~=nil then
for guid,buff in pairs(self.buff)do
if buff.playEffectHandle then
stopEffect(buff.playEffectHandle)
end
if buff.cfg.hideTime then
if self.entObj then
self.entObj:FadeToColor(Color.New(1,1,1,1),buff.cfg.hideTime[1],nil,0)
end
end
end
end
if self.buffEffect~=nil then
for guid,data in pairs(self.buffEffect)do
if data.handle then
stopEffect(data.handle)
end
end
end


if self.addEnt then
fightManager.removeEntity(self.addEnt.GUID)
self.addBodyId=nil
self.addEnt=nil
end
end

function fightEntity:addBuff(buffInfo,addSkillName,isLog)
if self.buff[buffInfo.guid]==nil then
self:updateBuffEffectState(buffInfo,1)




else
buffInfo.curLayerEffect=self.buff[buffInfo.guid].curLayerEffect


end

local str=buffInfo.cfg.infoTip
local arrow=buffInfo.cfg.effectType
if str then
str=FMT.fmt(str,addSkillName or"")
self:flowText(flowObjTypo.buff,{strPara=str,arrow=arrow},0.45)
end

local waitTime=0
if buffInfo.cfg.addEffectID~=nil then
local addEffectID=buffInfo.cfg.addEffectID

if self.battle then
local ent=self.battle:getEntity(buffInfo.srcID)
if ent then
local entClothing=ent:getClothing()
if entClothing>0 and buffInfo.cfg.addEffectIdClothing and buffInfo.cfg.addEffectIdClothing[entClothing]then
addEffectID=buffInfo.cfg.addEffectIdClothing[entClothing]
end
end
end

local delay=addEffectID[2]
if addEffectID[3]and waitTime<addEffectID[3]then
waitTime=addEffectID[3]
end
if delay and delay>0 then
timeEventController.delayDo(delay,function()
if self.buff[buffInfo.guid]then
if not self.buffEffect[buffInfo.guid]then
local offset=Vector3.zero
if addEffectID[4]and addEffectID[5]then
offset=Vector3.New(addEffectID[4],addEffectID[5],0)
end
local handle=self:playEffect(addEffectID[1],offset,true,false)
self.buffEffect[buffInfo.guid]={handle=handle,effectData=addEffectID}


end
else

end
end,false)
else
if not self.buffEffect[buffInfo.guid]then
local offset=Vector3.zero
if addEffectID[4]and addEffectID[5]then
offset=Vector3.New(addEffectID[4],addEffectID[5],0)
end
local handle=self:playEffect(addEffectID[1],offset,true,false)

self.buffEffect[buffInfo.guid]={handle=handle,effectData=addEffectID}


end
end

end

if buffInfo.cfg.hideTime then
if self.entObj then

self:fadeToColor(Color.New(1,1,1,0),buffInfo.cfg.hideTime[1],nil)
self:buffHide(buffInfo.guid,true)
end
end

if buffInfo.cfg.enterModelAnim then
local anim=buffInfo.cfg.enterModelAnim[1]
local wait=buffInfo.cfg.enterModelAnim[2]
if self.entObj then
self:runAnimator(anim,1)
end
if waitTime<wait then
waitTime=wait
end
if buffInfo.cfg.modelAnim then
timeEventController.delayDo(wait,function()
if self.entObj then
self:runAnimator(buffInfo.cfg.modelAnim,1)
if buffInfo.cfg.animExculdeModel then
self.buffAnimModelList[buffInfo.guid]=buffInfo.cfg.animExculdeModel
end
end
end)
end
end

local changeDuration=buffInfo.cfg.changeDuration
if buffInfo.cfg.modelScaleLayerAdd then
local behave=self:getBuffBehave(eFightBuffBehave.scale,buffInfo.guid)
if behave then
behave={guid=buffInfo.guid,data={buffInfo.cfg.modelScaleLayerAdd,layer=buffInfo.layer},duration=changeDuration}
self:setBuffBehave(eFightBuffBehave.scale,buffInfo.guid,behave)
else
table.insert(self.buffBehaveList[eFightBuffBehave.scale],{guid=buffInfo.guid,data={buffInfo.cfg.modelScaleLayerAdd,layer=buffInfo.layer},duration=changeDuration})
end
else
if buffInfo.cfg.modelScale then
local behave=self:getBuffBehave(eFightBuffBehave.scale,buffInfo.guid)
if behave then
behave={guid=buffInfo.guid,data={buffInfo.cfg.modelScale},duration=changeDuration}
self:setBuffBehave(eFightBuffBehave.scale,buffInfo.guid,behave)
else
table.insert(self.buffBehaveList[eFightBuffBehave.scale],{guid=buffInfo.guid,data={buffInfo.cfg.modelScale},duration=changeDuration})
end
end
end

if buffInfo.cfg.modelColor then
local behave=self:getBuffBehave(eFightBuffBehave.color,buffInfo.guid)
if behave then
behave={guid=buffInfo.guid,data={buffInfo.cfg.modelColor,buffInfo.cfg.modelColorDuration},duration=changeDuration}
self:setBuffBehave(eFightBuffBehave.color,buffInfo.guid,behave)
else
table.insert(self.buffBehaveList[eFightBuffBehave.color],{guid=buffInfo.guid,data={buffInfo.cfg.modelColor,buffInfo.cfg.modelColorDuration},duration=changeDuration})
end
end

if buffInfo.cfg.changebodyid then
local behave=self:getBuffBehave(eFightBuffBehave.changeModel,buffInfo.guid)
local entClothing=self:getClothing()
local changebodyid=buffInfo.cfg.changebodyid

local xm_voc=self:getXMVoc()
if xm_voc>0 and self.baseInfo.hidexianmodress~=1 and buffInfo.cfg.xmchangebodyid and buffInfo.cfg.xmchangebodyid[xm_voc]then
changebodyid=buffInfo.cfg.xmchangebodyid[xm_voc]
end

if buffInfo.cfg.clothingchangebodyid and buffInfo.cfg.clothingchangebodyid[entClothing]then
if entClothing>0 then
changebodyid=buffInfo.cfg.clothingchangebodyid[entClothing]
end
end

local ent=self.battle:getEntity(buffInfo.srcID)
if ent then
entClothing=ent:getClothing()
if buffInfo.cfg.clothingchangebodyid and buffInfo.cfg.clothingchangebodyid[entClothing]then
local addSrc=buffInfo.cfg.clothingchangebodyid[entClothing][5]
if addSrc==1 then
changebodyid=buffInfo.cfg.clothingchangebodyid[entClothing]
end
end
end

if behave then
behave={guid=buffInfo.guid,data=changebodyid,duration=changeDuration,priority=changebodyid[2]}
self:setBuffBehave(eFightBuffBehave.changeModel,buffInfo.guid,behave)
else
table.insert(self.buffBehaveList[eFightBuffBehave.changeModel],{guid=buffInfo.guid,data=changebodyid,duration=changeDuration,priority=changebodyid[2]})
end
end

if buffInfo.cfg.addPosBodyid then
local behave=self:getBuffBehave(eFightBuffBehave.addBody,buffInfo.guid)
if behave then
behave={guid=buffInfo.guid,data=buffInfo.cfg.addPosBodyid,duration=changeDuration}
self:setBuffBehave(eFightBuffBehave.addBody,buffInfo.guid,behave)
else
table.insert(self.buffBehaveList[eFightBuffBehave.addBody],{guid=buffInfo.guid,data=buffInfo.cfg.addPosBodyid,duration=changeDuration})
end
end

if not isLog then
self.battle:onAddSceneEffect(self,buffInfo.guid,buffInfo.id)
else
buffInfo.isLogDelete=nil
end

self.buff[buffInfo.guid]=buffInfo
self:updateBuffEffect(buffInfo)
self:flushBuff()

if waitTime and waitTime>0 then
self.battle:setBattlePause(true)
timeEventController.delayDo(waitTime,function()
self.battle:setBattlePause(false)
end,false)
end

if changeDuration then
self:onAddBuffBehave(changeDuration)
return changeDuration
end
return 0
end

function fightEntity:logAddBuff(buffInfo,logFun)
self.buff[buffInfo.guid]=buffInfo
end

function fightEntity:buffHide(guid,val)
if not self.buffHideList then
self.buffHideList={}
end
self.buffHideList[guid]=val
end

function fightEntity:isBuffHide()
if not self.buffHideList then
return false
end
return next(self.buffHideList)~=nil
end

function fightEntity:removeBuff(buffInfo,flushBuff)
if flushBuff==nil then
flushBuff=true
end

local guid=buffInfo.guid

local waitTime=0
if self.buff[buffInfo.guid]==nil then

end

if self.buffEffect[buffInfo.guid]then
local handle=self.buffEffect[buffInfo.guid].handle
if handle then
stopEffect(handle)
end
self.buffEffect[buffInfo.guid]=nil

end

if buffInfo.cfg.hideTime then
if self.entObj then
self:buffHide(guid,nil)

self:fadeToColor(Color.New(1,1,1,1),buffInfo.cfg.hideTime[1],nil)
end
end

if buffInfo.cfg.delEffectID~=nil then
local delEffectID=buffInfo.cfg.delEffectID
local ent=self.battle:getEntity(buffInfo.srcID)
if ent then
local entClothing=ent:getClothing()
if entClothing>0 and buffInfo.cfg.delEffectIdClothing and buffInfo.cfg.delEffectIdClothing[entClothing]then
delEffectID=buffInfo.cfg.delEffectIdClothing[entClothing]
end
end

self:playEffect(delEffectID,Vector3.zero,true,false)
end

self.buffAnimModelList[buffInfo.guid]=nil

if buffInfo.cfg.exitModelAnim then
local wait=buffInfo.cfg.enterModelAnim[2]
if waitTime<wait then
waitTime=wait
end
if self.entObj then
self:runAnimator(buffInfo.cfg.exitModelAnim[1],1)

end
end

local changeDuration=buffInfo.cfg.changeDuration

self:updateBuffBehave(buffInfo.guid)

self.battle:onRemoveSceneEffect(buffInfo.guid,self:isLeft())

self:updateBuffEffectState(buffInfo,-1)
self:removeBuffEffect(buffInfo)
self.buff[buffInfo.guid]=nil
if flushBuff then
self:flushBuff()
end

if waitTime and waitTime>0 then
self.battle:setBattlePause(true)
timeEventController.delayDo(waitTime,function()
self.battle:setBattlePause(false)
end,false)
end

if changeDuration then
return changeDuration
end
return 0
end

function fightEntity:logRemoveBuff(buffInfo,logFun)
self.buff[buffInfo.guid]=nil
end

function fightEntity:checkState(buffEffectType)
local state=self.buffEffectState[buffEffectType]
return state~=nil and state>0
end

function fightEntity:checkBuffRoundProtect(buff_guid)
local isProtect,guid=self:isBuffProtect(buff_guid)
if isProtect then
local protectBuff=self:getBuff(guid)
if protectBuff then
return protectBuff.protect_buff and protectBuff.protect_buff[5]==1
end
end
end

function fightEntity:checkLogBuffRoundProtect(buff_guid)
local isProtect,guid=self:isBuffProtect(buff_guid)
if isProtect then
local protectBuff=self:getBuff(guid)
if protectBuff then
return protectBuff.protect_buff and protectBuff.protect_buff[5]==1 and not protectBuff.isLogDelete
end
end
end

function fightEntity:updateBuffRound(checkTypo)
local flush=false
local waitTime=-1
local haveBehaveBuff=false

local protectBuffList={}
for guid,info in pairs(self.buff)do
if info.protect_buff_lookup and next(info.protect_buff_lookup)~=nil then
protectBuffList[guid]=info
else
if info.cfg.checkType==checkTypo then
if info.round~=-1 then
if not self:checkBuffRoundProtect(guid)then
info.round=info.round-1
if info.round<=0 then
if(not haveBehaveBuff)and self:isBehaveBuff(info.guid)then
haveBehaveBuff=true
end
self.battle:onRemoveBuff(info)
local t=self:removeBuff(info,false)
if t>waitTime then
waitTime=t
end
self.buff[info.guid]=nil
end
end
end
end
flush=true
end
end

for _,info in pairs(protectBuffList)do
if info.cfg.checkType==checkTypo then
if info.round~=-1 then

info.round=info.round-1
if info.round<=0 then
if(not haveBehaveBuff)and self:isBehaveBuff(info.guid)then
haveBehaveBuff=true
end
self.battle:onRemoveBuff(info)
local t=self:removeBuff(info,false)
if t>waitTime then
waitTime=t
end
self.buff[info.guid]=nil
end
end
flush=true
end
end
if flush then
self:flushBuff()
end
if haveBehaveBuff and waitTime>-1 then
self:onRemoveBuffBehave(waitTime)
end

return waitTime
end

function fightEntity:logUpdateBuffRound(checkTypo,logFun)
local protectBuffList={}

for guid,info in pairs(self.buff)do
if info.protect_buff_lookup and next(info.protect_buff_lookup)~=nil then
protectBuffList[guid]=info
else
if info.cfg.checkType==checkTypo then
if info.round~=-1 then

if not self:checkLogBuffRoundProtect(guid)then
info.round=info.round-1
if info.round==0 then
logFun(FMT.fmt('[客][{0}]删除buff[{1}][{2}]{3}',self:logName(),info.cfg.name,info.cfg.id,fightActionHelper.genBuffRoundInfoStr(info)))
self.battle:onRemoveBuff(info)
elseif info.round>0 then
logFun(FMT.fmt('[客][{0}]更新buff[{1}][{2}]{3}',self:logName(),info.cfg.name,info.cfg.id,fightActionHelper.genBuffRoundInfoStr(info)))
end
end
end
end
end
end
for guid,info in pairs(protectBuffList)do
if info.cfg.checkType==checkTypo then
if info.round~=-1 then

info.round=info.round-1
if info.round==0 then
info.isLogDelete=true
logFun(FMT.fmt('[客][{0}]删除buff[{1}][{2}]{3}',self:logName(),info.cfg.name,info.cfg.id,fightActionHelper.genBuffRoundInfoStr(info)))
self.battle:onRemoveBuff(info)
elseif info.round>0 then
logFun(FMT.fmt('[客][{0}]更新buff[{1}][{2}]{3}',self:logName(),info.cfg.name,info.cfg.id,fightActionHelper.genBuffRoundInfoStr(info)))
end
end
end
end
end


function fightEntity:updateBuffOnResurrenttion()
local flush=false
local waitTime=-1
local haveBehaveBuff=false
for guid,info in pairs(self.buff)do
if info.cfg.isReliveBeforeDel then
if(not haveBehaveBuff)and self:isBehaveBuff(info.guid)then
haveBehaveBuff=true
end
self.battle:onRemoveBuff(info)
local t=self:removeBuff(info,false)
if t>waitTime then
waitTime=t
end
self.buff[info.guid]=nil
flush=true
end
end

if flush then
self:flushBuff()
end
if haveBehaveBuff and waitTime>-1 then
self:onRemoveBuffBehave(waitTime)
end

return waitTime
end


function fightEntity:onRecvDamage(srcEnt,value,demageTypo,serverHP,oldValue)
local realHp=self:getAttribute(entityAttr.hp)
local hp=oldValue or realHp
local maxhp=self:getAttribute(entityAttr.max_hp)
local huDun=self:getAttribute(entityAttr.hudun)
local subMaxhp=self:getAttribute(entityAttr.sub_max_hp)







self.rcHP=self.rcHP+value

local isDead=false

local oldHp=hp
hp=hp-value
local realValue=value

if hp<=0 then
realValue=oldHp
hp=0
end


if self.battle and self.battle.isShowWindow then
self:flowText(flowObjTypo.hp,{change=math.floor(value),curhp=hp,maxhp=maxhp,demageTypo=demageTypo})
end

local change_hp_type=self:getAttribute(entityAttr.change_hp_type)
if not change_hp_type then
self:setAttribute(entityAttr.change_hp_type,0)
end

if change_hp_type==0 and realHp<serverHP then

loggerUtil.log(FMT.fmt("客户端血量【{0}】与服务端血量【{1}】不一致,原血量{2}",hp,serverHP,realHp))
return
end


if oldHp>0 then
if hp<=0 then
isDead=true

else
isDead=false
end
end
self.lastHPChange=-value

self:setAttribute(entityAttr.hp,serverHP)

self:setAttribute(entityAttr.change_hp_type,0)
if self.hud then
self.hud:setHP(hp,maxhp,subMaxhp,self.rcHP)
self.hud:setHuDunValue(huDun,hp,maxhp,subMaxhp)
self.hud:setSubHPMax(subMaxhp,maxhp)
end





return isDead
end



function fightEntity:onRecvTreated(srcEnt,value,serverHP,oldValue,dstBtPara)
local realHp=self:getAttribute(entityAttr.hp)
local hp=oldValue or realHp

local maxhp=self:getAttribute(entityAttr.max_hp)
local huDun=self:getAttribute(entityAttr.hudun)
local subMaxhp=self:getAttribute(entityAttr.sub_max_hp)


local realValue=value
local curHp=hp+value
if curHp>maxhp then
realValue=maxhp-hp
curHp=maxhp

end

local isResurrenttion=false
if hp<=0 and curHp>0 then
isResurrenttion=true
end
hp=curHp
self.lastHPChange=value
if self.battle.isShowWindow then
self:flowText(flowObjTypo.hp,{change=-math.floor(value),curhp=hp,maxhp=maxhp})
end

local change_hp_type=self:getAttribute(entityAttr.change_hp_type)
if not change_hp_type then
self:setAttribute(entityAttr.change_hp_type,1)
end

if change_hp_type==1 and realHp>serverHP then

return
end

self:setAttribute(entityAttr.hp,serverHP)

self:setAttribute(entityAttr.change_hp_type,1)

if isResurrenttion then

end
if self.hud then
self.hud:setHP(serverHP,maxhp,subMaxhp)
self.hud:setHuDunValue(huDun,serverHP,maxhp,subMaxhp)
self.hud:setSubHPMax(subMaxhp,maxhp)
end






return isResurrenttion
end





function fightEntity:onResurrenttion(dstBtPara)

if self.delayResurrenttion~=nil then
self.delayResurrenttion:cancel()
end
if self.delayFade~=nil then
self.delayFade:cancel()
end

local buffWait=self:updateBuffOnResurrenttion()
if buffWait<0 then
buffWait=0
end

local delayFunc=function()
self.delayResurrenttion=nil

local cfg=skillShowTypeTag[eSkillShowType.clientReLive]
if self.battle.isShowWindow then
self:show(true)
self:showHuD(true)
if self.setResurrentSkill then
local config=cfgHelper.get(cfg_skillconfig_get,self.setResurrentSkill)
local passiveResurrent=config.passiveResurrent or"fightResurrenttion"
self:runBehavior(passiveResurrent,{self.id},nil)
self:flowText(flowObjTypo.skillEffect,{nunPara=cfg.imageID})
self.setResurrentSkill=nil
else
if dstBtPara and dstBtPara.dstBT then
self:runBehavior(dstBtPara.dstBT,{dstBtPara.dstID},function()
if self.entObj then
self.entObj:FadeToColor(Color.New(1,1,1,1),0.1,nil)
if self.hud then
self.hud:fade(0.1,1)
end
self:rebulidBuffBehave()
else
logErr("entObj不存在")
end
end)
self:flowText(flowObjTypo.skillEffect,{nunPara=cfg.imageID})
else
self:runBehavior("fightResurrenttion",nil,function()
if self.entObj then
self.entObj:FadeToColor(Color.New(1,1,1,1),0.1,nil)
self:rebulidBuffBehave()
end
end)
timeEventController.delayDo(0.6,function()
self:flowText(flowObjTypo.skillEffect,{nunPara=cfg.imageID})
end)
end
end


else
self:showHuD(false)
end
end

self.delayResurrenttion=timer.new()
self.delayResurrenttion:start(1+buffWait,delayFunc,1)



local assist=self.battle:getEntity(self.id+stagePosWeight.assist)
if assist then
assist:onResurrenttion()
end

return buffWait+2
end


function fightEntity:onDead()

self.fBTree:stop()

for i,v in pairs(self:getBuffInfo()or defaultT)do
self.battle:onRemoveSceneEffect(v.guid,self:isLeft())
end

local isPlayDead=false

if self.typo==fightEntityType.diZi or(self.typo==fightEntityType.monster and fightModel:isDiziMonster(self.baseInfo.monsterID))then
isPlayDead=true
end

if isPlayDead then

self:runAnimator(entityStateID.hit)
if self.delayHit~=nil then
self.delayHit:cancel()
end
self.delayHit=timer.new()
self.delayHit:start(0.5,function()
self:runAnimator(entityStateID.dead)
end,1)
else
self:stopAnimator(entityStateID.hit,0.5)
end

self:showHuD(false)
if self.delayFade~=nil then
self.delayFade:cancel()
end
local delayFadeOut=function()
self.delayFade=nil

if not isPlayDead then
self:playEffect(30001,nil,false,false)
else
self:playEffect(30001,Vector3.New(0,0,-2),false,false)
end
if self.entObj then
local id=self.guid


fightManager.removeEntity(id)
self.entObj=nil


self.guid=-1
end
end
self.delayFade=timer.new()
self.delayFade:start(isPlayDead and 1 or 0.5,delayFadeOut,1)




local assist=self.battle:getEntity(self.id+stagePosWeight.assist)
if assist then
assist:onDead()
end

self:removeAllOutEffect()


if self:isLeft()and self.isNPC==nil then
local dizitemp={}
local diziInfo=self.baseInfo
if diziInfo.typo==fightEntityType.diZi then
if diziInfo.diziId and diziInfo.cvId then
dizitemp[#dizitemp+1]={diziId=diziInfo.diziId,cvId=diziInfo.cvId,jobid=diziInfo.image.job,disguise=diziInfo.disguise}
end
end

roleAudioController:fightingRoleSpeak(dizitemp,roleAudioNodeType.Fight_ShiWan)
end

end

function fightEntity:setPassiveResurrenttion(skillid)
self.setResurrentSkill=skillid
end


function fightEntity:getSelfGuid()
return self.guid
end

local defaultSuccessBehavior={
"fight_success_biaoqing",
"fight_success"
}

function fightEntity:getSuccessBehavior()
if self.bodyID~=nil then
local cfg=cfgHelper.get1(cfg_fightcompletebehaviorcfg_get,self.bodyID)
if cfg~=nil then
return cfg.btOnSccees1 or defaultSuccessBehavior[1],cfg.btOnSccees2 or defaultSuccessBehavior[2]
end
end

return defaultSuccessBehavior[1],defaultSuccessBehavior[2]
end

function fightEntity:onFightSuccess(behavior)
if behavior~=nil then
self:runBehavior(behavior,{},nil)
end
if self.baseInfo.image and self.baseInfo.image.sex==SEX_TYPE.eFeMale then
self:showExpression(eBiaoQing.haiXiu,math.random(40,100)*0.1)
else
self:showExpression(eBiaoQing.kaiXin,math.random(40,100)*0.1)
end
end




function fightEntity:flushBuff()
if self.hud then
self.hud:flushBuff(self.buff)
end
if self.refreshShenShiHUD then
self:refreshShenShiHUD()
end
end

function fightEntity:getDiZiId()
if self.baseInfo.typo==fightEntityType.diZi then
return self.baseInfo.diziId
end
end


local demageExpresion={eBiaoQing.siWan,eBiaoQing.shouShang,eBiaoQing.aiShang,eBiaoQing.daiZhi}
function fightEntity:randExpression(duration)

self:showExpression(demageExpresion[math.random(1,4)],duration)
end

local stateIDEvent={
[eAnimationID.hit]=function(ent)
ent:randExpression(0.45)
end
}

function fightEntity:runAnimator(stateID,speed)

if self:haveAnimExculdeModel()then
return
end
if self.entObj then
local func=stateIDEvent[stateID]
if func~=nil then
func(self)
end
self.entObj:RunAnimator(stateID,speed or 1)
end
end



function fightEntity:getFightInfo()
local info={}
info.name=self.name
info.attack=self.totalAttack
info.defend=self.totalDefend
info.cue=self.totalCue
info.treated=self.totalTreated
info.attr=self.baseInfo.rawAttr
return info
end

function fightEntity:getHpInfo()
local hp=self:getAttribute(entityAttr.hp)
local maxhp=self:getAttribute(entityAttr.max_hp)
return FMT.fmt("[{0}][位置{1}][{1}:{2}]",self.name,self.id,hp,maxhp)
end









function fightEntity:getPosOffset()
return fBTHelper.posOffset
end

function fightEntity:isShowHUD()
if self.battle then
return self.battle.isShowWindow
end
return true
end

function fightEntity:logName()
return FMT.fmt("[{0}][位置{1}]",self.name,self.id)
end

function fightEntity:initBuffBehave()
for t,v in pairs(eFightBuffBehave)do
self.buffBehaveList[v]={}
end
end

function fightEntity:updateBuffBehave(buffGuid)
for i,list in pairs(self.buffBehaveList)do
if next(list)~=nil then
for ii=#list,1,-1 do
if list[ii].guid==buffGuid then
self.lastBuffBehave[i]=list[ii].id
table.remove(list,ii)
end
end
self.buffBehaveList[i]=list
end
end
end

function fightEntity:getBuffBehave(behaveType,buffGuid)
local list=self.buffBehaveList[behaveType]
if list and next(list)~=nil then
for i=#list,1 do
if list[i].guid==buffGuid then
return list[i]
end
end
end
end

function fightEntity:isBehaveBuff(buffGuid)
for i,list in pairs(self.buffBehaveList)do
if next(list)~=nil then
for i=#list,1 do
if list[i].guid==buffGuid then
return true
end
end
end
end
end

function fightEntity:setBuffBehave(behaveType,buffGuid,data)
local list=self.buffBehaveList[behaveType]
if list and next(list)~=nil then
for i=#list,1 do
if list[i].guid==buffGuid then
list[i]=data
end
end
end

end

function fightEntity:onAddBuffBehave(waitTime)
local list=nil
for t,v in pairs(eFightBuffBehave)do
list=self.buffBehaveList[v]
if next(list)~=nil then
if list[1].priority then
local lastData=list[#list]
for i=#list,1 do
if list[i].priority>lastData.priority then
lastData=list[i]
end
end
fightBuffBehave.exeBuffBehave(v,{ent=self,buffInfo=lastData,waitTime=waitTime})
else
local lastData=list[#list]
fightBuffBehave.exeBuffBehave(v,{ent=self,buffInfo=lastData,waitTime=waitTime})
end
end
end
end

function fightEntity:onRemoveBuffBehave(waitTime)
local list=nil
for t,v in pairs(eFightBuffBehave)do
list=self.buffBehaveList[v]
if next(list)~=nil then

if list[1].priority then
local lastData=list[#list]
for i=#list,1 do
if list[i].priority>lastData.priority then
lastData=list[i]
end
end
fightBuffBehave.exeBuffBehave(v,{ent=self,buffInfo=lastData,waitTime=waitTime})
else
local lastData=list[#list]
fightBuffBehave.exeBuffBehave(v,{ent=self,buffInfo=lastData,waitTime=waitTime})
end
else

fightBuffBehave.exeBuffBehave(v,{ent=self,buffInfo=nil,waitTime=waitTime})
end
end
end

function fightEntity:rebulidBuffBehave()
self:onRemoveBuffBehave(0)
end

function fightEntity:haveAnimExculdeModel()
if self.buffAnimModelList then
for i,v in pairs(self.buffAnimModelList)do
for _,v2 in ipairs(v)do
if self.model.body==v2 then
return true
end
end
end
end
return false
end


function fightEntity:showEntityEffect()
if self.buffEffect~=nil then
for guid,data in pairs(self.buffEffect)do
if data.effectData then
if data.handle then
stopEffect(data.handle)
end
local offset=Vector3.zero
if data.effectData[4]and data.effectData[5]then
offset=Vector3.New(data.effectData[4],data.effectData[5],0)
end
local handle=self:playEffect(data.effectData[1],offset,true,false)
data.handle=handle
end
end
end
self:activeOutEffect(true,true)
end

function fightEntity:stopEntityEffect()
if self.buffEffect~=nil then
for guid,data in pairs(self.buffEffect)do
if data.handle then
stopEffect(data.handle)
data.handle=nil
end
end
end
self:activeOutEffect(false,true)
end

function fightEntity:changeATKPoint(pointId,count)
self.counterAttackList[pointId]=count
end

function fightEntity:getATKPointById(pointId)
return self.counterAttackList[pointId]or 0
end

function fightEntity:getATKPoint()
return self.counterAttackList or{}
end


function fightEntity:flushATKPoint()
if self.hud then
return self.hud:flushCounterAtkPoint(self.counterAttackList)
end
end


function fightEntity:setTempLingShouFlag(isTemp)
self.isTempLingShou=isTemp
end


function fightEntity:checkIsTempLingShou()
if self.isAssistant and self.assistantType==fightAssistantType.eLingShou then

if self.isTempLingShou then

return true
end
end
return false
end


function fightEntity:setSummonLingShouFlag(isSummon)
self.isSummonLingShou=isSummon
end


function fightEntity:checkIsSummonLingShou()
if self.isAssistant and self.assistantType==fightAssistantType.eLingShou then

if self.isSummonLingShou then

return true
end
end
return false
end


function fightEntity:checkIsLingShou()
if self.isAssistant and self.assistantType==fightAssistantType.eLingShou then

return true
end
return false
end

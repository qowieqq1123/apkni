






def_class('fightCardGPAction',fightBaseAction)

local exeActionType=
{
playEffect=1,
refreshHud=2,
}


function fightCardGPAction:__init()
self.typo=fightActionType.FIGHT_LOG_CARD_GP
end

function fightCardGPAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()

self.dstID=_rawData[2]
self.card=_rawData[3]

self.rawData=_rawData
self.isComplete=false
self.delayTime=0
self.isDead=false
self.isFail=nil
end


function fightCardGPAction:exe()

local ent=self.battle:getEntity(self.dstID)
local cardList=ent:getHuaSeList()

local gangPai=self.card

if ent then
local i,card=next(cardList)
if card and gangPai==card then
self.newCard=card
table.insert(cardList,4,card)
ent:changeHuaSe(cardList)

ent:runBehavior("gang_pai_success",{},function(state,id)
self:onBehaviorEvent(state,id)
end)
self.isComplete=false
else
self.newCard=gangPai
ent:changeHuaSe({gangPai})

ent:runBehavior("gang_pai_fail",{},function(state,id)
self:onBehaviorEvent(state,id)
end)

self.isFail=true
self.isComplete=false
end

else
self.isComplete=true
end

self.delayTime=10
self.isExe=true
self.activeState=0

end

function fightCardGPAction:onBehaviorEvent(state,args)

if fBTEvent.BehaviorFinish==state then
if self.activeState==0 then
self:exeActions(args)
end
self.isComplete=true
elseif fBTEvent.ActiveSkillActions==state then
self.activeState=args
self:exeActions(args)
end
end

function fightCardGPAction:exeActions(args)
if args==exeActionType.playEffect then
self:playEffect()
elseif args==exeActionType.refreshHud then
self:freshHUD()
end
end

function fightCardGPAction:freshHUD()
local ent=self.battle:getEntity(self.dstID)
if ent then
ent:refreshHuaSeHUD()
end
end

function fightCardGPAction:playEffect()
local ent=self.battle:getEntity(self.dstID)
if ent then
local effectid=cfgHelper.get(cfg_skillhsconfig_get,self.newCard,"anim")
ent:flowText(flowObjTypo.effect,{nunPara=effectid,offset=Vector3.New(0,-90,0),scale=Vector3.one,stayTime=5,attach=true,scale=Vector3.New(75,75,75)})
end
end

function fightCardGPAction:logExe(logContent)
local ent=self.battle:getEntity(self.dstID)
logContent(FMT.fmt('{0}杠牌 {1}',ent:logName(),self.card))
self.isComplete=true
end

function fightCardGPAction:statisticsExe()

end

function fightCardGPAction:update(deltaTime)


if self.isExe then
self.delayTime=self.delayTime-deltaTime
if self.delayTime<0 then
self.isComplete=true
end
end

return self.isComplete
end

function fightCardGPAction:onDespwan()
self.round=nil
self.battle=nil
self.isExe=nil
self.rawData=nil
self.isComplete=false
self.isFail=nil
fightActionMrg:recycleAction(self)
end
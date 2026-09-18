






def_class('fightCardChangeAction',fightBaseAction)

local exeActionType=
{
playEffect=1,
refreshHud=2,
}

function fightCardChangeAction:__init()
self.typo=fightActionType.FIGHT_LOG_CARD_CHANGE
end


function fightCardChangeAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]
self.cardList=_rawData[3]

self.rawData=_rawData
self.isComplete=false
self.delayTime=0
self.isExe=nil

local ent=self.battle:getEntity(self.dstID)
if ent:getSPHUDType()~=1 then
ent:setSPHUDType(1)
end
end


function fightCardChangeAction:exe()

self.isExe=true
self.isFadeHUD=nil

local cardList=self.cardList
local ent=self.battle:getEntity(self.dstID)
local newCard=cardList[#cardList]


if ent then

local oriList=ent:getHuaSeList()
if table.equals(oriList,cardList)then
self.isComplete=true
else
local lenOri=#oriList

if lenOri>=3 then
for i,v in ipairs(cardList)do
if oriList[i]~=v then
newCard=v
break
end
end
end

ent:changeHuaSe(cardList)
if newCard then
self.newCard=newCard

if ent.hud:getFadeTarget()==0 then
ent.hud:fade(0.2,1)
self.isFadeHUD=true
end


ent:runBehavior("mo_pai",{},function(state,id)
self:onBehaviorEvent(state,id)
end)
self.isComplete=false
else

ent:refreshHuaSeHUD()
self.isComplete=true
end
end
else
self.isComplete=true
end

self.delayTime=10




end

function fightCardChangeAction:freshHUD()
local ent=self.battle:getEntity(self.dstID)
if ent then
ent:refreshHuaSeHUD()
end
end

function fightCardChangeAction:logExe(logContent)
local ent=self.battle:getEntity(self.dstID)

logContent(FMT.fmt('{0}花牌变化为{{1}}',ent:logName(),table.concat(self.cardList,',')))
self.isComplete=true
end

function fightCardChangeAction:statisticsExe()

end

function fightCardChangeAction:exeActions(args)
if args==exeActionType.playEffect then
self:playEffect()
elseif args==exeActionType.refreshHud then
self:freshHUD()
end
end

function fightCardChangeAction:playEffect()
local ent=self.battle:getEntity(self.dstID)
if ent then
local effectid=cfgHelper.get(cfg_skillhsconfig_get,self.newCard,"anim")

ent:flowText(flowObjTypo.effect,{nunPara=effectid,offset=Vector3.New(0,-90,0),scale=Vector3.one,stayTime=5,attach=true,scale=Vector3.New(75,75,75)})
end
end

function fightCardChangeAction:onBehaviorEvent(state,args)

if fBTEvent.BehaviorFinish==state then
self:exeActions(args)
self.isComplete=true

elseif fBTEvent.ActiveSkillActions==state then
self:exeActions(args)
end
end

function fightCardChangeAction:update(deltaTime)

if self.isExe then




end

return self.isComplete
end

function fightCardChangeAction:onDespwan()
self.round=nil
self.battle=nil
self.delayTime=nil
self.rawData=nil
self.isComplete=false
self.teamType=nil
self.num=nil
self.nownum=nil
self.isExe=nil
fightActionMrg:recycleAction(self)
end
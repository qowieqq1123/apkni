







def_class("UITianMoJieEventWin",UIWindowBase)









function UITianMoJieEventWin:bindComponents()

self.effect1=UIObject.get(self,0)
self.effect2_1=UIObject.get(self,1)
self.effect2_2=UIObject.get(self,2)
self.effect2_3=UIObject.get(self,3)
self.effect3=UIObject.get(self,4)
self.flowRoot=UIObject.get(self,5)
self.flowTx=UIText.get(self,6)
self.progressHandle=UIObject.get(self,7)
self.progressSp=UIObject.get(self,8)
self.progressTx=UIText.get(self,9)
self.reddot=UIObject.get(self,10)
self.effect2={
self.effect2_1,
self.effect2_2,
self.effect2_3,
}



end


function UITianMoJieEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2_1);self.effect2_1=nil;
_UIObject_release(self.effect2_2);self.effect2_2=nil;
_UIObject_release(self.effect2_3);self.effect2_3=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.flowRoot);self.flowRoot=nil;
_UIObject_release(self.flowTx);self.flowTx=nil;
_UIObject_release(self.progressHandle);self.progressHandle=nil;
_UIObject_release(self.progressSp);self.progressSp=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.reddot);self.reddot=nil;
self.effect2=nil;
end















local _this=nil

local _effect2Offset={{-10,0},{0,-5},{10,0}}

local _effect2WayMid={
{{-100,0,0,0},{-100,0,0,1}},
{{50,50,0,0},{50,-50,0,1}},
{{100,0,0,0},{100,0,0,1}},
}



function UITianMoJieEventWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(34,121,self.on_34_121)
self:addProNotify(34,124,self.on_34_124)
self:addNotify(notifyConfig.onTianMoJieStageChange,self.onTianMoJieStageChange)
self:addNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
end


function UITianMoJieEventWin:__delete()
self:unbindComponents()
_this=nil

if self.tweener and self.tweener:IsActive()then
self.tweener:Kill()
end

if self.deadBt then
local sfId=self.deadBt:getSharedVar('sfId')
local monsterGuid=self.deadBt:getSharedVar('monsterGuid')
if tianMoJieController:haveEntity(sfId,monsterGuid)then
tianMoJieController:deleteEntity(sfId,monsterGuid)
end
behaviorManager:removeBehaviorTree(self.deadBt)
self.deadBt=nil
end
end




function UITianMoJieEventWin:onShow(argtable,afterOnloaded)
self:refreshView()
self:refreshReddot()

self:showTips()
self:showDeadAnimation()
end


function UITianMoJieEventWin:onHide()

end



function UITianMoJieEventWin:refreshView()
local stageCfg=cfg_tianmojiestageconfig()
local stage=tianMoJieModel:getStage()
stage=Mathf.Clamp(stage,1,#stageCfg)
local score=tianMoJieModel:getScore()
local last=stageCfg[stage-1]and stageCfg[stage-1].score or 0
local cur=Mathf.Clamp(score,0,stageCfg[stage].score)-last
local max=stageCfg[stage].score-last
local progress=cur/max
local rad=math.rad(90-progress*360)
local x=math.cos(rad)*26
local y=math.sin(rad)*26-2
self.progressSp:setChildIconFillAmount(progress)
self.progressTx:setText(stage)
self.progressHandle:setChildAnchoredPos(x,y)




end

function UITianMoJieEventWin:showAnimation()
local anim=tianMoJieModel:getEnterAnim()
if anim then
local actorID=playerModel:getActorID()
local entityDatas=tianMoJieController:getMountainEntityList(mapIdType.zhufeng)
for guidStr,entityData in pairs(entityDatas)do
if entityData.entityGuid==nil or entityData.hudGuid==nil or entityData.bloodGuid==nil then
self:delayDo(1,function()
self:showAnimation()
end)
return
end
end

local args={
sfId=zongmenModel:getMountainId(),
}
local index=1
for guidStr,entityData in pairs(entityDatas)do
args[FMT.fmt("guid{0}",index)]=entityData.entityGuid
args[FMT.fmt("hudGuid{0}",index)]=entityData.hudGuid
args[FMT.fmt("bloodGuid{0}",index)]=entityData.bloodGuid
args[FMT.fmt("data{0}",index)]=entityData.monsterGuid
if index==1 then
local tf=_MapManager.GetTilemapObjectTransform(entityData.entityGuid)
args.lookat={tf.position.x,tf.position.y}
end
index=index+1
end
behaviorManager:addBehaviorTree("ai_tianmojie_open",nil,true,args)
tianMoJieModel:clearEnterAnim()
end
end

function UITianMoJieEventWin:showTips()
local stage=tianMoJieModel:getStage()
local config=cfgHelper.get1(cfg_tianmojiestageconfig_get,stage)
if config and config.tips then
local anim=tianMoJieModel:getAnimData()
if not anim.finish then
UIManager:showWindow("UITianMoJieNextStageWin")
end
end
end

function UITianMoJieEventWin:refreshReddot()
local subClass=JiuChongTianJieEnterModel:getSubSysClass(JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie)
local reddot=subClass:getReddot(true)
self.reddot:setActive(reddot)
end

function UITianMoJieEventWin:synchronousEffectPosition(bt)
local hudGuid=bt:getSharedVar("bloodGuid")
local widget=hudControl:getHUDWidget(hudGuid)
local uiScreenPos=widget:GetChildUIScreenPos(0,true)
local pos=self.effect1:getChildUIScreenPos2Local(uiScreenPos)
self.effect1:setChildAnchoredPosition(pos)

pos=self.effect1:getChildLocalPosition()
for i,v in ipairs(self.effect2)do
local key=FMT.fmt("effectWay{0}",i)
local wayMid=_effect2WayMid[i]or{}
local offset=_effect2Offset[i]or{0,0}
local since=Vector3.New(pos.x+offset[1],pos.y+offset[2],0)
local target=self.effect3:getChildLocalPosition()
local ways={}
table.insert(ways,{since.x,since.y,since.z})
table.insert(ways,{target.x,target.y,target.z})
for j,w in ipairs(wayMid)do



local point=target*w[4]+since*(1-w[4])
table.insert(ways,{w[1]+point.x,w[2]+point.y,w[3]+point.z})
end
bt:setSharedVar(key,ways)
end
end

function UITianMoJieEventWin:showDeadAnimation()
local monsterData=tianMoJieController.deadData
if monsterData then
local entityData=tianMoJieController:getEntity(mapIdType.zhufeng,monsterData.guid)
if entityData then
local config=cfgHelper.get1(cfg_tianmojiemonconfig_get,monsterData.id)
local btArgs={
showEffect=true,
winlua=self.winlua,
flowRoot=self.flowRoot:getID(),
flowTx=self.flowTx:getID(),
scoreStr=FMT.fmt("魔劫积分 +{0}",config.score),
effect1=self.effect1:getID(),
effect3=self.effect3:getID(),
entityGuid=entityData.entityGuid,
sfId=mapIdType.zhufeng,
monsterGuid=entityData.monsterGuid,
bloodGuid=entityData.bloodGuid,
}
for i,v in ipairs(self.effect2)do
local key=FMT.fmt("effect2_{0}",i)
btArgs[key]=v:getID()
end
self.deadBt=behaviorManager:addBehaviorTree("ai_tianmojie_dead",nil,true,btArgs,true)
end
tianMoJieController.deadData=nil
end
end

function UITianMoJieEventWin:onFinishDead(bt)
self.deadBt=nil
end





































function UITianMoJieEventWin:onJumBtn()
UIFullTianMoJieControl:showMainWin()
end

function UITianMoJieEventWin.on_34_121()
if _this==nil then return end
_this:refreshView()
end

function UITianMoJieEventWin.onTianMoJieStageChange()
if _this==nil then return end
_this:showTips()
_this:refreshReddot()
end

function UITianMoJieEventWin.onTYTXZRewardChange(tzxGuid)
if _this==nil then return end
local txzId=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,"passport")
local txzData=UITYTongXingZhengModel:getDataByGuid(tzxGuid)
if txzId==txzData.txzId then
_this:refreshReddot()
end
end

function UITianMoJieEventWin.on_34_124()
if _this==nil then return end
_this:refreshReddot()
end
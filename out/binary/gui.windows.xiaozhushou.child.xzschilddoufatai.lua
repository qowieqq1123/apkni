







def_class("xzsChildDouFaTai",UICloneObject)





xzsChildDouFaTai.abName="ui/windows/xiaozhushou/child/xzschilddoufatai.ab"

xzsChildDouFaTai.assetName="xzsChildDouFaTai"


function xzsChildDouFaTai:bindComponents()

self.doingText=UIText.get(self,0)
self.finishPanel=UIObject.get(self,1)
self.finishText=UIText.get(self,2)
self.icon=UIImage.get(self,3)
self.progress=UIProgressBarAni.get(self,4)
self.title=UIText.get(self,5)

end


function xzsChildDouFaTai:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.finishPanel);self.finishPanel=nil;
_UIObject_release(self.finishText);self.finishText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.title);self.title=nil;
end








local _this=nil

function xzsChildDouFaTai:onLoaded(...)
self:bindComponents()
_this=self
end


function xzsChildDouFaTai:__delete()
self:stopFightTimer()
self:unbindComponents()
_this=nil
end




function xzsChildDouFaTai:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
local orderID=argtable.orderID
self.orderID=orderID
self.isWaittingFightEnd=nil
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self:startFightAI(orderID)
end


function xzsChildDouFaTai:onHide()
self:stopFightTimer()
end

function xzsChildDouFaTai:onFinish(result,name)
self.progress:setActive(false)
self.finishPanel:setActive(true)
self.finishText:setActive(true)
local wendao=douFaTaiModel:get_doufatai_wendao()
if result==fightResultType.Victory then
self.finishText:setText(FMT.fmt("已自动挑战<color=#ca631d>{0}</color>，挑战胜利，获得<color=#ca631d>{1}</color>积分，当前积分<color=#ca631d>{2}</color>",name,wendao-self.startScore,wendao))
else
self.finishText:setText(FMT.fmt("已自动挑战<color=#ca631d>{0}</color>，挑战失败，已停止自动挑战，当前积分<color=#ca631d>{1}</color>",name,wendao))
end

douFaTaiController:updateAutoFight(self.orderID,result)
end

function xzsChildDouFaTai:onFinishErr()
self.progress:setActive(false)
self.finishPanel:setActive(true)
self.finishText:setActive(true)
self.finishText:setText(FMT.fmt("挑战超时，已停止自动挑战"))
douFaTaiController:updateAutoFight(self.orderID,false)
end

function xzsChildDouFaTai:startFightTimer()
local updateFunc=function()
self:onSlowUpdate(1)
end
self.updateTimer=self:setTimer(1,0,updateFunc)
end

function xzsChildDouFaTai:stopFightTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
self.isWaittingFightEnd=nil
end

function xzsChildDouFaTai:startFightAI()
self.progress:setActive(true)
self.progress:animate(0)

self.finishPanel:setActive(false)

self.startScore=douFaTaiModel:get_doufatai_wendao()

self:startFightTimer()

self.progress:animateFiveParams(0,100,100,3)
self.doingText:setText("正在完成斗法台挑战......")

self.overTime=0
end

function xzsChildDouFaTai:onSlowUpdate(delay)

self.overTime=self.overTime+delay
if self.overTime>=10 then
self:stopFightTimer()
self:onFinishErr()
return
end



if douFaTaiController.isWaittingRefreshActor then return end

if self.isWaittingFightEnd then return end


local robotType,actor,isNianYa,name=self:getFightActor()

if actor then
if isNianYa then
douFaTaiController:req_17_14(1,robotType,actor,1,function()
if not _this then return end

douFaTaiController:req_select_actor()
self.progress:animateTwoParams(100,100)

self:stopFightTimer()
self:onFinish(fightResultType.Victory,name)
end)
self.isWaittingFightEnd=true

else
local waitting=douFaTaiController:skipFight(actor,robotType,function(param,result,prizeList)
if not _this then return end


douFaTaiController:req_select_actor()

self:stopFightTimer()
self:onFinish(result,name)
end)
if waitting==0 then

self.isWaittingFightEnd=true
end
end

end

end

function xzsChildDouFaTai:getFightActor()
local actorList=douFaTaiModel:getPiPeiActorList()or{}

local setupData=xiaoZhuShouModel:getSetupData(XIAOZHUSHU_ENUM.xzs_DouFaTai)
local isSelectScore=setupData[xzsDataKey.dftSelectActor]==2
local robotType,actorId,fight,name
local compareVal
if isSelectScore then
for i,v in pairs(actorList)do
if not compareVal or v.wendao>compareVal then
compareVal=v.wendao
robotType=v.robotType
actorId=v.actorId
fight=v.fight
name=v.name
end
end
else
for i,v in pairs(actorList)do
if not compareVal or v.fight<compareVal then
compareVal=v.fight
robotType=v.robotType
actorId=v.actorId
fight=v.fight
name=v.name
end
end
end

local isNianYa=false
if fight and robotType==4 then
local playerFight=playerModel:getActorFightValue()
local nianyaFight=cfgHelper.get(cfg_doufataibasicconfig_get,1,"neednt_battle_rate")
if(playerFight-fight)/fight>=nianyaFight/100 then
isNianYa=true
end
end

return robotType,actorId,isNianYa,name
end












def_class("UIMoJieMoJunBoxInfoWin",UIWindowBase)









function UIMoJieMoJunBoxInfoWin:bindComponents()

self.background=UIButton.get(self,0)
self.getBtn=UIButton.get(self,1)
self.rewardList=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.spine=UIObject.get(self,4)
self.spine2=UIObject.get(self,5)
self.timeTxt=UIText.get(self,6)
self.ycj=UIObject.get(self,7)

self.background:setButtonClick(function()self:onBackground()end)

self.getBtn:setButtonClick(function()self:onGetBtn()end)



end


function UIMoJieMoJunBoxInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.getBtn);self.getBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.spine2);self.spine2=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.ycj);self.ycj=nil;
end
















local _this



function UIMoJieMoJunBoxInfoWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(39,22,self.on_39_22)
end

function UIMoJieMoJunBoxInfoWin.on_39_22(seasonType,stageIndex,boxId,startTime,finish)
_this:refreshInfo(boxId)
end


function UIMoJieMoJunBoxInfoWin:__delete()
self:unbindComponents()

_this=nil
end




function UIMoJieMoJunBoxInfoWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.boxId=argtable.boxId

self:refreshInfo(self.boxId)

local nowTime=timeHelper.getServerShortTime()
local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
local endTime=mojunData.killTime+cfg.boxDuration
if endTime>nowTime then
self.endTime=endTime

self:setRemainingTimeTimer()
else
self:clearTimer()
end
local data=xianjieModel:getMoJunBoxEntityData(self.seasonType,self.stageIndex,self.boxId)
local isCaiJi=data.startTime>0 and data.finish==0
self.root:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(6275,1,{},eAnimationID.enter,false,false,0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
if isCaiJi then
self.spine2:setChildUIModelShowTarget(6276,1,{},eAnimationID.enter,false,false,0)
end
end)
end


function UIMoJieMoJunBoxInfoWin:refreshInfo(boxId)
if boxId~=self.boxId then return end
local data=xianjieModel:getMoJunBoxEntityData(self.seasonType,self.stageIndex,self.boxId)
local isShow=data.startTime==0
local isYlq=not isShow and data.finish==1
self.getBtn:setActive(not isYlq)
self.getBtn:setGray(not isShow)
self.ycj:setActive(isYlq)

local isCaiJi=data.startTime>0 and data.finish==0
self.spine2:setActive(isCaiJi)

local items=cfgHelper.get2(cfg_seasonmojunboxconfig_get,self.boxId,"items")
self.rewardList:setChildLayoutGroupCreateItems(#items)
local grids=self.rewardList:getChildLayoutGroupGridList()
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=items[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end


function UIMoJieMoJunBoxInfoWin:onHide()

end

function UIMoJieMoJunBoxInfoWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,
showModel=true,})
end


function UIMoJieMoJunBoxInfoWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=self.endTime-nowTime
if lerp>0 then

self.timeTxt:setText(FMT.fmt("魔君宝箱<color=#f1ce78>{0}</color>后消失",timeHelper.format_time_stamp16(lerp)))
else
self:onCloseBtn()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIMoJieMoJunBoxInfoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end






function UIMoJieMoJunBoxInfoWin:onBackground()
self:onCloseBtn()
end



function UIMoJieMoJunBoxInfoWin:onGetBtn()
local mojunData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
local data=xianjieModel:getMoJunBoxEntityData(self.seasonType,self.stageIndex,self.boxId)
if data.startTime~=0 then
return UIManager.error("已有队伍前往采集")
end
if mojunData.timeType==4 then
local cTime=gameUtilityModel.getServerShortTime2()
local speed=xianjieModel:getMoJunBoxTeamSpeed()
local wayTime=data:getBaseWayTime(speed)
if cTime+wayTime+10>=mojunData.endTime then
return UIManager.error("宝箱即将消失，无法采集")
end
else
return UIManager.error("不在魔君宝箱采集阶段")
end




local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount
if freeTeamCount<=0 then

local unlockTeamCount=xianjieModel:getWaiPaiTeamUnlockNum()
local maxExtraTeamCount=xianjieModel:getWaiPaiTeamMaxExtraNum()
if unlockTeamCount<maxExtraTeamCount then

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

self:showWindow('UICommonPageWin',args)
end

return UIManager.error("当前没有空闲行军队列")
end
xianjieController:reqMoJunBoxCaiJi(self.seasonType,self.stageIndex,self.boxId)
self:onCloseBtn()
end

function UIMoJieMoJunBoxInfoWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

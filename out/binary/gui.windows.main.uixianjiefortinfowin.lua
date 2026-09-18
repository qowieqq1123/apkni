







def_class("UIXianJieFortInfoWin",UIWindowBase)









function UIXianJieFortInfoWin:bindComponents()

self.infoGrid=UIObject.get(self,0)
self.layout=UIObject.get(self,1)



end


function UIXianJieFortInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoGrid);self.infoGrid=nil;
_UIObject_release(self.layout);self.layout=nil;
end


















local _abName="ui/windows/main/xianjiefortinfo_atlas_pak.ab"
local _itemCmpIndex={
icon=0,
nameObj=1,
name=2,
progressbar=3,
descObj=4,
desc=5,
jumpBtn=6,
rewardBtn=7,
rewardFlag=8,
completeFlag=9,
}

function UIXianJieFortInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieFortInfoWin:__delete()
self:unbindComponents()
end

function UIXianJieFortInfoWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end




function UIXianJieFortInfoWin:onShow(argtable,afterOnloaded)
self:checkInfoListPanelShow()
self:onShowArgRecv()
end

function UIXianJieFortInfoWin:onShowArgRecv()
self.infos=xianJieFortInfoController:getAllInfo()
self:refreshInfoView()
end

function UIXianJieFortInfoWin:refreshInfoView()
self:clearRewardBoxTweener()
self.updateList={}
self.infoGrid:setChildLayoutGroupCreateItems(#self.infos,function(index)
local info=self.infos[index]
local widget=self.infoGrid:getChildLayoutGroupGridItem(index-1)
local infoIcon=info.infoIcon~=nil and info.infoIcon or xianJieFortInfoController:getInfoIcon(info.type)
widget:SetChildCSImageSprite(_itemCmpIndex.icon,_abName,infoIcon)
widget:SetChildText(_itemCmpIndex.name,info.name)
if info.sTime and info.eTime then
table.insert(self.updateList,index)
widget:SetChildActive(_itemCmpIndex.progressbar,true)
local nowTime=timeHelper.getServerShortTime()
local passTime=nowTime-info.sTime
local needTime=info.eTime-info.sTime
widget:SetChildProgressValue(_itemCmpIndex.progressbar,passTime,needTime)
local leftTime=info.eTime-nowTime
local time_str=timeHelper.format_time_stamp(leftTime,true)
widget:SetChildProgressText(_itemCmpIndex.progressbar,time_str)
elseif info.progress then
widget:SetChildActive(_itemCmpIndex.progressbar,true)
local cur,max=unpack(info.progress)
widget:SetChildProgressValue(_itemCmpIndex.progressbar,cur,max)
widget:SetChildProgressText(_itemCmpIndex.progressbar,string.format("%d/%d",cur,max))
else
widget:SetChildActive(_itemCmpIndex.progressbar,false)
end
if info.desc then
widget:SetChildActive(_itemCmpIndex.descObj,true)
widget:SetChildText(_itemCmpIndex.desc,info.desc)
else
widget:SetChildActive(_itemCmpIndex.descObj,false)
end
widget:SetChildButtonClick(_itemCmpIndex.jumpBtn,function()
self:onClickInfo(info.type,info.jumpAttach)
end)
widget:SetChildButtonClick(_itemCmpIndex.rewardBtn,function()
self:onClickInfo(info.type,info.jumpAttach)
end)
if info.rewardBox then
widget:SetChildActive(_itemCmpIndex.rewardBtn,true)
self:doPunchRotation(widget,_itemCmpIndex.rewardBtn)
else
widget:SetChildActive(_itemCmpIndex.rewardBtn,false)
end
widget:SetChildActive(_itemCmpIndex.rewardFlag,info.rewardBox==true)

end)
if#self.updateList>0 then
self:clearUpdateTimer()
self.updateTimer=self:setTimer(1,0,function()
self:updateInfoView()
end)
end
end

function UIXianJieFortInfoWin:updateInfoView()
local needRefresh=false
for _,index in ipairs(self.updateList)do
local widget=self.infoGrid:getChildLayoutGroupGridItem(index-1)
local info=self.infos[index]
local nowTime=timeHelper.getServerShortTime()
local passTime=nowTime-info.sTime
local needTime=info.eTime-info.sTime
widget:SetChildProgressValue(_itemCmpIndex.progressbar,passTime,needTime)
local leftTime=info.eTime-nowTime
local time_str=timeHelper.format_time_stamp(leftTime,true)
widget:SetChildProgressText(_itemCmpIndex.progressbar,time_str)
if leftTime<=0 then
needRefresh=true
break
end
end
if needRefresh then
self:onShowArgRecv()
end
end

function UIXianJieFortInfoWin:doPunchRotation(widget,index)

widget:SetChildLocalPosX(index,296)
local idx=#self.tweenerList+1
self.tweenerList[idx]=widget:SetChildDOLocalMoveX(index,285,0.8)
self.tweenerList[idx]:SetEase(_Ease.OutQuad)
self.tweenerList[idx]:SetLoops(-1,_LoopType.Yoyo)
end

function UIXianJieFortInfoWin:clearRewardBoxTweener()
for i,v in ipairs(self.tweenerList or{})do
v:Kill()
end
self.tweenerList={}
end

function UIXianJieFortInfoWin:onClickInfo(type,jumpAttach)
xianJieFortInfoController:jumpInfo(type,jumpAttach)
end

function UIXianJieFortInfoWin:showInfoListPanel(isInit)
if self.isShowInfoList then
return
end

self:clearShowPanelTweener()
local endVal=0
if isInit then
self.winlua:SetChildAnchoredPos(self.layout:getID(),endVal,0)
else
self.winlua:SetChildAnchoredPos(self.layout:getID(),-450,0)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end
self.isShowInfoList=true
end

function UIXianJieFortInfoWin:hideInfoListPanel(callBack)
if not self.isShowInfoList then
return
end

self:clearShowPanelTweener()
local endVal=-450
self.winlua:SetChildAnchoredPos(self.layout:getID(),0,0)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3,callBack)
self.isShowInfoList=false
end

function UIXianJieFortInfoWin:checkInfoListPanelShow()
self:clearShowPanelTweener()
local state=simpleModeControl:getLeftSimple()
local state2=simpleModeControl:getFortLeftSimple()
self.isShowInfoList=state==leftSimpleState.task and state2==leftFortSimpleState.fort
local endVal=self.isShowInfoList and 0 or-450
self.winlua:SetChildAnchoredPos(self.layout:getID(),endVal,0)
end

function UIXianJieFortInfoWin:clearShowPanelTweener()
if self.showPanelTweener~=nil then
self.showPanelTweener:Kill()
self.showPanelTweener=nil
end
end
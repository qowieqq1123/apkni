







def_class("xzsChildXianWuLou2",UICloneObject)





xzsChildXianWuLou2.abName="ui/windows/xiaozhushou/child/xzschildxianwulou2.ab"

xzsChildXianWuLou2.assetName="xzsChildXianWuLou2"


function xzsChildXianWuLou2:bindComponents()

self.doingText=UIText.get(self,0)
self.errorPanel=UIObject.get(self,1)
self.errorTxt=UIText.get(self,2)
self.icon=UIImage.get(self,3)
self.infoDescTxt=UIText.get(self,4)
self.infoPanel=UIObject.get(self,5)
self.progress=UIProgressBarAni.get(self,6)
self.rewardGridList=UIObject.get(self,7)
self.rewardPanel=UIObject.get(self,8)
self.title=UIText.get(self,9)

end


function xzsChildXianWuLou2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorPanel);self.errorPanel=nil;
_UIObject_release(self.errorTxt);self.errorTxt=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.infoDescTxt);self.infoDescTxt=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardGridList);self.rewardGridList=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
end






local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"


function xzsChildXianWuLou2:onLoaded(...)
self:bindComponents()
self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)
self._onXianWuLouReward=function(...)
self:onXianWuLouReward(...)
end
self:addNotify(notifyConfig.onXianWuLouReward,self._onXianWuLouReward)
end


function xzsChildXianWuLou2:__delete()
self:unbindComponents()
end


function xzsChildXianWuLou2:onHide()

end




function xzsChildXianWuLou2:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

self.state=argtable.state
if self.state==-1 then
self.infoPanel:setActive(false)
self.rewardPanel:setActive(false)
self.progress:setActive(false)
self.errorPanel:setActive(true)
self.errorTxt:setText(argtable.error or"")
if argtable.completeFunc then
argtable.completeFunc()
end
else
local time=self.detailCfg.time
self.interval=time[1]
self.overTime=time[2]
self.stepFunc=argtable.stepFunc
self.completeFunc=argtable.completeFunc



self.stepValue=0

local rcnt=xianmengModel:getXWLRewardCount()
self.maxValue=rcnt
self.curNum=0
self.perValue=10000/self.maxValue


self.infoPanel:setActive(false)
self.rewardPanel:setActive(false)
self.progress:setActive(true)
self.errorPanel:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self:doNextStep()
end

end

function xzsChildXianWuLou2:onXianWuLouReward(assistant)
if assistant==1 then
self.curNum=self.curNum+1
self:onProgressStepComplete()
end
end

function xzsChildXianWuLou2:doReq2()
local typo,tjId,cnt,num
if xianmengModel:checkXWLInit()then
num=xianmengModel:getXWLRewardCount()
if num>0 then
local data=xianmengModel:getXWLData()
tjId=data.lunshuId2
typo=3
end
end
if typo then
return self.stepFunc(typo,tjId,cnt)
end
return false
end

function xzsChildXianWuLou2:doNextStep()
self.stepValue=self.stepValue+1
if self.stepValue<=self.maxValue then
local flag=self:doReq2()
local value=math.floor(self.stepValue*self.perValue)
if flag then
self.stepMark=0
self:setOverTime(true)
self.progress:animateThreeParams(value,10000,self.interval)
else
self.stepMark=1
self.progress:animateThreeParams(value,10000,0)
self:delayDo(0.1,function()
self:onProgressStepComplete()
end)
end
else
self.stepMark=nil
self:setOverTime(false)
self.progress:setActive(false)

local isshow=self.curNum>0
self.rewardPanel:setActive(isshow)
self.infoPanel:setActive(isshow)
self.errorPanel:setActive(not isshow)
if isshow then



self.commonList2=xiaoZhuShouModel:popWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl)
local count2=#self.commonList2
self.rewardGridList:setChildLayoutGroupCreateItems(count2,function(index)
local item=self.rewardGridList:getChildLayoutGroupGridItem(index-1)
local itemData=self.commonList2[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)



local lerp=self.maxValue-self.curNum
local str
if lerp>0 then
str=FMT.fmt('已领取<color=#7D3B17>{0}</color>次任务宝箱，剩余<color=#7D3B17>{1}</color>次任务宝箱无法领取',self.curNum,lerp)
xiaoZhuShouModel:addReportData(self.detailId,str)
else
str=FMT.fmt('已领取<color=#7D3B17>{0}</color>次任务宝箱',self.curNum)
end
self.infoDescTxt:setText(str)
else
local str='无法领取任务宝箱'
self.errorTxt:setText(str)
xiaoZhuShouModel:addReportData(self.detailId,str)
end


if self.completeFunc then
self.completeFunc()
end
end
end

function xzsChildXianWuLou2:onProgressStepComplete()
if self.stepMark~=nil then
self.stepMark=self.stepMark+1
if self.stepMark>=2 then
self.stepMark=nil
self:doNextStep()
end
end
end

function xzsChildXianWuLou2:setOverTime(active)
if self.overTimer then
self:stopTimerByID(self.overTimer)
self.overTimer=nil
end
if active then
self.overTimer=self:delayDo(self.overTime,function()
self:doNextStep()
end)
end
end
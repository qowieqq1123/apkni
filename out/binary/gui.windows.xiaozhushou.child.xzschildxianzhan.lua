







def_class("xzsChildXianZhan",UICloneObject)





xzsChildXianZhan.abName="ui/windows/xiaozhushou/child/xzschildxianzhan.ab"

xzsChildXianZhan.assetName="xzsChildXianZhan"


function xzsChildXianZhan:bindComponents()

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


function xzsChildXianZhan:unbindComponents()
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


function xzsChildXianZhan:onLoaded(...)
self:bindComponents()
self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)

self._onXianZhanYingBin=function(...)
self:onXianZhanYingBin(...)
end
self:addNotify(notifyConfig.onXianZhanYingBin,self._onXianZhanYingBin)
self._onXianZhanTuiFangReward=function(...)
self:onXianZhanTuiFangReward(...)
end
self:addNotify(notifyConfig.onXianZhanTuiFangReward,self._onXianZhanTuiFangReward)
end


function xzsChildXianZhan:__delete()
self:unbindComponents()
end


function xzsChildXianZhan:onHide()

end




function xzsChildXianZhan:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

self.state=argtable.state
if self.state==-1 then
self.rewardPanel:setActive(false)
self.infoPanel:setActive(false)
self.progress:setActive(false)
self.errorPanel:setActive(true)
self.errorTxt:setText(argtable.error or"")
if argtable.completeFunc then
argtable.completeFunc()
end
else
self.reqlist=argtable.reqlist
local time=self.detailCfg.time
self.interval=time[1]
self.overTime=time[2]
self.stepFunc=argtable.stepFunc
self.completeFunc=argtable.completeFunc

self.infostr=nil
self.commonList={}
self.commonLookup={}
self.stepValue=0
self.maxValue=#self.reqlist
self.perValue=10000/self.maxValue

self.rewardPanel:setActive(false)
self.infoPanel:setActive(false)
self.progress:setActive(true)
self.errorPanel:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self:doNextStep()
end

end

function xzsChildXianZhan:onXianZhanYingBin(len,roomList,assistant)
if assistant==1 then
if len>0 then
local str_='已招待<color=#CA631D>{0}</color>{1}名访客'
local str2
for i,v in ipairs(roomList)do
local name=xianzhanModel.getFangKeName(v.customerId)
if i==1 then
str2=name
else
str2=FMT.fmt('{0}、{1}',str2,name)
end
end
local str=FMT.fmt(str_,str2,len)
self.infostr=str
end
self:onProgressStepComplete()
end
end

function xzsChildXianZhan:onXianZhanTuiFangReward(itemListLen,itemList,assistant)
if assistant==1 then
if itemListLen>0 then
for k,v in ipairs(itemList)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,nil,v.param_1,v.param_2,true)
end
end
self:onProgressStepComplete()
end
end

function xzsChildXianZhan:doNextStep()
self.stepValue=self.stepValue+1
if self.stepValue<=self.maxValue then
self.stepMark=0
self.stepFunc(self.reqlist[self.stepValue])
self:setOverTime(true)
local value=math.floor(self.stepValue*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
else
self.stepMark=nil
self:setOverTime(false)
self.progress:setActive(false)
self.errorPanel:setActive(false)

local showInfo=self.infostr~=nil
self.infoPanel:setActive(showInfo)
if showInfo then
self.infoDescTxt:setText(self.infostr)
end
local count=#self.commonList
local showReward=count>0
self.rewardPanel:setActive(showReward)
if showReward then
self.rewardGridList:setChildLayoutGroupCreateItems(count,function(index)
local item=self.rewardGridList:getChildLayoutGroupGridItem(index-1)
local itemData=self.commonList[index]
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
end



if self.completeFunc then
self.completeFunc()
end
end
end

function xzsChildXianZhan:onProgressStepComplete()
if self.stepMark~=nil then
self.stepMark=self.stepMark+1
if self.stepMark>=2 then
self.stepMark=nil
self:doNextStep()
end
end
end

function xzsChildXianZhan:setOverTime(active)
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
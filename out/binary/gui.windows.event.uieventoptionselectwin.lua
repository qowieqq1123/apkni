







def_class("UIEventOptionSelectWin",UIWindowBase)









function UIEventOptionSelectWin:bindComponents()

self.backModel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.right=UIObject.get(self,2)
self.btnsTitleText=UIText.get(self,3)
self.modelObj=UIObject.get(self,4)
self.btnClose=UIButton.get(self,5)
self.costItems=UIObject.get(self,6)
self.rewardsItems=UIObject.get(self,7)
self.item1=UIBaseItem.get(self,8)
self.item2=UIBaseItem.get(self,9)
self.item3=UIBaseItem.get(self,10)
self.item5=UIBaseItem.get(self,11)
self.item4=UIBaseItem.get(self,12)
self.btnLayout=UIObject.get(self,13)
self.costLayout=UIObject.get(self,14)
self.rewardsLayout=UIObject.get(self,15)
self.content=UIText.get(self,16)
self.eventImage=UIObject.get(self,17)
self.name=UIText.get(self,18)
self.roleRoot=UIObject.get(self,19)
self.rolename=UIText.get(self,20)
self.bg=UIButton.get(self,21)
self.selectBtnLayout=UIObject.get(self,22)
self.btnsTitle=UIObject.get(self,23)
self.contentBg=UIObject.get(self,24)
self.nameRoot=UIObject.get(self,25)
self.closeClick=UIButton.get(self,26)
self.resultPanel=UIObject.get(self,27)
self.resultTitle=UIText.get(self,28)
self.resultText=UIText.get(self,29)
self.resultItemRoot=UIObject.get(self,30)
self.resultItemList=UIObject.get(self,31)
self.bottom=UIObject.get(self,32)
self.bottomLayout=UIObject.get(self,33)
self.resultDesc=UIText.get(self,34)
self.resultBg=UIButton.get(self,35)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.bg:setButtonClick(function()self:onBg()end)

self.closeClick:setButtonClick(function()self:onCloseClick()end)

self.resultBg:setButtonClick(function()self:onResultBg()end)



end


function UIEventOptionSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backModel);self.backModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.btnsTitleText);self.btnsTitleText=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.rewardsItems);self.rewardsItems=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.btnLayout);self.btnLayout=nil;
_UIObject_release(self.costLayout);self.costLayout=nil;
_UIObject_release(self.rewardsLayout);self.rewardsLayout=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.eventImage);self.eventImage=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.roleRoot);self.roleRoot=nil;
_UIObject_release(self.rolename);self.rolename=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.selectBtnLayout);self.selectBtnLayout=nil;
_UIObject_release(self.btnsTitle);self.btnsTitle=nil;
_UIObject_release(self.contentBg);self.contentBg=nil;
_UIObject_release(self.nameRoot);self.nameRoot=nil;
_UIObject_release(self.closeClick);self.closeClick=nil;
_UIObject_release(self.resultPanel);self.resultPanel=nil;
_UIObject_release(self.resultTitle);self.resultTitle=nil;
_UIObject_release(self.resultText);self.resultText=nil;
_UIObject_release(self.resultItemRoot);self.resultItemRoot=nil;
_UIObject_release(self.resultItemList);self.resultItemList=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.bottomLayout);self.bottomLayout=nil;
_UIObject_release(self.resultDesc);self.resultDesc=nil;
_UIObject_release(self.resultBg);self.resultBg=nil;
end
















local btnCmpIndex={
btnImg=0,
btnText=1,
clockRoot=2,
time=3,
consumeText=4,
consumeRoot=5,
extraTextRoot=6,
extraText=7,
}
local _this


local _abDirStr='ui/windows/event/sharedtextures/{0}.ab'
local _DOTween=Lua.DOTweenProxyExtensions

function UIEventOptionSelectWin:onLoaded(...)
_this=self
self:bindComponents()
self.rewardList={}
local rewardList=self.rewardList
rewardList[#rewardList+1]=self.item1
rewardList[#rewardList+1]=self.item2
rewardList[#rewardList+1]=self.item3

self:addNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
self:addNotify(notifyConfig.on_money_changed,self.onMoneyChanged)

for _,v in ipairs(rewardList)do
v:setBaseItemClickEvent(function(...)itemsComponentHelper.onItemClick(...)end)
end

self.costList={}
self.finishInit=false
local costList=self.costList
costList[#costList+1]=self.item4
costList[#costList+1]=self.item5
for _,v in ipairs(costList)do
v:setBaseItemClickEvent(function(...)self:onItemClick(...)end)
end







local modelId=2042
self.root:setActive(false)
self.backModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.common_window_enter,false,false,0,function()
timeEventController.delayDo(0.4,function()
if self and not self.isClose then
self.root:setActive(true)
self:playAnimation(1)
self.finishInit=true
end
end)
end)
end

function UIEventOptionSelectWin:__delete()
_this=nil
self:unbindComponents()
self:leaveAction()
end

function UIEventOptionSelectWin:leaveAction()
local actionKey=self.actionKey
if actionKey then
eventOptionActionControl.leaveAction(actionKey[1],actionKey[2])
end
self.actionKey=nil
end

function UIEventOptionSelectWin:onShow(argtable,afterOnloaded)
local dizinum=argtable.dizinum or 0
local diziguid=argtable.diziguid
local content=argtable.content
local effContent=argtable.effContent
local rewards=argtable.rewards
local btnList=argtable.btnList or{}
local name=argtable.name
local iconName=argtable.icon

local actionKey=argtable.actionKey
local npcData=argtable.npcData
local startStoryId=argtable.startStoryId
local eventguid=argtable.eventguid
local eventid=argtable.eventid
local isEnd=argtable.isEnd
self.isEnd=argtable.isEnd
self.eventguid=eventguid
self.eventid=eventid
self.endStoryId=argtable.endStoryId
self.endNpcData=argtable.endNpcData

self.btnList=btnList
self.okClick=argtable.okClick
self.dizinum=dizinum
self.diziguid=diziguid


self:leaveAction()
self.actionKey=actionKey

self:freshEventImage(iconName)
self.name:setText(name)

local btnCount=btnList and#btnList or 0
local hasBtn=btnCount>0
self.btnsTitle:setActive(not isEnd)
if isEnd then
eventOptionModel.setShowOptionEventResultIsOpening(nil)
end

self.right:setActive(hasBtn)
if hasBtn then

self.selectBtnLayout:setChildLayoutGroupCreateItems(btnCount)
local grids=self.selectBtnLayout:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local btnInfo=btnList[i]
local selectDispatch=btnInfo.dispatch
local selectWaitTime=selectDispatch and selectDispatch[2]or 0
local extraText=btnInfo.extraText
widget:SetChildButtonClick(btnCmpIndex.btnImg,btnInfo.click)
widget:SetChildText(btnCmpIndex.btnText,btnInfo.name)
local isShowClockRoot=selectWaitTime>0 and extraText==nil
widget:SetChildActive(btnCmpIndex.clockRoot,isShowClockRoot)
if isShowClockRoot then
widget:SetChildText(btnCmpIndex.time,timeHelper.format_time_stamp12(selectWaitTime))
end
local isShowExtraRoot=extraText~=nil
widget:SetChildActive(btnCmpIndex.extraTextRoot,isShowExtraRoot)
if isShowExtraRoot then
widget:SetChildText(btnCmpIndex.extraText,extraText)
end

local selectConsume=eventConfig.getOptionConsume(eventid,i)
local hasConsume=false
if not isEnd and selectConsume and next(selectConsume)then
local consumeItemId=selectConsume[1][1]
local consumeItemTargetCount=selectConsume[1][2]
local itemNameStr
local hasNumStr
local have
if itemsConfig.isMoney(consumeItemId)then
local moneyCfg=moneyModel.getMoneyConfig(consumeItemId)
local moneyName=moneyCfg.name
local moneyColor=moneyCfg.color
itemNameStr=FMT.cfmt(moneyColor,"{0}",moneyName)
have=moneyModel.getMoney(consumeItemId)
else
local itemConfig=itemsConfig.getConfig(consumeItemId)
local itemName=itemConfig.name
local itemColor=itemConfig.color
itemNameStr=FMT.cfmt(itemColor,"{0}",itemName)
have=bagControl.invokeFuncByItemId(consumeItemId,'getItemCountByItemID',consumeItemId)
end
if have>=consumeItemTargetCount then
hasNumStr=FMT.cfmt(FONT_COLOR.eGreenColor,"({0}/{1})",have,consumeItemTargetCount)
else
hasNumStr=FMT.cfmt(FONT_COLOR.eRedColor,"({0}/{1})",have,consumeItemTargetCount)
end
widget:SetChildText(btnCmpIndex.consumeText,FMT.fmt("提交{0}{1}",itemNameStr,hasNumStr))
hasConsume=true
end
widget:SetChildActive(btnCmpIndex.consumeRoot,hasConsume)
end
end

local isShowRole=diziguid~=nil or npcData~=nil

local roleName=''
if isShowRole then
local modelParams
if diziguid then
roleName=UIDiscipleModel:getDiscipleName(diziguid)or''
modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(diziguid)
elseif npcData then
roleName=eventOptionControl.getOptionNpcName(npcData,eventguid)or''
modelParams=eventOptionControl.getOptionNpcModel(npcData,eventguid,true)
end
self.rolename:setText(roleName)
local config=eventConfig.getEventConfig(self.eventid)
local modelShowParam=config.npcModelParam
local changeNpcId=eventOptionControl.getOptionNpcChangeModelNpcId(npcData,eventguid)
if changeNpcId then
modelShowParam=config.changeNpcModelParam
end
local size=modelShowParam and modelShowParam.size or 1
local offset=modelShowParam and modelShowParam.offset or{40,75}
local isFlip=modelShowParam and modelShowParam.isFlip or 0
self.modelObj:setChildUIModelShowTarget(modelParams.body,size,modelParams.componets,0,false,true)
self.modelObj:setChildCanvasGroupDOFade(1,0.3,nil)
self.modelObj:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.modelObj:setChildUIModelShowFlipX(isFlip==1)
end
self.roleRoot:setActive(isShowRole)
self.bottom:setActive(isShowRole)
self.bottomLayout:setActive(isShowRole)
local contentStr=content and gameplotModel:replaceName(content,roleName)or''
contentStr=FMT.fmt('{0}{1}','　　',contentStr)
if isEnd then
self.resultDesc:setText(contentStr)
if effContent then
local effContentStr=gameplotModel:replaceName(effContent,roleName)
self.resultText:setText(effContentStr)
self.resultText:setActive(true)
else
self.resultText:setActive(false)
end
else
self.content:setText(contentStr)
end
self.resultDesc:setActive(isEnd)

local hasrewardsItems=rewards~=nil and#rewards>0
self.rewardsLayout:setActive(hasrewardsItems)
if not isEnd then
if rewards then
for i,v in ipairs(self.rewardList)do
local reward=rewards[i]
local has=reward~=nil
v:setActive(has)
if has then
local itemid=reward[1]
local itemcount=reward[2]
local countStr=''
local showCountBG=false
local isGaiLv=itemcount<0
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local item={itemid=itemid}
local config={itemcount=countStr,showCountBG=showCountBG,showStageBg=true,showname=false}
local prop=itemsComponentHelper.getCommonFillData(item,config)
prop[PropIndex(DataPropKey.eWidgetActive,11)]=isGaiLv
v:setChildPropData(prop)
end
end
end
else
if hasrewardsItems then

self.resultItemList:setChildLayoutGroupCreateItems(#rewards)
local items=self.resultItemList:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=rewards[i+1]
local itemConfig=itemsConfig.getConfig(data[1])
data.stage=itemConfig.stage
widgetHelper.setNormalRewardItem(item,0,data)
end
end
self.resultItemRoot:setActive(hasrewardsItems)
end

if isEnd and(hasrewardsItems or effContent~=nil)then

self.resultPanel:setActive(true)
local resultTitleStr="结果"
if hasrewardsItems and effContent==nil then
resultTitleStr="获得奖励"
end
self.resultTitle:setText(resultTitleStr)
else
self.resultPanel:setActive(false)
end

local hasNeed=false
local needDiZi=dizinum>0
local porpList={}
if needDiZi then
local prop={
[PropIndex(DataPropKey.eWidgetQuality,0)]=eQualityColor.eWhite,
[PropIndex(DataPropKey.eWidgetIcon,1)]='icon_head_1',
[PropIndex(DataPropKey.eWidgetActive,2)]=true,
[PropIndex(DataPropKey.eWidgetText,3)]=dizinum,
[PropIndex(DataPropKey.eWidgetText,4)]='',
[DataPropKey.eItemID]=-1
}
porpList[#porpList+1]=prop
hasNeed=true
end





















self.costLayout:setActive(hasNeed)
if hasNeed then
for i,v in ipairs(self.costList)do
local prop=porpList[i]
v:setActive(prop~=nil)
if prop then
v:setChildPropData(prop)
end
end
end

self.btnLayout:setActive(false)




















end

function UIEventOptionSelectWin:onHide()

end

function UIEventOptionSelectWin:refreshBtnList()
local grids=self.selectBtnLayout:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local btnInfo=self.btnList[i]
local selectDispatch=btnInfo.dispatch
local selectWaitTime=selectDispatch and selectDispatch[2]or 0
local extraText=btnInfo.extraText
widget:SetChildButtonClick(btnCmpIndex.btnImg,btnInfo.click)
widget:SetChildText(btnCmpIndex.btnText,btnInfo.name)
local isShowClockRoot=selectWaitTime>0 and extraText==nil
widget:SetChildActive(btnCmpIndex.clockRoot,isShowClockRoot)
if isShowClockRoot then
widget:SetChildText(btnCmpIndex.time,timeHelper.format_time_stamp12(selectWaitTime))
end
local isShowExtraRoot=extraText~=nil
widget:SetChildActive(btnCmpIndex.extraTextRoot,isShowExtraRoot)
if isShowExtraRoot then
widget:SetChildText(btnCmpIndex.extraText,extraText)
end

local selectConsume=eventConfig.getOptionConsume(self.eventid,i)
local hasConsume=false
if not self.isEnd and selectConsume and next(selectConsume)then
local consumeItemId=selectConsume[1][1]
local consumeItemTargetCount=selectConsume[1][2]
local itemNameStr
local hasNumStr
local have
if itemsConfig.isMoney(consumeItemId)then
local moneyCfg=moneyModel.getMoneyConfig(consumeItemId)
local moneyName=moneyCfg.name
local moneyColor=moneyCfg.color
itemNameStr=FMT.cfmt(moneyColor,"{0}",moneyName)
have=moneyModel.getMoney(consumeItemId)
else
local itemConfig=itemsConfig.getConfig(consumeItemId)
local itemName=itemConfig.name
local itemColor=itemConfig.color
itemNameStr=FMT.cfmt(itemColor,"{0}",itemName)
have=bagControl.invokeFuncByItemId(consumeItemId,'getItemCountByItemID',consumeItemId)
end
if have>=consumeItemTargetCount then
hasNumStr=FMT.cfmt(FONT_COLOR.eGreenColor,"({0}/{1})",have,consumeItemTargetCount)
else
hasNumStr=FMT.cfmt(FONT_COLOR.eRedColor,"({0}/{1})",have,consumeItemTargetCount)
end
widget:SetChildText(btnCmpIndex.consumeText,FMT.fmt("提交{0}{1}",itemNameStr,hasNumStr))
hasConsume=true
end
widget:SetChildActive(btnCmpIndex.consumeRoot,hasConsume)
end
end



function UIEventOptionSelectWin.onItemListChanged(argsTable)
if _this==nil then return end
_this:refreshBtnList()
end

function UIEventOptionSelectWin.onMoneyChanged(moneyType,oldVal,newVal)
if _this==nil then return end
_this:refreshBtnList()
end

function UIEventOptionSelectWin:playAnimation(id)
self.root:setAnimatorInteger('nState',id,true)
end

function UIEventOptionSelectWin:freshEventImage(imageId)
self.winlua:SetChildCanvasGroupAlpha(self.eventImage:getID(),0)
self.winlua:SetChildCanvasGroupDOFade(self.eventImage:getID(),1,2,nil)
self.eventImage:setChildIcon(FMT.fmt("image_shijian_{0}",imageId),true)
end

function UIEventOptionSelectWin:onBtnOK()
if self.btnList[1]and self.btnList[1].click then
self.btnList[1].click(self.selectDiziguidList)
end
end

function UIEventOptionSelectWin:onBtnCancel()
self:closeSelf()
end

function UIEventOptionSelectWin:onBg()
self:onBtnClose()
end

function UIEventOptionSelectWin:onBtnClose()
if not self.finishInit then

return
end

if self.endStoryId then
self:setPageShow(false)
local endStoryId=self.endStoryId
local npcData=self.endNpcData
local eventguid=self.eventguid
local callback=self.okClick
local args={

npcData=npcData,
eventguid=eventguid,








callback=callback

}

worldStoryController:showStoryTree(endStoryId,callback,nil,nil,args)
else
if self.okClick then
self.okClick()
else
self:closeSelf()
end
end
end

function UIEventOptionSelectWin:onResultBg()
self:onBtnClose()
end

function UIEventOptionSelectWin:onCloseClick()
self:onBtnClose()
end

function UIEventOptionSelectWin:showEndStoryCallback()
if self.okClick then
self.okClick()
else
self:closeSelf()
end
end

function UIEventOptionSelectWin:onItemClick(itemid,index,itemguid,attach)
if itemid==-1 then
else
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end
end


function UIEventOptionSelectWin:setPageShow(isShow)
self.bg:setActive(isShow)
self.root:setActive(isShow)
end
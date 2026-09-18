







def_class("UIWanLingTaCollectWin",UIWindowBase)









function UIWanLingTaCollectWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.menuContent=UIObject.get(self,2)
self.targetContent=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIWanLingTaCollectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.menuContent);self.menuContent=nil;
_UIObject_release(self.targetContent);self.targetContent=nil;
end


















local pageConfig={
eWanLingTaShowcaseType.eTDLX,
eWanLingTaShowcaseType.eSBLQ,
eWanLingTaShowcaseType.eZMBW,
eWanLingTaShowcaseType.eXYHL,
eWanLingTaShowcaseType.eTCDB,
}
local itemWidgetCmp={
0,1,2
}
local propWidgetCmp={
0,1,2
}
local this

function UIWanLingTaCollectWin:onLoaded(...)
self:bindComponents()
this=self
self:addNotify(notifyConfig.onWanLingTaCollectRewardReceive,self.onWanLingTaCollectRewardReceive)
end


function UIWanLingTaCollectWin:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTaCollectWin:onShow(argtable,afterOnloaded)
self.pageIdx=1
if argtable.type then
for idx,typeId in ipairs(pageConfig)do
if typeId==argtable.type then
self.pageIdx=idx
break
end
end
end
self:refreshCollectMenu()
self:refreshCollectTarget()
end

function UIWanLingTaCollectWin.onWanLingTaCollectRewardReceive(sjId)
this:refreshCollectTarget()
end


function UIWanLingTaCollectWin:refreshCollectMenu()
local len=#pageConfig
self.menuContent:setChildLayoutGroupCreateItems(len,function(index)
local menuItem=self.menuContent:getChildLayoutGroupGridItem(index-1)
local typeId=pageConfig[index]
local cfg=cfg_xumitatujiantypeconfig_get(typeId)
menuItem:SetChildActive(0,self.pageIdx~=index)
menuItem:SetChildActive(1,self.pageIdx==index)
menuItem:SetChildText(2,cfg.name)
menuItem:SetChildButtonClick(0,function()
if self and not self.isClose then
self:onClickMenu(index)
end
end)
end)
end

function UIWanLingTaCollectWin:onClickMenu(index)
if self.pageIdx==index then
return
end
local menuItem=self.menuContent:getChildLayoutGroupGridItem(self.pageIdx-1)
menuItem:SetChildActive(0,true)
menuItem:SetChildActive(1,false)
self.pageIdx=index
menuItem=self.menuContent:getChildLayoutGroupGridItem(self.pageIdx-1)
menuItem:SetChildActive(0,false)
menuItem:SetChildActive(1,true)
self.targetContent:setChildCanvasGroupAlpha(0)
self:refreshCollectTarget()
self.targetContent:setChildAnchoredPos(0,0)
if self.fadeTween then
self.fadeTween:Kill()
self.fadeTween=nil
end
self.fadeTween=self.targetContent:setChildCanvasGroupDOFade(1,0.6)
end

function UIWanLingTaCollectWin:getSortCollectTargetData()
local typeId=pageConfig[self.pageIdx]
local collectCfgs=wanLingTaModel:getTuJianCollectConfig(typeId)
local temp={}
for i,v in ipairs(collectCfgs)do
local canShow=true
if v.discipleShow then
for i,dzId in ipairs(v.discipleShow)do
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzId)
if not dzData then
canShow=false
break
end
end
end
if canShow then
local sortWeight=v.id

local isReceive=wanLingTaModel:checkCollectTargetReceived(v.id)
if isReceive then
sortWeight=sortWeight+10000
end

local canReceive=wanLingTaModel:checkCollectTargetReddot(v.id)
if canReceive then
sortWeight=sortWeight-1000000
end
table.insert(temp,{id=v.id,cfg=v,sortWeight=sortWeight})
end
end
table.sort(temp,function(a,b)
return a.sortWeight<b.sortWeight
end)
return temp
end


function UIWanLingTaCollectWin:refreshCollectTarget()
local collectTargetData=self:getSortCollectTargetData()
local len=#collectTargetData
self.targetContent:setChildLayoutGroupCreateItems(len,function(index)
local targetItem=self.targetContent:getChildLayoutGroupGridItem(index-1)
local collectData=collectTargetData[index]
local collectCfg=collectData.cfg
local sjId=collectData.id

local isReceive=wanLingTaModel:checkCollectTargetReceived(sjId)

local canReceive=wanLingTaModel:checkCollectTargetReddot(sjId)

targetItem:SetChildText(1,collectCfg.name)

targetItem:SetChildText(2,collectCfg.desc)

local itemRewards=collectCfg.itemRewards or defaultT
local itemWidget=targetItem:GetChildWidgetBase(5)
for i,v in ipairs(itemWidgetCmp)do
local rewards=itemRewards[i]
if rewards then
itemWidget:SetChildActive(v,true)
local itemid,itemnum=unpack(rewards)
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local conf={itemid=itemid,itemcount=countStr,showCountBG=itemnum>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetBaseItemClickEvent(v,function(...)
itemsComponentHelper.onItemClick(...)
end)
itemWidget:SetChildPropData(v,prop)
else
itemWidget:SetChildActive(v,false)
end
end

local propRewardsDesc=collectCfg.propRewardsDesc or defaultT
local propWidget=targetItem:GetChildWidgetBase(6)
for i,v in ipairs(propWidgetCmp)do
local propDesc=propRewardsDesc[i]
if propDesc then
propWidget:SetChildActive(v,true)
local widget=propWidget:GetChildWidgetBase(v)
widget:SetChildText(0,propDesc)
else
propWidget:SetChildActive(v,false)
end
end

local showReceiveBtn=canReceive
targetItem:SetChildActive(7,showReceiveBtn)
if showReceiveBtn then
targetItem:SetChildButtonClick(7,function()
if self and not self.isClose then
self:onReceiveReward(sjId)
end
end)
end

local showGoBtn=not isReceive and not canReceive
targetItem:SetChildActive(8,false)
if showGoBtn then
if collectCfg.jumpArgs~=nil then
targetItem:SetChildActive(8,true)
targetItem:SetChildButtonClick(8,function()
jumpManager:jump(collectCfg.jumpArgs)
end)
elseif(collectCfg.param[1]==1 or collectCfg.param[1]==2)and not(collectCfg.type==eWanLingTaShowcaseType.eXYHL or collectCfg.type==eWanLingTaShowcaseType.eSBLQ)then
local tjIdList=collectCfg.param[2]
local tj_id=tjIdList[1]
local minLv=10000
for i,tjId in ipairs(tjIdList)do
local tj_conf=wanLingTaModel:getTuJianConfig(tjId)
local tj_data=wanLingTaModel:getTuJianData(tjId)
if tj_data.level<=0 then
tj_id=tjId
break
end
if tj_data.level<minLv then
minLv=tj_data.level
tj_id=tjId
end
end
targetItem:SetChildActive(8,true)
targetItem:SetChildButtonClick(8,function()
UIManager:invokeUIMethod("UIWanLingTaBgWin","onShow",{showcaseId=collectCfg.type,tj_id=tj_id})
UIManager:closeWindow("UIWanLingTaCollectWin")
end)
end
end

targetItem:SetChildActive(9,isReceive)

self:refreshCollectTargetItemOrDisciple(targetItem,collectCfg)
end)
end


function UIWanLingTaCollectWin:refreshCollectTargetItemOrDisciple(targetItem,collectCfg)

targetItem:SetChildLayoutGroupClearAllItems(3)
targetItem:SetChildLayoutGroupClearAllItems(4)
local param=collectCfg.param
local tj_type=collectCfg.type
local collectType=param[1]
if collectType==1 or collectType==2 or collectType==6 then
local tjIdList=param[2]
if tj_type==eWanLingTaShowcaseType.eXYHL then
local targetDiscipleLen=#tjIdList
targetItem:SetChildLayoutGroupCreateItems(4,targetDiscipleLen,function(index)
local item=targetItem:GetChildLayoutGroupGridItem(4,index-1)
local tjId=tjIdList[index]
local tj_conf=wanLingTaModel:getTuJianConfig(tjId)
local tj_data=wanLingTaModel:getTuJianData(tjId)
local dzId=tj_conf.needItem
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
local imageInfo=dzData.imageInfo

comHelper.setChildModelHeadIconBGByColor(item,0,imageInfo.color)

comHelper.setChildModelRawImageByDiziId(item,dzId,1,0,eHeadCenterType.eHead)

item:SetChildActive(2,collectType==2)
item:SetChildText(3,tj_data.level)
end)
else
local targetItemLen=#tjIdList
targetItem:SetChildLayoutGroupCreateItems(3,targetItemLen,function(index)
local item=targetItem:GetChildLayoutGroupGridItem(3,index-1)
local tjId=tjIdList[index]
local tj_conf=wanLingTaModel:getTuJianConfig(tjId)
local tj_data=wanLingTaModel:getTuJianData(tjId)
local itemid=tj_conf.needItem and tj_conf.needItem or tj_conf.activeUp[1][1][1]
local countStr=tj_data.level
local isActive=tj_data.level>0
local showCountBG=collectType==2
local gray=not isActive and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=false,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)
end
elseif collectType==4 or collectType==5 or collectType==7 then
local itemIdList=collectType==4 and{param[2]}or param[2]
local targetItemLen=#itemIdList
local itemList={}
targetItem:SetChildLayoutGroupCreateItems(3,targetItemLen,function(index)
local item=targetItem:GetChildLayoutGroupGridItem(3,index-1)
local itemid=itemIdList[index]
local ningLianLv,pos,guid=equipsModel.getAllEquipNingLianMaxStar(itemid)
if guid then
table.insert(itemList,{guid,pos})
end
local showCountBG=true
local gray=0
local conf={itemid=itemid,itemcount=ningLianLv,showCountBG=showCountBG,showname=false,showStage=false,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)
targetItem:SetChildButtonClick(7,function()
if self and not self.isClose then
self:onReceiveReward(collectCfg.id,itemList)
end
end)
end
end

function UIWanLingTaCollectWin:onReceiveReward(sjId,itemList)
if not itemList then
wanLingTaController.send_43_5(sjId)
else
wanLingTaController.send_43_5(sjId,#itemList,itemList)
end
end


function UIWanLingTaCollectWin:onCloseBtn()
self:closeSelf()
end

function UIWanLingTaCollectWin:onMask()
self:closeSelf()
end


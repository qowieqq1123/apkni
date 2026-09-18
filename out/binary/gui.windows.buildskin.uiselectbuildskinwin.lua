







def_class("UISelectBuildSkinWin",UIWindowBase)









function UISelectBuildSkinWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.changeAllToggle=UIToggleButton.get(self,1)
self.changeAllToggleText=UIText.get(self,2)
self.closebtn=UIButton.get(self,3)
self.descPanel=UIObject.get(self,4)
self.liandonBtn=UIButton.get(self,5)
self.mask=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.selectBtn=UIButton.get(self,8)
self.showmodel=UIObject.get(self,9)
self.skinListScroll=UIObject.get(self,10)
self.unLockBtn=UIButton.get(self,11)
self.unLockItem=UIObject.get(self,12)
self.unLockPanel=UIObject.get(self,13)
self.unLockReddot=UIObject.get(self,14)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.unLockBtn:setButtonClick(function()self:onUnLockBtn()end)



end


function UISelectBuildSkinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.changeAllToggle);self.changeAllToggle=nil;
_UIObject_release(self.changeAllToggleText);self.changeAllToggleText=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.descPanel);self.descPanel=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.showmodel);self.showmodel=nil;
_UIObject_release(self.skinListScroll);self.skinListScroll=nil;
_UIObject_release(self.unLockBtn);self.unLockBtn=nil;
_UIObject_release(self.unLockItem);self.unLockItem=nil;
_UIObject_release(self.unLockPanel);self.unLockPanel=nil;
_UIObject_release(self.unLockReddot);self.unLockReddot=nil;
end
















local _this
local skinListItemCmp={
model=0,
name=1,
select=2,
gray=3,
reddot=4,
useMark=5,
liandon=6,
}




function UISelectBuildSkinWin:onLoaded(...)
_this=self
self:bindComponents()
self.isToggle=userActorSetting.get('changeAllSameBuildSkin',false)
local clickEvent=function(...)
self:onClickItemCallback(...)
end
self.skinListScroll:setChildScrollViewInit(0.5,true,clickEvent,nil)
self:addNotify(notifyConfig.on_item_changed,function(...)self:onItemChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
self.changeAllToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle(self.isToggle)
end


function UISelectBuildSkinWin:__delete()
self:unbindComponents()
_this=nil
end




function UISelectBuildSkinWin:onShow(argtable,afterOnloaded)
self.build_id=argtable and argtable.build_id
self.un_build_id=argtable and argtable.un_build_id
self.jumpSkinId=argtable and argtable.skinId
local sfId=mapIdType.zhufeng
local max=zongmenModel:getBuildingMaxNum(self.build_id,sfId)
self.isShowToggle=max>1
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end
self.bgModel:setChildUIModelShowTarget(5033,1,{},eAnimationID.stand,false,false,0)
self:refresh(afterOnloaded)
end


function UISelectBuildSkinWin:onHide()

end

function UISelectBuildSkinWin:refresh(isInit)

self.showSkinIdList=buildSkinModel:getBuildSkinIdList(self.build_id)or{}
if isInit then
self.selectIndex=1
for index,skinId in ipairs(self.showSkinIdList)do
if not self.jumpSkinId then
local isUnLock=buildSkinModel:checkBuildSkinUnLock(skinId)
if not isUnLock and buildSkinModel:checkBuildSkinCanUnLock(skinId)then
self.selectIndex=index
break
end
else
if self.jumpSkinId==skinId then
self.selectIndex=index
break
end
end
end
end

self:refreshSkinList(isInit)


self:refreshSkinShowPanel()
end

function UISelectBuildSkinWin:refreshSkinList(isInit)
self.skinListScroll:setChildScrollViewCreateGrids(#self.showSkinIdList,1)
local girds=self.skinListScroll:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
self:refreshSkinItem(widget,i,isInit)
end
if isInit then
self.skinListScroll:setChildScrollViewSelectItem(self.selectIndex-1,false,false,false)
end
end

function UISelectBuildSkinWin:refreshSkinShowPanel(isInit)
local skinId=self.showSkinIdList[self.selectIndex]
local bdData=zongmenModel:getBuildingData(self.un_build_id)
local modelParam
local isDefault=skinId==0
local modelId
local bdLevel=bdData.level
local skinName
local isLD
if isDefault then
local mdata=isometricMapSystem:getModelByStatus(self.build_id,bdLevel,0,nil,nil,nil,nil,nil,true)
modelId=mdata.model
local defaultSkinCfg=cfgHelper.get(cfg_monijybuilddefaultappearanceconfig_get,self.build_id)
modelParam=defaultSkinCfg.showModelParam and defaultSkinCfg.showModelParam[2]or{}
skinName="默认外观"
else
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
modelParam=skinCfg.showModelParam and skinCfg.showModelParam[2]or{}

modelId=skinCfg.model
skinName=skinCfg.name
isLD=skinCfg.linkageId~=nil
end
local offset=modelParam.offset or{0,0}
local scale=modelParam.scale or 1
local isFlip=modelParam.isFlip or false
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.showmodel:getID(),true,true,true)
end
self.showmodel:setChildUIModelShowTarget(modelId,scale,nil,eAnimationID.stand,false,false,0.5)
self.showmodel:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.showmodel:setChildUIModelShowFlipX(isFlip)


local isUnLock=self:setUnLockPanel()


local isUse=bdData.build_appearance_id==skinId
self.selectBtn:setActive(not isUse and isUnLock)

self.liandonBtn:setActive(isLD)


self.changeAllToggle:setActive(not isUse and isUnLock and self.isShowToggle)
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.build_id)
if bdCfg then
local bdName=bdCfg.name
self.changeAllToggleText:setText(FMT.fmt("更换所有{0}外观",bdName))
end

local isShowDesc=false
if not isDefault then
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
if skinCfg.showDescText and next(skinCfg.showDescText)then

isShowDesc=true
local descList=skinCfg.showDescText
local descCount=#descList
local descGrids=self.descPanel:getChildCommonLayoutGroupWidgetList()
if descCount==2 then

for i=1,descGrids.Count do
local item=descGrids[i-1]
if i<=descCount then
local descText=descList[i]
item:SetChildText(0,descText)
item:SetChildActive(-1,true)
else
item:SetChildActive(-1,false)
end
end
elseif descCount==1 then

local selectIndex=3
for i=1,descGrids.Count do
local item=descGrids[i-1]
if i==selectIndex then
local descText=descList[1]
item:SetChildText(0,descText)
item:SetChildActive(-1,true)
else
item:SetChildActive(-1,false)
end
end
end
end
end

self.descPanel:setActive(isShowDesc)

end


function UISelectBuildSkinWin:setUnLockPanel()
local skinId=self.showSkinIdList[self.selectIndex]
local isUnLock=buildSkinModel:checkBuildSkinUnLock(skinId)
self.unLockPanel:setActive(not isUnLock)
if isUnLock then
return isUnLock
end

local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
local reddot=false
if skinCfg.unlock_condition then
local lockType=skinCfg.unlock_condition[1]
local lockParam=skinCfg.unlock_condition[2]
if lockType==1 then

local itemId=lockParam[1]
local itemNeedCount=lockParam[2]
local itemHasCount=itemsModel.getCount(itemId)
local item=self.unLockItem:getWidgetBase()
item:SetChildActive(-1,true)
local countStr=mathHelper.formatNumber(itemNeedCount,true)
if itemHasCount<itemNeedCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)

self.unLockItemId=itemId
reddot=itemHasCount>=itemNeedCount
end
end
self.unLockReddot:setActive(reddot)
return isUnLock
end

function UISelectBuildSkinWin:onClickItemCallback(clickNum,index)
local dataIndex=index+1
local oldSelectIdx=self.selectIndex
self.selectIndex=dataIndex
local oldSelectWidget=self.skinListScroll:getChildScrollViewItemWidget(oldSelectIdx-1)
local newSelectWidget=self.skinListScroll:getChildScrollViewItemWidget(self.selectIndex-1)
self:refreshSkinItem(oldSelectWidget,oldSelectIdx)
self:refreshSkinItem(newSelectWidget,self.selectIndex)


self:refreshSkinShowPanel()
end

function UISelectBuildSkinWin:refreshSkinItem(widget,index,isInit)
local skinId=self.showSkinIdList[index]
local bdData=zongmenModel:getBuildingData(self.un_build_id)
local isDefault=skinId==0
if isInit then

local modelParam
local modelId
local bdLevel=bdData.level
local skinName
local isLD
if isDefault then
local mdata=isometricMapSystem:getModelByStatus(self.build_id,bdLevel,0,nil,nil,nil,nil,nil,true)
modelId=mdata.model
local defaultSkinCfg=cfgHelper.get(cfg_monijybuilddefaultappearanceconfig_get,self.build_id)
modelParam=defaultSkinCfg.showModelParam and defaultSkinCfg.showModelParam[1]or{}
skinName="默认外观"
else
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
modelParam=skinCfg.showModelParam and skinCfg.showModelParam[1]or{}

modelId=skinCfg.model
skinName=skinCfg.name
isLD=skinCfg.linkageId~=nil
end
local offset=modelParam.offset or{0,0}
local scale=modelParam.scale or 1
local isFlip=modelParam.isFlip or false
widget:SetChildUIModelShowTarget(skinListItemCmp.model,modelId,scale,nil,eAnimationID.stand,true,false,-1)
widget:SetChildUIModelShowTargetOffset(skinListItemCmp.model,offset[1],offset[2])
widget:SetChildUIModelShowFlipX(skinListItemCmp.model,isFlip)

widget:SetChildText(skinListItemCmp.name,skinName)

widget:SetChildActive(skinListItemCmp.liandon,isLD)
end


local isSelect=index==self.selectIndex
widget:SetChildActive(skinListItemCmp.select,isSelect)


local isUnLock=buildSkinModel:checkBuildSkinUnLock(skinId)
widget:SetChildActive(skinListItemCmp.gray,not isUnLock)


local isUse=bdData.build_appearance_id==skinId
widget:SetChildActive(skinListItemCmp.useMark,isUse)


local reddot=not isUnLock and buildSkinModel:checkBuildSkinCanUnLock(skinId)
widget:SetChildActive(skinListItemCmp.reddot,reddot)
end

function UISelectBuildSkinWin:refreshSkinItemListReddot()
local girds=self.skinListScroll:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local skinId=self.showSkinIdList[i]

local isUnLock=buildSkinModel:checkBuildSkinUnLock(skinId)
local reddot=not isUnLock and buildSkinModel:checkBuildSkinCanUnLock(skinId)
widget:SetChildActive(skinListItemCmp.reddot,reddot)
end
end

function UISelectBuildSkinWin:freshToggle(isToggle)
self.changeAllToggle:setToggle(isToggle)
end

function UISelectBuildSkinWin:onToggleChanged(name,isToggle,data)
if self.isToggle==isToggle then return end
self.isToggle=isToggle
userActorSetting.flushVal('changeAllSameBuildSkin',isToggle)
self:freshToggle(isToggle)
end


function UISelectBuildSkinWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})
end

function UISelectBuildSkinWin:onItemChanged(changeType,itemguid,itemid,lastcount,itemcount)
if self.unLockItemId and itemid==self.unLockItemId then

self:setUnLockPanel()
end


self:refreshSkinItemListReddot()
end

function UISelectBuildSkinWin:onMoneyChanged(moneyType,lastVal,val)
if self.unLockItemId and moneyType==self.unLockItemId then

self:setUnLockPanel()
end


self:refreshSkinItemListReddot()
end




function UISelectBuildSkinWin:onSelectBtn()
local skinId=self.showSkinIdList[self.selectIndex]
local bdId=self.build_id
local ubdId=self.un_build_id
local isAll=self.isShowToggle and self.isToggle
local callback=function()

buildSkinController:reqChangeBuildSkin(bdId,ubdId,skinId,isAll)
end

local isHideChangeAllTipsDialog=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eChangeBuildSkinDialog)
if not isHideChangeAllTipsDialog and self.isShowToggle and self.isToggle then

local contentStr="是否更换所有建筑外观形象？"
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.build_id)
if bdCfg then
local bdName=bdCfg.name
contentStr=FMT.fmt("是否更换所有{0}外观形象？",bdName)
end


















local okcallback=function()
if _this==nil then return end
callback()
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eChangeBuildSkinDialog)
else
callback()
end
end



function UISelectBuildSkinWin:onClosebtn()
self:closeSelf()
end



function UISelectBuildSkinWin:onUnLockBtn()
local skinId=self.showSkinIdList[self.selectIndex]
local isCanUnLock,lockType,lockParam=buildSkinModel:checkBuildSkinCanUnLock(skinId,true)
if not isCanUnLock then
if lockType==1 then

local itemId=lockParam[1]
local itemNeedCount=lockParam[2]
local itemHasCount=itemsModel.getCount(itemId)
if moneyConfig.isMoney(itemId)and itemId==eMoneyType.mtLingYu then

local needXianYuCount=itemNeedCount-itemHasCount
local isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
if isEnough then
moneySystem:useMoney(itemId,itemNeedCount,function()

buildSkinController:reqUnLockBuildSkin(skinId)
end)
end
end
end
return
end

buildSkinController:reqUnLockBuildSkin(skinId)
end



function UISelectBuildSkinWin:onLiandonBtn()
local skinId=self.showSkinIdList[self.selectIndex]
local isDefault=skinId==0
if not isDefault then
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
UIManager:showWindow('UITipLianDonWin',{linkageId=skinCfg.linkageId})
end
end

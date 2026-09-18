







def_class("UIShiLianTaRewardSelectWin",UIWindowBase)









function UIShiLianTaRewardSelectWin:bindComponents()

self.desc=UIText.get(self,0)
self.closeButton=UIButton.get(self,1)
self.titleBg=UIImage.get(self,2)
self.titleBg2=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.title2=UIText.get(self,5)
self.ListPanel=UIObject.get(self,6)
self.chooseButton=UIButton.get(self,7)
self.descBg=UIObject.get(self,8)
self.effect=UIObject.get(self,9)
self.rightButton=UIButton.get(self,10)
self.leftButton=UIButton.get(self,11)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIShiLianTaRewardSelectWin")end)

self.chooseButton:setButtonClick(function()self:onChooseButton()end)

self.rightButton:setButtonClick(function()self:onRightButton()end)

self.leftButton:setButtonClick(function()self:onLeftButton()end)



end


function UIShiLianTaRewardSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.titleBg2);self.titleBg2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.chooseButton);self.chooseButton=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.rightButton);self.rightButton=nil;
_UIObject_release(self.leftButton);self.leftButton=nil;
end


















local titleTxt={"尚未通关第{0}层","恭喜通关第{0}层"}
local title2Txt={"通关后可从以下奖励选取1种","<color=#d3b97a>请从以下奖励选取{0}种</color>"}

local ItemCmpIndex=
{
item=0,
select=1,
btn=2,
lock=3,
colorEffect=4,
selectBtn=5,
cancelBtn=6,
}

local colorEffect=
{
[eQualityColor.eGreen]=10047,
[eQualityColor.eBlue]=10048,
[eQualityColor.ePurple]=10049,
[eQualityColor.eOrange]=10050,
[eQualityColor.eRed]=10051,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemBgCountIdx=2,
cmpItemTxtCountIdx=3,
cmpItemTxtStage=4,
cmpItemStageBg=5,
effect=6,
}



local _layer=1
local _selectIndex=nil
local _selectItem=nil
local _lastSelectIndex=nil

local _selectItemList={}


function UIShiLianTaRewardSelectWin:onLoaded(...)
self:bindComponents()
self:sortLayerList()
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",false)
end


function UIShiLianTaRewardSelectWin:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",true)
_selectIndex=nil
_selectItem=nil
_lastSelectIndex=nil
_selectItemList={}
end




function UIShiLianTaRewardSelectWin:onShow(argtable,afterOnloaded)
local aimLayer=shiLianTaModel:getSectionSelectLayer()
self.aimLayer=aimLayer
self.selectedLayerIndex=self:getLayerIndex(aimLayer)
self:refreshWin(aimLayer)
end

function UIShiLianTaRewardSelectWin:refreshWin(layer)

local clearLayer=shiLianTaModel:getClearLayer()
local showType=shiLianTaModel.RewardPanelType.NotClear
if layer<=clearLayer then
showType=shiLianTaModel.RewardPanelType.Clear
else
showType=shiLianTaModel.RewardPanelType.NotClear
end
_layer=layer
self.panelIndex=self:getLayerIndex(_layer)
local aimLayer=shiLianTaModel:getSectionSelectLayer()
if aimLayer then
self.leftButton:setActive(self.panelIndex>self.selectedLayerIndex)
else
self.leftButton:setActive(self.panelIndex>1)
end

self.rightButton:setActive(#self.sectionLayerList>self.panelIndex)
if showType==shiLianTaModel.RewardPanelType.NotClear then
self:showNotClearPanel()
elseif showType==shiLianTaModel.RewardPanelType.Clear then
self:showClearPanel()
end
self.effect:setChildShowEffect(10053,self.Clear)
end


function UIShiLianTaRewardSelectWin:onHide()

end

function UIShiLianTaRewardSelectWin:showNotClearPanel()
self.Clear=false
self.isAimLayer=false
self.chooseButton:setActive(false)
self.title:setText(FMT.fmt(titleTxt[1],_layer))
self.title2:setText(title2Txt[1])
self.titleBg:setActive(true)
self.titleBg2:setActive(false)
self.chooseButton:setActive(false)




if self.panelIndex==self.selectedLayerIndex then
self.itemList=shiLianTaModel:getSectionRewardData()
else
self.itemList=shiLianTaModel:getAimerLayerReward(_layer)
end
self:initRewardList()
end

function UIShiLianTaRewardSelectWin:showClearPanel()
self.Clear=true





local curLayer=_layer

self.title:setText(FMT.fmt(titleTxt[2],curLayer))

self.selectTimes=shiLianTaModel:getSectionSelectTimes()

self.titleBg:setActive(false)
self.titleBg2:setActive(true)

local rewardState=shiLianTaModel:getSectionRewardState()
local aimLayer=shiLianTaModel:getSectionSelectLayer()
if not rewardState and curLayer==aimLayer then
self.itemList=shiLianTaModel:getSectionRewardData()
self.title2:setText(FMT.fmt(title2Txt[2],self.selectTimes))
else
self.itemList=shiLianTaModel:getAimerLayerReward(_layer)
self.title2:setText("<color=#d3b97a>请先选取上一轮奖励</color>")
end
self.isAimLayer=not rewardState and curLayer==aimLayer
self.chooseButton:setActive(self.isAimLayer)
self:initRewardList()
end

function UIShiLianTaRewardSelectWin:initRewardList()
if self.itemList then
local length=#self.itemList
self.ListPanel:setChildLayoutGroupCreateItems(length)
local gridlist=self.ListPanel:getChildLayoutGroupGridList()
local gridNum=gridlist.Count

local list={}
for i,v in pairs(_selectItemList)do
table.insert(list,v)
end
local selectLength=#list

if gridNum>0 then
for i=1,gridNum do
local item=gridlist[i-1]
local itemData=self.itemList[i]
if item and itemData then
local itemId=itemData[1]
local count=itemData[2]
local itemConfig=itemsConfig.getConfig(itemId)
self:fillItem(item,itemId,count,itemConfig,i-1)






if self.isAimLayer then
if not _selectItemList[i]then
item:SetChildActive(ItemCmpIndex.select,false)
item:SetChildShowEffect(ItemCmpIndex.colorEffect,10103,false)
else
item:SetChildActive(ItemCmpIndex.select,true)
item:SetChildShowEffect(ItemCmpIndex.colorEffect,10103,true)
end
item:SetChildActive(ItemCmpIndex.selectBtn,selectLength<self.selectTimes)
else
item:SetChildActive(ItemCmpIndex.select,false)
item:SetChildShowEffect(ItemCmpIndex.colorEffect,10103,false)
item:SetChildActive(ItemCmpIndex.selectBtn,false)
end


item:SetChildShowEffect(ItemCmpIndex.lock,10052,not self.Clear)
item:SetChildActive(ItemCmpIndex.lock,not self.Clear)

item:SetChildButtonClick(ItemCmpIndex.selectBtn,function()

self:onItemClick(itemId,i,nil,"",item,i-1)
end)

item:SetChildButtonClick(ItemCmpIndex.cancelBtn,function()

self:onItemClick(itemId,i,nil,"",item,i-1)
end)

item:SetChildActive(ItemCmpIndex.selectBtn,self.isAimLayer)
end
end
end
end
end

function UIShiLianTaRewardSelectWin:fillItem(grid,itemid,count,itemConfig,i)
if not grid then
return
end
grid:SetBaseItemClickEvent(0,function(id,index,guid,attach)self:itemClick(id,index,guid,attach,grid,i)end)
grid:SetBaseItemLongTouchEvent(0,function(id,index,guid,attach)
self:itemClick(id,index,guid,attach)
end)
local prop={}
local color=itemConfig.color
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemBgCountIdx)]=count>1 and true or false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCountIdx)]=count==1 and''or count
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false

if self.Clear then
prop[PropIndex(DataPropKey.eWidgetQualityEffect,_itemWidgetIdx.effect)]=color
else
prop[PropIndex(DataPropKey.eWidgetQualityEffect,_itemWidgetIdx.effect)]=-1
end

prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
grid:SetChildPropData(0,prop)
end


















































function UIShiLianTaRewardSelectWin:onClickItemCallbackNew(index,item)
if self.Clear then
local gridlist=self.ListPanel:getChildLayoutGroupGridList()
local gridNum=gridlist.Count

local itemData=self.itemList[index+1]
if _selectItemList[index+1]then
item:SetChildActive(ItemCmpIndex.select,false)
item:SetChildShowEffect(ItemCmpIndex.colorEffect,10103,false)
_selectItemList[index+1]=nil
else
item:SetChildActive(ItemCmpIndex.select,true)
item:SetChildShowEffect(ItemCmpIndex.colorEffect,10103,true)
_selectItemList[index+1]=itemData
_lastSelectIndex=index+1
end

local list={}
for i,v in pairs(_selectItemList)do
table.insert(list,v)
end
local selectLength=#list
if gridNum>0 then
for i=1,gridNum do
local item=gridlist[i-1]
if item then
item:SetChildActive(ItemCmpIndex.selectBtn,selectLength<self.selectTimes)
end
end
end
end
end

function UIShiLianTaRewardSelectWin:onItemClick(id,index,guid,attach,grid,i)
if self.Clear then
self:onClickItemCallbackNew(i,grid)
else
self:itemClick(id,index,guid,attach)
end
end

function UIShiLianTaRewardSelectWin:itemClick(id,index,guid,attach)
if itemsConfig.isGubao(id)then
gubaoController:gubaoShowTips(id)
return
end
itemsComponentHelper.onItemClick(id,index,guid,attach)
end

function UIShiLianTaRewardSelectWin:sortLayerList()
local cfg=cfg_traintowerjieduanrewardconfig()
local list={}
for i,v in ipairs(cfg)do
if i<=shiLianTaModel.finalRewardId then
table.insert(list,v)
end
end
self.sectionLayerList=list
end

function UIShiLianTaRewardSelectWin:getLayerIndex(aimLayer)
if self.sectionLayerList then
for i,v in ipairs(self.sectionLayerList)do
for _,layer in ipairs(v.layer)do
if layer==aimLayer then
return i
end
end
end
return shiLianTaModel.finalRewardId
end
end





function UIShiLianTaRewardSelectWin:onChooseButton()
local aimLayer=shiLianTaModel:getSectionSelectLayer()

local list={}
for i,v in pairs(_selectItemList)do
table.insert(list,v[1])
end
if#list>0 then
shiLianTaController.req_13_4(aimLayer,#list,list)
else
UIManager.error("请选择奖励")
end







end

function UIShiLianTaRewardSelectWin:onLeftButton()
if self.panelIndex and self.panelIndex>1 then
if self.selectedLayerIndex==self.panelIndex-1 then
self:refreshWin(self.aimLayer)
else
local layer=self.sectionLayerList[self.panelIndex-1].layer[1]
if layer then
self:refreshWin(layer)
end
end
self.ListPanel:setChildCanvasGroupAlpha(0)
self.ListPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
end

function UIShiLianTaRewardSelectWin:onRightButton()
if self.panelIndex and self.panelIndex<#self.sectionLayerList then
if self.selectedLayerIndex==self.panelIndex+1 then
self:refreshWin(self.aimLayer)
else
local layer=self.sectionLayerList[self.panelIndex+1].layer[1]
if layer then
self:refreshWin(layer)
end
end
self.ListPanel:setChildCanvasGroupAlpha(0)
self.ListPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
end

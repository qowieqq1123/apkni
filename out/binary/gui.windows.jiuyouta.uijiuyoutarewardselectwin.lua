







def_class("UIJiuYouTaRewardSelectWin",UIWindowBase)









function UIJiuYouTaRewardSelectWin:bindComponents()

self.chooseButton=UIButton.get(self,0)
self.closeButton=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.descBg=UIObject.get(self,3)
self.effect=UIObject.get(self,4)
self.leftButton=UIButton.get(self,5)
self.ListPanel=UIObject.get(self,6)
self.rightButton=UIButton.get(self,7)
self.title=UIText.get(self,8)
self.title2=UIText.get(self,9)
self.titleBg=UIImage.get(self,10)
self.titleBg2=UIObject.get(self,11)

self.chooseButton:setButtonClick(function()self:onChooseButton()end)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIJiuYouTaRewardSelectWin")end)

self.leftButton:setButtonClick(function()self:onLeftButton()end)

self.rightButton:setButtonClick(function()self:onRightButton()end)



end


function UIJiuYouTaRewardSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chooseButton);self.chooseButton=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.leftButton);self.leftButton=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.rightButton);self.rightButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.titleBg2);self.titleBg2=nil;
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



function UIJiuYouTaRewardSelectWin:onLoaded(...)
self:bindComponents()


self:sortLayerList()

UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",false)
end


function UIJiuYouTaRewardSelectWin:__delete()
self:unbindComponents()
_selectIndex=nil
_selectItem=nil
_lastSelectIndex=nil
_selectItemList={}
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",true)
end




function UIJiuYouTaRewardSelectWin:onShow(argtable,afterOnloaded)
self:initLayerList()
end


function UIJiuYouTaRewardSelectWin:onHide()

end

function UIJiuYouTaRewardSelectWin:onRecv()
self:initLayerList()
end

function UIJiuYouTaRewardSelectWin:sortLayerList()
local list={}

local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
self.rankType=rankType
local config=JiuYouTaModel:getRankConfig(rankType)
for i,v in ipairs(config)do
if v.stage_reward then
local layer=v.layer_id

table.insert(list,{layer_id=layer,stage_reward=v.stage_reward,stage_range=v.stage_range})
end
end

self.sectionLayerList=list
end

function UIJiuYouTaRewardSelectWin:initLayerList()
_selectIndex=nil
_selectItem=nil
_lastSelectIndex=nil
_selectItemList={}

local list=self.sectionLayerList
local curSection=nil
for i,v in ipairs(list)do
if not self:isSectionFin(i)then
curSection=i
break
end
end

if not curSection then
UIManager.error("已领取所有通关奖励")
self:closeSelf()
return
end

self.curSectionIdx=curSection
self:refreshWin(self.curSectionIdx)
end

function UIJiuYouTaRewardSelectWin:isSectionFin(index)
local data=self.sectionLayerList[index]
local isFin=true
for i,v in ipairs(data.stage_range)do
if not JiuYouTaModel:isSectionRewardGot(data.layer_id,i)then
isFin=false
end
end
return isFin
end

function UIJiuYouTaRewardSelectWin:refreshWin(index)
local clearLayer=JiuYouTaModel:getClearLayer()

self.panelIndex=index

local layer=self.sectionLayerList[index].layer_id

self.Clear=clearLayer>=layer

self.leftButton:setActive(self.panelIndex>self.curSectionIdx)

self.rightButton:setActive(self.panelIndex<#self.sectionLayerList)
_layer=layer
if JiuYouTaModel:getSectionRewardState()then
self:showClearPanel()
else
self:showNotClearPanel()
end

self.effect:setChildShowEffect(10053,self.Clear)
end

function UIJiuYouTaRewardSelectWin:showNotClearPanel()
self.isAimLayer=false
self.chooseButton:setActive(false)

self.title2:setText(title2Txt[1])
self.titleBg:setActive(true)
self.titleBg2:setActive(false)
self.chooseButton:setActive(false)

local clearLayer=JiuYouTaModel:getClearLayer()
local data=self.sectionLayerList[self.panelIndex]
local needClear=nil
local itemList={}
for i,v in ipairs(data.stage_range)do
if clearLayer<v and not needClear then
needClear=v
end
if not JiuYouTaModel:isSectionRewardGot(data.layer_id,i)then
table.insert(itemList,{i,data.stage_reward[i]})
end
end

self.itemList=itemList
self.title:setText(FMT.fmt(titleTxt[1],needClear or _layer))
self:initRewardList()
end

function UIJiuYouTaRewardSelectWin:showClearPanel()


local curLayer=JiuYouTaModel:getSectionSelectLayer()or _layer
self.title:setText(FMT.fmt(titleTxt[2],curLayer))

self.titleBg:setActive(false)
self.titleBg2:setActive(true)

self.isAimLayer=self.curSectionIdx==self.panelIndex

if self.isAimLayer then
local clearLayer=JiuYouTaModel:getClearLayer()
local data=self.sectionLayerList[self.panelIndex]
local gotTimes=0
local clearTimes=0
local itemList={}
for i,v in ipairs(data.stage_range)do
if clearLayer>=v then
clearTimes=clearTimes+1
end

if JiuYouTaModel:isSectionRewardGot(data.layer_id,i)then
gotTimes=gotTimes+1
else
table.insert(itemList,{i,data.stage_reward[i]})
end
end

self.selectTimes=clearTimes-gotTimes
self.itemList=itemList
self.title2:setText(FMT.fmt(title2Txt[2],self.selectTimes))
else
local itemList={}
for i,v in ipairs(self.sectionLayerList[self.panelIndex].stage_reward)do
table.insert(itemList,{i,v})
end
self.itemList=itemList
self.title2:setText("<color=#d3b97a>请先选取上一轮奖励</color>")
end

self.chooseButton:setActive(self.isAimLayer)
self:initRewardList()
end

function UIJiuYouTaRewardSelectWin:initRewardList()
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
local idx=itemData[1]
local itemId=itemData[2][1][1]
local count=itemData[2][1][2]

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

function UIJiuYouTaRewardSelectWin:fillItem(grid,itemid,count,itemConfig,i)
if not grid then
return
end
grid:SetBaseItemClickEvent(0,function(id,index,guid,attach)self:itemClick(id,index,guid,attach,grid,i)end)
grid:SetBaseItemLongTouchEvent(0,function(id,index,guid,attach)
self:itemClick(id,index,guid,attach)
end)
local conf={
itemid=itemid,
itemcount=count>1 and count or'',
showCountBG=count>1,
showname=false
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local color=itemConfig.color

if self.Clear then
prop[PropIndex(DataPropKey.eWidgetQualityEffect,_itemWidgetIdx.effect)]=color
else
prop[PropIndex(DataPropKey.eWidgetQualityEffect,_itemWidgetIdx.effect)]=-1
end

prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
grid:SetChildPropData(0,prop)
end
function UIJiuYouTaRewardSelectWin:onClickItemCallbackNew(index,item)
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

function UIJiuYouTaRewardSelectWin:onItemClick(id,index,guid,attach,grid,i)
if self.Clear then
self:onClickItemCallbackNew(i,grid)
else
self:itemClick(id,index,guid,attach)
end
end

function UIJiuYouTaRewardSelectWin:itemClick(id,index,guid,attach)
if itemsConfig.isGubao(id)then
gubaoController:gubaoShowTips(id)
return
end
itemsComponentHelper.onItemClick(id,index,guid,attach)
end






function UIJiuYouTaRewardSelectWin:onChooseButton()

local list={}
for i,v in pairs(_selectItemList)do
table.insert(list,v[1])
end
if#list>0 then
JiuYouTaController.req_13_23(_layer,list)
else
UIManager.error("请选择奖励")
end

end

function UIJiuYouTaRewardSelectWin:onLeftButton()

if self.panelIndex and self.panelIndex>1 and not self:isSectionFin(self.panelIndex-1)then
self:refreshWin(self.panelIndex-1)
self.ListPanel:setChildCanvasGroupAlpha(0)
self.ListPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
end

function UIJiuYouTaRewardSelectWin:onRightButton()
if self.panelIndex and self.panelIndex<#self.sectionLayerList then
self:refreshWin(self.panelIndex+1)
self.ListPanel:setChildCanvasGroupAlpha(0)
self.ListPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
end

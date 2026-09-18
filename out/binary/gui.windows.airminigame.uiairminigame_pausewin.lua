







def_class("UIAirMiniGame_pauseWin",UIWindowBase)









function UIAirMiniGame_pauseWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.infoTitle=UIText.get(self,2)
self.infoAttrGridGroup=UIObject.get(self,3)
self.bagItemScrollView=UIScrollViewSlow.get(self,4)
self.selectItemInfo=UIObject.get(self,5)
self.model=UIObject.get(self,6)
self.equipsList=UIObject.get(self,7)
self.simpleAttrGroup=UIObject.get(self,8)
self.changeInfoBtn=UIButton.get(self,9)
self.changeInfoBtnText=UIText.get(self,10)
self.continueBtn=UIButton.get(self,11)
self.restartBtn=UIButton.get(self,12)
self.exitBtn=UIButton.get(self,13)
self.attrPanel=UIObject.get(self,14)
self.equipPanel=UIObject.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.changeInfoBtn:setButtonClick(function()self:onChangeInfoBtn()end)

self.continueBtn:setButtonClick(function()self:onContinueBtn()end)

self.restartBtn:setButtonClick(function()self:onRestartBtn()end)

self.exitBtn:setButtonClick(function()self:onExitBtn()end)



end


function UIAirMiniGame_pauseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.infoTitle);self.infoTitle=nil;
_UIObject_release(self.infoAttrGridGroup);self.infoAttrGridGroup=nil;
_UIObject_release(self.bagItemScrollView);self.bagItemScrollView=nil;
_UIObject_release(self.selectItemInfo);self.selectItemInfo=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.equipsList);self.equipsList=nil;
_UIObject_release(self.simpleAttrGroup);self.simpleAttrGroup=nil;
_UIObject_release(self.changeInfoBtn);self.changeInfoBtn=nil;
_UIObject_release(self.changeInfoBtnText);self.changeInfoBtnText=nil;
_UIObject_release(self.continueBtn);self.continueBtn=nil;
_UIObject_release(self.restartBtn);self.restartBtn=nil;
_UIObject_release(self.exitBtn);self.exitBtn=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.equipPanel);self.equipPanel=nil;
end
















local bagItemCmpIndex={
bg=0,
qualityIcon=1,
icon=2,
select=3,
stageBg=4,
stageText=5,
countBg=6,
countText=7,
suitIcon=8,
}

local equipItemCmpIndex={
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemStage=3,
cmpItemStageBg=4,
cmpCountBg=5,
cmpStar=6,
cmpSuitIcon=7,
cmpSelect=8,
cmpClick=9,
}
local bagColumn=4
local bagMinRow=4

local needClampAttrList={
[aiAttributeType.eLifeSteal]=true,
[aiAttributeType.eAttckSpeed]=true,
[aiAttributeType.eCirticalRate]=true,
[aiAttributeType.eDodge]=true,
[aiAttributeType.eAddBossDamage]=true,
[aiAttributeType.eAddEliteDamage]=true,
[aiAttributeType.ePriceReduct]=true,
}
local oppositeAttrList={
[aiAttributeType.ePriceReduct]=true,
[aiAttributeType.eRecvDamage]=true,
}



function UIAirMiniGame_pauseWin:onLoaded(...)
self:bindComponents()
self.bagItemScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)

self.bagItemScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

end


function UIAirMiniGame_pauseWin:__delete()

airController:pauseGame(false)
self:unbindComponents()
end




function UIAirMiniGame_pauseWin:onShow(argtable,afterOnloaded)

airController:pauseGame(true)
self.selectInfoIndex=1
self:refresh(true,true)
end


function UIAirMiniGame_pauseWin:onHide()

end

function UIAirMiniGame_pauseWin:refresh(isInit,isResetAttr)

self:refreshInfoPanel(isInit,isResetAttr)


self:refreshBagPanel(isInit)
end

function UIAirMiniGame_pauseWin:refreshInfoPanel(isInit,isResetAttr)

local actorLevel=airModel:getLevel()
local vocId=airModel:getVocationId()
local jobStr=UIDiscipleModel:getJobName(vocId)
self.infoTitle:setText(FMT.fmt("{0}：{1}级",jobStr,actorLevel))

if isResetAttr then
self.attrList,self.attrList_checkName=self:getAttrSortList()
end

if self.selectInfoIndex==1 then

self.equipPanel:setActive(true)
self.attrPanel:setActive(false)
self:refreshInfoPanel_equip(isInit,isResetAttr)
elseif self.selectInfoIndex==2 then

self.equipPanel:setActive(false)
self.attrPanel:setActive(true)
self:refreshInfoPanel_attr(isResetAttr)
end
end

function UIAirMiniGame_pauseWin:refreshBagPanel(isInit)

self.bagItemList=self:getBagItemSortList()
local count=#self.bagItemList
if isInit then
if count>0 then
self.selectBagItemIndex=1
else
self.selectBagItemIndex=nil
end
end
local minCount=bagMinRow*bagColumn
if count<=0 then
count=minCount
end

local row=math.ceil(count/bagColumn)
if row<bagMinRow then
row=bagMinRow
elseif row>=bagMinRow then
row=row+2
end

self.bagItemScrollView:freshSlowGrids(row*bagColumn,row,bagColumn,isInit)


self:refreshSelectBagItemInfo()
end

function UIAirMiniGame_pauseWin:refreshSelectBagItemInfo()
if self.selectBagItemIndex then

self.selectItemInfo:setActive(true)
local widget=self.selectItemInfo:getWidgetBase()
local itemInfo=self.bagItemList[self.selectBagItemIndex]
local itemId=itemInfo.itemId
local itemConfig=cfgHelper.get(cfg_airitemconfig_get,itemId)


local itemName=itemConfig.name
local itemColor=itemConfig.color
widget:SetChildText(0,FMT.cfmt(itemColor,itemName))


local attrList=self:getItemAttrSortList(itemId)
local grids=widget:GetChildCommonLayoutGroupWidgetList(1)
for i=1,grids.Count do
local attrWidget=grids[i-1]
local attrData=attrList[i]
if attrData then
attrWidget:SetChildActive(-1,true)
local attrId=attrData.attrId
local attrVal=attrData.attrVal
local isPercent=attrData.isPercent
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname

attrWidget:SetChildText(0,FMT.fmt("{0}：",attrName))
local attrValStr
if not isPercent then
attrValStr=airController:getAttrStr(attrId,attrVal)
else
local percent=attrVal/100
percent=math.floor(percent)
attrValStr=FMT.fmt("{0}%",percent)
end

if attrVal>=0 then
attrValStr=FMT.fmt("+{0}",attrValStr)
if oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
else
if not oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
end
attrWidget:SetChildText(1,attrValStr)
else
attrWidget:SetChildActive(-1,false)
end
end


local itemDesc=itemConfig.desc
if itemDesc then

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
itemDesc=string.gsub(itemDesc," ","\194\160")
end
widget:SetChildActive(2,true)
widget:SetChildText(2,FMT.fmt("道具效果：{0}",itemDesc))
else
widget:SetChildActive(2,false)
end
else

self.selectItemInfo:setActive(false)
end
end

function UIAirMiniGame_pauseWin:bindGrid(idx,widget)
widget:SetChildActive(-1,true)
local index=idx
local itemInfo=self.bagItemList[index]
local isTemp=itemInfo==nil
if not isTemp then
local itemid=itemInfo.itemId

local itemcount=itemInfo.itemCount
local itemConfig=cfgHelper.get(cfg_airitemconfig_get,itemid)
local color=itemConfig.color
local stage=itemConfig.stage
local showStage=stage~=nil
local iconName=FMT.fmt("icon_item_{0}",itemConfig.icon)
local stageTitile="品"
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local isSelect=self.selectBagItemIndex==index
local suitIcon=''
local showCountBG=itemcount>1
local countStr=showCountBG and mathHelper.formatNumber(itemcount)or''

widget:SetChildQulaityEx(bagItemCmpIndex.qualityIcon,0,color)
widget:SetChildIcon(bagItemCmpIndex.icon,iconName,false)
widget:SetChildActive(bagItemCmpIndex.select,isSelect)
widget:SetChildActive(bagItemCmpIndex.stageBg,showStage)
widget:SetChildText(bagItemCmpIndex.stageText,stageStr)
widget:SetChildText(bagItemCmpIndex.countText,countStr)
widget:SetChildActive(bagItemCmpIndex.countBg,showCountBG)

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,-1)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
widget:SetChildActive(6,false)
widget:SetChildText(7,'')

widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIAirMiniGame_pauseWin:refreshInfoPanel_equip(isInit,isResetAttr)
if isInit then

self:refreshDzModel()
end


local equipItemList=airModel:getEquipList()or{}
local equipItemGrids=self.equipsList:getChildCommonLayoutGroupWidgetList()
for i=1,equipItemGrids.Count do
local widget=equipItemGrids[i-1]
local itemId=equipItemList[i]
if itemId then
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)

local iconName=FMT.fmt("icon_item_{0}",itemCfg.icon)
widget:SetChildQulaityEx(equipItemCmpIndex.cmpItemQualityIdx,0,itemCfg.color)
widget:SetChildIcon(equipItemCmpIndex.cmpItemIconIdx,iconName,false)

local isSelect=self.selectEquipItemIndex and self.selectEquipItemIndex==i
widget:SetChildActive(equipItemCmpIndex.cmpSelect,isSelect)

widget:SetChildButtonClick(equipItemCmpIndex.cmpClick,function()
self:onEquipItemClick(i,itemId)
end,true)

else

widget:SetChildActive(equipItemCmpIndex.cmpItemQualityIdx,false)
widget:SetChildActive(equipItemCmpIndex.cmpItemIconIdx,false)
widget:SetChildText(equipItemCmpIndex.cmpItemTxtCount,'')
widget:SetChildText(equipItemCmpIndex.cmpItemStage,'')
widget:SetChildActive(equipItemCmpIndex.cmpItemStageBg,false)
widget:SetChildActive(equipItemCmpIndex.cmpCountBg,false)
widget:SetChildGroundStarNum(equipItemCmpIndex.cmpStar,0)
widget:SetChildStarNumber(equipItemCmpIndex.cmpStar,0)
widget:SetChildIcon(equipItemCmpIndex.cmpSuitIcon,'',false)
widget:SetChildActive(equipItemCmpIndex.cmpSelect,false)
widget:SetChildButtonClick(equipItemCmpIndex.cmpClick,function()
end,true)
end
end
































end

function UIAirMiniGame_pauseWin:refreshInfoPanel_attr(isResetAttr)






self.infoAttrGridGroup:setChildLayoutGroupCreateItems(#self.attrList_checkName,function(index)
local attrWidget=self.infoAttrGridGroup:getChildLayoutGroupGridItem(index-1)
local attr=self.attrList_checkName[index]
local isEmpty=attr.isEmpty
if isEmpty then
attrWidget:SetChildActive(3,false)
else
attrWidget:SetChildActive(3,true)
local attrId=attr.attrId
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.simpleName or attrCfg.attrname
attrWidget:SetChildText(0,attrName)
local attrVal=attr.attrVal
if needClampAttrList[attrId]then

attrVal=airActorSystem:getActorClampAttrVal(attrId,attrVal)
end
local attrValStr=airController:getAttrStr(attrId,attrVal,nil,true)
if needClampAttrList[attrId]then

local maxAttrVal=airActorSystem:getActorClampAttrMaxVal(attrId)
if maxAttrVal then
local attrMaxValStr=airController:getAttrStr(attrId,maxAttrVal,nil,true)
attrValStr=FMT.fmt("{0}/{1}",attrValStr,attrMaxValStr)
end
end
if attrCfg.flag==1 then


local attrAddValP=airActorSystem:getActorAttrAddPercentByAttrId(attrId)or 0
local relevantAttrId=attrCfg.relevantAttr
if relevantAttrId then

local relevantAttrVal=airActorSystem:getActorAttrValByAttrId(relevantAttrId)
if relevantAttrVal and relevantAttrVal~=0 then
local relevantAttrCfg=cfgHelper.get(cfg_airattributesconfig_get,relevantAttrId)
if relevantAttrCfg and relevantAttrCfg.flag==2 then

attrAddValP=attrAddValP+relevantAttrVal
end
end
end

if attrAddValP and attrAddValP~=0 then
attrAddValP=math.floor(attrAddValP/100)
local addAttrValStr=FMT.fmt("{0}%",attrAddValP)
if attrAddValP>0 then
addAttrValStr=FMT.fmt("+{0}",addAttrValStr)
end
attrValStr=FMT.fmt("{0}({1})",attrValStr,addAttrValStr)
end
end

if attrVal<0 then
if not oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
else
if oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
end
attrWidget:SetChildText(1,attrValStr)
attrWidget:SetChildButtonClick(2,function()
self:onAttrItemClick(index,attrId)
end,true)
end
end)

end

function UIAirMiniGame_pauseWin:getAttrSortList()
local attrList_lookup=airActorSystem:getActorAttrList_lookup()
local sortList={}
for attrId,attrVal in pairs(attrList_lookup)do
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local isHide=attrCfg.isHide
if not isHide then
local weight=attrCfg.showSortId
sortList[#sortList+1]={
attrId=attrId,
attrVal=attrVal,
weight=weight,
}
end
end

table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

local checkNameList={}
local attrItemCount=0
for i,v in ipairs(sortList)do
local attrId=v.attrId
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local isSingleRow=attrCfg.isSingleRow
if isSingleRow then
if attrItemCount%2>0 then
attrItemCount=attrItemCount+1
table.insert(checkNameList,{isEmpty=true})
end

attrItemCount=attrItemCount+2
v.isSingleRow=true
table.insert(checkNameList,v)
table.insert(checkNameList,{isEmpty=true})
else
attrItemCount=attrItemCount+1
table.insert(checkNameList,v)
end
end

return sortList,checkNameList
end

function UIAirMiniGame_pauseWin:refreshDzModel()
local modelParams=airActorSystem:getActorModelParam()


self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)


local mountModelParams,node,scale=airActorSystem:getActorMountModelParams()

if mountModelParams then
local modelId=mountModelParams.model
local offset=mountModelParams.offset
local offsetV=Vector3.New(offset[1],offset[2],offset[3])
self.model:setChildUIModelMount(modelId,{},node,scale,offsetV,nil)


self.model:setChildUIModelShowFlipX(true)
end
end

function UIAirMiniGame_pauseWin:setOutSideChildMount(modelParams,widget,index,node,scale,offsetX,offsetY,action)
local offset=modelParams.offset or{}
offsetX=offsetX or offset[1]or 0
offsetY=offsetY or offset[2]or 0
local offsetZ=offset[3]or 1
local modelId=modelParams.model
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'scales')or{}
scale=scale or scaleArgs[2]or 1
node=node or'zuoqidian'
comHelper.setChildMount(widget,index,modelId,{},node,scale,offsetX,offsetY,offsetZ,action)
if api_Available_SetChildUIModelMountSeparatorSlot()then
if modelParams.spSlot~=nil then
widget:SetChildUIModelMountSeparatorSlot(index,modelParams.spSlot)
end
end
end

function UIAirMiniGame_pauseWin:getItemAttrSortList(itemId)
if not self.itemAttrListLookup then
self.itemAttrListLookup={}
end

if self.itemAttrListLookup[itemId]then
return self.itemAttrListLookup[itemId]
end
local attrListLookup=airModel:getItemAttrListLookup(itemId)
local sortList={}
for attrId,v in pairs(attrListLookup)do
local sortId
if not v.cfgIdx then
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
sortId=attrCfg.showSortId
else
sortId=v.cfgIdx
end
sortList[#sortList+1]={
attrId=attrId,
attrVal=v.val,
isPercent=v.isPercent,
sortId=sortId,
}
end

table.sort(sortList,function(a,b)
return a.sortId<b.sortId
end)

self.itemAttrListLookup[itemId]=sortList
return self.itemAttrListLookup[itemId]
end

function UIAirMiniGame_pauseWin:getBagItemSortList()
local bagItemList=airModel:getItemBag()
local sortList={}
for i,v in ipairs(bagItemList)do
local itemId=v.itemId
local itemConfig=cfgHelper.get(cfg_airitemconfig_get,itemId)
local color=itemConfig.color
sortList[#sortList+1]={
itemId=itemId,
itemCount=v.itemCount,
color=color,
}
end

table.sort(sortList,function(a,b)
if a.color==b.color then
return a.itemId<b.itemId
else
return a.color>b.color
end
end)

return sortList
end




function UIAirMiniGame_pauseWin:onCloseBtn()
end



function UIAirMiniGame_pauseWin:onMask()
end



function UIAirMiniGame_pauseWin:onChangeInfoBtn()
if self.selectInfoIndex==1 then
self.selectInfoIndex=2
elseif self.selectInfoIndex==2 then
self.selectInfoIndex=1
end

self:refreshInfoPanel()
end



function UIAirMiniGame_pauseWin:onContinueBtn()
self:closeSelf()
end



function UIAirMiniGame_pauseWin:onRestartBtn()
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
local fubenCfg=cfg_airfubenconfig_get(fbId)
local level=fubenCfg.idx


local isNeedCost=airGameEnterModel:checkNeedCostStart(level)
if isNeedCost then










UIManager.error("今日挑战次数不足")
return
end


airController:reqRestartGame()
self:closeSelf()
end



function UIAirMiniGame_pauseWin:onExitBtn()


airLevelSystem:onClearNowLevel()
airController:returnBackGame()
self:closeSelf()
end


function UIAirMiniGame_pauseWin:onEquipItemClick(idx,itemId)

if self.selectEquipItemIndex then
local widget=self.equipsList:getChildCommonLayoutGroupWidgetItem(self.selectEquipItemIndex-1)
widget:SetChildActive(equipItemCmpIndex.cmpSelect,false)
end

self.selectEquipItemIndex=idx
local widget=self.equipsList:getChildCommonLayoutGroupWidgetItem(idx-1)
widget:SetChildActive(equipItemCmpIndex.cmpSelect,true)


self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=itemId,itemType=1,fromType=3,equipIndex=idx})
end

function UIAirMiniGame_pauseWin:onAttrItemClick(idx,attrId)
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
if not attrCfg.desc then
return
end

local widget=self.infoAttrGridGroup:getChildLayoutGroupGridItem(idx-1)
local posVector2=widget:GetChildScreenPointToLocalPointRectangle(-1)
local halfTipsWeight=334/2
local halfItemWeight=180/2
local posX=posVector2.x+halfItemWeight+halfTipsWeight-20
local posY=posVector2.y


self:showWindow("UIAirMiniGame_attrTipsWin",{attrId=attrId,pos={posX,posY}})
end

function UIAirMiniGame_pauseWin:onClickGrid(id,index,guid,attach)
local itemid=id
if itemid==-1 then return end
local originalSelectBagItemIndex=self.selectBagItemIndex
self.selectBagItemIndex=index


self.bagItemScrollView:freshSlowItem(originalSelectBagItemIndex-1)
self.bagItemScrollView:freshSlowItem(index-1)


self:refreshSelectBagItemInfo()
end

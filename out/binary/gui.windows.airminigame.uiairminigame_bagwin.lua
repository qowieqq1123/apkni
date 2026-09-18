







def_class("UIAirMiniGame_bagWin",UIWindowBase)









function UIAirMiniGame_bagWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.bagItemScrollView=UIScrollViewSlow.get(self,2)
self.selectItemInfo=UIObject.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.infoTitle=UIText.get(self,5)
self.infoAttrGridGroup=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIAirMiniGame_bagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.bagItemScrollView);self.bagItemScrollView=nil;
_UIObject_release(self.selectItemInfo);self.selectItemInfo=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.infoTitle);self.infoTitle=nil;
_UIObject_release(self.infoAttrGridGroup);self.infoAttrGridGroup=nil;
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




function UIAirMiniGame_bagWin:onLoaded(...)
self:bindComponents()
self.bagItemScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)

self.bagItemScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
end


function UIAirMiniGame_bagWin:__delete()
self:unbindComponents()
end




function UIAirMiniGame_bagWin:onShow(argtable,afterOnloaded)
self:refresh(true,true)
end


function UIAirMiniGame_bagWin:onHide()

end

function UIAirMiniGame_bagWin:refresh(isInit,isResetAttr)

self:refreshInfoPanel(isResetAttr)


self:refreshBagPanel(isInit)
end


function UIAirMiniGame_bagWin:refreshInfoPanel(isResetAttr)

local actorLevel=airModel:getLevel()
local vocId=airModel:getVocationId()
local jobStr=UIDiscipleModel:getJobName(vocId)
self.infoTitle:setText(FMT.fmt("{0}：{1}级",jobStr,actorLevel))


if isResetAttr then
self.attrList=self:getAttrSortList()
end
self.infoAttrGridGroup:setChildLayoutGroupCreateItems(#self.attrList,function(index)
local attrWidget=self.infoAttrGridGroup:getChildLayoutGroupGridItem(index-1)
local attr=self.attrList[index]
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

function UIAirMiniGame_bagWin:getAttrSortList()
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

return checkNameList
end

function UIAirMiniGame_bagWin:refreshBagPanel(isInit)

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

function UIAirMiniGame_bagWin:refreshSelectBagItemInfo()
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

function UIAirMiniGame_bagWin:bindGrid(idx,widget)
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

function UIAirMiniGame_bagWin:getItemAttrSortList(itemId)
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

function UIAirMiniGame_bagWin:getBagItemSortList()
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




function UIAirMiniGame_bagWin:onCloseBtn()
self:closeSelf()
end



function UIAirMiniGame_bagWin:onMask()
self:onCloseBtn()
end

function UIAirMiniGame_bagWin:onAttrItemClick(idx,attrId)

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

function UIAirMiniGame_bagWin:onClickGrid(id,index,guid,attach)
local itemid=id
if itemid==-1 then return end
local originalSelectBagItemIndex=self.selectBagItemIndex
self.selectBagItemIndex=index


self.bagItemScrollView:freshSlowItem(originalSelectBagItemIndex-1)
self.bagItemScrollView:freshSlowItem(index-1)


self:refreshSelectBagItemInfo()
end

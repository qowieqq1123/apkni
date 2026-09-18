







def_class("UIEquipJinglianWin",UIWindowBase)









function UIEquipJinglianWin:bindComponents()

self.leftDialogue=UIButton.get(self,0)
self.disciplePanel=UIObject.get(self,1)
self.leftPanel=UIObject.get(self,2)
self.effectRoot=UIObject.get(self,3)
self.leftdialogueinfo=UIObject.get(self,4)
self.showItem=UIBaseItem.get(self,5)
self.desc=UIText.get(self,6)
self.equipList=UIObject.get(self,7)
self.effect1=UIObject.get(self,8)
self.effect2=UIObject.get(self,9)
self.effect3=UIObject.get(self,10)
self.effect4=UIObject.get(self,11)
self.effect0=UIObject.get(self,12)
self.effect=UIObject.get(self,13)
self.effect5=UIObject.get(self,14)
self.ScrollView=UIScrollViewSlow.get(self,15)
self.Dropdown3Mask=UIObject.get(self,16)
self.Dropdown2_Dialogue=UIDropdownEx.get(self,17)
self.Dropdown1_Dialogue=UIDropdownEx.get(self,18)
self.putBtnReddot_Dialogue=UIObject.get(self,19)
self.attrRoot_11=UIObject.get(self,20)
self.attrRoot_10=UIObject.get(self,21)
self.attrRoot_12=UIObject.get(self,22)
self.attrRoot_8=UIObject.get(self,23)
self.attrRoot_9=UIObject.get(self,24)
self.attrRoot_6=UIObject.get(self,25)
self.attrRoot_5=UIObject.get(self,26)
self.attrRoot_4=UIObject.get(self,27)
self.attrRoot_3=UIObject.get(self,28)
self.attrRoot_7=UIObject.get(self,29)
self.attrRoot_1=UIObject.get(self,30)
self.attrRoot_2=UIObject.get(self,31)
self.rightItem=UIObject.get(self,32)
self.leftItem=UIObject.get(self,33)
self.Dropdown3=UIDropdownEx.get(self,34)
self.Dropdown2=UIDropdownEx.get(self,35)
self.Dropdown1=UIDropdownEx.get(self,36)
self.item1=UIBaseItem.get(self,37)
self.item2=UIBaseItem.get(self,38)
self.item3=UIBaseItem.get(self,39)
self.item4=UIBaseItem.get(self,40)
self.item5=UIBaseItem.get(self,41)
self.name=UIText.get(self,42)
self.progressBar=UIProgressBarAni.get(self,43)
self.progressCountReverse=UIText.get(self,44)
self.jinglianlevel=UIText.get(self,45)
self.progressBarReverse=UIProgressBarAni.get(self,46)
self.progressCount=UIText.get(self,47)
self.newReddot=UIObject.get(self,48)
self.putBtnReddot=UIObject.get(self,49)
self.discipleList=UIScrollView.get(self,50)

self.leftDialogue:setButtonClick(function()self:onLeftDialogue()end)
self.attrRoot={
self.attrRoot_1,
self.attrRoot_2,
self.attrRoot_3,
self.attrRoot_4,
self.attrRoot_5,
self.attrRoot_6,
self.attrRoot_7,
self.attrRoot_8,
self.attrRoot_9,
self.attrRoot_10,
self.attrRoot_11,
self.attrRoot_12,
}



end


function UIEquipJinglianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftDialogue);self.leftDialogue=nil;
_UIObject_release(self.disciplePanel);self.disciplePanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.leftdialogueinfo);self.leftdialogueinfo=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.equipList);self.equipList=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Dropdown3Mask);self.Dropdown3Mask=nil;
_UIObject_release(self.Dropdown2_Dialogue);self.Dropdown2_Dialogue=nil;
_UIObject_release(self.Dropdown1_Dialogue);self.Dropdown1_Dialogue=nil;
_UIObject_release(self.putBtnReddot_Dialogue);self.putBtnReddot_Dialogue=nil;
_UIObject_release(self.attrRoot_11);self.attrRoot_11=nil;
_UIObject_release(self.attrRoot_10);self.attrRoot_10=nil;
_UIObject_release(self.attrRoot_12);self.attrRoot_12=nil;
_UIObject_release(self.attrRoot_8);self.attrRoot_8=nil;
_UIObject_release(self.attrRoot_9);self.attrRoot_9=nil;
_UIObject_release(self.attrRoot_6);self.attrRoot_6=nil;
_UIObject_release(self.attrRoot_5);self.attrRoot_5=nil;
_UIObject_release(self.attrRoot_4);self.attrRoot_4=nil;
_UIObject_release(self.attrRoot_3);self.attrRoot_3=nil;
_UIObject_release(self.attrRoot_7);self.attrRoot_7=nil;
_UIObject_release(self.attrRoot_1);self.attrRoot_1=nil;
_UIObject_release(self.attrRoot_2);self.attrRoot_2=nil;
_UIObject_release(self.rightItem);self.rightItem=nil;
_UIObject_release(self.leftItem);self.leftItem=nil;
_UIObject_release(self.Dropdown3);self.Dropdown3=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressCountReverse);self.progressCountReverse=nil;
_UIObject_release(self.jinglianlevel);self.jinglianlevel=nil;
_UIObject_release(self.progressBarReverse);self.progressBarReverse=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.newReddot);self.newReddot=nil;
_UIObject_release(self.putBtnReddot);self.putBtnReddot=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
self.attrRoot=nil;
end

















local _remove=table.remove
local _insert=table.insert

local _bag_filter_desc={}
local _colomn=4
local _row=5
local _maxAttrLine=7
local _fillItemLen=5
local _colorFormat=
{
[eQualityColor.eGreen]='#4f851b',
[eQualityColor.eBlue]='#1b4385',
[eQualityColor.ePurple]='#431b85',
[eQualityColor.eOrange]='#85451b',
[eQualityColor.eRed]='#851b1b',

}
local _getIconName=function(color)
return FMT.fmt('icon_jingliantp_{0}',color-1)
end

local _getBgName=function(color)
return FMT.fmt('image_jinglianbg_{0}',color-1)
end

local _getAttrColor=function(attrId,val,itemsStage)
local const_def=cfg_discipleequipjinglianconfig().const_def
local attrcolor=const_def.attrcolor
local attrColortable=attrcolor[attrId][itemsStage]
local flag=cfg_attributesconfig_get(attrId).flag
if flag==2 then
val=val/100
elseif flag==3 then
val=val*100
end
for k,v in pairs(attrColortable)do
if val>=v[1]and(v[2]==nil or val<v[2])then
return k
elseif k>=#attrColortable then
return k
end
end
loggerUtil.logErrFMT('属性{0}阶数{1}没有找到值{2}对应的颜色',attrId,itemsStage,val)
end

local _upImg={1,4,5,2,}
local atlasAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
}
local _equipTypeLookup={}
for k,v in pairs(equipSlotIndex)do
_equipTypeLookup[v]=k
end

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpSelect=14,
xmicons=15,
xmstagetxt=16,
}



function UIEquipJinglianWin:onLoaded(...)
self:bindComponents()

self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleList:setClickAction(self._on_select_dis)
self.isInitDiscipleList=false

self.equipListWidget=self.equipList:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do
self.equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget:SetBaseItemChildIndex(idx,equipType)
end

self.showItem:setBaseItemClickEvent(function(...)self:onCostItemClick(...)end)
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self.Dropdown3:setDropdownCreatedAction(function(...)self:onDropdown3Created(...)end)
self.Dropdown1_Dialogue:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown2_Dialogue:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)

self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)

self.ScrollView:setSlowLongClickAction(function(...)self:onClickLongGridButton(...)end)

local colorlist=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以下',eQualityColorName[color])
end)

local stagelist=table.toTable(1,EQUIP_STAGE_MAX)
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(stagelist,function(stage)
return FMT.fmt('{0}阶及以下',stage)
end)

self.leftDialogue:setActive(false)


local itemsList={}
self.itemsList=itemsList
itemsList[#itemsList+1]=self.item1
itemsList[#itemsList+1]=self.item2
itemsList[#itemsList+1]=self.item3
itemsList[#itemsList+1]=self.item4
itemsList[#itemsList+1]=self.item5

for _,v in ipairs(itemsList)do
v:setBaseItemClickEvent(function(...)self:onSelectItemClick(...)end)
end

self:resetData()

self.filter={}
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.filter[ITEM_FILTER_TYPE.eColor]=0

self.unlockItem={}




self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.checkList={}







end


function UIEquipJinglianWin:__delete()
self.isRefreshingPutBtnReddot=nil
self.needRefreshPutBtnReddot=nil
self.Dropdown1:setChangeAction(nil)
self.Dropdown2:setChangeAction(nil)
self.Dropdown1_Dialogue:setChangeAction(nil)
self.Dropdown2_Dialogue:setChangeAction(nil)

local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid

notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
self:unbindComponents()

self.isInitDiscipleList=false


equipsModel:saveEquipJingLianDropDownIdx()
self:stopBehavior()


discipleEquipSheetReddot:resetConfig()


end




function UIEquipJinglianWin:onShow(argtable,afterOnloaded)
self:freshEquip(argtable)
end

function UIEquipJinglianWin:freshEquip(argtable)
self:resetData()
if argtable then
local itemguid=argtable.itemguid
self.item=equipsHelper.getEquip(itemguid)
local isEquip=equipsModel.isEquipedOnAnyDizi(itemguid)
self.isEquip=isEquip
end

self.disciplelist={}
if self.isEquip then
self.disciple_guid=equipsModel.getDiziguidByItemguid(argtable.itemguid)
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={true}
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
for i,v in ipairs(list)do
local equipList=equipsModel.getAllEquipsByDizi(v.netData.net.discipleguid)
if equipList and#equipList>0 then
_insert(self.disciplelist,v)
end
end
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
end
local len=#self.disciplelist
if len>0 then
if not self.isInitDiscipleList then
self.isInitDiscipleList=true
self:refreshDiscipleList()
self:refreshEquipList()
else
self.discipleList:setActive(true)
self.equipList:setActive(true)
end
end
self.disciplePanel:setActive(len>0)
if not self.isEquip then
self.equipList:setActive(false)
end

self:freshInfo()

self.JinglianLvIdx=nil
self.Dropdown3Mask:setActive(self.JinglianLvIdx==nil)


self:refreshPutBtnReddot()
end


function UIEquipJinglianWin:onHide()
self.discipleList:setActive(false)
self.equipList:setActive(false)
end



function UIEquipJinglianWin:resetData()
self.selectItemsLookup={}
self.selectList={}
self.addExp=0
self.leftExp=0
self.overExp=0
self.addItemExp=0
self.addLastItemExp=0
self.addLv=0
self.randNum=0
self.curPageIndex=1
self.isSetZero=false
self.isNewList={}
end

function UIEquipJinglianWin:freshInfo()
self:setShowItems()
self:setProgress()
self:setCostItems()
self:setDropdowns()
self:setSelectItems()
self:setAttrs()
end

function UIEquipJinglianWin:setShowItems()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetIcon,0,itemsModel.getIconName(item))
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetText,1,itemsConfig.getItemName(itemid))
self.showItem:setChildItemData(DataPropKey.eItemID,itemid)
self.showItem:setChildItemData(DataPropKey.eItemSeries,itemguid)

local maxlv=equipsConfig.getJinglianMaxLvByItemid(self.item.itemid)
self.desc:setText(FMT.fmt('当前装备最高可精炼至{0}级',maxlv))


end

function UIEquipJinglianWin:freshAddExp()
local selectItems=self.selectList or{}
local addItemExp,addExp,addLv,leftExp,overExp,randNum=self:getJinglianData(selectItems)
self.addItemExp=addItemExp
self.addExp=addExp
self.addLv=addLv
self.leftExp=leftExp
self.randNum=randNum
self.overExp=overExp
end

function UIEquipJinglianWin:getJinglianData(selectItems)
local addItemExp=0
if selectItems then
for k,v in pairs(selectItems)do
local itemguid=v[1]
local num=v[2]
local item=equipsHelper.getEquip(itemguid)
if item then
addItemExp=addItemExp+equipsHelper.getJinglianValue(itemguid,num)
end
end
end
local item=self.item
local itemid=item.itemid
local equipType=equipsConfig.getEquipType(itemid)
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianexp=item.itemData and item.itemData.jinglianexp or 0
local addLv,leftExp,overExp=equipsHelper.getAddJinglianLv(itemid,jinglianlv,jinglianexp,addItemExp)
local addExp=addItemExp-leftExp

local randNum=0
if addLv>0 then
for i=jinglianlv,jinglianlv+addLv-1 do
local jinglianConfig=equipsConfig.getJinglianConfig(equipType,i)
if jinglianConfig and jinglianConfig.rand then
randNum=randNum+1
end
end
end

return addItemExp,addExp,addLv,leftExp,overExp,randNum
end



function UIEquipJinglianWin:setProgress()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local maxlv=equipsConfig.getJinglianMaxLvByItemid(self.item.itemid)
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianexp=item.itemData and item.itemData.jinglianexp or 0
local duration=self.progressAni and 0.5 or 0
local durationReverse=self.progressReverseAni and 0.5 or 0
local addExp=self.addExp
local addLv=self.addLv
local curIsFull=jinglianlv>=maxlv
local lastAddExp=self.addLastItemExp
self.addLastItemExp=self.addItemExp
if curIsFull then
self.progressBar:animateThreeParams(100,100,duration)
self.progressBarReverse:animateThreeParams(0,100,durationReverse)
self.progressCount:setText('已满')
self.progressCountReverse:setText('')
else
local curExp=jinglianexp
local curShowExp=curExp
local fillExp=self.leftExp
local maxExp=0
local targetlv=addLv+jinglianlv
local isFull=targetlv>=maxlv
local addItemExp=self.addItemExp
local tExp=0
if addLv<=0 then
maxExp=equipsConfig.getJinglianExp(equipType,jinglianlv,itemConfig.stage)
else
if not isFull then
maxExp=equipsConfig.getJinglianExp(equipType,targetlv,itemConfig.stage)
else
maxExp=equipsConfig.getJinglianExp(equipType,maxlv-1,itemConfig.stage)
fillExp=fillExp+maxExp
end
if addLv>0 and not(addLv==1 and jinglianlv==maxlv-1)then
curShowExp=0
end
end
if addItemExp==0 then
fillExp=curShowExp
end
self.progressBar:animateThreeParams(curShowExp,maxExp,duration,false)
self.progressBarReverse:animateThreeParams(self.progressReverseAni and fillExp or curShowExp,maxExp,durationReverse)
self.progressCount:setText(FMT.fmt('{0}/{1}',math.floor(fillExp),maxExp))
self.progressCountReverse:setText(FMT.fmt('+{0}',math.floor(self.addItemExp)))
end
self.jinglianlevel:setText(addLv>0 and FMT.fmt('当前：{0}级  +{1}',jinglianlv,addLv)or
FMT.fmt('当前：{0}级',jinglianlv))
self.progressAni=false
self.progressReverseAni=false
end

function UIEquipJinglianWin:setCostItems()
local components={}
components[#components+1]=self.leftItem
components[#components+1]=self.rightItem

local item=self.item
local itemguid=item.itemguid
local maxlv=equipsConfig.getJinglianMaxLvByItemid(item.itemid)
local curlv=item.itemData and item.itemData.jinglianlv or 0
local targetlv=self.addLv+curlv
if targetlv>maxlv then targetlv=maxlv end

local consumelist=equipsHelper.getJinglianCost(itemguid,self.addItemExp-self.overExp,targetlv)
for i,v in ipairs(components)do
local costInfo=consumelist[i]
v:setActive(costInfo~=nil)
if costInfo then
local itemid=costInfo[1]
self.checkList[itemid]=true
local cost=costInfo[2]
local has=moneyModel.getMoney(itemid)
local costStr=has>=cost and cost or FMT.cfmt(FONT_COLOR.eRedColor,cost)

local widget=self.winlua:GetChildWidgetBase(v:getID())
widget:SetChildIcon(0,iconHelper.getIconName(itemid),false)
widget:SetChildText(1,costStr)
end
end
end


function UIEquipJinglianWin:setDropdowns()
local stageDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eStage]
local colorDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eColor]
local JinglianLvDescList=self:getJinglianLvDescList()
self.Dropdown1:setOption(stageDescList)
self.Dropdown2:setOption(colorDescList)
self.Dropdown3:setOption(JinglianLvDescList)
self.Dropdown1_Dialogue:setOption(stageDescList)
self.Dropdown2_Dialogue:setOption(colorDescList)

self.stageIdx=equipsModel:getEquipJingLianDropDownIdx(ITEM_FILTER_TYPE.eStage)
self.colorIdx=equipsModel:getEquipJingLianDropDownIdx(ITEM_FILTER_TYPE.eColor)

self.Dropdown1:setValue(self.stageIdx)
self.Dropdown2:setValue(self.colorIdx)
self.Dropdown1_Dialogue:setValue(self.stageIdx)
self.Dropdown2_Dialogue:setValue(self.colorIdx)

self:selectFilterStage(self.stageIdx)
self:selectFilterColor(self.colorIdx)

end


function UIEquipJinglianWin:refreshPutBtnReddot()
if self.isRefreshingPutBtnReddot then
self.needRefreshPutBtnReddot=true
end
self.isRefreshingPutBtnReddot=true

local item=self.item
local itemguid=item.itemguid
local reddot=equipsHelper.checkEquipIsCanJingLian(itemguid)
self.putBtnReddot:setActive(reddot)
self.newReddot:setActive(reddot)
self.putBtnReddot_Dialogue:setActive(reddot)
self.isRefreshingPutBtnReddot=nil
if self.needRefreshPutBtnReddot then
self.needRefreshPutBtnReddot=nil
return self:refreshPutBtnReddot()
end
end


function UIEquipJinglianWin:setAttrs()
local onJinglianFinish=self.onJinglianFinish
if onJinglianFinish then
self:setMacthAttr()
return
end
local attrsCmpList=self.attrRoot
local tlen=#attrsCmpList
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local addLv=self.addLv
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local baseAttrsLookup=equipsHelper.getJinglianBaseAttrs(itemid,jinglianlv)
self.baseAttrsLookup=table.deepCopy(baseAttrsLookup)
local nextBaseAttrsLookup=addLv>0 and equipsHelper.getJinglianBaseAttrs(itemid,jinglianlv+self.addLv)or{}
local temp={}
for attrType,attrValue in pairs(baseAttrsLookup)do
local addValue=(nextBaseAttrsLookup[attrType]or attrValue)-attrValue
temp[#temp+1]={attrType,attrValue,0,addValue}
end
if#temp>1 then
table.sort(temp,function(a,b)
return cfg_attributesconfig_get(a[1]).priority<cfg_attributesconfig_get(b[1]).priority
end)
end
local baseLen=#temp
for i=1,math.min(baseLen,_maxAttrLine)do
self:fillAttr(i,temp[i])
end
local useIdx=baseLen

local randomAttr=equipsHelper.getRandomAttrList(item)or{}
self.randomAttrLookup=attrListHelper.tramsformToLookup(randomAttr)
local len=#randomAttr
local index=1
if(useIdx+len)<=_maxAttrLine then
for i=useIdx+1,useIdx+len do
self:fillAttr(i,randomAttr[index],true)
index=index+1
end
else
loggerUtil.logErrFMT("属性条数超过了{0}条",_maxAttrLine)
return
end
useIdx=useIdx+len

if useIdx<_maxAttrLine+1 then
if len+self.randNum<5 then
if self.randNum>0 then
local desc=FMT.cfmt(eQualityColor.eGreen,FMT.fmt('增加{0}条新的随机属性',self.randNum))
self:fillDescAttr(useIdx+1,desc)
useIdx=useIdx+1
end
end
if len>=4 and self.randNum>0 then
local content=self.randNum>1 and'随机提升{0}条随机属性(可相同)'or'随机提升{0}条随机属性'
local desc=FMT.cfmt(eQualityColor.eGreen,FMT.fmt(content,self.randNum))
self:fillDescAttr(useIdx+1,desc)
useIdx=useIdx+1
end
if len<4 and len+self.randNum>=5 then
local upNum=len>=4 and self.randNum or self.randNum-(4-len)
local content=upNum>1 and'随机提升{0}条随机属性(可相同)'or'随机提升{0}条随机属性'
local desc=FMT.cfmt(eQualityColor.eGreen,FMT.fmt(content,upNum))
self:fillDescAttr(useIdx+2,desc)
useIdx=useIdx+2
end












else

return
end

if useIdx<_maxAttrLine+1 then
for i=useIdx+1,tlen do
self.attrRoot[i]:setActive(false)
end
end
end

function UIEquipJinglianWin:setMacthAttr()
local attrsCmpList=self.attrRoot
local tlen=#attrsCmpList
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local addLv=self.addLv
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local lastbaseAttrsLookup=self.baseAttrsLookup
local baseAttrsLookup=equipsHelper.getJinglianBaseAttrs(itemid,jinglianlv)
local newLookup=attrListHelper.getNewLookup(lastbaseAttrsLookup,baseAttrsLookup)
local baseAttrslist=attrListHelper.sortByLookup(baseAttrsLookup)
for i,v in ipairs(baseAttrslist)do
self:fillDiffAttr(i,v,newLookup,lastbaseAttrsLookup)
end

local useIdx=#baseAttrslist
local randomAttr=equipsHelper.getRandomAttrList(item)or{}
local newLookup=attrListHelper.getNewLookup(self.randomAttrLookup,attrListHelper.tramsformToLookup(randomAttr))
local len=#randomAttr
local index=1
if(useIdx+len)<=_maxAttrLine then
for i=useIdx+1,useIdx+len do
self:fillDiffAttr(i,randomAttr[index],newLookup,self.randomAttrLookup,true)
index=index+1
end
else
loggerUtil.logErrFMT("属性条数超过了{0}条",_maxAttrLine)
return
end
useIdx=useIdx+len

if useIdx<_maxAttrLine+1 then
for i=useIdx+1,tlen do
self.attrRoot[i]:setActive(false)
end
end
end

function UIEquipJinglianWin:fillDiffAttr(index,attr,newLookup,lastbaseAttrsLookup,isRandom)
local cmpObject=self.attrRoot[index]
cmpObject:setActive(attr~=nil)
if attr then
local attrId=attr[1]
local lastVal=lastbaseAttrsLookup[attrId]or 0
local isNew=newLookup[attrId]==true
local val=attr[2]or 0
local addValue=val-lastVal
local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
local name,lastValStr,ifMod=equipsHelper.getAttr(attrId,lastVal,TO_INT_TYPE.eDown)
local name,addValStr,ifMod=equipsHelper.getAttr(attrId,addValue,TO_INT_TYPE.eDown)
local name,valStr,ifMod=equipsHelper.getAttr(attrId,val,TO_INT_TYPE.eDown)

local hasAdd=(ifMod and mathHelper.decimal(addValue)or math.floor(addValue))>0
local showUp=not isNew and hasAdd or false

local upCount=attr[3]or 0
local haveUp=upCount>0

widget:SetChildActive(0,isRandom)
widget:SetChildActive(2,isRandom and(showUp or haveUp))
if not isNew then
addValStr=FMT.fmt('(+{0})',addValStr)
end
widget:SetChildText(3,isRandom and showUp and addValStr or'')
widget:SetChildActive(4,isRandom)

if haveUp then
widget:SetChildCSImageSprite(2,iconHelper.globalSpriteBundle1,FMT.fmt("icon_jiantou_{0}",_upImg[upCount]))
end

widget:SetChildText(6,haveUp and FMT.fmt("x{0}",upCount)or'')


if isRandom then
local itemConfig=itemsConfig.getConfig(self.item.itemid)
local attrColor=_getAttrColor(attrId,val,itemConfig.stage)
widget:SetChildCSImageSprite(0,globalABLookup.equipJinglian,_getIconName(attrColor))
widget:SetChildCSImageSprite(4,globalABLookup.equipJinglian,_getBgName(attrColor))
lastValStr=not isNew and FMT.fmt('<color={0}>{1}：{2}</color>',_colorFormat[attrColor],name,lastValStr)or
FMT.fmt('<color={0}>{1}：{2}</color>',_colorFormat[attrColor],name,addValStr)
else
lastValStr=FMT.fmt('<color=#7d3b17>{0}：</color>{1}',name,valStr)
end
widget:SetChildText(1,lastValStr)
widget:SetChildActive(5,isNew)
end
end

function UIEquipJinglianWin:fillAttr(index,attr,isRandom)
local cmpObject=self.attrRoot[index]
cmpObject:setActive(attr~=nil)
if attr then
local attrId=attr[1]
local addValue=attr[4]or 0
local iconname=''
local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
local name,valstr,ifMod=equipsHelper.getAttr(attrId,attr[2],TO_INT_TYPE.eDown)
local handleValue=ifMod and mathHelper.decimal(addValue)or math.floor(addValue)

local upCount=attr[3]or 0
local haveUp=upCount>0

local hasAdd=handleValue and handleValue>0 or false

widget:SetChildActive(0,isRandom)
widget:SetChildActive(2,hasAdd or haveUp)
if hasAdd then
local addValStr=ifMod and FMT.fmt('(+{0}%)',mathHelper.decimal(addValue))or FMT.fmt('(+{0})',math.floor(addValue))
widget:SetChildText(3,addValStr)
else
widget:SetChildText(3,'')
end
widget:SetChildActive(4,isRandom)

if haveUp then
widget:SetChildCSImageSprite(2,iconHelper.globalSpriteBundle1,FMT.fmt("icon_jiantou_{0}",_upImg[upCount]))
end

widget:SetChildText(6,haveUp and FMT.fmt("x{0}",upCount)or'')

if isRandom then
local itemConfig=itemsConfig.getConfig(self.item.itemid)
local attrColor=_getAttrColor(attrId,attr[2],itemConfig.stage)
widget:SetChildCSImageSprite(0,globalABLookup.equipJinglian,_getIconName(attrColor))
widget:SetChildCSImageSprite(4,globalABLookup.equipJinglian,_getBgName(attrColor))
valstr=FMT.fmt('<color={0}>{1}：{2}</color>',_colorFormat[attrColor],name,valstr)
else
valstr=FMT.fmt('<color=#7d3b17>{0}：</color>{1}',name,valstr)
end
widget:SetChildText(1,valstr)
widget:SetChildActive(5,false)
end
end

function UIEquipJinglianWin:fillDescAttr(index,desc)
local cmpObject=self.attrRoot[index]
cmpObject:setActive(desc~=nil)

local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
widget:SetChildText(1,desc)
widget:SetChildActive(2,false)
widget:SetChildText(3,'')
end



function UIEquipJinglianWin:setSelectItems()
local selectList=self.selectList or{}
local itemsList=self.itemsList
for i,v in ipairs(itemsList)do
local selectInfo=selectList[i]or{}
local itemguid=selectInfo[1]
local num=selectInfo[2]or 0
local item=equipsHelper.getEquip(itemguid)
local showCountBG=false
local jinglianlv=item and item.itemData and item.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>1 and num or''
local conf={showname=false,itemcount=countStr,showcount=countStr~='',showCountBG=countStr~=''}
v:setChildPropData(self:getSelectFillData(item,conf))
end
end


function UIEquipJinglianWin:getSelectFillData(item,conf)
if item==nil then
return self:getSelectTempFillData()
end
local prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
return prop
end


function UIEquipJinglianWin:getSelectTempFillData()
local conf={}
conf.showbg=true
local prop=itemsComponentHelper.getTempFillData(conf)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
return prop
end

function UIEquipJinglianWin:getNextFillIdx(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then return index end
for i=1,_fillItemLen do
local info=selectList[i]
if not info then
return i
end
end
end

function UIEquipJinglianWin:getSelectNum(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
local selectTable=selectList[index]or{}
return selectTable[2]or 0
end
return 0
end


function UIEquipJinglianWin:tryPutItem(itemguid,canOverExp)
local addExp=equipsHelper.getJinglianValue(itemguid,1)
local addTExp=self.addItemExp or 0
local needMaxExp=equipsHelper.getJinglianValueToMaxLevelOnItem(self.item)
if self.JinglianLvIdx then
local JinglianLvDescList,levellist=self:getJinglianLvDescList()
local targetlevel=levellist[self.JinglianLvIdx+1]









needMaxExp=equipsHelper.getJinglianValueToTargetLevelOnItem(self.item,targetlevel)
end
local lastIsFull=addTExp>=needMaxExp
if lastIsFull then
if self.JinglianLvIdx then
UIManager.error('已达指定精炼等级最大经验，无法添加')
else
UIManager.error('已达到最大经验，无法添加')
end
return false
end
addTExp=addTExp+addExp
local leftExp=addTExp-needMaxExp
if leftExp>0 then
if not canOverExp then
if self.JinglianLvIdx then
UIManager.error('已达指定精炼等级最大经验，无法添加')
else
UIManager.error('已达到最大经验，无法添加')
end
return false
end
end
return true
end

function UIEquipJinglianWin:setSelectNum(itemguid,index,num)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
if num==0 then
self.selectList[index]=nil
self.selectItemsLookup[tostring(itemguid)]=nil
else
self.selectList[index]={itemguid,num}
self.selectItemsLookup[tostring(itemguid)]=index
end
self:freshAddExp()
self.progressReverseAni=true
self.progressAni=false
end

function UIEquipJinglianWin:getSelectIndex(itemguid)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
return self.selectItemsLookup[tostring(itemguid)]
end


function UIEquipJinglianWin:showProvideSelectGrids()
if self.showDialogue then return end
self.showDialogue=true
self.leftDialogue:setActive(true)
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-320,0.5)
self.Dropdown1_Dialogue:setValue(self.stageIdx)
self.Dropdown2_Dialogue:setValue(self.colorIdx)
self:freshProvideSelectGrids(true)
end

function UIEquipJinglianWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
self.curPageIndex=1
self.isSetZero=false
self.ScrollView:clearSlowItems()
local func=function(...)
self.leftDialogue:setActive(false)
self.Dropdown1:setValue(self.stageIdx)
self.Dropdown2:setValue(self.colorIdx)
end
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-890,0.1,func)
end

function UIEquipJinglianWin:onLeftDialogue()
self:onClickBg()
end

function UIEquipJinglianWin:isPutItem(itemguid)
for i=1,_fillItemLen do
local info=self.selectList[i]
if info and info[1]==itemguid and info[2]and info[2]>0 then
return true
end
end
return false
end

function UIEquipJinglianWin:freshBagList()
local bagList=equipsHelper.getMateriasOnBag(self.item.itemguid,nil,nil)or{}

local list={}
local looupup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
local guidStr=item.guidStr or tostring(item.itemguid)
if not looupup[guidStr]and self:isPutItem(item.itemguid)then
list[#list+1]=item
looupup[guidStr]=true
_remove(bagList,i)
end
end

for i,v in ipairs(list)do
_insert(bagList,1,v)
end
end

self.bagList=bagList
end

function UIEquipJinglianWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIEquipJinglianWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectNum(itemguid)
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
local has=num>0
local showbg=true
local isLock=bagHelper.isLock(itemInfo)
local isFabao=itemsConfig.isFabao(itemid)
local showStage=itemConfig.stage~=nil
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
local isLock=bagHelper.isLock(itemInfo)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widget:SetChildQulaity(2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,isLock)
widget:SetChildActive(10,has)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildLongPress(10,index,function(idx)self:longPressAction(idx)end,function(idx)self:finishlongPressAction(idx)end)
widget:SetChildLongPress(11,index,function(idx)self:longPressAction(idx,true)end,function(idx)self:finishlongPressAction(idx,true)end)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildLongPress(11,index,nil,nil)
widget:SetChildLongPress(10,index,nil,nil)
end
end

function UIEquipJinglianWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
if not flag then
widget:SetChildLongPressStop(10)
self.useGoodTime=nil
end
end
end

end

function UIEquipJinglianWin:freshProvideSingleGiridText(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
local num=self:getSelectNum(itemguid)
local info=self.bagList[idx]
local itemcount=info.itemcount or 0
local jinglianlv=info.itemData and info.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
end
end

end

function UIEquipJinglianWin:freshProvideGridLock(itemguid,isUnlock)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,isUnlock)
end
end
end

function UIEquipJinglianWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end



function UIEquipJinglianWin:onDropdownChange(dropidx,idx)

if dropidx==ITEM_FILTER_TYPE.eColor then
self:selectFilterColor(idx)
self.colorIdx=idx
elseif dropidx==ITEM_FILTER_TYPE.eStage then
self:selectFilterStage(idx)
self.stageIdx=idx
end
equipsModel:changeEquipJingLianDropDownIdx({self.stageIdx,self.colorIdx})


local win=UIManager:findActiveWindow('UIEquipWin')
if win then
win:freshItemsReddot({checkEquip=true})
end


self:refreshPutBtnReddot()
end


function UIEquipJinglianWin:selectFilterColor(val)
local filtertype=ITEM_FILTER_TYPE.eColor
self:onFilter(filtertype,val)
end


function UIEquipJinglianWin:selectFilterStage(val)
local filtertype=ITEM_FILTER_TYPE.eStage
self:onFilter(filtertype,val)
end

function UIEquipJinglianWin:onFilter(filtertype,val)
if self.filter[filtertype]==val then return end
self.filter[filtertype]=val
self:freshProvideSelectGrids(true)
end

function UIEquipJinglianWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshProvideSelectGrids()
end

function UIEquipJinglianWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:freshProvideGridLock(itemguid,isUnlock)
if self.unlockItem[tostring(itemguid)]then
self.unlockItem[tostring(itemguid)]=nil
self:putItem(itemguid)
end
end

function UIEquipJinglianWin:onCostItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIEquipJinglianWin:onSelectItemClick(itemid,index,itemguid,attach)
self:showProvideSelectGrids()
end

function UIEquipJinglianWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
self:putItem(itemguid)
end

function UIEquipJinglianWin:onItemListChanged(list)
if list==nil then return end
local needRefreshReddot=false
for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
if itemsConfig.isMoney(itemid)or equipsConfig.isJinglianItem(itemid)then
needRefreshReddot=true
break
end
end

if needRefreshReddot then
self:refreshPutBtnReddot()
end
end

function UIEquipJinglianWin:onMoneyChanged(moneyType)
self:refreshPutBtnReddot()
self:setCostItems()
end

function UIEquipJinglianWin:putItem(itemguid,addnum)
local num=self:getSelectNum(itemguid)
local item=equipsHelper.getEquip(itemguid)
local itemcount=item.itemcount
if not self:checkMaxLv()then
return
end
if num>=itemcount then
UIManager.error('物品已达上限')
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
return
end
if bagHelper.isLock(item)then
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'装备锁定','该装备已锁定，是否解锁并进行精炼消耗？')
self.dialog.okcallback=function()
bagProtocolControl.req_change_bag_item_lockflag(itemguid,true)
if self and not self.isClose then
self:onUnlockItem(itemguid)
end
end
self.dialog:show()
return
end
if not self:tryPutItem(itemguid,true)then
return
end
self.onJinglianFinish=false
local lastNum=num
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end
addnum=addnum or 1
num=num+addnum
self:setSelectNum(itemguid,fillIdx,num)
self:freshProvideSingleGiridText(itemguid)
self:setCostItems()
self:setSelectItems()
self:setProgress()
self:setAttrs()
return true
end

function UIEquipJinglianWin:onClickGridButton(itemid,index,itemguid,attach,delnum)
if itemid==-1 then return end
local num=self:getSelectNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
self.onJinglianFinish=false
delnum=delnum or 1
num=num-delnum
local selectIdx=self:getSelectIndex(itemguid)
self:setSelectNum(itemguid,selectIdx,num)
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSingleGiridText(itemguid)
self:setSelectItems()
self:setCostItems()
self:setProgress()
self:setAttrs()
return true
end


function UIEquipJinglianWin:onClickLongGridButton(itemid,index,itemguid,attach)
if itemid~=-1 then

self.islong=true
end
end

function UIEquipJinglianWin:onClickBg()
self:closeProvideSelectGrids()
end

function UIEquipJinglianWin:onJinglianClick()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local equipType=equipsConfig.getEquipType(itemid)
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local selectItems=self.selectList
local itemsTemp={}
local equipsTemp={}
local flag=false
for k,v in pairs(selectItems)do
local _itemguid=v[1]
local num=v[2]
local item=equipsHelper.getEquip(_itemguid)
if item then
local temp={_itemguid,num}
if itemsConfig.isItem(item.itemid)then
itemsTemp[#itemsTemp+1]=temp
else
equipsTemp[#equipsTemp+1]=_itemguid
end
flag=true
end
end
if flag==false then
UIManager.error('请放入精炼材料')
return
end
local maxlv=equipsConfig.getJinglianMaxLvByItemid(self.item.itemid)
local curlv=item.itemData and item.itemData.jinglianlv or 0
local targetlv=self.addLv+curlv
if targetlv>maxlv then targetlv=maxlv end
local ret,errType,errArgs=equipsHelper.isCanJinglian(itemguid,self.addItemExp,targetlv)
if not ret then
if errType==equipsHelper.jinglianErr.eNotEnoughMoney then
local moneyType=errArgs[1]
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足，不可精炼',moneyName))
gainControl:showGainWin(moneyType)
elseif errType==equipsHelper.jinglianErr.eLevelToCap then
UIManager.error('装备精炼等级达到上限')
elseif errType==equipsHelper.jinglianErr.eNotEnoughColor then
UIManager.error('紫色及以上的装备才能精炼')
end
return
end



local itemslen=#itemsTemp
local equipslen=#equipsTemp
local pos=0
local guid=itemguid
if self.isEquip then
guid=equipsModel.getDiziguidByItemguid(itemguid)
pos=equipType
end
local overrideStage=equipsConfig.getJinglianConstConfig().override or{}
local override=overrideStage[stage]or 0
local callback=function()
equipsProtocolControl.req_equip_jinglian(guid,pos,itemslen,itemsTemp,equipslen,equipsTemp)
end


if equipsModel:isEquipChongzhu(itemguid)then
self.dialogue=UIDialogManager.getConfirmDialog(self.dialogue,'提示','该装备还未确定是否接受重铸结果\n无法进行装备强化')
self.dialogue.okcallback=function()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipChongZhu,{itemguid=itemguid})
end
self.dialogue.oktext="前往重铸"
self.dialogue:show()
else
callback()
end







end


function UIEquipJinglianWin:onPutClick(hideError)

if not self:checkMaxLv()then
return
end
local stageDropIdx=self.filter[ITEM_FILTER_TYPE.eStage]
local colorDropIdx=self.filter[ITEM_FILTER_TYPE.eColor]
local filterStage=stageDropIdx+1
local filterColor=colorDropIdx+1
local filterList=equipsHelper.getMateriasOnBag(self.item.itemguid,filterStage,filterColor,true)or{}

local insertList=self.selectList or{}
local list,errType,errArgs=self:getJinglianMetrials(self.item,filterList,insertList,_fillItemLen)
if list and#list>0 then
self.onJinglianFinish=false
for _,v in ipairs(list)do
local itemguid=v[1]
local num=v[2]
local idx=self:getNextFillIdx(itemguid)
self:setSelectNum(itemguid,idx,num)
self:freshProvideSelectSingleGirid(itemguid,true)
end
self:setSelectItems()
self:setCostItems()
self:setProgress()
self:setAttrs()
else
if hideError then
return
end
if errType==equipsHelper.jinglianErr.eNotMaterials then
UIManager.error('没有材料可放入')
local itemid=equipsConfig.getdefaultJinglianItem()
gainControl:showGainWin(itemid)
elseif errType==equipsHelper.jinglianErr.eNotPos then
UIManager.error('当前无空位可放入')
elseif errType==equipsHelper.jinglianErr.eExpOver then
if self.JinglianLvIdx then
UIManager.error('已达指定精炼等级最大经验，无法添加')
else
UIManager.error('已达到最大经验，无法添加')
end
elseif errType==equipsHelper.jinglianErr.eNotEnoughMoney then
local moneyType=errArgs
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足，不可精炼',moneyName))
gainControl:showGainWin(moneyType)
end
end
end


function UIEquipJinglianWin:onJinglian(oldlv,newlv)
if newlv~=oldlv and self.overExp==0 then
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
end
self.onJinglianFinish=true
self.progressAni=true
self.progressReverseAni=false
self:startBehavior()
self:resetData()
self:freshInfo()
self:freshProvideSelectGrids(true)

local equipType=equipsConfig.getEquipType(self.item.itemid)
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
if equip and equipSlotIndex[equipType]~=nil then
self:fillItem(equip,equipSlotIndex[equipType])
end


self:refreshPutBtnReddot()

if self.JinglianLvIdx then
local upItem=self.item
local jinglianlv=upItem.itemData and upItem.itemData.jinglianlv or 0
local JinglianLvDescList,levellist=self:getJinglianLvDescList()
local targetlevel=levellist[self.JinglianLvIdx+1]

if targetlevel==jinglianlv then
self.JinglianLvIdx=nil
self.Dropdown3Mask:setActive(true)
else
self:onPutClick(true)
end
end
end

function UIEquipJinglianWin:checkMaxLv()
local upItem=self.item
local jinglianlv=upItem.itemData and upItem.itemData.jinglianlv or 0
local maxlv=equipsConfig.getJinglianMaxLvByItemid(upItem.itemid)
if jinglianlv>=maxlv then
UIManager.error('装备精炼等级达到上限')
return false
end
return true
end

function UIEquipJinglianWin:onUnlockItem(itemguid)
self.unlockItem[tostring(itemguid)]=true
end



function UIEquipJinglianWin:startBehavior()
local flag=0
for i=1,_fillItemLen do
local info=self.selectList[i]
if info then
flag=flag+math.pow(2,i-1)
end
end
local target0=self.effect0:getID()
local target1=self.effect1:getID()
local target2=self.effect2:getID()
local target3=self.effect3:getID()
local target4=self.effect4:getID()
local target5=self.effect5:getID()

local parent=self.effectRoot:getID()
local pos=self.winlua:GetChildPosition(target0)
local v0=Vector2.New(0,0)
local initData=
{
stateId=flag,
widget=self.winlua,
target0=target0,
target1=target1,
target2=target2,
target3=target3,
target4=target4,
target5=target5,
parent=parent,
pos=pos,
duration1=1,
duration2=1.1,
duration3=1.2,
duration4=1.3,
duration5=1.4,


eSlider1=Vector2.New(0.3,0.4),
oSlider1=Vector2.New(0.3,0.4),

eSlider2=Vector2.New(0.1,0.2),
oSlider2=Vector2.New(0.1,0.2),

eSlider3=Vector2.New(0,0),
oSlider3=Vector2.New(0,0),

eSlider4=Vector2.New(-0.1,-0.2),
oSlider4=Vector2.New(-0.1,-0.2),

eSlider5=Vector2.New(-0.3,-0.4),
oSlider5=Vector2.New(-0.3,-0.4),
}
self:stopBehavior()
self.bt=behaviorManager:addBehaviorTree('bt_ui_equip_jinglian_fly',nil,true,initData)

end

function UIEquipJinglianWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end


function UIEquipJinglianWin:getJinglianMetrials(item,list,insertlist,maxLen)


if list==nil or#list<=0 then
return false,equipsHelper.jinglianErr.eNotMaterials
end



local tempList={}
for i=1,maxLen do
if insertlist[i]==nil then
tempList[#tempList+1]=i
end
end
local inertLen=#tempList
if inertLen==0 then
return false,equipsHelper.jinglianErr.eNotPos
end


local outlist={}
local fillList={}
local idxList={}
local totalExp=0
local useHoleLen=0
local holeIdxList={}
local needMoneyType
local itemLen=#list

for i,v in pairs(insertlist)do
local itemguid=v[1]
local guidStr=tostring(itemguid)
local num=v[2]
local hasExp=equipsHelper.getJinglianValue(itemguid,num)
totalExp=totalExp+hasExp
outlist[tostring(itemguid)]=true
useHoleLen=useHoleLen+1
idxList[guidStr]=i
holeIdxList[i]=true
fillList[guidStr]={itemguid,v[2]}
end

local needMaxExp=equipsHelper.getJinglianValueToMaxLevelOnItem(item)

if self.JinglianLvIdx then
local JinglianLvDescList,levellist=self:getJinglianLvDescList()
local targetlevel=levellist[self.JinglianLvIdx+1]









needMaxExp=equipsHelper.getJinglianValueToTargetLevelOnItem(item,targetlevel)
end
if totalExp>=needMaxExp then
return false,equipsHelper.jinglianErr.eExpOver
end

local itemguid1=item.itemguid
local ret,moneyType=equipsHelper.isCanJinglianByCostMoney(itemguid1,totalExp)
if not ret then
return false,equipsHelper.jinglianErr.eNotEnoughMoney,moneyType
end

local sortTag={}
local temp=table.deepCopy(list)
for i,v in ipairs(temp)do
local exp=equipsHelper.getJinglianValue(v.itemguid,1)
sortTag[tostring(v.itemguid)]=itemsConfig.getMainType(v.itemid)*-10000000+exp*100-i
end


table.sort(temp,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)

local _getNextHole=function()
for i=1,maxLen do
if not holeIdxList[i]then
return i
end
end
end
local _putItem=function(itemguid,hasExp,holeIdx)
local guidStr=tostring(itemguid)
local targetExp=totalExp+hasExp
local targetlv=equipsHelper.getJinglianTargetLv(itemguid1,targetExp)
local ret,moneyType=equipsHelper.isCanJinglianByCostMoney(itemguid1,targetExp,targetlv)
if not ret then
needMoneyType=moneyType
return false
end
if holeIdxList[holeIdx]==nil then
holeIdxList[holeIdx]=true
idxList[guidStr]=holeIdx
useHoleLen=useHoleLen+1
end
local lastNum=(fillList[guidStr]or{})[2]or 0
lastNum=lastNum+1
fillList[guidStr]={itemguid,lastNum}
totalExp=totalExp+hasExp
return true
end

local compelementInfo={}
for i,v in ipairs(temp)do
local itemid=v.itemid
local count=v.itemcount
local itemguid=v.itemguid
local guidStr=tostring(itemguid)
if totalExp>=needMaxExp then break end
local lastNum=(fillList[guidStr]or{})[2]or 0
local alreadyPut=lastNum>0
local isNew=not alreadyPut
local leftCount=count-lastNum
local holeIdx=idxList[guidStr]
local isEquip=itemsConfig.isEquip(itemid)
if isEquip or isNew then
if(useHoleLen+1)>maxLen then break end
holeIdx=_getNextHole()
end
if leftCount>0 and holeIdx then
local hasExp=equipsHelper.getJinglianValue(itemguid,1)
local canPutExp=needMaxExp-totalExp
local max=math.floor(canPutExp/hasExp)
local cnt=math.min(max,leftCount)
for j=1,cnt do
if totalExp>=needMaxExp then break end
if _putItem(itemguid,hasExp,holeIdx)then
leftCount=leftCount-1
else
break
end
end
if leftCount>0 and totalExp<needMaxExp then
if(useHoleLen==maxLen or useHoleLen==itemLen)then
_putItem(itemguid,hasExp,holeIdx)
else
local lastExp=compelementInfo[1]
if lastExp==nil or lastExp>hasExp then
compelementInfo={hasExp,itemguid}
end
end
end
end
end
if totalExp<needMaxExp and#compelementInfo>0 then
local itemguid=compelementInfo[2]
local hasExp=compelementInfo[1]
local guidStr=tostring(itemguid)
local holeIdx=idxList[guidStr]
if holeIdx==nil then
holeIdx=_getNextHole()
end
if holeIdx then
_putItem(itemguid,hasExp,holeIdx)
end
end
if useHoleLen==0 then
if needMoneyType then
return false,equipsHelper.jinglianErr.eNotEnoughMoney,needMoneyType
end
return false,equipsHelper.jinglianErr.eNotMaterials
end
local finalList={}
for key,v in pairs(fillList)do
finalList[idxList[key]]=v
end

return finalList
end

function UIEquipJinglianWin:getJinglianLvDescList()
local item=self.item
local itemid=item.itemid
local equipType=equipsConfig.getEquipType(itemid)
local maxlv=equipsConfig.getJinglianMaxLvByItemid(self.item.itemid)
local templist={}
local levellist={}
for i=0,maxlv do
local jinglianConfig=equipsConfig.getJinglianConfig(equipType,i)
if jinglianConfig and jinglianConfig.rand and i+1<=maxlv then
templist[#templist+1]=FMT.fmt("+{0}级",i+1)
levellist[#levellist+1]=i+1
end
end
return templist,levellist
end

function UIEquipJinglianWin:onDropdown3Created()
local JinglianLvDescList,levellist=self:getJinglianLvDescList()
local len=#levellist
local upItem=self.item
local jinglianlv=upItem.itemData and upItem.itemData.jinglianlv or 0
for i=1,len do
local isGray=jinglianlv>=levellist[i]
local idx=i-1
local widget=self.Dropdown3:getDropdownItemWidget(idx)
widget:SetChildActive(1,true)
widget:SetChildButtonClick(1,function()
self:onDropdown3Click(idx,isGray)
end)

if isGray then
widget:SetChildCSImageSprite(2,atlasAb,"button_chuangkou_7")
end
widget:SetChildImageExGray(2,isGray)
widget:SetChildActive(3,idx==self.JinglianLvIdx)
end
self.Dropdown3Mask:setActive(self.JinglianLvIdx==nil)
end

function UIEquipJinglianWin:onDropdown3Click(idx,isGray)
if isGray then
UIManager.error("装备精炼等级已超过该等级")
return
end

if self.JinglianLvIdx==idx then
self.JinglianLvIdx=nil
local widget=self.Dropdown3:getDropdownItemWidget(idx)
widget:SetChildActive(3,false)

self:resetSelectItems()
else
self.JinglianLvIdx=idx
self.Dropdown3:hideList()
self.Dropdown3:setValue(self.JinglianLvIdx)

self:resetSelectItems()
self:onPutClick()
end
self.Dropdown3Mask:setActive(self.JinglianLvIdx==nil)
end


function UIEquipJinglianWin:resetSelectItems()







self:resetData()
self:freshInfo()
self:freshProvideSelectGrids(true)


self:refreshPutBtnReddot()
end


function UIEquipJinglianWin:longPressAction(idx,isAdd)
if isAdd and not self.islong then
return
end
local info=self.bagList[idx]
if not info then
self:StopItemLongPress(idx,isAdd and 11 or 10)
self.useGoodTime=nil
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local maxNum=isAdd and info.itemcount or self:getSelectNum(info.itemguid)
if num>maxNum then
num=maxNum
end
if isAdd then
if not self:putItem(info.itemguid,num)then
self:StopItemLongPress(idx,11)
self.useGoodTime=nil
end
else
if not self:onClickGridButton(info.itemid,idx,info.itemguid,nil,num)then
self:StopItemLongPress(idx,10)
self.useGoodTime=nil
end
end
end


function UIEquipJinglianWin:finishlongPressAction(idx,isAdd)
if isAdd then
self.islong=false
end
self.useGoodTime=nil
end

function UIEquipJinglianWin:StopItemLongPress(idx,index)
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildLongPressStop(index)
end
end



function UIEquipJinglianWin:refreshDiscipleList()
local tNum=#self.disciplelist
self.discipleList:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid



comHelper.setChildModelHeadIconBG(item,0,discipleguid)

UIDiscipleModel:setDiscipleXianMoHeadImage(item,8,netdata)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.disciple_guid,discipleguid)
if isSelect then
idx=i
self.curDisIndex=idx
end
self:changItemSelect(item,isSelect)

self:refreshItemReddot(item,i)
end
self.discipleList:jumpToLockX(idx)
end

function UIEquipJinglianWin:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UIEquipJinglianWin:refreshItemReddot(item,idx)
if item==nil then
item=self.discipleList:getGridObjectByindex(idx-1)
end













item:SetChildActive(6,false)
end

function UIEquipJinglianWin:refreshAllItemReddot()
for i,v in ipairs(self.disciplelist)do
self:refreshItemReddot(nil,i)
end
end

function UIEquipJinglianWin:on_select_dis(id,index,guid,attach)

if self.curDisIndex==index then return end

local oldItem=self.item
local old=self.curDisIndex
self.curDisIndex=index
if old then
local olditem=self.discipleList:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.discipleList:getGridObjectByindex(self.curDisIndex-1)
self:changItemSelect(item,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)

for equipType,idx in ipairs(equipSlotIndex)do
local equip=equipsModel.getEquipByDizi(self.disciple_guid,equipType)
if equip then
self.item=equipsHelper.getEquip(equip.itemguid)
break
end
end

local oldIsCanChongZhu=equipsHelper.isCanChongZhu(oldItem.itemguid)
local isCanChongZhu=equipsHelper.isCanChongZhu(self.item.itemguid)

local oldIsxm=equipsHelper.isEquipXM(oldItem.itemguid)
local isxm=equipsHelper.isEquipXM(self.item.itemguid)
local isxmzbfresh=oldIsxm~=isxm


if isCanChongZhu then

equipsProtocolControl.req_equip_2_91_ex(self.item.itemguid)
end

local argtable={itemguid=self.item.itemguid}
if oldIsCanChongZhu~=isCanChongZhu or isxmzbfresh then
local isOpen=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,argtable)
local isOpen2
local isOpen3
if not isOpen or isxmzbfresh then
oneTabScreenController:openUI(SEC_FULL_TYPE.equipSecondary,argtable)
end
else
oneTabScreenController:changeArgs(argtable,true)
end

self:refreshEquipList()
self:freshEquip(argtable)
end





function UIEquipJinglianWin:refreshEquipList()
for equipType,idx in ipairs(equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
self:fillItem(equip,idx)
end
end

function UIEquipJinglianWin:fillItem(equip,equipSlotIdx)
local prop={}
local equipType=_equipTypeLookup[equipSlotIdx]
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
end
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
end

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)

if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

local curEquipType=equipsConfig.getEquipType(self.item.itemid)
local isSelect=curEquipType==equipType
self:changEquipSelect(widget,isSelect)


local ninglianStar=equipsModel.getNingLianStar(equip)
if ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_jinlian1")
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_moyan1")
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIEquipJinglianWin:changEquipSelect(widget,isSelect)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,isSelect)
end

function UIEquipJinglianWin:onBaseItemClick(id,equipType,guid,attach)
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
if not equip then
if self.showType==dicipleType.eSystem then
equipListManager.showTips({movepos=TIPS_MOVE_POS.eLeft,diziguid=self.disciple_guid,equipType=equipType})
end
return
end
local oldEquipType=equipsConfig.getEquipType(self.item.itemid)
if oldEquipType==equipType then return end

local old=equipSlotIndex[oldEquipType]
if oldEquipType then
local oldWidget=self.equipListWidget:GetChildWidgetBase(old)
self:changEquipSelect(oldWidget,false)
end

local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIndex[equipType])
self:changEquipSelect(widget,true)

local equip=equipsModel.getEquipByDizi(self.disciple_guid,equipType)

local oldIsCanChongZhu=equipsHelper.isCanChongZhu(self.item.itemguid)
local isCanChongZhu=equipsHelper.isCanChongZhu(equip.itemguid)
local oldIsxm=equipsHelper.isEquipXM(self.item.itemguid)
local isxm=equipsHelper.isEquipXM(equip.itemguid)
local isxmzbfresh=oldIsxm~=isxm

if isCanChongZhu then

equipsProtocolControl.req_equip_2_91_ex(equip.itemguid)
end

local argtable={itemguid=equip.itemguid}
if oldIsCanChongZhu~=isCanChongZhu or isxmzbfresh then
local isOpen=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,argtable)
local isOpen2
local isOpen3
if not isOpen or isxmzbfresh then
oneTabScreenController:openUI(SEC_FULL_TYPE.equipSecondary,argtable)
end
else
oneTabScreenController:changeArgs(argtable,true)
end
self.onJinglianFinish=false
self:freshEquip(argtable)
end

function UIEquipJinglianWin:onChangeItem(guid,equipType)
if tostring(guid)~=tostring(self.disciple_guid)then return end
local diziguid=self.disciple_guid
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equipSlotIndex[equipType]~=nil then
self:fillItem(equip,equipSlotIndex[equipType])
end
equipListManager.closeTips()
end


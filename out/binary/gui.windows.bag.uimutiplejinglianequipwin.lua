







def_class("UIMutipleJingLianEquipWin",UIWindowBase)









function UIMutipleJingLianEquipWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.comfireBtn=UIButton.get(self,2)
self.costPart=UIObject.get(self,3)
self.Dropdown_1=UIDropdownEx.get(self,4)
self.Dropdown_2=UIDropdownEx.get(self,5)
self.Dropdown_3=UIDropdownEx.get(self,6)
self.Dropdown3Mask=UIObject.get(self,7)
self.equipScrollView=UIObject.get(self,8)
self.filterDropPart=UIObject.get(self,9)
self.itemCosts=UIObject.get(self,10)
self.moneyCostPart=UIObject.get(self,11)
self.moneyCosts=UIObject.get(self,12)
self.noselectAllBtn=UIButton.get(self,13)
self.ronglianBtn=UIButton.get(self,14)
self.Root=UIObject.get(self,15)
self.selectAllBtn=UIButton.get(self,16)
self.spineBg=UIObject.get(self,17)
self.uiRoot=UIObject.get(self,18)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.comfireBtn:setButtonClick(function()self:onComfireBtn()end)

self.noselectAllBtn:setButtonClick(function()self:onNoselectAllBtn()end)

self.ronglianBtn:setButtonClick(function()self:onRonglianBtn()end)

self.selectAllBtn:setButtonClick(function()self:onSelectAllBtn()end)
self.Dropdown={
self.Dropdown_1,
self.Dropdown_2,
self.Dropdown_3,
}



end


function UIMutipleJingLianEquipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.comfireBtn);self.comfireBtn=nil;
_UIObject_release(self.costPart);self.costPart=nil;
_UIObject_release(self.Dropdown_1);self.Dropdown_1=nil;
_UIObject_release(self.Dropdown_2);self.Dropdown_2=nil;
_UIObject_release(self.Dropdown_3);self.Dropdown_3=nil;
_UIObject_release(self.Dropdown3Mask);self.Dropdown3Mask=nil;
_UIObject_release(self.equipScrollView);self.equipScrollView=nil;
_UIObject_release(self.filterDropPart);self.filterDropPart=nil;
_UIObject_release(self.itemCosts);self.itemCosts=nil;
_UIObject_release(self.moneyCostPart);self.moneyCostPart=nil;
_UIObject_release(self.moneyCosts);self.moneyCosts=nil;
_UIObject_release(self.noselectAllBtn);self.noselectAllBtn=nil;
_UIObject_release(self.ronglianBtn);self.ronglianBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.selectAllBtn);self.selectAllBtn=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.Dropdown=nil;
end
















local _this

local _bag_filter_desc={}

local _passWarningType={
eNone=0,
eLoseMoney=1,
eLoseExp=2,
}

local _CmpEquipItemIndex={
smallItem=0,
lock=1,
unlock=2,
name=3,
attrList=4,
selectOp=5,
selected=6,
clickBtn=7,
lockClickBtn=8,
spritePlayer=9,
layout=10,
}




function UIMutipleJingLianEquipWin:onLoaded(...)
self:bindComponents()

_this=self

self.moneyItemList=self.moneyCosts:getChildCommonLayoutGroupWidgetList()
self.costItemList=self.itemCosts:getChildCommonLayoutGroupWidgetList()

self.Dropdown_1:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown_2:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self.Dropdown_3:setDropdownCreatedAction(function(...)self:onDropdown3Created(...)end)

self.equipScrollView:setChildScrollViewInit(0.5,true,nil,nil)

local colorlist=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以下',eQualityColorName[color])
end)

local stagelist=table.toTable(1,EQUIP_STAGE_MAX)
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(stagelist,function(stage)
return FMT.fmt('{0}阶及以下',stage)
end)

self.filter={}
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.filter[ITEM_FILTER_TYPE.eColor]=0

self.selectEquipSortDataList={}

local _equipLockRefresh=function(itemid,itemguid,isUnlock)
if _this==nil then return end
_this:refreshEquipLockState(itemguid)
end
self:addNotify(notifyConfig.on_item_lock_changed,_equipLockRefresh)

local _on_money_changed=function(itemid,itemguid,isUnlock)
if _this==nil then return end
_this:changePassCheckJingLianState()
_this:refreshCost()
end
self:addNotify(notifyConfig.on_money_changed,_on_money_changed)

local _recv_3_241=function()
if _this==nil then return end
_this:onRongLian()
end
self:addProNotify(3,241,_recv_3_241)

local _recv_2_35=function(len,list)
if _this==nil then return end
_this:onJingLian(len,list)
end
self:addProNotify(2,35,_recv_2_35)

local expItemLookUp=equipsConfig.getJinglianItemList()
local _on_item_list_changed=function(argslist,lookup_guidStr,lookup_itemid)
if _this==nil or lookup_itemid==nil then return end
local isNeedUpdate=false
for itemid,val in pairs(expItemLookUp)do
if lookup_itemid[itemid]then
isNeedUpdate=true
break
end
end
if isNeedUpdate then
_this:recalculateCostList()
_this:refreshCost()
_this:changePassCheckJingLianState()
end
end
self:addNotify(notifyConfig.on_item_list_changed,_on_item_list_changed)
end


function UIMutipleJingLianEquipWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMutipleJingLianEquipWin:onShow(argtable,afterOnloaded)

local isRecvJingLian=argtable and argtable.isRecvJingLian or false
self.equipGuidList=equipsModel.getBagMutipleJingLianEquipGuidList()

self:refreshAll(afterOnloaded)

if afterOnloaded and isRecvJingLian then
self.centerLayout:setChildCanvasGroupAlpha(0)
self.spineBg:setChildSpineAnimation(eAnimationID.enter,1)
self:delayDo(2,function()
_this.centerLayout:setChildCanvasGroupAlpha(1)
_this:firstPlay()
end)
end
if argtable then
argtable.isRecvJingLian=false
end
end


function UIMutipleJingLianEquipWin:onHide()

end





function UIMutipleJingLianEquipWin:onCloseBtn()
self.uiRoot:setChildCanvasGroupDOFade(0,0.5,function()
self:closeSelf()
end)
end



function UIMutipleJingLianEquipWin:onComfireBtn()
if self.selectEquipSortDataList==nil or next(self.selectEquipSortDataList)==nil then
UIManager.info("请选择装备")
return
end

if self.JinglianLvIdx==nil then
UIManager.info("请选择精炼等级")
return
end

if not self.passCheckJinglianState then
self:showNoPassWarningTips()
return
end

local toLevel=self.levellist[self.JinglianLvIdx+1]

local costItemList={}
local costEquipList={}

for index,costData in ipairs(self.selectedMaterialList)do
if itemsConfig.isEquip(costData.itemid)then
costEquipList[#costEquipList+1]=costData.itemguid
elseif itemsConfig.isItem(costData.itemid)then
costItemList[#costItemList+1]={costData.itemguid,costData.itemcount}
end
end


equipsProtocolControl.req_equip_mutiple_jinglian(
#self.canJingLianEquipGuidList,self.canJingLianEquipGuidList,
#costItemList,costItemList,
#costEquipList,costEquipList,
toLevel)
end



function UIMutipleJingLianEquipWin:onRonglianBtn()
if next(self.selectEquipSortDataList)==nil then
UIManager.info("请选择装备")
return
end

local canRongLianList={}
local showTipsList={}
for index,sortData in ipairs(self.selectEquipSortDataList)do
local isLock=bagHelper.isLock(sortData.itemData)
if not isLock then
canRongLianList[#canRongLianList+1]=sortData.itemData
end

if sortData.itemData.itemData.len>0 then
for _,randData in ipairs(sortData.itemData.itemData.randattrList)do
if randData.param_3>=4 and(not isLock)then
showTipsList[#showTipsList+1]={sortData,randData}
end
end
end
end

if next(canRongLianList)==nil then
UIManager.info("无可熔炼装备")
return
end

if next(canRongLianList)then
local ronglianReq=function()
local callback=function(itemGuidList,rlitems,xmEquipType)
UIFullBaGuaLuControl:setRongLianGUID(itemGuidList,rlitems,false,true,true)
end

local showdata=
{
type='UIDialougeRongLian',
title='提示',
oktext='确定',
canceltext='取消',
okcallback=callback,
showclosebtn=true,
allowclickBG=true,
itemInfoList=canRongLianList,
}

local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
if next(showTipsList)==nil then
ronglianReq()
else
local content
for index,tipsData in ipairs(showTipsList)do
local sortData=tipsData[1]
local randData=tipsData[2]

local itemid=sortData.itemData.itemid


local equipName=""
local suitid=sortData.itemData.itemData.suitid or 0
if suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
equipName=FMT.fmt("[{0}]",suitConfig.name)
end
local name=itemsConfig.getItemName(itemid)
equipName=FMT.fmt("{0}{1}",equipName,name)

local attrDesc=helper.getAttributeStr2(randData.param_1,randData.param_2,2,"<color='#7d3b17'>{0}</color>达到<color='#7d3b17'>{1}</color>")

local tips=FMT.fmt("装备{0}连续强化{1},是否熔炼？",toColorString(FONT_COLOR.eOrangeDescColor,equipName),attrDesc)

content=content and FMT.fmt("{0}\n{1}",content,tips)or tips
end

local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
showclosebtn=true,
okcallback=ronglianReq
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
else
UIManager.info("无可熔炼的装备")
end
end



function UIMutipleJingLianEquipWin:onSelectAllBtn()
self.isSelectAll=not self.isSelectAll

if self.isSelectAll then
for index,sortData in ipairs(self.sortEquipList)do
if not table.findValueEx(self.selectEquipSortDataList,sortData,function(data)return data.guidStr end)then
self:refreshEquipSelectedState(sortData,true)
end
end
else
for index,sortData in ipairs(self.sortEquipList)do
if table.findValueEx(self.selectEquipSortDataList,sortData,function(data)return data.guidStr end)then
self:refreshEquipSelectedState(sortData,true)
end
end
end

self:setSelectAllState(self.isSelectAll)
end

function UIMutipleJingLianEquipWin:onNoselectAllBtn()
self:onSelectAllBtn()
end

function UIMutipleJingLianEquipWin:setSelectAllState(state)
self.isSelectAll=state

self.selectAllBtn:setActive(not self.isSelectAll)
self.noselectAllBtn:setActive(self.isSelectAll)
end


function UIMutipleJingLianEquipWin:initData()
self:setSelectAllState(false)

self.JinglianLvDescList,self.levellist,self.maxlv,self.minlv=self:getJinglianLvDescList()

self.JinglianLvIdx=nil

self.passCheckJinglianState=false
self.passWarningType=_passWarningType.eNone
self.passWarningArgs=defaultT

self.selectEquipSortDataList={}

self:recalculateCostList()
end

function UIMutipleJingLianEquipWin:refreshAll(afterOnloaded)
self:initData()

self:refreshEquipList()
self:refreshCost()
self:refreshFilters()
end

function UIMutipleJingLianEquipWin:sortEquip()
self.sortEquipList={}
self.sortEquipLookUp={}

for index,guid in ipairs(self.equipGuidList)do
local temp={}
temp.guid=guid
temp.guidStr=tostring(guid)

local itemData=itemsModel.getItem(guid)
temp.itemData=itemData
temp.fightVal=equipsHelper.getEquipFight(guid)
temp.sortWeight=0

local randattrList=itemData.itemData and itemData.itemData.randattrList
if randattrList then
local maxCount=0
for _,infoData in ipairs(randattrList)do
local count=infoData.param_3
maxCount=Mathf.Max(maxCount,count)
end
temp.sortWeight=maxCount
end

self.sortEquipList[#self.sortEquipList+1]=temp
self.sortEquipLookUp[temp.guidStr]=temp
end

if next(self.sortEquipList)then
table.sort(self.sortEquipList,function(a,b)
if a.sortWeight==b.sortWeight then
return a.fightVal>b.fightVal
else
return a.sortWeight>b.sortWeight
end
end)
end

end

function UIMutipleJingLianEquipWin:refreshEquipList()
self:sortEquip()

local allLen=#self.equipGuidList

self.equipItemLookUp={}
self.equipScrollView:setChildScrollViewCreateGrids(allLen,allLen)

self.grids=self.equipScrollView:getChildScrollViewItemWidgets()
for index=1,self.grids.Count do
local item=self.grids[index-1]
self:bindEquipFunc(index,item)
end

self.equipScrollView:setChildScrollRectEnable(allLen>4)
end

local _playInterval=0.15
function UIMutipleJingLianEquipWin:firstPlay()

local interval=0.05

for index=1,self.grids.Count do
local item=self.grids[index-1]
item:SetChildCanvasGroupAlpha(_CmpEquipItemIndex.layout,0)


self:delayDo(interval,function()
item:SetChildAnimationStringID(_CmpEquipItemIndex.spritePlayer,"bbpljl_effect",false)
item:SetChildCanvasGroupDOFade(_CmpEquipItemIndex.layout,1,0.35)
end)
interval=interval+_playInterval
end
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

local _colorFormat=
{
[eQualityColor.eGreen]='#4f851b',
[eQualityColor.eBlue]='#1b4385',
[eQualityColor.ePurple]='#431b85',
[eQualityColor.eOrange]='#85451b',
[eQualityColor.eRed]='#851b1b',

}

local _upImgAB=globalABLookup.global
local _upEndIndex={1,6,4,5,2}
function UIMutipleJingLianEquipWin:bindEquipFunc(index,item)
local equipSortData=self.sortEquipList[index]

self.equipItemLookUp[equipSortData.guidStr]=item

local equipData=equipSortData.itemData
local equipGuid=equipData.itemguid
local itemid=equipData.itemid
local showCountBG=equipData.itemData.jinglianlv>1
local itemcount=showCountBG and string.format("+%d",equipData.itemData.jinglianlv)or""
local itemConfig=itemsConfig.getConfig(itemid)

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
local suitid=equipData.itemData.suitid or 0
if suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitIcon=iconHelper.getSuitIcon(suitConfig.icon)
propData[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon
end
item:SetChildPropData(_CmpEquipItemIndex.smallItem,propData)
item:SetBaseItemClickEvent(_CmpEquipItemIndex.smallItem,function(...)
if _this==nil then return end


local args={
itemid=itemid,
itemguid=equipGuid,
}
args.formType=TIPS_FORM_TYPE.eClearBtn
args.attach={}
tipsManager.showTips(args)
end)

local equipName=""
local suitid=equipData.itemData.suitid or 0
if suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
equipName=FMT.fmt("[{0}]",suitConfig.name)
end
local name=itemsConfig.getItemName(itemid)
equipName=FMT.fmt("{0}{1}",equipName,name)
item:SetChildText(_CmpEquipItemIndex.name,equipName)

local randAttrList=equipData.itemData.randattrList or defaultT
local attrItemList=item:GetChildCommonLayoutGroupWidgetList(_CmpEquipItemIndex.attrList)
for aIndex=1,attrItemList.Count do
local aitem=attrItemList[aIndex-1]
local randInfoData=randAttrList[aIndex]

local aIsShow=randInfoData~=nil
aitem:SetChildActive(-1,aIsShow)
if aIsShow then
local attrType=randInfoData.param_1
local attrVal=randInfoData.param_2
local randCount=randInfoData.param_3

local attrDesc=helper.getAttributeStr(attrType,attrVal,2,"{0}:{1}")
local attrColor=_getAttrColor(attrType,attrVal,itemConfig.stage)
attrDesc=FMT.fmt('<color={0}>{1}</color>',_colorFormat[attrColor],attrDesc)
aitem:SetChildText(0,attrDesc)

local aIsShowUp=randCount>0
aitem:SetChildActive(1,aIsShowUp)
aitem:SetChildActive(2,aIsShowUp)
if aIsShowUp then
local upCount=Mathf.Min(#_upEndIndex,randCount)
local upEndImg=_upEndIndex[upCount]
local upIconName=string.format("icon_jiantou_%d",upEndImg)

aitem:SetChildCSImageSprite(1,_upImgAB,upIconName)
aitem:SetChildText(2,FMT.fmt("X{0}",randCount))
end
end
end

self:refreshEquipLockState(equipSortData.guid)

self:refreshEquipSelectedState(equipSortData)

local _clickFunc=function()
if _this==nil then return end

_this:refreshEquipSelectedState(equipSortData,true)
end
item:SetChildButtonClick(_CmpEquipItemIndex.clickBtn,_clickFunc,true)

local _clickLockFunc=function()
if _this==nil then return end

_this:refreshEquipLockState(equipSortData.guid,true)
end
item:SetChildButtonClick(_CmpEquipItemIndex.lockClickBtn,_clickLockFunc,true)
end

function UIMutipleJingLianEquipWin:refreshEquipLockState(guid,isClick)

local guidStr=tostring(guid)
local item=self.equipItemLookUp[guidStr]

local itemData=itemsModel.getItem(guid)

local isLock=bagHelper.isLock(itemData)
if isClick then
bagProtocolControl.req_change_bag_item_lockflag(guid,isLock)
return
end

item:SetChildActive(_CmpEquipItemIndex.lock,isLock)
item:SetChildActive(_CmpEquipItemIndex.unlock,not isLock)
end

function UIMutipleJingLianEquipWin:refreshEquipSelectedState(sortData,isClick)
local item=self.equipItemLookUp[sortData.guidStr]
local index=table.findValueEx(self.selectEquipSortDataList,sortData,function(data)return data.guidStr end)
local isSelect=index~=nil
if isClick then
isSelect=not isSelect
if isSelect then
table.insert(self.selectEquipSortDataList,sortData)

else
table.remove(self.selectEquipSortDataList,index)
end

self:setSelectAllState(#self.equipGuidList==#self.selectEquipSortDataList)
end
item:SetChildActive(_CmpEquipItemIndex.selected,isSelect)

self:resetDropDown3()
self:recalculateCostList()
self:refreshCost()
self:refreshFilters()
end

local _costListLenMax=5
function UIMutipleJingLianEquipWin:refreshCost()
for index=1,self.moneyItemList.Count do
local item=self.moneyItemList[index-1]
local data=self.costMoneyList[index]
local isShow=data~=nil
item:SetChildActive(-1,isShow)
if isShow then
local moneyID=data[1]
local moneyCount=data[2]
local moneyIconName=itemsModel.getItemIconName(moneyID)

item:SetChildIcon(0,moneyIconName,false)
local isEnough=itemsModel.checkItemEnough(moneyID,moneyCount)
moneyCount=isEnough and moneyCount or toColorString(FONT_COLOR.eRedColor,moneyCount)
item:SetChildText(1,moneyCount)
end
end

for index=1,_costListLenMax do
self:refreshCostItem(index)
end
end

local _costItemCmpIndex={
baseItem=0,
empty=1,
}
function UIMutipleJingLianEquipWin:refreshCostItem(index)
local item=self.costItemList[index-1]
local itemData=self.selectedMaterialList[index]
local isEmpty=itemData==nil

item:SetChildActive(_costItemCmpIndex.baseItem,not isEmpty)
item:SetChildActive(_costItemCmpIndex.empty,isEmpty)
if isEmpty then
return
end

local itemid=itemData.itemid
local itemCount=itemData.itemcount
local showCountBG=itemCount>1
local itemcountStr=showCountBG and itemCount or""


local conf={itemid=itemid,itemcount=itemcountStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_costItemCmpIndex.baseItem,prop)
local suitid=itemData.suitid or 0
if suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitIcon=iconHelper.getSuitIcon(suitConfig.icon)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon
end
item:SetBaseItemClickEvent(_costItemCmpIndex.baseItem,function(...)
itemsComponentHelper.onItemClick(itemid)
end)
end

function UIMutipleJingLianEquipWin:refreshFilters()
local stageDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eStage]
local colorDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eColor]
self.JinglianLvDescList,self.levellist,self.maxlv,self.minlv=self:getJinglianLvDescList()
local JinglianLvDescList=self.JinglianLvDescList

self.Dropdown_1:setOption(stageDescList)
self.Dropdown_2:setOption(colorDescList)
self.Dropdown_3:setOption(JinglianLvDescList)

self.stageIdx=equipsModel:getEquipJingLianDropDownIdx(ITEM_FILTER_TYPE.eStage)
self.colorIdx=equipsModel:getEquipJingLianDropDownIdx(ITEM_FILTER_TYPE.eColor)

self.Dropdown_1:setValue(self.stageIdx)
self.Dropdown_2:setValue(self.colorIdx)

self:selectFilterStage(self.stageIdx)
self:selectFilterColor(self.colorIdx)
end


function UIMutipleJingLianEquipWin:selectFilterColor(val)
local filtertype=ITEM_FILTER_TYPE.eColor
self:onFilter(filtertype,val)
end


function UIMutipleJingLianEquipWin:selectFilterStage(val)
local filtertype=ITEM_FILTER_TYPE.eStage
self:onFilter(filtertype,val)
end

function UIMutipleJingLianEquipWin:onFilter(filtertype,val)
if self.filter[filtertype]==val then return end
self.filter[filtertype]=val

end

function UIMutipleJingLianEquipWin:onDropdown3Created()
self.JinglianLvDescList,self.levellist,self.maxlv,self.minlv=self:getJinglianLvDescList()
local len=#self.levellist
local jinglianlv=self.minlv
for i=1,len do
local isGray=jinglianlv>=self.levellist[i]
local idx=i-1
local widget=self.Dropdown_3:getDropdownItemWidget(idx)
widget:SetChildActive(1,true)
widget:SetChildButtonClick(1,function()
self:onDropdown3Click(idx,isGray)
end)

if isGray then
widget:SetChildCSImageSprite(2,globalABLookup.global,"button_chuangkou_7")
end
widget:SetChildImageExGray(2,isGray)
widget:SetChildActive(3,idx==self.JinglianLvIdx)
end
self.Dropdown3Mask:setActive(self.JinglianLvIdx==nil)
end

function UIMutipleJingLianEquipWin:resetDropDown3()
self.JinglianLvIdx=nil
self.Dropdown3Mask:setActive(true)
end

function UIMutipleJingLianEquipWin:onDropdownChange(dropidx,idx)

if dropidx==ITEM_FILTER_TYPE.eColor then
self:selectFilterColor(idx)
self.colorIdx=idx
elseif dropidx==ITEM_FILTER_TYPE.eStage then
self:selectFilterStage(idx)
self.stageIdx=idx
end
equipsModel:changeEquipJingLianDropDownIdx({self.stageIdx,self.colorIdx})
end

function UIMutipleJingLianEquipWin:onDropdown3Click(idx,isGray)
if next(self.selectEquipSortDataList)==nil then
UIManager.error("请选择装备")
return
end

if isGray then
UIManager.error("装备精炼已达到该等级")
return
end

self.JinglianLvIdx=idx
self.Dropdown_3:hideList()
self.Dropdown_3:setValue(idx)

self:recalculateCostList()

self:refreshCost()

self.Dropdown3Mask:setActive(self.JinglianLvIdx==nil)
end


local _upLevelStep=4
function UIMutipleJingLianEquipWin:getJinglianLvDescList()
local maxlv
local minlv
local templist={}
local levellist={}

if next(self.selectEquipSortDataList)==nil then
maxlv=20
minlv=0
else
for index,sortData in ipairs(self.selectEquipSortDataList)do
local itemData=sortData.itemData

local itemid=itemData.itemid
local _maxlv=equipsConfig.getJinglianMaxLvByItemid(itemid)
maxlv=maxlv and Mathf.Min(_maxlv,maxlv)or _maxlv

local jinglianlv=itemData.itemData.jinglianlv
minlv=minlv and Mathf.Min(jinglianlv,minlv)or jinglianlv
end
end
local _maxlv=maxlv
local step=0
while _maxlv>0 do
if maxlv-_upLevelStep>0 then
step=step+1
local toStep=step*_upLevelStep
templist[#templist+1]=FMT.fmt("+{0}级",toStep)
levellist[#levellist+1]=toStep
else
local toStep=step*_upLevelStep+_maxlv
templist[#templist+1]=FMT.fmt("+{0}级",step*_upLevelStep+_maxlv)
levellist[#levellist+1]=toStep
end
_maxlv=_maxlv-_upLevelStep
end

return templist,levellist,maxlv,minlv
end

function UIMutipleJingLianEquipWin:recalculateCostList()

self.selectedMaterialList={}
self.selectedMaterialTotalExp=0

self.costMoneyList={{1,0}}
self.costMoneyLookup={[1]=0}

self.needTotalExp=0
self.canJingLianEquipGuidList={}

if self.JinglianLvIdx==nil then return end

local targetLv=self.levellist[self.JinglianLvIdx+1]

if next(self.selectEquipSortDataList)then
for index,sortData in ipairs(self.selectEquipSortDataList)do
local itemData=sortData.itemData
local jinglianlv=itemData.itemData.jinglianlv
local jinglianexp=itemData.itemData.jinglianexp
local itemID=itemData.itemid
local itemConfig=itemsConfig.getConfig(itemID)
local equipType=equipsConfig.getEquipType(itemID)
local maxJingLianLv=equipsConfig.getJinglianMaxLv(itemConfig.stage)
local needAddExp=0
if maxJingLianLv>=targetLv and targetLv>jinglianlv then
for lvIndex=jinglianlv,targetLv-1 do
local levelFullExp=equipsConfig.getJinglianExp(equipType,lvIndex,itemConfig.stage)
if lvIndex==jinglianlv then
needAddExp=needAddExp+(levelFullExp-jinglianexp)
else
needAddExp=needAddExp+levelFullExp
end
end

local moneyCostList=equipsHelper.getJinglianCost(itemData.itemguid,needAddExp,targetLv)
for mIndex,mData in ipairs(moneyCostList)do
local mItemID=mData[1]
local mItemCount=mData[2]
self.costMoneyLookup[mItemID]=(self.costMoneyLookup[mItemID]or 0)+mItemCount
end
self.needTotalExp=self.needTotalExp+needAddExp

table.insert(self.canJingLianEquipGuidList,itemData.itemguid)
end
end
end

self.costMoneyList=attrListHelper.transformToList(self.costMoneyLookup)

local stageDropIdx=self.filter[ITEM_FILTER_TYPE.eStage]
local colorDropIdx=self.filter[ITEM_FILTER_TYPE.eColor]
local filterStage=stageDropIdx+1
local filterColor=colorDropIdx+1

local items=equipsHelper.getItemsMaterias(nil,filterColor)
local equips=equipsHelper.getEquipsMaterias2(self.equipGuidList,filterStage,filterColor,true,nil)

local filterList=table.concatTableX(items,equips)
local filterSortList={}
for index,data in ipairs(filterList)do
local temp={}
local isItem=itemsConfig.isItem(data.itemid)

temp.data=data
temp.itemFlag=isItem and 1 or 0
temp.jlVal=equipsHelper.getJinglianValue(data.itemguid,1)

filterSortList[#filterSortList+1]=temp
end
table.sort(filterSortList,function(a,b)
if a.itemFlag==b.itemFlag then
return a.jlVal<b.jlVal
else
return a.itemFlag>b.itemFlag
end
end)

local _totalNeedExp=self.needTotalExp

local filterListLen=#filterList
local filterIndex=1
local fillItemCount=0

while _totalNeedExp>0 and filterListLen>=filterIndex and fillItemCount<_costListLenMax do
local sortData=filterSortList[filterIndex]
local itemData=sortData.data

local itemid=itemData.itemid
local count=itemData.itemcount
local itemguid=itemData.itemguid

local calSingleExp=sortData.jlVal
local calCount=_totalNeedExp/calSingleExp
local needCountMin=mathHelper.safe_floor(calCount)
local needCount=calCount>needCountMin and needCountMin+1 or needCountMin
local setCount=Mathf.Min(needCount,count)

table.insert(self.selectedMaterialList,{itemid=itemid,itemcount=setCount,itemguid=itemguid,suitid=itemData.itemData.suitid})
fillItemCount=fillItemCount+1

local totalExp=calSingleExp*setCount
self.selectedMaterialTotalExp=self.selectedMaterialTotalExp+totalExp
_totalNeedExp=_totalNeedExp-totalExp
filterIndex=filterIndex+1
end

self:changePassCheckJingLianState()
end

function UIMutipleJingLianEquipWin:changePassCheckJingLianState()
local pass=true

if pass and self.costMoneyList and next(self.costMoneyList)then
for index,cost in ipairs(self.costMoneyList)do
local isEnough=itemsModel.checkItemEnough(cost[1],cost[2])
if not isEnough then
pass=false
self.passWarningType=_passWarningType.eLoseMoney
self.passWarningArgs=cost
end
end
end

if pass and self.needTotalExp>self.selectedMaterialTotalExp then
pass=false
self.passWarningType=_passWarningType.eLoseExp
end

self.passCheckJinglianState=pass
end

function UIMutipleJingLianEquipWin:showNoPassWarningTips()
if self.passWarningType==_passWarningType.eLoseMoney then
gainControl:showGainWin(self.passWarningArgs[1])
elseif self.passWarningType==_passWarningType.eLoseExp then
gainControl:showGainWin(12111)
UIManager.info("精炼消耗物品不足")
end
end


function UIMutipleJingLianEquipWin:onRongLian()
local newEquipGuidList={}
for index,guid in ipairs(self.equipGuidList)do
local itemData=bagModel.getItem(guid)
if itemData~=nil then
newEquipGuidList[#newEquipGuidList+1]=guid
end
end

if next(newEquipGuidList)==nil then
self:onCloseBtn()
return
end

equipsModel.setBagMutipleJingLianEquipGuidList(newEquipGuidList)

self:onShow()
end

function UIMutipleJingLianEquipWin:onJingLian(len,list)
if len<=0 then return end

for index=1,len do
local data=list[index]

local guid=data.guid
local guidStr=tostring(guid)
local item=self.equipItemLookUp[guidStr]
if item then
item:SetChildAnimationStringID(_CmpEquipItemIndex.spritePlayer,"bbpljl_effect",false)
end
end

self:refreshAll()
end

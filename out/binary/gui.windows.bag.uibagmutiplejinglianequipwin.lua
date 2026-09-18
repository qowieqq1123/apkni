







def_class("UIBagMutipleJingLianEquipWin",UIWindowBase)









function UIBagMutipleJingLianEquipWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.comfireBtn=UIButton.get(self,2)
self.costPart=UIObject.get(self,3)
self.countInfo=UIText.get(self,4)
self.Dropdown_1=UIDropdownEx.get(self,5)
self.Dropdown_2=UIDropdownEx.get(self,6)
self.Dropdown_3=UIDropdownEx.get(self,7)
self.Dropdown3Mask=UIObject.get(self,8)
self.equipsPart=UIObject.get(self,9)
self.filterDropPart=UIObject.get(self,10)
self.itemCostList=UIObject.get(self,11)
self.layout=UIObject.get(self,12)
self.moneyCostList=UIObject.get(self,13)
self.Root=UIObject.get(self,14)
self.title=UIText.get(self,15)
self.uiRoot=UIObject.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.comfireBtn:setButtonClick(function()self:onComfireBtn()end)
self.Dropdown={
self.Dropdown_1,
self.Dropdown_2,
self.Dropdown_3,
}



end


function UIBagMutipleJingLianEquipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.comfireBtn);self.comfireBtn=nil;
_UIObject_release(self.costPart);self.costPart=nil;
_UIObject_release(self.countInfo);self.countInfo=nil;
_UIObject_release(self.Dropdown_1);self.Dropdown_1=nil;
_UIObject_release(self.Dropdown_2);self.Dropdown_2=nil;
_UIObject_release(self.Dropdown_3);self.Dropdown_3=nil;
_UIObject_release(self.Dropdown3Mask);self.Dropdown3Mask=nil;
_UIObject_release(self.equipsPart);self.equipsPart=nil;
_UIObject_release(self.filterDropPart);self.filterDropPart=nil;
_UIObject_release(self.itemCostList);self.itemCostList=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.moneyCostList);self.moneyCostList=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.Dropdown=nil;
end
















local _this
local _equipListLenMax=10
local _costListLenMax=5

local _bag_filter_desc={}

local _passWarningType={
eNone=0,
eLoseMoney=1,
eLoseExp=2,
}




function UIBagMutipleJingLianEquipWin:onLoaded(...)
self:bindComponents()

_this=self

self.equipItemlist=self.equipsPart:getChildCommonLayoutGroupWidgetList()
self.moneyItemList=self.moneyCostList:getChildCommonLayoutGroupWidgetList()
self.costItemList=self.itemCostList:getChildCommonLayoutGroupWidgetList()

self.Dropdown_1:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown_2:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self.Dropdown_3:setDropdownCreatedAction(function(...)self:onDropdown3Created(...)end)

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

local _on_money_changed=function(itemid,itemguid,isUnlock)
if _this==nil then return end
_this:changePassCheckJingLianState()
_this:refreshCostPart()
end
self:addNotify(notifyConfig.on_money_changed,_on_money_changed)


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
_this:refreshCostPart()
_this:changePassCheckJingLianState()
end
end
self:addNotify(notifyConfig.on_item_list_changed,_on_item_list_changed)
end


function UIBagMutipleJingLianEquipWin:__delete()
_this=nil

self:unbindComponents()
end




function UIBagMutipleJingLianEquipWin:onShow(argtable,afterOnloaded)
self.equipGuidList=argtable.equipGuidList or{}

self.bagPanel=argtable.bagPanel



self:refreshAll()
end


function UIBagMutipleJingLianEquipWin:onHide()

end





function UIBagMutipleJingLianEquipWin:onCloseBtn()
if self.bagPanel then
self.bagPanel:outMutipleJingLianModel()
end

end



function UIBagMutipleJingLianEquipWin:onComfireBtn()
if self.equipGuidList==nil or next(self.equipGuidList)==nil then
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



function UIBagMutipleJingLianEquipWin:initData()
self.JinglianLvDescList,self.levellist,self.maxlv,self.minlv=self:getJinglianLvDescList()

self.JinglianLvIdx=nil

self.passCheckJinglianState=false
self.passWarningType=_passWarningType.eNone
self.passWarningArgs=defaultT

self:recalculateCostList()
end

function UIBagMutipleJingLianEquipWin:refreshAll()
local len=#self.equipGuidList

local countStr=FMT.fmt("精炼{0}/{1} 件装备",len,_equipListLenMax)
self.countInfo:setText(countStr)

self:initData()

self:refreshEquipList()
self:refreshCostPart()
self:refreshDropDown()
end

function UIBagMutipleJingLianEquipWin:refreshEquipList()
for index=1,_equipListLenMax do
self:refreshEquip(index)
end
end

local _equipItemCmpIndex={
baseItem=0,
empty=1,
}
function UIBagMutipleJingLianEquipWin:refreshEquip(index)
local item=self.equipItemlist[index-1]
local equipGuid=self.equipGuidList[index]
local isEmpty=equipGuid==nil

item:SetChildActive(_equipItemCmpIndex.baseItem,not isEmpty)
item:SetChildActive(_equipItemCmpIndex.empty,isEmpty)
if isEmpty then
return
end

local itemData=itemsModel.getItem(equipGuid)

local itemid=itemData.itemid

local showCountBG=itemData.itemData.jinglianlv>0
local itemCountStr=showCountBG and string.format("+%d",itemData.itemData.jinglianlv)or""

local conf={itemid=itemid,itemcount=itemCountStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local suitid=itemData.itemData.suitid or 0
if suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitIcon=iconHelper.getSuitIcon(suitConfig.icon)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon
end
item:SetChildPropData(_equipItemCmpIndex.baseItem,prop)
item:SetBaseItemClickEvent(0,function(...)

local args={
itemid=itemid,
itemguid=equipGuid,
}
args.formType=TIPS_FORM_TYPE.eClearBtn
args.attach={}
tipsManager.showTips(args)
end)
end

function UIBagMutipleJingLianEquipWin:refreshCostPart()

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
function UIBagMutipleJingLianEquipWin:refreshCostItem(index)
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
local suitid=itemData.suitid or 0
if suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitIcon=iconHelper.getSuitIcon(suitConfig.icon)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon
end
item:SetChildPropData(_equipItemCmpIndex.baseItem,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(itemid)
end)
end


function UIBagMutipleJingLianEquipWin:refreshDropDown()
local stageDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eStage]
local colorDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eColor]
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

self:resetDropDown3()
end


function UIBagMutipleJingLianEquipWin:selectFilterColor(val)
local filtertype=ITEM_FILTER_TYPE.eColor
self:onFilter(filtertype,val)
end


function UIBagMutipleJingLianEquipWin:selectFilterStage(val)
local filtertype=ITEM_FILTER_TYPE.eStage
self:onFilter(filtertype,val)
end

function UIBagMutipleJingLianEquipWin:onFilter(filtertype,val)
if self.filter[filtertype]==val then return end
self.filter[filtertype]=val

end

local _upLevelStep=4
function UIBagMutipleJingLianEquipWin:getJinglianLvDescList()
local maxlv
local minlv
local templist={}
local levellist={}

if next(self.equipGuidList)==nil then
maxlv=20
minlv=0
else
for index,guid in ipairs(self.equipGuidList)do
local itemData=itemsModel.getItem(guid)

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

function UIBagMutipleJingLianEquipWin:onDropdown3Created()
self.JinglianLvDescList,self.levellist,self.maxlv,self.minlv=self:getJinglianLvDescList()

local len=#self.levellist
local jinglianlv=self.minlv
for i=1,len do
local isGray=jinglianlv>=self.levellist[i]
local idx=i-1
local widget=self.Dropdown_3:getDropdownItemWidget(idx)
widget:SetChildActive(1,true)
widget:SetChildButtonClick(1,function()
if isGray then return end
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

function UIBagMutipleJingLianEquipWin:onDropdownChange(dropidx,idx)

if dropidx==ITEM_FILTER_TYPE.eColor then
self:selectFilterColor(idx)
self.colorIdx=idx
elseif dropidx==ITEM_FILTER_TYPE.eStage then
self:selectFilterStage(idx)
self.stageIdx=idx
end
equipsModel:changeEquipJingLianDropDownIdx({self.stageIdx,self.colorIdx})
end

function UIBagMutipleJingLianEquipWin:onDropdown3Click(idx,isGray)
if isGray then
UIManager.error("装备精炼已达到该等级")
return
end

self.JinglianLvIdx=idx
self.Dropdown_3:hideList()
self.Dropdown_3:setValue(idx)

self:recalculateCostList()

self:refreshCostPart()

self.Dropdown3Mask:setActive(self.JinglianLvIdx==nil)
end

function UIBagMutipleJingLianEquipWin:resetDropDown3()
self.JinglianLvIdx=nil
self.Dropdown3Mask:setActive(true)
end

function UIBagMutipleJingLianEquipWin:recalculateCostList()

self.selectedMaterialList={}
self.selectedMaterialTotalExp=0

self.costMoneyList={{eMoneyType.mtLingShi,0},{eMoneyType.mtXuanTie,0}}
self.costMoneyLookup={[eMoneyType.mtLingShi]=0,[eMoneyType.mtXuanTie]=0}

self.needTotalExp=0
self.canJingLianEquipGuidList={}

if self.JinglianLvIdx==nil then return end

local targetLv=self.levellist[self.JinglianLvIdx+1]

if next(self.equipGuidList)then
for index,guid in ipairs(self.equipGuidList)do
local itemData=bagModel.getItem(guid)
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

local moneyCostList=equipsHelper.getJinglianCost(guid,needAddExp,targetLv)
for mIndex,mData in ipairs(moneyCostList)do
local mItemID=mData[1]
local mItemCount=mData[2]
self.costMoneyLookup[mItemID]=(self.costMoneyLookup[mItemID]or 0)+mItemCount
end
self.needTotalExp=self.needTotalExp+needAddExp

table.insert(self.canJingLianEquipGuidList,guid)
end
end
end

for index,val in pairs(self.costMoneyLookup)do
if val==nil then
self.costMoneyLookup[index]=nil
end
end

self.costMoneyList=attrListHelper.transformToList(self.costMoneyLookup)
table.sort(self.costMoneyList,function(a,b)
return a[1]<b[1]
end)

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

function UIBagMutipleJingLianEquipWin:changePassCheckJingLianState()
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

function UIBagMutipleJingLianEquipWin:showNoPassWarningTips()
if self.passWarningType==_passWarningType.eLoseMoney then
gainControl:showGainWin(self.passWarningArgs[1])
elseif self.passWarningType==_passWarningType.eLoseExp then
gainControl:showGainWin(12111)
UIManager.info("精炼消耗物品不足")
end
end


function UIBagMutipleJingLianEquipWin:opJingLianEquip(optype,equipGuid)
if optype==1 then
if not equipsHelper.isCanShowJinglian2(equipGuid,true)then
return false
end

if#self.equipGuidList>=_equipListLenMax then
UIManager.info("至多可选择十件装备")
return false
end

self.equipGuidList[#self.equipGuidList+1]=equipGuid
elseif optype==2 then
if#self.equipGuidList<=0 then return false end

table.removeValueEx(self.equipGuidList,equipGuid,function(guid)return tostring(guid)end)
end

equipsModel.setBagMutipleJingLianEquipGuidList(self.equipGuidList)

self:refreshAll()

return true
end

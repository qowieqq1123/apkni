







def_class("UIFabaoLianhuaWin",UIWindowBase)









function UIFabaoLianhuaWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.attr1ScrollView=UIObject.get(self,1)
self.attrName=UIText.get(self,2)
self.attrRoot1=UIObject.get(self,3)
self.attrRoot10=UIObject.get(self,4)
self.attrRoot11=UIObject.get(self,5)
self.attrRoot12=UIObject.get(self,6)
self.attrRoot2=UIObject.get(self,7)
self.attrRoot3=UIObject.get(self,8)
self.attrRoot4=UIObject.get(self,9)
self.attrRoot5=UIObject.get(self,10)
self.attrRoot6=UIObject.get(self,11)
self.attrRoot7=UIObject.get(self,12)
self.attrRoot8=UIObject.get(self,13)
self.attrRoot9=UIObject.get(self,14)
self.attrScrollView=UIObject.get(self,15)
self.attrshowRoot1=UIObject.get(self,16)
self.attrshowRoot10=UIObject.get(self,17)
self.attrshowRoot11=UIObject.get(self,18)
self.attrshowRoot12=UIObject.get(self,19)
self.attrshowRoot2=UIObject.get(self,20)
self.attrshowRoot3=UIObject.get(self,21)
self.attrshowRoot4=UIObject.get(self,22)
self.attrshowRoot5=UIObject.get(self,23)
self.attrshowRoot6=UIObject.get(self,24)
self.attrshowRoot7=UIObject.get(self,25)
self.attrshowRoot8=UIObject.get(self,26)
self.attrshowRoot9=UIObject.get(self,27)
self.btnAdd=UIButton.get(self,28)
self.btnConfirm=UIButton.get(self,29)
self.btnContinue=UIButton.get(self,30)
self.btnLianhua=UIButton.get(self,31)
self.btnReset=UIButton.get(self,32)
self.btnResetFilter=UIButton.get(self,33)
self.closeFilterBtn=UIButton.get(self,34)
self.Content=UIObject.get(self,35)
self.desc=UIText.get(self,36)
self.Dropdown1=UIDropdownEx.get(self,37)
self.Dropdown2=UIDropdownEx.get(self,38)
self.effect=UIObject.get(self,39)
self.effect0=UIObject.get(self,40)
self.effect1=UIObject.get(self,41)
self.effect2=UIObject.get(self,42)
self.effect3=UIObject.get(self,43)
self.effect4=UIObject.get(self,44)
self.effect5=UIObject.get(self,45)
self.effectRoot=UIObject.get(self,46)
self.FilterBtn=UIButton.get(self,47)
self.filterRoot=UIObject.get(self,48)
self.help=UIButton.get(self,49)
self.helpO=UIObject.get(self,50)
self.item1=UIBaseItem.get(self,51)
self.item2=UIBaseItem.get(self,52)
self.item3=UIBaseItem.get(self,53)
self.item4=UIBaseItem.get(self,54)
self.item5=UIBaseItem.get(self,55)
self.leftItem=UIObject.get(self,56)
self.lianhuaResetBtn=UIButton.get(self,57)
self.num=UIText.get(self,58)
self.pageCreater=UIObject.get(self,59)
self.rightItem=UIObject.get(self,60)
self.rightPanel=UIObject.get(self,61)
self.ScrollView=UIScrollViewSlow.get(self,62)
self.selectBg=UIButton.get(self,63)
self.selectPanel=UIObject.get(self,64)
self.showItem=UIBaseItem.get(self,65)
self.showPanel=UIObject.get(self,66)
self.switch=UIButton.get(self,67)
self.titleName=UIText.get(self,68)

self.btnAdd:setButtonClick(function()self:onBtnAdd()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.btnContinue:setButtonClick(function()self:onBtnContinue()end)

self.btnLianhua:setButtonClick(function()self:onBtnLianhua()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnResetFilter:setButtonClick(function()self:onBtnResetFilter()end)

self.closeFilterBtn:setButtonClick(function()self:onCloseFilterBtn()end)

self.FilterBtn:setButtonClick(function()self:onFilterBtn()end)

self.help:setButtonClick(function()self:onHelp()end)

self.lianhuaResetBtn:setButtonClick(function()self:onLianhuaResetBtn()end)

self.selectBg:setButtonClick(function()self:onSelectBg()end)

self.switch:setButtonClick(function()self:onSwitch()end)



end


function UIFabaoLianhuaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.attr1ScrollView);self.attr1ScrollView=nil;
_UIObject_release(self.attrName);self.attrName=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot10);self.attrRoot10=nil;
_UIObject_release(self.attrRoot11);self.attrRoot11=nil;
_UIObject_release(self.attrRoot12);self.attrRoot12=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.attrRoot6);self.attrRoot6=nil;
_UIObject_release(self.attrRoot7);self.attrRoot7=nil;
_UIObject_release(self.attrRoot8);self.attrRoot8=nil;
_UIObject_release(self.attrRoot9);self.attrRoot9=nil;
_UIObject_release(self.attrScrollView);self.attrScrollView=nil;
_UIObject_release(self.attrshowRoot1);self.attrshowRoot1=nil;
_UIObject_release(self.attrshowRoot10);self.attrshowRoot10=nil;
_UIObject_release(self.attrshowRoot11);self.attrshowRoot11=nil;
_UIObject_release(self.attrshowRoot12);self.attrshowRoot12=nil;
_UIObject_release(self.attrshowRoot2);self.attrshowRoot2=nil;
_UIObject_release(self.attrshowRoot3);self.attrshowRoot3=nil;
_UIObject_release(self.attrshowRoot4);self.attrshowRoot4=nil;
_UIObject_release(self.attrshowRoot5);self.attrshowRoot5=nil;
_UIObject_release(self.attrshowRoot6);self.attrshowRoot6=nil;
_UIObject_release(self.attrshowRoot7);self.attrshowRoot7=nil;
_UIObject_release(self.attrshowRoot8);self.attrshowRoot8=nil;
_UIObject_release(self.attrshowRoot9);self.attrshowRoot9=nil;
_UIObject_release(self.btnAdd);self.btnAdd=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.btnContinue);self.btnContinue=nil;
_UIObject_release(self.btnLianhua);self.btnLianhua=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnResetFilter);self.btnResetFilter=nil;
_UIObject_release(self.closeFilterBtn);self.closeFilterBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.FilterBtn);self.FilterBtn=nil;
_UIObject_release(self.filterRoot);self.filterRoot=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.helpO);self.helpO=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.leftItem);self.leftItem=nil;
_UIObject_release(self.lianhuaResetBtn);self.lianhuaResetBtn=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.rightItem);self.rightItem=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.showPanel);self.showPanel=nil;
_UIObject_release(self.switch);self.switch=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end


















local pageItemCmpIndex={
name=0,
childCreater=1,
toggle=2,
checkMark=3,
}

local childItemCmpIndex={
toggle=0,
name=1,
icon=2,
bg=3,
}

local _renameType=
{
[eAttributeType.eATK_PCT]='攻击率',
[eAttributeType.eDEF_PCT]='防御率',
[eAttributeType.eHP_PCT]='生命率',
}

local _maxAttrLine=10
local _bag_filter_desc={}
local _colomn=4
local _row=6
local _fillItemLen=5
local _this=nil
local _dropItemHeight=40
local _dropViewHeight=150

function UIFabaoLianhuaWin:onLoaded(...)
self:bindComponents()
self.showItem:setBaseItemClickEvent(function(...)self:onItemClick(...)end)

self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)



self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)

self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(ITEM_FILTER_TYPE.eStage,...)end)


self.selectBg:setActive(false)
_this=self

self.filterFlag={}
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

local attrsList={}
self.attrsList=attrsList
for i=1,12 do
attrsList[#attrsList+1]=self[FMT.fmt('attrRoot{0}',i)]
end


local attrsShowList={}
self.attrsShowList=attrsShowList
for i=1,12 do
attrsShowList[#attrsShowList+1]=self[FMT.fmt('attrshowRoot{0}',i)]
end






local list=table.toTable(1,5)
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}品',stage)
end,'所有')

self.filter={}

self.filter[ITEM_FILTER_TYPE.eStage]=0

self:initFilter()

self.selectBagType=BAG_TYPE.eMaterialsBag

self.selectList={}
self.selectNumList={}
self.leftList={}

self.selectFilter={}


self.switchFlag=false
self.curPageIndex=1
self.selectItemguid=nil
self.isSetZero=false
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.checkList={}
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)







end

function UIFabaoLianhuaWin:__delete()
self:unbindComponents()

tipsManager.closeTips()
end

function UIFabaoLianhuaWin:onShow(argtable,afterOnloaded)
self:freshFaBao(argtable)
end

function UIFabaoLianhuaWin:onHide()

end




function UIFabaoLianhuaWin:freshFaBao(argtable)
self.selectList={}
self.selectNumList={}
self.leftList={}
if argtable then
local itemguid=argtable.itemguid
self.item=fabaoHelper.getFabao(itemguid)
self.isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
local stage=itemsConfig.getConfig(self.item.itemid).stage
self.stage=stage
end
self:freshInfo()
end

function UIFabaoLianhuaWin:freshInfo()
self:freshShowItems()
self:freshDropdowns()
self:freshSelectItems()
self:freshAttrs()
self:freshCostItems()
self:freshLianhuaNum()
self.help:setActive(true)
self.helpO:setActive(false)
end


function UIFabaoLianhuaWin:freshShowItems()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local name=item.itemData.name
local item_config=itemsConfig.getConfig(itemid)

local iconName=itemsModel.getIconName(item)
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetIcon,0,iconName)
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetText,1,name)
self.showItem:setChildItemData(DataPropKey.eItemID,itemid)
self.showItem:setChildItemData(DataPropKey.eItemSeries,itemguid)
end


function UIFabaoLianhuaWin:freshAttrs()
self:stopAni()
self.showPanel:setActive(false)
self.rightPanel:setActive(true)
local switchFlag=self.switchFlag
local attrsCmpList=self.attrsList
local baseLen=0
local tlen=#attrsCmpList
local itemslist=self:getSelectInfoList()
local len=#itemslist
local hasItem=len>0
local showSwitch=false
if hasItem then showSwitch=true end
local showAlreadyAttr=not hasItem or switchFlag
local attrName=showAlreadyAttr and'已炼化属性'or'本次炼化属性'
self.attrName:setText(attrName)
self.switch:setActive(showSwitch)
if not showAlreadyAttr then
self.attrScrollView:setActive(true)
self.desc:setActive(false)
local attrRangeLookup=fabaoHelper.getAddLianhuaAttrsListByList(self.item,itemslist)
local attrRangeList=attrListHelper.sortByLookup(attrRangeLookup)or{}
baseLen=#attrRangeList

for i,v in ipairs(attrRangeList)do
self:fillRandomAttr(i,v[1],v[2])
end
else
local list=fabaoHelper.getLianhuaAttrsList(self.item)or{}
local attrList=attrListHelper.sortByList(list)or{}
baseLen=#attrList
local has=baseLen>0

self.desc:setActive(not has)
self.attrScrollView:setActive(has)
if has then
for i,v in ipairs(attrList)do
self:fillAttr(i,v[1],v[2])
end
end
end

if baseLen<_maxAttrLine then
for i=baseLen+1,tlen do
self.attrsList[i]:setActive(false)
end
end
self.arrow:setActive(baseLen>=9)
end

function UIFabaoLianhuaWin:fillAttr(index,attrid,val)
local cmpObject=self.attrsList[index]
cmpObject:setActive(true)
local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
local name,valstr,ifMod=equipsHelper.getAttr(attrid,val,TO_INT_TYPE.eDown)
local txt=FMT.fmt('{0}：{1}',name,valstr)
widget:SetChildText(0,txt)
end

function UIFabaoLianhuaWin:fillRandomAttr(index,attrid,range)
local cmpObject=self.attrsList[index]
cmpObject:setActive(true)
local min=range[1]
local max=range[2]
local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
local name,minValstr,ifMod=equipsHelper.getAttr(attrid,min,TO_INT_TYPE.eDown)
local name,maxValstr,ifMod=equipsHelper.getAttr(attrid,max,TO_INT_TYPE.eDown)
local valstr=FMT.fmt('{0}：{1}',name,FMT.cfmt(eQualityColor.eGreen,'{0}~{1}',minValstr,maxValstr))
widget:SetChildText(0,valstr)
end

function UIFabaoLianhuaWin:fillElement(index,element,range)
local cmpObject=self.attrsList[index]
cmpObject:setActive(true)
local txt=FMT.fmt('{0}系技能威力提升：{1}',ELEMENT_TYPE.getName(element),FMT.cfmt(eQualityColor.eGreen,'{0}%~{1}%',mathHelper.decimal(range[1]/100),mathHelper.decimal(range[2]/10000)))
local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
widget:SetChildText(0,txt)
end

function UIFabaoLianhuaWin:freshLianhuaNum()
local item=self.item
local leftNum,tNum=fabaoHelper.getLianhuaLeftNum(item.itemguid)
local costNum=tNum-leftNum
self.num:setText(FMT.fmt('已炼化材料数量：{0}/{1}',costNum,tNum))

self.lianhuaResetBtn:setActive(costNum>0)
end


function UIFabaoLianhuaWin:freshShowAttrs(lastAttrsList,attrsList)
local lookup1=attrListHelper.tramsformToLookup(lastAttrsList)
local lookup2=attrListHelper.tramsformToLookup(attrsList)
local newLookup=attrListHelper.getNewLookup(lookup1,lookup2)
self.showPanel:setActive(true)
self.rightPanel:setActive(false)
local tLen=#self.attrsShowList
local len=#attrsList
local delay=0.1
for i=1,12 do
self.attrsShowList[i]:setActive(false)
end

for i,v in ipairs(attrsList)do
local attrType=v[1]
local isNew=newLookup[attrType]==true
self:fillShowAttr(i,attrType,v[2],isNew)
end
self:stopAni()
self.delayTNum=len
self.delayTimer=self:setTimer(delay,0,function()
self.delayNum=self.delayNum+1
if self.delayNum>self.delayTNum then
self:stopAni()
return
end
self.attrsShowList[self.delayNum]:setActive(true)
end)





end

function UIFabaoLianhuaWin:testShowAni()
self.showPanel:setActive(true)
self.rightPanel:setActive(false)
local delay=0.1
for i=1,12 do
self.attrsShowList[i]:setActive(false)
end

local newLookup={{1,1},{2,2},{3,3},{4,4},{101,101},{102,102},{103,103},{104,104},{105,105},{106,106}}
local len=10
for i,v in ipairs(newLookup)do
local attrType=v[1]
local isNew=true
self:fillShowAttr(i,attrType,v[2],isNew)
end
self:stopAni()
self.delayNum=0
self.delayTNum=len
self.delayTimer=self:setTimer(delay,0,function()
self.delayNum=self.delayNum+1
if self.delayNum>self.delayTNum then
self:stopAni()
return
end
self.attrsShowList[self.delayNum]:setActive(true)
end)
end

function UIFabaoLianhuaWin:stopAni()
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
end
self.delayTimer=nil
self.delayNum=0
self.delayTNum=0
end

function UIFabaoLianhuaWin:fillShowAttr(index,attrid,val,isNew)
local cmpObject=self.attrsShowList[index]

local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
local name,valstr,ifMod=equipsHelper.getAttr(attrid,val,TO_INT_TYPE.eDown)
local txt=FMT.fmt('{0}：{1}',name,valstr)
widget:SetChildText(0,txt)
widget:SetChildActive(1,isNew)
end


function UIFabaoLianhuaWin:freshDropdowns()
local filterType=ITEM_FILTER_TYPE.eStage
local stageDescList=_bag_filter_desc[filterType]

local descList=table.deepCopy(stageDescList)
local options=table.reverse(descList)
self.Dropdown1:setOption(options)
local len=#stageDescList
local idx=self.selectFilter[filterType]or 0
local reIdx=len-1-idx

self.Dropdown1:setValue(reIdx)













end




function UIFabaoLianhuaWin:freshSelectItems()
local itemsList=self.itemsList
if self.selectList==nil then self.selectList={}end
for i,v in ipairs(itemsList)do
local itemguid=self.selectList[i]
local num=self.selectNumList[tostring(itemguid)]or 0
local item=itemguid and bagModel.getItem(itemguid)or nil
num=num>1 and num or''
local conf={showname=false,itemcount=num,showCountBG=num~=''}
v:setChildPropData(self:getSelectFillData(item,conf))
end
end


function UIFabaoLianhuaWin:getSelectFillData(item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData()
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
return prop
end


function UIFabaoLianhuaWin:getSelectTempFillData()
local conf={}
conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end

function UIFabaoLianhuaWin:getNextFillIdx(itemguid)
if self.selectList==nil then self.selectList={}end
local selectList=self.selectList
local idx=nil
for i=1,_fillItemLen do
if not selectList[i]and idx==nil then
idx=i
end
if tostring(itemguid)==tostring(selectList[i])then
return i
end
end
return idx
end

function UIFabaoLianhuaWin:isFull()
for i=1,_fillItemLen do
if not self.selectList[i]then
return false
end
end
return true
end

function UIFabaoLianhuaWin:isFillAnyItem()
for i=1,_fillItemLen do
if self.selectList[i]then
return true
end
end
return false
end

function UIFabaoLianhuaWin:setSelectItem(itemguid,index,num)
local handle=tostring(itemguid)
if num<=0 then
self.selectList[index]=nil
self.selectNumList[handle]=0
else
self.selectList[index]=itemguid
self.selectNumList[handle]=num
end
end

function UIFabaoLianhuaWin:deleteSelectItem(itemguid,index)
local handle=tostring(itemguid)
local lastNum=self.selectNumList[handle]or 0
if lastNum>0 and self.selectList[index]==nil or lastNum<=0 and self.selectList[index]then
loggerUtil.logErrFMT('炼化数据有问题')
return
end
if lastNum==0 then return end
self.selectNumList[handle]=self.selectNumList[handle]-1
if self.selectNumList[handle]<=0 then
self.selectList[index]=nil
end
end

function UIFabaoLianhuaWin:getSelectIndex(itemguid)
if self.selectList==nil then self.selectList={}end
for i=_fillItemLen,1,-1 do
if self.selectList[i]==itemguid then
return i
end
end
end

function UIFabaoLianhuaWin:getSelectItemNum(itemguid)
return self.selectNumList[tostring(itemguid)]or 0
end

function UIFabaoLianhuaWin:getSelectInfoList()
local temp={}
local selectList=self.selectList or{}
for i=1,_fillItemLen do
local itemguid=selectList[i]
if itemguid then
local num=self.selectNumList[tostring(itemguid)]or 0
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
temp[#temp+1]={itemid,num}
end
end

return temp
end



function UIFabaoLianhuaWin:getSelectItemsLength()
local lenth=0
local temp={}
local selectList=self.selectList or{}
for i=1,_fillItemLen do
local itemguid=selectList[i]
if itemguid then
local num=self.selectNumList[tostring(itemguid)]or 0
lenth=lenth+num
end
end
return lenth
end

function UIFabaoLianhuaWin:getTotalOtherNum(itemguid)
local lenth=0
local temp={}
local selectList=self.selectList or{}
for i=1,_fillItemLen do
local _itemguid=selectList[i]
if tostring(_itemguid)~=tostring(itemguid)then
local num=self.selectNumList[tostring(itemguid)]or 0
lenth=lenth+num
end
end
return lenth
end


function UIFabaoLianhuaWin:getSelectItemguidList()
local temp={}
local selectList=self.selectList or{}
for i=1,_fillItemLen do
local itemguid=selectList[i]
if itemguid then
local num=self.selectNumList[tostring(itemguid)]or 0
if num>0 then
for i=1,num do
temp[#temp+1]=itemguid
end
end
end
end

return temp
end



function UIFabaoLianhuaWin:freshCostItems()
local components={}
components[#components+1]=self.leftItem
components[#components+1]=self.rightItem

local itemslist=self:getSelectInfoList()
local consumelist=fabaoHelper.getLianhuaCostMoney(itemslist)
local consumeOnelist=fabaoConfig.getCostByLianhua(self.stage)
for i,v in ipairs(components)do
local costInfo=consumelist[i]or{}
local itemid=costInfo[1]or consumeOnelist[i][1]
self.checkList[itemid]=true
local val=costInfo[2]or 0
local isMoney=itemsConfig.isMoney(itemid)
if isMoney then
local enoughMoney=moneyModel.checkEnoughMoney(itemid,val)
val=enoughMoney and val or FMT.cfmt(FONT_COLOR.eRedColor,val)
end
local widget=self.winlua:GetChildWidgetBase(v:getID())
widget:SetChildIcon(0,iconHelper.getIconName(itemid),false)
widget:SetChildText(1,val)
end
end

function UIFabaoLianhuaWin:getFillOtherNum(itemguid)
local num=0
for i=1,_fillItemLen do
local _itemguid=self.selectList[i]
if _itemguid and tostring(_itemguid)~=tostring(itemguid)then
num=num+self.selectNumList[tostring(_itemguid)]
end
end
return num
end

function UIFabaoLianhuaWin:getCanPutMaxLianhuaNum(itemguid)
local fillNum=self:getFillOtherNum(itemguid)
local leftNum=fabaoHelper.getLianhuaLeftNum(self.item.itemguid)
local item=bagModel.getItem(itemguid)or{}
local alreadyNum=self.selectNumList[tostring(itemguid)]or 0
local hasNum=item.itemcount
local putMaxNum=leftNum-fillNum
return math.min(leftNum,hasNum,putMaxNum),alreadyNum
end

function UIFabaoLianhuaWin:hasPutAny()
for i=1,_fillItemLen do
if self.selectList[i]then
return true
end
end
return false
end


function UIFabaoLianhuaWin:showProvideSelectGrids()
if self.showDialogue then return end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshProvideSelectGrids(true)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UIFabaoLianhuaWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
self.curPageIndex=1
self.isSetZero=false
local selectItemguid=self.selectItemguid
self.selectItemguid=nil
self:freshProvideGridSelect(selectItemguid)
self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self:onCloseFilterBtn()
end

function UIFabaoLianhuaWin:freshBagList()
local filter={}
for k,v in pairs(self.filter)do
if v==0 then
filter[k]=nil
else
filter[k]=v
end
end

local filterFlag=self.filterFlag
for _,vt in pairs(self._filter)do
local filterType=vt.filterType
local _list=vt.list
local filterTypeData=filterFlag[filterType]or{}
local has=false
for i,v in ipairs(_list)do
local isToggle=filterTypeData[i]or false
if isToggle then
if filter[filterType]==nil then filter[filterType]={}end
filter[filterType][1]=ITEM_FILTER_COMPARE.eEquals
if filter[filterType][2]==nil then filter[filterType][2]={}end
local filterTable=filter[filterType][2]
filterTable[#filterTable+1]=v
end
has=has or isToggle
end

if not has then
if filter[filterType]==nil then filter[filterType]={}end
filter[filterType]={ITEM_FILTER_COMPARE.eEquals,nil}
end
end

local filterguid=self.item.itemguid
filter[ITEM_FILTER_TYPE.eItemConfigAttr]={ITEM_FILTER_COMPARE.eNotNull,{'lianhua'}}
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{filterguid}}





local bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)

local isPutItem=function(itemguid)
for i=1,_fillItemLen do
local info=self.selectList[i]
if self.selectList[i]and tostring(self.selectList[i])==tostring(itemguid)then
return true
end
end
end

local list={}
local looupup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
if not looupup[tostring(item.itemguid)]and isPutItem(item.itemguid)then
list[#list+1]=item
looupup[tostring(item.itemguid)]=true
table.remove(bagList,i)
end
end

for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end

self.bagList=bagList
end

function UIFabaoLianhuaWin:freshProvideSelectGrids(freshData)
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

function UIFabaoLianhuaWin:bindGrid(index,widget)
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
local num=self:getSelectItemNum(itemguid)
local countStr=num>0 and FMT.fmt('{0}/{1}',num,itemInfo.itemcount)or num<=0 and itemInfo.itemcount
local has=num>0
local showbg=true
local isLock=bagHelper.isLock(itemInfo)
local isFabao=itemsConfig.isFabao(itemid)
local showStage=itemConfig.stage~=nil
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)

widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,has)
widget:SetChildButtonClick(9,function()self:onClickGridButton(index,itemid,itemguid)end,true)
widget:SetChildActive(10,isFabao)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
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
end

local newbieName=FMT.fmt('UIFabaoLianhuaWin.#ScrollView.Item_{0}',index)
widget:SetChildNewBieComponentId(-1,newbieName)
end

function UIFabaoLianhuaWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,flag)
end
end
end

function UIFabaoLianhuaWin:freshProvideGridSelect(itemguid)
if itemguid==nil then return end
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid))
end
end
end

function UIFabaoLianhuaWin:freshProvideSelectSingleItemNum(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local itemcount=num>0 and FMT.fmt('{0}/{1}',num,item.itemcount)or item.itemcount
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildText(4,itemcount)
end
end
end

function UIFabaoLianhuaWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i
end
end
end




























function UIFabaoLianhuaWin:onDropdownChange(dropidx,reIdx)

local len=#_bag_filter_desc[dropidx]
local idx=len-1-reIdx
if self.selectFilter[dropidx]==idx then return end
self.curPageIndex=1
self.isSetZero=false
self.selectItemguid=nil
self.selectFilter[dropidx]=idx
self.filter[dropidx]=idx
self:freshProvideSelectGrids(true)
end

function UIFabaoLianhuaWin:onDropdownCreate(dropidx,scrollTrans,contentTrans)
local filterType=dropidx
local idx=self.selectFilter[filterType]or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end

contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIFabaoLianhuaWin:onItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
self:onSelectGridItem(itemguid)
end
end

function UIFabaoLianhuaWin:onBtnLianhua()
if self:getSelectItemsLength()<=0 then
UIManager.error('请选择炼化材料')
return
end
local itemguid=self.item.itemguid
local itemslist=self:getSelectInfoList()
local ret,err,args=fabaoHelper.isCanLianhua(itemguid,itemslist)
if not ret then
if err==fabaoHelper.lianhuaErr.eNotEnoughtMainItem then
UIManager.error('请放入主材料')
elseif err==fabaoHelper.lianhuaErr.eOverItem then
UIManager.error('可炼化材料达到上限')
elseif err==fabaoHelper.lianhuaErr.eNotEnoughMoney then
local moneyType=args[1]
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足',moneyName))
gainControl:showGainWin(moneyType)
end
return
end
local list=self:getSelectItemguidList()
local len=#list
local pos=0
local guid=itemguid
if self.isEquip then
guid=fabaoModel.getDiziguidByItemguid(itemguid)
pos=1
end
fabaoProtocolControl.reqLianhuaFabao(guid,pos,len,list)
end

function UIFabaoLianhuaWin:onSwitch()
self.switchFlag=not self.switchFlag
self:freshAttrs()
end

function UIFabaoLianhuaWin:onClickBg()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoLianhuaWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
local max,fill=self:getCanPutMaxLianhuaNum(itemguid)
local hasNum=fill>0
local min=hasNum and 0 or 1
local val=hasNum and fill or 1

tipsManager.showTips({formType=TIPS_FORM_TYPE.eFabaoLianhua,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNomal,
attach={index=index,selectNumCmpArgs={min=min,max=max,val=val}}})
self:onSelectGridItem(itemguid)
end

function UIFabaoLianhuaWin:putItem(index,itemid,itemguid,putnum)
if itemid==-1 then return end
local left=fabaoHelper.getLianhuaLeftNum(self.item.itemguid)
local fillNum=self:getFillOtherNum(itemguid)
if fillNum>=left then
UIManager.error('可炼化材料达到上限')
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
tipsManager.closeTips()
return
end
local num=self:getSelectItemNum(itemguid)
if putnum==num then
if putnum>0 then
UIManager.info('该道具已放入')
end
return
end
if num==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
elseif putnum==0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:setSelectItem(itemguid,fillIdx,putnum)
self:freshProvideSelectSingleItemNum(itemguid)
self:freshSelectItems()
self:freshAttrs()
self:freshCostItems()
self:freshLianhuaNum()
end

function UIFabaoLianhuaWin:onClickGridButton(itemid,index,itemguid,attach)
if itemid==-1 then return end
local num=self:getSelectItemNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
num=num-1
local selectIdx=self:getSelectIndex(itemguid)
self:deleteSelectItem(itemguid,selectIdx)
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshSelectItems()
self:freshProvideSelectSingleItemNum(itemguid)
self:freshAttrs()
self:freshCostItems()
self:freshLianhuaNum()
end

function UIFabaoLianhuaWin:onClickLongGridButton(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIFabaoLianhuaWin:onSelectGridItem(itemguid)
local lastItemguid=self.selectItemguid
self.selectItemguid=itemguid
if lastItemguid then
self:freshProvideGridSelect(lastItemguid)
end
self:freshProvideGridSelect(itemguid)
end

function UIFabaoLianhuaWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshProvideSelectGrids()
end

function UIFabaoLianhuaWin:onSelectItemClick(itemid,index,itemguid,attach)
self:showProvideSelectGrids()
end

function UIFabaoLianhuaWin:onSelectBg()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoLianhuaWin:onBtnReset()
if self:hasPutAny()then
local selectList=table.deepCopy(self.selectList)
self.selectList={}
self.selectNumList={}
self.switchFlag=false
for _,v in pairs(selectList)do
local itemguid=v
self:freshProvideSelectSingleGirid(itemguid,false)
self:freshProvideSelectSingleItemNum(itemguid)
end

self:freshAttrs()
self:freshCostItems()
self:freshSelectItems()
self:freshLianhuaNum()
end
end

function UIFabaoLianhuaWin:onBtnContinue()
self:freshAttrs()
end

function UIFabaoLianhuaWin:onBtnAdd()
local item=self.item
local stage=self.stage
local lianhuatimes=item.itemData.lianhuatimes
local upTimes=fabaoConfig.getLianhuaUpTimesMaxNum(stage)
local left=upTimes-lianhuatimes
if left<=0 then
UIManager.error('已达上限，无法再次提升')
return
end
local itemid=fabaoConfig.getLianhuaUpItemid()
local itemConfig=itemsConfig.getConfig(itemid)
local name=itemConfig.name
local desc=FMT.fmt('消耗{0}可扩展炼化材料上限',FMT.cfmt(itemConfig.color,'[{0}]',name))
local costfunc=function(num)
return fabaoConfig.getLianhuaUpTimesCost(stage,lianhuatimes,lianhuatimes+num)
end
local pos=0
local guid=item.itemguid
if self.isEquip then
guid=fabaoModel.getDiziguidByItemguid(guid)
pos=1
end
local clickfunc=function(num)
fabaoProtocolControl.reqLianhuaFabaoLimitUp(guid,pos,lianhuatimes+num)
end
local argstable=
{
itemid=itemid,
max=left,
name='上限扩展',
desc=desc,
numTitle='扩展数量',
costfunc=costfunc,
clickfunc=clickfunc,
}
self:showWindow('UICommonBuyTimeWin',argstable)
end

function UIFabaoLianhuaWin:onHelp()
local offset=Vector2.New(-15,15)
local descTable={}
for i=1,10 do
local desc=cfg_lang_get(FMT.fmt('fabao_lianhua_readtips_{0}',i),false)
if desc then
descTable[#descTable+1]=desc
else
break
end
end
UIManager:showWindow('UIConditionTipsTwo',{showType=eArrowDirectionType.eBottomLeft,
descTable=descTable,
posItem=self.help,
pos=offset,
closeCall=function()
if self and not self.isClose then
self.help:setActive(true)
self.helpO:setActive(false)
end
end})
self.help:setActive(false)
self.helpO:setActive(true)
end


function UIFabaoLianhuaWin:onLianhua(lastAttrsList,attrsList)
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
self:startBehavior()
self.selectList={}
self.leftList={}
self.selectNumList={}
self.curPageIndex=1
self.isSetZero=false
self.selectItemguid=nil
self:freshProvideSelectGrids(true)
self:freshCostItems()
self:freshSelectItems()
self:freshLianhuaNum()
self:freshShowAttrs(lastAttrsList,attrsList)
end

function UIFabaoLianhuaWin:onLianhuaReset()
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
self:freshLianhuaNum()
self:freshAttrs()
end

function UIFabaoLianhuaWin:startBehavior()
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
light=false,


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

function UIFabaoLianhuaWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end

function UIFabaoLianhuaWin:onCloseSelect()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoLianhuaWin:onMoneyChanged(moneyType)
self:freshCostItems()
end

function UIFabaoLianhuaWin:onLianhuaResetBtn()
self:showWindow('UIFabaoLianhuaResetTipsWin',{itemguid=self.item.itemguid})
end




function UIFabaoLianhuaWin:initFilter()
self._filter={}


local Element={}
Element.filterType=ITEM_FILTER_TYPE.eAnyElement
Element.name="五行属性"
Element.list=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
Element.childNameList={}
for _,element in ipairs(Element.list)do
Element.childNameList[#Element.childNameList+1]=ELEMENT_TYPE.getNameX(element)
end
Element.sortid=1
self._filter[#self._filter+1]=Element


local LianhuaAttr={}
LianhuaAttr.filterType=ITEM_FILTER_TYPE.eFaBaoMaterialsLianhuaAttr
LianhuaAttr.name="炼化属性"
LianhuaAttr.list=fabaoConfig.getCommonConfig().lianhuaattrs
LianhuaAttr.childNameList={}
for _,attrid in ipairs(LianhuaAttr.list)do
local name
if _renameType[attrid]then
name=_renameType[attrid]
else
name=helper.getAttributeName(attrid)
end
LianhuaAttr.childNameList[#LianhuaAttr.childNameList+1]=name
end
LianhuaAttr.sortid=2
self._filter[#self._filter+1]=LianhuaAttr


if self._filter and#self._filter then
table.sort(self._filter,function(a,b)
return a.sortid<b.sortid
end)
end
end
function UIFabaoLianhuaWin:onFilterBtn()
if self.isShowFilter then
self:onCloseFilterBtn()
return
end
self.isShowFilter=true
self.filterRoot:setActive(true)
self:updateView()
end
function UIFabaoLianhuaWin:onCloseFilterBtn()
self.isShowFilter=false
self.filterRoot:setActive(false)

self.filterFlag={}
self:freshProvideSelectGrids(true)
end
function UIFabaoLianhuaWin:onBtnResetFilter()
for i,v in pairs(self.filterFlag)do
for i1,v1 in pairs(v)do
self.filterFlag[i][i1]=false
end
end
self:updateView()
self:freshProvideSelectGrids(true)
end
function UIFabaoLianhuaWin:updateView()
local pagenum=#self._filter
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end
function UIFabaoLianhuaWin:refreshPageItem(item,pageidx)
local pageData=self._filter[pageidx]
local pageTitle=pageData.name
local childNameList=pageData.childNameList
self.filterFlag[pageData.filterType]=self.filterFlag[pageData.filterType]or{}
local childFlagList=self.filterFlag[pageData.filterType]

item:SetChildText(pageItemCmpIndex.name,pageTitle)

local childnum=#childNameList
item:SetChildLayoutGroupCreateItems(pageItemCmpIndex.childCreater,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
self:refreshChildItem(childItem,i,childNameList,childFlagList,pageidx)
end

item:SetChildActive(pageItemCmpIndex.toggle,false)
end
function UIFabaoLianhuaWin:refreshChildItem(childItem,idx,childNameList,childFlagList,pageidx)
local desc_str=childNameList[idx]
local isselect=childFlagList[idx]or false
childItem:SetChildToggleChange(childItemCmpIndex.toggle,nil)
childItem:SetChildToggle(childItemCmpIndex.toggle,isselect)
childItem:SetChildToggleChange(childItemCmpIndex.toggle,function(name,isOn)
childFlagList[idx]=isOn
_this:freshProvideSelectGrids(true)
end)
childItem:SetChildText(childItemCmpIndex.name,desc_str)
end

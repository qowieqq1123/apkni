







def_class("UIWanBaoXunBaoDui_SelectItemsWin",UIWindowBase)









function UIWanBaoXunBaoDui_SelectItemsWin:bindComponents()

self.root=UIObject.get(self,0)
self.selectPanel=UIObject.get(self,1)
self.ScrollView=UIScrollViewSlow.get(self,2)
self.Dropdown3=UIDropdownEx.get(self,3)
self.Dropdown4=UIDropdownEx.get(self,4)
self.btnReset=UIButton.get(self,5)
self.closeBtn=UIButton.get(self,6)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWanBaoXunBaoDui_SelectItemsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Dropdown3);self.Dropdown3=nil;
_UIObject_release(self.Dropdown4);self.Dropdown4=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local _bag_filter_desc={}

local _colomn=4
local _row=6
local _dropItemHeight=40
local _dropViewHeight=150
local _fillItemLen=5




function UIWanBaoXunBaoDui_SelectItemsWin:onLoaded(...)
self:bindComponents()






self.Dropdown3:setChangeAction(function(...)self:onBagDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown4:setChangeAction(function(...)self:onBagDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self.Dropdown3:setDropdownLayoutedAction(function(...)self:onBagDropdownCreate(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown4:setDropdownLayoutedAction(function(...)self:onBagDropdownCreate(ITEM_FILTER_TYPE.eColor,...)end)

self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)

local list=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(list,function(color)
return FMT.fmt('{0}',eQualityColorName[color])
end,'所有')

local list=table.toTable(1,5)
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}品',stage)
end,'所有')

self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.bagFilter={}
self.bagFilter[ITEM_FILTER_TYPE.eStage]=0
self.bagFilter[ITEM_FILTER_TYPE.eColor]=0
end


function UIWanBaoXunBaoDui_SelectItemsWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_SelectItemsWin:onShow(argtable,afterOnloaded)
self.itemdata=argtable.itemdata
self.needMaxExp=wanbaoXunBaoDuiHelper.caculateNeedMaxExp(self.itemdata.itemguid)
self.selectStage=1
self.selectColor=1
self.selectList=argtable.selectDatas or{}
self.selectItemsLookup={}
self:resetLookup()

self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)

self.bagList=self:getMetarialsData()

self.ScrollView:freshSlowGrids(#self.bagList,_row,_colomn,not self.isSetZero)
self.isSetZero=true


local filterType=ITEM_FILTER_TYPE.eStage
local stageDescList=_bag_filter_desc[filterType]

local descList=table.deepCopy(stageDescList)
local options=table.reverse(descList)
self.Dropdown3:setOption(options)
local len=#stageDescList
local idx=self.bagFilter[filterType]or 0
local reIdx=len-1-idx

self.Dropdown3:setValue(reIdx)

local filterType=ITEM_FILTER_TYPE.eColor
local stageDescList=_bag_filter_desc[filterType]

local descList=table.deepCopy(stageDescList)
local options=table.reverse(descList)
self.Dropdown4:setOption(options)
local len=#stageDescList
local idx=self.bagFilter[filterType]or 0
local reIdx=len-1-idx

self.Dropdown4:setValue(reIdx)
end


function UIWanBaoXunBaoDui_SelectItemsWin:onHide()

end





function UIWanBaoXunBaoDui_SelectItemsWin:onBtnReset()
end



function UIWanBaoXunBaoDui_SelectItemsWin:onCloseBtn()
local timerid
timerid=self:setTimer(0.5,1,function()
self:stopTimerByID(timerid)
self:closeSelf()
end)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
end

function UIWanBaoXunBaoDui_SelectItemsWin:bindGrid(index,widget)
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
local countStr=num>0 and FMT.fmt('{0}/{1}',itemInfo.itemcount,num)or num<=0 and itemInfo.itemcount
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
widget:SetChildButtonClick(9,function()self:onClickDelNumButton(index,itemid,itemguid)end,true)
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
end

function UIWanBaoXunBaoDui_SelectItemsWin:onClickDelNumButton(index,itemid,itemguid)
local index=self.selectItemsLookup[tostring(itemguid)]
table.remove(self.selectList,index)
self:resetLookup()

self:freshProvideSelectSingleGirid(itemguid,false)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EquipWin","freshCostList",self.selectList)
end

function UIWanBaoXunBaoDui_SelectItemsWin:resetLookup()
self.selectItemsLookup={}
for k,v in pairs(self.selectList)do
self.selectItemsLookup[tostring(v.itemguid)]=k
end
end

function UIWanBaoXunBaoDui_SelectItemsWin:getMetarialsData()
local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaoMao}},
[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,{self.selectColor}},
[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eGreaterEquals,{self.selectStage}},
}
local eitems=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter)

local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaterials}},
[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,{self.selectColor}},
[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eGreaterEquals,{self.selectStage}},
[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,{31501,31502}},
}
local mitems=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter)

local items=table.concatTable(mitems,eitems)

return items
end

function UIWanBaoXunBaoDui_SelectItemsWin:getMetarialsPropData()
local propdata={}
local items=self:getMetarialsData()
for k,v in pairs(items)do
table.insert(propdata,itemsComponentHelper.getCommonFillData(v,{showname=false,nomalname=false,showcount=items.itemcount>1}))
end
return propdata
end

function UIWanBaoXunBaoDui_SelectItemsWin:onBagDropdownCreate(dropidx,scrollTrans,contentTrans)
local filterType=dropidx
local idx=self.bagFilter[filterType]or 0
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


function UIWanBaoXunBaoDui_SelectItemsWin:onBagDropdownChange(dropidx,reIdx)

local len=#_bag_filter_desc[dropidx]
local idx=len-1-reIdx
if self.bagFilter[dropidx]==idx then return end
self.selectItemguid=nil
self.curPageIndex=1
self.isSetZero=false
self.bagFilter[dropidx]=idx

end

function UIWanBaoXunBaoDui_SelectItemsWin:getSelectItemNum(itemguid)
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
local selectTable=selectList[index]or{}
return selectTable.count or 0
end
return 0
end

function UIWanBaoXunBaoDui_SelectItemsWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
if#self.selectList>=5 then
UIManager.info("满了满了，装不下了")
return
end
local relBuyNum,fill=self:getCanPutMaxJilianNum(itemguid)
local hasNum=fill>0
local min=1
local val=hasNum and relBuyNum or 1


tipsManager.showTips({formType=TIPS_FORM_TYPE.eMMEquipJinLian,
tipsType=TIPS_TYPE.eCommonWBXBDItem,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,selectNumCmpArgs={min=min,max=relBuyNum,val=val}}})

end

function UIWanBaoXunBaoDui_SelectItemsWin:getCanPutMaxJilianNum(itemguid)
if not self:checkMaxLv(false)then return 0,0 end
local index=self.selectItemsLookup[tostring(itemguid)]
local alreadyNum=0
if not index then
if self:isFull()then return 0,0 end
else
local info=self.selectList[index]or{}
alreadyNum=info.count or 0
end
local relUseNum=self:getCanPutItemNum(itemguid,true)
return relUseNum,alreadyNum
end

function UIWanBaoXunBaoDui_SelectItemsWin:getSelectFillData(item,conf)
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


function UIWanBaoXunBaoDui_SelectItemsWin:getSelectTempFillData()
local conf={}
conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end

function UIWanBaoXunBaoDui_SelectItemsWin:getNextFillIdx(itemguid)
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

function UIWanBaoXunBaoDui_SelectItemsWin:isFull()
for i=1,_fillItemLen do
local info=self.selectList[i]
if not info then
return false
end
end
return true
end

function UIWanBaoXunBaoDui_SelectItemsWin:getCanPutItemNum(itemguid,canOverExp)
local itemdata=wanbaoXunBaoDuiHelper.getWBXBDItem(itemguid)
local addExp=wanbaoXunBaoDuiHelper.getJilianValue(itemguid)
local maxExp=self:caculateGetExpUnclude(itemguid)
local needNum=Mathf.Floor(maxExp/addExp)
local relNum=Mathf.Min(needNum,itemdata.itemcount)
if canOverExp and relNum<itemdata.itemcount then
relNum=relNum+1
end
return relNum
end

function UIWanBaoXunBaoDui_SelectItemsWin:checkMaxLv(warn)
local upItem=self.itemdata
local jilianlv=upItem.itemData and(upItem.itemData.jl_lv or 0)+1 or 0
local maxlv=wanbaoXunBaoDuiHelper.getJilianMaxLv(upItem.itemguid)
if jilianlv>=maxlv then
if warn then
UIManager.error('装备精炼等级达到上限')
end
return false
end
return true
end

function UIWanBaoXunBaoDui_SelectItemsWin:caculateGetExpUnclude(guid)
local totalExp=0
local sguid=tostring(guid)
for k,v in pairs(self.selectItemsLookup)do
if k~=sguid then
local guid=int64.new(k)
local num=self:getSelectItemNum(guid)
local exp=wanbaoXunBaoDuiHelper.getJilianValue(guid)
totalExp=totalExp+num*exp
end
end
return self.needMaxExp-totalExp
end

function UIWanBaoXunBaoDui_SelectItemsWin:putItem(index,itemid,itemguid,putnum)

if itemid==-1 then return end

if putnum>0 then
self:freshProvideSelectSingleGirid(itemguid,true)
else
self:freshProvideSelectSingleGirid(itemguid,false)
end


if putnum>0 then
local index=self.selectItemsLookup[tostring(itemguid)]
if index then
self.selectList[index]={itemguid=itemguid,count=putnum}
else
index=#self.selectList+1
self.selectList[index]={itemguid=itemguid,count=putnum}
self.selectItemsLookup[tostring(itemguid)]=index
end
else
local index=self.selectItemsLookup[tostring(itemguid)]
if index then
table.remove(self.selectList,index)
end
end




UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EquipWin","freshCostList",self.selectList)


end

function UIWanBaoXunBaoDui_SelectItemsWin:freshProvideSelectSingleGirid(itemguid,flag,lastIdx)
local idx=lastIdx or self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,flag)
end
end
end

function UIWanBaoXunBaoDui_SelectItemsWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end

function UIWanBaoXunBaoDui_SelectItemsWin:onCloseTips()
tipsManager.closeTips()
end

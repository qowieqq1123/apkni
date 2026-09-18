







def_class("UIFabaoBatchCreateWin",UIWindowBase)









function UIFabaoBatchCreateWin:bindComponents()

self.mask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.closeTipsMask=UIButton.get(self,2)
self.btnEquips=UIButton.get(self,3)
self.btnMaterials=UIButton.get(self,4)
self.selectMaterilas=UIObject.get(self,5)
self.lock=UIObject.get(self,6)
self.selectEquip=UIObject.get(self,7)
self.jingcuidesc=UIText.get(self,8)
self.lianzhiCostIcon1=UIImage.get(self,9)
self.lianzhiCostIcon2=UIImage.get(self,10)
self.titleRoot=UIObject.get(self,11)
self.tempSize=UIObject.get(self,12)
self.btnsRoot=UIObject.get(self,13)
self.Dropdown1=UIDropdownEx.get(self,14)
self.Dropdown2=UIDropdownEx.get(self,15)
self.listContent=UIObject.get(self,16)
self.selectDesc=UIText.get(self,17)
self.btnLianzhi=UIButton.get(self,18)
self.listScroller=UIObject.get(self,19)
self.maxCountText=UIText.get(self,20)
self.Content=UIObject.get(self,21)
self.lianzhiCost2=UIText.get(self,22)
self.lianzhiCost1=UIText.get(self,23)
self.btnReset=UIButton.get(self,24)
self.btnOnekey=UIButton.get(self,25)
self.ScrollView=UIScrollViewSlow.get(self,26)
self.btnFunc_2=UIButton.get(self,27)
self.btnFunc_4=UIButton.get(self,28)
self.btnFunc_3=UIButton.get(self,29)
self.btnFunc_5=UIButton.get(self,30)
self.btnFunc_1=UIButton.get(self,31)
self.btnSelects_1=UIObject.get(self,32)
self.btnFuncTxt_1=UIText.get(self,33)
self.btnSelects_2=UIObject.get(self,34)
self.btnFuncTxt_2=UIText.get(self,35)
self.btnSelects_3=UIObject.get(self,36)
self.btnFuncTxt_3=UIText.get(self,37)
self.btnSelects_4=UIObject.get(self,38)
self.btnFuncTxt_4=UIText.get(self,39)
self.btnSelects_5=UIObject.get(self,40)
self.btnFuncTxt_5=UIText.get(self,41)
self.weightPanel=UIObject.get(self,42)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.closeTipsMask:setButtonClick(function()self:onCloseTipsMask()end)

self.btnEquips:setButtonClick(function()self:onBtnEquips()end)

self.btnMaterials:setButtonClick(function()self:onBtnMaterials()end)

self.btnLianzhi:setButtonClick(function()self:onBtnLianzhi()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnOnekey:setButtonClick(function()self:onBtnOnekey()end)

self.btnFunc_2:setButtonClick(function()self:onBtnFunc_2()end)

self.btnFunc_4:setButtonClick(function()self:onBtnFunc_4()end)

self.btnFunc_3:setButtonClick(function()self:onBtnFunc_3()end)

self.btnFunc_5:setButtonClick(function()self:onBtnFunc_5()end)

self.btnFunc_1:setButtonClick(function()self:onBtnFunc_1()end)
self.btnFunc={
self.btnFunc_1,
self.btnFunc_2,
self.btnFunc_3,
self.btnFunc_4,
self.btnFunc_5,
}
self.btnSelects={
self.btnSelects_1,
self.btnSelects_2,
self.btnSelects_3,
self.btnSelects_4,
self.btnSelects_5,
}
self.btnFuncTxt={
self.btnFuncTxt_1,
self.btnFuncTxt_2,
self.btnFuncTxt_3,
self.btnFuncTxt_4,
self.btnFuncTxt_5,
}



end


function UIFabaoBatchCreateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTipsMask);self.closeTipsMask=nil;
_UIObject_release(self.btnEquips);self.btnEquips=nil;
_UIObject_release(self.btnMaterials);self.btnMaterials=nil;
_UIObject_release(self.selectMaterilas);self.selectMaterilas=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.selectEquip);self.selectEquip=nil;
_UIObject_release(self.jingcuidesc);self.jingcuidesc=nil;
_UIObject_release(self.lianzhiCostIcon1);self.lianzhiCostIcon1=nil;
_UIObject_release(self.lianzhiCostIcon2);self.lianzhiCostIcon2=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.tempSize);self.tempSize=nil;
_UIObject_release(self.btnsRoot);self.btnsRoot=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.listContent);self.listContent=nil;
_UIObject_release(self.selectDesc);self.selectDesc=nil;
_UIObject_release(self.btnLianzhi);self.btnLianzhi=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.maxCountText);self.maxCountText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.lianzhiCost2);self.lianzhiCost2=nil;
_UIObject_release(self.lianzhiCost1);self.lianzhiCost1=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnOnekey);self.btnOnekey=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.btnFunc_2);self.btnFunc_2=nil;
_UIObject_release(self.btnFunc_4);self.btnFunc_4=nil;
_UIObject_release(self.btnFunc_3);self.btnFunc_3=nil;
_UIObject_release(self.btnFunc_5);self.btnFunc_5=nil;
_UIObject_release(self.btnFunc_1);self.btnFunc_1=nil;
_UIObject_release(self.btnSelects_1);self.btnSelects_1=nil;
_UIObject_release(self.btnFuncTxt_1);self.btnFuncTxt_1=nil;
_UIObject_release(self.btnSelects_2);self.btnSelects_2=nil;
_UIObject_release(self.btnFuncTxt_2);self.btnFuncTxt_2=nil;
_UIObject_release(self.btnSelects_3);self.btnSelects_3=nil;
_UIObject_release(self.btnFuncTxt_3);self.btnFuncTxt_3=nil;
_UIObject_release(self.btnSelects_4);self.btnSelects_4=nil;
_UIObject_release(self.btnFuncTxt_4);self.btnFuncTxt_4=nil;
_UIObject_release(self.btnSelects_5);self.btnSelects_5=nil;
_UIObject_release(self.btnFuncTxt_5);self.btnFuncTxt_5=nil;
_UIObject_release(self.weightPanel);self.weightPanel=nil;
self.btnFunc=nil;
self.btnSelects=nil;
self.btnFuncTxt=nil;
end















local _bag_filter_desc={}
local _bag_filter_val={}
local _colomn=4
local _row=6
local _this=nil
local _dropItemHeight=40
local _dropViewHeight=150
local _mainIdx=1
local _fzIdx=6
local _jhIdx=7
local _equipIdxArray={1,6,2,3,4,5,7}
local _materialIdxArray={1,2,3,4,5,7}

local _equipIdxOneKeyArray={1,6,2,3,4,5}
local _materialIdxOneKeyArray={1,2,3,4,5}

local _defaultSelectPlanIndex=1
local _clickCd=2

local _planListItemCmpIndex={
bg=0,
select=1,
root=2,
nameText=3,
arrow=4,
arrowSelect=5,
mainItem=6,
costItemList={7,8,9,10},
weightTextList={11,12,13,14,15},
fabaoItem=16,
removeBtn=17,
addBtnImage=18,
addBtn=19,
jyitem=20,
weighthelp=21,
}




function UIFabaoBatchCreateWin:onLoaded(...)
_this=self
self:bindComponents()

self.ScrollView:setSlowClickAction(nil)

self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(2,...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(1,...)end)
self.Dropdown2:setDropdownLayoutedAction(function(...)self:onDropdownCreate(2,...)end)

self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
self:addNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)

self._onMoneyChanged=function(...)self:onMoneyChanged(...)end
self:addNotify(notifyConfig.on_money_changed,self._onMoneyChanged)

local list=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
_bag_filter_desc[ITEM_FILTER_TYPE.eElement]=itemsFilterHelper.getFilterNames(list,function(element)
return ELEMENT_TYPE.getNameX(element)
end,'所有')
_bag_filter_val[ITEM_FILTER_TYPE.eElement]=list

local maxStage=fabaoConfig.getFabaoMaxEquipStage()
local list=table.toTable(1,maxStage)
self.equipStageVal=list
self.equipStageDesc=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}阶',stage)
end,'所有')

local list=table.toTable(1,5)
self.nomalStageVal=list
self.nomalStageDesc=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}阶',stage)
end,'所有')

local list=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(list,function(color)
return FMT.fmt('{0}',eQualityColorName[color])
end,'所有')

_bag_filter_val[ITEM_FILTER_TYPE.eColor]=list


local weaponCfg=cfg_discipleweaponconfig()
local types=table.toTable(EQUIP_TYPE.eWeapon,EQUIP_TYPE.eShoot)
local list={}
for _,v in ipairs(types)do
if v==EQUIP_TYPE.eWeapon then
for ii,_ in ipairs(weaponCfg)do
list[#list+1]=v*100+ii
end
else
list[#list+1]=v*100
end
end
_bag_filter_val[ITEM_FILTER_TYPE.eItemType1AndType2]=list
_bag_filter_desc[ITEM_FILTER_TYPE.eItemType1AndType2]=itemsFilterHelper.getFilterNames(list,function(num)
local type1=math.floor(num/100)
local type2=num-type1*100
local name1=cfg_discipleequiptypeconfig_get(type1).name
local name2=type2>0 and cfg_discipleweaponconfig_get(type2).name
if name2 then
return FMT.fmt('{0}-{1}',name1,name2)
end
return FMT.fmt('{0}',name1)
end,'所有')

self.jingcaiStageDesc={'所有'}

_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=self.nomalStageDesc

self.filter={}
self.filter[ITEM_FILTER_TYPE.eElement]=0
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.filter[ITEM_FILTER_TYPE.eColor]=0

self.selectBagType=BAG_TYPE.eMaterialsBag

self.selectList={}
self.selectNumList={}
self.showAttrPanel=false
self.lianzhiType=FABAO_LIANZHI_TYPE.eNomal

self.selectDesc:setActive(false)

self.unlockItem={}
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.curPageIndex=1
self.isSetZero=false
self.selectItemguid=nil
self.selectItemguidIdx=nil
self.isSelectGrid=nil

self.selectPlanIndex=_defaultSelectPlanIndex

self.funcFilter=0
self:setFunctionBtns()
end


function UIFabaoBatchCreateWin:__delete()
self.isClickLianZhiBtn=nil


self:unbindComponents()
_this=nil
end




function UIFabaoBatchCreateWin:onShow(argtable,afterOnloaded)
if argtable then
self.ubdId=argtable.ubdId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:getBuildingData(self.ubdId)
zongmenModel:countManufacturePercent(self.bdData)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
self.bdType=self.config.id
local build_id=self.bdData.build_id
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)

local diziguid=self.bdData.dizi_id
self.diziguid=tostring(diziguid)=='0'and 0 or diziguid
end
self.maxPlanCount=fabaoConfig.getCommonConfig().batch
self:refresh()
end


function UIFabaoBatchCreateWin:onHide()

end

function UIFabaoBatchCreateWin:refresh()

self:refreshLeftPanel()


self:refreshRightPanel()
end



function UIFabaoBatchCreateWin:refreshLeftPanel()
self:freshProvideGrids(self.selectBagType)
end

function UIFabaoBatchCreateWin:freshProvideGrids(bagType)
self.isSetZero=false
self.curPageIndex=1
self.selectBagType=bagType
self.filter={}
self.filter[ITEM_FILTER_TYPE.eElement]=0
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.ScrollView:clearSlowItems()
self:freshFilterDesc()
self:setDropdowns()
self:freshProvideSelectGrids(true)
self:freshBagBtns()
end

function UIFabaoBatchCreateWin:freshProvideSelectGrids(freshData)
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

function UIFabaoBatchCreateWin:freshBagList()
local hasMain=self:hasPutMainItem()
local filter={}
for k,v in pairs(self.filter)do
if v==0 then
filter[k]=nil
else
filter[k]=_bag_filter_val[k][v]
end
end


local iseMaterialsBag=self.selectBagType==BAG_TYPE.eMaterialsBag
if iseMaterialsBag then
if filter[ITEM_FILTER_TYPE.eElement]==nil then
filter[ITEM_FILTER_TYPE.eElement]={ITEM_FILTER_COMPARE.eNotNull}
end
filter[ITEM_FILTER_TYPE.eItemConfigAttr]={ITEM_FILTER_COMPARE.eEquals,{{'type1',1}}}
else
filter[ITEM_FILTER_TYPE.eItemConfigAttr]={ITEM_FILTER_COMPARE.eNotNull,{'shentong'}}
end

if self.funcFilter>0 then
filter[ITEM_FILTER_TYPE.eFaBaoMaterialsFuncType]={ITEM_FILTER_COMPARE.eEquals,self.funcFilter}
end


local bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)
local sortTag={}
for i,v in ipairs(bagList)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local isLock=self:isLock(itemid)
local useFlag=not isLock and 1 or 0
local itemCfg=itemsConfig.getConfig(itemid)

local stageUseFlag=useFlag*itemCfg.stage
if hasMain then
stageUseFlag=itemCfg.stage
end
local num=self:getSelectItemNum(v.itemguid)
local needNum=self:getNeedNumByMainHole(v.itemguid)

local gray=not hasMain and(isLock or num+needNum>v.itemcount)or false
local grayNum=gray and 0 or 1
if gray then
stageUseFlag=0
end
sortTag[itemguidStr]=stageUseFlag*9999999+grayNum*999999+(100-itemCfg.stage)*999+itemid/1000
end
table.sort(bagList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)




















self.bagList=bagList
self:onSortEquipItems()
end


function UIFabaoBatchCreateWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
local hasPutMainItem=self:hasPutMainItem()
local inGray=not hasPutMainItem or false
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectItemNum(itemguid)
local has=num>0
local itemTxt=num>0 and FMT.fmt('{0}/{1}',num,itemInfo.itemcount)or itemInfo.itemcount>1 and itemInfo.itemcount or''
local showbg=true
local islock=not hasPutMainItem and self:isLock(itemid)or false
local showStage=itemConfig.stage~=nil
local needNum=self:getNeedNumByMainHole(itemguid)

local isGray=num+needNum>itemcount and inGray or islock or false
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true

widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)

widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildImageExGray(2,isGray)
widget:SetChildIcon(3,iconName,false)
widget:SetChildImageExGray(3,isGray)
widget:SetChildText(4,itemTxt)
widget:SetChildActive(5,itemTxt~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,islock)
widget:SetChildActive(10,has)
widget:SetChildButtonClick(10,function()self:onClickGridButton(index,itemid,itemguid)end,true)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(itemid,index,itemguid,nil)
end)
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
widget:SetChildButtonClick(-1,function()
self:onClickGrid(-1,index,-1,nil)
end)
end
end

function UIFabaoBatchCreateWin:onSortEquipItems()
if self.selectBagType~=BAG_TYPE.eEquipBag then return end
local sortCompareType=ITEM_SORT_COMPARE_TYPE.eDownOrder
local sortRule={}
sortRule.sort=sortCompareType
sortRule[1]={ITEM_SORT_TYPE.eNewFlag}
sortRule[2]={ITEM_SORT_TYPE.eStage}
sortRule[3]={ITEM_SORT_TYPE.eElement}
sortRule[4]={ITEM_SORT_TYPE.eColor}
table.sort(self.bagList,function(a,b)
local aVal=itemsSortHelper.sort(a,sortRule)
local bVal=itemsSortHelper.sort(b,sortRule)
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return aVal<bVal
end
return aVal>bVal
end)
end


function UIFabaoBatchCreateWin:isLock(itemid)
return not fabaoHelper.isUnlockByCreate(itemid)
end


function UIFabaoBatchCreateWin:setDropdowns()
local isMaterilas=self.selectBagType==BAG_TYPE.eMaterialsBag
self.Dropdown1:setActive(true)
local filterType=ITEM_FILTER_TYPE.eStage
local descList=_bag_filter_desc[filterType]
local descCopyList=table.weakCopy(descList)
local options=table.reverse(descCopyList)
self.Dropdown1:setOption(options)
local len=#descList
local idx=self.filter[filterType]or 0
local reIdx=len-1-idx
self.Dropdown1:setValue(reIdx)

local filterType=isMaterilas and ITEM_FILTER_TYPE.eElement or ITEM_FILTER_TYPE.eItemType1AndType2
local descList=_bag_filter_desc[filterType]
local descCopyList=table.weakCopy(descList)
local options=table.reverse(descCopyList)
self.Dropdown2:setOption(options)
local len=#descList
local idx=self.filter[filterType]or 0
local reIdx=len-1-idx
self.Dropdown2:setValue(reIdx)
end

function UIFabaoBatchCreateWin:freshFilterDesc()
local isEquipBag=self.selectBagType==BAG_TYPE.eEquipBag
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=isEquipBag and self.equipStageDesc or
self.nomalStageDesc
_bag_filter_val[ITEM_FILTER_TYPE.eStage]=isEquipBag and self.equipStageVal or
self.nomalStageVal
end

function UIFabaoBatchCreateWin:freshBagBtns()

local isMaterilas=self.selectBagType==BAG_TYPE.eMaterialsBag
local isEquip=self.selectBagType==BAG_TYPE.eEquipBag
self.btnsRoot:setActive(false)
self.titleRoot:setActive(isEquip)
self.tempSize:setActive(false)
self.selectEquip:setActive(isEquip)
self.selectMaterilas:setActive(isMaterilas)
self.btnOnekey:setActive(isMaterilas)

local tabType=FULL_TAB_TYPE.eFabao_zhuangbei

self.btnEquips:setActive(false)
self.lock:setActive(not fullScreenModel.isTabOpen(tabType))
end

function UIFabaoBatchCreateWin:freshProvideGridSelect(itemguid)
local idx=self:getBagItemIdx(itemguid)

if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true)
else
loggerUtil.logErrFMT('没找到序号的widget：{0}',tostring(itemguid))
end
end
end

function UIFabaoBatchCreateWin:freshLianZhiRoot(selectPlanIndex)
local flag=true
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
local isMakeByEquip=self:isMakeByEquip(selectPlanIndex)
if self.lianzhiType~=FABAO_LIANZHI_TYPE.eNomal or self.diziguid==0 or not self:isFullHoles(selectPlanIndex)then
flag=false
end


self:freshPlanWeight(selectPlanIndex)
self:refreshCostMoneyRoot()
end

function UIFabaoBatchCreateWin:freshPlanWeight(selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
if not self.planList[selectPlanIndex]then
self.planList[selectPlanIndex]={}
end

local weightList
local planData=self.planList[selectPlanIndex]

local mainid,itemlist=self:getPlanMaterials(selectPlanIndex)
local info=planData and planData.jyItem or{}
local isCanShow=self.diziguid and self.diziguid~=0 and mainid and itemlist and#itemlist-1>=#_planListItemCmpIndex.costItemList
if isCanShow then
weightList=fabaoHelper.lianzhiWeight(self.diziguid,mainid,itemlist,info.itemid)or{}
planData.weightList=weightList

local fabaoGuid=fabaoPreviewModel:create_normalFabao(mainid,itemlist)
planData.fabaoItem={
itemid=mainid,
itemguid=fabaoGuid
}
else
planData.weightList=nil
planData.fabaoItem=nil
end
end


function UIFabaoBatchCreateWin:onDropdownChange(dropIdx,reIdx)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local len=#_bag_filter_desc[typo]
local idx=len-1-reIdx
if self.filter[typo]==idx then return end
self.curPageIndex=1
self.isSetZero=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
local val=_bag_filter_val[typo][idx]
self.filter[typo]=idx
self:freshProvideSelectGrids(true)

self:onCloseTipsMask()
end

function UIFabaoBatchCreateWin:onDropdownCreate(dropIdx,scrollTrans,contentTrans)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local filterType=typo
local idx=self.filter[filterType]or 0
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


function UIFabaoBatchCreateWin:refreshRightPanel(isKeepPos)
local contentPos
if isKeepPos then

contentPos=self.listContent:getChildAnchoredPosition()
end

self:getCreatePlanList()
local planCount=#self.planList
local needShowAdd=planCount<self.maxPlanCount
local count=needShowAdd and planCount+1 or planCount
self.listScroller:setChildScrollViewCreateGrids(count,1)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshPlanListItem(grids[i-1],i)
end

if isKeepPos then

local scrollerViewHight=self.listScroller:getChildSizeDeltaY()
local contentHight=self.listContent:getChildSizeDeltaY()
local maxY=contentHight-scrollerViewHight
if maxY<0 then
maxY=0
end
local jumpY=contentPos.y<=maxY and contentPos.y or maxY
self.listContent:setChildAnchoredPosition(Vector2.New(contentPos.x,jumpY))
end


local planCountStr
local countStr
if planCount>=self.maxPlanCount then

countStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",planCount,self.maxPlanCount)
else

countStr=FMT.cfmt(FONT_COLOR.eGreenColor,"{0}/{1}",planCount,self.maxPlanCount)
end
planCountStr=FMT.fmt("最大炼制方案数（{0}）",countStr)
self.maxCountText:setText(planCountStr)


self:refreshCostMoneyRoot()
end

function UIFabaoBatchCreateWin:refreshPlanListItem(item,index)
if item==nil then
item=self.listScroller:getChildScrollViewItemWidget(index-1)
end
if item then
item:SetChildActive(-1,true)
local planData=self.planList[index]
if planData then
item:SetChildActive(_planListItemCmpIndex.weighthelp,planData.mainItem~=nil)
item:SetChildButtonClick(_planListItemCmpIndex.weighthelp,function()
self:showWeightPanel(planData.mainItem.itemid)
end,true)
item:SetChildActive(_planListItemCmpIndex.addBtnImage,false)
item:SetChildActive(_planListItemCmpIndex.root,true)
local planCount=#self.planList
local isShowRemoveBtn=planCount>1

local isSelect=self.selectPlanIndex and self.selectPlanIndex==index
item:SetChildActive(_planListItemCmpIndex.bg,not isSelect)
item:SetChildActive(_planListItemCmpIndex.select,isSelect)
if not isSelect then
item:SetChildButtonClick(_planListItemCmpIndex.bg,function()
self:onSelectPlan(index)
end)
end


local planName=FMT.fmt("法宝炼制方案{0}",index)
item:SetChildText(_planListItemCmpIndex.nameText,planName)


item:SetChildActive(_planListItemCmpIndex.removeBtn,isShowRemoveBtn)
item:SetChildButtonClick(_planListItemCmpIndex.removeBtn,function()
self:onClickPlanListRemoveBtn(index)
end)


local mainItemWidget=item:GetChildWidgetBase(_planListItemCmpIndex.mainItem)
self:setMaterialsItem(mainItemWidget,_mainIdx,index,planData.mainItem)


for i,cmpIndex in ipairs(_planListItemCmpIndex.costItemList)do
local itemIdx=i+1
local itemWidget=item:GetChildWidgetBase(cmpIndex)
local itemData=planData.costItemList and planData.costItemList[i]or nil
self:setMaterialsItem(itemWidget,itemIdx,index,itemData)
end
local itemWidget=item:GetChildWidgetBase(_planListItemCmpIndex.jyitem)
self:setMaterialsItem(itemWidget,_jhIdx,index,planData and planData.jyItem or nil,planData.mainItem)


local fabaoData=planData.fabaoItem
local fabaoItem
local itemcount=''
local fabaoItemWidget=item:GetChildWidgetBase(_planListItemCmpIndex.fabaoItem)
if fabaoData then
if self.diziguid and self.diziguid~=0 then
local itemid=fabaoData.itemid
local itemguid=fabaoData.itemguid

fabaoItem=fabaoHelper.getFabao(itemguid)
local mainid,itemlist
if(not fabaoItem and itemid)or(fabaoItem and fabaoItem.itemid~=itemid)then

mainid,itemlist=self:getPlanMaterials(index)
local fabaoGuid=fabaoPreviewModel:create_normalFabao(mainid,itemlist)
planData.fabaoItem={
itemid=mainid,
itemguid=fabaoGuid
}
fabaoItem=fabaoHelper.getFabao(fabaoGuid)
end
local weightList=planData.weightList
if fabaoItem and not weightList then
if not mainid or not itemlist then
mainid,itemlist=self:getPlanMaterials(index)
end
local jyItem=planData and planData.jyItem or{}
local jyid=jyItem.itemid
weightList=fabaoHelper.lianzhiWeight(self.diziguid,mainid,itemlist,jyid)or{}
planData.weightList=weightList
end
else
planData.fabaoItem=nil
planData.weightList=nil
end
end
local conf={showname=false,itemcount=itemcount,showCountBG=itemcount~=''}
item:SetChildPropData(_planListItemCmpIndex.fabaoItem,self:getSelectFillData(fabaoItem,conf))
fabaoItemWidget:SetChildButtonClick(-1,function()
self:onFabaoItemClick(index)
end)


local hasFabao=fabaoData~=nil
item:SetChildActive(_planListItemCmpIndex.arrow,not hasFabao)
item:SetChildActive(_planListItemCmpIndex.arrowSelect,hasFabao)


local weightList=planData.weightList or{}
for i,v in ipairs(_planListItemCmpIndex.weightTextList)do
local rateStr=weightList[i]or"?"
item:SetChildText(v,rateStr)
end
else
item:SetChildActive(_planListItemCmpIndex.weighthelp,false)
item:SetChildActive(_planListItemCmpIndex.root,false)
item:SetChildActive(_planListItemCmpIndex.bg,true)
item:SetChildActive(_planListItemCmpIndex.select,false)
item:SetChildActive(_planListItemCmpIndex.addBtnImage,true)


item:SetChildButtonClick(_planListItemCmpIndex.addBtn,function()
self:onClickPlanListAddBtn()
end)
end
end
end

function UIFabaoBatchCreateWin:getCreatePlanList()
if not self.planList then


self.planList={}
end

local planCount=#self.planList
if planCount<=0 then
self:addEmptyPlanItem()
end
end

function UIFabaoBatchCreateWin:addEmptyPlanItem()
local planItem={
mainItem=nil,
costItemList=nil,
fabaoItem=nil,
costMoneyCount=nil,
weightList=nil,
jyItem=nil,
}
table.insert(self.planList,planItem)
local index=#self.planList
return index
end

function UIFabaoBatchCreateWin:removePlanItemByIndex(index)
if not self.planList or not self.planList[index]then
return
end

if self.selectPlanIndex>index then
self.selectPlanIndex=self.selectPlanIndex-1
elseif self.selectPlanIndex==index then
self.selectPlanIndex=_defaultSelectPlanIndex
end

table.remove(self.planList,index)


local newSelectList={}
for planIndex,v in pairs(self.selectList)do
if planIndex<index then
newSelectList[planIndex]=v
elseif planIndex>index then
newSelectList[planIndex-1]=v
end
end
self.selectList=newSelectList

local newSelectNumList={}
for planIndex,v in pairs(self.selectNumList)do
if planIndex<index then
newSelectNumList[planIndex]=v
elseif planIndex>index then
newSelectNumList[planIndex-1]=v
end
end
self.selectNumList=newSelectNumList
end

function UIFabaoBatchCreateWin:setMaterialsItem(itemWidget,itemIndex,listIndex,itemData,mainItem)
if itemIndex==_jhIdx then
if mainItem==nil then
itemWidget:SetChildActive(-1,false)
return
else
itemWidget:SetChildActive(-1,true)
end
end

local itemcount=''
local item
local itemid
local isSelect=false
local mainid=mainItem and mainItem.itemid
if itemData then
itemid=itemData.itemid
item={itemid=itemid}
local needNum
if self:isMainHole(itemIndex)or self:isFzHole(itemIndex)then
needNum=self:getNeedNumInCfgItemid(itemid)
elseif self:isJHIdxHole(itemIndex)then
needNum=self:getJhNeedNumInCfgItemid(mainid,itemid)
else
needNum=1
end
if needNum>=1 then
local hasNum=self:getPutNum(itemIndex,listIndex)
if needNum>1 then
itemcount=needNum>hasNum and FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',hasNum,needNum)or FMT.fmt('{0}/{1}',hasNum,needNum)
else
itemcount=needNum>hasNum and FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',hasNum,needNum)or''
end
end
itemWidget:SetChildButtonClick(9,function()self:onClickPlanItemDeleteButton(listIndex,itemIndex,itemid)end,true)


local isSelectPlan=self.selectPlanIndex and self.selectPlanIndex==listIndex
isSelect=isSelectPlan and self.selectPlanItemIndex and self.selectPlanItemIndex==itemIndex or false
end
local conf={showname=false,itemcount=itemcount,showCountBG=itemcount~='',select=isSelect}
itemWidget:SetChildPropData(-1,self:getSelectFillData(item,conf))

itemWidget:SetChildButtonClick(-1,function()
self:onSelectItemClick(itemid,listIndex,itemIndex,nil)
end)
end

function UIFabaoBatchCreateWin:refreshCostMoneyRoot()
self.refreshMoneyTypeList_lookup={}
local costMoneyIndexList_lookup={}
self.costMoneyList={}

local percent=self.bdData.pcreatesubpercent or 0
for planIndex,planData in ipairs(self.planList)do

local mainid,itemlist=self:getPlanMaterials(planIndex)
local isFinishPlan=mainid and itemlist and#itemlist-1>=#_planListItemCmpIndex.costItemList
if isFinishPlan then
local stage=fabaoHelper.computeStage(itemlist)
local cost=fabaoConfig.getCostByLianzhi(stage)
if cost==nil then
loggerUtil.logErrFMT('当前材料/装备{0}没有配置对应阶数的金钱消耗',mainid)
end

for i,v in ipairs(cost)do
local moneyType=v[1]
local moneyCount=v[2]
local price=math.ceil(moneyCount*(1+percent/100))
if not costMoneyIndexList_lookup[moneyType]then
self.costMoneyList[#self.costMoneyList+1]={moneyType=moneyType,count=price}
costMoneyIndexList_lookup[moneyType]=#self.costMoneyList
else
local index=costMoneyIndexList_lookup[moneyType]
local count=self.costMoneyList[index].count
self.costMoneyList[index].count=count+price
end
end
end
end

local cost1=self.costMoneyList[1]
local cost2=self.costMoneyList[2]
local isShowCost1=cost1~=nil
local isShowCost2=cost2~=nil
self.lianzhiCost1:setActive(isShowCost1)
self.lianzhiCost2:setActive(isShowCost2)
if isShowCost1 then
local moneyType=cost1.moneyType
self.refreshMoneyTypeList_lookup[moneyType]=true
local moneyCount=cost1.count
local enoughMoney1=moneyModel.checkEnoughMoney(moneyType,moneyCount)
self.lianzhiCostIcon1:setImageIcon(iconHelper.getIconName(moneyType),false)
self.lianzhiCost1:setText(enoughMoney1 and moneyCount or FMT.cfmt(FONT_COLOR.eRedColor,moneyCount))
end
if isShowCost2 then
local moneyType=cost2.moneyType
self.refreshMoneyTypeList_lookup[moneyType]=true
local moneyCount=cost2.count
local enoughMoney2=moneyModel.checkEnoughMoney(moneyType,moneyCount)
self.lianzhiCostIcon2:setImageIcon(iconHelper.getIconName(moneyType),false)
self.lianzhiCost2:setText(enoughMoney2 and moneyCount or FMT.cfmt(FONT_COLOR.eRedColor,moneyCount))
end
end


function UIFabaoBatchCreateWin:hasPutMainItem()
return self:getMainGUID()~=nil
end

function UIFabaoBatchCreateWin:getMainGUID(selectPlanIndex)
if not self.selectList then
self.selectList={}
end

if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
if not self.selectList[selectPlanIndex]then
self.selectList[selectPlanIndex]={}
end
return self.selectList[selectPlanIndex][_mainIdx]
end

function UIFabaoBatchCreateWin:getNeedNumByMainHole(guid)
return self:getNeedNumInCfg(guid)
end

function UIFabaoBatchCreateWin:getNeedNumInCfg(guid)
if not guid then return 9999999 end
local item=bagModel.getItem(guid)
local itemid=item.itemid
return self:getNeedNumInCfgItemid(itemid)
end

function UIFabaoBatchCreateWin:getHjNeedNumInCfg(mainguid,guid)
if not guid or mainguid==nil then return 9999999 end
local item=bagModel.getItem(guid)
local itemid=item.itemid
local mainitem=bagModel.getItem(mainguid)
local mainid=mainitem.itemid
return self:getJhNeedNumInCfgItemid(mainid,itemid)
end

function UIFabaoBatchCreateWin:getNeedNumInCfgItemid(itemid)
if itemsConfig.isEquip(itemid)then return 1 end
local stage=itemsConfig.getConfig(itemid).stage
local needNum=fabaoConfig.getCommonConfig().materialnum[stage]
return needNum
end

function UIFabaoBatchCreateWin:getJhNeedNumInCfgItemid(mainid,itemid)
if mainid==nil then return 0 end
local stage=itemsConfig.getConfig(mainid).stage
local cfg=fabaoConfig.getJingHuaCfg()
if cfg[itemid]then
local needlist=cfg[itemid][1]
return needlist[stage]
end
return 1
end


function UIFabaoBatchCreateWin:isPutAnyHoleByGUID(itemguid,selectPlanIndex)
local array=self:getIdxArray(selectPlanIndex)
local checkFunc=function(planIndex)
for _,i in ipairs(array)do
local guid=self.selectList[planIndex]and self.selectList[planIndex][i]or nil
if guid and tostring(guid)==tostring(itemguid)then
return true
end
end
return false
end

if selectPlanIndex then
checkFunc(selectPlanIndex)
else

for planIndex,v in pairs(self.selectList)do
local isPun=checkFunc(planIndex)
if isPun then
return true
end
end
return false
end
end

function UIFabaoBatchCreateWin:getIdxArray(selectPlanIndex)
local array
if self:isMakeByEquip(selectPlanIndex)then
array=_equipIdxArray
else
array=_materialIdxArray
end
return array
end

function UIFabaoBatchCreateWin:getOneKeyIdxArray(selectPlanIndex)
local array
if self:isMakeByEquip(selectPlanIndex)then
array=_equipIdxOneKeyArray
else
array=_materialIdxOneKeyArray
end
return array
end

function UIFabaoBatchCreateWin:isMakeByEquip(selectPlanIndex)
local itemguid=self:getMainGUID(selectPlanIndex)
if itemguid then
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
return itemsConfig.isEquip(itemid)
end
return false
end


function UIFabaoBatchCreateWin:getTotalItemguidList()
local temp={}
for planIndex,v in pairs(self.selectList)do
local numList=self.selectNumList[planIndex]or{}
for i,guid in pairs(v)do
local guidStr=tostring(guid)
local old=temp[guidStr]or 0
local add=numList[i]or 0
temp[guidStr]=old+add
end
end
return temp
end


function UIFabaoBatchCreateWin:getTotalItemidList()
local temp={}
for planIndex,v in pairs(self.selectList)do
local numList=self.selectNumList[planIndex]or{}
for i,guid in pairs(v)do
local itemid=bagModel.getItem(guid).itemid
local old=temp[itemid]or 0
local add=numList[i]or 0
temp[itemid]=old+add
end
end
return temp
end

function UIFabaoBatchCreateWin:getSelectItemNum(itemguid,selectIndex)
if not itemguid then return 0 end
if self.selectList==nil then self.selectList={}end
local getNumFunc=function(planIndex)
if self.selectList[planIndex]==nil then self.selectList[planIndex]={}end
local handle=tostring(itemguid)
local num=0
local array=self:getIdxArray(planIndex)
for _,i in ipairs(array)do
if tostring(self.selectList[planIndex][i])==handle then
num=num+self:getPutNum(i,planIndex)
end
end
return num
end

if selectIndex then
return getNumFunc(selectIndex)
else
local allNum=0

for planIndex,v in pairs(self.selectList)do
local num=getNumFunc(planIndex)
allNum=allNum+num
end
return allNum
end
end

function UIFabaoBatchCreateWin:getPutNum(idx,selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
return self.selectNumList[selectPlanIndex]and self.selectNumList[selectPlanIndex][idx]or 0
end

function UIFabaoBatchCreateWin:getSelectFillData(item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData()
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
end

return prop
end

function UIFabaoBatchCreateWin:getSelectTempFillData()
local conf={}
conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end


function UIFabaoBatchCreateWin:getLeftPutNum(itemid)
local planData=self.planList[self.selectPlanIndex]
local hasMain=self:getMainGUID()or(planData and planData.mainItem~=nil)
if not hasMain then return 1 end
if itemsConfig.isEquip(itemid)then
return 0
elseif itemsConfig.isItem(itemid)or itemsConfig.isMaterials(itemid)then
local hasNum=0
local needNum=0
local flag=false
local array=self:getIdxArray()
local mainid=planData.mainItem and planData.mainItem.itemid or nil
for _,i in ipairs(array)do
if not self:isJHIdxHole(i)then
local planItemId
if planData then
if self:isMainHole(i)then
planItemId=planData.mainItem and planData.mainItem.itemid
if itemid==planItemId and not self:isfull(i)then

return 0
end
else
planItemId=planData.costItemList and planData.costItemList[i-1]and planData.costItemList[i-1].itemid
end
end

if(not planItemId or itemid==planItemId)and flag and(self:isTempHole(i)or self:isPutHoleByItemid(itemid,i))then
needNum=needNum+self:getNeedNumByItemidAndIdx(mainid,itemid,i)
hasNum=hasNum+self:getPutNum(i)
end
flag=flag or true
end
end
return needNum-hasNum
end
return 0
end

function UIFabaoBatchCreateWin:isPutHoleByItemid(itemid,idx)
local selectIndex=self.selectPlanIndex
local guid=self.selectList[selectIndex]and self.selectList[selectIndex][idx]or nil
if guid then
local item=bagModel.getItem(guid)
return item.itemid==itemid
end
return false
end

function UIFabaoBatchCreateWin:isTempHole(idx)
local selectIndex=self.selectPlanIndex
return self.selectList[selectIndex]and self.selectList[selectIndex][idx]==nil or false
end

function UIFabaoBatchCreateWin:getNeedNumByItemidAndIdx(mainid,itemid,fillIdx)
if self:isMainHole(fillIdx)or self:isFzHole(fillIdx)then
return self:getNeedNumInCfgItemid(itemid)
elseif self:isJHIdxHole(fillIdx)then
return self:getJhNeedNumInCfgItemid(mainid,itemid)
else
return 1
end
end

function UIFabaoBatchCreateWin:isMainHole(idx)
return _mainIdx==idx
end

function UIFabaoBatchCreateWin:isFzHole(idx)
return _fzIdx==idx
end

function UIFabaoBatchCreateWin:isJHIdxHole(idx)
return _jhIdx==idx
end

function UIFabaoBatchCreateWin:freshProvideSelectSingleGird(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
end
end
end

function UIFabaoBatchCreateWin:freshProvideGridLock(itemguid,isUnlock)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,isUnlock)
end
end
end

function UIFabaoBatchCreateWin:freshProvideGridSelect(itemguid)
local idx=self:getBagItemIdx(itemguid)

if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true)
else

end
else

end
end

function UIFabaoBatchCreateWin:freshProvideSelectSingleItemNum(itemguid)
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


function UIFabaoBatchCreateWin:setFunctionBtns()
self.funcBtnIdx=1
for i,v in ipairs(self.btnFunc)do
v:setButtonClick(function()
self:onClickBtnFunc(i)
end,true)
end
local names={'全部'}
for i=1,4 do
names[#names+1]=FABAO_LIANZHI_METRAILAS_FUNC_TYPE_Name[i]
end
for i,v in ipairs(self.btnFuncTxt)do
v:setText(names[i])
self.btnSelects[i]:setActive(self.funcBtnIdx==i)
end
end

function UIFabaoBatchCreateWin:onClickBtnFunc(index)
if self.funcBtnIdx==index then return end
self.funcBtnIdx=index
self.funcFilter=index-1
self.curPageIndex=1
self.isSetZero=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
self:freshProvideSelectGrids(true)
for i,v in ipairs(self.btnFuncTxt)do
self.btnSelects[i]:setActive(self.funcBtnIdx==i)
end
tipsManager.closeTips()
end


function UIFabaoBatchCreateWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i
end
end
end


function UIFabaoBatchCreateWin:getNextFillIdx(itemid,itemguid)
local handle=tostring(itemguid)
local array=self:getIdxArray()
local selectIndex=self.selectPlanIndex
local planData=self.planList and self.planList[selectIndex]or nil
local notItemHoleIndexList={}
for _,i in ipairs(array)do
local guid=self.selectList[selectIndex]and self.selectList[selectIndex][i]or nil
local planItemId
local isJHIdxHole=self:isJHIdxHole(i)
if not isJHIdxHole then
if planData then
if self:isMainHole(i)then
planItemId=planData.mainItem and planData.mainItem.itemid
elseif self:isJHIdxHole(i)then
planItemId=planData.jyItem and planData.jyItem.itemid
else
planItemId=planData.costItemList and planData.costItemList[i-1]and planData.costItemList[i-1].itemid
end
end
local isNotFull=false
if guid==nil or(tostring(guid)==handle and not self:isfull(i))then

isNotFull=true
end
if planItemId~=nil and itemid==planItemId and isNotFull then

return i
elseif planItemId==nil then

notItemHoleIndexList[#notItemHoleIndexList+1]=i
end
end
end


if notItemHoleIndexList and next(notItemHoleIndexList)then

local idx=notItemHoleIndexList[1]
return idx
end
end

function UIFabaoBatchCreateWin:isfull(fillIdx,selectIndex)
if not selectIndex then
selectIndex=self.selectPlanIndex
end
local guid=self.selectList[selectIndex]and self.selectList[selectIndex][fillIdx]or nil
if guid==nil then return false end
local needNum=self:getNeedNumByIdx(guid,fillIdx,selectIndex)
local hasNum=self:getPutNum(fillIdx,selectIndex)
return hasNum>=needNum
end

function UIFabaoBatchCreateWin:onUnlockItem(itemguid)
self.unlockItem[tostring(itemguid)]=true
end

function UIFabaoBatchCreateWin:putItem(index,itemid,itemguid,fillnum)
if itemid==-1 then return end
local putFinish=itemid~=nil
local handle=tostring(itemguid)
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local lastHasMain=self:hasPutMainItem()
local itemcount=item.itemcount
if num>=itemcount then
UIManager.error('物品已达上限')
tipsManager.closeTips()
return
end
local fillIdx=self:getNextFillIdx(itemid,itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
tipsManager.closeTips()
return
end
local isMainHole=self:isMainHole(fillIdx)
local isJHIdxHole=self:isJHIdxHole(fillIdx)
local fillBagType=self:getBagType(fillIdx)
local isFzHole=self:isFzHole(fillIdx)
local changeBagType=fillBagType~=self.selectBagType
if itemsConfig.isEquip(item.itemid)and not isMainHole then
UIManager.error('装备只能作为主材料')
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
local lastNum=num
local addNum=1
local curNum=num+addNum
if isMainHole or isFzHole or isFzHole then
local needNum=self:getNeedNumByIdx(itemguid,fillIdx)
local leibie=isMainHole and'主材料'or
isFzHole or'副材料'or
'精华材料'
if needNum and itemcount<num+needNum then
local itemName=itemsConfig.getConfig(itemid).name
local leftNum=itemcount-num
if leftNum<0 then
leftNum=0
end
UIManager.error(FMT.fmt('{0}数量不足以作为{3}({1}/{2})',itemName,leftNum,needNum,leibie))
gainControl:showGainWin(itemid)
return
end
addNum=needNum
curNum=addNum
else
addNum=fillnum
end
if lastNum==0 then
self:freshProvideSelectSingleGird(itemguid,true)
end
self:addSelectHole(itemid,itemguid,fillIdx,addNum)
self:freshLianZhiRoot()
self:freshProvideSelectSingleItemNum(itemguid)
self:refreshPlanListItem(nil,self.selectPlanIndex)
self:freshBagBtns()

self:onCloseTipsMask()

local flag,nextHole=self:isFullHoles(self.selectPlanIndex)




if changeBagType then
self:freshProvideGrids(fillBagType)
elseif not lastHasMain then
self:freshBagList()
self.ScrollView:freshAllItems()
end
end

function UIFabaoBatchCreateWin:isFullHoles(selectPlanIndex)
local array=self:getIdxArray(selectPlanIndex)
for _,i in ipairs(array)do
local isJHIdxHole=self:isJHIdxHole(i)
if not isJHIdxHole then
if not self:isfull(i,selectPlanIndex)then
return false,i
end
end
end
return true
end


function UIFabaoBatchCreateWin:getSelectMaterials(selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
local temp={}
local selectList=self.selectList and self.selectList[selectPlanIndex]or{}
local mainid
local array=self:getIdxArray(selectPlanIndex)
for _,i in ipairs(array)do
if not self:isJHIdxHole(i)then
local itemguid=selectList[i]
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
if self:isMainHole(i)then
mainid=itemid
if not itemsConfig.isEquip(itemid)then
temp[#temp+1]=itemid
end
else
temp[#temp+1]=itemid
end
end
end
end

return mainid,temp
end


function UIFabaoBatchCreateWin:getPlanMaterials(selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
local temp={}
local planData=self.planList[selectPlanIndex]
local mainid
if planData then
mainid=planData.mainItem and planData.mainItem.itemid or nil
if mainid and not itemsConfig.isEquip(mainid)then
temp[#temp+1]=mainid
end
local costItemList=planData.costItemList or{}
for i,v in pairs(costItemList)do
local itemid=v.itemid
temp[#temp+1]=itemid
end
return mainid,temp
end
return nil,nil
end

function UIFabaoBatchCreateWin:getBagType(index)
local isMainHole=self:isMainHole(index)
local isMakeByEquip=self:isMakeByEquip()
if isMakeByEquip and isMainHole then return BAG_TYPE.eEquipBag end
return BAG_TYPE.eMaterialsBag
end

function UIFabaoBatchCreateWin:getNeedNumByIdx(guid,fillIdx,selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
local mainguid=self.selectList[selectPlanIndex]and self.selectList[selectPlanIndex][_mainIdx]or nil
local _guid=self.selectList[selectPlanIndex]and self.selectList[selectPlanIndex][fillIdx]or nil
if _guid and tostring(guid)~=tostring(_guid)then return end
if self:isMainHole(fillIdx)or self:isFzHole(fillIdx)then
return self:getNeedNumInCfg(guid)
elseif self:isJHIdxHole(fillIdx)then
return self:getHjNeedNumInCfg(mainguid,guid)
else
return 1
end
end

function UIFabaoBatchCreateWin:addSelectHole(itemid,itemguid,index,num,selectPlanIndex,fixIndex,onekey)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
if num<=0 then return end
local array=not onekey and self:getIdxArray(selectPlanIndex)or self:getOneKeyIdxArray(selectPlanIndex)
local handle=tostring(itemguid)
if not self.planList[selectPlanIndex]then
self.planList[selectPlanIndex]={}
end
local planData=self.planList[selectPlanIndex]
local sameItemHoleIndexList={}
local notItemHoleIndexList={}

local putHole=function(i)
local needNum=self:getNeedNumByIdx(itemguid,i,selectPlanIndex)
local hasNum=self:getPutNum(i,selectPlanIndex)
local isMainHole=self:isMainHole(i)
local planItemId
if planData then
if isMainHole then
planItemId=planData.mainItem and planData.mainItem.itemid
elseif self:isJHIdxHole(i)then
planItemId=planData.jyItem and planData.jyItem.itemid
else
planItemId=planData.costItemList and planData.costItemList[i-1]and planData.costItemList[i-1].itemid
end
end

local guid=self.selectList[selectPlanIndex]and self.selectList[selectPlanIndex][i]or nil
local guidStr=tostring(guid)
local isNotFull=false
if guid==nil or guidStr==handle and hasNum<needNum then
isNotFull=true
end

if planItemId~=nil and itemid==planItemId and isNotFull then

sameItemHoleIndexList[#sameItemHoleIndexList+1]={idx=i,needNum=needNum,hasNum=hasNum}
elseif planItemId==nil then

notItemHoleIndexList[#notItemHoleIndexList+1]={idx=i,needNum=needNum,hasNum=hasNum}
end
end

if fixIndex then
putHole(index)
else
for _,i in ipairs(array)do
putHole(i)
end
end

local canAddHoleIndexList=table.concatTable(sameItemHoleIndexList,notItemHoleIndexList)
if canAddHoleIndexList then
for _,v in ipairs(canAddHoleIndexList)do
local idx=v.idx
local needNum=v.needNum
local hasNum=v.hasNum

local isMainHole=self:isMainHole(idx)
local itemData={
itemid=itemid,

}
if isMainHole then
planData.mainItem=itemData
elseif self:isJHIdxHole(idx)then
planData.jyItem=itemData
else
if not planData.costItemList then
planData.costItemList={}
end
planData.costItemList[idx-1]=itemData
end

local maxNum=needNum-hasNum
local add=math.min(num,maxNum)
self:addSelectNum(itemguid,idx,add,selectPlanIndex)
num=num-add
if num<=0 then
break
end
end
end
end

function UIFabaoBatchCreateWin:addSelectNum(itemguid,index,num,selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
if not self.selectList[selectPlanIndex]then
self.selectList[selectPlanIndex]={}
end
self.selectList[selectPlanIndex][index]=itemguid
self:addPutNum(index,num,selectPlanIndex)
end

function UIFabaoBatchCreateWin:deleteSelectNum(index,num,selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
self:deletePutNum(index,num,selectPlanIndex)
if self:getPutNum(index,selectPlanIndex)<=0 then
self.selectList[selectPlanIndex][index]=nil
end
end

function UIFabaoBatchCreateWin:addPutNum(idx,num,selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
if not self.selectNumList[selectPlanIndex]then
self.selectNumList[selectPlanIndex]={}
end
self.selectNumList[selectPlanIndex][idx]=self:getPutNum(idx,selectPlanIndex)+num
end

function UIFabaoBatchCreateWin:deletePutNum(idx,num,selectPlanIndex)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
local num1=self:getPutNum(idx,selectPlanIndex)-num
if num1<=0 then num1=0 end

self.selectNumList[selectPlanIndex][idx]=num1
end

function UIFabaoBatchCreateWin:getSelectIndex(itemguid,selectPlanIndex,isFirstMain)
if not selectPlanIndex then
selectPlanIndex=self.selectPlanIndex
end
if self.selectList==nil then self.selectList={}end
if not self.selectNumList[selectPlanIndex]then
self.selectNumList[selectPlanIndex]={}
end
local array=self:getIdxArray(selectPlanIndex)
if isFirstMain then

local mainGuid=self:getMainGUID(selectPlanIndex)
if mainGuid and tostring(mainGuid)==tostring(itemguid)then
return _mainIdx
end
end

local len=#array
for i=len,1,-1 do
local index=array[i]
if tostring(self.selectList[selectPlanIndex][index])==tostring(itemguid)then
return index
end
end
end

function UIFabaoBatchCreateWin:deleteSelectMaterial(itemguid,selectPlanIndex,selectIdx,warn)
local selectNum=self:getSelectItemNum(itemguid,selectPlanIndex)
if selectNum<=0 then
if warn then
UIManager.error('选中方案没使用该材料')
end
return
end
local isMainItem=self:isMainHole(selectIdx)
local deleteNum=1
local isFzHole=self:isFzHole(selectIdx)
local isJhHole=self:isJHIdxHole(selectIdx)
if isMainItem or isJhHole then
deleteNum=selectNum
elseif isFzHole then
deleteNum=self:getPutNum(selectIdx,selectPlanIndex)
end
self:deleteSelectNum(selectIdx,deleteNum,selectPlanIndex)
selectNum=selectNum-deleteNum
if self:isMainHole(selectIdx)then
if selectNum<=0 or self:getPutNum(selectIdx,selectPlanIndex)<=0 then
self.selectList[selectPlanIndex]={}
self.selectNumList[selectPlanIndex]={}


self.ScrollView:clearSlowItems()
self:freshProvideSelectGrids()
else
self:freshProvideSelectSingleItemNum(itemguid)
end
else
if selectNum<=0 then
self:freshProvideSelectSingleGird(itemguid,false)
end
self:freshProvideSelectSingleItemNum(itemguid)
end
self:freshLianZhiRoot(selectPlanIndex)
self:refreshPlanListItem(nil,selectPlanIndex)
self:freshBagBtns()
end

function UIFabaoBatchCreateWin:deletePlanMaterial(selectPlanIndex,selectIdx)
local isMainItem=self:isMainHole(selectIdx)
local planData=self.planList[selectPlanIndex]
if isMainItem then
planData.mainItem=nil
planData.costItemList=nil
planData.jyItem=nil
elseif self:isJHIdxHole(selectIdx)then
planData.jyItem=nil
else
if planData.costItemList then
planData.costItemList[selectIdx-1]=nil
end
end
self:freshLianZhiRoot(selectPlanIndex)
self:refreshPlanListItem(nil,selectPlanIndex)
end

function UIFabaoBatchCreateWin:getSelectPlanNeedItemList()
if not self.planList or not self.selectPlanIndex then return end
local planIndex=self.selectPlanIndex
local planData=self.planList[planIndex]
if not planData or not planData.mainItem then
return
end

local needItemList={}
local needItemList_lookup={}
local array=self:getIdxArray(planIndex)
local mainid=planData.mainItem and planData.mainItem.itemid or nil
for _,i in ipairs(array)do
local planItemId
if planData then
if self:isMainHole(i)then
planItemId=planData.mainItem and planData.mainItem.itemid
elseif self:isJHIdxHole(i)then
planItemId=planData.jyItem and planData.jyItem.itemid
else
planItemId=planData.costItemList and planData.costItemList[i-1]and planData.costItemList[i-1].itemid
end
if planItemId then
local needNum
if self:isMainHole(i)or self:isFzHole(i)then
needNum=self:getNeedNumInCfgItemid(planItemId)
elseif self:isJHIdxHole(i)then
needNum=self:getJhNeedNumInCfgItemid(mainid,planItemId)
else
needNum=1
end
local hasNum=self:getPutNum(i,planIndex)
if hasNum<needNum then
local deltaNum=needNum-hasNum

if not needItemList_lookup[planItemId]then
needItemList[#needItemList+1]={itemid=planItemId,deltaNum=deltaNum}
needItemList_lookup[planItemId]=#needItemList
else
local index=needItemList_lookup[planItemId]
local num=needItemList[index].deltaNum
needItemList[index].deltaNum=num+deltaNum
end
end
end
end
end

if next(needItemList)then
return needItemList
end
return nil
end

function UIFabaoBatchCreateWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshProvideSelectGrids()
end

function UIFabaoBatchCreateWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
local comCfg=fabaoConfig.getCommonConfig()
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local isEquip=itemsConfig.isEquip(itemid)
local refstage=stage
if isEquip then
refstage=comCfg.stage[stage]or nil
end

local hasMain=self:hasPutMainItem()

if refstage and not hasMain then
local systemLimit=comCfg.system
local sysid=systemLimit[refstage]
if sysid then
local isOpen=systemModel.isOpen(sysid)
if not isOpen then
local tips=systemModel.getOpenTips(sysid)
UIManager.info(tips)
return
end
end
end

local item=bagModel.getItem(itemguid)
local num=item.itemcount
local hasPut=self:getSelectItemNum(itemguid)
num=num-hasPut
local leftNum=self:getLeftPutNum(itemid)
local maxNum=math.min(num,leftNum)
maxNum=math.max(maxNum,1)
local isMakeByEquip=self:isMakeByEquip()
if isMakeByEquip and self:isTempHole(_fzIdx)then
maxNum=1
end

local selectNumCmpArgs={numFormat='放入：<color=#f1ce78>{0}/{1}</color>',
min=1,max=maxNum,val=maxNum}
local isMain
local fillidx=self:getNextFillIdx(itemid,itemguid)
if fillidx then
isMain=self:isMainHole(fillidx)
else
isMain=not hasMain or(hasMain and isMakeByEquip)
end

tipsManager.showTips({formType=TIPS_FORM_TYPE.eLianqiGeBagItem,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,
selectNumCmpArgs=selectNumCmpArgs,
isMain=isMain,
isMakeByEquip=isMakeByEquip},
move=TIPS_MOVE_POS.eCenter})


self.closeTipsMask:setActive(true)
self:onSelectOneGrid(itemguid,true,index)
end

function UIFabaoBatchCreateWin:onClickPlanListRemoveBtn(index)
local removeFunc=function(...)
if _this==nil then return end

_this:removePlanItemByIndex(index)


_this:refreshRightPanel(true)


_this.ScrollView:clearSlowItems()
_this:freshProvideSelectGrids(true)
end


local isHideFullSpecialityTipsDialog=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHideRemoveFabaoCreatePlanDialog)
if isHideFullSpecialityTipsDialog then
removeFunc()
else



















local content='是否删除该法宝炼制方案？'
UIDialogManager.getConfirmDialog3(nil,content,removeFunc,REPEAT_TYPE.eHideRemoveFabaoCreatePlanDialog,nil,nil)
end

end

function UIFabaoBatchCreateWin:onClickPlanListAddBtn()

local newPlanIndex=self:addEmptyPlanItem()

self:refreshRightPanel(true)


self:onSelectPlan(newPlanIndex)
self.listScroller:setChildScrollViewSelectItem(newPlanIndex-1,true,false,false)
end

function UIFabaoBatchCreateWin:onSelectPlan(index)
if self.selectPlanIndex==index then
return
end

local oldSelectIndex=self.selectPlanIndex
self.selectPlanIndex=index
self.selectPlanItemIndex=nil

self:refreshPlanListItem(nil,oldSelectIndex)


self:refreshPlanListItem(nil,index)


self.ScrollView:clearSlowItems()
self:freshProvideSelectGrids(true)
end


function UIFabaoBatchCreateWin:onSelectOneGrid(itemguid,isBagGrid,index)
local lastSelectGrid=self.isSelectGrid
self.isSelectGrid=isBagGrid

local lastItemguid=self.selectItemguid
self.selectItemguid=itemguid

local lastSelectIndex=self.selectItemguidIdx
self.selectItemguidIdx=index

if itemguid==nil or isBagGrid==nil or index==nil then
loggerUtil.logErrFMT('传入参数有问题：itemguid：{0} isBagGrid：{1} index：{2}',itemguid,isBagGrid,index)
return
end
if lastSelectGrid==isBagGrid and tostring(lastItemguid)==tostring(itemguid)and lastSelectIndex==index then
return
end

if lastItemguid then
if lastSelectGrid then
self:freshProvideGridSelect(lastItemguid)
end
end
if isBagGrid then
self:freshProvideGridSelect(itemguid)
end
end


function UIFabaoBatchCreateWin:onSelectPlanItemGrid(planIndex,itemIndex)
self.selectPlanItemIndex=itemIndex
if planIndex==nil or itemIndex==nil then
loggerUtil.logErrFMT('传入参数有问题：planIndex：{0} itemIndex：{1}',planIndex,itemIndex)
return
end


self:refreshPlanListItem(nil,planIndex)
end


function UIFabaoBatchCreateWin:onClickGridButton(index,itemid,itemguid)
if itemid==-1 then return end







local selectPlanIndex=self.selectPlanIndex
local selectIdx=self:getSelectIndex(itemguid,selectPlanIndex)
if not selectIdx then
UIManager.error('选中方案没使用该材料')
return
end
self:deletePlanMaterial(selectPlanIndex,selectIdx)
self:deleteSelectMaterial(itemguid,selectPlanIndex,selectIdx,true)


self:onCloseTipsMask()
end


function UIFabaoBatchCreateWin:onClickPlanItemDeleteButton(selectPlanIndex,selectIdx,itemid)
if itemid==-1 then return end
self:deletePlanMaterial(selectPlanIndex,selectIdx)

local itemguid=self.selectList[selectPlanIndex]and self.selectList[selectPlanIndex][selectIdx]or nil
if itemguid then
self:deleteSelectMaterial(itemguid,selectPlanIndex,selectIdx,true)
end


self:onCloseTipsMask()
end


function UIFabaoBatchCreateWin:onSelectItemClick(itemid,planIndex,itemIndex,attach)
local isNomal=self.lianzhiType==FABAO_LIANZHI_TYPE.eNomal
local lastIndex=self.selectPlanItemIndex
if not isNomal then
return
end

if lastIndex==itemIndex and UIManager:isActive('UITipsWin',true)then
return
end




local hasItem=itemid~=nil and itemid>0
self:onSelectPlan(planIndex)
if self:isJHIdxHole(itemIndex)then
self:onSelectPlanItemGrid(planIndex,itemIndex)
self:showJingHuaSelectWin()

elseif hasItem then
local isMakeByEquip=self:isMakeByEquip(planIndex)
local isMain=itemIndex==_fzIdx or itemIndex==_mainIdx
tipsManager.showTips({formType=TIPS_FORM_TYPE.eLianqiGeItem,
itemid=itemid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=itemIndex,planIndex=planIndex,isMain=isMain,isMakeByEquip=isMakeByEquip},
move=TIPS_MOVE_POS.eCenter})

self.closeTipsMask:setActive(true)
self.selectPlanItemIndex=itemIndex
self:onSelectPlanItemGrid(planIndex,itemIndex)
else
UIManager.error("点击左侧材料放入其中")
end
end

function UIFabaoBatchCreateWin:showJingHuaSelectWin()
local dzguid=self.diziguid
if dzguid==nil then
UIManager.error('请先选择主人')
return
end
local putlist=self:getTotalItemidList()
local planIndex=self.selectPlanIndex
self.selectList[planIndex]=self.selectList[planIndex]or{}
local planData=self.selectList[planIndex]
local itemguid=planData[_jhIdx]
local mainguid=planData[_mainIdx]
local mainitemid=bagModel.getItem(mainguid).itemid
local args={}
args.titleName="升品材料"
args.pos=1
args.extraWin='UIFabaoJingHuaSelectWin'
local extraParams={}
extraParams.itemguid=itemguid
extraParams.mainitemid=mainitemid
extraParams.putlist=putlist
extraParams.selectCB=function(guid,itemid,num)
self.selectList[planIndex]=self.selectList[planIndex]or{}
local old=self.selectList[planIndex][_jhIdx]
if tostring(old)==tostring(guid)then return end
self.selectList[planIndex][_jhIdx]=guid
if old then
self:deletePlanMaterial(planIndex,_jhIdx)
self:deleteSelectMaterial(old,planIndex,_jhIdx)
end
if guid then
self:addSelectHole(itemid,guid,_jhIdx,num,planIndex,true)
end
self:freshLianZhiRoot()
self:refreshPlanListItem(nil,self.selectPlanIndex)
end
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIFabaoBatchCreateWin:takeOffByTips(planIndex,index,itemid)
if itemid==-1 then return end

local itemguid=self.selectList[planIndex]and self.selectList[planIndex][index]or nil







self:deletePlanMaterial(planIndex,index)
self:deleteSelectMaterial(itemguid,planIndex,index)


self:onCloseTipsMask()
end

function UIFabaoBatchCreateWin:onFabaoItemClick(planIndex)
self:onSelectPlan(planIndex)

local planData=self.planList[planIndex]
local fabaoData=planData and planData.fabaoItem or nil
if fabaoData then
local itemid=fabaoData.itemid
local itemguid=fabaoData.itemguid
local isMakeByEquip=self:isMakeByEquip(planIndex)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eLianqiGeFabaoPreview,
itemid=itemid,
itemguid=itemguid,
attach={isMain=true,isMakeByEquip=isMakeByEquip,isShowShentongInfo=true,
elementTextColor='#efb150',lianhuaTextColor='#efb150'},
move=TIPS_MOVE_POS.eCenter})
end
end

function UIFabaoBatchCreateWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:freshProvideGridLock(itemguid,isUnlock)
if self.unlockItem[tostring(itemguid)]then
self.unlockItem[tostring(itemguid)]=nil
self:putItem(nil,nil,itemguid)
end
end

function UIFabaoBatchCreateWin:onMoneyChanged(moneytype,oldvalue,newvalue)
if self.refreshMoneyTypeList_lookup and self.refreshMoneyTypeList_lookup[moneytype]then
self:refreshCostMoneyRoot()
end
end




function UIFabaoBatchCreateWin:onMask()
self:closeSelf()
end



function UIFabaoBatchCreateWin:onCloseBtn()
self:closeSelf()
end



function UIFabaoBatchCreateWin:onBtnMaterials()
if self.selectBagType==BAG_TYPE.eMaterialsBag then return end
self:freshProvideGrids(BAG_TYPE.eMaterialsBag)

self:onCloseTipsMask()
end



function UIFabaoBatchCreateWin:onBtnEquips()
if not fullScreenModel.isTabOpen(FULL_TAB_TYPE.eFabao_zhuangbei,true)then return end
if self.selectBagType==BAG_TYPE.eEquipBag then return end
self:freshProvideGrids(BAG_TYPE.eEquipBag)

self:onCloseTipsMask()
end



function UIFabaoBatchCreateWin:onBtnOnekey()

local needItemList=self:getSelectPlanNeedItemList()
if needItemList then

local isEnough=true
for _,v in ipairs(needItemList)do
local itemid=v.itemid
local deltaNum=v.deltaNum
local hasItemCount=itemsModel.getCount(itemid)
if hasItemCount<deltaNum then
isEnough=false
break
end
end
if not isEnough then
UIManager.error("暂无一键放入的合适材料")
return
end

for _,v in ipairs(needItemList)do
local itemid=v.itemid
local deltaNum=v.deltaNum
local maxItemguid
local maxItemCount
local all=bagControl.invokeFuncByItemId(itemid,'getAllItemByItemID',itemid)
for _,item in ipairs(all)do
if not maxItemCount or maxItemCount<item.itemcount then
maxItemCount=item.itemcount
maxItemguid=item.itemguid
end
end

self:addSelectHole(itemid,maxItemguid,nil,deltaNum,true,nil,true)
end
end

local isChange=false
local mainguid=self:getMainGUID()
local moniSelectList={}
local moniSelectNumList={}
local selectPlanIndex=self.selectPlanIndex
local array=self:getOneKeyIdxArray()
for _,i in ipairs(array)do
moniSelectList[i]=self.selectList[selectPlanIndex]and self.selectList[selectPlanIndex][i]or nil
moniSelectNumList[i]=self:getPutNum(i)
end


local _getSelectItemNum=function(itemguid)
local handle=tostring(itemguid)
local allNum=self:getSelectItemNum(itemguid)
local ignoreNum=self:getSelectItemNum(itemguid,selectPlanIndex)
local addNum=0
for _,i in ipairs(array)do
if tostring(moniSelectList[i])==handle then
addNum=addNum+(moniSelectNumList[i]or 0)
end
end
local num=allNum-ignoreNum+addNum
return num
end


local _getLeftNum=function(itemguid)
local num=_getSelectItemNum(itemguid)or 0
local item=bagModel.getItem(itemguid)
local itemcount=item.itemcount
return itemcount-num
end


local _getNextFillItemGuid=function(holeIdx)
local bagList=self.bagList or{}
local nowMainGuid=self:getMainGUID()

if nowMainGuid then
local left=_getLeftNum(nowMainGuid)
local needNum=self:getNeedNumByIdx(nowMainGuid,holeIdx)
if left>=needNum then
return nowMainGuid,left
end
end

for i,v in ipairs(bagList)do
local left=_getLeftNum(v.itemguid)
local needNum=self:getNeedNumByIdx(v.itemguid,holeIdx)
if left>=needNum then
return v.itemguid,left
end
end
end


local _getMainFillGuid=function()
local bagList=self.bagList or{}
local idx=_mainIdx
for i,v in ipairs(bagList)do
if not self:isLock(v.itemid)then
local itemguid=v.itemguid
local left=_getLeftNum(itemguid)
local needNum=self:getNeedNumByIdx(itemguid,idx)
if left>=needNum then
return itemguid
end
end
end
end

local _addItem=function(index,itemguid,num)
moniSelectList[index]=itemguid
moniSelectNumList[index]=moniSelectNumList[index]+num
end

if mainguid==nil then
local itemguid=_getMainFillGuid()
if itemguid==nil then
UIManager.error('暂无一键放入的合适材料')
return
end
mainguid=itemguid
end
if mainguid==nil then
UIManager.error('暂无一键放入的合适材料')
return
end
local array=self:getOneKeyIdxArray()
for _,i in ipairs(array)do
local hasNum=moniSelectNumList[i]or 0
if self:isMainHole(i)then
local needNum=self:getNeedNumByIdx(mainguid,i)
local canAddNum=needNum-hasNum
local leftNum=_getLeftNum(mainguid)
local fillNum=math.min(leftNum,canAddNum)
if fillNum>0 then
_addItem(i,mainguid,fillNum)
isChange=true
self:freshProvideSelectSingleItemNum(mainguid)
self:freshProvideSelectSingleGird(mainguid,true)
end
else
local itemguid=moniSelectList[i]
if itemguid==nil then
local guid=_getNextFillItemGuid(i)
itemguid=guid
end
if itemguid then
local leftNum=_getLeftNum(itemguid)
local needNum=self:getNeedNumByIdx(itemguid,i)
needNum=needNum-hasNum
local addNum=needNum
if needNum>leftNum then
addNum=leftNum
end
local fillNum=math.min(leftNum,addNum)
_addItem(i,itemguid,fillNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:freshProvideSelectSingleGird(itemguid,true)
isChange=true
end
end
end

if isChange then
self.lastSelectIndex=nil
for _,i in ipairs(array)do
local itemguid=moniSelectList[i]
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local itemNum=moniSelectNumList[i]
local originalNum=self:getPutNum(i)
local deltaNum=itemNum-originalNum
self:addSelectHole(itemid,itemguid,nil,deltaNum,nil,nil,true)
end
end
end


self:freshProvideSelectGrids()


self:freshLianZhiRoot()
self:refreshPlanListItem(nil,self.selectPlanIndex)
end



function UIFabaoBatchCreateWin:onBtnReset()
local selectPlanIndex=self.selectPlanIndex




















local selectIdx=_mainIdx
self:deletePlanMaterial(selectPlanIndex,selectIdx)

local itemguid=self.selectList[selectPlanIndex]and self.selectList[selectPlanIndex][selectIdx]or nil
if itemguid then
self:deleteSelectMaterial(itemguid,selectPlanIndex,selectIdx)
end


self:onCloseTipsMask()
end



function UIFabaoBatchCreateWin:onBtnLianzhi()

if self.diziguid==0 then
UIManager.error('没有进驻弟子')
return
end

if not UIDiscipleModel:checkDZStateToDoSomething(self.diziguid,eCheckDiscipleStateOpType.eLianQi,true)then
return
end


for _,v in ipairs(self.costMoneyList)do
local moneyType=v.moneyType
local moneyCount=v.count

if not moneySystem:useMoney(moneyType,moneyCount,function()return end,WARNING_TYPE.eWarning)then
return
end
end


local lianzhiList={}
for planIndex,planData in ipairs(self.planList)do
local materialGuidList={}
local fzGuid=int64.new(0)
local jyguid=int64.new(0)
local isFull=self:isFullHoles(planIndex)
if not isFull then
UIManager.error("上方炼制方案没设置完成，请检查")
return
end
local array=self:getIdxArray(planIndex)
for _,i in ipairs(array)do
local guid=self.selectList[planIndex]and self.selectList[planIndex][i]or int64.new(0)
if self:isFzHole(i)then
fzGuid=guid
elseif self:isJHIdxHole(i)then
jyguid=guid
else
materialGuidList[i]=guid
end
end
lianzhiList[#lianzhiList+1]={
materialGuidList,
fzGuid,
jyguid
}
end


if self.isClickLianZhiBtn then
return
end



fabaoProtocolControl.reqBatchCreateFabao(lianzhiList,self.ubdId)


self.isClickLianZhiBtn=true
self:delayDo(_clickCd,function()
if not _this then return end
_this.isClickLianZhiBtn=nil
end)
end

function UIFabaoBatchCreateWin:onCloseTipsMask()

tipsManager.closeTips()

self.closeTipsMask:setActive(false)


if self.selectItemguid then
local selectBagItemguid=self.selectItemguid
self.selectItemguid=nil
self.selectItemguidIdx=nil
self:freshProvideGridSelect(selectBagItemguid)
end


if self.selectPlanItemIndex then
self.selectPlanItemIndex=nil
self:refreshPlanListItem(nil,self.selectPlanIndex)
end
end

function UIFabaoBatchCreateWin:fillWidgetWeight(widget,num)
local numStr1=string.format('%.1f',num)
local num2=math.floor(num)
local num1=tonumber(numStr1)
local isIntValue=num1==num2
local numStr=isIntValue and num2 or numStr1
widget:SetChildText(0,numStr)
end

function UIFabaoBatchCreateWin:hideWeightPanel()
if not self.isShowWeightPanel then return end
self.isShowWeightPanel=nil
self.weightPanel:setActive(false)
end

function UIFabaoBatchCreateWin:showWeightPanel(mainid)
if self.isShowWeightPanel then return end
self.isShowWeightPanel=true
self.weightPanel:setActive(true)
local widget=self.weightPanel:getWidgetBase()
local mainname=itemsConfig.getTipsColorName(mainid)
local dzguid=self.diziguid
local bd_tybe_cfg=cfg_monijybuildconfig_get(self.config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzguid,skill_id)
local nextlv=fabaoHelper.getNextLianzhiWeightlv(mainid,level)
local weightList=fabaoHelper.lianzhiBaseWeight(mainid,level)
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local isMax=nextlv==nil or explist[nextlv]==nil
local colorlv=FMT.cfmt3("fd8950",level)
local str1=FMT.fmt('当前炼制法宝主材料：{0}\n当前弟子的炼制等级：{1}\n对应的基础炼制概率：',mainname,colorlv)
widget:SetChildText(0,str1)

local widget1=widget:GetChildWidgetBase(1)
for i=1,5 do
local widget2=widget1:GetChildWidgetBase(i-1)
self:fillWidgetWeight(widget2,weightList[i])
end

widget:SetChildActive(4,not isMax)
widget:SetChildActive(5,isMax)
if not isMax then
local colorlv=FMT.cfmt3("fd8950",nextlv)
local weightList2=fabaoHelper.lianzhiBaseWeight(mainid,nextlv)
local str2=FMT.fmt('将弟子炼器等级提升至：{0}\n基础炼制概率可提升至：',colorlv)
widget:SetChildText(2,str2)
local widget3=widget:GetChildWidgetBase(3)
for i=1,5 do
local widget4=widget3:GetChildWidgetBase(i-1)
self:fillWidgetWeight(widget4,weightList2[i])
end
else
widget:SetChildText(7,'弟子炼器造诣已登峰造极，成败只能看天意了')
end
local ratiodesc=fabaoConfig.getCommonConfig().ratiodesc
widget:SetChildText(6,ratiodesc[1])
widget:SetChildText(8,ratiodesc[2])
end


function UIFabaoBatchCreateWin.test_refreshBag()
if not _this then return end
_this.ScrollView:clearSlowItems()
_this:freshProvideSelectGrids()
end

function UIFabaoBatchCreateWin.test_refreshPlan()
if not _this then return end
_this:refreshRightPanel()
end



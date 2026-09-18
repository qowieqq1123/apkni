







def_class("UIHeChengLianHuaPeiFang_TwoWin",UIWindowBase)









function UIHeChengLianHuaPeiFang_TwoWin:bindComponents()

self.costIcon=UIImage.get(self,0)
self.materialsItem_4=UIObject.get(self,1)
self.materialsItem_1=UIObject.get(self,2)
self.materialsItem_2=UIObject.get(self,3)
self.materialsItem_3=UIObject.get(self,4)
self.addBtn=UIButton.get(self,5)
self.subBtn=UIButton.get(self,6)
self.selectBtn=UIButton.get(self,7)
self.costCntText=UIText.get(self,8)
self.handleImg=UIObject.get(self,9)
self.maxCnt=UIButton.get(self,10)
self.selectCntText=UIText.get(self,11)
self.peiFangList=UIScrollView.get(self,12)
self.selectDropdown=UIDropdown.get(self,13)
self.sortBtn=UIButton.get(self,14)
self.unLockBtn=UIButton.get(self,15)
self.unLockText=UIText.get(self,16)
self.materials=UIObject.get(self,17)
self.matTypeText=UIText.get(self,18)
self.lianHuaItem=UIBaseItem.get(self,19)
self.selectCntSlider=UIObject.get(self,20)
self.selectBtnText=UIText.get(self,21)
self.typeScrollView=UIObject.get(self,22)
self.root=UIObject.get(self,23)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.sortBtn:setButtonClick(function()self:onSortBtn()end)

self.unLockBtn:setButtonClick(function()self:onUnLockBtn()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
}



end


function UIHeChengLianHuaPeiFang_TwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.costCntText);self.costCntText=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.peiFangList);self.peiFangList=nil;
_UIObject_release(self.selectDropdown);self.selectDropdown=nil;
_UIObject_release(self.sortBtn);self.sortBtn=nil;
_UIObject_release(self.unLockBtn);self.unLockBtn=nil;
_UIObject_release(self.unLockText);self.unLockText=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.matTypeText);self.matTypeText=nil;
_UIObject_release(self.lianHuaItem);self.lianHuaItem=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectBtnText);self.selectBtnText=nil;
_UIObject_release(self.typeScrollView);self.typeScrollView=nil;
_UIObject_release(self.root);self.root=nil;
self.materialsItem=nil;
end
















local menuItemInex=
{
select=0,
showItem=1,
require=2,
lock=3,
reddot=4,
name=5,
}

local _this=nil
local menu_slot_name='button_dytab'
local proskillId=DISCIPLE_PROSKILL_TYPE.eLianQi
local tempList={}




function UIHeChengLianHuaPeiFang_TwoWin:onLoaded(...)
self:bindComponents()
_this=self
local _onClickMenuCallBack=function(...)
self:onClickMenuCallBack(...)
end
self.peiFangList:setClickAction(_onClickMenuCallBack)
self.selectDropdown:setChangeAction(function(...)self:onClickSXTypeDropdown(...)end)

local _onTypeScrollItemClick=function(...)
self:onTypeScrollItemClick(...)
end
self.typeScrollView:setChildScrollViewInit(0.5,true,_onTypeScrollItemClick,nil)
self.selectPage=1
self.dropDownIdx=0
self.sortOrder=eSortOrder.eUp

local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)
self.gainTable={}

end


function UIHeChengLianHuaPeiFang_TwoWin:__delete()
self:unbindComponents()
_this=nil
end




function UIHeChengLianHuaPeiFang_TwoWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.sfId=argtable.sfId
self.bdData=argtable.bdData
if self.bdData then
self.ubdId=self.bdData.un_build_id
end
self.parent=argtable.parent

self.curPFConfig=argtable.curPFConfig
self.selectPage=argtable.selectPage or 1
self.selectType=argtable.selectType or 1
self.menuCurIndex=argtable.menuCurIndex or 1
self.selectCnt=1
self.checkRefreshItemLookup={}


self.option={}
local config=cfg_lianqigeconfig()
self.pageList=config.const_def.pageList
for i,v in ipairs(self.pageList)do
if self.option[i]==nil then
self.option[i]={}
self.option[i][#self.option[i]+1]="全部"
end
for ii,vv in ipairs(v.list)do
self.option[i][#self.option[i]+1]=vv.name
end
end

self.selectDropdown:setOption(self.option[self.selectPage])
self.selectDropdown:setValue(self.dropDownIdx)

self:resetPeiFangList()
self:resetTypeScrollView()
self:initPeiFangList()
self:refreshRightPanel()
end


function UIHeChengLianHuaPeiFang_TwoWin:onHide()

end

function UIHeChengLianHuaPeiFang_TwoWin:resetPeiFangList()
local isIgnoreReddotSort=self.selectPage==2
self.peiFangCfg=heChengLianHuaModel:getPeiFangListByType(self.selectPage,self.dropDownIdx,self.selectType,self.sortOrder,isIgnoreReddotSort)
if self.curPFConfig then
local pfId=self.curPFConfig.id
self.menuCurIndex=1
for i,v in ipairs(self.peiFangCfg)do
if v.id==pfId then
self.menuCurIndex=i
end
end
end
end

function UIHeChengLianHuaPeiFang_TwoWin:initPeiFangList()
self.peiFangList:freshGridsNum(#self.peiFangCfg,#self.peiFangCfg,1,true)
for i=1,#self.peiFangCfg do
local item=self.peiFangList:getGridObjectByindex(i-1)
if item then
local config=self.peiFangCfg[i]

item:SetChildActive(menuItemInex.select,i==self.menuCurIndex)

item:SetChildText(menuItemInex.name,config.name)


local showItemid=config.itemid
local showStage=true
if itemsConfig.isVocEquip(showItemid)then
showStage=false
end
local conf={itemid=showItemid,showStage=showStage,itemcount='',showCountBG=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(menuItemInex.showItem,propData)





local unLock,requireStr=heChengLianHuaModel:checkPeiFangUnlock(config)
item:SetChildActive(menuItemInex.lock,not unLock)

item:SetChildText(menuItemInex.require,requireStr)

local isCan=heChengLianHuaModel:getIsCan(config)
item:SetChildActive(menuItemInex.reddot,isCan)
end
end
self.peiFangList:jumpToLockX(self.menuCurIndex)
end

function UIHeChengLianHuaPeiFang_TwoWin:refreshPeiFangListReddot()
for i=1,#self.peiFangCfg do
local item=self.peiFangList:getGridObjectByindex(i-1)
if item then
local config=self.peiFangCfg[i]

local isCan=heChengLianHuaModel:getIsCan(config)
item:SetChildActive(menuItemInex.reddot,isCan)
end
end
end

function UIHeChengLianHuaPeiFang_TwoWin:onClickMenuCallBack(id,index,guid,attach)

if self.menuCurIndex==index then return end
self.menuCurIndex=index
for i=1,#self.peiFangCfg do
local item=self.peiFangList:getGridObjectByindex(i-1)
if item then
item:SetChildActive(menuItemInex.select,i==self.menuCurIndex)
end
end
self:refreshRightPanel()
end


function UIHeChengLianHuaPeiFang_TwoWin:onClickSXTypeDropdown(idx)
self.dropDownIdx=idx
local lastSelectPfId=self.curPFConfig.id
self:resetPeiFangList()
self:initPeiFangList()
if self.peiFangCfg[self.menuCurIndex]then
local curPfId=self.peiFangCfg[self.menuCurIndex].id
if lastSelectPfId~=curPfId then
self:refreshRightPanel()
end
end
end

function UIHeChengLianHuaPeiFang_TwoWin:refreshRightPanel()

table.clear(self.checkRefreshItemLookup)
self.curPFConfig=self.peiFangCfg[self.menuCurIndex]
local needDzJobLv=self.curPFConfig.need_lq_lvl
local unLockLimit=self.curPFConfig.unlock

local canHeCheng=true
local unLock=heChengLianHuaModel:checkPeiFangUnlock(self.curPFConfig)
local typeStr=unLock and'消耗材料'or'激活消耗'
self.matTypeText:setText(typeStr)
self.unLockBtn:setActive(not unLock)
self.materials:setActive(unLock)
self.selectCntSlider:setActive(unLock and canHeCheng)


local unLockStr=''
if unLock then
if not canHeCheng then
local jobName=cfgHelper.get2(cfg_discipleproskillconfig_get,proskillId,'name')
unLockStr=FMT.fmt('弟子{0}达到{1}级可炼化',jobName,needDzJobLv)
end
elseif unLockLimit[1]==1 then
unLockStr=FMT.fmt('宗门等级达到{0}级激活',unLockLimit[2])
end
self.unLockText:setActive(not unLock or not canHeCheng)
self.unLockText:setText(unLockStr)

local rewards=heChengLianHuaModel:getRewards(self.curPFConfig)
local num=rewards[1][2]*self.selectCnt
if not unLock then
num=1
end
local showNum=num>1
local numStr=showNum and num or''
local composeId=self.curPFConfig.itemid
self.checkRefreshItemLookup[composeId]=true
local showStage=true
if itemsConfig.isVocEquip(composeId)then
showStage=false
end
local conf={itemid=composeId,showStage=showStage,itemcount=numStr,showCountBG=showNum}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
self.lianHuaItem:setChildPropData(propData)
self.lianHuaItem:setBaseItemClickEvent(function(...)
tipsManager.showTips({itemid=composeId})
end)
if unLock then

local func=function(...)
self:onSliderChange(...)
end
local canMax=heChengLianHuaModel:getMaxLianHuaCount(self.curPFConfig)
self.selectCnt=canHeCheng and canMax or 1
self.maxLianZhiCnt=canMax
local mixCount
if canMax==1 then
mixCount=0
else
mixCount=1
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.maxLianZhiCnt>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,mixCount,self.maxLianZhiCnt,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

local lingshiCost,costList=heChengLianHuaModel:getCostList(self.curPFConfig)
self.gainTable={}
for i=1,#self.materialsItem do
self.materialsItem[i]:setActive(i<=#costList)
if i<=#costList then
local costMat=costList[i]
local matId=costMat[1]
local have=0
local itemList
self.checkRefreshItemLookup[matId]=true
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
elseif itemsConfig.isVocEquip(matId)then
local checkFunc=function(item)
if item.itemflag~=0 then

return false
end
local enhancelv=item.itemData and item.itemData.enhancelv or 0
if enhancelv>0 then

return false
end
return true
end

itemList=bagControl.invokeFuncByItemId(matId,'getItemListWithCheckFuncByItemID',matId,checkFunc,tempList)
have=#itemList
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
self.canSelectItemList=itemList
local need=costMat[2]*self.selectCnt
local colorStr=have<need and'red'or'white'
local countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(need))
local showStage=true
if itemsConfig.isVocEquip(matId)then
showStage=false
end
local matConf={itemid=matId,itemcount=countStr,showCountBG=false,showStage=showStage}
local matProp=itemsComponentHelper.getCommonFillDataSmall(matConf)
matProp[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
matProp[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
matProp[PropIndex(DataPropKey.eWidgetActive,7)]=have<need
self.gainTable[matId]=need
local widget=self.materialsItem[i]:getWidgetBase()
widget:SetChildPropData(0,matProp)
widget:SetBaseItemClickEvent(0,function(...)
if itemsModel.getCount(matId)<(self.gainTable[matId]or 0)then
local needCount=self.gainTable[matId]or 0
gainControl:showGainWin(matId,nil,{needCount=needCount})
return
end
tipsManager.showTips({itemid=matId,usingType=TIPS_USING_TYPE.eNormal})
end)
end
end
if lingshiCost then
self.costCntText:setActive(true)
local iconName=iconHelper.getIconName(lingshiCost[1])
local have=moneyModel.getMoney(lingshiCost[1])
local need=lingshiCost[2]*self.selectCnt
local colorStr=have<need and'red'or'black'
local countStr=FMT.fmt('<color={0}>{1}</color>',colorStr,need)
self.costIcon:setImageIcon(iconName,false)
self.costCntText:setText(countStr)
else
self.costCntText:setActive(false)
end
end

local btnStr="合成"
if self.curPFConfig.btnText then
btnStr=self.curPFConfig.btnText
end
self.selectBtnText:setText(btnStr)
end

function UIHeChengLianHuaPeiFang_TwoWin:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)

local lingshiCost,costList=heChengLianHuaModel:getCostList(self.curPFConfig)
self.gainTable={}
for i=1,#self.materialsItem do
if i<=#costList then
local costMat=costList[i]
local matId=costMat[1]
local have=0
local itemList
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
elseif itemsConfig.isVocEquip(matId)then
local checkFunc=function(item)
if item.itemflag~=0 then

return false
end
local enhancelv=item.itemData and item.itemData.enhancelv or 0
if enhancelv>0 then

return false
end
return true
end

itemList=bagControl.invokeFuncByItemId(matId,'getItemListWithCheckFuncByItemID',matId,checkFunc,tempList)
have=#itemList
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
self.canSelectItemList=itemList
local need=costMat[2]*self.selectCnt
local colorStr=have<need and'red'or'white'
local countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(need))
local widget=self.materialsItem[i]:getWidgetBase()
local matItem=widget:GetChildWidgetBase(0)
self.gainTable[matId]=need
local showStage=true
if itemsConfig.isVocEquip(matId)then
showStage=false
end
local matConf={itemid=matId,itemcount=countStr,showCountBG=false,showStage=showStage}
local matProp=itemsComponentHelper.getCommonFillDataSmall(matConf)
matProp[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
matProp[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
matProp[PropIndex(DataPropKey.eWidgetActive,7)]=have<need
widget:SetChildPropData(0,matProp)






end
end
if lingshiCost then
self.costCntText:setActive(true)
local have=moneyModel.getMoney(lingshiCost[1])
local need=lingshiCost[2]*self.selectCnt
local colorStr=have<need and'red'or'black'
local countStr=FMT.fmt('<color={0}>{1}</color>',colorStr,need)
self.costCntText:setText(countStr)
else
self.costCntText:setActive(false)
end

local rewards=heChengLianHuaModel:getRewards(self.curPFConfig)
local num=rewards[1][2]*self.selectCnt
local showNum=num>1
local numStr=showNum and num or''
local widget=self.lianHuaItem:getWidgetBase()
widget:SetChildActive(2,showNum)
widget:SetChildText(3,numStr)
end


function UIHeChengLianHuaPeiFang_TwoWin:resetTypeScrollView()
self.selectType=self.selectType or 1
local isShowTypeScrollView=self.selectPage==2 or self.selectPage==3
self.typeScrollView:setActive(isShowTypeScrollView)
local height=isShowTypeScrollView and 425 or 495
self.winlua:SetChildSizeDelta(self.peiFangList:getID(),330,height)

if isShowTypeScrollView then
self:freshTypeGirds()
end
end

function UIHeChengLianHuaPeiFang_TwoWin:freshTypeGirds()
local list={"合成","分解"}
local tNum=#list
self.typeScrollView:setChildScrollViewCreateGrids(tNum,tNum)

local grids=self.typeScrollView:getChildScrollViewItemWidgets()
for i=1,tNum do
local item=grids[i-1]
local name=list[i]
local flag=i==self.selectType
item:SetChildText(1,name)
self:refreshTypeItem(item,flag)
local reddot=self:checkTypeItemReddot(i)
item:SetChildActive(2,reddot)
end
end

function UIHeChengLianHuaPeiFang_TwoWin:onSelectTypeItem(index)
local old=self.selectType
self.selectType=index
if old and old~=index then
local item=self.typeScrollView:getChildScrollViewItemWidget(old-1)
self:refreshTypeItem(item,false)
end
local item=self.typeScrollView:getChildScrollViewItemWidget(index-1)
self:refreshTypeItem(item,true)

self:resetPeiFangList()
self:initPeiFangList()
self:refreshRightPanel()
end

function UIHeChengLianHuaPeiFang_TwoWin:refreshTypeItem(item,flag)
item:SetChildActive(0,flag)
end

function UIHeChengLianHuaPeiFang_TwoWin:checkTypeItemReddot(index)
local isShowType=self.selectPage==2 or self.selectPage==3
if not isShowType or index==2 then

return false
end

local selectPage=self.selectPage
local selectType=index
local dropDownIdx=0

local peiFangCfg=heChengLianHuaModel:getPeiFangListByType_notSort(selectPage,dropDownIdx,selectType)
for i,config in ipairs(peiFangCfg)do
local isCan=heChengLianHuaModel:getIsCan(config)
if isCan then
return true
end
end
return false
end

function UIHeChengLianHuaPeiFang_TwoWin:refreshTypeGirdsReddot()
local isShowType=self.selectPage==2 or self.selectPage==3
if not isShowType then
return
end
local grids=self.typeScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
local reddot=self:checkTypeItemReddot(i)
item:SetChildActive(2,reddot)
end
end

function UIHeChengLianHuaPeiFang_TwoWin:onItemListChanged(array)
local needRefresh=false
for i,v in ipairs(array)do
local itemid=v[3]
if self.checkRefreshItemLookup[itemid]then
needRefresh=true
break
end
end

if needRefresh then
self:refreshTypeGirdsReddot()
self:refreshPeiFangListReddot()
self:refreshRightPanel()
end
end




function UIHeChengLianHuaPeiFang_TwoWin:onAddBtn()
end



function UIHeChengLianHuaPeiFang_TwoWin:onSubBtn()
end



function UIHeChengLianHuaPeiFang_TwoWin:onSelectBtn()
local btnStr="合成"
if self.curPFConfig.btnText then
btnStr=self.curPFConfig.btnText
end
local isCan,isLzcsHC=heChengLianHuaModel:getIsCan(self.curPFConfig,self.selectCnt,true)
if not isCan then
return
end
local lingshiCost,costList=heChengLianHuaModel:getCostList(self.curPFConfig)
if self.selectPage==2 and not isLzcsHC then
local hclist={}
local fjlist={}

local items=lingzhenBagModel:getBagItems()
for i,v in ipairs(costList)do
local matId=v[1]
local need=v[2]*self.selectCnt
for ii,vv in ipairs(items)do
if vv.itemid==matId then
table.insert(hclist,{vv.itemguid,need})
for iii=1,need do
table.insert(fjlist,vv.itemguid)
end
end
end
end
local rewards=heChengLianHuaModel:getRewards(self.curPFConfig)
local itemId=rewards[1][1]
local count=rewards[1][2]*self.selectCnt
if not lingshiCost then
local win=UIManager:findActiveWindow('UIHeChengLianHuaWin')
if win then
local sfId=self.sfId
local bdData=self.bdData

win:startHeChengLianHua(self.curPFConfig.id,nil,function(pfId,isBackPf)
UIYuFuLingZhenControl.req_2_109(fjlist,{{param_1=itemId,param_2=count}})
if isBackPf then
UIFullBaGuaLuControl:showWindow('UIHeChengLianHuaPeiFangWin',{sfId=sfId,bdData=bdData,pfId=pfId})
end
end)
else
UIYuFuLingZhenControl.req_2_109(fjlist,{{param_1=itemId,param_2=count}})
end
else
UIYuFuLingZhenControl.req_2_146(rewards[1][1],self.selectCnt,#hclist,hclist)
end
else
local selectItemList={}
if self.canSelectItemList and next(self.canSelectItemList)then
local remainingCount=self.selectCnt
for _,item in ipairs(self.canSelectItemList)do
local itemguid=item.itemguid
local itemcount=item.itemcount
local useCount=math.min(itemcount,remainingCount)
selectItemList[#selectItemList+1]={itemguid,useCount}

remainingCount=remainingCount-useCount
if remainingCount<=0 then
break
end
end
end

heChengLianHuaController:reqHeChengItem(self.sfId,self.ubdId,self.curPFConfig.id,self.selectCnt,nil,selectItemList)
end

self:onClickCloseBtn()
end



function UIHeChengLianHuaPeiFang_TwoWin:onMaxCnt()
self.selectCnt=self.curPFConfig.maxCount
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.maxLianZhiCnt)
end



function UIHeChengLianHuaPeiFang_TwoWin:onSortBtn()
self.sortOrder=not self.sortOrder
self:resetPeiFangList()
self:initPeiFangList()
end



function UIHeChengLianHuaPeiFang_TwoWin:onUnLockBtn()
fullScreenUI:closeActiveUI()
jumpManager:jump({id=1101})
end

function UIHeChengLianHuaPeiFang_TwoWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.maxLianZhiCnt then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIHeChengLianHuaPeiFang_TwoWin:onTypeScrollItemClick(clickCount,index)
local idx=index+1
if self.selectType==idx then
return
end
self:onSelectTypeItem(idx)
end

function UIHeChengLianHuaPeiFang_TwoWin:closeSelfWinByParentWin()
self:closeSelf()
end

function UIHeChengLianHuaPeiFang_TwoWin:onClickCloseBtn()
if self.parent then
return self.parent:onClickCloseBtn()
else
self:closeSelf()
end
end

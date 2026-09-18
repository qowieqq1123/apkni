







def_class("UIHeChengLianHuaPeiFangWin",UIWindowBase)









function UIHeChengLianHuaPeiFangWin:bindComponents()

self.costIcon=UIImage.get(self,0)
self.materialsItem_4=UIBaseItem.get(self,1)
self.materialsItem_1=UIBaseItem.get(self,2)
self.materialsItem_2=UIBaseItem.get(self,3)
self.materialsItem_3=UIBaseItem.get(self,4)
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
self.title=UIText.get(self,21)
self.selectBtnText=UIText.get(self,22)
self.toggleGroup=UIObject.get(self,23)
self.typeScrollView=UIObject.get(self,24)
self.root=UIObject.get(self,25)

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


function UIHeChengLianHuaPeiFangWin:unbindComponents()
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
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.selectBtnText);self.selectBtnText=nil;
_UIObject_release(self.toggleGroup);self.toggleGroup=nil;
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

local useOtherPageWinNameList={
[3]="UIHeChengLianHuaPeiFang_TwoWin"
}

local hidePageTypeLookup={

}



function UIHeChengLianHuaPeiFangWin:onLoaded(...)
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
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
end


function UIHeChengLianHuaPeiFangWin:__delete()
self:unbindComponents()
_this=nil
end




function UIHeChengLianHuaPeiFangWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.sfId=argtable.sfId
self.bdData=argtable.bdData
if self.bdData then

self.ubdId=self.bdData.un_build_id
end

if argtable.pfId then

self.curPFConfig=cfgHelper.get1(cfg_lianqigeconfig_get,argtable.pfId)
self.selectPage,self.selectType=heChengLianHuaModel:getSelectTypeByItemid(argtable.pfId)
elseif argtable.itemid then

self.selectPage,self.menuCurIndex,self.selectType,self.curPFConfig=heChengLianHuaModel:getMenuIndexByItemid(argtable.itemid)
else
self.selectPage=argtable.selectPage or 1
self.selectType=argtable.selectType or 1
self.menuCurIndex=1
end
self.selectCnt=1


self.option={}
local config=cfg_lianqigeconfig()
self.pageList=config.const_def.pageList
self.showPageList={}
for i,v in ipairs(self.pageList)do
if self.option[i]==nil then
self.option[i]={}
self.option[i][#self.option[i]+1]="全部"
end
for ii,vv in ipairs(v.list)do
self.option[i][#self.option[i]+1]=vv.name
end

local isShow=true
if v.cnd then
isShow=false
local isHide=hidePageTypeLookup[i]
if not isHide then
local cndType=v.cnd[1]
local cndParam=v.cnd[2]
if cndType==1 then

local sysId=cndParam
isShow=systemModel.isOpen(sysId)
end
end
end
if isShow then
self.showPageList[#self.showPageList+1]={id=i,info=v}
end
end

self.selectDropdown:setOption(self.option[self.selectPage])
self.selectDropdown:setValue(self.dropDownIdx)

self:loadBtns()

self:refreshPageWin()






end


function UIHeChengLianHuaPeiFangWin:onHide()

end

function UIHeChengLianHuaPeiFangWin:resetPeiFangList()
local isIgnoreReddotSort=self.selectPage==2 or self.selectPage==3
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

function UIHeChengLianHuaPeiFangWin:initPeiFangList()
self.peiFangList:freshGridsNum(#self.peiFangCfg,#self.peiFangCfg,1,true)
for i=1,#self.peiFangCfg do
local item=self.peiFangList:getGridObjectByindex(i-1)
if item then
local config=self.peiFangCfg[i]

item:SetChildActive(menuItemInex.select,i==self.menuCurIndex)

item:SetChildText(menuItemInex.name,config.name)


local showItemid=config.itemid
local conf={itemid=showItemid,showStage=true,itemcount='',showCountBG=false}
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

function UIHeChengLianHuaPeiFangWin:refreshPeiFangListReddot()
for i=1,#self.peiFangCfg do
local item=self.peiFangList:getGridObjectByindex(i-1)
if item then
local config=self.peiFangCfg[i]

local isCan=heChengLianHuaModel:getIsCan(config)
item:SetChildActive(menuItemInex.reddot,isCan)
end
end
end

function UIHeChengLianHuaPeiFangWin:onClickMenuCallBack(id,index,guid,attach)

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


function UIHeChengLianHuaPeiFangWin:onClickSXTypeDropdown(idx)
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

function UIHeChengLianHuaPeiFangWin:refreshRightPanel()

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
local conf={itemid=composeId,showStage=true,itemcount=numStr,showCountBG=showNum}
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
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
local need=costMat[2]*self.selectCnt
local colorStr=have<need and'red'or'white'
local countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(need))
local matConf={itemid=matId,itemcount=countStr,showCountBG=false,showStage=true}
local matProp=itemsComponentHelper.getCommonFillDataSmall(matConf)
matProp[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
matProp[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
matProp[PropIndex(DataPropKey.eWidgetActive,7)]=have<need
self.gainTable[matId]=need
self.materialsItem[i]:setChildPropData(matProp)
self.materialsItem[i]:setBaseItemClickEvent(function(...)
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

function UIHeChengLianHuaPeiFangWin:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)

local lingshiCost,costList=heChengLianHuaModel:getCostList(self.curPFConfig)
self.gainTable={}
for i=1,#self.materialsItem do
if i<=#costList then
local costMat=costList[i]
local matId=costMat[1]
local have=0
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
local need=costMat[2]*self.selectCnt
local colorStr=have<need and'red'or'white'
local countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(need))
local matItem=self.winlua:GetChildCSGUIBaseItem(self.materialsItem[i]:getID())
self.gainTable[matId]=need
matItem:SetChildImageExGray(0,have==0)
matItem:SetChildImageExGray(1,have==0)
matItem:SetChildText(3,countStr)
matItem:SetChildActive(7,have<need)
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



function UIHeChengLianHuaPeiFangWin:onUnLockBtn()
fullScreenUI:closeActiveUI()
jumpManager:jump({id=1101})
end

function UIHeChengLianHuaPeiFangWin:onMaxCnt()
self.selectCnt=self.curPFConfig.maxCount
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.maxLianZhiCnt)
end

function UIHeChengLianHuaPeiFangWin:onSelectBtn()
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
heChengLianHuaController:reqHeChengItem(self.sfId,self.ubdId,self.curPFConfig.id,self.selectCnt)
end
self:onClickCloseBtn()
end

function UIHeChengLianHuaPeiFangWin:onSortBtn()
self.sortOrder=not self.sortOrder
self:resetPeiFangList()
self:initPeiFangList()
end

function UIHeChengLianHuaPeiFangWin:onClickCloseBtn()
UIFullBaGuaLuControl:closeWindow(self.winlua.name)
end

function UIHeChengLianHuaPeiFangWin:onSubBtn()
end

function UIHeChengLianHuaPeiFangWin:onAddBtn()
end

function UIHeChengLianHuaPeiFangWin:onLongPressBtn(id)
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

function UIHeChengLianHuaPeiFangWin:loadBtns()

self.pageIndexLookup={}
local len=#self.showPageList
self.toggleGroup:setChildLayoutGroupCreateItems(len)
local selectPage=self.selectPage or 1
for i=1,len do

local info=self.showPageList[i].info
local id=self.showPageList[i].id
self.pageIndexLookup[id]=i
local name=info.name
local item=self.toggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildButtonClickWithID(0,self.onToggleChange,i,true)
item:SetChildText(1,name)

local isSelected=selectPage==id
local func=function()
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)


end
end

function UIHeChengLianHuaPeiFangWin.onToggleChange(idx)
local pageId=_this.showPageList[idx].id
if _this.selectPage~=pageId then
if _this.selectPage then
local originalPageIdx=_this.pageIndexLookup[_this.selectPage]
_this:setToggleOn(originalPageIdx,false)
end
_this:setToggleOn(idx,true)

_this.selectPage=pageId
_this.dropDownIdx=0

_this.selectDropdown:setOption(_this.option[_this.selectPage])
_this.selectDropdown:setValue(_this.dropDownIdx)

_this:refreshPageWin()
end
end

function UIHeChengLianHuaPeiFangWin:setToggleOn(index,on)
local item=self.toggleGroup:getChildLayoutGroupGridItem(index-1)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIHeChengLianHuaPeiFangWin:refreshPageWin()
local winName=useOtherPageWinNameList[self.selectPage]
local isOtherPageWin=winName~=nil
self.root:setActive(not isOtherPageWin)
if isOtherPageWin then
self.otherPageWinName=winName
local args={
sfId=self.sfId,
bdData=self.bdData,
curPFConfig=self.curPFConfig,
selectPage=self.selectPage,
selectType=self.selectType,
menuCurIndex=self.menuCurIndex,
parent=self,
}
self:showWindow(winName,args)
else
local isActiveOtherPageWin=self.otherPageWinName~=nil
if isActiveOtherPageWin then
local winName=self.otherPageWinName
UIManager:invokeUIMethod(winName,"closeSelfWinByParentWin")
end
self.otherPageWinName=nil
self:resetPeiFangList()
self:resetTypeScrollView()
self:initPeiFangList()
self:refreshRightPanel()
end
end

function UIHeChengLianHuaPeiFangWin:resetTypeScrollView()
self.selectType=self.selectType or 1
local isShowTypeScrollView=self.selectPage==2 or self.selectPage==3
self.typeScrollView:setActive(isShowTypeScrollView)
local height=isShowTypeScrollView and 409 or 469
self.winlua:SetChildSizeDelta(self.peiFangList:getID(),384,height)

if isShowTypeScrollView then
self:freshTypeGirds()
end
end

function UIHeChengLianHuaPeiFangWin:freshTypeGirds()
local list={"合 成","分 解"}
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

function UIHeChengLianHuaPeiFangWin:onTypeScrollItemClick(clickCount,index)
local idx=index+1
if self.selectType==idx then
return
end
self:onSelectTypeItem(idx)
end

function UIHeChengLianHuaPeiFangWin:onSelectTypeItem(index)
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

function UIHeChengLianHuaPeiFangWin:refreshTypeItem(item,flag)
item:SetChildActive(0,flag)
end

function UIHeChengLianHuaPeiFangWin:checkTypeItemReddot(index)
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

function UIHeChengLianHuaPeiFangWin:refreshTypeGirdsReddot()
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

function UIHeChengLianHuaPeiFangWin:onItemListChanged(array)
if self.otherPageWinName then
local winName=self.otherPageWinName
return UIManager:invokeUIMethod(winName,"onItemListChanged",array)
end

local hasLzItem=false
for i,v in ipairs(array)do
local itemid=v[3]
if itemsConfig.isLingZhen(itemid)then
hasLzItem=true
break
end
end

if hasLzItem then
self:refreshTypeGirdsReddot()
self:refreshPeiFangListReddot()
end
end


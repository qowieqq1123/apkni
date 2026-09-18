







def_class("UIXingJiaoShangRenExchangeWin",UIWindowBase)









function UIXingJiaoShangRenExchangeWin:bindComponents()

self.background=UIButton.get(self,0)
self.buildingTab=UIButton.get(self,1)
self.buildingTabSelect=UIObject.get(self,2)
self.buildingView=UIScrollViewSlow.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.confirmBtn=UIButton.get(self,5)
self.finish=UIObject.get(self,6)
self.helpBtn=UIButton.get(self,7)
self.itemTab=UIButton.get(self,8)
self.itemTabSelect=UIObject.get(self,9)
self.itemView=UIScrollViewSlow.get(self,10)
self.model=UIObject.get(self,11)
self.selectBtn=UIButton.get(self,12)
self.selectItem_1=UIButton.get(self,13)
self.selectItem_10=UIButton.get(self,14)
self.selectItem_2=UIButton.get(self,15)
self.selectItem_3=UIButton.get(self,16)
self.selectItem_4=UIButton.get(self,17)
self.selectItem_5=UIButton.get(self,18)
self.selectItem_6=UIButton.get(self,19)
self.selectItem_7=UIButton.get(self,20)
self.selectItem_8=UIButton.get(self,21)
self.selectItem_9=UIButton.get(self,22)
self.selectList=UIObject.get(self,23)
self.selectNone=UIText.get(self,24)
self.selectTx=UIText.get(self,25)
self.talkRoot=UIObject.get(self,26)
self.talkTx=UIText.get(self,27)
self.targetBtn=UIButton.get(self,28)
self.targetIcon=UIImage.get(self,29)
self.targetList=UIObject.get(self,30)
self.targetNumTx=UIText.get(self,31)
self.targetOther=UIObject.get(self,32)
self.targetPanel=UIObject.get(self,33)

self.background:setButtonClick(function()self:onBackground()end)

self.buildingTab:setButtonClick(function()self:onBuildingTab()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.itemTab:setButtonClick(function()self:onItemTab()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.selectItem_1:setButtonClick(function()self:onSelectItem_1()end)

self.selectItem_10:setButtonClick(function()self:onSelectItem_10()end)

self.selectItem_2:setButtonClick(function()self:onSelectItem_2()end)

self.selectItem_3:setButtonClick(function()self:onSelectItem_3()end)

self.selectItem_4:setButtonClick(function()self:onSelectItem_4()end)

self.selectItem_5:setButtonClick(function()self:onSelectItem_5()end)

self.selectItem_6:setButtonClick(function()self:onSelectItem_6()end)

self.selectItem_7:setButtonClick(function()self:onSelectItem_7()end)

self.selectItem_8:setButtonClick(function()self:onSelectItem_8()end)

self.selectItem_9:setButtonClick(function()self:onSelectItem_9()end)

self.targetBtn:setButtonClick(function()self:onTargetBtn()end)
self.selectItem={
self.selectItem_1,
self.selectItem_2,
self.selectItem_3,
self.selectItem_4,
self.selectItem_5,
self.selectItem_6,
self.selectItem_7,
self.selectItem_8,
self.selectItem_9,
self.selectItem_10,
}



end


function UIXingJiaoShangRenExchangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.buildingTab);self.buildingTab=nil;
_UIObject_release(self.buildingTabSelect);self.buildingTabSelect=nil;
_UIObject_release(self.buildingView);self.buildingView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.finish);self.finish=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.itemTab);self.itemTab=nil;
_UIObject_release(self.itemTabSelect);self.itemTabSelect=nil;
_UIObject_release(self.itemView);self.itemView=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.selectItem_1);self.selectItem_1=nil;
_UIObject_release(self.selectItem_10);self.selectItem_10=nil;
_UIObject_release(self.selectItem_2);self.selectItem_2=nil;
_UIObject_release(self.selectItem_3);self.selectItem_3=nil;
_UIObject_release(self.selectItem_4);self.selectItem_4=nil;
_UIObject_release(self.selectItem_5);self.selectItem_5=nil;
_UIObject_release(self.selectItem_6);self.selectItem_6=nil;
_UIObject_release(self.selectItem_7);self.selectItem_7=nil;
_UIObject_release(self.selectItem_8);self.selectItem_8=nil;
_UIObject_release(self.selectItem_9);self.selectItem_9=nil;
_UIObject_release(self.selectList);self.selectList=nil;
_UIObject_release(self.selectNone);self.selectNone=nil;
_UIObject_release(self.selectTx);self.selectTx=nil;
_UIObject_release(self.talkRoot);self.talkRoot=nil;
_UIObject_release(self.talkTx);self.talkTx=nil;
_UIObject_release(self.targetBtn);self.targetBtn=nil;
_UIObject_release(self.targetIcon);self.targetIcon=nil;
_UIObject_release(self.targetList);self.targetList=nil;
_UIObject_release(self.targetNumTx);self.targetNumTx=nil;
_UIObject_release(self.targetOther);self.targetOther=nil;
_UIObject_release(self.targetPanel);self.targetPanel=nil;
self.selectItem=nil;
end















local _this=nil
local _selectItemCmp={
root=-1,
item=0,
building=1,
countBg=2,
txt_count=3,
txt_name=4,
buildingQuality=5,
buildingIcon=6,
}
local _targetItemCmp={
root=4,
effect=0,
icon=1,
numTx=2,
select=3,
}
local _col=5
local _row=4
local _pageNum=_col*_row



function UIXingJiaoShangRenExchangeWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(247,61,self.on_247_61)
self:addProNotify(247,62,self.on_247_62)
self:addNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)

self.itemView:bindSlowWidget(function(...)self:bindItemGrid(...)end)
self.buildingView:bindSlowWidget(function(...)self:bindBuildingGrid(...)end)
for i,v in ipairs(self.selectItem)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_selectItemCmp.root,function()
self:onSelectItemClick(i)
end)
end

self.winlua:SetChildLongTouch(self.targetBtn:getID(),0,1,function()
self:onLongTouchTargetBtn()
end)

self.tabSelect=true
end


function UIXingJiaoShangRenExchangeWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXingJiaoShangRenExchangeWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.info=argtable.info
self.actId=self.info.act_id
self.config=self.info:getSubActConfig()
self.tabSelect=self.tabSelect==nil and true or self.tabSelect
self:refreshModel()
self:refreshTargetPanel()
self:refreshViewTabSelect()
self:resetSelectData()
self:updateItemData()
self:updateBuildingData()
self:resetItemViewList()
self:resetBuildingViewList()
self:refreshSelectView()

self:showView()
end


function UIXingJiaoShangRenExchangeWin:onHide()

end




function UIXingJiaoShangRenExchangeWin:onBackground()
self:onCloseBtn()
end


function UIXingJiaoShangRenExchangeWin:onBuildingTab()
if not self.tabSelect then return end
self.itemTabSelect:setActive(false)
self.buildingTabSelect:setActive(true)
self.itemView:setScale(Vector3.up)
self.buildingView:setScale(Vector3.one)
self.tabSelect=false
end


function UIXingJiaoShangRenExchangeWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXingJiaoShangRenExchangeWin:onConfirmBtn()
if not self.info:checkDoing()then
return UIManager.error("商人已离开")
end

local itemList=self.targetData
local itemId=itemList[self.targetSelect]
local itemCount=self.info:getItemCount(itemId)
local exchangeCount=self.config.exchange[itemId][1]
if itemCount>=exchangeCount then
return UIManager.error("该物品数量已交易完")
end

if self.selectShowCnt<=0 then
return UIManager.info("请先选择图纸")
end

if self.selectScore>=self.targetScore then
local itemList={}
local nBuildList={}
local sBuildLookup={}
local sBuildList={}
for listIndex,count in pairs(self.selectItemData)do
local itemData=self.itemDataList[listIndex].itemStruct
if count>0 then
table.insert(itemList,{tostring(itemData.itemguid),count})
end
end
for listIndex,count in pairs(self.selectBuildingData)do
local buildingData=self.buildingDataList[listIndex]
if buildingData.flag==0 then
for i=1,count do
local guidData=buildingData.buildGuids[i]
local ubdId=guidData[1]
table.insert(nBuildList,ubdId)
end
else
for i=1,count do
local guidData=buildingData.buildGuids[i]
local ubdId=guidData[1]
local sfId=guidData[2]
if sBuildLookup[sfId]==nil then sBuildLookup[sfId]={}end
table.insert(sBuildLookup[sfId],ubdId)
end
end
end
for sfId,ubdIdList in pairs(sBuildLookup)do
table.insert(sBuildList,{sfId,ubdIdList})
end

local cPrecent=self.selectScore/self.targetScore*100
local strLib=self.config.speak3
local speadIdx=nil
for i,v in ipairs(strLib)do
local tPrecent=v[1]
if cPrecent<tPrecent then
speadIdx=i
break
end
end
speadIdx=speadIdx or#strLib




call_activitiesHandle_func("activitiesHandle_xingjiaoshangren","reqExchangeItem",self.info.act_id,self.info.sub_act_id,itemId,self.targetCount,itemList,nBuildList,sBuildList,speadIdx)
else
UIManager.info("仙商不愿意交易，再加点吧")


end
end


function UIXingJiaoShangRenExchangeWin:onItemTab()
if self.tabSelect then return end
self.itemTabSelect:setActive(true)
self.buildingTabSelect:setActive(false)
self.itemView:setScale(Vector3.one)
self.buildingView:setScale(Vector3.up)
self.tabSelect=true
end

function UIXingJiaoShangRenExchangeWin:onTargetBtn()
self:setTargetState()
end

function UIXingJiaoShangRenExchangeWin:onLongTouchTargetBtn()
local itemList=self.targetData
local itemId=itemList[self.targetSelect]
tipsManager.showTips({itemid=itemId})
end

function UIXingJiaoShangRenExchangeWin:onSelectBtn()
if self.targetSelect then
local itemList=self.targetData
local itemId=itemList[self.targetSelect]
local count=self.info:getItemCount(itemId)
local exchange=self.config.exchange
local exchangeCnt=exchange[itemId][1]
local max=exchangeCnt-count

if max>1 then
local show_data={
type='UIDialougeBuyCountNoTip',
title='选择兑换数量',
oktext='确定',
rewards={{itemId,0}},
refreshcallback=function(cnt)
return"确定"
end,

max=max,
showclosebtn=true,
okcallback=function(cnt)
if _this==nil then return end
self.targetCount=cnt
self:setSelectState()
end,
cancelcallback=nil,
closecallback=nil,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self.targetCount=1
self:setSelectState()
end
else
UIManager.info("请先选择兑换物品")
end
end

function UIXingJiaoShangRenExchangeWin:resetSelectData()







self.selectShowData={}

self.selectShowLookup={}

self.selectShowCnt=0

self.selectScore=0

self.selectItemData={}

self.selectBuildingData={}
end

function UIXingJiaoShangRenExchangeWin:showView()
self.itemView:setScale(self.tabSelect and Vector3.one or Vector3.up)
self.buildingView:setScale(not self.tabSelect and Vector3.one or Vector3.up)
if self.info:checkFinish()then
self:setFinishState()
self:speakWord2()
else
self:setTargetState()
self:speakWord1()
self:autoClickTargetItem()
end
end

function UIXingJiaoShangRenExchangeWin:autoClickTargetItem()
local itemList=self.targetData
local exchange=self.config.exchange
for index,itemId in ipairs(itemList)do
local count=self.info:getItemCount(itemId)
local exchangeCnt=exchange[itemId][1]
if count<exchangeCnt then
self:onClickTargetItem(index)
break
end
end
end

function UIXingJiaoShangRenExchangeWin:refreshTargetBtn()
local itemList=self.targetData
local itemId=itemList[self.targetSelect]
local itemCount=self.info:getItemCount(itemId)


self.targetNumTx:setText(self.targetCount)
self.targetIcon:setImageIcon(iconHelper.getIconName(itemId),false)
end

function UIXingJiaoShangRenExchangeWin:speakWord(str,callback)
if self.talkTween and self.talkTween:IsActive()then
self.talkTween:Kill(true)
end
self.talkTx:setText('')
self.talkRoot:setChildCanvasGroupAlpha(0)
self.talkRoot:setScale(Vector3.zero)
self.talkTween=Lua.SequenceProxy.New()
local talkTxCmp=self.talkTx:getGameObject():GetComponent("Text")
local tween0=Lua.DOTweenProxyExtensions.DOText(talkTxCmp,"",0)
tween0:SetEase(DG.Tweening.Ease.Linear)
local tween1=self.talkRoot:setChildCanvasGroupDOFade(1,0.1)
local tween2=self.talkRoot:setChildDOScale(1.2,0.2)
local tween3=self.talkRoot:setChildDOScale(1,0.1)
local tween4=Lua.DOTweenProxyExtensions.DOText(talkTxCmp,str,1)
local temp=Lua.SequenceProxy.New()
temp:Append(tween2)
temp:Append(tween3)
self.talkTween:Append(tween0)
self.talkTween:Append(temp)
self.talkTween:Join(tween1)
self.talkTween:Join(tween4)
if callback then
self.talkTween:AppendInterval(5)
self.talkTween:AppendCallback(callback)
end
end

function UIXingJiaoShangRenExchangeWin:setFinishState()
self:resetSelectData()
self:refreshSelectView()
self:resetItemViewList()
self:resetBuildingViewList()

self.finish:setActive(true)
self.targetOther:setActive(true)
self.selectList:setActive(false)
self.targetBtn:setActive(false)
self.targetPanel:setActive(false)

self.winState=-1
end

function UIXingJiaoShangRenExchangeWin:setTargetState()

self:resetSelectData()
self:refreshSelectView()
self:resetItemViewList()
self:resetBuildingViewList()

self.finish:setActive(false)
self.selectList:setActive(false)
self.targetBtn:setActive(false)
self.targetPanel:setActive(true)
self.targetOther:setActive(false)
self.selectBtn:setActive(self.targetSelect~=nil)
self.selectNone:setActive(self.targetSelect==nil)

if self.targetSelect then
local itemList=self.targetData
local itemId=itemList[self.targetSelect]
local itemName=itemsConfig.getItemName(itemId)
self.selectTx:setText(FMT.fmt("是否选择兑换【{0}】",itemName))
end

self.targetPanel:setChildCanvasGroupAlpha(0)
self.targetPanel:setChildCanvasGroupDOFade(1,0.2)

self.winState=0
end

function UIXingJiaoShangRenExchangeWin:setSelectState()
self.finish:setActive(false)
self.selectList:setActive(true)
self.targetBtn:setActive(true)
self.targetPanel:setActive(false)
self.targetOther:setActive(true)
self:refreshTargetBtn()

local itemList=self.targetData
local itemId=itemList[self.targetSelect]
self.targetScore=self.config.exchange[itemId][2]*self.targetCount

self:refreshConfirmGray()

self.selectList:setChildCanvasGroupAlpha(0)
self.selectList:setChildCanvasGroupDOFade(1,0.2)
self.targetBtn:setChildCanvasGroupAlpha(0)
self.targetBtn:setChildCanvasGroupDOFade(1,0.2)
self.targetOther:setChildCanvasGroupAlpha(0)
self.targetOther:setChildCanvasGroupDOFade(1,0.2)

self.winState=1
self:speakWord0()
end

function UIXingJiaoShangRenExchangeWin:refreshModel()
local modelParams=self.config.image
self.model:setChildUIModelShowTarget(modelParams[1],modelParams[3],modelParams[2],eAnimationID.stand,false,false,0)
end

function UIXingJiaoShangRenExchangeWin:refreshViewTabSelect()
self.itemTabSelect:setActive(self.tabSelect)
self.buildingTabSelect:setActive(not self.tabSelect)
end

function UIXingJiaoShangRenExchangeWin:refreshConfirmGray()
self.confirmBtn:setChildGraphicGray(self.selectShowCnt<=0)
end

function UIXingJiaoShangRenExchangeWin:refreshSelectView()
for i,v in ipairs(self.selectItem)do
self:refreshSelectItem(i)
end
end

function UIXingJiaoShangRenExchangeWin:refreshSelectItem(index)
local selectData=self.selectShowData[index]
local widget=self.selectItem[index]:getChildWidgetBase()
if selectData then
local dataType=selectData.type
local dataId=selectData.id
local dataCnt=selectData.count
local moreOne=dataCnt>0
widget:SetChildActive(_selectItemCmp.item,dataType==1)
widget:SetChildActive(_selectItemCmp.building,dataType==2)
widget:SetChildActive(_selectItemCmp.countBg,moreOne)
widget:SetChildText(_selectItemCmp.txt_count,moreOne and dataCnt or"")
if dataType==1 then
local conf={itemid=dataId,itemcount="",showCountBG=false,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(_selectItemCmp.item,prop)
widget:SetChildText(_selectItemCmp.txt_name,itemsConfig.getItemName(dataId))
elseif dataType==2 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,dataId)
local itemId=zongmenBuildingSuitModel:findPartItemByBuilding(dataId)
widget:SetChildCSImageIcon(_selectItemCmp.buildingIcon,cfg.icon,false)
widget:SetChildQulaity(_selectItemCmp.buildingQuality,itemsConfig.getItemColor(itemId))
widget:SetChildText(_selectItemCmp.txt_name,cfg.name)
end
else
widget:SetChildActive(_selectItemCmp.item,false)
widget:SetChildActive(_selectItemCmp.building,false)
widget:SetChildActive(_selectItemCmp.countBg,false)
widget:SetChildText(_selectItemCmp.txt_count,"")
widget:SetChildText(_selectItemCmp.txt_name,"")
end
end

function UIXingJiaoShangRenExchangeWin:onSelectItemClick(index)
local selectData=self.selectShowData[index]
if selectData then
local itemId=selectData.type==1 and selectData.id or zongmenBuildingSuitModel:findPartItemByBuilding(selectData.id)

self:showSelectDataTips(selectData.type,selectData.index,itemId,1,selectData.count,false)
end
end

function UIXingJiaoShangRenExchangeWin:showSelectDataTips(tabType,viewIndex,itemid,num,count,sign)
if num>count then return end
local selectNumCmpArgs={numFormat='选择：<color=#f1ce78>{0}/{1}</color>',min=1,val=num,max=count,isOverZero=true}
local args={
itemid=itemid,
showModel=true,
attach={
selectNumCmpArgs=selectNumCmpArgs,
tipsCommonUseItemCB=function(attach__)
if _this==nil then return end
if _this.selectShowCnt>=#_this.selectItem then
local contains=false
for i,v in pairs(self.selectShowData)do
if v.type==tabType and v.index==viewIndex then
contains=true
break
end
end
if not contains then
return UIManager.error("可选数量已达上限")
end
end
local selectNum=attach__.selectNumCmpArgs and attach__.selectNumCmpArgs.selectNum or 0
_this:onSelectViewItem(tabType,viewIndex,selectNum,sign)
end,
insertBtnList={TIPS_BTNS_TYPE.eCommonUseItem},
}
}
tipsManager.showTips(args)
end

function UIXingJiaoShangRenExchangeWin:onSelectViewItem(tabType,viewIndex,selectNum,sign)
local isItemType=tabType==1
local selectList=isItemType and self.selectItemData or self.selectBuildingData
local oldNum=selectList[viewIndex]or 0

if selectNum==0 then return end

local dataList=isItemType and self.itemDataList or self.buildingDataList
local viewData=dataList[viewIndex]
local dataId=isItemType and viewData.itemStruct.itemid or viewData.buildId

local colName=isItemType and"item_value"or"build_value"
local deltaNum=(sign and 1 or-1)*selectNum
local perScore=self.config[colName][dataId]
local deltaScore=deltaNum*perScore
selectList[viewIndex]=oldNum+deltaNum
self.selectScore=self.selectScore+deltaScore

local lookupKey=FMT.fmt("{0}_{1}",tabType,viewIndex)
local slotIdx=self.selectShowLookup[lookupKey]
if slotIdx then
local showData=self.selectShowData[slotIdx]
showData.count=showData.count+deltaNum
if showData.count<=0 then
self.selectShowData[slotIdx]=nil
self.selectShowLookup[lookupKey]=nil
self.selectShowCnt=self.selectShowCnt-1
end
self:refreshSelectItem(slotIdx)
elseif self.selectShowCnt<#self.selectItem then
for i=1,#self.selectItem do
local showData=self.selectShowData[i]
if showData==nil then
showData={
type=tabType,
id=dataId,
count=deltaNum,
index=viewIndex,
}
self.selectShowData[i]=showData
self.selectShowLookup[lookupKey]=i
self.selectShowCnt=self.selectShowCnt+1
self:refreshSelectItem(i)
break
end
end
end

if isItemType then
self:selectItemViewItem(viewIndex)
else
self:selectBuildingViewItem(viewIndex)
end
self:refreshConfirmGray()
self:speakWord0()
end


function UIXingJiaoShangRenExchangeWin:speakWord0()
local haveSelect=false
for i,v in pairs(self.selectItemData)do
if v>0 then
haveSelect=true
break
end
end

if not haveSelect then
for i,v in pairs(self.selectBuildingData)do
if v>0 then
haveSelect=true
break
end
end
end

if not haveSelect then
self:speakWord1()
return
end

local cPrecent=self.selectScore/self.targetScore*100
local strLib=self.config.speak0
local strs=nil
for i,v in ipairs(strLib)do
local tPrecent=v[1]
if cPrecent<tPrecent then
break
else
strs=v[2]
end
end
if strs then
local str=strs[math.random(1,#strs)]
self:speakWord(str)
end
end


function UIXingJiaoShangRenExchangeWin:speakWord3(index)
local strLib=self.config.speak3
local strs=strLib[index][2]
local str=strs[math.random(1,#strs)]
self:speakWord(str)
end


function UIXingJiaoShangRenExchangeWin:speakWord1()
local strLib=self.config.speak1
local str=strLib[math.random(1,#strLib)]
self:speakWord(str)
end


function UIXingJiaoShangRenExchangeWin:speakWord2()
local strLib=self.config.speak2
local str=strLib[math.random(1,#strLib)]
self:speakWord(str)
end


function UIXingJiaoShangRenExchangeWin:updateItemData(fliter)




self.itemDataList={}
local bagData=bagControl.getBagItems(BAG_TYPE.eItemBag)
for i,v in ipairs(bagData)do
local itemCfg=itemsConfig.getConfig(v.itemid)
if self.config.item_value[v.itemid]then
local key=tostring(v.itemguid)
if fliter==nil or fliter[key]==nil then
local color=itemCfg.color
local value=self.config.item_value[v.itemid]
local sortWeight=value and color or-1
table.insert(self.itemDataList,{itemStruct=v,count=v.itemcount,sortWeight=sortWeight})
else
local fliterCount=fliter[key]
if fliterCount<v.itemcount then
local color=itemCfg.color
local value=self.config.item_value[v.itemid]
local sortWeight=value and color or-1
table.insert(self.itemDataList,{itemStruct=v,count=v.itemcount-fliterCount,sortWeight=sortWeight})
end
end
end
end
if#self.itemDataList>1 then
table.sort(self.itemDataList,function(a,b)
return a.sortWeight>b.sortWeight
end)
end

self.iPageCnt=math.max(math.ceil(#self.itemDataList/_pageNum),1)
end

function UIXingJiaoShangRenExchangeWin:onItemEdgeEvent()
if self.iCurrPage>=self.iPageCnt then return end
self.iCurrPage=self.iCurrPage+1
self:refreshItemViewList(false)
end

function UIXingJiaoShangRenExchangeWin:resetItemViewList()
self.iCurrPage=1
self.itemView:clearSlowItems()
self:refreshItemViewList(true)
end

function UIXingJiaoShangRenExchangeWin:refreshItemViewList(notSetZero)
local showNum=self.iCurrPage*_pageNum
local showRow=showNum/_col
self.itemView:freshSlowGrids(showNum,showRow,_col,notSetZero)
end

function UIXingJiaoShangRenExchangeWin:bindItemGrid(index,item)
local itemData=self.itemDataList[index]
item:SetChildActive(0,itemData~=nil)
if itemData then
local itemStruct=itemData.itemStruct
local selectCount=self.selectItemData[index]or 0
local moreOne=itemData.count>1
local isFullSelect=selectCount>=itemData.count
local haveSelect=selectCount>0
local showCountBG=moreOne or haveSelect
local countStr=""
if haveSelect then
countStr=FMT.fmt("{0}/{1}",selectCount,itemData.count)
elseif moreOne then
countStr=tostring(itemData.count)
end
local value=self.config.item_value[itemStruct.itemid]
local haveScore=value~=nil
local grayValue=(not haveScore or isFullSelect)and 3 or 0
local conf={itemid=itemStruct.itemid,itemIndex=index,itemguid=itemStruct.itemguid,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true,gray=grayValue}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickItemViewItem(index)
end)
item:SetChildActive(1,not haveScore)
end
end

function UIXingJiaoShangRenExchangeWin:selectItemViewItem(index)
local item=self.itemView:getSlowItemByIndex(index-1)
local itemData=self.itemDataList[index]
if item and itemData then
local itemStruct=itemData.itemStruct
local selectCount=self.selectItemData[index]or 0
local moreOne=itemData.count>1
local isFullSelect=selectCount>=itemData.count
local haveSelect=selectCount>0
local showCountBG=moreOne or haveSelect
local value=self.config.item_value[itemStruct.itemid]
local haveScore=value~=nil
local gray=not haveScore or isFullSelect
local countStr=""
if haveSelect then
countStr=FMT.fmt("{0}/{1}",selectCount,itemData.count)
elseif moreOne then
countStr=tostring(itemData.count)
end
local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,3)]=countStr
prop[PropIndex(DataPropKey.eWidgetGray,0)]=gray
prop[PropIndex(DataPropKey.eWidgetGray,1)]=gray
prop[PropIndex(DataPropKey.eWidgetActive,7)]=gray
item:SetChildPropData(0,prop)
end
end

function UIXingJiaoShangRenExchangeWin:onClickItemViewItem(index)
local itemData=self.itemDataList[index]
if itemData then
local itemStruct=itemData.itemStruct
if self.winState<=0 then
tipsManager.showTips({itemid=itemStruct.itemid,showModel=true,})
return
end

local value=self.config.item_value[itemStruct.itemid]
if value then
local count=self.selectItemData[index]or 0
self:showSelectDataTips(1,index,itemStruct.itemid,1,itemData.count-count,true)
else
UIManager.error("商人不要这个图纸")
end
end
end



function UIXingJiaoShangRenExchangeWin:updateBuildingData(fliter1,fliter2)





self.buildingDataList={}

local lookup={}
local storageBuildings=zongmenModel:getAllstorageBuilding()
for i,v in pairs(storageBuildings)do
local value=self.config.build_value[v.build_id]
if value and(fliter1==nil or fliter1[v.un_build_id]==nil)then
if not lookup[v.build_id]then lookup[v.build_id]={}end
table.insert(lookup[v.build_id],{v.un_build_id,0})
end
end
for i,v in pairs(lookup)do
table.insert(self.buildingDataList,{buildId=i,buildGuids=v,flag=0})
end

lookup={}
storageBuildings=zongmenModel:getAllSkyStorageDatas()
for i,v in pairs(storageBuildings)do
local value=self.config.build_value[v.build_id]
if value then
if not lookup[v.build_id]then lookup[v.build_id]={}end
local sfId=zongmenModel:getSkyBuildingLocationMapId(v.un_build_id)
if fliter2==nil or fliter2[sfId]==nil or fliter2[sfId][v.un_build_id]==nil then
table.insert(lookup[v.build_id],{v.un_build_id,sfId})
end
end
end
for i,v in pairs(lookup)do
table.insert(self.buildingDataList,{buildId=i,buildGuids=v,flag=1})
end

self.bPageCnt=math.max(math.ceil(#self.buildingDataList/_pageNum),1)
end

function UIXingJiaoShangRenExchangeWin:onBuildingEdgeEvent()
if self.bCurrPage>=self.bPageCnt then return end
self.bCurrPage=self.bCurrPage+1
self:refreshBuildingViewList(false)
end

function UIXingJiaoShangRenExchangeWin:resetBuildingViewList()
self.bCurrPage=1
self.buildingView:clearSlowItems()
self:refreshBuildingViewList(true)
end

function UIXingJiaoShangRenExchangeWin:refreshBuildingViewList(notSetZero)
local showNum=self.bCurrPage*_pageNum
local showRow=showNum/_col
self.buildingView:freshSlowGrids(showNum,showRow,_col,notSetZero)
end

function UIXingJiaoShangRenExchangeWin:bindBuildingGrid(index,item)
local buildingData=self.buildingDataList[index]
if buildingData then
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildingData.buildId)
local itemId=zongmenBuildingSuitModel:findPartItemByBuilding(buildingData.buildId)
local itemCount=#buildingData.buildGuids
local selectCount=self.selectBuildingData[index]or 0
local isFullSelect=selectCount>=itemCount
local moreOne=itemCount>1
local haveSelect=selectCount>0
local showCountBG=moreOne or haveSelect
local countStr=""
if haveSelect then
countStr=FMT.fmt("{0}/{1}",selectCount,itemCount)
elseif moreOne then
countStr=tostring(itemCount)
end
local value=self.config.build_value[buildingData.buildId]
local haveScore=value~=nil
local gray=not haveScore or isFullSelect
item:SetChildActive(-1,true)
item:SetChildQulaity(0,itemsConfig.getItemColor(itemId))
item:SetChildImageExGray(0,gray)
item:SetChildCSImageIcon(1,buildCfg.icon,false)
item:SetChildImageExGray(1,gray)
item:SetChildButtonClick(-1,function()
self:onClickBuildingViewItem(index)
end)
item:SetChildActive(2,showCountBG)
item:SetChildText(3,countStr)
item:SetChildText(4,buildCfg.name)
item:SetChildActive(5,not haveScore)
item:SetChildActive(6,gray)
else
item:SetChildActive(-1,false)
item:SetChildActive(0,false)
item:SetChildActive(1,false)
item:SetChildActive(2,false)
item:SetChildText(3,"")
item:SetChildText(4,"")
item:SetChildActive(5,false)
item:SetChildActive(6,false)
end
end

function UIXingJiaoShangRenExchangeWin:selectBuildingViewItem(index)
local item=self.buildingView:getSlowItemByIndex(index-1)
local buildingData=self.buildingDataList[index]
if item and buildingData then
local itemCount=#buildingData.buildGuids
local selectCount=self.selectBuildingData[index]or 0
local isFullSelect=selectCount>=itemCount
local moreOne=itemCount>1
local haveSelect=selectCount>0
local value=self.config.build_value[buildingData.buildId]
local haveScore=value~=nil
local gray=not haveScore or isFullSelect
local showCountBG=moreOne or haveSelect
local countStr=""
if haveSelect then
countStr=FMT.fmt("{0}/{1}",selectCount,itemCount)
elseif moreOne then
countStr=tostring(itemCount)
end
item:SetChildActive(2,showCountBG)
item:SetChildText(3,countStr)
item:SetChildImageExGray(0,gray)
item:SetChildImageExGray(1,gray)
item:SetChildActive(6,gray)
end
end

function UIXingJiaoShangRenExchangeWin:onClickBuildingViewItem(index)
local buildingData=self.buildingDataList[index]
if buildingData then
local itemid=zongmenBuildingSuitModel:findPartItemByBuilding(buildingData.buildId)
if self.winState<=0 then
tipsManager.showTips({itemid=itemid,showModel=true,})
return
end

local value=self.config.build_value[buildingData.buildId]
if value then
local count=self.selectBuildingData[index]or 0
self:showSelectDataTips(2,index,itemid,1,#buildingData.buildGuids-count,true)
else
UIManager.error("商人不要这个建筑")
end
end
end


function UIXingJiaoShangRenExchangeWin:refreshTargetPanel()
self.targetData=self.info:getItemList()
local exchange=self.config.exchange
local itemCnt=#self.targetData
self.targetList:setChildLayoutGroupCreateItems(itemCnt,function(index)
local item=self.targetList:getChildLayoutGroupGridItem(index-1)
local itemId=self.targetData[index]
local count=self.info:getItemCount(itemId)
item:SetChildLongTouch(_targetItemCmp.root,index,1,function()
self:onLongTouchTargetItem(index)
end)
item:SetChildButtonClick(_targetItemCmp.root,function()
self:onClickTargetItem(index)
end)
item:SetChildActive(_targetItemCmp.select,self.targetSelect==index)
item:SetChildText(_targetItemCmp.numTx,FMT.fmt("{0}/{1}",count,exchange[itemId][1]))
item:SetChildCSImageIcon(_targetItemCmp.icon,iconHelper.getIconName(itemId),false)
item:SetChildShowEffect(_targetItemCmp.effect,-1,false)
end)
self.targetPanel:setChildScrollRectEnable(itemCnt>4)
end

function UIXingJiaoShangRenExchangeWin:refreshTargetNum(itemId)
local itemList=self.targetData
if itemId then
local index=table.findValue(itemList,itemId)
local item=self.targetList:getChildLayoutGroupGridItem(index-1)
local count=self.info:getItemCount(itemId)
local exchange=self.config.exchange
local exchangeCnt=exchange[itemId][1]
item:SetChildText(_targetItemCmp.numTx,FMT.fmt("{0}/{1}",count,exchangeCnt))



else
local items=self.targetList:getChildLayoutGroupGridList()
local exchange=self.config.exchange
for index=1,items.Count do
local item=items[index-1]
local itemId=itemList[index]
local count=self.info:getItemCount(itemId)
local exchangeCnt=exchange[itemId][1]
item:SetChildText(_targetItemCmp.numTx,FMT.fmt("{0}/{1}",count,exchangeCnt))



end
end
end

function UIXingJiaoShangRenExchangeWin:onLongTouchTargetItem(index)
local itemList=self.targetData
local itemId=itemList[index]
tipsManager.showTips({itemid=itemId})
end

function UIXingJiaoShangRenExchangeWin:onClickTargetItem(index)
if self.targetSelect~=index then
if index then
local itemList=self.targetData
local itemId=itemList[index]
local count=self.info:getItemCount(itemId)
local exchange=self.config.exchange
local exchangeCnt=exchange[itemId][1]

if count>=exchangeCnt then
UIManager.info("已交易完成")
return
end
end

if self.targetSelect then
local item=self.targetList:getChildLayoutGroupGridItem(self.targetSelect-1)
item:SetChildActive(_targetItemCmp.select,false)
end

self.targetSelect=index
self.targetCount=nil

if index then
local item=self.targetList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_targetItemCmp.select,true)
end

self.selectBtn:setActive(self.targetSelect~=nil)
self.selectNone:setActive(self.targetSelect==nil)
if self.targetSelect then
local itemList=self.targetData
local itemId=itemList[self.targetSelect]
local itemName=itemsConfig.getItemName(itemId)
self.selectTx:setText(FMT.fmt("是否选择兑换【{0}】",itemName))
end
end
end

function UIXingJiaoShangRenExchangeWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='xingjiaoshangren_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXingJiaoShangRenExchangeWin.on_247_61(actId,subId,len,list)
local subType=SUB_ACTIVITY_TYPE.eXingJiaoShangRen
if _this.info:compare(actId,subType,subId)then

_this:refreshTargetPanel()
_this:showView()
end
end

function UIXingJiaoShangRenExchangeWin.on_247_62(args)
local subType=SUB_ACTIVITY_TYPE.eXingJiaoShangRen
local actId=args[1]
local subId=args[2]
if _this.info:compare(actId,subType,subId)then
local itemId=args[3]
local itemLen=args[5]
local itemList=args[6]
local buildingLen=args[7]
local buildingList=args[8]
local skyLen=args[9]
local skyList=args[10]
local speadIdx=args[11]
local itemFliter=nil
if itemLen>0 then
itemFliter={}
for i,itemData in ipairs(itemList)do
itemFliter[tostring(itemData.param_1)]=itemData.param_2
end
end
local buildFliter=nil
if buildingLen>0 then
buildFliter={}
for i,un_build_id in ipairs(buildingList)do
buildFliter[un_build_id]=i
end
end
local skyFliter=nil
if skyLen>0 then
skyFliter={}
for i,sfBuild in ipairs(skyList)do
local temp={}
for j=1,sfBuild.len do
local un_build_id=sfBuild.buildList[j]
temp[un_build_id]=j
end
skyFliter[sfBuild.sf_id]=temp
end
end
_this:resetSelectData()
_this:updateItemData(itemFliter)
_this:updateBuildingData(buildFliter,skyFliter)
_this:refreshSelectView()
_this:resetItemViewList()
_this:resetBuildingViewList()
_this:refreshConfirmGray()
_this:speakWord3(speadIdx)

if _this.info:checkFinish()then
_this:setFinishState()
else
if _this.info:getItemSortDirty()then
_this:refreshTargetPanel()

_this:onClickTargetItem(nil)
_this:setTargetState()
_this:autoClickTargetItem()
else
_this:refreshTargetNum(itemId)

local itemList=_this.targetData
local targetId=itemList[_this.targetSelect]
if targetId==itemId then
_this:onClickTargetItem(nil)
_this:setTargetState()
_this:autoClickTargetItem()
end
end
end
end
end

function UIXingJiaoShangRenExchangeWin.onSubActivityStateChange(actId,subType,subId,state)
if _this.info:compare(actId,subType,subId)and state~=activitiesModel.activityDoingState then
_this:onCloseBtn()
UIManager.info("商人已离开")
end
end

function UIXingJiaoShangRenExchangeWin.onActivityStateChange(actId,state)
if state~=activitiesModel.activityDoingState and _this.actId==actId then
_this:onCloseBtn()
UIManager.info("商人已离开")
end
end

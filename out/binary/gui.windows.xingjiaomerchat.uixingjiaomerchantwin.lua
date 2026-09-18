







def_class("UIXingJiaoMerchantWin",UIWindowBase)









function UIXingJiaoMerchantWin:bindComponents()

self.background=UIButton.get(self,0)
self.confirmBtn=UIButton.get(self,1)
self.buildingView=UIScrollViewSlow.get(self,2)
self.itemView=UIScrollViewSlow.get(self,3)
self.buildingTab=UIButton.get(self,4)
self.itemTab=UIButton.get(self,5)
self.selectMask=UIObject.get(self,6)
self.leaveBtn=UIButton.get(self,7)
self.closeBtn=UIButton.get(self,8)
self.model=UIObject.get(self,9)
self.talkRoot=UIObject.get(self,10)
self.rewardBtn=UIButton.get(self,11)
self.buildingTabSelect=UIObject.get(self,12)
self.itemTabSelect=UIObject.get(self,13)
self.rewardGetted=UIObject.get(self,14)
self.rewardEffect=UIObject.get(self,15)
self.rewardIcon=UIImage.get(self,16)
self.selectItem_10=UIObject.get(self,17)
self.selectItem_9=UIObject.get(self,18)
self.selectItem_7=UIObject.get(self,19)
self.selectItem_6=UIObject.get(self,20)
self.selectItem_4=UIObject.get(self,21)
self.selectItem_3=UIObject.get(self,22)
self.selectItem_2=UIObject.get(self,23)
self.selectItem_1=UIObject.get(self,24)
self.selectItem_8=UIObject.get(self,25)
self.selectItem_5=UIObject.get(self,26)
self.talkTx=UIText.get(self,27)

self.background:setButtonClick(function()self:onBackground()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.buildingTab:setButtonClick(function()self:onBuildingTab()end)

self.itemTab:setButtonClick(function()self:onItemTab()end)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)
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


function UIXingJiaoMerchantWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.buildingView);self.buildingView=nil;
_UIObject_release(self.itemView);self.itemView=nil;
_UIObject_release(self.buildingTab);self.buildingTab=nil;
_UIObject_release(self.itemTab);self.itemTab=nil;
_UIObject_release(self.selectMask);self.selectMask=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.talkRoot);self.talkRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.buildingTabSelect);self.buildingTabSelect=nil;
_UIObject_release(self.itemTabSelect);self.itemTabSelect=nil;
_UIObject_release(self.rewardGetted);self.rewardGetted=nil;
_UIObject_release(self.rewardEffect);self.rewardEffect=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.selectItem_10);self.selectItem_10=nil;
_UIObject_release(self.selectItem_9);self.selectItem_9=nil;
_UIObject_release(self.selectItem_7);self.selectItem_7=nil;
_UIObject_release(self.selectItem_6);self.selectItem_6=nil;
_UIObject_release(self.selectItem_4);self.selectItem_4=nil;
_UIObject_release(self.selectItem_3);self.selectItem_3=nil;
_UIObject_release(self.selectItem_2);self.selectItem_2=nil;
_UIObject_release(self.selectItem_1);self.selectItem_1=nil;
_UIObject_release(self.selectItem_8);self.selectItem_8=nil;
_UIObject_release(self.selectItem_5);self.selectItem_5=nil;
_UIObject_release(self.talkTx);self.talkTx=nil;
self.selectItem=nil;
end















local _this=nil
local _selectItemCmp={
item=0,
buildingIcon=1,
deleteFlag=2,
countBg=3,
txt_count=4,
bg=5,
}
local _col=5
local _row=6
local _pageNum=_col*_row



function UIXingJiaoMerchantWin:onLoaded(...)
self:bindComponents()
_this=self

self:initModel()
self:initSelectView()
self:resetSelectData()

self.isFinished=false

self:updateItemData()
self:updateBuildingData()

self.itemView:bindSlowWidget(function(...)self:bindItemGrid(...)end)
self.buildingView:bindSlowWidget(function(...)self:bindBuildingGrid(...)end)

self:resetItemViewList()
self:resetBuildingViewList()
end


function UIXingJiaoMerchantWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXingJiaoMerchantWin:onShow(argtable,afterOnloaded)
self:refreshSelectView()
self:onItemTab()

local strLib=cfgHelper.get2(cfg_business1config_get,1,"speak1")
local str=strLib[math.random(1,#strLib)]
self:speakWord(str)
end


function UIXingJiaoMerchantWin:onHide()

end




function UIXingJiaoMerchantWin:onLeaveBtn()
if not self.isFinished then
UIDialogManager.getCommonDialog(nil,"送客后商人将离开宗门，本次礼包无法兑换，是否送客？",function()
xingjiaoMerchantController:send_33_7()
end)
end
end



function UIXingJiaoMerchantWin:onBackground()
self:onCloseBtn()
end



function UIXingJiaoMerchantWin:onBuildingTab()
if not self.tabSelect then return end
self.itemTabSelect:setActive(false)
self.buildingTabSelect:setActive(true)
self.itemView:setScale(Vector3.up)
self.buildingView:setScale(Vector3.one)
self.tabSelect=false
end



function UIXingJiaoMerchantWin:onItemTab()
if self.tabSelect then return end
self.itemTabSelect:setActive(true)
self.buildingTabSelect:setActive(false)
self.itemView:setScale(Vector3.one)
self.buildingView:setScale(Vector3.up)
self.tabSelect=true
end



function UIXingJiaoMerchantWin:onConfirmBtn()
if self.isFinished then return end
if self.selectShowCnt<=0 then return UIManager.info("请先选择交易物品")end

if self.selectScore>=self.targetScore then
local itemList={}
local nBuildList={}
local sBuildLookup={}
local sBuildList={}
for listIndex,count in pairs(self.selectItemData)do
local itemData=self.itemDataList[listIndex].itemStruct
table.insert(itemList,{itemData.itemguid,count})
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
table.insert(sBuildList,{sfId,#ubdIdList,ubdIdList})
end
xingjiaoMerchantController:send_33_6(itemList,nBuildList,sBuildList)





end
end



function UIXingJiaoMerchantWin:onCloseBtn()
UIFullXingJiaoMerchantControl:closeUI(true,true)
end



function UIXingJiaoMerchantWin:onRewardBtn()
local args={itemid=self.targetItem[1],showModel=true}
tipsManager.showTips(args)
end

function UIXingJiaoMerchantWin:resetSelectData()







self.selectShowData={}

self.selectShowLookup={}

self.selectShowCnt=0

self.selectScore=0

self.selectItemData={}

self.selectBuildingData={}
end

function UIXingJiaoMerchantWin:initSelectView()
for i,v in ipairs(self.selectItem)do
local widget=v:getChildWidgetBase()



widget:SetChildButtonClick(_selectItemCmp.bg,function()
self:onSelectItemClick(i)
end)
end
end

function UIXingJiaoMerchantWin:initModel()
self.targetItem=xingjiaoMerchantModel:getData()
self.targetBuild=zongmenBuildingSuitModel:findPartBuildingByItem(self.targetItem[1])
self.targetScore=cfgHelper.get2(cfg_business1itemconfig_get,self.targetItem[1],"exchange_score")
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.targetBuild)
self.rewardIcon:setImageIcon(buildCfg.icon,true)

local modelParams=cfgHelper.get2(cfg_business1config_get,1,"image")
self.model:setChildUIModelShowTarget(modelParams[1],modelParams[3],modelParams[2],eAnimationID.stand,false,false,0)
end

function UIXingJiaoMerchantWin:refreshSelectView()
self.selectMask:setActive(self.isFinished)
self.confirmBtn:setActive(not self.isFinished)
self.rewardEffect:setActive(not self.isFinished)
self.rewardGetted:setActive(self.isFinished)
self.leaveBtn:setActive(not self.isFinished)

for i,v in ipairs(self.selectItem)do
self:refreshSelectItem(i)
end
end

function UIXingJiaoMerchantWin:refreshSelectItem(index)
local selectData=self.selectShowData[index]
local widget=self.selectItem[index]:getChildWidgetBase()
if selectData then
local dataType=selectData.type
local dataId=selectData.id
local dataCnt=selectData.count
local moreOne=dataCnt>0
widget:SetChildActive(_selectItemCmp.item,dataType==1)
widget:SetChildActive(_selectItemCmp.buildingIcon,dataType==2)

widget:SetChildActive(_selectItemCmp.countBg,moreOne)
widget:SetChildText(_selectItemCmp.txt_count,moreOne and dataCnt or"")
if dataType==1 then
local conf={itemid=dataId,itemcount="",showCountBG=false,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(_selectItemCmp.item,prop)
elseif dataType==2 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,dataId)
widget:SetChildIcon(_selectItemCmp.buildingIcon,cfg.icon,false)
end
else
widget:SetChildActive(_selectItemCmp.item,false)
widget:SetChildActive(_selectItemCmp.buildingIcon,false)
widget:SetChildActive(_selectItemCmp.deleteFlag,false)
widget:SetChildActive(_selectItemCmp.countBg,false)
widget:SetChildText(_selectItemCmp.txt_count,"")
end
end















function UIXingJiaoMerchantWin:onSelectItemClick(index)
local selectData=self.selectShowData[index]
if selectData then
local itemId=selectData.type==1 and selectData.id or zongmenBuildingSuitModel:findPartItemByBuilding(selectData.id)

self:showSelectDataTips(selectData.type,selectData.index,itemId,1,selectData.count,false)
end
end

function UIXingJiaoMerchantWin:showSelectDataTips(tabType,viewIndex,itemid,num,count,sign)
if num>count then return end
local selectNumCmpArgs={numFormat='选择：<color=#f1ce78>{0}/{1}</color>',min=1,val=num,max=count,isOverZero=true}
local args={
itemid=itemid,
showModel=true,
attach={
selectNumCmpArgs=selectNumCmpArgs,
tipsCommonUseItemCB=function(attach__)
if _this==nil then return end
if _this.selectShowCnt>=#_this.selectItem then return UIManager.error("可选数量已达上限")end
local selectNum=attach__.selectNumCmpArgs and attach__.selectNumCmpArgs.selectNum or 0
_this:onSelectViewItem(tabType,viewIndex,selectNum,sign)
end,
insertBtnList={TIPS_BTNS_TYPE.eCommonUseItem},
}
}
tipsManager.showTips(args)
end

function UIXingJiaoMerchantWin:onSelectViewItem(tabType,viewIndex,selectNum,sign)
local isItemType=tabType==1
local selectList=isItemType and self.selectItemData or self.selectBuildingData
local oldNum=selectList[viewIndex]or 0

if selectNum==0 then return end

local dataList=isItemType and self.itemDataList or self.buildingDataList
local viewData=dataList[viewIndex]
local dataId=isItemType and viewData.itemStruct.itemid or viewData.buildId

local getter=isItemType and cfg_business1itemconfig_get or cfg_business1buildconfig_get
local deltaNum=(sign and 1 or-1)*selectNum
local perScore=cfgHelper.get2(getter,dataId,"score")
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

local cPrecent=self.selectScore/self.targetScore*100
local strLib=cfgHelper.get2(cfg_business1config_get,1,"speak0")
local strs=nil
for i,v in ipairs(strLib)do
local tPrecent=v[1]
strs=v[2]
if cPrecent<tPrecent then
break
end
end
local str=strs[math.random(1,#strs)]
self:speakWord(str)
end

function UIXingJiaoMerchantWin:speakWord(str,callback)
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

function UIXingJiaoMerchantWin:afterBuy()
self.isFinished=true

self.selectMask:setActive(true)
self.confirmBtn:setActive(false)
self.rewardEffect:setActive(false)
self.rewardGetted:setActive(true)
self.leaveBtn:setActive(false)





local cPrecent=self.selectScore/self.targetScore*100
local strLib=cfgHelper.get2(cfg_business1config_get,1,"speak3")
local strs=nil
for i,v in ipairs(strLib)do
local tPrecent=v[1]
strs=v[2]
if cPrecent<tPrecent then
break
end
end
local str=strs[math.random(1,#strs)]


self:speakWord(str,function()
if _this then
_this:onCloseBtn()
end
end)
end

function UIXingJiaoMerchantWin:afterLeave()
self.isFinished=true

self.selectMask:setActive(true)
self.confirmBtn:setActive(false)
self.rewardEffect:setActive(false)
self.rewardGetted:setActive(false)
self.leaveBtn:setActive(false)

local strLib=cfgHelper.get2(cfg_business1config_get,1,"speak2")
local str=strLib[math.random(1,#strLib)]
self:speakWord(str,function()
if _this then
_this:onCloseBtn()
end
end)
end


function UIXingJiaoMerchantWin:updateItemData()




self.itemDataList={}
local bagData=bagControl.getBagItems(BAG_TYPE.eItemBag)
for i,v in ipairs(bagData)do
local itemCfg=itemsConfig.getConfig(v.itemid)
if itemCfg.type1==itemtype1Type.eSystem then
local color=itemCfg.color
local scoreCfg=cfgHelper.get2(cfg_business1itemconfig_get,v.itemid)
local sortWeight=scoreCfg and color or-1
table.insert(self.itemDataList,{itemStruct=v,sortWeight=sortWeight})
end
end
if#self.itemDataList>1 then
table.sort(self.itemDataList,function(a,b)
return a.sortWeight>b.sortWeight
end)
end

self.iPageCnt=math.max(math.ceil(#self.itemDataList/_pageNum),1)
end

function UIXingJiaoMerchantWin:onItemEdgeEvent()
if self.iCurrPage>=self.iPageCnt then return end
self.iCurrPage=self.iCurrPage+1
self:refreshItemViewList(false)
end

function UIXingJiaoMerchantWin:resetItemViewList()
self.iCurrPage=1
self.itemView:clearSlowItems()
self:refreshItemViewList(true)
end

function UIXingJiaoMerchantWin:refreshItemViewList(notSetZero)
local showNum=self.iCurrPage*_pageNum
local showRow=showNum/_col
self.itemView:freshSlowGrids(showNum,showRow,_col,notSetZero)
end

function UIXingJiaoMerchantWin:bindItemGrid(index,item)
local itemData=self.itemDataList[index]
item:SetChildActive(0,itemData~=nil)
if itemData then
itemData=itemData.itemStruct
local selectCount=self.selectItemData[index]or 0
local moreOne=itemData.itemcount>1
local isFullSelect=selectCount>=itemData.itemcount
local haveSelect=selectCount>0
local showCountBG=moreOne or haveSelect
local countStr=""
if haveSelect then
countStr=FMT.fmt("{0}/{1}",selectCount,itemData.itemcount)
elseif moreOne then
countStr=tostring(itemData.itemcount)
end
local scoreCfg=cfgHelper.get1(cfg_business1itemconfig_get,itemData.itemid)
local haveScore=scoreCfg~=nil and scoreCfg.score~=nil
local grayValue=(not haveScore or isFullSelect)and 3 or 0
local conf={itemid=itemData.itemid,itemIndex=index,itemguid=itemData.itemguid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,gray=grayValue}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickItemViewItem(index)
end)
item:SetChildActive(1,not haveScore)
end
end

function UIXingJiaoMerchantWin:selectItemViewItem(index)
local item=self.itemView:getSlowItemByIndex(index-1)
local itemData=self.itemDataList[index]
if item and itemData then
itemData=itemData.itemStruct
local selectCount=self.selectItemData[index]or 0
local moreOne=itemData.itemcount>1
local isFullSelect=selectCount>=itemData.itemcount
local haveSelect=selectCount>0
local showCountBG=moreOne or haveSelect
local scoreCfg=cfgHelper.get1(cfg_business1itemconfig_get,itemData.itemid)
local haveScore=scoreCfg~=nil and scoreCfg.score~=nil
local gray=not haveScore or isFullSelect
local countStr=""
if haveSelect then
countStr=FMT.fmt("{0}/{1}",selectCount,itemData.itemcount)
elseif moreOne then
countStr=tostring(itemData.itemcount)
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

function UIXingJiaoMerchantWin:onClickItemViewItem(index)
if self.isFinished then return end
local itemData=self.itemDataList[index]
if itemData then
itemData=itemData.itemStruct
local scoreCfg=cfgHelper.get1(cfg_business1itemconfig_get,itemData.itemid)
if scoreCfg then
local value=self.selectItemData[index]or 0
self:showSelectDataTips(1,index,itemData.itemid,1,itemData.itemcount-value,true)
else
UIManager.error("商人不要这个图纸")
end
end
end



function UIXingJiaoMerchantWin:updateBuildingData()





self.buildingDataList={}

local lookup={}
local storageBuildings=zongmenModel:getAllstorageBuilding()
for i,v in pairs(storageBuildings)do
if not lookup[v.build_id]then lookup[v.build_id]={}end
local cfg=cfgHelper.get1(cfg_business1buildconfig_get,v.build_id)
if cfg and cfg.show then
table.insert(lookup[v.build_id],{v.un_build_id,0})
end
end
for i,v in pairs(lookup)do

table.insert(self.buildingDataList,{buildId=i,buildGuids=v,flag=0})
end

lookup={}
storageBuildings=zongmenModel:getAllSkyStorageDatas()
for i,v in pairs(storageBuildings)do
if not lookup[v.build_id]then lookup[v.build_id]={}end
local cfg=cfgHelper.get1(cfg_business1buildconfig_get,v.build_id)
if cfg and cfg.show then
table.insert(lookup[v.build_id],{v.un_build_id,v.sfId})
end
end
for i,v in pairs(lookup)do
table.insert(self.buildingDataList,{buildId=i,buildGuids=v,flag=1})
end

self.bPageCnt=math.max(math.ceil(#self.buildingDataList/_pageNum),1)
end

function UIXingJiaoMerchantWin:onBuildingEdgeEvent()
if self.bCurrPage>=self.bPageCnt then return end
self.bCurrPage=self.bCurrPage+1
self:refreshBuildingViewList(false)
end

function UIXingJiaoMerchantWin:resetBuildingViewList()
self.bCurrPage=1
self.buildingView:clearSlowItems()
self:refreshBuildingViewList(true)
end

function UIXingJiaoMerchantWin:refreshBuildingViewList(notSetZero)
local showNum=self.bCurrPage*_pageNum
local showRow=showNum/_col
self.buildingView:freshSlowGrids(showNum,showRow,_col,notSetZero)
end

function UIXingJiaoMerchantWin:bindBuildingGrid(index,item)
local buildingData=self.buildingDataList[index]
if buildingData then
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildingData.buildId)
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
local scoreCfg=cfgHelper.get1(cfg_business1buildconfig_get,buildingData.buildId)
local haveScore=scoreCfg~=nil and scoreCfg.score~=nil
local gray=not haveScore or isFullSelect
item:SetChildActive(0,true)
item:SetChildIcon(0,buildCfg.icon,false)
item:SetChildImageExGray(0,gray)
item:SetChildButtonClick(0,function()
self:onClickBuildingViewItem(index)
end)
item:SetChildActive(1,showCountBG)
item:SetChildText(2,countStr)
item:SetChildActive(3,not haveScore)
else
item:SetChildActive(0,false)
item:SetChildActive(1,false)
item:SetChildText(2,"")
item:SetChildActive(3,false)
end
end

function UIXingJiaoMerchantWin:selectBuildingViewItem(index)
local item=self.buildingView:getSlowItemByIndex(index-1)
local buildingData=self.buildingDataList[index]
if item and buildingData then
local itemCount=#buildingData.buildGuids
local selectCount=self.selectBuildingData[index]or 0
local isFullSelect=selectCount>=itemCount
local moreOne=itemCount>1
local haveSelect=selectCount>0
local scoreCfg=cfgHelper.get1(cfg_business1buildconfig_get,buildingData.buildId)
local haveScore=scoreCfg~=nil and scoreCfg.score~=nil
local gray=not haveScore or isFullSelect
local showCountBG=moreOne or haveSelect
local countStr=""
if haveSelect then
countStr=FMT.fmt("{0}/{1}",selectCount,itemCount)
elseif moreOne then
countStr=tostring(itemCount)
end
item:SetChildActive(1,showCountBG)
item:SetChildText(2,countStr)
item:SetChildImageExGray(0,gray)
end
end

function UIXingJiaoMerchantWin:onClickBuildingViewItem(index)
if self.isFinished then return end
local buildingData=self.buildingDataList[index]
if buildingData then
local scoreCfg=cfgHelper.get1(cfg_business1buildconfig_get,buildingData.buildId)
if scoreCfg and scoreCfg.score then
local value=self.selectBuildingData[index]or 0
local itemid=zongmenBuildingSuitModel:findPartItemByBuilding(buildingData.buildId)
self:showSelectDataTips(2,index,itemid,1,#buildingData.buildGuids-value,true)
else
UIManager.error("商人不要这个建筑")
end
end
end
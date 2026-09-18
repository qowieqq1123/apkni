







def_class("CatEntrustItem",UICloneObject)





CatEntrustItem.abName="ui/windows/catentrust/child/catentrustitem.ab"

CatEntrustItem.assetName="CatEntrustItem"


function CatEntrustItem:bindComponents()

self.addBtn=UIButton.get(self,0)
self.autoSelectCatBtn=UIButton.get(self,1)
self.catInfoPart=UIImage.get(self,2)
self.catTxItem_1=UIBaseItem.get(self,3)
self.catTxItem_2=UIBaseItem.get(self,4)
self.catTxList=UIObject.get(self,5)
self.changeWTTypeBtn=UIButton.get(self,6)
self.clickHead=UIButton.get(self,7)
self.cntInfoText=UIText.get(self,8)
self.conditionList=UIObject.get(self,9)
self.conditionTili=UIObject.get(self,10)
self.conditionWt=UIObject.get(self,11)
self.countSelectPart=UIObject.get(self,12)
self.DECatHead=UIObject.get(self,13)
self.DEcatInfoPart=UIImage.get(self,14)
self.DECatTxItem_1=UIBaseItem.get(self,15)
self.DECatTxItem_2=UIBaseItem.get(self,16)
self.DECatTxList=UIObject.get(self,17)
self.delBtn=UIButton.get(self,18)
self.DENoTxTip=UIText.get(self,19)
self.DEPart=UIObject.get(self,20)
self.DERewardInfo=UIText.get(self,21)
self.DeRewardUpImg=UIObject.get(self,22)
self.doingPart=UIObject.get(self,23)
self.doingWTInfo=UIText.get(self,24)
self.endPart=UIObject.get(self,25)
self.finishTip=UIObject.get(self,26)
self.freshBtn=UIButton.get(self,27)
self.handleImg=UIObject.get(self,28)
self.handleImg2=UIObject.get(self,29)
self.icon=UIImage.get(self,30)
self.infobg=UIObject.get(self,31)
self.infoEx=UIObject.get(self,32)
self.lockimg=UIObject.get(self,33)
self.lockPart=UIObject.get(self,34)
self.locktip=UIText.get(self,35)
self.mainPart=UIObject.get(self,36)
self.maxText=UIText.get(self,37)
self.mijing=UIObject.get(self,38)
self.noTxTip=UIText.get(self,39)
self.prepareCatHead=UIObject.get(self,40)
self.preparePart=UIObject.get(self,41)
self.preSelectCatPart=UIObject.get(self,42)
self.restoreTiliSpine=UIObject.get(self,43)
self.rewardInfo=UIText.get(self,44)
self.rewardUpImg=UIObject.get(self,45)
self.selectCatBtn=UIButton.get(self,46)
self.selectCntSlider=UIObject.get(self,47)
self.selectCntTxt=UIText.get(self,48)
self.selectEntrustBtn=UIButton.get(self,49)
self.selectZmBtn=UIButton.get(self,50)
self.sliderRect=UIObject.get(self,51)
self.sliderRoot=UIObject.get(self,52)
self.standimg=UIObject.get(self,53)
self.standPart=UIObject.get(self,54)
self.standtip=UIText.get(self,55)
self.subBtn=UIButton.get(self,56)
self.tayin=UIObject.get(self,57)
self.tiliicon=UIObject.get(self,58)
self.tiliInfo=UIText.get(self,59)
self.title=UIText.get(self,60)
self.unlockBtn=UIButton.get(self,61)
self.unlockBtnTxt=UILinkImageText.get(self,62)
self.wtConditionIcon=UIObject.get(self,63)
self.wtConditionInfo=UIText.get(self,64)
self.yiyuhuiyou=UIObject.get(self,65)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.autoSelectCatBtn:setButtonClick(function()self:onAutoSelectCatBtn()end)

self.changeWTTypeBtn:setButtonClick(function()self:onChangeWTTypeBtn()end)

self.clickHead:setButtonClick(function()self:onClickHead()end)

self.delBtn:setButtonClick(function()self:onDelBtn()end)

self.freshBtn:setButtonClick(function()self:onFreshBtn()end)

self.selectCatBtn:setButtonClick(function()self:onSelectCatBtn()end)

self.selectEntrustBtn:setButtonClick(function()self:onSelectEntrustBtn()end)

self.selectZmBtn:setButtonClick(function()self:onSelectZmBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.unlockBtn:setButtonClick(function()self:onUnlockBtn()end)
self.catTxItem={
self.catTxItem_1,
self.catTxItem_2,
}
self.DECatTxItem={
self.DECatTxItem_1,
self.DECatTxItem_2,
}

end


function CatEntrustItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.autoSelectCatBtn);self.autoSelectCatBtn=nil;
_UIObject_release(self.catInfoPart);self.catInfoPart=nil;
_UIObject_release(self.catTxItem_1);self.catTxItem_1=nil;
_UIObject_release(self.catTxItem_2);self.catTxItem_2=nil;
_UIObject_release(self.catTxList);self.catTxList=nil;
_UIObject_release(self.changeWTTypeBtn);self.changeWTTypeBtn=nil;
_UIObject_release(self.clickHead);self.clickHead=nil;
_UIObject_release(self.cntInfoText);self.cntInfoText=nil;
_UIObject_release(self.conditionList);self.conditionList=nil;
_UIObject_release(self.conditionTili);self.conditionTili=nil;
_UIObject_release(self.conditionWt);self.conditionWt=nil;
_UIObject_release(self.countSelectPart);self.countSelectPart=nil;
_UIObject_release(self.DECatHead);self.DECatHead=nil;
_UIObject_release(self.DEcatInfoPart);self.DEcatInfoPart=nil;
_UIObject_release(self.DECatTxItem_1);self.DECatTxItem_1=nil;
_UIObject_release(self.DECatTxItem_2);self.DECatTxItem_2=nil;
_UIObject_release(self.DECatTxList);self.DECatTxList=nil;
_UIObject_release(self.delBtn);self.delBtn=nil;
_UIObject_release(self.DENoTxTip);self.DENoTxTip=nil;
_UIObject_release(self.DEPart);self.DEPart=nil;
_UIObject_release(self.DERewardInfo);self.DERewardInfo=nil;
_UIObject_release(self.DeRewardUpImg);self.DeRewardUpImg=nil;
_UIObject_release(self.doingPart);self.doingPart=nil;
_UIObject_release(self.doingWTInfo);self.doingWTInfo=nil;
_UIObject_release(self.endPart);self.endPart=nil;
_UIObject_release(self.finishTip);self.finishTip=nil;
_UIObject_release(self.freshBtn);self.freshBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImg2);self.handleImg2=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.infobg);self.infobg=nil;
_UIObject_release(self.infoEx);self.infoEx=nil;
_UIObject_release(self.lockimg);self.lockimg=nil;
_UIObject_release(self.lockPart);self.lockPart=nil;
_UIObject_release(self.locktip);self.locktip=nil;
_UIObject_release(self.mainPart);self.mainPart=nil;
_UIObject_release(self.maxText);self.maxText=nil;
_UIObject_release(self.mijing);self.mijing=nil;
_UIObject_release(self.noTxTip);self.noTxTip=nil;
_UIObject_release(self.prepareCatHead);self.prepareCatHead=nil;
_UIObject_release(self.preparePart);self.preparePart=nil;
_UIObject_release(self.preSelectCatPart);self.preSelectCatPart=nil;
_UIObject_release(self.restoreTiliSpine);self.restoreTiliSpine=nil;
_UIObject_release(self.rewardInfo);self.rewardInfo=nil;
_UIObject_release(self.rewardUpImg);self.rewardUpImg=nil;
_UIObject_release(self.selectCatBtn);self.selectCatBtn=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntTxt);self.selectCntTxt=nil;
_UIObject_release(self.selectEntrustBtn);self.selectEntrustBtn=nil;
_UIObject_release(self.selectZmBtn);self.selectZmBtn=nil;
_UIObject_release(self.sliderRect);self.sliderRect=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.standimg);self.standimg=nil;
_UIObject_release(self.standPart);self.standPart=nil;
_UIObject_release(self.standtip);self.standtip=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.tayin);self.tayin=nil;
_UIObject_release(self.tiliicon);self.tiliicon=nil;
_UIObject_release(self.tiliInfo);self.tiliInfo=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.unlockBtn);self.unlockBtn=nil;
_UIObject_release(self.unlockBtnTxt);self.unlockBtnTxt=nil;
_UIObject_release(self.wtConditionIcon);self.wtConditionIcon=nil;
_UIObject_release(self.wtConditionInfo);self.wtConditionInfo=nil;
_UIObject_release(self.yiyuhuiyou);self.yiyuhuiyou=nil;
self.catTxItem=nil;
self.DECatTxItem=nil;
end






local _txMaxNum=2
local _ab='ui/windows/catentrust/catentrust_atlas_pak.ab'




function CatEntrustItem:onLoaded(...)
self:bindComponents()

self.selectCnt=1
self.isFirstInitSlider=true
end


function CatEntrustItem:__delete()
self:unbindComponents()
end




function CatEntrustItem:onShow(argtable,afterOnloaded)
self.index=argtable.index
self.wtInfo=argtable.wtInfo

self.type=self.wtInfo.data.entrustType
self.funcs=catEntrustConfig.getEntrustFuncObj(self.type)

local isShowLockPart=self.wtInfo.state==Cat_Entrust_State_Type.Lock
local isShowStandPart=self.wtInfo.state==Cat_Entrust_State_Type.Stand
local isShowMainPart=self.wtInfo.state>Cat_Entrust_State_Type.Stand

self.lockPart:setActive(isShowLockPart)
self.standPart:setActive(isShowStandPart)
self.mainPart:setActive(isShowMainPart)

self.restoreTiliSpine:setChildCanvasGroupAlpha(0)

if isShowLockPart then
local unlockTip,btnTxt=catEntrustConfig.getUnlockEntrustSlotTip(self.wtInfo.unlockCost)
self.locktip:setText(unlockTip)
self.unlockBtnTxt:setText(btnTxt)
end

if isShowMainPart then
self:freshMainPart()
end
end


function CatEntrustItem:onHide()

end



function CatEntrustItem:freshMainPart()
local data=self.wtInfo.data
local exclusiveData=self.wtInfo.data.exclusiveData
local enstrustFuncObj=self.funcs

local catData
local limitTxList
if data.dispatchCatGuid>0 then
catData=wanBaoXunBaoDuiModel:getCatData(data.dispatchCatGuid)
limitTxList={}
local show_limit_tx_list=catEntrustConfig.getBaseInfo('show_limit_tx_list')
if catData.texing_num>0 then
for txIndex,txId in ipairs(catData.txList)do
if show_limit_tx_list then
if table.containsValue(show_limit_tx_list,txId)then
limitTxList[#limitTxList+1]=txId
end
else
limitTxList[#limitTxList+1]=txId
end

end
end
end


if data.entrustType>0 then
local title=enstrustFuncObj.getName(exclusiveData)
self.title:setText(title)
end

local iconName,iconAb=enstrustFuncObj.getIcon(exclusiveData)
if iconAb then
self.icon:setCSImageSprite(iconAb,iconName)
else
self.icon:setChildIcon(iconName,true)
end



local isShowInfoEx=next(data.exclusiveData)
self.infoEx:setActive(isShowInfoEx~=nil)
if isShowInfoEx then
self:refreshInfoEx(enstrustFuncObj,data)
end


local isShowChangeTypeBtn=isShowInfoEx and self.wtInfo.state==Cat_Entrust_State_Type.Prepare
self.changeWTTypeBtn:setActive(isShowChangeTypeBtn)


local isShowPreSelectCatPart=data.dispatchCatGuid==0 and self.wtInfo.state==Cat_Entrust_State_Type.Prepare
self.preSelectCatPart:setActive(false)


local isShowPreparePart=self.wtInfo.state==Cat_Entrust_State_Type.Prepare and data.dispatchCatGuid~=0 and catData~=nil
self.preparePart:setActive(isShowPreparePart)
if isShowPreparePart then


self:refreshSliderRoot()


local isShowSelectZmBtn=data.entrustType==Entrust_Type.ZMTY and data.exclusiveData.systemZmId==nil
self.selectZmBtn:setActive(false)



local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(catData)
self.widget:SetChildModelCaptureImage(self.prepareCatHead:getID(),modelid,components,2,eAnimationID.idle,0,0,Vector2(-40,65),1,false)


local isShowRewardInfo=data.rewardUpRate>0
self.rewardUpImg:setActive(isShowRewardInfo)
if isShowRewardInfo then
local rewardInfoTip=enstrustFuncObj.getRewardInfo(data.rewardUpRate,data)
self.rewardInfo:setText(rewardInfoTip)
else
self.rewardInfo:setText(toColorStringX("#171311",'暂无加成'))
end


local color=catData.color+1
local colorFrameName=FMT.fmt("frame_maomaoweituo_pz{0}",color)
self.catInfoPart:setCSImageSprite(_ab,colorFrameName)


local txLen=#limitTxList
local isShowNoTxTip=txLen==0
local isShowTxList=(not isShowNoTxTip)or(isShowNoTxTip and isShowRewardInfo)
self.noTxTip:setActive(isShowNoTxTip and isShowRewardInfo)
self.catTxList:setActive(isShowTxList)
for txIndex=1,_txMaxNum do
local isShowTx=txLen>=txIndex
local txItem=self.catTxItem[txIndex]
local txItemWidget=txItem:getWidgetBase()
txItemWidget:SetChildActive(-1,isShowTx)
if isShowTx then
local txconfig=cfgHelper.get1(cfg_cattxconfig_get,catData.txList[txIndex])
local name=UIDiscipleModel.getSpecialityNameStr(txconfig.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(txconfig.frame)
txItemWidget:SetChildCSImageSprite(-1,abName,frameIcon)
txItemWidget:SetChildText(0,name)
txItemWidget:SetBaseItemClickEvent(-1,function()
UIManager:showWindow('UIWanBaoXunBaoDui_SpeicialWin',{
item=txItemWidget,
node='bottom',
spid=limitTxList[txIndex],
})
end)
end
end

self.selectCnt=self.wtInfo.data.exclusiveData.count
local isShowTiliCondition=self:checkShowTiliCondition()
self.conditionTili:setActive(isShowTiliCondition)
if isShowTiliCondition then
self:refreshWTCatTiLiCondition()
end


local isShowWtCondition=enstrustFuncObj.checkShowWtCondition(data)
self.conditionWt:setActive(isShowWtCondition)
if isShowWtCondition then
local wtConditionInfo,costItemId=enstrustFuncObj.getWtConditionInfo(data.exclusiveData)
local itemIconName=itemsModel.getIconName({itemid=costItemId})
self.wtConditionIcon:setChildIcon(itemIconName,false)
self.wtConditionInfo:setText(wtConditionInfo)
self.widget:ForceLayoutRect(self.wtConditionInfo:getID())
end
end


local isShowDEPart=self.wtInfo.state>Cat_Entrust_State_Type.Prepare
self.DEPart:setActive(isShowDEPart)
if isShowDEPart then

local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(catData)
self.widget:SetChildModelCaptureImage(self.DECatHead:getID(),modelid,components,2,eAnimationID.idle,0,0,Vector2(-40,65),1,false)


local isShowDERewardInfo=data.rewardUpRate>0
self.DeRewardUpImg:setActive(isShowDERewardInfo)
if isShowDERewardInfo then
local rewardInfoTip=enstrustFuncObj.getRewardInfo(data.rewardUpRate,data)
self.DERewardInfo:setText(rewardInfoTip)
else
self.DERewardInfo:setText(toColorStringX("#171311",'暂无加成'))
end


local color=catData.color+1
local colorFrameName=FMT.fmt("frame_maomaoweituo_pz{0}",color)
self.DEcatInfoPart:setCSImageSprite(_ab,colorFrameName)


local txLen=#limitTxList
local isShowEDNoTxTip=txLen==0
local isShowEDTxList=(not isShowEDNoTxTip)or(isShowEDNoTxTip and isShowDERewardInfo)
self.DENoTxTip:setActive(isShowEDNoTxTip and isShowDERewardInfo)
self.DECatTxList:setActive(isShowEDTxList)
for txIndex=1,_txMaxNum do
local isShowTx=txLen>=txIndex
local txItem=self.DECatTxItem[txIndex]
local txItemWidget=txItem:getWidgetBase()
txItemWidget:SetChildActive(-1,isShowTx)
if isShowTx then
local txconfig=cfgHelper.get1(cfg_cattxconfig_get,catData.txList[txIndex])
local name=UIDiscipleModel.getSpecialityNameStr(txconfig.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(txconfig.frame)
txItemWidget:SetChildCSImageSprite(-1,abName,frameIcon)
txItemWidget:SetChildText(0,name)
txItemWidget:SetBaseItemClickEvent(-1,function()
UIManager:showWindow('UIWanBaoXunBaoDui_SpeicialWin',{
item=txItemWidget,
node='bottom',
spid=limitTxList[txIndex],
})
end)
end
end
end


local isShowDoingPart=self.wtInfo.state==Cat_Entrust_State_Type.Doing
self.doingPart:setActive(isShowDoingPart)
if isShowDoingPart then
local doingInfo=enstrustFuncObj.getDoingWtInfo()
self.doingWTInfo:setText(doingInfo)
end


local isShowEndPart=self.wtInfo.state>=Cat_Entrust_State_Type.Finish
self.endPart:setActive(isShowEndPart)
if isShowEndPart then
self.finishTip:setActive(self.wtInfo.state==Cat_Entrust_State_Type.End)
end
end


function CatEntrustItem:refreshInfoEx(enstrustFuncObj,data)
local isShowTYEX=false
local isShowMJEX=data.entrustType==Entrust_Type.ZMMJ
local isShowYYEX=data.entrustType==Entrust_Type.YYHY

local item
self.tayin:setActive(isShowTYEX)
if isShowTYEX then
item=self.tayin:getWidgetBase()
local isShowZMName=data.exclusiveData.systemZmId~=nil
item:SetChildActive(-1,isShowZMName)
end
self.mijing:setActive(isShowMJEX)
if isShowMJEX then
item=self.mijing:getWidgetBase()
local iconName,iconAb=enstrustFuncObj.getExInfoIcon(data.exclusiveData)
if iconAb then
item:SetChildCSImageSprite(0,iconAb,iconName)
else
item:SetChildIcon(0,iconName,true)
end

end
self.yiyuhuiyou:setActive(isShowYYEX)
if isShowYYEX then
item=self.yiyuhuiyou:getWidgetBase()
local exIconName,exAb=enstrustFuncObj.getExInfoIcon(data.exclusiveData)
if exAb then
item:SetChildCSImageSprite(0,exAb,exIconName)
else
item:SetChildIcon(0,exIconName,true)
end
end
end

function CatEntrustItem:refreshWTCatTiLiCondition()
local data=self.wtInfo.data
if data.dispatchCatGuid>0 then
local catData=wanBaoXunBaoDuiModel:getCatData(data.dispatchCatGuid)
local singleTili=cfgHelper.get2(cfg_catentrusttypeconfig_get,data.entrustType,'need_tili')
local catNeedTili=singleTili*self.selectCnt
local catHasTili=catData.tili

local catHasTiliInfo=catHasTili>=catNeedTili and catHasTili or toColorString(FONT_COLOR.eRedColor,catHasTili)
local tiliConditionInfo=FMT.fmt("{0}/{1}",catHasTiliInfo,catNeedTili)
self.tiliInfo:setText(tiliConditionInfo)
end
end

function CatEntrustItem:refreshWTCondition()
local data=self.wtInfo.data
local enstrustFuncObj=catEntrustConfig.getEntrustFuncObj(data.entrustType)

if enstrustFuncObj.checkShowWtCondition(data)then
local catData
if data.dispatchCatGuid>0 then
catData=wanBaoXunBaoDuiModel:getCatData(data.dispatchCatGuid)
end
if catData~=nil then
local wtConditionInfo,costItemId=enstrustFuncObj.getWtConditionInfo(data.exclusiveData)
self.wtConditionInfo:setText(wtConditionInfo)
end
end
end

function CatEntrustItem:setSliderVal(min,max)
self.widget:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,min,max,function(val)self:onSliderChange(val)end)
self.maxText:setText(max)
self.selectCntTxt:setText(self.selectCnt)
self.sliderRect:setChildLayoutGroupCreateItems(max-min+1,function(i)
local rect=self.sliderRect:getChildLayoutGroupGridItem(i-1)
if rect then
rect:SetChildButtonClick(0,function()
self:onSliderChange(min+i-1)
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),min+i-1)
end)
end
end)
end

function CatEntrustItem:onSliderChange(value)
local oldCnt=self.selectCnt
self.selectCnt=value
if oldCnt~=self.selectCnt then
local selectDesc=self.funcs.getSelectDesc(self.selectCnt,self.wtInfo)
self.cntInfoText:setText(selectDesc)
self.selectCntTxt:setText(self.selectCnt)


self.wtInfo.data.exclusiveData.count=value

catEntrustModel:updateCatEntrustCostList()


local isShowTiliCondition=self:checkShowTiliCondition()
self.conditionTili:setActive(isShowTiliCondition)
if isShowTiliCondition then
self:refreshWTCatTiLiCondition()
end


self:refreshWTCondition()


if self.isCanCoordinate then
self:updateCoordinateOtherCountSlider()
end
end
end

function CatEntrustItem:startShowRestoreTiliSpine()
self.restoreTiliSpine:setChildCanvasGroupAlpha(1)
self.restoreTiliSpine:setChildUIModelShowTarget(5477,1,{},eAnimationID.stand)
self:delayDo(2.7,function()
self.restoreTiliSpine:setChildCanvasGroupAlpha(0)
end)
end


function CatEntrustItem:updateCoordinateOtherCountSlider()
local type=self.wtInfo.data.entrustType
catEntrustModel:updateWtSameTypeCountCoordinate(type,self.wtInfo.id)
end

function CatEntrustItem:refreshSliderRoot()
local data=self.wtInfo.data
local enstrustFuncObj=catEntrustConfig.getEntrustFuncObj(data.entrustType)

self.isCanCoordinate=false

local isShowSlider=enstrustFuncObj.checkShowSlider(data)
self.countSelectPart:setActive(isShowSlider)
if isShowSlider then
local initSliderData=enstrustFuncObj.getInitSliderData(self.wtInfo)
self.min=initSliderData.min
self.max=initSliderData.max
self.selectCnt=data.exclusiveData.count

local isShowSliderRoot=self.max>1
self.sliderRoot:setActive(isShowSliderRoot)
self:setSliderVal(initSliderData.min,initSliderData.max)

local selectDesc=self.funcs.getSelectDesc(self.selectCnt,self.wtInfo)
self.cntInfoText:setText(selectDesc)

self:refreshWTCondition()
end

self.selectCntTxt:setText(self.selectCnt)

self.isCanCoordinate=true
end


function CatEntrustItem:checkShowTiliCondition()
local needTili=cfgHelper.get2(cfg_catentrusttypeconfig_get,self.type,'need_tili')
return needTili>0
end


function CatEntrustItem:onUnlockBtn()
if next(self.wtInfo.unlockCost)then
catEntrustConfig.toUnlockWtSlot(self.wtInfo)
end
end

function CatEntrustItem:onSelectEntrustBtn()
catEntrustModel:startSelectWtProcess(self.wtInfo.id)
local tempWt=catEntrustModel:getTempWt()
catEntrustController.showSelectWin(
'选择委托',
'UICatEntrustSelectWtWin',
{wtSlotId=self.wtInfo.id,tempWt=tempWt},
false)
end

function CatEntrustItem:onChangeWTTypeBtn()
catEntrustModel:startSelectWtProcess(self.wtInfo.id)
local tempWt=catEntrustModel:getTempWt()
catEntrustController.showSelectWin(
'替换委托',
'UICatEntrustSelectWtWin',
{wtSlotId=self.wtInfo.id,tempWt=tempWt},
false)
end

function CatEntrustItem:onSelectCatBtn()
catEntrustController.showSelectWin(
'选择猫猫',
'UICatEntrustSelectCatWin',
{wtSlotId=self.wtInfo.id},
false)
end

function CatEntrustItem:onClickHead()
catEntrustController.showSelectWin(
'替换猫猫',
'UICatEntrustSelectCatWin',
{
wtSlotId=self.wtInfo.id,
selectCatGuid=self.wtInfo.data.dispatchCatGuid,
},
false)

end

function CatEntrustItem:onAutoSelectCatBtn()
catEntrustModel:autoSetCat(self.wtInfo.id)
end

function CatEntrustItem:onSubBtn()
local cnt=self.selectCnt
if cnt<=self.min then
return
end
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),cnt-1)
end

function CatEntrustItem:onAddBtn()
local cnt=self.selectCnt
if cnt>=self.max then
return
end
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),cnt+1)
end

function CatEntrustItem:onMaxCnt()

end

function CatEntrustItem:onSelectZmBtn()
catEntrustController.showSelectWin(
'选择宗门',
'UICatEntrustSelectSystemZMWin',
{wtSlotId=self.wtInfo.id},
false)
end

function CatEntrustItem:onDelBtn()
catEntrustModel:delLocalizeRecord(self.wtInfo.id)
catEntrustModel:resetWtSlotData(self.wtInfo)
UIManager:invokeUIMethod('UICatEntrustWin','refreshAll')
end

function CatEntrustItem:onFreshBtn()
self:onSelectEntrustBtn()
end


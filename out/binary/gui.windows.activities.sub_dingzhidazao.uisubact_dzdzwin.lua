







def_class("UISubAct_dzdzWin",UIWindowBase)









function UISubAct_dzdzWin:bindComponents()

self.startCustomizationRoot=UIObject.get(self,0)
self.customizationBtn=UIButton.get(self,1)
self.propIcon=UIButton.get(self,2)
self.propCount=UIText.get(self,3)
self.lastStepBtn=UIButton.get(self,4)
self.nextStepBtn=UIButton.get(self,5)
self.billPanelRoot=UIObject.get(self,6)
self.confirmListBtn=UIButton.get(self,7)
self.customCheck1=UIObject.get(self,8)
self.customCheck2=UIObject.get(self,9)
self.customCheck3=UIObject.get(self,10)
self.customCheck4=UIObject.get(self,11)
self.dzIcon=UIButton.get(self,12)
self.dzCount=UIText.get(self,13)
self.stepPanelRoot=UIObject.get(self,14)
self.stepTitleText=UIImage.get(self,15)
self.equipItemBaseRoot=UIObject.get(self,16)
self.equipItemBase=UIBaseItem.get(self,17)
self.notCustom=UIText.get(self,18)
self.suitIcon=UIObject.get(self,19)
self.suitText=UIText.get(self,20)
self.step1Root=UIObject.get(self,21)
self.cOrderText=UIText.get(self,22)
self.step2Root=UIObject.get(self,23)
self.notCustomText=UIText.get(self,24)
self.p2AttrName=UIText.get(self,25)
self.p2AttrValue=UIText.get(self,26)
self.p3AttrDesc=UIText.get(self,27)
self.customBtn=UIButton.get(self,28)
self.dzSuitIcon=UIButton.get(self,29)
self.dzSuitCount=UIText.get(self,30)
self.step3Root=UIObject.get(self,31)
self.refreshAttrScrollView=UIObject.get(self,32)
self.replaceAttrScrollView=UIObject.get(self,33)
self.refreshAttrBtn=UIButton.get(self,34)
self.replaceAttrBtn=UIButton.get(self,35)
self.refAttrIcon=UIButton.get(self,36)
self.refAttrCount=UIText.get(self,37)
self.step4Root=UIObject.get(self,38)
self.refineBasisAttr1Name=UIText.get(self,39)
self.refineBasisAttr1Value=UIText.get(self,40)
self.refineBasisAttr1Refine=UIText.get(self,41)
self.refineAttrScrollView=UIObject.get(self,42)
self.refineAttrBtn=UIButton.get(self,43)
self.refineIcon=UIButton.get(self,44)
self.refineCount=UIText.get(self,45)
self.bgModel=UIObject.get(self,46)
self.equipScrollView=UIObject.get(self,47)
self.armorScrollView=UIObject.get(self,48)
self.customBtnText=UIText.get(self,50)
self.refineAttrBtnText=UIText.get(self,51)
self.customListWin=UIObject.get(self,52)
self.customMakeBtn=UIButton.get(self,53)
self.moneyIcon=UIImage.get(self,54)
self.moneyCnt=UIText.get(self,55)
self.basisAttr1Name=UIText.get(self,56)
self.basisAttr1Value=UIText.get(self,57)
self.basisAttr1Refine=UIText.get(self,58)
self.customSuitIcon=UIObject.get(self,59)
self.customSuitText=UIText.get(self,60)
self.p2CutAttrName=UIText.get(self,61)
self.p3CutAttrDesc=UIText.get(self,62)
self.refineAttr1ScrollView=UIObject.get(self,63)
self.ItemBaseRoot=UIObject.get(self,64)
self.Slider=UIProgress.get(self,65)
self.refineBasisAttr2Name=UIText.get(self,66)
self.refineBasisAttr2Value=UIText.get(self,67)
self.refineBasisAttr2Refine=UIText.get(self,68)
self.refineBasisAttr1=UIObject.get(self,69)
self.refineBasisAttr2=UIObject.get(self,70)
self.basisAttr2Name=UIText.get(self,71)
self.basisAttr2Value=UIText.get(self,72)
self.basisAttr2Refine=UIText.get(self,73)
self.basisAttr1=UIObject.get(self,74)
self.basisAttr2=UIObject.get(self,75)
self.customSelect1=UIObject.get(self,76)
self.customSelect2=UIObject.get(self,77)
self.customSelect3=UIObject.get(self,78)
self.customSelect4=UIObject.get(self,79)
self.lastStepBtnText=UIText.get(self,80)
self.nextStepBtnText=UIText.get(self,81)
self.oldEffect=UIObject.get(self,82)
self.newEffect=UIObject.get(self,83)
self.suitAttrRoot=UIObject.get(self,84)
self.suitEffect=UIObject.get(self,85)
self.suitEffect1=UIObject.get(self,86)
self.haveMoneyIcon=UIImage.get(self,87)
self.haveMoneyCnt=UIText.get(self,88)
self.addMoneyBtn=UIButton.get(self,89)
self.oldEffect1=UIObject.get(self,90)
self.oldEffect2=UIObject.get(self,91)
self.oldEffect3=UIObject.get(self,92)
self.oldEffect4=UIObject.get(self,93)
self.newEffect1=UIObject.get(self,94)
self.newEffect2=UIObject.get(self,95)
self.newEffect3=UIObject.get(self,96)
self.newEffect4=UIObject.get(self,97)
self.refEffect1=UIObject.get(self,98)
self.refEffect2=UIObject.get(self,99)
self.refEffect3=UIObject.get(self,100)
self.refEffect4=UIObject.get(self,101)
self.oldAttrRoot=UIObject.get(self,102)
self.newAttrRoot=UIObject.get(self,103)
self.refineRandomAttrRoot=UIObject.get(self,104)
self.suitEffect2=UIObject.get(self,105)
self.suitEffect3=UIObject.get(self,106)
self.suitIconEffect=UIObject.get(self,107)
self.npcModel=UIObject.get(self,108)
self.bgModel1=UIObject.get(self,109)
self.bgModel2=UIObject.get(self,110)
self.Root1=UIObject.get(self,111)
self.root=UIObject.get(self,112)
self.maskBtn=UIButton.get(self,113)
self.speakObj=UIObject.get(self,114)
self.speakText=UIText.get(self,115)
self.npcModelRoot=UIObject.get(self,116)
self.FreeTip=UIText.get(self,117)

self.customizationBtn:setButtonClick(function()self:onCustomizationBtn()end)

self.propIcon:setButtonClick(function()self:onPropIcon()end)

self.lastStepBtn:setButtonClick(function()self:onLastStepBtn()end)

self.nextStepBtn:setButtonClick(function()self:onNextStepBtn()end)

self.confirmListBtn:setButtonClick(function()self:onConfirmListBtn()end)

self.dzIcon:setButtonClick(function()self:onDzIcon()end)

self.customBtn:setButtonClick(function()self:onCustomBtn()end)

self.dzSuitIcon:setButtonClick(function()self:onDzSuitIcon()end)

self.refreshAttrBtn:setButtonClick(function()self:onRefreshAttrBtn()end)

self.replaceAttrBtn:setButtonClick(function()self:onReplaceAttrBtn()end)

self.refAttrIcon:setButtonClick(function()self:onRefAttrIcon()end)

self.refineAttrBtn:setButtonClick(function()self:onRefineAttrBtn()end)

self.refineIcon:setButtonClick(function()self:onRefineIcon()end)

self.customMakeBtn:setButtonClick(function()self:onCustomMakeBtn()end)

self.addMoneyBtn:setButtonClick(function()self:onAddMoneyBtn()end)

self.maskBtn:setButtonClick(function()self:onMaskBtn()end)



end


function UISubAct_dzdzWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.startCustomizationRoot);self.startCustomizationRoot=nil;
_UIObject_release(self.customizationBtn);self.customizationBtn=nil;
_UIObject_release(self.propIcon);self.propIcon=nil;
_UIObject_release(self.propCount);self.propCount=nil;
_UIObject_release(self.lastStepBtn);self.lastStepBtn=nil;
_UIObject_release(self.nextStepBtn);self.nextStepBtn=nil;
_UIObject_release(self.billPanelRoot);self.billPanelRoot=nil;
_UIObject_release(self.confirmListBtn);self.confirmListBtn=nil;
_UIObject_release(self.customCheck1);self.customCheck1=nil;
_UIObject_release(self.customCheck2);self.customCheck2=nil;
_UIObject_release(self.customCheck3);self.customCheck3=nil;
_UIObject_release(self.customCheck4);self.customCheck4=nil;
_UIObject_release(self.dzIcon);self.dzIcon=nil;
_UIObject_release(self.dzCount);self.dzCount=nil;
_UIObject_release(self.stepPanelRoot);self.stepPanelRoot=nil;
_UIObject_release(self.stepTitleText);self.stepTitleText=nil;
_UIObject_release(self.equipItemBaseRoot);self.equipItemBaseRoot=nil;
_UIObject_release(self.equipItemBase);self.equipItemBase=nil;
_UIObject_release(self.notCustom);self.notCustom=nil;
_UIObject_release(self.suitIcon);self.suitIcon=nil;
_UIObject_release(self.suitText);self.suitText=nil;
_UIObject_release(self.step1Root);self.step1Root=nil;
_UIObject_release(self.cOrderText);self.cOrderText=nil;
_UIObject_release(self.step2Root);self.step2Root=nil;
_UIObject_release(self.notCustomText);self.notCustomText=nil;
_UIObject_release(self.p2AttrName);self.p2AttrName=nil;
_UIObject_release(self.p2AttrValue);self.p2AttrValue=nil;
_UIObject_release(self.p3AttrDesc);self.p3AttrDesc=nil;
_UIObject_release(self.customBtn);self.customBtn=nil;
_UIObject_release(self.dzSuitIcon);self.dzSuitIcon=nil;
_UIObject_release(self.dzSuitCount);self.dzSuitCount=nil;
_UIObject_release(self.step3Root);self.step3Root=nil;
_UIObject_release(self.refreshAttrScrollView);self.refreshAttrScrollView=nil;
_UIObject_release(self.replaceAttrScrollView);self.replaceAttrScrollView=nil;
_UIObject_release(self.refreshAttrBtn);self.refreshAttrBtn=nil;
_UIObject_release(self.replaceAttrBtn);self.replaceAttrBtn=nil;
_UIObject_release(self.refAttrIcon);self.refAttrIcon=nil;
_UIObject_release(self.refAttrCount);self.refAttrCount=nil;
_UIObject_release(self.step4Root);self.step4Root=nil;
_UIObject_release(self.refineBasisAttr1Name);self.refineBasisAttr1Name=nil;
_UIObject_release(self.refineBasisAttr1Value);self.refineBasisAttr1Value=nil;
_UIObject_release(self.refineBasisAttr1Refine);self.refineBasisAttr1Refine=nil;
_UIObject_release(self.refineAttrScrollView);self.refineAttrScrollView=nil;
_UIObject_release(self.refineAttrBtn);self.refineAttrBtn=nil;
_UIObject_release(self.refineIcon);self.refineIcon=nil;
_UIObject_release(self.refineCount);self.refineCount=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.equipScrollView);self.equipScrollView=nil;
_UIObject_release(self.armorScrollView);self.armorScrollView=nil;
_UIObject_release(self.customBtnText);self.customBtnText=nil;
_UIObject_release(self.refineAttrBtnText);self.refineAttrBtnText=nil;
_UIObject_release(self.customListWin);self.customListWin=nil;
_UIObject_release(self.customMakeBtn);self.customMakeBtn=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyCnt);self.moneyCnt=nil;
_UIObject_release(self.basisAttr1Name);self.basisAttr1Name=nil;
_UIObject_release(self.basisAttr1Value);self.basisAttr1Value=nil;
_UIObject_release(self.basisAttr1Refine);self.basisAttr1Refine=nil;
_UIObject_release(self.customSuitIcon);self.customSuitIcon=nil;
_UIObject_release(self.customSuitText);self.customSuitText=nil;
_UIObject_release(self.p2CutAttrName);self.p2CutAttrName=nil;
_UIObject_release(self.p3CutAttrDesc);self.p3CutAttrDesc=nil;
_UIObject_release(self.refineAttr1ScrollView);self.refineAttr1ScrollView=nil;
_UIObject_release(self.ItemBaseRoot);self.ItemBaseRoot=nil;
_UIObject_release(self.Slider);self.Slider=nil;
_UIObject_release(self.refineBasisAttr2Name);self.refineBasisAttr2Name=nil;
_UIObject_release(self.refineBasisAttr2Value);self.refineBasisAttr2Value=nil;
_UIObject_release(self.refineBasisAttr2Refine);self.refineBasisAttr2Refine=nil;
_UIObject_release(self.refineBasisAttr1);self.refineBasisAttr1=nil;
_UIObject_release(self.refineBasisAttr2);self.refineBasisAttr2=nil;
_UIObject_release(self.basisAttr2Name);self.basisAttr2Name=nil;
_UIObject_release(self.basisAttr2Value);self.basisAttr2Value=nil;
_UIObject_release(self.basisAttr2Refine);self.basisAttr2Refine=nil;
_UIObject_release(self.basisAttr1);self.basisAttr1=nil;
_UIObject_release(self.basisAttr2);self.basisAttr2=nil;
_UIObject_release(self.customSelect1);self.customSelect1=nil;
_UIObject_release(self.customSelect2);self.customSelect2=nil;
_UIObject_release(self.customSelect3);self.customSelect3=nil;
_UIObject_release(self.customSelect4);self.customSelect4=nil;
_UIObject_release(self.lastStepBtnText);self.lastStepBtnText=nil;
_UIObject_release(self.nextStepBtnText);self.nextStepBtnText=nil;
_UIObject_release(self.oldEffect);self.oldEffect=nil;
_UIObject_release(self.newEffect);self.newEffect=nil;
_UIObject_release(self.suitAttrRoot);self.suitAttrRoot=nil;
_UIObject_release(self.suitEffect);self.suitEffect=nil;
_UIObject_release(self.suitEffect1);self.suitEffect1=nil;
_UIObject_release(self.haveMoneyIcon);self.haveMoneyIcon=nil;
_UIObject_release(self.haveMoneyCnt);self.haveMoneyCnt=nil;
_UIObject_release(self.addMoneyBtn);self.addMoneyBtn=nil;
_UIObject_release(self.oldEffect1);self.oldEffect1=nil;
_UIObject_release(self.oldEffect2);self.oldEffect2=nil;
_UIObject_release(self.oldEffect3);self.oldEffect3=nil;
_UIObject_release(self.oldEffect4);self.oldEffect4=nil;
_UIObject_release(self.newEffect1);self.newEffect1=nil;
_UIObject_release(self.newEffect2);self.newEffect2=nil;
_UIObject_release(self.newEffect3);self.newEffect3=nil;
_UIObject_release(self.newEffect4);self.newEffect4=nil;
_UIObject_release(self.refEffect1);self.refEffect1=nil;
_UIObject_release(self.refEffect2);self.refEffect2=nil;
_UIObject_release(self.refEffect3);self.refEffect3=nil;
_UIObject_release(self.refEffect4);self.refEffect4=nil;
_UIObject_release(self.oldAttrRoot);self.oldAttrRoot=nil;
_UIObject_release(self.newAttrRoot);self.newAttrRoot=nil;
_UIObject_release(self.refineRandomAttrRoot);self.refineRandomAttrRoot=nil;
_UIObject_release(self.suitEffect2);self.suitEffect2=nil;
_UIObject_release(self.suitEffect3);self.suitEffect3=nil;
_UIObject_release(self.suitIconEffect);self.suitIconEffect=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.bgModel1);self.bgModel1=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.Root1);self.Root1=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.maskBtn);self.maskBtn=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.npcModelRoot);self.npcModelRoot=nil;
_UIObject_release(self.FreeTip);self.FreeTip=nil;
end


















local this

function UISubAct_dzdzWin:onLoaded(...)
this=self
self:bindComponents()
self:creatSelfList()
end


function UISubAct_dzdzWin:__delete()
this=nil
self:clearSelfList()
self:unbindComponents()
self:clearAllTimer()
UIManager:closeWindow('UITopMoneyWin2')
end

local abname="ui/windows/activities/sub_dingzhidazao/act_dzdz_atlas_pak.ab"
local AbName="ui/windows/equip/jinglian_atlas_pak.ab"

local paramType=
{
star=1,
custSuit=2,
refSuit=3,
refAttr=4,
repAttr=5,
refine=6,
recast=7,
generate=8,
}

local stepGrayType=
{
step1=1,
step2=2,
step3=3,
step4=4,
}

local ItemIndex=
{
icon=0,
item=1,
select=2,
text=3,
}

local attrItemIndex=
{
attrName=0,
attrValue=1,
attrEmpty=2,
attrItem=3,
attrIcon=4,
}

local attrRefineIndex=
{
item=0,
name=1,
value=2,
arrow=3,
addText=4,
back=5,
icon=6,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIcon=1,
cmpItemCountBg=2,
cmpItemTxtCount=3,
cmpItemName=4,
cmpItemStageBg=5,
cmpItemStage=6,
cmpItemMask=7,
cmpItemLock=8,
cmpQualityEffect=9,
cmpSuitIcon=10,
}

local anim1Id=
{
change=2186,
change2=2187,
}

local animId=
{
stand=2192,
change=2193,
stand2=2194,
}

local _colorFormat=
{
[eQualityColor.eWhite]='#FFFFFF',
[eQualityColor.eGreen]='#4f851b',
[eQualityColor.eBlue]='#1b4385',
[eQualityColor.ePurple]='#431b85',
[eQualityColor.eOrange]='#85451b',
[eQualityColor.eRed]='#851b1b',
}

local iconList=
{
[eQualityColor.eWhite]='icon_jingliantp_0',
[eQualityColor.eGreen]='icon_jingliantp_0',
[eQualityColor.eBlue]='icon_jingliantp_1',
[eQualityColor.ePurple]='icon_jingliantp_2',
[eQualityColor.eOrange]='icon_jingliantp_3',
[eQualityColor.eRed]='icon_jingliantp_4',
}

local bgList=
{
[eQualityColor.eWhite]='image_jinglianbg_0',
[eQualityColor.eGreen]='image_jinglianbg_0',
[eQualityColor.eBlue]='image_jinglianbg_1',
[eQualityColor.ePurple]='image_jinglianbg_2',
[eQualityColor.eOrange]='image_jinglianbg_3',
[eQualityColor.eRed]='image_jinglianbg_4',
}

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




function UISubAct_dzdzWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.sublist=activitiesModel:getActSubList_open_doing(self.activityId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

self.talkCfg=self.config.talkText
self.bgModelId=self.config.bgModelId
self.partConfig=cfg_dingzhidazaopartconfig()
self.npcWidget=self.npcModelRoot:getWidgetBase()

self:refreshRecvData()
self:initPartConfigData()
self:refreshBgModel()
self:refreshNpcModel()
self:refreshPanel()
self.Root1:setChildCanvasGroupAlpha(1)
if not self.customListWinFlag then
UIManager:showWindow('UITopMoneyWin2',{{10618},{10619}})
end

end



function UISubAct_dzdzWin:refreshBgModel()

if self.bgModelId then
local animId1=eAnimationID.stand

self.bgModel:setChildUIModelShowTarget(self.bgModelId[2],1,{},animId1,false,false,0)
self.bgModel:setActive(true)

self.bgModel1:setChildUIModelShowTarget(self.bgModelId[3],1,{},animId.stand,false,false,0)
self.bgModel1:setActive(true)

self.bgModel2:setChildUIModelShowTarget(self.bgModelId[1],1,{},animId.stand,false,false,0)
self.bgModel2:setActive(false)
else
self.bgModel:setActive(false)
self.bgModel:setChildUIModelRemoveTarget()
self.bgModel1:setActive(false)
self.bgModel1:setChildUIModelRemoveTarget()
self.bgModel2:setActive(false)
self.bgModel2:setChildUIModelRemoveTarget()
end
end


function UISubAct_dzdzWin:flipPageAnim(bgModelId)

self:clearPageAnim()
self.bgModel2:setActive(true)
self.roottween=self.Root1:setChildCanvasGroupDOFade(0,0.1,function()
self:refreshPanel()

self.bgModel2:setChildModelAnimationState(animId.change,1)
end)

self.pageTimer=self:delayDo(1.2,function()
if self.roottween and self.roottween:IsActive()then
self.roottween:Kill()
end
self.roottween=self.Root1:setChildCanvasGroupDOFade(1,0.5)
end)
end

function UISubAct_dzdzWin:clearPageAnim()
if self.roottween and self.roottween:IsActive()then
self.roottween:Kill()
self.roottween=nil
end
if self.pageTimer then
self:stopTimerByID(self.pageTimer)
self.pageTimer=nil
end
end


function UISubAct_dzdzWin:refreshNpcModel()
local modelParam=cfgHelper.get2(cfg_npcimageconfig_get,2018,'image')
self.npcModel:setChildUIModelShowTarget(1113004,1,{},eAnimationID.stand,false,false,0.5)
end


function UISubAct_dzdzWin:refreshSetpTitleText()
if self.pageIndex then

local str=string.format("image_dingzhidazao_btwz%s",self.pageIndex)
self.stepTitleText:setCSImageSprite(abname,str)
end
end

function UISubAct_dzdzWin:refreshPanel()
self:refreshStepRoot()
end

function UISubAct_dzdzWin:refreshRecvData()
self.data=self.activityData.data
self.stepNum=self.data.stepIndex
self.type1=self.data.type1
self.type2=self.data.type2
self.stage=self.data.stage
self.color=self.data.color
self.suitId=self.data.suitId
self.jinglianlv=self.data.jinglianlv
self.attrLen=self.data.attrLen
self.attrList=self.data.attrList
self.attrRefreshLen=self.data.attrRefreshLen
self.attrRefreshList=self.data.attrRefreshList
self.attrRefineLen=self.data.attrRefineLen
self.attrRefineList=self.data.attrRefineList
self.equipId=self.data.equipId

if self.type1==1 then
self.selectIndex=self.type2
elseif self.type1>1 then
self.selectIndex=self.type1+7
else
self.selectIndex=0
end

if self.stepNum<=paramType.star then
self.pageIndex=self.stepNum
elseif self.stepNum==paramType.custSuit or self.stepNum==paramType.refSuit then
self.pageIndex=2
elseif self.stepNum==paramType.refAttr or self.stepNum==paramType.repAttr then
self.pageIndex=3
elseif self.stepNum==paramType.refine or self.stepNum==paramType.recast then
self.pageIndex=4
end

self:refreshBillStateList()
end

function UISubAct_dzdzWin:refreshActivityData()
self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self:refreshRecvData()
end


function UISubAct_dzdzWin:refreshStepBtnRoot(stepNum)
local lastBtn
local nextBtn
local lastText
local nextText

if self.pageIndex>1 then
lastBtn=true
lastText=string.format("上一步\n%s",self.stepText[self.pageIndex-1])
self.lastStepBtnText:setText(lastText)
end
if self.pageIndex<4 and self.pageIndex>0 then
nextBtn=true
nextText=string.format("下一步\n%s",self.stepText[self.pageIndex+1])
self.nextStepBtnText:setText(nextText)
end

self.lastStepBtn:setActive(lastBtn)
self.nextStepBtn:setActive(nextBtn)

if stepNum then
local flag=self.customStateList[stepNum]
self.nextStepBtn:setButtonEnable(true,not flag)
end

self.confirmListBtn:setActive(self.pageIndex==4)

end


function UISubAct_dzdzWin:refreshStepRoot()
if self.stepNum>0 then
self.startCustomizationRoot:setActive(false)
self.billPanelRoot:setActive(true)
self.stepPanelRoot:setActive(true)
end
self.bgModel2:setActive(self.stepNum>0)
if self.pageIndex==0 then
self.startCustomizationRoot:setActive(true)
self.step1Root:setActive(false)
self.step3Root:setActive(false)
self.step2Root:setActive(false)
self.step4Root:setActive(false)
self.billPanelRoot:setActive(false)
self.stepPanelRoot:setActive(false)
self.equipItemBaseRoot:setActive(false)
self:refreshStepBtnRoot()
self:refreshStartCustomizationPanel()
elseif self.pageIndex==1 then
self.step1Root:setActive(true)
self.step3Root:setActive(false)
self.step2Root:setActive(false)
self.step4Root:setActive(false)
self.equipItemBaseRoot:setActive(false)
self:refreshStep1Root()
self:refreshStepBtnRoot(stepGrayType.step1)
elseif self.pageIndex==2 then
self.step1Root:setActive(false)
self.step2Root:setActive(true)
self.step3Root:setActive(false)
self.step4Root:setActive(false)
self.equipItemBaseRoot:setActive(true)
self:refreshStep2Root()
self:refreshStepBtnRoot(stepGrayType.step2)
elseif self.pageIndex==3 then
self.step1Root:setActive(false)
self.step2Root:setActive(false)
self.step3Root:setActive(true)
self.step4Root:setActive(false)
self.equipItemBaseRoot:setActive(true)
self:refreshStepBtnRoot(stepGrayType.step3)
self:refreshStep3Root()
elseif self.pageIndex==4 then
self.step1Root:setActive(false)
self.step3Root:setActive(false)
self.step2Root:setActive(false)
self.step4Root:setActive(true)
self.equipItemBaseRoot:setActive(true)
self:refreshStepBtnRoot(stepGrayType.step4)
self:refreshStep4Root()
end

self:refreshSetpTitleText()
self:refreshBillListPanel()
end


function UISubAct_dzdzWin:refreshStartCustomizationPanel()
local stage
local stageCfg=self.config.stage
local level=playerModel:getActorLevel()or 1
if level<self.config.level then
stage=stageCfg[1][3]
self.stage=stage
else
for k,v in ipairs(stageCfg)do
if v then
if level>=v[1]and level<=v[2]then
stage=v[3]
self.stage=stage
break
end
end
end
end


if self.activityData.data.free<1 then
self.FreeTip:setActive(true)
else
self.FreeTip:setActive(false)
end
local costCountCfg=self.config.useItem[stage][1]
if costCountCfg and self.activityData.data.free>=1 then
local costCount=costCountCfg[1]
self.propCount:setActive(true)
self.propIcon:setActive(true)
local name=iconHelper.getIconName(costCount[1])
local useCount=costCount[2]
local haveCount=itemsModel.getCount(costCount[1])
local value=string.format("%s/%s",haveCount,useCount)
if name and value then
self.propIcon:setIcon(name)
self.propCount:setText(value)
end
else
self.propCount:setActive(false)
self.propIcon:setActive(false)
end

end


function UISubAct_dzdzWin:refreshStep1Root()
local str=string.format("定制%s阶",self.stage)
self.cOrderText:setText(str)

self:refreshScrollviewRoot()
end


function UISubAct_dzdzWin:refreshStep2Root()
self:refreshEquipItemBase()
self:refreshSuitPanle()
self:refreshSuitBtn()
end


function UISubAct_dzdzWin:refreshStep3Root()
self:refreshAttrBtnIcon()
self:refreshEquipItemBase()
self:refreshAttrScrollviewRoot()
end


function UISubAct_dzdzWin:refreshStep4Root()
self:refreshRefBtnText()
self:refreshEquipItemBase()
self:refreshAttrScrollviewRoot()
self:refreshRefineAttrScrollviewRoot()
end

function UISubAct_dzdzWin:refreshSuitIcon()
local flag=self.suitId>0
local cfg=equipsConfig.getSuitConfig(self.suitId)
local iconName=equipsHelper.getEquipSuitIconById(self.suitId)

self.notCustom:setActive(not flag)
self.notCustomText:setActive(not flag)

if flag then
if self.refreshSuit then
self.suitIcon:setChildCanvasGroupDOFade(0,0.05,function()
self.suitIconEffect:setChildShowEffect(10503,true)
self.suitTimer=self:delayDo(0.25,function()
self.suitIcon:setChildCanvasGroupDOFade(1,0.1)
self.suitIcon:setIcon(iconName)
self.suitText:setText(cfg.name)
end)
end)
else
self.suitIcon:setIcon(iconName)
self.suitText:setText(cfg.name)
end
end
end


function UISubAct_dzdzWin:refreshSuitPanle()


local flag=self.suitId>0
self.suitIcon:setActive(flag)
self.suitAttrRoot:setActive(false)
self.suitEffect:setChildShowEffect(10503,false)
self.suitEffect1:setChildShowEffect(10503,false)

if flag then
if self.refreshSuit then
self.refreshSuit=nil
self.suitAttrRoot:setChildCanvasGroupDOFade(0,0.05,function()
self.suitAttrRoot:setActive(flag)
self.suitEffect:setChildShowEffect(10503,true)
self.suitEffect1:setChildShowEffect(10503,true)
self.suitEffect2:setChildShowEffect(10503,true)
self.suitEffect3:setChildShowEffect(10503,true)
self.suitTimer=self:delayDo(0.25,function()
self.suitAttrRoot:setChildCanvasGroupDOFade(1,0.1)
local cfg=equipsConfig.getSuitConfig(self.suitId)
self.p2AttrName:setText(cfg.attr2desc)
self.p3AttrDesc:setText(cfg.attr3desc)
end)
end)
else
self.suitAttrRoot:setActive(flag)
local cfg=equipsConfig.getSuitConfig(self.suitId)
self.p2AttrName:setText(cfg.attr2desc)
self.p3AttrDesc:setText(cfg.attr3desc)
end
end
end


function UISubAct_dzdzWin:refreshRefineAttrScrollviewData()
local len=4
local grids=self.refineAttrScrollView:getChildScrollViewItemWidgets()

if self.equipId>0 then
local attr
local cfg=itemsConfig.getConfig(self.equipId)
local static=cfg.static
local baseAttrsLookup=equipsHelper.getJinglianBaseAttrs(self.equipId,8)

if static then
for i=1,2 do
attr=cfg.static[i]


if attr then
local attrValue=attr[2]
self.baseAttrRootList[i]:setActive(true)
if self.jinglianlv>0 then
attrValue=baseAttrsLookup[attr[1]]
self.baseAttrRefList[i]:setActive(false)
else
local count=baseAttrsLookup[attr[1]]-attr[2]
local str=string.format("(+%s)",count)
self.baseAttrRefList[i]:setActive(true)
self.baseAttrRefList[i]:setText(str)
end

local name,value=equipsHelper.getAttr(attr[1],attrValue)
self.baseAttrNameList[i]:setText(name)
self.baseAttrValueList[i]:setText(value)
else
self.baseAttrRootList[i]:setActive(false)
end
end
end
end

for i=1,len do
local widget=grids[i-1]
local state=self.attrLen>0 or false

widget:SetChildActive(attrRefineIndex.item,true)
widget:SetChildActive(attrRefineIndex.name,state)
widget:SetChildActive(attrRefineIndex.value,state)
widget:SetChildActive(attrRefineIndex.arrow,false)
widget:SetChildActive(attrRefineIndex.addText,false)

if state then
local attrColor
local data=self.attrList[i]
local cfg=itemsConfig.getConfig(self.equipId)

if data then
if cfg then
attrColor=_getAttrColor(data.param_1,data.param_2,cfg.stage)
else
attrColor=0
end

local name,value=equipsHelper.getAttr(data.param_1,data.param_2)
local nameStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],name)
local valStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],value)
local iconName=iconList[attrColor]
local bgName=bgList[attrColor]

widget:SetChildText(attrRefineIndex.name,nameStr)
widget:SetChildText(attrRefineIndex.value,valStr)
widget:SetChildCSImageSprite(attrRefineIndex.icon,AbName,iconName)
widget:SetChildCSImageSprite(attrRefineIndex.back,AbName,bgName)


if self.attrRefineLen>0 then
for j=1,self.attrRefineLen do
if self.attrRefineList[j]then

if self.attrRefineList[j].param_1==data.param_1 then
local str=string.format("x%s",self.attrRefineList[j].param_2)
widget:SetChildActive(attrRefineIndex.arrow,true)
widget:SetChildActive(attrRefineIndex.addText,true)
widget:SetChildText(attrRefineIndex.addText,str)
end
end
end
else
widget:SetChildActive(attrRefineIndex.arrow,false)
widget:SetChildActive(attrRefineIndex.addText,false)
end
else
widget:SetChildActive(attrRefineIndex.item,false)
end
end
end
end


function UISubAct_dzdzWin:refreshRefineAttrScrollviewRoot()


local len=4
self.refineAttrScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.refineAttrScrollView:getChildScrollViewItemWidgets()

if self.refreshRef then
self.refreshRef=nil
self.refineRandomAttrRoot:setChildCanvasGroupDOFade(0,0.05,function()
self.refEffect1:setChildShowEffect(10503,true)
self.refEffect2:setChildShowEffect(10503,true)
self.refEffect3:setChildShowEffect(10503,true)
self.refEffect4:setChildShowEffect(10503,true)
self.refTimer=self:delayDo(0.25,function()
self.refineRandomAttrRoot:setChildCanvasGroupDOFade(1,0.1)
self:refreshRefineAttrScrollviewData()
end)
end)
else
self:refreshRefineAttrScrollviewData()
end
end


function UISubAct_dzdzWin:refreshAttrScrollviewData()
local len=4
local cfg
local attrColor

local refresh_grids=self.refreshAttrScrollView:getChildScrollViewItemWidgets()
local replace_grids=self.replaceAttrScrollView:getChildScrollViewItemWidgets()

if self.equipId>0 then
cfg=itemsConfig.getConfig(self.equipId)
end

for i=1,len do
local refresh_widget=refresh_grids[i-1]
local replace_widget=replace_grids[i-1]

local refresh_state=self.attrLen>0 or false
local replace_state=self.attrRefreshLen>0 or false

refresh_widget:SetChildActive(attrItemIndex.attrItem,true)
refresh_widget:SetChildActive(attrItemIndex.attrName,refresh_state)
refresh_widget:SetChildActive(attrItemIndex.attrValue,refresh_state)
refresh_widget:SetChildActive(attrItemIndex.attrEmpty,not refresh_state)

if refresh_state then
local data=self.attrList[i]
if data then
if cfg then
attrColor=_getAttrColor(data.param_1,data.param_2,cfg.stage)
else
attrColor=0
end

local name,value=equipsHelper.getAttr(data.param_1,data.param_2)
local nameStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],name)
local valStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],value)
refresh_widget:SetChildText(attrItemIndex.attrName,nameStr)
refresh_widget:SetChildText(attrItemIndex.attrValue,valStr)
else
refresh_widget:SetChildActive(attrItemIndex.attrItem,false)
end
end


replace_widget:SetChildActive(attrItemIndex.attrName,replace_state)
replace_widget:SetChildActive(attrItemIndex.attrValue,replace_state)
replace_widget:SetChildActive(attrItemIndex.attrIcon,replace_state)
replace_widget:SetChildActive(attrItemIndex.attrItem,replace_state)

if replace_state then
local data=self.attrRefreshList[i]
if data then
if cfg then
attrColor=_getAttrColor(data.param_1,data.param_2,cfg.stage)
else
attrColor=0
end

local name,value=equipsHelper.getAttr(data.param_1,data.param_2)
local nameStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],name)
local valStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],value)
replace_widget:SetChildText(attrItemIndex.attrName,nameStr)
replace_widget:SetChildText(attrItemIndex.attrValue,valStr)
else
replace_widget:SetChildActive(attrItemIndex.attrItem,false)
end
end
end
end


function UISubAct_dzdzWin:refreshAttrScrollviewRoot()




local len=4
self.refreshAttrScrollView:setChildScrollViewCreateGrids(len,1)
self.replaceAttrScrollView:setChildScrollViewCreateGrids(len,1)

if not self.refreshRAttr and not self.refreshRplace then
self:refreshAttrScrollviewData()
end

if self.refreshRplace then
self.refreshRplace=nil
self.oldAttrRoot:setChildCanvasGroupDOFade(0,0.05,function()
self.oldEffect1:setChildShowEffect(10503,true)
self.oldEffect2:setChildShowEffect(10503,true)
self.oldEffect3:setChildShowEffect(10503,true)
self.oldEffect4:setChildShowEffect(10503,true)
self.oldTimer=self:delayDo(0.25,function()
self.oldAttrRoot:setChildCanvasGroupDOFade(1,0.1)
self:refreshAttrScrollviewData()
end)
end)
elseif self.refreshRAttr then
self.refreshRAttr=nil
self.newAttrRoot:setChildCanvasGroupDOFade(0,0.05,function()
self.newEffect1:setChildShowEffect(10503,true)
self.newEffect2:setChildShowEffect(10503,true)
self.newEffect3:setChildShowEffect(10503,true)
self.newEffect4:setChildShowEffect(10503,true)
self.newTimer=self:delayDo(0.25,function()
self.newAttrRoot:setChildCanvasGroupDOFade(1,0.1)
self:refreshAttrScrollviewData()
end)
end)
end
end


function UISubAct_dzdzWin:refreshCustomListWin()
self.customListWin:setActive(true)
self.customListWinFlag=true
self:refreshListAttrScrollviewRoot()
self:refreshListIcon()
self:refreshItemBase()
self:refreshListSuitPanle()
UIManager:hideWindow('UITopMoneyWin2')
end


function UISubAct_dzdzWin:refreshListIcon()
local flag=false
local costId=paramType.generate
local costCfg=self.config.useItem[self.stage][costId]

if costCfg then
flag=true
local costCount=costCfg[1]
local name=iconHelper.getIconName(costCount[1])
local count=string.format("定制费用:%s",costCount[2])
local haveCount=itemsModel.getCount(costCount[1])
local value=mathHelper.formatNumber(haveCount,1)
self.moneyIcon:setIcon(name)
self.moneyCnt:setText(count)

self.haveMoneyIcon:setIcon(name)
self.haveMoneyCnt:setText(value)
end

self.moneyIcon:setActive(flag)
self.moneyCnt:setActive(flag)
end


function UISubAct_dzdzWin:refreshListSuitPanle()
local flag=self.suitId>0

self.moneyIcon:setActive(flag)


if flag then
local cfg=equipsConfig.getSuitConfig(self.suitId)
local iconName=equipsHelper.getEquipSuitIconById(self.suitId)
self.customSuitIcon:setIcon(iconName)
self.customSuitText:setText(cfg.name)
self.p2CutAttrName:setText(cfg.attr2desc)
self.p3CutAttrDesc:setText(cfg.attr3desc)
end
end


function UISubAct_dzdzWin:refreshListAttrScrollviewRoot()
local len=4

self.refineAttr1ScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.refineAttr1ScrollView:getChildScrollViewItemWidgets()

if self.equipId>0 then
local attr
local cfg=itemsConfig.getConfig(self.equipId)
local static=cfg.static
local baseAttrsLookup=equipsHelper.getJinglianBaseAttrs(self.equipId,8)

if static then
for i=1,2 do
attr=cfg.static[i]

if attr then
local attrValue=attr[2]
self.baseAttrRootList1[i]:setActive(true)
self.baseAttrRefList1[i]:setActive(false)
if self.jinglianlv>0 then
attrValue=baseAttrsLookup[attr[1]]
end

local name,value=equipsHelper.getAttr(attr[1],attrValue)
self.baseAttrNameList1[i]:setText(name)
self.baseAttrValueList1[i]:setText(value)
else
self.baseAttrRootList1[i]:setActive(false)
end
end
end
end

for i=1,len do
local widget=grids[i-1]
local state=self.attrLen>0 or false

widget:SetChildActive(attrRefineIndex.item,true)
widget:SetChildActive(attrRefineIndex.name,state)
widget:SetChildActive(attrRefineIndex.value,state)
widget:SetChildActive(attrRefineIndex.arrow,false)
widget:SetChildActive(attrRefineIndex.addText,false)

if state then
local attrColor
local data=self.attrList[i]
local cfg=itemsConfig.getConfig(self.equipId)

if data then
if cfg then
attrColor=_getAttrColor(data.param_1,data.param_2,cfg.stage)
else
attrColor=0
end

local name,value=equipsHelper.getAttr(data.param_1,data.param_2)
local nameStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],name)
local valStr=string.format("<color=%s>%s</color>",_colorFormat[attrColor],value)
local iconName=iconList[attrColor]
local bgName=bgList[attrColor]

widget:SetChildText(attrRefineIndex.name,nameStr)
widget:SetChildText(attrRefineIndex.value,valStr)
widget:SetChildCSImageSprite(attrRefineIndex.icon,AbName,iconName)
widget:SetChildCSImageSprite(attrRefineIndex.back,AbName,bgName)

if self.attrRefineLen>0 then
for j=1,self.attrRefineLen do
if self.attrRefineList[j]then

if self.attrRefineList[j].param_1==data.param_1 then
local str=string.format("x%s",self.attrRefineList[j].param_2)
widget:SetChildActive(attrRefineIndex.arrow,true)
widget:SetChildActive(attrRefineIndex.addText,true)
widget:SetChildText(attrRefineIndex.addText,str)
end
end
end
else
widget:SetChildActive(attrRefineIndex.arrow,false)
widget:SetChildActive(attrRefineIndex.addText,false)
end
else
widget:SetChildActive(attrRefineIndex.item,false)
end
end
end
end


function UISubAct_dzdzWin:refreshItemBase()
if self.equipId>0 then
local itemid=self.equipId
local iconName=iconHelper.getIconName(itemid)
local showStage=self.stage~=nil
local stageStr=showStage and string.format('%s阶',self.stage)or''
local jinglianStr=self.jinglianlv>0 and string.format('+%s',self.jinglianlv)or''

local widgetRoot=self.ItemBaseRoot:getChildWidgetBase()
local widget=widgetRoot:GetChildWidgetBase(0)
widget:SetChildQulaityEx(_itemWidgetIdx.cmpItemQualityIdx,0,self.data.color)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIcon,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemCountBg,jinglianStr~='')
end
end


function UISubAct_dzdzWin:refreshScrollviewRoot()
local equipLen=#self.equipList
local armorLen=#self.armorList

if equipLen>0 then
self.equipScrollView:setChildScrollViewCreateGrids(equipLen,4)
local grids=self.equipScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local datas=self.equipList[i]
local widget=grids[i-1]

widget:SetChildText(ItemIndex.text,datas.part_name)
widget:SetChildActive(ItemIndex.select,self.selectIndex==i)
local iconName=string.format("image_dingzhidazao_tb%s",datas.icon)
widget:SetChildCSImageSprite(ItemIndex.icon,abname,iconName)
widget:SetChildButtonClick(ItemIndex.item,function()
self:onPartClick(datas.id)
end)
end
else
self.equipScrollView:setActive(false)
end

if armorLen>0 then
self.armorScrollView:setChildScrollViewCreateGrids(armorLen,3)
local grids=self.armorScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local datas=self.armorList[i]
local widget=grids[i-1]

if self.selectIndex then
if self.selectIndex>8 then
local index=i+8
widget:SetChildActive(ItemIndex.select,self.selectIndex==index)
else
widget:SetChildActive(ItemIndex.select,false)
end
end

widget:SetChildText(ItemIndex.text,datas.part_name)
local iconName=string.format("image_dingzhidazao_tb%s",datas.icon)
widget:SetChildCSImageSprite(ItemIndex.icon,abname,iconName)
widget:SetChildButtonClick(ItemIndex.item,function()
self:onPartClick(datas.id)
end)
end
else
self.armorScrollView:setActive(false)
end
end


function UISubAct_dzdzWin:refreshEquipItemBase()
self:refreshSuitIcon()
if self.equipId>0 then
local itemid=self.equipId
local iconName=iconHelper.getIconName(itemid)
local showStage=self.stage~=nil
local stageStr=showStage and string.format('%s阶',self.stage)or''
local jinglianStr=self.jinglianlv>0 and string.format('+%s',self.jinglianlv)or''

local widgetRoot=self.equipItemBaseRoot:getChildWidgetBase()
local widget=widgetRoot:GetChildWidgetBase(0)
widget:SetChildQulaityEx(_itemWidgetIdx.cmpItemQualityIdx,0,self.data.color)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIcon,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemCountBg,jinglianStr~='')
end
end


function UISubAct_dzdzWin:refreshBillListPanel()
local str
local rate=0

for i=1,4 do
self.checkList[i]:setActive(self.customStateList[i])
self.selectList[i]:setActive(false)
end

if self.pageIndex>0 then
rate=self.rateList[self.pageIndex]
self.selectList[self.pageIndex]:setActive(true)
self.checkList[self.pageIndex]:setActive(false)
end

self.Slider:setProgressValue(rate,100)
local costCountCfg=self.config.useItem[self.stage][8]
if costCountCfg then
local costCount=costCountCfg[1]
self.dzIcon:setActive(true)
self.dzCount:setActive(true)
local name=iconHelper.getIconName(costCount[1])
local count=costCount[2]
self.dzIcon:setIcon(name)
self.dzCount:setText(count)
else
self.dzIcon:setActive(false)
self.dzCount:setActive(false)
end

end


function UISubAct_dzdzWin:refreshBillStateList()
for i=1,4 do
self.customStateList[i]=false
end

if self.type1>0 then self.customStateList[1]=true end
if self.suitId>0 then self.customStateList[2]=true end
if self.attrLen>0 then self.customStateList[3]=true end
if self.jinglianlv>0 then self.customStateList[4]=true end
end


function UISubAct_dzdzWin:refreshAttrBtnIcon()
local flag=false
local costId=paramType.refAttr
local costCfg=self.config.useItem[self.stage][costId]

if costCfg then
flag=true
local costCount=costCfg[1]
local name=iconHelper.getIconName(costCount[1])
local count=costCount[2]
self.refAttrIcon:setIcon(name)
self.refAttrCount:setText(count)
end

self.refAttrIcon:setActive(flag)
self.refAttrCount:setActive(flag)
end


function UISubAct_dzdzWin:refreshRefBtnText()
local str
local costId
if self.jinglianlv>0 then
str="重铸精炼"
costId=paramType.recast
else
str="精炼+8"
costId=paramType.refine
end

self.refineAttrBtnText:setText(str)
local costCountCfg=self.config.useItem[self.stage][costId]
if costCountCfg then
self.refineIcon:setActive(true)
self.refineCount:setActive(true)
local costCount=costCountCfg[1]
local name=iconHelper.getIconName(costCount[1])
local count=costCount[2]
self.refineIcon:setIcon(name)
self.refineCount:setText(count)
else
self.refineIcon:setActive(false)
self.refineCount:setActive(false)
end
end


function UISubAct_dzdzWin:refreshSuitBtn()
local str
local costId=0

if self.suitId>0 then
str="刷新套装"
costId=paramType.refSuit
else
str="定制套装"
costId=paramType.custSuit
end

self.customBtnText:setText(str)
local costCountCfg=self.config.useItem[self.stage][costId]
if costCountCfg then
self.dzSuitIcon:setActive(true)
self.dzSuitCount:setActive(true)
local costCount=costCountCfg[1]
local name=iconHelper.getIconName(costCount[1])
local count=costCount[2]
self.dzSuitIcon:setIcon(name)
self.dzSuitCount:setText(count)
else
self.dzSuitIcon:setActive(false)
self.dzSuitCount:setActive(false)
end
end


function UISubAct_dzdzWin:onPartClick(index)

if self.selectIndex==index then return end

if self.selectIndex>0 and self.suitId>0 then
local show_data={
type='UIDialouge',
title='提示',
content='如果重新定制部位,之前定制的所有内容将会重置,是否继续？',
oktext='确定',
canceltext='取消',
okcallback=function()
self.type1=self.partConfig[index].type1
self.type2=self.partConfig[index].type2

if self.type1>0 then
local list={200,self.type1,self.type2}
self:clickNextStepBtn(list)
end
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self.type1=self.partConfig[index].type1
self.type2=self.partConfig[index].type2

if self.type1>0 then
local list={200,self.type1,self.type2}
self:clickNextStepBtn(list)
end
end
end


function UISubAct_dzdzWin:checkNextStepBtnState(pageIndex)
local tipsText=self.config.tipsText
if pageIndex==1 then
if self.selectIndex>0 then return false end
elseif pageIndex==2 then
if self.suitId>0 then return false end
elseif pageIndex==3 then
if self.attrLen>0 then return false end
elseif pageIndex==4 then
if self.jinglianlv>0 then return false end
end
return tipsText[pageIndex]
end


function UISubAct_dzdzWin:clickNextStepBtn(params)











local jstr=jsonHelper.encode(params)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jstr)
end


function UISubAct_dzdzWin:initPartConfigData()
self.equipList={}
self.armorList={}

for k,v in ipairs(self.partConfig)do
if v.type1==1 then
table.insert(self.equipList,v)
else
table.insert(self.armorList,v)
end
end
end

function UISubAct_dzdzWin:creatSelfList()
self.rateList={0,35,70,100}

self.stepText=
{
[1]="定制部位",
[2]="定制套装",
[3]="定制属性",
[4]="定制精炼",
}

self.checkList=
{
[1]=self.customCheck1,
[2]=self.customCheck2,
[3]=self.customCheck3,
[4]=self.customCheck4,
}

self.selectList=
{
[1]=self.customSelect1,
[2]=self.customSelect2,
[3]=self.customSelect3,
[4]=self.customSelect4,
}


self.customStateList=
{
[1]=false,
[2]=false,
[3]=false,
[4]=false,
}

self.baseAttrRootList=
{
[1]=self.refineBasisAttr1,
[2]=self.refineBasisAttr2,
}

self.baseAttrRefList=
{
[1]=self.refineBasisAttr1Refine,
[2]=self.refineBasisAttr2Refine,
}

self.baseAttrNameList=
{
[1]=self.refineBasisAttr1Name,
[2]=self.refineBasisAttr2Name,
}
self.baseAttrValueList=
{
[1]=self.refineBasisAttr1Value,
[2]=self.refineBasisAttr2Value,
}

self.baseAttrRootList1=
{
[1]=self.basisAttr1,
[2]=self.basisAttr2,
}

self.baseAttrRefList1=
{
[1]=self.basisAttr1Refine,
[2]=self.basisAttr2Refine,
}

self.baseAttrNameList1=
{
[1]=self.basisAttr1Name,
[2]=self.basisAttr2Name,
}
self.baseAttrValueList1=
{
[1]=self.basisAttr1Value,
[2]=self.basisAttr2Value,
}
end

function UISubAct_dzdzWin:clearSelfList()
self.stepText=nil
self.rateList=nil
self.checkList=nil
self.selectList=nil
self.customStateList=nil

self.baseAttrRootList=nil
self.baseAttrRefList=nil
self.baseAttrNameList=nil
self.baseAttrValueList=nil

self.baseAttrRootList1=nil
self.baseAttrRefList1=nil
self.baseAttrNameList1=nil
self.baseAttrValueList1=nil
end

function UISubAct_dzdzWin:onClickClose()
self.customListWin:setActive(false)
self.customListWinFlag=false
UIManager:showWindow('UITopMoneyWin2',{{10618},{10619}})
end

function UISubAct_dzdzWin:onCheckCostEnough(index)
local costCountCfg=self.config.useItem[self.stage][index]
if not costCountCfg then
return true
end
local costCount=costCountCfg[1]
local useCount=costCount[2]
local haveCount=itemsModel.getCount(costCount[1])

if haveCount>=useCount then
return true
end

gainControl:showGainWin(costCount[1])
return false
end

function UISubAct_dzdzWin:onCheckCostEnoughToFinish(index)
local finCost=0
local finCfg=self.config.useItem[self.stage][paramType.generate]
if finCfg then
finCost=finCfg[1][2]
end

local costCountCfg=self.config.useItem[self.stage][index]
if not costCountCfg then
return true
end

local costCount=costCountCfg[1]
local useCount=costCount[2]
local haveCount=itemsModel.getCount(costCount[1])

if haveCount-useCount>=finCost then
return true
end


return false
end

function UISubAct_dzdzWin:doSpeaking_player(index)
local index=index or self.pageIndex
local speed=30
local speakStr=this.talkCfg[index]

this.winlua:SetChildCanvasGroupAlpha(self.speakObj:getID(),1)
this.winlua:SetChildTrendsTextPlay(self.speakText:getID(),speakStr,speed,nil)
this:doTalkAnim_player()
end

function UISubAct_dzdzWin:doTalkAnim_player()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end

self.winlua:SetChildScale(self.speakObj:getID(),Vector3.zero)
self.doTalk=self:delayDo(0.2,function()
self.talkTween=self.winlua:SetChildDOScaleY(self.speakObj:getID(),1.2,0.2,function()
if self==nil then return end
self.talkTween=nil
self.talkTween=self.winlua:SetChildDOScale(self.speakObj:getID(),0.8,0.1,function()
if self==nil then return end
self.talkTween=nil
return self:talkEnd()
end)
end)
end)
end

function UISubAct_dzdzWin:talkEnd()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(1.5,function()

if self==nil then return end
self.winlua:SetChildScale(self.speakObj:getID(),Vector3.zero)
self.winlua:SetChildCanvasGroupAlpha(self.speakObj:getID(),0)

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end)
end

function UISubAct_dzdzWin:clearAllTimer()
if self.doTalk then
self:stopTimerByID(self.doTalk)
self.doTalk=nil
end
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UISubAct_dzdzWin:npcWalkAnim()
local pos={148,-80}
self.refreshTimeFunc=function()
local fun=function()
if self==nil then return end
this.npcWidget:SetChildModelAnimationState(1,eAnimationID.jump2)
this.npcWidget:SetChildCanvasGroupDOFade(1,0,0.2,nil)
this:doSpeaking_player(4)
local tweener=this.npcWidget:SetChildDOAnchorPosY(0,pos[2],0.4,function()
this.npcWidget:SetChildCanvasGroupDOFade(1,1,0.2,nil)
this.npcWidget:SetChildModelAnimationState(1,eAnimationID.attack2)
end)
tweener:SetEase(_Ease.Linear)
end
if self==nil then return end
this.npcWidget:SetChildModelAnimationState(1,eAnimationID.walk)

local tweener=this.npcWidget:SetChildDOAnchorPosX(0,pos[1],2,fun)
tweener:SetEase(_Ease.Linear)
end
self.refreshTimeFunc()
self.refreshTimeId=self:setTimer(0.2,1,self.refreshTimeFunc)
end


function UISubAct_dzdzWin:onHide()
self.winlua:SetChildScale(self.speakObj:getID(),Vector3.zero)
self.winlua:SetChildCanvasGroupAlpha(self.speakObj:getID(),0)
self:clearAllTimer()
self:clearPageAnim()
UIManager:closeWindow('UITopMoneyWin2')
end




function UISubAct_dzdzWin:onCustomizationBtn()
local level=playerModel:getActorLevel()or 1
local limitLevel=self.config.level
if level<limitLevel then
local str=string.format("宗门等级达%s级方可定制",limitLevel)
UIManager.error(str)
return
end

if self.activityData.data.free<1 or self:onCheckCostEnough(paramType.star)then
self.bgModel1:setChildModelAnimationState(animId.change,1,function()
self.bgModel2:setActive(true)
self.root:setChildCanvasGroupDOFade(1,0.2,function()
self:clickNextStepBtn({paramType.star})
end)
end)











else
UIManager.info("道具数量不够")
gainControl:showGainWin(10618)
end
end


function UISubAct_dzdzWin:onPropIcon()
end


function UISubAct_dzdzWin:onLastStepBtn()
self.pageIndex=self.pageIndex-1
self:flipPageAnim(self.bgModelId[1])
self:clearAllTimer()
self:doSpeaking_player()
end


function UISubAct_dzdzWin:onNextStepBtn()
local str=self:checkNextStepBtnState(self.pageIndex)
if str then
UIManager.info(str)
else
self.pageIndex=self.pageIndex+1

self:flipPageAnim(self.bgModelId[1])
self:clearAllTimer()
self:doSpeaking_player()
end
end


function UISubAct_dzdzWin:onConfirmListBtn()
self:refreshCustomListWin()
end


function UISubAct_dzdzWin:onDzIcon()
end


function UISubAct_dzdzWin:onCustomBtn()
local cutTime=timeHelper.getServerShortTime()
if self.onCustomBtnClickTime and cutTime-self.onCustomBtnClickTime<=0.5 then
UIManager.info("祖师手速太快啦")
return
end
self.onCustomBtnClickTime=cutTime

local list
local text
if self.suitId==0 then
list={paramType.custSuit}
text="定制套装将会导致天银数量不足以完成打造，是否继续？"
else
list={paramType.refSuit}
text="刷新套装将会导致天银数量不足以完成打造，是否继续？"
end

local cost
local costCount=0
local costCountCfg=self.config.useItem[self.stage][list[1]]
if costCountCfg then
cost=costCountCfg[1]
costCount=cost[1]
end

if not self:onCheckCostEnough(list[1])then
UIManager.info("道具数量不够")
elseif not self:onCheckCostEnoughToFinish(list[1])then
local show_data={
type='UIDialouge',
title='提示',
content=text,
oktext='确定',
canceltext='前往获取',
okcallback=function()
self:clickNextStepBtn(list)
end,
cancelcallback=function()
gainControl:showGainWin(costCount)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self:clickNextStepBtn(list)
self.refreshSuit=true
end
end


function UISubAct_dzdzWin:onDzSuitIcon()
end


function UISubAct_dzdzWin:onRefreshAttrBtn()
local cost
local costCount=0
local costCountCfg=self.config.useItem[self.stage][paramType.refAttr]
if costCountCfg then
cost=costCountCfg[1]
costCount=cost[1]
end

local cutTime=timeHelper.getServerShortTime()
if self.RefreshAttrBtnClickTime and cutTime-self.RefreshAttrBtnClickTime<=0.5 then
UIManager.info("祖师手速太快啦")
return
end
self.RefreshAttrBtnClickTime=cutTime

local list={paramType.refAttr}
if not self:onCheckCostEnough(paramType.refAttr)then
UIManager.info("道具数量不够")
elseif not self:onCheckCostEnoughToFinish(paramType.refAttr)then
local show_data={
type='UIDialouge',
title='提示',
content='刷新随机属性将会导致天银数量不足以完成打造，是否继续？',
oktext='确定',
canceltext='前往获取',
okcallback=function()
self.refreshRAttr=true
self:clickNextStepBtn(list)
end,
cancelcallback=function()
gainControl:showGainWin(costCount)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self.refreshRAttr=true
self:clickNextStepBtn(list)
end
end


function UISubAct_dzdzWin:onReplaceAttrBtn()
local list={paramType.repAttr}

if self.attrRefreshLen>0 then
if self.jinglianlv>0 then
local show_data={
type='UIDialouge',
title='提示',
content='替换随机属性将会重置精炼强化，是否继续？',
oktext='确定',
canceltext='取消',
okcallback=function()
self.refreshRplace=true
self:clickNextStepBtn(list)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local show_data={
type='UIDialouge',
title='提示',
content='是否确认替换当前的随机属性？',
oktext='确定',
canceltext='取消',
okcallback=function()
self.refreshRplace=true
self:clickNextStepBtn(list)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
else
UIManager.info("请先刷新属性")
end

end


function UISubAct_dzdzWin:onRefAttrIcon()
end


function UISubAct_dzdzWin:onRefineAttrBtn()
local cutTime=timeHelper.getServerShortTime()
if self.onRefineAttrBtnClickTime and cutTime-self.onRefineAttrBtnClickTime<=0.5 then
UIManager.info("祖师手速太快啦")
return
end
self.onRefineAttrBtnClickTime=cutTime

local list
local text
if self.jinglianlv>0 then
list={paramType.recast}
text="重铸精炼将会导致天银数量不足以完成打造，是否继续？"
else
list={paramType.refine}
text="精炼+8将会导致天银数量不足以完成打造，是否继续？"
end

local cost
local costCount=0
local costCountCfg=self.config.useItem[self.stage][paramType.refAttr]
if costCountCfg then
cost=costCountCfg[1]
costCount=cost[1]
end

self.refreshRef=true
if not self:onCheckCostEnough(list[1])then
UIManager.info("道具数量不够")
elseif not self:onCheckCostEnoughToFinish(list[1])then
local show_data={
type='UIDialouge',
title='提示',
content=text,
oktext='确定',
canceltext='前往获取',
okcallback=function()
self:clickNextStepBtn(list)
end,
cancelcallback=function()
gainControl:showGainWin(costCount)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self:clickNextStepBtn(list)
end
end


function UISubAct_dzdzWin:onRefineIcon()
end


function UISubAct_dzdzWin:onCustomMakeBtn()
local pos={560,-310}
local list={paramType.generate}

if not self:onCheckCostEnough(paramType.generate)then
UIManager.info("道具数量不够")
else
local cb=function()
self.root:setChildCanvasGroupDOFade(0,3.4,function()
self.root:setActive(true)
self:clickNextStepBtn(list)
UIManager:closeWindow("UISubAct_dzdzMaskWin")
self.root:setChildCanvasGroupDOFade(1,1,nil)





self.bgModel1:setChildUIModelShowTarget(self.bgModelId[3],1,{},animId.stand,false,false,0,nil)
end)
end
self:onClickClose()
self.root:setActive(false)
self.bgModel2:setActive(false)
UIManager:showWindow("UISubAct_dzdzMaskWin")
self.bgModel1:setChildUIModelShowTarget(self.bgModelId[3],1,{},animId.stand2,false,false,0,cb)


end
end


function UISubAct_dzdzWin:onAddMoneyBtn()
if self.config.useItem[self.stage][paramType.generate]then
local cost=self.config.useItem[self.stage][paramType.generate][1]
gainControl:showGainWin(cost[1])
end

end

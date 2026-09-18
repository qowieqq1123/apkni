







def_class("UIWenXinGuanTransferDevilWin",UIWindowBase)









function UIWenXinGuanTransferDevilWin:bindComponents()

self.BtnTransfer=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.closeMask=UIButton.get(self,2)
self.correctBtn=UIButton.get(self,3)
self.devilBg=UIObject.get(self,4)
self.effect=UIObject.get(self,5)
self.Effect_devil=UIObject.get(self,6)
self.Effect_stand=UIObject.get(self,7)
self.iconDevil=UIObject.get(self,8)
self.iconImmortal=UIObject.get(self,9)
self.iconPeople=UIImage.get(self,10)
self.job=UIImage.get(self,11)
self.levelText=UIText.get(self,12)
self.moAttrContent=UIObject.get(self,13)
self.moAttrPercent=UIText.get(self,14)
self.modelDevilRoot=UIObject.get(self,15)
self.modelRoot=UIObject.get(self,16)
self.moneyBg=UIButton.get(self,17)
self.moneyIcon=UIImage.get(self,18)
self.moneyNum=UIText.get(self,19)
self.moTransferCost=UIText.get(self,20)
self.moTransferMoneyIcon=UIImage.get(self,21)
self.moTransferPreviewBtn=UIButton.get(self,22)
self.moTransSuccRoot=UIObject.get(self,23)
self.progress=UIObject.get(self,24)
self.Root=UIObject.get(self,25)
self.skillItem_1=UIButton.get(self,26)
self.skillItem_2=UIButton.get(self,27)
self.skillItem_3=UIButton.get(self,28)
self.skillPanel=UIObject.get(self,29)
self.transferBtn=UIButton.get(self,30)
self.transferBtnText=UIText.get(self,31)
self.uiPanel=UIObject.get(self,32)

self.BtnTransfer:setButtonClick(function()self:onBtnTransfer()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.closeMask:setButtonClick(function()self:onCloseMask()end)

self.correctBtn:setButtonClick(function()self:onCorrectBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.moTransferPreviewBtn:setButtonClick(function()self:onMoTransferPreviewBtn()end)

self.skillItem_1:setButtonClick(function()self:onSkillItem_1()end)

self.skillItem_2:setButtonClick(function()self:onSkillItem_2()end)

self.skillItem_3:setButtonClick(function()self:onSkillItem_3()end)

self.transferBtn:setButtonClick(function()self:onTransferBtn()end)
self.skillItem={
self.skillItem_1,
self.skillItem_2,
self.skillItem_3,
}
self.Effect={
["devil"]=self.Effect_devil,
["stand"]=self.Effect_stand,
}



end


function UIWenXinGuanTransferDevilWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BtnTransfer);self.BtnTransfer=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeMask);self.closeMask=nil;
_UIObject_release(self.correctBtn);self.correctBtn=nil;
_UIObject_release(self.devilBg);self.devilBg=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.Effect_devil);self.Effect_devil=nil;
_UIObject_release(self.Effect_stand);self.Effect_stand=nil;
_UIObject_release(self.iconDevil);self.iconDevil=nil;
_UIObject_release(self.iconImmortal);self.iconImmortal=nil;
_UIObject_release(self.iconPeople);self.iconPeople=nil;
_UIObject_release(self.job);self.job=nil;
_UIObject_release(self.levelText);self.levelText=nil;
_UIObject_release(self.moAttrContent);self.moAttrContent=nil;
_UIObject_release(self.moAttrPercent);self.moAttrPercent=nil;
_UIObject_release(self.modelDevilRoot);self.modelDevilRoot=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moTransferCost);self.moTransferCost=nil;
_UIObject_release(self.moTransferMoneyIcon);self.moTransferMoneyIcon=nil;
_UIObject_release(self.moTransferPreviewBtn);self.moTransferPreviewBtn=nil;
_UIObject_release(self.moTransSuccRoot);self.moTransSuccRoot=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.skillItem_1);self.skillItem_1=nil;
_UIObject_release(self.skillItem_2);self.skillItem_2=nil;
_UIObject_release(self.skillItem_3);self.skillItem_3=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.transferBtn);self.transferBtn=nil;
_UIObject_release(self.transferBtnText);self.transferBtnText=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
self.skillItem=nil;
self.Effect=nil;
end



















local endPos={35,30}
local immortalPosList={-241,-215,-188,-157,-123,-94,-66}
local devilPosList={237,209,183,152,118,88,60}

local abname="ui/windows/wenxinguan/wenxinguan_atlas_pak.ab"
local jobABName='ui/windows/wenxinguan/wenxinguanjob_atlas_pak.ab'


function UIWenXinGuanTransferDevilWin:onLoaded(...)
self:bindComponents()
self.moneyType=eMoneyType.mtMoQi
self.on_money_changed=function(mtype,last,curr)
if mtype==eMoneyType.mtMoQi then
self:refreshMoney()
end
end
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIWenXinGuanTransferDevilWin:__delete()
self:unbindComponents()
end




function UIWenXinGuanTransferDevilWin:onShow(argtable,afterOnloaded)
self.dzGuid=argtable.guid
if argtable.return_jump_param then
self.return_jump_param=argtable.return_jump_param
end

self:showBgModel()
self:showXMZPos()
self:refreshActorModel()
self:refreshSkillGrid()
self:refreshJobIcon()

self:refreshBtn()
self:refreshMoney()
end

function UIWenXinGuanTransferDevilWin:refreshMoney()
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.moneyType),false)
local moneyStr=mathHelper.formatNumber(itemsModel.getCount(self.moneyType),true)
self.moneyNum:setText(moneyStr)
end

function UIWenXinGuanTransferDevilWin:refreshBtn()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.dzGuid)
if jjlv>=baseCfg.voc_level then
self.transferBtn:setActive(false)
self.BtnTransfer:setActive(true)
local _,moTransferConsume=unpack(UIDiscipleModel:getDiscipleXianMoTransferConsume(self.dzGuid))
local moneyType,moneyCount=unpack(moTransferConsume)
local have=itemsModel.getCount(moneyType)
self.moTransferCost:setText(have<moneyCount and string.format("<color=#c82c2c>%d</color>",moneyCount)or moneyCount)
self.moTransferMoneyIcon:setChildIcon(iconHelper.getIconName(moTransferConsume[1]),false)
else
self.transferBtn:setActive(true)
self.BtnTransfer:setActive(false)
self.transferBtnText:setText(string.format("弟子境界达到\n<color=#FFBE56>[%s]</color>即可转职",UIDiscipleModel:getJJNameX(baseCfg.voc_level)))
end
end

function UIWenXinGuanTransferDevilWin:refreshJobIcon()
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local jobId=imageInfo.job
local iconName=jobXMType[jobId][2]
self.job:setCSImageSprite(jobABName,iconName)
end

function UIWenXinGuanTransferDevilWin:doFadePanel()
local tweener=self.Root:setChildCanvasGroupDOFade(1,0.5)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanTransferDevilWin:showXMZPos()
self.xmz_xian,self.xmz_mo=WenXinGuanModel:getDzXMZ(self.dzGuid)
self.iconPeople:setCSImageSprite(abname,iconXMType.devil)

if self.xmz_xian>0 then
if self.xmz_xian>=8 then
local pos=endPos[1]
self.iconImmortal:setChildDOAnchorPosX(0,0)
self.iconImmortal:setChildDOAnchorPosY(pos,0)
else
local pos=immortalPosList[self.xmz_xian]
self.iconImmortal:setChildDOAnchorPosX(pos,0)
end
end

if self.xmz_mo>0 then
if self.xmz_mo>=8 then
local pos=endPos[2]
self.iconDevil:setChildDOAnchorPosX(0,0)
self.iconDevil:setChildDOAnchorPosY(pos,0)
self.iconPeople:setChildDOAnchorPosY(-6,0)
self.winlua:SetChildScale(self.iconDevil:getID(),Vector3(0.8,0.8,0.8))
else
local pos=devilPosList[self.xmz_mo]
self.iconDevil:setChildDOAnchorPosX(pos,0)
end
end
end

function UIWenXinGuanTransferDevilWin:refreshActorModel()
local dzScale=1.2
local animId=eAnimationID.stand
local modelId_mmortal,modelId_devil=WenXinGuanModel:getDzXMSuit(self.dzGuid)

local info=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)

self.modelDevilRoot:setChildUIModelShowTarget(modelId_devil,dzScale,nil,animId)
self.modelDevilRoot:setChildUIModelShowFlipX(false)

dzScale=1
self.modelRoot:setChildUIModelShowTarget(modelParams.body,dzScale,modelParams.componets,animId)
self.modelRoot:setChildUIModelShowFlipX(true)
end

function UIWenXinGuanTransferDevilWin:showBgModel()
local animId=eAnimationID.stand
self.devilBg:setChildUIModelShowTarget(5522,1,{},animId,false,false,0)
end

function UIWenXinGuanTransferDevilWin:refreshSkillGrid()
self.skillList_immortal,self.skillList_devil=WenXinGuanModel:getDzXMSkill(self.dzGuid,true)
self.skillList=self.skillList_devil

if self.skillList then
self.skillCnt=#self.skillList
for i=1,self.skillCnt do
local skillId=self.skillList[i]
local item=self.skillItem[i]
if skillId then
item:setActive(true)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local iconName=iconHelper.getSkillIcon(skillCfg.icon)
item:setChildIcon(iconName,true)

else
self.skillItem[i]:setActive(false)
end
end
end
end

function UIWenXinGuanTransferDevilWin:skillBtnClick(skillID)
local args={
skillLv=1,
changLv=false,
fromCfg=true,
isShowSkill=true,
skillID=skillID,
dis_guid=self.dzGuid,
attend=eSkillTipsType.eDZSkill,
}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end


function UIWenXinGuanTransferDevilWin:onClickSkill(index,cfg)
local x=-146+78*(index-(self.skillCnt/2+0.5))
local name,icon,desc,bottomLeft
local skillCfg=cfg

if skillCfg then
name=skillCfg.name
icon=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("问心关技能id：%s读取配置失败",skillCfg.id)
end

desc=skillModel:getSkillDesc(skillCfg.id,1)
local halfVector=Vector2.right*0.5
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=halfVector,
anchoredPosition=Vector2.New(-270,220),
}
}
UIWenXinGuanTransferDevilWin:showWindow('UISimpleTeXingTipsWin',args)
end




function UIWenXinGuanTransferDevilWin:onCloseBtn()
fullScreenUI.clearAllCallback()
if not self.return_jump_param then

local guid=self.dzGuid
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
UIManager:showWindow('UIDiscipleJingJieWin',{guid=guid})
else
jumpManager:jump(self.return_jump_param)
end
end

function UIWenXinGuanTransferDevilWin:onCloseMask()
fullScreenUI.clearAllCallback()
local dis_guid=self.dzGuid
local startCallback=function()
UIManager:closeWindow("UIWenXinGuanTransferImmortalWin")
UIManager:closeWindow("UIWenXinGuanTransferDevilWin")
UIManager:closeWindow("UIWenXinGuanTransferWin")
UIManager:closeWindow("UIWenXinGuanUnknownWin")
UIFullDiscipleMainControl:showWindowInfo({dis_guid=dis_guid})
UIManager:showWindow("UIXianMoZhuanZhi_mainWin",dis_guid)
end
loadingControl.openCloud(startCallback,0.5)
end

function UIWenXinGuanTransferDevilWin:hideAndShow(flag)
self.progress:setActive(flag)
end

function UIWenXinGuanTransferDevilWin:onMoneyBg()
gainControl:showGainWin(self.moneyType)
end

function UIWenXinGuanTransferDevilWin:onCorrectBtn()
local startCallback=function()
self:hideAndShow(false)
UIManager:showWindow("UIWenXinGuanTransferWin",{guid=self.dzGuid})

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end

UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIWenXinGuanTransferDevilWin:onTransferPlayAnim()
self:refreshZhuanZhiAfterPanel()
self.closeBtn:setActive(false)
local fadeTime=0.5
self.job:setChildCanvasGroupDOFade(0,fadeTime)
self.skillPanel:setChildCanvasGroupDOFade(0,fadeTime)
self.winlua:SetChildUIModelShowFadeToColor(self.modelDevilRoot:getID(),Color.New(1,1,1,0),fadeTime,0,nil)
self.uiPanel:setChildCanvasGroupDOFade(0,fadeTime,function()
self.correctBtn:setActive(false)
self.progress:setActive(false)
self.BtnTransfer:setActive(false)
self.moTransferPreviewBtn:setActive(false)
self.job:setChildAnchoredPosition(Vector2(-250,140))
end)
self:delayDo(fadeTime,function()
self.modelRoot:setChildModelAnimationState(eAnimationID.walk,1)
self:delayDo(1.5,function()
self.modelRoot:setChildModelAnimationState(eAnimationID.run,1)
end)
self.winlua:SetCurveAniPlay(self.modelRoot:getID(),1,Vector3(-540,-320,0),Vector3(540,200,0),function()

self.modelRoot:setChildModelAnimationState(eAnimationID.attack7_2,1)
self.effect:setChildShowEffect(20624,true)
self:setSelfSpeak()
local delay=5.2
self:delayDo(delay,function()
self.winlua:SetChildUIModelShowFadeToColor(self.modelDevilRoot:getID(),Color.New(1,1,1,1),0,0,nil)
self.modelRoot:setActive(false)
end)
delay=delay+0.5
self:delayDo(delay,function()
self.job:setScale(Vector3(1.2,1.2,1.2))
self:setTransferSpeak()
self.modelDevilRoot:setChildModelAnimationState(eAnimationID.attack5,1)
self.job:setChildCanvasGroupDOFade(1,0.5)
self.job:setChildDOScale(1,0.5)
end)
delay=delay+1
self:delayDo(delay,function()
self.skillPanel:setChildCanvasGroupDOFade(1,0.5)
self.moTransSuccRoot:setChildCanvasGroupDOFade(1,0.5,function()
self.closeMask:setActive(true)
end)
end)
delay=delay+2.5
self:delayDo(delay,function()
self:removeSelfSpeak()
end)
end)
end)
end

function UIWenXinGuanTransferDevilWin:setSelfSpeak()
local lib=cfgHelper.get3(cfg_disciplevocconfig_get,1,"speakLib1",2)
local r=math.random(1,#lib)
local content=lib[r]
local parent=self.winlua:GetCommonComponent(self.modelRoot:getID(),'Transform')
if self.sHUD then
local hudWidget=_InstantiateManager.GetComponent(self.sHUD,'CSGUIWidgetBase')
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
self.sHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
if self.sHUD==id then
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,155)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
hudControl:removeHUD(id)
self.sHUD=nil
end
end)
end
end

function UIWenXinGuanTransferDevilWin:setTransferSpeak()
local lib=cfgHelper.get3(cfg_disciplevocconfig_get,1,"speakLib2",2)
local r=math.random(1,#lib)
local content=lib[r]
local parent=self.winlua:GetCommonComponent(self.modelDevilRoot:getID(),'Transform')
if self.tHUD then
local hudWidget=_InstantiateManager.GetComponent(self.tHUD,'CSGUIWidgetBase')
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
self.tHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
if self.tHUD==id then
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,155)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
hudControl:removeHUD(id)
self.tHUD=nil
end
end)
end
end

function UIWenXinGuanTransferDevilWin:removeSelfSpeak()
if self.sHUD then
_InstantiateManager.RemoveInstance(self.sHUD)
self.sHUD=nil
end
if self.tHUD then
_InstantiateManager.RemoveInstance(self.tHUD)
self.tHUD=nil
end
end

function UIWenXinGuanTransferDevilWin:refreshZhuanZhiAfterPanel()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local voc=UIDiscipleModel:getDiscipleJob(self.dzGuid)
local attrPercent=self.moAttrPercent
local attrContent=self.moAttrContent
local attrList=baseCfg.attr2[voc]
attrPercent:setText(string.format("境界修为属性+%d%%",baseCfg.jingjie_attr_add))
attrContent:setChildLayoutGroupCreateItems(#attrList,function(index)
local item=attrContent:getChildLayoutGroupGridItem(index-1)
local attrType,attrValue=unpack(attrList[index])
local attrConfig=cfg_attributesconfig_get(attrType)
local name=attrConfig.attrname
local valStr=helper.getAttributeStrEx(attrType,attrValue)
item:SetChildText(0,name)
item:SetChildText(1,string.format("+%s",valStr))
end)
end


function UIWenXinGuanTransferDevilWin:onBtnTransfer()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.dzGuid)
if jjlv>=baseCfg.voc_level then
local voc_consume=UIDiscipleModel:getDiscipleXianMoTransferConsume(self.dzGuid)
local moTransferConsume=voc_consume[2]
local moneyType,moneyCount=unpack(moTransferConsume)
local moneyName=itemsModel.getName(moneyType)
local have=itemsModel.getCount(moneyType)
if have<moneyCount then
UIManager.error(string.format("%s不足",moneyName))
gainControl:showGainWin(moneyType)
return
end
local voc=UIDiscipleModel:getDiscipleJob(self.dzGuid)
local xm_voc=2
local name=UIDiscipleModel:getDiscipleName(self.dzGuid)
local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,voc)
local xm_name=vocCfg.xm_name[xm_voc]
local content=string.format('弟子%s将消耗%d点%s转职成为<color=#C82C2C>%s</color>职业，是否开始转职？',name,moneyCount,moneyName,xm_name)
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=function()
UIDiscipleController:reqXianMoTransfer(self.dzGuid,2)
end,
canvasIndex=8,
})
dialog:show()
else
UIManager.info(string.format("弟子境界需达到[%s]",UIDiscipleModel:getJJNameX(baseCfg.voc_level)))
end
end


function UIWenXinGuanTransferDevilWin:onSkillItem_1()
local index=1
local skillId=self.skillList[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferDevilWin:onSkillItem_2()
local index=2
local skillId=self.skillList[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferDevilWin:onSkillItem_3()
local index=3
local skillId=self.skillList[index]
self:skillBtnClick(skillId)


end

function UIWenXinGuanTransferDevilWin:onMoTransferPreviewBtn()
self:showWindow("UIXianMoZhuanZhi_transferPreviewWin",{2,self.dzGuid})
end


function UIWenXinGuanTransferDevilWin:onTransferBtn()
local netData=UIDiscipleModel:getDiscipleData(self.dzGuid)
local jjlv=netData.jingjielv
local show_broke=UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and
UIDiscipleModel:checkJJBrokeByHand(jjlv)

if show_broke then

UIManager.info("前往飞升台完成渡劫突破天仙期")
local buildID=SLG_SYSTEM_TYPE.eFeiShengTai2
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,buildID)
if next(bdDatas)and bdDatas[1].flag==0 then
local jumpParam={type=0,id=JUMP_TYPE.efeishengtai,args={}}
jumpManager:jump(jumpParam)
return
end
end

local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
UIManager.info(string.format("弟子境界需达到[%s]",UIDiscipleModel:getJJNameX(baseCfg.voc_level)))
end
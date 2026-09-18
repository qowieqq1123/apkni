







def_class("UIWenXinGuanTransferImmortalWin",UIWindowBase)









function UIWenXinGuanTransferImmortalWin:bindComponents()

self.blackMask=UIObject.get(self,0)
self.BtnTransfer=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.closeMask=UIButton.get(self,3)
self.correctBtn=UIButton.get(self,4)
self.effect=UIObject.get(self,5)
self.Effect_Immortal=UIObject.get(self,6)
self.Effect_stand=UIObject.get(self,7)
self.iconDevil=UIObject.get(self,8)
self.iconImmortal=UIObject.get(self,9)
self.iconPeople=UIImage.get(self,10)
self.immortalBg=UIObject.get(self,11)
self.job=UIImage.get(self,12)
self.levelText_Immortal=UIText.get(self,13)
self.modelImmortalRoot=UIObject.get(self,14)
self.modelRoot=UIObject.get(self,15)
self.moneyBg=UIButton.get(self,16)
self.moneyIcon=UIImage.get(self,17)
self.moneyNum=UIText.get(self,18)
self.progress=UIObject.get(self,19)
self.Root=UIObject.get(self,20)
self.skillItem_1=UIButton.get(self,21)
self.skillItem_2=UIButton.get(self,22)
self.skillItem_3=UIButton.get(self,23)
self.skillPanel=UIObject.get(self,24)
self.transferBtn=UIButton.get(self,25)
self.transferBtnText=UIText.get(self,26)
self.uiPanel=UIObject.get(self,27)
self.xianAttrContent=UIObject.get(self,28)
self.xianAttrPercent=UIText.get(self,29)
self.xianTransferCost=UIText.get(self,30)
self.xianTransferMoneyIcon=UIImage.get(self,31)
self.xianTransferPreviewBtn=UIButton.get(self,32)
self.xianTransSuccRoot=UIObject.get(self,33)

self.BtnTransfer:setButtonClick(function()self:onBtnTransfer()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.closeMask:setButtonClick(function()self:onCloseMask()end)

self.correctBtn:setButtonClick(function()self:onCorrectBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.skillItem_1:setButtonClick(function()self:onSkillItem_1()end)

self.skillItem_2:setButtonClick(function()self:onSkillItem_2()end)

self.skillItem_3:setButtonClick(function()self:onSkillItem_3()end)

self.transferBtn:setButtonClick(function()self:onTransferBtn()end)

self.xianTransferPreviewBtn:setButtonClick(function()self:onXianTransferPreviewBtn()end)
self.skillItem={
self.skillItem_1,
self.skillItem_2,
self.skillItem_3,
}
self.Effect={
["Immortal"]=self.Effect_Immortal,
["stand"]=self.Effect_stand,
}
self.levelText={
["Immortal"]=self.levelText_Immortal,
}



end


function UIWenXinGuanTransferImmortalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackMask);self.blackMask=nil;
_UIObject_release(self.BtnTransfer);self.BtnTransfer=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeMask);self.closeMask=nil;
_UIObject_release(self.correctBtn);self.correctBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.Effect_Immortal);self.Effect_Immortal=nil;
_UIObject_release(self.Effect_stand);self.Effect_stand=nil;
_UIObject_release(self.iconDevil);self.iconDevil=nil;
_UIObject_release(self.iconImmortal);self.iconImmortal=nil;
_UIObject_release(self.iconPeople);self.iconPeople=nil;
_UIObject_release(self.immortalBg);self.immortalBg=nil;
_UIObject_release(self.job);self.job=nil;
_UIObject_release(self.levelText_Immortal);self.levelText_Immortal=nil;
_UIObject_release(self.modelImmortalRoot);self.modelImmortalRoot=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.skillItem_1);self.skillItem_1=nil;
_UIObject_release(self.skillItem_2);self.skillItem_2=nil;
_UIObject_release(self.skillItem_3);self.skillItem_3=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.transferBtn);self.transferBtn=nil;
_UIObject_release(self.transferBtnText);self.transferBtnText=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.xianAttrContent);self.xianAttrContent=nil;
_UIObject_release(self.xianAttrPercent);self.xianAttrPercent=nil;
_UIObject_release(self.xianTransferCost);self.xianTransferCost=nil;
_UIObject_release(self.xianTransferMoneyIcon);self.xianTransferMoneyIcon=nil;
_UIObject_release(self.xianTransferPreviewBtn);self.xianTransferPreviewBtn=nil;
_UIObject_release(self.xianTransSuccRoot);self.xianTransSuccRoot=nil;
self.skillItem=nil;
self.Effect=nil;
self.levelText=nil;
end



















local endPos={35,30}
local immortalPosList={-241,-215,-188,-157,-123,-94,-66}
local devilPosList={237,209,183,152,118,88,60}

local abname="ui/windows/wenxinguan/wenxinguan_atlas_pak.ab"
local jobABName='ui/windows/wenxinguan/wenxinguanjob_atlas_pak.ab'


function UIWenXinGuanTransferImmortalWin:onLoaded(...)
self:bindComponents()
self.moneyType=eMoneyType.mtXianQi
self.on_money_changed=function(mtype,last,curr)
if mtype==eMoneyType.mtXianQi then
self:refreshMoney()
end
end
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIWenXinGuanTransferImmortalWin:__delete()
self:unbindComponents()
end




function UIWenXinGuanTransferImmortalWin:onShow(argtable,afterOnloaded)
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

function UIWenXinGuanTransferImmortalWin:refreshMoney()
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.moneyType),false)
local moneyStr=mathHelper.formatNumber(itemsModel.getCount(self.moneyType),true)
self.moneyNum:setText(moneyStr)
end

function UIWenXinGuanTransferImmortalWin:refreshBtn()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.dzGuid)
if jjlv>=baseCfg.voc_level then
self.transferBtn:setActive(false)
self.BtnTransfer:setActive(true)
local xianTransferConsume=unpack(UIDiscipleModel:getDiscipleXianMoTransferConsume(self.dzGuid))
local moneyType,moneyCount=unpack(xianTransferConsume)
local have=itemsModel.getCount(moneyType)
self.xianTransferCost:setText(have<moneyCount and string.format("<color=#c82c2c>%d</color>",moneyCount)or moneyCount)
self.xianTransferMoneyIcon:setChildIcon(iconHelper.getIconName(xianTransferConsume[1]),false)
else
self.transferBtn:setActive(true)
self.BtnTransfer:setActive(false)
self.transferBtnText:setText(string.format("弟子境界达到\n<color=#FFBE56>[%s]</color>即可转职",UIDiscipleModel:getJJNameX(baseCfg.voc_level)))
end
end

function UIWenXinGuanTransferImmortalWin:doFadePanel()
local tweener=self.Root:setChildCanvasGroupDOFade(1,1.5)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanTransferImmortalWin:showBgModel()
local animId=eAnimationID.stand
self.immortalBg:setChildUIModelShowTarget(5521,1,{},animId,false,false,0)
end

function UIWenXinGuanTransferImmortalWin:refreshJobIcon()
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local jobId=imageInfo.job
local iconName=jobXMType[jobId][1]
self.job:setCSImageSprite(jobABName,iconName)
end

function UIWenXinGuanTransferImmortalWin:showXMZPos()
self.xmz_xian,self.xmz_mo=WenXinGuanModel:getDzXMZ(self.dzGuid)
self.iconPeople:setCSImageSprite(abname,iconXMType.immortal)

if self.xmz_xian>0 then
if self.xmz_xian>=8 then
local pos=endPos[1]
self.iconImmortal:setChildDOAnchorPosX(0,0)
self.iconImmortal:setChildDOAnchorPosY(pos,0)
self.iconPeople:setChildDOAnchorPosY(-6,0)
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
else
local pos=devilPosList[self.xmz_mo]
self.iconDevil:setChildDOAnchorPosX(pos,0)
end
end
end

function UIWenXinGuanTransferImmortalWin:refreshActorModel()
local dzScale=1.2
local animId=eAnimationID.stand
local modelId_mmortal,modelId_devil=WenXinGuanModel:getDzXMSuit(self.dzGuid)

local info=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)

self.modelImmortalRoot:setChildUIModelShowTarget(modelId_mmortal,dzScale,nil,animId)
self.modelImmortalRoot:setChildUIModelShowFlipX(true)

dzScale=1
self.modelRoot:setChildUIModelShowTarget(modelParams.body,dzScale,modelParams.componets,animId)
self.modelRoot:setChildUIModelShowFlipX(false)
end

function UIWenXinGuanTransferImmortalWin:refreshSkillGrid()
self.skillList_immortal,self.skillList_devil=WenXinGuanModel:getDzXMSkill(self.dzGuid,true)
self.skillList=self.skillList_immortal

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

function UIWenXinGuanTransferImmortalWin:skillBtnClick(skillID)
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


function UIWenXinGuanTransferImmortalWin:onClickSkill(index,cfg)
local x=-146+78*(index-(self.skillCnt/2+0.5))
local name,icon,desc,bottomLeft
local skillCfg=cfg

if skillCfg then
name=skillCfg.name
icon=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("镇妖试炼怪物无效怪物特性:{0},{1},{2}")
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
anchoredPosition=Vector2.New(300,220),
}
}
UIWenXinGuanTransferImmortalWin:showWindow('UISimpleTeXingTipsWin',args)
end





function UIWenXinGuanTransferImmortalWin:onCloseBtn()
fullScreenUI.clearAllCallback()
if not self.return_jump_param then

local guid=self.dzGuid
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
UIManager:showWindow('UIDiscipleJingJieWin',{guid=guid})
else
jumpManager:jump(self.return_jump_param)
end
end

function UIWenXinGuanTransferImmortalWin:onCloseMask()
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

function UIWenXinGuanTransferImmortalWin:hideAndShow(flag)
self.progress:setActive(flag)
end

function UIWenXinGuanTransferImmortalWin:onMoneyBg()
gainControl:showGainWin(self.moneyType)
end

function UIWenXinGuanTransferImmortalWin:onCorrectBtn()
local startCallback=function()
self:hideAndShow(false)
UIManager:showWindow("UIWenXinGuanTransferWin",{guid=self.dzGuid})

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end

UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIWenXinGuanTransferImmortalWin:onTransferPlayAnim()
self:refreshZhuanZhiAfterPanel()
self.closeBtn:setActive(false)
local fadeTime=0.5
self.job:setChildCanvasGroupDOFade(0,fadeTime)
self.skillPanel:setChildCanvasGroupDOFade(0,fadeTime)
self.winlua:SetChildUIModelShowFadeToColor(self.modelImmortalRoot:getID(),Color.New(1,1,1,0),fadeTime,0,nil)
self.uiPanel:setChildCanvasGroupDOFade(0,fadeTime,function()
self.correctBtn:setActive(false)
self.progress:setActive(false)
self.BtnTransfer:setActive(false)
self.xianTransferPreviewBtn:setActive(false)
self.job:setChildAnchoredPosition(Vector2(250,140))
end)
self:delayDo(fadeTime,function()
self.modelRoot:setChildModelAnimationState(eAnimationID.walk,1)
self:delayDo(1.5,function()
self.modelRoot:setChildModelAnimationState(eAnimationID.run,1)
end)
self.winlua:SetCurveAniPlay(self.modelRoot:getID(),1,Vector3(540,-300,0),Vector3(-540,180,0),function()

self.modelRoot:setChildModelAnimationState(eAnimationID.attack7_2,1)
self.effect:setChildShowEffect(20623,true)
self.blackMask:setActive(true)
self:setSelfSpeak()
local delay=3.5
self:delayDo(delay,function()
self.winlua:SetChildUIModelShowFadeToColor(self.modelImmortalRoot:getID(),Color.New(1,1,1,1),0,0,nil)
self.modelRoot:setActive(false)
end)
delay=delay+0.5
self:delayDo(delay,function()
self.job:setScale(Vector3(1.2,1.2,1.2))
self:setTransferSpeak()
self.modelImmortalRoot:setChildModelAnimationState(eAnimationID.attack5,1)
self.job:setChildCanvasGroupDOFade(1,0.5)
self.job:setChildDOScale(1,0.5)
self.blackMask:setActive(false)
end)
delay=delay+1
self:delayDo(delay,function()
self.skillPanel:setChildCanvasGroupDOFade(1,0.5)
self.xianTransSuccRoot:setChildCanvasGroupDOFade(1,0.5,function()
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

function UIWenXinGuanTransferImmortalWin:setSelfSpeak()
local lib=cfgHelper.get3(cfg_disciplevocconfig_get,1,"speakLib1",1)
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

function UIWenXinGuanTransferImmortalWin:setTransferSpeak()
local lib=cfgHelper.get3(cfg_disciplevocconfig_get,1,"speakLib2",1)
local r=math.random(1,#lib)
local content=lib[r]
local parent=self.winlua:GetCommonComponent(self.modelImmortalRoot:getID(),'Transform')
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

function UIWenXinGuanTransferImmortalWin:removeSelfSpeak()
if self.sHUD then
_InstantiateManager.RemoveInstance(self.sHUD)
self.sHUD=nil
end
if self.tHUD then
_InstantiateManager.RemoveInstance(self.tHUD)
self.tHUD=nil
end
end

function UIWenXinGuanTransferImmortalWin:refreshZhuanZhiAfterPanel()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local voc=UIDiscipleModel:getDiscipleJob(self.dzGuid)
local attrPercent=self.xianAttrPercent
local attrContent=self.xianAttrContent
local attrList=baseCfg.attr1[voc]
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


function UIWenXinGuanTransferImmortalWin:onBtnTransfer()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.dzGuid)
if jjlv>=baseCfg.voc_level then
local voc_consume=UIDiscipleModel:getDiscipleXianMoTransferConsume(self.dzGuid)
local xianTransferConsume=voc_consume[1]
local moneyType,moneyCount=unpack(xianTransferConsume)
local moneyName=itemsModel.getName(moneyType)
local have=itemsModel.getCount(moneyType)
if have<moneyCount then
UIManager.error(string.format("%s不足",moneyName))
gainControl:showGainWin(moneyType)
return
end
local voc=UIDiscipleModel:getDiscipleJob(self.dzGuid)
local xm_voc=1
local name=UIDiscipleModel:getDiscipleName(self.dzGuid)
local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,voc)
local xm_name=vocCfg.xm_name[xm_voc]
local content=string.format('弟子%s将消耗%d点%s转职成为<color=#CA831D>%s</color>职业，是否开始转职？',name,moneyCount,moneyName,xm_name)
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=function()
UIDiscipleController:reqXianMoTransfer(self.dzGuid,1)
end,
canvasIndex=8,
})
dialog:show()
else
UIManager.info(string.format("弟子境界需达到[%s]",UIDiscipleModel:getJJNameX(baseCfg.voc_level)))
end
end


function UIWenXinGuanTransferImmortalWin:onSkillItem_1()
local index=1
local skillId=self.skillList[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferImmortalWin:onSkillItem_2()
local index=2
local skillId=self.skillList[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferImmortalWin:onSkillItem_3()
local index=3
local skillId=self.skillList[index]
self:skillBtnClick(skillId)


end

function UIWenXinGuanTransferImmortalWin:onXianTransferPreviewBtn()
self:showWindow("UIXianMoZhuanZhi_transferPreviewWin",{1,self.dzGuid})
end


function UIWenXinGuanTransferImmortalWin:onTransferBtn()
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
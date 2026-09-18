







def_class("UIWenXinGuanTransferWin",UIWindowBase)









function UIWenXinGuanTransferWin:bindComponents()

self.blackMask=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.closeMask=UIButton.get(self,2)
self.cloudModel=UIObject.get(self,3)
self.devilSkillItem_1=UIButton.get(self,4)
self.devilSkillItem_2=UIButton.get(self,5)
self.devilSkillItem_3=UIButton.get(self,6)
self.DevilSkillList=UIObject.get(self,7)
self.effect=UIObject.get(self,8)
self.Effect_stand=UIObject.get(self,9)
self.iconDevil=UIObject.get(self,10)
self.iconImmortal=UIObject.get(self,11)
self.iconPeople=UIImage.get(self,12)
self.immortalSkillItem_1=UIButton.get(self,13)
self.immortalSkillItem_2=UIButton.get(self,14)
self.immortalSkillItem_3=UIButton.get(self,15)
self.ImmortalSkillList=UIObject.get(self,16)
self.job=UIImage.get(self,17)
self.lockPanel=UIObject.get(self,18)
self.moAttrContent=UIObject.get(self,19)
self.moAttrPercent=UIText.get(self,20)
self.moBgMask=UIObject.get(self,21)
self.modelDevilRoot=UIObject.get(self,22)
self.modelImmortalRoot=UIObject.get(self,23)
self.modelRoot=UIObject.get(self,24)
self.moEffect=UIObject.get(self,25)
self.moTransferBtn=UIButton.get(self,26)
self.moTransferCost=UIText.get(self,27)
self.moTransferMoneyIcon=UIImage.get(self,28)
self.moTransferPreviewBtn=UIButton.get(self,29)
self.moTransSuccRoot=UIObject.get(self,30)
self.picture=UIObject.get(self,31)
self.progressBg=UIObject.get(self,32)
self.resetBtn=UIButton.get(self,33)
self.resetEmptyTips=UIText.get(self,34)
self.resetPanel=UIObject.get(self,35)
self.resetRewardContent=UIObject.get(self,36)
self.restCostTxt=UILinkImageText.get(self,37)
self.reverseBtn=UIButton.get(self,38)
self.reverseCostItem=UIBaseItem.get(self,39)
self.reverseDesc=UIText.get(self,40)
self.reverseEmptyTips=UIText.get(self,41)
self.reverseNewJob=UIText.get(self,42)
self.reverseOldJob=UIText.get(self,43)
self.reversePanel=UIObject.get(self,44)
self.reversePreviewBtn=UIButton.get(self,45)
self.reverseRewardContent=UIObject.get(self,46)
self.reverseRewardPanel=UIObject.get(self,47)
self.transferBtn=UIButton.get(self,48)
self.transferBtnText=UIText.get(self,49)
self.transferRoot=UIObject.get(self,50)
self.unlockPanel=UIObject.get(self,51)
self.xianAttrContent=UIObject.get(self,52)
self.xianAttrPercent=UIText.get(self,53)
self.xianBgMask=UIObject.get(self,54)
self.xianEffect=UIObject.get(self,55)
self.xianTransferBtn=UIButton.get(self,56)
self.xianTransferCost=UIText.get(self,57)
self.xianTransferMoneyIcon=UIImage.get(self,58)
self.xianTransferPreviewBtn=UIButton.get(self,59)
self.xianTransSuccRoot=UIObject.get(self,60)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.closeMask:setButtonClick(function()self:onCloseMask()end)

self.devilSkillItem_1:setButtonClick(function()self:onDevilSkillItem_1()end)

self.devilSkillItem_2:setButtonClick(function()self:onDevilSkillItem_2()end)

self.devilSkillItem_3:setButtonClick(function()self:onDevilSkillItem_3()end)

self.immortalSkillItem_1:setButtonClick(function()self:onImmortalSkillItem_1()end)

self.immortalSkillItem_2:setButtonClick(function()self:onImmortalSkillItem_2()end)

self.immortalSkillItem_3:setButtonClick(function()self:onImmortalSkillItem_3()end)

self.moTransferBtn:setButtonClick(function()self:onMoTransferBtn()end)

self.moTransferPreviewBtn:setButtonClick(function()self:onMoTransferPreviewBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.reverseBtn:setButtonClick(function()self:onReverseBtn()end)

self.reversePreviewBtn:setButtonClick(function()self:onReversePreviewBtn()end)

self.transferBtn:setButtonClick(function()self:onTransferBtn()end)

self.xianTransferBtn:setButtonClick(function()self:onXianTransferBtn()end)

self.xianTransferPreviewBtn:setButtonClick(function()self:onXianTransferPreviewBtn()end)
self.devilSkillItem={
self.devilSkillItem_1,
self.devilSkillItem_2,
self.devilSkillItem_3,
}
self.immortalSkillItem={
self.immortalSkillItem_1,
self.immortalSkillItem_2,
self.immortalSkillItem_3,
}
self.Effect={
["stand"]=self.Effect_stand,
}



end


function UIWenXinGuanTransferWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackMask);self.blackMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeMask);self.closeMask=nil;
_UIObject_release(self.cloudModel);self.cloudModel=nil;
_UIObject_release(self.devilSkillItem_1);self.devilSkillItem_1=nil;
_UIObject_release(self.devilSkillItem_2);self.devilSkillItem_2=nil;
_UIObject_release(self.devilSkillItem_3);self.devilSkillItem_3=nil;
_UIObject_release(self.DevilSkillList);self.DevilSkillList=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.Effect_stand);self.Effect_stand=nil;
_UIObject_release(self.iconDevil);self.iconDevil=nil;
_UIObject_release(self.iconImmortal);self.iconImmortal=nil;
_UIObject_release(self.iconPeople);self.iconPeople=nil;
_UIObject_release(self.immortalSkillItem_1);self.immortalSkillItem_1=nil;
_UIObject_release(self.immortalSkillItem_2);self.immortalSkillItem_2=nil;
_UIObject_release(self.immortalSkillItem_3);self.immortalSkillItem_3=nil;
_UIObject_release(self.ImmortalSkillList);self.ImmortalSkillList=nil;
_UIObject_release(self.job);self.job=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.moAttrContent);self.moAttrContent=nil;
_UIObject_release(self.moAttrPercent);self.moAttrPercent=nil;
_UIObject_release(self.moBgMask);self.moBgMask=nil;
_UIObject_release(self.modelDevilRoot);self.modelDevilRoot=nil;
_UIObject_release(self.modelImmortalRoot);self.modelImmortalRoot=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.moEffect);self.moEffect=nil;
_UIObject_release(self.moTransferBtn);self.moTransferBtn=nil;
_UIObject_release(self.moTransferCost);self.moTransferCost=nil;
_UIObject_release(self.moTransferMoneyIcon);self.moTransferMoneyIcon=nil;
_UIObject_release(self.moTransferPreviewBtn);self.moTransferPreviewBtn=nil;
_UIObject_release(self.moTransSuccRoot);self.moTransSuccRoot=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.progressBg);self.progressBg=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.resetEmptyTips);self.resetEmptyTips=nil;
_UIObject_release(self.resetPanel);self.resetPanel=nil;
_UIObject_release(self.resetRewardContent);self.resetRewardContent=nil;
_UIObject_release(self.restCostTxt);self.restCostTxt=nil;
_UIObject_release(self.reverseBtn);self.reverseBtn=nil;
_UIObject_release(self.reverseCostItem);self.reverseCostItem=nil;
_UIObject_release(self.reverseDesc);self.reverseDesc=nil;
_UIObject_release(self.reverseEmptyTips);self.reverseEmptyTips=nil;
_UIObject_release(self.reverseNewJob);self.reverseNewJob=nil;
_UIObject_release(self.reverseOldJob);self.reverseOldJob=nil;
_UIObject_release(self.reversePanel);self.reversePanel=nil;
_UIObject_release(self.reversePreviewBtn);self.reversePreviewBtn=nil;
_UIObject_release(self.reverseRewardContent);self.reverseRewardContent=nil;
_UIObject_release(self.reverseRewardPanel);self.reverseRewardPanel=nil;
_UIObject_release(self.transferBtn);self.transferBtn=nil;
_UIObject_release(self.transferBtnText);self.transferBtnText=nil;
_UIObject_release(self.transferRoot);self.transferRoot=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.xianAttrContent);self.xianAttrContent=nil;
_UIObject_release(self.xianAttrPercent);self.xianAttrPercent=nil;
_UIObject_release(self.xianBgMask);self.xianBgMask=nil;
_UIObject_release(self.xianEffect);self.xianEffect=nil;
_UIObject_release(self.xianTransferBtn);self.xianTransferBtn=nil;
_UIObject_release(self.xianTransferCost);self.xianTransferCost=nil;
_UIObject_release(self.xianTransferMoneyIcon);self.xianTransferMoneyIcon=nil;
_UIObject_release(self.xianTransferPreviewBtn);self.xianTransferPreviewBtn=nil;
_UIObject_release(self.xianTransSuccRoot);self.xianTransSuccRoot=nil;
self.devilSkillItem=nil;
self.immortalSkillItem=nil;
self.Effect=nil;
end



















local endPos={35,30}
local immortalPosList={-241,-215,-188,-157,-123,-94,-66}
local devilPosList={237,209,183,152,118,88,60}

local abname="ui/windows/wenxinguan/wenxinguan_atlas_pak.ab"


function UIWenXinGuanTransferWin:onLoaded(...)
self:bindComponents()
end


function UIWenXinGuanTransferWin:__delete()
self:unbindComponents()

UIManager:closeWindow('UITopMoneyWin2')
end




function UIWenXinGuanTransferWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.cloudModel:setChildUIModelShowTarget(5712,0.75,{},eAnimationID.stand,false,false,0)
end
self.dzGuid=argtable.guid
self.isFull=argtable.isFull
self.isReset=argtable.reset
self.isReverse=argtable.reverse
self.return_jump_param=argtable.return_jump_param
self.skillList_immortal,self.skillList_devil=WenXinGuanModel:getDzXMSkill(self.dzGuid,true)

self:showXMZPos()
self:refreshActorModel()
self:refreshSkillGrid(self.skillList_devil,true)
self:refreshSkillGrid(self.skillList_immortal)
self:refreshBtn()
if self.isReset then
self:refreshResetPanel()
elseif self.isReverse then
self:refreshReversePanel()
end

UIManager:showWindow('UITopMoneyWin2',{{eMoneyType.mtXianYu},{eMoneyType.mtLingYu},})
end


function UIWenXinGuanTransferWin:refreshResetPanel()
self.progressBg:setActive(false)
self.transferRoot:setActive(false)
self.resetPanel:setActive(true)
local resetGain=UIDiscipleModel:getDiscipleResetDaoHengGain(self.dzGuid)
self.resetEmptyTips:setActive(#resetGain<=0)
self.resetRewardContent:setChildLayoutGroupCreateItems(#resetGain,function(index)
local item=self.resetRewardContent:getChildLayoutGroupGridItem(index-1)
local itemid,itemnum=unpack(resetGain[index])
local conf={itemid=itemid,itemcount=itemnum>1 and tostring(itemnum)or"",showCountBG=itemnum>1,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
end)
local offsetnum=#resetGain-4
if offsetnum>0 then
self.resetRewardContent:setChildAnchoredPosition(Vector2(offsetnum*41,0))
end


local cost=UIDiscipleModel:getXianMoResetCost()
local costTips="消耗：免费"
if next(cost)then
local costItemId=cost[1]
local useCount=cost[2]
local iconname=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
costTips=FMT.fmt('消耗：{0}<color=#7d3b17>{1}</color>',iconStr,useCount)
end
self.restCostTxt:setText(costTips)
end


function UIWenXinGuanTransferWin:refreshReversePanel()
self.progressBg:setActive(false)
self.transferRoot:setActive(false)
self.reversePanel:setActive(true)
local dzName=UIDiscipleModel:getDiscipleName(self.dzGuid)
local voc=UIDiscipleModel:getDiscipleJob(self.dzGuid)
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.dzGuid)
local new_xm_voc=xm_voc==1 and 2 or 1
local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,voc)
local xm_name=vocCfg.xm_name[xm_voc]
local new_xm_name=vocCfg.xm_name[new_xm_voc]
self.reverseDesc:setText(string.format("使用一念存真鉴将<color=#CA631D>%s</color>从",dzName))
self.reverseOldJob:setText(string.format("<color=%s>%s</color>",xm_voc==1 and"#CA831D"or"#C82C2C",xm_name))
self.reverseNewJob:setText(string.format("<color=%s>%s</color>",new_xm_voc==1 and"#CA831D"or"#C82C2C",new_xm_name))
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local itemid,needNum=unpack(baseCfg.voc_change_consunme[1])
local itemNum=itemsModel.getCount(itemid)
local countStr=string.format(itemNum>=needNum and"<color=#aae252>%s</color>/%d"or"<color=#c82c2c>%s</color>/%d",mathHelper.formatNumber(itemNum),needNum)
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.reverseCostItem:setChildPropData(prop)
self.reverseCostItem:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClick(...)
end)
local reverseGain=UIDiscipleModel:getDiscipleReverseXianMoGain(self.dzGuid)
self.reverseEmptyTips:setActive(#reverseGain<=0)
self.reverseRewardContent:setChildLayoutGroupCreateItems(#reverseGain,function(index)
local item=self.reverseRewardContent:getChildLayoutGroupGridItem(index-1)
local itemid,itemnum=unpack(reverseGain[index])
local conf={itemid=itemid,itemcount=itemnum>1 and tostring(itemnum)or"",showCountBG=itemnum>1,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
end)
self.showReverseReward=#reverseGain>0
self.reverseRewardPanel:setActive(self.showReverseReward)
self.reversePreviewBtn:setActive(self.showReverseReward)
end

function UIWenXinGuanTransferWin:refreshBtn()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.dzGuid)
if jjlv>=baseCfg.voc_level then
self.lockPanel:setActive(false)
self.unlockPanel:setActive(true)
local xianTransferConsume,moTransferConsume=unpack(UIDiscipleModel:getDiscipleXianMoTransferConsume(self.dzGuid))
local moneyType,moneyCount=unpack(xianTransferConsume)
local have=itemsModel.getCount(moneyType)
self.xianTransferCost:setText(have<moneyCount and string.format("<color=#c82c2c>%d</color>",moneyCount)or moneyCount)
self.xianTransferMoneyIcon:setChildIcon(iconHelper.getIconName(xianTransferConsume[1]),false)
local moneyType,moneyCount=unpack(moTransferConsume)
local have=itemsModel.getCount(moneyType)
self.moTransferCost:setText(have<moneyCount and string.format("<color=#c82c2c>%d</color>",moneyCount)or moneyCount)
self.moTransferMoneyIcon:setChildIcon(iconHelper.getIconName(moTransferConsume[1]),false)
else
self.lockPanel:setActive(true)
self.unlockPanel:setActive(false)
self.transferBtnText:setText(string.format("弟子境界达到\n<color=#FFBE56>[%s]</color>即可转职",UIDiscipleModel:getJJNameX(baseCfg.voc_level)))
end
end

function UIWenXinGuanTransferWin:showBgModel()
local animId=eAnimationID.stand
self.unknownBg:setChildUIModelShowTarget(5520,1,{},animId,false,false,0)
self.immortalBg:setChildUIModelShowTarget(5521,1,{},animId,false,false,0)
self.devilBg:setChildUIModelShowTarget(5522,1,{},animId,false,false,0)
end

function UIWenXinGuanTransferWin:showXMZPos()
self.xmz_xian,self.xmz_mo=WenXinGuanModel:getDzXMZ(self.dzGuid)

if self.xmz_xian>0 then
if self.xmz_xian>=8 then
local pos=endPos[1]
self.iconImmortal:setChildDOAnchorPosX(0,0)
self.iconImmortal:setChildDOAnchorPosY(pos,0)
self.iconPeople:setChildDOAnchorPosY(-6,0)
self.iconPeople:setCSImageSprite(abname,iconXMType.immortal)
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
self.iconPeople:setCSImageSprite(abname,iconXMType.devil)
self.winlua:SetChildScale(self.iconDevil:getID(),Vector3(0.8,0.8,0.8))
else
local pos=devilPosList[self.xmz_mo]
self.iconDevil:setChildDOAnchorPosX(pos,0)
end
end

local effectId
if self.xmz_mo>self.xmz_xian then
effectId=20427
self.iconPeople:setCSImageSprite(abname,iconXMType.devil)
elseif self.xmz_mo<self.xmz_xian then
effectId=20428
self.iconPeople:setCSImageSprite(abname,iconXMType.immortal)
end

if effectId then
self.effect:setChildShowEffect(effectId,true)
end
end

function UIWenXinGuanTransferWin:refreshActorModel()
local dzScale=1.2
local animId=eAnimationID.stand
local modelId_mmortal,modelId_devil=WenXinGuanModel:getDzXMSuit(self.dzGuid)

local info=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)

self.modelImmortalRoot:setChildUIModelShowTarget(modelId_mmortal,dzScale,nil,animId)
self.modelImmortalRoot:setChildUIModelShowFlipX(true)

self.modelDevilRoot:setChildUIModelShowTarget(modelId_devil,dzScale,nil,animId)
self.modelDevilRoot:setChildUIModelShowFlipX(false)

dzScale=1
self.modelRoot:setChildUIModelShowTarget(modelParams.body,dzScale,modelParams.componets,animId)
self.modelRoot:setChildUIModelShowFlipX(false)
end

function UIWenXinGuanTransferWin:refreshSkillGrid(skillList,flag)
local skillItem=self.immortalSkillItem
if flag then skillItem=self.devilSkillItem end

if skillList then
self.skillCnt=#skillList
for i=1,self.skillCnt do
local skillId=skillList[i]
local item=skillItem[i]

if skillId then
item:setActive(true)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local iconName=iconHelper.getSkillIcon(skillCfg.icon)
item:setChildIcon(iconName,true)
else
skillItem[i]:setActive(false)
end
end
end
end


function UIWenXinGuanTransferWin:onClickSkill(index,cfg,x)
local x=x
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
anchoredPosition=Vector2.New(x,245),
}
}
UIWenXinGuanTransferWin:showWindow('UISimpleTeXingTipsWin',args)
end

function UIWenXinGuanTransferWin:skillBtnClick(skillID)
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




function UIWenXinGuanTransferWin:onCloseBtn()
fullScreenUI.clearAllCallback()
if self.return_jump_param then
jumpManager:jump(self.return_jump_param)
return
end

if not self.isFull then
local startCallback=function()
self:closeSelf()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
UIManager:invokeUIMethod("UIWenXinGuanUnknownWin","hideAndShow",true)
UIManager:invokeUIMethod("UIWenXinGuanTransferDevilWin","hideAndShow",true)
UIManager:invokeUIMethod("UIWenXinGuanTransferImmortalWin","hideAndShow",true)
end

UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
else
local guid=self.dzGuid
local isXianMo=UIDiscipleModel:checkDiscipleXianMoVoc(guid)
if(self.isReset or self.isReverse)and isXianMo then
local startCallback=function()
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
UIManager:showWindow("UIXianMoZhuanZhi_mainWin",guid)
end
loadingControl.openCloud(startCallback,0.5)
else
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
UIManager:showWindow('UIDiscipleJingJieWin',{guid=guid})
UIManager:closeWindow("UIXianMoZhuanZhi_mainWin")
end
end
end

function UIWenXinGuanTransferWin:onCloseMask()
local dis_guid=self.dzGuid
local startCallback=function()
UIManager:closeWindow("UIWenXinGuanTransferImmortalWin")
UIManager:closeWindow("UIWenXinGuanTransferDevilWin")
UIManager:closeWindow("UIWenXinGuanTransferWin")
UIFullDiscipleMainControl:showWindowInfo({dis_guid=dis_guid})
UIManager:showWindow("UIXianMoZhuanZhi_mainWin",dis_guid)
end
loadingControl.openCloud(startCallback,0.5)
end


function UIWenXinGuanTransferWin:onImmortalSkillItem_1()
local index=1
local skillId=self.skillList_immortal[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferWin:onImmortalSkillItem_2()
local index=2
local skillId=self.skillList_immortal[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferWin:onImmortalSkillItem_3()
local index=3
local skillId=self.skillList_immortal[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferWin:onDevilSkillItem_1()
local index=1
local skillId=self.skillList_devil[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferWin:onDevilSkillItem_2()
local index=2
local skillId=self.skillList_devil[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferWin:onDevilSkillItem_3()
local index=3
local skillId=self.skillList_devil[index]
self:skillBtnClick(skillId)


end


function UIWenXinGuanTransferWin:onTransferBtn()
local netData=UIDiscipleModel:getDiscipleData(self.dzGuid)
local jjlv=netData.jingjielv
local show_broke=UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and
UIDiscipleModel:checkJJBrokeByHand(jjlv)

if show_broke then

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

function UIWenXinGuanTransferWin:onResetPlayAnim()
local startCallback=function()
self.resetPanel:setActive(false)
self.transferRoot:setActive(true)
self:refreshActorModel()
self:refreshBtn()
self.progressBg:setActive(true)
end
loadingControl.openCloud(startCallback,0.5)
end

function UIWenXinGuanTransferWin:onTransferPlayAnim(type)
self.transferRoot:setActive(false)
self.progressBg:setActive(false)
self.ImmortalSkillList:setActive(false)
self.DevilSkillList:setActive(false)
self.resetPanel:setActive(false)
self.reversePanel:setActive(false)
self.closeBtn:setActive(false)
self:setSelfSpeak()
local modelId_mmortal,modelId_devil=WenXinGuanModel:getDzXMSuit(self.dzGuid)

self.modelRoot:setChildModelAnimationState(eAnimationID.walk,1)

self.winlua:SetChildUIModelShowFadeToColor(self.modelRoot:getID(),Color.New(1,1,1,0),1,1,nil)
if type==1 then

self.winlua:SetChildUIModelShowFadeToColor(self.modelImmortalRoot:getID(),Color.New(1,1,1,0),0.5,0,nil)
self.winlua:SetChildUIModelShowFadeToColor(self.modelDevilRoot:getID(),Color.New(1,1,1,0),0.5,0,nil)

self.modelRoot:setChildDOAnchorPos(Vector2(-320,-130),2,function()

local info=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info,nil,{hideXianMo=true})
self.modelImmortalRoot:setChildUIModelShowTarget(modelParams.body,1.2,modelParams.componets,eAnimationID.stand,false,false,1.5)
self.modelImmortalRoot:setChildUIModelShowFlipX(true)

self:delayDo(1.5,function()

self.modelImmortalRoot:setChildModelAnimationState(eAnimationID.walk,1)

self.modelImmortalRoot:setChildDOAnchorPos(Vector2(0,-130),2,function()

self.xianEffect:setChildShowEffect(20623,true)

self.modelImmortalRoot:setChildModelAnimationState(eAnimationID.attack7_2,1)

self:delayDo(3.5,function()
self.modelImmortalRoot:setChildUIModelShowTarget(modelId_mmortal,1.2,nil,eAnimationID.stand)
self.modelImmortalRoot:setChildUIModelShowFlipX(true)
end)
self:delayDo(4,function()

self:setTransferSpeak(1)

self:refreshJobIcon(1)
end)

self:delayDo(5,function()


self.closeBtn:setActive(true)
self.ImmortalSkillList:setChildAnchoredPosition(Vector2(-245,27))
self.ImmortalSkillList:setActive(true)
self.xianTransSuccRoot:setActive(true)
self.xianTransSuccRoot:setChildCanvasGroupDOFade(1,0.5,function()
self.closeMask:setActive(true)
end)
end)
end):SetEase(_Ease.Linear)

self.cloudModel:setChildModelAnimationState(eAnimationID.xm_cloud_move_right,1)
self:delayDo(0.15,function()
self.xianBgMask:setChildSizeDelta(1624,750)
self.moBgMask:setActive(false)
end)
end)
end):SetEase(_Ease.Linear)

else

self.modelRoot:setChildUIModelShowFlipX(true)

self.winlua:SetChildUIModelShowFadeToColor(self.modelImmortalRoot:getID(),Color.New(1,1,1,0),0.5,0,nil)
self.winlua:SetChildUIModelShowFadeToColor(self.modelDevilRoot:getID(),Color.New(1,1,1,0),0.5,0,nil)

self.modelRoot:setChildDOAnchorPos(Vector2(320,-130),2,function()

local info=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info,nil,{hideXianMo=true})
self.modelDevilRoot:setChildUIModelShowTarget(modelParams.body,1.2,modelParams.componets,eAnimationID.stand,false,false,1.5)
self.modelDevilRoot:setChildUIModelShowFlipX(false)

self:delayDo(1.5,function()

self.modelDevilRoot:setChildModelAnimationState(eAnimationID.walk,1)

self.modelDevilRoot:setChildDOAnchorPos(Vector2(0,-130),2,function()

self.moEffect:setChildShowEffect(20624,true)

self.modelDevilRoot:setChildModelAnimationState(eAnimationID.attack7_2,1)

self:delayDo(5.2,function()
self.modelDevilRoot:setChildUIModelShowTarget(modelId_devil,1.2,nil,eAnimationID.stand)
self.modelDevilRoot:setChildUIModelShowFlipX(false)
end)
self:delayDo(5.7,function()

self:setTransferSpeak(2)

self:refreshJobIcon(2)
end)

self:delayDo(6.7,function()


self.closeBtn:setActive(true)
self.DevilSkillList:setChildAnchoredPosition(Vector2(245,27))
self.DevilSkillList:setActive(true)
self.moTransSuccRoot:setActive(true)
self.moTransSuccRoot:setChildCanvasGroupDOFade(1,0.5,function()
self.closeMask:setActive(true)
end)
end)
end):SetEase(_Ease.Linear)

self.cloudModel:setChildModelAnimationState(eAnimationID.xm_cloud_move_left,1)
self:delayDo(0.15,function()
self.moBgMask:setChildSizeDelta(1624,750)
self.xianBgMask:setActive(false)
end)
end)
end):SetEase(_Ease.Linear)
end
self:refreshZhuanZhiAfterPanel(type)
end

function UIWenXinGuanTransferWin:setSelfSpeak()
local content="谨遵师命"
local parent=self.winlua:GetCommonComponent(self.modelRoot:getID(),'Transform')
_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,155)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
self:delayDo(1,function()
_InstantiateManager.RemoveInstance(id)
end)
end)
end

function UIWenXinGuanTransferWin:setTransferSpeak(type)
local lib=cfgHelper.get3(cfg_disciplevocconfig_get,1,"speakLib2",type)
local r=math.random(1,#lib)
local content=lib[r]
local model=type==1 and self.modelImmortalRoot or self.modelDevilRoot
local parent=self.winlua:GetCommonComponent(model:getID(),'Transform')
_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,155)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
self:delayDo(3,function()
_InstantiateManager.RemoveInstance(id)
end)
end)
end

function UIWenXinGuanTransferWin:refreshJobIcon(type)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local jobId=imageInfo.job
local iconName=jobXMType[jobId][type]
local jobABName='ui/windows/wenxinguan/wenxinguanjob_atlas_pak.ab'
self.job:setCSImageSprite(jobABName,iconName)
self.job:setChildAnchoredPosition(Vector2(type==1 and 250 or-250,140))
self.job:setScale(Vector3(1.2,1.2,1.2))
self.job:setChildCanvasGroupDOFade(1,0.5)
self.job:setChildDOScale(1,0.5)
end

function UIWenXinGuanTransferWin:refreshZhuanZhiAfterPanel(type)
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local voc=UIDiscipleModel:getDiscipleJob(self.dzGuid)
local attrPercent=type==1 and self.xianAttrPercent or self.moAttrPercent
local attrContent=type==1 and self.xianAttrContent or self.moAttrContent
local attrList=type==1 and baseCfg.attr1[voc]or baseCfg.attr2[voc]
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

function UIWenXinGuanTransferWin:onXianTransferPreviewBtn()
UIManager:showWindow("UIXianMoZhuanZhi_transferPreviewWin",{1,self.dzGuid})
end

function UIWenXinGuanTransferWin:onMoTransferPreviewBtn()
UIManager:showWindow("UIXianMoZhuanZhi_transferPreviewWin",{2,self.dzGuid})
end

function UIWenXinGuanTransferWin:onXianTransferBtn()









local arg=
{
guid=self.dzGuid,
isFull=true,
}
jumpManager:jump({id=JUMP_TYPE.eWenXinGuan_Immortal,args=arg},function()
UIManager:invokeUIMethod("UIWenXinGuanTransferImmortalWin","hideAndShow",true)
end,JUMP_BACK.eNoBack)
end

function UIWenXinGuanTransferWin:onMoTransferBtn()









local arg=
{
guid=self.dzGuid,
isFull=true,
}
jumpManager:jump({id=JUMP_TYPE.eWenXinGuan_Devli,args=arg},function()
UIManager:invokeUIMethod("UIWenXinGuanTransferDevilWin","hideAndShow",true)
end,JUMP_BACK.eNoBack)
end

function UIWenXinGuanTransferWin:onResetBtn()
local callback=function()
local name=UIDiscipleModel:getDiscipleName(self.dzGuid)
local content=string.format("斩念重修后%s弟子将返回未转职状态，转职所消耗的仙魔气无法返还，是否斩念重修？",name)
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=function()
UIDiscipleController:reqXianMoTransferReset(self.dzGuid)
end,
canvasIndex=8,
})
dialog:show()
end

local cost=UIDiscipleModel:getXianMoResetCost()
if next(cost)then
itemsModel:useItem(cost[1],cost[2],callback,WARNING_TYPE.eWarning)
else
callback()
end
end

function UIWenXinGuanTransferWin:onReverseBtn()
local baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local itemid,needNum=unpack(baseCfg.voc_change_consunme[1])
local itemNum=itemsModel.getCount(itemid)
if itemNum<needNum then
return gainControl:showGainWin(itemid)
end
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.dzGuid)
local new_xm_voc=xm_voc==1 and 2 or 1
local reverseGain=UIDiscipleModel:getDiscipleReverseXianMoGain(self.dzGuid)
if#reverseGain>0 then
local xinfa_level=UIDiscipleModel:getDiscipleXinFaLevel(self.dzGuid)
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,xinfa_level)
local xinfaStage=xinfaLevelCfg.stage
local new_xinfaStage=UIDiscipleModel:getXinFaStage(new_xm_voc)
local new_xinfaCfg=cfgHelper.get2(cfg_disciplexinfaconfig_get,new_xm_voc,new_xinfaStage)
local new_xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,new_xinfaCfg.full_level)
local new_xinfa_type=new_xm_voc==1 and"仙术"or"魔功"
local new_daoheng=new_xinfaLevelCfg.daoheng_conf[1]
local content=string.format("%s%s阶心法未解锁，仙魔逆转后道行将降低至%s年，溢出的道行转化为以下真元，是否逆转？",new_xinfa_type,mathHelper.numberToChinese(xinfaStage),new_daoheng)
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=function()
UIDiscipleController:reqXianMoSwitch(self.dzGuid)
end,
itemList=reverseGain,
canvasIndex=8,
})
dialog:show()
else
local discipleName=UIDiscipleModel:getDiscipleName(self.dzGuid)
local xianStr="<color=#CA831D>仙</color>"
local moStr="<color=#C82C2C>魔</color>"
local content=string.format("是否将%s弟子从%s转为%s？",discipleName,xm_voc==1 and xianStr or moStr,xm_voc==1 and moStr or xianStr)
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=function()
UIDiscipleController:reqXianMoSwitch(self.dzGuid)
end,
canvasIndex=8,
})
dialog:show()
end
end

function UIWenXinGuanTransferWin:onReversePreviewBtn()
self.showReverseReward=not self.showReverseReward
self.reverseRewardPanel:setActive(self.showReverseReward)
end
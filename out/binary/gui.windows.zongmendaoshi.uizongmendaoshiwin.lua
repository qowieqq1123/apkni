







def_class("UIZongMenDaoShiWin",UIWindowBase)









function UIZongMenDaoShiWin:bindComponents()

self.rewardRoot=UIObject.get(self,0)
self.rewardMask=UIButton.get(self,1)
self.rewardPanel=UIObject.get(self,2)
self.rewardList=UIObject.get(self,3)
self.conditionNum=UIText.get(self,4)
self.tipsBtn=UIButton.get(self,5)
self.hbMaxInfoBtnBg=UIObject.get(self,6)
self.hbMaxInfoPanel=UIObject.get(self,7)
self.hbMaxInfoPanelMask=UIButton.get(self,8)
self.sectList=UIObject.get(self,9)
self.hbMaxInfoBtn=UIButton.get(self,10)
self.hbMaxInfoBtnEffect=UIObject.get(self,11)
self.conditionProgress=UIProgress.get(self,12)
self.bgModel=UIObject.get(self,13)

self.rewardMask:setButtonClick(function()self:onRewardMask()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.hbMaxInfoPanelMask:setButtonClick(function()self:onHbMaxInfoPanelMask()end)

self.hbMaxInfoBtn:setButtonClick(function()self:onHbMaxInfoBtn()end)



end


function UIZongMenDaoShiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.rewardMask);self.rewardMask=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.conditionNum);self.conditionNum=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.hbMaxInfoBtnBg);self.hbMaxInfoBtnBg=nil;
_UIObject_release(self.hbMaxInfoPanel);self.hbMaxInfoPanel=nil;
_UIObject_release(self.hbMaxInfoPanelMask);self.hbMaxInfoPanelMask=nil;
_UIObject_release(self.sectList);self.sectList=nil;
_UIObject_release(self.hbMaxInfoBtn);self.hbMaxInfoBtn=nil;
_UIObject_release(self.hbMaxInfoBtnEffect);self.hbMaxInfoBtnEffect=nil;
_UIObject_release(self.conditionProgress);self.conditionProgress=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end


















local this
local openHbMaxInfoPanel

function UIZongMenDaoShiWin:onLoaded(...)
self:bindComponents()
this=self
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
end


function UIZongMenDaoShiWin:__delete()
self:unbindComponents()
UIManager:closeWindow("UITopMaskWin")
end




function UIZongMenDaoShiWin:onShow(argtable,afterOnloaded)
local isComplete=ZongMenDaoShiController:isZongMenDaoShiComplete()
if afterOnloaded then
openHbMaxInfoPanel=false
UIManager:showWindow("UITopMaskWin")
self.hbMaxInfoBtnEffect:setChildShowEffect(10521,not isComplete)
self.bgModel:setChildUIModelShowTarget(5411,1,{},eAnimationID.stand)
end
local sectInfoList=ZongMenDaoShiModel:getZMDaoShiInfoList()
self.sectList:setChildLayoutGroupCreateItems(#sectInfoList)
local sectList=self.sectList:getChildLayoutGroupGridList()
for i=1,#sectInfoList do
local sectWidget=sectList[i-1]
local serial=sectInfoList[i].serial
local isDaoShi=sectInfoList[i].isDaoShi
if serial==-1 then
sectWidget:SetChildActive(12,false)
sectWidget:SetChildActive(13,true)
local refresh_time=sectInfoList[i].refresh_time
local inteval=refresh_time-timeHelper.getServerShortTime()
local timeStr=inteval>0 and timeHelper.format_time_stamp2(inteval)or'不久'
sectWidget:SetChildText(14,string.format("据闻早已隐世不出的神秘宗门将于<color=#549327>%s</color>后出现",timeStr))
else
local data=systemZongMenModel:getInfoData(serial)
local isKickout=data==nil or data.flag==systemZongMenFightFlagType.eExpel

local icon=isKickout and'icon_family_114'or systemZongMenModel:getIconName(data.id,data.level)
local isSub
if isKickout then
isSub=false
else
isSub=data.flag==systemZongMenFightFlagType.eVassal
end
local nameStr=isKickout and'匿名宗门'or systemZongMenModel:getNameStr(data.id,data.nameIdx)
local reputationValue=isKickout and 0 or data.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=isKickout and 1 or systemZongMenModel:getRenownIndex(data.id,reputationValue)


local swlv=cfgHelper.get2(cfg_zmdsbaseconfig_get,1,'swlv')
local reputationCond=reputationIndex>=swlv


local reputationStr=systemZongMenModel:getRenownName(swlv)
local maxValue=isKickout and 0 or systemZongMenModel:getRenownValue(data.id,swlv)
sectWidget:SetChildProgressValue(16,reputationValue,maxValue)
sectWidget:SetChildText(17,string.format("%s/%s",reputationValue,maxValue))
sectWidget:SetChildActive(16,not isKickout and not isSub)
sectWidget:SetChildActive(17,reputationValue<maxValue)
sectWidget:SetChildGray(3,reputationValue<maxValue)

sectWidget:SetChildCSImageIcon(0,icon,true)
if isKickout or isSub then
sectWidget:SetChildActive(1,true)
sectWidget:SetChildCSImageSprite(1,"ui/windows/zongmendaoshi/zongmendaoshi_atlas_pak.ab",isKickout and'image_zongmendaoshi_yiquzhu'or'image_zongmendaoshi_fuyong')
else
sectWidget:SetChildActive(1,false)
end
sectWidget:SetChildText(2,nameStr)

sectWidget:SetChildText(4,reputationStr)
sectWidget:SetChildButtonClick(5,function()
if not isDaoShi then
self:refreshRewardPanel(data.id)
self:onRewardBtn(sectWidget,i)
end
end)
sectWidget:SetChildActive(15,not isDaoShi)
sectWidget:SetChildActive(6,isDaoShi)
sectWidget:SetChildActive(7,not isDaoShi and not(isSub or reputationCond))
sectWidget:SetChildButtonClick(7,function()
local unitKey=systemZongMenModel:convertUnitKey(data.serial)
if worldModel:isSameWorld(data.worldId)then
worldController:resetRightView()
worldController:lookAtUnit(unitKey)
local func=function()
UIFullJiuChongTianJieControl:closeUI()
UIManager:closeWindow("UIZongMenDaoShiWin")
end
loadingControl.openCloud(func,0.5)
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,data.worldId,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={lookAtUnit=unitKey}
worldController:enterWorld(data.worldId,args)
self:setTimer(1,1,function()
UIFullJiuChongTianJieControl:closeUI()
UIManager:closeWindow("UIZongMenDaoShiWin")
end)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end)
sectWidget:SetChildActive(8,not isDaoShi and(isSub or reputationCond))
sectWidget:SetChildButtonClick(8,function()
local cfg=cfgHelper.get1(cfg_zmdsbaseconfig_get,1)
local rewards=cfg.reward[data.id]
if not rewards then
loggerUtil.logErrFMT('宗门道誓未配置宗门奖励 宗门id：{0}',data.id)
return
end
local storyId=cfg.story[data.id]
if not storyId then
loggerUtil.logErrFMT('宗门道誓未配置对话剧情id 宗门id：{0}',data.id)
return
end

local disciplelist=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)or{}
local disciples=disciplelist[1]
if not disciples then
disciples=UIDiscipleModel:getPlotDiscipleByIndex(1)
end

local detailInfo=ZongMenDaoShiModel:getZMImageData(data.serial)
local zmImage=UIDiscipleModel.calculationDiscipleImage(detailInfo.leader_data,detailInfo.leader_image)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(zmImage)
local args={
groupid=storyId,
isFullOpen=false,
rewards=rewards,
npcData={zmDisciple=disciples,systemZongMenModel=modelParams,systemZongMenName=string.format("%s掌门",nameStr)},
callback=function()
ZongMenDaoShiController.send_34_92(data.serial)
end,
}
gameplotController:showPlotBoard(args)
end)
sectWidget:SetChildActive(9,isDaoShi)
sectWidget:SetChildActive(10,not isDaoShi and(isSub or reputationCond))
sectWidget:SetChildActive(11,isDaoShi)
sectWidget:SetChildActive(12,true)
sectWidget:SetChildActive(13,false)
end
end
self.rewardRoot:setActive(false)
local daoshiNum=ZongMenDaoShiModel:getZMDaoShiNum()
local cfg=cfgHelper.get1(cfg_zmdsbaseconfig_get,1)
self.conditionProgress:setProgressValue(daoshiNum,cfg.max)
self.conditionNum:setText(string.format("%d/%d",daoshiNum,cfg.max))

self.hbMaxInfoBtnBg:setActive(not isComplete)
self.hbMaxInfoPanel:setActive(not isComplete and openHbMaxInfoPanel)

self:stopAllTimer()
self:setTimer(1,0,function()
self:refreshTimePanel()
end)
end


function UIZongMenDaoShiWin:onHide()
self:stopAllTimer()
UIManager:closeWindow("UITopMaskWin")
end


function UIZongMenDaoShiWin:refreshTimePanel()
local sectInfoList=ZongMenDaoShiModel:getZMDaoShiInfoList()
local sectList=self.sectList:getChildLayoutGroupGridList()
for i=1,#sectInfoList do
local sectWidget=sectList[i-1]
local serial=sectInfoList[i].serial
if serial==-1 then
local refresh_time=sectInfoList[i].refresh_time
local inteval=refresh_time-timeHelper.getServerShortTime()
local timeStr=inteval>0 and timeHelper.format_time_stamp2(inteval)or'不久'
sectWidget:SetChildText(14,string.format("据闻早已隐世不出的神秘宗门将于<color=#549327>%s</color>后出现",timeStr))
end
end
end

function UIZongMenDaoShiWin:refreshRewardPanel(zmId)

local cfg=cfgHelper.get1(cfg_zmdsbaseconfig_get,1)
local rewards=cfg.reward[zmId]
if rewards then
self.rewardList:setChildLayoutGroupCreateItems(#rewards)
local rwGrids=self.rewardList:getChildLayoutGroupGridList()
for i=1,#rewards do
local rwWidget=rwGrids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward.showCount or reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
else
loggerUtil.logErrFMT('宗门道誓未配置宗门奖励 宗门id：{0}',zmId)
end
end

function UIZongMenDaoShiWin:onRewardBtn(sectWidget,i)
if sectWidget==nil then
local sectList=self.sectList:getChildLayoutGroupGridList()
sectWidget=sectList[i-1]
end
local wPos=sectWidget:GetChildPosition(5)
self.rewardRoot:setActive(true)
self.rewardPanel:setChildPosition(wPos)
local apos=self.rewardPanel:getChildAnchoredPosition()
apos.x=apos.x-60
self.rewardPanel:setChildAnchoredPosition(apos)
end
function UIZongMenDaoShiWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIZongMenDaoShiWin.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
if oldFlag==systemZongMenFightFlagType.eVassal or newFlag==systemZongMenFightFlagType.eVassal then
this:onShow()
end
end


function UIZongMenDaoShiWin:onTipsBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UIZongMenDaoShiRule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIZongMenDaoShiWin:onRewardMask()
self.rewardRoot:setActive(false)
end

function UIZongMenDaoShiWin:onHbMaxInfoBtn()
openHbMaxInfoPanel=not openHbMaxInfoPanel
self.hbMaxInfoPanel:setActive(openHbMaxInfoPanel)
self.hbMaxInfoPanelMask:setActive(openHbMaxInfoPanel)
end

function UIZongMenDaoShiWin:onHbMaxInfoPanelMask()
openHbMaxInfoPanel=false
self.hbMaxInfoPanel:setActive(openHbMaxInfoPanel)
self.hbMaxInfoPanelMask:setActive(openHbMaxInfoPanel)
end

function UIZongMenDaoShiWin:onCloseBtn()
local func=function()
UIManager:closeWindow("UIZongMenDaoShiWin")
end
loadingControl.openCloud(func,0.5)
end

function UIZongMenDaoShiWin:onCloseMainBtn()
local func=function()
UIFullJiuChongTianJieControl:closeUI()
UIManager:closeWindow("UIZongMenDaoShiWin")
end
loadingControl.openCloud(func,0.5)
end
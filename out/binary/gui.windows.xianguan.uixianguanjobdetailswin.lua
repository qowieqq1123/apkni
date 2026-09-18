







def_class("UIXianGuanJobDetailsWin",UIWindowBase)









function UIXianGuanJobDetailsWin:bindComponents()

self.addFlag=UIObject.get(self,0)
self.backBgSpine=UIObject.get(self,1)
self.beforeSpine=UIObject.get(self,2)
self.campaignIcon=UIImage.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.compaigmTxt=UIText.get(self,5)
self.compaignImg=UIImage.get(self,6)
self.cxXGBtn=UIButton.get(self,7)
self.inJobBtn=UIButton.get(self,8)
self.jobCondition=UIText.get(self,9)
self.jobIcon=UIImage.get(self,10)
self.jobInfoPart=UIObject.get(self,11)
self.jobName=UIText.get(self,12)
self.jobNameBg=UIObject.get(self,13)
self.jobState=UIText.get(self,14)
self.playerInfoDetailBtn=UIButton.get(self,15)
self.playerModel=UIObject.get(self,16)
self.playerModelDefault=UIObject.get(self,17)
self.playerModelMask=UIObject.get(self,18)
self.playerModelPart=UIObject.get(self,19)
self.playerName=UIText.get(self,20)
self.registerBtn=UIButton.get(self,21)
self.Root=UIObject.get(self,22)
self.showCampainTypeBtn=UIButton.get(self,23)
self.tqScrollView=UIScrollView.get(self,24)
self.uiRoot=UIObject.get(self,25)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cxXGBtn:setButtonClick(function()self:onCxXGBtn()end)

self.inJobBtn:setButtonClick(function()self:onInJobBtn()end)

self.playerInfoDetailBtn:setButtonClick(function()self:onPlayerInfoDetailBtn()end)

self.registerBtn:setButtonClick(function()self:onRegisterBtn()end)

self.showCampainTypeBtn:setButtonClick(function()self:onShowCampainTypeBtn()end)



end


function UIXianGuanJobDetailsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addFlag);self.addFlag=nil;
_UIObject_release(self.backBgSpine);self.backBgSpine=nil;
_UIObject_release(self.beforeSpine);self.beforeSpine=nil;
_UIObject_release(self.campaignIcon);self.campaignIcon=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.compaigmTxt);self.compaigmTxt=nil;
_UIObject_release(self.compaignImg);self.compaignImg=nil;
_UIObject_release(self.cxXGBtn);self.cxXGBtn=nil;
_UIObject_release(self.inJobBtn);self.inJobBtn=nil;
_UIObject_release(self.jobCondition);self.jobCondition=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.jobInfoPart);self.jobInfoPart=nil;
_UIObject_release(self.jobName);self.jobName=nil;
_UIObject_release(self.jobNameBg);self.jobNameBg=nil;
_UIObject_release(self.jobState);self.jobState=nil;
_UIObject_release(self.playerInfoDetailBtn);self.playerInfoDetailBtn=nil;
_UIObject_release(self.playerModel);self.playerModel=nil;
_UIObject_release(self.playerModelDefault);self.playerModelDefault=nil;
_UIObject_release(self.playerModelMask);self.playerModelMask=nil;
_UIObject_release(self.playerModelPart);self.playerModelPart=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.registerBtn);self.registerBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.showCampainTypeBtn);self.showCampainTypeBtn=nil;
_UIObject_release(self.tqScrollView);self.tqScrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this
local _ab=globalABLookup.xianguan

local CmpTeQuanItemIndex={
icon=0,
name=1,
desc=2,
tipsBg=3,
tipsTxt=4,
}




function UIXianGuanJobDetailsWin:onLoaded(...)
self:bindComponents()

_this=self

local bindWidget=function(index,item)self:bindTeQuanWidget(index,item)end
self.tqScrollView:bindScrollWidget(bindWidget)

self:addNotify(notifyConfig.onChangeXianGuanJob,function(...)
if _this==nil then return end
_this:onChangeXianGuanJob(...)
end)
self:addProNotify(40,23,self.on_40_23)
end


function UIXianGuanJobDetailsWin:__delete()

if self.addFlagDt then
self.addFlagDt:Complete()
self.addFlagDt:Kill()
self.addFlagDt=nil
end

_this=nil

self:unbindComponents()
end




function UIXianGuanJobDetailsWin:onShow(argtable,afterOnloaded)
self.groupId=argtable and argtable.groupId
self.jobId=argtable and argtable.jobId
self.isdujie=argtable and argtable.isdujie
self.isCampaign=argtable and argtable.isCampaign

self:refreshAll()

self.playerModelPart:setActive(false)
self:delayDo(0.4,function()
if _this==nil then return end
_this.playerModelPart:setActive(true)
end)
self.backBgSpine:setChildUIModelShowTarget(5717,1,nil,eAnimationID.enter)
self.beforeSpine:setChildUIModelShowTarget(5718,1,nil,eAnimationID.enter)
end


function UIXianGuanJobDetailsWin:onHide()

end

function UIXianGuanJobDetailsWin:refreshAll()
local jobCfg=xianguanConfig.getJobConfig(self.groupId,self.jobId)
local playerInfo=xianguanController.getJobPlayerInfo(self.groupId,self.jobId)
local isHasJober=playerInfo.actorid~=nil

local isCanJob=xianguanController.checkIsCanJob(self.groupId,self.jobId)
local isInJob=xianguanController.checkSelfInJob(self.groupId)


self.playerModelMask:setActive(isHasJober)
self.playerModelDefault:setActive(not isHasJober)
self.jobState:setActive(not isHasJober)
self.playerInfoDetailBtn:setActive(isHasJober)


local isShowInJobBtn=(not isHasJober)and(not isInJob)and isCanJob
isShowInJobBtn=false
self.inJobBtn:setActive(isShowInJobBtn)

if isShowInJobBtn then
if self.addFlagDt then
self.addFlagDt:Complete()
self.addFlagDt:Kill()
self.addFlagDt=nil
end

self.addFlag:setScale(Vector3(1.1,1.1,1.1))
self.addFlagDt=self.addFlag:setChildDOScale(0.8,1)
self.addFlagDt:SetEase(_Ease.Linear)
self.addFlagDt:SetLoops(-1,_LoopType.Yoyo)
end

if isHasJober then
if playerInfo.iconInfo then
local replace={[PLAYER_IMAGE_TYPE.eBodyOrnament]=1}
playerController:setImage(self.widget,self.playerModel:getID(),playerInfo.sex,playerInfo.iconInfo,playerController:supportDynamic(),0.8,replace)
end
self.playerName:setText(playerInfo.actorname)
else
local tipStr







tipStr=toColorStringX("#171311","虚位以待")
self.jobState:setText(tipStr)
end

self.jobName:setText(jobCfg.name)
local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
self.jobIcon:setCSImageSprite(_ab,jobIconName)

local jobCondition=xianguanConfig.getJobCondition(self.groupId,self.jobId)
local isSatisfyCondition=xianguanController.checkSatisfyCondition(self.groupId,self.jobId)
local color=isSatisfyCondition and"#549327"or"#f36666"
local conditionStr=toColorStringX(color,jobCondition)
self.jobCondition:setText(conditionStr)

local compaignTypeIconName=cfgHelper.get2(cfg_xianguancampaigntypeconfig_get,jobCfg.campaignType,'icon')
self.compaignImg:setCSImageSprite(_ab,compaignTypeIconName)

local compaigmTxt=cfgHelper.get2(cfg_xianguancampaigntypeconfig_get,jobCfg.campaignType,'name')
self.compaigmTxt:setText(compaigmTxt)

local deskDecoration=cfgHelper.get2(cfg_xianguancampaigntypeconfig_get,jobCfg.campaignType,'deskDecoration')
self.campaignIcon:setCSImageSprite(globalABLookup.xianguan,deskDecoration)

self.privilegeList=xianguanConfig.getLimitCrossTeQuanIdsByJobId(self.jobId)
local tqLen=#self.privilegeList
self.tqScrollView:freshGridsNum(tqLen,tqLen,2)

if self.isdujie then
self.jobState:setText(toColorStringX("#171311","虚位以待"))
local jbstr=FMT.fmt("渡劫飞升第{0}名",self.isdujie)
self.jobCondition:setText(toColorStringX("#549327",jbstr))
self.inJobBtn:setActive(false)
end

self:refreshCampaign()
end

function UIXianGuanJobDetailsWin:refreshCampaign()
local jobCfg=xianguanConfig.getJobConfig(self.groupId,self.jobId)
self.registerBtn:setActive(self.isCampaign)
self.cxXGBtn:setActive(self.isCampaign)
if self.isCampaign then
local status=xianguanController:getJingXuanSegment(jobCfg.campaignType)
local isRegister=status==1
if isRegister then
local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWenXuan)or xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)
local canCX=xianguanConfig.checkCanJob(self.groupId,self.jobId)
local hasCX=officer_id~=nil
local canQX=officer_id==self.jobId
self.cxXGBtn:setGray(not canCX)

self.cxXGBtn:setActive(isRegister and(not hasCX or canQX))
self.cxXGBtn:setCSImageSprite(globalABLookup.xianguanJingXuan,canQX and"button_quxiaocanxuan"or"button_canxuan")
else
self.cxXGBtn:setActive(false)
end
end
end

function UIXianGuanJobDetailsWin:bindTeQuanWidget(index,item)
local tqId=self.privilegeList[index]
local tqCfg=cfgHelper.get(cfg_xianguanprivilegeconfig_get,tqId)

local tqIconName=xianguanConfig.getTeQuanIconName(tqCfg.icon)
item:SetChildIcon(CmpTeQuanItemIndex.icon,tqIconName,false)

item:SetChildText(CmpTeQuanItemIndex.name,tqCfg.name)

item:SetChildText(CmpTeQuanItemIndex.desc,tqCfg.desc)


local isShowTips=false

local isHasCJXYCondition=xianguanHelper.checkHasConditionType(tqId,XianGuanUseConditionEnum.eChongJianXianYu)
if isHasCJXYCondition then
if not seasonController:checkSeasonHandleStageAllEnd(0)then
isShowTips=true
item:SetChildText(CmpTeQuanItemIndex.tipsTxt,"完成重建仙域生效")
end
end

item:SetChildActive(CmpTeQuanItemIndex.tipsBg,isShowTips)
end




function UIXianGuanJobDetailsWin:onChangeXianGuanJob(jobInfo)
if jobInfo.groupId==self.groupId and jobInfo.jobId==self.jobId then
self:refreshAll()
end
end





function UIXianGuanJobDetailsWin:onPlayerInfoDetailBtn()
local playerInfo=xianguanController.getJobPlayerInfo(self.groupId,self.jobId)

if playerInfo then
local actorId=playerInfo.actorid
local attach={}

attach.serverid=playerInfo.serverid
attach.bigServer=true
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,nil,attach)
end
end

function UIXianGuanJobDetailsWin:onInJobBtn()
if self.isdujie then
return
end
local isCanJob=xianguanController.checkIsCanJob(self.groupId,self.jobId)

if isCanJob then
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,self.groupId)
local jobCfg=xianguanConfig.getJobConfig(self.groupId,self.jobId)
local content=FMT.fmt("上任本官职后，将不能上任{0}里的其他官职，是否上任{1}?",topCfg.name,toColorStringX("#ca631d",jobCfg.name))

local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=function(...)
if _this==nil then return end

UIManager.info("请求上任")
xianguanController.reqXianGuanCampaign(_this.jobId)
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
UIManager.error("未达到仙官上任要求")
end
end

function UIXianGuanJobDetailsWin:onCloseBtn()
self:closeSelf()
end

function UIXianGuanJobDetailsWin:onShowCampainTypeBtn()
local jobCfg=xianguanConfig.getJobConfig(self.groupId,self.jobId)

self:showWindow("UIXianGuanCampaignTypeWIn",{type=jobCfg.campaignType})
end

function UIXianGuanJobDetailsWin:onRegisterBtn()
local groupId=self.groupId
local jobId=self.jobId
local jobCfg=xianguanConfig.getJobConfig(groupId,jobId)
local callback=function()
local args={groupId=groupId,jobId=jobId,isCampaign=true}
UIFullXJForceControl:showWindow("UIXianGuanJobDetailsWin",args)
end
UIFullXJForceControl:showJingXuanWindow(jobCfg.campaignType,self.jobId,callback)
self:closeSelf()
end

function UIXianGuanJobDetailsWin:onCxXGBtn()
local jobCfg=xianguanConfig.getJobConfig(self.groupId,self.jobId)
local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWenXuan)or xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)
local canCX=xianguanConfig.checkCanJob(self.groupId,self.jobId)
local hasCX=officer_id~=nil
local canQX=officer_id==self.jobId
if not canCX and not hasCX then
UIManager.error(FMT.fmt("{0}可参选",xianguanConfig.getJobCondition(self.groupId,self.jobId,true)))
return
end
if canQX then
local config=xianguanController:getJingXuanConfig(jobCfg.campaignType)

local showdata={
type='UIDialouge',
title='提示',
content=FMT.fmt("取消参选后，需要等待{0}秒可再参选，\n是否取消？",config.cooldown_sec),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
local status=xianguanController:getJingXuanSegment(jobCfg.campaignType)
local isRegister=status==1
if not isRegister then
UIManager.error("只有报名阶段才能取消参选")
return
end
if jobCfg.campaignType==1 then
xianguanController:req_send_40_9()
else
xianguanController:send_40_23_cancel()
end
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
elseif not hasCX then
if jobCfg.campaignType==XianGuanCampaignType.eWenXuan then
UIManager:showWindow("UIXianGuanCampaignDescWin",{officerId=self.jobId})
elseif jobCfg.campaignType==XianGuanCampaignType.eWuXuan then
UIFullXJForceControl:showWuXuanAttendWin(self.jobId)
end
end
end

function UIXianGuanJobDetailsWin.on_40_23()
local jobCfg=xianguanConfig.getJobConfig(_this.groupId,_this.jobId)
if jobCfg.campaignType==XianGuanCampaignType.eWuXuan then
_this:refreshCampaign()
end
end

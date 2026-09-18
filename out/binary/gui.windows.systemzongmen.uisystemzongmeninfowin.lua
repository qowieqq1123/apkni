







def_class("UISystemZongMenInfoWin",UIWindowBase)









function UISystemZongMenInfoWin:bindComponents()

self.allyBtn=UIButton.get(self,0)
self.attackBtn=UIButton.get(self,1)
self.attackingBtn=UIButton.get(self,2)
self.attackLock=UIObject.get(self,3)
self.campIcon=UIImage.get(self,4)
self.daZhenBtn=UIButton.get(self,5)
self.daZhenLock=UIObject.get(self,6)
self.giftBtn=UIButton.get(self,7)
self.level=UIText.get(self,8)
self.name=UIText.get(self,9)
self.quZhuBtn=UIButton.get(self,10)
self.relationBtn=UIButton.get(self,11)
self.relationIcon=UIImage.get(self,12)
self.relationTx=UIText.get(self,13)
self.reputationBtn=UIButton.get(self,14)
self.reputationIcon=UIImage.get(self,15)
self.reputationProgressBar=UIProgress.get(self,16)
self.reputationReddot=UIObject.get(self,17)
self.reputationTx=UIText.get(self,18)
self.stability=UIText.get(self,19)
self.strengthIcon=UIButton.get(self,20)
self.strengthPanel=UIButton.get(self,21)
self.strengthTips=UIText.get(self,22)
self.strengthTx=UIObject.get(self,23)
self.surrenderBtn=UIButton.get(self,24)
self.timeBg=UIObject.get(self,25)
self.timeTx=UIText.get(self,26)
self.vassalBtn=UIButton.get(self,27)
self.vassalList=UIObject.get(self,28)
self.vassalPanel=UIButton.get(self,29)
self.zmJJ=UIText.get(self,30)
self.zmModel=UIObject.get(self,31)
self.zmName=UIText.get(self,32)

self.allyBtn:setButtonClick(function()self:onAllyBtn()end)

self.attackBtn:setButtonClick(function()self:onAttackBtn()end)

self.attackingBtn:setButtonClick(function()self:onAttackingBtn()end)

self.daZhenBtn:setButtonClick(function()self:onDaZhenBtn()end)

self.giftBtn:setButtonClick(function()self:onGiftBtn()end)

self.quZhuBtn:setButtonClick(function()self:onQuZhuBtn()end)

self.relationBtn:setButtonClick(function()self:onRelationBtn()end)

self.reputationBtn:setButtonClick(function()self:onReputationBtn()end)

self.strengthIcon:setButtonClick(function()self:onStrengthIcon()end)

self.strengthPanel:setButtonClick(function()self:onStrengthPanel()end)

self.surrenderBtn:setButtonClick(function()self:onSurrenderBtn()end)

self.vassalBtn:setButtonClick(function()self:onVassalBtn()end)

self.vassalPanel:setButtonClick(function()self:onVassalPanel()end)



end


function UISystemZongMenInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allyBtn);self.allyBtn=nil;
_UIObject_release(self.attackBtn);self.attackBtn=nil;
_UIObject_release(self.attackingBtn);self.attackingBtn=nil;
_UIObject_release(self.attackLock);self.attackLock=nil;
_UIObject_release(self.campIcon);self.campIcon=nil;
_UIObject_release(self.daZhenBtn);self.daZhenBtn=nil;
_UIObject_release(self.daZhenLock);self.daZhenLock=nil;
_UIObject_release(self.giftBtn);self.giftBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.quZhuBtn);self.quZhuBtn=nil;
_UIObject_release(self.relationBtn);self.relationBtn=nil;
_UIObject_release(self.relationIcon);self.relationIcon=nil;
_UIObject_release(self.relationTx);self.relationTx=nil;
_UIObject_release(self.reputationBtn);self.reputationBtn=nil;
_UIObject_release(self.reputationIcon);self.reputationIcon=nil;
_UIObject_release(self.reputationProgressBar);self.reputationProgressBar=nil;
_UIObject_release(self.reputationReddot);self.reputationReddot=nil;
_UIObject_release(self.reputationTx);self.reputationTx=nil;
_UIObject_release(self.stability);self.stability=nil;
_UIObject_release(self.strengthIcon);self.strengthIcon=nil;
_UIObject_release(self.strengthPanel);self.strengthPanel=nil;
_UIObject_release(self.strengthTips);self.strengthTips=nil;
_UIObject_release(self.strengthTx);self.strengthTx=nil;
_UIObject_release(self.surrenderBtn);self.surrenderBtn=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.vassalBtn);self.vassalBtn=nil;
_UIObject_release(self.vassalList);self.vassalList=nil;
_UIObject_release(self.vassalPanel);self.vassalPanel=nil;
_UIObject_release(self.zmJJ);self.zmJJ=nil;
_UIObject_release(self.zmModel);self.zmModel=nil;
_UIObject_release(self.zmName);self.zmName=nil;
end
















local _this=nil
local _abName="ui/windows/systemzongmen/systemzongmen_atlas_pak.ab"
local _refreshFlagHandle={
[systemZongMenFightFlagType.eNone]="refreshAttackBtn_Normal",
[systemZongMenFightFlagType.eBeAttacked]="refreshAttackBtn_Attacking",
[systemZongMenFightFlagType.eAttacking]="refreshAttackBtn_Normal",
[systemZongMenFightFlagType.eSurrender]="refreshAttackBtn_Surrender",
[systemZongMenFightFlagType.eExpel]="refreshAttackBtn_Normal",
[systemZongMenFightFlagType.eVassal]="refreshAttackBtn_Vassal",
}
local _dazhenCheck={
[systemZongMenFightFlagType.eSurrender]="投降",
[systemZongMenFightFlagType.eExpel]="驱逐",
[systemZongMenFightFlagType.eVassal]="附庸",
}



function UISystemZongMenInfoWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
self:addNotify(notifyConfig.onSystemZMInfoChange,self.onSystemZMInfoChange)
self:addNotify(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
self:addNotify(notifyConfig.onSystemZMRenownRewardFlag,self.onSystemZMRenownRewardFlag)
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)
self:initVassalList()
end


function UISystemZongMenInfoWin:__delete()
self:unbindComponents()
_this=nil
self:endFlagTimer()
end




function UISystemZongMenInfoWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.dataInfo=systemZongMenModel:getInfoData(self.serial)

local zmType=cfgHelper.get2(cfg_syssectconfig_get,self.dataInfo.id,"type")
self.reputationList=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"renown_list",zmType)
self.reputationRange=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"sect_money_limit",systemZongMenInfoMoneyType.eShengWang)

self:initStrengthTips()
self:refreshAttackBtn()
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBase)then
self:refreshView()
end
end


function UISystemZongMenInfoWin:onHide()

end




function UISystemZongMenInfoWin:onAttackingBtn()
local sysId=SYSTEM_DEFINE.eXiTongZongMenZhanDou
if not systemModel.isOpen(sysId)then
local str=systemModel.getOpenTips(sysId)
UIManager.error(str)
return
end


if self.dataInfo.flag==systemZongMenFightFlagType.eBeAttacked then
local check=systemZongMenModel:checkDefenseInfo(self.dataInfo.serial)

if check then
if systemZongMenModel:isExistBattleWaitResult(self.dataInfo.serial)then
UIManager.error("已派遣进攻队伍")
return
end

local tasks=worldTaskModel:findAllFakeEx(function(task)
return task.target_type==eWorldUnitTpye.SYSTEMZM and task.target_id>0 and mathHelper.compareInt64(task.target_guid,self.dataInfo.serial)
end)

if#tasks>0 then
UIManager.error("已派遣进攻队伍")

elseif(self.dataInfo.end_time-timeHelper.getServerShortTime())<=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"teamMoveTime",1)then
UIManager.error("剩余时间已不足派遣进攻队伍")
else
systemZongMenController:showFightPrepare(self.dataInfo)
end
else
UIManager.error("正在获取该宗门防御情报，请稍后")
end
else
UIManager.error("已不再战争状态")
end
end

function UISystemZongMenInfoWin:onSurrenderBtn()
local sysId=SYSTEM_DEFINE.eXiTongZongMenZhanDou
if not systemModel.isOpen(sysId)then
local str=systemModel.getOpenTips(sysId)
UIManager.error(str)
return
end

UIFullSystemZongMenControl:showWindow("UISystemZongMenSurrenderWin",self.serial)
end

function UISystemZongMenInfoWin:onVassalBtn()
local sysId=SYSTEM_DEFINE.eXiTongZongMenZhanDou
if not systemModel.isOpen(sysId)then
local str=systemModel.getOpenTips(sysId)
UIManager.error(str)
return
end

self.vassalPanel:setScale(Vector3.one)
self.winlua:ForceLayoutRect(self.vassalPanel:getID())
end

function UISystemZongMenInfoWin:onVassalPanel()
self.vassalPanel:setScale(Vector3.zero)
end

function UISystemZongMenInfoWin:onDaZhenBtn()
local sysId=SYSTEM_DEFINE.eXiTongZongMenZhanDou
if not systemModel.isOpen(sysId)then
local str=systemModel.getOpenTips(sysId,"需要","方可查看")
UIManager.error(str)
return
end

local type=cfgHelper.get2(cfg_syssectconfig_get,self.dataInfo.id,"type")
if type==2 then
UIManager.error("剧情宗门不能被进攻")
return
end

local check=_dazhenCheck[self.dataInfo.flag]
if check then
UIManager.error(FMT.fmt("无法查看{0}宗门的大阵",check))
return
end

if mathHelper.validInt64(self.dataInfo.disciple_guid)then
if not UIDiscipleModel:checkDiscipleState2(self.dataInfo.disciple_guid,DISCIPLE_STATE_TYPE.eBeiBu)then
local check=systemZongMenModel:checkDefenseInfo(self.dataInfo.serial)
if check then
if self.dataInfo.flag==systemZongMenFightFlagType.eExpel then
UIManager.error("该宗门已被驱逐")
else
UIFullSystemZongMenControl:showWindow("UISystemZongMenDaZhenWin",self.serial)
end
else
UIManager.error("正在获取该宗门防御情报，请稍后")
end
else
UIManager.error("被捕弟子无法破坏大阵")
end
else
UIManager.error("请先派遣弟子潜入")
end
end


function UISystemZongMenInfoWin:onGiftBtn()

local relation=systemZongMenModel:getInfoDataRelation(self.serial)
if relation~=systemZongMenRelationType.eDiDui then
systemZongMenController:req_giftInfo(self.serial)
UIFullSystemZongMenControl:showWindow("UISystemZongMenGiftWin",self.serial)
else
UIManager.error("对方拒绝接见我方使节")
end
end


function UISystemZongMenInfoWin:onAllyBtn()
UIManager.info("敬请期待")
end


function UISystemZongMenInfoWin:onAttackBtn()


local sysId=SYSTEM_DEFINE.eXiTongZongMenZhanDou
if not systemModel.isOpen(sysId)then
local str=systemModel.getOpenTips(sysId,"需要","方可攻打")
UIManager.error(str)
return
end

local type=cfgHelper.get2(cfg_syssectconfig_get,self.dataInfo.id,"type")
if type==2 then
UIManager.error("不能进攻该宗门")
return
end

if self.dataInfo.flag==systemZongMenFightFlagType.eNone then
if self.dataInfo.tayin==0 then
if systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eAttacking)then
UIManager.error("需要先防守宗门的进攻")
else
UIDialogManager.getCommonDialog2(nil,"是否确认攻打该宗门？\n<color=red>(一旦攻打该宗门会立刻进入敌对状态)</color>",function()
systemZongMenController:req_attack(self.dataInfo.serial)
end)
end
else
UIManager.error("弟子拓印中，无法开始战争")
end
elseif self.dataInfo.flag==systemZongMenFightFlagType.eBeAttacked then
UIManager.error("已开始进攻该宗门")
elseif self.dataInfo.flag==systemZongMenFightFlagType.eAttacking then
UIManager.error("需要先防守宗门的进攻")
elseif self.dataInfo.flag==systemZongMenFightFlagType.eSurrender then
UIManager.error("该宗门已被击破")
elseif self.dataInfo.flag==systemZongMenFightFlagType.eExpel then
UIManager.error("该宗门已被驱逐")
elseif self.dataInfo.flag==systemZongMenFightFlagType.eVassal then
UIManager.error("已成为附庸宗门")
end
end

function UISystemZongMenInfoWin:onRelationBtn()
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBase)then
UIFullSystemZongMenControl:showWindow("UISystemZongMenRelationDialog")
end
end

function UISystemZongMenInfoWin:onReputationBtn()
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBase)then
if self.zmCfg.renownRewards then
local args={
serial=self.serial
}
UIFullSystemZongMenControl:showWindow("UISystemZongMenReputationDialog",args)
end
end
end

function UISystemZongMenInfoWin:onQuZhuBtn()
local type=cfgHelper.get2(cfg_syssectconfig_get,self.dataInfo.id,"type")
if type==2 then
UIManager.error("不能驱逐该宗门")
return
end

local nameStr=systemZongMenModel:getNameStr(self.dataInfo.id,self.dataInfo.nameIdx)

local callback=function()
if _this==nil then return end
systemZongMenController:req_deal_surrender(_this.serial,2)
end

local taskid=XianjieXuanShangModel:getXJXStaskidbyGuid(self.serial)
if taskid then
local taskRepeatVis=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eQuZhuTipsTask)
if taskRepeatVis then
callback()
else
local taskCfg=cfg_xianjiexuanshangtaskconfig_get(taskid)
local content=FMT.fmt("{0}正在执行{1}任务，驱逐宗门后任务将自动取消，且无法获得任务奖励，是否驱逐该宗门?",toColorString(FONT_COLOR.eOrangeColor,nameStr),toColorString(FONT_COLOR.eOrangeColor,taskCfg.name))
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
if _this==nil then return end
callback()
end,
showclosebtn=true,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eQuZhuTipsTask,flag)
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
return
end

local baseRepeatVis=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eQuZhuTipsBase)
if baseRepeatVis then
callback()
else
local content=FMT.fmt("是否驱逐宗门{0}?",toColorString(FONT_COLOR.eOrangeColor,nameStr))
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
callback()
end,
showclosebtn=true,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eQuZhuTipsBase,flag)
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
end

function UISystemZongMenInfoWin.onSystemZMDetailInfo(partType,serial)
if serial==_this.serial and partType==systemZongMenDetailDataPart.eBase then
_this:refreshView()
end
end

function UISystemZongMenInfoWin:refreshView()
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBase)
local nameStr=systemZongMenModel:getNameStr(self.dataInfo.id,self.dataInfo.nameIdx)
self.name:setText(nameStr)
self:refreshLevel(self.dataInfo.level)
self:refreshStability(self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eWenDingDu])

self.zmCfg=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)
local campSp,campAb=systemZongMenModel:getCampIcon(self.zmCfg.camp)
self.campIcon:setSprite(campAb,campSp)

local zmNameStr=FMT.fmt("掌门：{0}",self.detailInfo.leader_name)
self.zmName:setText(zmNameStr)
local zmJJStr=UIDiscipleModel:getJJNameEx(self.detailInfo.leader_jingjie)
self.zmJJ:setText(zmJJStr)
local zmImage=UIDiscipleModel.calculationDiscipleImage(self.detailInfo.leader_data,self.detailInfo.leader_image)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(zmImage)
comHelper.setChildInSideModelEx(self.zmModel,modelParams,1,nil,0,0,false,true)

local config=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)
if config.strengthIcon then
local spriteName=FMT.fmt("icon_zhongmenB_0{0}",config.strengthIcon)
self.strengthIcon:setSprite(globalABLookup.dashijie_component,spriteName)
self.strengthTx:setActive(true)
else
self.strengthIcon:setChildIcon("",false)
self.strengthTx:setActive(false)
end

self:refreshRelation(self.dataInfo.relation_num)

self:refreshReputation(self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eShengWang])
end

function UISystemZongMenInfoWin:refreshRelation(value)
local relationCfg=cfgHelper.get1(cfg_syssectrelationconfig_get,value)
local relationName=relationCfg.name
self.relationTx:setText(relationCfg.name)
self.relationIcon:setSprite(relationCfg.icon[1],relationCfg.icon[2])
end

function UISystemZongMenInfoWin:refreshLevel(value)
local levelStr=FMT.fmt("<color=#7D3B17>宗门等级：</color>{0}",value)
self.level:setText(levelStr)
end

function UISystemZongMenInfoWin:refreshStability(value)
local stabilityStr=FMT.fmt("稳定度：{0}",value)
self.stability:setText(stabilityStr)
end

function UISystemZongMenInfoWin:refreshReputation(value)
local reputationIndex=systemZongMenModel:getRenownIndex(self.dataInfo.id,value)
local reputationStr=systemZongMenModel:getRenownName(reputationIndex)
local reputationIconName=systemZongMenModel:getRenownIcon(reputationIndex)
self.reputationTx:setText(reputationStr)
self.reputationIcon:setSprite(_abName,reputationIconName)
self:refreshReputationReddot()

local sSeg=self.reputationList[reputationIndex-1]or self.reputationRange[1]
local eSeg=self.reputationList[reputationIndex]or self.reputationRange[2]
local showProgress=#self.reputationList>=reputationIndex
if showProgress then
local mSeg=eSeg-sSeg
local cSeg=math.min(value-sSeg,mSeg)
local progressValue=math.floor(cSeg/mSeg*10000)
self.reputationProgressBar:setProgressValue(progressValue,10000)
self.reputationProgressBar:setChildProgressText(FMT.fmt("{0}/{1}",cSeg,mSeg))
else
self.reputationProgressBar:setProgressValue(10000,10000)
self.reputationProgressBar:setChildProgressText("满级")
end
end

function UISystemZongMenInfoWin:refreshReputationReddot()
local reddot=systemZongMenModel:getReddot_Renown(self.serial)
self.reputationReddot:setActive(reddot)
end

function UISystemZongMenInfoWin:initVassalList()
local list=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"vassalRule0")
self.vassalList:setChildLayoutGroupCreateItems(#list,function(index)
local item=self.vassalList:getChildLayoutGroupGridItem(index-1)
item:SetChildText(-1,list[index])
end)
end

function UISystemZongMenInfoWin:refreshAttackBtn()
self[_refreshFlagHandle[self.dataInfo.flag]](self)
end

function UISystemZongMenInfoWin:refreshAttackBtn_Normal()
self.attackBtn:setActive(true)

local open=systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)
self.attackLock:setActive(not open)
self.daZhenLock:setActive(not open)
self.daZhenBtn:setChildGraphicGray(not open)
self.attackBtn:setChildGraphicGray(not open)

self.attackingBtn:setActive(false)
self.vassalBtn:setActive(false)
self.surrenderBtn:setActive(false)
self.quZhuBtn:setActive(false)
self:endFlagTimer(true)
end

function UISystemZongMenInfoWin:refreshAttackBtn_Attacking()
self.attackBtn:setActive(false)
self.attackingBtn:setActive(true)
self.vassalBtn:setActive(false)
self.surrenderBtn:setActive(false)
self.quZhuBtn:setActive(false)
self:startFlagTimer(true)
end

function UISystemZongMenInfoWin:refreshAttackBtn_Surrender()
self.attackBtn:setActive(false)
self.attackingBtn:setActive(false)
self.vassalBtn:setActive(false)
self.surrenderBtn:setActive(true)
self.quZhuBtn:setActive(false)
self:startFlagTimer(true)
end

function UISystemZongMenInfoWin:refreshAttackBtn_Vassal()
self.attackBtn:setActive(false)
self.attackingBtn:setActive(false)
self.vassalBtn:setActive(true)
self.surrenderBtn:setActive(false)

local isShowQuZhuBtn=self.dataInfo.flag==systemZongMenFightFlagType.eVassal and self.dataInfo.start_time<0
self.quZhuBtn:setActive(isShowQuZhuBtn)

local isStartTimer=self.dataInfo.start_time>=0
self:startFlagTimer(isStartTimer)
end

function UISystemZongMenInfoWin:startFlagTimer(refresh)
if refresh then
self.timeBg:setActive(true)
self:updateFlagTimer()
end
if not self.flagTimer then
self.flagTimer=self:setTimer(1,0,function()
self:updateFlagTimer()
end)
end
end

function UISystemZongMenInfoWin:updateFlagTimer()
local nowTime=timeHelper.getServerShortTime()
local endTime=self.dataInfo.end_time
local deltaTime=math.max(endTime-nowTime,0)
local timeStr=timeHelper.format_time_stamp3(deltaTime,true)
self.timeTx:setText(timeStr)
end

function UISystemZongMenInfoWin:endFlagTimer(refresh)
if self.flagTimer then
self:stopTimerByID(self.flagTimer)
self.flagTimer=nil
if refresh then
self.timeTx:setText("")
self.timeBg:setActive(false)
end
end
end

function UISystemZongMenInfoWin.onSystemZMInfoChange(serial,type,oldVal,param)
if _this.serial==serial then
if type==systemZongMenInfoUpdateType.eLevel then
local levelStr=FMT.fmt("宗门等级：{0}",param)
_this.level:setText(levelStr)
elseif type==systemZongMenInfoUpdateType.eRelation then
_this:refreshRelation(param)
end
end
end

function UISystemZongMenInfoWin.onSystemZMMoneyNumChange(serial,eType,newVal,oldVal)
if _this.serial==serial then
if eType==systemZongMenInfoMoneyType.eShengWang then
_this:refreshReputation(newVal)
elseif eType==systemZongMenInfoMoneyType.eWenDingDu then
_this:refreshStability(newVal)
end
end
end

function UISystemZongMenInfoWin.onSystemZMRenownRewardFlag(serial,idx,old)
if _this.serial==serial then
_this:refreshReputationReddot()
end
end

function UISystemZongMenInfoWin.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
if _this.serial==serial then
_this:refreshAttackBtn()
local detailInfo=_this.detailInfo
if _this.isVisible and newFlag==systemZongMenFightFlagType.eBeAttacked and detailInfo then
local strLib=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"startWarSpeak")
local args={
discipledata=detailInfo.leader_data,
discipleimage=detailInfo.leader_image,
disciplename=detailInfo.leader_name,
talkcontent=strLib[math.random(1,#strLib)],
callback=function()
UIFullSystemZongMenControl:closeWindow("UISystemZongMenDiscipleTalkWin")
_this:onAttackingBtn()
end,
}
UIFullSystemZongMenControl:showWindow("UISystemZongMenDiscipleTalkWin",args)
end
end
end

function UISystemZongMenInfoWin.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXiTongZongMenZhanDou then
systemZongMenController:req_look_dazhen(_this.serial)
end
end

function UISystemZongMenInfoWin:onStrengthIcon()
local config=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)
if config.strengthIcon then
self.strengthPanel:setScale(Vector3.one)
self.winlua:ForceLayoutRect(self.strengthPanel:getID())
end
end

function UISystemZongMenInfoWin:onStrengthPanel()
self.strengthPanel:setScale(Vector3.zero)
end

function UISystemZongMenInfoWin:initStrengthTips()
local config=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)
local str=config.strengthTx
self.strengthTips:setText(str)
end
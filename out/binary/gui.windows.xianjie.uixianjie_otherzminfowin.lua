







def_class("UIXianJie_otherZmInfoWin",UIWindowBase)









function UIXianJie_otherZmInfoWin:bindComponents()

self.attackBtn=UIButton.get(self,0)
self.costTimeItem=UIObject.get(self,1)
self.costTimeTxt=UIText.get(self,2)
self.fhz=UIObject.get(self,3)
self.fsBtn=UIButton.get(self,4)
self.fsCD=UIText.get(self,5)
self.fsCDBg=UIObject.get(self,6)
self.fzBanFlag=UIObject.get(self,7)
self.fzBtn=UIButton.get(self,8)
self.fzCD=UIText.get(self,9)
self.fzCDBg=UIObject.get(self,10)
self.fzImage=UIObject.get(self,11)
self.headIconCreater=UIObject.get(self,12)
self.helpBtn=UIButton.get(self,13)
self.helpText=UIText.get(self,14)
self.jijieBtn=UIButton.get(self,15)
self.lymsPanel=UIButton.get(self,16)
self.mask=UIButton.get(self,17)
self.playerName=UIText.get(self,18)
self.posTxt=UIText.get(self,19)
self.recordBtn=UIButton.get(self,20)
self.root=UIObject.get(self,21)
self.ruleBtn=UIButton.get(self,22)
self.sdBanFlag=UIObject.get(self,23)
self.sdBtn=UIButton.get(self,24)
self.sdCD=UIText.get(self,25)
self.sdCDBg=UIObject.get(self,26)
self.sdImage=UIObject.get(self,27)
self.searchBanFlag=UIObject.get(self,28)
self.searchBtn=UIButton.get(self,29)
self.shareBtn=UIButton.get(self,30)
self.shenDunBtn=UIButton.get(self,31)
self.xmItem=UIObject.get(self,32)
self.xyNameText=UIText.get(self,33)
self.zmFightValueText=UIText.get(self,34)
self.zmNameText=UIText.get(self,35)
self.mjslpanel=UIObject.get(self,36)
self.mjslskill=UIObject.get(self,37)
self.slItem=UIObject.get(self,38)
self.slNameText=UIText.get(self,39)
self.mjtag=UIImage.get(self,40)

self.attackBtn:setButtonClick(function()self:onAttackBtn()end)

self.fsBtn:setButtonClick(function()self:onFsBtn()end)

self.fzBtn:setButtonClick(function()self:onFzBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.jijieBtn:setButtonClick(function()self:onJijieBtn()end)

self.lymsPanel:setButtonClick(function()self:onLymsPanel()end)

self.mask:setButtonClick(function()self:onMask()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.sdBtn:setButtonClick(function()self:onSdBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.shenDunBtn:setButtonClick(function()self:onShenDunBtn()end)



end


function UIXianJie_otherZmInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attackBtn);self.attackBtn=nil;
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.costTimeTxt);self.costTimeTxt=nil;
_UIObject_release(self.fhz);self.fhz=nil;
_UIObject_release(self.fsBtn);self.fsBtn=nil;
_UIObject_release(self.fsCD);self.fsCD=nil;
_UIObject_release(self.fsCDBg);self.fsCDBg=nil;
_UIObject_release(self.fzBanFlag);self.fzBanFlag=nil;
_UIObject_release(self.fzBtn);self.fzBtn=nil;
_UIObject_release(self.fzCD);self.fzCD=nil;
_UIObject_release(self.fzCDBg);self.fzCDBg=nil;
_UIObject_release(self.fzImage);self.fzImage=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.helpText);self.helpText=nil;
_UIObject_release(self.jijieBtn);self.jijieBtn=nil;
_UIObject_release(self.lymsPanel);self.lymsPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.sdBanFlag);self.sdBanFlag=nil;
_UIObject_release(self.sdBtn);self.sdBtn=nil;
_UIObject_release(self.sdCD);self.sdCD=nil;
_UIObject_release(self.sdCDBg);self.sdCDBg=nil;
_UIObject_release(self.sdImage);self.sdImage=nil;
_UIObject_release(self.searchBanFlag);self.searchBanFlag=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.shenDunBtn);self.shenDunBtn=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
_UIObject_release(self.xyNameText);self.xyNameText=nil;
_UIObject_release(self.zmFightValueText);self.zmFightValueText=nil;
_UIObject_release(self.zmNameText);self.zmNameText=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
_UIObject_release(self.slItem);self.slItem=nil;
_UIObject_release(self.slNameText);self.slNameText=nil;
_UIObject_release(self.mjtag);self.mjtag=nil;
end















local _this
local cjson=require'cjson'
local slskillidx=
{
skillbtn=0,
icon=1,
name=2,
djsbg=3,
djs=4
}



function UIXianJie_otherZmInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)
self:addNotify(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
self:addNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)
self:addNotify(notifyConfig.onXianJieEntityDataChange,self.onXianJieEntityDataChange)
end


function UIXianJie_otherZmInfoWin:__delete()
self:unbindComponents()
self:stopFsTick()
xianjieController:closeWin2('UIXianJie_otherZmInfoWin')
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
if zmData then
zmData:selectEntity(false)
end
self:stopSelfTimerMJSL()
_this=nil
end




function UIXianJie_otherZmInfoWin:onShow(argtable,afterOnloaded)
self.actorId=argtable and argtable.actorId
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
if zmData==nil then
self:closeSelf()
else
self:refreshInfo(zmData)
end

local isSelfPlayer=playerModel:checkActorId(self.actorId)
self.enemyType=xianjieModel:checkEnemyType2(self.actorId,zmData.ownersceneidx)
local isFriend=self.enemyType==xjEnemyType.eAllies
if not isSelfPlayer and isFriend then
YingXianGeController.reqZhiYuan(self.actorId)
end
if afterOnloaded then
if zmData then
zmData:selectEntity(true)
end
end
end



function UIXianJie_otherZmInfoWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_otherZmInfoWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_otherZmInfoWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onCloseClick()
end

function UIXianJie_otherZmInfoWin.onXianJieMonsterChange(typo,infoguid)
if _this==nil or not _this.isVisible then return end
if typo==CHANGE_TYPE.eDelete then
if tostring(_this.infoguid)==tostring(infoguid)then
xianjieController:closeWin3()
end
end
end

function UIXianJie_otherZmInfoWin.onTeQuanInfoChange(tqData)
if _this==nil or not _this.isVisible then return end
local tqid=tqData.tqid
if tqid==_this.fzTqId then
_this:refreshFzCD()
elseif tqid==cfgHelper.get3(cfg_fairylandbaseconfig_get,1,"fengsuoZongMen",1)then
_this:refreshFsCD()
elseif tqid==XIANGUAN_PRIVILEGE_ENUM.eTqType_17 then
_this:refreshSdCD()
end
end

function UIXianJie_otherZmInfoWin.onChangeXianGuanJob(jobInfo)
if _this==nil or not _this.isVisible then return end
if jobInfo.actorid==_this.actorId then
_this:refreshView()
end
end

function UIXianJie_otherZmInfoWin.onXianJieEntityDataChange(posTable,actorid)
if _this==nil or not _this.isVisible then return end
if actorid==_this.actorId then
_this:refreshView()
end
end




function UIXianJie_otherZmInfoWin:onHide()

end

function UIXianJie_otherZmInfoWin:onShowArgRecv(argtable)
local oldId=self.actorId
if oldId and not mathHelper.compareInt64(oldId,argtable.actorId)then
local zmData=xianjieModel:getZongMenData(oldId)
if zmData then
zmData:selectEntity(false)
end
zmData=xianjieModel:getZongMenData(argtable.actorId)
if zmData then
zmData:selectEntity(true)
end
end

if argtable and argtable.actorId then
self.actorId=argtable.actorId
end
self:refreshView()
end

function UIXianJie_otherZmInfoWin:refreshActorInfo(actorId)
if actorId==self.actorId then
self:refreshView()
end
end

function UIXianJie_otherZmInfoWin:refreshView()
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
if zmData==nil then
self:closeSelf()
else
self:refreshInfo(zmData)
end
end

function UIXianJie_otherZmInfoWin:refreshInfo(zmData)
if zmData==nil then
zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
end
if zmData==nil then return end
self.serverid=zmData.serverid

local gridX_c,gridZ_c=zmData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c


local iconInfo=zmData.iconInfo
playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=iconInfo,scale=0.82})


local nameStr=zmData.actorname
self.playerName:setText(nameStr)
self.shareplayer=nameStr
local isFriend=self.enemyType==xjEnemyType.eAllies


local sceneidx=zmData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(sceneidx)then

self.costTimeItem:setActive(false)
else
self.costTimeItem:setActive(true)
local gridX=zmData.gridX
local gridZ=zmData.gridZ
local speed
local marchType
if isFriend then
marchType=xjServerMarchType.eYuanZhu
else
marchType=xjServerMarchType.eAttackRole
end
speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",marchType,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX,gridZ,speed,nil,nil,nil)
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
self.costTimeTxt:setText(time_str)
end


local zmName=zmData.sectname
self.zmNameText:setText(zmName)
self.sharezm=zmName


local fight=mathHelper.int64_to_number(zmData.fightvalue)
self.zmFightValueText:setText(mathHelper.formatNumber3(fight))


local xmGuid=zmData.guildid
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
local xmWidget=self.xmItem:getWidgetBase()
xmWidget:SetChildActive(1,hasXM)
xmWidget:SetChildActive(4,hasXM)
local xmName_str
local xmData
if hasXM then

xmData=xianjieModel:getXianMengData(xmGuid)
self.xmGuid=xmGuid
end

if xmData then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

xmWidget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

xmWidget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

xmWidget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


local guildid=xmData.guildid
xmWidget:SetChildButtonClick(4,function()

local isOther=xianjienSceneIndexType:isOhterXianYu(zmData.ownersceneidx)
if not isOther then
xianmengController:openXMDetailInfoWin(guildid)
else
UIManager.error('不同仙域的仙盟，无法探知其信息')
end
end,true)
else
xmName_str='无'
if hasXM then
xianmengController:reqXMDetailData(xmGuid)
end
end
xmWidget:SetChildText(0,xmName_str)


local ownersceneidx=zmData.ownersceneidx
local xyNameStr=xianjieController:getCrossServerNamebySCidx(ownersceneidx)
local selfSceneidx=xianjieModel:getXianYuSceneIndex()
if ownersceneidx~=selfSceneidx then

xyNameStr=FMT.cfmt(FONT_COLOR.eRedColor,"【异界】{0}",xyNameStr)
end
self.xyNameText:setText(xyNameStr)


self:refreshBottomPanel(zmData)

self:refreshFsCD()

self:refreshFzCD()

self:refreshSdCD()


self:refreshLYMSPanel()

self:freshMoJieShiLiItem(zmData)
self:freshMoJiePnael(zmData)
self:freshMoJieSkillPnael(zmData)
end

function UIXianJie_otherZmInfoWin:refreshBottomPanel(zmData)
if zmData==nil then
zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
end
if zmData==nil then return end

local enemyType=xianjieModel:checkEnemyType2(self.actorId,zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eAllies
local isEnemy=enemyType==xjEnemyType.eEnemy
local isOpenFangHuZhao=xianjieModel:isOpenFangHuZhao(self.actorId)or
xianjieModel:isOpenTianShuShenDun(self.actorId)
local isOther=xianjienSceneIndexType:isOhterXianYu(zmData.sceneidx)

local isShowSearchBtn=not isFriend and not isOther
self.searchBtn:setActive(isShowSearchBtn)
if isShowSearchBtn then

local hasLYMSBuff=xianjieModel:isCanNotTanChaAndFangZhu(self.actorId)
self.searchBtn:setChildImageExGray(hasLYMSBuff)
self.searchBanFlag:setActive(hasLYMSBuff)
end

local isInMoGong=xianjieController:checkInMoGongZhengDuo()
local sceneidx=zmData.sceneidx
local isXianYu=xianjienSceneIndexType:isXianYu(sceneidx)
self.attackBtn:setActive(not isFriend and not isXianYu)

self.jijieBtn:setActive(false)
self.helpBtn:setActive(not isEnemy and not isOther)
self.fhz:setActive(isOpenFangHuZhao)
self.shenDunBtn:setActive(false)

self:refreshYuanZhuBtnText()
end

function UIXianJie_otherZmInfoWin:refreshYuanZhuBtnText()
local canYuanZhu=self:getIsCanYuanJun()
self.helpText:setText(canYuanZhu and"援助"or"查看援军")
end

function UIXianJie_otherZmInfoWin:getIsCanYuanJun()
local actorId=playerModel:getActorID()
local sceneidx=xianjieModel:getSceneIndex()
local hasYuanZhu=YingXianGeModel:getYZMYItem(self.actorId,actorId,sceneidx)~=nil
local isInXM=xianmengModel:checkActorInXM(self.actorId)
local wpData=xianjieModel:getWaiPaiByQBEntityData2(xjWaiPiaBaseType.eMarckTeam,self.actorId)
return isInXM and not hasYuanZhu and not wpData
end

function UIXianJie_otherZmInfoWin:rec_detail(guildid)
if mathHelper.compareInt64(guildid,self.xmGuid)then

self.detailData=xianjieModel:getXianMengData(guildid)
self:refreshView()
end
end

function UIXianJie_otherZmInfoWin:refreshLYMSPanel()

local actorId=self.actorId
local jobType=XIANGUAN_TYPE_ENUM.eLingYinMiShi
local isLYMS,jobId=xianguanController:checkActorHasJobByType(actorId,jobType)
local isShowLymsPanel=false
if isLYMS then
local privilegeId=XIANGUAN_PRIVILEGE_ENUM.eTianMuGeShi

local isHasTq=xianguanConfig.checkJobCfgHasTeQuan(jobId,privilegeId)
if isHasTq and xianguanHelper.checkTeQuanPlatformLimit(privilegeId)and xianguanHelper.checkSpecialUseCondition(jobId,privilegeId,false)then
self.lymsPanel:setActive(true)
isShowLymsPanel=true
local widget=self.lymsPanel:getWidgetBase()

widget:SetChildButtonClick(-1,function()
if _this==nil or not _this.isVisible then return end
return _this:onLYMSPanelClick()
end,true)


local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local iconName=xianguanConfig.getTeQuanIconName(privilegeCfg.icon)
local abName="ui/icons/xianguantequan/xianguantequan_atlas_pak.ab"
widget:SetChildCSImageSprite(1,abName,iconName)


local isValid=xianjieModel:isZmInvisible(actorId)


local str
if isValid then
str="非战争狂热时，只有盟友可见"
else
str="战争狂热中，天幕隔世特权失效"
end
widget:SetChildText(2,str)
end
end
self.lymsPanel:setActive(isShowLymsPanel)
end




function UIXianJie_otherZmInfoWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eZongMen
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''








local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local winParams={
parentWin=self,
lang=langId,
num=nil,
screenPos=screenPos,
}
self:showWindow("UIXianJie_commonRuleWin",winParams)
end



function UIXianJie_otherZmInfoWin:onRecordBtn()
local zmName=self.sharezm
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.zongmen,
nameStr=zmName,
sharename=zmName,
ishujian=false,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end



function UIXianJie_otherZmInfoWin:onShareBtn()
local zmName=self.sharezm
local nameStr=self.shareplayer
local _sceneType=xianjieModel:getScenceType()
local data=
{
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=zmName,
shareType=xianjie_Point_Share.zongmen,
scenceType=_sceneType,
name=zmName,
shareName=nameStr,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(_sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end



function UIXianJie_otherZmInfoWin:onSearchBtn()
if xianjieModel:isOpenFangHuZhao(self.actorId)then
UIManager.error('对方已开启护山大阵，无法侦查')
return
end
local hasLYMSBuff=xianjieModel:isCanNotTanChaAndFangZhu(self.actorId)
if hasLYMSBuff then
local jobType=XIANGUAN_TYPE_ENUM.eLingYinMiShi
local isLYMS,jobId=xianguanController:checkActorHasJobByType(self.actorId,jobType)
if isLYMS then
UIManager.error('对方是灵隐密使，无法侦查')
else
UIManager.error('对方在灵隐密使的保护范围内无法侦查')
end
return
end
UIManager:showWindow('UIXianJie_zmSearchTipsWin',{actorId=self.actorId})
end



function UIXianJie_otherZmInfoWin:onAttackBtn()
local actorId=self.actorId

local zmData=xianjieModel:getZongMenData(actorId)

local ret,retType,args=xianjieModel:isCanAttackRole(zmData,true)
if not ret then
xianjieModel:showAttackRoleTips(retType,args)
return
end

local flag,g_list,errorParams=zmData:checkMovePathCondition(true,true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
local isBornAreaPath=errorParams.isBornAreaPath
if isSelfInNeutralArea then

errStr="处于阵外无法进攻本阵内的其他祖师"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法进攻阵外的祖师"
else
if isBornAreaPath then

errStr="处于本阵内无法进攻其他祖师"
else

errStr="处于本阵内无法进攻其他本阵内的其他祖师"
end
end
UIManager.error(errStr)
end
return
end

local isMy=playerModel:checkActorId(actorId)

local func1=function(dzlist,soldierList,yzid)
if xianjieModel:getXJYZChuZhenTeamList(yzid)then
UIManager.error('云舟已出征')
return
end
local dzlen=#dzlist
if dzlen<=0 then
UIManager.error('出征必须携带弟子')
return
end
local cnt=0
for _,v in ipairs(soldierList)do
cnt=cnt+v[2]
end

local hasCnt=0
local cfgs=cfg_fairylandsoldierconfig()
for i=1,#cfgs do
local moneyType=eMoneyType[string.format('mtFLSoldier%d_1',i)]
hasCnt=hasCnt+moneyModel.getMoney(moneyType)
end

local func2=function()
xianjieController:reqOrder(int64.new(tostring(actorId)),
xjServerMarchType.eAttackRole,
dzlist,soldierList,'',yzid,nil,g_list)
end
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eChuZhanNotEnoughSoldier)
if not check and cnt>math.floor(hasCnt/2)then
local desc='本次出征后，云甲营中的剩余修士将不足以支持防守阵容所需，确定要出征吗？'
UIDialogManager.getConfirmDialog3(nil,desc,func2,REPEAT_TYPE.eChuZhanNotEnoughSoldier)
else
func2()
end
end

local func=function(targetFight)

local gridX=zmData.gridX
local gridZ=zmData.gridZ
self.sharex=gridX
self.sharez=gridZ
local sceneidx=zmData.sceneidx
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eAttackRole,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX,gridZ,speed,nil,nil,nil)
wayTime=math.ceil(wayTime)
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func1,
orderType=xjOrderType.eAttackRole,
isIgnoreCheckFreeTeam=true,
isIgnoreCheckCost=true,
isCheckYBDData=false,
minSoldierNum=1,
targetFight=targetFight,
wayTime=wayTime,
cancelCallBack=function()
xianjieController:openZmInfoWin(isMy,actorId)
end,
})
end

local fightFunc=function()
local datatb=xianjieModel:Get_searchLogLookup(actorId,0)
if datatb then
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
if left>=maxTime then
func()
else
local args_={actorid=actorId,serverid=self.serverid,guid=datatb.guid,stationguid=0,markRecored=true}
local callback=function(args,other)
if _this==nil then
func()
return
end
local logtb=self:splitStr(datatb.params)
local dzFightList={}
for i=1,args.disciplelistlen do
local baseData=table.weakCopy(args.discipleList[i])
if baseData.flag>0 then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(baseData)
local dzGuidStr=tostring(dzData.base.discipleguid)
local fightValue=mathHelper.int64_to_number(dzData.base.fightvalue)
dzFightList[dzGuidStr]=fightValue
end
end

local soldierList={}
local moneyList=logtb[2]
if#moneyList>0 then
for i,v in pairs(moneyList)do
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(v[1])
if soldierLevel and soldierLevel>0 then
if not soldierList[soldierLevel]then
soldierList[soldierLevel]=0
end
soldierList[soldierLevel]=soldierList[soldierLevel]+v[2]
end
end
end
local fightValue=xianjieModel:getXJYZTeamFightValue(dzFightList,soldierList)
func(fightValue)
end
otherPlayerModel:reqActorXianJieInfo(otherPlayerInfoType.eXianJieSearchLog,self.actorId,args_,callback)
end
else
func()
end
end

if tianshudazhenModel:isOpeningFHZ()then
local desc='参与战争将退出护山大阵，是否继续参与？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,fightFunc)
else
fightFunc()
end
end



function UIXianJie_otherZmInfoWin:onJijieBtn()



























































end

function UIXianJie_otherZmInfoWin:onShenDunBtn()
UIManager:showWindow('UITianShuDaZhenOtherUseWin',{actorid=self.actorId})
end



function UIXianJie_otherZmInfoWin:onMask()
xianjieController:closeWin('UIXianJie_otherZmInfoWin')
end



function UIXianJie_otherZmInfoWin:onHelpBtn()
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
if not zmData then
return nil
end

local flag,g_list,errorParams=zmData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法向本阵内祖师进行援助"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法向阵外祖师进行援助 "
else

errStr="处于阵内无法向其他本阵内祖师进行援助"
end
UIManager.error(errStr)
end
return
end

local enemyType=xianjieModel:checkEnemyType2(self.actorId,zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eAllies
if isFriend then
local sceneidx=xianjieModel:getSceneIndex()
local cur,max=YingXianGeModel:getYZMYTotleXB(self.actorId,sceneidx)
if max==0 then
UIManager.error('盟友未建迎仙阁，暂不能援助')
return
end
else
YingXianGeController.reqZhiYuan(self.actorId)
end
UIManager:showWindow('UIYingXianGeMYYJWin',{actorId=self.actorId})
end


function UIXianJie_otherZmInfoWin:splitStr(str)
return cjson.decode(str)
end

function UIXianJie_otherZmInfoWin:onFsBtn()
local jobInfo=xianguanModel:getSelfGroupJobInfo(1)
local info=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"fengsuoZongMen")
local privilegeId=info[1]
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local privilegeObj=nil
if jobInfo then
local jobIDs=xianguanModel:getPrivilegeJobs(privilegeId)
if jobIDs then
local index=table.findValue(jobIDs,jobInfo.jobId)
if not index then
UIManager.error(info[2])
return
end
end

local privilegeKey=xianguanConfig.getTeQuanFindKey(jobInfo.jobId,privilegeId)
privilegeObj=xianguanModel:getSelfTequanObj(privilegeKey)
if privilegeObj then
if not privilegeObj:checkUseCondition()then
return
end
else
UIManager.error(info[2])
return
end
end


local zmData=xianjieModel:getZongMenData(self.actorId)
local mainEffect=privilegeCfg.effectArgs[1]
local buffId=mainEffect[1]
if zmData.bufflistlen>0 then
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(zmData.buffList)do
local buffCfg=cfg_fairylandbuffconfig_get(v.buffid)
for j,w in ipairs(buffCfg.effects)do
local effectType=w[1]
if effectType==xjBuffEffectType.eBanJinGuZongMen then
if v.endsec<=0 then
UIManager.error("对方宗门被封锁冷却中，无法再次对其封锁")
return
elseif nowTime<v.endsec then
UIManager.error(FMT.fmt("对方宗门被封锁冷却中，{0}后才能再次对其封锁",timeHelper.format_time_stamp(v.endsec-nowTime)))
return
end
end
end
end
end

local func=function()
local json=jsonHelper.encode({7,tostring(self.actorId)})
privilegeObj:use({exInfoJsonStr=json})
end

local duration=mainEffect[2]
local content=FMT.fmt("是否封锁<color=#ca631d>【{0}】</color>的宗门<color=#ca631d>{1}</color>？封锁期间，其宗门无法迁城，天枢大阵崩溃不被传送走，“煞气入侵”战争效果暂停倒数。",zmData.actorname,timeHelper.formatSimpleTime(duration))
UIDialogManager.getCommonDialog(nil,content,func)
end

function UIXianJie_otherZmInfoWin:refreshFsCD()
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
local enemyType=xianjieModel:checkEnemyType2(self.actorId,zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eAllies
if isFriend then
self:hideFsBtn()
return
end

local info=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"fengsuoZongMen")
if not info then
self:hideFsBtn()
return
end

local privilegeId=info[1]
if not xianguanHelper.checkTeQuanPlatformLimit(privilegeId)then
self:hideFsBtn()
return
end

local jobIDs=xianguanModel:getPrivilegeJobs(privilegeId)
if jobIDs==nil or#jobIDs<=0 then
self:hideFsBtn()
return
end

local checkShow=false
for i,v in ipairs(jobIDs)do
if xianguanModel:getSelfJobInfoByJobId(v)and xianguanHelper.checkSpecialUseCondition(v,privilegeId,false)then
checkShow=true
end
end
self.fsBtn:setActive(checkShow)

if checkShow then
for i,v in ipairs(jobIDs)do
local key=xianguanConfig.getTeQuanFindKey(v,privilegeId)
local privilegeObj=xianguanModel:getSelfTequanObj(key)
if privilegeObj and xianguanHelper.checkSpecialUseCondition(v,privilegeId,false)then
local leastTime=privilegeObj:getCdLeft()
if leastTime>0 then
self.fsTime=timeHelper.getServerShortTime()+leastTime
if self:updateFsTick()then
self.fsCDBg:setActive(true)
self:startFsTick()
return
end
end
end
end
end
self.fsTime=nil
self.fsCD:setText("")
self.fsCDBg:setActive(false)
self:stopFsTick()
end

function UIXianJie_otherZmInfoWin:hideFsBtn()
self.fsBtn:setActive(false)
self.fsTime=nil
self.fsCD:setText("")
self.fsCDBg:setActive(false)
self:stopFsTick()
end

function UIXianJie_otherZmInfoWin:startFsTick()
if not self.fsTick then
self.fsTick=self:setTimer(1,0,function()
if not self:updateFsTick()then
self:refreshFsCD()
end
end)
end
end

function UIXianJie_otherZmInfoWin:stopFsTick()
if self.fsTick then
self:stopTimerByID(self.fsTick)
self.fsTick=nil
end
end

function UIXianJie_otherZmInfoWin:updateFsTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.fsTime-nowTime
local temp=leastTime>0
if temp then
self.fsCD:setText(timeHelper.format_time_stamp(leastTime))
end
return temp
end

function UIXianJie_otherZmInfoWin:onFzBtn()
local hasLYMSBuff=xianjieModel:isCanNotTanChaAndFangZhu(self.actorId)
if hasLYMSBuff then
local jobType=XIANGUAN_TYPE_ENUM.eLingYinMiShi
local isLYMS,jobId=xianguanController:checkActorHasJobByType(self.actorId,jobType)
if isLYMS then
UIManager.error('对方是灵隐密使，无法放逐')
else
UIManager.error('对方在灵隐密使的保护范围内无法放逐')
end
return
end
local jobInfo=xianguanModel:getSelfGroupJobInfo(1)
local info=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"fangzhuZongmen")
local privilegeId=info[1]
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local privilegeObj=nil
if jobInfo then
local privilegeKey=xianguanConfig.getTeQuanFindKey(jobInfo.jobId,privilegeId)
privilegeObj=xianguanModel:getSelfTequanObj(privilegeKey)
if privilegeObj then

if not privilegeObj:checkUseCondition()then
return
end
else
UIManager.error(info[2])
return
end
end


local duration=privilegeCfg.effectArgs[1][2]

local zmData=xianjieModel:getZongMenData(self.actorId)

if zmData.bufflistlen>0 then
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(zmData.buffList)do
local buffCfg=cfg_fairylandbuffconfig_get(v.buffid)
for j,w in ipairs(buffCfg.effects)do
local effectType=w[1]
if effectType==xjBuffEffectType.eBanFangZhuZongMen then
if v.endsec<=0 then
UIManager.error("对方宗门被放逐冷却中，无法再次对其放逐")
return
elseif nowTime<v.endsec then
UIManager.error(FMT.fmt("对方宗门被放逐冷却中，{0}后才能再次对其放逐",timeHelper.format_time_stamp(v.endsec-nowTime)))
return
end
end
end
end
end


local func=function()
local otherZMActor=xianjieModel:getZongMenData(self.actorId)
if otherZMActor then
otherZMActor:setMoveFlag(true)
end

local json=jsonHelper.encode({6,tostring(self.actorId)})
privilegeObj:use({exInfoJsonStr=json})
end
local content=FMT.fmt("是否将<color=#ca631d>【{0}】</color>的宗门放逐到当前场景的随机地点？放逐后对方宗门在<color=#ca631d>{1}</color>内将无法使用宗门迁移令",zmData.actorname,timeHelper.formatSimpleTime(duration))
UIDialogManager.getCommonDialog(nil,content,func)
end

function UIXianJie_otherZmInfoWin:refreshFzCD()


local info=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"fangzhuZongmen")





local checkShow=false

if info then
self.fzTqId=info[1]
local jobInfo=xianguanModel:getSelfGroupJobInfo(1)
local leastTime=0
local privilegeKey=xianguanConfig.getTeQuanFindKey(jobInfo.jobId,info[1])

local privilegeObj=xianguanModel:getSelfTequanObj(privilegeKey)
if privilegeObj then
leastTime=privilegeObj:getCdLeft()
end
if xianguanHelper.checkSpecialUseCondition(jobInfo.jobId,info[1],false)and privilegeObj and xianguanHelper.checkTeQuanPlatformLimit(info[1])then
checkShow=true
end
self.fzBtn:setActive(checkShow)
if leastTime>0 then
self.fzTime=timeHelper.getServerShortTime()+leastTime
if self:updateFzTick()then
self.fzCDBg:setActive(true)
self:startFzTick()
return
end
end
else
self.fzBtn:setActive(checkShow)
end
if checkShow then

local hasLYMSBuff=xianjieModel:isCanNotTanChaAndFangZhu(self.actorId)
self.fzImage:setChildImageExGray(hasLYMSBuff)
self.fzBanFlag:setActive(hasLYMSBuff)
end

self.fzTime=nil
self.fzCD:setText("")
self.fzCDBg:setActive(false)
self:stopFzTick()
end

function UIXianJie_otherZmInfoWin:startFzTick()
if not self.fzTick then
self.fzTick=self:setTimer(1,0,function()
if not self:updateFzTick()then
self:refreshFzCD()
end
end)
end
end

function UIXianJie_otherZmInfoWin:stopFzTick()
if self.fzTick then
self:stopTimerByID(self.fzTick)
self.fzTick=nil
end
end

function UIXianJie_otherZmInfoWin:updateFzTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.fzTime-nowTime
local temp=leastTime>0
if temp then
self.fzCD:setText(timeHelper.format_time_stamp(leastTime))
end
return temp
end

function UIXianJie_otherZmInfoWin:onLYMSPanelClick()
local widget=self.lymsPanel:getWidgetBase()
local posVector2=widget:GetChildScreenPointToLocalPointRectangle(1)
local pos={posVector2.x,posVector2.y}
local offset={-210,85}
local privilegeId=XIANGUAN_PRIVILEGE_ENUM.eTianMuGeShi
local args={
privilegeId=privilegeId,
}
UIManager:showWindow("UIXianGuanPrivilegeTipsWin",{pos=pos,showData=args,offset=offset,arrowType=2,})
end

function UIXianJie_otherZmInfoWin:onSdBtn()
local zmData=xianjieModel:getZongMenData(self.actorId)
if zmData==nil then
UIManager.error('进入仙界后方可使用')
return
end
if not xianjieModel:checkMoJunTiaoZhanRange(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)then
UIManager.error('无法在魔君挑战区域内使用')
return
end
local xgid=tianshudazhenModel:getXgJobId()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17

if not xianguanModel:callTeQuanObjFunc(xgid,tqid,'checkUseCondition')then
return
end
local func=function()
tianshudazhenModel:useShenDunTeQuan(self.actorId)
end
local isOpenTianShuShenDun=xianjieModel:isOpenTianShuShenDun(self.actorId)
local isOpenFangHuZhao=xianjieModel:isOpenFangHuZhao(self.actorId)

if isOpenTianShuShenDun or isOpenFangHuZhao then
local desc=FMT.fmt('使用天枢神盾可无视煞气入侵，\n立即激活<color=#c0703b>12小时</color>天枢大阵，\n是否为<color=#c0703b>{0}</color>使用?？',zmData.actorname)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
return
end

local desc=FMT.fmt('使用天枢神盾可无视煞气入侵，\n立即激活<color=#c0703b>12小时</color>天枢大阵，\n是否为<color=#c0703b>{0}</color>使用?？',zmData.actorname)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
end

function UIXianJie_otherZmInfoWin:refreshSdCD()

local hasXgJob=tianshudazhenModel:hasXgsdTq()

local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
local enemyType=xianjieModel:checkEnemyType2(self.actorId,zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eAllies

local tqId=XIANGUAN_PRIVILEGE_ENUM.eTqType_17

local checkShow=false

if hasXgJob and isFriend then

local jobInfo=xianguanModel:getSelfGroupJobInfo(1)
local leastTime=0
local privilegeKey=xianguanConfig.getTeQuanFindKey(jobInfo.jobId,tqId)

local privilegeObj=xianguanModel:getSelfTequanObj(privilegeKey)
if privilegeObj then
leastTime=privilegeObj:getCdLeft()
end
if xianguanHelper.checkSpecialUseCondition(jobInfo.jobId,tqId,false)and privilegeObj and xianguanHelper.checkTeQuanPlatformLimit(tqId)then
checkShow=true
end
self.sdBtn:setActive(checkShow)
if leastTime>0 then
self.sdTime=timeHelper.getServerShortTime()+leastTime
if self:updateSdTick()then
self.sdCDBg:setActive(true)
self:startSdTick()
return
end
else
local maxcnt=xianguanModel:callTeQuanObjFunc(jobInfo.jobId,tqId,'getMaxTimes')
local cnt=xianguanModel:callTeQuanObjFunc(jobInfo.jobId,tqId,'getLeftTimes')
local tqCfg=cfg_xianguanprivilegeconfig_get(tqId)
local reset=tqCfg.reset
local useCntStr=''
if reset==1 or reset==2 then
useCntStr=cnt>0 and FMT.fmt('<color=#aae252>本日:{0}/{1}</color>',cnt,maxcnt)or
FMT.fmt('<color=#c82c2c>本日:{0}</color><color=#aae252>/{1}</color>',cnt,maxcnt)
elseif reset==3 or reset==4 then
useCntStr=cnt>0 and FMT.fmt('<color=#aae252>本周:{0}/{1}</color>',cnt,maxcnt)or
FMT.fmt('<color=#c82c2c>本周:{0}</color><color=#aae252>/{1}</color>',cnt,maxcnt)
elseif reset==0 then
useCntStr=cnt>0 and FMT.fmt('<color=#aae252>剩余:{0}</color>',cnt)or
'<color=#c82c2c>剩余:0</color>'
end
self.sdCDBg:setActive(useCntStr~='')
self.sdCD:setText(useCntStr)
end
else
self.sdBtn:setActive(checkShow)
end


self.sdTime=nil
self:stopSdTick()
end

function UIXianJie_otherZmInfoWin:startSdTick()
if not self.sdTick then
self.sdTick=self:setTimer(1,0,function()
if not self:updateSdTick()then
self:refreshSdCD()
end
end)
end
end

function UIXianJie_otherZmInfoWin:stopSdTick()
if self.sdTick then
self:stopTimerByID(self.sdTick)
self.sdTick=nil
end
end

function UIXianJie_otherZmInfoWin:updateSdTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.sdTime-nowTime
local temp=leastTime>0
if temp then
self.sdCD:setText(timeHelper.format_time_stamp(leastTime))
end
return temp
end


function UIXianJie_otherZmInfoWin:freshMoJiePnael(zmData)
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
if isMJtime then
self:freshMoJiBuffnum(zmData)
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMoJiBuffClick(widget,zmData)
end)
else
self.mjslpanel:setActive(false)
end
end

function UIXianJie_otherZmInfoWin:freshMoJiBuffnum(zmData)

local buffTemp={}
local buffNum=0

if zmData and zmData.bufflistlen>0 then
local buffList_lookup=zmData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)
if buffTemp and next(buffTemp)then
self.mjslpanel:setActive(true)
else
self.mjslpanel:setActive(false)
end
end

function UIXianJie_otherZmInfoWin:onMoJiBuffClick(_posWidget,zmData)

local buffTemp={}
local buffNum=0
if zmData and zmData.bufflistlen>0 then
local buffList_lookup=zmData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
local widget=_this.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)


if buffTemp and next(buffTemp)then
self:showWindow('UIMoJieShiLiBuffTips',{posWidget=_posWidget,posWidgetIndex=0,pos={x=-265,y=65},bufflsit=buffTemp})
else
UIManager.info('暂无获得的魔界势力状态')
end
end

function UIXianJie_otherZmInfoWin:freshMoJieShiLiItem(zmData)
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen and zmData then
local forceid=zmData.force
if forceid and forceid>0 then
self.slItem:setActive(true)
local cfg=cfg_devildomforceconfig_get(forceid)
self.slNameText:setText(cfg.name)
local abname='ui/windows/xiangong/xiangong_atlas_pak.ab'
local Icons={[1]='image_xiangongrenwu_bs2',[2]='image_xiangongrenwu_bs3',[3]='image_xiangongrenwu_bs1'}
self.winlua:SetChildCSImageSprite(self.mjtag:getID(),abname,Icons[forceid])
else
self.slItem:setActive(false)
end
end
end



function UIXianJie_otherZmInfoWin:freshMoJieSkillPnael(zmData)
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
if zmData==nil then
zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
end
if zmData==nil then return end
local enemyType=xianjieModel:checkEnemyType2(self.actorId,zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eAllies

local forceid=xianjieController:getForce()
if not isFriend and forceid>0 and xianjieController:getShiLiDebuffCheck(forceid)then
local Skillidx,Taskidx=xianjieController:getForceCfg()
if Skillidx==nil then
self.mjslskill:setActive(false)
logErr(FMT.fmt('获取势力配置为nil,查看魔界赛季配置表的force字段'))
return
end
self.mjslskill:setActive(true)
self.skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
local skillcfg=self.skillcfg

local widget=self.mjslskill:getWidgetBase()
widget:SetChildText(slskillidx.name,skillcfg.name)
local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
widget:SetChildCSImageIcon(slskillidx.icon,iconName,false)
widget:SetChildButtonClick(slskillidx.skillbtn,function()
if _this==nil then return end
_this:onUseMoJiSkillbtn(zmData)
end)
self:CheckUseMoJiSkillTime()
else
self.mjslskill:setActive(false)
end
else
self.mjslskill:setActive(false)
end
end

function UIXianJie_otherZmInfoWin:onUseMoJiSkillbtn(zmData)
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
local flag,g_list,errorParams=zmData:checkMovePathCondition(true,true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
local isBornAreaPath=errorParams.isBornAreaPath
if isSelfInNeutralArea then

errStr="处于阵外无法对本阵内的祖师使用"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法对阵外的祖师使用"
else
if isBornAreaPath then

errStr="处于本阵内无法对祖师使用"
else

errStr="处于本阵内无法对其他本阵内的祖师使用"
end
end
UIManager.error(errStr)
end
return
end

local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then
UIManager.info('技能冷却中')
return
end
local actorid=self.actorId


local _fun=function()
xianjieController:useMoJieShiLiSkill(actorid)
end
local UseSkilldesc=self.skillcfg.UseSkilldesc
local skillname=self.skillcfg.name
local parem1=UseSkilldesc[1]
local parem2=UseSkilldesc[2][lvl]
local strdesc=''
xpcall(function()
strdesc=FMT.fmt(parem1,unpack(parem2))
end,function(err)
logErr(FMT.fmt('魔界势力技能参数报错，配置字段UseSkilldesc,技能名字：{0},技能等级：{1}',skillname,lvl))
end)
local str=FMT.fmt("是否使用<color=#ca631d>【{0}】</color>技能\n\n{1}",skillname,strdesc)
xianjieController:showUseSkillWin(_fun,str)
else
UIManager.info('势力技能只能在魔界使用')
end
end

function UIXianJie_otherZmInfoWin:serverMoJiSkill()
if _this==nil then return end
_this:CheckUseMoJiSkillTime()
end

function UIXianJie_otherZmInfoWin:CheckUseMoJiSkillTime()
local widget=self.mjslskill:getWidgetBase()
local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then

widget:SetChildActive(slskillidx.djsbg,true)
widget:SetChildGray(slskillidx.icon,true)
self:stopSelfTimerMJSL()
local timeStr=timeHelper.format_time_stamp(endTime-curTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=timeHelper.format_time_stamp(showTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
if dtTime<=0 then
self:stopSelfTimerMJSL()
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
self.timermjsl=self:setTimer(1,0,func)
else
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
function UIXianJie_otherZmInfoWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end

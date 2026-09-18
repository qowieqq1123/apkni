







def_class("UIXianJie_XMInfoWin",UIWindowBase)









function UIXianJie_XMInfoWin:bindComponents()

self.bjBtn=UIButton.get(self,0)
self.costTimeTxt=UIText.get(self,1)
self.czBtn=UIButton.get(self,2)
self.guildBG=UIButton.get(self,3)
self.guildIcon=UIImage.get(self,4)
self.guildKuangIcon=UIImage.get(self,5)
self.helpBtn=UIButton.get(self,6)
self.mask=UIButton.get(self,7)
self.nameTx=UIText.get(self,8)
self.posTxt=UIText.get(self,9)
self.progressBar=UIProgress.get(self,10)
self.recordBtn=UIButton.get(self,11)
self.root=UIObject.get(self,12)
self.ruleBtn=UIButton.get(self,13)
self.serverTx=UIText.get(self,14)
self.shareBtn=UIButton.get(self,15)
self.zcBtn=UIButton.get(self,16)
self.zfBtn=UIButton.get(self,17)
self.zfzBtn=UIButton.get(self,18)

self.bjBtn:setButtonClick(function()self:onBjBtn()end)

self.czBtn:setButtonClick(function()self:onCzBtn()end)

self.guildBG:setButtonClick(function()self:onGuildBG()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.zcBtn:setButtonClick(function()self:onZcBtn()end)

self.zfBtn:setButtonClick(function()self:onZfBtn()end)

self.zfzBtn:setButtonClick(function()self:onZfzBtn()end)



end


function UIXianJie_XMInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bjBtn);self.bjBtn=nil;
_UIObject_release(self.costTimeTxt);self.costTimeTxt=nil;
_UIObject_release(self.czBtn);self.czBtn=nil;
_UIObject_release(self.guildBG);self.guildBG=nil;
_UIObject_release(self.guildIcon);self.guildIcon=nil;
_UIObject_release(self.guildKuangIcon);self.guildKuangIcon=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.serverTx);self.serverTx=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.zcBtn);self.zcBtn=nil;
_UIObject_release(self.zfBtn);self.zfBtn=nil;
_UIObject_release(self.zfzBtn);self.zfzBtn=nil;
end















local _this=nil



function UIXianJie_XMInfoWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianJieXMChange,self.onXianJieXMChange)
self:addNotify(notifyConfig.onXianJieDefendXianMengStationChange,self.onXianJieDefendXianMengStationChange)
end


function UIXianJie_XMInfoWin:__delete()
self:unbindComponents()
_this=nil

self:stopProgressTick()
if self.guildData then
self.guildData:selectEntity(false)
end
end




function UIXianJie_XMInfoWin:onShow(argtable,afterOnloaded)
self.guildData=xianjieModel:getXianMengData(argtable.guild)
if self.guildData==nil then
self:onMask()
return
end

if afterOnloaded then
if self.guildData then
self.guildData:selectEntity(true)
end
end
local nameStr=self.guildData.guildname



self.nameTx:setText(nameStr)
local serverStr=loginModel:getServerName(self.guildData.serverid)
self.serverTx:setText(serverStr)
local image=xianmengModel.splitGuildIcon(self.guildData.guildicon)
self.guildIcon:setSprite(globalABLookup.xianmengicons,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
self.guildBG:setSprite(globalABLookup.xianmengicons,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
self.guildKuangIcon:setSprite(globalABLookup.xianmengicons,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local _posx,_posy=self.guildData:getCenterGridPosFloor()
self.posTxt:setText(FMT.fmt('（X:{0},Y:{1}）',_posx,_posy))
local wayTime=self.guildData:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=wayTime>0 and timeHelper.format_time_stamp3(math.ceil(wayTime))or"——"
self.costTimeTxt:setText(time_str)


self.enemyType=xianjieModel:checkEnemyType3(self.guildData.guildid,self.guildData.ownersceneidx)
local hadZF=xianjieModel:haveSelfDefendXianMengTeamData(self.guildData.guildid)
self.bjBtn:setActive(systemModel.isOpen(SYSTEM_DEFINE.eXianJieBiaoJi)and xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptFLFlag))
self.zfBtn:setActive(self.enemyType==xjEnemyType.eSelf and not hadZF)
self.zfzBtn:setActive(self.enemyType==xjEnemyType.eSelf and hadZF)
self.czBtn:setActive(self.enemyType==xjEnemyType.eAllies or self.enemyType==xjEnemyType.eStranger)
self.zcBtn:setActive(self.enemyType==xjEnemyType.eAllies or self.enemyType==xjEnemyType.eStranger)

self:refreshProgress()
end


function UIXianJie_XMInfoWin:onHide()

end




function UIXianJie_XMInfoWin:onBjBtn()
local _posx,posy=self.guildData:getCenterGridPosFloor()
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(2)
xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end


function UIXianJie_XMInfoWin:onCzBtn()
if self.enemyType==xjEnemyType.eAllies or self.enemyType==xjEnemyType.eStranger then
local value=self.guildData.shield
if value<=0 then
local config=cfgHelper.get1(cfg_devildomdazhenconfig_get,self.guildData.lv)
local since=self.guildData.sec
local nowTime=timeHelper.getServerShortTime()
if(since+config.fix)>nowTime then
UIManager.error("仙盟已被攻破")
return
end
end

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

local flag,g_list=self.guildData:checkMovePathCondition()
if not flag then
UIManager.error("无法派遣到达目的地")
return
end

local wayTime=self.guildData:getBaseWayTime()
local orderType=xjOrderType.eAttackXianMeng
local guid=self.guildData.guildid
local func=function(selectDzList,selectMoneyList,boatId)
xianjieController:reqOrder(guid,orderType,selectDzList,selectMoneyList,'',boatId,nil,g_list)
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,wayTime=wayTime,orderType=orderType})
end
end


function UIXianJie_XMInfoWin:onGuildBG()
xianmengController:openXMDetailInfoWin(self.guildData.guildid)
end


function UIXianJie_XMInfoWin:onHelpBtn()






local screenPos=self.helpBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local args={
parentWin=self,
lang='xianjiexianmeng_help_%d',
screenPos=screenPos,
}
UIManager:showWindow("UIXianJie_monsterRuleWin",args)
end


function UIXianJie_XMInfoWin:onMask()
xianjieController:closeWin(self.__name)
end


function UIXianJie_XMInfoWin:onRecordBtn()
local _posx,_posy=self.guildData:getCenterGridPosFloor()
local nameStr=FMT.fmt("{0}堡垒",self.guildData.guildname)
local temp=
{
gridX=_posx,
gridZ=_posy,
Point_Share=xianjie_Point_Share.mowu,
nameStr=nameStr,
sharename=nameStr,
ishujian=true,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end


function UIXianJie_XMInfoWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eXianMeng
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


function UIXianJie_XMInfoWin:onShareBtn()
local nameStr=self.guildData.guildname
local _sceneType=xianjieModel:getScenceType()
local _posx,_posy=self.guildData:getCenterGridPosFloor()
local data=
{
x=_posx,
y=_posy,
icon1="icon_sjgdbiaoshi_1",
msgName=nameStr,
shareType=xianjie_Point_Share.xianmeng,
scenceType=_sceneType,
name=nameStr,
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


function UIXianJie_XMInfoWin:onZcBtn()
if self.enemyType==xjEnemyType.eAllies or self.enemyType==xjEnemyType.eStranger then
UIManager:showWindow('UIXianJie_XMSpyOnWin',{guild=self.guildData.guildid})
end
end


function UIXianJie_XMInfoWin:onZfzBtn()
self:onZfBtn()
end


function UIXianJie_XMInfoWin:onZfBtn()
if self.enemyType==xjEnemyType.eSelf then

local garrison=xianjieModel:getXianMengGarrison(self.guildData.guildid)
if not garrison or garrison.serverTime>garrison.clientTime then
xianjieController:send_35_156(self.guildData.guildid)
end
local args={
guild=self.guildData.guildid,
parentWin=self,
}
self:showWindow("UIXianJie_XMBLDefendInfoWin",args)


























end
end

function UIXianJie_XMInfoWin:refreshProgress()
local value=self.guildData.shield
local since=self.guildData.sec
local nowTime=timeHelper.getServerShortTime()
local config=cfgHelper.get1(cfg_devildomdazhenconfig_get,self.guildData.lv)
local maxVal=config.shield
local maxStr=mathHelper.formatNumber(maxVal)
if value>0 then
local interval=config.recover[1]
local delta=config.recover[2]
local curVal=value+math.floor((nowTime-since)/interval)*delta
if curVal>=maxVal then
self.progressBar:setProgressValue(10000,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{0}",maxStr))
self:stopProgressTick()
else
local curStr=mathHelper.formatNumber(curVal)
local progressVal=math.floor(curVal/maxVal*10000)
self.progressBar:setProgressValue(progressVal,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",curStr,maxStr))
self:startProgressTick2(curVal,maxVal,since,interval,delta)
end
else
local finishTime=since+config.fix
if nowTime>=finishTime then
self.progressBar:setProgressValue(10000,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{0}",maxStr))
self:stopProgressTick()
else
self.progressBar:setProgressValue(0,10000)
self.progressBar:setChildProgressText(FMT.fmt("0/{0}",maxStr))
self:startProgressTick1(finishTime,maxVal)
end
end
end

function UIXianJie_XMInfoWin:startProgressTick2(value,since,state,maxVal,speed)
self.progressData={
value=value,
since=since,
state=state,
maxVal=maxVal,
speed=speed,
}
if self.progressTick==nil then
self.progressTick=self:setTimer(1,0,function()
self:updateProgressTick2()
end)
end
end

function UIXianJie_XMInfoWin:startProgressTick1(time,maxVal)
self.progressData={time,maxVal}
if self.progressTick==nil then
self.progressTick=self:setTimer(1,0,function()
self:updateProgressTick1()
end)
end
end

function UIXianJie_XMInfoWin:stopProgressTick()
self.progressData=nil
if self.progressTick then
self:stopTimerByID(self.progressTick)
self.progressTick=nil
end
end

function UIXianJie_XMInfoWin:updateProgressTick1()
local nowTime=timeHelper.getServerShortTime()
local finishTime=self.progressData[1]
if nowTime>=finishTime then
local maxStr=self.progressData[2]
self.progressBar:setProgress(10000,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{0}",maxStr))
self:stopProgressTick()
end
end

function UIXianJie_XMInfoWin:updateProgressTick2()
local nowTime=timeHelper.getServerShortTime()
local sinceTime=self.progressData[3]
local interval=self.progressData[4]
if(sinceTime-nowTime)%interval==0 then
local sinceVal=self.progressData[1]
local targetVal=self.progressData[2]
local targetStr=mathHelper.formatNumber(maxVal)
local deltaVal=self.progressData[5]
local curVal=sinceVal+(nowTime-sinceTime)/interval*deltaVal
if curVal<targetVal then
local curStr=mathHelper.formatNumber(curVal)
local progressValue=math.floor(curVal/maxVal*10000)
self.progressBar:setProgress(progressValue,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",curStr,targetStr))
else
self.progressBar:setProgress(10000,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{0}",targetStr))
self:stopProgressTick()
end
end
end

function UIXianJie_XMInfoWin.onXianJieXMChange(changeType,guildId)
if mathHelper.compareInt64(_this.guildData.guildid,guildId)then
if changeType==CHANGE_TYPE.eChanged then
_this:onShow({guild=guildId})
elseif changeType==CHANGE_TYPE.eDelete then
_this:onMask()
end
end
end

function UIXianJie_XMInfoWin.onXianJieDefendXianMengStationChange(changeType,guid)
if xianmengModel:isMyXM2(_this.guildData.guildid)and mathHelper.compareInt64(guid,_this.guildData.guildid)then
local hadZF=xianjieModel:haveSelfDefendXianMengTeamData(_this.guildData.guildid)
_this.zfBtn:setActive(not hadZF)
_this.zfzBtn:setActive(hadZF)
end
end

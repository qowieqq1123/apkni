







def_class("UIXianJie_puTongZhenJiInfoWin",UIWindowBase)









function UIXianJie_puTongZhenJiInfoWin:bindComponents()

self.commitBtn=UIButton.get(self,0)
self.commitBtnTxt=UIText.get(self,1)
self.costBg=UIObject.get(self,2)
self.costIcon=UIImage.get(self,3)
self.costNum=UIText.get(self,4)
self.costTimeItem=UIObject.get(self,5)
self.exBtns=UIObject.get(self,6)
self.findXg=UIObject.get(self,7)
self.lockBtn=UIButton.get(self,8)
self.lockPanel=UIObject.get(self,9)
self.lockTxt=UIText.get(self,10)
self.mask=UIButton.get(self,11)
self.mjslpanel=UIObject.get(self,12)
self.mjslskill=UIObject.get(self,13)
self.mojingCount=UIObject.get(self,14)
self.monsterInfo=UIObject.get(self,15)
self.monsterRewardDetailbtn=UIButton.get(self,16)
self.posTxt=UIText.get(self,17)
self.progressbar=UIObject.get(self,18)
self.progressValue=UIObject.get(self,19)
self.progressValueTxt=UIText.get(self,20)
self.proroot=UIObject.get(self,21)
self.proTipbtn=UIButton.get(self,22)
self.proTitle=UIText.get(self,23)
self.recommendedItem=UIObject.get(self,24)
self.recommendjzItem=UIObject.get(self,25)
self.recordBtn=UIButton.get(self,26)
self.rewardPanel=UIObject.get(self,27)
self.rewardPanelBg1=UIObject.get(self,28)
self.rewardPanelBg2=UIObject.get(self,29)
self.rewardTips=UIText.get(self,30)
self.rewardView=UIObject.get(self,31)
self.root=UIObject.get(self,32)
self.ruleBtn=UIButton.get(self,33)
self.shareBtn=UIButton.get(self,34)
self.shdBtn=UIButton.get(self,35)
self.shdTx=UIText.get(self,36)
self.showRewardBtn=UIButton.get(self,37)
self.stateLayout=UIObject.get(self,38)
self.stateTimeTxt=UIText.get(self,39)
self.stateTxt=UIText.get(self,40)
self.teamItem=UIObject.get(self,41)
self.texingBtn=UIButton.get(self,42)
self.timeRemaining=UIObject.get(self,43)
self.troopsItem=UIObject.get(self,44)
self.unlockPanel=UIObject.get(self,45)
self.xjbjbtn=UIButton.get(self,46)
self.zhenjiWuXing=UIObject.get(self,47)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.lockBtn:setButtonClick(function()self:onLockBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.monsterRewardDetailbtn:setButtonClick(function()self:onMonsterRewardDetailbtn()end)

self.proTipbtn:setButtonClick(function()self:onProTipbtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.shdBtn:setButtonClick(function()self:onShdBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)

self.texingBtn:setButtonClick(function()self:onTexingBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)



end


function UIXianJie_puTongZhenJiInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.exBtns);self.exBtns=nil;
_UIObject_release(self.findXg);self.findXg=nil;
_UIObject_release(self.lockBtn);self.lockBtn=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
_UIObject_release(self.mojingCount);self.mojingCount=nil;
_UIObject_release(self.monsterInfo);self.monsterInfo=nil;
_UIObject_release(self.monsterRewardDetailbtn);self.monsterRewardDetailbtn=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.progressValueTxt);self.progressValueTxt=nil;
_UIObject_release(self.proroot);self.proroot=nil;
_UIObject_release(self.proTipbtn);self.proTipbtn=nil;
_UIObject_release(self.proTitle);self.proTitle=nil;
_UIObject_release(self.recommendedItem);self.recommendedItem=nil;
_UIObject_release(self.recommendjzItem);self.recommendjzItem=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardPanelBg1);self.rewardPanelBg1=nil;
_UIObject_release(self.rewardPanelBg2);self.rewardPanelBg2=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.shdBtn);self.shdBtn=nil;
_UIObject_release(self.shdTx);self.shdTx=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
_UIObject_release(self.texingBtn);self.texingBtn=nil;
_UIObject_release(self.timeRemaining);self.timeRemaining=nil;
_UIObject_release(self.troopsItem);self.troopsItem=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.zhenjiWuXing);self.zhenjiWuXing=nil;
end
















local slskillidx=
{
skillbtn=0,
icon=1,
name=2,
djsbg=3,
djs=4
}
local _this




function UIXianJie_puTongZhenJiInfoWin:onLoaded(...)
self:bindComponents()
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)
self:addNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addProNotify(35,63,self.on_35_63)
self:addProNotify(35,198,self.on_35_198)
self:addProNotify(35,10,self.on_35_10)
local widget=self.teamItem:getWidgetBase()
widget:SetChildButtonClick(1,function()
self:onClickTeamBtn()
end)
end


function UIXianJie_puTongZhenJiInfoWin:__delete()
_this=nil
self:unbindComponents()
xianjieController:closeWin2('UIXianJie_puTongZhenJiInfoWin')
self:stopSelfTimerMJSL()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
if monsterData then
monsterData:selectEntity(false)
end
end



function UIXianJie_puTongZhenJiInfoWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then
return
end
xianjieController:closeWin3()
end

function UIXianJie_puTongZhenJiInfoWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then
return
end
xianjieController:closeWin3()
end

function UIXianJie_puTongZhenJiInfoWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then
return
end
_this:onCloseClick()
end

function UIXianJie_puTongZhenJiInfoWin.onXianJieMonsterChange(typo,infoguid)
if _this==nil or not _this.isVisible then
return
end
if typo==CHANGE_TYPE.eDelete then
if tostring(_this.infoguid)==tostring(infoguid)then
xianjieController:closeWin3()
end
end
end

function UIXianJie_puTongZhenJiInfoWin.onNewDay5am()
if _this==nil or not _this.isVisible then
return
end
_this:refreshRewardTimes()
end

function UIXianJie_puTongZhenJiInfoWin.on_35_63(infoguid)
if _this.infoguid==infoguid then
_this:refreshTeamInfo()
end
end
function UIXianJie_puTongZhenJiInfoWin.on_35_198(infoguid)
if _this.infoguid==infoguid then
_this:refreshTeamInfo()
end
end

function UIXianJie_puTongZhenJiInfoWin.on_35_10()
if _this==nil or not _this.isVisible then
return
end
_this:refreshRewardTimes()
end





function UIXianJie_puTongZhenJiInfoWin:onShow(argtable,afterOnloaded)
self.infoguid=argtable.infoguid

if self.mytimer==nil then
_this:updateTime()
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)

if monsterData==nil then
self:closeSelf()
return
else
self:refreshInfo(monsterData)

local _sceneidx=monsterData.sceneidx
if not xianjieModel:checkMonsterTeamInfoCacheValid(self.infoguid)then
if xianjienSceneIndexType:isMoJie(_sceneidx)then
xianjieController:reqMoJieMonsterTeamInfo(self.infoguid)
else
xianjieController:reqMonsterTeamInfo(self.infoguid)
end
end
end
if afterOnloaded then
if monsterData then
monsterData:selectEntity(true)
end
end


if systemModel.isOpen(SYSTEM_DEFINE.eXianJieBiaoJi)then
self.xjbjbtn:setActive(false)
local actorid=playerModel:getActorID()
local pos=xianmengModel:getXMMemberPost(actorid)
if pos then
if pos==GUILD_POST_TYPE.gpAllyLeader or pos==GUILD_POST_TYPE.gpViceLeader then
self.xjbjbtn:setActive(true)
end
end
else
self.xjbjbtn:setActive(false)
end

self:refreshShdBtn()
end


function UIXianJie_puTongZhenJiInfoWin:onHide()

end

function UIXianJie_puTongZhenJiInfoWin:onShowArgRecv(argtable)
local oldGuid=self.infoguid
if oldGuid and oldGuid~=argtable.infoguid then
local monsterData=xianjieModel:getPuTongZhenJiData(oldGuid)
if monsterData then
monsterData:selectEntity(false)
end
monsterData=xianjieModel:getPuTongZhenJiData(argtable.infoguid)
if monsterData then
monsterData:selectEntity(true)
end
end
self:refreshView(argtable.infoguid)
end

function UIXianJie_puTongZhenJiInfoWin:updateTime()
if self.isActiveTimer then
self:refreshStateDesc()
end
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
if not monsterData then
return
elseif monsterData.expiresec~=0 then
self:refreshTimeRemaining()
end
end

function UIXianJie_puTongZhenJiInfoWin:refreshView(infoguid)
if mathHelper.compareInt64(self.infoguid,infoguid)then
return
end
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
if monsterData==nil then
self:closeSelf()
return
end

self.infoguid=infoguid
self:refreshInfo()
self:refreshShdBtn()
end

function UIXianJie_puTongZhenJiInfoWin:onLoadFinish()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end

function UIXianJie_puTongZhenJiInfoWin:refreshInfo(monsterData)
if monsterData==nil then
monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
end
if monsterData==nil then
return
end
local cfg=monsterData:getCfg()
self.sharecfg=cfg


local gridX_c,gridZ_c=monsterData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c
self.mstentitytype=monsterData.entitytype
local isZhenJi=monsterData.entitytype==xjServerEnityType.eMoJingZhenJi_Normal


local monsterInfoWidget=self.monsterInfo:getWidgetBase()
monsterInfoWidget:SetChildText(1,cfg.name)
monsterInfoWidget:SetChildActive(19,isZhenJi)
if isZhenJi then
monsterInfoWidget:SetChildCSImageSprite(19,globalABLookup.global,FMT.fmt("icon_yuansu_{0}",cfg.wxType or 1))
end
monsterInfoWidget:SetChildActive(20,false)



local monsterSceneIdx=monsterData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(monsterSceneIdx)then

self.costTimeItem:setActive(false)
else
self.costTimeItem:setActive(true)
local costTimeWidget=self.costTimeItem:getWidgetBase()
local wayTime=monsterData:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
costTimeWidget:SetChildText(0,time_str)
end

self.rewardPanelBg1:setActive(monsterData.entitytype~=xjServerEnityType.eMonsterHouse)
self.rewardPanelBg2:setActive(monsterData.entitytype==xjServerEnityType.eMonsterHouse)


self:refreshTeamInfo()




self:refreshWuXingZhenJi(monsterData)

local recommendedWidget=self.recommendedItem:getChildWidgetBase()
local recommendedStr=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"recommend",monsterData.entitytype,cfg.stage)
if recommendedStr==nil then
logErr("仙界配置- 基础配置 recommend 缺少配置",monsterData.entitytype,cfg.stage)
end
recommendedStr=mathHelper.formatNumber(recommendedStr)
recommendedWidget:SetChildText(0,recommendedStr)

local recommendjzStr
local recommendjz=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"recommendJZ")
if recommendjz then
local ent_recommendjz=recommendjz[monsterData.entitytype]or{}
recommendjzStr=ent_recommendjz[cfg.stage]
end
self.recommendjzItem:setActive(recommendjzStr~=nil)
if recommendjzStr then
local recommendjzWidget=self.recommendjzItem:getChildWidgetBase()
recommendjzWidget:SetChildText(0,recommendjzStr)
end

self.troopsItem:setActive(false)
























local haveCost=cfg.consume~=nil and#cfg.consume>0
self.costBg:setActive(haveCost)
if haveCost then
local itemId=cfg.consume[1][1]
local itemNum=cfg.consume[1][2]
local haveNum=itemsModel.getCount(itemId)
local numColor=haveNum>=itemNum and"549327"or"c82c2c"
self.costIcon:setImageIcon(iconHelper.getIconName(itemId),false)
self.costNum:setText(FMT.fmt("消耗：<color=#{1}>{0}</color>",mathHelper.formatNumber(itemNum),numColor))

self.winlua:ForceLayoutRect(self.costBg:getID())
end


local dropCfg=cfgHelper.get1(cfg_awardconfig_get,cfg.drop)
local rewards=dropCfg.showItems or{}

if cfg.ex_drop then
local csid=xianjieModel:getMoJieEnterConfig('csid')
local ex_drop=cfg.ex_drop[csid]
local ex_dropCfg=cfgHelper.get1(cfg_awardconfig_get,ex_drop[2])
local ex_dropItems=ex_dropCfg.showItems or{}
local ispass=false
local csid=xianjieController:getMoJieSaiJiWanFaID()
if ex_drop[1]==0 then
ispass=true
elseif csid and seasonController:checkSeasonStageBegined(csid,ex_drop[1])then
ispass=true
end
if ispass then
local rewards2=table.weakCopy(ex_dropItems)
local old_rewards=dropCfg.showItems or{}
for k,v in ipairs(old_rewards)do
table.insert(rewards2,v)
end
rewards=rewards2
end
end
local rnum=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemData=rewards[i]
local itemid=itemData[1]
local itemnum=itemData[2]
local percent=itemData[4]
local isxmkf=itemData.isxmkf or false
local itemcount,showCountBG
local isShowPercent=percent~=nil
local range
if percent then
showCountBG=false
itemcount=""
else
range=itemData.range
if itemnum>1 or itemData.range~=nil then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
end

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,range=range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then
return
end
_this:onClickItem(...)
end)

local showSign=itemnum<=0 and itemData.range==nil and percent==nil
rwItem:SetChildActive(1,showSign)
rwItem:SetChildActive(2,isShowPercent)
if isShowPercent then
rwItem:SetChildText(3,FMT.fmt("{0}%",percent))
end
rwItem:SetChildActive(4,isxmkf)

end
self.rewardView:setChildScrollRectEnable(rnum>=5)

local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
local unlock=check and seasonController:checkSeasonStageBegined(check[1],check[2])or true
if check then
local seasonName=seasonModel:getHandleConfig(check[1],'name')
local chapter_idx=mathHelper.numberToChinese(check[2])
local chapterName=seasonModel:getStageConfigEx(check[1],check[2],"name")
local lockStr=FMT.fmt("【{0}-第{1}章·{2}】解锁征讨",seasonName,chapter_idx,chapterName)
self.lockTxt:setText(lockStr)
else
self.lockTxt:setText("")
end




local marchguid
self.isActiveTimer=nil
local wpData=xianjieModel:getWaiPaiByQBEntityData2(xjWaiPiaBaseType.eMarckTeam,self.infoguid)
if wpData then
marchguid=wpData.guid
self.isActiveTimer=true
else
local teamData=xianjieModel:getSelfJiJieTeamDataByInfoguid(self.infoguid)
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
local state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
self.isActiveTimer=true
end
end
end
self.marchguid=marchguid
self:refreshStateDesc()


local btnStr="征讨"

self.commitBtnTxt:setText(btnStr)

self:refreshRewardTimes(monsterData)
self.monsterRewardDetailbtn:setActive(false)

if monsterData.actorid and tostring(monsterData.actorid)~='0'then
local zmdata=xianjieModel:getZongMenData(monsterData.actorid)
local actorname=zmdata.actorname
local serverid=zmdata.serverid
self.findXg:setActive(true)
local findXgWidget=self.findXg:getChildWidgetBase()
findXgWidget:SetChildText(0,actorname)
findXgWidget:SetChildButtonClick(1,function()
local attach={}
if serverid~=playerModel:getActorServerID()then
attach={serverid=serverid}
end
otherPlayerController:openOtherPlayerInfoWin(monsterData.actorid,nil,nil,attach)
end)
else
self.findXg:setActive(false)
end

self.timeRemaining:setActive(monsterData.expiresec~=0)

self:freshMoJiePnael(monsterData)
self:freshMoJieSkillPnael(monsterData)

self.unlockPanel:setActive(unlock)
self.lockPanel:setActive(not unlock)
end

function UIXianJie_puTongZhenJiInfoWin:refreshWuXingZhenJi(monsterData,infoguid_str)
if infoguid_str~=nil and infoguid_str~=tostring(self.infoguid)then
return
end
if monsterData==nil then
monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
end

if monsterData==nil then
self:closeSelf()
return
end
local cfg=monsterData:getCfg()
local isZhenJi=monsterData.entitytype==xjServerEnityType.eMoJingZhenJi_Normal
self.mojingCount:setActive(isZhenJi)
self.zhenjiWuXing:setActive(isZhenJi)
if isZhenJi then
local mojingCountWidget=self.mojingCount:getChildWidgetBase()
local useMoJing=tonumber(tostring(monsterData.useMoJing))
local maxMoJing=cfg.mojing[2]or 0
mojingCountWidget:SetChildText(0,FMT.fmt("{0}/{1}",maxMoJing-useMoJing,maxMoJing))
mojingCountWidget:SetChildButtonClick(1,function()
local screenPos=mojingCountWidget:GetChildUIScreenPos(1,false)
screenPos.y=screenPos.y+12
local winParams={
parentWin=self,
lang="ui_putongzhenji_mojing_rule_%d",
num=1,
screenPos=screenPos,
}
self:showWindow("UIXianJie_puTongZhenJi_mojingRuleWin",winParams)
end)

local zhenjiWuXingWidget=self.zhenjiWuXing:getChildWidgetBase()
zhenjiWuXingWidget:SetChildCSImageSprite(0,globalABLookup.global,FMT.fmt("icon_yuansu_{0}",cfg.wxType or 1))
zhenjiWuXingWidget:SetChildText(1,cfg.wxDesc)
end
end

function UIXianJie_puTongZhenJiInfoWin:refreshRewardTimes(monsterData)
if monsterData==nil then
monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
end

if monsterData==nil then
return
end
local rewardTipsStr="征讨奖励"
local entityType=monsterData.entitytype

local cfg=monsterData:getCfg()
if cfg.flag and cfg.flag==2 then
entityType=bit.lshift(cfg.flag,8)+entityType
end
local rewardTimeConf=xianjieModel:getMonsterInfoCfg(entityType)
if rewardTimeConf then
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype,cfg.flag)
local least=maxTimes-curTimes
self.sgleast=least
local color=least>0 and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
rewardTipsStr=FMT.fmt("{0}(剩余<color={2}>{1}</color>/{3}次)",rewardTipsStr,least,FONT_COLOR_VAL[color],rewardTimeConf[1]+rewardTimeConf[2])
end


self.rewardTips:setText(rewardTipsStr)
end

function UIXianJie_puTongZhenJiInfoWin:refreshLife(widget,monsterData)
if widget==nil then
widget=self.monsterInfo:getWidgetBase()
end
if monsterData==nil then
monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
end
local hp=monsterData.hp
widget:SetChildIconFillAmount(10,hp/10000)
local rate_str=FMT.fmt('{0}%',hp/100)
widget:SetChildText(11,rate_str)
end

function UIXianJie_puTongZhenJiInfoWin:refreshTeamInfo()
local widget=self.teamItem:getWidgetBase()
local teamInfos=xianjieModel:readMonsterTeamInfo(self.infoguid)
local teamCnt=teamInfos and#teamInfos.data or 0
local haveTeam=teamCnt>0
local str=haveTeam and FMT.fmt("前往中（<color=#ca631d>{0}</color>）",teamCnt)or"无"
widget:SetChildActive(1,haveTeam)
widget:SetChildText(0,str)
end

function UIXianJie_puTongZhenJiInfoWin:refreshStateDesc()
local teamHandle
local state,timeData,lerp
local desc
if self.marchguid then
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
if teamData then
local teamHandle_=teamData:getTeamHandle()
state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjMarchTeamStateType.eNone then
teamHandle=teamHandle_
desc=xjMarchTeamStateType:getDesc(state)or''
end
end
if teamHandle==nil then
self.marchguid=nil
end
else
local teamData=xianjieModel:getSelfJiJieTeamDataByInfoguid(self.infoguid)
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
teamHandle=teamHandle_
desc=xjJiJieTeamStateType:getDesc(state)or''
end
end
end

local hasWaiPai=teamHandle~=nil

local showBtn=not hasWaiPai
self.commitBtn:setActive(showBtn)

self.stateLayout:setActive(hasWaiPai)
if hasWaiPai then
self.stateTxt:setText(desc)
local time_str
if lerp>0 then
time_str=timeHelper.format_time_stamp3(lerp)
else
time_str='--'
end
self.stateTimeTxt:setText(time_str)
else
self.isActiveTimer=nil
end
end

function UIXianJie_puTongZhenJiInfoWin:refreshTimeRemaining()
if not _this then
return
end
local monsterData=xianjieModel:getPuTongZhenJiData(_this.infoguid)
local timeRemainingWidget=_this.timeRemaining:getChildWidgetBase()
_this.timeRemaining:setActive(monsterData.expiresec~=0)

local nowtime=timeHelper.getServerShortTime()
local lerp=monsterData.expiresec-nowtime
local time_str

if lerp>0 then
time_str=timeHelper.format_time_stamp3(lerp)
else
time_str='--'
end
timeRemainingWidget:SetChildText(0,time_str)
end

function UIXianJie_puTongZhenJiInfoWin:onLockBtn()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
if check[1]==0 then
jumpManager:jump({id=JUMP_TYPE.eChongJianXianYu,args={chapter_idx=check[2]}})
end
end

function UIXianJie_puTongZhenJiInfoWin:onClickTeamBtn()
local args={
parentWin=self,
infoguid=self.infoguid
}
self:showWindow("UIXianJie_monsterTeamWin",args)
end

function UIXianJie_puTongZhenJiInfoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXianJie_puTongZhenJiInfoWin:onCloseClick(atOnce)
xianjieController:closeWin('UIXianJie_puTongZhenJiInfoWin',atOnce)
end

function UIXianJie_puTongZhenJiInfoWin:onCommitBtn()

local flag=xianjieModel:checkTriggerSeasonStageBehaivour()
if flag then
_this:onCloseClick()
return
end
local infoguid=self.infoguid
local monsterData=xianjieModel:getPuTongZhenJiData(infoguid)
local check=xianjieModel:getMonsterSeasonCheck(monsterData.entitytype)
if check and not seasonController:checkSeasonStageBegined(check[1],check[2])then
local seasonName=seasonModel:getHandleConfig(check[1],"name")
local stageName=seasonModel:getStageConfigEx(check[1],check[2],"name")
return UIManager.error(FMT.fmt("{0}·{1}开放后开启",seasonName,stageName))
end


local monsterSceneIdx=monsterData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(monsterSceneIdx)then

return UIManager.error("无法前往其他仙域")
end

local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法进攻本阵内的魔物"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法进攻阵外的魔物"
else

errStr="处于本阵内无法进攻其他本阵内的魔物"
end
UIManager.error(errStr)
end
return
end

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

local cfg=monsterData:getCfg()

local isWarringXianXuTimes=false

if cfg.flag==1 then
if not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eLaoYu,true)then
return
elseif not systemModel.isOpen(SYSTEM_DEFINE.eXianJieXianYu)then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eXianJieXianYu)
UIManager.error(str)
return
elseif not UIPrisonModel:getMoYuLockState()then
UIDialogManager.getCommonDialog(nil,"魔狱未建造，无法发起征讨\n是否前往建造",function()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eLaoYu,args={weakGuide=4100}}})
end)
return
elseif not UIPrisonModel:existEmptyRoom(ePrisonRoomType.eMonster)then
UIManager.error("魔狱牢房已满，无法发起征讨")
return
elseif xianjieModel:checkFuncRewardRecvMonsterLog(item_funtion_type.eMoWuDrop,0)then
UIDialogManager.getCommonDialog(nil,"魔物奖励未领取，无法发起征讨\n是否前往领取",function()
xianjieController:OpenXianjieMonsterLog(nil,4101)
end)
return
end
end
if xjEntityShowAttackRange[monsterData.entitytype]==1 then
local zmData=xianjieModel:getZongMenData(playerModel:getActorID())
local x1=zmData.gridX
local y1=zmData.gridZ
local x2=x1+zmData.gridWidth
local y2=y1+zmData.gridHeight
local gridX_c=monsterData.gridX_c
local gridZ_c=monsterData.gridZ_c
local wrange=cfg.range+monsterData.gridWidth/2
local hrange=cfg.range+monsterData.gridHeight/2
local x1_=gridX_c-wrange
local y1_=gridZ_c-hrange
local x2_=gridX_c+wrange
local y2_=gridZ_c+hrange

if not mathHelper.rectCrashRect(x1,y1,x2,y2,x1_,y1_,x2_,y2_)then
UIManager.error("需要进入其攻击范围才可发起进攻")

return
end
end

local monsterGroupId=cfg.monster[1]
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local monsterFight=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"recommend",monsterData.entitytype,cfg.stage)

local orderType=xjMonsterFightOrderMapping[monsterData.entitytype]or xjOrderType.eAttack
local isJiJie=orderType==xjOrderType.eJiJieInitiate

local isChuZheng,isCanChuZheng,tipsChuZheng=xianjieModel:checkXJIsChuZhengEx(orderType,false)
local wayTime=monsterData:getBaseWayTime()
if not isChuZheng then

local costList=cfg.consume
moneySystem:useMoneys(cfg.consume,function()


local winArgs={
enterCallBack=function(selectList,zfId,mapId)
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,v[2])
end

local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)

xianjieController:reqOrder(guid,orderType,dzlist,nil,nil,nil,nil,g_list)
UIManager:closeWindow('UIXianGuan_fightExtraWin')
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()

end,
enterTxt="仙界",
cancelCallBack=function()
UIManager:closeWindow('UIXianGuan_fightExtraWin')
fightController:closeSelectStage()
xianjieController:openMonsterInfoWin(infoguid)
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
isCheckXJOccupyType=true,
statePriorityCheck=false,
showZhenFa=false,





xjWayTime=wayTime,
costList=costList,
targetFight=monsterFight,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianjieModel:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=xianjieModel.checkDZSortFunc
fightController.showPrepareWin(fightPreSelectModel.fightType.xianjieMonster,winArgs,function()
UIManager:showWindow('UIXianGuan_fightExtraWin')
end)
end,WARNING_TYPE.eWarning)

elseif isChuZheng then
if isCanChuZheng>0 then
if zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXianYunGang,false)then

UIManager.error(tipsChuZheng)
else

local buildname=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eXianYunGang,"name")
local str=FMT.fmt("{0}未建造，无法发起征讨\n是否前往建造？",buildname)
UIDialogManager.getCommonDialog(nil,str,function()
jumpManager:jump({id=JUMP_TYPE.eUnlockRepairBuild2,args={buildType=SLG_SYSTEM_TYPE.eXianYunGang,mapid=mapIdType.fort,weakGuide=4110}})
end)
end
return
end

local extraCost=cfg.consume

if isJiJie then

local isCanJiJie,err=xianjieModel:checkCanJiJie()
if not isCanJiJie then
return UIManager.error(err)
end


local _func=function()
local minSoldierNum=1
local confirmCb=function(timeSecond)

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local data=xianjieModel:getJiJieLocalData()or{}
local isAutoGoFlag=data.lastSelectAutoFlag or 1
local isEndGoFlag=data.lastSelectEndGoFlag or 0
local params={timeSecond,isAutoGoFlag,isEndGoFlag}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end

local maxSoldierNum=tianShuDianController:getJiJieXiuShiMaxCount(self.infoguid)
return UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
wayTime=wayTime,
jiJieTime=timeSecond,
orderType=orderType,
minSoldierNum=minSoldierNum,
maxSoldierNum=maxSoldierNum,
confirmBtnStr="发起集结",
targetFight=monsterFight,
})
end
local isXianXu=monsterData.entitytype==xjServerEnityType.eMonsterHouse
self:showWindow("UIXianJie_JiJie_initiateWin",{confirmCb=confirmCb,extraCost=extraCost,orderType=orderType,isXianXu=isXianXu})
end

local rewardTimeConf=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",1,monsterData.entitytype)
if rewardTimeConf and not(monsterData.entitytype==xjServerEnityType.eMonsterHouse and cfg.flag and cfg.flag==2)then
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(monsterData.entitytype)
local least=maxTimes-curTimes
if least<=0 then
local args={
content="征讨奖励次数为<color=#c82c2c>0</color>，无法获得奖励\n是否继续发起集结？",
oktext="集结",
okcb=_func
}
local _dialog=UIDialogManager.getConfirmDialogEx(nil,args)
_dialog:show()
return
end
end

if isWarringXianXuTimes then
local str=(cfg.flag and cfg.flag==2)and"预备队正在前往界游仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"or
"预备队正在前往仙墟，剩余奖励次数不足，重复出发可能会无法获得奖励，是否继续参与？"
UIDialogManager.getCommonDialog(nil,str,_func)
return
end

_func()
else

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local params=''
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,params,boatId,nil,g_list)
end

local commonFunc=function()
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=orderType,targetFight=monsterFight})
end
commonFunc()
end
end
end

function UIXianJie_puTongZhenJiInfoWin:onTexingBtn()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local monsterCfg=monsterData:getCfg()
local winParams={
parentWin=self,
fazes=monsterCfg.faze or{},
}
self:showWindow("UIXianJie_monsterFaZeWin",winParams)
end

function UIXianJie_puTongZhenJiInfoWin:onRuleBtn()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local monsterCfg=monsterData:getCfg()
local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local rules=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,'monsterRule',monsterData.entitytype,monsterCfg.flag or 0)
local winParams={
parentWin=self,
lang=rules[1],
num=rules[2],
screenPos=screenPos,
}
self:showWindow("UIXianJie_monsterRuleWin",winParams)
end

function UIXianJie_puTongZhenJiInfoWin:onShowRewardBtn()

local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local cfg=monsterData:getCfg()
local csid=xianjieModel:getMoJieEnterConfig('csid')
local args={
parentWin=self,
drop={cfg.drop,cfg.box},
entityType=monsterData.entitytype
}
if cfg.ex_drop then
args.ex_drop=cfg.ex_drop[csid]
end
self:showWindow("UIXianJie_MonsterDropWin",args)
end

function UIXianJie_puTongZhenJiInfoWin:onRecordBtn()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local hideStage
if monsterData then
if xjMonsterInfoHideStage[monsterData.entitytype]and xjMonsterInfoHideStage[monsterData.entitytype]==1 then
hideStage=true
end
end

local cfg=monsterData:getCfg()
local nameStr=cfg.name
local temp={
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.mowu,
nameStr=nameStr,
sharename=nameStr,
ishujian=true,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end

function UIXianJie_puTongZhenJiInfoWin:onShareBtn()

local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local hideStage
if monsterData then
if xjMonsterInfoHideStage[monsterData.entitytype]and xjMonsterInfoHideStage[monsterData.entitytype]==1 then
hideStage=true
end
end
local cfg=monsterData:getCfg()

local nameStr=cfg.name
local _sceneType=xianjieModel:getScenceType()
local data={
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=nameStr,
shareType=xianjie_Point_Share.mowu,
scenceType=_sceneType,
name=nameStr,
shareName=nameStr,
shareId=cfg.id,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(_sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareId,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csPuTongZhenJi,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end

function UIXianJie_puTongZhenJiInfoWin:onMask()
xianjieController:closeWin('UIXianJie_puTongZhenJiInfoWin')
end

function UIXianJie_puTongZhenJiInfoWin:onMonsterRewardDetailbtn()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local cfg=monsterData:getCfg()
UIManager:showWindow("UIXianJie_monsterRewardDetailWin",{type=monsterData.entitytype,cfg=cfg})
end

function UIXianJie_puTongZhenJiInfoWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(1)

if self.mstentitytype==xjServerEnityType.eMonsterHouse or
self.mstentitytype==xjServerEnityType.eMoJieMoZong_Big or
self.mstentitytype==xjServerEnityType.eMoJieZhenYan_Big or
self.mstentitytype==xjServerEnityType.eMoJieShangGuMoster then
cbid=xianjieController.getZuoBiaoType(5)

elseif self.mstentitytype==xjServerEnityType.eBossMonster or
self.mstentitytype==xjServerEnityType.eMoJieZhenYan_Small or
self.mstentitytype==xjServerEnityType.eMoJieZhenYan_Spe or
self.mstentitytype==xjServerEnityType.eMoJieMoZong_Small then
cbid=xianjieController.getZuoBiaoType(3)
elseif self.mstentitytype==xjServerEnityType.eMonster then

if self.sharecfg then
if self.sharecfg.flag==1 or self.sharecfg.flag==2 then
cbid=xianjieController.getZuoBiaoType(6)
else
cbid=xianjieController.getZuoBiaoType(1)
end
else
cbid=xianjieController.getZuoBiaoType(1)
end
elseif self.mstentitytype==xjServerEnityType.eMoJieMoster then
cbid=xianjieController.getZuoBiaoType(1)
end

xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end

function UIXianJie_puTongZhenJiInfoWin:onShdBtn()
jumpManager:jump({id=JUMP_TYPE.eShouHunDing})
end

function UIXianJie_puTongZhenJiInfoWin:refreshShdBtn()
local show=shouhundingController:isOpen()
if show then
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
show=shouhundingModel:checkEntityData(monsterData)
end
self.shdBtn:setActive(show)
if show then
self:refreshShdTx()
end
end

function UIXianJie_puTongZhenJiInfoWin:refreshShdTx()
local cur=shouhundingModel:getDataValue()
local max=shouhundingModel:getDataMax()
local precent=math.min(cur,max)/max*100
precent=math.min(precent,100)
precent=precent>1 and math.floor(precent)or math.ceil(precent)
self.shdTx:setText(FMT.fmt("{0}%",precent))
end

function UIXianJie_puTongZhenJiInfoWin.on_money_changed(mType)
if shouhundingModel:isDataType(mType)then
_this:refreshShdTx()
end
end

function UIXianJie_puTongZhenJiInfoWin.on_system_open(sysId)
if shouhundingModel:isSysID(sysId)then
_this:refreshShdBtn()
end
end

function UIXianJie_puTongZhenJiInfoWin:proTipBtnClick(monsterData)
local entitytype=monsterData.entitytype
if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
local soldierList=monsterData.soldierList
local cfg=monsterData:getCfg()


local jzInfo=cfg.jz
if jzInfo then
local maxLookup={}
for i,v in ipairs(jzInfo)do
maxLookup[v[1]]=v[2]
end
self:showWindow("UIMoZong_moBingInfoWin",{soldierList=soldierList,maxLookup=maxLookup})
end

end
end

function UIXianJie_puTongZhenJiInfoWin:getProValue(monsterData)
local cur,max=0,0
local entitytype=monsterData.entitytype
if entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
entitytype==xjServerEnityType.eMoJieZhenYan_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Big or
entitytype==xjServerEnityType.eMoJieMoZong_Big then
local soldierList=monsterData.soldierList
local cfg=monsterData:getCfg()


local jzInfo=cfg.jz
if jzInfo then
for i,v in ipairs(jzInfo)do
max=max+v[2]
end
end
if soldierList then
for i,v in ipairs(soldierList)do
cur=cur+v.param_2
end
end
end
return cur,max
end

function UIXianJie_puTongZhenJiInfoWin:refreshProValue()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local showProCfg=_showPro[monsterData.entitytype]
if showProCfg then
local monsterInfoWidget=self.monsterInfo:getWidgetBase()
local cur,max=self:getProValue(monsterData)
monsterInfoWidget:SetChildUIProgressbar(14,cur,max,false)
monsterInfoWidget:SetChildText(18,FMT.fmt("{0}/{1}",mathHelper.formatNumber(cur),mathHelper.formatNumber(max)))
end
end


function UIXianJie_puTongZhenJiInfoWin:freshMoJiePnael()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
if isMJtime then
self:freshMoJiBuffnum(monsterData)
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMoJiBuffClick(widget,monsterData)
end)
else
self.mjslpanel:setActive(false)
end
end

function UIXianJie_puTongZhenJiInfoWin:freshMoJiBuffnum()
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local buffTemp={}
local buffNum=0

if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
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

function UIXianJie_puTongZhenJiInfoWin:onMoJiBuffClick(_posWidget)
local monsterData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local buffTemp={}
local buffNum=0
if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
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

function UIXianJie_puTongZhenJiInfoWin:freshMoJieShiLiItem()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
local forceid=0
if forceid>0 then
self.slItem:setActive(true)
local cfg=cfg_devildomforceconfig_get(forceid)
self.slNameText:setText(cfg.name)
else
self.slItem:setActive(false)
end
end
end



function UIXianJie_puTongZhenJiInfoWin:freshMoJieSkillPnael(monsterData)
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
if monsterData==nil then return end
self.exBtns:setLocalPosY(-200)
local forceid=xianjieController:getForce()
if forceid>0 and xianjieController:getShiLiDebuffCheck(forceid)then
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
_this:onUseMoJiSkillbtn(monsterData)
end)
self:CheckUseMoJiSkillTime()
else
self.mjslskill:setActive(false)
end
else
self.mjslskill:setActive(false)
end
end

function UIXianJie_puTongZhenJiInfoWin:onUseMoJiSkillbtn(monsterData)
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法对本阵内的魔物使用"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法对阵外的魔物使用"
else

errStr="处于本阵内无法对其他本阵内的魔物使用"
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
local actorid=int64.new(tostring(self.infoguid))

local _fun=function()
xianjieController:useMoJieShiLiSkill(actorid)
xianjieController:closeWin('UIXianJie_puTongZhenJiInfoWin')
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

function UIXianJie_puTongZhenJiInfoWin:serverMoJiSkill()
if _this==nil then return end
_this:CheckUseMoJiSkillTime()
end

function UIXianJie_puTongZhenJiInfoWin:CheckUseMoJiSkillTime()
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
function UIXianJie_puTongZhenJiInfoWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end


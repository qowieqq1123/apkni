







def_class("UIMoJieGate_attackWin",UIWindowBase)









function UIMoJieGate_attackWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.gateModel=UIObject.get(self,4)
self.gateNameText=UIText.get(self,5)
self.belongXmText=UIText.get(self,6)
self.titlePanel=UIObject.get(self,7)
self.stateText=UIText.get(self,8)
self.tipsPanel=UIObject.get(self,9)
self.bottomTipsText=UIText.get(self,10)
self.hpProgressPanel=UIObject.get(self,11)
self.hpProgressBar=UIProgress.get(self,12)
self.timeProgressPanel=UIObject.get(self,13)
self.timeProgressBar=UIProgress.get(self,14)
self.repairTextPanel=UIObject.get(self,15)
self.repairText=UIText.get(self,16)
self.rankPanel=UIObject.get(self,17)
self.rankTitleText=UIText.get(self,18)
self.rankGroup=UIObject.get(self,19)
self.atkBtn=UIButton.get(self,20)
self.unlockTipsText=UIText.get(self,21)
self.rankTipsText=UIText.get(self,22)
self.buffBtn=UIButton.get(self,23)
self.buffTips=UIObject.get(self,24)
self.buffDescText=UIText.get(self,25)
self.tipsClickMask=UIButton.get(self,26)
self.attackingTipsText=UIText.get(self,27)
self.helpBtn=UIButton.get(self,28)
self.btnCostPanel=UIObject.get(self,29)
self.btnCostIcon=UIImage.get(self,30)
self.btnCostText=UIText.get(self,31)
self.costPanel=UIObject.get(self,32)
self.costIcon=UIImage.get(self,33)
self.costText=UIText.get(self,34)
self.lockPanel=UIObject.get(self,35)
self.lockText=UIText.get(self,36)
self.rewardScrollView=UIObject.get(self,37)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.atkBtn:setButtonClick(function()self:onAtkBtn()end)

self.buffBtn:setButtonClick(function()self:onBuffBtn()end)

self.tipsClickMask:setButtonClick(function()self:onTipsClickMask()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIMoJieGate_attackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gateModel);self.gateModel=nil;
_UIObject_release(self.gateNameText);self.gateNameText=nil;
_UIObject_release(self.belongXmText);self.belongXmText=nil;
_UIObject_release(self.titlePanel);self.titlePanel=nil;
_UIObject_release(self.stateText);self.stateText=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.bottomTipsText);self.bottomTipsText=nil;
_UIObject_release(self.hpProgressPanel);self.hpProgressPanel=nil;
_UIObject_release(self.hpProgressBar);self.hpProgressBar=nil;
_UIObject_release(self.timeProgressPanel);self.timeProgressPanel=nil;
_UIObject_release(self.timeProgressBar);self.timeProgressBar=nil;
_UIObject_release(self.repairTextPanel);self.repairTextPanel=nil;
_UIObject_release(self.repairText);self.repairText=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankTitleText);self.rankTitleText=nil;
_UIObject_release(self.rankGroup);self.rankGroup=nil;
_UIObject_release(self.atkBtn);self.atkBtn=nil;
_UIObject_release(self.unlockTipsText);self.unlockTipsText=nil;
_UIObject_release(self.rankTipsText);self.rankTipsText=nil;
_UIObject_release(self.buffBtn);self.buffBtn=nil;
_UIObject_release(self.buffTips);self.buffTips=nil;
_UIObject_release(self.buffDescText);self.buffDescText=nil;
_UIObject_release(self.tipsClickMask);self.tipsClickMask=nil;
_UIObject_release(self.attackingTipsText);self.attackingTipsText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.btnCostPanel);self.btnCostPanel=nil;
_UIObject_release(self.btnCostIcon);self.btnCostIcon=nil;
_UIObject_release(self.btnCostText);self.btnCostText=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockText);self.lockText=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
end















local _this




function UIMoJieGate_attackWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
self:addNotify(notifyConfig.onXianJieWaiPaiChange,self.onXianJieWaiPaiChange)
end


function UIMoJieGate_attackWin:__delete()
_this=nil
self:clearTimer()
self:unbindComponents()
end




function UIMoJieGate_attackWin:onShow(argtable,afterOnloaded)
self.gateId=argtable.gateId
self.bgModel:setChildUIModelShowTarget(6427,1,nil,eAnimationID.stand)
self.isShowBuffTipsPanel=false

local isIgnoreEnterAnim=argtable.isIgnoreEnterAnim
if not isIgnoreEnterAnim then
self.root:setChildCanvasGroupAlpha(0)
self.root:setScale(Vector3.zero)
self.rewardScrollView:setChildScrollRectEnable(false)

self.root:setChildCanvasGroupDOFade(1,0.5)
self.root:setChildDOScale(1,0.5,function()
self.rewardScrollView:setChildScrollRectEnable(true)
end)
else
self.root:setChildCanvasGroupAlpha(1)
self.root:setScale(Vector3.one)
self.rewardScrollView:setChildScrollRectEnable(true)
end

self:refresh(true)
end


function UIMoJieGate_attackWin:onHide()
self:clearTimer()
end

function UIMoJieGate_attackWin:refresh(isInit)
self:clearTimer()

local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,self.gateId)
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
self.gateBaseCfg=gateBaseCfg


local gateName=gateCfg.name
local gateXYSceneIndex=gateCfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
local nameStr=FMT.fmt("{0}-{1}",xyName,gateName)
self.gateNameText:setText(nameStr)


local xmName="暂无归属"
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if hasXM then
xmName=xmData.param_3
end
self.belongXmText:setText(FMT.fmt("归属：{0}",xmName))


local isOpenGate=false
if gateData then
isOpenGate=seasonController:checkSeasonStageBegined(season_id,chapter_idx)
end
local atkState=xianjieModel:getMoJieGateAtkState(self.gateId)
self.titlePanel:setActive(true)
self.tipsPanel:setActive(isOpenGate and atkState==2)
if isOpenGate then
if atkState==2 then
self.bottomTipsText:setText("要塞筑起结界，暂不可攻打")

local isCanPass=xianjieModel:checkMoJieGateIsSelfXMCanPass(self.gateId)
if isCanPass then
self.stateText:setText("可通过")

else
self.stateText:setText("修复状态")

end
elseif atkState==1 then
self.stateText:setText("攻打状态")
elseif atkState==0 then
self.stateText:setText("可攻打状态")
end
else
self.stateText:setText("未开启状态")
end



local isShowHp=true
local maxHpValue=gateBaseCfg.guankou_hp
local showHpValue=gateData and gateData.hp or maxHpValue
self.hpProgressPanel:setActive(isShowHp)
if showHpValue then

if gateData.fixTime and gateData.fixTime>0 then
local cdTime=gateBaseCfg.fix_time
local startTime=gateData.fixTime
local endTime=startTime+cdTime
local nowTime=timeHelper.getServerShortTime()
if nowTime>endTime then

showHpValue=maxHpValue
end
end
self.hpProgressBar:setProgressValue(showHpValue,maxHpValue)
local progressStr
if atkState~=2 then
local hpShowPercent=showHpValue/maxHpValue*100
if hpShowPercent<0.01 then
hpShowPercent=0.01
end
progressStr=string.format('%0.2f%%',hpShowPercent)
else
progressStr="修复中"
end
self.hpProgressBar:setChildProgressText(progressStr)
end

self.timeProgressPanel:setActive(atkState==1)
self.repairTextPanel:setActive(atkState==2)



local nowTime=timeHelper.getServerShortTime()
if atkState==1 then

local cdTime=gateBaseCfg.attack_time
local endTime=gateData.atkTime+cdTime

local isShowAtkTime=nowTime<=endTime
self.timeProgressPanel:setActive(isShowAtkTime)
if isShowAtkTime then
self:setAtkTimer(gateData.atkTime,endTime)
end
elseif atkState==2 then

local cdTime=gateBaseCfg.fix_time
local endTime=gateData.fixTime+cdTime
local isShowFixTime=nowTime<=endTime
self.repairTextPanel:setActive(isShowFixTime)
if isShowFixTime then
self:setFixTimer(endTime)
end
end


self:refreshRankPanel()


self.unlockTipsText:setActive(not isOpenGate)
self.teamHandleID=nil
local isShowAtkBtn=isOpenGate and atkState~=2
local isSelfAttacking=false
if not isOpenGate then
local unlockTipsStr=FMT.fmt("【魔界探索·第{0}章·{1}】解锁攻打",mathHelper.numberToChinese(chapter_idx),gateBaseCfg.name)
self.unlockTipsText:setText(unlockTipsStr)
end
if isShowAtkBtn then
local isHasSelfTeam,teamHandleID=xianjieModel:checkMoJieGateHasTeam(self.gateId)
self.teamHandleID=teamHandleID
isSelfAttacking=isHasSelfTeam
end
self.atkBtn:setActive(isShowAtkBtn and not isSelfAttacking)
self.attackingTipsText:setActive(isShowAtkBtn and isSelfAttacking)


local extraCost=self.gateBaseCfg.consume
local isShowCost=extraCost~=nil
self.costPanel:setActive(isShowCost and not isOpenGate)
self.btnCostPanel:setActive(isShowCost and isOpenGate)
if isShowCost then
local cost=extraCost[1]
local moneyType=cost[1]
local moneyCount=cost[2]
local hasCount=itemsModel.getCount(moneyType)
local countStr=mathHelper.formatNumber(moneyCount)
if hasCount<moneyCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
local iconName=iconHelper.getIconName(moneyType)

if isOpenGate then
self.btnCostIcon:setChildIcon(iconName,false)
self.btnCostText:setText(countStr)
else
self.costIcon:setChildIcon(iconName,false)
self.costText:setText(countStr)
end
end


self:refreshAtkBuffPanel()

if hasXM then

return self:reopenGateWin()
end


self:refreshOwnRewardPanel()
end

function UIMoJieGate_attackWin:refreshRankPanel()
local sortRankList=self:getSortRankList()
if sortRankList then

self.rankGroup:setActive(true)
self.rankTipsText:setActive(false)
local count=#sortRankList
local xmOwnLookup=xianjieModel:getMoJieGateSelfXianYuOwnGateXmLookup()
self.rankGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.rankGroup:getChildLayoutGroupGridItem(index-1)
local rankData=sortRankList[index]
if rankData then
widget:SetChildActive(-1,true)
local rankNum=index

local rankIcon
local rank_str=tostring(rankNum)
if rankNum<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rankNum)
else
rankIcon=FMT.fmt('icon_phbmingci_4')
end
local showRankIcon=rankIcon~=nil
if showRankIcon then
widget:SetChildCSImageSprite(0,globalABLookup.rankList,rankIcon)
widget:SetChildText(1,rank_str)
else
widget:SetChildText(1,rank_str)
end


local xmData=rankData.guild_info or nil
local xmGuid=xmData and xmData.param_1 or nil
local xmName=xmData and xmData.param_3 or"未知仙盟"
widget:SetChildText(2,xmName)


local dmgValue=rankData.damage or 0
local maxHpValue=self.gateBaseCfg.guankou_hp
local dmgStr=string.format('%0.2f%%',dmgValue/maxHpValue*100)
widget:SetChildText(3,dmgStr)


local xmGuidStr=tostring(xmGuid)
local hasOwn=xmOwnLookup[xmGuidStr]~=nil
widget:SetChildActive(4,hasOwn)
if hasOwn then
widget:SetChildButtonClick(4,function()
if not _this then return end
_this:onTiChuFlagClick(widget)
end,true)
end

local posX=hasOwn and-50 or-19
widget:SetChildAnchoredPos(3,posX,0)
else
widget:SetChildActive(-1,false)
end
end)
else

self.rankGroup:setActive(false)
self.rankTipsText:setActive(true)
end
end

function UIMoJieGate_attackWin:getSortRankList(list)
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
list=gateData and gateData.rankList or nil

local sortList
if list then
sortList=table.weakCopy(list)
table.sort(sortList,function(a,b)return a.damage>b.damage end)
end
return sortList
end

function UIMoJieGate_attackWin:setAtkTimer(startTime,endTime)
self:clearAtkTimer()
local allTime=endTime-startTime
local func=function()
local nowTime=timeHelper.getServerShortTime()
if nowTime<=endTime then
local deltaTime=nowTime-startTime
local percent=math.floor(deltaTime/allTime*10000)

self.timeProgressBar:setProgressValue(percent,10000)
local lerp=endTime-nowTime
self.timeProgressBar:setChildProgressText(timeHelper.format_time_stamp11(lerp,true))
else
self:refresh()
end
end

self.atkTimer=self:setTimer(1,0,func)
func()
end

function UIMoJieGate_attackWin:clearAtkTimer()
if self.atkTimer then
self:stopTimerByID(self.atkTimer)
self.atkTimer=nil
end
end

function UIMoJieGate_attackWin:setFixTimer(endTime)
self:clearFixTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
if nowTime<=endTime then
local lerp=endTime-nowTime
self.repairText:setText(FMT.fmt("{0}后修复完成",timeHelper.format_time_stamp11(lerp,true)))
else
self:refresh()
end
end

self.fixTimer=self:setTimer(1,0,func)
func()
end

function UIMoJieGate_attackWin:clearFixTimer()
if self.fixTimer then
self:stopTimerByID(self.fixTimer)
self.fixTimer=nil
end
end

function UIMoJieGate_attackWin:clearTimer()
self:clearAtkTimer()
self:clearFixTimer()
end

function UIMoJieGate_attackWin:refreshByGateId(gateId)
if not gateId or self.gateId==gateId then
return self:refresh()
end
end

function UIMoJieGate_attackWin:reopenGateWin()
local gateId=self.gateId
return xianjieController:openMoJieGateWin(gateId,nil,true)
end

function UIMoJieGate_attackWin:refreshAtkBuffPanel()

local gateId=self.gateId
local ownXmGuid=xianjieModel:getMoJieGateOwnXmGuid(gateId)
local hasOwn=ownXmGuid and not mathHelper.compareInt64(ownXmGuid,Int64_0)
local isShowBuffBtn=false
local buffLv
if not hasOwn then

buffLv=xianjieModel:getMoJieGateAtkBuff()
if buffLv and buffLv>0 then
isShowBuffBtn=true
end
end

self.buffBtn:setActive(isShowBuffBtn)
if isShowBuffBtn then

local descStr="未知法则"
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local stageId=gateData and gateData.stageId or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local buffCfg=gateBaseCfg and gateBaseCfg.attack_buff or nil
local fzId=buffCfg and buffCfg[3]
if fzId then
local fzCfg=cfgHelper.getSSlawRule(fzId)
local desc=fzCfg.desc
local descparm=fzCfg.descparm
if descparm then
if buffLv>0 then
descStr=string.format(desc,unpack(descparm[buffLv]))
else
local params={}
for i=1,#descparm[1]do
table.insert(params,0)
end
descStr=string.format(desc,unpack(params))
end
end
end
self.buffDescText:setText(descStr)
else
self.buffTips:setActive(false)
self.tipsClickMask:setActive(false)
self.isShowBuffTipsPanel=false
end
end

function UIMoJieGate_attackWin.onSeasonStageChange()
if not _this then
return
end

_this:refreshAtkBuffPanel()
end

function UIMoJieGate_attackWin.onNewDay5am()
if not _this then
return
end

_this:refreshAtkBuffPanel()
end

function UIMoJieGate_attackWin.onXianJieWaiPaiChange(changeType,param)
if _this==nil or not _this.isVisible then return end
if(changeType==CHANGE_TYPE.eChanged or changeType==CHANGE_TYPE.eAdd)then
local teamHandle=param
local marchData=teamHandle.teamData
if marchData.marchtype==xjServerMarchType.eKillBossMonster then
local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,_this.gateId)
local gateBuildId=gateCfg.build_id
local guid=marchData.infoguid
local sceneidx=marchData.tarsceneidx
if guid and sceneidx then
local entityType=xianjieModel:getEntityTypeByGuid(guid,sceneidx)
if entityType and entityType==xjServerEnityType.eClientBuild then
local targetGateBuildId=mathHelper.int64_to_number(guid)
if targetGateBuildId==gateBuildId then

_this:refresh()
end
end
end
end
elseif changeType==CHANGE_TYPE.eDelete then
local teamHandleID=param
if teamHandleID==_this.teamHandleID then

_this:refresh()
end
end
end

function UIMoJieGate_attackWin:checkIsEnoughCost(itemList)
if not itemList or not next(itemList)then
return true
end

for i,v in pairs(itemList)do
local itemId=v[1]
local needNum=v[2]
local haveNum=itemsModel.getCount(itemId)

if haveNum<needNum then
return false,itemId
end
end
return true
end

function UIMoJieGate_attackWin:refreshOwnRewardPanel()
local rewards=self:getOwnRewardList()
local num=#rewards
self.rewardScrollView:setChildScrollViewCreateGrids(num,num)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local reward=rewards[i]
if reward then
widget:SetChildActive(-1,true)
local itemid=reward.itemId
local count=reward.itemCount
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end
end

function UIMoJieGate_attackWin:getOwnRewardList()



local rewards={}

local own_rewardList=self.gateBaseCfg.own_reward
if own_rewardList then
local list=own_rewardList
for i,v in ipairs(list)do
local itemId=v[1]
local itemCount=v[2]
local itemColor=itemsConfig.getItemColor(itemId)
rewards[#rewards+1]={
itemId=itemId,
itemCount=itemCount,
itemColor=itemColor,
}
end
end


local own_money_rewardList=self.gateBaseCfg.own_money_reward
if own_money_rewardList then
local list=own_money_rewardList
for i,v in ipairs(list)do
local itemId=v[1]
local itemCount=v[2]
local itemColor=itemsConfig.getItemColor(itemId)
rewards[#rewards+1]={
itemId=itemId,
itemCount=itemCount,
itemColor=itemColor,
}
end
end

if#rewards>1 then

table.sort(rewards,function(a,b)
if a.itemColor==b.itemColor then
return a.itemId<b.itemId
else
return a.itemColor>b.itemColor
end
end)
end

return rewards
end




function UIMoJieGate_attackWin:onClickMask()
self:onClickClose()
end



function UIMoJieGate_attackWin:onCloseBtn()
self:onClickClose()
end



function UIMoJieGate_attackWin:onAtkBtn()

local flag=xianjieModel:checkTriggerSeasonStageBehaivour()
if flag then
_this:onClickClose()
return
end
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local season_id=gateData and gateData.seasonId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
if not seasonController:checkSeasonStageBegined(season_id,chapter_idx)then
local seasonName=seasonModel:getHandleConfig(season_id,"name")
local stageName=seasonModel:getStageConfigEx(season_id,chapter_idx,"name")
return UIManager.error(FMT.fmt("{0}·{1}开放后开启",seasonName,stageName))
end


local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,self.gateId)
local gateSceneIdx=gateCfg.area
local selfXySceneIdx=xianjieModel:getXianYuSceneIndex()
if gateSceneIdx~=selfXySceneIdx then

return UIManager.error("无法攻打其他仙域本阵的关口要塞")
end


local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
if hasXM then
UIManager.error("关口已被攻破")

return self:onClickClose()
end


local atkState=xianjieModel:getMoJieGateAtkState(self.gateId)
if atkState==2 then
return UIManager.error("关口修复中，无法攻打")
end


local selfHasXm=xianmengModel:hasXM()
if not selfHasXm then
UIManager.error("未加入仙盟，无法参与攻打关口")
return
end



















if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

local orderType=xjOrderType.eAttackBoss
local isChuZheng,isCanChuZheng,tipsChuZheng=xianjieModel:checkXJIsChuZhengEx(orderType,false)
local wayTime=gateEntityData:getBaseWayTime(true)
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


local extraCost=self.gateBaseCfg.consume
if extraCost then
local isEnough,itemId=self:checkIsEnoughCost(extraCost)
if not isEnough then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
return
end
end

local entityId=gateCfg.build_id
local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(entityId)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local params=''
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,params,boatId,nil)
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=orderType})
end

function UIMoJieGate_attackWin:onClickClose()
xianjieController:closeWin('UIMoJieGate_attackWin')
end

function UIMoJieGate_attackWin:onBuffBtn()
self.isShowBuffTipsPanel=not self.isShowBuffTipsPanel
self.buffTips:setActive(self.isShowBuffTipsPanel)
self.tipsClickMask:setActive(self.isShowBuffTipsPanel)
end

function UIMoJieGate_attackWin:onTipsClickMask()
self.buffTips:setActive(false)
self.tipsClickMask:setActive(false)
self.isShowBuffTipsPanel=false
end

function UIMoJieGate_attackWin:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eMoJieGate,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end


function UIMoJieGate_attackWin:onTiChuFlagClick(widget)
local str="此仙盟已有关口归属\n不参与此关口归属权争夺"
local offset=Vector2.New(390,-90)
local d={
str=str,
posWidget=widget,
pos=offset,
}
self:showWindow('UIDescribeTips9',d)
end

function UIMoJieGate_attackWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIMoJieGate_attackWin:test_showGateTimeData()
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local atkTime=gateData and gateData.atkTime or 0
local fixTime=gateData and gateData.fixTime or 0

end

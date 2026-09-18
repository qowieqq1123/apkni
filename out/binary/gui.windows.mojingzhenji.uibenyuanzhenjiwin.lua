







def_class("UIBenYuanZhenJiWin",UIWindowBase)









function UIBenYuanZhenJiWin:bindComponents()

self.addChangellCountBtn=UIButton.get(self,0)
self.attackBtn=UIButton.get(self,1)
self.btnRule=UIButton.get(self,2)
self.cdProgress=UIObject.get(self,3)
self.cdVal=UIText.get(self,4)
self.changellCount=UIText.get(self,5)
self.countdownPanel=UIObject.get(self,6)
self.countdownText=UIText.get(self,7)
self.damagePanel=UIObject.get(self,8)
self.fazeDesc=UIText.get(self,9)
self.hpPercent=UIText.get(self,10)
self.hpProgress=UIObject.get(self,11)
self.lockDesc=UIText.get(self,12)
self.lockDesc2=UIText.get(self,13)
self.lockPanel=UIObject.get(self,14)
self.mbg=UIObject.get(self,15)
self.mjslpanel=UIObject.get(self,16)
self.mjslskill=UIObject.get(self,17)
self.monFaze_1=UIImage.get(self,18)
self.monFaze_2=UIImage.get(self,19)
self.monFaze_3=UIImage.get(self,20)
self.mqProgress=UIObject.get(self,21)
self.mqVal=UIText.get(self,22)
self.name=UIText.get(self,23)
self.notXmDamageRank=UIText.get(self,24)
self.notXmScoreRank=UIText.get(self,25)
self.root=UIObject.get(self,26)
self.scorePanel=UIObject.get(self,27)
self.stateLayout=UIObject.get(self,28)
self.stateTxt=UIText.get(self,29)
self.stopAttackBtn=UIButton.get(self,30)
self.stopAttackText=UIText.get(self,31)
self.unlockCdn=UIText.get(self,32)
self.xmDamageRank=UILoopListView.new(self,33)
self.xmScoreRank=UILoopListView.new(self,34)

self.addChangellCountBtn:setButtonClick(function()self:onAddChangellCountBtn()end)

self.attackBtn:setButtonClick(function()self:onAttackBtn()end)

self.btnRule:setButtonClick(function()self:onBtnRule()end)

self.stopAttackBtn:setButtonClick(function()self:onStopAttackBtn()end)

self.xmDamageRank:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.xmScoreRank:bindLoopListView(function(...)
self:onFreshAction_2(...)
end,function(...)
self:onStartAction_2(...)
end)self.monFaze={
self.monFaze_1,
self.monFaze_2,
self.monFaze_3,
}



end


function UIBenYuanZhenJiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addChangellCountBtn);self.addChangellCountBtn=nil;
_UIObject_release(self.attackBtn);self.attackBtn=nil;
_UIObject_release(self.btnRule);self.btnRule=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.cdVal);self.cdVal=nil;
_UIObject_release(self.changellCount);self.changellCount=nil;
_UIObject_release(self.countdownPanel);self.countdownPanel=nil;
_UIObject_release(self.countdownText);self.countdownText=nil;
_UIObject_release(self.damagePanel);self.damagePanel=nil;
_UIObject_release(self.fazeDesc);self.fazeDesc=nil;
_UIObject_release(self.hpPercent);self.hpPercent=nil;
_UIObject_release(self.hpProgress);self.hpProgress=nil;
_UIObject_release(self.lockDesc);self.lockDesc=nil;
_UIObject_release(self.lockDesc2);self.lockDesc2=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
_UIObject_release(self.monFaze_1);self.monFaze_1=nil;
_UIObject_release(self.monFaze_2);self.monFaze_2=nil;
_UIObject_release(self.monFaze_3);self.monFaze_3=nil;
_UIObject_release(self.mqProgress);self.mqProgress=nil;
_UIObject_release(self.mqVal);self.mqVal=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.notXmDamageRank);self.notXmDamageRank=nil;
_UIObject_release(self.notXmScoreRank);self.notXmScoreRank=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scorePanel);self.scorePanel=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.stopAttackBtn);self.stopAttackBtn=nil;
_UIObject_release(self.stopAttackText);self.stopAttackText=nil;
_UIObject_release(self.unlockCdn);self.unlockCdn=nil;
self.xmDamageRank:deleteSelf();self.xmDamageRank=nil;
self.xmScoreRank:deleteSelf();self.xmScoreRank=nil;
self.monFaze=nil;
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

function UIBenYuanZhenJiWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIBenYuanZhenJiWin:__delete()
self:unbindComponents()
if self.countdownTimer then
self:stopTimerByID(self.countdownTimer)
end
_this=nil
end




function UIBenYuanZhenJiWin:onShow(argtable,afterOnloaded)
self.season_id=argtable.seasonType
self.chapter_idx=argtable.stageIndex
self.build_id=argtable.build_id

self.netData=xianjieModel:getBenYuanZhenJiNetData(self.season_id,self.chapter_idx,self.build_id)or{}
if not self.netData then
return
end
self.configs=seasonModel:getStageConfigEx(self.season_id,self.chapter_idx)
if not self.configs then
loggerUtil.logErrFMT("魔晶阵基赛季配置未找到 赛季id：{0} 章节索引{1}",self.season_id,self.chapter_idx)
return
end

self.byZhenJiCfg=self.configs.byZhenJi[self.build_id]
if not self.byZhenJiCfg then
loggerUtil.logErrFMT("本源阵基配置未找到 建筑id：{0}",self.build_id)
return
end

self:setName()
self:refreshView(nil,true)

local marchguid
local wpData=xianjieModel:getWaiPaiByQBEntityData2(xjWaiPiaBaseType.eMarckTeam,self.build_id)
if wpData then
marchguid=wpData.guid
end
self.marchguid=marchguid
self:refreshStateDesc()

local attackTime=self.configs.attackTime;
self.attackBtn:setActive(true)
self.stopAttackBtn:setActive(false)
if attackTime~=nil and next(attackTime)~=nil then
self.stopAttackText.setText(string.format("每日%d~%d点开启征讨",attackTime[1],attackTime[4]))
end
self:refreshAttackTime()

if self.mytimer==nil then
_this:updateTime()
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end
end

function UIBenYuanZhenJiWin:setName()
local byzjData=xianjieModel:getBenYuanZhenJiDataByBuildId(self.season_id,self.chapter_idx,self.build_id)
local cfg=byzjData:getCfg()
self.name:setText(cfg.name)

local unlockDesc=self.configs.unlockDesc
self.lockDesc:setText(unlockDesc[2])
self.lockDesc2:setText(unlockDesc[2])
end

function UIBenYuanZhenJiWin:refreshBgModel(type,isInit)
if self.oldType~=type then
if isInit then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
end

local animIdArr={eAnimationID.enter,eAnimationID.enter2,eAnimationID.enter3}
if isInit and type==3 then
self.mbg:setChildUIModelShowTarget(6422,1,nil,eAnimationID.stand3)
else
self.root:setChildCanvasGroupAlpha(0)
self.mbg:setChildUIModelShowTarget(6422,1,nil,animIdArr[type])
self:delayDo(1,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
self.oldType=type
end
end

function UIBenYuanZhenJiWin:refreshView(build_id,isInit)
if build_id and build_id~=self.build_id then
return
end
if build_id~=nil then
self.netData=xianjieModel:getBenYuanZhenJiNetData(self.season_id,self.chapter_idx,self.build_id)or{}
end
local curMQ=self.netData.ptzjDieNum or 0
local maxMQ=self.byZhenJiCfg[3]
local countdownTime=self.netData.countdownTime or 0
if xianjieModel:checkMoJingZhenJiDestroyed(self.season_id,self.chapter_idx,self.build_id)then
self:refeshScorePanel()
self:refreshBgModel(2,isInit)
elseif curMQ>=maxMQ and countdownTime>0 and countdownTime<timeHelper.getServerShortTime()then
self:refeshDamagePanel()
self:refreshBgModel(3,isInit)
elseif curMQ>=maxMQ and countdownTime>0 then
self:refeshCountdownPanel()
self:refreshBgModel(1,isInit)
elseif curMQ<maxMQ then
self:refeshLockPanel()
self:refreshBgModel(1,isInit)
end
end

function UIBenYuanZhenJiWin:updateTime()
if self.marchguid then
self:refreshStateDesc()
end
self:refreshAttackTime()
end

function UIBenYuanZhenJiWin:refreshStateDesc()
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
desc="征讨中..."
end
end
if teamHandle==nil then
self.marchguid=nil
end
end

local hasWaiPai=teamHandle~=nil

local showBtn=not hasWaiPai
self.attackBtn:setActive(showBtn)

self.stateLayout:setActive(hasWaiPai)
if hasWaiPai then
self.stateTxt:setText(desc)
end
end

function UIBenYuanZhenJiWin:refreshAttackTime()
if not self.netData then
return;
end
local attackTime=self.configs.attackTime;
if not attackTime or not next(attackTime)then
return;
end
if xianjieModel:checkMoJingZhenJiDestroyed(self.season_id,self.chapter_idx,self.build_id)then
return;
end
local curTime=timeHelper.getServerShortTime();
local curMQ=self.netData.ptzjDieNum or 0
local maxMQ=self.byZhenJiCfg[3]
local countdownTime=self.netData.countdownTime or 0
if curMQ>=maxMQ and countdownTime>0 and countdownTime<curTime then
local curLongTime=timeHelper.getServerLongTime()
local y,m,d=timeHelper.getDateNumber(curLongTime)
local s_time=timeHelper.timeServer(y,m,d,attackTime[1],attackTime[2],attackTime[3])
local e_time=timeHelper.timeServer(y,m,d,attackTime[4],attackTime[5],attackTime[6])
local attackFlag=curLongTime>s_time and curLongTime<e_time
if self.oldAttackFlag==nil or self.oldAttackFlag~=attackFlag then
self.attackBtn:setActive(attackFlag)
self.stopAttackBtn:setActive(not attackFlag)
self.oldAttackFlag=attackFlag
end
end
end


function UIBenYuanZhenJiWin:refeshLockPanel()
local unlockDesc=self.configs.unlockDesc
self.lockPanel:setChildCanvasGroupAlpha(1)
self.lockPanel:setChildCanvasGroupRaycast(true)
local curMQ=self.netData.ptzjDieNum or 0
local maxMQ=self.byZhenJiCfg[3]
local leftMQ=maxMQ-curMQ
self.mqProgress:setChildIconFillAmount(leftMQ/maxMQ)
self.mqVal:setText(string.format("魔气值：%d/%d",leftMQ,maxMQ))
self.unlockCdn:setText(string.format(unlockDesc[1],leftMQ))
end


function UIBenYuanZhenJiWin:refeshCountdownPanel()
self.lockPanel:setChildCanvasGroupAlpha(0)
self.countdownPanel:setChildCanvasGroupAlpha(1)
self.countdownPanel:setChildCanvasGroupRaycast(true)
local func=function()
local nowTime=timeHelper.getServerShortTime()
local moqiDelTime=_this.netData.moqiDelTime or 0
local countdownTime=_this.netData.countdownTime or 0
local cd=countdownTime-moqiDelTime
local left=countdownTime-nowTime
if left>0 then
_this.cdProgress:setChildIconFillAmount(left/cd)
_this.cdVal:setText(string.format("%s后消散",timeHelper.format_time_stamp11(left)))
local year,month,day,hour,min,sec=timeHelper.getServerStampData(timeHelper.convertLongStamp(countdownTime))
if min==0 then
min="00"
end
if sec==0 then
sec="00"
end
_this.countdownText:setText(string.format("%s-%s-%s %s:%s:%s 魔气消散",year,month,day,hour,min,sec))
else
if _this.countdownTimer then
_this:stopTimerByID(_this.countdownTimer)
_this.countdownPanel:setChildCanvasGroupAlpha(0)
_this.countdownPanel:setChildCanvasGroupRaycast(false)
_this:refeshDamagePanel()
_this:refreshBgModel(2)
end
end
end
func()
if self.countdownTimer then
self:stopTimerByID(self.countdownTimer)
end
self.countdownTimer=self:setTimer(1,0,func)
end


function UIBenYuanZhenJiWin:refeshDamagePanel()
self:refeshChallenge()
self.damagePanel:setChildCanvasGroupAlpha(1)
self.damagePanel:setChildCanvasGroupRaycast(true)





if self.netData.hpVal==0 then
self.hpProgress:setChildIconFillAmount(0)
self.hpPercent:setText(FMT.fmt("{0}%",0))
else
local curHP=self.netData.useMoJing or 0
local maxHP=self.configs.byZhenJi[self.build_id][10][2]
self.hpProgress:setChildIconFillAmount((maxHP-curHP)/maxHP)
self.hpPercent:setText(FMT.fmt("{0}/{1}",maxHP-curHP,maxHP))
end

local fazeList=self.byZhenJiCfg[9]
local fazeLen=#fazeList
for i,v in ipairs(self.monFaze)do
if fazeList[i]then
local faze=fazeList[i]
local fazeID=faze[1]
local fazeLv=faze[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
if fazeCfg then
v:setActive(true)


v:setChildIcon(fazeCfg.image,false)
else
v:setActive(false)
loggerUtil.logErrFMT("没有对应的法则配置：{0}",fazeID)
end
else
v:setActive(false)
end
end
self.fazeDesc:setActive(fazeLen==1)
if fazeLen==1 then
local faze=fazeList[1]
local fazeID=faze[1]
local fazeLv=faze[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
self.fazeDesc:setText(fazeCfg.desc)
end

self.rankData=self.netData.rankList or{}
local count=#self.rankData
local createList={}
for i=1,count do
table.insert(createList,i)
end

local _slotName='item'
self.xmDamageRank:initData(_slotName,createList)
self.notXmDamageRank:setActive(count<=0)

self:freshMoJiePnael()
self:freshMoJieSkillPnael()
end

function UIBenYuanZhenJiWin:refeshChallenge()
local changellData=xianjieModel:getMoJingZhenJiChangellData(self.season_id,self.chapter_idx,self.build_id)

local buyNum=changellData and changellData.buyNum or 0
local tzNum=changellData and changellData.tzNum or 0
local attackNum=self.configs.attackNum
self.changellCount:setText(FMT.fmt("讨伐剩余：{0}次",attackNum+buyNum-tzNum))
self.attackBtn:setGray(false)
end

function UIBenYuanZhenJiWin:onChangellAdd(isWarning)
local changellData=xianjieModel:getMoJingZhenJiChangellData(self.season_id,self.chapter_idx,self.build_id)

local curBuyNum=changellData and changellData.buyNum or 0
local maxBuyNum=self.configs.buyNum[1]
local lerpBuyNum=maxBuyNum-curBuyNum
if lerpBuyNum<=0 then
if isWarning then
UIManager.error('购买次数已用完')
end
return
end

local costDatas=self.configs.buyNum[2][1]
local costItemID=costDatas[1]
local costItemNum=costDatas[2]

local refresh=function(num)
local itemNum=costItemNum*num
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买讨伐次数？',costStr)
return contentStr,FMT.fmt("（剩余购买次数：{0}）",lerpBuyNum)
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=lerpBuyNum,
tips=FMT.fmt("（剩余购买次数：{0}）",lerpBuyNum),
oktext='购买',
canceltext='取消',
okcallback=function(num)
if _this==nil then return end

if xianjieModel:checkMoJingZhenJiDestroyed(self.season_id,self.chapter_idx,self.build_id)then
if isWarning then
UIManager.error('本源阵基已被摧毁')
end
return
end
local itemNum=costItemNum*num
local func=function()
xianjieController:reqBenYuanZhenJiBuyChangellNum(_this.season_id,_this.chapter_idx,_this.build_id,num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eWarning)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return true
end


function UIBenYuanZhenJiWin:onFreshAction(i,grid)
self:refreshDamageRankItem(grid,i)
end

function UIBenYuanZhenJiWin:onStartAction(i,grid)

end

function UIBenYuanZhenJiWin:getRankRewards(rank)
local rankItems=self.configs.xmRankItems
for i,v in ipairs(rankItems)do
local min=v[1]
local max=v[2]
local items=v[3]
if rank>=min and rank<=max then
return items
end
end
end

function UIBenYuanZhenJiWin:refreshDamageRankItem(widget,index)
local rankData=self.rankData[index]
widget:SetChildText(0,index)



local xmName=rankData.name or''
if xmName==''then
xmName='未知仙盟'
end
local image
if rankData.guildicon and rankData.guildicon>0 then
image=xianmengModel.splitGuildIcon(rankData.guildicon)
else
image={bg=1,icon=1,kuang=1}
end
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

widget:SetChildText(4,xmName)

widget:SetChildText(5,tonumber(tostring(rankData.mojingNum)))

local rewardList=self:getRankRewards(index)or{}
local rewardWidget={6,7,8}
for i,v in ipairs(rewardWidget)do
local reward=rewardList[i]
if reward then
widget:SetChildActive(v,true)
local rewardItem=widget:GetChildCSGUIBaseItem(v)
local itemid,itemnum=unpack(reward)
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local conf={itemid=itemid,itemcount=countStr,showCountBG=itemnum>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(v,function(...)
itemsComponentHelper.onItemClick(...)
end)
widget:SetChildPropData(v,prop)
else
widget:SetChildActive(v,false)
end
end
end


function UIBenYuanZhenJiWin:refeshScorePanel()
self.scorePanel:setChildCanvasGroupAlpha(1)
self.scorePanel:setChildCanvasGroupRaycast(true)

self.rankData=self.netData.rankList or{}
local count=#self.rankData
local createList={}
for i=1,count do
table.insert(createList,i)
end
local _slotName='item'
self.xmScoreRank:initData(_slotName,createList)

self.notXmScoreRank:setActive(count<=0)
end

function UIBenYuanZhenJiWin:onFreshAction_2(i,grid)
self:refreshScoreRankItem(grid,i)
end

function UIBenYuanZhenJiWin:onStartAction_2(i,grid)

end

function UIBenYuanZhenJiWin:refreshScoreRankItem(widget,index)
local rankData=self.rankData[index]
widget:SetChildText(0,index)



local xmName=rankData.name or''
local image
if rankData.guildicon and rankData.guildicon>0 then
image=xianmengModel.splitGuildIcon(rankData.guildicon)
else
image={bg=1,icon=1,kuang=1}
end
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

widget:SetChildText(4,xmName)



widget:SetChildText(5,tonumber(tostring(rankData.mojingNum)))

local rewardList=self:getRankRewards(index)or{}
local rewardWidget={6,7,8}
for i,v in ipairs(rewardWidget)do
local reward=rewardList[i]
if reward then
widget:SetChildActive(v,true)
local rewardItem=widget:GetChildCSGUIBaseItem(v)
local itemid,itemnum=unpack(reward)
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local conf={itemid=itemid,itemcount=countStr,showCountBG=itemnum>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(v,function(...)
itemsComponentHelper.onItemClick(...)
end)
widget:SetChildPropData(v,prop)
else
widget:SetChildActive(v,false)
end
end
end


function UIBenYuanZhenJiWin:onAttackBtn()
local infoguid=self.build_id
local monsterData=xianjieModel:getBenYuanZhenJiDataByBuildId(self.season_id,self.chapter_idx,self.build_id)
local changellData=xianjieModel:getMoJingZhenJiChangellData(self.season_id,self.chapter_idx,self.build_id)

local buyNum=changellData and changellData.buyNum or 0
local tzNum=changellData and changellData.tzNum or 0
local attackNum=self.configs.attackNum
if tzNum>=attackNum+buyNum then
self:onChangellAdd(true)
return
end

local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法进攻本阵内的阵基"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法进攻阵外的阵基"
else

errStr="处于本阵内无法进攻其他本阵内的阵基"
end
UIManager.error(errStr)
end
return
end
local wayTime=monsterData:getBaseWayTime()



local monsterFight=nil
local orderType=xjOrderType.eMoJingZhenJi_Origin

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local params=''
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,params,boatId,nil,g_list)
UIManager:closeWindow("UIBenYuanZhenJiWin")
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,wayTime=wayTime,orderType=orderType,targetFight=monsterFight})
end

function UIBenYuanZhenJiWin:onStopAttackBtn()
UIManager.info('未到征讨时间')
end

function UIBenYuanZhenJiWin:onAddChangellCountBtn()
self:onChangellAdd(true)
end

function UIBenYuanZhenJiWin:onBtnRule()
local args={
ruleGroupID=ruleTipsImageGroup.eMoJingZhenJi,
}
self:showWindow("UIRuleTipsImage2Win",args)
end

function UIBenYuanZhenJiWin:freshMoJiePnael()
local netData=xianjieModel:getBenYuanZhenJiNetData(self.season_id,self.chapter_idx,self.build_id)
local stage=seasonModel:findFirstDoingStage(seasonStageType.eMJZJ)
if stage then
self:freshMoJiBuffnum(netData)
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMoJiBuffClick(widget,netData)
end)
else
self.mjslpanel:setActive(false)
end
end

function UIBenYuanZhenJiWin:freshMoJiBuffnum(netData)
if not netData then
netData=xianjieModel:getBenYuanZhenJiNetData(self.season_id,self.chapter_idx,self.build_id)
end
local buffTemp={}
local buffNum=0
if netData and netData.bufflistlen and netData.bufflistlen>0 then
local buffList_lookup=netData.buffList or{}
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

function UIBenYuanZhenJiWin:onMoJiBuffClick(_posWidget,netData)

local buffTemp={}
local buffNum=0
if netData and netData.bufflistlen and netData.bufflistlen>0 then
local buffList_lookup=netData.buffList or{}
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

function UIBenYuanZhenJiWin:freshMoJieShiLiItem()
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



function UIBenYuanZhenJiWin:freshMoJieSkillPnael()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
local monsterData=xianjieModel:getBenYuanZhenJiDataByBuildId(self.season_id,self.chapter_idx,self.build_id)
if isopen then
if monsterData==nil then return end
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

function UIBenYuanZhenJiWin:onUseMoJiSkillbtn()
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
local monsterData=xianjieModel:getBenYuanZhenJiDataByBuildId(self.season_id,self.chapter_idx,self.build_id)
if monsterData==nil then return end
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
local build_id=self.build_id
local actorid=int64.new(tostring(build_id))

local _fun=function()
xianjieController:useMoJieShiLiSkill(actorid)
self:closeSelf()
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

function UIBenYuanZhenJiWin:serverMoJiSkill()
if _this==nil then return end
_this:CheckUseMoJiSkillTime()
end

function UIBenYuanZhenJiWin:CheckUseMoJiSkillTime()
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
function UIBenYuanZhenJiWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end
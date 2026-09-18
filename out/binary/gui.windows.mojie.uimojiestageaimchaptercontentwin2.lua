







def_class("UIMoJieStageAimChapterContentWin2",UIWindowBase)









function UIMoJieStageAimChapterContentWin2:bindComponents()

self.background=UIImage.get(self,0)
self.bossList=UIObject.get(self,1)
self.finishImg=UIObject.get(self,2)
self.jumpBtn=UIButton.get(self,3)
self.mainTask=UIObject.get(self,4)
self.mainTaskTxt=UIText.get(self,5)
self.stagePassLevelRewardList=UIObject.get(self,6)
self.storyBg=UIObject.get(self,7)
self.storyTx=UIText.get(self,8)
self.storyTx2=UIText.get(self,9)
self.tipsTx=UIText.get(self,10)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UIMoJieStageAimChapterContentWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bossList);self.bossList=nil;
_UIObject_release(self.finishImg);self.finishImg=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.mainTask);self.mainTask=nil;
_UIObject_release(self.mainTaskTxt);self.mainTaskTxt=nil;
_UIObject_release(self.stagePassLevelRewardList);self.stagePassLevelRewardList=nil;
_UIObject_release(self.storyBg);self.storyBg=nil;
_UIObject_release(self.storyTx);self.storyTx=nil;
_UIObject_release(self.storyTx2);self.storyTx2=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end

















local _this



function UIMoJieStageAimChapterContentWin2:onLoaded(...)
self:bindComponents()

_this=self

self.mojiangOpenTimerList={}

self:addProNotify(39,2,self.on_39_2)
self:addProNotify(39,3,self.on_39_3)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)

self:addProNotify(39,11,self.on_39_11)
self:addProNotify(39,10,self.on_39_10)
end


function UIMoJieStageAimChapterContentWin2:__delete()
_this=nil

self:stopAllMoJiangOpenTime()
self:stopOpenTimer()

self:unbindComponents()
end




function UIMoJieStageAimChapterContentWin2:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handleType=self.showParams.handleType
self.stageIdx=self.showParams.stageIdx
self.stageHandle=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)
self.winArgs=self.stageCfg.winArgs

self:refreshAll()
end


function UIMoJieStageAimChapterContentWin2:onHide()

end





function UIMoJieStageAimChapterContentWin2:onJumpBtn()
if not self.stageHandle:isOverBegin()then
local beginTime=self.stageHandle.beginTime
local stageName=self.stageCfg.name
local serverTime=timeHelper.getServerShortTime()
local left=beginTime-serverTime
UIManager.info(FMT.fmt("{0}章节将于{1}后开启",stageName,timeHelper.format_time_stamp4(left)))
return
end

local limitGK=self.winArgs.jumpBtn.limitGK
if limitGK then
local passGK=xianjieModel:getMoJieGateSelfXMCanPassAnyGateId()
if passGK==nil then
UIManager.info("所在仙域本阵的关口要塞未开放，无法前往")
seasonController:jumpGate()
return
end
end

local jumpParams=self.winArgs.jumpBtn.jump
if jumpParams==nil then return end
jumpManager:jump(jumpParams)
end


function UIMoJieStageAimChapterContentWin2:refreshAll()

self:initActiveData()

self:freshBackGround()
self:freshBossList()
self:freshJumpBtn()
self:freshMidTips()
self:freshMainTask()
self:freshFinishImg()
self:refreshStagePassLevelRewardPart()

self:activeObjects()

end


function UIMoJieStageAimChapterContentWin2:initActiveData()



self.isShowBg=self.winArgs.backgroundImage~=nil
self.isShowBossList=true
self.isShowJumpBtn=self.winArgs.jumpBtn~=nil
self.isShowMidTips=true
self.isShowMaintask=self.stageCfg.passLevelCondition~=nil


self.isShowFinishImg=self.stageHandle:isFinish()
end

function UIMoJieStageAimChapterContentWin2:activeObjects()
self.background:setActive(self.isShowBg)
self.bossList:setActive(self.isShowBossList)
self.jumpBtn:setActive(self.isShowJumpBtn)
self.tipsTx:setActive(self.isShowMidTips)
self.mainTask:setActive(self.isShowMaintask)
self.finishImg:setActive(self.isShowFinishImg)
end


function UIMoJieStageAimChapterContentWin2:freshBackGround()
if not self.isShowBg then return end

local imageCfg=self.winArgs.backgroundImage
self.background:setSprite(imageCfg[1],imageCfg[2])
end

local MoJiangStateEnum={
eNone=0,
eLock=1,
eDoing=2,
eKill=3,
}

local CmpMoJiangItemindex={
name=0,
head=1,
hpbg=2,
hpbar=3,
hptxt=4,
tip=5,
recvImg=6,
reddot=7,
}

function UIMoJieStageAimChapterContentWin2:freshBossList()
local mojiang=self.stageCfg.mojiang
local tempMoJiang={}

for index,mjInfo in pairs(mojiang)do
tempMoJiang[#tempMoJiang+1]={bdid=index,mjInfo=mjInfo}
end

table.sort(tempMoJiang,function(a,b)
return a.mjInfo.open<b.mjInfo.open
end)

local mjLen=#tempMoJiang

local curTime=timeHelper.getServerShortTime()
local stageBeginTime=self.stageHandle.beginTime

self.bossList:setChildLayoutGroupCreateItems(mjLen,function(index)
local item=_this.bossList:getChildLayoutGroupGridItem(index-1)
local data=tempMoJiang[index]


local monster_group=data.mjInfo.monster[1]
local monster_group_cfg=cfgHelper.get1(cfg_monstergroup_get,monster_group)

comHelper.setChildModelRawImage_monsterGroup(item,monster_group,CmpMoJiangItemindex.head,0,eHeadCenterType.eHead)
item:SetChildText(CmpMoJiangItemindex.name,monster_group_cfg.name)


local isOpen=stageBeginTime+data.mjInfo.open<=curTime

local bossEntity=xianjieModel:getMoJiangEntity(_this.showParams.handleType,_this.showParams.stageIdx,data.bdid)
local isReceived=bossEntity and bossEntity.challenge==1 or false
local cnt=math.max(data.mjInfo.times-bossEntity.fightTimes,0)


local state=_this:getMoJiangState(data)

local isShowHp=state==MoJiangStateEnum.eDoing and bossEntity~=nil
local isShowTips=state==MoJiangStateEnum.eLock or(state==MoJiangStateEnum.eKill and(not isReceived))
local hasCnt=limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJiang)and cnt>0 and state~=MoJiangStateEnum.eKill
local isShowReddot=isOpen and bossEntity and(bossEntity:checkRewardReddot()or hasCnt)or false

item:SetChildActive(CmpMoJiangItemindex.hpbg,isShowHp)
item:SetChildActive(CmpMoJiangItemindex.tip,isShowTips)
item:SetChildActive(CmpMoJiangItemindex.recvImg,isReceived)
item:SetChildActive(CmpMoJiangItemindex.reddot,isShowReddot)
item:SetChildActive(CmpMoJiangItemindex.hptxt,isShowHp)

if isShowHp then
local curHp=bossEntity.hp
item:SetChildIconFillAmount(CmpMoJiangItemindex.hpbar,curHp/10000)
local val=mathHelper.safe_floor(curHp*100)/10000
item:SetChildText(CmpMoJiangItemindex.hptxt,string.format("%0.2f%%",val))
end

if isShowTips then
if not isReceived and state==MoJiangStateEnum.eKill then
item:SetChildText(CmpMoJiangItemindex.tip,'已击败')
elseif not isOpen then

_this:startMoJiangOpenTime(item,index,data,stageBeginTime)
end
end

item:SetBaseItemClickEvent(-1,function()

state=_this:getMoJiangState(data)

if state==MoJiangStateEnum.eNone then
local beginTime=self.stageHandle.beginTime
local stageName=self.stageCfg.name
local serverTime=timeHelper.getServerShortTime()
local left=beginTime-serverTime
UIManager.info(FMT.fmt("{0}章节将于{1}后开启",stageName,timeHelper.format_time_stamp4(left)))
return
elseif state==MoJiangStateEnum.eLock then
local time=timeHelper.getServerShortTime()
local left=(stageBeginTime+data.mjInfo.open)-time
UIManager.info(FMT.fmt("{0}将在{1}后开放",monster_group_cfg.name,timeHelper.format_time_stamp4(left)))
return
end

local passGK=xianjieModel:getMoJieGateSelfXMCanPassAnyGateId()
if passGK==nil then
UIManager.info("所在仙域本阵的关口要塞未开放，无法前往")
return
end

local content=FMT.fmt("是否前往征讨{0}",monster_group_cfg.name)

local jumpFunc=function()
jumpManager:jump(
{
id=JUMP_TYPE.eMoJiang,
args={
seasonType=_this.showParams.handleType,
stageIndex=_this.showParams.stageIdx,
build_id=data.bdid
}})
end

if state==MoJiangStateEnum.eKill then
jumpFunc()
return
end

local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=jumpFunc,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end)
end)
end

function UIMoJieStageAimChapterContentWin2:getMoJiangState(data)

local curTime=timeHelper.getServerShortTime()
local stageBeginTime=self.stageHandle.beginTime

local isOpen=stageBeginTime+data.mjInfo.open<=curTime

local bossEntity=xianjieModel:getMoJiangEntity(_this.showParams.handleType,_this.showParams.stageIdx,data.bdid)

local state=MoJiangStateEnum.eNone

if bossEntity and bossEntity.killTime>0 then
state=MoJiangStateEnum.eKill
elseif isOpen then
state=MoJiangStateEnum.eDoing
else
state=MoJiangStateEnum.eLock
end

return state
end

function UIMoJieStageAimChapterContentWin2:startMoJiangOpenTime(item,index,data,stageBeginTime)
self:stopMoJiangOpenTime(index)

local curTime=timeHelper.getServerShortTime()
local entTime=stageBeginTime+data.mjInfo.open
local leftTime

local func=function()
curTime=timeHelper.getServerShortTime()
leftTime=entTime-curTime
item:SetChildText(CmpMoJiangItemindex.tip,FMT.fmt("{0}后开放",timeHelper.format_time_stamp3(leftTime)))
if leftTime<=0 then
_this:stopMoJiangOpenTime(index)
end
end

self.mojiangOpenTimerList[index]=self:setTimer(1,0,func)
func()
end

function UIMoJieStageAimChapterContentWin2:stopMoJiangOpenTime(index)
local timer=self.mojiangOpenTimerList[index]
if timer then
self:stopTimerByID(timer)
self.mojiangOpenTimerList[index]=nil
end
end

function UIMoJieStageAimChapterContentWin2:stopAllMoJiangOpenTime()
for index,timer in pairs(self.mojiangOpenTimerList)do
self:stopTimerByID(timer)
self.mojiangOpenTimerList[index]=nil
end
end

function UIMoJieStageAimChapterContentWin2:freshJumpBtn()
local isGray=not self.stageHandle:isOverBegin()
self.jumpBtn:setGray(isGray)
end

local _attachmentArgsTips=function(args)
local type=args[1]
local tips=args[2]
if type==0 then return tips end

if type==1 then
return FMT.fmt(tips,_this.stageHandle.chapterScore)
end
end
function UIMoJieStageAimChapterContentWin2:freshMidTips()
if not xianmengModel:hasXM()then
self.tipsTx:setText('暂无仙盟')
return
end

local stageState=self.stageHandle:getState()

local tipStr
if stageState==eSeasonStageStateEnum.eUnLock then
self:startOpenTimer()
elseif stageState==eSeasonStageStateEnum.eDoing then
tipStr=_attachmentArgsTips(self.winArgs.recordStr)
elseif stageState==eSeasonStageStateEnum.eFinish then
tipStr=_attachmentArgsTips(self.winArgs.finishStr)
end

if tipStr then
self.tipsTx:setText(tipStr)
end
end

function UIMoJieStageAimChapterContentWin2:startOpenTimer()
self:stopOpenTimer()

local curTime=timeHelper.getServerShortTime()
local beginTime=self.stageHandle.beginTime

local strFmt=self.winArgs.openPreStr

local func=function()
curTime=timeHelper.getServerShortTime()
local left=beginTime-curTime
local timeStr=timeHelper.format_time_stamp4(left)
local infoStr=FMT.fmt(strFmt,timeStr)
_this.tipsTx:setText(infoStr)

if left<0 then
_this:stopOpenTimer()
_this:refreshAll()
end
end

self.openTimer=self:setTimer(1,0,func)
func()
end

function UIMoJieStageAimChapterContentWin2:stopOpenTimer()
if self.openTimer then
self:stopTimerByID(self.openTimer)
self.openTimer=nil
end
end
function UIMoJieStageAimChapterContentWin2:freshMainTask()
local passLevelCondition=self.stageCfg.passLevelCondition

local limitVal=Mathf.Min(self.stageHandle.chapterScore,passLevelCondition.max)
local str=FMT.fmt("{0}  {1}/{2}",passLevelCondition.desc,limitVal,passLevelCondition.max)

self.mainTaskTxt:setText(str)
end
function UIMoJieStageAimChapterContentWin2:freshFinishImg()
end

function UIMoJieStageAimChapterContentWin2:refreshStagePassLevelRewardPart()
local passStageReward=self.stageCfg.passStageReward

local len=#passStageReward

local isFinish=self.stageHandle:isFinish()
local isReceived=self.stageHandle.pass_rw_flag==1
local isCanRecv=isFinish and(not isReceived)

local createFunc=function(index)
if _this==nil then return end

local item=_this.stagePassLevelRewardList:getChildLayoutGroupGridItem(index-1)
local data=passStageReward[index]

local itemid=data[1]
local itemnum=data[2]
local showCountBG=itemnum>1
local itemcount=showCountBG and itemnum or""
local graynum=isReceived and 1 or 0

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)

item:SetChildActive(1,isCanRecv)
item:SetChildActive(2,isReceived)

item:SetBaseItemClickEvent(0,function()
if isCanRecv then
seasonController:send_39_2(self.showParams.handleType,self.showParams.stageIdx,1)
else
itemsComponentHelper.onItemClick(itemid)
end
end)
end

self.stagePassLevelRewardList:setChildLayoutGroupCreateItems(len,createFunc)

end




function UIMoJieStageAimChapterContentWin2.on_39_2(season_id,chapter_idx,param1,param2)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin2.on_39_3(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin2.on_39_11(seasonType,stageIndex,build_id,hp)
if seasonType==_this.handleType and stageIndex==_this.stageIdx and _this.stage then
_this:freshBossList()
end
end

function UIMoJieStageAimChapterContentWin2.on_39_10(seasonType,stageIndex,build_id,damage)
if seasonType==_this.handleType and stageIndex==_this.stageIdx and _this.stage then
_this:freshBossList()
end
end

function UIMoJieStageAimChapterContentWin2.onSeasonChange()
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()

end

function UIMoJieStageAimChapterContentWin2.onSeasonStageChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end

function UIMoJieStageAimChapterContentWin2.onSeasonStageDataChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end


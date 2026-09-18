







def_class("UIXJCaravanEscort_mainWin",UIWindowBase)









function UIXJCaravanEscort_mainWin:bindComponents()

self.escortPanel=UIObject.get(self,0)
self.escortShipGroup=UIObject.get(self,1)
self.plunderPanel=UIObject.get(self,2)
self.plunderShipGroup=UIObject.get(self,3)
self.btnClose=UIButton.get(self,4)
self.pageBtnGroup=UIObject.get(self,5)
self.recordBtn=UIButton.get(self,6)
self.inviteBtn=UIButton.get(self,7)
self.refreshBtn=UIButton.get(self,8)
self.robCountText=UIText.get(self,9)
self.isHideXYNotSelect=UIImage.get(self,10)
self.isHideXYSelect=UIImage.get(self,11)
self.isHideXYBtn=UIButton.get(self,12)
self.escortCountText=UIText.get(self,13)
self.notShipTips=UIObject.get(self,14)
self.helpBtn=UIButton.get(self,15)
self.escortTipsText=UIText.get(self,16)
self.robTipsText=UIText.get(self,17)
self.escortBgModel=UIObject.get(self,18)
self.bgModel=UIObject.get(self,19)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.inviteBtn:setButtonClick(function()self:onInviteBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.isHideXYBtn:setButtonClick(function()self:onIsHideXYBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIXJCaravanEscort_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.escortPanel);self.escortPanel=nil;
_UIObject_release(self.escortShipGroup);self.escortShipGroup=nil;
_UIObject_release(self.plunderPanel);self.plunderPanel=nil;
_UIObject_release(self.plunderShipGroup);self.plunderShipGroup=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.pageBtnGroup);self.pageBtnGroup=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.inviteBtn);self.inviteBtn=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.robCountText);self.robCountText=nil;
_UIObject_release(self.isHideXYNotSelect);self.isHideXYNotSelect=nil;
_UIObject_release(self.isHideXYSelect);self.isHideXYSelect=nil;
_UIObject_release(self.isHideXYBtn);self.isHideXYBtn=nil;
_UIObject_release(self.escortCountText);self.escortCountText=nil;
_UIObject_release(self.notShipTips);self.notShipTips=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.escortTipsText);self.escortTipsText=nil;
_UIObject_release(self.robTipsText);self.robTipsText=nil;
_UIObject_release(self.escortBgModel);self.escortBgModel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local pageCfgList={
[1]={
name="护送",
pageType=1,
},
[2]={
name="掠夺",
pageType=2,
},
}

local escortShipItemCmpIndex={
unlockPanel=0,
shipModelPos=1,
timeBg=2,
timeText=3,
lock=4,
click=5,
rewardFlag=6,
anchorModel=7,
}

local plunderShipItemCmpIndex={
shipModelPos=0,
headIcon=1,
playerName=2,

xyName=3,
click=4,
playerInfo=5,
}
local colorImgName={
[1]="frame_tydaojupinjikuan_3",
[2]="frame_tydaojupinjikuan_4",
[3]="frame_tydaojupinjikuan_6",
[4]="frame_tydaojupinjikuan_5",
[5]="frame_tydaojupinjikuan_2",
[6]="frame_tydaojupinjikuan_1",
}

local shipModelIdList={
[1]=6338,
[2]=6339,
[3]=6340,
[4]=6341,
[5]=6342,
}

local shipModelAnimIdList_idle={
[0]=3491,
[1]=3492,
[2]=3493,
}

local shipModelAnimIdList_yun={
[0]=3494,
[1]=3495,
[2]=3496,
}

local shipAnchorModelIdList={
[1]=6347,
[2]=6348,
[3]=6349,
[4]=6350,
}

local shipEffectIdList={
[1]=22681,
[2]=22680,
}

local shipModelInstance={
[1]=INSTANCE_TYPE.eUICEShipItem1,
[2]=INSTANCE_TYPE.eUICEShipItem2,
[3]=INSTANCE_TYPE.eUICEShipItem3,
[4]=INSTANCE_TYPE.eUICEShipItem4,
[5]=INSTANCE_TYPE.eUICEShipItem5,
}

local _this



function UIXJCaravanEscort_mainWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onXJCaravanEscortSelfShipFinish,self.onXJCaravanEscortSelfShipFinish)
self:addNotify(notifyConfig.onXJCaravanEscortCanDispatchTimeEnd,self.onXJCaravanEscortCanDispatchTimeEnd)
self:addNotify(notifyConfig.onXJCaravanEscortRobCountChange,self.onXJCaravanEscortRobCountChange)
end


function UIXJCaravanEscort_mainWin:__delete()
_this=nil
self:clearEscortTimer()
self:clearTopTipsTimer()
self:clearAllShipModel()
self:unbindComponents()
end




function UIXJCaravanEscort_mainWin:onShow(argtable,afterOnloaded)
self.selectPageIdx=argtable and argtable.selectPageIdx or 1
local openMsgPosIdx=argtable and argtable.openMsgPosIdx
local openMsgShipGuid=argtable and argtable.openMsgShipGuid
local openRecordWin=argtable and argtable.openRecordWin
if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(6337,1,{},eAnimationID.stand)
self.escortBgModel:setChildUIModelShowTarget(6336,1,{},eAnimationID.stand)
end
self.shipModelList={}

self:refresh(true)

if self.selectPageIdx==1 then
if openMsgPosIdx then

self:onClickEscortShip(openMsgPosIdx,openRecordWin)
elseif openMsgShipGuid then

self:onClickEscortShipByShipGuid(openMsgShipGuid,openRecordWin)
end
elseif self.selectPageIdx==2 and openMsgShipGuid then
self:onClickPlunderShip(openMsgShipGuid)
elseif openRecordWin then
self:onRecordBtn()
end
end


function UIXJCaravanEscort_mainWin:onHide()
self:clearEscortTimer()
self:clearTopTipsTimer()
self:clearAllShipModel()
end

function UIXJCaravanEscort_mainWin:refresh(isInit)

self:refreshPageBtnGroup()


self:refreshPage(isInit)


self:refreshBtnList()
end

function UIXJCaravanEscort_mainWin:refreshPageBtnGroup()
local pageList=pageCfgList
local pageCount=#pageList

self.pageBtnGroup:setChildLayoutGroupCreateItems(pageCount,function(index)
local widget=self.pageBtnGroup:getChildLayoutGroupGridItem(index-1)
local isSelect=self.selectPageIdx==index
widget:SetChildActive(0,not isSelect)
widget:SetChildActive(1,isSelect)

local pageCfg=pageCfgList[index]
local name=pageCfg and pageCfg.name or"未知页签"
widget:SetChildText(2,name)

widget:SetChildButtonClick(-1,function()
return self:onClickPageBtn(index)
end,true)

local reddot=false
local pageType=pageCfg.pageType
if pageType==1 then
reddot=xianJieCaravanEscortModel:checkSelfEscortShipPosHasReward()or xianJieCaravanEscortModel:checkSelfEscortShipPosHasNotGoShip()
elseif pageType==2 then
reddot=xianJieCaravanEscortModel:checkHasRemainingRobCount()
end
widget:SetChildActive(3,reddot)
end)
end

function UIXJCaravanEscort_mainWin:refreshPageBtnReddot()
local grids=self.pageBtnGroup:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
local pageCfg=pageCfgList[i]
if pageCfg then
local pageType=pageCfg.pageType
local reddot=false
if pageType==1 then
reddot=xianJieCaravanEscortModel:checkSelfEscortShipPosHasReward()or xianJieCaravanEscortModel:checkSelfEscortShipPosHasNotGoShip()
elseif pageType==2 then
reddot=xianJieCaravanEscortModel:checkHasRemainingRobCount()
end
widget:SetChildActive(3,reddot)
end
end
end

function UIXJCaravanEscort_mainWin:refreshPage(isInit)
local pageCfg=pageCfgList[self.selectPageIdx]
local pageType=pageCfg.pageType


self:refreshTopTips()

self.escortPanel:setActive(pageType==1)
self.plunderPanel:setActive(pageType==2)
if pageType==1 then
self:refreshEscortPanel(isInit)
elseif pageType==2 then
self:refreshPlunderPanel(nil,isInit)
end
end

function UIXJCaravanEscort_mainWin:refreshPageByPageIdx(pageIndex)
if not pageIndex or pageIndex==self.selectPageIdx then
return self:refreshPage()
end
end

function UIXJCaravanEscort_mainWin:refreshBtnList()
local pageCfg=pageCfgList[self.selectPageIdx]
local pageType=pageCfg.pageType


self.recordBtn:setActive(true)


local isCanInvite=false
self.inviteBtn:setActive(pageType==1 and isCanInvite)


self.refreshBtn:setActive(pageType==2)
end


function UIXJCaravanEscort_mainWin:refreshEscortPanel(isInit)
local pageType=1
self:clearEscortTimer()

local grids=self.escortShipGroup:getChildCommonLayoutGroupWidgetList()
local selfEscortData=xianJieCaravanEscortModel:getSelfEscortData()
local shipPosDataList=selfEscortData and selfEscortData.shipPosDataList or nil
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)

local maxEscortNum=baseCfg and baseCfg.daily_times or 0
local curEscortNum=selfEscortData and selfEscortData.getTimes or 0
local showRemainingNum=maxEscortNum-curEscortNum
if showRemainingNum<0 then
showRemainingNum=0
end
self.escortCountText:setText(FMT.fmt("本期护送次数：{0}/{1}",showRemainingNum,maxEscortNum))
self.yunShuStatePosList={}




local needTimer=false
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildActive(-1,true)

local isUnlock=xianJieCaravanEscortModel:checkEscortShipPosIsUnlock(i)
widget:SetChildActive(escortShipItemCmpIndex.unlockPanel,isUnlock)
widget:SetChildActive(escortShipItemCmpIndex.lock,not isUnlock)

if isInit then

local anchorModelId=shipAnchorModelIdList[i]
widget:SetChildUIModelShowTarget(escortShipItemCmpIndex.anchorModel,anchorModelId,1,{},eAnimationID.stand)
end


widget:SetChildButtonClick(escortShipItemCmpIndex.click,function()

return self:onClickEscortShip(i)
end,true)

if isUnlock then
local posData=shipPosDataList and shipPosDataList[i]or nil
if posData then
local posBaseData=posData.xianzhouStruct
local shipId=posBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local color=shipId
local endTime


local isShowTime=false
local isMoving=false
local startTime=posBaseData.start_sec or 0
if startTime and startTime>0 then
endTime=startTime+duration
if nowTime<endTime then
isShowTime=true
needTimer=true
isMoving=true
end
else
isShowTime=true
end

widget:SetChildActive(escortShipItemCmpIndex.timeBg,isShowTime)
widget:SetChildActive(escortShipItemCmpIndex.anchorModel,not isMoving)

if isShowTime then
if isMoving then
local lerp=endTime-nowTime
widget:SetChildText(escortShipItemCmpIndex.timeText,FMT.cfmt1(FONT_COLOR.eGreenColor,"护送中:{0}",timeHelper.format_time_stamp(lerp)))
else
widget:SetChildText(escortShipItemCmpIndex.timeText,FMT.fmt("护送时间:{0}",timeHelper.format_time_stamp(duration)))
end
end















local animId=eAnimationID.stand
if isMoving then
self.yunShuStatePosList[i]=true

else
self.yunShuStatePosList[i]=nil

end

local shipModelPosTarn=widget:GetChildGameObject(escortShipItemCmpIndex.shipModelPos).transform

local robbedTimes=posBaseData and posBaseData.robbed_times or 0
local shipEffectId=shipEffectIdList[robbedTimes]or nil
local shipMoveEffectId=isMoving and 22682 or nil
self:instantiateShipModel(color,shipModelPosTarn,pageType,i,shipEffectId,shipMoveEffectId,0.36,animId,isMoving)



















local isFinish=endTime and nowTime>=endTime or false
widget:SetChildActive(escortShipItemCmpIndex.rewardFlag,isFinish)
end
else
widget:SetChildActive(-1,false)
end
else
widget:SetChildActive(escortShipItemCmpIndex.anchorModel,false)
end
end

if needTimer then
self:setEscortTimer()
end
end

function UIXJCaravanEscort_mainWin:refreshEscortPanel_updateTimer()
local pageType=1
local grids=self.escortShipGroup:getChildCommonLayoutGroupWidgetList()
local selfEscortData=xianJieCaravanEscortModel:getSelfEscortData()
local shipPosDataList=selfEscortData and selfEscortData.shipPosDataList or nil
local needTimer=false
local nowTime=timeHelper.getServerShortTime()
local hasChangeFinishState=false
for i=1,grids.Count do
local widget=grids[i-1]
local isUnlock=xianJieCaravanEscortModel:checkEscortShipPosIsUnlock(i)
if isUnlock then
local posData=shipPosDataList and shipPosDataList[i]or nil
if posData then
local posBaseData=posData.xianzhouStruct
local shipId=posBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local endTime


local isShowTime=false
local isMoving=false
local startTime=posBaseData.start_sec or 0
if startTime and startTime>0 then
endTime=startTime+duration
if nowTime<endTime then
isShowTime=true
needTimer=true
isMoving=true
end
else
isShowTime=true
end

widget:SetChildActive(escortShipItemCmpIndex.timeBg,isShowTime)
widget:SetChildActive(escortShipItemCmpIndex.anchorModel,not isMoving)
if isShowTime then
if isMoving then
local lerp=endTime-nowTime
widget:SetChildText(escortShipItemCmpIndex.timeText,FMT.cfmt1(FONT_COLOR.eGreenColor,"护送中:{0}",timeHelper.format_time_stamp(lerp)))
else
widget:SetChildText(escortShipItemCmpIndex.timeText,FMT.fmt("护送时间:{0}",timeHelper.format_time_stamp(duration)))
end
end


local isFinish=endTime and nowTime>=endTime or false
widget:SetChildActive(escortShipItemCmpIndex.rewardFlag,isFinish)
if isFinish and nowTime-endTime<=1 then
hasChangeFinishState=true
end

if isFinish and self.yunShuStatePosList and self.yunShuStatePosList[i]then

local color=shipId
local modelId=shipModelIdList[color]
local robbedTimes=posBaseData and posBaseData.robbed_times or 0

local animId=eAnimationID.stand

local shipEffectId=shipEffectIdList[robbedTimes]or nil
local shipMoveEffectId=isMoving and 22682 or nil
self.yunShuStatePosList[i]=nil

self:changeShipModelState(pageType,i,shipEffectId,shipMoveEffectId,animId,false)
end
end
end
end
end

if hasChangeFinishState then
self:refreshPageBtnReddot()
end

if not needTimer then
self:clearEscortTimer()
end
end


function UIXJCaravanEscort_mainWin:refreshPlunderPanel(isReset,isInit)
local pageType=2
self:clearEscortTimer()
local selfEscortData=xianJieCaravanEscortModel:getSelfEscortData()
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)

local maxRobNum=baseCfg and baseCfg.rob_times or 0
local curRobNum=selfEscortData and selfEscortData.robTimes or 0
local showRemainingNum=maxRobNum-curRobNum
if showRemainingNum<0 then
showRemainingNum=0
end
self.robCountText:setText(FMT.fmt("本期掠夺次数：{0}/{1}",showRemainingNum,maxRobNum))





local isHideSelfXianYuShip=xianJieCaravanEscortModel:getCaravanEscortPlunderIsHideXianYu()
self.isHideXYNotSelect:setActive(not isHideSelfXianYuShip)
self.isHideXYSelect:setActive(isHideSelfXianYuShip)


local plunderShipKeyList=xianJieCaravanEscortModel:getPlunderShipRandomKeyList(isHideSelfXianYuShip,isReset)
self.showPlunderShipListCount=#plunderShipKeyList
self.hidePlunderShipLookup={}
self.hidePlunderShipCount=0
local selfHasXM=xianmengModel:hasXM()
local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
local grids=self.plunderShipGroup:getChildCommonLayoutGroupWidgetList()
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local guidStr=plunderShipKeyList[i]
local shipData=guidStr and xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)or nil
if shipData then
local shipBaseData=shipData.xianzhouStruct
local shipId=shipBaseData.xianzhou_id
local shipGuid=shipBaseData.xianzhou_guid


local xmData=shipData.guildInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local isSelfXm=false
if selfXMGuid and xmGuid and mathHelper.compareInt64(xmGuid,selfXMGuid)then
isSelfXm=true
end


local isExpire=false
local isMoving=false
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local startTime=shipBaseData.start_sec or 0
isExpire=startTime>0 and nowTime>=(startTime+duration)or false
isMoving=startTime>0 and nowTime<(startTime+duration)or false
end

local isHideShip=isExpire or isSelfXm
if not isHideShip then
widget:SetChildActive(-1,true)

local color=shipId
local modelId=shipModelIdList[color]
local animId=eAnimationID.stand
local robbedTimes=shipBaseData and shipBaseData.robbed_times or 0
if isMoving then

else

end


local shipModelPosTarn=widget:GetChildGameObject(plunderShipItemCmpIndex.shipModelPos).transform

local shipEffectId=shipEffectIdList[robbedTimes]or nil
local shipMoveEffectId=isMoving and 22682 or nil
self:instantiateShipModel(color,shipModelPosTarn,pageType,i,shipEffectId,shipMoveEffectId,0.27,animId,isMoving)


local isShowPlayerInfo=true
widget:SetChildActive(plunderShipItemCmpIndex.playerInfo,isShowPlayerInfo)
if isShowPlayerInfo then









local sceneIdx=shipData.scene_idx

local xyNameStr=xianjieController:getCrossServerNamebySCidx(sceneIdx)
widget:SetChildText(plunderShipItemCmpIndex.xyName,xyNameStr)


local playerName=shipData.name
widget:SetChildText(plunderShipItemCmpIndex.playerName,playerName)


local iconInfo=shipData.iconInfo
playerController:setHeadIcon(widget,plunderShipItemCmpIndex.headIcon,{iconInfo=iconInfo,scale=0.62})
end


widget:SetChildButtonClick(plunderShipItemCmpIndex.click,function()

return self:onClickPlunderShip(shipGuid)
end,true)
else
local shipGuidStr=tostring(shipGuid)
self.hidePlunderShipLookup[shipGuidStr]=true
self.hidePlunderShipCount=self.hidePlunderShipCount+1
widget:SetChildActive(-1,false)
end
else
widget:SetChildActive(-1,false)
end
end

local isShowEmptyTips=self.showPlunderShipListCount<=0 or self.hidePlunderShipCount>=self.showPlunderShipListCount
self.notShipTips:setActive(isShowEmptyTips)

if isInit and self.showPlunderShipListCount>0 and self.hidePlunderShipCount>=self.showPlunderShipListCount then

return self:onRefreshBtn()
end
end

function UIXJCaravanEscort_mainWin:setEscortTimer()
self:clearEscortTimer()
local func=function()
return self:refreshEscortPanel_updateTimer()
end
self.escortTimer=self:setTimer(1,0,func)
func()
end

function UIXJCaravanEscort_mainWin:clearEscortTimer()
if self.escortTimer then
self:stopTimerByID(self.escortTimer)
self.escortTimer=nil
end
end

function UIXJCaravanEscort_mainWin:refreshTopTips()
self:clearTopTipsTimer()
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)

local nowTime=timeHelper.getServerShortTime()
local canDispatchEndTime=xianJieCaravanEscortModel:getXJCaravanEscortActCanDispatchEndTime()
local dayStr="今日"
local needTimer=false
local zeroTime
if canDispatchEndTime then
zeroTime=timeHelper.getServerZeroShortStamp(canDispatchEndTime)
if nowTime<zeroTime then
dayStr="次日"
needTimer=true
end
end

local topTipsStr_escort=FMT.fmt("{0}{1}",dayStr,baseCfg.winTopTips[1])
self.escortTipsText:setText(topTipsStr_escort)

local topTipsCfgStr_rob=FMT.fmt("{0}{1}",dayStr,baseCfg.winTopTips[2])
self.robTipsText:setText(topTipsCfgStr_rob)

if needTimer then
self.refreshTopTipsTime=zeroTime
self:setTopTipsTimer()
end
end

function UIXJCaravanEscort_mainWin:setTopTipsTimer()
self:clearTopTipsTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
local isChangeState=self.refreshTopTipsTime and nowTime>=self.refreshTopTipsTime or false
if isChangeState then
return self:refreshTopTips()
end
end
self.topTipsTimer=self:setTimer(1,0,func)
func()
end

function UIXJCaravanEscort_mainWin:clearTopTipsTimer()
if self.topTipsTimer then
self:stopTimerByID(self.topTipsTimer)
self.topTipsTimer=nil
end
end


function UIXJCaravanEscort_mainWin:instantiateShipModel(color,parentTarn,pageType,idx,shipEffectId,shipMoveEffectId,scale,animId,isShowCloud)
scale=scale or 1
animId=animId or eAnimationID.stand
isShowCloud=isShowCloud or false
if not self.shipModelList[pageType]then
self.shipModelList[pageType]={}
end
local shipModelData=self.shipModelList[pageType][idx]
if not shipModelData or shipModelData.color~=color then
local instanceType=shipModelInstance[color]

if shipModelData then
local oldRid=shipModelData.rid
_InstantiateManager.RemoveInstance(oldRid)
end

local rid=_InstantiateManager.AddInstance(instanceType,parentTarn,function(_id)
local modelWidget=_InstantiateManager.GetComponent(_id,'CSGUIWidgetBase')

modelWidget:SetChildScale(3,Vector3.New(scale,scale,scale))
modelWidget:SetChildActive(3,true)


modelWidget:SetChildSpineAnimation(0,animId,1,nil)


modelWidget:SetChildActive(4,isShowCloud)
if isShowCloud then
modelWidget:SetChildSpineAnimation(4,3494,1,nil)
end


if shipEffectId then
modelWidget:SetChildShowEffect(1,shipEffectId,true)
else
modelWidget:SetChildShowEffect(1,0,false)
end

if shipMoveEffectId then
modelWidget:SetChildShowEffect(2,shipMoveEffectId,true)
else
modelWidget:SetChildShowEffect(2,0,false)
end
end)

self.shipModelList[pageType][idx]={
rid=rid,
color=color,
animId=animId,
isShowCloud=isShowCloud,
}
elseif shipModelData and(shipModelData.animId~=animId or shipModelData.isShowCloud~=isShowCloud)then
return self:changeShipModelState(pageType,idx,shipEffectId,shipMoveEffectId,animId,isShowCloud)
end
end


function UIXJCaravanEscort_mainWin:changeShipModelState(pageType,idx,shipEffectId,shipMoveEffectId,animId,isShowCloud)
local shipModelData=self.shipModelList[pageType]and self.shipModelList[pageType][idx]
if shipModelData then
local rid=shipModelData.rid
local modelWidget=_InstantiateManager.GetComponent(rid,'CSGUIWidgetBase')
if modelWidget then

modelWidget:SetChildSpineAnimation(0,animId,1,nil)


isShowCloud=isShowCloud or false
modelWidget:SetChildActive(4,isShowCloud or false)
if isShowCloud then
modelWidget:SetChildSpineAnimation(4,3494,1,nil)
end


if shipEffectId then
modelWidget:SetChildShowEffect(1,shipEffectId,true)
else
modelWidget:SetChildShowEffect(1,0,false)
end
if shipMoveEffectId then
modelWidget:SetChildShowEffect(2,shipMoveEffectId,true)
else
modelWidget:SetChildShowEffect(2,0,false)
end
end
self.shipModelList[pageType][idx].animId=animId
end
end

function UIXJCaravanEscort_mainWin:clearAllShipModel()
for pageType,pageModelList in pairs(self.shipModelList)do
for idx,modelData in pairs(pageModelList)do
local rid=modelData.rid
_InstantiateManager.RemoveInstance(rid)
pageModelList[idx]=nil
end
end
end

function UIXJCaravanEscort_mainWin.onLimitActStateChange(actID,actState)
if _this==nil then return end
local flag=actID==LIMIT_ACT_TYPE.eMiaoXingShangLv
if not flag then
return
end

if actState==limitActivitiesModel.actDoingState or actState==limitActivitiesModel.actFinishState then
if actState==limitActivitiesModel.actFinishState then
UIManager.error("活动已结束")
_this:onBtnClose()
end
end
end

function UIXJCaravanEscort_mainWin.onXJCaravanEscortSelfShipFinish(posIdx,shipGuid)
if _this==nil then return end
_this:refreshPageBtnReddot()
end

function UIXJCaravanEscort_mainWin.onXJCaravanEscortCanDispatchTimeEnd()
if _this==nil then return end
_this:refreshPageBtnReddot()
end

function UIXJCaravanEscort_mainWin.onXJCaravanEscortRobCountChange()
if _this==nil then return end
_this:refreshPageBtnReddot()
end




function UIXJCaravanEscort_mainWin:onBtnClose()
UIFullXJCaravanEscortController:closeActiveUI()
end



function UIXJCaravanEscort_mainWin:onRecordBtn()
xianjieController:OpenXianjieMXSLSingleLog()
end



function UIXJCaravanEscort_mainWin:onInviteBtn()
end



function UIXJCaravanEscort_mainWin:onRefreshBtn()

local lastRefreshTime=xianJieCaravanEscortModel:getCaravanEscortRefreshPlunderShipCdTime()
local cd=3
local nowTime=timeHelper.getServerShortTime()
if nowTime<lastRefreshTime+cd then
return UIManager.error("点击过快，请稍后再试")
end

self:refreshPlunderPanel(true)
xianJieCaravanEscortModel:setCaravanEscortRefreshPlunderShipCdTime()

xianJieCaravanEscortController:resetCaravanEscortTeamList()
UIManager.info("刷新成功")
end


function UIXJCaravanEscort_mainWin:onClickPageBtn(index)
if index==self.selectPageIdx then
return
end

self.selectPageIdx=index
return self:refresh()
end

function UIXJCaravanEscort_mainWin:onClickEscortShipByShipGuid(shipGuid,isOpenRecordWin)
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(shipGuid)
local posIdx=posData and posData.pos or nil
if posIdx then
return self:onClickEscortShip(posIdx,isOpenRecordWin)
else
UIManager.error("该仙舟已完成护送，无法查看")
return
end
end

function UIXJCaravanEscort_mainWin:onClickEscortShip(posIdx,isOpenRecordWin)
local isUnlock=xianJieCaravanEscortModel:checkEscortShipPosIsUnlock(posIdx)
if not isUnlock then
UIManager.error("该位置尚未解锁")
return
end

local showType=1
local params={showType=showType,posIdx=posIdx,parentWin=self}
local isFinish=false
local isStart=false
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(posIdx)
if posData then
local posBaseData=posData.xianzhouStruct
local shipGuid=posBaseData.xianzhou_guid
if shipGuid and not mathHelper.compareInt64(shipGuid,Int64_0)then
showType=2
params={showType=showType,guid=shipGuid,parentWin=self}
end

local shipId=posBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local endTime
local startTime=posBaseData.start_sec or 0
if startTime and startTime>0 then
isStart=true
endTime=startTime+duration
local nowTime=timeHelper.getServerShortTime()
isFinish=endTime and nowTime>=endTime or false
end
end
end

if not isFinish then


local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isActDoing then
UIManager.error("不在活动开启时间内")
return
end

if not isStart then

local isInDispatchTime=xianJieCaravanEscortModel:checkIsXJCaravanEscortActCanDispatch()
if not isInDispatchTime then
UIManager.error("不在护送时间段内")
return
end


local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local maxDailyTimes=baseCfg.daily_times
local curGetTimes=xianJieCaravanEscortModel:getSelfEscortData_getTimes()
if curGetTimes>=maxDailyTimes then
UIManager.error("本期已达护送上限")
return
end
end
else




end

params.isOpenRecordWin=isOpenRecordWin
self:showWindow("UIXJCaravanEscort_shipMsgWin",params)
end

function UIXJCaravanEscort_mainWin:onClickPlunderShip(shipGuid)
local showType=2
local params={showType=showType,guid=shipGuid,parentWin=self}
local shipGuidStr=tostring(shipGuid)

local selfHasXM=xianmengModel:hasXM()
local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
local isExpire=false
local isSelfXm=false
local nowTime=timeHelper.getServerShortTime()
local shipData=shipGuid and xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)or nil
if shipData then
local shipBaseData=shipData.xianzhouStruct
local shipId=shipBaseData.xianzhou_id


local xmData=shipData.guildInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
if selfXMGuid and xmGuid and mathHelper.compareInt64(xmGuid,selfXMGuid)then
isSelfXm=true
end


local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
local startTime=shipBaseData.start_sec or 0
isExpire=startTime>0 and nowTime>=(startTime+duration)or false
end
else
isExpire=true
end
local isHideShip=isExpire or isSelfXm
if isHideShip then
if isExpire then
UIManager.error("该仙舟已完成护送，无法查看")
elseif isSelfXm then
UIManager.error("同仙盟仙舟，无法掠夺")
end
if self.hidePlunderShipLookup and not self.hidePlunderShipLookup[shipGuidStr]then

local isHideSelfXianYuShip=xianJieCaravanEscortModel:getCaravanEscortPlunderIsHideXianYu()
local plunderShipKeyList=xianJieCaravanEscortModel:getPlunderShipRandomKeyList(isHideSelfXianYuShip)
local grids=self.plunderShipGroup:getChildCommonLayoutGroupWidgetList()
local isChangeActive=false
for i=1,grids.Count do
local widget=grids[i-1]
local guidStr=plunderShipKeyList[i]
local showShipData=guidStr and xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guidStr)or nil
if showShipData then
local shipBaseData=showShipData.xianzhouStruct
local showShipGuid=shipBaseData.xianzhou_guid
if showShipGuid and mathHelper.compareInt64(showShipGuid,shipGuid)then
isChangeActive=true
self.hidePlunderShipLookup[shipGuidStr]=true
self.hidePlunderShipCount=self.hidePlunderShipCount+1
widget:SetChildActive(-1,false)
break
end
end
end

if isChangeActive then
if self.showPlunderShipListCount and self.hidePlunderShipCount and self.hidePlunderShipCount>=self.showPlunderShipListCount then

self.notShipTips:setActive(true)
end
end
end

return
end

self:showWindow("UIXJCaravanEscort_shipMsgWin",params)
end

function UIXJCaravanEscort_mainWin:onIsHideXYBtn()
local isHide=xianJieCaravanEscortModel:getCaravanEscortPlunderIsHideXianYu()
xianJieCaravanEscortModel:setCaravanEscortPlunderIsHideXianYu(not isHide)

self:refreshPlunderPanel()
end

function UIXJCaravanEscort_mainWin:onHelpBtn()
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local langId
local pageCfg=pageCfgList[self.selectPageIdx]
local pageType=pageCfg.pageType
if pageType==1 then
langId=baseCfg and baseCfg.escortHelpLangId or''
elseif pageType==2 then
langId=baseCfg and baseCfg.plunderHelpLangId or''
end

local d={}
d.title='规则'
d.mode=3
d.name=langId
d.showBlack=true
self:showWindow('UIRuleWin',d)
end

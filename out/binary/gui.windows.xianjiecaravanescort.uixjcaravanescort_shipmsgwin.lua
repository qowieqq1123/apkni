







def_class("UIXJCaravanEscort_shipMsgWin",UIWindowBase)









function UIXJCaravanEscort_shipMsgWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.clickMask=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.otherTeamPanel=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.initiatorTeamPanel=UIObject.get(self,5)
self.initiatorTeamItem=UIObject.get(self,6)
self.chuFaBtn=UIButton.get(self,7)
self.wayTimeText=UIText.get(self,8)
self.leaveBtn=UIButton.get(self,9)
self.leaveWayTimeText=UIText.get(self,10)
self.refreshBtn=UIButton.get(self,11)
self.baodiText=UIText.get(self,12)
self.refreshCost=UIObject.get(self,13)
self.refreshCostIcon=UIImage.get(self,14)
self.refreshCostText=UIText.get(self,15)
self.refreshCostFree=UIObject.get(self,16)
self.getRewardBtn=UIButton.get(self,17)
self.shareBtn=UIButton.get(self,18)
self.gotoBtn=UIButton.get(self,19)
self.shipColor=UIImage.get(self,20)
self.titleName=UIText.get(self,21)
self.changeBtnPanel=UIObject.get(self,22)
self.changeBtn=UIButton.get(self,23)
self.rewardScrollView=UIObject.get(self,24)
self.robBtn=UIButton.get(self,25)
self.robCountText=UIText.get(self,26)
self.shareWayTimeText=UIText.get(self,27)
self.chuFaBtnRoot=UIObject.get(self,28)
self.refreshBtnRoot=UIObject.get(self,29)
self.robBtnRoot=UIObject.get(self,30)
self.shipModelPos=UIObject.get(self,31)
self.baodiBg=UIObject.get(self,32)
self.recordBtn=UIButton.get(self,33)
self.shipEnterEffect=UIObject.get(self,34)
self.shipColorModel=UIObject.get(self,35)
self.rewardEffect=UIObject.get(self,36)
self.rewardInfoBtn=UIButton.get(self,37)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.chuFaBtn:setButtonClick(function()self:onChuFaBtn()end)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.robBtn:setButtonClick(function()self:onRobBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.rewardInfoBtn:setButtonClick(function()self:onRewardInfoBtn()end)



end


function UIXJCaravanEscort_shipMsgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.otherTeamPanel);self.otherTeamPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.initiatorTeamPanel);self.initiatorTeamPanel=nil;
_UIObject_release(self.initiatorTeamItem);self.initiatorTeamItem=nil;
_UIObject_release(self.chuFaBtn);self.chuFaBtn=nil;
_UIObject_release(self.wayTimeText);self.wayTimeText=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.leaveWayTimeText);self.leaveWayTimeText=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.baodiText);self.baodiText=nil;
_UIObject_release(self.refreshCost);self.refreshCost=nil;
_UIObject_release(self.refreshCostIcon);self.refreshCostIcon=nil;
_UIObject_release(self.refreshCostText);self.refreshCostText=nil;
_UIObject_release(self.refreshCostFree);self.refreshCostFree=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.shipColor);self.shipColor=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.changeBtnPanel);self.changeBtnPanel=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.robBtn);self.robBtn=nil;
_UIObject_release(self.robCountText);self.robCountText=nil;
_UIObject_release(self.shareWayTimeText);self.shareWayTimeText=nil;
_UIObject_release(self.chuFaBtnRoot);self.chuFaBtnRoot=nil;
_UIObject_release(self.refreshBtnRoot);self.refreshBtnRoot=nil;
_UIObject_release(self.robBtnRoot);self.robBtnRoot=nil;
_UIObject_release(self.shipModelPos);self.shipModelPos=nil;
_UIObject_release(self.baodiBg);self.baodiBg=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.shipEnterEffect);self.shipEnterEffect=nil;
_UIObject_release(self.shipColorModel);self.shipColorModel=nil;
_UIObject_release(self.rewardEffect);self.rewardEffect=nil;
_UIObject_release(self.rewardInfoBtn);self.rewardInfoBtn=nil;
end
















local colorImgName={
[1]="image_mlsx_pz1",
[2]="image_mlsx_pz2",
[3]="image_mlsx_pz3",
[4]="image_mlsx_pz4",
[5]="image_mlsx_pz5",
[6]="image_mlsx_pz5",
}

local initiatorTeamItemCmpIndex={
hasPanel=0,
emptyPanel=1,
addBtn=2,
selfFlag=3,
head=4,
name=5,
dzPanel=6,
teamGrid=7,
changeDzBtn=8,
fightValueText=9,
xmXianYuName=10,
initiatorFlag=11,
emptyText=12,
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



function UIXJCaravanEscort_shipMsgWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end


function UIXJCaravanEscort_shipMsgWin:__delete()
self:closeWindow('UITopMoneyWin2')
self:clearEscortTimer()
self:clearRwEffDelayTimer()
_this=nil
self:unbindComponents()
end




function UIXJCaravanEscort_shipMsgWin:onShow(argtable,afterOnloaded)
self.showType=argtable and argtable.showType or 1
self.parentWin=argtable and argtable.parentWin
self.isNeedJumpWithLD=argtable and argtable.isNeedJumpWithLD
if self.isNeedJumpWithLD==nil then
local isLockShip=xianjieModel:checkSceneState(xjSceneStateType.eClickTeam)
self.isNeedJumpWithLD=not isLockShip
end

local isOpenRecordWin=argtable and argtable.isOpenRecordWin or false

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),6317,1,{},eAnimationID.enter)
end

if self.showType==1 then
self.posIdx=argtable and argtable.posIdx or 1
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local costItemId=baseCfg.refresh_item
self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtXianYu},{eMoneyType.mtLingYu},{costItemId}},offsetX=0,offsetY=-25})
elseif self.showType==2 then
self.guidList=argtable and argtable.guidList or nil
if self.guidList then
self.selectIdx=argtable and argtable.selectIdx or 1
self.guid=self.guidList[self.selectIdx]
else
self.guid=argtable and argtable.guid or nil
end


xianJieCaravanEscortController:reqGetShipDetailData(self.guid)
self:closeWindow('UITopMoneyWin2')
end

self:refresh(true)

if isOpenRecordWin and self.isShowRecordBtn then
self:onRecordBtn()
end
end


function UIXJCaravanEscort_shipMsgWin:onHide()
self:clearEscortTimer()
self:clearRwEffDelayTimer()
end

function UIXJCaravanEscort_shipMsgWin:refresh(isInit,isRefreshNew)
self:clearEscortTimer()

self:refreshInfoPanel(isInit,isRefreshNew)


self:refreshMemberPanel()


self:refreshBtnPanel()

end

function UIXJCaravanEscort_shipMsgWin:refreshByPosIdx(posIdx,isCheckReset,isRefreshNew)
if not posIdx or(not self.posIdx or posIdx==self.posIdx)then
if isCheckReset then
return self:checkAndReopenWin()
else
return self:refresh(nil,isRefreshNew)
end
end
end

function UIXJCaravanEscort_shipMsgWin:refreshByShipGuid(shipGuid,isResetDataCb)
if not shipGuid or(self.guid and mathHelper.compareInt64(shipGuid,self.guid))then
if isResetDataCb then

xianJieCaravanEscortController:reqGetShipDetailData(self.guid)
end
return self:refresh()
end
end

function UIXJCaravanEscort_shipMsgWin:refreshInfoPanel(isInit,isRefreshNew,isDelay)
local shipId
local rewards
local isYun=false
local robbedTimes=0
local isWaitDelay=false
if isRefreshNew and not isDelay then
self:clearRwEffDelayTimer()

self.rewardEffect:setChildShowEffect(22687,true)

self.rwEffDelayTimer=self:delayDo(0.5,function()
return self:refreshInfoPanel(isInit,isRefreshNew,true)
end)
isWaitDelay=true
elseif isRefreshNew==nil then
self.rewardEffect:setChildShowEffect(0,false)
end
if self.showType==1 then
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
if posData then
local posBaseData=posData.xianzhouStruct
robbedTimes=posBaseData and posBaseData.robbed_times or 0
shipId=posBaseData.xianzhou_id











local rewardsList=posBaseData.reward_list
local list={}
if rewardsList then
for _,v in ipairs(rewardsList)do
local itemId=v.param_1
local itemCount=v.param_2
local itemColor=itemsConfig.getItemColor(itemId)
list[#list+1]={itemId,itemCount,itemColor=itemColor}
end
end
rewards=list
end
elseif self.showType==2 then
local shipGuid=self.guid
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
if shipData then
local shipBaseData=shipData.xianzhouStruct
robbedTimes=shipBaseData and shipBaseData.robbed_times or 0












shipId=shipBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
local startTime=shipBaseData.start_sec or 0
local isStart=startTime and startTime>0 or false
local nowTime=timeHelper.getServerShortTime()
local isFinish=false
if isStart then

if shipCfg then
local duration=shipCfg.need_time
isFinish=startTime>0 and nowTime>=(startTime+duration)or false
end
else

end
isYun=isStart and not isFinish


local showRewards={}
local actuallyRewards=shipBaseData.reward_list
if actuallyRewards then
for _,v in ipairs(actuallyRewards)do
local itemId=v.param_1
local itemCount=v.param_2
local itemColor=itemsConfig.getItemColor(itemId)
table.insert(showRewards,{itemId,itemCount,itemColor=itemColor})
end
end

local robRewards=shipBaseData.robbed_reward_list
if robRewards then
for _,v in ipairs(robRewards)do
local itemId=v.param_1
local itemCount=v.param_2
local itemColor=itemsConfig.getItemColor(itemId)
table.insert(showRewards,{itemId,itemCount,itemColor=itemColor,isRob=true})
end
end
rewards=showRewards
end
end

if shipId then
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then

local color=shipCfg.id
local isChangeColor=self.shipLastColor and color~=self.shipLastColor or false
local isRefreshModel=true
local isShowShipEnterAnim=(isInit or(isRefreshNew and isChangeColor))and self.showType==1
if isWaitDelay then
if not isShowShipEnterAnim then
isRefreshModel=false
end
elseif isDelay then
isRefreshModel=false
end

if isRefreshModel then
local colorIconName=colorImgName[color]
if colorIconName then
local abName="ui/windows/xianjiecaravanescort/xianjiecaravanescort_color_atlas_pak.ab"
self.shipColor:setSprite(abName,colorIconName)
end



local modelId=shipModelIdList[color]
local animId=eAnimationID.stand
local delayTime
local isShowEnterEffect=false
local isShowEnterMoveEffect=false
local isRed=color>=5
if isYun then

else
if isShowShipEnterAnim then
animId=eAnimationID.enter
isShowEnterEffect=color>=5
isShowEnterMoveEffect=true
if isInit then
delayTime=0.3
end
else

end
end

self.shipLastColor=color
self.shipColor:setActive(not isRed)
self.shipColorModel:setActive(isRed)
if not isRed then
self.shipColorModel:setChildUIModelRemoveTarget()
end

local finishAnimFunc=nil
if isShowEnterEffect then
local effectId=22683
finishAnimFunc=function()
if not _this or not _this.isVisible then return end
self.shipEnterEffect:setChildShowEffect(effectId,true)
if isRed then
self.colorModelTimer=self:delayDo(1.5,function()
if not _this or not _this.isVisible then return end
self.shipColorModel:setChildUIModelShowTarget(6366,1,{},eAnimationID.stand,nil,nil,0.5)
end)
end
end
else
if isRed then
self.shipColorModel:setChildUIModelShowTarget(6366,1,{},eAnimationID.stand)
end
end

local shipModelPosTarn=self.shipModelPos:getTransform()
local shipEffectId=shipEffectIdList[robbedTimes]or nil
local shipMoveEffectId=isYun and 22682 or nil
local moveEffectScale
local moveEffectPos
if isShowEnterMoveEffect then
shipMoveEffectId=22684
moveEffectScale=3
moveEffectPos={16,10}
end
if not delayTime then

self:instantiateShipModel(color,shipModelPosTarn,shipEffectId,shipMoveEffectId,0.36,animId,isYun,finishAnimFunc,moveEffectScale,moveEffectPos)
else
self.enterModelTimer=self:delayDo(delayTime,function()
if not _this or not _this.isVisible then return end

self:instantiateShipModel(color,shipModelPosTarn,shipEffectId,shipMoveEffectId,0.36,animId,isYun,finishAnimFunc,moveEffectScale,moveEffectPos)
end)
end


local name=shipCfg.name
local textColor=color
local shipNameStr=FMT.cfmt(textColor,'{0}',name)
self.titleName:setText(shipNameStr)
end

if not isWaitDelay then

table.sort(rewards,function(a,b)
if a.isRob==b.isRob then
if a.itemColor==b.itemColor then
return a[1]<b[1]
else
return a.itemColor>b.itemColor
end
else
local robWeight_A=a.isRob and 100 or 0
local robWeight_B=b.isRob and 100 or 0
return robWeight_A<robWeight_B
end
end)
local rewardCount=#rewards
self.rewardScrollView:setChildScrollViewCreateGrids(rewardCount,rewardCount)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for index=1,grids.Count do
local rwItem=grids[index-1]
local itemData=rewards[index]
local itemid=itemData[1]
local itemnum=itemData[2]
local itemcount,showCountBG
if itemnum>1 or itemData.range~=nil then
itemcount=mathHelper.formatNumber(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end

local isRob=itemData.isRob or false






local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isRob
rwItem:SetChildPropData(0,prop)
rwItem:SetChildActive(4,isRob)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then
return
end
_this:onClickItem(...)
end)
end





local isShowRewardInfoBtn=self.showType==1 and shipCfg.showRewards~=nil
self.rewardInfoBtn:setActive(isShowRewardInfoBtn)
end

end
end
end


function UIXJCaravanEscort_shipMsgWin:refreshMemberPanel()

self:refreshInitiatorTeamPanel()



end

function UIXJCaravanEscort_shipMsgWin:refreshInitiatorTeamPanel()
local iconInfo
local dzList
local widget=self.initiatorTeamItem:getWidgetBase()
local isShowAdd=false
local isCanChange=false
local isSelfInitiator=false
local isSelfDz=false
local dzGuidList={}
local playerName="未知祖师"
local xmName=""
local xySceneIdx

if self.showType==1 then
isShowAdd=true
isSelfInitiator=true
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
if posData then
isCanChange=true
local dzGuidStrList=xianJieCaravanEscortModel:getEscortShipPosDzList(self.posIdx)
if dzGuidStrList then
dzList={}
for i,guidStr in ipairs(dzGuidStrList)do
local netData=UIDiscipleModel:getDiscipleDataByStr(guidStr)
if netData then
dzList[i]=netData
else
dzList[i]={flag=0}
end
dzGuidList[i]=netData and netData.discipleguid or Int64_0
end
isSelfDz=true
end

iconInfo=playerModel:getActorIconInfo()
playerName=playerModel:getActorName()

local hasXm=xianmengModel:hasXM()
if hasXm then
xmName=xianmengModel:getXMName()
end
xySceneIdx=xianjieModel:getXianYuSceneIndex()
end
elseif self.showType==2 then
local shipGuid=self.guid
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
if shipData then
local initiatorActorId=shipData.actor_id
isSelfInitiator=playerModel:checkActorId(initiatorActorId)
local detailData=xianJieCaravanEscortModel:getShipTeamDetailDataByGuid(shipGuid)
if detailData then
dzList=detailData.dzList
for i,netData in ipairs(dzList)do
local guid=netData and netData.discipleguid
dzGuidList[i]=guid or Int64_0
end

end

playerName=shipData.name
iconInfo=shipData.iconInfo
xySceneIdx=shipData.scene_idx
local xmData=shipData.guildInfo
if xmData then
xmName=xmData.param_3
end
else

return
end
end

local isEmpty=dzList==nil
widget:SetChildActive(initiatorTeamItemCmpIndex.emptyPanel,isEmpty)
widget:SetChildActive(initiatorTeamItemCmpIndex.hasPanel,not isEmpty)
if isEmpty then
widget:SetChildActive(initiatorTeamItemCmpIndex.addBtn,isShowAdd)
widget:SetChildActive(initiatorTeamItemCmpIndex.emptyText,not isShowAdd)

widget:SetChildButtonClick(initiatorTeamItemCmpIndex.addBtn,function()
return self:onClickAddBtn()
end,true)
else
widget:SetChildActive(initiatorTeamItemCmpIndex.initiatorFlag,false)


playerController:setHeadIcon(widget,initiatorTeamItemCmpIndex.head,{scale=0.6,iconInfo=iconInfo})
widget:SetChildActive(initiatorTeamItemCmpIndex.selfFlag,isSelfInitiator)


widget:SetChildText(initiatorTeamItemCmpIndex.name,playerName)


local xyName=xianjieController:getCrossServerNamebySCidx(xySceneIdx)
local xmXianYuName=FMT.fmt("[{0}]{1}",xyName,xmName)
widget:SetChildText(initiatorTeamItemCmpIndex.xmXianYuName,xmXianYuName)


local dznum=#dzList
widget:SetChildLayoutGroupCreateItems(initiatorTeamItemCmpIndex.teamGrid,dznum,function(index)
local dzItem=widget:GetChildLayoutGroupGridItem(initiatorTeamItemCmpIndex.teamGrid,index-1)
local netData=dzList[index]
local has=netData~=nil and(netData.flag==nil or netData.flag>0)
dzItem:SetChildActive(-1,has)
local dzHeadItemWidget=dzItem:GetChildWidgetBase(0)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzHeadItemWidget,0,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,dzHeadItemWidget,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzItem:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

UIDiscipleModel:setDiscipleXianMoHeadImage(dzHeadItemWidget,8,netData)
end
end)


local allFightValue=0
for i,netData in ipairs(dzList)do
local has=netData~=nil and(netData.flag==nil or netData.flag>0)

if has then
local fightValue
if isSelfDz then
fightValue=UIDiscipleModel:getDiscipleFightValue(netData.discipleguid)
else
local fightValue_int64=netData.fightvalue
fightValue=mathHelper.int64_to_number(fightValue_int64)
end

allFightValue=allFightValue+fightValue
end
end
widget:SetChildText(initiatorTeamItemCmpIndex.fightValueText,mathHelper.formatNumber3(allFightValue))
end
widget:SetChildActive(initiatorTeamItemCmpIndex.changeDzBtn,isCanChange)
if isCanChange then

widget:SetChildButtonClick(initiatorTeamItemCmpIndex.changeDzBtn,function()
return self:onClickTeamChangeBtn(dzGuidList)
end,true)
end
end

function UIXJCaravanEscort_shipMsgWin:refreshBtnPanel()
self:clearEscortTimer()
local isSelfInitiator=false
local isSelfTeam=false
local isSelfXm=false
local isStart=false
local isFinish=false
local isNeedTimer=false
local shipId
local shipCfg
local posData
local shipData
self.isShowRecordBtn=false

local nowTime=timeHelper.getServerShortTime()
if self.showType==1 then
isSelfInitiator=true
isSelfTeam=true
isSelfXm=true

posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
if posData then
local posBaseData=posData.xianzhouStruct
shipId=posBaseData.xianzhou_id
shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
local startTime=posBaseData.start_sec or 0
isStart=startTime and startTime>0 or false
if isStart then

if shipCfg then
local duration=shipCfg.need_time
isFinish=startTime>0 and nowTime>=(startTime+duration)or false
end
else

end
end
elseif self.showType==2 then
local shipGuid=self.guid
shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
if shipData then
local initiatorActorId=shipData.actor_id
isSelfInitiator=playerModel:checkActorId(initiatorActorId)
if isSelfInitiator then
isSelfTeam=true
isSelfXm=true
else
local selfHasXM=xianmengModel:hasXM()
local xmData=shipData.guildInfo
if xmData then
local xmGuid=xmData.param_1
isSelfXm=selfHasXM and xianmengModel:isMyXM(xmGuid)or false
end
end

local shipBaseData=shipData.xianzhouStruct
shipId=shipBaseData.xianzhou_id
shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
local startTime=shipBaseData.start_sec or 0
isStart=startTime and startTime>0 or false
if isStart then

if shipCfg then
local duration=shipCfg.need_time
isFinish=startTime>0 and nowTime>=(startTime+duration)or false
end
else

end
end
end
isNeedTimer=isStart and not isFinish

self.isShowRecordBtn=isSelfTeam and isStart
self.recordBtn:setActive(self.isShowRecordBtn)


local isShowChuFaBtn=isSelfInitiator and not isStart
self.chuFaBtnRoot:setActive(isShowChuFaBtn)
if isShowChuFaBtn then
local duration=shipCfg.need_time
self.wayTimeText:setText(FMT.fmt("护送时间：{0}",timeHelper.format_time_stamp(duration)))
end


local isShowRefreshBtn=isSelfInitiator and not isStart
if isShowRefreshBtn then
local totalRefreshCount=posData and posData.total_times or 0
local roundRefreshCount=posData and posData.round_times or 0
local maxRoundCount=shipCfg.round
local isShowBaoDi=maxRoundCount~=nil
self.baodiBg:setActive(true)
if isShowBaoDi then
local remainingCount=maxRoundCount-roundRefreshCount
self.baodiText:setText(FMT.fmt("再刷新<color=#efb150>{0}</color>次必定升级",remainingCount))
else
self.baodiText:setText("本次刷新不会降低品质")
end

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local costItemId=baseCfg.refresh_item
local costCount=1
local hasCostItemCount=costItemId and itemsModel.getCount(costItemId)or 0
if hasCostItemCount<=0 then

local costList=baseCfg.refresh_money
costItemId=eMoneyType.mtLingYu
costCount=0
for i,v in ipairs(costList)do
local minCount=v[1]
local cost=v[2]
if totalRefreshCount>=minCount then
costCount=cost
end
end
end

local isFree=totalRefreshCount<=0
self.refreshCostFree:setActive(isFree)
self.refreshCost:setActive(not isFree)
if not isFree then
local hasCount=itemsModel.getCount(costItemId)
local countStr=mathHelper.formatNumber(costCount)
if hasCount<costCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
self.refreshCostText:setText(countStr)
self.refreshCostIcon:setImageIcon(iconHelper.getIconName(costItemId),false)
end
end
self.refreshBtnRoot:setActive(isShowRefreshBtn)


local isShowGetRewardBtn=isSelfTeam and isFinish
self.getRewardBtn:setActive(isShowGetRewardBtn)


local isShowShareBtn=isStart and not isFinish
self.shareBtn:setActive(isShowShareBtn)
if isShowShareBtn then
if shipData then
local shipBaseData=shipData.xianzhouStruct
local startTime=shipBaseData.start_sec or 0
if shipCfg then
local duration=shipCfg.need_time
local endTime=startTime+duration
local lerp=endTime-nowTime
self.shareWayTimeText:setText(FMT.fmt("护送时间：{0}",timeHelper.format_time_stamp(lerp)))
end
end
end


local isShowGotoBtn=(isSelfTeam or isSelfXm)and isStart and not isFinish
self.gotoBtn:setActive(isShowGotoBtn)


local isShowRobBtn=not isSelfTeam and not isSelfXm and isStart and not isFinish
self.robBtnRoot:setActive(isShowRobBtn)
if isShowRobBtn then
if shipData then
local shipBaseData=shipData.xianzhouStruct
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local maxBeRobbedTimes=baseCfg.be_robbed_times
local curRobbedTimes=shipBaseData.robbed_times
local delta=maxBeRobbedTimes-curRobbedTimes
if delta<0 then
delta=0
end
self.robCountText:setText(FMT.fmt("仙舟剩余可掠夺次数：{0}次",delta))
end
end





if isNeedTimer then
self:setEscortTimer()
end
end

function UIXJCaravanEscort_shipMsgWin:setEscortTimer()
self:clearEscortTimer()
local func=function()
return self:refreshBtnPanel_updateTimer()
end
self.escortTimer=self:setTimer(1,0,func)
func()
end

function UIXJCaravanEscort_shipMsgWin:clearEscortTimer()
if self.escortTimer then
self:stopTimerByID(self.escortTimer)
self.escortTimer=nil
end
end


function UIXJCaravanEscort_shipMsgWin:clearRwEffDelayTimer()
if self.rwEffDelayTimer then
self:stopTimerByID(self.rwEffDelayTimer)
self.rwEffDelayTimer=nil
end
end

function UIXJCaravanEscort_shipMsgWin:refreshBtnPanel_updateTimer()
local nowTime=timeHelper.getServerShortTime()
local isStart=false
local isFinish=false
local isSelfTeam=false
local startTime
local endTime
local duration
if self.showType==1 then
isSelfTeam=true
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
if posData then
local posBaseData=posData.xianzhouStruct
local shipId=posBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
startTime=posBaseData.start_sec or 0
duration=shipCfg and shipCfg.need_time or nil
end
elseif self.showType==2 then
local shipGuid=self.guid
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
if shipData then
local initiatorActorId=shipData.actor_id
local isSelfInitiator=playerModel:checkActorId(initiatorActorId)
if isSelfInitiator then
isSelfTeam=true
end

local shipBaseData=shipData.xianzhouStruct
local shipId=shipBaseData.xianzhou_id
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
startTime=shipBaseData.start_sec or 0
duration=shipCfg and shipCfg.need_time or nil
end
end

if startTime and duration then
isStart=startTime and startTime>0 or false
if isStart then

endTime=startTime+duration
isFinish=startTime>0 and nowTime>=endTime or false
end
end

if isStart and not isFinish then

local lerp=endTime-nowTime
self.shareWayTimeText:setText(FMT.fmt("护送时间：{0}",timeHelper.format_time_stamp(lerp)))
else

self:clearEscortTimer()
if isSelfTeam then

return self:checkAndReopenWin()
else

UIManager.error("该仙舟已完成护送")
return self:onCloseBtn()
end
end
end


function UIXJCaravanEscort_shipMsgWin:checkAndReopenWin()
if self.showType==1 then

local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
if posData then
local posBaseData=posData.xianzhouStruct
local startTime=posBaseData.start_sec or 0
local isStart=startTime and startTime>0 or false
if isStart then

self.guid=posBaseData.xianzhou_guid
self.showType=2
self:closeWindow('UITopMoneyWin2')
end
end
end

return self:refresh()
end

function UIXJCaravanEscort_shipMsgWin:closeWinByPos(posIdx)
local nowPosIdx
if self.showType==1 then
nowPosIdx=self.posIdx
elseif self.showType==2 then
local shipGuid=self.guid
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(shipGuid)
nowPosIdx=posData and posData.pos or nil
end

if not posIdx or(nowPosIdx and posIdx==nowPosIdx)then
return self:onCloseBtn()
end
end



function UIXJCaravanEscort_shipMsgWin:instantiateShipModel(color,parentTarn,shipEffectId,shipMoveEffectId,scale,animId,isShowCloud,finishAnimFunc,moveEffectScale,moveEffectPos)
scale=scale or 1
animId=animId or eAnimationID.stand
moveEffectScale=moveEffectScale or 2.1
moveEffectPos=moveEffectPos or{-12,-19}
isShowCloud=isShowCloud or false
local shipModelData=self.shipModelData
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

modelWidget:SetChildScale(2,Vector3.New(moveEffectScale,moveEffectScale,moveEffectScale))
modelWidget:SetChildAnchoredPos(2,moveEffectPos[1],moveEffectPos[2])
if shipMoveEffectId then
modelWidget:SetChildShowEffect(2,shipMoveEffectId,true)
else
modelWidget:SetChildShowEffect(2,0,false)
end

if finishAnimFunc then
return finishAnimFunc()
end
end)

self.shipModelData={
rid=rid,
color=color,
animId=animId,
isShowCloud=isShowCloud,
}
elseif shipModelData and(shipModelData.animId~=animId or shipModelData.isShowCloud~=isShowCloud)then
return self:changeShipModelState(shipEffectId,shipMoveEffectId,animId,isShowCloud)
end
end

function UIXJCaravanEscort_shipMsgWin:changeShipModelState(shipEffectId,shipMoveEffectId,animId,isShowCloud)
local shipModelData=self.shipModelData
if shipModelData then
local rid=shipModelData.rid
local modelWidget=_InstantiateManager.GetComponent(rid,'CSGUIWidgetBase')
if modelWidget then

modelWidget:SetChildSpineAnimation(0,animId,1,nil)


isShowCloud=isShowCloud or false
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
end
self.shipModelData.animId=animId
end
end

function UIXJCaravanEscort_shipMsgWin:clearShipModel()
if self.shipModelData then
local rid=self.shipModelData.rid
_InstantiateManager.RemoveInstance(rid)
end
end

function UIXJCaravanEscort_shipMsgWin.onLimitActStateChange(actID,actState)
if _this==nil then return end
local flag=actID==LIMIT_ACT_TYPE.eMiaoXingShangLv
if not flag then
return
end

if actState==limitActivitiesModel.actDoingState or actState==limitActivitiesModel.actFinishState then
if actState==limitActivitiesModel.actFinishState then
UIManager.error("活动已结束")
_this:onCloseBtn()
end
end
end




function UIXJCaravanEscort_shipMsgWin:onChuFaBtn()

local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isActDoing then
UIManager.error("不在活动开启时间内，无法派遣")
return
end


local isInDispatchTime=xianJieCaravanEscortModel:checkIsXJCaravanEscortActCanDispatch()
if not isInDispatchTime then
UIManager.error("不在护送时间段内，无法派遣")
return
end


local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local maxDailyTimes=baseCfg.daily_times
local curGetTimes=xianJieCaravanEscortModel:getSelfEscortData_getTimes()
if curGetTimes>=maxDailyTimes then
UIManager.error("已达护送次数上限")
return
end

local posIdx=self.posIdx









local dzGuidStrList=xianJieCaravanEscortModel:getEscortShipPosDzList(posIdx)
local dzGuidList={}
local dzCount=0
if dzGuidStrList then
for i,guidStr in ipairs(dzGuidStrList)do
local netData=UIDiscipleModel:getDiscipleDataByStr(guidStr)
if netData then
dzGuidList[i]=netData.discipleguid
dzCount=dzCount+1
else
dzGuidList[i]=Int64_0
end
end
end

if dzCount<=0 then
UIManager.error("未设置护送队伍")
return
end

local pathData=xianJieCaravanEscortController:getShipPathData()
local jsonStr=jsonHelper.encode(pathData)
local reqFunc=function()

return xianJieCaravanEscortController:reqCaravanEscortShipDispatch(posIdx,dzGuidList,jsonStr)
end



























local paiqianFunc=function()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLPaiQian)
if not flag then

local showdata=
{
type='UIDialouge',
title='提示',
content="当前队伍派出后将无法撤回\n是否确认派出？",
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext='本次登录不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLPaiQian,flag)
end,

okcallback=reqFunc,
showclosebtn=true,
}
local dialog2=UIDialogManager.newDialog(showdata)
dialog2:show()
else

return reqFunc()
end
end


local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLPaiQianColor)
local isMaxColor=self.shipLastColor and self.shipLastColor>=5 or false
if not flag and not isMaxColor then

local showdata=
{
type='UIDialouge',
title='提示',
content="当前仙舟尚不是天阶\n是否护送？",
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext='本次登录不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLPaiQianColor,flag)
end,
okcallback=paiqianFunc,
showclosebtn=true,
}
local dialog3=UIDialogManager.newDialog(showdata)
dialog3:show()
else
return paiqianFunc()
end
end



function UIXJCaravanEscort_shipMsgWin:onClickMask()
return self:onCloseBtn()
end



function UIXJCaravanEscort_shipMsgWin:onCloseBtn()
if self.parentWin then
self:closeSelf()
else


self:closeSelf()
end
end



function UIXJCaravanEscort_shipMsgWin:onLeaveBtn()
end



function UIXJCaravanEscort_shipMsgWin:onRefreshBtn()

local nowTime=timeHelper.getServerShortTime()
if self.lastClickTime and nowTime<self.lastClickTime+1 then
UIManager.error("操作过快，请稍后重试")
return
end


local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isActDoing then
UIManager.error("不在活动开启时间内，无法刷新")
return
end


local isInDispatchTime=xianJieCaravanEscortModel:checkIsXJCaravanEscortActCanDispatch()
if not isInDispatchTime then
UIManager.error("不在护送时间段内，无法刷新")
return
end

local posIdx=self.posIdx
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(posIdx)

local totalRefreshCount=posData and posData.total_times or 0

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local costItemId=baseCfg.refresh_item
local costCount=1
local hasCostItemCount=costItemId and itemsModel.getCount(costItemId)or 0
if hasCostItemCount<=0 then

local costList=baseCfg.refresh_money
costItemId=eMoneyType.mtLingYu
costCount=0
for i,v in ipairs(costList)do
local minCount=v[1]
local cost=v[2]
if totalRefreshCount>=minCount then
costCount=cost
end
end
end

local isFree=totalRefreshCount<=0
local isItemRefresh=not isFree and not moneyConfig.isMoney(costItemId)

local sendFunc=function()
if _this~=nil then
_this.lastClickTime=nowTime
end
xianJieCaravanEscortController:reqSelfEscortShipPosRefresh(posIdx,isItemRefresh)
end

local useItemRefreshFunc=function()
if _this~=nil then
_this.lastClickTime=nowTime
end
itemsModel:useItem(costItemId,costCount,sendFunc,WARNING_TYPE.eWarning)
end

local refreshFunc=function()
if isFree then
return sendFunc()
else
if costItemId==eMoneyType.mtLingYu then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLRefresh)
if not flag then

local str=FMT.fmt("是否使用<color=#549327>{0}</color>灵玉进行刷新？",costCount)
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext='本次登录不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLRefresh,flag)
end,

okcallback=useItemRefreshFunc,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
else

return useItemRefreshFunc()
end
else
return useItemRefreshFunc()
end
end
end

local isMaxColor=self.shipLastColor and self.shipLastColor>=5 or false
if isMaxColor then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLMaxColorRefresh)
if not flag then

local showdata=
{
type='UIDialouge',
title='提示',
content="当前已是天阶仙舟\n是否继续刷新？",
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext='本次登录不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eMXSLMaxColorRefresh,flag)
end,
okcallback=refreshFunc,
showclosebtn=true,
}
local dialog2=UIDialogManager.newDialog(showdata)
dialog2:show()
else
return refreshFunc()
end
else
return refreshFunc()
end
end



function UIXJCaravanEscort_shipMsgWin:onGetRewardBtn()
local posIdx
if self.showType==1 then
posIdx=self.posIdx
elseif self.showType==2 then
local shipGuid=self.guid
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(shipGuid)
posIdx=posData and posData.pos or nil
end

if posIdx then
xianJieCaravanEscortController:reqSelfEscortShipGetReward(posIdx)
end
end



function UIXJCaravanEscort_shipMsgWin:onShareBtn()
local _sceneType=xianjienSceneType.eXianJie
local shipSceneIdx
local shipGuid=self.guid
local shipGuidStr=tostring(shipGuid)
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
local playerName="未知祖师"
local shipId
local posX=0
local posY=0
local actorIdStr
if shipData then
playerName=shipData.name
actorIdStr=tostring(shipData.actor_id)
local xianYuSceneIdx=shipData.scene_idx
shipSceneIdx=xianYuSceneIdx
local cfg=cfgHelper.get1(cfg_fairylandsceneidxconfig_get,xianYuSceneIdx)
local tagPos=cfg.tagPos
posX=tagPos[1]
posY=tagPos[2]

local shipBaseData=shipData.xianzhouStruct
shipId=shipBaseData.xianzhou_id
end

local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
if entityData then
shipSceneIdx=entityData.srcSceneIdx
local pathParam=entityData.pathParam
if pathParam then

shipSceneIdx=pathParam.zmSceneIdx
local pos=pathParam.zmPos
posX=pos[1]
posY=pos[2]
end
end

local sceneType=xianjieModel:sceneIndex2SceneType(shipSceneIdx)
local isSelfInitiator=false
local isSelfTeam=false
if self.showType==1 then
isSelfTeam=true
elseif self.showType==2 then
if shipData then
local initiatorActorId=shipData.actor_id
isSelfInitiator=playerModel:checkActorId(initiatorActorId)
if isSelfInitiator then
isSelfTeam=true
end
end
end
local isSelfTeamFlag=isSelfTeam and 1 or 0


local data=
{
x=posX,
y=posY,
icon1="icon_sjgdbiaoshi_1",
msgName="护送队伍",
shareType=xianjie_Point_Share.miaoxingshanglv,
scenceType=sceneType,
name="护送队伍",
shareName=playerName,
shipGuidStr=shipGuidStr,
shipId=shipId,
isSelfTeamFlag=isSelfTeamFlag,
actorIdStr=actorIdStr,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,shipSceneIdx,data.x,data.y,shipGuidStr,shipId,isSelfTeamFlag,actorIdStr})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y),
canvasIdx=7,
}
UIManager:showWindow("UICommonShareTwoWin",args)
end



function UIXJCaravanEscort_shipMsgWin:onGotoBtn()
local shipGuid=self.guid

local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
local hasPath=false
if shipData then
hasPath=xianJieCaravanEscortModel:checkHasPathData(shipData)
end

if not hasPath then
UIManager.error("无法确定该仙舟所在位置")
return
end

local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
if entityData then
local getEntityDataFunc=function()
return xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
end

local clickEntKey=entityData:getTeamEnityKey()
if not clickEntKey then

local shipNowSceneIdx,pos=entityData:getTeamPos()
if shipNowSceneIdx then
local nowSceneIdx=xianjieModel:getSceneIndex()
if nowSceneIdx~=shipNowSceneIdx then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(shipNowSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
end
end)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end
else
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
end
end


if self.parentWin then
return self.parentWin:onBtnClose()
else
return self:onCloseBtn()
end
end




function UIXJCaravanEscort_shipMsgWin:onChangeBtn()





end




function UIXJCaravanEscort_shipMsgWin:onRobBtn()
local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isActDoing then
UIManager.error("不在活动开启时间内，无法掠夺")
return
end

local shipGuid=self.guid
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
local nowTime=timeHelper.getServerShortTime()
local endTime
local startTime
local isExpire=false










if shipData then
local shipBaseData=shipData.xianzhouStruct

local isSelfXm=false
local selfHasXM=xianmengModel:hasXM()
local xmData=shipData.guildInfo
if xmData then
local xmGuid=xmData.param_1
isSelfXm=selfHasXM and xianmengModel:isMyXM(xmGuid)or false
end
if isSelfXm then
UIManager.error("同仙盟仙舟，无法掠夺")
return
end

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)

local maxBeRobbedTimes=baseCfg.be_robbed_times
local curRobbedTimes=shipBaseData.robbed_times
if curRobbedTimes>=maxBeRobbedTimes then
UIManager.error("该仙舟可掠夺次数不足，无法掠夺")
return
end


local selfEscortData=xianJieCaravanEscortModel:getSelfEscortData()
local maxRobNum=baseCfg and baseCfg.rob_times or 0
local curRobNum=selfEscortData and selfEscortData.robTimes or 0
if curRobNum>=maxRobNum then
UIManager.error("已达掠夺次数上限")
return
end

local shipId=shipBaseData.xianzhou_id

local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,shipId)
if shipCfg then
local duration=shipCfg.need_time
startTime=shipBaseData.start_sec or 0
endTime=startTime+duration
isExpire=startTime>0 and nowTime>=endTime or false
end
if isExpire then
UIManager.error("该仙舟已完成护送，无法掠夺")
return
end
end


local isJump2Ship=false
local isCanJumpMXSL=xianJieCaravanEscortModel:checkCanXJCaravanEscortWinJump()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local getEntityDataFunc=function()
return xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
end
local otherSceneJumpFunc=function(srcSceneIdx)
local sceneType=xianjieModel:sceneIndex2SceneType(srcSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
end
end)
end
local closeWinFunc=function()
if self.parentWin then
return self.parentWin:onBtnClose()
else
return self:onCloseBtn()
end
end
if self.isNeedJumpWithLD and isCanJumpMXSL then

local hasPath=false
if shipData then
hasPath=xianJieCaravanEscortModel:checkHasPathData(shipData)
end
if hasPath then
if entityData then
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
isJump2Ship=true
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
closeWinFunc()
else

local shipNowSceneIdx,pos=entityData:getTeamPos()
if shipNowSceneIdx then
local nowSceneIdx=xianjieModel:getSceneIndex()
if nowSceneIdx~=shipNowSceneIdx then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
closeWinFunc()
return otherSceneJumpFunc(shipNowSceneIdx)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
isJump2Ship=true
end
end
end
end
end
end

if not isJump2Ship then

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local mapId=baseCfg.map_id
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianJieCaravanEscortModel:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
local defTeamList={}
local detailData=xianJieCaravanEscortModel:getShipTeamDetailDataByGuid(shipGuid)
local defDzList=detailData and detailData.dzList
if defDzList then
for i,netData in ipairs(defDzList)do






local has=netData~=nil and(netData.flag==nil or netData.flag>0)
if has then
defTeamList[i]={guid=netData.discipleguid,typo=fightEntityType.diZi,netData=netData,}
end
end
end

local hasParentWin=self.parentWin~=nil
local flag=hasParentWin and 1 or 0
local isNeedJumpWithLD_back=self.isNeedJumpWithLD
local winArgs={
enterTxt='掠夺队伍',
mapId=mapId,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
monsterListEx=defTeamList,
enterCallBack=function(selectList,zfId,mapId)
local isActDoing=xianJieCaravanEscortModel:checkIsXJCaravanEscortActDoing()
if not isActDoing then
UIManager.error("不在活动开启时间内，无法掠夺")
return
end
local nowTime=timeHelper.getServerShortTime()
local isExpire=startTime>0 and nowTime>=endTime or false
if isExpire then

return UIManager:invokeUIMethod("UIFightPrepareWin","onCloseFunc")
end

fightLaunchController:sendFight(eBattleLaunch.xjCaravanEscort,selectList,mapId,zfId,{shipGuid,flag})
end,
cancelCallBack=function()
fightController:closeSelectStage()
if hasParentWin then

local param={
selectPageIdx=2,
openMsgShipGuid=shipGuid,
}
UIFullXJCaravanEscortController:showMainWindowByJump(param)
else
if entityData then
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
else

local shipNowSceneIdx,pos=entityData:getTeamPos()
if shipNowSceneIdx then
local nowSceneIdx=xianjieModel:getSceneIndex()
if nowSceneIdx~=shipNowSceneIdx then
otherSceneJumpFunc(shipNowSceneIdx)
end
end
end
end

local showType=2
xianjieController:openXJCaravanEscortShipMsgWin(showType,shipGuid)
end
end,
}






fightController.showPrepareWin(fightPreSelectModel.fightType.xjCaravanEscortAtkTeam,winArgs)
end
end


function UIXJCaravanEscort_shipMsgWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIXJCaravanEscort_shipMsgWin:onClickAddBtn()
return self:setTeamDZList()
end

function UIXJCaravanEscort_shipMsgWin:onClickTeamChangeBtn(dzGuidList)

return self:setTeamDZList(dzGuidList)
end

function UIXJCaravanEscort_shipMsgWin:setTeamDZList(teamList)
local posIdx=self.posIdx
if not teamList or not next(teamList)then
teamList=nil
end

local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local mapId=baseCfg.map_id
local param={
selectPageIdx=1,
openMsgPosIdx=posIdx,
}
local winArgs={
mapId=mapId,
teamList=teamList,
enterCallBack=function(selectList,zfId,mapId)
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,v[2])
end
xianJieCaravanEscortModel:setEscortShipPosDzList(posIdx,dzlist)
fightController:closeSelectStage()

UIFullXJCaravanEscortController:showMainWindowByJump(param)
end,
enterTxt="护送队伍",
cancelCallBack=function()
fightController:closeSelectStage()

UIFullXJCaravanEscortController:showMainWindowByJump(param)
end,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,

isIgnoreSaveData=true,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianJieCaravanEscortModel:initBattleDZ(d,posIdx)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=function(guid)
return xianJieCaravanEscortModel:checkDZSortFunc(guid,posIdx)
end
fightController.showPrepareWin(fightPreSelectModel.fightType.xjCaravanEscortDefTeam,winArgs,function()

end)
end

function UIXJCaravanEscort_shipMsgWin:onRecordBtn()
local shipGuid=self.guid
local startTime
local shipId
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
local isOpenWithMainWin=self.parentWin~=nil
if shipData then
local shipBaseData=shipData.xianzhouStruct
shipId=shipBaseData.xianzhou_id
startTime=shipBaseData.start_sec or 0

self:showWindow("UIXJCaravanEscort_recordWin",{shipGuid=shipGuid,shipId=shipId,startTime=startTime,isOpenWithMainWin=isOpenWithMainWin})
end
end

function UIXJCaravanEscort_shipMsgWin:onRewardInfoBtn()
local shipId

if self.showType==1 then
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
if posData then
local posBaseData=posData.xianzhouStruct
shipId=posBaseData.xianzhou_id
end
elseif self.showType==2 then
local shipGuid=self.guid
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
if shipData then
local shipBaseData=shipData.xianzhouStruct
shipId=shipBaseData.xianzhou_id
end
end

if shipId then
self:showWindow("UIXJCaravanEscort_rewardsInfoWin",{shipId=shipId})
end
end


function UIXJCaravanEscort_shipMsgWin:test_showGoBtn()
self.gotoBtn:setActive(true)
end


function UIXJCaravanEscort_shipMsgWin:test_printShipData()
local data={}
if self.showType==1 then
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByPos(self.posIdx)
data=posData
elseif self.showType==2 then
local shipGuid=self.guid
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
data=shipData
end


end


function UIXJCaravanEscort_shipMsgWin:test_changeNowShipPathData()
if self.showType==1 then
return logErr("当前船只未出发 无法修改")
elseif self.showType==2 then
local shipGuid=self.guid
xianJieCaravanEscortController:testFunc_changePathData(shipGuid)
end
end

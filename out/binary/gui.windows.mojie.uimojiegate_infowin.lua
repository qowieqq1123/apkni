







def_class("UIMoJieGate_infoWin",UIWindowBase)









function UIMoJieGate_infoWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.gateModel=UIObject.get(self,4)
self.gateNameText=UIText.get(self,5)
self.belongXmText=UIText.get(self,6)
self.stateText=UIText.get(self,7)
self.topTipsText=UIText.get(self,8)
self.whiteListGroup=UIObject.get(self,9)
self.gotoBtn=UIButton.get(self,10)
self.applyBtn=UIButton.get(self,11)
self.whiteListBtn=UIButton.get(self,12)
self.noTipsText=UIText.get(self,13)
self.whiteListReddot=UIObject.get(self,14)
self.helpBtn=UIButton.get(self,15)
self.rewardScrollView=UIObject.get(self,16)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.whiteListBtn:setButtonClick(function()self:onWhiteListBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIMoJieGate_infoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gateModel);self.gateModel=nil;
_UIObject_release(self.gateNameText);self.gateNameText=nil;
_UIObject_release(self.belongXmText);self.belongXmText=nil;
_UIObject_release(self.stateText);self.stateText=nil;
_UIObject_release(self.topTipsText);self.topTipsText=nil;
_UIObject_release(self.whiteListGroup);self.whiteListGroup=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.whiteListBtn);self.whiteListBtn=nil;
_UIObject_release(self.noTipsText);self.noTipsText=nil;
_UIObject_release(self.whiteListReddot);self.whiteListReddot=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
end



















function UIMoJieGate_infoWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieGate_infoWin:__delete()
self:unbindComponents()
end




function UIMoJieGate_infoWin:onShow(argtable,afterOnloaded)
self.gateId=argtable.gateId
self.bgModel:setChildUIModelShowTarget(6427,1,nil,eAnimationID.stand)

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

local isShowPassList=argtable.isShowPassList
if isShowPassList then

self:onWhiteListBtn()
end
end


function UIMoJieGate_infoWin:onHide()

end

function UIMoJieGate_infoWin:refresh(isInit)

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
local isSelfXianYu=gateXYSceneIndex==xianjieModel:getXianYuSceneIndex()
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


local selfHasXM=xianmengModel:hasXM()
local isSelfXm=selfHasXM and hasXM and xianmengModel:isMyXM(xmGuid)
local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
local passState
if isSelfXm then
passState=1
else
if isSelfXianYu then

local isInWhiteList=selfHasXM and xianjieModel:checkMoJieGateIsCanPassByXMGuid(self.gateId,selfXMGuid)or false
if isInWhiteList then
passState=2
else
passState=3
end
else

passState=4
end
end
local isCanPass=passState==1 or passState==2
local passStateStr=isCanPass and"可通过"or"不可通过"
self.stateText:setText(passStateStr)


local passTipsStr
if passState==1 then
passTipsStr="您属于当前关口的归属仙盟成员\n可通过关口"
elseif passState==2 then
passTipsStr="您已获得归属仙盟的允许\n可通过当前关口"
elseif passState==3 then
passTipsStr="您没有获得归属仙盟的允许\n无法通过此关口"
elseif passState==4 then
passTipsStr="您不属于该关口所在仙域\n无法通过此关口"
end
self.topTipsText:setText(passTipsStr)


self:refreshWhiteListPanel()


self.applyBtn:setActive(passState==3)

self:refreshWhiteListBtn()


self:refreshOwnRewardPanel()
end

function UIMoJieGate_infoWin:refreshWhiteListPanel()
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil

local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
local selfHasXM=xianmengModel:hasXM()
local isSelfXm=selfHasXM and hasXM and xianmengModel:isMyXM(xmGuid)
local selfXMGuid=selfHasXM and xianmengModel:getMyXMGuildID()or nil
local isCanPass=false
if isSelfXm then
isCanPass=true
else

local isInWhiteList=selfHasXM and xianjieModel:checkMoJieGateIsCanPassByXMGuid(self.gateId,selfXMGuid)or false
isCanPass=isInWhiteList
end

self.whiteListGroup:setActive(isCanPass)
local isShowNoTips=true
local isAllPass=false
if isCanPass then

local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local allPassChapterId=gateBaseCfg.can_pass_stage
if allPassChapterId then
local isStart=seasonController:checkSeasonStageBegined(season_id,allPassChapterId)
if isStart then
isAllPass=true
end
end

if not isAllPass then
local whiteList=gateData and gateData.whiteList or nil
local count=whiteList and#whiteList or 0
isShowNoTips=count<=0
self.whiteListGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.whiteListGroup:getChildLayoutGroupGridItem(index-1)
local wlXmData=whiteList[index]
local wlXmGuid=wlXmData and wlXmData.param_1 or nil
if wlXmGuid then
widget:SetChildActive(-1,true)

local xmName=wlXmData.param_3 or"未知仙盟"
widget:SetChildText(0,xmName)
else
widget:SetChildActive(-1,false)
end
end)
else
self.whiteListGroup:setActive(false)
isShowNoTips=true
end
end
self.noTipsText:setActive(isShowNoTips)
if isShowNoTips then
local tipsStr
if isCanPass then
if isAllPass then
tipsStr="关口开放，可自由通过"
else
tipsStr="暂无其他可通行仙盟"
end
else
tipsStr="无通过权限，无法查看"
end
self.noTipsText:setText(tipsStr)
end
end


function UIMoJieGate_infoWin:refreshWhiteListBtn()
local isShowWLBtn=false
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
if selfXmOwnGateId==self.gateId then
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil


local isAllPass=false
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)
local allPassChapterId=gateBaseCfg.can_pass_stage
if allPassChapterId then
local isStart=seasonController:checkSeasonStageBegined(season_id,allPassChapterId)
if isStart then
isAllPass=true
end
end

if not isAllPass then
local hasPrivilege=xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptGuanKouYaoSai)
isShowWLBtn=hasPrivilege
end
end

self.whiteListBtn:setActive(isShowWLBtn)
if isShowWLBtn then
local reddot=xianjieModel:checkMoJieGateHasNotReadAskByGateId(self.gateId)
self.whiteListReddot:setActive(reddot)
end
end


function UIMoJieGate_infoWin:refreshByGateId(gateId)
if not gateId or self.gateId==gateId then
return self:refresh()
end
end

function UIMoJieGate_infoWin:refreshOwnRewardPanel()
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

function UIMoJieGate_infoWin:getOwnRewardList()



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




function UIMoJieGate_infoWin:onClickMask()
self:onClickClose()
end



function UIMoJieGate_infoWin:onCloseBtn()
self:onClickClose()
end



function UIMoJieGate_infoWin:onGotoBtn()
end



function UIMoJieGate_infoWin:onApplyBtn()

local hasXm=xianmengModel:hasXM()
if not hasXm then
return UIManager.error("加入仙盟后才能申请通过关口")
end

local cd=2
local nowTime=timeHelper.getServerShortTime()
if self.lastReqApplyTime and nowTime<self.lastReqApplyTime+cd then
return UIManager.error("点击过快，请稍后再试")
end


local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local season_id=gateData and gateData.seasonId or 1
local stageId=gateData and gateData.stageId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
local gateId=self.gateId
xianjieController:reqApplyForGatePass(season_id,chapter_idx,gateId)
self.lastReqApplyTime=nowTime
end



function UIMoJieGate_infoWin:onWhiteListBtn()
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local isShowWLBtn=false
if selfXmOwnGateId==self.gateId then
local hasPrivilege=xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptGuanKouYaoSai)
isShowWLBtn=hasPrivilege
end
if not isShowWLBtn then

return
end


local gateId=self.gateId
self:showWindow("UIMoJieGate_passListWin",{gateId=gateId})
end

function UIMoJieGate_infoWin:onClickClose()
xianjieController:closeWin('UIMoJieGate_infoWin')
end

function UIMoJieGate_infoWin:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eMoJieGate,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end

function UIMoJieGate_infoWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
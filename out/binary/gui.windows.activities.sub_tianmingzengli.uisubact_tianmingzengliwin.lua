







def_class("UISubAct_tianmingzengliWin",UIWindowBase)









function UISubAct_tianmingzengliWin:bindComponents()

self.libaoScroller=UIObject.get(self,0)
self.timeText=UIText.get(self,1)
self.dzmodel=UIObject.get(self,2)
self.baoXiang=UIButton.get(self,3)
self.baoXiangOpen=UIButton.get(self,4)
self.upTianMing=UIButton.get(self,5)
self.baoXiangReddot=UIImage.get(self,6)
self.TipsWin=UIObject.get(self,7)
self.tipsText=UIImage.get(self,8)
self.tipsRewardScroller=UIObject.get(self,9)
self.goToCheck=UIButton.get(self,10)
self.Btnclose=UIButton.get(self,11)

self.baoXiang:setButtonClick(function()self:onBaoXiang()end)

self.baoXiangOpen:setButtonClick(function()self:onBaoXiangOpen()end)

self.upTianMing:setButtonClick(function()self:onUpTianMing()end)

self.goToCheck:setButtonClick(function()self:onGoToCheck()end)

self.Btnclose:setButtonClick(function()self:onBtnclose()end)



end


function UISubAct_tianmingzengliWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.libaoScroller);self.libaoScroller=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.dzmodel);self.dzmodel=nil;
_UIObject_release(self.baoXiang);self.baoXiang=nil;
_UIObject_release(self.baoXiangOpen);self.baoXiangOpen=nil;
_UIObject_release(self.upTianMing);self.upTianMing=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.TipsWin);self.TipsWin=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.tipsRewardScroller);self.tipsRewardScroller=nil;
_UIObject_release(self.goToCheck);self.goToCheck=nil;
_UIObject_release(self.Btnclose);self.Btnclose=nil;
end
















local libaoItemIndex={
rewards_free=0,
rewards_buy=1,
freeBtn=2,
buyBtn=3,
buyBtnText=4,
limitCountText=5,
gotMask=6,
selloutMask=7,
rebate=8,
rebateText=9,
dzBg=10,
dzHead=11,
dzMask=12,
dzLock=13,
tianmingGrid=14,
freeBtnReddot=15,
limitCountBg=16,
dzPanel=17,
skillPanel=18,
skillIcon=19,
skillLock=20,
}

local abname="ui/windows/recharge/dailytehuisingleday_atlas_pak.ab"




function UISubAct_tianmingzengliWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_tianmingzengliWin:__delete()
self.lastRefreshTime=nil
self:clearTimer()
self:doPunchRotation(false)
self:unbindComponents()
end




function UISubAct_tianmingzengliWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.checkFlag=true
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)

self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time


self.tempDzData={}


self:refresh()

local dzModelParam=self.config.dzModelParam
self.dzId=dzModelParam.dzId
self.gearPos=tianmingzengliModel:getTMZLLastUnlockPos(self.dzId)

local flag,pos,txetcfg,rewardCfg=self:judgeIsUnlock()
if flag then
self.gearPos=pos
self:refreshTipsWin(pos,txetcfg)
self:setTipsReward(rewardCfg)
tianmingzengliModel:setTMZLLastUnlockPos(self.dzId,self.gearPos)
else
self.winlua:SetChildActive(self.TipsWin:getID(),false)
if self.noGotIndex then
self.libaoScroller:setChildScrollViewSelectItem(self.noGotIndex-1)
else
if not self.yesGotIndex then self.yesGotIndex=0 end
self.libaoScroller:setChildScrollViewSelectItem(self.yesGotIndex-1)
end
end
end


function UISubAct_tianmingzengliWin:onHide()
self:clearTimer()
self:doPunchRotation(false)
end

function UISubAct_tianmingzengliWin:refresh()

self.lastRefreshTime=timeHelper.getServerLongTime()


self:refreshDzModel()


self:refreshLibaoList()


self:refreshDailyReward()


self:setRemainingTimeTimer()
end

function UISubAct_tianmingzengliWin:refreshDzModel()
local dzModelParam=self.config.dzModelParam
if not dzModelParam or not next(dzModelParam)then
logErr(FMT.fmt("活动id: {0}, 活动类型: {1}, 子活动id: {2}找不到弟子展示模型参数数据 请检查配置是否正确",self.activityId,self.subType,self.subId))
return
end

local dzId=dzModelParam.dzId
if dzId==self.initDzModelId then

return
end

local modelId=dzModelParam.modelId
local scale=dzModelParam.scale or 1
local offset=dzModelParam.offset or{0,0}
local animId=dzModelParam.animId or eAnimationID.stand

local dzData=self:getDiscipleData(dzId)
if modelId then

self.dzmodel:setChildUIModelShowTarget(modelId,scale,{},animId)
self.dzmodel:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

if not dzData.discipleguid and not dzData.hasFixedImage then

logErr(FMT.fmt("对应的弟子id: {0} 没有配置固定组件库 无法加载形象",dzId))
return
end

local info=dzData.imageInfo
if info then


self.dzmodel:setChildUIModelRemoveTarget()

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)
self.dzmodel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,animId)
self.dzmodel:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

self.initDzModelId=dzId
end


function UISubAct_tianmingzengliWin:sortLibaoList()
local unLockCfg=self.config.unLockLimit
local libaoCfgList=self.config.rewards
self.libaoList_sort={}
for i=1,#libaoCfgList do
local libaoId=i
local libaoCfg=libaoCfgList[libaoId]
local libaoData={}
libaoData.id=libaoId
libaoData.cfg=libaoCfg
libaoData.sortWeight=libaoId

local isGotAndBuyAll=false
local isGot=self.activityData:reqTianMingZengLi_checkFreeLibaoIsGot(libaoId)
local isSellOut=false
local buyLimitCount=libaoCfg[6]
local nowBuyCount=self.activityData:reqTianMingZengLi_getLibaoBuyCount(libaoId)
if buyLimitCount and nowBuyCount>=buyLimitCount then
isSellOut=true
end
isGotAndBuyAll=isGot and isSellOut

if isGotAndBuyAll then
libaoData.sortWeight=libaoData.sortWeight+1000
end


if unLockCfg and unLockCfg[i][1]then
local dzId=libaoCfg[1]
local index=unLockCfg[i][1]
local targetTianmingLv=libaoCfgList[index][2]
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)

if hasDz and dzNowTmLv>=targetTianmingLv then
table.insert(self.libaoList_sort,libaoData)
end
else
table.insert(self.libaoList_sort,libaoData)
end
end


table.sort(self.libaoList_sort,function(a,b)
return a.sortWeight<b.sortWeight
end)
end

function UISubAct_tianmingzengliWin:onGoToCheck()
self:onBtnclose()
self.libaoScroller:setChildScrollViewSelectItem(self.gearPos-1)
end

function UISubAct_tianmingzengliWin:refreshTipsWin(pos,text)
self.winlua:SetChildActive(self.TipsWin:getID(),true)
self.winlua:SetChildCSImageSprite(self.tipsText:getID(),abname,text)
end

function UISubAct_tianmingzengliWin:onBtnclose()
self.winlua:SetChildActive(self.TipsWin:getID(),false)
if self.noGotIndex then
self.libaoScroller:setChildScrollViewSelectItem(self.noGotIndex)
else
self.libaoScroller:setChildScrollViewSelectItem(self.yesGotIndex)
end
end

function UISubAct_tianmingzengliWin:judgeIsUnlock()

local flag=false
local pos=nil
local textCfg=nil
local rewardCfg=nil

local index=self.gearPos
if not index then index=0 end

local unLockCfg=self.config.unLockLimit
local isShowCfg=self.config.unLockShow

local libaoCfgList=self.config.rewards
local libaoCfg=libaoCfgList[1]
local dzId=libaoCfg[1]
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)

if hasDz and unLockCfg then

for k=index+1,#unLockCfg do

if unLockCfg[k][1]then
libaoCfg=libaoCfgList[unLockCfg[k][1]]
local limitLv=libaoCfg[2]

if dzNowTmLv>=limitLv then

if isShowCfg[k][1]then
flag=true
pos=k
textCfg=isShowCfg[k][2]
rewardCfg=isShowCfg[k][3]

end
end
end
end
end
return flag,pos,textCfg,rewardCfg
end

function UISubAct_tianmingzengliWin:refreshLibaoList()

self:sortLibaoList()


local libaoList=self.libaoList_sort
local yieldRateCfg=self.config.yieldRate or{}
local count=#libaoList
self.libaoScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.libaoScroller:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local libaoData=libaoList[i]
local libaoId=libaoData.id
if libaoData then
local libaoCfg=libaoData.cfg
local dzId=libaoCfg[1]
local targetTianmingLv=libaoCfg[2]
local freeRewards=libaoCfg[3]
local buyRewards=libaoCfg[4]
local buyLibaoRechargeId=libaoCfg[5]
local buyLimitCount=libaoCfg[6]
local isResetBuyDaily=libaoCfg[7]and libaoCfg[7]==1


local dzData=self:getDiscipleData(dzId)
local dzInfo=dzData.imageInfo
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
local openLibao=hasDz and dzNowTmLv>=targetTianmingLv or false
if dzInfo then

local chong=UIDiscipleModel.getTianMingLevelChong(targetTianmingLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(targetTianmingLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
widget:SetChildLayoutGroupCreateItems(libaoItemIndex.tianmingGrid,chong)
local tmGrids=widget:GetChildLayoutGroupGridList(libaoItemIndex.tianmingGrid)
for i=1,chong do
local fireItem=tmGrids[i-1]
fireItem:SetChildCSImageSprite(0,abName,iconName)
end

if floor>0 and chong==1 then

widget:SetChildActive(libaoItemIndex.dzPanel,false)
widget:SetChildActive(libaoItemIndex.skillPanel,true)
self:setLiBaoDiziTianMingSkillItem(widget,dzData,openLibao,targetTianmingLv)
else

widget:SetChildActive(libaoItemIndex.dzPanel,true)
widget:SetChildActive(libaoItemIndex.skillPanel,false)
self:setLiBaoDiziHeadItem(widget,dzData,openLibao,targetTianmingLv)
end

end


self:setRewardShow(freeRewards,widget,libaoItemIndex.rewards_free)

local isGot=self.activityData:reqTianMingZengLi_checkFreeLibaoIsGot(libaoId)
widget:SetChildActive(libaoItemIndex.gotMask,isGot)

widget:SetChildActive(libaoItemIndex.freeBtn,not isGot)
if not isGot then

if self.checkFlag and openLibao then
self.checkFlag=false
self.noGotIndex=i
end

widget:SetChildButtonClick(libaoItemIndex.freeBtn,function()
self:onLibaoFreeBtn(libaoId,dzId)
end)
else
self.yesGotIndex=i
end

widget:SetChildActive(libaoItemIndex.freeBtnReddot,openLibao and not isGot)


self:setRewardShow(buyRewards,widget,libaoItemIndex.rewards_buy)

local nowBuyCount=self.activityData:reqTianMingZengLi_getLibaoBuyCount(libaoId)
local isSellOut=false
if buyLimitCount then
local remainingBuyCount=buyLimitCount-nowBuyCount
if remainingBuyCount<=0 then
remainingBuyCount=0
isSellOut=true
end
widget:SetChildText(libaoItemIndex.limitCountText,FMT.fmt("限:{0}次",remainingBuyCount))
end
widget:SetChildActive(libaoItemIndex.limitCountBg,buyLimitCount~=nil and not isSellOut)


widget:SetChildActive(libaoItemIndex.selloutMask,isSellOut)

widget:SetChildActive(libaoItemIndex.buyBtn,not isSellOut)
if not isSellOut then

widget:SetChildButtonClick(libaoItemIndex.buyBtn,function()
self:onLibaoBuyBtn(libaoId,dzId)
end)


local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,buyLibaoRechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(libaoItemIndex.buyBtnText,str)
end


local rate=yieldRateCfg[libaoId]
if rate then

widget:SetChildText(libaoItemIndex.rebateText,FMT.fmt("{0}%",rate))
widget:SetChildActive(libaoItemIndex.rebate,true)
else

widget:SetChildActive(libaoItemIndex.rebate,false)
end
end
end
end


function UISubAct_tianmingzengliWin:setLiBaoDiziHeadItem(widget,dzData,openLibao,tmLevel)
local dzInfo=dzData.imageInfo
local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(tmLevel,1)


local color=dzInfo.color
comHelper.setChildModelHeadIconBGByColor(widget,libaoItemIndex.dzBg,color)


local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(dzData)
local headCenterType=1
local size=1
comHelper.setChildModelRawImageEx(libaoItemIndex.dzHead,widget,modelParams,headCenterType,size)


widget:SetChildActive(libaoItemIndex.dzMask,not openLibao)
widget:SetChildActive(libaoItemIndex.dzLock,not openLibao)
if not openLibao then

widget:SetChildButtonClick(libaoItemIndex.dzMask,function()
local tipsStr=FMT.fmt("弟子“{0}”{1}可解锁",dzName,tmLv_str)
UIManager.error(tipsStr)
end)
end
end


function UISubAct_tianmingzengliWin:setLiBaoDiziTianMingSkillItem(widget,dzData,openLibao,tmLevel)
local dzInfo=dzData.imageInfo
local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(tmLevel,1)
local dzJobId=dzInfo.job
local floor=UIDiscipleModel.getTianMingLevelFloor(tmLevel)
local tmId=dzData.tmList[floor+1]
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmId or 0)
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)


local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,dzJobId,dzData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
widget:SetChildCSImageIcon(libaoItemIndex.skillIcon,skillIconName)
widget:SetChildImageExGray(libaoItemIndex.skillIcon,not openLibao)


widget:SetChildActive(libaoItemIndex.skillLock,not openLibao)

widget:SetChildButtonClick(libaoItemIndex.skillIcon,function()

self:showWindow("UIDiscipleTianMingSkillTipsWin",{
tmId=tmId,
tmState=openLibao,
tmLv=dzNowTmLv,
needFloor=floor,
jobId=dzJobId,
isNotShowButton=true,
})
end)
end

function UISubAct_tianmingzengliWin:setTipsReward(rewards)
local libaoList=rewards
local count=#libaoList
self.tipsRewardScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.tipsRewardScroller:getChildScrollViewItemWidgets()

for i=1,grids.Count do
local widget=grids[i-1]
local itemGrids=widget:GetChildCommonLayoutGroupWidgetList(0)

for i=1,itemGrids.Count do
local itemWidget=itemGrids[i-1]
local rewardData=rewards[i]

if rewardData then
itemWidget:SetChildActive(-1,true)
local itemid=rewardData[1]
local itemcount=rewardData[2]
if not itemcount then
itemcount=0
end
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local colorEffect=rewardData[3]and rewardData[3]==1 or false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=true,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetChildActive(2,true)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
itemWidget:SetChildActive(-1,false)
itemWidget:SetChildActive(2,false)
end
end
end
end


function UISubAct_tianmingzengliWin:setRewardShow(rewards,widget,index)
if not rewards then
return
end

local itemGrids=widget:GetChildCommonLayoutGroupWidgetList(index)
for i=1,itemGrids.Count do
local itemWidget=itemGrids[i-1]
local rewardData=rewards[i]
if rewardData then
itemWidget:SetChildActive(-1,true)
local itemid=rewardData[1]
local itemcount=rewardData[2]
if not itemcount then
itemcount=0
end
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local colorEffect=rewardData[3]and rewardData[3]==1 or false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
itemWidget:SetChildActive(-1,false)
end
end
end

function UISubAct_tianmingzengliWin:refreshDailyReward()

local isGot=self.activityData:reqTianMingZengLi_checkDailyRewardsIsGot()


self.baoXiang:setActive(not isGot)
self.baoXiangOpen:setActive(isGot)
self:doPunchRotation(not isGot)
end




function UISubAct_tianmingzengliWin:onBaoXiang()

local isGot=self.activityData:reqTianMingZengLi_checkDailyRewardsIsGot()
if isGot then

return
end


self.activityData:reqTianMingZengLi_getDailyRewards()
end



function UISubAct_tianmingzengliWin:onBaoXiangOpen()
end


function UISubAct_tianmingzengliWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))



if not timeHelper.isTodayStamp(self.lastRefreshTime)then

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)

return self:refresh()
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_tianmingzengliWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_tianmingzengliWin:getDiscipleData(diziId)
if not diziId then
return
end
if not self.tempDzData then
self.tempDzData={}
end

if self.tempDzData[diziId]then
return self.tempDzData[diziId]
end


local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziId)
if dzData then
self.tempDzData[diziId]=dzData
else

self.tempDzData[diziId]=UIDiscipleModel:getDiscipleDataByDiziId(diziId)
end

return self.tempDzData[diziId]
end


function UISubAct_tianmingzengliWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISubAct_tianmingzengliWin:onLibaoFreeBtn(libaoId,dzId)
local isGot=self.activityData:reqTianMingZengLi_checkFreeLibaoIsGot(libaoId)
if isGot then

return
end


local libaoCfgList=self.config.rewards
local libaoCfg=libaoCfgList[libaoId]
local targetTianmingLv=libaoCfg[2]
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
local openLibao=hasDz and dzNowTmLv>=targetTianmingLv or false

if openLibao then

self.activityData:reqTianMingZengLi_getFreeLibao(libaoId)
else

local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(targetTianmingLv,1)
local tipsStr=FMT.fmt("弟子“{0}”{1}可领取",dzName,tmLv_str)
UIManager.error(tipsStr)
end
end


function UISubAct_tianmingzengliWin:onLibaoBuyBtn(libaoId,dzId)

local libaoCfgList=self.config.rewards
local libaoCfg=libaoCfgList[libaoId]
local targetTianmingLv=libaoCfg[2]
local buyLibaoRechargeId=libaoCfg[5]
local buyLimitCount=libaoCfg[6]

local nowBuyCount=self.activityData:reqTianMingZengLi_getLibaoBuyCount(libaoId)
if buyLimitCount and nowBuyCount>=buyLimitCount then

return
end

local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
local openLibao=hasDz and dzNowTmLv>=targetTianmingLv or false

if openLibao then

self.activityData:reqTianMingZengLi_buyLibao(libaoId,buyLibaoRechargeId,1)
else

local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(targetTianmingLv,1)
local tipsStr=FMT.fmt("弟子“{0}”{1}可购买",dzName,tmLv_str)
UIManager.error(tipsStr)
end
end


function UISubAct_tianmingzengliWin:onUpTianMing()

local dzModelParam=self.config.dzModelParam
if not dzModelParam or not next(dzModelParam)then
logErr(FMT.fmt("活动id: {0}, 活动类型: {1}, 子活动id: {2}找不到弟子展示模型参数数据 请检查配置是否正确",self.activityId,self.subType,self.subId))
return
end
local dzId=dzModelParam.dzId
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil

if hasDz then

local tabType=FULL_TAB_TYPE.eDiscipleTianMing
local subType=self.subType
local subId=self.subId
UIFullCommonControl:jumpDiscipleMain(dzData.discipleguid,tabType,function()
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subId)
if#sub_actList>0 then
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId}},function()
jumpManager:clearJump()
end)
else
UIManager.error("活动已结束")
return UIFullDiscipleMainControl:closeUI()
end
end)
else

local dzName=dzData.disciplename
local tipsStr=FMT.fmt("宗门暂未招收弟子“{0}”",dzName)
UIManager.error(tipsStr)

local jumpArgs=self.config.jumpParam
if jumpArgs then

jumpManager:jump(jumpArgs)
else

local cost=UIDiscipleModel:getUpTianMingCost(dzData)
local itemid=cost[1][1]
return gainControl:showGainWin(itemid)
end
end
end


function UISubAct_tianmingzengliWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setRotation(0,0,0)
end
end
end
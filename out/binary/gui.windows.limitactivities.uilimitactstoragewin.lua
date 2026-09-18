







def_class("UILimitActStorageWin",UIWindowBase)









function UILimitActStorageWin:bindComponents()

self.actContent=UIObject.get(self,0)
self.actListPanel=UIObject.get(self,1)
self.countImg=UIObject.get(self,2)
self.countTex=UIText.get(self,3)
self.root=UIObject.get(self,4)
self.toggleIcon=UIButton.get(self,5)
self.toggleIcon_select=UIObject.get(self,6)
self.toggleReddot=UIImage.get(self,7)

self.toggleIcon:setButtonClick(function()self:onToggleIcon()end)


self.sprite_limitacticon_2=0

end


function UILimitActStorageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actContent);self.actContent=nil;
_UIObject_release(self.actListPanel);self.actListPanel=nil;
_UIObject_release(self.countImg);self.countImg=nil;
_UIObject_release(self.countTex);self.countTex=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.toggleIcon);self.toggleIcon=nil;
_UIObject_release(self.toggleIcon_select);self.toggleIcon_select=nil;
_UIObject_release(self.toggleReddot);self.toggleReddot=nil;
self.toggleIcon=nil;
end
















local _this

local showCondConfig={
[LIMIT_ACT_TYPE.eXianMengDiGong]=function()
local xdl=xianmengdigongModel:getXDL()
local mainShowLimit=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'mainShowLimit')
return xdl~=nil and xdl>=mainShowLimit
end,
[LIMIT_ACT_TYPE.eWenDouLeiTai]=function()
local validOne=poetryArenaModel:findAValidArena()
return validOne~=nil
end,
[LIMIT_ACT_TYPE.eXianFaWenDao]=function()
local check=UIXianFaWenDaoControl:checkUnlock(true)
return check
end,
[LIMIT_ACT_TYPE.eLingXuWenJian]=function()
local check=lingxuwenjianModel:checkInAttack()
return check
end,
[LIMIT_ACT_TYPE.eYiYuHuiYou]=function()
local check=YiYuHuiYouController:checkYYHYActivityIcon()
return check
end,
}

local showTipsConfig={
[LIMIT_ACT_TYPE.eTianYuanShouChao]=function()
local guid=xianmengModel:getCanChallengeBoss()
if guid~=nil then
return'image_shoulingchuxian',0,45
end
end,
[LIMIT_ACT_TYPE.eLingXuWenJian]=function(data)
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eStandby then
return'icon_beizhan',-31,14
elseif raceState==eLXWJ_State.eFight then
return'icon_kaizhan',-31,14
end
end,
[LIMIT_ACT_TYPE.eLeiTaiYanWu]=function(data)
local isDoing=xianJieArenaActModel:checkIsXJArenaActDoing()
if not isDoing then
return'image_yugao_1',-23,20,globalABLookup.global,0.8
end
end,
[LIMIT_ACT_TYPE.eXianGuanWuXuan]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eRegister then
return'image_xianguanzjm_1',0,37.5,globalABLookup.globa4,1
elseif segment==XianGuanWuXuanSegment.eReady then
return'image_xianguanzjm_3',0,37.5,globalABLookup.globa4,1
elseif segment==XianGuanWuXuanSegment.eMatch then
return'image_xianguanzjm_2',0,37.5,globalABLookup.globa4,1
end
end,
[LIMIT_ACT_TYPE.eXianGuanWenXuan]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
if segment==XianGuanWenXuanSegment.eRegister then
return'image_xianguanzjm_1',0,37.5,globalABLookup.globa4,1
elseif segment==XianGuanWenXuanSegment.eVote then
return'image_xianguanzjm_2',0,37.5,globalABLookup.globa4,1
end
end,
[LIMIT_ACT_TYPE.eXianJieXingYu]=function(data)
local xingyuList=XingYuModel:getXingYuIdList()
if not xingyuList then
return
end
local state,endTime=XingYuController.getXingYuState(xingyuList[1])
if state==XingYuState.eTanSuo then
return'image_tubiaobiaoqian_1',2.2,41.2,"ui/windows/xingyu/xingyu_atlas_pak.ab"
elseif state==XingYuState.eHunZhan then
return'image_tubiaobiaoqian_2',2.2,41.2,"ui/windows/xingyu/xingyu_atlas_pak.ab"
elseif state==XingYuState.eZhenDuo then
return'image_tubiaobiaoqian_3',2.2,41.2,"ui/windows/xingyu/xingyu_atlas_pak.ab"
end
end,
[LIMIT_ACT_TYPE.eXianGuanWuXuan_BW]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eRegister then
return'image_xianguanzjm_1',0,37.5,globalABLookup.globa4,1
elseif segment==XianGuanWuXuanSegment.eReady then
return'image_xianguanzjm_3',0,37.5,globalABLookup.globa4,1
elseif segment==XianGuanWuXuanSegment.eMatch then
return'image_xianguanzjm_2',0,37.5,globalABLookup.globa4,1
end
end,
[LIMIT_ACT_TYPE.eXianGuanWenXuan_BW]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
if segment==XianGuanWenXuanSegment.eRegister then
return'image_xianguanzjm_1',0,37.5,globalABLookup.globa4,1
elseif segment==XianGuanWenXuanSegment.eVote then
return'image_xianguanzjm_2',0,37.5,globalABLookup.globa4,1
end
end,
[LIMIT_ACT_TYPE.eMoGongZhengDuo]=function(data)
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
if actInfo.state==limitActivitiesModel.actPreviewState then
return'icon_yugao',-31,14,globalABLookup.globa4,1
end
end,
}
local showTipsConfig2={
[LIMIT_ACT_TYPE.eXianGuanWuXuan]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eRegister then
return"报名中",0,41
elseif segment==XianGuanWuXuanSegment.eReady then
return"即将开始",0,41
elseif segment==XianGuanWuXuanSegment.eMatch then
return"竞选中",0,41
end
end,
[LIMIT_ACT_TYPE.eXianGuanWenXuan]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
if segment==XianGuanWenXuanSegment.eRegister then
return"报名中",0,41
elseif segment==XianGuanWenXuanSegment.eVote then
return"投票中",0,41
end
end,
[LIMIT_ACT_TYPE.eXianGuanWuXuan_BW]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eRegister then
return"报名中",0,41
elseif segment==XianGuanWuXuanSegment.eReady then
return"即将开始",0,41
elseif segment==XianGuanWuXuanSegment.eMatch then
return"竞选中",0,41
end
end,
[LIMIT_ACT_TYPE.eXianGuanWenXuan_BW]=function(data)
local segment=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
if segment==XianGuanWenXuanSegment.eRegister then
return"报名中",0,41
elseif segment==XianGuanWenXuanSegment.eVote then
return"投票中",0,41
end
end,
}

local showTimeConfig={
[LIMIT_ACT_TYPE.eLingXuWenJian]=function(data)
local check,left=lingxuwenjianModel:checkInAttack()
if check then
local str=FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
return str
end
return nil
end,
[LIMIT_ACT_TYPE.eXianGuanWuXuan]=function(data)
local segmentData=xianguanController:getActivitySegmentData_WuXuan_Compatible()
if segmentData then
local segment=segmentData.status
local nowTime=timeHelper.getServerShortTime()
if segment==XianGuanWuXuanSegment.eRegister then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWuXuanSegment.eReady then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWuXuanSegment.eMatch then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWuXuanSegment.eBwWait then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#c82c2c>{0}</color>后开启',timeHelper.format_time_stamp3(left))
end
end
return nil
end,
[LIMIT_ACT_TYPE.eXianGuanWenXuan]=function(data)
local segmentData=xianguanController:getActivitySegmentData_WenXuan_Compatible()
if segmentData then
local segment=segmentData.status
local nowTime=timeHelper.getServerShortTime()
if segment==XianGuanWenXuanSegment.eRegister then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWenXuanSegment.eVote then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWenXuanSegment.eBwWait then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#c82c2c>{0}</color>后开启',timeHelper.format_time_stamp3(left))
end
end
return nil
end,
[LIMIT_ACT_TYPE.eXianGuanWuXuan_BW]=function(data)
local segmentData=xianguanController:getActivitySegmentData_WuXuan_Compatible()
if segmentData then
local segment=segmentData.status
local nowTime=timeHelper.getServerShortTime()
if segment==XianGuanWuXuanSegment.eRegister then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWuXuanSegment.eReady then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWuXuanSegment.eMatch then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWuXuanSegment.eBwWait then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#f36666>{0}后开启</color>',timeHelper.format_time_stamp12(left))
end
end
return nil
end,
[LIMIT_ACT_TYPE.eXianGuanWenXuan_BW]=function(data)
local segmentData=xianguanController:getActivitySegmentData_WenXuan_Compatible()
if segmentData then
local segment=segmentData.status
local nowTime=timeHelper.getServerShortTime()
if segment==XianGuanWenXuanSegment.eRegister then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWenXuanSegment.eVote then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
elseif segment==XianGuanWenXuanSegment.eBwWait then
local left=math.max(segmentData.endTime-nowTime,0)
return FMT.fmt('<color=#f36666>{0}后开启</color>',timeHelper.format_time_stamp12(left))
end
end
return nil
end,
}

local _ExTipsLookup={
[LIMIT_ACT_TYPE.eMoGongZhengDuo]={
getRightUpTipsInfo=function()
return globalABLookup.global,'button_tygantanhao_3',0.8
end,
}
}

local _itemPreClickLookup={
[LIMIT_ACT_TYPE.eMoGongZhengDuo]={
onClick=function()
local result=limitActivitiesModel:checkActPreview(LIMIT_ACT_TYPE.eMoGongZhengDuo)
if result then
local args={
ruleGroupID=ruleTipsImageGroup.eMoGongZhengDuo,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end
return result
end,
}
}

local showReddotConfig={
[LIMIT_ACT_TYPE.eLingXuWenJian]=true,
}

local mojun_abname='ui/windows/limitactivities/limitacticons_atlas_pak.ab'

local getButtonIsActivated=function(button)
return button:GetChildActiveSelf(-1)
end

local funcBtnViewMaxWidth=500
local buttonWidth=105
local buttonSpacing=0
local buttonScollSpacing_left=20
local buttonScollSpacing_right=74
local maxShowBtnCount=3


local limitActButtonHandler={
[LIMIT_ACT_TYPE.eTianYuanShouChao]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,



refreshState=function(self,uiBase)
local monsterChallengeCount=xianmengModel:getChallengeNum1_TYSC()
local bossDataList=xianmengModel:getBossDataList_TYSC()
if monsterChallengeCount==0 then
local hasChallengeChance=false
for _,data in pairs(bossDataList)do
if xianmengModel:getChallengeNum3_TYSC(data.guid)>0 then
hasChallengeChance=true
end
end
local hasRewards=xianmengModel:checkRankReddot_TYSC()
local hideButton=not hasChallengeChance and not hasRewards

if hideButton then
self.baseButton:SetChildActive(-1,false)
end
end
end
},
[LIMIT_ACT_TYPE.eShiJieShouLing]={
baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
local hasChallengeChance=worldLeaderModel:hasChallengeCount_canBuy()
if not hasChallengeChance then
self.baseButton:SetChildActive(-1,false)
end
end
},
[LIMIT_ACT_TYPE.eXianJieFuMo]={
baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
local hasChallengeChance=XianJieFuMoController:getReddot(true)
if not hasChallengeChance then
self.baseButton:SetChildActive(-1,false)
end
end
},
[LIMIT_ACT_TYPE.eWenDouLeiTai]={
baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
local validOne=poetryArenaModel:findAValidArena()
if not validOne then
self.baseButton:SetChildActive(-1,false)
end
end
},
[LIMIT_ACT_TYPE.eYiYuHuiYou]={
baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
local hasChallengeChance=YiYuHuiYouController:tiaozhanNumReddot2()
local hasRewards=YiYuHuiYouController:yyhyRankReddot()

if not hasChallengeChance and not hasRewards then
self.baseButton:SetChildActive(-1,false)
end
end
},
[LIMIT_ACT_TYPE.eMiaoXingShangLv]={
baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
local baseCfg=cfgHelper.get(cfg_miaoxingshanglvbaseconfig_get,1)
local maxGetTimes=baseCfg and baseCfg.daily_times or 0
local getTimes=xianJieCaravanEscortModel:getSelfEscortData_getTimes()
local maxRobTimes=baseCfg and baseCfg.rob_times or 0
local robTimes=xianJieCaravanEscortModel:getSelfEscortData_robTimes()
if(maxGetTimes-getTimes)<=0 and(maxRobTimes-robTimes)<=0 then
self.baseButton:SetChildActive(-1,false)
end
end
},

}

local registerFuncButton=function(key,button)
local handler=limitActButtonHandler[key]
if handler then
handler.baseButton=button
end
end



function UILimitActStorageWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange)
self:addNotify(notifyConfig.onXiaoZhuShouFinish,self.onXiaoZhuShouFinish)
self:addNotify(notifyConfig.onXiaoZhuShouStop,self.onXiaoZhuShouStop)
self:startYiYuHuiYouWeakguid()
end


function UILimitActStorageWin:__delete()
self:endAllReddotPunchRotation()
self:unbindComponents()
_this=nil
self:clearActTimer()
self:clearFLTweener()
end


function UILimitActStorageWin:onHide()
self:endAllReddotPunchRotation()
end

function UILimitActStorageWin.onLimitActOpen(actID,flag)
if _this==nil then return end
if _this.actLookup[actID]==nil then return end

_this:refreshView()
end

function UILimitActStorageWin.onLimitActStateChange(actID,state)
if _this==nil then return end
local actcfg=limitActivitiesModel:getActConfig(actID)
if actcfg.hideInMain then
return
end

_this:refreshView()

if state==limitActivitiesModel.actDoingState and actID==LIMIT_ACT_TYPE.eYiYuHuiYou then
_this:startYiYuHuiYouWeakguid()
end
end

function UILimitActStorageWin.onLimitActReddotChange(actID)
if _this==nil then return end

local data=_this.dataLookup and _this.dataLookup[actID]or nil
if data then
data.isReddot=limitActivitiesModel:getActReddot(actID)
local idx=_this:findActItemIndex(actID)
if idx then
_this:refreshActItemReddot(nil,idx)
end
end
end

function UILimitActStorageWin.onXiaoZhuShouFinish()
_this:quickRefresh()
end

function UILimitActStorageWin.onXiaoZhuShouStop()
_this:quickRefresh()
end

function UILimitActStorageWin:startYiYuHuiYouWeakguid()
if self.weakTimer then
self:stopTimerByID(self.weakTimer)
end
self.weakTimer=self:delayDo(3,function()
self.weakTimer=nil
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eYiYuHuiYou)then
weakGuideController:beginGuide(1167,nil,false)
end
end)
end

function UILimitActStorageWin:refreshCondShow(actID)
local condFunc=showCondConfig[actID]
if condFunc==nil then return end

if _this==nil or _this.dataLookup==nil then return end

local needRefresh=false
local data=_this.dataLookup[actID]
local checkcond=condFunc()
if checkcond then
if data==nil then
needRefresh=true
end
else
if data~=nil then
needRefresh=true
end
end
if needRefresh then
self:refreshView()
end
end

function UILimitActStorageWin:refreshTipsShow(actID)
local idx=self:findActItemIndex(actID)
if idx then
self:refreshActItemReddot(nil,idx)
end
end




function UILimitActStorageWin:onShow(argtable,afterOnloaded)
self:refreshView()
end

function UILimitActStorageWin:refreshView()
self:endAllReddotPunchRotation()
self:refreshToggle()
self:refreshActListPanel()
self:quickRefresh()
end

function UILimitActStorageWin:getSortActList()
local actlist=limitActivitiesModel:getActList_show()
local dataList={}
local actLookup={}
for i,actInfo in ipairs(actlist)do
local actcfg=actInfo:getActConfig()
if not actcfg.hideInMain then
local actID=actInfo:getActID()
local checkcond=true
local condFunc=showCondConfig[actID]
if condFunc then
checkcond=condFunc()
end
if checkcond then
local d={}
d.actID=actInfo:getActID()
d.state=actInfo:getStateEx()
if d.state==limitActivitiesModel.actPreviewState then
d.left=actInfo:getStartLeftTime()
elseif d.state==limitActivitiesModel.actDoingState then
d.left=actInfo:getEndLeftTime()
end
d.isReddot=actInfo:getRoddot()
table.insert(dataList,d)
end
actLookup[actID]=true
end
end
if#dataList>1 then
table.sort(dataList,function(a,b)
if a.state==b.state then
return a.left<b.left
else
return a.state>b.state
end
end)
end
self.dataList=dataList
local lookup={}
for i,data in ipairs(dataList)do
lookup[data.actID]=data
end
self.dataLookup=lookup
self.actLookup=actLookup
end

function UILimitActStorageWin:refreshToggle()
self:getSortActList()
local isshow=#self.dataList>0
self.root:setActive(isshow)
if isshow then
local isShowActList=limitActivitiesController:getIsShowActList()
if isShowActList then
self.actListPanel:setChildCanvasGroupAlpha(1)
self.actListPanel:setActive(true)

else
self.actListPanel:setChildCanvasGroupAlpha(0)
self.actListPanel:setActive(false)

end
self.toggleIcon_select:setActive(isShowActList)
self:refreshToggleReddot(isShowActList)


UIManager:invokeUIMethod("UIMain","freshSimpleBtn")
end
end

function UILimitActStorageWin:findActItemIndex(actID)
for idx,data in ipairs(self.dataList)do
if data.actID==actID then
return idx
end
end
return nil
end

function UILimitActStorageWin:refreshActTimer()
local num=#self.dataList
local isShowActTimer=num>0
if isShowActTimer then
if self.actTimer==nil then
self.actTimer=self:setTimer(1,0,function()
if _this==nil then return end
_this:onActUpdata()
end)
end
else
self:clearActTimer()
end
end

function UILimitActStorageWin:clearActTimer()
if self.actTimer~=nil then
self:stopTimerByID(self.actTimer)
self.actTimer=nil
end
end

function UILimitActStorageWin:onActUpdata()
for idx,data in ipairs(self.dataList)do
self:refreshActItemTime(nil,idx)
end
end

function UILimitActStorageWin:refreshToggleReddot(isShowActList)
local isReddot=false
if not isShowActList then

for i,data in ipairs(self.dataList or{})do
if data.isReddot==true then
isReddot=true
break
end
end
end
self.toggleReddot:setActive(isReddot)
self:doPunchRotation(self.widget,self.toggleReddot:getID(),100,isReddot)
end

function UILimitActStorageWin:refreshActListPanel()
local num=#self.dataList
self.actContent:setChildLayoutGroupCreateItems(num)
local grids=self.actContent:getChildLayoutGroupGridList()
for idx=1,num do
local item=grids[idx-1]
self:refreshActItem(item,idx)
item:SetChildButtonClick(5,function()
if _this==nil then return end
if _this:onActItemPreClick(idx)then return end
_this:onActItemClick(idx)
end)
end
self:refreshActTimer()
end

function UILimitActStorageWin:onActItemPreClick(idx)
local data=self.dataList[idx]
local actID=data.actID
local preClick=_itemPreClickLookup[actID]
local doNext=false
if preClick then
doNext=preClick.onClick()
end
return doNext
end

function UILimitActStorageWin:refreshActItem(item,idx)
if item==nil then
item=self.actListPanel:getChildLayoutGroupGridItem(idx-1)
end
local data=self.dataList[idx]
registerFuncButton(data.actID,item)
local actCfg=limitActivitiesModel:getActConfig(data.actID)

local abName,icon_name=limitActivitiesModel.getActIcon(actCfg.icon)
item:SetChildCSImageSprite(0,abName,icon_name)

if actCfg.id==LIMIT_ACT_TYPE.eMoJieMoJun then
local MJZJID=xianjieModel:getMoJunZhangJieID()
if MJZJID and MJZJID==MoJunZhangJieID.two then
item:SetChildCSImageSprite(0,mojun_abname,'act_entericon_96')
end
end

item:SetChildText(1,actCfg.name)

self:refreshActItemTime(item,idx)

self:refreshActItemReddot(item,idx)

self:refreshActExTips(item,idx)

item:SetChildWeakGuideComponentId(-1,FMT.fmt('UILimitActStorageWin.actListPanel.{0}',data.actID))
end

function UILimitActStorageWin:refreshActExTips(item,idx)
local data=self.dataList[idx]
local actID=data.actID

local extips=_ExTipsLookup[actID]
if extips==nil then
item:SetChildActive(8,false)
return
end

item:SetChildActive(8,extips.getRightUpTipsInfo~=nil)
if extips.getRightUpTipsInfo then
local ab,iconName,scale=extips.getRightUpTipsInfo()
item:SetChildCSImageSprite(8,ab,iconName)
item:SetChildScale(8,Vector3(scale,scale,scale))
end
end

function UILimitActStorageWin:refreshActItemReddot(item,idx)
if item==nil then
item=self.actContent:getChildLayoutGroupGridItem(idx-1)
end
local data=self.dataList[idx]
local actID=data.actID

local tipIcon=nil
local x,y
local abName
local scale
local tipsFunc=showTipsConfig[actID]
if tipsFunc~=nil then
tipIcon,x,y,abName,scale=tipsFunc()
end
local showTips=tipIcon~=nil
item:SetChildActive(6,showTips)
if showTips then
abName=abName or globalABLookup.mainwin
item:SetChildCSImageSprite(6,abName,tipIcon)
item:SetChildLocalPosition(6,Vector3(x or 0,y or 0,0))
scale=scale or 1
item:SetChildScale(6,Vector3(scale,scale,scale))
end

local tipsFunc2=showTipsConfig2[actID]
local tipStr,x2,y2
if tipsFunc2~=nil then
tipStr,x2,y2=tipsFunc2()
end

item:SetChildText(7,tipStr or"")
item:SetChildLocalPosition(7,Vector3(x2 or 0,y2 or 0,0))

local data=self.dataList[idx]
local isReddot=data.isReddot
local showReddot=isReddot and(not showTips or showReddotConfig[actID])
item:SetChildActive(4,showReddot)
self:doPunchRotation(item,4,idx,showReddot)
end

function UILimitActStorageWin:getActTimeStr(data)
local time_str
local left
if data.state==limitActivitiesModel.actPreviewState then
left=limitActivitiesModel:getActStartLeftTime(data.actID)
elseif data.state==limitActivitiesModel.actDoingState then
left=limitActivitiesModel:getActEndLeftTime(data.actID)
end
if left~=nil and left>0 then
if data.state==limitActivitiesModel.actPreviewState then
time_str=FMT.fmt('<color=#b39d68>{0}后开启</color>',timeHelper.format_time_stamp12(left))
elseif data.state==limitActivitiesModel.actDoingState then
time_str=FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
end
end
return time_str
end

function UILimitActStorageWin:refreshActItemTime(item,idx)
if item==nil then
item=self.actContent:getChildLayoutGroupGridItem(idx-1)
end
local data=self.dataList[idx]
local time_str
local actID=data.actID
local func=showTimeConfig[actID]
if func then
time_str=func(data)
else
time_str=self:getActTimeStr(data)
end
local showTime=time_str~=nil
item:SetChildActive(2,showTime)
if showTime then
item:SetChildText(3,time_str)
end
end

function UILimitActStorageWin:onActItemClick(idx)
local data=self.dataList[idx]
local actID=data.actID
limitActivitiesController:jump(actID)
end

function UILimitActStorageWin:clearFLTweener()
if self.flTweener then
self.flTweener:Kill()
self.flTweener=nil
end
end

function UILimitActStorageWin:onToggleIcon()
self:clearFLTweener()
local isShowActList=not limitActivitiesController:getIsShowActList()
self:changeActListShow(isShowActList)
end

function UILimitActStorageWin:changeActListShow(isShow)
local isShowActListNow=limitActivitiesController:getIsShowActList()
if isShowActListNow==isShow then
return
end

self:clearFLTweener()
if isShow then
self.actListPanel:setActive(true)
self.flTweener=self.actListPanel:setChildCanvasGroupDOFade(1,0.5,nil)
else
self.flTweener=self.actListPanel:setChildCanvasGroupDOFade(0,0.5,function()
if _this==nil then return end
_this.actListPanel:setActive(false)
end)
end
self.toggleIcon_select:setActive(isShow)
limitActivitiesController:setIsShowActList(isShow)

self:refreshToggleReddot(isShow)


UIManager:invokeUIMethod("UIMain","freshSimpleBtn")
end






function UILimitActStorageWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UILimitActStorageWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then

v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)
end
end
self.reddotTweenerList=nil
end





function UILimitActStorageWin:quickRefresh()
self:handleLimitActButtonVisibility()
self:updateCountIconDisplay()
end

function UILimitActStorageWin:handleLimitActButtonVisibility()
local list=self.dataList
if list==nil then
return
end
local visibleBtnCount=#list
for _,data in pairs(list)do
local handler=limitActButtonHandler[data.actID]
if handler then
handler:refreshState(self)
end
end

for _,data in pairs(list)do
local handler=limitActButtonHandler[data.actID]
if handler and not handler:isActive()then
visibleBtnCount=visibleBtnCount-1
end
end

self.visibleBtnCount=visibleBtnCount

local viewWidth=self:getFuncBtnViewWidth(visibleBtnCount)
self.actListPanel:setChildSizeDelta(viewWidth,80)
end

function UILimitActStorageWin:getFuncBtnViewWidth(buttonCount)
local width=buttonScollSpacing_left+buttonScollSpacing_right
local showBtnCount=math.min(buttonCount,maxShowBtnCount)
for i=1,showBtnCount do
width=width+buttonWidth+buttonSpacing
end

if buttonCount>3 then
width=width+buttonWidth/2
end

width=math.max(90,math.min(width,funcBtnViewMaxWidth))
return width
end

function UILimitActStorageWin:updateCountIconDisplay()
if self.visibleBtnCount~=nil then
self.countImg:setActive(self.visibleBtnCount>3)
self.countTex:setText(self.visibleBtnCount)
end
end

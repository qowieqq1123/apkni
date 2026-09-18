







def_class("UIXianJieLimitActStorageWin",UIWindowBase)









function UIXianJieLimitActStorageWin:bindComponents()

self.root=UIObject.get(self,0)
self.toggleIcon=UIButton.get(self,1)
self.toggleReddot=UIImage.get(self,2)
self.actListPanel=UIObject.get(self,3)
self.toggleIconSelect=UIObject.get(self,4)

self.toggleIcon:setButtonClick(function()self:onToggleIcon()end)



end


function UIXianJieLimitActStorageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.toggleIcon);self.toggleIcon=nil;
_UIObject_release(self.toggleReddot);self.toggleReddot=nil;
_UIObject_release(self.actListPanel);self.actListPanel=nil;
_UIObject_release(self.toggleIconSelect);self.toggleIconSelect=nil;
end
















local _this
local _simpleKey="UIXianJieLimitActStorageWin.actListPanel"

local showCondConfig={

}

local showTipsConfig={
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

local showTimeConfig={
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
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
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
return FMT.fmt('<color=#a1ec58>{0}</color>',timeHelper.format_time_stamp3(left))
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
local mojun_abname='ui/windows/limitactivities/limitacticons_atlas_pak.ab'




function UIXianJieLimitActStorageWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange)

self:addNotify(notifyConfig.onXianJieMainWinSimpleStateChange,self.onXianJieMainWinSimpleStateChange)
end


function UIXianJieLimitActStorageWin:__delete()
_this=nil
self:unbindComponents()
self:clearActTimer()
self:clearFLTweener()
end




function UIXianJieLimitActStorageWin:onShow(argtable,afterOnloaded)
self:refreshView()
end


function UIXianJieLimitActStorageWin:onHide()

end


function UIXianJieLimitActStorageWin.onLimitActOpen(actID,flag)
if _this==nil then return end
if _this.actLookup[actID]==nil then return end

_this:refreshView()
end

function UIXianJieLimitActStorageWin.onLimitActStateChange(actID,state)
if _this==nil then return end
local actcfg=limitActivitiesModel:getActConfig(actID)
if not actcfg.showInXianJieMain then
return
end

_this:refreshView()
end

function UIXianJieLimitActStorageWin.onLimitActReddotChange(actID)
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

function UIXianJieLimitActStorageWin.onXianJieMainWinSimpleStateChange()
_this:refreshToggle()
end

function UIXianJieLimitActStorageWin:refreshView()
self:refreshToggle()
self:refreshActListPanel()
end

function UIXianJieLimitActStorageWin:refreshCondShow(actID)
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

function UIXianJieLimitActStorageWin:refreshTipsShow(actID)
local idx=self:findActItemIndex(actID)
if idx then
self:refreshActItemReddot(nil,idx)
end
end

function UIXianJieLimitActStorageWin:getSortActList()
local actlist=limitActivitiesModel:getActList_show()
local dataList={}
local actLookup={}
for i,actInfo in ipairs(actlist)do
local actcfg=actInfo:getActConfig()
if actcfg.showInXianJieMain then
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

function UIXianJieLimitActStorageWin:refreshToggle()
self:getSortActList()
local isshow=#self.dataList>0
self.root:setActive(isshow)
if isshow then

local isShowActList=not xianjieMainWinSimpleModeConfig:getRecordState(_simpleKey)

if isShowActList then
self.actListPanel:setChildCanvasGroupAlpha(1)
self.actListPanel:setActive(true)

else
self.actListPanel:setChildCanvasGroupAlpha(0)
self.actListPanel:setActive(false)

end
self.toggleIconSelect:setActive(isShowActList)
self:refreshToggleReddot(isShowActList)


UIManager:invokeUIMethod("UIXianJieMainWin","freshSimpleBtn")
end
end

function UIXianJieLimitActStorageWin:findActItemIndex(actID)
for idx,data in ipairs(self.dataList)do
if data.actID==actID then
return idx
end
end
return nil
end

function UIXianJieLimitActStorageWin:refreshActTimer()
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

function UIXianJieLimitActStorageWin:clearActTimer()
if self.actTimer~=nil then
self:stopTimerByID(self.actTimer)
self.actTimer=nil
end
end

function UIXianJieLimitActStorageWin:onActUpdata()
for idx,data in ipairs(self.dataList)do
self:refreshActItemTime(nil,idx)
end
end

function UIXianJieLimitActStorageWin:refreshToggleReddot(isShowActList)
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
end

function UIXianJieLimitActStorageWin:refreshActListPanel()
local num=#self.dataList
self.actListPanel:setChildLayoutGroupCreateItems(num)
local grids=self.actListPanel:getChildLayoutGroupGridList()
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

function UIXianJieLimitActStorageWin:onActItemPreClick(idx)
local data=self.dataList[idx]
local actID=data.actID
local preClick=_itemPreClickLookup[actID]
local doNext=false
if preClick then
doNext=preClick.onClick()
end
return doNext
end

function UIXianJieLimitActStorageWin:refreshActItem(item,idx)
if item==nil then
item=self.actListPanel:getChildLayoutGroupGridItem(idx-1)
end
local data=self.dataList[idx]
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

item:SetChildWeakGuideComponentId(-1,FMT.fmt('UIXianJieLimitActStorageWin.actListPanel.{0}',data.actID))
end

function UIXianJieLimitActStorageWin:refreshActExTips(item,idx)
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

function UIXianJieLimitActStorageWin:refreshActItemReddot(item,idx)
if item==nil then
item=self.actListPanel:getChildLayoutGroupGridItem(idx-1)
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
local showReddot=isReddot and not showTips
item:SetChildActive(4,showReddot)
end

function UIXianJieLimitActStorageWin:getActTimeStr(data)
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

function UIXianJieLimitActStorageWin:refreshActItemTime(item,idx)
if item==nil then
item=self.actListPanel:getChildLayoutGroupGridItem(idx-1)
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

function UIXianJieLimitActStorageWin:clearFLTweener()
if self.flTweener then
self.flTweener:Kill()
self.flTweener=nil
end
end

function UIXianJieLimitActStorageWin:changeActListShow()
local isShow=not xianjieMainWinSimpleModeConfig:changeRecordState(_simpleKey)

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
self.toggleIconSelect:setActive(isShow)
limitActivitiesController:setIsShowActList(isShow)

self:refreshToggleReddot(isShow)


UIManager:invokeUIMethod("UIXianJieMainWin","freshSimpleBtn")
end





function UIXianJieLimitActStorageWin:onToggleIcon()
self:clearFLTweener()
self:changeActListShow()
end

function UIXianJieLimitActStorageWin:onActItemClick(idx)
local data=self.dataList[idx]
local actID=data.actID
limitActivitiesController:jump(actID)
end

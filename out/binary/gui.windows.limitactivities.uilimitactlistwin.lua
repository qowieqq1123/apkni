







def_class("UILimitActListWin",UIWindowBase)









function UILimitActListWin:bindComponents()

self.actListPanel=UIObject.get(self,0)



end


function UILimitActListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actListPanel);self.actListPanel=nil;
end
















local _this

local stateWeight={
[limitActivitiesModel.actFinishState]=1,
[limitActivitiesModel.actIdleState]=2,
[limitActivitiesModel.actPreviewState]=3,
[limitActivitiesModel.actDoingState]=4,
}

local specialGetStateFunc={
[LIMIT_ACT_TYPE.eLeiTaiYanWu]=function(actInfo)
local params
local check=actInfo:checkCustomCondition()
if not check then
params={}
params.isHideLeft=true
return limitActivitiesModel.actIdleState,params
else
return actInfo:getStateEx(),params
end
end,
[LIMIT_ACT_TYPE.eMoGongZhengDuo]=function(actInfo)
local params
local check1=actInfo:checkCondition()
local check2=actInfo:checkCustomCondition()
if not check1 or not check2 then
params={}
params.isHideLeft=true
return limitActivitiesModel.actIdleState,params
else
return actInfo:getStateEx(),params
end
end,
}


function UILimitActListWin:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end


function UILimitActListWin:__delete()
_this=nil
self:unbindComponents()
self:clearActTimer()

notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end


function UILimitActListWin:onHide()

end

function UILimitActListWin.onLimitActOpen(actID,flag)
if _this==nil then return end
_this:refreshView()
end

function UILimitActListWin.onLimitActStateChange(actID,state)
if _this==nil then return end
_this:refreshView()
end




function UILimitActListWin:onShow(argtable,afterOnloaded)
self:refreshView()
end

function UILimitActListWin:refreshView()
self:refreshActListPanel()
end

function UILimitActListWin:getSortActList()
local actlist=limitActivitiesModel:getActList_show2()
local dataList={}
for i,actInfo in ipairs(actlist)do
local d={}
d.actID=actInfo:getActID()

local spFunc=specialGetStateFunc[d.actID]
local spParams
if spFunc then
d.state,spParams=spFunc(actInfo)
else
d.state=actInfo:getStateEx()
end
d.weight=stateWeight[d.state]
local showleft=false
local isHideLeft=false
if spParams and spParams.isHideLeft~=nil then
isHideLeft=spParams.isHideLeft
end
if d.state==limitActivitiesModel.actDoingState then
d.left=actInfo:getEndLeftTime()
elseif d.state==limitActivitiesModel.actPreviewState or d.state==limitActivitiesModel.actIdleState then
d.left=actInfo:getStartLeftTime()
local isDone=limitActivitiesModel:getActMark_done(d.actID)
if isDone==false and not isHideLeft then
showleft=true
end
else
d.left=0
end
d.showleft=showleft
if not actInfo:checkHideInWin()then
table.insert(dataList,d)
end
end
if#dataList>1 then
table.sort(dataList,function(a,b)
if a.weight==b.weight then
return a.left<b.left
else
return a.weight>b.weight
end
end)
end
self.dataList=dataList
local lookup={}
for i,data in ipairs(dataList)do
lookup[data.actID]=data
end
self.dataLookup=lookup
end

function UILimitActListWin:refreshActListPanel()
self:getSortActList()
local num=#self.dataList
self.actListPanel:setChildLayoutGroupCreateItems(num)
local grids=self.actListPanel:getChildLayoutGroupGridList()
for idx=1,num do
local item=grids[idx-1]
self:refreshActItem(item,idx)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onActItemClick(idx)
end)
end
self:refreshActTimer()
end

function UILimitActListWin:refreshActItem(item,idx)
if item==nil then
item=self.actListPanel:getChildLayoutGroupGridItem(idx-1)
end
local data=self.dataList[idx]
local actCfg=limitActivitiesModel:getActConfig(data.actID)

local iconInfo,iconInfo2=limitActivitiesModel.getActBigIcon(data.actID,2)
item:SetChildCSImageSprite(1,iconInfo[1],iconInfo[2])
item:SetChildCSImageSprite(8,iconInfo2[1],iconInfo2[2])

item:SetChildText(2,actCfg.name)

item:SetChildText(3,actCfg.desc)

local rewardlist=actCfg.reward
local c=#rewardlist
item:SetChildLayoutGroupCreateItems(4,c)
local grids=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local gooditem=grids[i-1]
local itemid=rewardlist[i]
local conf={itemid=itemid,itemcount='',showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
gooditem:SetChildPropData(0,prop)
gooditem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

local dayCond,lerpDay=limitActivitiesModel:checkDayCondition(data.actID)

if dayCond then
local showleft=data.showleft
item:SetChildActive(5,not showleft)
item:SetChildActive(6,showleft)
if showleft then
self:refreshActItemTime(item,idx)
else
local state_name
if data.state==limitActivitiesModel.actDoingState then
state_name='image_huorejinxing_1'
else
state_name='image_zanweikaiqi_1'
end
item:SetChildCSImageSprite(5,globalABLookup.limitacwinicons,state_name)
end
else
item:SetChildActive(5,false)
item:SetChildActive(6,true)
item:SetChildText(6,FMT.fmt('{0}天后可参与',lerpDay))
end


local timestr=limitActivitiesModel.getTimeDesc(actCfg)
item:SetChildText(7,timestr)
end

function UILimitActListWin:refreshActItemTime(item,idx)
if item==nil then
item=self.actListPanel:getChildLayoutGroupGridItem(idx-1)
end
local data=self.dataList[idx]
local left=limitActivitiesModel:getActStartLeftTime(data.actID)
local time_str=FMT.fmt('{0}后开启',timeHelper.format_time_stamp12(left))
item:SetChildText(6,time_str)
end

function UILimitActListWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UILimitActListWin:refreshActTimer()
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

function UILimitActListWin:clearActTimer()
if self.actTimer~=nil then
self:stopTimerByID(self.actTimer)
self.actTimer=nil
end
end

function UILimitActListWin:onActUpdata()
for idx,data in ipairs(self.dataList)do
local actID=data.actID
if limitActivitiesModel:checkDayCondition(actID)and data.showleft then
self:refreshActItemTime(nil,idx)
end
end
end

function UILimitActListWin:onActItemClick(idx)
local data=self.dataList[idx]
local actID=data.actID
local extraParams=nil
if actID==10005 then

extraParams={ZZSHshopshow=true}
elseif actID==LIMIT_ACT_TYPE.eXianJieXingYu then
extraParams={limitActListWin=true}
end
limitActivitiesController:jump(actID,extraParams)
end
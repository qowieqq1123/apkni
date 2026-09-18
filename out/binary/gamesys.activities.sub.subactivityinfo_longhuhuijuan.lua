







local subActivityInfo_longhuhuijuan={name='longhuhuijuan'}

function subActivityInfo_longhuhuijuan:onInit()
self:listenNotify(notifyConfig.on_mystery_event_new,function(...)
self:onMysteryEventNew(...)
end)

self.resumeCB=function()
if self.act_id then
activitiesController:jump(self.act_id,self.sub_act_type,self.sub_act_id)
end
end

self:initBuff()
end

function subActivityInfo_longhuhuijuan:checkReddot()

local plotConfig=self:getSubActConfig('plot')
local today=self:getStart2NowDay()
for id,cfg in ipairs(plotConfig)do
local open,t=self:checkPlotOpenCfg(id,cfg,today)

if open then
local zhenJi=self:getPlotZhenJi(id)
if zhenJi then
local zjId=zhenJi[2]
if self:checkZhenJiFix(zjId)then
return true
end
end
end

if t==3 then
return true
end
end

local progress=self:getProgress()
local active_reward=self:getSubActConfig('active_reward')
local max=active_reward[1]
if progress>=max and not self:isGuBaoGot()then
return true
end

if self:getMainEvent()then
return true
end

local lineEvents=self:getLineEvents()
if lineEvents and next(lineEvents)then
return true
end

return false
end

function subActivityInfo_longhuhuijuan:getMapIndex()

local plotConfig=self:getSubActConfig('plot')
local today=self:getStart2NowDay()
for id,cfg in ipairs(plotConfig)do
local open,t=self:checkPlotOpenCfg(id,cfg,today)
if t==3 then
return id
end
end

return self:getPlotMaxid()
end

function subActivityInfo_longhuhuijuan:checkZhenJiFix(zjId)
local cfg=cfgHelper.get(cfg_longhuhuijuaneventconfig_get,zjId)
local repair=cfg.repair


local idx=self:getRepairEventProgress(zjId)
local nextCfg=repair[idx+1]
if nextCfg then
local cailiaoList=nextCfg[1]
local isEnough=true
for i,v in ipairs(cailiaoList)do
local count=itemsModel.getCount(v[1])
if count<v[2]then
isEnough=false
break
end
end
if isEnough then
return true
end
end
end











function subActivityInfo_longhuhuijuan:checkPlotOpen(id)

local plotConfig=self:getSubActConfig('plot')
local today=self:getStart2NowDay()
local cfg=plotConfig[id]
return self:checkPlotOpenCfg(id,cfg,today)
end

function subActivityInfo_longhuhuijuan:getPlotMaxid()
if not self.data then return 0 end
return self.data.plot_max_id or 0
end

function subActivityInfo_longhuhuijuan:checkPlotOpenCfg(id,cfg,today)
if not self.data then return end
local finishMainIdx=self.data.main_event_num or 0

if cfg[1]>today then
return false,1
end
if cfg[2]>finishMainIdx then
return false,2
end

if id>(self.data.plot_max_id or 0)then
return false,3
end

return true
end

function subActivityInfo_longhuhuijuan:getMainEvent()
if not self.data then return end
local today=self:getStart2NowDay()
local main_events=self:getSubActConfig('main_events')
local mainLineIdx=0
local finishMainIdx=self.data.main_event_num or 0
for i,v in ipairs(main_events)do
if i>today then
break
end

for ii,vv in ipairs(v)do
mainLineIdx=mainLineIdx+1

if mainLineIdx>finishMainIdx then
return vv,i,ii
end
end
end
end

function subActivityInfo_longhuhuijuan:getMainEventCfg(index)
local main_events=self:getSubActConfig('main_events')or{}
local mainLineIdx=0
for i,v in ipairs(main_events)do
for ii,vv in ipairs(v)do
mainLineIdx=mainLineIdx+1
if mainLineIdx==index then
return vv
end
end
end
end

function subActivityInfo_longhuhuijuan:getLineEvents()
if not self.data then return end
local today=self:getStart2NowDay()
local finishMainIdx=self.data.main_event_num or 0
local line_events=self:getSubActConfig('line_events')

local eventList={}
for i,v in ipairs(line_events)do
if v[2]<=today and finishMainIdx>=v[1]then
for ii,vv in ipairs(v[3])do
if not self:isLineEventFinish(i,ii)then
table.insert(eventList,{i,ii,vv})
break
end
end
end
end
return eventList
end

function subActivityInfo_longhuhuijuan:getProgress()
if not self.data then
return 0
end
return self.data.progress
end

function subActivityInfo_longhuhuijuan:isGuBaoGot()
if not self.data then
return false
end
return self.data.has_recv==1
end

function subActivityInfo_longhuhuijuan:isLineEventFinish(idx,lineIdx)
if(not self.data)or(not self.data.lineBits)or(not self.data.lineBits[idx])then return false end
return bitHelper.check_pos(self.data.lineBits[idx],lineIdx-1)
end

function subActivityInfo_longhuhuijuan:setLineEventFinish(idx,lineIdx)
if(not self.data)then return end
if not self.data.lineBits then
self.data.lineBits={}
end
if not self.data.lineBits[idx]then
self.data.lineBits[idx]=0
end
self.data.lineBits[idx]=bitHelper.set_1(self.data.lineBits[idx],lineIdx-1)
end

function subActivityInfo_longhuhuijuan:addMainEventNum()
self.data.main_event_num=self.data.main_event_num+1
end

function subActivityInfo_longhuhuijuan:getPlotAct(id)
local max=self:getPlotMaxid()
if id>max then
return
end
local active_act=self:getSubActConfig('active_act')
if active_act[id]then
local cfg=active_act[id]
local today=self:getStart2NowDay()
local finishMainIdx=self.data.main_event_num or 0
if today>=cfg[3]and finishMainIdx>=cfg[4]then
return cfg
end
end
end

function subActivityInfo_longhuhuijuan:initBuff()
self.buffPlotList={}
local main_events=self:getSubActConfig('main_events')
local mainLineIdx=0
for i,v in ipairs(main_events)do
for ii,vv in ipairs(v)do
mainLineIdx=mainLineIdx+1
if vv[3]and vv[3]~=0 then
local posPlot=cfgHelper.get(cfg_longhuhuijuanposconfig_get,vv[2],"plot")
self.buffPlotList[posPlot]={vv[3],mainLineIdx}
end
end
end
end

function subActivityInfo_longhuhuijuan:getBuff(id)
local max=self:getPlotMaxid()
if id>max then
return
end
local finishMainIdx=self.data.main_event_num or 0
local buffInfo=self.buffPlotList[id]
if buffInfo and buffInfo[2]<=finishMainIdx then
return buffInfo[1]
end
end

function subActivityInfo_longhuhuijuan:checkOtherSubActCond(act_type,act_id2,warring)
local active_act=self:getSubActConfig('active_act')
for plot,v in pairs(active_act)do

if act_type==v[1]and act_id2==v[2]then
local max=self:getPlotMaxid()
if plot>max then
if warring then
UIManager.error(FMT.fmt("请祖师解锁第{0}个绘卷图块",plot))
end
return false
end
local today=self:getStart2NowDay()
local finishMainIdx=self.data.main_event_num or 0
if today<v[3]then
if warring then
UIManager.error(FMT.fmt("{0}天后才能解锁",v[3]-today))
end
return false
end
if finishMainIdx<v[4]then
if warring then
local mainCfg=self:getMainEventCfg(v[4])
if mainCfg then
local qiyu=MysteryEventModel.get_group_cfg(mainCfg[1])
if qiyu then
UIManager.error(FMT.fmt("完成绘卷的\"{0}\"事件解锁",qiyu[1].title))
end
end
end
return false
end
return true
end
end
end













function subActivityInfo_longhuhuijuan:getPlotZhenJi(plotid)

local max=self:getPlotMaxid()
if plotid>max then
return
end

local repair_event=self:getSubActConfig('repair_events')

if repair_event[plotid]then
local cfg=repair_event[plotid]
local finishMainIdx=self.data.main_event_num or 0
if finishMainIdx>=cfg[1]then
return cfg
end
end
end

function subActivityInfo_longhuhuijuan:getRepairEventProgress(eventId)
if not self.data then return 0 end
return self.data.repairEvents[eventId]or 0
end


function subActivityInfo_longhuhuijuan:onMysteryEventNew(sysId,eventList)
if sysId==SYSTEM_DEFINE.eCloudCityTreasure then
for i,v in ipairs(eventList)do
local data=v.otherData
local act_id=data.act_id
local act2_id=data.act2_id
local idx=data.idx
local event_idx=data.event_idx
if act_id==self.act_id and act2_id==self.sub_act_id then
local guid=v.guid
if idx==0 and event_idx==0 then

MysteryEventSystem:showEventByGuid(sysId,guid,{},true,self.resumeCB)
else

MysteryEventSystem:showEventByGuid(sysId,guid,{},true,self.resumeCB)
end
end
break
end
end
end

function subActivityInfo_longhuhuijuan:getMysteryEvent(nidx,nEvent_idx)
local list=MysteryEventListModel:get_eventList_by_sys(SYSTEM_DEFINE.eCloudCityTreasure)
if list then
for guid,v in pairs(list)do
local data=v.otherData
local act_id=data.act_id
local act2_id=data.act2_id
local idx=data.idx
local event_idx=data.event_idx
if act_id==self.act_id and act2_id==self.sub_act_id then
if idx==nidx and event_idx==nEvent_idx then
return guid
end
end
end
end
end


function subActivityInfo_longhuhuijuan:addProgress(addType)
if not self.data then
return
end
local progress=self:getSubActConfig('progress')

self.data.progress=self.data.progress+(progress[addType]or 0)
end

function subActivityInfo_longhuhuijuan:onDelete()
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld then
if worldModel.world==1 then
worldLongHuShanModel:hideUnitImp()
end
end
end

return subActivityInfo_longhuhuijuan







local _MODULENAME="LZDiaoKeController"

gameState.addListener(def_table(_MODULENAME))
LZDiaoKeController.name=_MODULENAME
LZDiaoKeController.data={}
local _this=LZDiaoKeController

function LZDiaoKeController:onAppStart()

LZDiaoKeModel:onAppStart()

socketManager:register_receiver(6,50,self.recv_6_50)
socketManager:register_receiver(6,51,self.recv_6_51)
socketManager:register_receiver(6,52,self.recv_6_52)
socketManager:register_receiver(6,53,self.recv_6_53)
socketManager:register_receiver(6,54,self.recv_6_54)
socketManager:register_receiver(6,55,self.recv_6_55)

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function LZDiaoKeController:onEnterState(isReconnect)
LZDiaoKeModel:onEnterState()
self.lastHudFlag={}
end


function LZDiaoKeController:onProtocolReq()
LZDiaoKeModel:onProtocolReq()

end


function LZDiaoKeController:onLeaveState(isReconnect)
LZDiaoKeModel:onLeaveState(isReconnect)

self.data={}
end


function LZDiaoKeController:onLostConnection()

end


function LZDiaoKeController:onReConnection(isInitPro)

end

function LZDiaoKeController:onNormalUpdate(delay)
if not LZDiaoKeController.checkOpen()then
return
end
local sfid=zongmenModel:getMountainId()
local sfData=LZDiaoKeModel:getSFData(sfid)
for i,v in pairs(sfData)do

if v.u_jzGuid and self.lastHudFlag[i]~=LZDiaoKeModel:hasReward(v.u_jzGuid)then
self.lastHudFlag[i]=LZDiaoKeModel:hasReward(v.u_jzGuid)
hudControl:refreshBuildingStatusHUD(v.u_jzGuid)

end
end
end

function LZDiaoKeController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
timeEventController.addNormalTimerHandler(2,LZDiaoKeController.name,LZDiaoKeController)
_this.lastHudFlag={}
elseif etype==homeEvent.eLeaveHome then
timeEventController.removeNormalTimerHandler(2,LZDiaoKeController.name)
_this.lastHudFlag={}
end
end



function LZDiaoKeController:req_Data()
socketManager:send_6_50()
end






function LZDiaoKeController:req_Dingzhi(sfid,jzGuid,len,dzdkList)
socketManager:send_6_51(sfid,jzGuid,len,dzdkList)
end





function LZDiaoKeController:req_StartDK(sfid,jzGuid,dkNum)
socketManager:send_6_52(sfid,jzGuid,dkNum)
end





function LZDiaoKeController:req_StopDK(sfid,jzGuid,opType)
socketManager:send_6_53(sfid,jzGuid,opType)
end




function LZDiaoKeController:req_LingGanReward(sfid,jzGuid)
socketManager:send_6_54(sfid,jzGuid)
end




function LZDiaoKeController:req_AddLingGan(sfid,jzGuid)
socketManager:send_6_55(sfid,jzGuid)
end


















function LZDiaoKeController.recv_6_50(dklen,dkList)
local data={}
if dklen==0 then

LZDiaoKeModel:setData(data)
return
end


for i,v in ipairs(dkList)do
local sfid,u_jzGuid,lgz,dkNum,startTime,len,dzdkList,len2,dkItemList,lgzAddCount=v.sfId,v.jzGuid,v.lgz,v.dkNum,v.startTime,v.len,v.dzdkList,v.len2,v.dkItemList,v.lgzAddCount

local jzGuid=u_jzGuid
if not data[sfid]then
data[sfid]={}
end
local sfdata=data[sfid]
if not sfdata[jzGuid]then
sfdata[jzGuid]={}
end
local jzdata=sfdata[jzGuid]

jzdata.lgz=lgz
jzdata.dkNum=dkNum

jzdata.startTime=startTime>timeHelper.getServerShortTime()and timeHelper.getServerShortTime()or startTime
jzdata.lgzAddCount=lgzAddCount
if len==0 then
len=5
dzdkList={1,2,3,4,5}
end
local temp={}
for i,v in ipairs(dzdkList)do
temp[v]=v
end
jzdata.dzlen=len
jzdata.dzdkList=temp
jzdata.dkItemList=dkItemList
jzdata.u_jzGuid=u_jzGuid
end
LZDiaoKeModel:setData(data)
end






function LZDiaoKeController.recv_6_51(sfid,jzGuid,len,dzdkList)
local jzData=LZDiaoKeModel:getJZData(sfid,jzGuid)
if len==0 then
len=5
dzdkList={1,2,3,4,5}
end
local temp={}
for i,v in ipairs(dzdkList)do
temp[v]=v
end
jzData.dzlen=len
jzData.dzdkList=temp
UIManager:invokeUIMethod("UILZDKMainWin","refreshDKList")
UIManager:invokeUIMethod("UILZDKMainWin","refreshCostItem")
UIManager:invokeUIMethod("UILZDKMainWin","refreshBottom")
end








function LZDiaoKeController.recv_6_52(arg)
local sfid,jzGuid,dkNum,startTime,len,dkItemList=arg[1],arg[2],arg[3],arg[4],arg[5],arg[6]
local jzData=LZDiaoKeModel:getJZData(sfid,jzGuid)
jzData.dkNum=dkNum

jzData.startTime=startTime>timeHelper.getServerShortTime()and timeHelper.getServerShortTime()or startTime
jzData.dkItemList=dkItemList
UIManager:invokeUIMethod("UILZDKMainWin","refreshMidPanel")
UIManager:invokeUIMethod("UILZDKMainWin","refreshBottom")
hudControl:refreshBuildingStatusHUD(jzGuid)
end










function LZDiaoKeController.recv_6_53(arg)
local sfid,jzGuid,len,itemList,lgz,newstartTime,len2,dkItemList=arg[1],arg[2],arg[3],arg[4],arg[5],arg[6],arg[7],arg[8]
local jzData=LZDiaoKeModel:getJZData(sfid,jzGuid)
jzData.lgz=lgz
jzData.dkItemList=dkItemList
if newstartTime==0 then
jzData.dkNum=0
jzData.startTime=0
jzData.lgzAddCount=0
else

newstartTime=newstartTime>timeHelper.getServerShortTime()and timeHelper.getServerShortTime()or newstartTime
local oldstartTime=jzData.startTime
local olddkNum=jzData.dkNum
local oldAddCount=jzData.lgzAddCount
local needTime=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"dktime")
local finishNum=math.floor((newstartTime-oldstartTime)/needTime)
local newdkNum=olddkNum-finishNum
local newAddCount=oldAddCount-finishNum
jzData.dkNum=newdkNum>=0 and newdkNum or 0
jzData.startTime=newstartTime
jzData.lgzAddCount=newAddCount>=0 and newAddCount or 0
end
UIManager:invokeUIMethod("UILZDKMainWin","stopHandleTimer")
UIManager:invokeUIMethod("UILZDKMainWin","refreshMidPanel")
UIManager:invokeUIMethod("UILZDKMainWin","refreshBottom")
local temp={}
for i,v in ipairs(itemList or{})do
temp[#temp+1]={itemid=v.param_1,num=v.param_2}
end




showPrizeControl.showWindow(temp,nil,{tips=nil})
hudControl:refreshBuildingStatusHUD(jzGuid)
reddotControl.on_change_catch_type(CATCH_TYPE.eLingZhenDiaoke)
end






function LZDiaoKeController.recv_6_54(sfid,jzGuid,len,itemList,lgz)
local jzData=LZDiaoKeModel:getJZData(sfid,jzGuid)
jzData.lgz=lgz

local temp={}
for i,v in ipairs(itemList)do
temp[#temp+1]={itemid=v.param_1,num=v.param_2}
end
showPrizeControl.showWindow(temp,nil,{tips=nil})


UIManager:invokeUIMethod("UILZDKMainWin","refreshLGZVal")
reddotControl.on_change_catch_type(CATCH_TYPE.eLingZhenDiaoke)
hudControl:refreshBuildingStatusHUD(jzGuid)
end






function LZDiaoKeController.recv_6_55(sfid,jzGuid,lgz,lgzAddCount)
local jzData=LZDiaoKeModel:getJZData(sfid,jzGuid)
jzData.lgz=lgz
jzData.lgzAddCount=lgzAddCount
UIManager:invokeUIMethod("UILZDKMainWin","refreshLGZVal")
reddotControl.on_change_catch_type(CATCH_TYPE.eLingZhenDiaoke)
end





function LZDiaoKeController.checkOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eLingZhenDiaoKe)
end


function LZDiaoKeController.on_building_event(etype,sfId,ubdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData.build_id==SLG_SYSTEM_TYPE.eTianGongGe then
local dkState,curNum,sumNum=LZDiaoKeModel:CheckDKState(sfId,ubdId)
if dkState==LZDKSTATE.eDKing then
LZDiaoKeController:req_StopDK(sfId,ubdId,1)
end
end
end
end

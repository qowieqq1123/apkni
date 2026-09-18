






local _MODULENAME="ZongMenDaoShiModel"


def_table(_MODULENAME)
ZongMenDaoShiModel.name=_MODULENAME
ZongMenDaoShiModel.zongmenData={}
ZongMenDaoShiModel.daoShiData={}
ZongMenDaoShiModel.daoShiInfoList={}
ZongMenDaoShiModel.zongmenImageData={}

function ZongMenDaoShiModel:onAppStart()

end


function ZongMenDaoShiModel:onEnterState(isReconnect)
if not isReconnect then
notifySystem:listenNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
notifySystem:listenNotify(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
end
end


function ZongMenDaoShiModel:onProtocolReq()

end


function ZongMenDaoShiModel:onLeaveState(isReconnect)

self.zongmenData={}
self.daoShiData={}
self.daoShiInfoList={}
self.zongmenImageData={}

if not isReconnect then
notifySystem:removelistener(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
notifySystem:removelistener(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
end
end



function ZongMenDaoShiModel:initZMDaoShiList(list)
self.zongmenData={}
self.daoShiData={}
self.zongmenImageData={}
for _,v in ipairs(list)do
local serial=v.param_1
local isDaoShi=v.param_2==1
if isDaoShi then
table.insert(self.daoShiData,serial)
else
table.insert(self.zongmenData,serial)
end
self.zongmenImageData[tostring(serial)]={leader_data=v.param_3,leader_image=v.param_4,leader_name=v.param_5}
end
self:initZMDaoShiInfoList()
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end


function ZongMenDaoShiModel:addZMDaoShiList(syssect_guid)
table.insert(self.daoShiData,syssect_guid)
for i,serial in ipairs(self.zongmenData)do
if serial==syssect_guid then
table.remove(self.zongmenData,i)
break
end
end
self:initZMDaoShiInfoList()
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end


function ZongMenDaoShiModel:getZMImageData(serial)
return self.zongmenImageData[tostring(serial)]
end



function ZongMenDaoShiModel:getZMDaoShiNum()
return#self.daoShiData
end


function ZongMenDaoShiModel:initZMDaoShiInfoList()
self.daoShiInfoList={}
local num=#self.daoShiData
local sectNum=#self.zongmenData
local cfg=cfgHelper.get1(cfg_zmdsbaseconfig_get,1)
local total=cfg.max
local lessNum=total-num-sectNum
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
local lookup=systemZongMenModel:getFightFlagLookup(systemZongMenFightFlagType.eExpel)or{}
local diffDay=baseCfg.destroy_stand_time+1
for i=1,sectNum do
table.insert(self.daoShiInfoList,{serial=self.zongmenData[i]})
end
if#self.daoShiInfoList>1 then
table.sort(self.daoShiInfoList,function(a,b)
local sort1=a.serial
local sort2=b.serial
local reddot1=ZongMenDaoShiController:getZongMenDaoShiReddotBySerial(a.serial)
if reddot1 then
sort1=sort1-100000
end
local reddot2=ZongMenDaoShiController:getZongMenDaoShiReddotBySerial(b.serial)
if reddot2 then
sort2=sort2-100000
end
return sort1<sort2
end)
end
for i=1,lessNum do
local serial=lookup[i]or 0
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local longStamp=timeHelper.convertLongStamp(infoData.start_time)
local sinceZero=timeHelper.getServerZeroStamp(longStamp)
local end_time=timeHelper.convertShortStamp(sinceZero+(86400*diffDay)+3600*5)
table.insert(self.daoShiInfoList,{serial=-1,refresh_time=end_time})
end
end
for i=1,num do
table.insert(self.daoShiInfoList,{serial=self.daoShiData[i],isDaoShi=true})
end
end


function ZongMenDaoShiModel:getZMDaoShiInfoList()
return self.daoShiInfoList
end


function ZongMenDaoShiModel:getZMDataList()
return self.zongmenData
end

function ZongMenDaoShiModel.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
if oldFlag==systemZongMenFightFlagType.eVassal or newFlag==systemZongMenFightFlagType.eVassal then
ZongMenDaoShiModel:initZMDaoShiInfoList()
UIManager:invokeUIMethod("UIZongMenDaoShiWin","onShow")
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end
end

function ZongMenDaoShiModel.onSystemZMMoneyNumChange(serial,eType,newVal,oldVal)
if eType==systemZongMenInfoMoneyType.eShengWang then
ZongMenDaoShiModel:initZMDaoShiInfoList()
UIManager:invokeUIMethod("UIZongMenDaoShiWin","onShow")
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end
end
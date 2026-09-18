






local _MODULENAME="DuJieZhiBaoModel"


def_table(_MODULENAME)
DuJieZhiBaoModel.name=_MODULENAME
DuJieZhiBaoModel.data={}
DuJieZhiBaoModel.data.severdata={}

function DuJieZhiBaoModel:onAppStart()

end


function DuJieZhiBaoModel:onEnterState(isReconnect)
self.data.severdata.treasureData={}
end


function DuJieZhiBaoModel:onProtocolReq()

end


function DuJieZhiBaoModel:onLeaveState(isReconnect)

self.data={}
self.data.severdata={}
end



function DuJieZhiBaoModel:initDJZBData(len,arry)




self.data.severdata.treasureData={}
if len and len>0 then
local temp={}
for k,v in ipairs(arry)do
temp[v.id]=v
end
self.data.severdata.treasureData=temp
end
end

function DuJieZhiBaoModel:getDJZBData()
return self.data.severdata.treasureData or{}
end

function DuJieZhiBaoModel:setDJZBData(list)
self.data.severdata.treasureData=list
end



function DuJieZhiBaoModel:DJZBLianhuaback(id,refine_rate)
if self.data.severdata.treasureData then
if self.data.severdata.treasureData[id]then
local num=self.data.severdata.treasureData[id].refine_rate
if num then
self.data.severdata.treasureData[id].refine_rate=refine_rate
else
self.data.severdata.treasureData[id].refine_rate=refine_rate or 0
end
else
self.data.severdata.treasureData[id]={}
self.data.severdata.treasureData[id].refine_rate=refine_rate or 0
end
else
self.data.severdata.treasureData={}
self.data.severdata.treasureData[id]={}
self.data.severdata.treasureData[id].refine_rate=refine_rate or 0
end
end



function DuJieZhiBaoModel:downCDtimes(id,reduce_times)
local data
local sfId=zongmenModel:getMountainId()
local bdDatas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(bdDatas)do
if v.build_id==id then
data=v
end
end
if data then
local un_build_id=data.un_build_id
if un_build_id~=0 then
zongmenModel:setUpgradeSpeedupTime(1,un_build_id,reduce_times)
buildingCDControl:setSpeedUp(un_build_id,speedUpType.eUpgradeBuilding)
local args={ignorePlayAudio=true}
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.speedUpComplete,1,un_build_id,args)
UIManager:invokeUIMethod("UIFlyupward_speed","refreshdata")
end
end
end



function DuJieZhiBaoModel:setRewardFlag(id,reward_idx)
if self.data.severdata.treasureData then
if self.data.severdata.treasureData[id]then
self.data.severdata.treasureData[id].reward_flag=reward_idx or 0
end
end
end

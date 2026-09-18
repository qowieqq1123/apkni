







zongmenSundriseTempDataModel={}

local cdDatas=nil
local cdDatasNum=0

function zongmenSundriseTempDataModel:initData()
cdDatas={}
cdDatasNum=0
end

function zongmenSundriseTempDataModel:clearData()
cdDatas=nil
cdDatasNum=0
end

function zongmenSundriseTempDataModel:getAllCDDatas()
return cdDatas
end

function zongmenSundriseTempDataModel:addCDData(guid,time)
local data=cdDatas[guid]
if data==nil then
data={time=time}
cdDatas[guid]=data
cdDatasNum=cdDatasNum+1
else
data.time=time
end
if data.hudID==nil then
data.isInit=false
local offset=_MapManager.GetObjectBottomOffset(guid)
data.hudID=hudControl:addHUD(INSTANCE_TYPE.eSundriseLimitTime,guid,offset,false,true,function(id)
data.isInit=true
local lookup=zongmenSundriseControl.getHudFunc(zongmenSundriseHudType.eLimitTime)
lookup:init(id,guid)
end)
end
end

function zongmenSundriseTempDataModel:refreshCDData(guid,time)
local data=cdDatas[guid]
if data~=nil then
data.time=time
end
end

function zongmenSundriseTempDataModel:removeCDData(guid)
if cdDatas[guid]~=nil then
local data=cdDatas[guid]
if data.hudID~=nil then
hudControl:removeHUD(data.hudID)
end
cdDatasNum=cdDatasNum-1
cdDatas[guid]=nil
data=nil
end
end

function zongmenSundriseTempDataModel:getCDDatasNum()
return cdDatasNum
end

function zongmenSundriseTempDataModel.getCDLastTime(endTime)
return endTime-gameUtilityModel.getServerShortTime()
end
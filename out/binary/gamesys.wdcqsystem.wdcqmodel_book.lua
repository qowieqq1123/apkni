
local _bookData=nil
local _dataKey="WDCQBookData"
local _msgWinData={}

local corverKey=function(...)
return table.concat({...},"_")
end


function WDCQModel:addBookWin_GM(group,phase,order,flag,delay,duration)
local nowTime=timeHelper.getServerShortTime()
local key=corverKey(group,phase,order,flag)
local temp={
group=group,
phase=phase,
order=order,
startTime=nowTime+delay,
endTime=nowTime+delay+duration,
flag=flag,
}
_msgWinData[key]=temp
end

function WDCQModel:clearBookWin()
table.clear(_msgWinData)
end

function WDCQModel:setBookWin(group,phase,order,flag)
local nowTime=timeHelper.getServerShortTime()
local roundCfg=WDCQController.getRoundCfg(group,phase,order)
local limit=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,"book_time")

if(flag==nil or flag==1)and self:waitBookData(group,phase,order,1)then
if nowTime<roundCfg.startTime then
local key=corverKey(group,phase,order,1)
local temp={
group=group,
phase=phase,
order=order,
startTime=roundCfg.startTime-limit,
endTime=roundCfg.startTime,
flag=1,
}
_msgWinData[key]=temp
end
end

if(flag==nil or flag==2)and self:waitBookData(group,phase,order,2)then
if nowTime<roundCfg.endTime then
local key=corverKey(group,phase,order,2)
local temp={
group=group,
phase=phase,
order=order,
startTime=roundCfg.startTime,
endTime=roundCfg.endTime,
flag=2,
}
_msgWinData[key]=temp
end
end
end

function WDCQModel:hasBookWin()
return next(_msgWinData)~=nil
end

function WDCQModel:getShowBookWin()
local nowTime=timeHelper.getServerShortTime()
for i,v in pairs(_msgWinData)do
if v.startTime<=nowTime and nowTime<v.endTime then
local matchInfo=WDCQController.getMacthInfo(v.group,v.phase,v.order)
if matchInfo and mathHelper.validInt64(matchInfo.actor_id_1)and mathHelper.validInt64(matchInfo.actor_id_2)then
return v
end
end
end
end

function WDCQModel:getBookWin(group,phase,order,flag)
local key=corverKey(group,phase,order,flag)
return _msgWinData[key]
end

function WDCQModel:removeBookWin(group,phase,order,flag)
if flag then
local key=corverKey(group,phase,order,flag)
_msgWinData[key]=nil
else
for i=1,2 do
local key=corverKey(group,phase,order,i)
_msgWinData[key]=nil
end
end
end

function WDCQModel:refreshBookWin()
local nowTime=timeHelper.getServerShortTime()
for i,v in pairs(_msgWinData)do
if nowTime>=v.endTime then
_msgWinData[i]=nil
end
end
end

function WDCQModel:resetBookData()
_bookData=nil
end

function WDCQModel:loadBookData()
if _bookData==nil then
_bookData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,_dataKey,{})
end
local startTime=WDCQController.getGameStartTime()
local endTime=WDCQController.getGameEndTime()
if next(_bookData)==nil or _bookData.startTime~=startTime or _bookData.endTime~=endTime then
_bookData.startTime=startTime
_bookData.endTime=endTime
_bookData.datas={}
self:saveBookData()
else
local change=false
for i,v in pairs(_bookData.datas)do
local infos=string.split(i,"_")
local group=tonumber(infos[1])
local phase=tonumber(infos[2])
local order=tonumber(infos[3])
local config=cfgHelper.get2(cfg_wendingcangqiongmatchconfig_get,group,phase)
if config.book==nil or config.book==0 then
_bookData.datas[i]=nil
change=true
end
end
if change then
self:saveBookData()
end
end
for i,v in pairs(_bookData.datas)do
local infos=string.split(i,"_")
local group=tonumber(infos[1])
local phase=tonumber(infos[2])
local order=tonumber(infos[3])
WDCQModel:setBookWin(group,phase,order)
end

if WDCQModel:hasBookWin()then
msgWinControl:addMsgWin(msgWinType.eWDCQYYCS,nil,nil,true)
end
end

function WDCQModel:saveBookData()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWenDingCangQiong,_dataKey,_bookData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
end

function WDCQModel:haveBookData()
return next(_bookData.datas)~=nil
end

function WDCQModel:doBookData(group,phase,order)
local key=corverKey(group,phase,order)
_bookData.datas[key]=1
end

function WDCQModel:cancelBookData(group,phase,order)
local key=corverKey(group,phase,order)
_bookData.datas[key]=nil
end

function WDCQModel:getBookData(group,phase,order)
local key=corverKey(group,phase,order)
return _bookData.datas[key]or 0
end

function WDCQModel:waitBookData(group,phase,order,flag)
local data=self:getBookData(group,phase,order)
return mathHelper.getBitValue(data,0)and not mathHelper.getBitValue(data,flag)
end

function WDCQModel:finishBookData(group,phase,order,flag)
local key=corverKey(group,phase,order)
local data=_bookData.datas[key]
if data and mathHelper.getBitValue(data,0)then
_bookData.datas[key]=mathHelper.setbit(data,flag)
end
end

function WDCQModel:printAllBookData(sign)

loggerUtil.logFMT("{0} {1}",sign,serializeHelper.serialize(_bookData))
loggerUtil.logFMT("{0} {1}",sign,serializeHelper.serialize(_msgWinData))
end

function WDCQModel:clearAllBookData_GM()
_bookData.startTime=startTime
_bookData.endTime=endTime
_bookData.datas={}
WDCQModel:saveBookData()
end
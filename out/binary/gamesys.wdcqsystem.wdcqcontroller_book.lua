function WDCQController:doBookWatch(group,phase,order)
WDCQModel:doBookData(group,phase,order)
WDCQModel:saveBookData()

WDCQModel:setBookWin(group,phase,order)
msgWinControl:addMsgWin(msgWinType.eWDCQYYCS,nil,nil,true)
end

function WDCQController:cancelBookWatch(group,phase,order)
WDCQModel:cancelBookData(group,phase,order)
WDCQModel:saveBookData()

WDCQModel:removeBookWin(group,phase,order)
end

function WDCQController:checkAutoBook()



WDCQModel:clearBookWin()
WDCQModel:loadBookData()

local configs=cfg_wendingcangqiongmatchconfig()
local nowTime=timeHelper.getServerShortTime()
local dirty=false
for group,cfgs in ipairs(configs)do
local groupTemp=WDCQModel:getData_GroupTemp(group)
if groupTemp and groupTemp.hasData then
for phase,cfg in ipairs(cfgs)do
if cfg.book==2 then
for order,conf in ipairs(cfg.time_conf)do
local bookData=WDCQModel:getBookData(group,phase,order)
if not mathHelper.getBitValue(bookData,0)then
WDCQModel:doBookData(group,phase,order)
dirty=true
WDCQModel:setBookWin(group,phase,order)
msgWinControl:addMsgWin(msgWinType.eWDCQYYCS,nil,nil,true)
end
end
end
end
end
end
if dirty then
WDCQModel:saveBookData()
end
end

function WDCQController:removeBookWinWhenLiveRoomClose(group,phase,order)
local nowTime=timeHelper.getServerShortTime()
for i=1,2 do
local bookData=WDCQModel:getBookWin(group,phase,order,i)
if bookData and bookData.startTime<=nowTime then
WDCQModel:removeBookWin(group,phase,order,i)
end
end
end

function WDCQController:addBookWin_GM(group,phase,order,flag,delay,duration)
WDCQModel:addBookWin_GM(group,phase,order,flag,delay,duration)
msgWinControl:addMsgWin(msgWinType.eWDCQYYCS,nil,nil,true)
end
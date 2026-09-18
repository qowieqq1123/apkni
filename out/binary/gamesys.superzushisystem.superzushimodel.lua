









superZuShiModel={}


superZuShiModel.data={}

function superZuShiModel:onAppStart()

end


function superZuShiModel:onEnterState(isReconnect)

end


function superZuShiModel:onProtocolReq()

end


function superZuShiModel:onLeaveState(isReconnect)

self.data={}
end


function superZuShiModel:setSuperZuShiData(data)
self.data.superZuShiData={}


if data.detail and data.detail~=""then
local detailData={}
detailData.content=data.detail.content
detailData.show_reward=data.detail.show_reward
if data.detail.connect and data.detail.connect~=""then
detailData.connect={}
detailData.connect.content=data.detail.connect.content
detailData.connect.information=data.detail.connect.information
detailData.connect.add_url=data.detail.connect.add_url
if detailData.connect.add_url==""then
detailData.connect.add_url=nil
end
detailData.connect.qr_code=data.detail.connect.qr_code
if detailData.connect.qr_code==""then
detailData.connect.qr_code=nil
end
end
self.data.superZuShiData.detail=detailData
end


if data.condition and data.condition~=""then
local targetRechargeNumStr=data.condition.recharge
local limitZmLevelStr=data.condition.level
local showBeginTimeStr=data.condition.begin_time
local showEndTimeStr=data.condition.end_time
local conditionData={}
if targetRechargeNumStr and targetRechargeNumStr~=""then
conditionData.recharge=tonumber(targetRechargeNumStr)
end
if limitZmLevelStr and limitZmLevelStr~=""then
conditionData.level=tonumber(limitZmLevelStr)
end
if showBeginTimeStr and showBeginTimeStr~=""then
conditionData.begin_time=timeHelper.dataToTimeStam(showBeginTimeStr)
end
if showEndTimeStr and showEndTimeStr~=""then
conditionData.end_time=timeHelper.dataToTimeStam(showEndTimeStr)
end
self.data.superZuShiData.condition=conditionData
end
end

function superZuShiModel:getSuperZuShiDetailData()
if self.data.superZuShiData and self.data.superZuShiData.detail then
return self.data.superZuShiData.detail
end
end


function superZuShiModel:checkSuperZuShiEnterShow()
if not self.data.superZuShiData or not next(self.data.superZuShiData)then

return false
end

if not self.data.superZuShiData.condition or not next(self.data.superZuShiData.condition)then

return false
end

local isShow=true
local targetRechargeNum=self.data.superZuShiData.condition.recharge
local limitZmLevel=self.data.superZuShiData.condition.level
local showBeginTime=self.data.superZuShiData.condition.begin_time
local showEndTime=self.data.superZuShiData.condition.end_time
if targetRechargeNum then

local totalRechargeNum=rechargeModel:getTotalRecharge()/10
if totalRechargeNum<targetRechargeNum then
return false
end
end

if limitZmLevel then

local zmLevel=zongmenModel:getLevel()or 1
if zmLevel<limitZmLevel then
return false
end
end

local nowTime=timeHelper.getServerLongTime()
if showBeginTime and showEndTime then

if nowTime<showBeginTime or nowTime>=showEndTime then
return false,showBeginTime,showEndTime
end
end


local firstShowEnterTime=superZuShiModel:getSuperZuShiEnterFirstShowTime()
if not firstShowEnterTime then

firstShowEnterTime=nowTime
superZuShiModel:setSuperZuShiEnterFirstShowTime({nowTime})
superZuShiModel:saveSuperZuShiEnterFirstShowTime(nowTime)
end
local limitEndShowTime=firstShowEnterTime+10*86400
if nowTime>=limitEndShowTime then
return false,showBeginTime,limitEndShowTime
end

return isShow,showBeginTime,limitEndShowTime
end

function superZuShiModel:isShowEnter()
return true
end

function superZuShiModel.initSuperZuShiEnterFirstShowTime(len,arr)
local firstShowTimeData={}
if len>0 then
for i,v in ipairs(arr)do
firstShowTimeData[i]=v
end
end
superZuShiModel:setSuperZuShiEnterFirstShowTime(firstShowTimeData)
end

function superZuShiModel:setSuperZuShiEnterFirstShowTime(data)
self.data.superZuShiEnterFirstShowTime=data[1]
end

function superZuShiModel:saveSuperZuShiEnterFirstShowTime(time)
local timeData={time}
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.SUPER_VIP_DATA_START_TIME,#timeData,timeData)
end

function superZuShiModel:getSuperZuShiEnterFirstShowTime()
return self.data and self.data.superZuShiEnterFirstShowTime or nil
end

function superZuShiModel:test_setSuperZuShiDetailData()
local json_table
local jsonStr=[[{
    "code": 0,
    "message": "ok",
    "data": {
        "detail": {
        	"content":"超级祖师超级祖师\n超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师超级祖师",
        	"show_reward":"0"
        	"connect":{
        		"content":"超级祖师你好",
        		"information":"123456",
        		"add_url": "http://www.baidu.com",
        		"qr_code":"hello.jpg"
        	}
        },
        "condition": {"level":"1"}
    }
}]]
local s,e=pcall(function()
json_table=jsonHelper.decode(jsonStr)
end)
superZuShiModel:setSuperZuShiEnterFirstShowTime({})
if json_table and json_table.code==0 then
superZuShiModel:setSuperZuShiData(json_table.data)


superZuShiController:checkSuperZuShiEnter()
end
end









activitiesHandle_tianmingzengli=new_activitiesHandle('activitiesHandle_tianmingzengli',activitiesHandle)

function activitiesHandle_tianmingzengli.onInit(...)

end

function activitiesHandle_tianmingzengli.recv_249_35(actid,act2id,len,list,dailySec)
local subType=SUB_ACTIVITY_TYPE.eTianMingZengLi
local actId=actid
local subId=act2id
local data={}
local libaoList={}
if len and len>0 then
for i,v in ipairs(list)do
local libaoId=v.param_1
local freeGotCount=v.param_2
local buyCount=v.param_3
local lastBuyTime=v.param_4
local libaoData={
libaoId=libaoId,
freeGotCount=freeGotCount,
buyCount=buyCount,
lastBuyTime=lastBuyTime,
}
libaoList[libaoId]=libaoData
end
end
data.libaoList=libaoList
data.lastGotDailyTime=dailySec
activitiesModel:setSubActInfoData(actId,subType,subId,data)

local win=UIManager:findActiveWindow('UISubAct_tianmingzengliWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end








activitiesHandle_duihuanhuodong=new_activitiesHandle('activitiesHandle_duihuanhuodong',activitiesHandle)






function activitiesHandle_duihuanhuodong:onInit()

end


function activitiesHandle_duihuanhuodong.recv_249_44(actid,act2id,len,list)





local subType=SUB_ACTIVITY_TYPE.eDuiHuanHuoDong
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local goodLookup={}
if len>0 then
for i,v in ipairs(list)do
goodLookup[v.param_1]=v
end
end
data.goodLookup=goodLookup
activitiesModel:setSubActInfoData(actID,subType,subid,data)
UIManager:invokeUIMethod('UISubAct_duihuanhuodong_win','rec_refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_duihuanhuodong.recv_249_45(actid,act2id,idx,times,lastsec)






local subType=SUB_ACTIVITY_TYPE.eDuiHuanHuoDong
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil or data.goodLookup==nil then return end

local d=data.goodLookup[idx]
if d==nil then
d={param_1=idx}
data.goodLookup[idx]=d
end
d.param_2=times
d.param_3=lastsec
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_duihuanhuodong_win','rec_buy',idx)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
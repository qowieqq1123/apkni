







activitiesHandle_tujiantezhi=new_activitiesHandle('activitiesHandle_tujiantezhi',activitiesHandle)






function activitiesHandle_tujiantezhi:onInit()

end


function activitiesHandle_tujiantezhi.recv_247_57(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.ePictureSpeciality
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.selectSpeciality={}
if args[3]and args[3]>0 and args[4]then
for k,v in ipairs(args[4])do
data.selectSpeciality[v]=true
end
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tujiantezhi.recv_247_58(...)
local args={...}
local subType=SUB_ACTIVITY_TYPE.ePictureSpeciality
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

if args[3]and args[3]>0 and args[4]then
for k,v in ipairs(args[4])do
data.selectSpeciality[v]=true
end
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)
UIManager:invokeUIMethod('UISubAct_tujianTeZhiWin','severfresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
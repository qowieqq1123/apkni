







activitiesHandle_tujiandizi=new_activitiesHandle('activitiesHandle_tujiandizi',activitiesHandle)






function activitiesHandle_tujiandizi:onInit()

end


function activitiesHandle_tujiandizi.recv_247_55(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.ePictureDisciple
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.selectDisciple={}
if args[3]and args[3]>0 and args[4]then
for k,v in ipairs(args[4])do
data.selectDisciple[v]=true
end
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tujiandizi.recv_247_56(...)
local args={...}
local subType=SUB_ACTIVITY_TYPE.ePictureDisciple
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

if args[3]and args[3]>0 and args[4]then
for k,v in ipairs(args[4])do
data.selectDisciple[v]=true
end
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)
UIManager:invokeUIMethod('UISubAct_tujiandiziWin','severfresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
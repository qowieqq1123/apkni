







activitiesHandle_tongbaoxianshi=new_activitiesHandle('activitiesHandle_tongbaoxianshi',activitiesHandle)

function activitiesHandle_tongbaoxianshi:getTypeList()
local list={0}
local cfg=cfg_tongbaoxianshitypeconfig()
for i,v in ipairs(cfg)do
table.insert(list,v.id)
end
return list
end

function activitiesHandle_tongbaoxianshi:getNameList()
local list={"全部"}
local cfg=cfg_tongbaoxianshitypeconfig()
for i,v in ipairs(cfg)do
table.insert(list,v.name)
end
return list
end

function activitiesHandle_tongbaoxianshi:onInit()

end

function activitiesHandle_tongbaoxianshi.recv_249_102(actid,act2id,len,dhList)
local subType=SUB_ACTIVITY_TYPE.eTongBaoXianShi
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)or{}
local selectFangAnList=data.selectFangAn
if not selectFangAnList then
local startTime=activitiesModel:getSubActStartTime(actid,subType,act2id)
if startTime>0 then
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTongTianXianShi,table.concat({actid,act2id,startTime},"_"),{})
selectFangAnList={}
for i,v in ipairs(saveData)do
selectFangAnList[v[1]]=v[2]
end
data.selectFangAn=selectFangAnList
end
end

local exchangeList={}
if len>0 then
for i,v in ipairs(dhList)do
exchangeList[v.param_1]=v.param_2
end
end
data.exchangeList=exchangeList
activitiesModel:setSubActInfoData(actid,subType,act2id,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod("UISubAct_tongbaoxianshi_Win","refresh",nil,true)
end

function activitiesHandle_tongbaoxianshi.saveSelectData(actid,act2id)
local subType=SUB_ACTIVITY_TYPE.eTongBaoXianShi
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)or{}
local selectFangAnList=data.selectFangAn
if selectFangAnList then
local startTime=activitiesModel:getSubActStartTime(actid,subType,act2id)
if startTime>0 then
local saveList={}
for i,v in pairs(selectFangAnList)do
table.insert(saveList,{i,v})
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTongTianXianShi,table.concat({actid,act2id,startTime},"_"),saveList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eTongTianXianShi)
end
end
end
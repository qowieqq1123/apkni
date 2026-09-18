






UISchoolController=gameState.addListener({})

function UISchoolController:onAppStart()

socketManager:register_receiver(6,1,UISchoolController.recv_6_1)
socketManager:register_receiver(6,2,UISchoolController.recv_6_2)
socketManager:register_receiver(6,3,UISchoolController.recv_6_3)

end

function UISchoolController:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.on_new_day)

UISchoolModel:on_enter_state()

UISchoolController:loadRecordData()
end

function UISchoolController:onPlayerCreate(...)

end

function UISchoolController:onLeaveState()
notifySystem:removelistener(notifyConfig.onNewDay5am,self.on_new_day)

UISchoolModel:on_leave_state()
end

function UISchoolController.on_new_day(is_login)
UISchoolController:clearRecordData()
UISchoolController:req_data()
UISchoolController.waitAddNewDayAI=true
end



function UISchoolController:req_data()
socketManager:send_6_1()
end


function UISchoolController:req_start_study(courseId,len,diziList,times)
socketManager:send_6_2(courseId,len,diziList,times or 1)
end


function UISchoolController:req_achieve_reward(id)
socketManager:send_6_3(id)
end



function UISchoolController.recv_6_1(array)
local teachNum=array[1]
local teachMax=array[2]
local len=array[3]
local classInfo=array[4]
local stateCntList={array[5],array[6],array[7],array[8],array[9]}
local rewardGotListLen=array[10]
local rewardGotIdList=array[11]
UISchoolModel:init_data(teachNum,teachMax,len,classInfo,stateCntList,rewardGotListLen,rewardGotIdList)

local win1=UIManager:findActiveWindow('UISchoolMainWin')
if win1 then
win1:refreshBottomPanel()
end







UISchoolController:refreshBuildHud()
reddotControl.on_change_catch_type(CATCH_TYPE.eSchool)

if UISchoolController.waitAddNewDayAI then
UISchoolController.waitAddNewDayAI=false
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoAttendClass)
end
end


function UISchoolController.recv_6_2(len,array,times)
if len==0 then return end

if times>1 then
local list={}
for i,v in ipairs(array)do
local key=tostring(v.dzGuild)
local data=list[key]
if data then
data.exp=data.exp+v.exp
data.smartAdd=data.smartAdd+v.smartAdd
else
data=v
end
list[key]=data
end
array={}
for k,v in pairs(list)do
array[#array+1]=v
end
end

if len>0 then
UISchoolModel:set_study_result(array)
end

local recordData=UISchoolController:getRecordData()
if recordData then
for i,v in ipairs(array)do
v.skillData=UISchoolModel:getOldDiZiProSkillData(v.dzGuild)
end
recordData.result=array
recordData.times=times
UISchoolController:saveRecordData()
UISchoolController:req_data()
end

local win1=UIManager:findActiveWindow('UISchoolMainWin')
if win1 then
win1:actionClassPlay()
end

end



function UISchoolController.recv_6_3(result)
if result==0 then
local rewardId=UISchoolModel:get_sendReward_id()
UISchoolModel:set_classData_byType(rewardId)
local win2=UIManager:findActiveWindow('UISchoolRewardWin')
if win2 then
win2:initRewardListPanel()
end
UISchoolController:refreshBuildHud()
reddotControl.on_change_catch_type(CATCH_TYPE.eSchool)
else
UIManager.error('领取失败')
end
end

function UISchoolController:refreshBuildHud()


local bdData=UISchoolModel:getSchoolBDData()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

function UISchoolController:autoSelectDZ(diziList,selectClassId,tableCount)
if selectClassId then
diziList=UISchoolModel:getClassSelectDzDataListByClassType(selectClassId)
end
UISchoolModel:saveLastSelectDzList(diziList)
local autoList={}

local sixAttrType=DISCIPLE_BASE_ATTR_TYPE.eCongHui
local disciplesList=UISchoolModel:getDZListSortResult(sixAttrType,selectClassId,eSortOrder.eDown,1)
local max=#disciplesList>=tableCount and tableCount or#disciplesList
for i=1,max do
local netdata=disciplesList[i].netData
local net=netdata.net
local guid=net.discipleguid

local classLevel=UIDiscipleModel:getDiscipleJobLevel(guid,selectClassId)

local proSkillConst=cfgHelper.getdef(cfg_discipleproskillconfig)
local expList=proSkillConst.exp
local maxLevel=#expList
local autoAll=true
local isOld=UISchoolModel:checkIsOldSelectDz(guid)
autoAll=not isOld
if autoAll and classLevel<maxLevel then
table.insert(autoList,guid)
end
end
diziList=UISchoolModel:getAutoDiZiList(autoList,max)
return diziList
end

function UISchoolController:autoHandleClass(selectClassId,times,diziList)
local remain=UISchoolModel:get_study_remainNum()
if remain<=0 then
return false
end

local bdData=UISchoolModel:getSchoolBDData()
if not bdData then
return false
end

local config=cfgHelper.get1(cfg_collegecourseconfig_get,selectClassId)
local cost=config.useItem
if cost then
local moneyType=cost[1]
local moneyCount=cost[2]*times
local enough=moneySystem:useMoney(moneyType,moneyCount,function()return end,WARNING_TYPE.eNone)
if not enough then
return false
end
end

if not diziList or#diziList<=0 then
local tableCount=cfgHelper.get2(cfg_collegearchitectureconfig_get,bdData.level,'sea')
diziList=UISchoolController:autoSelectDZ(diziList,selectClassId,tableCount)
end

local sendList={}
for i,guid in ipairs(diziList)do
if guid~=0 then
local netData=UIDiscipleModel:getDiscipleData(guid)
local skillData=UIDiscipleModel:getDiscipleJobDataEx(netData,selectClassId)
UISchoolModel:setOldDiZiProSkillData(guid,{skillData.level,skillData.exp})
sendList[#sendList+1]=guid
end
end
if#sendList<=0 then
return false
end

UISchoolController:req_start_study(selectClassId,#sendList,sendList,times)

self.recordData={type=selectClassId}

return true
end

function UISchoolController:getRecordData()
return self.recordData
end

function UISchoolController:clearRecordData()
self.recordData=nil
userActorArraySetting.set(ACTOR_SETTING_TYPE.eAutoClassResult,'AUTO_CLASS_RESULT',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eAutoClassResult)

UISchoolController:refreshBuildHud()
end

function UISchoolController:saveRecordData()
local rdata=table.deepCopy(self.recordData)
local len=#rdata.result
for i=1,len do
local d1=rdata.result[i]
local d2=self.recordData.result[i]
d1.dzGuild=tostring(d2.dzGuild)
d1.exp=tostring(d2.exp)
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eAutoClassResult,'AUTO_CLASS_RESULT',rdata)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eAutoClassResult)
end

function UISchoolController:loadRecordData()
local rdata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eAutoClassResult,'AUTO_CLASS_RESULT',nil)
if not rdata then
return
end
local len=#rdata.result
for i=1,len do
local d1=rdata.result[i]
d1.dzGuild=int64.new(d1.dzGuild)
d1.exp=int64.new(d1.exp)
end
self.recordData=rdata
end

function UISchoolController:checkAndShowAutoClassResult()






return false
end
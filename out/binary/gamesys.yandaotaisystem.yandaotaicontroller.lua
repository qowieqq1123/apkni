






local _MODULENAME="yandaotaiController"


gameState.addListener(def_table(_MODULENAME))

yandaotaiController.name=_MODULENAME
yandaotaiController.data={}

function yandaotaiController:onAppStart()

yandaotaiModel:onAppStart()


socketManager:register_receiver(6,176,yandaotaiController.recv_6_176)
socketManager:register_receiver(6,177,yandaotaiController.recv_6_177)
socketManager:register_receiver(6,178,yandaotaiController.recv_6_178)
socketManager:register_receiver(6,179,yandaotaiController.recv_6_179)





function yandaotaiController.send_6_177(id)
socketManager:send_6_177(id)
end




function yandaotaiController.send_6_178(len,list)
socketManager:send_6_178(len,list)
end


function yandaotaiController.send_6_179()
socketManager:send_6_179()
end


end


function yandaotaiController:onEnterState(isReconnect)
yandaotaiModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onYingXianGe_XMHZChange,self.refreshBulidHud)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.refreshBulidHud)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function yandaotaiController:onProtocolReq()
yandaotaiModel:onProtocolReq()
end


function yandaotaiController:onLeaveState(isReconnect)
yandaotaiModel:onLeaveState(isReconnect)

self.data={}
notifySystem:removelistener(notifyConfig.onYingXianGe_XMHZChange,self.refreshBulidHud)
notifySystem:removelistener(notifyConfig.on_money_changed,self.refreshBulidHud)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end


function yandaotaiController:onLostConnection()

end


function yandaotaiController:onReConnection(isInitPro)

end



function yandaotaiController:isSystemOpen()
end

function yandaotaiController.refreshBulidHud()
local un_build_id=yandaotaiController:getBuildUnBulidId()
if un_build_id then
hudControl:refreshBuildingStatusHUD(un_build_id)
end
end

function yandaotaiController.on_building_event(etype,sfId,bdId,arg1,arg2)
local un_build_id=yandaotaiController:getBuildUnBulidId()
if un_build_id~=bdId then
return
end
if etype==buildingEvent.levelUpComplete then
yandaotaiModel:updateTechnologyMaxLevelList()
UIFullYanDaoTaiControl:refreshMainMenu()
end
end


function yandaotaiController:refreshJZChange(id)
local effect
local level=yandaotaiModel:getTechnologyListLevel(id)or 1
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level)
if cfg then effect=cfg.study_effect end

if effect then
for k,v in ipairs(effect)do
local effectType=v[1]
if effectType==5 then
local list=v[2]
for i,j in ipairs(list)do
local type=j[1]
notifySystem:postNotify(notifyConfig.onJZAttrsChange,type)
end
end
end
end
end








function yandaotaiController.recv_6_176(len,technologyList,len2,studyList)
yandaotaiModel:initTechnologyListDatas(len,technologyList)
yandaotaiModel:initStudyListDatas(len2,studyList)
yandaotaiModel:initTechnologyAddrateDatas(technologyList)
yandaotaiModel:updateTechnologyMaxLevelList()

XianYunGangModel:refreshCanBuildBoatList()
UIFullYanDaoTaiControl:refreshMainMenu()
end




function yandaotaiController.recv_6_177(technology_id,start_time)
yandaotaiModel:setStudyListTime(technology_id,start_time)
UIManager:invokeUIMethod('UITechnologyWin','refreshWin')
local treeId=yandaotaiModel:getTechnologyTreeId(technology_id)
local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,treeId)
if cfg.type==YDT_TREE_TYPE.eChuanCheng then
UIManager:invokeUIMethod('UIYanDaoTaiWin','refreshWin')
else
UIManager:invokeUIMethod('UIYanDaoTaiDaoZangWin','refreshWin')
end
yandaotaiController.refreshBulidHud()

reddotControl.on_change_catch_type(CATCH_TYPE.eYanDaoTaiChange)
end




function yandaotaiController.recv_6_178(len,technologyIds)
if len>0 then
for k,v in ipairs(technologyIds)do
yandaotaiModel:addTechnologyListLevel(v)


local config=cfgHelper.get2(cfg_technologyconfig_get,v,1)
if config then
local name=config.technology_name
local level=yandaotaiModel:getTechnologyListLevel(v)or 1

UIManager.info(string.format('%s科技等级提升到%s级',name,level))

local effect=config.study_effect
if effect then
for k,v in ipairs(effect)do
local type=v[1]
if type==5 then
local attrId=v[2][1][1]

xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aYanDaoTai,attrId)

end
end
end
end
end
end

yandaotaiModel:cancelStudy()
UIManager:invokeUIMethod('UITechnologyWin','refreshLevel')
UIManager:invokeUIMethod('UIYanDaoTaiWin','refreshWin')
UIManager:invokeUIMethod('UIYanDaoTaiDaoZangWin','refreshWin')
yandaotaiController.refreshBulidHud()
XianYunGangModel:refreshCanBuildBoatList()
xianJieFortInfoController:refreshAllInfo()
UIFullYanDaoTaiControl:refreshMainMenu()

reddotControl.on_change_catch_type(CATCH_TYPE.eYanDaoTaiChange)
end


function yandaotaiController.recv_6_179()
local data=yandaotaiModel:getStudyList()
if data and data.id then
local cfg=cfgHelper.get2(cfg_technologyconfig_get,data.id,1)
UIManager.info(string.format('取消研究%s，材料已返还',cfg.technology_name))
end

yandaotaiModel:cancelStudy()

UIManager:invokeUIMethod('UITechnologyWin','stopLevelUpTimer')
UIManager:invokeUIMethod('UITechnologyWin','refreshWin')
UIManager:invokeUIMethod('UIYanDaoTaiWin','refreshWin')
UIManager:invokeUIMethod('UIYanDaoTaiDaoZangWin','refreshWin')
yandaotaiController.refreshBulidHud()

reddotControl.on_change_catch_type(CATCH_TYPE.eYanDaoTaiChange)
end





function yandaotaiController:getBuildData()
local buildDataList=zongmenModel:getAllBuildingDataByBdId(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)or{}
return buildDataList[1]
end

function yandaotaiController:checkCanLevelUp(warning)
local bdData=yandaotaiController:getBuildData()

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if nextLvCfg then
local flag=zongmenControl:checkLevelUp(nextLvCfg,warning,mapIdType.fort)
if flag then
return true
end
end

return false
end

function yandaotaiController:checkLevelUpFinish()
local list=yandaotaiModel:getStudyList()

if list then
local icon
local state
local id=list.id
if id then
local level=yandaotaiModel:getTechnologyListLevel(id)or 1
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
local value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)
local study_time=yandaotaiController.getchangeSpeed(cfg.study_time,value2)
local time=study_time
icon=cfg.winParams[1]

local flag=yandaotaiModel:checkStudyisFinishTime(id,time)
if flag then
state=1
return flag,state,icon,id
else
state=3
return not flag,state,icon,id
end
end
end
return false
end

function yandaotaiController:checkIsCanStudy(treeId)
local bdLevel=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)
if not bdLevel or bdLevel==0 then
return false
end

if not treeId then
local cfgs=cfg_technologytreeconfig()
for i,v in ipairs(cfgs)do
if yandaotaiModel:getIsOpenTree(i)and self:checkIsCanStudyEx(i)then
return true
end
end
else
if yandaotaiModel:getIsOpenTree(treeId)and self:checkIsCanStudyEx(treeId)then
return true
end
end
return false
end

function yandaotaiController:checkIsCanStudyEx(treeId)
local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,treeId)
local ids=yandaotaiModel:getTechnologyIds(cfg.type,cfg.tabIdx)

for id,v in pairs(ids)do
local time=yandaotaiModel:getStudyListTime(id)
if not time then
local level,limitLevel,maxLevel,isMaxLevel=yandaotaiModel:isMaxLevel(id)

if not isMaxLevel then
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
local flag=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)and yandaotaiModel:checkIsEnoughCost(cfg.study_cost)
local isFull=isMaxLevel or level>=limitLevel

if flag and not isFull then
return flag
end
end
end
end
return false
end

function yandaotaiController:checkHudState()
local flag,state,icon,id=self:checkLevelUpFinish()
if flag then return state,icon,id end
if self:checkIsCanStudy()then return 2 end

return 0
end

function yandaotaiController:getBuildUnBulidId()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)
if bdDatas and next(bdDatas)then
return bdDatas[1].un_build_id
end
end

function yandaotaiController:getBuildData()
local buildDataList=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)or{}
return buildDataList[1]
end

function yandaotaiController:getBuildLevel()
local data=yandaotaiController:getBuildData()
return data and data.level or 0
end



function yandaotaiController.getchangeSpeed(study_time,value2)
if value2 and value2>0 then
return math.ceil(study_time*(1-value2/10000))
end
return study_time
end

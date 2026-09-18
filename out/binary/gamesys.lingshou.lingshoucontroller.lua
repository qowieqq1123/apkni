










































local _MODULENAME="lingshouController"
gameState.addListener(def_table(_MODULENAME))
lingshouController.name=_MODULENAME

function lingshouController:onAppStart()
lingshouModel:onAppStart()
socketManager:register_receiver(19,1,lingshouController.do_protocol_19_1)
socketManager:register_receiver(19,2,lingshouController.do_protocol_19_2)
socketManager:register_receiver(19,3,lingshouController.do_protocol_19_3)
socketManager:register_receiver(19,4,lingshouController.do_protocol_19_4)

socketManager:register_receiver(19,8,lingshouController.do_protocol_19_8)
socketManager:register_receiver(19,9,lingshouController.do_protocol_19_9)
socketManager:register_receiver(19,10,lingshouController.do_protocol_19_10)
socketManager:register_receiver(19,11,lingshouController.do_protocol_19_11)
socketManager:register_receiver(19,12,lingshouController.do_protocol_19_12)
socketManager:register_receiver(19,13,lingshouController.do_protocol_19_13)
socketManager:register_receiver(19,14,lingshouController.do_protocol_19_14)
socketManager:register_receiver(19,15,lingshouController.do_protocol_19_15)
socketManager:register_receiver(19,108,lingshouController.do_protocol_19_108)

lingshouController:onAppStart_xuemai()
lingshouController:onAppStart_chuangong()
lingshouController:onAppStart_kickout()
end

function lingshouController:onEnterState()
self.waitEventGuid=nil
lingshouModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:listenNotify(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChanged)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:listenNotify(notifyConfig.onLingShouCatchLittleGameEnd,self.onLingShouCatchLittleGameEnd)
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish,self.on_mystery_event_finish)
notifySystem:listenNotify(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
worldController:registerSceneState(worldModel.ON_SCENE_STATE.ENTER,1,function()
lingshouController:onEnterWorld(worldModel.world)
end)

lingshouController:onEnterState_xuemai()
lingshouController:onEnterState_chuangong()

timeEventController.addNormalTimerHandler(1,lingshouController.name,lingshouController)
end

function lingshouController:onLeaveState()
notifySystem:removelistener(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:removelistener(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChanged)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:removelistener(notifyConfig.onLingShouCatchLittleGameEnd,self.onLingShouCatchLittleGameEnd)
notifySystem:removelistener(notifyConfig.on_mystery_event_finish,self.on_mystery_event_finish)
notifySystem:removelistener(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)
notifySystem:removelistener(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
lingshouModel:onLeaveState()

lingshouController:onLeaveState_xuemai()
lingshouController:onLeaveState_chuangong()

lingshouModel:onLeaveState_traiteffect()
self.waitEventGuid=nil
end

function lingshouController:onPlayerCreate(...)

end

function lingshouController:onLostConnection()
lingshouController:onLostConnection_xuemai()
lingshouController:onLostConnection_chuangong()
end




function lingshouController:reqLingShouList()
socketManager:send_19_1()
end


function lingshouController:reqChangeName(guid,name)
socketManager:send_19_2(guid,name)
end


function lingshouController:reqJJBroke(guid)
if lingshouModel:checkNoOptState(guid)then return end

socketManager:send_19_3(guid)
end


function lingshouController:reqQlUp(guid)
if lingshouModel:checkNoOptState(guid)then return end

socketManager:send_19_4(guid)
end


function lingshouController:reqAwake(guid)
if lingshouModel:checkNoOptState(guid)then return end

socketManager:send_19_5(guid)
end


function lingshouController:reqRongHe(guid,ls_list)
if lingshouModel:checkNoOptState(guid)then return end

local len=#ls_list
socketManager:send_19_6(guid,len,ls_list)
end


function lingshouController:reqUpMainSKill(guid)
if lingshouModel:checkNoOptState(guid)then return end

socketManager:send_19_14(guid)
end


function lingshouController:reqLSRefreshOrder(lsGuid,order)
order=mathHelper.number_to_int64(order)
local list={{lsGuid,order}}
socketManager:send_19_15(1,list)
end


function lingshouController:send_19_108(lsGuid,qlReset,xmReset,zdjnReset)
socketManager:send_19_108(lsGuid,qlReset,xmReset,zdjnReset)
end





function lingshouController.changeLSNetData(lsData)
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsData.id)
lsData.cfg=lscfg
end


function lingshouController.do_protocol_19_1(len,lingshouList)



















if lingshouList then
for i,v in ipairs(lingshouList)do
lingshouController.changeLSNetData(v)
end
end
lingshouModel:initLingShouDatas(lingshouList)
end


function lingshouController.do_protocol_19_2(guid,name,ret_code)

if ret_code==0 then
local lsData=lingshouModel:getLingShouData(guid)
if lsData then
local old=lsData.name
lsData.name=name
UIManager:callWindowFunc('UILingShouModelWin','rec_changeName',guid,name)
notifySystem:postNotify(notifyConfig.onChangeName,changeNameType.eLingshou,old,name)
end
else
local log_str=changeNameLog:getlog(ret_code)
UIManager.error(log_str)



end
end


function lingshouController.do_protocol_19_3(guid)
UIManager.info('灵兽突破成功')
lingshouModel:setLingShouJJDirty()
UIManager:callWindowFunc('UILingShouJingJieWin','rec_broke',guid)
end


function lingshouController.do_protocol_19_4(guid)
local lsData=lingshouModel:getLingShouData(guid)
if lsData then
lsData.qianli=lsData.qianli+1

local qianliItemList=lsData.qianliItemList or{}
local qlcfg=cfgHelper.get(cfg_lingshouqianliconfig_get,lsData.qianli)
for i,v in ipairs(qlcfg.cost)do
local f=false
for i2,v2 in ipairs(qianliItemList)do
if v2.param_1==v[1]then
f=true
v2.param_2=v2.param_2+v[2]
break
end
end
if not f then
table.insert(qianliItemList,{param_1=v[1],param_2=v[2],param_3=0})
end
end
lsData.qianliItemList=qianliItemList
lsData.qianli_item_len=#qianliItemList


lingshouModel:setAttrListDirtyX(guid,lingshouAttributeType.eJingJie,true)
lingshouModel:setAttrListDirtyX(guid,lingshouAttributeType.eQianLi,true)

UIManager.info('潜力提升成功')
UIManager:callWindowFunc('UILingShouQianLiWin','rec_qianliUp',guid)
end
end




























function lingshouController.do_protocol_19_8(lingshouinfo)
lingshouController:addLingShou(lingshouinfo)
end


function lingshouController.do_protocol_19_9(guid)

local flag=lingshouModel:removeLingShouData(guid)
if flag then

lingShouAIManager:handleRemoveLingShou(guid)
lingshouModel:setLingShouJJDirty()
notifySystem:postNotify(notifyConfig.onLingShouRemove,guid)
end
end


function lingshouController.do_protocol_19_10(len,list)
if len>0 then
for i,v in ipairs(list)do
local lsData=lingshouModel:getLingShouData(v.param_1)
if lsData then
local old_value=lsData.xinqing
lsData.xinqing=v.param_2

if old_value~=lsData.xinqing then
notifySystem:postNotify(notifyConfig.onLingShouXinQingChanged,v.param_1,old_value,lsData.xinqing)
end
end
end
end
end


function lingshouController.do_protocol_19_11(len,list)





if len>0 then
for i,v in ipairs(list)do
lingshouController.do_protocol_19_7(v.guid,v.lv,v.exp)
end
end
end


function lingshouController.do_protocol_19_12(len,list)
if len>0 then
for i,v in ipairs(list)do
local lsData=lingshouModel:getLingShouData(v.param_1)
if lsData then
local old_value=lsData.born_times
lsData.born_times=v.param_2

if old_value~=lsData.born_times then
notifySystem:postNotify(notifyConfig.onLingShouFanYanChanged,v.param_1,old_value,lsData.born_times)
end
end
end
end
end


function lingshouController.do_protocol_19_7(guid,jj_lvl,jj_exp)
jj_exp=mathHelper.int64_to_number(jj_exp)
local lsData=lingshouModel:getLingShouData(guid)
if lsData then
local old_lv=lsData.jj_lvl
local old_exp=lsData.jj_exp
lsData.jj_lvl=jj_lvl
lsData.jj_exp=jj_exp

if old_lv~=jj_lvl then
lingshouModel:setAttrListDirtyX(guid,lingshouAttributeType.eJingJie,true)
lingshouModel:setLingShouJJDirty()
end

if old_lv~=jj_lvl or old_exp~=jj_exp then
notifySystem:postNotify(notifyConfig.onLingShouJJChange,guid,old_lv,jj_lvl,old_exp,jj_exp)
end
end
end

function lingshouController.do_protocol_19_13(len,list)
if len>0 then
for i,v in ipairs(list)do
local lsGuid=v.param_1
local newState=v.param_2
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
local oldState=lsData.pet_state
lsData.pet_state=newState
lingshouModel:onStateChange(lsGuid,oldState,newState)
end
end
end
end


function lingshouController.do_protocol_19_14(guid)
local lsData=lingshouModel:getLingShouData2(guid)
lsData.skill_level=lsData.skill_level+1
reddotControl.on_change_catch_type(CATCH_TYPE.eLingShouMainSkillChange)
end


function lingshouController.do_protocol_19_15(len,list)
if len==nil or len<=0 then return end
if list==nil then return end
for _,v in ipairs(list)do
lingshouModel:setLSOrder(v.param_1,v.param_2)
end
end


function lingshouController.do_protocol_19_108(lsGuid)
UIManager.info('成功重置')
UIManager:invokeUIMethod("UILingShouInfoWin","refreshView")
UIManager:invokeUIMethod("UILingShouModelWin","freshLingShouCZ")
UIManager:invokeUIMethod("UILingShouXueMaiWin","refreshAll")

end


function lingshouController:enterLingShouDaoMap(callback)
local callback_
if callback then
callback_=function(flag,...)
if not flag then
return
end
callback(flag,...)
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.lingshoudao},nil,callback_)
end

function lingshouController:jumpToLingShouStatePos(guid,closeUICallBack)
if MysteryModel:is_enter_Mystery()then

UIManager.error("当前正处于副本中")
return
end

local isCloseUI=false
local isJump=false
local bdData
local state=lingshouModel:getHighestStateType(guid)
if state then
if state==eLingShouStateType.petBuild then

local ubdId=UIShouLanModel:getShouLanUbdIdByLsGuid(guid)
if ubdId then
bdData=zongmenModel:getBuildingData(ubdId)
end
elseif state==eLingShouStateType.petBorn then


elseif state==eLingShouStateType.petEquip then


end
end

if bdData then
local sfId=zongmenModel:getBuildingLocationMapId(bdData.un_build_id)
local callBack=function()
UIFullDiscipleMainControl:checkLinkRoadToOpenBuilding(sfId,bdData.un_build_id)
end

local targetPos_x=bdData.x
local targetPos_y=bdData.y
local sfCallBack=function(flag_)
if flag_ then

local temppos=_MapManager.ToVector3Int(targetPos_x,targetPos_y,0)
local mapId=zongmenModel:getMountainId()
local pos=_MapManager.GetCellCenterWorld(mapId,temppos,mapLayer.Data)
isometricMapSystem:moveCameraToPosition(pos,true,callBack)
end
end

cameraMoveController:Begin({eSceneType.eZongmen,sfId},nil,sfCallBack)
isJump=true
end


if not isJump then

return
end

if not isCloseUI and closeUICallBack then
closeUICallBack()
end
end

function lingshouController.onDiscipleLingShouChange(dis_guid,changeType,ls_guid1,ls_guid2)
if UIDiscipleModel:isMyActorDZ(dis_guid)then
local showFightTips=true
UIDiscipleModel:setDiscipleAttrListDirtyX(dis_guid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,showFightTips)
end
end

function lingshouController.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eLingShou then

local cur=mainControl:getSceneType()
if cur==eSceneType.eWorld then









else

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.OpenLingShouSysNotInWorld)
end

end
end

function lingshouController.onWorldBlockStateChanged(world,block,state)
if world==2 and block==1 and state==eWorldBlockState.OPEN then

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
if isOpen then

local treeName="story_48_lingshouzb_1"
storyAICommonManager:startStoryBehavior(treeName)
end
end
end

function lingshouController:onEnterWorld(worldId)
if worldId==2 then

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
if isOpen then

local isFinishNewBie=lingshouController:checkLingShouNewBieIsFinish(NEWBIE_LUA_FUNC_NAME.OpenLingShouSysInWorld)
if not isFinishNewBie then

local treeName="story_48_lingshouzb_1"
storyAICommonManager:startStoryBehavior(treeName)
end
end
end
end

function lingshouController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
lingshouController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
lingshouController:onLeaveHome()
end
end
function lingshouController:onEnterHome(worldId)

















end

function lingshouController:onLeaveHome()

end

function lingshouController.onEnterHomeFinish()
local mapId=zongmenModel:getMountainId()
local isOpenLSF=systemModel.isOpen(SYSTEM_DEFINE.eLingShouFeng)
if isOpenLSF then
if mapId==mapIdType.zhufeng then

local isFinishWorldOpenLsSys=lingshouController:checkLingShouNewBieIsFinish(NEWBIE_LUA_FUNC_NAME.OpenLingShouSysInWorld)
if isFinishWorldOpenLsSys then

local isFinishOpenLSF=lingshouController:checkLingShouNewBieIsFinish(NEWBIE_LUA_FUNC_NAME.OpenLingShouFengSys)
local isFinishEnterLSF=lingshouController:checkLingShouNewBieIsFinish(NEWBIE_LUA_FUNC_NAME.EnterLingShouFeng)
if not isFinishOpenLSF and not isFinishEnterLSF then

local treeName="story_47_lingshoufeng_1"
storyAICommonManager:startStoryBehavior(treeName)
end
end
elseif mapId==mapIdType.lingshoudao then
local isFinishEnterLSF=lingshouController:checkLingShouNewBieIsFinish(NEWBIE_LUA_FUNC_NAME.EnterLingShouFeng)
if not isFinishEnterLSF then

local bdId=2001
local build=isometricMapSystem:getAnyRepairData(bdId)
if build==nil then








return
end


local treeName="story_49_lingshoufeng_2"
storyAICommonManager:startStoryBehavior(treeName)
end
end
end
end

function lingshouController.onMountainChange(oldid,id)


























end

function lingshouController:checkLingShouNewBieIsFinish(luaFuncName)
local config=newbieModel.getLookupConfig(NEW_BIE_CND_TYPE.eLuaFun,luaFuncName)
local newbieId=config and config.id or nil
if newbieId then
return newbieModel.isFinish(newbieId)
else

return true
end
return false
end

function lingshouController:getLingShouNewBieIdByLuaFuncName(luaFuncName)
local config=newbieModel.getLookupConfig(NEW_BIE_CND_TYPE.eLuaFun,luaFuncName)
local newbieId=config and config.id or nil
return newbieId
end

function lingshouController.onLingShouCatchLittleGameEnd(eventGuid)
if eventGuid then
lingshouController.waitEventGuid=eventGuid
end
end

function lingshouController.on_mystery_event_finish(sysId,eventGuid,eventgroupid)
if lingshouController.waitEventGuid and mathHelper.compareInt64(lingshouController.waitEventGuid,eventGuid)then
lingshouController.waitEventGuid=nil


newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.GetFirstLingShouInZhuaBu)
end
end

function lingshouController.onDiscipleJobChange(discipleguid,jobtype,oldlv,lv,oldexp,exp)
if jobtype==DISCIPLE_PROSKILL_TYPE.eSiYang and oldlv~=lv then
local lsGuid=UIDiscipleModel:getDZLingShou(discipleguid)
if lsGuid then
lingshouModel:setAttrListDirtyX(lsGuid,lingshouAttributeType.eDJob,true)
end
end
end


function lingshouController:addLingShou(lingshouinfo)
lingshouController.changeLSNetData(lingshouinfo)
local guid=lingshouinfo.guid
local old_lv
local old_exp
local old_qianli
local lsData=lingshouModel:getLingShouData(guid)
if lsData then
old_lv=lsData.jj_lvl
old_exp=lsData.jj_exp
old_qianli=lsData.qianli
end
local isnew=lingshouModel:addLingShouData(lingshouinfo)
if isnew then

lingShouAIManager:handleAddLingShou(lingshouinfo)
else
local jj_lvl=lingshouinfo.jj_lvl
local jj_exp=lingshouinfo.jj_exp
if old_lv~=jj_lvl then
lingshouModel:setAttrListDirtyX(guid,lingshouAttributeType.eJingJie,true)
lingshouModel:setLingShouJJDirty()
end

if jj_lvl~=old_lv or jj_exp~=old_exp then
notifySystem:postNotify(notifyConfig.onLingShouJJChange,guid,old_lv,jj_lvl,old_exp,jj_exp)
end

local qianli=lingshouinfo.qianli
if qianli~=old_qianli then
lingshouModel:setAttrListDirtyX(guid,lingshouAttributeType.eQianLi,true)
end
end
notifySystem:postNotify(notifyConfig.onLingShouGetOrUpdate,lingshouinfo,isnew)
end



function lingshouController:onNormalUpdate(delay)
lingshouController:normalUpdate_chuangong()
end


function lingshouController:checkLingShouCZopen(lsData)
local flag=false
for i=1,3 do
if i==1 then

local qianli_init=lsData.qianli_init or 0
local qianli=lsData.qianli or 0
if qianli_init~=qianli then
flag=true
break
end
elseif i==2 then

local xuemai=lsData.cfg.xuemai
local xuemai_val_init=xuemai and xuemai[2]or 1
local xuemai_val=lsData.xuemai_val or 1
local xuemai_dianshu=lsData.xuemai_dianshu or 0
if xuemai_dianshu>0 or xuemai_val~=xuemai_val_init then
flag=true
break
end
elseif i==3 then

local skill_level=lsData.skill_level or 0
local skill_level_init=lsData.skill_level_init or 0
if skill_level~=skill_level_init then
flag=true
break
end
end
end
return flag
end

function lingshouController:showLingShouCZwin(lsGuid)
UIManager:showWindow('UILingShouCZWin',{lsGuid=lsGuid})
end














local _MODULENAME="guildOrderController"
gameState.addListener(def_table(_MODULENAME))
guildOrderController.name=_MODULENAME

function guildOrderController:onAppStart()
socketManager:register_receiver(3,246,guildOrderController.do_protocol_3_246)
socketManager:register_receiver(3,247,guildOrderController.do_protocol_3_247)
socketManager:register_receiver(3,248,guildOrderController.do_protocol_3_248)
end

function guildOrderController:onEnterState(isReconnet)
if not isReconnet then
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildEvent)
notifySystem:listenNotify(notifyConfig.onGameCounterChange,self.onGameCounterChange)

notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)

notifySystem:listenNotify(notifyConfig.create_sundrise,self.create_sundrise)
notifySystem:listenNotify(notifyConfig.onEmergenciesStart,self.onEmergenciesStart)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_level_change)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)

guildOrderModel:initSetupConfig()
guildOrderController:initAI()
end
end

function guildOrderController:onLeaveState(isReconnet)
guildOrderModel:clearData()
guildOrderModel:clearCondChangeLookup()

if not isReconnet then
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:removelistener(notifyConfig.building_event,self.onBuildEvent)
notifySystem:removelistener(notifyConfig.onGameCounterChange,self.onGameCounterChange)

notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

notifySystem:removelistener(notifyConfig.create_sundrise,self.create_sundrise)
notifySystem:removelistener(notifyConfig.onEmergenciesStart,self.onEmergenciesStart)
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_level_change)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)

guildOrderController:clearAI()
end
end

function guildOrderController:onPlayerCreate(...)
end

function guildOrderController:onProtocolReq(isReconnect)
guildOrderModel:initCondTypeLookup()

end

function guildOrderController:onOpenView(isReconnect)
if not isReconnect then
if mainControl:isInScene(eSceneType.eZongmen)then
timeEventController.delayDo(1,function()
guildOrderController:initAllAI()
end)
end
end
end

function guildOrderController:onLostConnection()

end




function guildOrderController.onMoneyChange(moneyType,lastVal,val)
guildOrderModel:disposeItemChange(moneyType)
end


function guildOrderController.on_item_list_changed(args)
for _,v in ipairs(args)do
guildOrderModel:disposeItemChange(v[3])
end
end


function guildOrderController.onDiscipleCreate(dis_guid)
guildOrderModel:disposeCondChange(guildOrderCondType.eDZJingJieNum)
end


function guildOrderController.onDiscipleRemove(kickoutType,dis_guid)
guildOrderModel:disposeCondChange(guildOrderCondType.eDZJingJieNum)
end


function guildOrderController.onDiscipleJJChange(dis_guid,oldlv,lv,oldexp,exp)
if oldlv~=lv then
guildOrderModel:disposeCondChange(guildOrderCondType.eDZJingJieNum)
end
end


function guildOrderController.onBuildEvent(eventType,param1,param2,param3)
if eventType==buildingEvent.zongmenLevelUp and param3~=param1 then

guildOrderModel:disposeCondChange(guildOrderCondType.eZongMenLevel)
end

if eventType==buildingEvent.levelUpComplete then
local data=zongmenModel:getBuildingData(param2)
if not data then
return
end
local id=data.build_id
local un_build_id=data.un_build_id
local dataslist=guildOrderController:getAllDefId()or{}
local localdefId=dataslist[tostring(un_build_id)]
if localdefId then
local level=data.level
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,level)
local plans=lcfg.produce_plans
local index=#plans or 1
guildOrderController:setAllDefId({un_build_id,index})
end
end
end


function guildOrderController.onGameCounterChange(accutype)
if accutype==gameCounterType.eYinXianTaiZhaoMuNum then
guildOrderModel:disposeCondChange(guildOrderCondType.eYinXianTaiZhaoMuNum)
elseif accutype==gameCounterType.eFangShiBuyNum then
guildOrderModel:disposeCondChange(guildOrderCondType.eFangShiBuyNum)
end
end

function guildOrderController.on_system_open(sysid)
if sysid==SYSTEM_DEFINE.eZongMenOrder then

reddotControl.on_change_catch_type(CATCH_TYPE.eGuildOrderReddotChange)

guildOrderController:refreshBuildHud()
end
end

function guildOrderController.create_sundrise(id,guid,stype)
if stype==sundriseType.eStillSundrise then
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoCleaning,true)
elseif stype==sundriseType.eStillEnemy then
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoFightMonster,true)
end
end

function guildOrderController.onEmergenciesStart(eventType,eventId)
if eventType==emergenciesType.eMonsterInvasion then
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoFightMonster,true)
elseif eventType==emergenciesType.eBuildingOnFire then
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoFireFighting,true)
elseif eventType==emergenciesType.eYiMuCongSheng then
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoCaoLing,true)
end
end

function guildOrderController.on_level_change(level,exp)

reddotControl.on_change_catch_type(CATCH_TYPE.eGuildOrderReddotChange)

guildOrderController:refreshBuildHud()
end


function guildOrderController:refreshBuildHud()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eZongMen)
if bdDatas then
local bdData=bdDatas[1]
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
end

function guildOrderController.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eZMMonster or prizeType==ePrizeType.eMonsterInvade then
if effectData.auto_clear==1 then
for i,v in ipairs(prizelist)do
UIManager.rewardInfo(iconHelper.getIconName(v.itemid),FMT.fmt('X{0}',v.num))
end
end
end
end



function guildOrderController:send_3_247(orderID)

socketManager:send_3_247(orderID)
end



function guildOrderController:send_3_248(auto_type,auto_value)
socketManager:send_3_248(auto_type,auto_value)
end





function guildOrderController.do_protocol_3_246(len,list)


guildOrderModel:initData(list)
end


function guildOrderController.do_protocol_3_247(orderID,err_code)



if err_code==0 then
guildOrderModel:activeOrder(orderID)
UIManager:invokeUIMethod('UIGuildOrderWin','rec_active',orderID)

UIManager:showWindow('UIGuildOrderAcitveWin',{orderID=orderID})

reddotControl.on_change_catch_type(CATCH_TYPE.eGuildOrderReddotChange)

guildOrderController:refreshBuildHud()
notifySystem:postNotify(notifyConfig.onGuildOrderChange,orderID)
else
local error_str
if err_code==1 then
error_str='弟子指定境界数量不足'
elseif err_code==2 then
error_str='宗门等级没达到'
elseif err_code==3 then
error_str='引仙台次数不够'
elseif err_code==4 then
error_str='访市购买次数不够'
end
UIManager.error(error_str)
end
end

function guildOrderController.do_protocol_3_248(auto_type,auto_value)
if auto_type==2 then
emergenciesControl:endMonsterFight(auto_value,1)
end
end


function guildOrderController:cleargetAllDefId()
local data={}
userActorSetting.set('guildOrderAutoShengChanBuild',{})
userActorSetting.set("UIGOSetupWin_ZDSC",data)
userActorSetting.flush()
end


function guildOrderController:getAllDefId()
local DefId=userActorSetting.get('UIGOSetupWin_ZDSC',{})
return DefId
end

function guildOrderController:setAllDefId(list)
if list and next(list)then
local data=userActorSetting.get('UIGOSetupWin_ZDSC',{})
local defId=list[2]
local un_build_id=list[1]

if data then
data[tostring(un_build_id)]=defId
else
data={}
data[tostring(un_build_id)]=defId
end
userActorSetting.set("UIGOSetupWin_ZDSC",data)
userActorSetting.flush()
end
end


function guildOrderController:setAutoSC(flag)
guildOrderController.autoSCflag=flag
end
function guildOrderController:getAutoSC()
return guildOrderController.autoSCflag
end


function guildOrderController:handleAutoShengChan()
local _cfg=cfgHelper.get(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoShengChan)
if _cfg and((not guildOrderModel:checkSystemCnd(_cfg))or(not guildOrderModel:checkOrderCondEx(_cfg.unlock)))then
return false
end
local orderID=GUILD_ORDER_TYPE.eAutoShengChan
local setup,cfg=guildOrderModel:getSetupData(orderID)
local isStopAuto=guildOrderModel:getIsStopAutoShengChan()
if setup.isOpen and not isStopAuto then
local scFlaglist=setup.scFlaglist
local scbuildList={2,3,4,7,8,9}
local _list={}
for k,v in ipairs(scFlaglist)do
if v==1 then
_list[scbuildList[k]]=true
end
end
local olddata={}
local datas2,topTypes2=zongmenControl:fastManufacture({})
for i,v in ipairs(datas2)do
olddata[v.data.un_build_id]=v.defId
end
local list=guildOrderController:getAllDefId()or{}
local newlist={}
for i,v in pairs(list)do
local old_defId=v
local un_build_id=tonumber(i)
local now_defId=olddata[un_build_id]
if now_defId then
if old_defId<=now_defId then
newlist[un_build_id]=old_defId
else
newlist[un_build_id]=now_defId
end
end
end

local datas,topTypes=zongmenControl:fastManufacture(newlist)
local showTips=false
local reqlist={}
for i,v in ipairs(datas)do
if v.defId>0 and#v.need<=0 then
if not emergenciesModel:isCreeper(v.data.un_build_id)then
local buildid=v.data.build_id
if _list[buildid]then
table.insert(reqlist,{v.defId,v.data.un_build_id})
showTips=true
end
end
end
end
if mainControl:isInScene(eSceneType.eWorld)and showTips then
return
end
local reqCnt=#reqlist
if reqCnt>0 then
zongmenControl:reqSchemePlantEx(zongmenModel:getMountainId(),#reqlist,reqlist)
end

end
end


function guildOrderController:handleSingleAutoShengChan(ubdId)
local _cfg=cfgHelper.get(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoShengChan)
if _cfg and((not guildOrderModel:checkSystemCnd(_cfg))or(not guildOrderModel:checkOrderCondEx(_cfg.unlock)))then
return false
end
local orderID=GUILD_ORDER_TYPE.eAutoShengChan
local setup,cfg=guildOrderModel:getSetupData(orderID)
local isStopAuto=guildOrderModel:getIsStopAutoShengChan()
if setup.isOpen and not isStopAuto then
local scFlaglist=setup.scFlaglist
local scbuildList={2,3,4,7,8,9}
local _list={}
for k,v in ipairs(scFlaglist)do
if v==1 then
_list[scbuildList[k]]=true
end
end

local olddata={}
local datas2,topTypes2=zongmenControl:fastManufactureSingleBdId(ubdId,{})
for i,v in ipairs(datas2)do
olddata[v.data.un_build_id]=v.defId
end
local list=guildOrderController:getAllDefId()or{}
local newlist={}
for i,v in pairs(list)do
local old_defId=v
local un_build_id=tonumber(i)
local now_defId=olddata[un_build_id]
if now_defId then
if old_defId<=now_defId then
newlist[un_build_id]=old_defId
else
newlist[un_build_id]=now_defId
end
end
end

local datas,topTypes=zongmenControl:fastManufactureSingleBdId(ubdId,newlist)
local showTips=false
local reqlist={}
for i,v in ipairs(datas)do
if v.defId>0 and#v.need<=0 then
if not emergenciesModel:isCreeper(v.data.un_build_id)then
local buildid=v.data.build_id
if _list[buildid]then
table.insert(reqlist,{v.defId,v.data.un_build_id})
showTips=true
end
end
end
end
if mainControl:isInScene(eSceneType.eWorld)and showTips then
return
end
local reqCnt=#reqlist
if reqCnt>0 then
zongmenControl:reqSchemePlantEx(zongmenModel:getMountainId(),#reqlist,reqlist)
end
end
end


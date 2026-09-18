






local _MODULENAME="worldLongHuShanController"




gameState.addListener(def_table(_MODULENAME))
worldLongHuShanController.name=_MODULENAME
worldLongHuShanController.data={}



function worldLongHuShanController:onAppStart()

worldDailyEventModel:onAppStart()





notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickObjectInWorld)


worldController:registerSceneState(1,3,function()
worldLongHuShanController:showAllUnit()
end)

end


function worldLongHuShanController:onEnterState()
worldDailyEventModel:onEnterState()
end


function worldLongHuShanController:onServerDataInitFinish()
worldExperienceModel:onServerDataInitFinish()
end


function worldLongHuShanController:onLeaveState(isReconnet)
worldDailyEventModel:onLeaveState(isReconnet)
end


function worldLongHuShanController:onLostConnection()

end

function worldLongHuShanController:onProtocolReq()

end


function worldLongHuShanController:onReConnection(isReconnect)
if not isReconnect then
worldDailyEventModel:onReConnection()
return
end

end




function worldLongHuShanController.onClickObjectInWorld(args,atOnce)
if args and args[1]==worldModel.UNITTYPE.LONGHUSHAN then
local guid=args[2]
local isShow,showType,subid,act_id=worldLongHuShanModel:isShowUnit()
if isShow then
if showType==1 then
activitiesController:jump(act_id,SUB_ACTIVITY_TYPE.eLongHuHuiJuan,subid)
elseif showType==2 then
mainControl:enterHome({mapIdType.zhufeng},function()
emergenciesControl_HuiJuan:exeNPCClick(subid,true)
end)
end
end

end

end


function worldLongHuShanController:showAllUnit()
local isShow,showType,subid=worldLongHuShanModel:isShowUnit()

if isShow then
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld then
local cfg=cfgHelper.get(cfg_longhuhuijuanconfig_get,subid,"worldModel")
if cfg and worldModel.world==1 then
worldLongHuShanModel:showUnitImp({modelRes=cfg[1]},worldModel.world,cfg[2],cfg[3],false)
end
end
end
end


























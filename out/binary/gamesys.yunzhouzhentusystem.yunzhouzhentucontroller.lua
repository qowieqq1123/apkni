






local _MODULENAME="YunZhouZhenTuController"

gameState.addListener(def_table(_MODULENAME))
YunZhouZhenTuController.name=_MODULENAME
YunZhouZhenTuController.data={}

function YunZhouZhenTuController:onAppStart()
YunZhouZhenTuModel:onAppStart()

socketManager:register_receiver(6,189,YunZhouZhenTuController.recv_protocol_6_189)
socketManager:register_receiver(6,190,YunZhouZhenTuController.recv_protocol_6_190)

end


function YunZhouZhenTuController:onEnterState(isReconnect)
YunZhouZhenTuModel:onEnterState()
end


function YunZhouZhenTuController:onProtocolReq()
YunZhouZhenTuModel:onProtocolReq()
end


function YunZhouZhenTuController:onLeaveState(isReconnect)
YunZhouZhenTuModel:onLeaveState(isReconnect)

self.data={}
end


function YunZhouZhenTuController:onLostConnection()

end


function YunZhouZhenTuController:onReConnection(isInitPro)

end


function YunZhouZhenTuController:send_6_189()
socketManager:send_6_189()
end

function YunZhouZhenTuController:send_6_190(id,chongshu,zhenshu)
socketManager:send_6_190(id,chongshu,zhenshu)
end



function YunZhouZhenTuController.recv_protocol_6_189(len,yzztList)
YunZhouZhenTuModel:setYZZTData(len,yzztList)
end


function YunZhouZhenTuController.recv_protocol_6_190(id,level)
YunZhouZhenTuModel:setYZZTLevelUp(id,level)


notifySystem:postNotify(notifyConfig.onYunZhouZhenTuUpLevel,id,level)
UIManager:invokeUIMethod("UIXianYunGangWin","freshYyztReddot")



UIDiscipleModel:setAllDiscipleAttrListDirty({DISCIPLE_ATTRIBUTE_TYPE.eBase},true)


AudioManager.playAudio(634)
end




function YunZhouZhenTuController:checkYunZhouZhenTuSystem(showtip)

if systemModel.isOpen(SYSTEM_DEFINE.eiYunZhouZhenTu)then
return true
else
if showtip then
UIManager.info('系统暂未开放')
end
return false
end

return false
end


function YunZhouZhenTuController:OpenYunZhouZhenTuMainWin(_isjump)
if self:checkYunZhouZhenTuSystem(true)then
UIManager:showWindow('UIYunZhouZhenTuMainWin',{ztid=1,isjump=_isjump})
end
end


function YunZhouZhenTuController:JumpYunZhouZhenTuMainWin()
local cb=function()
YunZhouZhenTuController:OpenYunZhouZhenTuMainWin()
end

return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={
type=SLG_SYSTEM_TYPE.eXianYunGang,
mapid=mapIdType.fort,
scenetype=eSceneType.eZongmen
}},cb)
end

function YunZhouZhenTuController:jumptesttt()
jumpManager:jump({id=JUMP_TYPE.eYunZhouZhenTu})
end









local _MODULENAME="YingXianGeController"

gameState.addListener(def_table(_MODULENAME))
YingXianGeController.name=_MODULENAME
YingXianGeController.data={}

function YingXianGeController:onAppStart()

YingXianGeModel:onAppStart()




socketManager:register_receiver(35,7,YingXianGeController.recv_35_7)
socketManager:register_receiver(35,155,YingXianGeController.recv_35_155)
socketManager:register_receiver(35,130,YingXianGeController.recv_35_130)


end


function YingXianGeController:onEnterState(isReconnect)
YingXianGeModel:onEnterState()
end


function YingXianGeController:onProtocolReq()
YingXianGeModel:onProtocolReq()
end


function YingXianGeController:onLeaveState(isReconnect)
YingXianGeModel:onLeaveState(isReconnect)

self.data={}
self.bdData=nil
end


function YingXianGeController:onLostConnection()

end


function YingXianGeController:onReConnection(isInitPro)

end



function YingXianGeController.reqZhiYuan(actorid)
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx and xianjienSceneIndexType:isMoJie(sceneidx)then
YingXianGeController.reqZhiYuan_MoJie(actorid)
elseif sceneidx and xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
YingXianGeController.reqZhiYuan_MoGong(actorid)
else
YingXianGeController.reqZhiYuan_XianJie(actorid)
end
end



function YingXianGeController.reqZhiYuan_XianJie(actorid)
socketManager:send_35_7(actorid)
end





function YingXianGeController.recv_35_7(actorid,assistlistlen,assistlist)
















if assistlistlen>0 then
for _,v in ipairs(assistlist)do
if v.disciplelistlen>0 then
for _,vv in ipairs(v.guidlist)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
end
end
YingXianGeModel:setYZMYData(actorid,assistlistlen,assistlist,xjYuanZhuGroupType.eXianJie)

UIManager:invokeUIMethod("UIOthePlayerInfoWin","updateYuanZhuBtn")
UIManager:invokeUIMethod("UIYingXianGeMYYJWin","refresh")
UIManager:invokeUIMethod("UIYingXianGeWDYJWin","refresh")
UIManager:invokeUIMethod("UIXianJie_otherZmInfoWin","refreshYuanZhuBtnText")
end



function YingXianGeController.reqZhiYuan_MoJie(actorid)
socketManager:send_35_155(actorid)
end





function YingXianGeController.recv_35_155(actorid,assistlistlen,assistlist)
















if assistlistlen>0 then
for _,v in ipairs(assistlist)do
if v.disciplelistlen>0 then
for _,vv in ipairs(v.guidlist)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
end
end
YingXianGeModel:setYZMYData(actorid,assistlistlen,assistlist,xjYuanZhuGroupType.eMoJie)

UIManager:invokeUIMethod("UIOthePlayerInfoWin","updateYuanZhuBtn")
UIManager:invokeUIMethod("UIYingXianGeMYYJWin","refresh")
UIManager:invokeUIMethod("UIYingXianGeWDYJWin","refresh")
UIManager:invokeUIMethod("UIXianJie_otherZmInfoWin","refreshYuanZhuBtnText")
end



function YingXianGeController.reqZhiYuan_MoGong(actorid)
socketManager:send_35_130(actorid)
end





function YingXianGeController.recv_35_130(actorid,assistlistlen,assistlist)
















if assistlistlen>0 then
for _,v in ipairs(assistlist)do
if v.disciplelistlen>0 then
for _,vv in ipairs(v.guidlist)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
end
end
YingXianGeModel:setYZMYData(actorid,assistlistlen,assistlist,xjYuanZhuGroupType.eMoGong)

UIManager:invokeUIMethod("UIOthePlayerInfoWin","updateYuanZhuBtn")
UIManager:invokeUIMethod("UIYingXianGeMYYJWin","refresh")
UIManager:invokeUIMethod("UIYingXianGeWDYJWin","refresh")
UIManager:invokeUIMethod("UIXianJie_otherZmInfoWin","refreshYuanZhuBtnText")
end




function YingXianGeController:refreshYXGHUD()
local bdData=YingXianGeController:getBuildingData()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

function YingXianGeController:getBuildingData()
if not self.bdData then
self.bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYingXianGe)
end
return self.bdData
end

function YingXianGeController:getBuildingLevel()
local data=self:getBuildingData()
if data then
return data.level
end
return 0
end
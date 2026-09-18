






local _MODULENAME="XianYunGangController"

gameState.addListener(def_table(_MODULENAME))
XianYunGangController.name=_MODULENAME
XianYunGangController.data={}

function XianYunGangController:onAppStart()

XianYunGangModel:onAppStart()



socketManager:register_receiver(6,166,XianYunGangController.recv_6_166)
socketManager:register_receiver(6,167,XianYunGangController.recv_6_167)
socketManager:register_receiver(6,168,XianYunGangController.recv_6_168)
socketManager:register_receiver(6,169,XianYunGangController.recv_6_169)
socketManager:register_receiver(6,170,XianYunGangController.recv_6_170)
socketManager:register_receiver(6,171,XianYunGangController.recv_6_171)



end


function XianYunGangController:onEnterState(isReconnect)
XianYunGangModel:onEnterState()

notifySystem:listenNotify(notifyConfig.home_event,XianYunGangController.on_home_event)
end


function XianYunGangController:onProtocolReq()
XianYunGangModel:onProtocolReq()
end


function XianYunGangController:onLeaveState(isReconnect)
XianYunGangModel:onLeaveState(isReconnect)

notifySystem:removelistener(notifyConfig.home_event,XianYunGangController.on_home_event)

XianYunGangController:onLeaveState_Event()


self.data={}
self.bdData=nil
end


function XianYunGangController:onLostConnection()

end


function XianYunGangController:onReConnection(isInitPro)
if isInitPro then
XianYunGangController:onEnterState_Event()
end
end

function XianYunGangController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
XianYunGangController:onEnterState_Event()
elseif etype==homeEvent.eLeaveHome then

end
end

function XianYunGangController.on_money_changed(mtype,last,curr)
if XianYunGangModel:getIsBoatMoney(mtype)then
XianYunGangModel:setReddotFlag(true)
return
end
end



function XianYunGangController:onEnterState_Event(isReconnect)

notifySystem:listenNotify(notifyConfig.on_money_changed,XianYunGangController.on_money_changed)

notifySystem:listenNotify(notifyConfig.building_event,XianYunGangController.on_building_event)
end

function XianYunGangController:onLeaveState_Event()
notifySystem:removelistener(notifyConfig.on_money_changed,XianYunGangController.on_money_changed)

notifySystem:removelistener(notifyConfig.building_event,XianYunGangController.on_building_event)
end

function XianYunGangController.on_building_event(etype,sfId,ubdId,arg1,arg2)
local bdData=zongmenModel:getBuildingData(ubdId)
if not bdData or not XianYunGangModel:getIsBoatBybdId(bdData.build_id)then
return
end


if etype==buildingEvent.buildComplete or etype==buildingEvent.levelUpComplete then
XianYunGangModel:refreshBoatList()
end
XianYunGangModel:setReddotFlag(true)
end


function XianYunGangController.reqBoatInfo()
socketManager:send_6_166()
end


function XianYunGangController.reqYunZhouComponentsEquip(boat_id,equip_guid)
socketManager:send_6_167(boat_id,equip_guid)
end


function XianYunGangController.reqYunZhouComponentsTakeOff(boat_id,pos)
socketManager:send_6_168(boat_id,pos)
end


function XianYunGangController.reqYunZhouComponentsStrengthen(guid,pos,item_list_len,item_list,equipsListLen,equipList)
socketManager:send_6_169(guid,pos,item_list_len,item_list,equipsListLen,equipList)
end


function XianYunGangController.reqYunZhouComponentsCompose(guid,pos,equipsListLen,equipList,quick)
if quick then
XianYunGangController.quickCompose=true
end
socketManager:send_6_170(guid,pos,equipsListLen,equipList)
end


function XianYunGangController.reqYunZhouComponentsQuickCompose(target_id)
socketManager:send_6_171(target_id)
end




function XianYunGangController.recv_6_166(boat_list_len,boat_list)










XianYunGangModel:setBoatList(boat_list_len,boat_list)

UIManager:invokeUIMethod("UIXianYunGangWin","freshExplorationShip")
UIManager:invokeUIMethod("UIXianYunGangWin","refresh")
end




function XianYunGangController.recv_6_167(boat_id,itemguid)
XianYunGangModel:setYunZhouComponentsPosData(boat_id,itemguid)
UIManager:invokeUIMethod("UIXianYunGangWin","refreshEquipList")
UIManager:invokeUIMethod("UIXianYunGangWin","refreshDownPanel")
UIManager:invokeUIMethod("UIXianJie_YunZhouSelectWin","refreshSelectYunZhouInfo")
UIManager:invokeUIMethod("UIXianJie_YunZhouPrepareWin","refreshTopPanel")
end








function XianYunGangController.recv_6_168(boat_id,pos)
XianYunGangModel:setYunZhouComponentsPosData(boat_id,0,pos)
UIManager:invokeUIMethod("UIXianYunGangWin","refreshEquipList")
UIManager:invokeUIMethod("UIXianYunGangWin","refreshDownPanel")
UIManager:invokeUIMethod("UIXianJie_YunZhouSelectWin","refreshSelectYunZhouInfo")
UIManager:invokeUIMethod("UIXianJie_YunZhouPrepareWin","refreshTopPanel")
end










function XianYunGangController.recv_6_169(guid,pos,level,exp)
local oldlv
local item
if pos==0 then
item=bagModel.getItem(guid)
else
local boatid=tonumber(tostring(guid))
item=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
end
if item then
local itemData=item.itemData
oldlv=itemData.jinglianlv
end
XianYunGangModel:setYunZhouComponentsStrengthenData(guid,pos,level,exp)
UIManager:invokeUIMethod("UIYunZhouComponentsStrengthenWin","onJinglian",oldlv,level)
if oldlv and oldlv~=level then
UIManager:invokeUIMethod("UIXianYunGangWin","refreshEquipList")
UIManager:invokeUIMethod("UIXianYunGangWin","refreshDownPanel")
UIManager:invokeUIMethod("UIYunZhouComponentsStrengthenWin","refreshYunZhouEquipList")
end

if pos~=0 then
notifySystem:postNotify(notifyConfig.onYunZhouZhenQiPosChange)
end
end









function XianYunGangController.recv_6_170(guid,pos,oldItemId,ret_list_len,ret_list)
local item
local isEquiped=false
local itemguid
local newItemId
if pos==0 then
item=bagModel.getItem(guid)
itemguid=item and item.itemguid or nil
else
local boatid=tonumber(tostring(guid))
item=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
isEquiped=true
end
local cfg=cfgHelper.get1(cfg_boatequipmakeconfig_get,oldItemId)
if cfg then
newItemId=cfg.target
end
if item and not itemguid then
if newItemId then
item.itemid=newItemId
end
end
if not XianYunGangController.quickCompose then
UIManager:invokeUIMethod("UIYunZhouComponentsComposeWin","refreshYunZhouEquipList")
UIManager:invokeUIMethod("UIYunZhouComponentsComposeWin","onComposeCallBack",itemguid)
else
UIManager:invokeUIMethod("UIYunZhouComponentsComposeWin","onComposeCallBack")
end
XianYunGangController.quickCompose=nil

if isEquiped then
UIManager:invokeUIMethod("UIXianYunGangWin","refreshEquipList")
UIManager:invokeUIMethod("UIXianYunGangWin","refreshDownPanel")
end
UIManager:showWindow("UIYunZhouComponentsComposeResultWin",{oldItemId,newItemId,ret_list})
if pos~=0 then
notifySystem:postNotify(notifyConfig.onYunZhouZhenQiPosChange)
end
end


function XianYunGangController.recv_6_171(target_id,ret_list_len,ret_list)
UIManager:showWindow("UIYunZhouComponentsQuickComposeResultWin",{itemid=target_id,ret_list=ret_list})
UIManager:invokeUIMethod("UIYunZhouComponentsComposeWin","mainItemChangeRefresh")
end



function XianYunGangController:getBuildingData()
if not self.bdData then
self.bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
end
return self.bdData
end

function XianYunGangController:getBuildingLevel()
local data=self:getBuildingData()
if data then
return data.level
end
return 0
end

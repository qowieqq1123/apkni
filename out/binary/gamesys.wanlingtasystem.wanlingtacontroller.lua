






local _MODULENAME="wanLingTaController"




gameState.addListener(def_table(_MODULENAME))
wanLingTaController.name=_MODULENAME
wanLingTaController.data={}

function wanLingTaController:onAppStart()

wanLingTaModel:onAppStart()


socketManager:register_receiver(43,1,wanLingTaController.recv_43_1)
socketManager:register_receiver(43,2,wanLingTaController.recv_43_2)
socketManager:register_receiver(43,3,wanLingTaController.recv_43_3)
socketManager:register_receiver(43,4,wanLingTaController.recv_43_4)
socketManager:register_receiver(43,5,wanLingTaController.recv_43_5)
socketManager:register_receiver(43,6,wanLingTaController.recv_43_6)
socketManager:register_receiver(43,7,wanLingTaController.recv_43_7)

socketManager:register_receiver(1,16,wanLingTaController.recv_1_16)
end


function wanLingTaController:onEnterState()
wanLingTaModel:onEnterState()


notifySystem:listenNotify(notifyConfig.on_bagtype_item_list_changed,self.on_bagtype_item_list_changed)
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopDataReady)
notifySystem:listenNotify(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
end


function wanLingTaController:onProtocolReq()
wanLingTaModel:onProtocolReq()
funcShopController.send_23_1(eFuncShopType.eWanLingBaoKu)
end


function wanLingTaController:onLeaveState()
wanLingTaModel:onLeaveState()
notifySystem:removelistener(notifyConfig.on_bagtype_item_list_changed,self.on_bagtype_item_list_changed)
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopDataReady)
notifySystem:removelistener(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)

self.data={}
end


function wanLingTaController:onLostConnection()

end


function wanLingTaController.send_43_2(level)
socketManager:send_43_2(level)
end

function wanLingTaController.send_43_3(tj_id,itemNum,itemList)
socketManager:send_43_3(tj_id,itemNum,itemList)
end

function wanLingTaController.send_43_4(tj_id,itemNum,itemList,aim_lv)
socketManager:send_43_4(tj_id,itemNum,itemList,aim_lv or 0)
end

function wanLingTaController.send_43_5(sjId,itemNum,itemList)
itemNum=itemNum or 0
itemList=itemList or{}
socketManager:send_43_5(sjId,itemNum,itemList)
end

function wanLingTaController.send_43_6(guid,tjId)
socketManager:send_43_6(guid,tjId)
end

function wanLingTaController.send_43_7(tl_lv)
socketManager:send_43_7(tl_lv)
end







function wanLingTaController.recv_43_1(args)
local talingLevel,talingRewardLevel,tjJiHuoListLen,tjJiHuoList,sjListLen,sjList,dzNum,dzInfoList=table.unpackEx(args)
wanLingTaModel:setData({level=talingLevel,rewardLevel=talingRewardLevel,tjData=tjJiHuoList,sjList=sjList,dzInfoList=dzInfoList})
wanLingTaModel:setWanLingTaBaseAttrsDirtyFlag()
wanLingTaModel:setWanLingTaSpeAttrsDirtyFlag()
daobingModel:refreshAllDaoBingAttrsLookup()
gubaoModel:setGuBaoAllDirty()
UIDiscipleModel:setAllDiscipleAttrListDirty({DISCIPLE_ATTRIBUTE_TYPE.eWanLingTa})
wanLingTaController:refreshBuildingStatusHUD()
end



function wanLingTaController.recv_43_2(level)
wanLingTaModel:setData({rewardLevel=level})
wanLingTaController:refreshBuildingStatusHUD()
end



function wanLingTaController.recv_43_3(tjId)
wanLingTaModel:setData({tjData={{id=tjId,level=1}}})
wanLingTaModel:setWanLingTaBaseAttrsDirtyFlag()
local type=wanLingTaModel:getTuJianType(tjId)
if type==eWanLingTaShowcaseType.eTDLX then
UIManager:showWindow('UIWanLingTaTDLXActiveWin',{gbid=tjId})
wanLingTaModel:setWanLingTaSpeAttrsDirtyFlag()
daobingModel:refreshAllDaoBingAttrsLookup()
gubaoModel:setGuBaoAllDirty()
UIDiscipleModel:setAllDiscipleAttrListDirty({DISCIPLE_ATTRIBUTE_TYPE.eWanLingTa})
end
notifySystem:postNotify(notifyConfig.onWanLingTaTuJianChange,tjId,1)
wanLingTaController:refreshBuildingStatusHUD()
end




function wanLingTaController.recv_43_4(tjId,tjLevel)
wanLingTaModel:setData({tjData={{id=tjId,level=tjLevel}}})
wanLingTaModel:setWanLingTaBaseAttrsDirtyFlag()
local type=wanLingTaModel:getTuJianType(tjId)
if type==eWanLingTaShowcaseType.eTDLX then
wanLingTaModel:setWanLingTaSpeAttrsDirtyFlag()
daobingModel:refreshAllDaoBingAttrsLookup()
gubaoModel:setGuBaoAllDirty()
UIDiscipleModel:setAllDiscipleAttrListDirty({DISCIPLE_ATTRIBUTE_TYPE.eWanLingTa})
end
notifySystem:postNotify(notifyConfig.onWanLingTaTuJianChange,tjId,tjLevel)
wanLingTaController:refreshBuildingStatusHUD()
end



function wanLingTaController.recv_43_5(sjId)
wanLingTaModel:setData({sjList={sjId}})
wanLingTaModel:setWanLingTaBaseAttrsDirtyFlag()
local cfg=cfgHelper.get1(cfg_xumitasjjlconfig_get,sjId)
if cfg.speRewards and next(cfg.speRewards)then
wanLingTaModel:setWanLingTaSpeAttrsDirtyFlag()
daobingModel:refreshAllDaoBingAttrsLookup()
gubaoModel:setGuBaoAllDirty()
UIDiscipleModel:setAllDiscipleAttrListDirty({DISCIPLE_ATTRIBUTE_TYPE.eWanLingTa})
end
notifySystem:postNotify(notifyConfig.onWanLingTaCollectRewardReceive,sjId)
wanLingTaController:refreshBuildingStatusHUD()
end




function wanLingTaController.recv_43_6(dzId,jingjielv)
wanLingTaModel:setData({dzInfoList={{param_1=dzId,param_2=jingjielv}}})
end



function wanLingTaController.recv_43_7(tl_lv)
wanLingTaModel:setData({level=tl_lv})
UIManager.info(string.format("塔灵等级已提升至%d级",tl_lv))
end




function wanLingTaController.recv_1_16(itemListLen,itemList)

end



function wanLingTaController:getBuildData()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShenShouTa)
if bdDatas==nil or#bdDatas<=0 then return nil end
return bdDatas[1]
end

function wanLingTaController:refreshBuildingStatusHUD()
local bdData=wanLingTaController:getBuildData()
if bdData==nil then return end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end


function wanLingTaController.onCommonShopDataReady(shopType)
if shopType==eFuncShopType.eWanLingBaoKu then
wanLingTaModel:initShopItemList()
end
end

function wanLingTaController.onCommonShopChange(shopType,buyId,buyNum)
if shopType==eFuncShopType.eWanLingBaoKu then
UIManager:invokeUIMethod('UIWanLingBaoKuWin','refreshItemByID',buyId)
end
end


function wanLingTaController.on_bagtype_item_list_changed(bagType,args,lookup_guidStr,lookup_itemid,lookup_change)
if(bagType~=BAG_TYPE.eEquipBag and bagType~=BAG_TYPE.eItemBag)then return end
if lookup_change[CHANGE_TYPE.eAdd]==nil then return end
if not systemModel.isOpen(SYSTEM_DEFINE.eiXuMiTa)then return end

wanLingTaController:refreshBuildingStatusHUD()
end


function wanLingTaController.onDiscipleJJChange(dis_guid,oldlv,newlv,oldexp,exp)
if not systemModel.isOpen(SYSTEM_DEFINE.eiXuMiTa)then return end
if oldlv<newlv then
wanLingTaModel:checkDiscipleSaveLevel(dis_guid,newlv)
end
end


function wanLingTaController.on_building_event(etype,sfId,ubdId,build_id)






end


function wanLingTaController.onDiscipleCreate(dis_guid)
wanLingTaModel:initConfigLength()
wanLingTaController:refreshBuildingStatusHUD()
end







local _MODULENAME="xianbaoController"

gameState.addListener(def_table(_MODULENAME))
xianbaoController.name=_MODULENAME
xianbaoController.data={}

function xianbaoController:onAppStart()

xianbaoModel:onAppStart()

socketManager:register_receiver(16,31,self.recv_16_31)
socketManager:register_receiver(16,32,self.recv_16_32)
socketManager:register_receiver(16,33,self.recv_16_33)

end


function xianbaoController:onEnterState(isReconnect)
xianbaoModel:onEnterState()
end


function xianbaoController:onProtocolReq()
xianbaoModel:onProtocolReq()
local list=xianbaoModel:CheckActiveItem()
if next(list)then
msgWinControl:addMsgWin(msgWinType.eLianDongZY,{list,4})
end
end


function xianbaoController:onLeaveState(isReconnect)
xianbaoModel:onLeaveState(isReconnect)

self.data={}
end


function xianbaoController:onLostConnection()

end


function xianbaoController:onReConnection(isInitPro)

end








function xianbaoController.req_16_32(xianbao_id,guid)
socketManager:send_16_32(xianbao_id,guid)
end



function xianbaoController.req_16_33(xianbao_id)
socketManager:send_16_33(xianbao_id)
end













function xianbaoController.recv_16_31(len,xianbao_list)
local data={}
if len>0 then
for i,v in ipairs(xianbao_list)do
data[v.param_1]=v.param_2
end
end
xianbaoModel:setData(data)
end



function xianbaoController.recv_16_32(xianbao_id)
local data=xianbaoModel:getData()
data[xianbao_id]=0
if not xianbaoModel:CheckDianfengXianbao(xianbao_id)then
UIManager:showWindow("UIXianBaoAcitveWin",{xbid=xianbao_id})
end
UIManager:invokeUIMethod("UIXianBaoBagWin","initXBListPanel")
UIManager:invokeUIMethod("UIXianBaoTuJianWin","initXBListPanel")
reddotControl.on_change_catch_type(CATCH_TYPE.eXianBao)
local list=xianbaoModel:CheckActiveItem()
if next(list)then
msgWinControl:addMsgWin(msgWinType.eLianDongZY,{list,4})
end
end




function xianbaoController.recv_16_33(xianbao_id,star)
local data=xianbaoModel:getData()
local oldlv=data[xianbao_id]or 0
data[xianbao_id]=star
UIManager:callWindowFunc('UIXianBaoTuJianWin','freshXbItem',xianbao_id)
UIManager:callWindowFunc('UIXianBaoUpStarWin','onStarRet',xianbao_id,oldlv,star)
UIManager:showWindow("UIXianBaoUpStarSuccessWin",{xianbao_id,oldlv,star})
reddotControl.on_change_catch_type(CATCH_TYPE.eXianBao)
end



function xianbaoController:checkOpenXianBao()
return systemModel.isOpen(SYSTEM_DEFINE.eXianBao)
end

function xianbaoController:showXBTipsByItemID(itemId)
local flag,xbId=xianbaoConfig.isXianbaoActiveItem(itemId)
if not flag then
return
end
tipsManager.showTipsXB({
formType=TIPS_FORM_TYPE.eXianBaoMaterial,
tipsType=TIPS_TYPE.eCommonXianBao,
itemid=xbId,
bg=false,
funType=TIPS_FUNC_TYPE.eXianBao,
attach={xbItemId=itemId}
})
end

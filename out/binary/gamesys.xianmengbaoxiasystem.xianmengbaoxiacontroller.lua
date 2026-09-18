






local _MODULENAME="XianMengBaoXiaController"

gameState.addListener(def_table(_MODULENAME))
XianMengBaoXiaController.name=_MODULENAME
XianMengBaoXiaController.data={}

function XianMengBaoXiaController:onAppStart()
XianMengBaoXiaModel:onAppStart()

socketManager:register_receiver(20,97,self.recv_20_97)
socketManager:register_receiver(20,98,self.recv_20_98)
socketManager:register_receiver(20,99,self.recv_20_99)

end


function XianMengBaoXiaController:onEnterState(isReconnect)
XianMengBaoXiaModel:onEnterState()
end


function XianMengBaoXiaController:onProtocolReq()
XianMengBaoXiaModel:onProtocolReq()
end


function XianMengBaoXiaController:onLeaveState(isReconnect)
XianMengBaoXiaModel:onLeaveState(isReconnect)

self.data={}
end


function XianMengBaoXiaController:onLostConnection()

end


function XianMengBaoXiaController:onReConnection(isInitPro)

end


function XianMengBaoXiaController:send_20_97()
socketManager:send_20_97()
end

function XianMengBaoXiaController:send_20_98(guid,itemId,len,actorList)
socketManager:send_20_98(guid,itemId,len,actorList)
end



function XianMengBaoXiaController.recv_20_97(len,xzbxList)
XianMengBaoXiaModel:setXZBXList(len,xzbxList)
end

function XianMengBaoXiaController.recv_20_98(xzbxData)
XianMengBaoXiaModel:freshXZBXData(xzbxData)
UIManager.info('宝箱成功分配')
UIManager:invokeUIMethod("UIXianZhangBaoXiaFPWin","freshsever")
UIManager:invokeUIMethod("UIXianZhangBaoXiaChooseWin","freshsever")
end

function XianMengBaoXiaController.recv_20_99(bxType,xzbxData)
XianMengBaoXiaModel:freshPushXZBXData(bxType,xzbxData)
UIManager:invokeUIMethod("UIXianZhangBaoXia","freshsever",bxType)
UIManager:invokeUIMethod("UIXianZhangBaoXiaFPWin","freshsever")
UIManager:invokeUIMethod("UIXianZhangBaoXiaChooseWin","freshsever")
end


function XianMengBaoXiaController:checkIsOpenBaoXiao()
return self:checkBXConditon()
end

function XianMengBaoXiaController:checkBXConditon()
local flag=false

local cfg=cfg_xianzangbaoxiabaseconfig_get(1)
local versionLimit=cfg.versionLimit
if versionLimit then
local versionId=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()
if versionId and pfId then
local platform=versionLimit[versionId]
if platform and platform[pfId]then
flag=true
end
end
end

return flag
end


function XianMengBaoXiaController:isMengZhu()
if lingxuwenjianModel:isLeader()then

return true
end
return false
end


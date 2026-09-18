local waitRecvList=nil
function xianjieController:onAppStart_buff()
socketManager:register_receiver(35,21,xianjieController.recv_protocol_35_21)
socketManager:register_receiver(35,22,xianjieController.recv_protocol_35_22)
end

function xianjieController:onEnterState_buff(isReconnet)
waitRecvList={}
xianjieModel:clearBuff()

notifySystem:listenNotify(notifyConfig.onXianJieDataFreshInit,self.onXianJieDataFreshInit)
end

function xianjieController:onLeaveState_buff(isReconnet)
notifySystem:removelistener(notifyConfig.onXianJieDataFreshInit,self.onXianJieDataFreshInit)
xianjieModel:clearBuff()
waitRecvList=nil

end

function xianjieController.onXianJieDataFreshInit()
if waitRecvList and next(waitRecvList)then
for i,v in ipairs(waitRecvList)do
local params=v[3]
local funcName=string.format('recv_protocol_%d_%d',v[1],v[2])
local recvFunc=xianjieController[funcName]
if recvFunc then
recvFunc(unpack(params))
end
end
waitRecvList={}
end
end

function xianjieController.recv_protocol_35_21(len,bufflist)
if not xianjieController:checkXianJieInit_35_1()then
waitRecvList[#waitRecvList+1]={35,21,{len,bufflist}}
return
end

xianjieModel:initBuff(len,bufflist)
end

function xianjieController.recv_protocol_35_22(buffid,times)
if not xianjieController:checkXianJieInit_35_1()then
waitRecvList[#waitRecvList+1]={35,22,{buffid,times}}
return
end

xianjieModel:addBuff(buffid,times)
notifySystem:postNotify(notifyConfig.onXianJieBuffFresh,buffid)
end
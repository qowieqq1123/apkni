




systemProtocolControl=gameState.addListener({})



function systemProtocolControl:onAppStart()
socketManager:register_receiver(254,6,self.onInitSystem)
socketManager:register_receiver(254,7,self.onSystemOpen)
socketManager:register_receiver(254,26,self.onSystemListOpen)
end

function systemProtocolControl:onEnterState()
systemModel.init()
end

function systemProtocolControl:onLeaveState()
systemModel.init()
end




function systemProtocolControl.onInitSystem(len,list,openseclistlen,opensecList)
systemControl.onInitSystem(len,list)

systemModel.setSystemOpenTime(opensecList)
end


function systemProtocolControl.onSystemOpen(sysid)
systemControl.onOpenSystem(sysid)
pfCommonHelper.systemOpenPoint(sysid)
end

function systemProtocolControl.onSystemListOpen(len,array)
if len>0 then
for i=1,len do

systemControl.onOpenSystem(array[i])
end
end
end


function systemProtocolControl.reqSystemInit()
socketManager:send_254_6()
end


function systemProtocolControl.reqSystemOpen(sysid)
socketManager:send_254_7(sysid)
end


function systemProtocolControl.reqSystemListOpen(array)
if#array<=0 then return end
socketManager:send_254_26(#array,array)
end


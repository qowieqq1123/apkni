

function lingshouController:onAppStart_chuangong()
socketManager:register_receiver(19,104,self.do_protocol_19_104)
socketManager:register_receiver(19,105,self.do_protocol_19_105)
socketManager:register_receiver(19,106,self.do_protocol_19_106)
end

function lingshouController:onEnterState_chuangong()
end

function lingshouController:onLeaveState_chuangong()
end

function lingshouController:onLostConnection_chuangong()

end



function lingshouController.req_19_104()
socketManager:send_19_104()
end

function lingshouController.req_19_105(lsGuidSrc,lsGuidDst)
socketManager:send_19_105(lsGuidSrc,lsGuidDst)
end

function lingshouController.req_19_106(lsGuidList)
if lsGuidList==nil or#lsGuidList==0 then
return
end
socketManager:send_19_106(#lsGuidList,lsGuidList)
end


function lingshouController.do_protocol_19_104(len,cgList)
lingshouModel:setChuanGongDataList(cgList or{})
end

function lingshouController.do_protocol_19_105(lsinfoSrc,lsinfoDst,zizhiTime,zizhiDec)
lingshouController:addLingShou(lsinfoSrc)
lingshouController:addLingShou(lsinfoDst)
if zizhiDec>0 then
lingshouModel:addChuanGongData(lsinfoSrc.guid,zizhiTime,zizhiDec)
end
end

function lingshouController.do_protocol_19_106(len,zizhiList)
if len==0 or zizhiList==nil then
return
end
for _,data in ipairs(zizhiList)do
local guid=data.param_1
local lsData=lingshouModel:getLingShouData2(guid)
notifySystem:postNotify(notifyConfig.onLingShouGetOrUpdate,lsData,false)
notifySystem:postNotify(notifyConfig.onLingShouZiZhiRestore,guid)
end
end


local _rlist={}
function lingshouController:normalUpdate_chuangong(delay)
local chuangongDataList=lingshouModel:getChuanGongSortData()
if chuangongDataList==nil or next(chuangongDataList)==nil then return end
local curTime=timeHelper.getServerShortTime()
for index,cgData in ipairs(chuangongDataList)do
if curTime>=cgData.zizhiTime then
_rlist[#_rlist+1]=cgData.lsguid
lingshouModel:removeChuanGongData(cgData.lsguid)
end
end
if#_rlist>0 then
lingshouController.req_19_106(_rlist)
table.clear(_rlist)
end
end
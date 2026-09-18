






local _MODULENAME="FreeGiftController"

gameState.addListener(def_table(_MODULENAME))
FreeGiftController.name=_MODULENAME
FreeGiftController.data={}

function FreeGiftController:onAppStart()
FreeGiftModel:onAppStart()

socketManager:register_receiver(15,41,self.recv_15_41)
socketManager:register_receiver(15,42,self.recv_15_42)
socketManager:register_receiver(15,43,self.recv_15_43)
end

local thiscallback=nil
local recvFreeGiftListCallback=nil

function FreeGiftController:onEnterState(isReconnect)
FreeGiftModel:onEnterState()
self.isInit=false
end


function FreeGiftController:onProtocolReq()
FreeGiftModel:onProtocolReq()
end


function FreeGiftController:onLeaveState(isReconnect)
FreeGiftModel:onLeaveState(isReconnect)

self.data={}
self.isInit=nil
end


function FreeGiftController:onLostConnection()

end


function FreeGiftController:onReConnection(isInitPro)

end


function FreeGiftController.send_15_42(giftid,param,assistant)
socketManager:send_15_42(giftid,param,assistant or 0)
end







function FreeGiftController.send_15_43(list)

socketManager:send_15_43(#list,list)
end


function FreeGiftController.recv_15_41(len,list)
FreeGiftModel:initDatas(len,list)
FreeGiftController.isInit=true
notifySystem:postNotify(notifyConfig.onFreeGiftInit)
end


function FreeGiftController.recv_15_42(...)
FreeGiftModel:RefreshGetGift(...)
if thiscallback then
thiscallback(true)
thiscallback=nil
end
end


function FreeGiftController.recv_15_43(len,list)
if len>0 then
for i,v in ipairs(list)do
local giftid,json,lastsec=v.param_1,v.param_2,v.param_3
FreeGiftModel:RefreshGetGift(giftid,json,lastsec)
end
end
if recvFreeGiftListCallback then
recvFreeGiftListCallback(true)
recvFreeGiftListCallback=nil
end
end






function FreeGiftController.SendFreeGift(giftid,data,callback,assistant)
thiscallback=nil
thiscallback=callback
local isget
local gifttype
if data==nil then
gifttype=FreeGiftType.system
isget=FreeGiftModel:IsCanGetGift(giftid,gifttype,data)
elseif data then
if data and data[1]and data[2]and data[3]then
local conditions=cfg_freegiftconfig_get(giftid).conditions
gifttype=conditions[1]
isget=FreeGiftModel:IsCanGetGift(giftid,gifttype,data)
else
loggerUtil.logErrFMT('请求免费礼包领取--传入data参数错误,请检查')
return false
end
end

if isget then
if gifttype==FreeGiftType.system or gifttype==FreeGiftType.special or gifttype==FreeGiftType.serverTransfer then
FreeGiftController.send_15_42(giftid,"",assistant or 0)
elseif gifttype==FreeGiftType.role or gifttype==FreeGiftType.yunyin or gifttype==FreeGiftType.kuafu or gifttype==FreeGiftType.cbigkuafu then

if data and data[1]and data[2]and data[3]then

local info={data[1],data[3]}
local jsonStr=jsonHelper.encode(info)
FreeGiftController.send_15_42(giftid,jsonStr,assistant or 0)
end
end
else
if thiscallback then
thiscallback(false)
end
end
end





function FreeGiftController.SendFreeGiftList(giftidList,dataList,callback)
recvFreeGiftListCallback=nil
recvFreeGiftListCallback=callback
local isgetList={}
if dataList then
for i,data in ipairs(dataList)do
local giftid=giftidList[i]
if data==nil then
local gifttype=FreeGiftType.system
if FreeGiftModel:IsCanGetGift(giftid,gifttype,data)then
table.insert(isgetList,{giftid,gifttype,data})
end
elseif data then
if data and data[1]and data[2]and data[3]then
local conditions=cfg_freegiftconfig_get(giftid).conditions
local gifttype=conditions[1]
if FreeGiftModel:IsCanGetGift(giftid,gifttype,data)then
table.insert(isgetList,{giftid,gifttype,data})
end
else
loggerUtil.logErrFMT('请求免费礼包领取--传入data参数错误,请检查')
return false
end
end
end
else
for i,giftid in ipairs(giftidList)do
local gifttype=FreeGiftType.system
if FreeGiftModel:IsCanGetGift(giftid,gifttype)then
table.insert(isgetList,{giftid,gifttype})
end
end
end


local fail=true
if#isgetList>0 then
local sendList={}
for i,v in ipairs(isgetList)do
local giftid,gifttype,data=v[1],v[2],v[3]
local temp={}
if gifttype==FreeGiftType.system or gifttype==FreeGiftType.special then
temp[1]=giftid
temp[2]=""
elseif gifttype==FreeGiftType.role or gifttype==FreeGiftType.yunyin or gifttype==FreeGiftType.kuafu or gifttype==FreeGiftType.cbigkuafu then

if data and data[1]and data[2]and data[3]then

local info={data[1],data[3]}
local jsonStr=jsonHelper.encode(info)
temp[1]=giftid
temp[2]=jsonStr
end
end
if next(temp)then
table.insert(sendList,temp)
end
end
if#sendList>0 then
fail=false
FreeGiftController.send_15_43(sendList)
end
end
if fail and recvFreeGiftListCallback then
recvFreeGiftListCallback(false)
recvFreeGiftListCallback=nil
end
end




function FreeGiftController.GetFreeGift(giftid,data)
if data==nil then
local gifttype=FreeGiftType.system
return FreeGiftModel:IsCanGetGift(giftid,gifttype,data)
elseif data then
if data and data[1]and data[2]and data[3]then
local conditions=cfg_freegiftconfig_get(giftid).conditions
local gifttype=conditions[1]
return FreeGiftModel:IsCanGetGift(giftid,gifttype,data)
else
loggerUtil.logErrFMT('调用免费礼包是否领取--传入data参数错误,请检查')
return false
end
end
end

function FreeGiftController:checkInitFinish()
return self.isInit
end


function FreeGiftController:testtt(it)
local json="[16,11]"
local json2=""
if it==1 then
local data=jsonHelper.decode(json)

else
local data=jsonHelper.decode(json2)

end
end

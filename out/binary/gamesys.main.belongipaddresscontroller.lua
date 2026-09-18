







local _MODULENAME="belongIPAddressController"
gameState.addListener(def_table(_MODULENAME))
belongIPAddressController.name=_MODULENAME

local actorReqLockTime=2
local recordNum=10
local recordNumCnt
local recordData
local callbackLookup

function belongIPAddressController:onAppStart()
socketManager:register_receiver(254,23,belongIPAddressController.do_protocol_254_23)
end

function belongIPAddressController:onEnterState(isReconnet)
callbackLookup={}
recordNumCnt=0
end

function belongIPAddressController:onLeaveState(isReconnet)
callbackLookup=nil
recordNumCnt=0
recordData=nil
end

function belongIPAddressController:initRecore()
if recordData==nil then
local temp={}
recordData=onlineDataSetting:getData('belongIPAddress',temp)
if recordData==nil then
recordData=temp
onlineDataSetting:setData('belongIPAddress',recordData)
end
end




end

function belongIPAddressController:getBelongData(actorid_str)
belongIPAddressController:initRecore()
return recordData[actorid_str]
end

function belongIPAddressController:recordBelongData(actorid_str,belong,markRecored)
belongIPAddressController:initRecore()
recordData[actorid_str]=belong
local check=false
if markRecored then
recordNumCnt=0
check=true
else
recordNumCnt=recordNumCnt+1
if recordNumCnt>=recordNum then
recordNumCnt=0
check=true
end
end
if check then

end
end

function belongIPAddressController:doCallBack(belong,callback,desc_fmt)
if callback==nil then return end
if desc_fmt~=nil then
belong=FMT.fmt(desc_fmt,belong)
else
belong=FMT.fmt('归属地：{0}',belong)
end
callback(belong)
end









function belongIPAddressController:reqBelong(args)
local actorid=args.actorid
local serverid=args.serverid
local callback=args.callback
local markRecored=args.markRecored
local desc_fmt=args.desc_fmt
local actorid_str=mathHelper.int64_to_string(actorid)
local data=belongIPAddressController:getBelongData(actorid_str)
if data~=nil then
local belong=data
belongIPAddressController:doCallBack(belong,callback,desc_fmt)
return
end
local cb_data=callbackLookup[actorid_str]
if cb_data then
local curTime=Time.realtimeSinceStartup
if(curTime-cb_data.time)<actorReqLockTime then
return
end
end

if serverid~=nil then
local serverid_self=playerModel:getActorServerID()
if serverid_self==serverid then
serverid=nil
end
end
if serverid==nil then
socketManager:send_254_23(actorid)
else
socketManager:send_254_24(serverid,actorid)
end
callbackLookup[actorid_str]={callback=callback,time=Time.realtimeSinceStartup,desc_fmt=desc_fmt,markRecored=markRecored}
end






function belongIPAddressController.do_protocol_254_23(actorid,belong)



local actorid_str=mathHelper.int64_to_string(actorid)
local cb_data=callbackLookup[actorid_str]

local markRecored
if cb_data~=nil then
markRecored=cb_data.markRecored
end
belongIPAddressController:recordBelongData(actorid_str,belong,markRecored)

if cb_data==nil then
return
end
callbackLookup[actorid_str]=nil

belongIPAddressController:doCallBack(belong,cb_data.callback,cb_data.desc_fmt)
end


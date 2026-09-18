






local _refreshTime=600




function otherPlayerModel:setActorXianJieInfo(typo,actorid,stationguid,otherArgs)
if self.xianjieInfoLookup[typo]==nil then
self.xianjieInfoLookup[typo]={}
end
local actorid_str=tostring(actorid)
if not self.xianjieInfoLookup[typo][actorid_str]then
self.xianjieInfoLookup[typo][actorid_str]={}
end
local stationguid_str=tostring(stationguid)
self.xianjieInfoLookup[typo][actorid_str][stationguid_str]={time=Time.realtimeSinceStartup,otherArgs=otherArgs}
return otherArgs
end




function otherPlayerModel:getActorXianJieInfo(typo,actorid,stationguid,checkNew,mustNew)

if self.xianjieInfoLookup[typo]then
local actorid_str=tostring(actorid)
local stationguid_str=tostring(stationguid)

local data=self.xianjieInfoLookup[typo][actorid_str]
if data and data[stationguid_str]then
local check=true
if checkNew then
local old=data[stationguid_str].time
local cur=Time.realtimeSinceStartup
if cur-old>=_refreshTime then
check=false
end
end
if mustNew then
check=false
end
if check then
return data[stationguid_str].otherArgs
end
end
end
return nil
end

function otherPlayerModel:reqActorXianJieInfo(typo,actorid,args,callback,checkNew,mustNew)
local otherArgs=otherPlayerModel:getActorXianJieInfo(typo,actorid,args.stationguid,checkNew,mustNew)

if otherArgs and args.guid~=otherArgs.guid then
xianjieModel:Get_searchLogLookup(actorid,args.stationguid)
local old_datatb=xianjieModel:Get_singlelogByGuid(otherArgs.guid)
local cur_datatb=xianjieModel:Get_singlelogByGuid(args.guid)
local curSec=cur_datatb and tonumber(cur_datatb.sec)or 0
local oldSec=old_datatb and tonumber(old_datatb.sec)or 0
if curSec>oldSec then
otherArgs=nil
end
end
if callback then
if otherArgs then
callback(otherArgs)
else
args.isXianJie=true
otherPlayerController:reqCommonInfo(actorid,typo,args,callback)
end
end
end
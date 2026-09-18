







local _refreshTime=600


function otherPlayerModel:handleArrangeDZ(arrangeDZ)

local fightValNum=mathHelper.int64_to_number(arrangeDZ.fightvalue)
arrangeDZ.fightValNum=fightValNum
arrangeDZ.fightValNum_get=function(self_)
return self_.fightValNum
end

if arrangeDZ.equipLookup==nil then
local equipLookup={}
local fabaoList=arrangeDZ.fabaoList or{}
equipLookup[EQUIP_TYPE.eFabao]=fabaoList[1]
arrangeDZ.equipLookup=equipLookup
end

local daobingList=arrangeDZ.daobingList or{}
arrangeDZ.equipLookup[EQUIP_TYPE.eDaoBing]=daobingList[1]


if arrangeDZ.lingshouList~=nil then
for i,lsData in ipairs(arrangeDZ.lingshouList)do
lingshouController.changeLSNetData(lsData)
lingshouModel:initAttrLookup_otherDz(lsData,arrangeDZ.base)
end
end
end

function otherPlayerModel:getArrangeDZ_weaponID(arrangeDZ)
return arrangeDZ.discipleweapon or 0
end

function otherPlayerModel:getArrangeDZ_equipData(arrangeDZ,equipType)
local equipLookup=arrangeDZ.equipLookup
if equipLookup~=nil then
return equipLookup[equipType]
end
return nil
end

function otherPlayerModel:getArrangeDZ_lingshou(arrangeDZ)
if arrangeDZ then
local lingshouList=arrangeDZ.lingshouList
if lingshouList~=nil and#lingshouList>0 then
return lingshouList[1]
end
end
return nil
end




function otherPlayerModel:setActorDefTeams(typo,actorid,discipleList,otherArgs)











if self.defTeamsLookup[typo]==nil then
self.defTeamsLookup[typo]={}
end
local actorid_str=tostring(actorid)
local temp=nil
if discipleList then
temp={}
for i,v in ipairs(discipleList)do
if v.flag>0 then
local d=v

local fightValNum=mathHelper.int64_to_number(d.fightvalue)
d.fightValNum=fightValNum
temp[i]=d
else
temp[i]=nil
end
end
end
self.defTeamsLookup[typo][actorid_str]={teams=temp,time=Time.realtimeSinceStartup,otherArgs=otherArgs}
return temp,otherArgs
end


function otherPlayerModel:setActorDefTeamsDetail(typo,actorid,discipleList,otherArgs,save)

if self.defTeamsLookup[typo]==nil then
self.defTeamsLookup[typo]={}
end
local actorid_str=tostring(actorid)
local temp=nil
if discipleList then
temp={}
for i,v in ipairs(discipleList)do
if v.flag>0 then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(v)
local dzData_=otherPlayerModel:addDZData(actorid,dzData,false,save)
temp[i]=dzData_
else
temp[i]=nil
end
end
end
self.defTeamsLookup[typo][actorid_str]={teams=temp,time=Time.realtimeSinceStartup,otherArgs=otherArgs}
return temp,otherArgs
end




function otherPlayerModel:getActorDefTeams(typo,actorid,checkNew,mustNew)

if self.defTeamsLookup[typo]then
local actorid_str=tostring(actorid)
local data=self.defTeamsLookup[typo][actorid_str]
if data then
local check=true
if checkNew then
local old=data.time
local cur=Time.realtimeSinceStartup
if cur-old>=_refreshTime then
check=false
end
end
if mustNew then
check=false
end
if check then
return data.teams,data.otherArgs
end
end
end
return nil
end

function otherPlayerModel:reqActorDefTeams(typo,actorid,args,callback,checkNew,mustNew)
if checkNew==nil then checkNew=true end
local teams,otherArgs=otherPlayerModel:getActorDefTeams(typo,actorid,checkNew,mustNew)
if callback then
if teams then
callback(teams,otherArgs)
else
otherPlayerController:reqCommonInfo(actorid,typo,args,callback)
end
end
end
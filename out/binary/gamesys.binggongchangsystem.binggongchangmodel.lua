






local _MODULENAME="bingGongChangModel"


def_table(_MODULENAME)
bingGongChangModel.name=_MODULENAME
bingGongChangModel.data={}

function bingGongChangModel:onAppStart()

end


function bingGongChangModel:onEnterState(isReconnect)

end


function bingGongChangModel:onProtocolReq()

end


function bingGongChangModel:onLeaveState(isReconnect)

self.data={}
end

function bingGongChangModel:initEquipClass()
local list={}
local bgfET
local equipConfig=itemsHelper:getEquipLookUp()
for i,id in pairs(equipConfig)do
local v=itemsConfig.getConfig(id)
list[v.stage]=list[v.stage]or{}
bgfET=BGF_EQUIP_TYPE.checkBGFEquipType(v.type1)
if v.build then
list[v.stage][bgfET]=list[v.stage][bgfET]or{}
if v.type1==EQUIP_TYPE.eWeapon then
list[v.stage][bgfET][v.type2]=list[v.stage][bgfET][v.type2]or{}
table.insert(list[v.stage][bgfET][v.type2],v.id)
else
list[v.stage][bgfET][v.type1]=list[v.stage][bgfET][v.type1]or{}
table.insert(list[v.stage][bgfET][v.type1],v.id)
end
end
end
self.equipClass=list
end

function bingGongChangModel:getEquipByType(bgfEquipType,stage)
if not self.equipClass then
bingGongChangModel:initEquipClass()
end
return self.equipClass[stage][bgfEquipType]
end


function bingGongChangModel:setDiziData(diziData)
self.data.selectDiziData=diziData
end

function bingGongChangModel:hasDiZi()
if self.data then
return self.data.selectDiziData~=nil
end
return false
end

function bingGongChangModel:getDiziData()
if bingGongChangModel.data.selectDiziData and bingGongChangModel.data.selectDiziData.guid and not UIDiscipleModel:getDiscipleData(bingGongChangModel.data.selectDiziData.guid)then
bingGongChangModel.data.selectDiziData.guid=nil
end
return self.data.selectDiziData
end

function bingGongChangModel:setStartTime(startTime)
self.data.startTime=startTime
end

function bingGongChangModel:getStartTime()
return self.data.startTime or 0
end


function bingGongChangModel:lianZhiState()
if bingGongChangModel:getStartTime()>0 then
local time=timeHelper.getServerShortTime()
local needTime=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"needTime")*bingGongChangModel:getSelectNum()

if time>needTime+self.data.startTime then
return 2
else
return 1
end
else
return 0
end
end

function bingGongChangModel:getLianZhiCD()
if self.data then
if self.data.startTime>0 then
local time=timeHelper.getServerShortTime()
local needTime=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"needTime")*bingGongChangModel:getSelectNum()
local cd=needTime+self.data.startTime-time
if cd>0 then
return cd
else
return 0
end
end
end
return nil
end


function bingGongChangModel:getLianZhiRecviveOne()
if self.data then
if self.data.startTime and self.data.startTime>0 then
local time=timeHelper.getServerShortTime()
local needTime=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"needTime")
local cd=needTime+self.data.startTime-time
if cd>0 then
return cd
else
return 0
end
end
end
return nil
end

function bingGongChangModel:setLianZhiData(lianzhiData)
self.data.lianzhiData=lianzhiData
end

function bingGongChangModel:getLianZhiData()
return self.data.lianzhiData
end

function bingGongChangModel:setJingLianVal(jingLianVal)
self.data.jingLianVal=jingLianVal
end
function bingGongChangModel:getJingLianVal()
return self.data.jingLianVal or 0
end

function bingGongChangModel:updateLianZhiData(key,data)
self.data.lianzhiData[key]=data
end


function bingGongChangModel:getSelectNum()
if not self.data.lianzhiData then
return 0
end
return self.data.lianzhiData.equipNum
end


function bingGongChangModel:getLianZhiWeight(stage,proLv,matItemId)
local proLvCfg=cfgHelper.get(cfg_binggongfanglianqileveloddsconfig_get,proLv)
local colorOdds=proLvCfg.colorOdds[stage]
local newOdds={}
if matItemId then
local matColorOdds=cfgHelper.get(cfg_binggongfangteshumaterialsconfig_get,matItemId)
if matColorOdds then






































local flag={}
local temp=table.deepCopy(colorOdds)
local total=0
local itemWeight=matColorOdds.odds
for i,v in ipairs(itemWeight)do
temp[i]=temp[i]+v
total=total+v
end


for i,v in ipairs(temp)do
if v>0 then
if total>v then
temp[i]=0
total=total-v
flag[i]=2
else
if total>=0 then
flag[i]=1
temp[i]=temp[i]-total
total=0
else
flag[i]=1
end

end
end
end

for i,v in ipairs(temp)do
newOdds[i]={v,flag[i]or 0}
end
end

else
for i,v in ipairs(colorOdds)do
newOdds[i]={v,0}
end
end

return newOdds
end











local _MODULENAME="jctjDuJieXianDanModel"


def_table(_MODULENAME)
jctjDuJieXianDanModel.name=_MODULENAME
jctjDuJieXianDanModel.data={}
jctjDuJieXianDanModel.bdData={}
jctjDuJieXianDanModel.repairData={}

function jctjDuJieXianDanModel:onAppStart()

end


function jctjDuJieXianDanModel:onEnterState(isReconnect)
self.entity={}
self.repairData={}
end


function jctjDuJieXianDanModel:onProtocolReq()

end


function jctjDuJieXianDanModel:onLeaveState(isReconnect)

self.data={}
self.entity={}
self.bdData={}
self.repairData={}
end

function jctjDuJieXianDanModel:initXianDanData(sfid,buildUid,jdId,endTime,klFlag,monDieFlag,endFlag)
self.bdData={sfid=sfid,buildUid=buildUid}
self.data={jdId=jdId,endTime=endTime,klFlag=klFlag,monDieFlag=monDieFlag,endFlag=endFlag}



if jctjDuJieXianDanModel:hasEntityConfig()then
if klFlag==1 and monDieFlag==1 then
if cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId+1)then
self.data.jdId=jdId+1
self.data.endTime=0
self.data.klFlag=0
self.data.monDieFlag=0
end
end
else
if klFlag==1 then
self.data.jdId=jdId+1
self.data.endTime=0
self.data.klFlag=0
self.data.monDieFlag=0
end
end




end

function jctjDuJieXianDanModel:beginLianZhi(jzGuid,jdId,endTime)
self.bdData.buildUid=jzGuid
self.data.jdId=jdId
self.data.endTime=endTime
end

function jctjDuJieXianDanModel:openDanLu(klFlag)
self.data.klFlag=klFlag
end

function jctjDuJieXianDanModel:setEndFlag(endFlag)
self.data.endFlag=endFlag
end

function jctjDuJieXianDanModel:openDanLuTime(danluOpenTime)
self.data.danluOpenTime=danluOpenTime
end

function jctjDuJieXianDanModel:getOpenDanLuTime()
return self.data.danluOpenTime or 0
end

function jctjDuJieXianDanModel:getOpenDanLuDay()
local time=self:getOpenDanLuTime()
if time>0 then
time=timeHelper.convertLongStamp(time)
local kl0Time=timeHelper.getServerZeroStamp(time)
local kl5Time=kl0Time+5*3600
if time<=kl5Time then
kl5Time=kl5Time+86400
end
local _5Time=timeHelper.getTodayFiveStamp()

return(_5Time-kl5Time)/86400+1
end
return 1
end

function jctjDuJieXianDanModel:setNextJieDuan()
local jdId=self:getLianZhiJieDuan()
if jctjDuJieXianDanModel:hasEntityConfig()then
self.data.klFlag=1
self.data.monDieFlag=0
else
if cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId+1)then
self.data.jdId=jdId+1
self.data.endTime=0
self.data.klFlag=0
jctjDuJieXianDanModel:openDanLuTime(0)
end
end

end

function jctjDuJieXianDanModel:setNextJieDuanAfterFight()
local jdId=self:getLianZhiJieDuan()

if cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId+1)then
self.data.jdId=jdId+1
self.data.endTime=0
self.data.klFlag=0
jctjDuJieXianDanModel:openDanLuTime(0)
else
jctjDuJieXianDanModel:openDanLuTime(0)
self:setMonDieFlag(1)
end
end


function jctjDuJieXianDanModel:getLianZhiBuild()
return self.bdData.buildUid
end


function jctjDuJieXianDanModel:resetLianZhiBuild()
self.bdData.buildUid=0
end

function jctjDuJieXianDanModel:getLianZhiJieDuan()
return self.data.jdId or 0
end

function jctjDuJieXianDanModel:setLianZhiJieDuanServerStartId(id)
self.data.serverStartId=id
end

function jctjDuJieXianDanModel:getLianZhiJieDuanServerStartId()
return self.data.serverStartId or 0
end



function jctjDuJieXianDanModel:isLianZhiState()
return self.data.endTime>0 and self.data.klFlag==0
end

function jctjDuJieXianDanModel:setMonDieFlag(flag)
self.data.monDieFlag=flag
end

function jctjDuJieXianDanModel:getMonDieFlag()
return self.data.monDieFlag
end

function jctjDuJieXianDanModel:getLianZhiEndTime()
return self.data.endTime or 0
end

function jctjDuJieXianDanModel:getLianZhiKlFlag()
return self.data.klFlag or 0
end


function jctjDuJieXianDanModel:getLianZhiEndFlag()
return self.data.endFlag or 0
end


function jctjDuJieXianDanModel:checkLianZhiLingQu()
local jd=jctjDuJieXianDanModel:getLianZhiJieDuan()
local cfg=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jd)
if cfg and cfg.lastFlag and jctjDuJieXianDanModel:getMonDieFlag()==1 then
return true
end
end

function jctjDuJieXianDanModel:hasEntity()
if self:getMonDieFlag()==1 then
return false
end
if self:getLianZhiEndTime()==0 then
return false
end
if self:getLianZhiKlFlag()==0 then
return false
end
return self:hasEntityConfig()
end

function jctjDuJieXianDanModel:hasEntityConfig()
local jd=jctjDuJieXianDanModel:getLianZhiJieDuan()
local cfg=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jd)
if cfg and cfg.dlId then
return cfg.dlId
end
end


function jctjDuJieXianDanModel:isLianDanFinish()
if self:getLianZhiKlFlag()==0 then
local endTime=self:getLianZhiEndTime()
local now=timeHelper.getServerShortTime()
if endTime>0 then
return now>=endTime
end
end
return false
end


function jctjDuJieXianDanModel:checkXQCYBuff()
local jd=jctjDuJieXianDanModel:getLianZhiJieDuan()
local cfg=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jd+1)
if not cfg then
cfg=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jd)
end
if cfg and cfg.xqcy then
local num=JiuChongTianJieEnterModel:getOpenTianJiePeople()
if num>=cfg.xqcy[1]then
local sub=math.floor(num/cfg.xqcy[1])*cfg.xqcy[2]
return sub>cfg.xqcy[3]and cfg.xqcy[3]or sub
end
end
end

function jctjDuJieXianDanModel:setEntity(mapType,entGuid,entBt,entHud,danlingId,oriPos)
self.entity[mapType]={
entGuid=entGuid,
entBt=entBt,
entHud=entHud,
danlingId=danlingId,
oriPos=oriPos,
}
end

function jctjDuJieXianDanModel:clearEntity(mapType)
self.entity[mapType]=nil
end

function jctjDuJieXianDanModel:getEntity(mapType)
return self.entity[mapType]
end

function jctjDuJieXianDanModel:getRepairData()
return self.repairData
end

function jctjDuJieXianDanModel:getRepairTime(bdguid)
local time=self.repairData[bdguid]
return time
end

function jctjDuJieXianDanModel:isInRepairTime(bdguid)
local time=self.repairData[bdguid]
if time then
local currtime=gameUtilityModel.getServerShortTime()
if currtime<time then
return true
end
end
return false
end

function jctjDuJieXianDanModel:initRepairTime(time,bdguidList)
if bdguidList then
for i,v in ipairs(bdguidList)do
self.repairData[v]=time
end
end
end

function jctjDuJieXianDanModel:setDuJieJJUpDizi(diziList,stamp)
self.data.dujieJJDizi=self.data.dujieJJDizi or{}
self.data.dujieJJDiziList=diziList
if diziList then
local jjchangetime=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"jjchangetime")or 300
local dzGuid
for _,v in ipairs(diziList)do
dzGuid=v.dzGuid
local k=tostring(dzGuid)
self.data.dujieJJDizi[k]=jjchangetime+stamp
end
end
end

function jctjDuJieXianDanModel:getDuJieJJUpDizi(diziguid)
if not self.data.dujieJJDizi then
return
end
return self.data.dujieJJDizi[tostring(diziguid)]
end

function jctjDuJieXianDanModel:getDuJieJJUpDiziList()
return self.data.dujieJJDiziList
end



















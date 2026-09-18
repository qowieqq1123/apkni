






local _MODULENAME="wuXingDianModel"


def_table(_MODULENAME)
wuXingDianModel.name=_MODULENAME
wuXingDianModel.data={}

function wuXingDianModel:onAppStart()
wuXingDianModel:initCfg()
end


function wuXingDianModel:onEnterState(isReconnect)
if isReconnect then return end
wuXingDianModel:resetData()
local argtable=
{
0,nil,0,0,0,0,0,0,nil,0,nil
}
wuXingDianModel:onInitData(argtable)
wuXingDianModel:initSTRecord()
local data=wuXingDianModel:getData()
data.jie=0
data.endStamp=nil
end


function wuXingDianModel:onLeaveState(isReconnect)
if isReconnect then return end

wuXingDianModel:resetData()
end

function wuXingDianModel:resetData()
self.data={}
end

function wuXingDianModel:initCfg()
local list={}

local cfgs=cfg_fiveelementstemplelayerprizeconfig()
local wxdId=wuXingDianConfig.getSDType()
for prizeid,v in pairs(cfgs)do
list[prizeid]={}
local temp=list[prizeid]
local vv=v[wxdId]
for layer,vvv in pairs(vv)do
temp[#temp+1]=vvv
end
table.sort(temp,function(a,b)
return a.layer<b.layer
end)
end
self.sdprizeCfgs=list

local cfgs=cfg_fiveelementstemplealllayerconfig()
self.prizeCfgs=cfgs
end


function wuXingDianModel:onInitData(argstable)
local wxdList=argstable[2]
local begin_sec=argstable[3]
local drop_lv=argstable[4]
local saodang=argstable[5]
local prizeStarId=argstable[6]
local allStar=argstable[7]
local len1=argstable[8]
local prizelist=argstable[9]
local starlist=argstable[11]
local buylayer=argstable[12]

local data={}
local tLayer=0
local wxdLookup={}
for i,v in ipairs(wxdList or{})do
local wxdId=v.temple_id
v.wxdId=wxdId
wxdLookup[v.temple_id]=v
if not wuXingDianConfig.isSD(wxdId)then
tLayer=tLayer+v.layer
end
end
data.tLayer=tLayer
data.wxdLookup=wxdLookup
data.wxdList=wxdList
data.begin_sec=begin_sec
data.drop_lv=drop_lv
data.saodang=saodang
data.prizeStarId=prizeStarId
data.allStar=allStar
local prizelookup={}
for i,v in ipairs(prizelist or{})do
prizelookup[v.id]=v
if v.id==1 then
data.buylayer=v.free_recv_id or 0
end
end
data.prizelookup=prizelookup


local temp={}
for i,v in ipairs(starlist or{})do
temp[v.temple_id]={}
local t=temp[v.temple_id]
local lookup={}
for _,vv in ipairs(v.starList or{})do
lookup[vv.param_1]=vv.param_2 or 0
end
t.lookup=lookup
end
data.starInfo=temp

self.data=data
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eWXSD)
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end


function wuXingDianModel:onRewards(id,free_recv_id,recv_id,recharge_recv_id)
local prizelookup=self.data.prizelookup
if prizelookup and prizelookup[id]then
prizelookup[id].free_recv_id=free_recv_id
prizelookup[id].recv_id=recv_id
prizelookup[id].recharge_recv_id=recharge_recv_id
return
end
local info=
{
id=id,
free_recv_id=free_recv_id,
recv_id=recv_id,
recharge_recv_id=recharge_recv_id,
invest_bit=0,
}
self.data.prizelookup[id]=info
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end


function wuXingDianModel:onTouZi(id,invest_bit)
local prizelookup=self.data.prizelookup
if prizelookup and prizelookup[id]then
prizelookup[id].invest_bit=invest_bit
return
end
local info=
{
id=id,
free_recv_id=0,
recv_id=0,
recharge_recv_id=0,
invest_bit=invest_bit,
}

self.data.prizelookup[id]=info
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end


function wuXingDianModel:onSDData(begin_sec,drop_lv)
local wxdId=0
local layer=wuXingDianConfig.getSDType()

local data=self.data

local wxdLookup=self.data.wxdLookup
local wxdList=self.data.wxdList
if wxdList==nil then
wxdList={}
self.data.wxdList=wxdList
end

if wxdLookup[wxdId]==nil then
local info={
wxdId=wxdId,
layer=0,
}
wxdLookup[wxdId]=info
wxdList[#wxdList+1]=info
else
local v=wxdLookup[wxdId]
v.layer=0
end
local oldOpen=wuXingDianModel:isOpenSDByData()
data.begin_sec=begin_sec
data.drop_lv=drop_lv
if not oldOpen and begin_sec>0 then
self:initCurJie()
systemControl.onWuXingShengDianChanged()
notifySystem:postNotify(notifyConfig.onOpenWXSD)
end
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eWXSD)
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end

function wuXingDianModel:onFinishLayer(data)
local wxdId=data.temple_id

local isSD=wuXingDianConfig.isSD(wxdId)

local layer=data.layer
local star_bits=data.star_bits

local wxdLookup=self.data.wxdLookup
local wxdList=self.data.wxdList
if wxdList==nil then
wxdList={}
self.data.wxdList=wxdList
end

if wxdLookup[wxdId]==nil then
local info={
wxdId=wxdId,
layer=layer,
}
wxdLookup[wxdId]=info
wxdList[#wxdList+1]=info
else
local finishlayer=wuXingDianModel:getFinishLayer(wxdId)
local v=wxdLookup[wxdId]
if layer>finishlayer then
v.layer=layer
end
end

if not isSD then
local tLayer=0
for k,v in pairs(wxdLookup)do
if not wuXingDianConfig.isSD(k)then
tLayer=tLayer+v.layer
end
end
self.data.tLayer=tLayer
end

if self.data.starInfo==nil then self.data.starInfo={}end
if self.data.starInfo[wxdId]==nil then self.data.starInfo[wxdId]={}end
if self.data.starInfo[wxdId].lookup==nil then self.data.starInfo[wxdId].lookup={}end
local old_bits=self.data.starInfo[wxdId].lookup[layer]
if old_bits~=star_bits then
local len=0
if old_bits then
for i=1,3 do
if mathHelper.getBitValue(old_bits,i-1)then
len=len+1
end
end
end
local newlen=0
for i=1,3 do
if mathHelper.getBitValue(star_bits,i-1)then
newlen=newlen+1
end
end
local old=self.data.allStar or 0
local new=old+newlen-len
if old<new then
self.data.allStar=new
self.data.starInfo[wxdId].lookup[layer]=star_bits
end
end
notifySystem:postNotify(notifyConfig.wuxingta_change)
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end

function wuXingDianModel:onSaoDang(num)
self.data.saodang=num
end

function wuXingDianModel:onStarPrize(id)
self.data.prizeStarId=id
end

function wuXingDianModel:setRankList(id,myrank,ranlist)
self.data.rank=self.data.rank or{}
self.data.rank[id]={myrank=myrank,ranlist=ranlist}
end

function wuXingDianModel:setMyRank(id,myrank)
self.data.rank=self.data.rank or{}
self.data.rank[id]=self.data.rank[id]or{}
self.data.rank[id].myrank=myrank
end

function wuXingDianModel:setTop3RankList(id,ranlist)
self.data.top3=self.data.top3 or{}
self.data.top3[id]={ranlist=ranlist}
end

function wuXingDianModel:setBuyLayer(buylayer)
self.data.buylayer=buylayer
end

function wuXingDianModel:initSTRecord(recordList)
local lookup={}
local recordlen={}
local recordPrizelen={}
for i,v in ipairs(recordList or{})do
local id=v.idx
recordPrizelen[id]=v.has_recv_times
recordlen[id]=0
if lookup[id]==nil then lookup[id]={}end

local lookupInfo=lookup[id]

local list=v.recordList2 or{}
for _,vv in ipairs(list)do
local wxdId=vv.temple_id
lookupInfo[wxdId]=vv
recordlen[id]=recordlen[id]+1
end
end
self.data.recordLookup=lookup
self.data.recordlen=recordlen
self.data.recordPrizelen=recordPrizelen
end



function wuXingDianModel:onSTPrize(list)
if self.data.recordPrizelen==nil then self.data.recordPrizelen={}end
for i,v in ipairs(list or{})do
local id=v.param_1
local old=self.data.recordPrizelen[id]or 0
self.data.recordPrizelen[id]=old+v.param_2
end
end

function wuXingDianModel:resetDataOnNewJie(jie,endStamp)
local oldData=wuXingDianModel:getData()
local data={}

local sdType=wuXingDianType.eSD
data.wxdLookup=oldData.wxdLookup
data.wxdList=oldData.wxdList


local info={
wxdId=sdType,
layer=0,
}
data.wxdLookup[sdType]=info
for i,v in ipairs(data.wxdList)do
if v.wxdId==sdType then
table.remove(data.wxdList,i)
break
end
end
data.wxdList[#data.wxdList+1]=info

data.begin_sec=oldData.begin_sec
data.saodang=0
data.jie=jie
data.endStamp=endStamp
data.prizeStarId=oldData.prizeStarId or 0
data.allStar=oldData.allStar or 0
data.tLayer=oldData.tLayer or 0
data.starInfo=oldData.starInfo
data.prizelookup=oldData.prizelookup
if data.prizelookup==nil then data.prizelookup={}end
data.prizelookup[1]={}
self.data=data
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eWXSD)
end


function wuXingDianModel:isOpenSDByData()
return self.data.begin_sec and self.data.begin_sec>0
end

function wuXingDianModel:getData()
return self.data
end

function wuXingDianModel:getReallyBuyLayer()
return self.data.buylayer or 0
end

function wuXingDianModel:getWXDData(wxdId)
local wxdLookup=self.data.wxdLookup
if wxdLookup==nil then return end
return wxdLookup[wxdId]
end

function wuXingDianModel:getPrizeDataById(id)
if self.data.prizelookup then
return self.data.prizelookup[id]
end
end

function wuXingDianModel:getPrizeData(wxdId)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return end
local id=2
if wuXingDianConfig.isSD(wxdId)then id=1 end
if self.data.prizelookup then
return self.data.prizelookup[id]
end
end

function wuXingDianModel:getPrizeStar()
return self.data.prizeStarId or 0
end

function wuXingDianModel:getAllStar()
return self.data.allStar or 0
end

function wuXingDianModel:getFinishLayer(wxdId)
local wxdLookup=self.data.wxdLookup
if wxdLookup==nil then return 0 end
local info=wxdLookup[wxdId]
if info==nil then return 0 end
return info.layer or 0
end

function wuXingDianModel:getRewardLayer(wxdId)
if not wuXingDianConfig.isSD(wxdId)then
return wuXingDianModel:getFinishLayer(wxdId)
end
local layer=wuXingDianModel:getFinishLayer(wxdId)
local buylayer=wuXingDianModel:getReallyBuyLayer()
if buylayer>layer then
layer=buylayer
end
return layer
end


function wuXingDianModel:getCurLayer(wxdId)
local wxdLookup=self.data.wxdLookup
if wxdLookup==nil then return 1 end
local info=wxdLookup[wxdId]
if info==nil then return 1 end
local layer=info.layer
if layer==nil then return 1 end
layer=layer+1
local max=wuXingDianModel:getMaxLayer(wxdId)
if layer>max then layer=max end
return layer
end

function wuXingDianModel:getWXMinLayer()
local min
for i,v in pairs(wuXingDianBaseType)do
local wxdId=v
local layer=wuXingDianModel:getFinishLayer(wxdId)
if min==nil or layer<min then
min=layer
end
end
return min
end

function wuXingDianModel:initCurJie()
local data=wuXingDianModel:getData()
local jie,endStamp=wuXingDianModel:getCurJieByCfg()
data.jie=jie
data.endStamp=endStamp
end

function wuXingDianModel:getCurJieByCfg()
local begin_sec=self.data.begin_sec
if begin_sec==nil or begin_sec==0 then return 0 end
local stamp=timeHelper.getServerLongTime()
local beginStamp=timeHelper.getServerOpenLongTime()
local passMonth=timeHelper.getPassMonths(stamp,beginStamp)
local year,month,day=timeHelper.getServerStampData(stamp)
local maxDay=timeHelper.getMaxDayByMonth(year,month)
local endStamp=timeHelper.timeServer(year,month,maxDay,23,59,59)
return passMonth,endStamp
end


function wuXingDianModel:getCurJie()
local data=wuXingDianModel:getData()
if data.jie==nil then
wuXingDianModel:initCurJie()
end
return data.jie,data.endStamp
end

function wuXingDianModel:getCurJieLeftDay()
local jie,endStamp=wuXingDianModel:getCurJie()
if endStamp==nil then return 0 end
local zeroStamp=timeHelper.getTodayZeroStamp()
local left=endStamp-zeroStamp
local day=math.ceil(left/86400)
return day
end

function wuXingDianModel:getSDGroupIdByJie(jie)
local cfg=cfg_fiveelementsholytempleconfig_get(0)
local period_list=cfg.period_list
if self:checkChangeNewPeriod()then
period_list=cfg.ex_period_list
end
local fixlen=#period_list
if fixlen>=jie then
return period_list[jie]
else
local circular_period_list=cfg.circular_period_list
if self:checkChangeNewPeriod()then
circular_period_list=cfg.ex_circular_period_list
end
local circlelen=#circular_period_list
local left=jie-fixlen
local index=left%circlelen
if index==0 then index=circlelen end
return circular_period_list[index]
end
end

function wuXingDianModel:getSaoDangRewards()
local rewards=nil
for i,v in pairs(wuXingDianBaseType)do
local wxdId=v
local layer=wuXingDianModel:getFinishLayer(wxdId)
if layer>0 then
local cfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local sd_drop_id=cfg.sd_drop_id
if sd_drop_id then
local itemsList=cfgHelper.get2(cfg_awardconfig_get,sd_drop_id,"showItems")
rewards=attrListHelper.concatRangList(rewards,itemsList)
end
end
end
return rewards
end

function wuXingDianModel:getSDGroupId()
local jie=wuXingDianModel:getCurJie()
return wuXingDianModel:getSDGroupIdByJie(jie)
end

function wuXingDianModel:getSDLayerId(groupId,layer)
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
local id_list=groupcfg.id_list
local maxLayer=groupcfg.max_lay
if layer>maxLayer then
loggerUtil.logErrFMT('当期圣殿不能超过{0}',maxLayer)
layer=maxLayer
end
local len=0
local max=0
for i,v in ipairs(id_list)do
local rlen=v[2]-v[1]+1
if(len+rlen)>=layer then
local idx=layer-len
return v[1]+idx-1
end
len=len+rlen
if v[2]>max then max=v[2]end
end
loggerUtil.logErrFMT('当期圣殿组合配置{0}的max_lay参数和参数上限{1}不匹配',groupId,maxLayer)
return max
end


function wuXingDianModel:getLayerCfg(wxdId,layer)
if not wuXingDianConfig.isSD(wxdId)then
local cfgs=cfg_fiveelementstemplelayerconfig_get(wxdId)
return cfgs[layer]
else
local jie=wuXingDianModel:getCurJie()
local groupId=wuXingDianModel:getSDGroupIdByJie(jie)
local layerId=wuXingDianModel:getSDLayerId(groupId,layer)
return cfg_fiveelementsholytemplefightconfig_get(layerId)
end
end

function wuXingDianModel:getLayerCfgEx(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)then
local jie=wuXingDianModel:getCurJie()
local groupId=wuXingDianModel:getSDGroupIdByJie(jie)
return cfg_fiveelementsholytemplelayerconfig_get(groupId)[layer]
else
local cfgs=cfg_fiveelementstemplelayerconfig_get(wxdId)
return cfgs[layer]
end
end

function wuXingDianModel:getMaxLayer(wxdId)
if not wuXingDianConfig.isSD(wxdId)then
local cfg=cfg_fiveelementstemplelayerconfig_get(wxdId)
return#cfg
end
local jie=wuXingDianModel:getCurJie()
if jie==0 then return 0 end
local groupId=wuXingDianModel:getSDGroupIdByJie(jie)
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
return groupcfg.max_lay
end

function wuXingDianModel:getShiLianFaZeList(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)then
local groupId=wuXingDianModel:getSDGroupId()
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
return groupcfg.train_fazelist
else
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
return layerCfg.train_fazelist
end
end

function wuXingDianModel:getShiLianFaZeDesc(wxdId)
if wuXingDianConfig.isSD(wxdId)then
local groupId=wuXingDianModel:getSDGroupId()
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
return groupcfg.fztips[2]
else
local wxdCfg=cfg_fiveelementstempleconfig_get(wxdId)
return wxdCfg.fztips[2]
end
end

function wuXingDianModel:getShiLianFaZeId(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)then
local groupId=wuXingDianModel:getSDGroupId()
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
return groupcfg.train_fazelist[1]
else
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local train_fazelist=layerCfg.train_fazelist or{}
local info=train_fazelist[1]or{}
return info[1]
end
end

function wuXingDianModel:getShiLianFaZeLv(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)then
local layerCfg=wuXingDianModel:getLayerCfgEx(wxdId,layer)
return layerCfg.train_faze_lv
else
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local train_fazelist=layerCfg.train_fazelist or{}
local info=train_fazelist[1]or{}
return info[2]
end
end

function wuXingDianModel:getLayerFaZeList(wxdId,layer)
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
return layerCfg.fazelist
end

function wuXingDianModel:getShouTongInfo(id)
if self.data.recordLookup==nil then return end
return self.data.recordLookup[id]
end

function wuXingDianModel:getShouTongLen(id)
if self.data.recordlen==nil then return 0 end
return self.data.recordlen[id]or 0
end

function wuXingDianModel:getShouTongPrizeLen(id)
if self.data.recordPrizelen==nil then return 0 end
return self.data.recordPrizelen[id]or 0
end


function wuXingDianModel:getPassLayerStarNum(wxdId,layer)
local star_bits=wuXingDianModel:getPassLayerStar(wxdId,layer)
local num=0
for i=1,3 do
if mathHelper.getBitValue(star_bits,i-1)then
num=num+1
end
end
return num
end


function wuXingDianModel:getPassLayerStar(wxdId,layer)
if self.data.starInfo==nil then return 0 end
if self.data.starInfo[wxdId]==nil then return 0 end
if self.data.starInfo[wxdId].lookup==nil then return 0 end
return self.data.starInfo[wxdId].lookup[layer]or 0
end

function wuXingDianModel:getCurrentMaxStar(star)
local cfgs=cfg_fiveelementstemplestarconfig()
for i,v in ipairs(cfgs)do
if star<v.star then
return v.id
end
end
return cfgs[#cfgs].id
end

function wuXingDianModel:getCurrentMaxSTLayer(layer)
local cfgs=cfg_fiveelementstempleshoutongconfig()

local maxlayer
for _,v in pairs(wuXingDianBaseType)do
local _maxlayer=wuXingDianModel:getMaxLayer(v)
if maxlayer==nil or _maxlayer<maxlayer then
maxlayer=_maxlayer
end
end
for i,v in ipairs(cfgs)do
if v.layer>maxlayer then return end
if layer<v.layer then
return v.id
end
end
end

function wuXingDianModel:getNextGrandPrizeLayer(wxdId,layer)
local cfgs=cfg_fiveelementstemplelayerconfig_get(wxdId)
local maxlayer=wuXingDianModel:getMaxLayer(wxdId)
for i,v in ipairs(cfgs)do
if v.layer>maxlayer then return end
if layer<v.layer and v.grandprize then
return v.layer
end
end
end

function wuXingDianModel:getRankList()
return self.data.rank and self.data.rank[0]or nil
end

function wuXingDianModel:getWuXingDianRankList(idx)
return self.data.rank and self.data.rank[idx]or nil
end

function wuXingDianModel:getWXTotalLayer()
return self.data.tLayer or 0
end

function wuXingDianModel:getTop3RankList(id)
return self.data.top3 and self.data.top3[id]
end


function wuXingDianModel:isFinishLayer(wxdId,layer)
local finishlayer=wuXingDianModel:getFinishLayer(wxdId)
return finishlayer>=layer
end

function wuXingDianModel:isFinishMaxLayer(wxdId)
local layer=wuXingDianModel:getMaxLayer(wxdId)
local finishlayer=wuXingDianModel:getFinishLayer(wxdId)
return finishlayer>=layer
end


function wuXingDianModel:getMonsterGroupId(wxdId,layer)
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
return layerCfg.mon_ids
end

function wuXingDianModel:getTouZiFlagById(id)
local info=wuXingDianModel:getPrizeDataById(id)or{}
return info.invest_bit or 0
end

function wuXingDianModel:getTouZiFlag(wxdId)
local info=wuXingDianModel:getPrizeData(wxdId)or{}
return info.invest_bit or 0
end

function wuXingDianModel:hasAnyTouzi(wxdId)
return not wuXingDianModel:hasTouziMoney(wxdId)or
not wuXingDianModel:hasTouziRecharge(wxdId)
end


function wuXingDianModel:hasTouziMoney(wxdId)
local flag=wuXingDianModel:getTouZiFlag(wxdId)
return mathHelper.getBitValue(flag,0)
end


function wuXingDianModel:hasTouziRecharge(wxdId)
local flag=wuXingDianModel:getTouZiFlag(wxdId)
return mathHelper.getBitValue(flag,1)
end


function wuXingDianModel:getPrizeCfgsIndex(wxdId,layer)
local cfgs=wuXingDianModel:getPrizeCfgs(wxdId)
local index
for i,v in ipairs(cfgs)do
if v.layer>layer then
break
else
index=i
end
end
return index
end

function wuXingDianModel:getPrizeCfgs(wxdId)
if wuXingDianConfig.isSD(wxdId)then
local groupId=wuXingDianModel:getSDGroupId()
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
local prize=groupcfg.prize_id
return self.sdprizeCfgs[prize]
else
return self.prizeCfgs
end
end

function wuXingDianModel:getCanPizeLayer(wxdId,layer)
local prizeCfgs=wuXingDianModel:getPrizeCfgs(wxdId)
local prizelayer=0
local index=0
for i,v in ipairs(prizeCfgs)do
if layer>=v.layer and v.layer>=prizelayer then
prizelayer=v.layer
index=i
end
end
return prizelayer,index
end


function wuXingDianModel:hasAnyPrize(wxdId)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return false end
local layer=wuXingDianModel:getRewardLayer(wxdId)
if not wuXingDianConfig.isSD(wxdId)then
layer=wuXingDianModel:getWXTotalLayer()
end
return wuXingDianModel:canFreePrize(wxdId,layer)or
wuXingDianModel:canMoneyPrize(wxdId,layer)or
wuXingDianModel:canRechargePrize(wxdId,layer)
end


function wuXingDianModel:isFreePrize(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return false end
local info=wuXingDianModel:getPrizeData(wxdId)
if info==nil then return false end
layer=wuXingDianModel:getCanPizeLayer(wxdId,layer)
local free_layer=info.free_recv_id or 0
return free_layer>=layer
end


function wuXingDianModel:isMoneyPrize(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return false end
local info=wuXingDianModel:getPrizeData(wxdId)
if info==nil then return false end
layer=wuXingDianModel:getCanPizeLayer(wxdId,layer)
local recv_id=info.recv_id or 0
return recv_id>=layer
end


function wuXingDianModel:isRechargePrize(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return false end
local info=wuXingDianModel:getPrizeData(wxdId)
if info==nil then return false end
layer=wuXingDianModel:getCanPizeLayer(wxdId,layer)
local recharge_recv_id=info.recharge_recv_id or 0
return recharge_recv_id>=layer
end


function wuXingDianModel:canFreePrize(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return false end
local info=wuXingDianModel:getPrizeData(wxdId)or{}
local finishlayer=wuXingDianModel:getRewardLayer(wxdId)
if not wuXingDianConfig.isSD(wxdId)then
finishlayer=wuXingDianModel:getWXTotalLayer()
end
layer=wuXingDianModel:getCanPizeLayer(wxdId,layer)
local free_layer=info.free_recv_id or 0
return finishlayer>=layer and free_layer<layer
end


function wuXingDianModel:canMoneyPrize(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return false end
local info=wuXingDianModel:getPrizeData(wxdId)or{}
if not wuXingDianModel:hasTouziMoney(wxdId)then return false end

local finishlayer=wuXingDianModel:getRewardLayer(wxdId)
if not wuXingDianConfig.isSD(wxdId)then
finishlayer=wuXingDianModel:getWXTotalLayer()
end
layer=wuXingDianModel:getCanPizeLayer(wxdId,layer)
local money_layer=info.recv_id or 0
return finishlayer>=layer and money_layer<layer
end


function wuXingDianModel:canRechargePrize(wxdId,layer)
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then return false end
local info=wuXingDianModel:getPrizeData(wxdId)or{}
if not wuXingDianModel:hasTouziRecharge(wxdId)then return false end
local finishlayer=wuXingDianModel:getRewardLayer(wxdId)
if not wuXingDianConfig.isSD(wxdId)then
finishlayer=wuXingDianModel:getWXTotalLayer()
end
layer=wuXingDianModel:getCanPizeLayer(wxdId,layer)
local recharge_layer=info.recharge_recv_id or 0
return finishlayer>=layer and recharge_layer<layer
end

function wuXingDianModel:getFightLingGen(wxdId,layer)
local needlg
if wuXingDianConfig.isSD(wxdId)then
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
needlg=layerCfg.spirit_root_ids
else
needlg=cfgHelper.get2(cfg_fiveelementstempleconfig_get,wxdId,'spirit_root_ids')
end
return needlg
end


function wuXingDianModel:canFightLingGen(dzguid,wxdId,layer)
local needlg=wuXingDianModel:getFightLingGen(wxdId,layer)
for i,v in ipairs(needlg)do
if UIDiscipleModel:getDiscipleSpecialityByID(dzguid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,v)then
return true
end
end
return false
end


function wuXingDianModel:isCanAnyFight()
for _,v in pairs(wuXingDianBaseType)do
if wuXingDianModel:isWXDOpen(v)then
local finishlayer=wuXingDianModel:getFinishLayer(v)
local maxLayer=wuXingDianModel:getMaxLayer(v)
if finishlayer<maxLayer then return true end
end
end
return false
end


function wuXingDianModel:isWXDOpen(wxdId)
if wuXingDianConfig.isSD(wxdId)then
return wuXingDianModel:isSDOpen()
else
local ret=true
local args=nil
local condition=cfgHelper.get2(cfg_fiveelementstempleconfig_get,wxdId,'conditions')
if condition==nil then return true end
for i,v in ipairs(condition)do
local typo=v[1]
if typo==1 then
if not playerModel:checkActorLevel(v[2])then
ret=false
args={1,v}
break
end
elseif typo==2 then
local openDay=timeHelper.getServerOpenDay()
if openDay<v[2]then
ret=false
args={1,v}
break
end
end
end
if not ret then
local data=wuXingDianModel:getWXDData(wxdId)
if data~=nil then return true end
end
return ret,args
end
return true
end


function wuXingDianModel:isSDOpen()
local needlayer=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'need_layer')
for _,v in pairs(wuXingDianBaseType)do
local layer=wuXingDianModel:getFinishLayer(v)
if layer<needlayer then return false,{2,needlayer}end
end
return true
end

function wuXingDianModel:isSDCanFight()
if not wuXingDianModel:isSDOpen()then return false end
if wuXingDianModel:isFinishMaxLayer(wuXingDianType.eSD)then
return false
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eWXSDFight)
return not flag
end

function wuXingDianModel:isCanSaoDang()
if not wuXingDianModel:isOpenSDByData()then return false,0 end
local args=0
local flag=self.data.saodang==nil or self.data.saodang<1
for _,v in pairs(wuXingDianBaseType)do
local layer=wuXingDianModel:getFinishLayer(v)
if layer>0 then
args=1
if flag then return true end
end
end
return false,args
end

function wuXingDianModel:isCanAnyPrizeStar()
local star=wuXingDianModel:getAllStar()
for i,v in ipairs(cfg_fiveelementstemplestarconfig())do
if star<v.star then return false end
if not wuXingDianModel:isPrizeStar(v.id)then
return true
end
end
return false
end


function wuXingDianModel:isPrizeStar(id)
local prizestar=wuXingDianModel:getPrizeStar()
return prizestar>=id
end

function wuXingDianModel:isCanPrizeStar(id)
if wuXingDianModel:isPrizeStar(id)then return false end
local star=wuXingDianModel:getAllStar()
return star>=cfgHelper.get2(cfg_fiveelementstemplestarconfig_get,id,'star')
end

function wuXingDianModel:isCanAnyPrizeShouTong()
for i,v in ipairs(cfg_fiveelementstempleshoutongconfig())do
if wuXingDianModel:hasAnyActorShouTong(v.id)then
if wuXingDianModel:isCanPrizeShouTong(v.id)then
return true
end
end
end
return false
end


function wuXingDianModel:hasAnyNewLayer()
for _,wxdId in pairs(wuXingDianBaseType)do
if wuXingDianModel:hasNewLayer(wxdId)then
return true
end
end
return false
end

function wuXingDianModel:hasNewLayer(wxdId)
if not wuXingDianModel:isWXDOpen(wxdId)then
return false
end
local layer=wuXingDianModel:getFinishLayer(wxdId)
local maxLayer=wuXingDianModel:getMaxLayer(wxdId)
if layer>=maxLayer then
return false
end

local oldMaxLayer=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,FMT.fmt("wuXingDianLayer_{0}",wxdId),40)
return maxLayer>oldMaxLayer
end

function wuXingDianModel:setNewLayer(wxdId)
local maxLayer=wuXingDianModel:getMaxLayer(wxdId)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,FMT.fmt("wuXingDianLayer_{0}",wxdId),maxLayer,40)
wuXingDianController:freshReddot()
end


function wuXingDianModel:hasAnyActorShouTong(id)
return wuXingDianModel:getShouTongLen(id)>0
end


function wuXingDianModel:hasAnyActorShouTongByWXD(id,wxdId)
if self.data.recordLookup[id]==nil then return false end
return self.data.recordLookup[id][wxdId]~=nil
end


function wuXingDianModel:isAllPrizeShouTong(id)
for _,wxdId in pairs(wuXingDianBaseType)do
local recordlen=wuXingDianModel:getShouTongLen(id)
local recordprizelen=wuXingDianModel:getShouTongPrizeLen(id)
if recordlen~=5 or recordlen~=recordprizelen then return false end
end
return true
end

function wuXingDianModel:isCanPrizeShouTong(id)
for _,wxdId in pairs(wuXingDianBaseType)do
local recordlen=wuXingDianModel:getShouTongLen(id)
local recordprizelen=wuXingDianModel:getShouTongPrizeLen(id)
if recordlen>recordprizelen then return true end
end
return false
end

function wuXingDianModel:isPassMaxStar(wxdId,layer)
local num=wuXingDianModel:getPassLayerStarNum(wxdId,layer)
return num>=3
end

function wuXingDianModel:isCanBuySDLayer()
if not wuXingDianModel:isOpenSDByData()then return false end
local wxdId=wuXingDianConfig.getSDType()
local layer=wuXingDianModel:getRewardLayer(wxdId)
local maxLayer=wuXingDianModel:getMaxLayer(wxdId)
local index=wuXingDianModel:getPrizeCfgsIndex(wxdId,layer)or 0
local maxIndex=wuXingDianModel:getPrizeCfgsIndex(wxdId,maxLayer)
if index>=maxIndex then return false end

return wuXingDianModel:isInLastTimeBySD()
end


function wuXingDianModel:isInLastTimeBySD()
if not wuXingDianModel:isOpenSDByData()then return false end
local startStamp,endStamp=wuXingDianModel:getCurJie()
local buyDay=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'buy_day')
local canBuyStamp=endStamp-(buyDay-1)*86400
local canBuyZeroStamp=timeHelper.getServerZeroStamp(canBuyStamp)
local stamp=timeHelper.getServerLongTime()
return stamp>=canBuyZeroStamp
end


function wuXingDianModel:getWarnTips(args)
local typo=args[1]
local argstable=args[2]
if typo==1 then
local argsType=argstable[1]
local val=argstable[2]
if argsType==1 then
return FMT.fmt('宗门{0}级开启',val)
elseif argsType==2 then
local openDay=timeHelper.getServerOpenDay()
local needOpenDay=val
return FMT.fmt('{0}天后开启',needOpenDay-openDay)
end
elseif typo==2 then
local val=argstable
return FMT.fmt('五殿均通关{0}层可开启',val)
end
end

function wuXingDianModel:getAnyOpenTitle()
local list
for _,v in pairs(wuXingDianBaseType)do
if wuXingDianModel:isWXDOpen(v)and
not wuXingDianModel:isOpenTitle(v)then
if list==nil then list={}end
list[#list+1]=v
end
end
return list
end

function wuXingDianModel:isOpenTitle(wxdId)
if wxdId==nil then return true end
if wxdId==wuXingDianType.eFire then return true end
return userActorSetting.get(FMT.fmt('wxd_open_title_{0}',wxdId),false)
end

function wuXingDianModel:setOpenTitle(wxdId)
if wxdId==nil then return end
local isOpen=wuXingDianModel:isOpenTitle(wxdId)
if isOpen then return end
userActorSetting.flushVal(FMT.fmt('wxd_open_title_{0}',wxdId),true)
wuXingDianController:freshReddot()
end


function wuXingDianModel:setInFight(state)
self.data.isInFight=state
end

function wuXingDianModel:getInFight()
return self.data.isInFight or false
end

function wuXingDianModel:getSDBuyPrize(index,targetIdx)
local wxdId=wuXingDianConfig.getSDType()
local info=wuXingDianModel:getPrizeData(wxdId)
local free_recv_id=info and info.free_recv_id or 0
local recv_id=info and info.recv_id or 0
local recharge_recv_id=info and info.recharge_recv_id or 0
local cfgs=wuXingDianModel:getPrizeCfgs(wxdId)
local hasTouziMoney=wuXingDianModel:hasTouziMoney(wxdId)
local hasTouziRecharge=wuXingDianModel:hasTouziRecharge(wxdId)
local data=wuXingDianModel:getData()
local level=data.drop_lv
local temp={}
local oldnum=0
local newnum=0
for i,v in ipairs(cfgs)do
local layer=v.layer
if v.id>targetIdx then
break
end
if index==i then
oldnum=v.money_num
end
if i==targetIdx then
newnum=v.money_num
end
if layer>free_recv_id then
local drop_id=v.free_drop_id
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(drop_id,level)
local itemsList=rewardCfg.showItems or{}
temp=table.concatTableXX(itemsList,temp)
end
if hasTouziMoney and layer>recv_id then
local drop_id=v.drop_id
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(drop_id,level)
local itemsList=rewardCfg.showItems or{}
temp=table.concatTableXX(itemsList,temp)
end
if hasTouziRecharge and layer>recharge_recv_id then
local drop_id=v.recharge_drop_id
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(drop_id,level)
local itemsList=rewardCfg.showItems or{}
temp=table.concatTableXX(itemsList,temp)
end
end
local cost=newnum-oldnum
if index==nil then
cost=newnum
end
return temp,cost
end


function wuXingDianModel:checkChangeNewPeriod()
local cfg=cfg_fiveelementsholytempleconfig_get(0)
local period_list_time=cfg.period_list_time
local startTime=period_list_time[1]
local GameVersion=pfwindowslController:getGameVersion()
if period_list_time[GameVersion]then
startTime=period_list_time[GameVersion]
end
if startTime then

local startStamp=timeHelper.getDateStamp(startTime)
local stamp=timeHelper.getServerLongTime()
return stamp>=startStamp
end
return false
end
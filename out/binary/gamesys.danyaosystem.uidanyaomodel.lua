






UIDanYaoModel={}

UIDanYaoModel.data={}
local _ptypeList={}
local _stypeList={}
local _lookStype={}
local initdf=false
local unlockItemLook={}
local _selectId=nil
local canGetHudTigger={}
local needCheckCanGetLookUp={}

DANYAO_FILTER_TYPE=
{
eJingjie=1,
eLianTi=2,
eLingshou=3,
eOther=4,
}
DANYAO_ZHALU_SEASON={
eNone=0,
eBuildingFire=1,
eDiscipleSpecial=2,
}

function UIDanYaoModel:checkDanFangLangVer(langVer)
if langVer==nil then
return true
end
if activitiesModel and activitiesModel.checklangVerCondition then
return activitiesModel:checklangVerCondition(langVer)
end
return true
end

function UIDanYaoModel:checkDanFangServerLimit(serverlimit)
if serverlimit==nil then
return true
end

local limitType=serverlimit.type
local pfCfg=serverlimit.pf
if limitType==nil then
return true
end

local pfid=gameUtilityModel.getServerPlatform()
local serverid=playerModel:getActorServerID()
local crossid=loginModel:getCrossServerId()
local checkId=(limitType==3 or limitType==4)and crossid or serverid

local function _isEmptyTable(t)
return type(t)=='table'and next(t)==nil
end

local function _matchOne(v)
if type(v)=='number'then
return checkId==v
elseif type(v)=='table'then

local min=tonumber(v[1])
local max=tonumber(v[2])
if min and max then
return checkId>=min and checkId<=max
end
end
return false
end

local function _matchList(cfg)
if cfg==-1 then
return true
end
if _isEmptyTable(cfg)then
return false
end
if type(cfg)~='table'then
return true
end

for _,v in pairs(cfg)do
if _matchOne(v)then
return true
end
end
return false
end

local function _match(cfg)
if cfg==nil then
return nil
end
if cfg==-1 then
return true
end
if _isEmptyTable(cfg)then
return false
end
return _matchList(cfg)
end

local cfg=nil
if type(pfCfg)=='table'then
cfg=pfCfg[pfid]
if cfg==nil then
cfg=pfCfg[-1]
end
end

local matched=_match(cfg)
local isWhite=(limitType==1 or limitType==3)
local isBlack=(limitType==2 or limitType==4)

if isWhite then
if matched==nil then
return false
end
return matched==true
elseif isBlack then
if matched==nil then
return true
end
return matched==false
end

return false
end

function UIDanYaoModel:checkDanFangClientLimit(cfg)
if cfg==nil then
return true
end
if not self:checkDanFangLangVer(cfg.langVer)then
return false
end
if not self:checkDanFangServerLimit(cfg.serverlimit)then
return false
end
return true
end



function UIDanYaoModel:checkInit()
return initdf==true
end


function UIDanYaoModel:on_enter_state()
self.data={}
self.danFangIdList={}
self.batchData={}
initdf=false
unlockItemLook={}
_selectId=nil
UIDanYaoModel:initDanFangCfg()
UIDanYaoModel:loadDanFangNewFlag()
end

function UIDanYaoModel:on_leave_state()

self.data={}
_selectId=nil
self.danFangIdList={}
self.batchData=nil
UIDanYaoModel:saveDanFangNewFlag()
end



function UIDanYaoModel:init_data(ubdId,array)
local data=self.data[ubdId]
if data==nil then
data={}
self.data[ubdId]=data
end
data.sfId=array.sf_id
data.ubdId=array.un_build_id
data.dfId=array.df_id
data.beginTime=array.begintime
data.zlTime=array.zl_endtime
data.zlType=array.zl_type
data.cnt=array.cnt
data.cntList=array.cntlist
data.passTime=array.totaltimes
data.lianDan=data.lianDan or 0
data.isPause=false
local cntLen=array.cnt_list_len
if cntLen>0 then
data.isPause=data.beginTime==0
end
end

function UIDanYaoModel:init_batch_data(list)

for i,v in ipairs(list)do
local data={}
data.sfId=v.sf_id
data.ubdId=v.un_build_id
data.beginTime=v.begintime

data.zlTime=v.zl_endtime
data.zlType=v.zl_type
data.currIndex=0
local ddList={}
if v.len>0 then
for ii,vv in ipairs(v.list)do
local dd={}
dd.dfId=vv.df_id
dd.cnt=vv.cnt
dd.cnt_list_len=vv.cnt_list_len
dd.cntList=vv.cntlist
table.insert(ddList,dd)
end
end
data.ddList=ddList
self:setDingDanIndex(data)
self.batchData[v.un_build_id]=data
if data.currIndex>0 then
self:setCurrentDingDan(data)
UIDanYaoModel:startLianDan(v.un_build_id)
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end

local check=UIDanYaoModel:checkZhaLu(data.ubdId,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if check then
local bdData=zongmenModel:getBuildingData(data.ubdId)
UIDanYaoController:showZhaLuPerformance(bdData)
end
end
end

function UIDanYaoModel:getDanFangNeedTime(dfId,dzguid)
local need=cfgHelper.get2(cfg_danfangconfig_get,dfId,'need_times')

local rate=1+gubaoModel:getGBSkil_LianDanTime()/100
if dzguid and mathHelper.validInt64(dzguid)then

local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(dzguid))
local speRate=dzSpecialityGrowEffectController:getLianDanTimeChangeRate(netData)
if speRate then
rate=rate+speRate/100
end

local isShuWuDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
if isShuWuDZ then
local dzData=UIDiscipleModel:getDiscipleData(dzguid)
local pdval,ptype=UIDiscipleModel:countShuWUDZSelfPDAddValue(dzData)
if ptype==eMoneyType.mtLingDan then
rate=rate-pdval/100
end
end
end
need=mathHelper.safe_ceil(need*rate)
return need
end

function UIDanYaoModel:setDingDanIndex(data)
local ctime=gameUtilityModel.getServerShortTime()
local dtime=ctime-data.beginTime
local btime=data.beginTime
local check=true
local bdData=zongmenModel:getBuildingData(data.ubdId)
for ii,vv in ipairs(data.ddList)do
local need=UIDanYaoModel:getDanFangNeedTime(vv.dfId,bdData.dizi_id)
if check then
data.currIndex=ii
end
vv.beginTime=btime
local ntime=need*vv.cnt
btime=btime+ntime
if dtime>=ntime then
vv.complete=true
else
check=false
end
dtime=dtime-ntime
end
end

function UIDanYaoModel:isDingDanNoProduction(ubdId)
local data=self.batchData[ubdId]
if data then
if#data.ddList>0 then
local dd=data.ddList[#data.ddList]
return dd.complete
end
end
return true
end

function UIDanYaoModel:isDingDanComplete(ubdId)
local data=self.batchData[ubdId]
if data then
if#data.ddList>0 then
local dd=data.ddList[#data.ddList]
return dd.complete
end
end
return false
end

function UIDanYaoModel:setCurrentDDComplete(ubdId)
local data=self.batchData[ubdId]
if data then
local dd=data.ddList[data.currIndex]
dd.complete=true
end
end

function UIDanYaoModel:setCurrentDingDan(data)
local dd=data.ddList[data.currIndex]
local arr={
sf_id=data.sfId,
un_build_id=data.ubdId,
df_id=dd.dfId,
begintime=dd.beginTime,
zl_endtime=data.zlTime,
zl_type=data.zlType,
cnt=dd.cnt,
cnt_list_len=dd.cnt_list_len,
cntlist=dd.cntList,
totaltimes=0,
}
self:refresh_data(data.ubdId,arr)
end

function UIDanYaoModel:addBatchData(sfId,ubdId,beginTime,len,list)
local data=self.batchData[ubdId]
if data then
data.beginTime=beginTime
if len>0 then
for ii,vv in ipairs(list)do
local dd={}
dd.dfId=vv.df_id
dd.cnt=vv.cnt
dd.cnt_list_len=vv.cnt_list_len
dd.cntList=vv.cntlist
table.insert(data.ddList,dd)
end
end
else
data={}
data.sfId=sfId
data.ubdId=ubdId
data.beginTime=beginTime
data.zlTime=0
data.zlType=DANYAO_ZHALU_SEASON.eNone
local ddList={}
if len>0 then
for ii,vv in ipairs(list)do
local dd={}
dd.dfId=vv.df_id
dd.cnt=vv.cnt
dd.cnt_list_len=vv.cnt_list_len
dd.cntList=vv.cntlist
table.insert(ddList,dd)
end
end
data.ddList=ddList
self.batchData[ubdId]=data
end
self:setDingDanIndex(data)
end

function UIDanYaoModel:updateDingDan(datas)

if datas[7]==1 then
self.batchData[datas[2]]=nil
return
end
local data=self.batchData[datas[2]]
data.beginTime=datas[3]

for i=1,datas[5]do
table.remove(data.ddList,1)
end
if#data.ddList>0 then
local dd=data.ddList[1]
local cntlist=dd.cntList
for i=1,datas[6]do
table.remove(cntlist,1)
end
dd.cnt_list_len=#cntlist
dd.cnt=dd.cnt_list_len
end
self:setDingDanIndex(data)
end

function UIDanYaoModel:getBatchData(ubdId)
return self.batchData[ubdId]
end

function UIDanYaoModel:refresh_data(ubdId,array)
UIDanYaoModel:init_data(ubdId,array)
end

function UIDanYaoModel:clear_data()
self.data={}
end


function UIDanYaoModel:getOneKeyPrizeData()
local temp={}
local sfId=mapIdType.zhufeng
if UIDanYaoController:isDingDanSystemOpen()then
for ubdId,data in pairs(self.batchData)do
temp[#temp+1]={2,sfId,ubdId,data.currIndex,0}
end
else
for ubdId,data in pairs(self.data)do
temp[#temp+1]={1,sfId,ubdId}
end
end
return temp
end


function UIDanYaoModel:init_danFang_data(dfLen,dfList)
self.danFangIdList={}
if dfLen>0 then
for i,v in ipairs(dfList)do
table.insert(self.danFangIdList,v)
end
end
initdf=true
end


function UIDanYaoModel:initDanFangCfg()
_ptypeList={}
_stypeList={}
_lookStype={}
local danFangCfg=cfg_danfangconfig()
for i,v in pairs(danFangCfg)do
local id=v.id
if id then
local sType=v.s_type
local bType=v.b_type
if _ptypeList[bType]==nil then _ptypeList[bType]={}end
if _stypeList[bType]==nil then _stypeList[bType]={}end

table.insert(_ptypeList[bType],v)

local temp=_stypeList[bType]
if temp[sType]==nil then temp[sType]={}end
local temp1=temp[sType]
table.insert(temp1,v)

_lookStype[id]=bType

if v.unlock==nil then
table.insert(self.danFangIdList,v.id)
end
self:initUnlockItemLook(v)
end
end

for bType,v in pairs(_ptypeList)do
if#v>1 then
table.sort(v,function(a,b)
return a.id<b.id
end)
end
end

for bType,v in pairs(_stypeList)do
for sType,vv in pairs(v)do
if#vv>1 then
table.sort(vv,function(a,b)
return a.id<b.id
end)
end
end
end
end

function UIDanYaoModel:getDFByFilter(btype,stype)
if _stypeList[btype]==nil then return{}end
return _stypeList[btype][stype]or{}
end

function UIDanYaoModel:selectDFId(dfId)
_selectId=dfId
end

function UIDanYaoModel:getSelectDFId()
return _selectId
end


function UIDanYaoModel:get_danFangIdList()
return self.danFangIdList
end

function UIDanYaoModel:getFilterCfg(btype)
local cfg
if btype==DANYAO_FILTER_TYPE.eJingjie then
cfg=cfg_danfangjingjietypeconfig()
elseif btype==DANYAO_FILTER_TYPE.eLianTi then
cfg=cfg_danfangliantitypeconfig()
elseif btype==DANYAO_FILTER_TYPE.eLingshou then
cfg=cfg_danfanglingshoutypeconfig()
elseif btype==DANYAO_FILTER_TYPE.eOther then
cfg=cfg_danfangothertypeconfig()
end
return cfg
end

function UIDanYaoModel:getFilterName(btype,stype)
local cfg
if btype==DANYAO_FILTER_TYPE.eJingjie then
cfg=cfg_danfangjingjietypeconfig_get(stype)
elseif btype==DANYAO_FILTER_TYPE.eLianTi then
cfg=cfg_danfangliantitypeconfig_get(stype)
elseif btype==DANYAO_FILTER_TYPE.eLingshou then
cfg=cfg_danfanglingshoutypeconfig_get(stype)
elseif btype==DANYAO_FILTER_TYPE.eOther then
cfg=cfg_danfangothertypeconfig_get(stype)
else
return''
end
return cfg.typename
end


function UIDanYaoModel:addDFUnLock(dfId)
table.insert(self.danFangIdList,dfId)
end

function UIDanYaoModel:get_all_danyaodata()
return self.data
end

function UIDanYaoModel:get_danYaodata(ubdId)
local data=self.data[ubdId]
if not data then

data={
sf_id=mapIdType.zhufeng,
un_build_id=ubdId,
df_id=0,
begintime=0,
zl_endtime=0,
zl_type=DANYAO_ZHALU_SEASON.eNone,
cnt=0,
cnt_list_len=0,
totaltimes=0,
}
self:refresh_data(ubdId,data)
data=self.data[ubdId]
end
return data
end


function UIDanYaoModel:lianzhi_update_data(array)
local sfId=array[1]
local ubdId=array[2]
local data=self.data[ubdId]
data.dfId=array[3]
data.cnt=array[4]
local startTime=array[5]
local curTime=timeHelper.getServerShortTime()
if curTime<startTime then
startTime=curTime
end
data.beginTime=startTime
data.cntList=array[7]
data.passTime=0
end


function UIDanYaoModel:reward_updata_data(array)
local sfId=array[1]
local ubdId=array[2]
local data=self.data[ubdId]
data.cnt=array[3]
data.beginTime=array[4]
data.passTime=array[5]
end


function UIDanYaoModel:update_data_time(sfId,ubdId,beginTime,passTime)
local data=self.data[ubdId]
if data==nil then
data={}
self.data[ubdId]=data
end
data.beginTime=beginTime
data.passTime=passTime
data.isPause=beginTime==0
end


function UIDanYaoModel:update_data_time_by_speedup(sfId,ubdId,speedUpTime)
local data=self.data[ubdId]
if data==nil then
data={}
self.data[ubdId]=data
end

local speedUpbeginTime=data.beginTime-speedUpTime
if speedUpbeginTime<0 then
speedUpbeginTime=0
end

data.beginTime=speedUpbeginTime
data.passTime=0
data.isPause=false

local bdata=self:getBatchData(ubdId)
if bdata then
bdata.beginTime=speedUpbeginTime
UIDanYaoModel:setDingDanIndex(bdata)
end
end


function UIDanYaoModel:isUnLock(dfId)
local dfConfig=cfgHelper.get1(cfg_danfangconfig_get,dfId)
local unLockStr=''

for i,v in ipairs(self.danFangIdList)do
if v==dfId then
return true
end
end


local limit=dfConfig.unlock
if limit then
local unLockType=limit[1]
if unLockType==1 then
unLockStr='收集对应的丹方激活'
elseif unLockType==2 then
unLockStr='可通过宗门大殿解锁'
elseif unLockType==3 then
local unLockLevel=limit[2]

if playerModel:checkActorLevel(unLockLevel)then
return true
end
unLockStr=FMT.fmt('<color=#c82c2c>宗门等级{0}级解锁</color>',unLockLevel)
else
unLockStr='激活条件不详'
end
return false,unLockStr
end
return true
end


function UIDanYaoModel:isCanUnLock(limit)
local unLockType=limit[1]
if unLockType==1 then
local itemId=limit[2]
local needCount=limit[3]
local have=self:getHaveItemCount(itemId)
return have>=needCount
elseif unLockType==2 then
return false
end
return false
end

function UIDanYaoModel:isCanLianZhiAnyByCfg(cfg,percent)
local materials=cfg.cost or{}
return UIDanYaoModel:isCanLianZhi(materials,1,percent)
end


function UIDanYaoModel:isCanLianZhi(materials,cnt,percent)
for i,v in ipairs(materials)do
local itemid=v[1]
local price=v[2]
if moneyConfig.isMoney(itemid)then
price=math.ceil(price*(1+percent/100))
end
local needCount=price*cnt
local have=self:getHaveItemCount(itemid)
if have<needCount then
return false,itemid
end
end
return true
end

function UIDanYaoModel:getItemCountStr(itemId,needCount)
local have=self:getHaveItemCount(itemId)
local colorStr=have<needCount and'#E33021FF'or'#ffffffff'
local countStr=''
if moneyConfig.isMoney(itemId)then
countStr=FMT.fmt('<color={0}>{1}</color>',colorStr,mathHelper.formatBIGNumbereEx(needCount))
else
countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(needCount))
end
return countStr
end

function UIDanYaoModel:getHaveItemCount(itemid)
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
return have
end

function UIDanYaoModel:getDFType(id)
return _lookStype[id]
end


function UIDanYaoModel:getDanFangList(dzId,btypo,stype,percent)
local realShowList={}
local dfList=_ptypeList[btypo]
if stype~=nil and stype~=0 then
dfList=_stypeList[btypo][stype]
end
for i,v in ipairs(dfList)do
if v.forcehide then
else

if not self:checkDanFangClientLimit(v)then
else
local unLock=self:isUnLock(v.id)
if not unLock and v.hide then
local show=self:checkDanFangHide(v.hide)
if show then
table.insert(realShowList,v)
end
else
table.insert(realShowList,v)
end
end
end
end
local sortList=self:getSortDanFangList(dzId,realShowList,percent)
return sortList
end


function UIDanYaoModel:hasDanFang(btypo,stype)
local dfList=_ptypeList[btypo]
if stype~=nil and stype~=0 then
dfList=_stypeList[btypo][stype]
end
for i,v in ipairs(dfList)do
if v.forcehide then
else

if not self:checkDanFangClientLimit(v)then
else
local unLock=self:isUnLock(v.id)
if not unLock and v.hide then
local show=self:checkDanFangHide(v.hide)
if show then
return true
end
else
return true
end
end
end
end
return false
end

function UIDanYaoModel:getTotalActiveDanfangList()
local allCfg=cfg_danfangconfig()
local unlockList={}
for id,cfg in pairs(allCfg)do
if id~='const_def'then
local unLock=self:isUnLock(cfg.id)
if unLock then
table.insert(unlockList,cfg.id)
end
end
end
return unlockList
end


function UIDanYaoModel:getSortDanFangList(dzId,list,percent)
for i,v in ipairs(list)do



local isNew=UIDanYaoModel:checkDanFangNewFlag(v.id)
local sortTag=v.id/100

local unLock=UIDanYaoModel:isUnLock(v.id)
if unLock then
local canLianzhi=UIDanYaoModel:isCanLianZhiAnyByCfg(v,percent)and UIDanYaoModel:checkDzProLevel(dzId,v)or false
v.sortTag=sortTag+v.sort*100-100000
if isNew then
v.sortTag=v.sortTag-10000000
end
if canLianzhi then
v.sortTag=v.sortTag-100000000
end
else
v.sortTag=sortTag+v.locksort*100+100000
end
end
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end

function UIDanYaoModel:checkDzProLevel(dzId,config)
local textStr=''
local limitLv=config.need_dd_lvl
local proType=DISCIPLE_PROSKILL_TYPE.eDanDao
local proLevel=UIDiscipleModel:getDiscipleJobLevel(dzId,proType)
if proLevel<limitLv then
local proName=cfgHelper.get2(cfg_discipleproskillconfig_get,proType,'name')
textStr=FMT.fmt('{0}等级需达到{1}级',proName,limitLv)
end
return proLevel>=limitLv,textStr
end

function UIDanYaoModel:getZhaLuData(ubdId)
local data=self.data[ubdId]
local nowTime=timeHelper.getServerShortTime()
if data and data.zlTime>nowTime then
return data.zlTime,data.zlType
end
data=self.batchData[ubdId]
if data and data.zlTime>nowTime then
return data.zlTime,data.zlType
end
end


function UIDanYaoModel:get_zhalu_time(ubdId)
local serTime=timeHelper.getServerShortTime()
local zlTime,zlType=self:getZhaLuData(ubdId)
if zlTime and zlType then
local remainTime=zlTime-serTime
if remainTime>0 then
return true,remainTime,zlType
end
end
return false
end

function UIDanYaoModel:checkZhaLu(ubdId,zlType)
local check,least,type=self:get_zhalu_time(ubdId)
return check and type==zlType,least
end


function UIDanYaoModel:set_zhalu_time(ubdId,zlTime,zlType)
local data=self.data[ubdId]
if data==nil then return end
data.zlTime=zlTime
data.zlType=zlType or DANYAO_ZHALU_SEASON.eNone
end


function UIDanYaoModel:isCanAdvanceReward(ubdId,dfId)
local bdData=zongmenModel:getBuildingData(ubdId)
local oneNeedTime=UIDanYaoModel:getDanFangNeedTime(dfId,bdData.dizi_id)
local serTime=timeHelper.getServerShortTime()
local data=self.data[ubdId]
local oneRewardTime=data.beginTime+oneNeedTime
return serTime>=oneRewardTime
end

function UIDanYaoModel:startLianDan(ubdId)
local data=self.data[ubdId]
if data then
data.lianDan=1
end
end

function UIDanYaoModel:endLianDan(ubdId)
local data=self.data[ubdId]
if data then
data.lianDan=0
data.isPause=false
end
end

function UIDanYaoModel:getLianDanFlag(ubdId)
local data=self.data[ubdId]
if data then
local flag=data.lianDan or 0
return flag>0
end
return false
end

function UIDanYaoModel:getMaxLianZhiCount(config,percent)
local costList=config.cost
local max=config.maxcnt
for i,v in ipairs(costList)do
local itemid=v[1]
local price=v[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
price=math.ceil(price*(1+percent/100))
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
local can=math.floor(have/price)
max=can<max and can or max
end
local count=max>config.maxcnt and config.maxcnt or max
count=count==0 and 1 or count
return count
end

function UIDanYaoModel:checkIsPause(ubdId)
local data=self.data[ubdId]
if data then
return data.isPause
end
return false
end

function UIDanYaoModel:initUnlockItemLook(config)
local unlock=config.unlock
if unlock and unlock[1]==1 then
local itemid=unlock[2]
unlockItemLook[itemid]=config.id
end
end

function UIDanYaoModel:checkIsDanFangUnlockItem(itemid)
return unlockItemLook[itemid]
end


function UIDanYaoModel:loadDanFangNewFlag()
self.dfNewFlags=userActorSetting.get('danfangnewflag',{})
end

function UIDanYaoModel:saveDanFangNewFlag()
userActorSetting.set('danfangnewflag',self.dfNewFlags)
userActorSetting.flush()
end

function UIDanYaoModel:setDanFangNewFlag(dfId)
table.insert(self.dfNewFlags,dfId)
end

function UIDanYaoModel:clearDanFangNewFlag()
self.dfNewFlags={}
self:saveDanFangNewFlag()
end

function UIDanYaoModel:checkDanFangNewFlag(dfId)
for i,v in ipairs(self.dfNewFlags)do
if v==dfId then
return true
end
end
return false
end

function UIDanYaoModel:checkHaveDanFangNew()
if self.dfNewFlags and#self.dfNewFlags>0 then
return true,self.dfNewFlags[1]
end
return false
end


function UIDanYaoModel:checkDanFangHide(hideCfg)
local hideType=hideCfg[1]
local hideValue=hideCfg[2]
if hideType==1 then
local itemId=hideValue
local have=bagControl.invokeFuncByItemId(itemId,'getItemCountByItemID',itemId)
return have>0
elseif hideType==2 then
local unLockLevel=hideValue
return playerModel:checkActorLevel(unLockLevel)
end
return true
end


function UIDanYaoModel.initNeecCheckCanGetList()
local cfgs=cfg_danfangconfig()

for index,cfg in pairs(cfgs)do
if cfg.upLevelUnlockReddotCondition~=nil then
needCheckCanGetLookUp[cfg.id]=cfg
end
end
end

local _upLevlCheckType={
eShopBuy=1,
}
local _upLevelUnlockDanFangReddotCondition={
[_upLevlCheckType.eShopBuy]=function(condition)
local buyID=condition[2]
local shopID=condition[3]

if not funcShopModel:checkFuncShopTypeFuncOpen(shopID)then return false end

local isUnlockItem=funcShopModel:check_item_unlock(shopID,buyID)
if not isUnlockItem then
return false
end

local limitBuyOut=funcShopModel:checkSoldout(shopID,buyID)
if limitBuyOut then
return false
end

return funcShopModel:checkCanBuy(shopID,buyID)
end
}

function UIDanYaoModel.checkDanFangUpLevelUnlockReddot(danfangID)

local hide=cfgHelper.get(cfg_danfangconfig_get,danfangID,'hide')
local isShow=hide and UIDanYaoModel:checkDanFangHide(hide)or false
if isShow then return false end

local cfgAll=cfgHelper.get(cfg_danfangconfig_get,danfangID)
if cfgAll and not UIDanYaoModel:checkDanFangClientLimit(cfgAll)then
return false
end

local upLevelUnlockReddotCondition=cfgHelper.get(cfg_danfangconfig_get,danfangID,'upLevelUnlockReddotCondition')
if upLevelUnlockReddotCondition==nil or next(upLevelUnlockReddotCondition)==nil then
return false
end

if not UIDanYaoModel:checkDanFangCanGet(danfangID)then
return false
end

for index,condition in ipairs(upLevelUnlockReddotCondition)do
local type=condition[1]
local conditionCheck=_upLevelUnlockDanFangReddotCondition[type]
if conditionCheck then
if not conditionCheck(condition)then
return false
end
else

logErr("前端缺少检查类型",type)

return false
end
end

return true
end



function UIDanYaoModel.checkUpLevelUnlockReddot()

for dfid,cfg in pairs(needCheckCanGetLookUp)do

if cfg and not UIDanYaoModel:checkDanFangClientLimit(cfg)then
else
if cfg.hide==nil or UIDanYaoModel:checkDanFangHide(cfg.hide)then
local isLock=UIDanYaoModel:isUnLock(cfg.id)
if not isLock then
if UIDanYaoModel.checkDanFangUpLevelUnlockReddot(cfg.id)then
return true,cfg.id
end
end
end
end
end

return false
end

local _DanFang_CanGet_OneGet_Tip="DanFang_CanGet_OneGet_Tip"
function UIDanYaoModel:readDanFangCanGetTipRecord()
local info=userActorSetting.get(_DanFang_CanGet_OneGet_Tip,{})



self.DanFangCanGetTip={}

if next(info)then
for index,danfangID in ipairs(info)do
self.DanFangCanGetTip[danfangID]=1
end
end
end

function UIDanYaoModel:writeDanFangCanGetTipsRecord()
if self.data==nil or self.DanFangCanGetTip==nil or next(self.DanFangCanGetTip)==nil then return end

local temp={}

for danfangID,state in pairs(self.DanFangCanGetTip)do
temp[#temp+1]=danfangID
end



userActorSetting.set(_DanFang_CanGet_OneGet_Tip,temp)
userActorSetting.flush()
end

function UIDanYaoModel:recordDanFangCanGetTip(danfangID)
if needCheckCanGetLookUp==nil or needCheckCanGetLookUp[danfangID]==nil then return end

if self.data==nil then return false end
if self.DanFangCanGetTip==nil then
self:readDanFangCanGetTipRecord()
end

if self.DanFangCanGetTip[danfangID]and self.DanFangCanGetTip[danfangID]==1 then return end

self.DanFangCanGetTip[danfangID]=1

self:writeDanFangCanGetTipsRecord()

UIManager:invokeUIMethod('UIDanFangWin','freshRightPanel')
UIManager:invokeUIMethod('UIDanFangWin','freshDanFangList')
UIManager:invokeUIMethod('UIDanYaoWin','refreshCanGetReddot')
UIDanYaoController:refreshAllLianDanFangHud()
end


function UIDanYaoModel:checkDanFangCanGet(danfangID)
if self.data==nil then return false end
if self.DanFangCanGetTip==nil then
self:readDanFangCanGetTipRecord()
end

return self.DanFangCanGetTip[danfangID]==nil or self.DanFangCanGetTip[danfangID]~=1
end

local _canGetTiggerType={
eSys=1,
eBuild=2,
eXM=3,
eMoney=4,
}
function UIDanYaoModel.initCanGetHudTigger()
canGetHudTigger={}

for index,type in pairs(_canGetTiggerType)do
canGetHudTigger[type]={}
end

for index,cfg in pairs(needCheckCanGetLookUp)do
if cfg.upLevelUnlockReddotTrigger~=nil then
for index,info in ipairs(cfg.upLevelUnlockReddotTrigger)do
local type=info[1]
local trigger=canGetHudTigger[type]

if type==_canGetTiggerType.eSys then
local sysID=info[2]
trigger[sysID]=cfg
elseif type==_canGetTiggerType.eBuild then
local buildID=info[2]
trigger[buildID]=cfg
elseif type==_canGetTiggerType.eXM then
trigger[#trigger+1]=cfg
elseif type==_canGetTiggerType.eMoney then
local moneyID=info[2]
trigger[moneyID]=cfg
end
end
end
end
end

function UIDanYaoModel.checkFreshHud(type,arg1,arg2)
if next(canGetHudTigger)==nil then UIDanYaoModel.initCanGetHudTigger()end

local isFresh=false

if type==_canGetTiggerType.eSys then
local sysID=arg1
if canGetHudTigger[_canGetTiggerType.eSys][sysID]then
isFresh=true

if arg2==nil then
hudControl:refreshBuildingStatusHUD(arg2)
return
end
end
elseif type==_canGetTiggerType.eBuild then
local buildID=arg1
if canGetHudTigger[_canGetTiggerType.eSys][buildID]then
isFresh=true
end
elseif type==_canGetTiggerType.eXM then
if next(canGetHudTigger[_canGetTiggerType.eXM])then
isFresh=true
end
elseif type==_canGetTiggerType.eMoney then
local moneyID=arg1
if canGetHudTigger[_canGetTiggerType.eMoney][moneyID]then
isFresh=true
end
end

if isFresh then
UIDanYaoController:refreshAllLianDanFangHud()
end
end



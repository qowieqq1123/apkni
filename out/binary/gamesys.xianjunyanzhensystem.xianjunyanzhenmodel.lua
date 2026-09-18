






local _MODULENAME="XianJunYanZhenModel"


def_table(_MODULENAME)
XianJunYanZhenModel.name=_MODULENAME
XianJunYanZhenModel.data={}

function XianJunYanZhenModel:onAppStart()

end


function XianJunYanZhenModel:onEnterState(isReconnect)

end


function XianJunYanZhenModel:onProtocolReq()

end


function XianJunYanZhenModel:onLeaveState(isReconnect)

self.data={}
end





function XianJunYanZhenModel:setXJYWData(total_star,total_star_rw_idx,gx_len,gxList,used_len,usedList,log_len,logList,log_fight_id_len,fightIdList,gx_star_list_len,gxStarList)
self.data.total_star=total_star
self.data.total_star_rw_idx=total_star_rw_idx
self.data.gxList={}
self.data.usedList={}
self.data.logList={}
self.data.fightIdList=fightIdList or{}

self.data.usedYZLookup={}
self.data.usedDZLookup={}
self.data.usedXSLookup={}
self.data.killLookup={}
self.data.buffLookup={}
self.data.buffList={}
self.data.hasNewBuff={}
self.data.newLogLookup={}
self.data.logGxId=nil
self.data.maxLayer=0


local oldData=userActorSetting.get("XianJunYanZhen_curGxId",nil)
if type(oldData)=='number'then
oldData=nil
end
if oldData then
if gx_len==0 then
self.data.cur_gx_id=1
self.data.max_gx_id=1
XianJunYanZhenModel:saveCurGxId()
elseif not self.data.max_gx_id then
local gxLen=XianJunYanZhenModel:getGxLen()
self.data.cur_gx_id=oldData.curGxId
self.data.max_gx_id=oldData.maxGxId
if self.data.cur_gx_id>gxLen then
self.data.cur_gx_id=gxLen
end
if self.data.max_gx_id>gxLen then
self.data.max_gx_id=gxLen
end
end
end

local gxStarListLookup={}
if gx_star_list_len>0 then
for i=1,gx_star_list_len do
local gx_id=gxStarList[i].param_1
local idx=gxStarList[i].param_2
if not gxStarListLookup[gx_id]then
gxStarListLookup[gx_id]={}
end
gxStarListLookup[gx_id][idx]=true
end
end

if gx_len>0 then
for i=1,gx_len do
local gx_id=gxList[i].param_1
local star=gxList[i].param_2
local rw=gxList[i].param_3
local cantz=gxList[i].param_4
local max_star=gxList[i].param_5

self.data.gxList[gx_id]={
gx_id=gx_id,
star=star,
rw=rw,
cantz=cantz,
max_star=max_star,
starList=gxStarListLookup[gx_id],
}
if not self.data.cur_gx_id and star==0 then
self.data.cur_gx_id=gx_id
end
if max_star==0 and(not self.data.max_gx_id or gx_id>self.data.max_gx_id)then
self.data.max_gx_id=gx_id
end
if max_star>0 and gx_id>self.data.maxLayer then
self.data.maxLayer=gx_id
end
end
end

if used_len>0 then
for i=1,used_len do
local used_data=usedList[i]
self.data.usedList[used_data.mon_groub_idx]=used_data

if used_data.boat_len>0 then
for ii=1,used_data.boat_len do
local boatId=used_data.boatList[ii]
self.data.usedYZLookup[boatId]=used_data

local xiushiData=used_data.xiushiList[ii]
for iii=1,xiushiData.len do
local level=xiushiData.list[iii].param_1
local count=xiushiData.list[iii].param_2
self.data.usedXSLookup[level]=(self.data.usedXSLookup[level]or 0)+count
end
end
end

if used_data.dizi_len>0 then
for ii=1,used_data.dizi_len do
local dzid_str=tostring(used_data.diziList[ii])
local boatIdx=math.floor((ii-1)/5+1)
local boatId=used_data.boatList[boatIdx]

self.data.usedDZLookup[dzid_str]=boatId
end
end
end
end

if log_len>0 then
for i=1,log_len do
local gx_id=logList[i].param_1
local mon_groub_idx=logList[i].param_2
local ret=logList[i].param_3
local total_xiushi_cnt=logList[i].param_4
local qs_xiushi_cnt=logList[i].param_5
local damage_rate=logList[i].param_6

self.data.logGxId=gx_id
if self.data.gxList[gx_id].star==0 then
self.data.cur_gx_id=gx_id
end

self.data.logList[i]={
gx_id=gx_id,
mon_groub_idx=mon_groub_idx,
ret=ret,
total_xiushi_cnt=total_xiushi_cnt,
qs_xiushi_cnt=qs_xiushi_cnt,
damage_rate=damage_rate,
}

if ret==0 and not self.data.killLookup[mon_groub_idx]then
self.data.killLookup[mon_groub_idx]=true

XianJunYanZhenModel:addKillBuff(gx_id,mon_groub_idx)
end
end
end
if not self.data.max_gx_id then
XianJunYanZhenModel:setOpenGx(gx_len+1)
elseif not self.data.gxList[self.data.max_gx_id]then
XianJunYanZhenModel:initGxData(self.data.max_gx_id)
end
end

function XianJunYanZhenModel:setCanUseXSList(len,list)
if not self.data.canUseXSList or len>0 then
self.data.canUseXSList={}
end
if len>0 then
self.data.canUseXSList={}
for i=1,len do
self.data.canUseXSList[list[i].param_1]=list[i].param_2
end
end
end

function XianJunYanZhenModel:saveCurGxId()
userActorSetting.set('XianJunYanZhen_curGxId',{curGxId=self.data.cur_gx_id,maxGxId=self.data.max_gx_id})
userActorSetting.flush()
end








function XianJunYanZhenModel:addKillBuff(gx_id,mon_groub_idx)
local mon_groub_list=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,gx_id,"mon_groub_list")
local monster=mon_groub_list[mon_groub_idx]
local monsterId=monster[1]
local minTeamNum=monster[2]
local dzBuffs=monster[3]
local monsterBuffs=monster[4]
local buffType=monster[6]

local lookup=self.data.buffLookup
if dzBuffs and next(dzBuffs)then
if not lookup[-1]then
lookup[-1]={}
end
for k,v in pairs(dzBuffs)do
if not lookup[-1][v[1]]then
lookup[-1][v[1]]={}
end
table.insert(lookup[-1][v[1]],{level=v[2],type=buffType})
end

self.data.hasNewBuff=true
end
if monsterBuffs and next(monsterBuffs)then
for mId,v in pairs(monsterBuffs)do
if not lookup[mId]then
lookup[mId]={}
end

for k,vv in pairs(v)do
if not lookup[mId][vv[1]]then
lookup[mId][vv[1]]={}
end
table.insert(lookup[mId][vv[1]],{level=vv[2],type=buffType})
end
end

self.data.hasNewBuff=true
end
self.data.buffLookup=lookup
end


function XianJunYanZhenModel:setUsedData(mon_groub_idx,boat_len,boatList,xiushi_len,xiushiList)
if not self.data.usedList then
self.data.usedList={}
end
if not self.data.usedList[mon_groub_idx]then
self.data.usedList[mon_groub_idx]={
mon_groub_idx=mon_groub_idx,
boat_len=boat_len,
boatList=boatList,
dizi_len=0,
diziList={},
xiushi_len=xiushi_len,
xiushiList=xiushiList,
}
end

local used_data=self.data.usedList[mon_groub_idx]

for i=1,used_data.boat_len do
local yzLookup={}
local boatId=used_data.boatList[i]

local xiushiData=used_data.xiushiList[i]
local xsList={}
for ii=1,xiushiData.len do
local level=xiushiData.list[ii].param_1
local count=xiushiData.list[ii].param_2
self.data.usedXSLookup[level]=(self.data.usedXSLookup[level]or 0)+count

xsList[level]=count
end

yzLookup.xsList=xsList
local dzLen=used_data.dizi_len or 0
local dzList=used_data.diziList or{}

local yzData=XianJunYanZhenModel:getXJYZYunZhouDataByYzIdx(boatId)
local teamDzList_lookup=yzData and yzData.team or nil
local hasTeam=teamDzList_lookup~=nil and next(teamDzList_lookup)~=nil
if hasTeam then
for idx,dzGuidStr in pairs(teamDzList_lookup)do
local dzGuid=int64.new(dzGuidStr)

dzLen=dzLen+1
table.insert(dzList,dzGuid)

self.data.usedDZLookup[dzGuidStr]=boatId
end
end
yzLookup.dizi_len=dzLen
yzLookup.diziList=dzList

self.data.usedYZLookup[boatId]=yzLookup
end
end


function XianJunYanZhenModel:setLogData(gx_id,mon_groub_idx,xiushi_len,xiushiList,damage_xiushi_len,damageXsList,damage_rate_len,damageRateList,fight_log_id_len,fightIdList,result)
if not self.data.logList or not XianJunYanZhenModel:getIsHasGxLog(gx_id)then
if self.data.logGxId then
self.data.buffLookup={}
self.data.buffList={}
end
self.data.logGxId=gx_id
XianJunYanZhenModel:setResetGxData(gx_id)
end
for i=1,fight_log_id_len do
local total_xiushi_cnt=0

local len=xiushiList[i].len
for ii=1,len do
local count=xiushiList[i].list[ii].param_2
total_xiushi_cnt=total_xiushi_cnt+count
end
local isWin=i==fight_log_id_len and result==fightResultType.Victory
local args={
gx_id=gx_id,
mon_groub_idx=mon_groub_idx,
ret=isWin and 0 or 1,
total_xiushi_cnt=total_xiushi_cnt,
qs_xiushi_cnt=damageXsList[i]or 0,
damage_rate=damageRateList[i]or 0,
}
table.insert(self.data.logList,args)
self.data.newLogLookup[#self.data.logList]=true

table.insert(self.data.fightIdList,fightIdList[i])
end

if result==fightResultType.Victory then
self.data.killLookup[mon_groub_idx]=true

XianJunYanZhenModel:addKillBuff(gx_id,mon_groub_idx)
end
end


function XianJunYanZhenModel:setResetGxData(gx_id)
if self.data.logGxId==gx_id then
self.data.usedList={}
self.data.logList={}
self.data.fightIdList={}
self.data.usedYZLookup={}
self.data.usedDZLookup={}
self.data.usedXSLookup={}
self.data.killLookup={}
self.data.buffLookup={}
self.data.buffList={}
self.data.hasNewBuff={}
self.data.newLogLookup={}
end

if self.data.gxList[gx_id]then
self.data.gxList[gx_id].star=0
end

if self.data.cur_gx_id~=gx_id then
self.data.cur_gx_id=gx_id
end
end


function XianJunYanZhenModel:setGxData(gx_id,star,starList)

XianJunYanZhenModel:initGxData(gx_id)

local oldMaxStar=self.data.gxList[gx_id].max_star
self.data.gxList[gx_id].star=star
if star>oldMaxStar then
self.data.gxList[gx_id].max_star=star
self.data.gxList[gx_id].starList=starList
end
if star>oldMaxStar then
self.data.total_star=self.data.total_star+star-oldMaxStar
end

if star>0 then
self.data.cur_gx_id=self.data.max_gx_id
end

if star>0 and gx_id>self.data.maxLayer then
self.data.maxLayer=gx_id
end
end


function XianJunYanZhenModel:setGxRetData(gx_id,ret)

local cantz=ret==0 and 1 or 0
XianJunYanZhenModel:initGxData(gx_id)

self.data.gxList[gx_id].cantz=cantz
end


function XianJunYanZhenModel:setOpenGx(gx_id)
local gxLen=XianJunYanZhenModel:getGxLen()
if gx_id>gxLen then
gx_id=gxLen
end

XianJunYanZhenModel:initGxData(gx_id)

self.data.gxList[gx_id].star=0

local maxGxId=self.data.max_gx_id or 0
if gx_id>maxGxId then
self.data.max_gx_id=gx_id
end
self.data.cur_gx_id=gx_id
end


function XianJunYanZhenModel:setTotalStarRwIdx(total_star_rw_idx)
self.data.total_star_rw_idx=total_star_rw_idx
end


function XianJunYanZhenModel:initGxData(gx_id)
if not self.data.gxList then
self.data.gxList={}
end
if not self.data.gxList[gx_id]then
self.data.gxList[gx_id]={
gx_id=gx_id,
star=0,
rw=0,
cantz=0,
max_star=0,
}
end
end




function XianJunYanZhenModel:getCurGxId()
return self.data.cur_gx_id or 1
end


function XianJunYanZhenModel:getMaxGxId()
return self.data.max_gx_id or 1
end


function XianJunYanZhenModel:getGxLen()
if not self.gxLen then
for i,v in ipairs(cfg_xianjunyanzhengxconfig())do
if v.id then
self.gxLen=v.id
end
end
end
return self.gxLen
end


function XianJunYanZhenModel:getMaxLayer()
return self.data.maxLayer or 0
end


function XianJunYanZhenModel:getTotalStar()
return self.data.total_star or 0
end


function XianJunYanZhenModel:getMaxStar()
if not self.maxStarCount then
self.maxStarCount=0
for i,v in ipairs(cfg_xianjunyanzhengxconfig())do
self.maxStarCount=self.maxStarCount+#v.star_conf+1
end
end
return self.maxStarCount
end


function XianJunYanZhenModel:getTotalStarRwIdx()
return self.data.total_star_rw_idx or 0
end


function XianJunYanZhenModel:getGxData(gx_id)
XianJunYanZhenModel:initGxData(gx_id)

return self.data.gxList[gx_id]or defaultT
end


function XianJunYanZhenModel:getGxStar(gx_id)
XianJunYanZhenModel:initGxData(gx_id)

return self.data.gxList[gx_id].star or 0
end


function XianJunYanZhenModel:getGxMaxStar(gx_id)
XianJunYanZhenModel:initGxData(gx_id)

return self.data.gxList[gx_id].max_star or 0
end


function XianJunYanZhenModel:getGxStarList(gx_id)
XianJunYanZhenModel:initGxData(gx_id)

return self.data.gxList[gx_id].starList or{}
end


function XianJunYanZhenModel:getGxCanTz(gx_id)
XianJunYanZhenModel:initGxData(gx_id)

return self.data.gxList[gx_id].cantz==1
end


function XianJunYanZhenModel:getCanUseXSList(gx_id)
if not XianJunYanZhenModel:getIsHasGxLog(gx_id)then
return nil
end
return self.data.canUseXSList
end

function XianJunYanZhenModel:getGxQSXSRate(gx_id)
local mon_groub_list=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,gx_id,"mon_groub_list")
local multi_battle_mon_id=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,gx_id,"multi_battle_mon_id")
local logList=XianJunYanZhenModel:getLogList(gx_id)
local totalXiushiCnt=0
local qsXiushiCnt=0
for i=1,#mon_groub_list do
if XianJunYanZhenModel:getUsedData(i,gx_id)~=nil then
for _,v in ipairs(logList)do
if v.mon_groub_idx==i then
if v.ret==0 or(multi_battle_mon_id~=nil and multi_battle_mon_id[i]~=nil)then
totalXiushiCnt=totalXiushiCnt+v.total_xiushi_cnt
qsXiushiCnt=qsXiushiCnt+v.qs_xiushi_cnt
end
end
end
end
end
if totalXiushiCnt>0 then
return math.floor((qsXiushiCnt*100)/totalXiushiCnt)
else
return 0
end
end


function XianJunYanZhenModel:getUsedData(mon_groub_idx,gx_id)
local curGxId=gx_id or XianJunYanZhenModel:getCurGxId()
if not XianJunYanZhenModel:getIsHasGxLog(curGxId)then
return nil
end
if not self.data.usedList then
return nil
end
return self.data.usedList[mon_groub_idx]
end


function XianJunYanZhenModel:getIsUsedYZ(yzid,gx_id)
local curGxId=gx_id or XianJunYanZhenModel:getCurGxId()
if not XianJunYanZhenModel:getIsHasGxLog(curGxId)then
return false
end
if not self.data.usedYZLookup then
return false
end
return self.data.usedYZLookup[yzid]~=nil
end


function XianJunYanZhenModel:getIsUsedDZ(disguid,gx_id)
local curGxId=gx_id or XianJunYanZhenModel:getCurGxId()
if not XianJunYanZhenModel:getIsHasGxLog(curGxId)then
return false
end
if not self.data.usedDZLookup then
return false
end
local disguid_str=tostring(disguid)
return self.data.usedDZLookup[disguid_str]~=nil
end


function XianJunYanZhenModel:getUsedXS(gx_id)
local curGxId=gx_id or XianJunYanZhenModel:getCurGxId()
if not XianJunYanZhenModel:getIsHasGxLog(curGxId)then
return defaultT
end
if not self.data.usedXSLookup then
return defaultT
end
return self.data.usedXSLookup or{}
end


function XianJunYanZhenModel:getLogList(gx_id)
if not gx_id then
gx_id=XianJunYanZhenModel:getCurGxId()
end
if not XianJunYanZhenModel:getIsHasGxLog(gx_id)then
return defaultT
end
return self.data.logList or{}
end


function XianJunYanZhenModel:getIsHasGxLog(gx_id)
return self.data.logGxId==gx_id
end


function XianJunYanZhenModel:getBuffList(gx_id)
if not XianJunYanZhenModel:getIsHasGxLog(gx_id)then
return defaultT
end
if not self.data.buffLookup or not next(self.data.buffLookup)then
return defaultT
end

if self.data.hasNewBuff then
self.data.hasNewBuff=false

local mon_groub_list=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,gx_id,"mon_groub_list")
local len=#mon_groub_list+1

self.data.buffList={}
for i=1,len do
local idx=i-1
local monId
if idx==0 then
monId=-1
else
monId=mon_groub_list[idx][1]
end
local buff=self.data.buffLookup[monId]
if buff and next(buff)then
local type=0
local descparmLookup={}
for buffId,v in pairs(buff)do
for k,vv in ipairs(v)do
local level=vv.level
type=vv.type or 0
local cfg=cfgHelper.getSSlawRule(buffId)
descparmLookup[buffId]=descparmLookup[buffId]or{}
for k,val in ipairs(cfg.descparm[level])do
descparmLookup[buffId][k]=(descparmLookup[buffId][k]or 0)+val
end
end
end

local descStr
for buffId,v in pairs(descparmLookup)do
local cfg=cfgHelper.getSSlawRule(buffId)
local desc=string.format(cfg.desc,unpack(v))
if idx>0 then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,mon_groub_list[idx][1])
desc=FMT.fmt(desc,monsterCfg.name)
end
if descStr then
descStr=FMT.fmt("{0}\n{1}",descStr,desc)
else
descStr=desc
end
end
table.insert(self.data.buffList,{monId,descStr,type})
end
end
end

return self.data.buffList
end


function XianJunYanZhenModel:getIsKill(gx_id,mon_groub_idx)

local star=XianJunYanZhenModel:getGxStar(gx_id)
if star>0 then
return true,0,100
end

if not XianJunYanZhenModel:getIsHasGxLog(gx_id)then
return false,100,100
end

if self.data.killLookup[mon_groub_idx]then
return true,0,100
end

local hp=10000
local maxHp=10000
local logList=XianJunYanZhenModel:getLogList(gx_id)
for i,v in ipairs(logList)do
if v.mon_groub_idx==mon_groub_idx then
hp=hp-(v.damage_rate or 0)
end
end
hp=math.max(hp,0)
return false,hp*100/maxHp,100
end


function XianJunYanZhenModel:getFightIdList()
return self.data.fightIdList or{}
end


function XianJunYanZhenModel:checkReddot()
return XianJunYanZhenModel:isCanAnyPrizeStar()
end

function XianJunYanZhenModel:isCanAnyPrizeStar()
local star=XianJunYanZhenModel:getTotalStar()
for i,v in ipairs(cfg_xianjunyanzhenstarrwconfig())do
if star<v.star then return false end
if not XianJunYanZhenModel:isPrizeStar(v.id)then
return true
end
end
return false
end

function XianJunYanZhenModel:isPrizeStar(id)
local prizestar=XianJunYanZhenModel:getTotalStarRwIdx()
return prizestar>=id
end

function XianJunYanZhenModel:isCanPrizeStar(id)
if XianJunYanZhenModel:isPrizeStar(id)then return false end
local star=XianJunYanZhenModel:getTotalStar()
return star>=cfgHelper.get2(cfg_xianjunyanzhenstarrwconfig_get,id,'star')
end


function XianJunYanZhenModel:isNewLog(idx)
if self.data.newLogLookup[idx]then
return true
end
return false
end

function XianJunYanZhenModel:clearNewLog()
self.data.newLogLookup={}
end



function XianJunYanZhenModel:showXJYZUsedDialouge(args)
local boat_id=args.boat_id
local callFunc=args.callFunc
local isUsedYZ=XianJunYanZhenModel:getIsUsedYZ(boat_id)
if isUsedYZ then
local curGxId=XianJunYanZhenModel:getCurGxId()
local content=FMT.fmt('该阵器在<color=#7d3b17>仙军演阵</color>中处于锁定状态，\n调整阵器视为重新挑战<color=#7d3b17>第{0}关</color>，是否\n要调整？',curGxId)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
XianJunYanZhenController:send_42_2(curGxId)
callFunc()
end,
showclosebtn=true,
}
self.tipsDialog=UIDialogManager.newDialog(showdata)
self.tipsDialog:show()
return true
else
callFunc()
end
return false
end

function XianJunYanZhenModel:getDescStr(gx_id,condition,index,isWc)
if not condition then
return"击败全部妖魔，成功通关",false
end
local type=condition[1]
local isHide=condition[2]
local count=condition[3]
local isLock=false
local desc=FMT.fmt("未适配类型{0}",type)
local max_star=XianJunYanZhenModel:getGxMaxStar(gx_id)
if isHide==1 and max_star<index-1 then
isLock=true
desc=FMT.fmt("完成{0}星目标后解锁",index-1)
elseif type==1 then
if isWc then
desc=FMT.fmt("通关轻伤修士不超过{0}%",count)
else
local qs_xs_rate=XianJunYanZhenModel:getGxQSXSRate(gx_id)
desc=FMT.fmt("通关轻伤修士不超过{0}%({1}%)",count,qs_xs_rate)
end
elseif type==2 then
desc=FMT.fmt("全部队伍出战弟子不超过{0}名",count)
elseif type==3 then
if count==0 then
desc="全部队伍出战均为仙魔弟子"
else
desc=FMT.fmt("全部队伍出战均为{0}弟子",count==1 and"仙道"or"魔道")
end
elseif type==4 then
local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,count)
desc=FMT.fmt("队伍不携带{0}或以上修士通关",soldierCfg.name),false
elseif type==5 then
local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,count)
desc=FMT.fmt("队伍只携带{0}或以上修士通关",soldierCfg.name),false
end
return desc,isLock
end
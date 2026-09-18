







local _qjStageName={'学徒','名匠','宗师','至尊'}

function UIDiscipleModel:initShuWuData()
self.shuWuData={}
self.shuWuMEffectData={}
self.shuWuDYEffectData={}
self.isShuWuMEffectDirty=true
self.isShuWuDZEffectDirty=true
self.shuWuFightValueData={}
self.shuWuLastFightValueData={}

self.shuwuDZCfgDict={}
local cfgs=cfg_discipleshuwuconfig()
for k,v in pairs(cfgs)do
self.shuwuDZCfgDict[k]=v
end
end

function UIDiscipleModel:clearShuWuData()
self.shuWuData=nil
self.shuWuMEffectData=nil
self.shuWuDZEffectData=nil
self.shuwuDZCfgDict=nil
self.shuWuFightValueData=nil
end

function UIDiscipleModel:setShuWuDatas(len,arr)
if len>0 then
for i,v in ipairs(arr)do
local data={
dzId=v.param_1,
bdId=v.param_2,
effectType=v.param_3,
triggerCount=v.param_4,
}
self.shuWuData[data.dzId]=data
end
end
end

function UIDiscipleModel:resetShuWuData(rdata)
local data={
dzId=rdata.param_1,
bdId=rdata.param_2,
effectType=rdata.param_3,
triggerCount=rdata.param_4,
}
self.shuWuData[data.dzId]=data
end

function UIDiscipleModel:getShuWuData(dizidi)
if self.shuWuData and self.shuWuData[dizidi]then
return self.shuWuData[dizidi].triggerCount
end
end
function UIDiscipleModel:setShuWuDataZero()
if self.shuWuData and self.shuWuData[5002]then
self.shuWuData[5002].triggerCount=0
end
end

function UIDiscipleModel:getShuWuDZConfig(id)
return self.shuwuDZCfgDict[id]
end

function UIDiscipleModel:isShuWuDisciple(id)
return self.shuwuDZCfgDict[id]~=nil
end

function UIDiscipleModel:isShuWuDiscipleEx(dzId)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
return self.shuwuDZCfgDict[dzData.id]~=nil
end

function UIDiscipleModel:getShuWuQJLevelInfo(bdId,level)
local stage,order=self:countShuWuQJStageValue(level)
local name=self:getShuWuQJStageName(bdId,stage)
return name,order
end

function UIDiscipleModel:getShuWuQJLevelFullName(bdId,level)
local name,order=self:getShuWuQJLevelInfo(bdId,level)
return FMT.fmt('{0}{1}阶',name,order)
end

function UIDiscipleModel:getShuWuQJStageName(bdId,stage)
local cfg=cfgHelper.get1(cfg_discipleshuwuinfoconfig_get,bdId)
local name=FMT.fmt('{0}{1}',cfg.prefix,_qjStageName[stage])
return name
end

function UIDiscipleModel:countShuWuQJStageValue(level)
local stage=math.floor((level-1)/10)+1
local order=(level-1)%10+1
return stage,order
end

function UIDiscipleModel:setShuWuFightValueDirty(guid)
local str=tostring(guid)
self.shuWuFightValueData[str]=nil
end

function UIDiscipleModel:recordShuWuLastFightValue(guid)
local str=tostring(guid)
self.shuWuLastFightValueData[str]=self.shuWuFightValueData[str]
end

function UIDiscipleModel:getShuWuLastFightValue(guid)
local str=tostring(guid)
return self.shuWuLastFightValueData[str]or-1
end

function UIDiscipleModel:getShuWuFightValue(guid)
local idStr=tostring(guid)
local fvalue=self.shuWuFightValueData[idStr]
if fvalue then
return fvalue
end

local dzData=UIDiscipleModel:getDiscipleData(guid)
local jjlevel=dzData.jingjielv
local jjRate=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlevel,'shuwu')
local cfg=UIDiscipleModel:getShuWuDZConfig(dzData.id)
local attr1=dzData.attrList
local attr2=cfgHelper.getdef1(cfg_discipleshuwuconfig,'attr6')
local attr3=cfg.attr6
fvalue=0
for i=1,6 do
local fv=attr1[i]*attr2[i]*attr3[i]*jjRate
fvalue=fvalue+fv
end
fvalue=math.floor(fvalue)
self.shuWuFightValueData[idStr]=fvalue
return fvalue
end

function UIDiscipleModel:getShuWuSkillDesc(args,dzData_id)
local htype=args[1]
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,args[2])
local dstrdata=cfgHelper.get1(cfg_discipleshuwuattrinfoconfig_get,htype)
local descid=1
if dstrdata.descid then
descid=dstrdata.descid
elseif dstrdata.descid2 then
descid=dstrdata.descid2[dzData_id]
end
local dstr=cfgHelper.get2(cfg_discipleshuwuattrdescinfoconfig_get,descid,'desc')
local desc
if htype==1 then
desc=FMT.fmt(dstr,bdcfg.name,args[3])
elseif htype==2 then
desc=FMT.fmt(dstr,bdcfg.name,args[3])
elseif htype==3 then
local name=UIDiscipleModel:discipleBaseAttrName(args[3])
desc=FMT.fmt(dstr,bdcfg.name,name,args[4]*0.01)
elseif htype==4 then
desc=FMT.fmt(dstr,bdcfg.name,args[3])
elseif htype==5 then
local temp=args[3]
local num=UIDiscipleModel:getShuWuData(dzData_id)or 0
desc=FMT.fmt(dstr,bdcfg.name,temp[1],temp[2],temp[3],temp[4],0,args[5],num)
elseif htype==6 then
desc=FMT.fmt(dstr,args[2],math.abs(args[3]))
elseif htype==7 then
desc=FMT.fmt(dstr,args[2])
elseif htype==8 then
local num=UIDiscipleModel:getShuWuData(dzData_id)or 0
desc=FMT.fmt(dstr,bdcfg.name,args[3],0,0,args[5],num)
elseif htype==9 then
desc=FMT.fmt(dstr,bdcfg.name,math.abs(args[3]))
end
return desc
end

function UIDiscipleModel:getShuWuSkillNextDesc(args,dzData_id)
local htype=args[1]
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,args[2])
local dstrdata=cfgHelper.get1(cfg_discipleshuwuattrinfoconfig_get,htype)
local descid=1
if dstrdata.descid then
descid=dstrdata.descid
elseif dstrdata.descid2 then
descid=dstrdata.descid2[dzData_id]
end
local dstr=cfgHelper.get2(cfg_discipleshuwuattrdescinfoconfig_get,descid,'desc2')
local desc
if htype==1 then
desc=FMT.fmt(dstr,bdcfg.name,args[3])
elseif htype==2 then
desc=FMT.fmt(dstr,bdcfg.name,args[3])
elseif htype==3 then
local name=UIDiscipleModel:discipleBaseAttrName(args[3])
desc=FMT.fmt(dstr,bdcfg.name,name,args[4]*0.01)
elseif htype==4 then
desc=FMT.fmt(dstr,bdcfg.name,args[3])
elseif htype==5 then
local temp=args[3]
desc=FMT.fmt(dstr,bdcfg.name,temp[1],temp[2],temp[3],temp[4],0,args[5])
elseif htype==6 then
desc=FMT.fmt(dstr,args[2],math.abs(args[3]))
elseif htype==7 then
desc=FMT.fmt(dstr,args[2])
elseif htype==8 then
desc=FMT.fmt(dstr,bdcfg.name,args[3],0,0,args[5])
elseif htype==9 then
desc=FMT.fmt(dstr,bdcfg.name,math.abs(args[3]))
end
return desc
end

function UIDiscipleModel:setShuWuMEffectDirty()
self.isShuWuMEffectDirty=true
end

function UIDiscipleModel:setShuWuDYEffectDirty()
self.isShuWuDZEffectDirty=true
end

function UIDiscipleModel:getShuWuDZGlobalMEffectData()
if not self.isShuWuMEffectDirty then
return self.shuWuMEffectData
end
self.isShuWuMEffectDirty=false

self.shuWuMEffectData={}
local datas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(datas)do
local netData=v.netData.net
if UIDiscipleModel:isShuWuDisciple(netData.id)then
local qjCfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,netData.qiaojianglv)
local bonus=qjCfg.bonus[netData.id]
if bonus then
for ii,vv in ipairs(bonus)do
if vv[1]==1 then
local val=self.shuWuMEffectData[vv[2]]or 0
val=val+vv[3]
self.shuWuMEffectData[vv[2]]=val
end
end
end

if netData.swList then
local cfg=UIDiscipleModel:getShuWuDZConfig(netData.id)
for ii,vv in ipairs(netData.swList)do
if vv>0 then
local skillId=cfg.skill[ii]
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,vv)
local bonus=skillCfg.bonus
for iii,vvv in ipairs(bonus)do
if vvv[1]==1 then
local val=self.shuWuMEffectData[vvv[2]]or 0
val=val+vvv[3]
self.shuWuMEffectData[vvv[2]]=val
end
end
end
end
end
end
end

return self.shuWuMEffectData
end


function UIDiscipleModel:getShuWuDZGlobalDYEffectData()
if not self.isShuWuDZEffectDirty then
return self.shuWuDYEffectData
end
self.isShuWuDZEffectDirty=false

self.shuWuDYEffectData={}
local datas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(datas)do
local netData=v.netData.net
if UIDiscipleModel:isShuWuDisciple(netData.id)then
local qjCfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,netData.qiaojianglv)
local bonus=qjCfg.bonus[netData.id]
if bonus then
for ii,vv in ipairs(bonus)do
if vv[1]==6 then
local val=self.shuWuDYEffectData[1]or 0
val=val+vv[2]
self.shuWuDYEffectData[1]=val

local val=self.shuWuDYEffectData[2]or 0
val=val+vv[3]
self.shuWuDYEffectData[2]=val
elseif vv[1]==7 then
local val=self.shuWuDYEffectData[3]or 0
val=val+vv[2]
self.shuWuDYEffectData[3]=val
end
end
end

if netData.swList then
local cfg=UIDiscipleModel:getShuWuDZConfig(netData.id)
for ii,vv in ipairs(netData.swList)do
if vv>0 then
local skillId=cfg.skill[ii]
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,vv)
local bonus=skillCfg.bonus
for iii,vvv in ipairs(bonus)do
if vvv[1]==6 then
local val=self.shuWuDYEffectData[1]or 0
val=val+vvv[2]
self.shuWuDYEffectData[1]=val

local val=self.shuWuDYEffectData[2]or 0
val=val+vvv[3]
self.shuWuDYEffectData[2]=val
elseif vvv[1]==7 then
local val=self.shuWuDYEffectData[3]or 0
val=val+vvv[2]
self.shuWuDYEffectData[3]=val
end
end
end
end
end
end
end

return self.shuWuDYEffectData
end

function UIDiscipleModel:countShuWUDZSelfPDAddValue(dzData)
local qjLevel=dzData.qiaojianglv or 1
local id=dzData.id
local cfg=UIDiscipleModel:getShuWuDZConfig(id)
local bdId=cfg.bdId
local bonus=cfgHelper.get2(cfg_discipleqiaojiangconfig_get,qjLevel,'bonus')
bonus=bonus[id]
local count=0
if bonus then
for i,v in ipairs(bonus)do
local bt=v[2]
if bt==0 or bt==bdId then
local ht=v[1]
if bt==1 or ht==2 then
count=count+v[3]
elseif ht==9 then
count=count+math.abs(v[3])
elseif ht==3 then
count=count+dzData.attrList[v[3]]*v[4]*0.01
end
end
end
end

local ptype=cfg.produceType
local swList=dzData.swList or{0,0,0}
for i,v in ipairs(swList)do
if v>0 then
local skillId=cfg.skill[i]
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,v)
local bonus=skillCfg.bonus
for ii,vv in ipairs(bonus)do
if(vv[1]==1 or vv[1]==2)and vv[2]==bdId then
count=count+vv[3]
elseif vv[1]==9 and vv[2]==bdId then
count=count+math.abs(vv[3])
elseif vv[1]==3 then
count=count+dzData.attrList[vv[3]]*vv[4]*0.01
end
end
end
end
count=math.floor(count)
return count,ptype
end









UIDiscipleModel={}
local _LuaHelper=CS.LuaHelper
UIDiscipleModel.data={}
local _cacheTexture2D=30

DISCIPLE_PROSKILL_TYPE=
{
ePeiZhi=1,
eDanDao=2,
eShangDao=3,
eFuLu=4,
eLianQi=5,
eZhenFa=6,
eSiYang=7,
eJuLing=8,
}


dicipleType={
eSystem=1,
eTemp=2,
}


discipleSrcType={
eNone=0,
eZongMen=1,
eHome=2,
eZhaoMuFuLu=3,
eBaiShan=4,
eAppointment=7,

ePlotBegin=99,
ePlot1=100,
ePlot2=101,
ePlot3=102,
ePlot4=103,
ePlot5=104,
ePlot6=105,
ePlot7=106,
ePlot8=107,
ePlot9=108,
ePlot10=109,
ePlotEnd=10000,


isPlot=function(self,v)
return v>self.ePlotBegin and v<self.ePlotEnd
end,


isItem=function(self,v)
return v>=self.ePlotEnd
end,
}

disciplePlotTypes={}
for k,v in pairs(discipleSrcType)do
if type(v)=='number'and discipleSrcType:isPlot(v)then
disciplePlotTypes[#disciplePlotTypes+1]=v
end
end




discipleconfigFlag=
{
forbidQuZhu=0,
forbidChuanGong=1,
forbidTianMingXiangGuang=2,
forbidLingGenXiangGuang=3,
forbidGaiMing=4,
forbidChongSuiTianMing=5,
forbidLianDongChange=6,
forbidSuChenLingShan=7,
}


local discipleNetData=nil
local discipleCount=0

local discipleNetDataTemp=nil

local itemDiscipleData=nil
local discipleIdCount=nil

local isUseRandtmList=nil
local discipleTMResetList=nil

function UIDiscipleModel:clearData()
self.data={}



self.fightFreshTag=nil

discipleNetData=nil
discipleCount=0
discipleNetDataTemp=nil
itemDiscipleData=nil
discipleIdCount=nil
isUseRandtmList=nil
discipleTMResetList=nil
self.postList_=nil
discipleLookup:clearData()
UIDiscipleModel:clearDZSpeTimePass()
UIDiscipleModel:clearDaoYanData()
self:initRelation()
end






function UIDiscipleModel:init()
if discipleNetData==nil then
discipleNetData={}
end
if itemDiscipleData==nil then
itemDiscipleData={}
end

if discipleIdCount==nil then
discipleIdCount={}
end

if discipleTMResetList==nil then
discipleTMResetList={}
end

UIDiscipleModel:clearDZSpeTimePass()
self.discipleJJListDirty=nil
self.discipleLTListDirty=nil
end

function UIDiscipleModel:initDiscipleList(data)
UIDiscipleModel:init()
for i,v in ipairs(data)do
local data_=discipleNetData[v.discipleguidStr]
if data_==nil then
local d={}
d.netData={net=v,init=true}
d.disType=dicipleType.eSystem
discipleNetData[v.discipleguidStr]=d
else
data_.netData={net=v,init=true}
end
local id=v.id
if discipleIdCount[id]==nil then discipleIdCount[id]=0 end
discipleIdCount[id]=discipleIdCount[id]+1
end
discipleCount=#data
UIDiscipleController:setInit()
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
UIDiscipleModel:initDiscipleAttrLookup(netData.discipleguid)
UIDiscipleModel:setSkillLvPlusLookupDirty(netData.discipleguid)
UIDiscipleModel:updateDZSpeTimePass(netData)
end
UIDiscipleModel:initOthers(data)


discipleLookup:initLookup()
UIDiscipleModel:onInitRelation()
UIDiscipleModel:initXianMoDiscipleCount()
end

function UIDiscipleModel:initOthers(list)
mountModel:initMount(list)
fabaoModel.initFabao(list)
daobingModel:initEquip(list)
equipsModel.initEquips(list)
UIFuLuFangModel:initFuBaoDatas(list)
ClothingModel:initEquip(list)
vocEquipModel:initEquip(list)
lingshouModel:initLingShouEquip(list)
end

function UIDiscipleModel:checkDiscipleCount()
return discipleCount
end

function UIDiscipleModel:getDiscipleIdCount(id)
return discipleIdCount[id]or 0
end

function UIDiscipleModel:getDiscipleColorCount(color)











return dataControl:getValue(DATA_TYPE.dzColorCount,nil,color)or 0
end


function UIDiscipleModel:getDiscipleColorCountAndList(color)
local c=0
local list={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
if imageInfo.color==color then
c=c+1
table.insert(list,netData)
end
end
end
return c,list
end

function UIDiscipleModel:getDiscipleJobCount(jobid)
local data=dataControl:getValue(DATA_TYPE.dzJobInfo,nil,jobid)
return data and#data or 0
end


function UIDiscipleModel:getDiscipleJobAndColorCount(jobid,color)
local c=0
local list={}

if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
if imageInfo.job==jobid and imageInfo.color>=color then
c=c+1
table.insert(list,netData)
end
end
end
return c,list
end

function UIDiscipleModel:findDisciplesByJob(jobid)











return dataControl:getValue(DATA_TYPE.dzJobInfo,nil,jobid)or defaultT
end

function UIDiscipleModel:findDisciplesByID(id)










return dataControl:getValue(DATA_TYPE.dzIdInfo,nil,id)or defaultT
end

function UIDiscipleModel:getDiscipleEquipCount(itemID)










return dataControl:getValue(DATA_TYPE.dzEquipCount,nil,itemID)or 0
end

function UIDiscipleModel:getAllDiscipleData()
return discipleNetData or{}
end

function UIDiscipleModel:getAllDiscipleDataX()
return discipleNetData
end

function UIDiscipleModel:resetFightDiscipleGuidList()
self.fightFreshTag=true
end


function UIDiscipleModel:getFightTop5DiscipleGuidList()
UIDiscipleModel:refreshFightList()

if self.top5FightList==nil then self.top5FightList={}end

return self.top5FightList
end


function UIDiscipleModel:getFightTop15DiscipleGuidList()
UIDiscipleModel:refreshFightList()

if self.top15FightList==nil then self.top15FightList={}end

return self.top15FightList
end


function UIDiscipleModel:getFightTop15DiscipleSumFightValue()
UIDiscipleModel:refreshFightList()

return self.top15FightValue or 0
end


function UIDiscipleModel:getFightTop15DiscipleSumFabaoFightValue()
UIDiscipleModel:refreshFightList()

return self.top15FabaoFightValue or 0
end


function UIDiscipleModel:getFightTop15DiscipleSumDaoBingFightValue()
UIDiscipleModel:refreshFightList()

return self.top15DaobingFightValue or 0
end


function UIDiscipleModel:getFightTopJobDiscipleGuid(job)
if self.topJobFightList==nil then self.topJobFightList={}end

UIDiscipleModel:refreshFightList()

return self.topJobFightList[job]
end


function UIDiscipleModel:getDiscipleFightRank(dzGuidStr)
UIDiscipleModel:refreshFightList()

if self.topFightLookup==nil then return nil end

return self.topFightLookup[dzGuidStr]
end

function UIDiscipleModel:isTopFight(dzGuidStr,rankSmaller)
local index=UIDiscipleModel:getDiscipleFightRank(dzGuidStr)
return index and index<=rankSmaller or false
end


function UIDiscipleModel:isTexture2dTopDisciple(dzGuidStr)
return UIDiscipleModel:isTopFight(dzGuidStr,30)
end


function UIDiscipleModel:checkDiscipleIsTop5(dzguid)
return UIDiscipleModel:isTopFight(tostring(dzguid),5)
end

function UIDiscipleModel:refreshFightList()
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData==nil then return end

if self.fightFreshTag~=false then
self.fightFreshTag=false

local sortTag={}
local dzlist={}
for _,v in pairs(discipleNetData)do
local netData=v.netData.net
local fight=UIDiscipleModel:getDiscipleFightValueEx(netData)
sortTag[netData.discipleguidStr]=fight
dzlist[#dzlist+1]=netData
end

_sort(dzlist,function(a,b)
return sortTag[a.discipleguidStr]>sortTag[b.discipleguidStr]
end)

local top5list={}
local top15list={}
local toplookup={}

local top15FightValue=0
local top15FabaoFightValue=0
local top15DaobingFightValue=0

local max=math.min(#dzlist,_cacheTexture2D)
local jobLookup={}

for i=1,#dzlist do
local dzinfo=dzlist[i]
local discipleguid=dzinfo.discipleguid
local discipleguidStr=dzinfo.discipleguidStr


toplookup[discipleguidStr]=i
if i<=max then


if i<=5 then
_insert(top5list,{
topIndex=i,
discipleguid=discipleguid,
discipleguidStr=discipleguidStr,
})
end


if i<=15 then

_insert(top15list,{
topIndex=i,
discipleguid=discipleguid,
discipleguidStr=discipleguidStr,
})

top15FightValue=top15FightValue+UIDiscipleModel:getDiscipleFightValue(discipleguid)

local equip=equipsHelper.getEquipByDizi(discipleguid,EQUIP_TYPE.eFabao)
if equip then
top15FabaoFightValue=top15FabaoFightValue+fabaoHelper.getFabaoFight(equip.itemguid)
end

equip=equipsHelper.getEquipByDizi(discipleguid,EQUIP_TYPE.eDaoBing)
if equip then
top15DaobingFightValue=top15DaobingFightValue+daobingHelper.getEquipFightX(equip.itemid,equip.itemguid)
end
end
end


local job=UIDiscipleModel:getDiscipleJobByData(dzinfo)
if jobLookup[job]==nil then jobLookup[job]={}end
local joblist=jobLookup[job]
joblist[#joblist+1]=dzinfo
end


local topJobFightList={}
for job,v in pairs(jobLookup)do
_sort(v,function(a,b)
return sortTag[a.discipleguidStr]>sortTag[b.discipleguidStr]
end)
topJobFightList[job]=v[1].discipleguid
end
self.topJobFightList=topJobFightList

self.topFightLookup=toplookup
self.top5FightList=top5list
self.top15FightList=top15list
self.top15FightValue=top15FightValue
self.top15FabaoFightValue=top15FabaoFightValue
self.top15DaobingFightValue=top15DaobingFightValue
end
end















function UIDiscipleModel:getDiscipleData(guid)
local data=UIDiscipleModel:getDiscipleDataX(guid)
if data then
return data.netData.net
end
return nil
end

function UIDiscipleModel:getDiscipleDataByStr(strGuid)
local data=UIDiscipleModel:getDiscipleDataXByStr(strGuid)
if data then
return data.netData.net
end
return nil
end

function UIDiscipleModel:getAnyDiscipleDataByStr(strGuid)
return UIDiscipleModel:getDiscipleDataByStr(strGuid)or
otherPlayerModel:getDZBaseDataByStr(strGuid)
end

function UIDiscipleModel:getMyDiscipleData2(guid)
local data=UIDiscipleModel:getMyDiscipleData(guid)
if data then
return data.netData.net
end
return nil
end

function UIDiscipleModel:getMyDiscipleData2ByStr(strGuid)
local data=UIDiscipleModel:getMyDiscipleDataByStr(strGuid)
if data then
return data.netData.net
end
return nil
end



function UIDiscipleModel:getItemDiscipleDataByItemId(itemId,index)
local itemConfig=itemsConfig.getConfig(itemId)
local funcparam=itemConfig.funcparam
local itemType=funcparam.type
local diziId=nil
if itemType==item_funtion_type.disciple then

diziId=funcparam.discipleid

if not diziId then
logErr(FMT.fmt("道具 {0} 未配置弟子id",itemId))
return nil
end
elseif itemType==item_funtion_type.selectDisciple then

diziId=funcparam.list[index]

if not diziId then
logErr(FMT.fmt("道具 {0} 未配置对应索引为 {1} 所对应的弟子id",itemId,index))
return nil
end
end

local dzData=self:getDiscipleDataByDiziId(diziId)
if dzData then

dzData.srctype=itemId
end

return dzData
end


function UIDiscipleModel:getDiscipleDataByDiziId(diziId)
if itemDiscipleData[diziId]then
return itemDiscipleData[diziId]
end


local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziId)
if diziCfg then
local diziFixedData=table.weakCopy(diziCfg)
local tmpItemDiscipleData={}

tmpItemDiscipleData.id=diziId

tmpItemDiscipleData.srctype=0

tmpItemDiscipleData.disciplename=diziCfg.name or"未知名称"

tmpItemDiscipleData.imageInfo={}
if diziFixedData.imagelib then
tmpItemDiscipleData.hasFixedImage=true

tmpItemDiscipleData.imageInfo.hair=diziFixedData.imagelib[1]
tmpItemDiscipleData.imageInfo.face=diziFixedData.imagelib[2]
tmpItemDiscipleData.imageInfo.body=diziFixedData.imagelib[3]
tmpItemDiscipleData.imageInfo.accessory=diziFixedData.imagelib[4]
else
tmpItemDiscipleData.hasFixedImage=false
end

local maxWeightIndex=1
for i=1,#diziFixedData.color do
local mwColor=diziFixedData.color[maxWeightIndex]
if diziFixedData.color[i]>mwColor then
maxWeightIndex=i
end
end
tmpItemDiscipleData.imageInfo.color=maxWeightIndex


maxWeightIndex=1
for i=1,#diziFixedData.sex do
local mwSex=diziFixedData.sex[maxWeightIndex]
if diziFixedData.sex[i]>mwSex then
maxWeightIndex=i
end
end
tmpItemDiscipleData.imageInfo.sex=maxWeightIndex


maxWeightIndex=1
local race=diziFixedData.race[tmpItemDiscipleData.imageInfo.color]
for i=1,#race do
local mwRace=race[maxWeightIndex][2]
if race[i][2]>mwRace then
maxWeightIndex=i
end
end
tmpItemDiscipleData.imageInfo.race=race[maxWeightIndex][1]

tmpItemDiscipleData.imageInfo.job=diziFixedData.voclib


tmpItemDiscipleData.vocsgidx=diziFixedData.vocskilllib or 1


tmpItemDiscipleData.attrList=diziFixedData.attr6_show or diziFixedData.attr6

tmpItemDiscipleData.shouyuan=diziFixedData.shouyuan

tmpItemDiscipleData.stand=diziFixedData.stand

tmpItemDiscipleData.jingjielv=diziFixedData.jingjie or 0

tmpItemDiscipleData.liantilv=0


tmpItemDiscipleData.specialityList={}

if diziFixedData.spiritrootlib and next(diziFixedData.spiritrootlib)then
local speciality={}
speciality.specialitytype=1
speciality.specialityLst={}
for i=1,#diziFixedData.spiritrootlib do
local tmpTable={param_1=diziFixedData.spiritrootlib[i],param_2=0}
table.insert(speciality.specialityLst,tmpTable)
end
speciality.len=#speciality.specialityLst

table.insert(tmpItemDiscipleData.specialityList,speciality)
end

if diziFixedData.bodylib and next(diziFixedData.bodylib)then
local speciality={}
speciality.specialitytype=2
speciality.specialityLst={}
for i=1,#diziFixedData.bodylib do
local tmpTable={
param_1=diziFixedData.bodylib[i],
param_2=0,
param_3=0,
}
table.insert(speciality.specialityLst,tmpTable)
end
speciality.len=#speciality.specialityLst

table.insert(tmpItemDiscipleData.specialityList,speciality)
end

if diziFixedData.talentlib and next(diziFixedData.talentlib)then
local speciality={}
speciality.specialitytype=3
speciality.specialityLst={}
for i=1,#diziFixedData.talentlib do
local tmpTable={
param_1=diziFixedData.talentlib[i],
param_2=0,
param_3=0,
}
table.insert(speciality.specialityLst,tmpTable)
end
speciality.len=#speciality.specialityLst

table.insert(tmpItemDiscipleData.specialityList,speciality)
end

if diziFixedData.strangelib and next(diziFixedData.strangelib)then
local speciality={}
speciality.specialitytype=4
speciality.specialityLst={}
for i=1,#diziFixedData.strangelib do
local tmpTable={
param_1=diziFixedData.strangelib[i],
}
table.insert(speciality.specialityLst,tmpTable)
end
speciality.len=#speciality.specialityLst

table.insert(tmpItemDiscipleData.specialityList,speciality)
end
tmpItemDiscipleData.specialitylistlen=#tmpItemDiscipleData.specialityList


if diziFixedData.tianming and next(diziFixedData.tianming)then
tmpItemDiscipleData.tmlv=0
tmpItemDiscipleData.tmList=diziFixedData.tianming
tmpItemDiscipleData.tmlistlen=#tmpItemDiscipleData.tmList
else
tmpItemDiscipleData.tmlv=-1
tmpItemDiscipleData.tmlistlen=0
end


if diziFixedData.proskill and next(diziFixedData.proskill)then
tmpItemDiscipleData.proskillList={}
for i=1,#diziFixedData.proskill do
local tmpTable={
param_1=i,
param_2=diziFixedData.proskill[i],
param_3=0,
}
table.insert(tmpItemDiscipleData.proskillList,tmpTable)
end
tmpItemDiscipleData.proskilllistlen=#tmpItemDiscipleData.proskillList
end


tmpItemDiscipleData.gongfaidList={0,0}
if diziFixedData.gongfalib and next(diziFixedData.gongfalib)then
for i=1,#diziFixedData.gongfalib do
tmpItemDiscipleData.gongfaidList[i]=diziFixedData.gongfalib[i]
end
end

itemDiscipleData[diziId]=tmpItemDiscipleData
UIDiscipleController.changeDiscipleNetData(itemDiscipleData[diziId])
return itemDiscipleData[diziId]
else
logErr(FMT.fmt("未找到弟子id: {0} 的配置",diziId))
return nil
end
end

function UIDiscipleModel:getMyDiscipleData(guid)
return UIDiscipleModel:getMyDiscipleDataByStr(tostring(guid))
end

function UIDiscipleModel:getMyDiscipleDataByStr(strGuid)
if discipleNetData then
local d=discipleNetData[strGuid]
if d~=nil then return d end
end
return nil
end

function UIDiscipleModel:isZMDisciple(guid)
return UIDiscipleModel:isZMDiscipleByStr(tostring(guid))
end

function UIDiscipleModel:isZMDiscipleByStr(strGuid)
if discipleNetData then
local d=discipleNetData[strGuid]
return d~=nil
end
return nil
end

function UIDiscipleModel:getDiscipleDataTemp(guid)
local strGuid=tostring(guid)
if discipleNetDataTemp then
local d=discipleNetDataTemp[strGuid]
if d~=nil then return d end
end
return nil
end

function UIDiscipleModel:getDiscipleDataX(guid)
return UIDiscipleModel:getDiscipleDataXByStr(tostring(guid))
end

function UIDiscipleModel:getDiscipleDataXByStr(strGuid)
if discipleNetData then
local d=discipleNetData[strGuid]
if d~=nil then return d end
end
if discipleNetDataTemp then
local d=discipleNetDataTemp[strGuid]
if d~=nil then return d end
end
return nil
end



function UIDiscipleModel:getSortList(selectFunc,sortFunc)
local list={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local add=true
if selectFunc then
if not selectFunc(netData)then
add=false
end
end
if add then
_insert(list,netData)
end
end
end
if#list>0 then
if sortFunc then _sort(list,sortFunc)end
end
return list
end

function UIDiscipleModel:getDiscipleList()
return discipleNetData
end


function UIDiscipleModel:getRandomDiscipleData()
local data=nil
local c=UIDiscipleModel:checkDiscipleCount()
local r=0
if c>0 then
r=math.random(1,c)
end
if r>0 then
local idx=0
for k,v in pairs(discipleNetData)do
idx=idx+1
if idx==r then
data=v.netData.net
break
end
end
end
return data
end

function UIDiscipleModel:addDiscipleData(data)
local f=nil
UIDiscipleModel:init()

f=discipleNetData[data.discipleguidStr]
if f then
f.netData={net=data,init=true}
else
local d={}
d.netData={net=data,init=true,isnew=true,disType=dicipleType.eSystem}
d.disType=dicipleType.eSystem
discipleNetData[data.discipleguidStr]=d
discipleCount=discipleCount+1

discipleLookup:addLookup(d)
end
local id=data.id
if discipleIdCount[id]==nil then discipleIdCount[id]=0 end
discipleIdCount[id]=discipleIdCount[id]+1

UIDiscipleModel:initDiscipleAttrLookup(data.discipleguid)
UIDiscipleModel:refreshDiscipleZongMenPost(data.discipleguidStr,nil,data.pos)
UIDiscipleModel:setSkillLvPlusLookupDirty(data.discipleguid)
UIDiscipleModel:updateDZSpeTimePass(data)
return f~=nil
end

function UIDiscipleModel:removeDiscipleData(guid)
if discipleNetData then
local guid_str=tostring(guid)
if discipleNetData[guid_str]~=nil then
local data=discipleNetData[guid_str].netData.net
discipleNetData[guid_str]=nil
discipleCount=discipleCount-1
UIDiscipleModel:removeDZSpeTimePass(guid_str)
local id=data.id
if discipleIdCount[id]==nil then discipleIdCount[id]=0 end
discipleIdCount[id]=discipleIdCount[id]-1
if discipleIdCount[id]<0 then
discipleIdCount[id]=0
loggerUtil.logErrFMT('弟子数量减少至负数')
end
UIDiscipleModel:refreshDiscipleZongMenPost(guid_str,data.pos,nil)
return true
end
end
return false
end

function UIDiscipleModel:clearAllDZNewSign()
if discipleNetData then
for k,v in pairs(discipleNetData)do
v.netData.isnew=nil
end
end
end

function UIDiscipleModel:addDiscipleDataTemp(data)
if not UIDiscipleController:checkInit()then



return
end
if discipleNetDataTemp==nil then
discipleNetDataTemp={}
end
UIDiscipleController.changeDiscipleNetData(data)

local d={}
d.netData={net=data,init=true}
d.disType=dicipleType.eTemp
discipleNetDataTemp[data.discipleguidStr]=d

UIDiscipleModel:initDiscipleAttrLookup(data.discipleguid)

UIDiscipleModel:addDiZiCache(data)

UIDiscipleModel:addDaoYanDZ(d)
end

function UIDiscipleModel:addDiZiCache(data)
equipsModel.addNewDizi(data)
fabaoModel.addNewDizi(data)
UIFuLuFangModel:addFuBaoData(data)
daobingModel:addNewDizi(data)
ClothingModel:addNewDizi(data,true)
vocEquipModel:addNewDizi(data,true)
lingshouModel:addNewDizi(data)
end

function UIDiscipleModel:removeDiscipleDataTemp(guid)
if discipleNetDataTemp then
local guid_str=tostring(guid)
if discipleNetDataTemp[guid_str]~=nil then
discipleNetDataTemp[guid_str]=nil
equipsModel.deleDiziEquip(guid)
fabaoModel.deleDizi(guid)
daobingModel:deleDizi(guid)
vocEquipModel:deleDizi(guid)
UIFuLuFangModel:removeLookup(guid)
lingshouModel:deleDizi(guid)
return true
end
end
return false
end

function UIDiscipleModel:getDiscipleType(guid)
local netData=UIDiscipleModel:getDiscipleDataX(guid)
return netData.disType
end


function UIDiscipleModel:getDiscipleSrcTypeByData(netData)
return netData.srctype or discipleSrcType.eNone
end


function UIDiscipleModel:getDiscipleSrcType(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.srctype or discipleSrcType.eNone
end


function UIDiscipleModel:isPlotDiscipleByData(netData)
local srctype=UIDiscipleModel:getDiscipleSrcTypeByData(netData)
return discipleSrcType:isPlot(srctype)
end


function UIDiscipleModel:isPlotDisciple(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:isPlotDiscipleByData(netData)
end
function UIDiscipleModel:isItemDisciple(guid)
local srctype=UIDiscipleModel:getDiscipleSrcType(guid)
return discipleSrcType:isItem(srctype)
end

function UIDiscipleModel:getAllPlotDisciple()











return dataControl:getValue(DATA_TYPE.dzSrcInfo,SUB_DATA_TYPE.eDZSrc_2)or defaultT
end


function UIDiscipleModel:findSrcTypeDisciple(src)










local data=dataControl:getValue(DATA_TYPE.dzSrcInfo,SUB_DATA_TYPE.eDZSrc_1,src)
if data==nil then return end
local info=data[1]
if info then
return UIDiscipleModel:getDiscipleDataByStr(info.discipleguidStr)
end
end


function UIDiscipleModel:getSameSrcTypeDiscipleCount(src)












local data=dataControl:getValue(DATA_TYPE.dzSrcInfo,SUB_DATA_TYPE.eDZSrc_1,src)
return data and#data or 0
end


function UIDiscipleModel:getSameIdDiscipleCount(diziId)











local data=dataControl:getValue(DATA_TYPE.dzIdInfo,nil,diziId)
return data and#data or 0
end


function UIDiscipleModel:getSameIdDiscipleCountAndList(diziId)













local data=dataControl:getValue(DATA_TYPE.dzIdInfo,nil,diziId)or defaultT
local cnt=#data
return cnt,data
end


function UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziId)











local isSpDz=UIDiscipleModel:isSPDisciple(diziId)

local data=dataControl:getValue(DATA_TYPE.dzIdInfo,nil,diziId)or defaultT
local guidInfo=data[1]
if not guidInfo and isSpDz then

local dzCfg=cfgHelper.get1(cfg_discipleconfig_get,diziId)
if dzCfg and dzCfg.switch then
for _,dzId in ipairs(dzCfg.switch)do
data=dataControl:getValue(DATA_TYPE.dzIdInfo,nil,dzId)or defaultT
guidInfo=data[1]
if guidInfo then
break
end
end
end
end

if guidInfo then
return UIDiscipleModel:getDiscipleDataByStr(guidInfo.discipleguidStr)
end
end


function UIDiscipleModel:getPlotDiscipleByIndex(idx)

















if idx==nil or idx<=0 then return nil end
if discipleNetData then
local src=nil
local skey='ePlot'..idx
src=discipleSrcType[skey]
if src then
return UIDiscipleModel:findSrcTypeDisciple(src)
end
end
return nil
end


function UIDiscipleModel:getDiscipleID(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleIDEx(netData)
end
function UIDiscipleModel:getDiscipleIDEx(netData)
if netData then
return netData.id
end
return nil
end

function UIDiscipleModel:getDiscipleNameByData(netData)
return netData and netData.disciplename or nil
end


function UIDiscipleModel:getDiscipleName(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleNameByData(netData)
end

function UIDiscipleModel:isMyActorDZ(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData~=nil
end

function UIDiscipleModel:isMyDZHideDress(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
return netData.hidedress
end
end


function UIDiscipleModel:isSpecialDZ(guid)
local dzid=UIDiscipleModel:getDiscipleID(guid)
local data=cfgHelper.get1(cfg_discipleconfig_get,dzid)
if data==nil or data.flag==nil then return false end
local flag=data.flag
return bitHelper.check_pos(flag,0)
end





function UIDiscipleModel:isSpecialDZEx(guid,typo)
local dzid=UIDiscipleModel:getDiscipleID(guid)
local data=cfgHelper.get1(cfg_discipleconfig_get,dzid)
if data==nil or data.flag==nil then return false end
local flag=data.flag
return bitHelper.check_pos(flag,typo)
end


function UIDiscipleModel:isZhuanShuDZ(guid)
return UIDiscipleModel:isSpecialDZ(guid)and
not UIDiscipleModel:isPlotDisciple(guid)
end


function UIDiscipleModel:isLianDongChangDiscipleImage(guid)
local dzid=UIDiscipleModel:getDiscipleID(guid)
local data=cfgHelper.get1(cfg_discipleconfig_get,dzid)
if data==nil or data.flag==nil then return false end
local flag=data.flag
return bitHelper.check_pos(flag,discipleconfigFlag.forbidLianDongChange)
end

function UIDiscipleModel:getDiscipleColor(guid,switchidx)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData~=nil then
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid,switchidx)
return imageInfo.color
end
return nil
end

function UIDiscipleModel.getDiscipleColorDesc(color)
return cfgHelper.getglobal2('dzcolordesc',color)
end

function UIDiscipleModel.getDiscipleJJColor(jjVal)
local colorCfg=cfgHelper.get2(cfg_globalconfig_get,1,'jingjie_color')
for i,v in ipairs(colorCfg)do
if jjVal>=v[1]and jjVal<=v[2]then
return v[3]
end
end
return nil
end

function UIDiscipleModel:getDiscipleColorName(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData~=nil then
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local color=imageInfo.color
return helper.getQColorString(color,netData.disciplename)
end
return nil
end

function UIDiscipleModel:getDiscipleWinList()
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder)
return list or{}
end


function UIDiscipleModel:hasSpecialDiscipleLihuiByGuid(guid)
local diziId=UIDiscipleModel:getDiscipleID(guid)
if diziId~=nil then
local specialLihuiCfg=cfgHelper.get1(cfg_disciplespeciallihuiconfig_get,diziId)
if specialLihuiCfg then
return true
end
end

return false
end


function UIDiscipleModel:hasSpecialDiscipleLihuiByDiscipleId(diziId)
if diziId~=nil then
local specialLihuiCfg=cfgHelper.get1(cfg_disciplespeciallihuiconfig_get,diziId)
if specialLihuiCfg then
return true
end
end

return false
end


function UIDiscipleModel:getSpecialDiscipleLihuiCfgByGuid(guid)
local diziId=UIDiscipleModel:getDiscipleID(guid)
if diziId~=nil then
local specialLihuiCfg=cfgHelper.get1(cfg_disciplespeciallihuiconfig_get,diziId)
if specialLihuiCfg then
return specialLihuiCfg
end
end

return nil
end





function UIDiscipleModel:getDiscipleFightValue(guid)
if not UIDiscipleController:checkInit()then return 0 end
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData.calculationFight==nil or netData.calculationFightDirty then
UIDiscipleModel:calculationDiscipleFightValue(netData)

if initProControl.isDone()then
netData.calculationFightDirty=false
end
end
return netData.calculationFight or 0
end
function UIDiscipleModel:getDiscipleFightValueEx(netData)
if not UIDiscipleController:checkInit()then return 0 end
if netData.calculationFight==nil or netData.calculationFightDirty then
UIDiscipleModel:calculationDiscipleFightValue(netData)

if initProControl.isDone()then
netData.calculationFightDirty=false
end
end
return netData.calculationFight or 0
end
function UIDiscipleModel:calculationDiscipleFightValue(netData)
local attrlookup
if UIDiscipleModel:isMyActorDZ(netData.discipleguid)then
attrlookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(netData.discipleguid,true)
else
attrlookup=UIDiscipleModel:getDiscipleAttrListEx(netData,true)
end
netData.calculationFight=UIDiscipleModel.calculationFightValue(attrlookup)
end
function UIDiscipleModel:calculationDiscipleFightValueX(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
UIDiscipleModel:calculationDiscipleFightValue(netData)
end
function UIDiscipleModel.calculationFightValue(attrlookup)
local calculationFight=cfgHelper.getFight(attrlookup)
return calculationFight
end
function UIDiscipleModel.calculationFightValue2(atrrlist)
local attrlookup=UIDiscipleModel.getAttrListLookup(atrrlist)
return UIDiscipleModel.calculationFightValue(attrlookup)
end

function UIDiscipleModel:setDiscipleCalculationFightDirty(netData,attrType,showFightTips)
if not UIDiscipleController:checkInit()then
return
end
netData.calculationFightDirty=true
local lastVal=netData.calculationFight or 0
UIDiscipleModel:calculationDiscipleFightValue(netData)
local val=netData.calculationFight or 0
local isChanged=lastVal~=val
if isChanged then

UIDiscipleModel:resetFightDiscipleGuidList()




end
if isChanged and showFightTips then
notifySystem:postNotify(notifyConfig.onDiscipleFightChanged,netData.discipleguid,lastVal,val,attrType)
end
end
function UIDiscipleModel:setDiscipleCalculationFightDirty2(netData,attrTypes,showFightTips)
if not UIDiscipleController:checkInit()then
return
end
netData.calculationFightDirty=true
local lastVal=netData.calculationFight or 0
UIDiscipleModel:calculationDiscipleFightValue(netData)
local val=netData.calculationFight or 0
local isChanged=lastVal~=val
if isChanged then

UIDiscipleModel:resetFightDiscipleGuidList()




end
if isChanged and showFightTips then
if attrTypes then
for i,attrType in ipairs(attrTypes)do
notifySystem:postNotify(notifyConfig.onDiscipleFightChanged,netData.discipleguid,lastVal,val,attrType)
end
end
end
end

function UIDiscipleModel:getFight(discipleguid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
return netData and netData.calculationFight or 0
end


function UIDiscipleModel:getDiscipleInjury(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.injury
end

function UIDiscipleModel.getInjuryName(injury,fmat)
fmat=fmat or'%s'
local str=nil
local name=eInjuryType:getName(injury)or''
str=string.format(fmat,name)
return str
end
function UIDiscipleModel.getInjuryNameEx(injury,fmat)
fmat=fmat or'%s'
local str=nil
local injuryType=eInjuryType.getType(injury)
if injuryType~=nil and injuryType~=eInjuryType.eHealth then
local name=eInjuryType:getName(injury)
str=string.format(fmat,name)
end
return str or''
end

function UIDiscipleModel:getDiscipleInjuryName(guid,fmat)
local netData=self:getDiscipleData(guid)
local injury=netData.injury
return self.getInjuryName(injury,fmat)
end
function UIDiscipleModel:getDiscipleInjuryNameEx(guid,fmat)
local netData=self:getDiscipleData(guid)
local injury=netData.injury
return self.getInjuryNameEx(injury,fmat)
end
function UIDiscipleModel:getInjuryType(guid)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
return eInjuryType.getType(injury)
end
function UIDiscipleModel:checkInjuryType(guid,injuryType)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local cur=eInjuryType.getType(injury)
return cur==injuryType
end

function UIDiscipleModel:getDiscipleLoyalty(guid)
local netData=self:getDiscipleData(guid)
return netData.loyalty
end

function UIDiscipleModel:checkLowLoyaltyByData(netData)
if self.loyaltyWork==nil then
local low=cfgHelper.get2(cfg_discipleloyaltyconfig_get,1,'work')
self.loyaltyWork=low
end
return netData.loyalty<=self.loyaltyWork
end

function UIDiscipleModel:checkLowLoyalty(guid)
local netData=self:getDiscipleData(guid)
return UIDiscipleModel:checkLowLoyaltyByData(netData)
end


function UIDiscipleModel:getDiscipleJobByData(netData,switchidx)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData,switchidx)
if imageInfo then
return imageInfo.job
end
end


function UIDiscipleModel:getDiscipleJob(guid,switchidx)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleJobByData(netData,switchidx)
end


function UIDiscipleModel:isMeleeAttack(guid)
local job=self:getDiscipleJob(guid)
local firstPos=cfgHelper.get3(cfg_disciplevocationconfig_get,job,"pospriorty",1)
return firstPos<3
end


function UIDiscipleModel:isRangedAttack(guid)
local job=self:getDiscipleJob(guid)
local firstPos=cfgHelper.get3(cfg_disciplevocationconfig_get,job,"pospriorty",1)
return firstPos>=3
end

function UIDiscipleModel:getDiscipleSexByData(netData)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
if imageInfo then
return imageInfo.sex
end
end

function UIDiscipleModel:getDiscipleSex(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleSexByData(netData)
end

function UIDiscipleModel:getDiscipleUseSex(guid)
local id=UIDiscipleModel:getDiscipleID(guid)
local useSex=cfgHelper.get2(cfg_discipleconfig_get,id,'useSex')
return useSex or UIDiscipleModel:getDiscipleSex(guid)
end



function UIDiscipleModel:getDiscipleShowWeaponID(guid,checkChange,switchidx)
local equipItem
if self:isMyActorDZ(guid)then
equipItem=daobingModel:getEquipByDizi(guid,switchidx)or
equipsModel.getEquipByDizi(guid,EQUIP_TYPE.eWeapon,switchidx)
else
equipItem=otherPlayerModel:getDZEquipData(guid,EQUIP_TYPE.eDaoBing)or
otherPlayerModel:getDZEquipData(guid,EQUIP_TYPE.eWeapon)
end
if equipItem then
local itemid=equipItem.itemid or 0
if itemid>0 then

if checkChange==true then
local equipCfg=itemsConfig.getConfig(itemid)
local weaponTypeCfg=cfgHelper.get1(cfg_discipleweaponconfig_get,equipCfg.type2)
if weaponTypeCfg and weaponTypeCfg.group then
local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(guid))
local groupid=dzSpecialityGrowEffectController:getReplaceWeaponLookup(netData)
if groupid>0 then
local itemid_=weaponTypeCfg.group[groupid]
if itemid_ then
itemid=itemid_
end
end
end
end
end
return itemid
end
return 0
end



function UIDiscipleModel:getDiscipleWeaponID(guid,checkChange)
local equipItem
if self:isMyActorDZ(guid)then
equipItem=equipsModel.getEquipByDizi(guid,EQUIP_TYPE.eWeapon)
else
equipItem=otherPlayerModel:getDZEquipData(guid,EQUIP_TYPE.eWeapon)
end
if equipItem then
local itemid=equipItem.itemid or 0
if itemid>0 then

if checkChange==true then
local equipCfg=itemsConfig.getConfig(itemid)
local weaponTypeCfg=cfgHelper.get1(cfg_discipleweaponconfig_get,equipCfg.type2)
if weaponTypeCfg and weaponTypeCfg.group then
local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(guid))
local groupid=dzSpecialityGrowEffectController:getReplaceWeaponLookup(netData)
if groupid>0 then
local itemid_=weaponTypeCfg.group[groupid]
if itemid_ then
itemid=itemid_
end
end
end
end
end
return itemid
end
return 0
end



function UIDiscipleModel:getDiscipleWeaponIDByDzData(dzData,checkChange)
local equipItem=dzData.equipLookup and dzData.equipLookup[EQUIP_TYPE.eDaoBing]or
dzData.equipLookup and dzData.equipLookup[EQUIP_TYPE.eWeapon]or nil
if equipItem then
local itemid=equipItem.itemid or 0
if itemid>0 then

if checkChange==true then
local equipCfg=itemsConfig.getConfig(itemid)
local weaponTypeCfg=cfgHelper.get1(cfg_discipleweaponconfig_get,equipCfg.type2)
if weaponTypeCfg and weaponTypeCfg.group then
local groupid=dzSpecialityGrowEffectController:getReplaceWeaponLookup(dzData)
if groupid>0 then
local itemid_=weaponTypeCfg.group[groupid]
if itemid_ then
itemid=itemid_
end
end
end
end
end
return itemid
end
return 0
end



function UIDiscipleModel:getDiscipleShouYuan(guid,needSort)
local netData=UIDiscipleModel:getDiscipleData(guid)
local n=netData:getShouYuan()
if needSort==true and n==-1 then
return 10000000000
else
return UIDiscipleModel.getDiscipleShouYuanFloor(n)
end
end
function UIDiscipleModel.getDiscipleShouYuanFloor(shouyuan)
return math.floor(shouyuan)
end
function UIDiscipleModel.getDiscipleShouYuanCeil(shouyuan)
return math.ceil(shouyuan)
end
function UIDiscipleModel:getDiscipleShouYuanDesc(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleShouYuanDescEx(netData)
end
function UIDiscipleModel:getDiscipleShouYuanDescEx(netData)
if netData:getShouYuan()~=nil then
local shouyuan=UIDiscipleModel.getDiscipleShouYuanCeil(netData:getShouYuan())
return UIDiscipleModel:getDiscipleShouYuanDescX(shouyuan)
else
return'未知'
end
end
function UIDiscipleModel:getDiscipleShouYuanDescX(shouyuan)
if shouyuan==-1 then
return'无限'
else
return tostring(shouyuan)
end
end

function UIDiscipleModel:getDiscipleAge(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.age+gameUtilityModel.getGameYearPass2(netData.addtm)
end

function UIDiscipleModel:getDiscipleBagList(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.disciplebagList or{}
end

function UIDiscipleModel:getDiscipleBagShowList(guid)
local list=self:getDiscipleBagList(guid)

local show={}
for i,v in ipairs(list)do
for j=1,v.param_1 do
table.insert(show,v.param_2)
end
end
_sort(show,itemsSortHelper.sortItemsArrayByColor)
return show
end

function UIDiscipleModel:getDiscipleBagLength(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.disciplebag_len or 0
end

function UIDiscipleModel:getDiscipleBagCount(guid)
local list=self:getDiscipleBagList(guid)
local count=0
for i,v in ipairs(list)do
count=count+v.param_1
end
return count
end

function UIDiscipleModel:checkDiscipleSatietyFull(netData)
local jjlv=netData.jingjielv
local max1,max2=UIDiscipleModel:getDZMaxSatiety(netData)
local curSatiety=netData.jingjiesatiety
return tonumber(tostring(curSatiety))>=max2
end

function UIDiscipleModel:getDZMaxSatiety(netData)
local jjlv=netData.jingjielv
local max1=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'satiety')
local max2=max1
local rate=gubaoModel:getGBSkil_AddSatiety()/100
local add=math.floor(max1*rate)
max2=max2+add
return max1,max2,add
end







function UIDiscipleModel:getDiscipleJobLevel(guid,jobType)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleJobLevelEx(netData,jobType)
end
function UIDiscipleModel:getDiscipleJobLevelEx(netData,jobType)
local skill=netData.proskillList[jobType]
return skill and skill.level or 0
end

function UIDiscipleModel:getDiscipleJobLevelDesc(jobType,val,fmt_str)
fmt_str=fmt_str or'{0}:{1}'
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'name')
return FMT.fmt(fmt_str,name,val)
end

function UIDiscipleModel:getDiscipleJobName(jobType)
return cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'name')
end

function UIDiscipleModel:getDiscipleJobExp(guid,jobType)
local netData=UIDiscipleModel:getDiscipleData(guid)
local skill=netData.proskillList[jobType]
return skill and skill.exp or 0
end

function UIDiscipleModel:getDiscipleJobData(guid,jobType)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleJobDataEx(netData,jobType)
end

function UIDiscipleModel:getDiscipleJobDataEx(netData,jobType)
return netData.proskillList[jobType]
end


function UIDiscipleModel:getDiscipleProskillRate(guid,jobType,excludeBaseRate)
local rate=0
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData~=nil then
local baserate=0
if not excludeBaseRate then
baserate=UIDiscipleModel:getDiscipleBaseAttrExListXX(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui,1)
end
local effectrate=dzSpecialityGrowEffectController:getProskillExpRateLookup(netData,jobType,2)
local fubaorate=UIFuLuFangModel:getFuBaoEffect(guid,FUBAO_EFFECT_TYPE.eProfessionExp,jobType)
local zonmenbuff=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eZhuanyeExpChanged)or{}
local zongmenrate=zonmenbuff[jobType]or 0
local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eProfessionExp,jobType)
local gubaorate=gubaoModel:getGBSkil_ProskillExpRate(jobType,2)

local addxcValLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eLittleWorldAttrLimit)
local xCVal=addxcValLookup[jobType]or 0

rate=baserate+effectrate+fubaorate+zongmenrate+buildingBuffRate+gubaorate+xCVal/100
else
UIDiscipleModel.logNotDiZiError(guid)
end
return rate
end

function UIDiscipleModel.logNotDiZiError(guid)
logErr(FMT.fmt('弟子{0}已不在弟子列表中，使用前请先检测弟子是否存在！',tostring(guid)))
end






function UIDiscipleModel:getDiscipleJobSkillList(guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local groupid=netData.vocsgidx
return UIDiscipleModel:getDiscipleJobSkillListEx(groupid,imageInfo.job,netData.jingjielv,netData)
end

function UIDiscipleModel:getDiscipleJobSkillList2(guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local groupid=netData.vocsgidx
return UIDiscipleModel:getDiscipleJobSkillListEx2(groupid,imageInfo.job,netData.jingjielv,netData)
end

function UIDiscipleModel:getDiscipleJobSkillListEx(groupid,jobid,jjlv,netData)
local result={}
local skills=cfgHelper.get3(cfg_disciplevocationconfig_get,jobid,'skills',groupid)
for idx,skillId in ipairs(skills)do
local lv=discipleLookup:getJobSkilLevelByJJLevel(skillId,jjlv)
local c_skillId=skillId
if netData~=nil then
if lv and lv>0 then
lv=UIDiscipleModel:getSkillLv(netData.discipleguid,skillId,lv)
end
c_skillId=UIDiscipleModel:getSkillReplace(netData,skillId,jobid)
end
result[#result+1]={c_skillId,lv}
end
return result
end

function UIDiscipleModel:getDiscipleJobSkillListEx2(groupid,jobid,jjlv,netData)
local result={}
local skills=cfgHelper.get3(cfg_disciplevocationconfig_get,jobid,'skills',groupid)
for idx,skillId in ipairs(skills)do
local lv=discipleLookup:getJobSkilLevelByJJLevel(skillId,jjlv)or 0
local c_skillId=skillId
if netData~=nil then
c_skillId=UIDiscipleModel:getSkillReplace(netData,skillId,jobid)
end
result[#result+1]={c_skillId,lv}
end
return result
end

function UIDiscipleModel:getDiscipleJobSkilIDlList(netData)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local groupid=netData.vocsgidx
local skills=cfgHelper.get3(cfg_disciplevocationconfig_get,imageInfo.job,'skills',groupid)
return skills
end










function UIDiscipleModel:getJobName(jobid)
return cfgHelper.get2(cfg_disciplevocationconfig_get,jobid,'name')
end
function UIDiscipleModel:getJobNameX(guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
return UIDiscipleModel:getJobName(imageInfo.job)
end
function UIDiscipleModel:discipleBaseAttrName(attrType)
return cfgHelper.getglobal3('discipleattr',attrType,'name')
end
function UIDiscipleModel:getJobIconName(jobid)
return cfgHelper.get2(cfg_disciplevocationconfig_get,jobid,'icon')
end
function UIDiscipleModel:getJobIconNameX(guid,switchidx)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid,switchidx)
return UIDiscipleModel:getJobIconName(imageInfo.job)
end
function UIDiscipleModel:getJobIconName2(jobid)
return cfgHelper.get2(cfg_disciplevocationconfig_get,jobid,'icon2')
end
function UIDiscipleModel:getJobIconName2X(guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
return UIDiscipleModel:getJobIconName2(imageInfo.job)
end

function UIDiscipleModel:getJobOrientation(jobid,dzID)
local cfg=cfgHelper.get1(cfg_disciplevocationconfig_get,jobid)
local o
if dzID~=nil and cfg.spe_orientation~=nil then
o=cfg.spe_orientation[dzID]
end
if o==nil then
o=cfg.orientation
end
return o
end

function UIDiscipleModel:getJobOrientationName(jobid,dzID)
local orientation=UIDiscipleModel:getJobOrientation(jobid,dzID)
return cfgHelper.get2(cfg_disciplevocationorientationconfig_get,orientation,'name')
end

function UIDiscipleModel:getJobOrientationIcon(jobid,dzID)
local orientation=UIDiscipleModel:getJobOrientation(jobid,dzID)
local icon=cfgHelper.get2(cfg_disciplevocationorientationconfig_get,orientation,'icon')
local abName=globalABLookup.diziorientationicons
return abName,icon
end

function UIDiscipleModel:getJobOrientationBigIcon(jobid,dzID)
local orientation=UIDiscipleModel:getJobOrientation(jobid,dzID)
local icon=cfgHelper.get2(cfg_disciplevocationorientationconfig_get,orientation,'bigicon')
local abName=globalABLookup.diziorientationicons
return abName,icon
end


function UIDiscipleModel.getJobPosPriorty(jobid)
return cfgHelper.get2(cfg_disciplevocationconfig_get,jobid,'pospriorty')
end

function UIDiscipleModel:getJobStandStr(jobid,dzID)
local jobcfg=cfgHelper.get1(cfg_disciplevocationconfig_get,jobid)
local stand_str=jobcfg.stand_str[dzID]or jobcfg.stand_str[0]
return stand_str
end

function UIDiscipleModel:getJobDesc(jobid,dzID)
local jobcfg=cfgHelper.get1(cfg_disciplevocationconfig_get,jobid)
local desc=jobcfg.desc[dzID]or jobcfg.desc[0]
return desc
end





function UIDiscipleModel:checkReddot(guid)
return UIDiscipleModel:checkJJReddot(guid)or UIDiscipleModel:checkLTReddot(guid)
end

function UIDiscipleModel:setSaveSortType(idx)
onlineDataSetting:setData(onlineDataKeyType.eDiscipleSelectSortType,idx)
end
function UIDiscipleModel:getSaveSortType()
return onlineDataSetting:getData(onlineDataKeyType.eDiscipleSelectSortType,eDiscipleSortType.eFightSort)
end
function UIDiscipleModel:setSaveSortCondition(sortCondition)
local saveSortCondition={}
for k,v in pairs(sortCondition)do
saveSortCondition[tostring(k)]=v
end
onlineDataSetting:setData(onlineDataKeyType.eDiscipleSelectSortCond,saveSortCondition)
end
function UIDiscipleModel:getSaveSortCondition()
local temp=onlineDataSetting:getData(onlineDataKeyType.eDiscipleSelectSortCond,{})
local temp_=table.deepCopy(temp)
local saveSortCondition={}
for k,v in pairs(temp_)do
saveSortCondition[tonumber(k)]=v
end
return saveSortCondition
end

function UIDiscipleModel.getSearchName(guid_str,name,state_str)
local py=_LuaHelper.ToPinYin(name)
local str=FMT.fmt('{0}_{1}',name,py)
if state_str then
str=FMT.fmt('{0}_{1}',str,state_str)
end



return str
end

function UIDiscipleModel:getAllShouYuanChuiWeiDZ()
local list={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
if UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eShouYuanChuiWei)then
list[#list+1]=v
end
end
end
return list
end

function UIDiscipleModel:getAllInjuryChuiWeiDZ()
local list={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
if UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eInjuryChuiWei)then
list[#list+1]=v
end
end
end
return list
end

function UIDiscipleModel:getAllInjuryFushangDZ(dzguid)
local list={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local dzId=v.netData.net.discipleguid
local injury=UIDiscipleModel:getDiscipleInjury(dzId)
local injuryType=eInjuryType.getType(injury)
if injuryType>eInjuryType.eHealth or dzguid==dzId then
list[#list+1]=v
end
end
end
return list
end

function UIDiscipleModel:getDiscipleColorFrameName(netData,color)
if color==nil then
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
color=imageInfo.color
end
local isOpen=UIDiscipleModel:checkOponTianMing(netData)
local floor
if isOpen then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
else
floor=0
end
local iconname=cfgHelper.get3(cfg_discipletianmingfloorconfig_get,floor,'colorframe',color)
local abname=globalABLookup.diciplecolorframe
return abname,iconname
end


function UIDiscipleModel:getDiscipleByFightIndex(fightIndex)
if fightIndex==nil or fightIndex<=0 then return nil end
local list=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,nil,nil)
local c=#list
if c>0 then
local temp=list[fightIndex]
if temp==nil then
temp=list[1]
end
return temp.netData.net
end
return nil
end


function UIDiscipleModel:getDiscipleCount_FaBaoColor(color)
color=color or 0
local num=0
for _,color_ in pairs(eQualityColor)do
if color_>=color then
local num1=dataControl:getValue(DATA_TYPE.dzFBCount,SUB_DATA_TYPE.eDZFaBao_Color,color_)or 0
num=num+num1
end
end
return num
end


function UIDiscipleModel:getDiscipleCount_Jingjie()
local countList={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local jingjielv=netData.jingjielv
countList[jingjielv]=(countList[jingjielv]or 0)+1
end
end
return countList
end

function UIDiscipleModel:checkHasDiZi_jingjie(jjlv)
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
if netData.jingjielv>=jjlv then
return true
end
end
end
return false
end



function UIDiscipleModel:getDiscipleList_equipType(equipType)
local list={}
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local equip=equipsHelper.getEquipByDizi(netData.discipleguid,equipType)
if equip~=nil then
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
if equipType==EQUIP_TYPE.eFabao then
if fabaoHelper.isCanShowJilian(equip.itemguid)then
local lv=fabaoModel.getFabaoJilianLevel(equip.itemguid)
table.insert(list,{netData,lv,itemConfig.stage,itemConfig.color})
end
else
if equipsHelper.isCanShowJinglian(equip.itemguid)then
local lv=equipsModel.getEquipJinglianLevel(equip)
table.insert(list,{netData,lv,itemConfig.stage,itemConfig.color})
end
end
end
end
end
if#list>0 then
_sort(list,function(a,b)
if a[2]==b[2]then
if a[3]==b[3]then
return a[4]>b[4]
else
return a[3]>b[3]
end
else
return a[2]>b[2]
end
end)
end
return list
end































function UIDiscipleModel:setDiscipleTMResetList(discipleguid,len,array,flag)
local guisStr=tostring(discipleguid)
discipleTMResetList[guisStr]=array







end

function UIDiscipleModel:getDiscipleTMResetList(discipleguid)
local guisStr=tostring(discipleguid)
if discipleTMResetList then
return discipleTMResetList[guisStr]
end
end

function UIDiscipleModel:setIsUseRandtmList(flag)
isUseRandtmList=flag
end

function UIDiscipleModel:getIsUseRandtmList()
return isUseRandtmList
end


function UIDiscipleModel:fightValueConversion(fight)
return mathHelper.formatNumber7(fight,1,2)
end





function UIDiscipleModel:isDisSuitSame(dzguid)
local curSuitID
local _equipSlotIndex={[EQUIP_TYPE.eWeapon]=0,[EQUIP_TYPE.eClothes]=1,[EQUIP_TYPE.eCap]=2,[EQUIP_TYPE.eShoot]=3,}

for equipType,idx in ipairs(_equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(dzguid,equipType)
if equip then
local suitid=equip.itemData.suitid
if not curSuitID then curSuitID=suitid end
if curSuitID~=suitid then return 0 end
else
return 0
end
end

return 1
end


function UIDiscipleModel:changeDiscipleimageVoc(discipleguid,disguise,discipleimage)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
netData.discipleimage=discipleimage
netData.disguise=disguise

UIDiscipleModel.calculationDiscipleImageBase(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)
equipsControl.freshWindow('showModel')
equipsControl.freshWindow('onChangeClothing',discipleguid)


UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshBotton")
UIManager:callWindowFunc("UIDiscipleMainWin","refreshDiscipleList")
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")
if mainControl:isInScene(eSceneType.eZongmen)then
discipleStateManager:refreshDiscipleModel(discipleguid)
end
if MysteryModel:is_in_mystery()then
mysteryPlayerController.setPlayerModel()
end
UIDiscipleModel:setSkillLvPlusLookupDirty(netData.discipleguid,false)
UIManager.info('切换成功')
UIManager:closeWindow('UIGuanLianWin')

local nowTime=timeHelper.getServerLongTime()+300
local key=FMT.fmt('changeDiscipleimageVoc_{0}',tostring(discipleguid))
userActorSetting.set(key,nowTime)
userActorSetting.flush()
end
end


function UIDiscipleModel:IsChangeImageByDiZiId(discipleguid)
local isldchang=UIDiscipleModel:isLianDongChangDiscipleImage(discipleguid)
if isldchang then
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local dzID=UIDiscipleModel:getDiscipleIDEx(netData)
local disguise=netData.disguise
if disguise==0 or disguise==dzID then

return false
else
return true
end
end
return false
end

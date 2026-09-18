




eventTextConfig={}

local _remove=table.remove

eventTextConfig.effectFunc=
{

[EVENT_EFFECT_TYPE.eDiziAddJingjieExp]=function(...)
return eventTextConfig.onAddJingjieExp(...)
end,

[EVENT_EFFECT_TYPE.eDiziAddJingjieExp_Precent]=function(...)
return eventTextConfig.onAddJingjieExpPrecent(...)
end,


[EVENT_EFFECT_TYPE.eDiziAddLiantiExp]=function(...)
return eventTextConfig.onAddDiziLiantiExp(...)
end,


[EVENT_EFFECT_TYPE.eDiziAddLiantiExp_Precent]=function(...)
return eventTextConfig.onAddDiziLiantiExpPrecent(...)
end,


[EVENT_EFFECT_TYPE.eDiziAddZhuanyeSkillExp_Precent]=function(...)
return eventTextConfig.onAddDiziProfessionExp(...)
end,


[EVENT_EFFECT_TYPE.eDiziAddZhuanyeSkillExp]=function(...)
return eventTextConfig.onAddDiziProfessionExp(...)
end,


[EVENT_EFFECT_TYPE.eAddPlantExtraPrize_Precent]=function(...)
return eventTextConfig.onDiziPrecentCommon(...)
end,


[EVENT_EFFECT_TYPE.eAddPlantExtraPrize]=function(...)
return eventTextConfig.onAddDiziPlantItem(...)
end,


[EVENT_EFFECT_TYPE.eDiziGetTezhi]=function(...)
return eventTextConfig.onDiziTezhi(...)
end,


[EVENT_EFFECT_TYPE.eDiziRemoveTezhi]=function(...)
eventTextConfig.onDiziTezhi(...)
end,


[EVENT_EFFECT_TYPE.eDiziDujie_Precent]=function(...)
eventTextConfig.onDiziDujiePrecent(...)
end,

[EVENT_EFFECT_TYPE.eDizGongfaExp]=function(...)
eventTextConfig.onDiziGongfa(...)
end,

[EVENT_EFFECT_TYPE.eDizGongfaExp_Precent]=function(...)
eventTextConfig.onDiziGongfaPrecent(...)
end,


[EVENT_EFFECT_TYPE.eDiziFushang]=function(...)
eventTextConfig.onDiziFushang(...)
end,


[EVENT_EFFECT_TYPE.eDiziChangeAttr6]=function(...)
eventTextConfig.onDiziAttr6Changed(...)
end,

[EVENT_EFFECT_TYPE.eFriendRelationValueChanged]=function(...)
eventTextConfig.onFriendRelationValueChanged(...)
end,


[EVENT_EFFECT_TYPE.eFriendRelationExValueChanged]=function(...)
eventTextConfig.onFriendRelationValueChanged(...)
end,


[EVENT_EFFECT_TYPE.eAddZongmenExp]=function(...)
eventTextConfig.onZongmenExpChanged(...)
end,


[EVENT_EFFECT_TYPE.eZongmenZhenXieChanged]=function(...)
eventTextConfig.onZongmenZhenXieChanged(...)
end,


[EVENT_EFFECT_TYPE.eGetPrize]=function(...)
eventTextConfig.onGetPrize(...)
end,


[EVENT_EFFECT_TYPE.eDZBagGetItem]=function(...)
eventTextConfig.onDZBagGetItem(...)
end,


[EVENT_EFFECT_TYPE.eDZBagMissItem]=function(...)
eventTextConfig.onDZBagMissItem(...)
end,


[EVENT_EFFECT_TYPE.eLittleWorldStability]=function(...)
eventTextConfig.onLittleWorldStabilityChanged(...)
end,


[EVENT_EFFECT_TYPE.eLittleWorldPopulation]=function(...)
eventTextConfig.onLittleWorldStabilityChanged(...)
end

}









function eventTextConfig.onAddJingjieExp(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end


function eventTextConfig.onAddJingjieExpPrecent(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end

eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end

function eventTextConfig.onAddDiziLiantiExp(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end


function eventTextConfig.onAddDiziLiantiExpPrecent(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end

eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end


function eventTextConfig.onAddDiziProfessionExp(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end


function eventTextConfig.onDiziPrecentCommon(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end



function eventTextConfig.onAddDiziPlantItem(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
local list=eventServerDataModel.getData(eventguid)
local itemNum=math.abs(_remove(list,1))
if itemNum==nil or itemNum<=0 then return false end
local dataNum=itemNum*2
if not eventTextConfig.checkErr(eventguid,dataNum,effect,list)then
return false
end
local name=''
for i=1,itemNum do
local itemid=math.abs(_remove(list,1))
local num=math.abs(_remove(list,1))
eventServerDataModel.addItem(eventguid,itemid,num)
local itemConf=itemsConfig.getConfig(itemid)or{}
local itemName=itemConf.name or''
local str=num>1 and FMT.fmt('{0}x{1}',itemName,num)or itemName
str=FMT.cfmt(itemConf.color,str)
name=i==1 and FMT.fmt('{0}',str)
or FMT.fmt('{0}、{1}',name,str)
end

local itemidx=replaceArgs.item or 0
itemidx=itemidx+1

replaceArgs.item=itemidx

eventActionControl.setReplace(FMT.fmt('item{0}',itemidx),name)
end


function eventTextConfig.onDiziTezhi(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end

local list=eventServerDataModel.getData(eventguid)
if not eventTextConfig.checkErr(eventguid,2,effect,list)then
return false
end
local tezhiType=math.abs(_remove(list,1))
local tezhiid=math.abs(_remove(list,1))
local tezhiname=UIDiscipleModel:getSpecialityName(tezhiType,tezhiid)

local tezhiidx=replaceArgs.tezhi or 0
tezhiidx=tezhiidx+1
replaceArgs.tezhi=tezhiidx

local tezhiStr=FMT.fmt('tezhi{0}',tezhiidx)
eventActionControl.setReplace(tezhiStr,tezhiname)
end

function eventTextConfig.onDiziDujiePrecent(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
outParmas[#outParmas+1]=FMT.fmt('{0}',math.abs(effect[2]))
end

function eventTextConfig.onDiziGongfa(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
local list=eventServerDataModel.getData(eventguid)
if not eventTextConfig.checkErr(eventguid,2,effect,list)then
return false
end

local gfid=math.abs(_remove(list,1))
local val=math.abs(_remove(list,1))
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfid,'name')

local gfnameidx=replaceArgs.gfname or 0
gfnameidx=gfnameidx+1
replaceArgs.gfname=gfnameidx

local numidx=replaceArgs.num or 0
numidx=numidx+1
replaceArgs.num=numidx

eventActionControl.setReplace(FMT.fmt('gfname{0}',gfnameidx),gfname)

local numStr=FMT.fmt('num{0}',numidx)
eventActionControl.setReplace(numStr,val)
end

function eventTextConfig.onDiziGongfaPrecent(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
local list=eventServerDataModel.getData(eventguid)
if not eventTextConfig.checkErr(eventguid,2,effect,list)then
return false
end

local gfid=math.abs(_remove(list,1))
local val=math.abs(_remove(list,1))
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfid,'name')

local gfnameidx=replaceArgs.gfname or 0
gfnameidx=gfnameidx+1
replaceArgs.gfname=gfnameidx

local numidx=replaceArgs.num or 0
numidx=numidx+1
replaceArgs.num=numidx

eventActionControl.setReplace(FMT.fmt('gfname{0}',gfnameidx),gfname)

local numStr=FMT.fmt('num{0}',numidx)
eventActionControl.setReplace(numStr,val)
end

function eventTextConfig.onDiziFushang(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end

function eventTextConfig.onDiziAttr6Changed(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
local list=eventServerDataModel.getData(eventguid)
if not eventTextConfig.checkErr(eventguid,1,effect,list)then
return false
end
local val=math.abs(_remove(list,1))

local numidx=replaceArgs.num or 0
numidx=numidx+1
replaceArgs.num=numidx

eventActionControl.setReplace(FMT.fmt('num{0}',numidx),val)

local attrType=effect[2]
outParmas[#outParmas+1]=helper.getAttributeName(attrType)
end

function eventTextConfig.onFriendRelationValueChanged(eventguid,textData,effect,outParmas,content,replaceArgs)
local dizi=textData.dizi1
local diziguid=dizi.diziguid
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil then return false end
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end

function eventTextConfig.onZongmenExpChanged(eventguid,textData,effect,outParmas,content,replaceArgs)
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end

function eventTextConfig.onZongmenZhenXieChanged(eventguid,textData,effect,outParmas,content,replaceArgs)
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end

function eventTextConfig.onGetPrize(eventguid,textData,effect,outParmas,content,replaceArgs)
local list=eventServerDataModel.getData(eventguid)
if not list then return false end
local itemNum=math.abs(_remove(list,1))
if itemNum==nil or itemNum<=0 then return false end
local dataNum=itemNum*2
if not eventTextConfig.checkErr(eventguid,dataNum,effect,list)then
return false
end
local name=''
for i=1,itemNum do
local itemid=math.abs(_remove(list,1))
local num=math.abs(_remove(list,1))
eventServerDataModel.addItem(eventguid,itemid,num)
local itemConf=itemsConfig.getConfig(itemid)or{}
local itemName=itemConf.name or''
local str=num>1 and FMT.fmt('{0}x{1}',itemName,num)or itemName
str=FMT.cfmt(itemConf.color,str)
name=i==1 and FMT.fmt('{0}',str)
or FMT.fmt('{0}、{1}',name,str)
end

local itemidx=replaceArgs.item or 0
itemidx=itemidx+1

replaceArgs.item=itemidx

eventActionControl.setReplace(FMT.fmt('item{0}',itemidx),name)
end

function eventTextConfig.onDZBagGetItem(eventguid,textData,effect,outParmas,content,replaceArgs)
eventTextConfig.onGetPrize(eventguid,textData,effect,outParmas,content,replaceArgs)
end

function eventTextConfig.onDZBagMissItem(eventguid,textData,effect,outParmas,content,replaceArgs)
eventTextConfig.onGetPrize(eventguid,textData,effect,outParmas,content,replaceArgs)
end

function eventTextConfig.onLittleWorldStabilityChanged(eventguid,textData,effect,outParmas,content,replaceArgs)
eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
end

function eventTextConfig.checkErr(eventguid,needLen,effect,list)
if needLen>0 and(list==nil or needLen>#list)then
loggerUtil.logWarnFMT('事件效果{0}文本需要{1}个服务器数据，无法找到！',effect[1],needLen)
eventServerDataModel.clearData(eventguid)
return false
end
return true
end


function eventTextConfig.onOneNumData(eventguid,effect,replaceArgs)
local list=eventServerDataModel.getData(eventguid)
if not eventTextConfig.checkErr(eventguid,1,effect,list)then
return false
end
local val=math.abs(_remove(list,1))

local numidx=replaceArgs.num or 0
numidx=numidx+1
replaceArgs.num=numidx
local valStr=mathHelper.formatNumber2(val)

eventActionControl.setReplace(FMT.fmt('num{0}',numidx),valStr)
end

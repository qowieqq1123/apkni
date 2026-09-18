systemZongMenResultStep={

eIllustration=1,
eChange=2,
}

systemZongMenResultType={
eSuccess=0,
eExcape=1,
eExpel=2,
eCapture=3,
}

systemZongMenResultTypeName={
[systemZongMenResultType.eSuccess]="成功",
[systemZongMenResultType.eExcape]="失败",
[systemZongMenResultType.eExpel]="驱逐",
[systemZongMenResultType.eCapture]="被捕",
}

local _steps={
[systemZongMenFuncType.eZaoYao]=
{
[systemZongMenResultType.eSuccess]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration2(data)end},
{winName="UISystemZongMenZYSucessWin",winParam=function(data)return systemZongMenModel:funcZaoYaoSuccess(data)end},
},
[systemZongMenResultType.eExcape]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration1(data)end},
},
[systemZongMenResultType.eExpel]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration1(data)end},
{winName="UISystemZongMenZYFailureWin2",winParam=function(data)return systemZongMenModel:funcResultFail2(data)end},
},
[systemZongMenResultType.eCapture]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration1(data)end},
{winName="UISystemZongMenZYFailureWin2",winParam=function(data)return systemZongMenModel:funcResultFail2(data)end},
},
},
[systemZongMenFuncType.eTaYin]=
{
[systemZongMenResultType.eSuccess]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration3(data)end},
{winName="UICommonShowPrizeWin",winParam=function(data)return systemZongMenModel:funcTaYinSuccess(data)end},
},
[systemZongMenResultType.eExcape]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration3(data)end},
{winName="UICommonShowPrizeWin",winParam=function(data)return systemZongMenModel:funcTaYinSuccess(data)end},
},
[systemZongMenResultType.eExpel]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration0(data)end},
{winName="UISystemZongMenZYFailureWin2",winParam=function(data)return systemZongMenModel:funcResultFail2(data)end},
},
[systemZongMenResultType.eCapture]=
{
{winName="UISystemZongMenResultWin",winParam=function(data)return systemZongMenModel:funcIllustration0(data)end},
{winName="UISystemZongMenZYFailureWin2",winParam=function(data)return systemZongMenModel:funcResultFail2(data)end},
},
},
}

local _result=nil

function systemZongMenModel:newResultData()
_result={}






end

function systemZongMenModel:clearResultData()
_result=nil
end

function systemZongMenModel:exsitResultData()
return _result~=nil
end

function systemZongMenModel:pushOtherResultData(datas)
if not self:exsitResultData()then
self:newResultData()
end
for i,v in pairs(datas)do
_result[i]=v
end
end

function systemZongMenModel:getResultData()
return _result
end

function systemZongMenModel:getResultWins(funcType,result,data)
local list={}
if _steps[funcType]and _steps[funcType][result]then
local steps=_steps[funcType][result]
for i,v in ipairs(steps)do
if v.winName then
local winName=v.winName
local winParam=v.winParam and v.winParam(data)or nil
table.insert(list,{winName=winName,winParam=winParam})
end
end
else
loggerUtil.logErrFMT("无效的系统宗门结果处理:{0},{1}",funcType,result)
end
return list
end

function systemZongMenModel:getResultWinsEx()
return self:getResultWins(_result.funcType,_result.result,_result)
end


function systemZongMenModel:funcIllustration0(data)
local infoData=systemZongMenModel:getInfoData(data.serial)
local zmName=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
local param=data.datas
local sName=UIDiscipleModel:getDiscipleName(param.source)
return{
result=data.result,
funcType=data.funcType,
param={gameUtilityModel.getGameYear(),sName,zmName},
}
end

function systemZongMenModel:funcIllustration1(data)
local temp=self:funcIllustration0(data)
local detailData=systemZongMenModel:getDetailPartInfo(data.serial,systemZongMenDetailDataPart.eDZList)
local tGuid=data.datas.target
local tName=""
if detailData and detailData.num>0 then
for i,v in ipairs(detailData.discipleList)do
if mathHelper.compareInt64(v.discipleguid,tGuid)then
tName=v.disciplename
break
end
end
end
temp.param[4]=tName
return temp
end

function systemZongMenModel:funcIllustration2(data)

local param=self:funcIllustration1(data)
local datas=data.datas
local subNum=datas.num
local subList=datas.subList
local subValue=0
if subNum>0 then
for i,v in ipairs(subList)do
if v.param_1==datas.target then
subValue=v.param_2
break
end
end
end
param.param[5]=subValue
return param
end

function systemZongMenModel:funcIllustration3(data)
local temp=self:funcIllustration0(data)
local itemsStr1=nil
local itemsStr2=nil
if data.items then

for i,v in ipairs(data.items)do
local cfg=itemsConfig.getConfig(v.itemid)
local itemName=itemsConfig.getColorName(v.itemid)
if cfg.type1==13 then
if itemsStr1==nil then
itemsStr1=itemName
else
itemsStr1=FMT.fmt("{0},{1}",itemsStr1,itemName)
end
else
if itemsStr2==nil then
itemsStr2=itemName
else
itemsStr2=FMT.fmt("{0},{1}",itemsStr2,itemName)
end
end
end
end
temp.param[4]=itemsStr1 or itemsStr2 or""
return temp
end

function systemZongMenModel:funcZaoYaoSuccess(data)
local list={}
if systemZongMenModel:checkDetailPartInfo(data.serial,systemZongMenDetailDataPart.eDZList)then
local detailData=systemZongMenModel:getDetailPartInfo(data.serial,systemZongMenDetailDataPart.eDZList)
if detailData.num>0 then
for i,v in ipairs(data.datas.subList)do
for j,w in ipairs(detailData.discipleList)do
if v.param_1==w.discipleguid then
table.insert(list,{disciple=w,value=v.param_2})
end
end
end
end
else

end
return{list=list}
end

function systemZongMenModel:funcResultFail2(data)
local infoData=systemZongMenModel:getInfoData(data.serial)
local discipleGuid=infoData.disciple_guid
local temp={
disciple=discipleGuid,
serial=data.serial,
attrs={},
special={},
result=data.result,
}
local guidStr=tostring(discipleGuid)
if data.disciples then
local jingjieList=data.disciples[eDiscipleChangeType.eJingJieChange]
if jingjieList then
local list=jingjieList[guidStr]

if list then
if list[1][1]~=list[#list][2]then
table.insert(temp.attrs,{"",UIDiscipleModel:getJJName4(list[1][1]),UIDiscipleModel:getJJName4(list[#list][2])})
else
table.insert(temp.attrs,{"<color=#7D3B17>修为：</color>",list[1][3],list[#list][4]})
end
end
end
local injuryList=data.disciples[eDiscipleChangeType.eInjuryChange]
if injuryList then
local list=injuryList[guidStr]
if list then
table.insert(temp.attrs,{"<color=#7D3B17>负伤值：</color>",list[1][1],list[#list][2]})
end
end
local specialityList=data.disciples[eDiscipleChangeType.eSpeciality]
if specialityList then
local list=specialityList[guidStr]
if list then
for i,v in ipairs(list)do

if v[3]==1 then
table.insert(temp.special,{v[1],v[2]})
end
end
end
end
end
return temp
end

function systemZongMenModel:funcResultFail3(data)
local infoData=systemZongMenModel:getInfoData(data.serial)
local discipleGuid=infoData.disciple_guid
local temp={
disciple=discipleGuid,
serial=data.serial
}
return temp
end

function systemZongMenModel:funcTaYinSuccess(data)
local prizelist=data.items or{}
for i,v in ipairs(prizelist)do
local config=itemsConfig.getConfig(v.itemid)
if config.type1==13 then
v.sortWeight=v.sortWeight+100000
end
end
table.sort(prizelist,function(a,b)
return a.sortWeight>b.sortWeight
end)

local temp={
list=prizelist,
}
return temp
end

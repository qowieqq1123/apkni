




chatEmotHelper={}



function chatEmotHelper.decodeEmot(content)
if content==nil or content==''then return''end
local setting=chatConfig.getCommonConfig()
local maxEmot=setting.maxemot
local len=string.len(content)
if len<=0 then return''end
local commonConfig=chatConfig.getCommonConfig()
local maxChar=commonConfig.maxemot
local emotTag=commonConfig.emotchar
local emotNum=0
local isChange=false
local emotKeyTemp=''
local emotKey=''
local textBuilder=''
local startIndex=1;
for i=1,len do
local ch=string.sub(content,i,i)
if ch==emotTag then
local next=emotNum>=maxEmot or isChange
if not next then
local index=1
for j=1,maxChar do
if i+j<=len then
local nch=string.sub(content,i+j,i+j)
emotKeyTemp=emotKeyTemp..nch
local conf=spriteAnimationsHelper.has(emotKeyTemp)
if conf then
index=j+1
emotKey=emotKeyTemp
end
end
end
textBuilder=textBuilder..string.sub(content,startIndex,i-1)
startIndex=i+index
i=startIndex
local emotName=emotKey
local conf=spriteAnimationsHelper.has(emotName)
if conf then
local str=FMT.fmt(chatConfig.emotfmt,emotName)
textBuilder=textBuilder..str
emotNum=emotNum+1
else
textBuilder=textBuilder..emotTag
textBuilder=textBuilder..emotName
end
emotKeyTemp=''
emotKey=''
end
elseif ch=='<'then
isChange=true
elseif ch=='>'then
isChange=false
end
end
textBuilder=textBuilder..string.sub(content,startIndex,len)
return textBuilder
end


function chatEmotHelper.decodeChatEmot(content)
if content==nil or content==''then return''end
local setting=chatConfig.getCommonConfig()
local maxEmot=setting.maxemot
local len=string.len(content)
if len<=0 then return''end
local commonConfig=chatConfig.getCommonConfig()
local maxChar=commonConfig.maxemot
local emotTag=commonConfig.emotchar
local emotNum=0
local isChange=false
local emotKeyTemp=''
local emotKey=''
local textBuilder=''
local startIndex=1;
for i=1,len do
local ch=string.sub(content,i,i)
if ch==emotTag then
local next=emotNum>=maxEmot or isChange
if not next then
local index=1
for j=1,maxChar do
if i+j<=len then
local nch=string.sub(content,i+j,i+j)
emotKeyTemp=emotKeyTemp..nch

local conf=chatConfig.hasNomalEmotAsset(emotKeyTemp)and
spriteAnimationsHelper.has(emotKeyTemp)or false
if conf then
index=j+1
emotKey=emotKeyTemp
end
end
end
textBuilder=textBuilder..string.sub(content,startIndex,i-1)
startIndex=i+index
i=startIndex
local emotName=emotKey
local conf=chatConfig.hasNomalEmotAsset(emotName)and
spriteAnimationsHelper.has(emotName)or false
if conf then
local str=FMT.fmt(chatConfig.emotfmt,emotName)
textBuilder=textBuilder..str
emotNum=emotNum+1
else
textBuilder=textBuilder..emotTag
textBuilder=textBuilder..emotName
end
emotKeyTemp=''
emotKey=''
end
elseif ch=='<'then
isChange=true
elseif ch=='>'then
isChange=false
end
end
textBuilder=textBuilder..string.sub(content,startIndex,len)
return textBuilder
end


function chatEmotHelper.clearSpecialSymbol(str)
return string.delTagsWithoutSpecialPattern(str,'[{}]',"<a;.-;.-;.-;.-;/>")
end

function chatEmotHelper.getIconEmotMesg(iconname,size)
if size then
local args=FMT.fmt('{0},{1}',iconname,size)
local str=FMT.fmt(chatConfig.iconEmotTagFormat,args)
return FMT.fmt(chatConfig.emotRuleFormat,str)
end
local str=FMT.fmt(chatConfig.iconEmotTagFormat,iconname)
return FMT.fmt(chatConfig.emotRuleFormat,str)
end

function chatEmotHelper.getSmallEmotMesg(id)
local config=cfg_chatesystemmotconfig_get(id)
local assetname=config.assetname
local commonConfig=chatConfig.getCommonConfig()
local emotTag=commonConfig.emotchar
return FMT.fmt('{0}{1}',emotTag,assetname)
end

function chatEmotHelper.getBigEmotMesg(packageId,id,desc,type)
local bigEmotFormat=chatConfig.bigEmotFormat
local val1=packageId
local val2=desc and desc~=''and FMT.fmt('{0},{1}',id,desc)or id
return FMT.fmt(bigEmotFormat,val1,val2,type)
end

function chatEmotHelper.containsBigEmot(mesg)
return(string.find(mesg,chatConfig.bigEmot_or)or
string.find(mesg,chatConfig.bigEmot))~=nil
end

function chatEmotHelper.decodeBigEmot(mesg)
local args1,args2,args3
local func=function()
args1,args2,args3=string.match(mesg,chatConfig.bigEmot)
end
local ret=pcall(func)
if not ret or(args1==nil and args2==nil)then
local func=function()
args1,args2,args3=string.match(mesg,chatConfig.bigEmot_or)
end
local ret=pcall(func)
if not ret then
loggerUtil.logErrFMT('大表情传错错误：',mesg)
end
end
if args3==nil then
local spArray=string.split(args2,',')
local packageid,id
local s,e=pcall(function()
packageid=tonumber(args1)
id=tonumber(spArray[1])
end)
if not s then
loggerUtil.logErrFMT('大表情传错错误：',mesg)
end
return packageid,id,spArray[2],3
else
local packageid=tonumber(args1)
local idx=tonumber(args2)
local type=tonumber(args3)
local emotid=chatEmotModel:getEmoId(type,packageid,idx)
return packageid,emotid,'',type
end
end

function chatEmotHelper.checkName(name)
local commonConfig=chatConfig.getCommonConfig()
if string.lenEx(name)>commonConfig.emotTextLimit then return false,1 end
if helper.check_spec_chars(name)then return false,2 end
return true
end

function chatEmotHelper.isDefineEmot(packageId)
return packageId==CHAT_EMOT_STYPE.eDefine
end

function chatEmotHelper.isMaxDefineEmot()
return chatEmotModel.getDefineEmotNum()>=chatConfig.getMaxDefineEmotNum()
end

function chatEmotHelper.isEnoughUnlock(id)
local emotConfig=chatConfig.getDefineEmotConfigById(id)
local unlock=emotConfig.unlock
if unlock then
return chatEmotHelper.isEnoughSingle(unlock[1],unlock[2])
end
return false
end

function chatEmotHelper.isEnoughSingle(typo,val)
if typo==CHAT_EMOT_UNLOCK_CND_TYPE.eZongmenLv then
local curVal=zongmenModel:getLevel()
return curVal>=val
else



end
return false
end

function chatEmotHelper.containsShareDiscipleInfo(chatInfo)
return string.find(chatInfo.mesg,chatConfig.shareDiscipleInfo)~=nil or chatInfo.regexType==CHAT_REGEX_TYPE.eSharedz
end

function chatEmotHelper.decodeShareDiscipleInfo(mesg)
local sguid,name,level,iconname,job,fightvalue,discipledata,discipleimage,tmlv=string.match(mesg,chatConfig.shareDiscipleInfo)
local data={
guid=int64.new(sguid),
name=name,
level=tonumber(level),
iconname=iconname,
job=tonumber(job),
fightvalue=tonumber(fightvalue)or 0,
discipledata=tonumber(discipledata)or 0,
discipleimage=tonumber(discipleimage)or 0,
tmlv=tonumber(tmlv),
discipleguid=int64.new(sguid),
}
return data
end

function chatEmotHelper.encodeDiscipleShareChatInfo(guid)
local discipleNetData=UIDiscipleModel:getDiscipleDataX(guid)
local netdata=discipleNetData.netData
local netData=netdata.net

local color=UIDiscipleModel:getDiscipleColor(guid)
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData,image.color)
local fightvalue=UIDiscipleModel:getDiscipleFightValue(guid)

local chatinfo=FMT.fmt(chatConfig.shareDiscipleInfoFormat,
tostring(guid),
netData.name or netData.disciplename,
netData.jingjielv,
iconname,
image.job,
fightvalue,
netData.discipledata,
netData.discipleimage,
netData.tmlv
)
return chatinfo
end


function chatEmotHelper.getDiscipleShareChatJson(guid)
local discipleNetData=UIDiscipleModel:getDiscipleDataX(guid)
local netdata=discipleNetData.netData
local netData=netdata.net
local color=UIDiscipleModel:getDiscipleColor(guid)
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local fightvalue=UIDiscipleModel:getDiscipleFightValue(guid)
local chatinfo={
tostring(guid)
}
return jsonHelper.encode(chatinfo)
end


function chatEmotHelper.getLingShouShareChatJson(ls_guid)
local chatinfo={
tostring(ls_guid)
}
return jsonHelper.encode(chatinfo)
end



function chatEmotHelper.getLingShouInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local lsID=tonumber(jsonTable[2])or 0
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local data={
ls_guid=int64.new(tostring(jsonTable[1])),
guid=int64.new(tostring(jsonTable[1])),
id=lsID,
name=jsonTable[3]or'',
jj_lvl=tonumber(jsonTable[4])or 0,
zizhi=tonumber(jsonTable[5])or 0,
qianli=tonumber(jsonTable[6])or 0,
xuemai_type=tonumber(jsonTable[7])or 0,
xuemai_val=tonumber(jsonTable[8])or 0,
xuemai_dianshu=tonumber(jsonTable[9])or 0,
sex=tonumber(jsonTable[10])or 0,
generation=tonumber(jsonTable[11])or 1,
wordList=jsonTable[12]or{},
born_times=tonumber(jsonTable[13])or 0,
serverSkillList=jsonTable[14]or{},
serverAttrList=jsonTable[15]or{},
cfg=lscfg,
}
return data
end


function chatEmotHelper.getDZInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
guid=int64.new(tostring(jsonTable[1])),
name=jsonTable[2],
level=tonumber(jsonTable[3]),
job=tonumber(jsonTable[4]),
fightvalue=tonumber(jsonTable[5])or 0,
discipledata=tonumber(jsonTable[6])or 0,
discipleimage=int64.new(jsonTable[7]or 0),
tmlv=tonumber(jsonTable[8]),
id=tonumber(jsonTable[9])or 0,
discipleguid=int64.new(tostring(jsonTable[1])),
clothingId=tonumber(jsonTable[10])or nil,
daoyan_unlock=tonumber(jsonTable[11])or 0,
daoyan_lv=tonumber(jsonTable[12])or 0,
}
return data
end


function chatEmotHelper.containsSharQieCuoInfo(mesg)
return string.find(mesg,chatConfig.shareQieCuoInfo)~=nil
end



function chatEmotHelper.getDZQieCuoShareChatJson(myseverid,myname,myheadiconinfo,otherseverid,othername,otherheadiconinfo,result,zhanbao)
local chatinfo={
myseverid,myname,myheadiconinfo,otherseverid,othername,otherheadiconinfo,result,zhanbao
}
return jsonHelper.encode(chatinfo)
end


function chatEmotHelper.getDZQieCuoInfoByRegex(regexInfo)

local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local myheaddata=jsonHelper.decode(jsonTable[3])

local otherheaddata=jsonHelper.decode(jsonTable[6])


local _selfFright=nil
local _otherFright=nil
if jsonTable[9]then
_selfFright=int64.new(jsonTable[9]or 0)
end
if jsonTable[10]then
_otherFright=int64.new(jsonTable[10]or 0)
end
local data={
myseverid=tonumber(jsonTable[1])or 0,
myname=jsonTable[2],
myactoricon=tonumber(myheaddata[1])or 0,
mypiList=myheaddata[2],

otherseverid=tonumber(jsonTable[4])or 0,
othername=jsonTable[5],
otheractoricon=tonumber(otherheaddata[1])or 0,
otherpiList=otherheaddata[2],

fightresult=tonumber(jsonTable[7])or 0,
zhanbao=jsonTable[8],


selfFright=_selfFright,
otherFright=_otherFright,
}


return data
end


function chatEmotHelper.getLXWJInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
def=tonumber(jsonTable[1])or 0,
atk=tonumber(jsonTable[2])or 0,
wj=tonumber(jsonTable[3])or 0,
best=tonumber(jsonTable[4])or 0,
}
return data
end

function chatEmotHelper.getTMRQInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
actId=tonumber(jsonTable[1])or 0,
subType=tonumber(jsonTable[2])or 0,
subId=tonumber(jsonTable[3])or 0,
monsterGuid=tonumber(jsonTable[4])or 0,
monsterId=tonumber(jsonTable[5])or 0,
monsterLevel=tonumber(jsonTable[6])or 0,
}
return data
end

function chatEmotHelper.getXGWXInfoByRegex1(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
jobId=tonumber(jsonTable[1])or 0,
declaration=tonumber(jsonTable[2])or 0,
bwFlag=tonumber(jsonTable[3])or 0,
}
return data
end

function chatEmotHelper.getXGWXInfoByRegex2(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
jobId=tonumber(jsonTable[1])or 0,
declaration=tonumber(jsonTable[2])or 0,
actorIdx=tonumber(jsonTable[3])or 0,
bwFlag=tonumber(jsonTable[4])or 0,
}
return data
end

function chatEmotHelper.getCSJDInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
actId=tonumber(jsonTable[1])or 0,
subType=tonumber(jsonTable[2])or 0,
subId=tonumber(jsonTable[3])or 0,
hbGuid=tonumber(jsonTable[4])or 0,
}
return data
end

function chatEmotHelper.getZZSHInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
shareType=tonumber(jsonTable[1])or 0,
shareName=jsonTable[2],
x=tonumber(jsonTable[3])or 0,
y=tonumber(jsonTable[4])or 0,
stage=tonumber(jsonTable[5])or 0,
}
return data
end

function chatEmotHelper.getXJInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local data={
shareType=tonumber(jsonTable[1])or 0,
shareName=jsonTable[2],
scenceType=tonumber(jsonTable[3])or 1,
x=tonumber(jsonTable[4])or 0,
y=tonumber(jsonTable[5])or 0,

}
if data.shareType==xianjie_Point_Share.miaoxingshanglv then
data.shipGuidStr=jsonTable[6]
data.shipId=tonumber(jsonTable[7])
data.isSelfTeamFlag=tonumber(jsonTable[8])or 0
data.actorIdStr=jsonTable[9]
end
return data
end

function chatEmotHelper.getPTZJInfoByRegex(regexInfo)
local str=regexInfo[1][2]
local jsonTable=jsonHelper.decode(str)
local shareId=tonumber(jsonTable[2])
local cfg=xianjieController:xjrzgetCfg_hj(xjServerEnityType.eMoJingZhenJi_Normal,shareId)

local data={
shareType=tonumber(jsonTable[1])or 0,
shareName=cfg.name,
scenceType=tonumber(jsonTable[3])or 1,
x=tonumber(jsonTable[4])or 0,
y=tonumber(jsonTable[5])or 0,

}
return data
end

function chatEmotHelper.getXJQiuYuanShareJson(sceneidx,posX,posZ,tabType)
local jsonTable=
{
sceneidx,
posX,
posZ,
tabType,
}
return jsonHelper.encode(jsonTable)
end

function chatEmotHelper.getXJQiuYuanInfoByRegex(regexInfo)
local str=regexInfo[1][2]
if str==""then
str="{}"
end
local jsonTable=jsonHelper.decode(str)
local data={
sceneidx=tonumber(jsonTable[1])or 0,
x=tonumber(jsonTable[2])or 0,
y=tonumber(jsonTable[3])or 0,
tabType=tonumber(jsonTable[4])or ATTACKTABTYPE.eXJ,
}
return data
end

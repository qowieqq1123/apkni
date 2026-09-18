







xianmengIconType={
eIcon=1,
eBG=2,
eKuang=3,
}

xianmengModel={}

local myData=nil
local noteRefrehTime=10
local detailDataRefreshTime=30
local searchDataRefreshTime=60
local _noticeStamp={}

function xianmengModel:clearData()
myData=nil
_noticeStamp={}
end

function xianmengModel:initData()
myData={}
myData.searchXMLookup=nil
myData.searchXMDetailLookup={}
myData.searchXMMemberListLookup={}
end


function xianmengModel:initXMData(xmData)
myData.xmData=xmData
end

function xianmengModel:checkInit()
if myData then
return myData.xmData~=nil
end
return false
end


function xianmengModel:initMyXMDetialData(xmDetialData)
myData.xmDetialData=xmDetialData
end

function xianmengModel:leaveXM()

myData.xmData.guildid=int64.new('0')

myData.xmDetialData=nil
end

function xianmengModel:getXMAllData()
return myData
end

function xianmengModel:getXMBaseData()
return myData.xmData
end

function xianmengModel:getXMDetialData()
return myData.xmDetialData
end

function xianmengModel:setXMCooperationEarn(cooperation_earn)
if not myData or not myData.xmData then
return
end
myData.xmData.cooperation_earn=cooperation_earn
end

function xianmengModel:getXMCooperationEarn()
if not myData or not myData.xmData then
return 0
end
return myData.xmData.cooperation_earn or 0
end

function xianmengModel:markLeaveXMTime()
local ver=pfwindowslController:getGameVersion()
local exit=cfgHelper.get2(cfg_guildbaseconfig_get,1,'exit')
if exit[ver]and(myData.xmData.exitsec==0)then
myData.xmData.exitsec=1
else
myData.xmData.exitsec=gameUtilityModel.getServerShortTime()
end
end

function xianmengModel:getMyXMDetialData()
if myData then
return myData.xmDetialData
end
end


function xianmengModel:markXMDetialDataTime(flag)
if flag==true then
myData.xmDetialDataTime=gameUtilityModel.getServerShortTime()
else
myData.xmDetialDataTime=nil
end
end


function xianmengModel:checkXMDetialDataOutData()
if myData~=nil then
if myData.xmDetialData==nil or myData.xmDetialDataTime==nil then
return true
else
local lerp=gameUtilityModel.getServerShortTime()-myData.xmDetialDataTime
if lerp>=detailDataRefreshTime then
return true
end
end
return false
end
return nil
end

function xianmengModel:setGuildImage(guildicon)
if myData and myData.xmDetialData then
myData.xmDetialData.guildicon=guildicon
end
end

function xianmengModel:getXMLevel()
if myData and myData.xmDetialData then
return myData.xmDetialData.guildlevel,myData.xmDetialData.guildexp
end
return nil,nil
end

function xianmengModel:setXMLevelAndExp(guildlevel,guildexp)
if myData and myData.xmDetialData then
if guildlevel~=nil then
myData.xmDetialData.guildlevel=guildlevel
end
if guildexp~=nil then
myData.xmDetialData.guildexp=guildexp
end
end
end


function xianmengModel:getXMNotice()
local guildnotice
if myData and myData.xmDetialData then
guildnotice=myData.xmDetialData.guildnotice
end
return xianmengModel:getXMNoticeEx(guildnotice)
end

function xianmengModel:getXMNotice2()
local guildnotice
if myData and myData.xmDetialData then
guildnotice=myData.xmDetialData.guildexnotice
end
return xianmengModel:getXMNoticeEx(guildnotice)
end
function xianmengModel:getXMNoticeEx(guildnotice,default)
if guildnotice==nil or guildnotice==''then
return default or'暂无公告'
end
return guildnotice
end

function xianmengModel:setXMNotice(notice)
if myData and myData.xmDetialData then
myData.xmDetialData.guildnotice=notice
end
end

function xianmengModel:setXMNotice2(notice)
if myData and myData.xmDetialData then
myData.xmDetialData.guildexnotice=notice
end
end

function xianmengModel:getXMName()
if myData and myData.xmDetialData then
return myData.xmDetialData.guildname
end
return nil
end

function xianmengModel:getXMLeaderName()
if myData and myData.xmDetialData then
return myData.xmDetialData.leadername
end
return nil
end

function xianmengModel:setXMLeaderName(leadername)
if myData and myData.xmDetialData then
myData.xmDetialData.leadername=leadername
end
end

function xianmengModel:setXMName(guildname)
if myData and myData.xmDetialData then
myData.xmDetialData.guildname=guildname
end
end

function xianmengModel:setXMLimit(joinlimit,levellimit)
if myData and myData.xmDetialData then
myData.xmDetialData.joinlimit=joinlimit
myData.xmDetialData.levellimit=levellimit
end
end

function xianmengModel:getXMMemberList()
if myData and myData.xmDetialData then
return myData.xmDetialData.list or{}
end
return nil
end

function xianmengModel:getXMMemberNum()
local list=xianmengModel:getXMMemberList()
if list then
return#list
end
return 0
end

function xianmengModel:getXMMemberName(actorid)
local data=xianmengModel:getXMMemberData(actorid)
if data then
return data.actorname
end
return nil
end

function xianmengModel:getXMMemberPost(actorid)
local data=xianmengModel:getXMMemberData(actorid)
if data then
return data.pos
end
end

function xianmengModel:setXMMemberPost(actorid,postType)
local data=xianmengModel:getXMMemberData(actorid)
if data then
data.pos=postType
end
end

function xianmengModel:getXMMemberData(actorid)
local list=xianmengModel:getXMMemberList()
if list~=nil and#list>0 then
for i,v in ipairs(list)do
if mathHelper.compareInt64(v.actorid,actorid)then
return v
end
end
end
return nil
end

function xianmengModel:removeXMMember(actorid)
if myData and myData.xmDetialData then
local f=nil
local list=myData.xmDetialData.list
if list then
for i,v in ipairs(list)do
if mathHelper.compareInt64(v.actorid,actorid)then
f=i
break
end
end
end
if f then
table.remove(list,f)
end
end
end

function xianmengModel:checkActorInXM(actorid)
local data=xianmengModel:getXMMemberData(actorid)
return data~=nil
end

function xianmengModel:getJoinCoolDownTime()
local lerp=0
local xmData=myData.xmData
if xmData then
local exitsec=xmData.exitsec
if exitsec>0 then
local joinCD=xianmengModel:getJoinCD(exitsec)
local cur=gameUtilityModel.getServerShortTime()
local l=cur-exitsec
if l>0 then
lerp=joinCD-l
if lerp<0 then
lerp=0
end
end
end
end
return lerp
end

function xianmengModel:getJoinCD(exitsec)
local joinCD=nil
local ver=pfwindowslController:getGameVersion()
local joinCooldown=cfgHelper.get2(cfg_guildbaseconfig_get,1,'joinCooldown')[ver]
local exitsec_l=gameUtilityModel.serverShortTimeToLong(exitsec)
local lerpDay=timeHelper.getServerOpenDayByStamp(exitsec_l)
for i,v in ipairs(joinCooldown)do
if lerpDay>=v[1]and lerpDay<=v[2]then
joinCD=v[3]
break
end
end
if joinCD==nil then
joinCD=joinCooldown[#joinCooldown][3]
end
return joinCD
end


function xianmengModel:checkCanJoin(isWarning)
local lerp=xianmengModel:getJoinCoolDownTime()
if lerp>0 then
if isWarning then
local timeStr=timeHelper.format_time_stamp7(lerp)
UIManager.error(FMT.fmt("{0}后才能再次加入仙盟",timeStr))
end
return false
end

return true
end

function xianmengModel:hadXM()
if myData and myData.xmData then
local xmData=myData.xmData
return xmData.exitsec>0
end
return false
end

function xianmengModel:hasXM()
if myData and myData.xmData then
local xmData=myData.xmData
return not mathHelper.compareInt64(xmData.guildid,int64.new('0'))
end
return false
end

function xianmengModel:isMyXM(guildid)
if guildid==nil then return false end
local my_guildid=xianmengModel:myXMGuildID()
if my_guildid==nil then return false end
return mathHelper.compareInt64(my_guildid,guildid)
end

function xianmengModel:isMyXM2(guildid)
if guildid==nil then return false end
local my_guildid=xianmengModel:getMyXMGuildID()
if my_guildid==nil then return false end
return mathHelper.compareInt64(my_guildid,guildid)
end

function xianmengModel:createXM(guildid)
local xmData=myData.xmData
xmData.guildid=guildid
end

function xianmengModel:myXMGuildID()
if myData and myData.xmData then
return myData.xmData.guildid
end
return nil
end

function xianmengModel:getMyXMGuildID()
local my_guildid=xianmengModel:myXMGuildID()
if mathHelper.validInt64(my_guildid)then
return my_guildid
end
return nil
end

function xianmengModel:compareTwoGuildID(guildid1,guildid2)
if mathHelper.validInt64(guildid1)and mathHelper.validInt64(guildid2)then
return mathHelper.compareInt64(guildid1,guildid2)
end
return false
end



function xianmengModel:initApplicationList(list)
local lookup={}
myData.applicationLookup=lookup
if list then
for i,v in ipairs(list)do
local actorid_str=tostring(v.actorid)
v.actorid_str=actorid_str
lookup[actorid_str]=v
end
end
end

function xianmengModel:clearApplicationList()
if myData and myData.applicationLookup then
myData.applicationLookup={}
end
end

function xianmengModel:getApplicationListCount()
local num=0
if myData and myData.applicationLookup then
for k,v in pairs(myData.applicationLookup)do
num=num+1
end
end
return num
end

function xianmengModel:getApplicationList()
local list={}
if myData and myData.applicationLookup then
for k,v in pairs(myData.applicationLookup)do
table.insert(list,v)
end
end
return list
end

function xianmengModel:getApplication(actorid)
if myData and myData.applicationLookup then
local actorid_str=tostring(actorid)
return myData.applicationLookup[actorid_str]
end
return nil
end

function xianmengModel:removeApplication(actorid)
if myData and myData.applicationLookup then
local actorid_str=tostring(actorid)
if actorid_str=='0'then

myData.applicationLookup={}
else
if myData.applicationLookup[actorid_str]then
myData.applicationLookup[actorid_str]=nil
end
end
end
end





function xianmengModel:initInvitationList(list)
local lookup={}
myData.invitationLookup=lookup
if list then
for i,v in ipairs(list)do
local guildid_str=tostring(v.guildid)
v.guildid_str=guildid_str
lookup[guildid_str]=v
end
end
end


function xianmengModel:clearInvitationList()
if myData then
myData.invitationLookup={}
end
end

function xianmengModel:getInvitationList()
local list={}
if myData and myData.invitationLookup then
for k,v in pairs(myData.invitationLookup)do
table.insert(list,v)
end
end
return list
end

function xianmengModel:getInvitationCount()
local num=0
if myData and myData.invitationLookup then
for k,v in pairs(myData.invitationLookup)do
num=num+1
end
end
return num
end

function xianmengModel:removeInvitation(guildid)
if myData and myData.invitationLookup then
local guildid_str=tostring(guildid)
if guildid_str=='0'then

myData.invitationLookup={}
else
if myData.invitationLookup[guildid_str]then
myData.invitationLookup[guildid_str]=nil
end
end
end
return list
end





function xianmengModel:initApplyJoinList()
local lookup={}
myData.applyJoinLookup=lookup
end

function xianmengModel:setApplyJoinState(guildid,flag)
local guildid_str=tostring(guildid)
myData.applyJoinLookup[guildid_str]=flag
end

function xianmengModel:checkApplyJoinState(guildid)
local guildid_str=tostring(guildid)
return myData.applyJoinLookup[guildid_str]~=nil
end





function xianmengModel:initInviteJoinList()
local lookup={}
myData.inviteJoinLookup=lookup
end

function xianmengModel:setInviteJoinState(actorid,flag)
local actorid_str=tostring(actorid)
myData.inviteJoinLookup[actorid_str]=flag
end

function xianmengModel:checkInviteJoinState(actorid)
local actorid_str=tostring(actorid)
return myData.inviteJoinLookup[actorid_str]~=nil
end





local checkXMJoinCond=function(self_,isWarning)
local isfullnum=self_.isfull
if isfullnum then
if isWarning then
UIManager.error('仙盟人数已达上限')
end
return false
end

local joinlimit=self_.joinlimit
if mathHelper.getBitValue(joinlimit,1)then
if isWarning then
UIManager.error('不再招人')
end
return false
else

local levellimit=self_.levellimit
local zmlv=zongmenModel:getLevel()
if zmlv<levellimit then
if isWarning then
UIManager.error(FMT.fmt('宗门需要达到{0}级才可申请',levellimit))
end
return false
else
return true
end
end
end

function xianmengModel:recordSearchXMData(list)
local lookup={}
myData.searchXMLookup=lookup
myData.searchXMRefreshTime=gameUtilityModel.getServerShortTime()
if list then
for i,v in ipairs(list)do
local guildid_str=tostring(v.guildid)
v.guildid_str=guildid_str
v.guildid_num=mathHelper.int64_to_number(v.guildid)
v.membernum_max=xianmengModel.getXMMaxMemberNum(v.guildlevel)
v.isfull=v.membernum>=v.membernum_max
v.memberfight_num=mathHelper.int64_to_number(v.memberfight)
v.checkfunc=checkXMJoinCond
lookup[guildid_str]=v
end
end
return list
end

function xianmengModel:clearSearchXMData()
myData.searchXMLookup=nil
myData.searchXMRefreshTime=nil
end

function xianmengModel:getAllSearchXMData()
local list={}
if myData then
for k,v in pairs(myData.searchXMLookup)do
table.insert(list,v)
end
end
return list
end

function xianmengModel:getSearchXMData(guildid)
if myData.searchXMLookup then
local guildid_str=tostring(guildid)
return myData.searchXMLookup[guildid_str]
end
end

function xianmengModel:checkSearchXMData(isGetNew)
local lookup=myData.searchXMLookup
local flag=true
if lookup~=nil then
local lerp=gameUtilityModel.getServerShortTime()-myData.searchXMRefreshTime
if lerp<searchDataRefreshTime then
flag=false
end
end
if flag or isGetNew then
xianmengController:reqXMList(200,1)
end
return flag
end

function xianmengModel:recordSearchXMDetailData(detailData)
local guildid_str=tostring(detailData.guildid)
detailData.guildid_str=guildid_str
detailData.checkfunc=checkXMJoinCond
myData.searchXMDetailLookup[guildid_str]=detailData


local data=xianmengModel:getSearchXMData(detailData.guildid)
if data then
data.guildicon=detailData.guildicon
data.leaderserverid=detailData.leaderserverid
data.guildname=detailData.guildname
data.leadername=detailData.leadername
data.guildlevel=detailData.guildlevel
data.membernum=detailData.membernum
data.memberfight=detailData.memberfight
data.memberfight_num=mathHelper.int64_to_number(detailData.memberfight)
data.levellimit=detailData.levellimit
data.joinlimit=detailData.joinlimit

data.guildnotice=detailData.guildnotice
data.guildexnotice=detailData.guildexnotice
end
end

function xianmengModel:getSearchXMDetailData(guildid)
local guildid_str=tostring(guildid)
return myData.searchXMDetailLookup[guildid_str]
end

function xianmengModel:recordSearchXMMemberList(guildid,list)
local guildid_str=tostring(guildid)
local num=0
if list~=nil then
num=#list
end
if num>0 then
for i,v in ipairs(list)do
v.fight_num=mathHelper.int64_to_number(v.fight)
end
end
if num>1 then
table.sort(list,function(a,b)
if a.pos==b.pos then
return a.fight_num>b.fight_num
else
return a.pos<b.pos
end
end)
end
myData.searchXMMemberListLookup[guildid_str]=list
end

function xianmengModel:getSearchXMMemberList(guildid)
local guildid_str=tostring(guildid)
return myData.searchXMMemberListLookup[guildid_str]
end


function xianmengModel:getSearchXMHuoYueNum(guildid)
if guildid==nil then return end
local list=xianmengModel:getSearchXMMemberList(guildid)
if list then
local num=0
for i,v in ipairs(list)do
if v.online==0 then
num=num+1
else
local cur=gameUtilityModel.getServerShortTime()
if cur-v.online<=timeSecLook.eSevenDaySec then
num=num+1
end
end
end
return num
end
end

function xianmengModel:getSearchXMSortNames()
if myData.sortNames==nil then
myData.sortNames={'仙盟等级','总实力','活跃'}
end
return myData.sortNames
end

function xianmengModel:getSearchXMFilter(sortCondition)
local c=1
local filterName={}
local filterFlag={}

filterName[c]={}
filterName[c][1]='状态'
filterName[c][2]={}
filterFlag[c]={}
table.insert(filterName[c][2],{name='可申请',typeid=1})
local flag_1=discipleLookup.getFilterFlagByCondition(sortCondition,c,1)
table.insert(filterFlag[c],flag_1)

return filterName,filterFlag
end

function xianmengModel:getSearchXMFilter2(sortCondition)
local c=1
local filterName={}
local filterFlag={}

filterName[c]={}
filterName[c][1]='状态'
filterName[c][2]={}
filterFlag[c]={}
table.insert(filterName[c][2],{name='未满员',typeid=1})
local flag_1=discipleLookup.getFilterFlagByCondition(sortCondition,c,1)
table.insert(filterFlag[c],flag_1)
table.insert(filterName[c][2],{name='满员',typeid=2})
local flag_2=discipleLookup.getFilterFlagByCondition(sortCondition,c,2)
table.insert(filterFlag[c],flag_2)

return filterName,filterFlag
end

function xianmengModel:getSearchXMSortList(list,sortType,filterCondition,sortOrder)
local result={}
if list~=nil then
for i,v in ipairs(list)do
local add=true
if filterCondition~=nil then
if filterCondition[1]~=nil and#filterCondition[1]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[1])do
if v1==1 then

if v:checkfunc()and not xianmengModel:checkApplyJoinState(v.guildid)then
addx=true
end
end
end
add=add and addx
end
end
if add then
result[#result+1]=v
end
end
if#result>1 then
xianmengModel:searchXMSort(result,sortType,sortOrder)
end
end
return result
end

function xianmengModel:getSearchXMSortList2(list,sortType,filterCondition,sortOrder)
local result={}
if list~=nil then
for i,v in ipairs(list)do
local add=true
if filterCondition~=nil then
if filterCondition[1]~=nil and#filterCondition[1]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[1])do
if v1==1 then

if not v.isfull then
addx=true
end
elseif v1==2 then

if v.isfull then
addx=true
end
end
end
add=add and addx
end
end
if add then
result[#result+1]=v
end
end
if#result>1 then
xianmengModel:searchXMSort(result,sortType,sortOrder)
end
end
return result
end

function xianmengModel:searchXMSort(result,sortType,sortOrder)
if sortType~=nil then
sortOrder=sortOrder or eSortOrder.eDown
table.sort(result,function(a,b)
local va,vb
if sortType==1 then

va=a.guildlevel
vb=b.guildlevel
elseif sortType==2 then

va=a.memberfight_num
vb=b.memberfight_num
elseif sortType==3 then

va=a.weekscore
vb=b.weekscore
end
if va==vb then
return a.guildid_num>b.guildid_num
else
return helper.sortOrderComparis(va,vb,sortOrder)
end
end)
end
end

function xianmengModel.getAllyList()
local list={}
if xianmengModel:hasXM()then
local memberList=xianmengModel:getXMMemberList()or{}
for i,v in ipairs(memberList)do
if v.actorid~=playerModel:getActorID()then
local temp={}
temp.actorId=v.actorid
temp.actorName=v.actorname
temp.actorLevel=v.level
temp.serverId=v.serverid or playerModel:getActorServerID()
temp.iconInfo=v.iconInfo











temp.offline=v.online
if temp.offline==0 then

table.insert(list,1,temp)
else

table.insert(list,temp)
end
end
end
end
return list
end




function xianmengModel:setXMSignRecored(signImage)
myData.xmSignRecored=signImage
end

function xianmengModel:getXMSignRecored()
return myData.xmSignRecored
end





function xianmengModel:getXMShopRefreshTime()
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,0,0,0)
local t2=t1+86400
local cur=gameUtilityModel.getServerLongTime()
local lerp=t1-cur
if lerp<0 then
lerp=t2-cur
end
return lerp
end

function xianmengModel:setXMShopNewFlag(flag)
myData.xmShopNewFlag=flag
end

function xianmengModel:checkNeedNewShopItems(isGetNew)
local shopType=eFuncShopType.eXianMeng
local flag=true
if funcShopModel:checkInit(shopType)then
if myData.xmShopNewFlag==nil then
flag=false
end
end
if flag and isGetNew then
funcShopController.send_23_1(shopType)
xianmengController:setEnterXMShopMark(true)
end
return flag
end






local xianmengNotesChangeParams={

[GUILD_LOG_TYPE.gltChangePos]=function(params)
local postType=tonumber(params[3])
local name=cfgHelper.get2(cfg_guildpositionconfig_get,postType,'name')
params[3]=name
end,
}

function xianmengModel:initXMNotes(list)
myData.notelist=list or{}
myData.noteRefreshTime=gameUtilityModel.getServerShortTime()
end

function xianmengModel:clearXMNotes()
myData.notelist=nil
myData.noteRefreshTime=nil
end

function xianmengModel:getXMNotes()
if myData then
return myData.notelist or{}
end
return nil
end

function xianmengModel:getXMNoteDesc(noteData)
local logtype=noteData.logtype
local notecfg=cfgHelper.get1(cfg_guildlogconfig_get,logtype)
local logstr
if notecfg~=nil then
local params=noteData.list
if params~=nil and#params>0 then
local params_c=table.deepCopy(params)
local changeFunc=xianmengNotesChangeParams[logtype]
if changeFunc then
changeFunc(params_c)
end
logstr=FMT.fmt(notecfg.formatstr,unpack(params_c))
else
logstr=notecfg.formatstr
end
else
logstr=FMT.fmt('缺乏{0}类型',logtype)
end
local long_time=gameUtilityModel.serverShortTimeToLong(noteData.timesec)

local timestr=timeHelper.dateServerStamp('%Y.%m.%d    %H:%M',long_time)
if pfwindowslController:checkIsGameVersion_yuenan()then
timestr=timeHelper.dateServerStamp('%d.%m.%Y    %H:%M',long_time)
end
return logstr,timestr
end

function xianmengModel:tryOpenXMNotes()
local list=myData.notelist
local flag=true
if list~=nil then

local lerp=gameUtilityModel.getServerShortTime()-myData.noteRefreshTime
if lerp<noteRefrehTime then
flag=false
end
end
if flag then
xianmengController:reqXMNoteList()
else
UIManager:showWindow('UIXianMengNoteWin')
end
end



function xianmengModel.getDefualtGuildIamge()
local image={}
image.icon=1
image.bg=1
image.kuang=1
return image
end

function xianmengModel:getGuildImage()
local guildicon=myData.xmDetialData.guildicon
return xianmengModel.splitGuildIcon(guildicon)
end

function xianmengModel.splitGuildIcon(icon)
local image={}
image.icon=bit.band(icon,0xFF)
image.bg=bit.band(bit.rshift(icon,8),0xFF)
image.kuang=bit.band(bit.rshift(icon,16),0xFF)
return image
end

function xianmengModel.composeGuildIcon(image)
local icon=0
icon=bit.bor(icon,image.icon)
icon=bit.bor(icon,bit.lshift(image.bg,8))
icon=bit.bor(icon,bit.lshift(image.kuang,16))
return icon
end

function xianmengModel.getXMMaxMemberNum(xmlv)
return cfgHelper.get2(cfg_guildlevelconfig_get,xmlv,'max')
end

function xianmengModel:checkOpenNotice(out)











local colIdx=out and 1 or 2
local cfg=cfgHelper.get1(cfg_guildbaseconfig_get,1)

local openday=timeHelper.getServerOpenDay()
if openday<cfg.modnotice_opendays[colIdx]then
return false,1,cfg.modnotice_opendays[colIdx]
end

local zmLv=zongmenModel:getLevel()
if zmLv<cfg.modnotice_zmlevel[colIdx]then
return false,2,cfg.modnotice_zmlevel[colIdx]
end

return true,0
end

function xianmengModel.getXMPostName(postType,iscolor)
local name=cfgHelper.get2(cfg_guildpositionconfig_get,postType,'name')
if iscolor then
if postType==GUILD_POST_TYPE.gpAllyLeader then
name=FMT.fmt('<color=#ca631d>{0}</color>',name)
elseif postType==GUILD_POST_TYPE.gpViceLeader then
name=FMT.fmt('<color=#ca631d>{0}</color>',name)
elseif postType==GUILD_POST_TYPE.gpElder then
name=FMT.fmt('<color=#6833c0>{0}</color>',name)
else
name=FMT.fmt('<color=#549327>{0}</color>',name)
end
end
return name
end

function xianmengModel:findPostListByPrivile(privileType)
local posCfg=cfg_guildpositionconfig()
local list={}
for i,v in ipairs(posCfg)do
if v.privilege[privileType]then
table.insert(list,i)
end
end
return list
end


function xianmengModel.checkPostPrivile(postType,privileType)
local privilege=cfgHelper.get2(cfg_guildpositionconfig_get,postType,'privilege')
if privilege then
return privilege[privileType]==true
end
return false
end
function xianmengModel:checkPostSelfPrivile(privileType)
local playerId=playerModel:getActorID()
return self.checkPostPrivileByActor(playerId,privileType)
end

function xianmengModel.checkPostPrivileByActor(actorid,privileType)
local data=xianmengModel:getXMMemberData(actorid)
if data then
return xianmengModel.checkPostPrivile(data.pos,privileType)
end
return false
end
function xianmengModel.checkActorPost(actorid,postType)
local data=xianmengModel:getXMMemberData(actorid)
if data then
return data.pos==postType
end
return false
end
function xianmengModel.compareTwoActorPost(actorid1,actorid2,comparenum)
local data1=xianmengModel:getXMMemberData(actorid1)
local data2=xianmengModel:getXMMemberData(actorid2)
return data2.pos-data1.pos>=comparenum
end


function xianmengModel:checkSystemReddot()
if xianmengModel:hasXM()then
local num=xianmengModel:getApplicationListCount()
return num>0
end
return false
end


function xianmengModel:checkPalaceReddot()
if xianmengModel:getXMUnionGroupFlag()then
return true
end
local num=xianmengModel:getApplicationListCount()
return num>0
end


function xianmengModel:checkXMZReddot()
if xianmengModel:hasXM()and zongmenModel:getMountainId()~=mapIdType.xianmeng then
local flag=limitActivitiesModel:getActReddot(LIMIT_ACT_TYPE.eLingXuWenJian)
return flag
end
return false
end

function xianmengModel:getXMUnionGroupFlag()
if not(webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative())then
return false
end
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXMUnionGroup,'XM_UNIONGROUP_FLAG',true)
return flag
end

function xianmengModel:setXMUnionGroupFlag()
if not(webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative())then
return
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXMUnionGroup,'XM_UNIONGROUP_FLAG',false)
end

function xianmengModel:recordNoticeStamp(out)
local index=out and 2 or 1
_noticeStamp[index]=timeHelper.getServerShortTime()
end

function xianmengModel:getNoticeStamp(out)
local index=out and 2 or 1
return _noticeStamp[index]
end

function xianmengModel:checkNoticeStamp(out)
local stamp=self:getNoticeStamp(out)
if stamp then
local index=out and 2 or 1
local interval=cfgHelper.get3(cfg_guildbaseconfig_get,1,"modnotice_interval",index)
return timeHelper.getServerShortTime()>stamp+interval
end
return true
end

function xianmengModel:getChangeAnimationDatatestttt()
local Changedata=userActorSetting.get("UIXM_LXWJ_zhenyanWin_Changedata",{})

end

function xianmengModel:isInTeQuanAct(typo)
local activities=activitiesModel:getAllActivitiesEx()
if activities==nil then return end
for _,actInfo in pairs(activities)do
if actInfo:checkDoing()then
local sub_actList=actInfo:getSubActInfoList(SUB_ACTIVITY_TYPE.eXianMengTeQuan)
if sub_actList and#sub_actList>0 then
for i,subInfo in ipairs(sub_actList)do
if subInfo:checkOpen()and activitiesModel:checkActOpen(subInfo.act_id)then
if typo then
if subInfo:inTeQuanTime(typo)then
return subInfo
end
else
return subInfo
end
end
end
end
end
end
end

function xianmengModel:getOpenSubActList()
local temp={}
local sub_actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.eXianMengTeQuan)
if sub_actList and#sub_actList>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and activitiesModel:checkActOpen(sub_actInfo.act_id)then
temp[#temp+1]=sub_actInfo
end
end
end
return temp
end


function xianmengModel:getAcTCDTeQuan()
local activities=activitiesModel:getAllActivitiesEx()
if activities==nil then return 0 end
local rate=0
for _,actInfo in pairs(activities)do
if actInfo:checkDoing()then
local sub_actList=actInfo:getSubActInfoList(SUB_ACTIVITY_TYPE.eXianMengTeQuan)
if sub_actList and#sub_actList>0 then
for i,subInfo in ipairs(sub_actList)do
if subInfo:checkOpen()and activitiesModel:checkActOpen(subInfo.act_id)then
local cdTeQuanTimes,maxTimes=subInfo:getFreeCDTimes()
if cdTeQuanTimes>0 then
return cdTeQuanTimes,maxTimes
end
end
end
end
end
end
return 0
end


function xianmengModel:getAcTJJRateTeQuan()
local activities=activitiesModel:getAllActivitiesEx()
if activities==nil then return 0 end
local rate=0
for _,actInfo in pairs(activities)do
if actInfo:checkDoing()then
local sub_actList=actInfo:getSubActInfoList(SUB_ACTIVITY_TYPE.eXianMengTeQuan)
if sub_actList and#sub_actList>0 then
for i,subInfo in ipairs(sub_actList)do
if subInfo:checkOpen()and activitiesModel:checkActOpen(subInfo.act_id)then
rate=rate+subInfo:getAutoJJRate()
end
end
end
end
end
return rate
end

function xianmengModel:setDaQianShiJieData(data)
local now=timeHelper.getServerShortTime()
self.daQianShiJieData={stamp=now,xmList=data}
end

function xianmengModel:getDaQianShiJieData()
if not self.daQianShiJieData then
return
end
local now=timeHelper.getServerShortTime()
if self.daQianShiJieData.stamp<now-60 then
return self.daQianShiJieData.xmList
end
end

function xianmengModel.checkZhaoMuCD()
local info=xianmengModel:getXMDetialData()

if not info then
return false
end
local recruit=info.recruit
local cfgRecruit=cfgHelper.get2(cfg_guildbaseconfig_get,1,'recruit')
if recruit then
local cur=gameUtilityModel.getServerShortTime()
local lerp=cur-recruit

if lerp>=cfgRecruit then
return true,0
else
return false,cfgRecruit-lerp
end
end
return false,cfgRecruit
end



function xianmengModel:setXMJuanXianAllData(len,myjx,len2,loglist)
if not myData.kflistSelfLog then
myData.kflistSelfLog={}
end
if len>0 and myjx then
for k,v in ipairs(myjx)do
if v.itemId then
if v.dayNum and type(v.dayNum)~="number"then
myData.kflistSelfLog[v.itemId]=mathHelper.int64_to_number(v.dayNum)
end
end
end
end

if not myData.kflistLog then
myData.kflistLog={}
end
if len2>0 and loglist then


myData.kflistLog=loglist
end
end


function xianmengModel:setXMJuanXianSelfLogData(arge)
if not myData.kflistSelfLog then
myData.kflistSelfLog={}
end
if arge and arge.itemId then
if arge.dayNum and type(arge.dayNum)~="number"then
myData.kflistSelfLog[arge.itemId]=mathHelper.int64_to_number(arge.dayNum)or 0
end
end
end


function xianmengModel:setXMJuanXianLogData(loglist)
if not myData.kflistLog then
myData.kflistLog={}
end
if loglist then
myData.kflistLog[#myData.kflistLog+1]=loglist
end
end


function xianmengModel:getXMJuanXianSelfLogData()
if not myData.kflistSelfLog then
myData.kflistSelfLog={}
end

return myData.kflistSelfLog
end


function xianmengModel:getXMJuanXianLogData()
if not myData.kflistLog then
myData.kflistLog={}
end
return myData.kflistLog
end


function xianmengModel:resetXMJuanXianData()
if myData then
myData.kflistSelfLog={}

end
end










local _MODULENAME="rankListModel"




def_table(_MODULENAME)
rankListModel.name=_MODULENAME


rankListModel.data={}
rankListModel.time={}
rankListModel.number={}

local exportRankList={
[eRankListType.eZongMenFight]=function()
local list=rankListModel.data[eRankListType.eZongMenFight]or{}
local temp={}
for i,v in ipairs(list)do
local data={
actorId=v.actorId,
playerName=v.name,
zmName=v.zmName,
head=v.iconInfo,
zmLevel=v.zmLevel,
rankNum=v.rank,
data={

v.zmFight,
},
sex=v.sex,

}
table.insert(temp,data)
end
return temp
end,
[eRankListType.eDouFaTai]=function()
local list=douFaTaiModel:get_rank_data()
local temp={}
for i,v in ipairs(list)do

local data={
actorId=v.actorId,
playerName=v.name,
zmName=v.zmName,
head=v.iconInfo,




zmLevel=v.zmLevel or 0,
rankNum=i,
data={
v.wendao,
}
}
table.insert(temp,data)
end
return temp
end,
[eRankListType.eShiLianTa]=function()
local list=shiLianTaModel:getRankData()
local temp={}
for i,v in ipairs(list)do


local data={
actorId=v.actorId,
playerName=v.name,
zmName=nil,
head=v.iconInfo,




zmLevel=v.zmLevel or 0,
rankNum=v.rank,
data={
v.layer,
}
}
table.insert(temp,data)
end
return temp
end,
[eRankListType.eFaBaoFight]=function()
local list=rankListModel.data[eRankListType.eFaBaoFight]or{}
local temp={}
for i,v in ipairs(list)do
local data={
actorId=v.actorId,
playerName=v.name,
zmName=v.zmName,
head=v.iconInfo,
zmLevel=v.zmLevel,
rankNum=v.rank,
data={


v.fbFight,
v.fbInfo,
},
sex=v.sex,

}
table.insert(temp,data)
end
return temp
end,
[eRankListType.eYueLongChiRank]=function()
local list=rankListModel.data[eRankListType.eYueLongChiRank]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=v.rank
table.insert(temp,data)
end
return temp
end,
[eRankListType.eYueLongChiRankCS]=function()
local list=rankListModel.data[eRankListType.eYueLongChiRankCS]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=v.rank
table.insert(temp,data)
end
return temp
end,
[eRankListType.eYinJieKaiTian]=function()
local list=rankListModel.data[eRankListType.eYinJieKaiTian]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.head=data.iconInfo
data.data={timeHelper.getFormatByShortStamp(data.sec)}
data.playerName=v.name
data.rankNum=v.rank
data.zmName=loginModel:getServerName(data.serverId)
data.server=data.serverId
table.insert(temp,data)
end
return temp
end,
[eRankListType.eDuJieFeiSheng]=function()
local list=rankListModel.data[eRankListType.eDuJieFeiSheng]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.head=data.iconInfo
data.data={''}
data.playerName=v.name
data.rankNum=v.rank
data.zmName=loginModel:getServerName(data.serverId)
data.server=data.serverId
table.insert(temp,data)
end
return temp
end,
[eRankListType.eJiuYouTa1]=function()
local list=rankListModel.data[eRankListType.eJiuYouTa1]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.data={''}
data.playerName=v.name
data.layer=v.zmFight
data.rankNum=v.rank
data.zmName=loginModel:getServerName(data.serverId)
table.insert(temp,data)
end
return temp
end,
[eRankListType.eJiuYouTa2]=function()
local list=rankListModel.data[eRankListType.eJiuYouTa2]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.data={''}
data.playerName=v.name
data.layer=v.zmFight
data.rankNum=v.rank
data.zmName=loginModel:getServerName(data.serverId)
table.insert(temp,data)
end
return temp
end,
[eRankListType.eJiuYouTa3]=function()
local list=rankListModel.data[eRankListType.eJiuYouTa3]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.data={''}
data.playerName=v.name
data.layer=v.zmFight
data.rankNum=v.rank
data.zmName=loginModel:getServerName(data.serverId)
table.insert(temp,data)
end
return temp
end,
[eRankListType.eJiuYouTaJiFen1]=function()
return JiuYouTaModel:dealScoreRankData(eRankListType.eJiuYouTaJiFen1)
end,
[eRankListType.eJiuYouTaJiFen2]=function()
return JiuYouTaModel:dealScoreRankData(eRankListType.eJiuYouTaJiFen2)
end,
[eRankListType.eJiuYouTaJiFen3]=function()
return JiuYouTaModel:dealScoreRankData(eRankListType.eJiuYouTaJiFen3)
end,
[eRankListType.eFaBaoFight1]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eFaBaoFight1,true)
end,
[eRankListType.eDaoBingFight1]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eDaoBingFight1,true)
end,
[eRankListType.eFaBaoFight2]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eFaBaoFight2)
end,
[eRankListType.eDaoBingFight2]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eDaoBingFight2)
end,
[eRankListType.eTop15Disciple1]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eTop15Disciple1)
end,
[eRankListType.eTop15Disciple2]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eTop15Disciple2)
end,
[eRankListType.eBaoLeiShiLi]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eBaoLeiShiLi)
end,
[eRankListType.eShaQiJiLei]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eShaQiJiLei)
end,
[eRankListType.eXiuShiZhanSun]=function()
return rankListModel:getRankListBy_rankItem1(eRankListType.eXiuShiZhanSun)
end,
[eRankListType.eTopJob1]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob1)
end,
[eRankListType.eTopJob2]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob2)
end,
[eRankListType.eTopJob51]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob51)
end,
[eRankListType.eTopJob52]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob52)
end,
[eRankListType.eTopJob101]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob101)
end,
[eRankListType.eTopJob102]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob102)
end,
[eRankListType.eTopJob151]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob151)
end,
[eRankListType.eTopJob152]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob152)
end,
[eRankListType.eTopJob201]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob201)
end,
[eRankListType.eTopJob251]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob251)
end,
[eRankListType.eTopJob252]=function()
return rankListModel:getRankListBy_rankItemVoc(eRankListType.eTopJob252)
end,
[eRankListType.eXianFaWenDao1]=function()
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao1)
return rankListModel:getXianFaWenDaoRankList(level)
end,
[eRankListType.eXianFaWenDao2]=function()
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao2)
return rankListModel:getXianFaWenDaoRankList(level)
end,
[eRankListType.eXianFaWenDao3]=function()
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao3)
return rankListModel:getXianFaWenDaoRankList(level)
end,
[eRankListType.eXianFaWenDao4]=function()
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao4)
return rankListModel:getXianFaWenDaoRankList(level)
end,
[eRankListType.eXianFaWenDao5]=function()
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao5)
return rankListModel:getXianFaWenDaoRankList(level)
end,
[eRankListType.eWanLingTaRank]=function()
return rankListModel:getRankListBy_rankItem11(eRankListType.eWanLingTaRank)
end,
[eRankListType.eXianFaRank]=function()
local list=rankListModel.data[eRankListType.eXianFaRank]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=i
table.insert(temp,data)
end
return temp
end,
[eRankListType.eXianSunRank]=function()
local list=rankListModel.data[eRankListType.eXianSunRank]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=i
table.insert(temp,data)
end
return temp
end,
[eRankListType.eZhuMoRank]=function()
local list=rankListModel.data[eRankListType.eZhuMoRank]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=i
table.insert(temp,data)
end
return temp
end,
[eRankListType.eXMZhuMoRank]=function()
local list=rankListModel.data[eRankListType.eXMZhuMoRank]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=i
table.insert(temp,data)
end
return temp
end,
[eRankListType.eMingYuanZhuSha]=function()
local list=rankListModel.data[eRankListType.eMingYuanZhuSha]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=i
table.insert(temp,data)
end
return temp
end,
[eRankListType.eBigCrossMingYuanZhuSha]=function()
local list=rankListModel.data[eRankListType.eBigCrossMingYuanZhuSha]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.rankNum=i
table.insert(temp,data)
end
return temp
end,
[eRankListType.eMoHePersonalRank]=function()
local list=xianjieModel:GetMoHe_PersonalDataList()or{}
return list
end,
[eRankListType.eMoHeXMRank]=function()
local list=xianjieModel:GetMoHe_XMDataList()or{}
return list
end,
}

local appendPlayerInfo={
[eRankListType.eZongMenFight]=function(info)
info.number=rankListModel.number[eRankListType.eZongMenFight]or 0
info.data=playerModel:getActorFightValue()
end,
[eRankListType.eDouFaTai]=function(info)
local data=douFaTaiModel:get_doufatai_data()
info.number=data.rank or 0
info.data=data.wendao
end,
[eRankListType.eShiLianTa]=function(info)
local rankData=shiLianTaModel:getMyRank()
info.number=rankData and rankData.rank or 0
info.data=shiLianTaModel:getClearLayer()
end,
[eRankListType.eFaBaoFight]=function(info)
info.number=rankListModel.number[eRankListType.eFaBaoFight]or 0
local maxFight=-1
local maxGuid=nil
for diziguidStr,switchList in pairs(fabaoModel.equipsLookup)do
for switchidx,item in pairs(switchList)do
local fight=fabaoHelper.getFabaoFight(item.itemguid)
if fight>maxFight then
maxFight=fight
maxGuid=item.itemguid
end
end
end
for bagIdx,item in ipairs(fabaoBagModel:getBagItems())do
local fight=fabaoHelper.getFabaoFight(item.itemguid)
if fight>maxFight then
maxFight=fight
maxGuid=item.itemguid
end
end
info.data=maxGuid or nil
end,
[eRankListType.eYinJieKaiTian]=function(info)
local data=JiuChongTianJieEnterModel:getYinJieMyRank()
info.rank=data and data.rank or 0
info.number=info.rank
info.sec=data and data.sec or 0
info.data=info.sec>0 and timeHelper.getFormatByShortStamp(info.sec)or''
info.isFinish=zheXianLingModel:isFinishAll()
end,
[eRankListType.eDuJieFeiSheng]=function(info)
local data=JiuChongTianJieEnterModel:getDuJieMyRank()
info.rank=data and data.rank or 0
info.data=data and data.percent or 0
info.percent=data and data.percent
info.number=info.rank
end,
[eRankListType.eFaBaoFight1]=function(info)
info.number=rankListModel.number[eRankListType.eFaBaoFight1]or 0
info.data=UIDiscipleModel:getFightTop15DiscipleSumFabaoFightValue()or 0
end,
[eRankListType.eDaoBingFight1]=function(info)
info.number=rankListModel.number[eRankListType.eDaoBingFight1]or 0
info.data=UIDiscipleModel:getFightTop15DiscipleSumDaoBingFightValue()or 0
end,
[eRankListType.eFaBaoFight2]=function(info)
info.number=rankListModel.number[eRankListType.eFaBaoFight2]or 0
info.data=UIDiscipleModel:getFightTop15DiscipleSumFabaoFightValue()or 0
end,
[eRankListType.eDaoBingFight2]=function(info)
info.number=rankListModel.number[eRankListType.eDaoBingFight2]or 0
info.data=UIDiscipleModel:getFightTop15DiscipleSumDaoBingFightValue()or 0
end,
[eRankListType.eTop15Disciple1]=function(info)
info.number=rankListModel.number[eRankListType.eTop15Disciple1]or 0

info.data=playerModel:getActorTop15FightHistoryValue()
end,
[eRankListType.eTop15Disciple2]=function(info)
info.number=rankListModel.number[eRankListType.eTop15Disciple2]or 0
info.data=playerModel:getActorTop15FightHistoryValue()

end,
[eRankListType.eBaoLeiShiLi]=function(info)
info.number=rankListModel.number[eRankListType.eBaoLeiShiLi]or 0
info.data=zongmenModel:getFortFightValue()
end,
[eRankListType.eShaQiJiLei]=function(info)
info.number=rankListModel.number[eRankListType.eShaQiJiLei]or 0
info.data=moneyModel.getMoney(eMoneyType.mtLeak)
end,
[eRankListType.eXiuShiZhanSun]=function(info)
info.number=rankListModel.number[eRankListType.eXiuShiZhanSun]or 0
info.data=moneyModel.getMoney(eMoneyType.mtDie)
end,
[eRankListType.eTopJob1]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(1)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob2]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(2)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob51]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(51)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob52]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(52)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob101]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(101)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob102]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(102)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob151]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(151)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob152]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(152)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob201]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(201)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob251]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(251)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eTopJob252]=function(info)
info.number=rankListModel.number[eRankListType.eTopJob1]or 0
local discipleguid=UIDiscipleModel:getFightTopJobDiscipleGuid(252)
info.data=discipleguid and UIDiscipleModel:getDiscipleFightValue(discipleguid)or 0
end,
[eRankListType.eXianFaWenDao1]=function(info)
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao1)
rankListModel:addXianFaWenDaoPlayerInfo(info,level)
end,
[eRankListType.eXianFaWenDao2]=function(info)
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao2)
rankListModel:addXianFaWenDaoPlayerInfo(info,level)
end,
[eRankListType.eXianFaWenDao3]=function(info)
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao3)
rankListModel:addXianFaWenDaoPlayerInfo(info,level)
end,
[eRankListType.eXianFaWenDao4]=function(info)
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao4)
rankListModel:addXianFaWenDaoPlayerInfo(info,level)
end,
[eRankListType.eXianFaWenDao5]=function(info)
local level=table.findValue(eXFWDLevel2RankType,eRankListType.eXianFaWenDao5)
rankListModel:addXianFaWenDaoPlayerInfo(info,level)
end,
}


local lookupData={}

local lookupHandle={
[eRankListType.eFaBaoFight]=function(rankList)
local datas={}
for i,v in ipairs(rankList)do
local itemData=v.fbInfo
datas[tostring(itemData.itemguid)]=i
end
lookupData[eRankListType.eFaBaoFight]=datas
end
}


function rankListModel:onAppStart()
hunDunBeiModel:onAppStart()
wanLingBeiModel:onAppStart()
wuJiBeiModel:onAppStart()
end


function rankListModel:onEnterState()
hunDunBeiModel:onEnterState()
wanLingBeiModel:onEnterState()
wuJiBeiModel:onEnterState()
end


function rankListModel:onLeaveState()

self.data={}
lookupData={}
self.time={}
self.number={}
hunDunBeiModel:onLeaveState()
wanLingBeiModel:onLeaveState()
wuJiBeiModel:onLeaveState()
end


function rankListModel:onServerDataInitFinish()
hunDunBeiModel:onServerDataInitFinish()
wanLingBeiModel:onServerDataInitFinish()
wuJiBeiModel:onServerDataInitFinish()
end




function rankListModel:setRankList(rankType,rankList)
self.data[rankType]=rankList

local exHandle=lookupHandle[rankType]
if exHandle then
exHandle(rankList)
end
end

function rankListModel:getRankList(rankType)
local list={}
if exportRankList[rankType]then
list=exportRankList[rankType]()
end
if#list>1 then
table.sort(list,function(a,b)
return a.rankNum<b.rankNum
end)
end
return list
end

function rankListModel:setRankNo(rankType,rankNum)
self.number[rankType]=rankNum
end

function rankListModel:getRankNo(rankType)
return self.number[rankType]
end

function rankListModel:getPlayerInfo(rankType)
local kuangAnimType,kuangAnim=playerModel:getActorHeadKuangAnim()
local info={
actorId=playerModel:getActorID(),
playerName=playerModel:getActorName(),
zmLevel=playerModel:getActorLevel(),
head=playerModel:getActorIconInfo(),
serverId=loginModel.server_id,
serverName=loginModel:getMyServerName(),




zmName=UISettingModel:getZMName()
}
if appendPlayerInfo[rankType]then
appendPlayerInfo[rankType](info)
return info
end
return info
end

function rankListModel:setRankTime(rankType,time)
self.time[rankType]=time
end

function rankListModel:checkRankTime(rankType)
local nextTime=self.time[rankType]
if nextTime then
return timeHelper.getServerShortTime()>=nextTime
end
return true
end

function rankListModel.getFrameName(number)
if number>0 and number<=3 then
return FMT.fmt("icon_phbmingci_{0}",number)
end
end

function rankListModel.getFrameName2(number)
if number>0 and number<=3 then
return FMT.fmt("frame_phbkuang_{0}",number)
end
end

function rankListModel.getNumberStr(number)
if number<=0 then
return"未上榜"
else
return tostring(number)
end
end

function rankListModel:findFabao(itemguid)








local lookupList=lookupData[eRankListType.eFaBaoFight]
if lookupList then
local index=lookupList[tostring(itemguid)]
if index then

local rankData=self.data[eRankListType.eFaBaoFight][index]
if rankData then
return rankData.fbInfo
end
end
end
end

function rankListModel:getXianFaWenDaoRankList(level)
local temp={}
if level==nil then return temp end

local list=UIXianFaWenDaoControl:getRankDataByLevel(level)

for i,v in ipairs(list)do
local data={rankNum=v.rank or i,}
if v.actorid then
data.actorId=v.actorid
data.playerName=v.actorname
data.head=v.iconInfo
data.data={v.score,}
data.server=v.serverid
end
table.insert(temp,data)
end

return temp
end

function rankListModel:addXianFaWenDaoPlayerInfo(info,level)
if level==nil then return end
local myLevel=UIXianFaWenDaoControl:getLevel()
local myRank=UIXianFaWenDaoControl:getRank()
local score=UIXianFaWenDaoControl:getScore()
info.number=myLevel==level and myRank or 0
info.data=myLevel==level and score or nil
end

function rankListModel:getRankListBy_rankItemVoc(rankType)
local list=rankListModel.data[rankType]or{}
local temp={}
for i,v in ipairs(list)do
local data={
actorId=v.actorId,
playerName=v.name,
zmName=v.sectname,
head=v.iconInfo,
rankNum=v.rank,
data={
v.fightvalue
},
server=v.serverId,
discipleguid=v.discipleguid,
disciplename=v.disciplename,
discipledata=v.discipledata,
discipleimage=v.discipleimage,
discipleweapon=v.discipleweapon,
discipledress=v.discipledress,
}
table.insert(temp,data)
end
return temp
end

function rankListModel:getRankListBy_rankItem1(rankType,localServer)
local list=rankListModel.data[rankType]or{}
local temp={}
for i,v in ipairs(list)do
local data={
actorId=v.actorId,
playerName=v.name,
zmName=v.zmName~=""and v.zmName or nil,
head=v.iconInfo,
zmLevel=v.zmLevel,
rankNum=v.rank,
data={
v.zmFight,
},
sex=v.sex,
server=not localServer and v.serverId or nil,
}
table.insert(temp,data)
end
return temp
end

function rankListModel:getRankListBy_rankItem11(rankType,localServer)
local list=rankListModel.data[rankType]or{}
local temp={}
for i,v in ipairs(list)do
local data={
actorId=v.actorId,
playerName=v.name,
head=v.iconInfo,
zmLevel=v.zmLevel,
rankNum=i,
lv=v.lv or 0,
exp=v.exp or 0,
server=not localServer and v.serverId or nil,
}
table.insert(temp,data)
end
return temp
end
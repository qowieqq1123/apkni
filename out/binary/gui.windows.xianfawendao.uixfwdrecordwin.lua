







def_class("UIXFWDRecordWin",UIWindowBase)









function UIXFWDRecordWin:bindComponents()

self.infoScrollView=UIObject.get(self,0)
self.empty=UIObject.get(self,1)



end


function UIXFWDRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoScrollView);self.infoScrollView=nil;
_UIObject_release(self.empty);self.empty=nil;
end



















function UIXFWDRecordWin:onLoaded(...)
self:bindComponents()

self.myServerName=loginModel:getMyServerName()

self.infoScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXFWDRecordWin:__delete()
self:unbindComponents()
end




function UIXFWDRecordWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIXFWDRecordWin:refresh()
local datas=UIXianFaWenDaoControl:getRecordData()
local len=#datas
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
local currtime=gameUtilityModel.getServerShortTime()
local icon=UIXianFaWenDaoControl:getScoreIconName()

local tt,ft,pt=UIXianFaWenDaoControl:getAllChallengeTimes()
self.hasTimes=pt>0
self.hasFree=ft>0

self.empty:setActive(len<=0)

self.infoScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.infoScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
self:setHeadIconAndName(item,data)


local dt=currtime-data.sec
item:SetChildText(2,timeHelper.format_time_stamp14(dt))
if data.score==0 then
item:SetChildText(3,'无变化')
else
local color=data.score>=0 and'green'or'red'
item:SetChildText(3,FMT.fmt('<color={0}>{1}</color>',color,data.score))
end
local needMoney
if self.hasFree or not self.hasTimes then
item:SetChildActive(8,false)
else
item:SetChildActive(8,true)
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local index=tt-cfg.free+1
local md=cfg.consume[index][1]
local iconName=moneyModel.getIconNameEx(md[1])
item:SetChildIcon(9,iconName,true)
item:SetChildText(10,md[2])
needMoney=md
end
item:SetChildIcon(4,icon,true)
if data.back==0 and not isTruce then
item:SetChildActive(5,true)
item:SetChildButtonClick(5,function()
if self.hasTimes then
if needMoney then
local have=moneyModel.getMoney(needMoney[1])
if have<needMoney[2]then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(needMoney[1])))
return
end
end
if UIXianFaWenDaoControl:isMoneyNumFull()then
local tips=FMT.fmt('今日{0}已达获取上限，是否跳转？',moneyModel.getMoneyName(eMoneyType.mtZhanYuDian))
UIDialogManager.getConfirmDialog3(nil,tips,function()
self.monData=data
self:reqAndOpenFightingWin(i)
end,REPEAT_TYPE.eXFWDZhanYUDain)
else
self.monData=data
self:reqAndOpenFightingWin(i)
end
else
UIManager.error('挑战次数不足')
end
end)
else
item:SetChildActive(5,false)
end
item:SetChildButtonClick(6,function()
self:replayFight(data)
end)


item:SetChildCSImageSprite(7,globalABLookup.global,'image_gongfangbj_'..(data.recordtype==1 and 2 or 1))
end
end

function UIXFWDRecordWin:replayFight(data)
local args={eReplayType=eRePlayerType.xianfawendao}

local myserver=FMT.fmt('[{0}]',loginModel:getMyServerName())
args.player1={playerModel:getActorID(),playerModel:getActorName(),playerModel:getActorIconInfo(),myserver}
local name
local info
local server
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(data.actorid)
if robbotType==1 then
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
if robotcfg then
local actoricon=robotcfg.headImage[1]
actoricon=bit.bor(actoricon,bit.lshift(robotcfg.headImage[2],16))
info={actoricon=actoricon}
name=UIXianFaWenDaoControl:getRobbitName(data.actorid,robotID)
server=loginModel:getMyServerName()

else
logErr(FMT.fmt('缺少机器人配置{0}',robotID))
end
else
if not data.actorname or data.actorname==''then
name=UIXianFaWenDaoControl:getRobbitName(data.actorid,1,true)
server=loginModel:getMyServerName()

else
name=data.actorname
server=loginModel:getServerName(data.serverid)

end
info=data.iconInfo
end
server=FMT.fmt('[{0}]',server)
args.player2={data.actorid,name,info,server}

if data.recordtype==0 then
local player=args.player1
args.player1=args.player2
args.player2=player
end
fightController:send_log_list(data.list,args,true)
end

function UIXFWDRecordWin:setHeadIconAndName(item,data)
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(data.actorid)
if robbotType==1 then
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
if robotcfg then
local actoricon=robotcfg.headImage[1]
actoricon=bit.bor(actoricon,bit.lshift(robotcfg.headImage[2],16))
playerController:setHeadIcon(item,0,{scale=0.6,iconInfo={actoricon=actoricon}})
local name=UIXianFaWenDaoControl:getRobbitName(data.actorid,robotID)
item:SetChildText(1,FMT.fmt('<color=#ca631d>[{0}]</color>{1}',self.myServerName,name))
else
logErr(FMT.fmt('缺少机器人配置{0}',robotID))
end
elseif data.iconInfo.actoricon==0 then
local sname=loginModel:getServerName(data.serverid)
local name=data.actorname
item:SetChildActive(11,true)
item:SetChildText(1,FMT.fmt('<color=#ca631d>[{0}]</color>{1}',sname,name))
else
item:SetChildActive(11,false)
playerController:setHeadIcon(item,0,{scale=0.6,iconInfo=data.iconInfo})
local sname=loginModel:getServerName(data.serverid)
local name=data.actorname
if not name or name==''then
name=UIXianFaWenDaoControl:getRobbitName(data.actorid,1,true)
end
item:SetChildText(1,FMT.fmt('<color=#ca631d>[{0}]</color>{1}',sname,name))
end
end


function UIXFWDRecordWin:onHide()

end

function UIXFWDRecordWin:getMyTeamData()
local team=UIXianFaWenDaoControl:getTeam()
local teamData={{},{},{}}
for i,v in ipairs(team)do
local dzId=tostring(v)
if dzId~='0'then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[dzId]={pId,1,v}
end
end
return teamData
end

function UIXFWDRecordWin:getMultipleMonsterList(monList)
local list={}
for i,v in ipairs(monList)do
local mcfg=cfgHelper.get1(cfg_monstergroup_get,v)
local tlist={}
list[i]=tlist
for ii,monsterID in ipairs(mcfg.monList)do
local d={typo=fightEntityType.monster,monsterID=monsterID}
table.insert(tlist,d)
end
end
return list
end

function UIXFWDRecordWin:reqAndOpenFightingWin(index)
local datas=UIXianFaWenDaoControl:getRecordData()
local data=datas[index]
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(data.actorid)
local callback=function(rec_data)
local teamData={{},{},{}}
for i,v in pairs(rec_data)do
if v.flag==1 then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[#tdata+1]={pos=pId,typo=fightEntityType.diZi,guid=v.discipleguid,netData=v}
end
end

UIXianFaWenDaoControl:showXianFaWenDaoAdjustWin({selectIndex=index,monTeam=teamData,dataType=XFWD_DATA_TYPE.eRecord})
end
if robbotType==1 then
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
local monList=self:getMultipleMonsterList(robotcfg.monTeamId)

UIXianFaWenDaoControl:showXianFaWenDaoAdjustWin({selectIndex=index,monTeam=monList,dataType=XFWD_DATA_TYPE.eRecord})
else
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eXianFaWenDao1,data.actorid,{serverid=data.serverid},callback,true)
end
end

function UIXFWDRecordWin:openFightingWin(index,monTeam)
local myTeam=self:getMyTeamData()
local faZeData=UIXianFaWenDaoControl:getFazeList()
local monData=self.monData
local flag=self.hasFree and 0 or 1
fightController.showPrepareWin(fightPreSelectModel.fightType.xianfawendao,{
enterTxt='仙法问道',
mapId=818004,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
skipShouYuanCheck=true,
isHomeBattle=true,
multipleMonsterListEx=monTeam,
multipleTeams=myTeam,
showZhenFa=false,
faZeData=faZeData,
statePriorityCheck=false,
enterCallBack=function(teamList,zfId)
fightLaunchController:sendFightEx(eBattleLaunch.xianfawendao,teamList,{index,flag})
local args={}
local name=FMT.fmt('[{0}]{1}',loginModel:getMyServerName(),playerModel:getActorName())
args.player1={name,playerModel:getActorIconInfo()}
args.player2={monData.actorname,monData.iconInfo}
fightModel:setSendExtraArgs(eBattleType.xianfawendao,args)
end,
cancelCallBack=function()
UIXianFaWenDaoControl:showXianFaWenDaoWin({subWin=3})
end
})
end




function UIXFWDRecordWin:onCloseClick()
self:closeSelf()
end
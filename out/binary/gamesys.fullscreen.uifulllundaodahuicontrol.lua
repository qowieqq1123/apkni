







UIFullLunDaoDaHuiControl=gameState.addListener(fullScreenUI.create())

UIFullLunDaoDaHuiControl.tagList=
{
{
name="选拔赛",
panel="UIXuanBaSaiMainWin",
reddot=function()
return lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.xuanBa})
end,
},
{
name="淘汰赛",
child=
{
{
name="小组赛",
panel="UIXiaoZuSaiMainWin",
reddot=function()
local fightList=lundaodahuiModel:getXiaoZuFight()
for _,group in ipairs(fightList)do
for _,id in ipairs(group)do
local check=lundaodahuiModel:checkJingCai(id)
if check then
return true
end
end
end
if lundaodahuiModel:checkRongYuTangReddot()then
return true
end

if lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.top8,eLDMatchType.top16,eLDMatchType.top32})then
return true
end

return false
end,
args={selectPlayer=true},
},
{
name="半决赛",
panel="UIBanJueSaiMainWin",
reddot=function()
local fightList=lundaodahuiModel:getBanJueSaiFight()
for _,id in ipairs(fightList)do
local check=lundaodahuiModel:checkJingCai(id)
if check then
return true
end
end

if lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.banjuesai})then
return true
end
return false
end
},
{
name="决赛",
panel="UIJueSaiMainWin",
reddot=function()
local fightList=lundaodahuiModel:getJueSaiFight()
for _,id in ipairs(fightList)do
local check=lundaodahuiModel:checkJingCai(id)
if check then
return true
end
end

if lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.jijunsai,eLDMatchType.juesai})then
return true
end
return false
end
},
},

reddot=function()
return lundaodahuiModel:checkJingCaiAllReddot()or lundaodahuiModel:checkRongYuTangReddot()or(lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.top32,eLDMatchType.top16,eLDMatchType.top8,eLDMatchType.banjuesai,eLDMatchType.jijunsai,eLDMatchType.juesai}))
end
},
{
name="决赛直播",
child=
{
{
name="季军赛",
panel="UIJueSaiZhiBoWin",
args={matchType=6},
},
{
name="冠军赛",
panel="UIJueSaiZhiBoWin",
args={matchType=7},
},
},
},
}

local tielianControl=
{
panel="UIJueSaiTieLianWin",
check=function()
local match1=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)

local match2=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)

local nowTime=timeHelper.getServerLongTime()
return mainViewsControl.isOpen()and MysteryModel:get_cur_fbid()==nil and(gameplotModel:isFinish())and(not fightModel:haveBattleShow())and
((match1 and((nowTime>=match1-600 and nowTime<match1+120)))or(match2 and(nowTime>=match2-600 and nowTime<match2+120)))
end
}

function UIFullLunDaoDaHuiControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eLunDaoDaHui,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end


function UIFullLunDaoDaHuiControl:showLunDaoDaHui(argstable)
local tabType=FULL_TAB_TYPE.eLDXuanBaSai

local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILunDaoDaHuiLeftWin'},
viewArgs={['UILunDaoDaHuiLeftWin']=argstable},
}
self:showUI(args)
end


function UIFullLunDaoDaHuiControl:showLookRivalWin(actor_id,teamList)
local lookType=DOUFATAI_LOOK_TYPE.eLunDaoTeam
local extra=lundaodahuiModel:getCurLookData(actor_id)
self:showWindow("UIDouFaTaiLookRivalWin",{lookType=lookType,actor_id=actor_id,teamList=teamList,extra=extra})
lundaodahuiModel:setCurLookData(actor_id)
end

function UIFullLunDaoDaHuiControl:showLookRivalWinNew(actor_id,lookData,openWin)
local sendId=nil
if type(actor_id)=="number"then
sendId=int64.new(actor_id)
else
sendId=actor_id
end

local callback
if openWin then
callback=function(teamDzList,otherArgs)
lookData=lookData or{}
UIManager:showWindow("UICommonLookRivalWin",{lookType=DOUFATAI_LOOK_TYPE.eLunDaoTeam,teamList=teamDzList,bgType=1,otherArgs={playerHeadInfo=lookData[2],name=lookData[3],serverId=lookData[1]}})
end
end
otherPlayerController:reqCommonInfo(actor_id,otherPlayerInfoType.eLunDaoDaHuiFight,{serverid=lookData[1]},callback)
end


function UIFullLunDaoDaHuiControl:showTieLian()
if not tielianControl.check()then
return
end

UIManager:showWindow(tielianControl.panel)
end
buildTiaoZhanConfig={}


buildShiLianTaFightType=
{
eShiLianTa=1,
eWuXingDian=2,
eJiuYouTa=3,
}

buildShiLianTaFightFunc=
{
[buildShiLianTaFightType.eShiLianTa]=
{
completeFight=function()
local battleId=shiLianTaModel:getPlayingBattle()
if battleId then
fightController:completeBattle(battleId,true)
end
end,
},
[buildShiLianTaFightType.eWuXingDian]=
{
completeFight=function()
local battleId=wuXingDianController:getBattle(true)
if battleId then
fightController:completeBattle(battleId,true)
end
end,
},
[buildShiLianTaFightType.eJiuYouTa]=
{
completeFight=function()
local battleId=JiuYouTaModel:getPlayingBattle()
if battleId then
fightController:completeBattle(battleId,true)
end
end,
},
}


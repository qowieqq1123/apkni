









local _MODULENAME="fightRePlayHandle"




def_table(_MODULENAME)
fightRePlayHandle.name=_MODULENAME

local handle={

[eRePlayerType.doufatai]={

battleType=eBattleType.doufatai,
showStage=true,
hideExitWatch=true,
exchangeHp=true,
onStartBattle=function(battleId,args)
UIFullDouFaTaiControl:closeUI(false)

local Record=args[1]
local selfName=playerModel:getActorName()
local head,kuang,name,wendao,playerHead=douFaTaiModel:getDouFaTaiActorInfo(Record)
if not playerHead then
playerHead=playerModel:getActorIconInfoByCfg(head,kuang)
end
local winArgs={selfName,nil,name,playerHead}
local battle=fightModel:getBattle(battleId)
if battle then
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()
local actorId=playerModel:getActorID()
if rightId and tostring(tonumber(tostring(rightId)))==tostring(tonumber(tostring(actorId)))then
winArgs={name,playerHead,selfName,nil,isExchange=true}
end
winArgs.leftId=leftId
winArgs.rightId=rightId
end
UIManager:showWindow('UIDouFaTaiPlayBackWin',winArgs)






end,
onCompleteBattle=function(battle)
UIManager:closeWindow('UIDouFaTaiPlayBackWin')

if battle then
douFaTaiController.closeBattle(battle)
end
end,
onCloseBattle=function(battle)

end,
},

[eRePlayerType.lundaodahui]={
battleType=eBattleType.doufatai,
showStage=true,
hideExitWatch=true,
onStartBattle=function(battleId,args)
UIFullLunDaoDaHuiControl:closeUI(false)
local dzPlayer=args[1]
local serverName1=loginModel:getServerName(dzPlayer[1].serverId)
local serverName2=loginModel:getServerName(dzPlayer[2].serverId)

local nameStr1=FMT.fmt("{0}",serverName1)
local nameStr2=FMT.fmt("{0}",serverName2)
local winArgs={dzPlayer[1].name,dzPlayer[1].iconInfo,dzPlayer[2].name,dzPlayer[2].iconInfo,hideFlag=true,showWinTimes=args.showWinTimes}
UIManager:showWindow('UIDouFaTaiPlayBackWin',winArgs)
end,
onCompleteBattle=function(battle,args)
UIManager:closeWindow('UIDouFaTaiPlayBackWin')

if battle then
fightController:closeBattle(battle)
end
local page=args~=nil and args.page
local subPage=args~=nil and args.subType
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=page,subPage=subPage})
if args.groupArgs then
local selectPage,lastY=unpack(args.groupArgs)
UIManager:showWindow("UILDGroupInfoWin",{selectPage=selectPage,lastY=lastY})
end
lundaodahuiModel:setZhiBoFlag(nil)
end,
onCloseBattle=function(battle)

end,
},

[eRePlayerType.lundaodahuiJueSai]={
battleType=eBattleType.lundaodahuiJueSai,
showStage=true,

mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battleId,args)
UIFullLunDaoDaHuiControl:closeUI(false)
if not args.showWinTimes then
local dzPlayer=args[1]
local winArgs={dzPlayer[1].name,dzPlayer[1].iconInfo,dzPlayer[2].name,dzPlayer[2].iconInfo,hideFlag=true,showWinTimes=args.showWinTimes}
UIManager:showWindow('UIDouFaTaiPlayBackWin',winArgs)
end

UIManager:showWindow('UIJueSaiZhiBoDanMuWin')
end,
onCompleteBattle=function(battle,args)
UIManager:closeWindow('UIDouFaTaiPlayBackWin')
UIManager:closeWindow('UIJueSaiZhiBoDanMuWin')

if battle then
fightController:closeBattle(battle)
end
local isReconnet=args.isReconnet
if not isReconnet then
local page=args~=nil and args.page
local subPage=args~=nil and args.subPage
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=page,subPage=subPage})

if args and(not args.showBattle)then
local extraargs={}
extraargs.player1={FMT.fmt("{0}{1}",args.player1[4],args.player1[2]),args.player1[3]}
extraargs.player2={FMT.fmt("{0}{1}",args.player2[4],args.player2[2]),args.player2[3]}
fightModel:setSendExtraArgs(eBattleType.lundaodahuiJueSai,args)
if args.logList then
fightController.openReplayWin(eRePlayerType.lundaodahuiJueSai,args.logIdList,args.logList,args)
end

end
end

lundaodahuiModel:setZhiBoFlag(nil)
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true,true)
end,
},

[eRePlayerType.shilianta]={
battleType=eBattleType.shilianta,
showStage=true,
onStartBattle=function(battleId,args)

UIFullFightControl:showWindow("UIShiLianTaFightTop",args[1])

fightManager.initCamera(Vector3.New(0,1.1,-2.5),Vector3.New(0,0,0),Vector3.New(0,-1.3,-1.35),Vector3.New(0,0.3,2.5),15)
end,
onCompleteBattle=function(battle,args)

fightController:closeBattle(battle,args)
shiLianTaController:showEnterWindow(nil,args[1],function()
UIFullFightPrepareControl:showWindow('UIShiLianTaLogWin',{layer=args[1]})
end)
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true)
shiLianTaController:showEnterWindow(nil,args[1],function()
UIFullFightPrepareControl:showWindow('UIShiLianTaLogWin',{layer=args[1]})
end)
end,
},

[eRePlayerType.jiuyaota]={
battleType=eBattleType.jiuyouta,
showStage=true,
onStartBattle=function(battleId,args)

UIFullFightControl:showWindow("UIShiLianTaFightTop",args[1])

fightManager.initCamera(Vector3.New(0,1.1,-2.5),Vector3.New(0,0,0),Vector3.New(0,-1.3,-1.35),Vector3.New(0,0.3,2.5),15)
end,
onCompleteBattle=function(battle,args)

fightController:closeBattle(battle,args)




end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true)
UIFullJiuYouTaControl:showJiuYouTaWindow(nil,args.layer,function()
UIFullFightPrepareControl:showWindow('UIJiuYouTaLogWin',{layer=args.layer})
end)
end,
},

[eRePlayerType.jiucengyaolou]={
battleType=eBattleType.jiucengyaolou,
showStage=true,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

fightController:closeBattle(battle,args)
activitiesController:jump(args.data.act_id,SUB_ACTIVITY_TYPE.eJiuCengYaoLou,args.data.act2_id,{jumpIndex=args.data.jumpIndex})
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true)

end,
},

[eRePlayerType.zongmendabi]={
battleType=eBattleType.zongmendabi,
showStage=true,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

fightController:closeBattle(battle,args)
activitiesController:jump(args.data.actID,args.data.subType,args.data.subid,{tab_idx=args.data.tab_idx})
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true)
end,
},

[eRePlayerType.lingxuwenjian]={
battleType=eBattleType.lingxuwenjian,
showStage=true,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

local isReconnet=args.isReconnet
if not isReconnet then
local func=function()
fightController:closeBattle(battle,args)
local openPos={args.data.src,args.data.lxwjtype,args.data.lxwjkey}
openPos.openReplay=args.data.openReplay
local jumpParam={openPos=openPos}
limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end
loadingControl.openCloud(func)
lingxuwenjianController:setMarkCloud(true)
end
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true)
end,
},

[eRePlayerType.lingxuwenjian2]={
battleType=eBattleType.lingxuwenjian2,
showStage=true,
hideExitWatch=true,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

local isReconnet=args.isReconnet
if not isReconnet then
local func=function()
fightController:closeBattle(battle,args)
local openPos={args.data.src,args.data.lxwjtype,args.data.lxwjkey}
openPos.openReplay=args.data.openReplay
local jumpParam={openPos=openPos}
limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end
loadingControl.openCloud(func)
lingxuwenjianController:setMarkCloud(true)
end
end,
onCloseBattle=function(battle)

end,
},

[eRePlayerType.lingxuwenjian3]={
battleType=eBattleType.lingxuwenjian3,
showStage=true,
hideExitWatch=true,

onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battleId,args)

local isReconnet=args.isReconnet
if not isReconnet then
local openPos={args.data.src,args.data.lxwjtype,args.data.lxwjkey}
openPos.openReplay=args.data.openReplay
local callback=function()
fightController:closeBattle(battleId,args)
local jumpParam={openPos=openPos}
limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end
local result=args.data.result
fightResultController:startResult({eShowResultType.lingxuwenjian3,eBattleType.lingxuwenjian3,result,battleId,
{},callback,{{openPos[1],openPos[2],openPos[3],result}},true,nil})
end
end,
onCloseBattle=function(battle)

end,
},

[eRePlayerType.xianfawendao]={
battleType=eBattleType.xianfawendao,
showStage=true,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

fightController:closeBattle(battle,args)
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true)
UIXianFaWenDaoControl:showXianFaWenDaoWin({subWin=3})
end,
},

[eRePlayerType.diziqiecuo]={
battleType=eBattleType.qiecuo,
showStage=true,
hideExitWatch=true,
exchangeHp=false,
onStartBattle=function(battleId,args)
local selfName=args.data.myname
local selficonInfo={actoricon=args.data.myactoricon,piList=args.data.mypiList}

local otherName=args.data.othername
local othericonInfo={actoricon=args.data.otheractoricon,piList=args.data.otherpiList}

local winArgs={selfName,selficonInfo,otherName,othericonInfo}
UIManager:showWindow('UIQieCuoPlayBackWin',winArgs)

end,
onCompleteBattle=function(battle,args)
UIManager:closeWindow('UIQieCuoPlayBackWin')

local myactorid=args.data.myname
local myseverid=args.data.myseverid
local iconInfo={actoricon=args.data.otheractoricon,piList=args.data.otherpiList}
local myiconInfo={actoricon=args.data.myactoricon,piList=args.data.mypiList}
local duishouactorid=iconInfo
local duishouseverid=args.data.otherseverid
local othername=args.data.othername
local myname=args.data.myname

local selfFright=args.data.selfFright or nil
local otherFright=args.data.otherFright or nil


local callback=function()
fightController:closeBattle(battle)
end
if args.data.fightresult==1 then
fightResultController:startResult({eShowResultType.qiecuo,eBattleType.qiecuo,fightResultType.Victory,battle,
{},callback,{{false,myseverid,false,duishouseverid,iconInfo,othername,myiconInfo,myname,true,selfFright,otherFright}},true,nil})
else
fightResultController:startResult({eShowResultType.qiecuo,eBattleType.qiecuo,fightResultType.Lose,battle,
{},callback,{{false,myseverid,false,duishouseverid,iconInfo,othername,myiconInfo,myname,true,selfFright,otherFright}},true,nil})
end
end,
onCloseBattle=function(battle,args)

local cbtype=DiZiDuelModel:getCallBackType()
if cbtype then
local cbfun=DiZiDuelModel:getCallBackFun(cbtype,nil,nil)
if cbfun then
cbfun()
end
DiZiDuelModel:setCallBackType(false)
end
end,
},


[eRePlayerType.wuxingdian]={
battleType=eBattleType.wuxingdian,
showStage=true,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

fightController:closeBattle(battle,args)
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true)
end,
},

[eRePlayerType.shanhailog]={
battleType=eBattleType.zhengzhanshanhailog,
showStage=true,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

local callback=function()
fightController:closeBattle(battle)
limitActivitiesController:jump(LIMIT_ACT_TYPE.eZhengZhanShanHai,{showCloud=false,log_jump=args[5],log_jump_args=args.log_jump_args,is_jijie=args[9],not_showlogtips=true})
end
if args[5]==2 or args[5]==3 then
callback()
else

if args[8]==1 then
fightResultController:startResult({eShowResultType.zhengzhanshanhailog,eBattleType.zhengzhanshanhailog,fightResultType.Victory,battle,
{},callback,{args[4],args[5],args[6],args[7],args[9]},true,nil})

elseif args[8]==0 then
fightResultController:startResult({eShowResultType.zhengzhanshanhailog,eBattleType.zhengzhanshanhailog,fightResultType.Lose,battle,
{},callback,{args[4],args[5],args[6],args[7],args[9]},true,nil})
end
end
end,
onCloseBattle=function(battle,args)



fightController:completeBattle(battle,true,true)
end,
},

[eRePlayerType.xianjielog]={
battleType=eBattleType.xianjielog,
showStage=true,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

local isMXSL=args.isMXSL
local mxslPageIdx=args.mxslPageIdx
local callback=function()
fightController:closeBattle(battle)
if not isMXSL then
xianjieController:OpenZhengZhanShanHaiMonsterLog()
else
local shipGuid=args.shipGuid
if not shipGuid then
mxslPageIdx=mxslPageIdx or 1
UIFullXJCaravanEscortController:showMainWindow_openRecordWin(mxslPageIdx)
else
local isOpenWithMainWin=args.isOpenWithMainWin
UIFullXJCaravanEscortController:showMainWindow_openShipRecordWin(shipGuid,isOpenWithMainWin)
end
end
local temp=xianjieController:getjbTozb()
if temp then
xianjieController:setjbTozb(false)
UIManager:showWindow('UIXianJie_notejianbao',temp)
end
end

if not args[4]then
callback()
else
if args[5]==1 then
fightResultController:startResult({eShowResultType.xianjielog,eBattleType.xianjielog,fightResultType.Victory,battle,
{},callback,{args[4],newLogic=args.newLogic},true,nil})
elseif args[5]==0 then
fightResultController:startResult({eShowResultType.xianjielog,eBattleType.xianjielog,fightResultType.Lose,battle,
{},callback,{args[4]},true,nil})
else
callback()
end
end
end,
onCloseBattle=function(battle,args)



fightController:completeBattle(battle,true,true)
end,
},

[eRePlayerType.systemZongMenAttack]={
battleType=eBattleType.systemZongMenAttack,
showStage=true,
hideExitWatch=true,
onStartBattle=function(battleId,args)
if args.showResult then
local resultData=args.resultData
systemZongMenController:popBattleResultNotify(resultData.serial)
end
UIFullFightControl:showWindow("UISystemZongMenFightRoundWin",{battle=battleId})
end,
onCompleteBattle=function(battle,args)
UIFullFightControl:closeWindow('UISystemZongMenFightRoundWin')
if args.showResult then
local resultData=args.resultData
local callback=function()
fightController:closeBattle(battle)
end

fightResultController:startResult({eShowResultType.systemZongMenAttack,eBattleType.systemZongMenAttack,resultData.result,battle,
{},callback,{resultData.serial},true,nil})
else
fightController:closeBattle(battle)
end
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true,true)
end,
},

[eRePlayerType.systemZongMenDefense]={
battleType=eBattleType.systemZongMenDefense,
showStage=true,
hideExitWatch=true,
onStartBattle=function(battleId,args)
if args.showResult then
local resultData=args.resultData
systemZongMenController:popBattleResultNotify(resultData.serial)
end
UIFullFightControl:showWindow("UISystemZongMenFightRoundWin",{battle=battleId})
end,
onCompleteBattle=function(battle,args)
UIFullFightControl:closeWindow('UISystemZongMenFightRoundWin')
fightController:closeBattle(battle)
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true,true)
end,
},

[eRePlayerType.wendingcangqiong]={
battleType=eBattleType.wengdingcangqiong,
showStage=true,
showSkipAll=true,
onStartBattle=function(battleId,args)


end,
onCompleteBattle=function(battle,args)
UIFullFightControl:closeWindow('UIWDCQPlayBackWin')
if args and args.fightCloseCallBack then
args.fightCloseCallBack(battle)
args.fightCloseCallBack=nil
end

end,
onCloseBattle=function(battle,args)

end,
},

[eRePlayerType.xiweisailog]={
battleType=eBattleType.wdcqxiweisai,
showStage=true,
showSkipAll=true,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battleId,args)
end,
onCompleteBattle=function(battle,args)



if args and args.fightCloseCallBack then
args.fightCloseCallBack(battle)
args.fightCloseCallBack=nil
end
end,
onCloseBattle=function(battle,args)

end,
},

[eRePlayerType.xianguanwuxuanlog]={
battleType=eBattleType.xianguanwuxuan,
showStage=true,
showSkipAll=true,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)
fightController:closeBattle(battle)
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true,true)

local segment=xianguanModel:getWuXuanActivitySegment()
if segment==XianGuanWuXuanSegment.eMatch or segment==XianGuanWuXuanSegment.eFinish then
UIFullXJForceControl:jumpJingXuanMainWindow(XianGuanCampaignType.eWuXuan)
end
end,
},

[eRePlayerType.xingyu]={
battleType=eBattleType.xingyu,
showStage=true,
showSkipAll=true,
exchangeHp=true,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battleId,args)
loadingControl.closeCloud()
end,
onCompleteBattle=function(battle,args)



local result=args.result
if args and args.fightCloseCallBack then
if not result then
args.fightCloseCallBack(battle)
args.fightCloseCallBack=nil
else
fightResultController:startResult({eShowResultType.xingyu,eBattleType.xingyu,result,battle,
{},args.fightCloseCallBack,{{result,args.round}},true,nil})
end



end

end,
onCloseBattle=function(battle,args)

end,
},

[eRePlayerType.xianjunyanzhen]={
battleType=eBattleType.xianjunyanzhen,
showStage=true,
useReportMapId=true,
mulitResultType=eFightMulitResultType.ResultOneTimes,
onStartBattle=function(battleId,args)

end,
onCompleteBattle=function(battle,args)

UIManager:showWindow("UIFightPrepareLoading",{para=1})
timeEventController.delayDo(0.5,function()
fightController:closeBattle(battle,args)
UIFullXianJunYanZhenControl:showRecordWindow({gx_id=args[4]})
end)
end,
onCloseBattle=function(battle,args)
fightController:completeBattle(battle,true,true)
end,
},
}

function fightRePlayHandle:getHandle(eType)
return handle[eType]
end

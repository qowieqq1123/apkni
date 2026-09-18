









local _MODULENAME="fightResultWinConfig"
def_table(_MODULENAME)

fightResultWinConfig.name=_MODULENAME






local _baseWinConfig={









["UICommonVictoryWin"]={
[0]=function()
return{}
end,
[1]=function(quitBtnName,quitCallBack)
return{
hideContinue=true,
quitBtnName=quitBtnName,
quitCallBack=quitCallBack
}
end,
[2]=function(continueBtnName,continuCallBack,quitBtnName,quitCallBack)
return{
hideContinue=false,
continueBtnName=continueBtnName,
continuCallBack=continuCallBack,
quitBtnName=quitBtnName,
quitCallBack=quitCallBack,
}
end,
[3]=function(continueBtnName,continuCallBack,quitBtnName,quitCallBack,cd,hideContinue)
return{
hideContinue=hideContinue or false,
continueBtnName=continueBtnName,
continuCallBack=continuCallBack,
quitBtnName=quitBtnName,
quitCallBack=quitCallBack,
cd=cd,
}
end,
[4]=function(continuCallBack,quitCallBack,cd)
return{
continuCallBack=continuCallBack,
cd=cd,
quitCallBack=quitCallBack,
}
end,
[5]=function(continueBtnName,continueBtnDesc,continuCallBack,quitBtnName,quitCallBack,cd,hideContinue)
return{
hideContinue=hideContinue or false,
continueBtnName=continueBtnName,
continueBtnDesc=continueBtnDesc,
continuCallBack=continuCallBack,
quitBtnName=quitBtnName,
quitCallBack=quitCallBack,
cd=cd,
}
end,
[6]=function(continueBtnName,continuCallBack,quitBtnName,quitCallBack,disableCd,hideContinue)
return{
hideContinue=hideContinue or false,
continueBtnName=continueBtnName,
continuCallBack=continuCallBack,
quitBtnName=quitBtnName,
quitCallBack=quitCallBack,
disableCd=disableCd,
}
end,
[7]=function(quitBtnName,quitCallBack,delayClose)
return{
hideContinue=true,
quitBtnName=quitBtnName,
quitCallBack=quitCallBack,
delayClose=delayClose
}
end,
},





["UICommonLoseWin"]={
[1]=function(quitBtnName,quitCallBack)
return{
quitBtnName=quitBtnName,
quitCallBack=quitCallBack
}
end,
[2]=function(continueBtnName,continuCallBack,quitBtnName,quitCallBack)
return{
continueBtnName=continueBtnName,
continuCallBack=continuCallBack,
quitBtnName=quitBtnName,
quitCallBack=quitCallBack,
}
end,
[3]=function(percent,iconAb,iconName,tips)
return{
progressData={
percent=percent,
icon={iconAb,iconName},
tips=tips,
}
}
end,
},
["UICommonLoseWin2"]={
[1]=function(quitBtnName,quitCallBack)
return{
quitBtnName=quitBtnName,
quitCallBack=quitCallBack
}
end,
},
['UICommonLoseWin3']={

},
}






local _extraWinConfig={























["UIWorldBattleVictoryWin"]={
[1]=function(rewards)
local items,exp=worldFightModel:turnResult(rewards)
return{

items=items,
}
end,
[2]=function(rewards)
local items,exp=worldFightModel:turnResult(rewards)
local moneyTx=exp>0 and FMT.fmt("宗门经验  +{0}",exp)or nil
return{
money=moneyTx and{text=moneyTx}or nil,
items=items,
}
end,
[3]=function(items)
return{
items=items,
}
end,
[4]=function(items,title,tips)
return{
items=items,
title=title,
tips=tips,
}
end,
[5]=function(rewards,noRewardsTips)
local items,exp=worldFightModel:turnResult(rewards)
local money=nil
if items==nil or not next(items)then
money={text=noRewardsTips}
items=nil
end
return{

items=items,
money=money,
}
end,
[6]=function(rewards)
local items={}
if rewards then
for i,v in ipairs(rewards)do
table.insert(items,{
itemid=v.param_1,
itemcount=v.param_2,
sortWeight=0,
})
end
end
return{
items=items,
}
end,
[7]=function(items,title,money,tips)
return{
items=items,
title=title,
money=money,
tips=tips,
}
end,
[8]=function(items,title,tips)
return{
items=items,
title=title,
center_tips=tips,
}
end,
[9]=function(items,title,tips,param)
return{
items=items,
title=title,
center_tips=tips,
headdata_param=param,
}
end,
[10]=function(items,title,tips,progress)
return{
items=items,
closeTips=title,
tips=tips,
progress=progress,
}
end,
[11]=function(tgsldata)
return{
tgsldata=tgsldata,
}
end,
[12]=function(center_tips)
return{
title="",
center_tips=center_tips,
}
end,
[13]=function(sfpyWin_tips)
return{
sfpyWin_tips=sfpyWin_tips,
}
end,
},

["UIXJRZBattleLoseWin"]={
[1]=function(rzdata)
return{
rzdata=rzdata,
}
end,
},
























["UIWorldBattleLoseWin"]={






















},






["UIWuDaoVictoryWin"]={
[1]=function(disguid,xwexp)
return{
tipstr="入魔弟子已恢复清醒",
disguid=disguid,
xwexp=xwexp,
}
end,
},




["UIDouFaTaiVictoryWin"]={
[1]=function(args,prize,bId)
local rewards=prize or{}
args[5]=#rewards
args[6]=rewards
args[9]=bId
return args
end,
},




["UIXFWDResultWin"]={
[1]=function(rewards,rankInfo,resInfo,tips)
return{
rewards=rewards,
rankInfo=rankInfo,
resInfo=resInfo,
tips=tips
}
end,
},




["UIDouFaTaiLoseWin"]={
[1]=function(args,prize,bId)
local rewards=prize or{}
args[5]=#rewards
args[6]=rewards
args[9]=bId
return args
end,
},

["UIShiLianTaVictoryWin"]={
[1]=function(items,title,middle,bottom)
return{
items=items,
title=title,
middle=middle,
bottom=bottom,
}
end,
},






["UINPCPKVictoryWin"]={
[1]=function(npcid,intimacy,prize)
local rewards=prize or{}
return{
tipstr="你在切磋中获得了胜利。",
npcid=npcid,
intimacy=intimacy,
rewards=rewards,
}
end,
},

["UIXM_TYSC_VictoryWin"]={
[1]=function(data,prize)
local rewards=prize or{}
return{
data=data,
rewards=rewards,
}
end,
},

["UIXM_XMDG_resultWin"]={
[1]=function(data,prize)
local rewards=prize or{}
return{
data=data,
rewards=rewards,
}
end,
},

["UITuiTuVictoryWin"]={
[1]=function(rewards,tips)
return{
items=rewards,
tips=tips,
}
end,
},

["UISubAct_zongmendabi_result_win"]={
[1]=function(data,prize)
local rewards=prize or{}
return{
data=data,
rewards=rewards,
}
end,
},

["UIXM_LXWJ_result_win"]={
[1]=function(data,prize)
local rewards=prize or{}
return{
data=data,
rewards=rewards,
}
end,
},

["UIXM_LXWJ_wjresult_win"]={
[1]=function(data,prize)
local rewards=prize or{}
return{
data=data,
rewards=rewards,
}
end,
},

["UIQieCuoBattleLoseWin"]={
[1]=function(data)
return{
headdata_param=data,
}
end,
},
["UIWuXingDianBattleVictoryWin"]={
[1]=function(data)
local rewards=data[1]
local params=data[2][1]
local wxdId=params.temple_id
local layer=params.layer
local starTag=params.star_bits
local items,exp=worldFightModel:turnResult(rewards)

return{
items=items,
wxdId=wxdId,
layer=layer,
starTag=starTag,
}
end,
},

["UIYunYouMerchantFightResultWin"]={
[1]=function(tips,progress)
return{
tips=tips,
progress=progress,
}
end,
},
["UIVisitorChallengeFightResultWin"]={
[1]=function(prize,data)
return{
data=data,
items=prize or{},
}
end,
},
["UIVisitorChanllengeFightLoseWin"]={
[1]=function(prize,data)
return{
data=data,
items=prize or{},
}
end,
},
["UIZhengZhanShanHaiLogVictoryWin"]=
{
[1]=function(logstr,flag,hurt_hp,itemlist,jijie,param)

return{
flag=flag,
logstr=logstr,

hurt_hp=hurt_hp,
itemlist=itemlist,
jijie=jijie,
param=param
}
end,
},
["UIHouShanZLChallengeFightResultWin"]={
[1]=function(prize,data,state)
return{
data=data,
items=prize or{},
state=state
}
end,
},
["UIYCTBBattleLoseWin"]={
[1]=function(data)
return{
yctb_data=data,
}
end,
},
["UISystemZongMenFightAttackFailureWin"]={
[1]=function(battleId)
return{
battleId=battleId
}
end,
},
["UISystemZongMenFightAttackSuccessWin"]={
[1]=function(battleId,tips)
return{
battleId=battleId,
tips=tips
}
end,
},
["UISubAct_ChiSeJinDi_CopyFightVictoryWin"]={
[1]=function(level,tips)
return{
level=level,
tips=tips,
}
end,
},
['UISubAct_ChiSeJinDi_CopyFightLoseWin']={
[1]=function(hp,maxhp,tips)
return{
hp=hp,
maxhp=maxhp,
tips=tips,
}
end,
},
['UIZYSLShowPrizeWin']={
[1]=function(param)
return{
list=param[1].rewardList,
damage=param[1].total_damage,
bossIdx=param[1].boss_idx,
actId=param[1].actid,
subType=param[1].acttypeid,
subId=param[1].act2id,
}
end,
},
["UITianMoJieFightResultWin"]={
[1]=function(rewards,content,oldVal,newVal,tips)
return{
rewardList=rewards,
contentTx=content,
progressData={
oldVal=oldVal,
newVal=newVal,
tips=tips,
},
}
end
},




["UIXWSResultWin"]={
[1]=function(rewards,rankInfo,tips)
return{
rewards=rewards,
rankInfo=rankInfo,
tips=tips
}
end,
},
["UIYFGBattleVictoryWin"]={
[1]=function(fightData,winSide,param)
return{
fightData=fightData,
winSide=winSide,
param=param,
}
end,
},
["UILingShanFightResultWin"]={
[1]=function(result,param)
return{
result=result,
param=param,
}
end,
},
["UIXJCaravanEscort_victoryWin"]={
[1]=function(prize,data)
return{
items=prize or{},
data=data,
}
end,
},
["UIMingYuanZhuSha_FightVictoryExWin"]={
[1]=function(bid,data)
return{
battleId=bid,
data=data,
}
end,
},
["UIXingYu_jiesuanWin"]={
[1]=function(data)


return{
data=data,

}
end,
},
}

function fightResultWinConfig:getBaseWinParam(baseWin,index,...)
local win=_baseWinConfig[baseWin]
if win then
local content=win[index]
if content then
return content(...)
end
end
end

function fightResultWinConfig:getExtraWinParam(extraWin,index,...)
local win=_extraWinConfig[extraWin]
if win then
local content=win[index]
if content then
return content(...)
end
end
end
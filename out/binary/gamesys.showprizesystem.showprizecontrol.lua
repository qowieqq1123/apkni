









showPrizeControl=gameState.addListener({})

ePrizeType={

eCommon=1,
eEvent=2,
eWuDaoTang=3,
eFight=4,
eMystery=5,
eNone=6,
eZMMonster=7,
eDouFaTai=8,
eMonsterInvade=9,
eFuLu=10,
eDiscipleUseItem=11,
eXianZhanBaiPiao=12,
eNPCInteract=13,
eGuanQia=14,
eChuanGongGe=15,
eFeiShengTai=16,
eActivityXianShiChouKa=17,
eWorldLeaderFight=18,
eWorldLeaderSweep=19,
eJiuCengYaoLou=20,
eLianDanDaHui=21,
eXianGuYiJi=22,
eTianYuanShouChao=23,
eTianYuanShouChao2=24,
eNPCIntimacyReward=25,
eTreasureBoxReward=26,
eHuanJingReward=27,
eReallyItemNum=28,
eSystemZongMenTaYin=29,
eHouShanJinDi=30,
eActivityXianShiChouKa2=31,
eXianFaWenDaoReward=32,
eCangBaoGePrize=33,
eCangBaoGeActive=34,
eZongMenDaBi=35,
eXianMengDiGong=36,
eWanBaoXunBaodui_task=37,
eYiYuHuiYou=38,
eWanBaoXunBaodui_build=39,
eFaBaoBatchCreate=40,
eOverExp=41,
eYunChengTanBaoNurmal=42,
eYunChengTanBaoSpecial=43,
eYunChengTanBaoFight=44,
eDongTianFuDi=32,
eLianDang=45,
eYunChengTanBaoGame=46,
eTianTiShiLian=47,
eShiZhuanJianLi=48,
eWuXingDian=49,
eTianMoRuQinChallenge=50,
eTianMoRuQinRank=51,
eTianMoRuQinRankBatch=52,
eDoubleLotteryBatch=53,
eMysteryResult=54,
eBingGongFang=55,
ePaintedPuzzle=57,
eVisitorChallenge=58,
eTianJiangFuYuan=59,
eMysteryTreasure=60,
eHoushanZhenling=61,
eLongHuDaoDan=63,
eXZKSFinishOrder=62,
eHoushanZhenLingSD=64,
eTBGReward=65,
eDingZhiDaZao=66,
eShopCreate=67,
eNiuDanJi=69,
eZheXianLingJiYuan=71,
eCatEntrust=72,
eZongMenXiuXing=73,
eDuJieXianDan=74,
eAirGeCaoSettlement=75,
eChuanSongZhenAllReward=76,
eTeZhiTuJianReward=77,
eTianMoJie=78,
eDoubleLotteryBatch2=79,
echaoslingchi=80,
eJuTianYiGnosis=81,
eYuLingZhai=82,
eLunHuiDian=83,
eXJFMFight=84,
eXJFMSaoDang=85,
eZaoWuGeBuilding=86,
eYunHaiDiaoBao=87,
eFeiJianDuoBao=88,
eXZS_HouShanZhenLing=89,
eXZS_Common=90,
eLTYW_OccupyReward=91,
eFabaoJingLianReset=92,
eJiuYouTa=93,
eActivityTuJianDizi=94,
eXingChenUpgrade=95,
eMoGongZhengDuo=96,
eTianDaoDing=97,
eZZSHOneKeyGetReward=98,
eShouHunDing=99,
eXingYunZhuanPan=100,
eDzDaoYanReset=101,
eShengYuanMiZang=102,
eGuBaoBaoXaing=104,
eMingYuanZhuSha=105,
eLingShuCiFu=106,
eLingShouDai=107,


eCommonClient=1000,
eTreasureBoxClient=1001,


isClient=function(v)
return v>=1000
end,
isDiscipleFight=function(this,v)
return v==this.eWuDaoTang or
v==this.eFight or
v==this.eMystery or
v==this.eZMMonster or
v==this.eDouFaTai or
v==this.eMonsterInvade
end
}


local notCoverConfig={
[ePrizeType.eCommonClient]=true,
[ePrizeType.eTreasureBoxClient]=true,
}


local popupInfoType={
[ePrizeType.eMysteryTreasure]=true,
}

local _insertFlag=false
local _insertList={}
local _insertList2={}
local _insertPrizeType=nil
local _gubaoBXdata=nil

funcGubaoBXType={
eNiuDanJi=1,
eFeiJianDuoBao=2,
eYunHaiDiaoBao=3,
}








function showPrizeControl:onAppStart()
socketManager:register_receiver(1,4,self.onPrizeInsertStart)
socketManager:register_receiver(1,5,self.onPrizeInsertEnd)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function showPrizeControl:onEnterState()
showPrizeControl.clearData()

_gubaoBXdata=nil
end

function showPrizeControl:onLeaveState()
showPrizeControl.clearData()

_gubaoBXdata=nil
end




function showPrizeControl.onItemListChanged(argsTable)
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local oldVal=v[4]
local newVal=v[5]
showPrizeControl.onItemChanged(changeType,itemguid,itemid,oldVal,newVal)
end
end

function showPrizeControl.onItemChanged(changeType,itemguid,itemid,oldVal,newVal)
local delta=newVal-oldVal
if changeType~=CHANGE_TYPE.eDelete then
if _insertFlag then
showPrizeControl.insert(_insertPrizeType,_insertList,itemguid,itemid,delta)
end



else
if _insertFlag then
showPrizeControl.insert2(_insertPrizeType,_insertList2,itemguid,itemid,delta)
end



end
end

function showPrizeControl.onMoneyChanged(moneyType,oldVal,newVal)
local delta=newVal-oldVal
if delta>0 then
if _insertFlag then
showPrizeControl.insert(_insertPrizeType,_insertList,nil,moneyType,delta)
end



elseif delta<0 then
if _insertFlag then
showPrizeControl.insert2(_insertPrizeType,_insertList2,nil,moneyType,delta)
end



end
end




function showPrizeControl:clearData()
_insertFlag=false
_insertList={}
_insertList2={}
_insertPrizeType=nil
end

function showPrizeControl.onPrizeInsertStart(prizeType)
_insertFlag=true
_insertList={}
_insertList2={}
_insertPrizeType=prizeType
end

function showPrizeControl.onPrizeInsertEnd(effectData)
local prizeType=effectData.effecttype
local tipsid=effectData.tipsid

local temp=table.deepCopy(_insertList)
local temp2=table.deepCopy(_insertList2)
if prizeType==ePrizeType.eCommon then

local isCancelSC=guildOrderModel:getIsStopAutoShengChan()
if isCancelSC then
local newtemp={}
for i,v in pairs(temp)do
if not newtemp[v.itemid]then
newtemp[v.itemid]=v
else
newtemp[v.itemid].num=newtemp[v.itemid].num+v.num
end
end
temp={}
for i,v in pairs(newtemp)do
table.insert(temp,v)
end
end

table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)
local tips=showPrizeControl.getTips(tipsid)
showPrizeControl.showWindow(temp,nil,{tips=tips})
elseif prizeType==ePrizeType.eReallyItemNum then
table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)
local args={}
args.effect=10078
showPrizeControl.showWindow(temp,nil,args)
elseif prizeType==ePrizeType.eTreasureBoxReward then

local itemList=effectData.list
if itemList then

local templist={}
local tempLookup={}
for i,v in ipairs(itemList)do
showPrizeControl.insertCommon(templist,tempLookup,nil,v.param_1,v.param_2,false)
end

showPrizeControl.showWindowFourNow(templist)
else

table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)
showPrizeControl.showWindowFourNow(temp)
end
elseif prizeType==ePrizeType.eOverExp then
local item=temp[1]
local itemid=item.itemid
local name=itemsModel.getName(itemid)
local tips=FMT.fmt('溢出的经验值已转换成{0}返还',name)
showPrizeControl.showWindowSixNow(temp,nil,tips)
elseif prizeType==ePrizeType.eFaBaoBatchCreate then

table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)

local ubdId=effectData.buildguid
local bdData=zongmenModel:getBuildingData(ubdId)
local diziguid=bdData.dizi_id
local diziName
local itemguidList={}
local proType=DISCIPLE_PROSKILL_TYPE.eLianQi
local allAddVal=0
for i,v in ipairs(temp)do
local itemguid=v.itemguid
local itemid=v.itemid
if itemsConfig.isFabao(itemid)then
table.insert(itemguidList,itemguid)
local itemconfig=itemsConfig.getConfig(itemid)
local stage=itemconfig.stage
local proskill=fabaoConfig.getCommonConfig().proskill
local val=proskill[stage]
local addVal=val
if diziguid then
local addRate=UIDiscipleModel:getDiscipleProskillRate(diziguid,proType)
addVal=math.floor(addVal*(1+addRate/100))
end
allAddVal=allAddVal+addVal
end
end
if diziguid then
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
diziName=diziInfo.disciplename
end
local isTempName=diziName==nil or diziName==''
diziName=isTempName and''or FMT.cfmt(FONT_COLOR.eOrangeColor,diziName)
local str=not isTempName and allAddVal and allAddVal>0 and FMT.cfmt(FONT_COLOR.eOrangeDescColor,'{0}炼器经验增加{1}点',diziName,allAddVal)or''
showPrizeControl.showWindow(temp,nil,{tips=str})
notifySystem:postNotify(notifyConfig.onDiscipleMakeFaBao,diziguid,itemguidList)
elseif prizeType==ePrizeType.eTianTiShiLian then
local winArgs={
extraWin="UILingYunLanZhongVictoryWin",
extraParams={
items=temp,
title=nil,
tips="",
effectData=effectData
},
btnsInfo={
continuCallBack=function()
if UIManager:isActive("UISubAct_TianTiShiLianWin")then
UIManager:invokeUIMethod("UISubAct_TianTiShiLianWin","onStartGame")
end
end,
quitCallBack=function()end,
continueBtnName="重新开始",
quitBtnName="退出"
},
battleId=-1,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
elseif prizeType==ePrizeType.eHoushanZhenling then
showPrizeControl.showWindowSixNow(temp,nil,nil)
elseif prizeType==ePrizeType.eHoushanZhenLingSD then

if UIManager:isActive('UICommonVictoryWin')then
UIManager:closeWindow('UICommonVictoryWin')
end

local winArgs={
isHideFightBtn=true,
extraWin="UIHouShanZLChallengeFightResultWin",
extraParams={
items=temp,
state=2,
data=effectData
},
noShowCloseTip=true,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
elseif prizeType==ePrizeType.eLingShouDai then

local showList={}
local lookup={}

local dropList=effectData and effectData.dropList
if dropList and type(dropList)=='table'and#dropList>0 then
for _,v in ipairs(dropList)do
local itemid=v.itemId or v.itemid or v.param_1 or v.id or v[1]
local num=v.itemNum or v.num or v.param_2 or v[2]or 1
local lsList=v.lsList

if itemid and num and num>0 then
if itemsConfig.getMainType(itemid)==ITEM_MAIN_TYPE.eLingShou and lsList and type(lsList)=='table'and#lsList>0 then
for _,lsGuid in ipairs(lsList)do
showPrizeControl.insertCommon(showList,lookup,nil,itemid,1,false)
local info=showList[#showList]
if info then
info.conf=info.conf or{}
info.conf.attach=lsGuid
end
end
else

showPrizeControl.insertCommon(showList,lookup,nil,itemid,num,false)
end
end
end
else
for _,v in ipairs(temp)do
local itemid=v.itemid
local num=v.num
if itemid and num and num>0 then
showPrizeControl.insertCommon(showList,lookup,v.itemguid,itemid,num,false)
end
end
end

if#showList>0 then
local tips=showPrizeControl.getTips(tipsid)
UIManager:showWindow('UICommonShowPrizeWin',{list=showList,tips=tips})
end
end



notifySystem:postNotify(notifyConfig.onShowPrize,prizeType,temp,effectData,temp2)

showPrizeControl:clearData()
end

local insertLookup=nil
function showPrizeControl.insert(prizeType,reslist,itemguid,itemid,num)
if reslist==nil or num<=0 then return end
if#reslist<=0 then
insertLookup={}
end
showPrizeControl.insertCommon(reslist,insertLookup,itemguid,itemid,num,false)
end

local insertLookup2=nil
function showPrizeControl.insert2(prizeType,reslist,itemguid,itemid,num)
if reslist==nil or num>=0 then return end
if#reslist<=0 then
insertLookup2={}
end
showPrizeControl.insertCommon(reslist,insertLookup2,itemguid,itemid,num,false)
end

function showPrizeControl.isPrizeState()
return _insertFlag
end

function showPrizeControl.getPrizeType()
return _insertPrizeType
end

function showPrizeControl.isPopupType(pType)
return popupInfoType[pType]
end


































































local _tempLookup=nil
function showPrizeControl.insertTemp(templist,itemguid,itemid,num,isCover)
if templist==nil or num<=0 then return end
if#templist<=0 then
_tempLookup={}
end
showPrizeControl.insertCommon(templist,_tempLookup,itemguid,itemid,num,isCover)
end




function showPrizeControl.showWindow(prizelist,callback,args)
if#prizelist<=0 then return end
local argstable={list=prizelist,callback=callback}
if args then
for k,v in pairs(args)do
argstable[k]=v
end
end
UIManager:showWindow('UICommonShowPrizeWin',argstable)
end

function showPrizeControl.showWindowFullScreen(prizelist,fullScreen,callback)
if#prizelist<=0 then return end
if fullScreen then
fullScreen:showWindow('UICommonShowPrizeWin',{list=prizelist,callback=callback})
end
end

function showPrizeControl.showWindowNow(list,callback,tips)
UIManager:showWindow('UICommonShowPrizeWin',{list=list,callback=callback,tips=tips})
end

function showPrizeControl.showWindowTwoNow(list,callback,tips)
UIManager:showWindow('UICommonShowPrizeTwoWin',{list=list,callback=callback,tips=tips})
end

function showPrizeControl.showWindowFourNow(list,callback,tips)
if#list<=0 then return end
UIManager:showWindow('UICommonShowPrizeFourWin',{list=list,callback=callback,tips=tips})
end

function showPrizeControl.showWindowSixNow(list,callback,tips)
if#list<=0 then return end
UIManager:showWindow('UICommonShowPrizeSixWin',{list=list,callback=callback,tips=tips})
end

function showPrizeControl.showWindowSevenNow(list,callback,tips,closeTips)
if#list<=0 then return end
UIManager:showWindow('UICommonShowPrizeSevenWin',{list=list,callback=callback,tips=tips,closeTips=closeTips})
end


function showPrizeControl.insertCommon(commonlist,commonlookup,itemguid,itemid,num,isCover)
local handle
if itemguid then
handle=tostring(itemguid)
else
handle=itemid
end
local idx=commonlookup[handle]

if idx and(isCover==nil or isCover==true)then
local info=commonlist[idx]
info.num=info.num+num
else
idx=#commonlist+1
commonlookup[handle]=idx
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
if itemsConfig.isLingZhen(itemid)then
color=UIYuFuLingZhenControl:getItemColorById(itemid,itemguid)
end




local rareLv=itemsConfig.getRareLvByCfg(itemConfig)
local sortWeight=rareLv*10000
sortWeight=sortWeight+color*1000
if itemsConfig.isEquip(itemid)then
sortWeight=sortWeight+100
end

commonlist[idx]={itemguid=itemguid,itemid=itemid,num=num,sortWeight=sortWeight}
end
end

function showPrizeControl.getTips(tipsid)
if tipsid==nil or tipsid<=0 then return end
local cfg=cfg_showprizetipsconfig_get(tipsid)
if cfg==nil then return end
return cfg.tips
end



function showPrizeControl:setGuBaoBaoXiangData(extera)

_gubaoBXdata=extera
end
function showPrizeControl:getGuBaoBaoXiangData()
return _gubaoBXdata
end
function showPrizeControl:clearGuBaoBaoXiangData()
_gubaoBXdata=nil
end

function showPrizeControl:checkGuBaoBX(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.funcparam and itemCfg.funcparam.type==item_funtion_type.eGuBaoBaoXiang then
return true
end
end

local _GBfunctHandle=
{

[funcGubaoBXType.eNiuDanJi]=function(extera,new_rewards)
local act_id=extera.act_id
local sub_act_type=extera.sub_act_type
local sub_act_id=extera.sub_act_id
local rewards=extera.rewards
local rewardlist=table.weakCopy(rewards)

for k,v in ipairs(new_rewards)do
rewardlist[#rewardlist+1]=v
end

local activityData=activitiesModel:getSubActInfo(act_id,sub_act_type,sub_act_id)
activityData:ShowPrize2(rewardlist)
end,


[funcGubaoBXType.eFeiJianDuoBao]=function(extera,new_rewards)
local act_id=extera.act_id
local sub_act_type=extera.sub_act_type
local sub_act_id=extera.sub_act_id
local rewards=extera.rewards
local rewardlist=table.weakCopy(rewards)

for k,v in ipairs(new_rewards)do
rewardlist[#rewardlist+1]=v
end


local activityData=activitiesModel:getSubActInfo(act_id,sub_act_type,sub_act_id)
activityData:ShowPrize2(rewardlist)
end,


[funcGubaoBXType.eYunHaiDiaoBao]=function(extera,new_rewards)
local act_id=extera.act_id
local sub_act_type=extera.sub_act_type
local sub_act_id=extera.sub_act_id
local rewards=extera.rewards
local rewardlist=table.weakCopy(rewards)

for k,v in ipairs(new_rewards)do
rewardlist[#rewardlist+1]=v
end

local activityData=activitiesModel:getSubActInfo(act_id,sub_act_type,sub_act_id)
activityData:ShowPrize2(rewardlist)
end,
}


function showPrizeControl.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eGuBaoBaoXaing then

local new_rewards={}
for i,v in ipairs(prizelist)do
table.insert(new_rewards,{itemid=v.itemid,num=v.num})
end
local gubaoBXdata=showPrizeControl:getGuBaoBaoXiangData()

if gubaoBXdata then
local funcType=gubaoBXdata.funcType
if _GBfunctHandle[funcType]then
_GBfunctHandle[funcType](gubaoBXdata,new_rewards)
end
showPrizeControl:clearGuBaoBaoXiangData()
else

end
end
end
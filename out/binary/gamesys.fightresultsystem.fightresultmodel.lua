






local _MODULENAME="fightResultModel"




def_table(_MODULENAME)
fightResultModel.name=_MODULENAME


fightResultModel.data={}

local _record=nil
local _rewards={}
local _attributes={}
local _package_index=0
local _packages={}

local _fight_prize_association={
[eBattleLaunch.zongmenMonster]=ePrizeType.eZMMonster,
[eBattleLaunch.monsterInvade]=ePrizeType.eMonsterInvade,
[eBattleLaunch.doufatai]=ePrizeType.eDouFaTai,
[eBattleLaunch.mystery]=ePrizeType.eFight,
[eBattleLaunch.experience]=ePrizeType.eFight,
[eBattleLaunch.worldMonster]=ePrizeType.eFight,
[eBattleLaunch.resPoint]=ePrizeType.eFight,
[eBattleLaunch.qiyuEvent]=ePrizeType.eFight,
[eBattleLaunch.fuyaoshilian]=ePrizeType.eFight,

[eBattleLaunch.huanjing]=ePrizeType.eHuanJingReward,
[eBattleLaunch.xianfawendao]=ePrizeType.eXianFaWenDaoReward,
[eBattleLaunch.tianmoruqin_tm]=ePrizeType.eTianMoRuQinChallenge,
[eBattleLaunch.tianmoruqin_sj]=ePrizeType.eFight,
[eBattleLaunch.taigushilian]=ePrizeType.eFight,
[eBattleLaunch.visitorChallenge]=ePrizeType.eVisitorChallenge,
[eBattleLaunch.houshanzhenling]=ePrizeType.eHoushanZhenling,
[eBattleLaunch.longhuxiangyao]=ePrizeType.eFight,
[eBattleLaunch.dujiexiandan]=ePrizeType.eDuJieXianDan,
[eBattleLaunch.tianmojie]=ePrizeType.eTianMoJie,
[eBattleLaunch.xunbaoshilian]=ePrizeType.eFight,
[eBattleLaunch.xianjieResPoint]=ePrizeType.eFight,
[eBattleLaunch.xianjieFuMo]=ePrizeType.eXJFMFight,
[eBattleLaunch.jiuyouta]=ePrizeType.eJiuYouTa,
[eBattleLaunch.gubaoshilian]=ePrizeType.eFight,
[eBattleLaunch.activitiesPushMap]=ePrizeType.eFight,
}


function fightResultModel:onAppStart()

end


function fightResultModel:onEnterState()

end


function fightResultModel:onLeaveState()

self.data={}
_record=nil
_rewards={}
_attributes={}
_package_index=0
_packages={}
end


function fightResultModel:onServerDataInitFinish()

end




function fightResultModel:makeRecord(handle,battleId,btnsInfo,extraWinArgs,logPackage,battleType,fightData,param)

_record={
handle=handle,
battleId=battleId,
btnsInfo=btnsInfo,
extraWinArgs=extraWinArgs,
logPackage=logPackage,
battleType=battleType,
fightData=fightData,
param=param,
}
end

function fightResultModel:clearRecord()

_record=nil
end

function fightResultModel:getRecord()
return _record
end

function fightResultModel:haveRecord()
return self:getRecord()~=nil
end



function fightResultModel:calculateFightData(battleId)
local resList=nil
local battle=fightModel:getBattle(battleId)
if battle~=nil then
resList={}
local list=battle:getStatisticsList()or{}
for i,v in ipairs(list)do
local res=v.statistics
local round=v.round
local maxRound=v.maxRound
res.round=round
res.maxRound=maxRound
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()
res.leftId=leftId
res.rightId=rightId
table.insert(resList,res)
end
end
return resList
end



function fightResultModel:pushReward(effectType,rewards)
if not _rewards[effectType]then _rewards[effectType]={}end

table.insert(_rewards[effectType],rewards)

end

function fightResultModel:popReward(effectType)
if self:getRewardCount(effectType)>0 then



local temp={}
for index,list in ipairs(_rewards[effectType])do
for itemIdx,item in ipairs(list)do
local itemTemp=nil
for iTemp,vTemp in ipairs(temp)do
if vTemp.itemguid==item.itemguid and vTemp.itemid==item.itemid then
itemTemp=vTemp
break
end
end
if itemTemp then
itemTemp.num=itemTemp.num+item.num
else
table.insert(temp,table.deepCopy(item))
end
end
end
_rewards[effectType]={}

return temp
end
return{}
end

function fightResultModel:getRewardCount(effectType)
return#(_rewards[effectType]or{})
end



function fightResultModel:pushAttribute(effectType,attribute)
if not _attributes[effectType]then _attributes[effectType]={}end
table.insert(_attributes[effectType],attribute)
end

function fightResultModel:popAttribute(effectType)
if self:getAttributeCount(effectType)>0 then
return table.remove(_attributes[effectType],1)
end
return{}
end

function fightResultModel:getAttributeCount(effectType)
return#(_attributes[effectType]or{})
end



function fightResultModel:setPackageResult(log,prize,attribute,teamNum)
_package_index=_package_index+1
_packages[_package_index]={
logStr=log,
prizeList=prize,
attrList=attribute,
teamNum=teamNum,
}
return _package_index
end

function fightResultModel:getPackageResutl(index)
return _packages[index]
end

function fightResultModel:clearPackageResult(index)
_packages[index]=nil
end

function fightResultModel:printAllPackgeResult()
for i,v in pairs(_packages)do

end
end

function fightResultModel:getFightPrize(eFight)
local ePrize=_fight_prize_association[eFight]
if ePrize then
return self:popReward(ePrize)
end
return{}
end

function fightResultModel:getFightAttribute(eFight)
local ePrize=_fight_prize_association[eFight]
if ePrize then
return self:popAttribute(ePrize)
end
return{}
end

function fightResultModel:checkPrizeContain(prizeType)
return table.containsValue(_fight_prize_association,prizeType)
end




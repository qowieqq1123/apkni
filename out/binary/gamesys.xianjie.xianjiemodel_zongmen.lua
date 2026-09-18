







xjAttackMode=
{
ePeace=0,
eXianYu=1,
eXianMeng=2,
ePersion=3,
}

ATTACKTYPE=
{
eXJActor=1,
eMJActor=2,
eMoZong=3,
eMoJun=4,
eMJActor_dazhen=5,
eMoGong=6,
eZhenYan=7,
}


ATTACKTABTYPE=
{
eXJ=1,
eMJ=2,
eBaoLei=3,
eMG=4,
}

function xianjieModel:clearData_zongmen()
xianjieModel:clearData_zongmen1()
xianjieModel:clearData_zongmen2()
end

function xianjieModel:clearData_zongmen1()
if self.myZongMenData then
xianjieController:removeXJClass(self.myZongMenData)
self.myZongMenData=nil
end
end

function xianjieModel:clearData_zongmen2()
local lp=self.allZMDatas
if lp then
for actorid_str,zmData in pairs(lp)do
xianjieController:removeXJClass(zmData)
end
self.allZMDatas=nil
self.allZMPosLookup=nil
end
self.myZongMenData2=nil
self.myZongMenData3=nil
self.myZongMenData_mgzd=nil
end

function xianjieModel:clearData_AttackList()

self.myAttackerNotifyLookup={}
self.myAttackerLen=0
end

function xianjieModel:initZongMenOutPos(sceneidx,x,y)
self.zmOutPos={sceneidx,x,y}
end

function xianjieModel:initZongMenOutPos_mojie(sceneidx,x,y)
if sceneidx~=0 then
self.zmOutPos_mj={sceneidx,x,y}
end
end

function xianjieModel:initZongMenOutPos_mogongzhengduo(sceneidx,x,y)
if sceneidx~=0 then
self.zmOutPos_mgzd={sceneidx,x,y}
end
end

function xianjieModel:getZongMenOutPos()
if not xianjieController:checkInPlotScene2()then
return self.zmOutPos
else
local zmData=self.myZongMenData
if zmData then
return{zmData.sceneidx,zmData.gridX,zmData.gridZ}
end
end
return nil
end

function xianjieModel:getZongMenOutPos_mojie()
return self.zmOutPos_mj
end

function xianjieModel:getZongMenOutPos_mogongzhengduo()
return self.zmOutPos_mgzd
end

function xianjieModel:clearZongmenOutPos_mogongzhengduo()
self.zmOutPos_mgzd=nil
end

function xianjieModel:getZongmenOutPosBySceneIdx(sceneidx)
if xianjienSceneIndexType:isMoJie(sceneidx)then
return xianjieModel:getZongMenOutPos_mojie()
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
return xianjieModel:getZongMenOutPos_mogongzhengduo()
else
return xianjieModel:getZongMenOutPos()
end
end

function xianjieModel:getZongMenSize()
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eActor,'size')
local gridWidth=size[1]
local gridHeight=size[2]
return gridWidth,gridHeight
end




function xianjieModel:initMyZongMenData(x,y,sceneidx)
xianjieModel:clearData_zongmen1()
local serverid=playerModel:getActorServerID()
local actorname=playerModel:getActorName()
local actorid=playerModel:getActorID()
local actorid_str=tostring(actorid)
local entitytype=xjServerEnityType.eActor
local sectdress=UISettingModel:getCurSettingId_Type(KUANGE_TYPE.zongmen)
local v={entitytype=entitytype,x=x,y=y,sceneidx=sceneidx,actorid=actorid,actorid_str=actorid_str,serverid=serverid,actorname=actorname,ismy=true,sectdress=sectdress}
v.isPlot=true
local zmData=xianjieController:createXJClass(xjDataType.eZongMen,v)
self.myZongMenData=zmData
end


function xianjieModel:refreshMyZongMenData(key,value)
if not xianjieController:checkInPlotScene2()then
return
end
local zmData_=self.myZongMenData

if zmData_ then
zmData_[key]=value
zmData_.x=zmData_.gridX
zmData_.y=zmData_.gridZ
zmData_:refreshEntityByExtraData(zmData_)
zmData_:refreshData(zmData_)
zmData_:refreshEntity()
zmData_.x=nil
zmData_.y=nil
end
end


function xianjieModel:initMyZongMenData2(sceneidx,v)
if xianjienSceneIndexType:isMoJie(sceneidx)then

if self.myZongMenData3 then
xianjieController:removeXJClass(self.myZongMenData3)
self.myZongMenData3=nil
end
self.myZongMenData3=v
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
if self.myZongMenData_mgzd then
xianjieController:removeXJClass(self.myZongMenData_mgzd)
self.myZongMenData_mgzd=nil
end
self.myZongMenData_mgzd=v
else
if self.myZongMenData2 then
xianjieController:removeXJClass(self.myZongMenData2)
self.myZongMenData2=nil
end
self.myZongMenData2=v
end
end



function xianjieModel:getMyZongMenData(sceneidx)
if not xianjieController:checkInPlotScene2()then
sceneidx=sceneidx or xianjieModel:getSceneIndex()
if sceneidx~=nil then
if xianjienSceneIndexType:isMoJie(sceneidx)then

return self.myZongMenData3
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
return self.myZongMenData_mgzd
else

return self.myZongMenData2
end
else

return self.myZongMenData2
end
else

return self.myZongMenData
end
end

function xianjieModel:createMyZongMenEnity(needRefreshAOI)
local zmData=xianjieModel:getMyZongMenData()
if zmData then
zmData:createEntity(needRefreshAOI)
end
end

function xianjieModel:removeMyZongMenEntity()
if self.myZongMenData then
self.myZongMenData:removeEntity()
end
if self.myZongMenData2 then
self.myZongMenData2:removeEntity()
end
if self.myZongMenData3 then
self.myZongMenData3:removeEntity()
end
if self.myZongMenData_mgzd then
self.myZongMenData_mgzd:removeEntity()
end
end

function xianjieModel:changeMyZongMenPos(sceneidx,gridX,gridZ,result)
local zmData=xianjieModel:getMyZongMenData(sceneidx)
if zmData then
zmData:refreshData({x=gridX,y=gridZ,sceneidx=sceneidx})
if xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieModel:initZongMenOutPos_mojie(sceneidx,gridX,gridZ)
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then

else
xianjieModel:initZongMenOutPos(sceneidx,gridX,gridZ)
end

local lookpos=xianjieController:worldGridPos2WorldPos4(gridX,gridZ,sceneidx)
xianjieController:lookAtPosition(lookpos,nil,0.2,nil,DG.Tweening.Ease.Linear)

if zmData.ent_key~=nil then
local widget=xianjieController:invokeEntityFunc(zmData.ent_key,'getWidget')
if not widget then
xianjieController:invokeEntityFunc(zmData.ent_key,'setIsPlayEffect',true)
xianjieController:invokeEntityFunc(zmData.ent_key,'refreshPos',true)
else
xianjieController:invokeEntityFunc(zmData.ent_key,'refreshPos',true)
xianjieController:invokeEntityFunc(zmData.ent_key,'playEffect')
end
else
zmData:createEntity(true)
xianjieController:invokeEntityFunc(zmData.ent_key,'setIsPlayEffect',true)
end

xianjieModel:refreshAllEntityBuff()
xianjieModel:openFirstEntityXianJieTips()
xianjieModel:refreshMyZongMenMoJunAreaId(sceneidx)

notifySystem:postNotify(notifyConfig.onXianJieZMMove)

if result==0 then

elseif result==1 then
UIManager.info('天枢大阵被击破，堡垒已回归复活点')
end
end
end

function xianjieModel:openFirstEntityXianJieTips()
local isFrist=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'firstEntryXianJie',0)==0
if not isFrist then
return
end
local zmData=xianjieModel:getMyZongMenData()
local sceneidx=zmData and zmData.sceneidx
local isOpenXY=systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)
local checkAllCloudUnlockEx=xianjieModel:checkAllCloudUnlockEx()
local isXJ=xianjieModel:checkSceneType(xianjienSceneType.eXianJie)
local isXianJie=sceneidx==xianjieModel:getSceneIndex(xianjienSceneType.eXianJie)

if isOpenXY and checkAllCloudUnlockEx and isXJ and isXianJie then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'firstEntryXianJie',1,0)
UIManager:showWindow('UIXianJie_firstEntryXianJieTipsWin')
end
end





function xianjieModel:initAllZongMenDatas()
xianjieModel:clearData_zongmen2()
self.allZMDatas={}
self.allZMPosLookup={}
end

function xianjieModel:refreshZongMenData(v,isInit)















local actorid_str=v.actorid_str
if isInit then
if v.serverid~=0 then
local zmData=xianjieController:createXJClass(xjDataType.eZongMen,v)
if zmData.ismy then
xianjieModel:initMyZongMenData2(zmData.sceneidx,zmData)
end
xianjieModel:addZmData(actorid_str,zmData)
xianjieModel:setGuid2EntityType(v.actorid,v.entitytype,v.sceneidx)
else



end
else
if v.serverid~=0 then
local zmData_=self.allZMDatas[actorid_str]
if zmData_==nil then
local zmData=xianjieController:createXJClass(xjDataType.eZongMen,v)
if zmData.ismy then
xianjieModel:initMyZongMenData2(zmData.sceneidx,zmData)
end
xianjieModel:addZmData(actorid_str,zmData)
xianjieModel:setGuid2EntityType(v.actorid,v.entitytype,v.sceneidx)
zmData:createEntity(true)

else
zmData_:refreshEntityByExtraData(v)
zmData_:refreshData(v)

if zmData_:getMoveFlag()then
xianjieController:invokeEntityFunc(zmData_.ent_key,'playOtherMoveEffect',function()
zmData_:refreshEntity()
zmData_:setMoveFlag()
end)

else
zmData_:refreshEntity()
end


end
else
local zmData=self.allZMDatas[actorid_str]
if zmData~=nil then
local actorid=zmData.actorid
local ismy=zmData.ismy
local sceneidx=zmData.sceneidx
if ismy then
xianjieModel:initMyZongMenData2(sceneidx,nil)
end

xianjieController:removeEntityAllHalo(zmData)
xianjieModel:removeZmData(actorid_str)

xianjieModel:setGuid2EntityType(v.actorid,nil,sceneidx)

else



end
end
end
end

function xianjieModel:getZongMenData(actorid)
if self.allZMDatas then
local actorid_str=tostring(actorid)
return self.allZMDatas[actorid_str]
end
return nil
end

function xianjieModel:getZongMenDataEx(actorid_str)
if self.allZMDatas then
return self.allZMDatas[actorid_str]
end
return nil
end

function xianjieModel:createAllZongMenEnities(needRefreshAOI)
local lp=self.allZMDatas
if lp then
for actorid_str,zmData in pairs(lp)do
zmData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllZongMenEnities()
local lp=self.allZMDatas
if lp then
for actorid_str,zmData in pairs(lp)do
zmData:removeEntity()
end
end
end

function xianjieModel:addZmData(actorid_str,zmData)
if self.allZMDatas[actorid_str]==nil then
self.allZMDatas[actorid_str]=zmData
local gridX=zmData.gridX
local gridZ=zmData.gridZ
self.allZMPosLookup[gridX]=self.allZMPosLookup[gridX]or{}
self.allZMPosLookup[gridX][gridZ]=self.allZMPosLookup[gridX][gridZ]or{}
local list=self.allZMPosLookup[gridX][gridZ]
list[#list+1]=zmData:getID()
end
end

function xianjieModel:removeZmData(actorid_str)
local zmData=self.allZMDatas[actorid_str]
if zmData then
local entityId=zmData:getID()
local gridX=zmData.gridX
local gridZ=zmData.gridZ
if self.allZMPosLookup[gridX]and self.allZMPosLookup[gridX][gridZ]then
local list=self.allZMPosLookup[gridX][gridZ]
for i,v in ipairs(list)do
if v==entityId then
_remove(list,i)
return
end
end
end
zmData:removeEntity()
xianjieController:removeXJClass(zmData)
self.allZMDatas[actorid_str]=nil
end
end

function xianjieModel:refreshZmDataPos(zmData)
local entityId=zmData:getID()

local gridX=zmData.gridX
local gridZ=zmData.gridZ
if self.allZMPosLookup then
local flag=false
for _,v in pairs(self.allZMPosLookup)do
for _,list in pairs(v)do
for i,vv in ipairs(list)do
if vv==entityId then
_remove(list,i)
flag=true
break
end
end
if flag then break end
end
if flag then break end
end
end

self.allZMPosLookup[gridX]=self.allZMPosLookup[gridX]or{}
self.allZMPosLookup[gridX][gridZ]=self.allZMPosLookup[gridX][gridZ]or{}
local list=self.allZMPosLookup[gridX][gridZ]
list[#list+1]=zmData:getID()
end

function xianjieModel:getZmDataByPos(gridX,gridZ)
if self.allZMPosLookup[gridX]==nil then return end
return self.allZMPosLookup[gridX][gridZ]
end

function xianjieModel:setZongMenLianZhan(actorid,hitCount)
local zmData=self:getZongMenData(actorid)
if zmData==nil then return end
zmData.lianzhan=hitCount
end

function xianjieModel:getZongMenLianZhan(actorid)
local zmData=self:getZongMenData(actorid)
if zmData==nil then return end
return zmData.lianzhan or 0
end

function xianjieModel:getHitCountBgName(hitCount)
local hitCountRangeList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'hitCountRangeList')

local bgName=""

local sindex=1

for index,range in ipairs(hitCountRangeList)do
if hitCount>=range[1]then
bgName=range[3]
sindex=index
else
break
end
end

return bgName,sindex
end



function xianjieModel:getZongMenSceneidx(zmData)
if zmData==nil then
zmData=xianjieModel:getMyZongMenData()
end
if zmData then
return zmData.sceneidx
end
end

function xianjieModel:getZongMenWorldGridCenterPos(zmData)
if zmData==nil then
zmData=xianjieModel:getMyZongMenData()
end
if zmData then
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
return gridX_c,gridZ_c,zmData.sceneidx,zmData:getBornAreaID()
end
end

function xianjieModel:getZongMenWorldPos(zmData)
if zmData==nil then
zmData=xianjieModel:getMyZongMenData()
end
if zmData then
return xianjieController:worldGridPos2WorldPos1(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight,zmData.sceneidx),zmData.sceneidx
end
end

function xianjieModel:getZongMenWorldPos_1(zmData)
if zmData==nil then
zmData=xianjieModel:getMyZongMenData()
end
if zmData then
return xianjieController:worldGridPos2WorldPos11(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight,zmData.sceneidx),zmData.sceneidx
end
end

function xianjieModel:getZongMenToPosWayTime(sceneidx,gridX_c,gridZ_c,speed,zmData,isBack,battleTime)
if zmData==nil then
zmData=xianjieModel:getMyZongMenData()
end
if zmData==nil then
return 0
end
if speed==nil then
speed=xianjieModel:getCloudSearchSpeed()
end
local gridX_c_,gridZ_c_=xianjieModel:getZongMenWorldGridCenterPos(zmData)
local movePath=xianjieController:getMovePath(zmData.sceneidx,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c)
local wayTime
if type(speed)=='table'then
wayTime=xianjieController:getMovePathWayTime2(movePath,speed,isBack,battleTime)
else
wayTime=xianjieController:getMovePathWayTime(movePath,speed)
end
return wayTime
end




ZongMenMoveTypeEnum={
USE_ITEM=1,
USE_PRIVILEGE=2,
USE_MOJIE_FREE=3,
USE_MOGONGACT_FREE=4,
}


function xianjieModel:getZongMenMoveType()
local curSceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(curSceneIdx)then
if moGongZhengDuoActModel:checkUseMoGongFreeMoveZongMen()then
return ZongMenMoveTypeEnum.USE_MOGONGACT_FREE
end
end


if xianjieModel:checkMoJieZmMoveFreeCount()then
return ZongMenMoveTypeEnum.USE_MOJIE_FREE
end


if xianjieModel:checkHasFreeTimesOfXianGuanPrivilege()then
return ZongMenMoveTypeEnum.USE_PRIVILEGE
end


return ZongMenMoveTypeEnum.USE_ITEM
end


function xianjieModel:checkHasFreeTimesOfXianGuanPrivilege()

local tqId=XIANGUAN_PRIVILEGE_ENUM.eYiTianYiRi

if not xianguanHelper.checkTeQuanPlatformLimit(tqId)then return end

if xianguanController:checkSelfHasTeQuanByType(tqId,XIANGUAN_TYPE_ENUM.eYiTianShenJiang)then
local xgInfo=xianguanController:getSelfHasTeQuanByType(tqId,XIANGUAN_TYPE_ENUM.eYiTianShenJiang)
local isHasTimes=xianguanModel:callTeQuanObjFunc(xgInfo.jobId,tqId,"checkUseTimes")
local spState=xianguanHelper.checkSpecialUseCondition(XIANGUAN_TYPE_ENUM.eYiTianShenJiang,tqId)
return(not isHasTimes)and spState
end

return false
end

function xianjieModel:checkShowFreeTimesofXianGuanPrivilegeTips()
if xianjieModel:checkHasFreeTimesOfXianGuanPrivilege()then
local tqId=XIANGUAN_PRIVILEGE_ENUM.eYiTianYiRi
local xgInfo=xianguanController:getSelfHasTeQuanByType(tqId,XIANGUAN_TYPE_ENUM.eYiTianShenJiang)
local times=xianguanModel:callTeQuanObjFunc(xgInfo.jobId,tqId,"getTimes")
local maxTimes=xianguanConfig.getTeQuanCfg(tqId,'times')
UIManager.info(FMT.fmt("特权移天易日的免费迁城次数剩余{0}次",maxTimes-times))
end
end

function xianjieModel:getZongMenMoveCost()
local count=xianjieModel:getCurCountToday()
local costs
if xianjieModel:checkCurrentInMoJie()then
costs=cfgHelper.get2(cfg_devildombaseconfig_get,1,'actormove')
else
costs=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'move')
end
local len=#costs
if count>len then count=len end
return costs[count]
end

function xianjieModel:checkZongMenMoveCost(isWarning)
local costs=xianjieModel:getZongMenMoveCost()
if costs then
for i,v in ipairs(costs)do
local itemid=v[1]
local need=v[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagModel.getItemCountById(itemid)
end
if have<need then
if isWarning then
local name=itemsConfig.getItemName(itemid)
UIManager.error(string.format('%s不足',name))
end
return false,itemid,need-have,need
end
end
end
return true
end

function xianjieModel:getZongMenMovePlayEffectId()
if xianjieModel:checkHasFreeTimesOfXianGuanPrivilege()then
return 20636
end
return 22622
end

function xianjieModel:jumpMyZongMen(cb,iscameraLow)
if iscameraLow==nil then
iscameraLow=true
end

local zmData=xianjieModel:getMyZongMenData()
if zmData then
local gridX_c,gridZ_c=xianjieModel:getZongMenWorldGridCenterPos(zmData)
xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,cb,iscameraLow)
end
end


function xianjieModel:getEntityBuffList()
local zmData=xianjieModel:getMyZongMenData()
return zmData.buffList
end

function xianjieModel:hasMyZMBuffEffect(effecttype)
local actorid=playerModel:getActorID()
return xianjieModel:hasBuffEffect(actorid,effecttype)
end

function xianjieModel:getBuffEffectLeftTime(actorid,effecttype)
local zmData=xianjieModel:getZongMenData(actorid)
if zmData and zmData.buffInfo and zmData.buffInfo[effecttype]then
local left=zmData.buffInfo[effecttype]-timeHelper.getServerShortTime()
return math.max(left,0)
end
return 0
end

function xianjieModel:hasBuffEffect(actorid,effecttype,sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local zmData=xianjieModel:getZongMenData(actorid)
local effectDuration=zmData and zmData.buffInfo and zmData.buffInfo[effecttype]
if effectDuration==nil then return false end
local effectCfg=cfgHelper.get2(cfg_fairylandbuffconfig_get,effecttype)
if effectCfg and effectCfg.shield_scene then
if effectCfg.shield_scene[sceneidx]==1 then
return false
end
end
local left=zmData.buffInfo[effecttype]-timeHelper.getServerShortTime()
return left>0
end


function xianjieModel:isOpenTianShuShenDun(actorid)
return xianjieModel:hasBuffEffect(actorid,xjBuffEffectType.eLongweiShenDunBuff)
end


function xianjieModel:isOpenFangHuZhao(actorid)
return xianjieModel:hasBuffEffect(actorid,xjBuffEffectType.eFangHuZhao)
end


function xianjieModel:isDisableFangHuZhao(actorid)
return xianjieModel:hasBuffEffect(actorid,xjBuffEffectType.eDisableFangHuZhao)
end


function xianjieModel:isCanNotTanChaAndFangZhu(actorid)
local effecttype=xjBuffEffectType.eCanNotTanChaAndFangZhu
local zmData=xianjieModel:getZongMenData(actorid)
if zmData and zmData.buffInfo and zmData.buffInfo[effecttype]then
return true
end
return false
end


function xianjieModel:isZmInvisible(actorid)
local effecttype=xjBuffEffectType.eZongMenInvisible
local zmData=xianjieModel:getZongMenData(actorid)
if zmData and zmData.buffInfo and zmData.buffInfo[effecttype]then
local hasZZKR=xianjieModel:isDisableFangHuZhao(actorid)
if not hasZZKR then
return true
end
end
return false
end


function xianjieModel:isZmSkillPenglai(actorid)
local effecttype=xjBuffEffectType.eMJSLSkillPengLaiAdd
local zmData=xianjieModel:getZongMenData(actorid)
if zmData and zmData.buffInfo and zmData.buffInfo[effecttype]then
return true
end
return false
end

function xianjieModel:isZmSLSkillIcon(actorid)
local effecttype=xjBuffEffectType.eMJSLSkillAddIcon
local zmData=xianjieModel:getZongMenData(actorid)
if zmData and zmData.buffInfo and zmData.buffInfo[effecttype]then
return true
end
return false
end

function xianjieModel:isZmSkillJiuYuan(actorid)
local effecttype=xjBuffEffectType.eMJSLSkillJiuYuanAdd
local zmData=xianjieModel:getZongMenData(actorid)
if zmData and zmData.buffInfo and zmData.buffInfo[effecttype]then
return true
end
return false
end























































































































































local _xjAttackTipsType=
{
ePeaceMode=1,
eOwnerMapSame=2,
eXianMengSame=3,
eOpenFHZ=4,
eAttackSame=5,
eDiffScene=6,
eWaiPaiTeamFull=7,
eTianShuShenDun=8,
}

function xianjieModel:isCanAttackRole(zmData,retArgs)
local actorid=zmData.actorid
if xianjieModel:isOpenFangHuZhao(actorid)then
if retArgs then
return false,_xjAttackTipsType.eOpenFHZ
end
return false
end

if xianjieModel:isOpenTianShuShenDun(actorid)then
if retArgs then
return false,_xjAttackTipsType.eTianShuShenDun
end
return false
end

local waiPaiData=xianjieModel:getWaiPaiByQBEntityData(actorid)
if waiPaiData then
if retArgs then
return false,_xjAttackTipsType.eAttackSame
end
return false
end

local myZmData=xianjieModel:getMyZongMenData()
if zmData.sceneidx~=myZmData.sceneidx then
if retArgs then
return false,_xjAttackTipsType.eDiffScene
end
return false
end

local ret=xianjieModel:checkWaiPaiTeamNum()
if not ret then
if retArgs then
local max=xianjieModel:getWaiPaiTeamMaxNum()
return false,_xjAttackTipsType.eWaiPaiTeamFull,max
end
return false
end

local model=xianjieModel:getMapMode()
if model==xjAttackMode.ePeace then
if retArgs then
return false,_xjAttackTipsType.ePeaceMode
end
return false
elseif model==xjAttackMode.eXianYu then
local ret=myZmData:getXianYuSceneIndex()~=zmData:getXianYuSceneIndex()
if not ret and retArgs then
return ret,_xjAttackTipsType.eOwnerMapSame
end
return ret
elseif model==xjAttackMode.eXianMeng then
local ret=myZmData:getXMGuildid()~=zmData:getXMGuildid()
if not ret and retArgs then
return ret,_xjAttackTipsType.eXianMengSame
end
return ret
elseif model==xjAttackMode.ePersion then
return true
end
return true
end

function xianjieModel:showAttackRoleTips(retType,args)
if retType==_xjAttackTipsType.ePeaceMode then
UIManager.error('当前地图不可攻击玩家')
elseif retType==_xjAttackTipsType.eOwnerMapSame then
UIManager.error('当前地图不可攻击同一仙域的玩家')
elseif retType==_xjAttackTipsType.eXianMengSame then
UIManager.error('当前地图不可攻击同一仙盟的玩家')
elseif retType==_xjAttackTipsType.eOpenFHZ then
UIManager.error('目标宗门已开启护山大阵，无法攻打')
elseif retType==_xjAttackTipsType.eTianShuShenDun then
UIManager.error('目标宗门已开启天枢神盾大阵，无法攻打')
elseif retType==_xjAttackTipsType.eAttackSame then
UIManager.error('已对玩家发起行军')
elseif retType==_xjAttackTipsType.eDiffScene then
UIManager.error('需与目标处于同一地图才可出征')
elseif retType==_xjAttackTipsType.eWaiPaiTeamFull then
UIManager.error(FMT.fmt('最多外派{0}支队伍',args))
end
end



function xianjieModel:setCurCountToday(value)
self.curCountToday=value
end

function xianjieModel:setCurCountToday_mojie(value,value2)
self.curCountToday_mj=value
self.curCountToday_mj_dz=value2
end

function xianjieModel:addCurCountToday()
if self.curCountToday then
self.curCountToday=self.curCountToday+1
else
self.curCountToday=1
end
end

function xianjieModel:addCurCountToday_mojie(way)
if way==0 then
self.curCountToday_mj=(self.curCountToday_mj or 0)+1
else
self.curCountToday_mj_dz=(self.curCountToday_mj_dz or 0)+1
end
end

function xianjieModel:getCurCountToday()
local sceneidx=xianjieModel:getSceneIndex()
local count
if xianjienSceneIndexType:isMoJie(sceneidx)then
count=self.curCountToday_mj
else
count=self.curCountToday
end

count=(count or 0)+1

return count
end

function xianjieModel:getMoJieZongMenMoveCount()
return self.curCountToday_mj or 0,self.curCountToday_mj_dz or 0
end

function xianjieModel:refreshAllEntityBuff()
local isFLXS=xianguanController:checkSelfHasJobByType(11)

if isFLXS then
xianjieModel:refreshAllEntityFunc('refreshPos',true)
end
end

function xianjieModel:refreshAllZongMenEntityModel()
local zmData=xianjieModel:getMyZongMenData()
if zmData then
xianjieController:invokeEntityFunc(zmData.ent_key,"changeModel")
end

xianjieModel:refreshAllEntityFunc('changeModel')
end

function xianjieModel:refreshAllEntityFunc(funcName,...)
for _,zmData in pairs(self.allZMDatas)do
xianjieController:invokeEntityFunc(zmData.ent_key,funcName,...)
end
end

function xianjieModel:checkCurrentInMoJie()
local sceneidx=xianjieModel:getSceneIndex()
return xianjienSceneIndexType:isMoJie(sceneidx)
end

function xianjieModel:checkMoJieZmMoveFreeCount()
if not xianjieModel:checkCurrentInMoJie()then return false end
local mjMoveCount=xianjieModel:getCurCountToday()
local costs=cfgHelper.get2(cfg_devildombaseconfig_get,1,'actormove')
local countMax=#costs
if mjMoveCount>countMax then return false end
local cost=costs[mjMoveCount]
if cost and next(cost)==nil then
return true
end
return false
end



function xianjieModel:setAttackerNotifyList(attacklistlen,attackList,is_login)
local attackNotifyLookup={}
local attackNotifyLenLookup={}
self.firstAttackType=nil
if attacklistlen>0 then
for _,v in ipairs(attackList)do




local guid=v.param_2
local attackType=v.param_2
if not self.firstAttackType then
self.firstAttackType=attackType
end
if not attackNotifyLookup[attackType]then
attackNotifyLookup[attackType]={}
attackNotifyLenLookup[attackType]=0
end
local guidStr=tostring(guid)
attackNotifyLookup[attackType][guidStr]=true
attackNotifyLenLookup[attackType]=attackNotifyLenLookup[attackType]+1
end
end
self.attackNotifyLenLookup=attackNotifyLenLookup
self.attackNotifyLookup=attackNotifyLookup
self.attackerLen=attacklistlen
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZMAttacktipEx)
if attacklistlen>0 and not flag then

if not UIManager:findActiveWindow("UIXianJie_ZMttackerWin")then
local notifyAttack=is_login==0
local _attackType=self.firstAttackType
UIManager:showWindow('UIXianJie_ZMttackerWin',{notifyAttack=notifyAttack,attackType=_attackType})
end
else
UIManager:closeWindow('UIXianJie_ZMttackerWin')
end
UIManager:invokeUIMethod("UIFuncStorageWin","refreshXiJiBtn")
UIManager:invokeUIMethod("UIXianJieFuncStorageWin","refreshXiJiBtn")
xianjieController:reqAttackerList(true)
end

function xianjieModel:isUnderAttack()
if not self.attackerLen then
return false
end
return self.attackerLen>0
end


function xianjieModel:isZMUnderAttack()
local flag=xianjieModel:isUnderAttack_Type(ATTACKTYPE.eXJActor)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMJActor)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMoJun)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eZhenYan)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMoZong)
return flag
end


function xianjieModel:isUnderAttack_Type(attackType)
if not self.attackNotifyLenLookup or not self.attackNotifyLenLookup[attackType]then
return false
end
return self.attackNotifyLenLookup[attackType]>0
end


function xianjieModel:isAttacker(attackType,guidStr)
if not self.attackNotifyLookup or not self.attackNotifyLookup[attackType]then
return false
end
return self.attackNotifyLookup[attackType][guidStr]~=nil
end


function xianjieModel:setAttackList(attackList)
local attackTimeLookup={}
local attackInfoListLookup={}
self.firstAttackType=nil
if attackList then
for i,v in ipairs(attackList)do
local attackType=v.attacktype
if not self.firstAttackType then
self.firstAttackType=attackType
end
if not attackInfoListLookup[attackType]then
attackInfoListLookup[attackType]={}
end
table.insert(attackInfoListLookup[attackType],v)
end

for attackType,typelist in pairs(attackInfoListLookup)do
local lerpTime
for _,attacker in ipairs(typelist)do
local teamData=xianjieModel:getMarchTeamData(attacker.marchguid)
local teamHandle=teamData and teamData:getTeamHandle()or nil
local lerpTime_=teamHandle and teamHandle:geLerpTime()or 0
if lerpTime==nil or lerpTime_>lerpTime then
lerpTime=lerpTime_
end
end
if lerpTime>0 then
attackTimeLookup[attackType]=lerpTime+timeHelper.getServerShortTime()
else
attackTimeLookup[attackType]=0
end
end
end
self.attackTimeLookup=attackTimeLookup
self.attackInfoListLookup=attackInfoListLookup
end


function xianjieModel:getAttackInfoList(attackType)
if not self.attackInfoListLookup then
return
end
return self.attackInfoListLookup[attackType]
end

function xianjieModel:getAttackTime(attackType)
if not self.attackTimeLookup or not self.attackTimeLookup[attackType]then
return 0
end
local left=self.attackTimeLookup[attackType]-timeHelper.getServerShortTime()
if left<0 then return 0 end
return left
end

function xianjieModel:getMinLeftAttackTime()
local minLeft,attackType,attackTabType
for k,type in pairs(ATTACKTYPE)do
local left=xianjieModel:getAttackTime(type)
if not minLeft or(left>0 and left<minLeft)then
minLeft=left
attackType=type
attackTabType=xianjieModel:attackType_To_attackTabType(attackType)
end
end
return minLeft,attackType,attackTabType
end

function xianjieModel:attackType_To_attackTabType(attackType)
if not self.tabLookUp then
self.tabLookUp={
[ATTACKTYPE.eXJActor]=ATTACKTABTYPE.eXJ,
[ATTACKTYPE.eMJActor]=ATTACKTABTYPE.eMJ,
[ATTACKTYPE.eMoZong]=ATTACKTABTYPE.eMJ,
[ATTACKTYPE.eMoJun]=ATTACKTABTYPE.eMJ,
[ATTACKTYPE.eMJActor_dazhen]=ATTACKTABTYPE.eBaoLei,
[ATTACKTYPE.eMoGong]=ATTACKTABTYPE.eMG,
[ATTACKTYPE.eZhenYan]=ATTACKTABTYPE.eMJ,
}
end
return self.tabLookUp[attackType]
end

function xianjieModel:getFirstTabType()
if self.firstAttackType then
return xianjieModel:attackType_To_attackTabType(self.firstAttackType)
end
return ATTACKTABTYPE.eXJ
end

function xianjieModel:getListAttackType(tabType)
if not self.attackTypeListLookUp then
self.attackTypeListLookUp={
[ATTACKTABTYPE.eXJ]={ATTACKTYPE.eXJActor,},
[ATTACKTABTYPE.eMJ]={ATTACKTYPE.eMJActor,ATTACKTYPE.eMoZong,ATTACKTYPE.eMoJun,ATTACKTYPE.eZhenYan,},
[ATTACKTABTYPE.eBaoLei]={ATTACKTYPE.eMJActor_dazhen,},
[ATTACKTABTYPE.eMG]={ATTACKTYPE.eMoGong,},
}
end
return self.attackTypeListLookUp[tabType]
end


function xianjieModel:isZMUnderAttack_TabType(tabType)
local attackTypeList=xianjieModel:getListAttackType(tabType)
for k,attackType in pairs(attackTypeList)do
if xianjieModel:isUnderAttack_Type(attackType)then
return true
end
end
return false
end



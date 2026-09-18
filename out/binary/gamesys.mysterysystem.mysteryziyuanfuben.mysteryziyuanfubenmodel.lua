






local _MODULENAME="mysteryZiYuanFuBenModel"


def_table(_MODULENAME)
mysteryZiYuanFuBenModel.name=_MODULENAME
mysteryZiYuanFuBenModel.data={}

function mysteryZiYuanFuBenModel:onAppStart()

end


function mysteryZiYuanFuBenModel:onEnterState(isReconnect)
self.data={}
self.initFBListFlag=nil
self.data.fbList={}
self.data.unitList={}
self.data.tongguanDiff={}
end


function mysteryZiYuanFuBenModel:onLeaveState(isReconnect)

self.data={}
self.initFBListFlag=nil
end

function mysteryZiYuanFuBenModel:onProtocolReq()

end

function mysteryZiYuanFuBenModel:getFirstArgs(tagId)
local firstPosArgs=cfgHelper.get(cfg_secretsceneziyuanfubenbaseconfig_get,1,"firstPosArgs")
return firstPosArgs[tagId]
end

function mysteryZiYuanFuBenModel:initFBList()
if not systemModel.isOpen(SYSTEM_DEFINE.eMiJingRand)then
return
end
mysteryZiYuanFuBenModel.initFBListFlag=true
self.fbIdList={}
self.data.fbList={}
local config=cfg_secretsceneziyuanfubenconfig()
self.data.resMysteryList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eResMystery,'resMysteryList',{})

local isRefreshFirstList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eResMystery,'isRefreshFirst',{})

local posList={}
for tagId,group in pairs(config)do
local data={}
local fbdata=nil
local openId={}
local curLayer=self:getCurLayer(tagId)
for id,config in pairs(group)do
local mjGroup=config.mjGroup
for index,mjId in ipairs(mjGroup)do
self.fbIdList[mjId]={tagId,id,index}
if curLayer>0 then
local resId=mysteryZiYuanFuBenModel:getCurResId(tagId,index)
if resId and resId==id and curLayer==index then
fbdata=mjId
end
else
if not fbdata then
local resId=mysteryZiYuanFuBenModel:getCurResId(tagId,index)
if resId and resId==id and(self:getZiYuanMysteryUseItem(tagId,index)==0)then
fbdata=mjId
end
end
end

end
local sysId=config.sysId
if worldBlockModel:checkBlockState(config.worldBlock[1],config.worldBlock[2]or 1,eWorldBlockState.OPEN)then
if sysId and systemModel.isOpen(sysId)then
table.insert(openId,config.mjId)
else
table.insert(openId,config.mjId)
end

end
end

local resMystery=self.data.resMysteryList[tagId]
local curId=nil
local gudingIndex=nil

if fbdata then

local miji=fbdata
data.mjId=miji
local group=self.fbIdList[miji]

curId=group[2]
else

if not resMystery or(type(resMystery)~="number")then
if not isRefreshFirstList[tagId]then
local firstPos=mysteryZiYuanFuBenModel:getFirstArgs(tagId)
if firstPos then
curId=firstPos[1]
gudingIndex=true
isRefreshFirstList[tagId]=true
else
curId=openId[math.random(1,#openId)]
end
else

curId=openId[math.random(1,#openId)]
end
else


if not isRefreshFirstList[tagId]then
local firstPos=mysteryZiYuanFuBenModel:getFirstArgs(tagId)
if firstPos then
curId=resMystery
gudingIndex=true
isRefreshFirstList[tagId]=true
else
curId=resMystery

end
else
curId=resMystery
end
end
end

if curId then
local config_=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,tagId,curId)
local addFlag=mysteryZiYuanFuBenModel:add_World_Mystery_unit(tagId,curId,gudingIndex)
if addFlag then
data.curId=curId
self.data.fbList[tagId]=data
self.data.resMysteryList[tagId]=curId
if config_.sysId and not systemModel.isOpen(config_.sysId)then
self.data.fbList[tagId]=nil
self.data.resMysteryList[tagId]=nil
end

else

for i=1,10 do
curId=openId[math.random(1,#openId)]
local addFlag=mysteryZiYuanFuBenModel:add_World_Mystery_unit(tagId,curId,gudingIndex)
if addFlag then
data.curId=curId
self.data.fbList[tagId]=data
self.data.resMysteryList[tagId]=curId
if config_.sysId and not systemModel.isOpen(config_.sysId)then
self.data.fbList[tagId]=nil
self.data.resMysteryList[tagId]=nil
end
break
end
end
end
end
end

worldModel:finishInit(eWorldUnitTpye.RESMYSTERY)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eResMystery,'resMysteryList',self.data.resMysteryList)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eResMystery,'isRefreshFirst',isRefreshFirstList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eResMystery)
end

function mysteryZiYuanFuBenModel:getGroupFbData(tagId)
return self.data.fbList[tagId]
end

function mysteryZiYuanFuBenModel:getFbData()
return self.data.fbList
end

function mysteryZiYuanFuBenModel:setFbDataFBId(tagId,fbId)
if self.data.fbList[tagId]then
self.data.fbList[tagId].mjId=fbId
end
end


function mysteryZiYuanFuBenModel:resetFbData(tagId)
local group=cfg_secretsceneziyuanfubenconfig_get(tagId)
local openId={}
for id,config in pairs(group)do
if worldBlockModel:checkBlockState(config.worldBlock[1],config.worldBlock[2]or 1,eWorldBlockState.OPEN)then
table.insert(openId,config.mjId)
end
end
if next(openId)then

local curId
for i=1,10 do
local curId=openId[math.random(1,#openId)]
local addFlag=mysteryZiYuanFuBenModel:add_World_Mystery_unit(tagId,curId)
if addFlag then
self.data.fbList[tagId]={curId=curId}
self.data.resMysteryList[tagId]=curId
break
end
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eResMystery,'resMysteryList',self.data.resMysteryList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eResMystery)

UIManager:invokeUIMethod("UIMysteryEnterZiYuanWin","onShow",{tagId,curId})
end
end

function mysteryZiYuanFuBenModel:resetFbDataByFbid(fbId)
local group=self.fbIdList[fbId]
if group then
mysteryZiYuanFuBenModel:resetFbData(group[1])
end
end

function mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(fbId)
if not self.fbIdList then

return
end
return self.fbIdList[fbId]
end

function mysteryZiYuanFuBenModel:checkPosition()
if self.data.resMysteryList then
local posList={}
for tagId,mijiId in pairs(self.data.resMysteryList)do
table.insert(posList,table.concat({tagId,mijiId},"-"))
end
worldPositionLibrary:checkData(eWorldUnitTpye.RESMYSTERY,posList)
end
end

function mysteryZiYuanFuBenModel:add_mysteryFB_unit(posGuid,worldId,x,z,blockId,flip)
self.data.unitList[posGuid]={worldId,x,z,blockId,flip}
end

function mysteryZiYuanFuBenModel:get_mysteryFB_unit(posGuid)
return self.data.unitList[posGuid]
end

function mysteryZiYuanFuBenModel:get_all_mysteryFB_unit()
return self.data.unitList
end

function mysteryZiYuanFuBenModel:get_mysteryFB_group_unit(tagId)
local data=mysteryZiYuanFuBenModel:getGroupFbData(tagId)
if data then
local key=table.concat({tagId,data.curId},"-")
return self.data.unitList[key]
end
end


function mysteryZiYuanFuBenModel:add_World_Mystery_unit(tagId,mijiId,gudingIndex)
local addFlag=true
local areaCfg=cfg_secretsceneziyuanfubenconfig_get(tagId)[mijiId]
local worldId=nil
local blockId=nil
local posGuid=table.concat({tagId,mijiId},"-")
local unit=self:get_mysteryFB_unit(posGuid)
local position,x,z,flip
local checkGuid=worldPositionLibrary:containData(posGuid)
local valid=true
if checkGuid then
valid=false
local data=worldPositionLibrary:getData(posGuid)
x=data.x
z=data.z
flip=data.flip
worldId=data.world
position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then

if position~=Vector3.zero then
if not unit then
mysteryZiYuanFuBenModel:add_mysteryFB_unit(posGuid,worldId,x,z,blockId,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.RESMYSTERY,posGuid)
end
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
self:showUnitImp(posGuid,areaCfg,worldId,x,z,flip)
end
end
return true
else
loggerUtil.logErrFMT("本地存在错误秘境旧坐标数据:{0},({1},{2}),{3}",worldId,x,z,tostring(posGuid))
worldPositionLibrary:eraseData(posGuid)
addFlag=false
end
else
addFlag=false
end
end
local randomPos=areaCfg.randomPos
local posList={}
for i,v in ipairs(randomPos)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v)
local world=cfg.world
local block=cfg.blockId
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
table.insert(posList,v)
end
end
local isGuDingPos=false
if gudingIndex then
if areaCfg.firstPos then
x=areaCfg.firstPos[1]
z=areaCfg.firstPos[2]
flip=areaCfg.firstPos[3]or false
worldId=areaCfg.worldBlock[1]
position,blockId=worldPositionConfig:getPosition(worldId,{x,z})
isGuDingPos=true
end
if not isGuDingPos then
loggerUtil.logErrFMT("随机秘境{0}firstPos字段没配",tagId)
end
end
if not isGuDingPos then
if next(posList)then
local check,temp=worldPositionLibrary:extract(posList)
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
worldId=temp[1].world

position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("随机秘境{0}坐标随机库抽取失败,GUID:{1}",tagId,tostring(posGuid))
addFlag=false
end
else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("随机秘境{0}坐标随机库无已解锁坐标,GUID:{1}",tagId,tostring(posGuid))
addFlag=false
end
end

if not worldId then
return false
end
if not unit then
mysteryZiYuanFuBenModel:add_mysteryFB_unit(posGuid,worldId,x,z,blockId,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.RESMYSTERY,posGuid)
end
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
self:showUnitImp(posGuid,areaCfg,worldId,x,z,flip)
end
end
return addFlag
end


function mysteryZiYuanFuBenModel:remove_World_Mystery_unit(tagId,mijiId)
local posGuid=table.concat({tagId,mijiId},'-')
local posData=self:get_mysteryFB_unit(posGuid)

if not posData then
return
end
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,tagId})
local taskKey=worldTaskModel:findTaskKey_ByTargetProgress(unitKey,eWorldTripProgress.Work)
if taskKey then
worldTaskController:returnMission(taskKey)
end
self.data.unitList[posGuid]=nil
worldPositionLibrary:eraseData(posData[5])
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
mysteryZiYuanFuBenModel:hideUnitImp(posGuid)
end

end


function mysteryZiYuanFuBenModel:onWorldPositionReRandom(rData,aData)


local group=string.split(rData.key,'-')
local tagId=tonumber(group[1])
local mijiId=tonumber(group[2])
local areaCfg=cfg_secretsceneziyuanfubenconfig_get(tagId)[mijiId]
local worldId=nil
local blockId=nil
local unit=self:get_mysteryFB_unit(tagId,mijiId)
local position,x,z,flip
local posGuid=table.concat({tagId,mijiId},"-")
local checkGuid=worldPositionLibrary:containData(posGuid)
local valid=true
if checkGuid then

worldPositionLibrary:eraseData(posGuid)
end
local randomPos=areaCfg.randomPos
local posList={}
for i,v in ipairs(randomPos)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v)
local world=cfg.world
local block=cfg.blockId
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
table.insert(posList,v)
end
end

if next(posList)then
local check,temp=worldPositionLibrary:extract(posList)
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
worldId=temp[1].world

position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("随机秘境{0}坐标随机库抽取失败,GUID:{1}",tagId,tostring(posGuid))
end
else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("随机秘境{0}坐标随机库无已解锁坐标,GUID:{1}",tagId,tostring(posGuid))
end

if not worldId then
return
end
if not unit then
mysteryZiYuanFuBenModel:add_mysteryFB_unit(posGuid,worldId,x,z,blockId,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.RESMYSTERY,posGuid)
end
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
self:showUnitImp(posGuid,areaCfg,worldId,x,z,flip)
end
end
end


function mysteryZiYuanFuBenModel:showUnitImp(posGuid,cfg,world,x,z,flip)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,posGuid})
local modelSettings=worldModel:getModelSettings(cfg.modelRes,eWorldUnitTpye.RESMYSTERY)
local hudSettings=worldModel:getHUDSetting(cfg.hudRes)
local luaData={eWorldUnitTpye.RESMYSTERY,posGuid}
local position=worldPositionConfig:getPosition(world,{x,z})
worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSettings)
worldController:setUnitFlipX(unitKey,flip or false)
end

function mysteryZiYuanFuBenModel:hideUnitImp(posGuid)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,posGuid})
worldController:popUnit(unitKey)
end


function mysteryZiYuanFuBenModel:checkCond(tagId,zjMjId,diffIndex)
local initLevel=mysteryZiYuanFuBenModel:getInitLevel()
local tongguanDiff=mysteryZiYuanFuBenModel:getTongGuanDiff(tagId)
local notPass=diffIndex-tongguanDiff>1

local allconfig=cfg_secretsceneziyuanfubenconfig()
local config=allconfig[tagId][zjMjId]

local smallworldlevel=config.smallworldlevel
if smallworldlevel then
if not mysteryZiYuanFuBenModel:checkLittleWorldLevel(tagId,zjMjId,diffIndex)then
return false
end
end

local diffCond=config.diffCond
if diffCond then
local cond=diffCond[diffIndex]
if cond then
if initLevel>0 and initLevel>=cond then
return true
end
if notPass then
return false
end
return systemConfig.isEnoughSingleCnd(SYSTEM_OPEN_TYPE.eZongmemLevelChanged,cond)
end
end
if notPass then
return false
end
return true
end

function mysteryZiYuanFuBenModel:checkLittleWorldLevel(tagId,zjMjId,diffIndex)
local allconfig=cfg_secretsceneziyuanfubenconfig()
local config=allconfig[tagId][zjMjId]

local smallworldlevel=config.smallworldlevel
if smallworldlevel then
local worldLv=LittleWorldModel:getLittleWorldLevel()
for i,v in ipairs(smallworldlevel)do
if diffIndex>=v[2]and worldLv<v[1]then
return false,v[1]
end
end
end
return true
end

function mysteryZiYuanFuBenModel:getTongGuanDiff(tagId)
local data=self.data.ziYuanMysteryData[tagId]or{}
return data.passDiff or 0
end

function mysteryZiYuanFuBenModel:getCurLayer(tagId)
local data=self.data.ziYuanMysteryData[tagId]or{}
return data.curLayer or 0
end

function mysteryZiYuanFuBenModel:SetprobeNum(tagId)
local data=self.data.ziYuanMysteryData[tagId]or{}
local probeCountCfg=cfg_secretsceneziyuanfubenbaseconfig_get(1).probeCount
if data and data.probeNum and probeCountCfg[tagId]and probeCountCfg[tagId][1]then
data.probeNum=data.probeNum+probeCountCfg[tagId][2]
if data.probeNum>probeCountCfg[tagId][3]then
data.probeNum=probeCountCfg[tagId][3]
end
self.data.ziYuanMysteryData[tagId]=data
end
end

function mysteryZiYuanFuBenModel:getprobeNum(tagId)
local data=self.data.ziYuanMysteryData[tagId]or{}
return data.probeNum or-1
end


function mysteryZiYuanFuBenModel:reduceprobeNum(tagId,num)
local data=self.data.ziYuanMysteryData[tagId]or{}
if data and data.probeNum then
data.probeNum=data.probeNum-num
if data.probeNum<0 then
data.probeNum=0
end
self.data.ziYuanMysteryData[tagId]=data
end
end

function mysteryZiYuanFuBenModel:setInitLevel(initLevel)
self.data.initLevel=initLevel
end

function mysteryZiYuanFuBenModel:getInitLevel()
local data=self.data.initLevel
return data or 0
end

function mysteryZiYuanFuBenModel:getMultiChallenge(tagId,index)
local data=self.data.ziYuanMysteryData[tagId]or{}
local layerData=data.layerData[index]or{}
return layerData.duobeiChallenge or 1
end

function mysteryZiYuanFuBenModel:set_temp_Multi(multi)
self.data.multi=multi
end

function mysteryZiYuanFuBenModel:get_temp_Multi()
return self.data.multi
end

function mysteryZiYuanFuBenModel:initZiYuanMysteryData(resList)
self.data.ziYuanMysteryData={}
if resList then
for _,v in ipairs(resList)do
local tagId=v.tagId
local data={tagId=tagId,curLayer=v.curLayer}
local passDiff=0
local layerData={}
if v.len>0 then
for _,lay in ipairs(v.layList)do
layerData[lay.mjGroupIndex]=lay
if lay.firstPass==1 then
passDiff=lay.mjGroupIndex
else
if mysteryZiYuanFuBenModel:checkPassRewardInitLevel(tagId,1,lay.mjGroupIndex)then
passDiff=lay.mjGroupIndex
end
end
end
end
data.passDiff=passDiff
data.layerData=layerData
data.curResId=v.curResId
data.probeNum=v.probeNum
self.data.ziYuanMysteryData[tagId]=data
end
end
end

function mysteryZiYuanFuBenModel:getCurResId(tagId,mjGroupIndex)
local data=self.data.ziYuanMysteryData[tagId]
if data then
return data.curResId
end



end

function mysteryZiYuanFuBenModel:getZiYuanMysteryJinDu(tagId,mjGroupIndex)
local data=self.data.ziYuanMysteryData[tagId]
if data and data.layerData and data.layerData[mjGroupIndex]then
return data.layerData[mjGroupIndex].jinDu
end
return 0
end

function mysteryZiYuanFuBenModel:getZiYuanMysteryUseItem(tagId,mjGroupIndex)
local data=self.data.ziYuanMysteryData[tagId]
if data and data.layerData and data.layerData[mjGroupIndex]then
return data.layerData[mjGroupIndex].useItem
end
return 1
end

function mysteryZiYuanFuBenModel:setZiYuanMysteryData(tagId,mjGroupIndex,stRWFlag)
local data=self.data.ziYuanMysteryData[tagId]or{}
local layerData=data.layerData or{}
if layerData[mjGroupIndex]then
layerData[mjGroupIndex].stRWFlag=stRWFlag
else
layerData[mjGroupIndex]={stRWFlag=stRWFlag}
end
data.layerData=layerData
self.data.ziYuanMysteryData[tagId]=data
end


function mysteryZiYuanFuBenModel:setZiYuanMysteryDataCurLayer(tagId,curLayer)
local data=self.data.ziYuanMysteryData[tagId]or{}
data.curLayer=curLayer
self.data.ziYuanMysteryData[tagId]=data
end

function mysteryZiYuanFuBenModel:isGotShouTongReward(tagId,mjGroupIndex)
local data=self.data.ziYuanMysteryData[tagId]or{}
local layerData=data.layerData or{}
if layerData[mjGroupIndex]then
return layerData[mjGroupIndex].stRWFlag==1
end
end


function mysteryZiYuanFuBenModel:checkPassRewardInitLevel(tagId,zjMjId,mjGroupIndex)
local initLevel=mysteryZiYuanFuBenModel:getInitLevel()
local allconfig=cfg_secretsceneziyuanfubenconfig()
local config=allconfig[tagId][zjMjId]
local diffCond=config.diffCond
if diffCond then
local cond=diffCond[mjGroupIndex]
if cond then
if initLevel>0 and initLevel>=cond then
return true
end
end
end
return false
end

function mysteryZiYuanFuBenModel:checkPassReward(tagId,zjMjId,mjGroupIndex)
if mysteryZiYuanFuBenModel:checkPassRewardInitLevel(tagId,zjMjId,mjGroupIndex)then
return true
end
local diffIndex=mysteryZiYuanFuBenModel:getTongGuanDiff(tagId)
return mjGroupIndex<=diffIndex
end

function mysteryZiYuanFuBenModel:checkPassRewardByFbId(fbid)
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(fbid)
if group then
if mysteryZiYuanFuBenModel:checkPassRewardInitLevel(group[1],group[2],group[3])then
return true
end
local diffIndex=mysteryZiYuanFuBenModel:getTongGuanDiff(group[1])
return group[3]<=diffIndex
end
end


function mysteryZiYuanFuBenModel:checkPassButNotGetReward(tagId,zjMjId,mjGroupIndex)
local isGot=mysteryZiYuanFuBenModel:isGotShouTongReward(tagId,mjGroupIndex)
if isGot then
return false
end
local allconfig=cfg_secretsceneziyuanfubenconfig()
local config=allconfig[tagId][zjMjId]
if not mysteryZiYuanFuBenModel:checkUnlock(config)then
return false
end
return mysteryZiYuanFuBenModel:checkPassReward(tagId,zjMjId,mjGroupIndex)
end

function mysteryZiYuanFuBenModel:checkPassButNotGetRewardzjMjId(tagId,zjMjId)
local allconfig=cfg_secretsceneziyuanfubenconfig()
local config=allconfig[tagId][zjMjId]
local mjGroup=config.mjGroup
if not mysteryZiYuanFuBenModel:checkUnlock(config)then
return false
end
for i,v in ipairs(mjGroup)do
if mysteryZiYuanFuBenModel:checkPassButNotGetReward(tagId,zjMjId,i)then
return true
end
end
return false
end

function mysteryZiYuanFuBenModel:checkPassReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eMiJingRand)then
return
end
local allconfig=cfg_secretsceneziyuanfubenconfig()
for index,v in pairs(allconfig)do
local fbData=mysteryZiYuanFuBenModel:getGroupFbData(index)
if fbData then
local curId=fbData.curId
if mysteryZiYuanFuBenModel:checkPassButNotGetRewardzjMjId(index,curId)then
return true
end
end
end
return false
end

function mysteryZiYuanFuBenModel:checkUnlock(config)
local zheXianLingret=true
local cond=config.condition
local book_id
local index
if cond then
book_id=cond[1]
index=cond[2]or 0
zheXianLingret=zheXianLingModel:checkFinish(book_id,index)
end
return zheXianLingret
end

function mysteryZiYuanFuBenModel:getCurMaxLayer(data)
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId)
local mjGroup=config.mjGroup
local max=#mjGroup
local curLayer=mysteryZiYuanFuBenModel:getCurLayer(config.tagId)
local unlock=mysteryZiYuanFuBenModel:checkUnlock(config)
local firstIdx=0
local secondIdx=0
for i=1,max do
local ret=unlock and mysteryZiYuanFuBenModel:checkCond(data.tagId,data.curId,i)
local pret=mysteryZiYuanFuBenModel:checkPassReward(data.tagId,data.curId,i)
if ret then
firstIdx=i
end
if pret then
secondIdx=i
end
end
return firstIdx,secondIdx
end

function mysteryZiYuanFuBenModel:getMjShowTypeStr(type)
local nameList={"灵石","灵矿","灵木","灵草","装备","古宝","灵兽"}

return nameList[type]
end

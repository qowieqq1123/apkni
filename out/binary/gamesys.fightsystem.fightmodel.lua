






local _MODULENAME="fightModel"




def_table(_MODULENAME)
fightModel.name=_MODULENAME
fightModel.data={}


function fightModel:onAppStart()
self.stage={}
end
local default_info=
{
fightKey=0,
}

function fightModel:onEnterState()
self.battle={}
self.replayParam={}
self.data.sendExtraArgs={}
self.data.fightLogData={}
self:loadInfo()
end


function fightModel:onLeaveState(isReconnet)


self:closeAllBattle(isReconnet)
self.data={}
self.data.sendExtraArgs={}
self.replayParam={}
self.data.fightLogData={}
end


function fightModel:onServerDataInitFinish()

end





local _worldOffset=Vector3.New(1000,-2000,2000)

fightModel._worldOffsetFixed=Vector3.New(0,-2000,2000)
fightModel.fightWorldBaseHeight=-2000
local _worldOffset2=Vector3.New(0,-2000,2000)
local _rowOneR=Vector3.New(2.0,0,0)+_worldOffset
local _rowTwoR=Vector3.New(4.0,0,0)+_worldOffset
local _rowThreeR=Vector3.New(4.0,0,0)+_worldOffset
local _rowOneL=Vector3.New(-2.0,0,0)+_worldOffset
local _rowTwoL=Vector3.New(-4.0,0,0)+_worldOffset
local _rowThreeL=Vector3.New(-4.0,0,0)+_worldOffset

local posInfoKey=
{
[stagePosType.TwoThree]="twoTheePos",
[stagePosType.OneTwo]="oneTwoPos",
[stagePosType.TwoOne]="twoOnePos",
[stagePosType.OnePos]="onePos"
}

local defaultPosInfo={id=stageCenterPos.left,pos=Vector3.New(0,0,0)+_worldOffset,left=true,rowPos=_rowOneL}

local centerPosInfo={Vector3.New(-3.21,0,0)+_worldOffset,Vector3.New(3.21,0,0)+_worldOffset}

function fightModel.getWorldCenter()
return _worldOffset
end

function fightModel.getWorldPosition(localPos)
return _worldOffset+localPos
end



function fightModel:getPosInfo(id)




local info={}
local cfg=cfgHelper.get(cfg_fightstageposconfig_get,id)
if cfg~=nil then
for k,v in pairs(cfg)do
info[k]=v
end
if cfg.twoTheePos then
info.pos=Vector3.New(cfg.twoTheePos[1],cfg.twoTheePos[2],cfg.twoTheePos[3])+_worldOffset
end
if cfg.rowPos then
info.rowPos=Vector3.New(cfg.rowPos[1],cfg.rowPos[2],cfg.rowPos[3])+_worldOffset
end
return info
end


defaultPosInfo.id=id
return defaultPosInfo
end

function fightModel:isLeft(id)





local cfg=cfgHelper.get(cfg_fightstageposconfig_get,id)
if cfg~=nil then
return cfg.left
end

return true
end

function fightModel:isAssist(id)





local cfg=cfgHelper.get(cfg_fightstageposconfig_get,id)
if cfg~=nil then
return cfg.assist
end

return false
end

function fightModel:getPosInfoByTypo(typo,id)






local cfg=cfgHelper.get(cfg_fightstageposconfig_get,id)
if cfg~=nil then

local info={}
for k,v in pairs(cfg)do
info[k]=v
end

local key=posInfoKey[typo]
local pos=cfg[key]
if pos then
info.pos=Vector3.New(pos[1],pos[2],pos[3])+_worldOffset
end
if cfg.rowPos then
info.rowPos=Vector3.New(cfg.rowPos[1],cfg.rowPos[2],cfg.rowPos[3])+_worldOffset
end
return info
end

defaultPosInfo.id=id
return defaultPosInfo
end

function fightModel:transToBattleWorld(localPos)
return localPos+_worldOffset
end

function fightModel:transToBattleWorld2(localPos)
return localPos+_worldOffset2
end


function fightModel:getcenterPos(isLeft)
return isLeft and centerPosInfo[1]or centerPosInfo[2]
end

function fightModel:getStage(id)
return cfgHelper.get1(cfg_fightstageconfig_get,id)
end

function fightModel:getJsonReport(strReport)
return jsonHelper.decode(strReport)
end


function fightModel:saveInfo()
userActorSetting.set('fightInfo',self.info)
userActorSetting.flush()
end

function fightModel:loadInfo()
self.info=userActorSetting.get('fightInfo',default_info)
end

function fightModel:saveFightReport(id,reportStr)
self:saveInfo()
end

function fightModel:createBattle(reportStr,onComplete,onClose,useReportMapId)
self.info.fightKey=self.info.fightKey+1
self:saveFightReport(self.info.fightKey,reportStr)
local battleObj=fightBattle(reportStr,self.info.fightKey,onComplete,onClose,useReportMapId)
self.battle[battleObj.id]=battleObj
return battleObj
end

function fightModel:getBattleStage(fightInfo)
local stageInfo=fightInfo[fightReportTag.stage]
if stageInfo[stageInfoTag.mapID]==0 then
return 1
end
return stageInfo[stageInfoTag.mapID]or 1
end


function fightModel:getBattleStageInfo(fightInfo)
return fightInfo[fightReportTag.stage]
end


function fightModel:getBattleResult(fightInfo)
return fightInfo[fightReportTag.result]
end


function fightModel:getBattle(id)
return self.battle[id]
end


function fightModel:removeBattle(id)
if self.battle~=nil then
self.battle[id]=nil
end
end


function fightModel:onBattleContinue(id)
if self.battle~=nil and self.battle[id]~=nil then
local battle=self.battle[id]
if battle and battle.isShowWindow then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()
end


local battleType=battle.battleType
self.continueBattleType=battleType
end
end

function fightModel:getBattleContinueType()
return self.continueBattleType
end



function fightModel:closeAllBattle(isReconnet)
if next(self.battle)then
for i,v in pairs(self.battle)do
v:onLeaveState(isReconnet)
end
self.battle={}
end
end

function fightModel:haveBattleShow()
if self.battle and next(self.battle)then
for i,v in pairs(self.battle)do
if v.isShowWindow and v.fightUseType==FIGHT_USE_TYPE.eNormal then
return i
end
end
end
end

function fightModel:isBattleShow(id)
local battle=fightModel:getBattle(id)
if battle then
return battle.isShowWindow
end
end

function fightModel:setPreSelectEntity(pool)
self.preSelectEntities=pool
end

function fightModel:getPreSelectEntity()
return self.preSelectEntities
end


function fightModel:getFightReport(id)
return cfg_customfightreportconfig_get(id)
end

function fightModel:getServerFightReport(id)
return cfg_fightserverreportconfig_get(id)
end

function fightModel:saveRePlayFightParam(args)
local log_id=args[2]
self.replayParam[log_id]=args
end

function fightModel:getRePlayFightParam(log_id)
return self.replayParam[log_id]
end


function fightModel:remapEntityAttr(rawAttr,testAttr,jzAttr)
local attr={}
for _,data in ipairs(rawAttr)do
attr[data[1]]=data[2]
end

if testAttr~=nil then
for _,data in ipairs(testAttr)do
attr[data[1]]=data[2]
end
end

if jzAttr~=nil then
for t,v in pairs(jzAttr)do
attr[t]=v
end
end

return attr
end


function fightModel:isDiziMonster(id)
local monsterCfg=cfgHelper.get(cfg_monsterconfig_get,id)
if monsterCfg then
if monsterCfg.modelid[2]then
return true
end
end
end


function fightModel:getEntityInfo(rawData,jzAfterAttr)
local headFlag=rawData[fightEntityTag.typo]
local rawAttr=rawData[fightEntityTag.attr]
local testAttr=rawData[fightEntityTag.test]
local attr=self:remapEntityAttr(rawAttr,testAttr,jzAfterAttr)

local fabao=rawData[fightEntityTag.fabao]

if headFlag==fightCommonTag.typoDizi then

local baseInfo=rawData[fightEntityTag.baseInfo]
local fabao=rawData[fightEntityTag.fabao]

local assistant=rawData[fightEntityTag.assistant]

local info={}
info.typo=fightEntityType.diZi
info.attr=attr
info.rawAttr=rawAttr
info.fabao=fabao
info.assistant=assistant
info.name=baseInfo[fightBaseInfoTag.name]
local jobInfo=baseInfo[fightBaseInfoTag.jobData]
local modelData=baseInfo[fightBaseInfoTag.model]
local weaponItemID=baseInfo[fightBaseInfoTag.weapon]or 0
info.tmlv=baseInfo[fightBaseInfoTag.tmlv]or-1

info.clothingId=baseInfo[fightBaseInfoTag.clothingId]
info.clothingStar=baseInfo[fightBaseInfoTag.clothingStar]
info.diziId=baseInfo[fightBaseInfoTag.diziId]
info.cvId=baseInfo[fightBaseInfoTag.cvId]
info.xianmo_voc=baseInfo[fightBaseInfoTag.xm_voc]
info.hidexianmodress=baseInfo[fightBaseInfoTag.hide_xm]
info.disguise=baseInfo[fightBaseInfoTag.disguise]
local xianmo_voc
if info.hidexianmodress~=1 then
xianmo_voc=info.xianmo_voc
end
local weaponID=0
if weaponItemID>0 then
local equipCfg=itemsConfig.getConfig(weaponItemID)
if equipCfg~=nil then
weaponID=equipCfg.imageID or 0
end
end
local args={
tmLv=info.tmlv,
clothingId=info.clothingId,
clothingStar=info.clothingStar,
xianmo_voc=xianmo_voc,
}
local image,outSideImage=UIDiscipleModel.getDiscipleFightModelInfo(jobInfo,modelData,weaponID,1.0,args)
info.model=outSideImage
info.image=image

info.jzAfterAttr=jzAfterAttr

info.weaponID=weaponID

return info

elseif headFlag>fightCommonTag.typoDizi then
local hp=attr[entityAttr.hp]or 0
local maxhp=attr[entityAttr.max_hp]or 1
local info=fightModel:createMonsterInfo(headFlag,hp,maxhp)
info.rawAttr=rawAttr
info.attr=attr
info.fabao=fabao

info.jzAfterAttr=jzAfterAttr

return info
end
end

function fightModel:getAssistantInfo(rawData)


local id=rawData[fightAssistantTag.id]
local modelId=rawData[fightAssistantTag.modelId]




local info={}
local cfg=cfgHelper.get(cfg_lingshouconfig_get,id)

local attr={}



info.attr=attr

local model={}

model.body=modelId


local modelCfg=cfgHelper.get2(cfg_dbbodyconfig_get,model.body)
local scaleArgs=modelCfg.scales
local fightScale=modelCfg.fightScales
model.scale=fightScale or(scaleArgs and scaleArgs[2])or 0.7
model.size=transformHelper.bodySize(model.body,model.scale)
info.name=cfg.name
info.model=model

return info
end

function fightModel:createEntityInfo(guid,hp,maxhp)
local info={}
info.typo=fightEntityType.diZi
local attr={}
info.attr=attr
attr[entityAttr.hp]=hp
attr[entityAttr.max_hp]=maxhp


local weaponID=UIDiscipleModel:getDiscipleShowWeaponID(guid,true)or 0

local clothingId,clothingStar

local xianmo_voc

local netdata=UIDiscipleModel:getDiscipleData(guid)

if not netdata then

netdata=otherPlayerModel:getDZBaseData(guid)
local clothing=otherPlayerModel:getDZEquipData(guid,EQUIP_TYPE.eShiZhuang)or{}
clothingId=clothing.itemid
clothingStar=clothing.star or 0
if netdata.hidexianmodress~=1 then
xianmo_voc=netdata.xianmo_voc
end
else
local clothing=ClothingModel:getEquipByDizi(guid)or{}
if netdata.hidedress~=1 then
clothingId=clothing.itemid
clothingStar=clothing.itemData and clothing.itemData.star or 0
end
if netdata.hidexianmodress~=1 then
xianmo_voc=netdata.xianmo_voc
end
end

if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
if equipCfg~=nil then
weaponID=equipCfg.imageID
else
weaponID=0
end
end



info.name=netdata.disciplename
local args={
tmLv=netdata.tmlv,
clothingId=clothingId,
clothingStar=clothingStar,
xianmo_voc=xianmo_voc,
}
local image,outSideImage=UIDiscipleModel.getDiscipleFightModelInfo(netdata.discipledata,netdata.discipleimage,weaponID,1.0,args)
info.model=outSideImage
info.image=image
info.tmlv=netdata.tmlv or-1
info.xianmo_voc=xianmo_voc
return info
end



function fightModel:createEntityInfoEx(arrangeDZ,hp,maxhp)
local info={}
info.typo=fightEntityType.diZi
local attr={}
info.attr=attr
attr[entityAttr.hp]=hp
attr[entityAttr.max_hp]=maxhp


local weaponID=otherPlayerModel:getArrangeDZ_weaponID(arrangeDZ)
local weaponImageID=0
if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
if equipCfg~=nil then
if equipCfg.imageID==nil then
logErr(FMT.fmt('weaponID:{0} 沒有配置iamgeID',weaponID))
weaponID=0
else
weaponID=equipCfg.imageID
end
else
weaponID=0
end
end
local clothingId=arrangeDZ.clothingId
local clothingStar=arrangeDZ.clothingStar
if not clothingId then
if arrangeDZ.dressList then
local clothing_equip=arrangeDZ.dressList[1]
if clothing_equip then
clothingId=clothing_equip.itemid
clothingStar=clothing_equip.itemData.star
end
end
end

local xianmo_voc
if arrangeDZ.hidexianmodress~=1 then
xianmo_voc=arrangeDZ.xianmo_voc
end

info.name='弟子'
local args={
tmLv=arrangeDZ.tmlv,
clothingId=clothingId,
clothingStar=clothingStar,
xianmo_voc=xianmo_voc,
}
local image,outSideImage=UIDiscipleModel.getDiscipleFightModelInfo(arrangeDZ.discipledata,arrangeDZ.discipleimage,weaponID,1.0,args)
info.model=outSideImage
info.image=image
info.tmlv=arrangeDZ.tmlv or-1
info.xianmo_voc=xianmo_voc

return info
end

function fightModel:createMonsterInfo(monsterID,hp,maxhp)
local info={}
info.typo=fightEntityType.monster
info.monsterID=monsterID
local attr={}
info.attr=attr
attr[entityAttr.hp]=hp
attr[entityAttr.max_hp]=maxhp

local monsterCfg=cfg_monsterconfig_get(monsterID)
local model={}

if monsterCfg~=nil then
model.body=monsterCfg.modelid[1]
model.componets=monsterCfg.modelid[2]
model.scale=monsterCfg.scale or 0.7
model.size=transformHelper.bodySize(model.body,model.scale)
info.name=monsterCfg.name
info.tmlv=monsterCfg.tmLevel
else
info.name='怪物'
end
info.model=model

return info
end



function fightModel:createVirtualInfo()
local info={}
info.typo=fightEntityType.monster
info.monsterID=1
local attr={}
info.attr=attr
attr[entityAttr.hp]=0
attr[entityAttr.max_hp]=0


info.name=eSpEntityName.eEmpty
info.model={}

return info
end

function fightModel:getSheildId(sheildLv)
local cfg=cfgHelper.get(cfg_shanmendazhenconfig_get,sheildLv)
return cfg.hudunBar or 1
end

function fightModel:createShieldInfo(sheildId,sheildVal,sheildMax,sheildLv)
local info={}
info.typo=fightEntityType.shield
info.sheildID=sheildId
info.sheildLv=sheildLv
local attr={}
info.attr=attr
attr[entityAttr.hp]=sheildVal
attr[entityAttr.max_hp]=sheildMax

local cfg=cfgHelper.get(cfg_fightsheildconfig_get,sheildId)
info.name='护盾'
if cfg then
info.effect=cfg.effect
info.entModel=cfg.model
info.enterBt=cfg.showBehavior
info.breakBt=cfg.breakBehavior
info.name=cfg.name or'护盾'
end
info.model={}

return info
end

function fightModel:checkNull(val)
return val==nil or tostring(val)=='userdata: NULL'
end

function fightModel:getJunZhenTeamList(numList,teamNum)
local newList={}
local total=0
for i,v in ipairs(numList or{})do
local jkNum=fightModel:checkNull(v[2])and 0 or v[2]
local qsNum=fightModel:checkNull(v[3])and 0 or v[3]

local csNum=fightModel:checkNull(v[4])and 0 or v[4]
local swNum=fightModel:checkNull(v[5])and 0 or v[5]
table.insert(newList,{v[1],math.ceil(jkNum/teamNum),math.ceil(qsNum/teamNum),math.ceil(csNum/teamNum),math.ceil(swNum/teamNum)})
total=total+jkNum
end

return newList,total
end

function fightModel:getJunZhenTotalNum(numList)
local total=0
for i,v in ipairs(numList or{})do
local jkNum=fightModel:checkNull(v[2])and 0 or v[2]
total=total+jkNum
end
return total
end


function fightModel:getJunZhenInfo(fightInfo)
return fightInfo[fightReportTag.jzRound]or{}
end


function fightModel:getZhanLiInfo(fightInfo)
local yuanjun=fightInfo[fightReportTag.yuanjun]
return yuanjun[fightYuanJunTag.zhanli]or{0,0}
end


function fightModel:getLeftActorId(fightInfo)
local stageInfo=fightInfo[fightReportTag.stage]
return stageInfo[stageInfoTag.leftActorId]
end


function fightModel:getRightActorId(fightInfo)
local stageInfo=fightInfo[fightReportTag.stage]
return stageInfo[stageInfoTag.rightActorId]
end

function fightModel:getLeftEntity(fightInfo)
local fightEntity=fightInfo[fightReportTag.attack]
return fightEntity
end

function fightModel:getRightEntityAttr(fightInfo)
local fightEntity=fightInfo[fightReportTag.defend]
return fightEntity
end

function fightModel:getLeftEntityAttr(fightInfo,index)
local fightEntity=fightInfo[fightReportTag.attack]
return fightEntity[index]and fightEntity[index][fightEntityTag.attr]
end

function fightModel:getRightEntityAttr(fightInfo,index)
local fightEntity=fightInfo[fightReportTag.defend]
return fightEntity[index]and fightEntity[index][fightEntityTag.attr]
end

local curUseJunModelIndex=0

function fightModel:initJunModelParam()
curUseJunModelIndex=curUseJunModelIndex+1
if curUseJunModelIndex>3 then
curUseJunModelIndex=0
end
end
function fightModel:replaceJunModel(abName)
return string.replace(abName,".ab",FMT.fmt("_{0}.ab",curUseJunModelIndex))
end



function fightModel:createJunZhenInfo(jzData,typo,mapId)

local info={}
info.typo=fightEntityType.junzhen

local jz=jzData[1]
local jzLv=jz and jz[1]or 1
local jzNum=0

for i,v in ipairs(jzData)do
if v[1]>jzLv then
jzLv=v[1]
end
jzNum=jzNum+v[2]
end

info.jzLv=jzLv
info.jzNum=jzNum

info.jzData=jzData

local cfg=cfgHelper.get(cfg_jzconfig_get,jzLv)

local attr={}
info.attr=attr

local model={}

local entModel=cfg.model
if typo>0 then
local monsterCfg=cfg_monsterconfig_get(typo)
local jzMonType=monsterCfg.jzMonType or 1
local jzConfigId=1
if mapId then
local stageCfg=fightModel:getStage(mapId)
if stageCfg and stageCfg.jzConfig then
jzConfigId=stageCfg.jzConfig
end
end

local mon_model=cfgHelper.get(cfg_jzbaseconfig_get,jzConfigId,"mon_model")
entModel=mon_model[jzMonType]
end

info.oriTypo=typo

info.name='军阵'
if cfg then
info.entModel=fightModel:replaceJunModel(entModel)
attr[entityAttr.hp]=cfg.hp
attr[entityAttr.max_hp]=cfg.hp
attr[entityAttr.def]=cfg.def
attr[entityAttr.attack]=cfg.attack

info.name=cfg.name or'军阵'
model.body=530000
model.componets={}
model.scale=0
end
info.model=model

return info
end




function fightModel:createStageList(index,stage)
self.stage[index]=stage
end

function fightModel:getStageList(index)
return self.stage[index]
end

function fightModel:closeStageList(index)
self.stage[index]=nil
end

function fightModel:closeAllStage()
if self.stage then
for idx,stage in pairs(self.stage)do
stage:close()
end
self.stage={}
end
end





function fightModel:setSendExtraArgs(battleType,args)

self.data.sendExtraArgs[battleType]=args
end

function fightModel:getSendExtraArgs(battleType)
return self.data.sendExtraArgs[battleType]
end

function fightModel:printStatisticsTimes()
local showId=self:haveBattleShow()
if showId then
local showBattle=self:getBattle(showId)
showBattle:printStatisticsTimes()
end
end

function fightModel:getHuaSeIcon(id)
return"icon_huase_"..id
end

function fightModel:banBattleAcc(flag)
self.battleAccBan=flag
end

function fightModel:getBattleAccBan()
return self.battleAccBan
end


function fightModel:saveLogReport(log_id,fightLog)
self.data.fightLogData[log_id]=fightLog
end

function fightModel:getLogReport(log_id)
return self.data.fightLogData[log_id]
end


function fightModel:isNewFightActionOpen()
return true
end
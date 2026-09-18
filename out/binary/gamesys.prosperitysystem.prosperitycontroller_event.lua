




function prosperityController:onAppStart_Event()

end

function prosperityController:onEnterState_Event(isReconnect)


notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)


notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)


notifySystem:listenNotify(notifyConfig.onDanFangUnlock,self.onDanFangUnlock)


notifySystem:listenNotify(notifyConfig.onGongFaActive,self.onZangJingGeChange)
notifySystem:listenNotify(notifyConfig.onGongFaStudyLevelChange,self.onZangJingGeChange)


notifySystem:listenNotify(notifyConfig.onQianJiGeUnlockSkill,self.onQianJiGeUnlockSkill)


notifySystem:listenNotify(notifyConfig.onGuildOrderChange,self.onGuildOrderChange)


notifySystem:listenNotify(notifyConfig.onChuanSongZhenUnlock,self.onChuanSongZhenUnlock)


notifySystem:listenNotify(notifyConfig.onWanBaoXunBaoDuiUnlockChannel,self.onWanBaoXunBaoDuiUnlockChannel)


notifySystem:listenNotify(notifyConfig.onXianZhanRoomChange,self.onXianZhanRoomChange)


notifySystem:listenNotify(notifyConfig.onXiuZhenJiaZuJinZhu,self.onYinXianTaiJiaZuChange)
notifySystem:listenNotify(notifyConfig.onXiuZhenJiaZuChange,self.onYinXianTaiJiaZuChange)
notifySystem:listenNotify(notifyConfig.onXiuZhenJiaZuDead,self.onYinXianTaiJiaZuChange)


notifySystem:listenNotify(notifyConfig.onXuanShangTaiLevelChange,self.onXuanShangTaiLevelChange)


notifySystem:listenNotify(notifyConfig.onZongMenAreaUnLock,self.onZongMenAreaUnLock)



notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleFRDUpdate)

notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onDiscipleFRDUpdate)
notifySystem:listenNotify(notifyConfig.onDiscipleNewID,self.onDiscipleFRDUpdate)





notifySystem:listenNotify(notifyConfig.onDiscipleSpecialityChange,self.onDiscipleSpecialityChange)



notifySystem:listenNotify(notifyConfig.onGuBaoActive,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoLianHua,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoShengXing,self.onGuBaoUpdate)




notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)

notifySystem:listenNotify(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
notifySystem:listenNotify(notifyConfig.onDiscipleTianMingCiFuChange,self.onDiscipleTianMingCiFuChange)
notifySystem:listenNotify(notifyConfig.onDiscipleShuWuLevelChange,self.onDiscipleShuWuLevelChange)
notifySystem:listenNotify(notifyConfig.onDiscipleShuWuQJLevelChange,self.onDiscipleShuWuQJLevelChange)



end

function prosperityController:onProtocolReq_Event()

end

function prosperityController:onLeaveState_Event()

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)


notifySystem:removelistener(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)


notifySystem:removelistener(notifyConfig.onDanFangUnlock,self.onDanFangUnlock)


notifySystem:removelistener(notifyConfig.onGongFaActive,self.onZangJingGeChange)
notifySystem:removelistener(notifyConfig.onGongFaStudyLevelChange,self.onZangJingGeChange)


notifySystem:removelistener(notifyConfig.onQianJiGeUnlockSkill,self.onQianJiGeUnlockSkill)


notifySystem:removelistener(notifyConfig.onGuildOrderChange,self.onGuildOrderChange)


notifySystem:removelistener(notifyConfig.onChuanSongZhenUnlock,self.onChuanSongZhenUnlock)


notifySystem:removelistener(notifyConfig.onWanBaoXunBaoDuiUnlockChannel,self.onWanBaoXunBaoDuiUnlockChannel)


notifySystem:removelistener(notifyConfig.onXianZhanRoomChange,self.onXianZhanRoomChange)


notifySystem:removelistener(notifyConfig.onXiuZhenJiaZuJinZhu,self.onYinXianTaiJiaZuChange)
notifySystem:removelistener(notifyConfig.onXiuZhenJiaZuChange,self.onYinXianTaiJiaZuChange)
notifySystem:removelistener(notifyConfig.onXiuZhenJiaZuDead,self.onYinXianTaiJiaZuChange)



notifySystem:removelistener(notifyConfig.onZongMenAreaUnLock,self.onZongMenAreaUnLock)



notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onDiscipleFRDUpdate)

notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.onDiscipleFRDUpdate)
notifySystem:removelistener(notifyConfig.onDiscipleNewID,self.onDiscipleFRDUpdate)



notifySystem:removelistener(notifyConfig.onDiscipleSpecialityChange,self.onDiscipleFRDUpdate)



notifySystem:removelistener(notifyConfig.onGuBaoActive,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoLianHua,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoShengXing,self.onGuBaoUpdate)

notifySystem:removelistener(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
notifySystem:removelistener(notifyConfig.onDiscipleTianMingCiFuChange,self.onDiscipleTianMingCiFuChange)

notifySystem:removelistener(notifyConfig.onDiscipleShuWuLevelChange,self.onDiscipleShuWuLevelChange)
notifySystem:removelistener(notifyConfig.onDiscipleShuWuQJLevelChange,self.onDiscipleShuWuQJLevelChange)
end



function prosperityController.on_building_event(etype,sfId,ubdId,arg1,arg2)

local bdData=zongmenModel:getBuildingData(ubdId)

if etype==buildingEvent.buildComplete or etype==buildingEvent.levelUpComplete then

prosperityModel:updateBuildFrData(bdData)
elseif etype==buildingEvent.replaceDisciple then

prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.DiscipleProfressionalSkill)
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
elseif etype==buildingEvent.planStart
or etype==buildingEvent.planCancel
or etype==buildingEvent.planComplete
then
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
elseif etype==buildingEvent.storageBuilding then
prosperityModel:initBuildingFrdData()
elseif etype==buildingEvent.placeBuilding then
prosperityModel:initBuildingFrdData()
end
end

function prosperityController.onDiscipleJobChange(discipleguid,jobtype,oldlv,lv,oldexp,exp)






local bdId=zongmenModel:getDiscipleBuilding(discipleguid)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData~=nil then
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.DiscipleProfressionalSkill)
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
end






end

function prosperityController.onDanFangUnlock(df_id)
prosperityModel:updateDanFangFRDValue(true)
end

function prosperityController.onZangJingGeChange()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.GongFa)
end

function prosperityController.onQianJiGeUnlockSkill()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.exploreSKill)
end

function prosperityController.onGuildOrderChange()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.ZongMenRule)
end

function prosperityController.onChuanSongZhenUnlock()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.ZhengYan)
end

function prosperityController.onWanBaoXunBaoDuiUnlockChannel()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.ChannelNum)
end

function prosperityController.onXianZhanRoomChange()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.XianZhanRoomNum)
end

function prosperityController.onYinXianTaiJiaZuChange()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.YinXianTaiJiaZu)
end

function prosperityController.onXuanShangTaiLevelChange()
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.XuanShangTaiLevel)
end

function prosperityController.onZongMenAreaUnLock(sfID,areaID)
prosperityModel:updateAreaFRValue(areaID,true)
end

function prosperityController.onDiscipleFRDUpdate()
prosperityModel:updateDiscipleFRDValue(true)
end

function prosperityController.onGuBaoUpdate(gbid)

if gubaoLookup:checkEffect(21,gbid)then
prosperityModel:updateAllBuildFrDataByFormulaType(FRD_SP_BuildingFunc_Index.ProduceRate)
end
end

function prosperityController.onZongMengLevelChange()
prosperityController.onDanFangUnlock()
end

function prosperityController.onDiscipleSpecialityChange(dis_guid,specialitytype,specialityid,updatetype)
local bdId=zongmenModel:getDiscipleBuilding(dis_guid)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData~=nil then
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
end
end

function prosperityController.onDiscipleTianMingLvChange(dis_guid,oldtmlv,tmlv)
local bdId=zongmenModel:getDiscipleBuilding(dis_guid)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData~=nil then
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
end
end

function prosperityController.onDiscipleTianMingCiFuChange(dis_guid)
local bdId=zongmenModel:getDiscipleBuilding(dis_guid)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData~=nil then
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
end
end

function prosperityController.onDiscipleShuWuLevelChange(dis_guid,index,lv)
local bdId=zongmenModel:getDiscipleBuilding(dis_guid)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData~=nil then
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
end
end

function prosperityController.onDiscipleShuWuQJLevelChange(dis_guid,lv)
local bdId=zongmenModel:getDiscipleBuilding(dis_guid)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData~=nil then
prosperityModel:updateBuildFrData(bdData,FRD_SP_BuildingFunc_Index.ProduceRate)
end
end





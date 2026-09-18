














local limitActInfo_zhengtaomojiang={name='zhengtaomojiang'}


function limitActInfo_zhengtaomojiang:onInit()

end


function limitActInfo_zhengtaomojiang:onStart()

end


function limitActInfo_zhengtaomojiang:onDelete()

end


function limitActInfo_zhengtaomojiang:checkReddot()
return false
end


function limitActInfo_zhengtaomojiang:jump(extraParams)
local stage=seasonModel:findFirstDoingStage(seasonStageType.eMJHD)
if stage then
local seasonType=stage.handle.id
local stageIndex=stage.index
local dataList=xianjieModel:getMoJiangSortList(seasonType,stageIndex)
for i,v in ipairs(dataList)do
local entityData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,v.id)
if entityData.killTime<=0 then
jumpManager:jump({id=JUMP_TYPE.eMoJiang,args={seasonType=seasonType,stageIndex=stageIndex,build_id=v.id}})
return
end
end
jumpManager:jump({id=JUMP_TYPE.eMoJiang,args={seasonType=seasonType,stageIndex=stageIndex,build_id=dataList[1].id}})
else
UIManager.error("魔将章节未开启")
end
end

function limitActInfo_zhengtaomojiang:checkCustomCondition(isWarning)
if not xianjieModel:checkJoin()then
if isWarning then
UIManager.error("仙域未开启")
end
return false
end
if not xianjieModel:checkCurrentMoJieEnterTime()then
if isWarning then
UIManager.error("魔界未开启")
end
return false
end
if not MojiePreviewExtendController.checkPoKaiMoJieFlag()then
if isWarning then
UIManager.error("魔界还未破开")
end
return false
end
if not seasonModel:haveDoingStage(seasonStageType.eMJHD)then
if isWarning then
UIManager.error("魔将章节未开启")
end
return false
end
return true
end

function limitActInfo_zhengtaomojiang:checkJump_time(isWarning)
if not xianjieModel:checkCurrentMoJieEnterTime()then
if isWarning then
UIManager.error("魔界未开启")
end
return false
end
if not seasonModel:haveDoingStage(seasonStageType.eMJHD)then
if isWarning then
UIManager.error("魔将章节未开启")
end
return false
end
return true
end

function limitActInfo_zhengtaomojiang:checkJump_data(isWarning)
if not xianjieModel:checkJoin()then
if isWarning then
UIManager.error("仙域未开启")
end
return false
end
if not MojiePreviewExtendController.checkPoKaiMoJieFlag()then
if isWarning then
UIManager.error("魔界还未破开")
end
return false
end
return true
end

return limitActInfo_zhengtaomojiang










local limitActInfo_mogongzhengduo={name='mogongzhengduo'}


function limitActInfo_mogongzhengduo:onInit()

end


function limitActInfo_mogongzhengduo:onStart()

end


function limitActInfo_mogongzhengduo:onUpdate()

end


function limitActInfo_mogongzhengduo:onDelete()

end


function limitActInfo_mogongzhengduo:onFinish()

end


function limitActInfo_mogongzhengduo:checkReddot()
return false
end


function limitActInfo_mogongzhengduo:jump()
if not xianjieController:checkCanEnterMoGongZhengDuo()then
return
end


fullScreenUI.closeActiveUI(false,true)
local sceneidx=xianjieModel:getSceneIndex()
if not xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then

local toSid=moGongZhengDuoActModel:getBaseConfig('sceneidx')
local sceneType=xianjieModel:sceneIndex2SceneType(toSid)
xianjieController:jumpXianJie(sceneType)
else

moGongZhengDuoActController:openArenaInfoWin()
end
end

function limitActInfo_mogongzhengduo:checkCustomCondition(isWarning)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
if isWarning then
UIManager.info("魔界未开启")
end
return false,"魔界未开启"
end


return true
end



return limitActInfo_mogongzhengduo
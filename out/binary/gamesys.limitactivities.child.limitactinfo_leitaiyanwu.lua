









local limitActInfo_leitaiyanwu={name='leitaiyanwu'}


function limitActInfo_leitaiyanwu:onInit()

end


function limitActInfo_leitaiyanwu:onStart()

xianJieArenaActController:checkReqArenaDataByIgnoreMJ()
end


function limitActInfo_leitaiyanwu:onUpdate()

end


function limitActInfo_leitaiyanwu:onDelete()

end


function limitActInfo_leitaiyanwu:onFinish()

end


function limitActInfo_leitaiyanwu:checkReddot()
return false
end


function limitActInfo_leitaiyanwu:jump()

fullScreenUI.closeActiveUI(false,true)
local sceneType=xianjienSceneType.eXianJie
if not mainControl:isSceneType(eSceneType.eXianJie)or xianjieModel:getScenceType()~=sceneType then

xianjieController:jumpXianJie(sceneType)
else

UIManager:invokeUIMethod("UIXianJieExtra_LTYWWin","onZhanKuangBtn")
end
end

function limitActInfo_leitaiyanwu:checkCustomCondition(isWarning)
local isDoingMoJie=limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJieSaiJi)
local pass=true
if isDoingMoJie then

pass=false











end
local tips=nil
if not pass and isWarning then
tips="需要等待魔界赛季结束"
UIManager.error(tips)
end
return pass,tips
end

return limitActInfo_leitaiyanwu
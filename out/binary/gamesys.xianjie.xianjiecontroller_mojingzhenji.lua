local _openFlag=0
function xianjieController:onAppStart_mojingzhenji()
socketManager:register_receiver(39,7,self.recv_39_7)
socketManager:register_receiver(39,8,self.recv_39_8)
socketManager:register_receiver(39,38,self.recv_39_38)
socketManager:register_receiver(39,39,self.recv_39_39)
socketManager:register_receiver(39,43,self.recv_39_43)
socketManager:register_receiver(39,45,self.recv_39_45)
socketManager:register_receiver(39,46,self.recv_39_46)
end

function xianjieController:onEnterState_mojingzhenji(isReconnet)
_openFlag=0
xianjieModel:initData_mojingzhenji()
end

function xianjieController:onLeaveState_mojingzhenji(isReconnet)
xianjieModel:clearData_mojingzhenji()
end

function xianjieController:onEnterMap_mojingzhenji()
xianjieModel:onEnterMap_mojingzhenji()
end

function xianjieController:onExitMap_mojingzhenji()
xianjieModel:onExitMap_mojingzhenji()
end

function xianjieController:reqBenYuanZhenJiData(season_id,chapter_idx,build_id,openFlag)
if openFlag then
_openFlag=_openFlag+1
end
seasonController:send_39_2(season_id,chapter_idx,1,build_id)
end

function xianjieController:reqBenYuanZhenJiList(season_id,chapter_idx)
seasonController:send_39_2(season_id,chapter_idx,2,0)
end

function xianjieController:reqBenYuanZhenJiBuyChangellNum(season_id,chapter_idx,build_id,num)
local addNumStr=tostring(num)
seasonController:send_39_2(season_id,chapter_idx,3,build_id,addNumStr)
end

function xianjieController.recv_39_7(args)
local season_id=args[1]
local chapter_idx=args[2]
local build_id=args[3]
xianjieModel:setBenYuanZhenJiNetData(season_id,chapter_idx,build_id,args)
local args={
buildId=build_id,
buyNum=args[7]or 0,
tzNum=args[8]or 0,
}
xianjieModel:setMoJingZhenJiChangellData(season_id,chapter_idx,build_id,args)

if _openFlag>0 then
_openFlag=_openFlag-1

xianjieController:openBenYuanZhenJiWin(season_id,chapter_idx,build_id)
end
end

function xianjieController.recv_39_8(season_id,chapter_idx,build_id)
xianjieModel:setMoJingZhenJiDestroyed(season_id,chapter_idx,build_id)
end

function xianjieController.recv_39_38(season_id,chapter_idx,len,byzjList)
xianjieModel:setBenYuanZhenJiNetList(season_id,chapter_idx,len,byzjList)

UIManager:invokeUIMethod("UIMoJieExplorationBenYuanZhenJiWin","inititem")
end

function xianjieController.recv_39_39(season_id,chapter_idx,zjtype,guid,useNum)
local useMoJing=tonumber(tostring(useNum))
if zjtype==1 then
local build_id=tonumber(tostring(guid))

xianjieModel:setBenYuanZhenJiUseMoJing(season_id,chapter_idx,build_id,useMoJing)

UIManager:invokeUIMethod("UIBenYuanZhenJiWin","refreshView",build_id)
else

local monsterData=xianjieModel:getPuTongZhenJiData(guid)
if monsterData~=nil then
monsterData.useMoJing=useNum

xianjieModel:refreshPuTongZhenJiData(monsterData,false)
UIManager:invokeUIMethod("UIXianJie_puTongZhenJiInfoWin","refreshWuXingZhenJi",nil,tostring(guid))
end
end
end

function xianjieController.recv_39_43(season_id,chapter_idx,byzjId,buyNum,tzNum)

local build_id=byzjId
local args={
buildId=byzjId,
tzNum=tzNum or 0,
buyNum=buyNum or 0,
}
xianjieModel:setMoJingZhenJiChangellData(season_id,chapter_idx,build_id,args)

UIManager:invokeUIMethod("UIBenYuanZhenJiWin","refeshChallenge",byzjId)
end

function xianjieController.recv_39_45(season_id,chapter_idx,ptzjDieNum,len,byzjList)

xianjieModel:setMoJingZhenJiUpdateNetList(season_id,chapter_idx,ptzjDieNum,len,byzjList)

UIManager:invokeUIMethod("UIBenYuanZhenJiWin","refreshView")
end

function xianjieController.recv_39_46(season_id,chapter_idx,buildingId,len,buffList)

xianjieModel:setMoJingZhenJiUpdateNetBuff(season_id,chapter_idx,buildingId,len,buffList)


end




function xianjieController:jumpMoJieBenYuanZhenJiByBuildId(buildId,isOpenWin,height)
height=height or 50
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end

local openFunc
if isOpenWin then
openFunc=function()
local data=xianjieModel:findBenYuanZhenJiDataByBuildId(buildId)
xianjieController:reqBenYuanZhenJiData(data.season_id,data.chapter_idx,data.entityId,true)
end
end

local buildCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,buildId)
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
xianjieController:jumpGrid(sceneIdx,buildCfg.x,buildCfg.y,openFunc,true,nil,height)
return true
end
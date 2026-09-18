








xjSceneStateType={
eMoveZongMen=1,
eClickLine=2,
eClickTeam=3,
eClickEmpty=4,
eMoveXianMeng=5,
}










local handleSceneStateLookup={
[xjSceneStateType.eMoveZongMen]={
enterState=function(stateType,...)
xianjieModel:enterSceneState_zmMove(stateType,...)
end,
refreshState=function(stateType,...)
xianjieModel:refreshSceneState_entity(stateType,...)
end,
leaveState=function(stateType)
xianjieModel:leaveSceneState_zmMove(stateType)
end,
closeMainCheck=true,
zoomSceneLeave=true,
winOpenLeave=true,
enterSceneStateLeave=true,
winOpenLeaveFilter={
['UIMoJie_ZongMenMoveTipsWin']=true,
},
},
[xjSceneStateType.eMoveXianMeng]={
enterState=function(stateType,...)
xianjieModel:enterSceneState_xmMove(stateType,...)
end,
refreshState=function(stateType,...)
xianjieModel:refreshSceneState_entity(stateType,...)
end,
leaveState=function(stateType)
xianjieModel:leaveSceneState_entity(stateType)
end,
closeMainCheck=true,
zoomSceneLeave=true,
winOpenLeave=true,
enterSceneStateLeave=true,
},
[xjSceneStateType.eClickLine]={
enterState=function(stateType,...)
xianjieModel:enterSceneState_clickLine(stateType,...)
end,
refreshState=function(stateType,...)
xianjieModel:refreshSceneState_entity(stateType,...)
end,
leaveState=function(stateType)
xianjieModel:leaveSceneState_entity(stateType)
end,
closeMainCheck=true,
clickSceneLeave=true,
zoomSceneLeave=true,
moveSceneLeave=true,
winOpenLeave=true,
enterSceneStateLeave=true,
},
[xjSceneStateType.eClickTeam]={
enterState=function(stateType,...)
xianjieModel:enterSceneState_clickTeam(stateType,...)
end,
refreshState=function(stateType,...)

end,
leaveState=function(stateType)
xianjieModel:leaveSceneState_clickTeam(stateType)
end,
closeMainCheck=true,
clickSceneLeave=true,
zoomSceneLeave=true,
moveSceneLeave=true,
winOpenLeave=true,
enterSceneStateLeave=true,
winOpenLeaveFilter={
['UIXJCaravanEscort_shipMsgWin']=true,
},
},
[xjSceneStateType.eClickEmpty]={
enterState=function(stateType,...)
xianjieModel:enterSceneState_clickEmpty(stateType,...)
end,
refreshState=function(stateType,...)
xianjieModel:refreshSceneState_entity(stateType,...)
end,
leaveState=function(stateType)
xianjieModel:leaveSceneState_entity(stateType)
end,
closeMainCheck=true,
zoomSceneLeave=true,
moveSceneLeave=true,
winOpenLeave=true,
enterSceneStateLeave=true,
},
}

local mSceneState=0
local entKeyLookup={}

function xianjieModel:clearSceneState()
mSceneState=0
entKeyLookup={}
end


function xianjieModel:clearSceneState_closeMain()
for stateType,handle in pairs(handleSceneStateLookup)do
if handle.closeMainCheck then
xianjieModel:leaveSceneState(stateType)
end
end
end

function xianjieModel:setSceneState(stateType,flag)
if flag then
mSceneState=bitHelper.set_1(mSceneState,stateType-1)
else
mSceneState=bitHelper.set_0(mSceneState,stateType-1)
end
end

function xianjieModel:checkSceneState(stateType)
return bitHelper.check_pos(mSceneState,stateType-1)
end

function xianjieModel:checkClickSceneState(sceneidx,gridX,gridZ,stateType,isValid)
if xianjieModel:checkSceneState(stateType)then
if isValid then
xianjieModel:refreshSceneState(stateType,gridX,gridZ)
end
return true
end
return false
end

function xianjieModel:checkSceneState_clickScene()
local check=false
for stateType,handle in pairs(handleSceneStateLookup)do
if handle.clickSceneLeave then
if xianjieModel:leaveSceneState(stateType)then
check=true
end
end
end
return check
end

function xianjieModel:checkSceneState_zoomScene()
local check=false
for stateType,handle in pairs(handleSceneStateLookup)do
if handle.zoomSceneLeave then
if xjSceneStateType.eMoveZongMen~=stateType and xianjieModel:leaveSceneState(stateType)then
check=true
end
end
end
return check
end

function xianjieModel:checkSceneState_moveScene()
local check=false
for stateType,handle in pairs(handleSceneStateLookup)do
if handle.moveSceneLeave then
if xianjieModel:leaveSceneState(stateType)then
check=true
end
end
end
return check
end

function xianjieModel:checkSceneState_winOpen(winName)
local check=false
for stateType,handle in pairs(handleSceneStateLookup)do
if handle.winOpenLeave and(handle.winOpenLeaveFilter==nil or not handle.winOpenLeaveFilter[winName])then
if xianjieModel:leaveSceneState(stateType)then
check=true
end
end
end
return check
end

function xianjieModel:checkSceneState_enterSceneState()
local check=false
for stateType,handle in pairs(handleSceneStateLookup)do
if handle.enterSceneStateLeave then
if xianjieModel:leaveSceneState(stateType)then
check=true
end
end
end
return check
end

function xianjieModel:enterSceneState(stateType,...)

if not xianjieModel:checkSceneState(stateType)then
xianjieModel:checkSceneState_enterSceneState()

xianjieController:closeWin3()
xianjieModel:setSceneState(stateType,true)
notifySystem:postNotify(notifyConfig.onXianJieSceneStateChange,stateType,true)
local handle=handleSceneStateLookup[stateType]
if handle then
handle.enterState(stateType,...)
end
else



end
end

function xianjieModel:refreshSceneState(stateType,...)
local handle=handleSceneStateLookup[stateType]
if handle then
handle.refreshState(stateType,...)
end
end

function xianjieModel:refreshSceneState_entity(stateType,...)
local entkey=entKeyLookup[stateType]
if entkey then
local ent=xianjieController:getEntity(entkey)
if ent then
ent:refreshPos(...)
end
end
end

function xianjieModel:getSceneStateEntity(stateType)
local entkey=entKeyLookup[stateType]
if entkey then
local ent=xianjieController:getEntity(entkey)
return ent
end
end

function xianjieModel:leaveSceneState(stateType)
if xianjieModel:checkSceneState(stateType)then

xianjieModel:setSceneState(stateType,false)
notifySystem:postNotify(notifyConfig.onXianJieSceneStateChange,stateType,false)
local handle=handleSceneStateLookup[stateType]
if handle then
handle.leaveState(stateType)
return true
end
end
return false
end

function xianjieModel:leaveSceneState_entity(stateType)
local entkey=entKeyLookup[stateType]
if entkey then
xianjieController:removeEntity(entkey)
entKeyLookup[stateType]=nil
end
end


function xianjieModel:enterSceneState_zmMove(stateType,gridX,gridZ,width,height)
local sceneidx=xianjieModel:getSceneIndex()
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local lookpos=xianjieController:worldGridPos2WorldPos4(gridX,gridZ,sceneidx)
local height=xianjieController:getDefaultCamerY(sceneType)
xianjieController:lookAtPositionChangeHeight(lookpos,height,nil,nil,nil)
local mapGridKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eMapGrid,{},true)
entKeyLookup[stateType]=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eZMMove,{gridX,gridZ,width,height,mapGridKey},true)

local isInMoJie=xianjieModel:isInMoJie()
if isInMoJie then
UIManager:showWindow("UIMoJie_ZongMenMoveTipsWin")
end
end

function xianjieModel:leaveSceneState_zmMove(stateType)
xianjieModel:leaveSceneState_entity(stateType)

local isInMoJie=xianjieModel:isInMoJie()
if isInMoJie then
UIManager:closeWindow("UIMoJie_ZongMenMoveTipsWin")
end
end



function xianjieModel:enterSceneState_xmMove(stateType,gridX,gridZ,width,height)
local sceneidx=xianjieModel:getSceneIndex()
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local lookpos=xianjieController:worldGridPos2WorldPos4(gridX,gridZ,sceneidx)
local height=xianjieController:getDefaultCamerY(sceneType)
xianjieController:lookAtPositionChangeHeight(lookpos,height,nil,nil,nil)
local mapGridKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eMapGrid,{},true)
entKeyLookup[stateType]=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eXMMove,{gridX,gridZ,width,height,mapGridKey},true)
end



function xianjieModel:enterSceneState_clickEmpty(stateType,gridX,gridZ,width,height)
entKeyLookup[stateType]=xianjieController:addEntity(XJ_ENTITY_TYPE.eClickEmpty,{gridX,gridZ,width,height},true)
end



function xianjieModel:enterSceneState_clickLine(stateType,clickEntKey,spos,epos,cpos)
entKeyLookup[stateType]=xianjieController:addEntity(XJ_ENTITY_TYPE.eClickLine,{clickEntKey,spos,epos,cpos},true)
end



function xianjieModel:enterSceneState_clickTeam_before(clickEntKey,callback)
local ent_=xianjieController:getEntity(clickEntKey)
if ent_==nil then return end
local sceneidx,cpos=ent_:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx)then
local func=function()
local ent=xianjieController:getEntity(clickEntKey)
if ent then
local sceneidx_,cpos_=ent:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx_)then
xianjieModel:enterSceneState(xjSceneStateType.eClickTeam,clickEntKey)
end
if callback then
return callback()
end
end
end
xianjieController:lookAtPosition(cpos,nil,0.2,func,DG.Tweening.Ease.Linear)
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local teamHandle=ent_:getTeamHandle()
local onlykey=teamHandle.onlykey
local func=function()
local teamHandle_=xianjieController:getXJTeamHandleByKey(onlykey)
local clickEntKey_=teamHandle_:getTeamEnityKey()
local ent=xianjieController:getEntity(clickEntKey_)
if ent then
local sceneidx_,cpos_=ent:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx_)then
local func2=function()
local ent_=xianjieController:getEntity(clickEntKey_)
if ent_ then
local sceneidx__,cpos__=ent_:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx__)then
xianjieModel:enterSceneState(xjSceneStateType.eClickTeam,clickEntKey_)
end
end

if callback then
return callback()
end
end
xianjieController:lookAtPosition(cpos_,nil,0.2,func2,DG.Tweening.Ease.Linear)
end
end
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end


function xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc,callback)
local ent_=xianjieController:getEntity(clickEntKey)
if ent_==nil then return end
local sceneidx,cpos=ent_:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx)then
local func=function()
local ent=xianjieController:getEntity(clickEntKey)
if ent then
local sceneidx_,cpos_=ent:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx_)then
xianjieModel:enterSceneState(xjSceneStateType.eClickTeam,clickEntKey)
end
if callback then
return callback()
end
end
end
xianjieController:lookAtPosition(cpos,nil,0.2,func,DG.Tweening.Ease.Linear)
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local func=function()
local clickEntKey_
if getEntityDataFunc then
local entityData=getEntityDataFunc()
clickEntKey_=entityData:getTeamEnityKey()
else
clickEntKey_=clickEntKey
end
local ent=xianjieController:getEntity(clickEntKey_)
if ent then
local sceneidx_,cpos_=ent:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx_)then
local func2=function()
local ent_=xianjieController:getEntity(clickEntKey_)
if ent_ then
local sceneidx__,cpos__=ent_:getTeamPos()
if xianjieModel:checkSceneIndex(sceneidx__)then
xianjieModel:enterSceneState(xjSceneStateType.eClickTeam,clickEntKey_)
end
end

if callback then
return callback()
end
end
xianjieController:lookAtPosition(cpos_,nil,0.2,func2,DG.Tweening.Ease.Linear)
end
end
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end

function xianjieModel:enterSceneState_clickTeam(stateType,clickEntKey)
entKeyLookup[stateType]=clickEntKey
local ent=xianjieController:getEntity(clickEntKey)
if ent then
ent:onSelect(nil,true)
ent:addHudEx()
end
end

function xianjieModel:leaveSceneState_clickTeam(stateType)
local clickEntKey=entKeyLookup[stateType]
if clickEntKey then
entKeyLookup[stateType]=nil
local ent=xianjieController:getEntity(clickEntKey)
if ent then
ent:removeHudEx()
ent:onSelect(nil,false)
end
end
end


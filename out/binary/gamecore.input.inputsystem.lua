






local _PlayerInput=CS.PlayerInput
local _PlayerInput_Instance=_PlayerInput.Instance
local _msg=CS.MessageInterface
local _msg_type=GlobalEventType


function inputSystem:init()

_PlayerInput.CreateTouchFilters(1)
_PlayerInput.Instance:SetTable('inputSystem')

end


function inputSystem:enter()


inputSystem.enable=true
inputSystem:init()
CS.EntityManager.Instance:SetEntityRayHitAction(inputSystem.onRayHitEntity)

end

function inputSystem:leave()

inputSystem.enable=false
CS.EntityManager.Instance:SetEntityRayHitAction(nil)

end


function inputSystem:on_lost_connection(...)

end

function inputSystem:on_app_quit()
_PlayerInput_Instance=nil
end







function inputSystem.onJoystickMoveStartDelegate()
notifySystem:postNotify(notifyConfig.joystickMoveStart)
return 0
end

function inputSystem.onJoystickMoveDelegate(screenPoint)
notifySystem:postNotify(notifyConfig.joystickMove,screenPoint)
return 0
end

function inputSystem.onJoystickMoveEndDelegate()
notifySystem:postNotify(notifyConfig.joystickMoveEnd)
return 0
end


function inputSystem.onSwipeStartDelegate(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
notifySystem:postNotify(notifyConfig.swipeStart,fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
return 0
end

function inputSystem.onSwipeDelegate(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
notifySystem:postNotify(notifyConfig.swipe,fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
return 0
end

function inputSystem.onSwipeEndDelegate(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
notifySystem:postNotify(notifyConfig.swipeEnd,fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
return 0
end

function inputSystem.onSwipeStart2FDelegate(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
notifySystem:postNotify(notifyConfig.swipeStart2F,fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
return 0
end

function inputSystem.onSwipe2FDelegate(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
notifySystem:postNotify(notifyConfig.swipe2F,fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
return 0
end

function inputSystem.onSwipeEnd2FDelegate(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
notifySystem:postNotify(notifyConfig.swipeEnd2F,fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
return 0
end










function inputSystem.onTouchStartDelegate(fingerIndex,touchCount,screenPoint,guid)
if not inputSystem.isInScreen(screenPoint)then return 0 end
notifySystem:postNotify(notifyConfig.touchStart,fingerIndex,touchCount,screenPoint,guid)
return 0
end


function inputSystem.onTouchDownDelegate(fingerIndex,touchCount,screenPoint)
if not inputSystem.isInScreen(screenPoint)then return 0 end
notifySystem:postNotify(notifyConfig.touchDown,fingerIndex,touchCount,screenPoint)
return 0
end


function inputSystem.onTouchUpDelegate(fingerIndex,touchCount,screenPoint,params)
if not inputSystem.isInScreen(screenPoint)then return 0 end
local guid
local guidList
local apiLevel=deviceHelper.getAPILevel()
if apiLevel>=434 then
guid=-1
guidList=params
if guidList and guidList.Count>0 then
guid=guidList[0]or-1
end
else
guid=params
end

notifySystem:postNotify(notifyConfig.touchUp,fingerIndex,touchCount,screenPoint,guid)
if apiLevel>=434 then
notifySystem:postNotify(notifyConfig.touchUpList,fingerIndex,touchCount,screenPoint,guidList)
end
return 0
end


function inputSystem.onPinchDelegate(fingerIndex,touchCount,screenPoint,deltaPinch,deltaTime)
if newbieControl.isInNewbie()then return 0 end
notifySystem:postNotify(notifyConfig.pinch,fingerIndex,touchCount,screenPoint,deltaPinch,deltaTime)
return 0
end
















function inputSystem.onLongTapDelegate(fingerIndex,touchCount,screenPoint)
notifySystem:postNotify(notifyConfig.longTap,fingerIndex,touchCount,screenPoint)
return 0
end


function inputSystem.onLongTapStartDelegate(fingerIndex,touchCount,screenPoint,guid)
notifySystem:postNotify(notifyConfig.longTapStart,fingerIndex,touchCount,screenPoint,guid)
return 0
end


function inputSystem.onLongTapEndDelegate(fingerIndex,touchCount,screenPoint)
notifySystem:postNotify(notifyConfig.longTapEnd,fingerIndex,touchCount,screenPoint)
return 0
end

function inputSystem.onRayHitEntity(guid)

notifySystem:postNotify(notifyConfig.rayHitEntity,guid)
end

function inputSystem.onWeakGuideChangeDeletgate(compKey,flag,rectTrans,sortLayer,sortOrder)
weakGuideController.onWeakGuideComponentChange(compKey,flag,rectTrans,sortLayer,sortOrder)
return 0
end

function inputSystem.onWeakGuideClickDeletgate(compKey)
weakGuideController.onWeakGuideComponentClick(compKey)
return 0
end

function inputSystem.isInScreen(screenPoint)
return screenPoint.x>=0 and screenPoint.x<=_Screen.width and
screenPoint.y>=0 and screenPoint.y<=_Screen.height
end

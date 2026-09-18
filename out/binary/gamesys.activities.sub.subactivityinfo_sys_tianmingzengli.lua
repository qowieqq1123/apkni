









local subActivityInfo_sys_tianmingzengli={name='subActivityInfo_sys_tianmingzengli'}

function subActivityInfo_sys_tianmingzengli:onInit()

self:setData({})

self._onTianMingZengliOpenChange=function(...)
self:onTianMingZengliOpenChange(...)
end
notifySystem:listenNotify(notifyConfig.onTianMingZengliOpenChange,self._onTianMingZengliOpenChange)
end

function subActivityInfo_sys_tianmingzengli:onStart()

end

function subActivityInfo_sys_tianmingzengli:onDelete()
notifySystem:removelistener(notifyConfig.onTianMingZengliOpenChange,self._onTianMingZengliOpenChange)
end


function subActivityInfo_sys_tianmingzengli:checkReddot()
local reddot,dzId=tianmingzengliModel:getTMZLEnterReddot()
return reddot
end


function subActivityInfo_sys_tianmingzengli:checkCondition(isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eTianMingZengLi)then
if isWarning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eTianMingZengLi)
UIManager.error(tips)
end
return false
end
return tianmingzengliController:checkIsCanOpenTMZLWin()
end


function subActivityInfo_sys_tianmingzengli:removeEnter()
tianmingzengliController:freshEnter(false)
end


function subActivityInfo_sys_tianmingzengli:resumeEnter()
local isShowEnter=tianmingzengliController:isEnterCanShow()
if isShowEnter then
tianmingzengliController:freshEnter(true)
end
end

function subActivityInfo_sys_tianmingzengli:onActivity_system_tab_Change(subType)
if subType==SUB_ACTIVITY_TYPE.eTianMingZengLi_sys then

end
end

function subActivityInfo_sys_tianmingzengli:onTianMingZengliOpenChange()
self:refreshCondition()
end

return subActivityInfo_sys_tianmingzengli
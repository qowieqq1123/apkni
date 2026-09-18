
local subActivityInfo_sys_xianyouruyun={name='subActivityInfo_sys_xianyouruyun'}

function subActivityInfo_sys_xianyouruyun:onInit()

self:setData({})

self._onXianYouRuYunOpenChange=function(...)
self:onXianYouRuYunOpenChange(...)
end
notifySystem:listenNotify(notifyConfig.onXianYouRuYunOpenChange,self._onXianYouRuYunOpenChange)
end

function subActivityInfo_sys_xianyouruyun:onStart()

end

function subActivityInfo_sys_xianyouruyun:onDelete()
notifySystem:removelistener(notifyConfig.onXianYouRuYunOpenChange,self._onXianYouRuYunOpenChange)
end


function subActivityInfo_sys_xianyouruyun:checkReddot()
local reddot=xianYouRuYunModel:getIsReddot()
return reddot
end


function subActivityInfo_sys_xianyouruyun:checkCondition(isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianYouRuYun)then
if isWarning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianYouRuYun)
UIManager.error(tips)
end
return false
end
return true
end


function subActivityInfo_sys_xianyouruyun:removeEnter()
xianYouRuYunController:freshEnter(false)
end


function subActivityInfo_sys_xianyouruyun:resumeEnter()
local isShowEnter=xianYouRuYunController:isEnterCanShow()
if isShowEnter then
xianYouRuYunController:freshEnter(true)
end
end

function subActivityInfo_sys_xianyouruyun:onActivity_system_tab_Change(subType)
if subType==SUB_ACTIVITY_TYPE.eXianYouRuYun_sys then

end
end

function subActivityInfo_sys_xianyouruyun:onXianYouRuYunOpenChange()
self:refreshCondition()
end

return subActivityInfo_sys_xianyouruyun
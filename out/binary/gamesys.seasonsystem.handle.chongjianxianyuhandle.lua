chongjianxianyuHandle=simple_class(seasonHandle)

function chongjianxianyuHandle:onInit()
self._on_37_1=function()
self:on_37_1()
end
self._onXianJieCloudUnlock=function()
self:onXianJieCloudUnlock()
end
self._onJoinXianYuFlagChange=function()
self:onJoinXianYuFlagChange()
end
socketManager:addNotify(37,1,self._on_37_1)
notifySystem:listenNotify(notifyConfig.onXianJieCloudUnlock,self._onXianJieCloudUnlock)
notifySystem:listenNotify(notifyConfig.onJoinXianYuFlagChange,self._onJoinXianYuFlagChange)
end

function chongjianxianyuHandle:onDelete()
socketManager:removeNotify(37,1,self._on_37_1)
notifySystem:removelistener(notifyConfig.onXianJieCloudUnlock,self._onXianJieCloudUnlock)
notifySystem:removelistener(notifyConfig.onJoinXianYuFlagChange,self._onJoinXianYuFlagChange)
end

function chongjianxianyuHandle:on_37_1()
notifySystem:postNotify(notifyConfig.onSeasonEnterConditionChange,self.id)
end

function chongjianxianyuHandle:onXianJieCloudUnlock()
notifySystem:postNotify(notifyConfig.onSeasonEnterConditionChange,self.id)
end

function chongjianxianyuHandle:onJoinXianYuFlagChange()
notifySystem:postNotify(notifyConfig.onSeasonEnterConditionChange,self.id)
end

function chongjianxianyuHandle:checkShowCondition()
if not self:checkCondition()then

return false
end
if self:isOver()then

return false
end
return true
end

return chongjianxianyuHandle

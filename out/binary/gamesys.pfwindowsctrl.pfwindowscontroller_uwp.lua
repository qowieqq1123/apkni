

function pfwindowslController:onAppStart_uwp()

end

function pfwindowslController:onEnterState_uwp(isReconnect)

end


function pfwindowslController:onLeaveState_uwp(isReconnect)

end


local showRatingReview=false

function pfwindowslController:setShowRatingReview(_showRatingReview)
showRatingReview=_showRatingReview
end

function pfwindowslController:canVisiableUwpHaoPing()
if verifyManager:isOpen()then
return false
end
return showRatingReview
end


local UwpHaoPingGiftIdGiftId=90

function pfwindowslController:getUwpHaoPingGiftIdGiftId()
return UwpHaoPingGiftIdGiftId
end



function pfwindowslController:checkEnterUwpHaoPing(needRemove)
local isOpen=pfwindowslController:canVisiableUwpHaoPing()
if isOpen then

platformSDK.printSDK('[bindPhone] enterManager:freshEnter',self.enterUwpHaoPingGuid)
self.enterUwpHaoPingGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eUwpHaoPing,getReddotFun=function()
return false
end})
else
if self.enterUwpHaoPingGuid then
pfwindowslController:removeEnterUwpHaoPing()
end
local iscanget=FreeGiftController.GetFreeGift(UwpHaoPingGiftIdGiftId)
if iscanget then
FreeGiftController.SendFreeGift(UwpHaoPingGiftIdGiftId,nil,function()

end)
end
end
end


function pfwindowslController:removeEnterUwpHaoPing()

UIManager:closeWindow("UI_UwpHaoPingWin")
enterManager:freshFunc('onClose',ENTER_TYPE.eUwpHaoPing)
local ret=enterManager:removeEnter(self.enterUwpHaoPingGuid)
self.enterUwpHaoPingGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end


function pfwindowslController:refreshEnterUwpHaoPingReddot()

end

function pfwindowslController:testShowRatingReview()
pfwindowslController:setShowRatingReview(true)
pfwindowslController:checkEnterUwpHaoPing()
end









def_class("UIXianJie_JiJie_msgSettingWin",UIWindowBase)









function UIXianJie_JiJie_msgSettingWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.btnConfirm=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.titleName=UIText.get(self,3)
self.autoBtn=UIButton.get(self,4)
self.endGoBtn=UIButton.get(self,5)
self.autoMarkSelect=UIObject.get(self,6)
self.endGoMarkSelect=UIObject.get(self,7)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.autoBtn:setButtonClick(function()self:onAutoBtn()end)

self.endGoBtn:setButtonClick(function()self:onEndGoBtn()end)



end


function UIXianJie_JiJie_msgSettingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.autoBtn);self.autoBtn=nil;
_UIObject_release(self.endGoBtn);self.endGoBtn=nil;
_UIObject_release(self.autoMarkSelect);self.autoMarkSelect=nil;
_UIObject_release(self.endGoMarkSelect);self.endGoMarkSelect=nil;
end



















function UIXianJie_JiJie_msgSettingWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_JiJie_msgSettingWin:__delete()
self:unbindComponents()
end




function UIXianJie_JiJie_msgSettingWin:onShow(argtable,afterOnloaded)
self.actorId=argtable and argtable.actorId
self.guid=argtable and argtable.guid

self.msgData=xianjieModel:getJiJieTeamDetail(self.actorId,self.guid)
local infoguid=self.msgData.infoguid
local monsterData=xianjieModel:getMonsterData(infoguid)
self.isMoJun=false
if not monsterData then
if xianjieModel:isMoJunBuild_int64(infoguid)then
self.isMoJun=true
end
end
self.autoBtn:setActive(not self.isMoJun)

self:refresh()
end


function UIXianJie_JiJie_msgSettingWin:onHide()

end

function UIXianJie_JiJie_msgSettingWin:refresh()

local isAuto=self.msgData.autoGo==1
self.autoMarkSelect:setActive(isAuto)

local isEndGo=self.msgData.endGo==1
self.endGoMarkSelect:setActive(isEndGo or self.isMoJun)
end





function UIXianJie_JiJie_msgSettingWin:onClickMask()
return self:onCloseBtn()
end



function UIXianJie_JiJie_msgSettingWin:onBtnConfirm()
return self:onCloseBtn()
end



function UIXianJie_JiJie_msgSettingWin:onCloseBtn()
self:closeSelf()
end



function UIXianJie_JiJie_msgSettingWin:onAutoBtn()
if not self.msgData then
return
end
local chuZhengSec=self.msgData.sec
if chuZhengSec==0 then

return
else
local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("队员正在前往集结，无法取消勾选")
end
end

local isAuto=self.msgData.autoGo==1

local infoguid=self.msgData.infoguid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieChangeAuto
local actorId=self.actorId
local auto=isAuto and 0 or 1
local endGoFlag=self.msgData.endGo or 1
local params={auto,endGoFlag}
local pstr=jsonHelper.encode(params)
xianjieModel:setJiJieLocalData_lastSelectAutoFlag(auto)
xianjieModel:saveJiJieLocalData()
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)
end



function UIXianJie_JiJie_msgSettingWin:onEndGoBtn()
if not self.msgData then
return
end
if self.isMoJun then
return
end
local chuZhengSec=self.msgData.sec
if chuZhengSec==0 then

return
else
local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("队员正在前往集结，无法取消勾选")
end
end

local isEndGo=self.msgData.endGo==1

local infoguid=self.msgData.infoguid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieChangeAuto
local actorId=self.actorId
local endGoFlag=isEndGo and 0 or 1
local autoFlag=self.msgData.autoGo or 1
local params={autoFlag,endGoFlag}
local pstr=jsonHelper.encode(params)

local func1=function()
xianjieModel:setJiJieLocalData_lastSelectEndGoFlag(endGoFlag)
xianjieModel:saveJiJieLocalData()
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)
end
if isEndGo then

return func1()
else

local desc='勾选到点自动出征后，在集结时间结束后未集结到足够的修士也会出征，是否勾选？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func1,REPEAT_TYPE.eXianJieJiJieEndGo)
end
end


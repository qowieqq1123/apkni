







def_class("UISubAct_CangBaoTuUnlockTips",UIWindowBase)









function UISubAct_CangBaoTuUnlockTips:bindComponents()

self.background=UIButton.get(self,0)
self.numTips=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.item=UIBaseItem.get(self,3)
self.jumpBtn=UIButton.get(self,4)
self.friendBtn=UIButton.get(self,5)
self.guildBtn=UIButton.get(self,6)
self.descTx=UIText.get(self,7)
self.extraTips=UIText.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.friendBtn:setButtonClick(function()self:onFriendBtn()end)

self.guildBtn:setButtonClick(function()self:onGuildBtn()end)



end


function UISubAct_CangBaoTuUnlockTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.numTips);self.numTips=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.friendBtn);self.friendBtn=nil;
_UIObject_release(self.guildBtn);self.guildBtn=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.extraTips);self.extraTips=nil;
end
















local _this=nil




function UISubAct_CangBaoTuUnlockTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_CangBaoTuUnlockTips:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_CangBaoTuUnlockTips:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.piece=argtable.piece
self.map=argtable.map
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self:refreshNum()

self.guildBtn:setImageExGray(not xianmengModel:hasXM())
self.friendBtn:setActive(systemModel.isOpen(SYSTEM_DEFINE.eFriend))

local pieceName=self.config.mapName[self.map][3][self.piece]
local money=self.config.money[self.piece]
local moneyName=itemsConfig.getColorName(money)
local descStr=FMT.fmt("解锁{0}需要{1}\n祖师尚未获得，是否前往",pieceName,moneyName)
self.descTx:setText(descStr)
local conf={itemid=money,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClickEx(...)
end)


self.extraTips:setText("")

end


function UISubAct_CangBaoTuUnlockTips:onHide()

end





function UISubAct_CangBaoTuUnlockTips:onCloseBtn()
self:closeSelf()
end



function UISubAct_CangBaoTuUnlockTips:onJumpBtn()
weakGuideController:beginGuide(self.config.weakGuide)
self:closeSelf()
end



function UISubAct_CangBaoTuUnlockTips:onFriendBtn()
local data=self.info:getData()
if data.task.helptimes<self.config.help then
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
piece=self.piece,
funcType=2,
closeCallback=function()
self.extraTips:setActive(false)
end
}
self:showWindow("UISubAct_CangBaoTuFriendListWin",args)
self.extraTips:setActive(true)
else
UIManager.error("今日求助次数已用完")
end
end



function UISubAct_CangBaoTuUnlockTips:onGuildBtn()
if not xianmengModel:hasXM()then
local show_data={
type='UIDialouge',
title='提示',
content='祖师尚未加入仙盟，是否前往加入',
oktext='前往',
canceltext='取消',
okcallback=function()
jumpManager:jump({id=JUMP_TYPE.eXianMengJoin})
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
end

local data=self.info:getData()
if data.task.helptimes<self.config.help then
local money=self.config.money[self.piece]
local least=self.info:checkSOSTime(money)
if least>=0 then
activitiesHandle_cangbaotu:reqSOSItem(self.activityId,self.subId,int64.zero,money)
self.info:markSOSTime(money)
self:closeSelf()
else
UIManager.error(FMT.fmt("{0}秒后才可继续求助",-least))
end
else
UIManager.error("今日求助次数已用完")
end
end

function UISubAct_CangBaoTuUnlockTips:onBackground()
self:closeSelf()
end

function UISubAct_CangBaoTuUnlockTips:refreshNum(check)
if check then
if check[1]~=self.activityId or check[2]~=self.subType or check[3]~=self.subId then
return
end
end
local data=self.info:getData()
local str=FMT.fmt("今日求助次数：{0}/{1}",data.task.helptimes,self.config.help)
self.numTips:setText(str)
end
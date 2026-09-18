







def_class("UILunDaoGuanJunWin",UIWindowBase)









function UILunDaoGuanJunWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.frontClick=UIButton.get(self,3)
self.mainPanel=UIObject.get(self,4)
self.jie=UIText.get(self,5)
self.titleModel=UIObject.get(self,6)
self.playerRoot=UIObject.get(self,7)
self.zrBtn=UIButton.get(self,8)
self.closeBtn=UIButton.get(self,9)

self.mask:setButtonClick(function()self:onMask()end)

self.frontClick:setButtonClick(function()self:onFrontClick()end)

self.zrBtn:setButtonClick(function()self:onZrBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILunDaoGuanJunWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.frontClick);self.frontClick=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.jie);self.jie=nil;
_UIObject_release(self.titleModel);self.titleModel=nil;
_UIObject_release(self.playerRoot);self.playerRoot=nil;
_UIObject_release(self.zrBtn);self.zrBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end



















function UILunDaoGuanJunWin:onLoaded(...)
self:bindComponents()

notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:refreshServer()
end)
end


function UILunDaoGuanJunWin:__delete()
self:unbindComponents()
end




function UILunDaoGuanJunWin:onShow(args,afterOnloaded)
lundaodahuiModel:setShowGuanJunWinFlag(true)
socketManager:send_17_39()

local serverId,playerId,name,iconInfo=args.serverId,args.playerId,args.name,args.piList
self.serverId=serverId
self.playerId=playerId
self.name=name
self.iconInfo=iconInfo
local serverName=loginModel:getServerName(serverId)
local jieShu=lundaodahuiModel:getJieShu()
self.jie:setText(jieShu)
local widget=self.playerRoot:getChildWidgetBase()
widget:SetChildText(0,FMT.fmt("<color=#f1ce78>{0}</color>\n{1}",serverName,name))

playerController:setImage(widget,3,nil,iconInfo,true)
playerController:setHeadIcon(widget,1,{scale=1,iconInfo=iconInfo})

self.mainPanel:setChildCanvasGroupAlpha(0)
local tweener=self.mainPanel:setChildCanvasGroupDOFade(1,0.5)
tweener:SetDelay(0.5)
end


function UILunDaoGuanJunWin:onHide()

end

function UILunDaoGuanJunWin:refreshServer()
local widget=self.playerRoot:getChildWidgetBase()
local serverName=loginModel:getServerName(self.serverId)
widget:SetChildText(0,FMT.fmt("<color=#f1ce78>{0}</color>\n{1}",serverName,self.name))
end





function UILunDaoGuanJunWin:onMask()
self:closeSelf()
end



function UILunDaoGuanJunWin:onFrontClick()
end



function UILunDaoGuanJunWin:onZrBtn()
UIFullLunDaoDaHuiControl:showLookRivalWinNew(self.playerId,{self.serverId,self.iconInfo,self.name},true)
end



function UILunDaoGuanJunWin:onCloseBtn()
self:closeSelf()
end


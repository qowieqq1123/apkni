







def_class("UIGuPiaoRongYuWin",UIWindowBase)









function UIGuPiaoRongYuWin:bindComponents()

self.half_1=UIObject.get(self,0)
self.half_2=UIObject.get(self,1)
self.rankItem_1=UIObject.get(self,2)
self.rankItem_2=UIObject.get(self,3)
self.closeButton=UIButton.get(self,4)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIGuPiaoRongYuWin")end)
self.half={
self.half_1,
self.half_2,
}
self.rankItem={
self.rankItem_1,
self.rankItem_2,
}



end


function UIGuPiaoRongYuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.half_1);self.half_1=nil;
_UIObject_release(self.half_2);self.half_2=nil;
_UIObject_release(self.rankItem_1);self.rankItem_1=nil;
_UIObject_release(self.rankItem_2);self.rankItem_2=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
self.half=nil;
self.rankItem=nil;
end



















local widgetIndex=
{
head=0,
name=2,
server=3,
yq=4,
half=5,
zanBtn=6,
zan=7,
caiBtn=8,
cai=9,
gridRoot=10,
show=11,
hide=12,
headBtn=15,
}


function UIGuPiaoRongYuWin:onLoaded(...)
self:bindComponents()
self.speak={}
end


function UIGuPiaoRongYuWin:__delete()
self:unbindComponents()
end




function UIGuPiaoRongYuWin:onShow(argtable,afterOnloaded)
if not shangHangController:send_248_100()then
self:freshInfo()
end
end


function UIGuPiaoRongYuWin:onHide()
self:stopSpeak(1)
self:stopSpeak(2)
end

function UIGuPiaoRongYuWin:freshInfo()
self:freshGuShenInfo()
self:freshJiuShenInfo()
end

function UIGuPiaoRongYuWin:freshCount()
local data=shanmenModel:get_gushen_data()
if data and next(data)then
local widget=self.rankItem_2:getWidgetBase()
widget:SetChildText(widgetIndex.zan,data.like)
widget:SetChildText(widgetIndex.cai,data.hate)
end

local data=shanmenModel:get_jiushen_data()
if data and next(data)then
local widget=self.rankItem_1:getWidgetBase()
widget:SetChildText(widgetIndex.zan,data.like)
widget:SetChildText(widgetIndex.cai,data.hate)
end
end

function UIGuPiaoRongYuWin:freshGuShenInfo()
local data=shanmenModel:get_gushen_data()
local widget=self.rankItem_2:getWidgetBase()
if data and next(data)and data.server~=0 then
widget:SetChildActive(widgetIndex.show,true)
widget:SetChildActive(widgetIndex.hide,false)
widget:SetChildText(widgetIndex.name,data.name)
widget:SetChildText(widgetIndex.yq,FMT.fmt("总资产：{0}",mathHelper.formatNumber5(data.yuquan,2)))
local serverName=loginModel:getServerName(data.server)
widget:SetChildText(widgetIndex.server,serverName)
widget:SetChildText(widgetIndex.zan,data.like)
widget:SetChildText(widgetIndex.cai,data.hate)
local comment_cnt=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"comment_cnt")
widget:SetChildButtonClick(widgetIndex.zanBtn,function()
local cnt=shangHangModel:getLikeOrHateCnt()
if cnt<comment_cnt then



socketManager:send_248_101(1,1,0)
else
UIManager.error("次数不足")
end
end)
widget:SetChildButtonClick(widgetIndex.caiBtn,function()
local cnt=shangHangModel:getLikeOrHateCnt()
if cnt<comment_cnt then
socketManager:send_248_101(1,2,0)
else
UIManager.error("次数不足")
end
end)

local playerImage=data.icon.piList or playerImageModel:getDefaultImage()
playerImageController.setPlayerModel(self.winid,self.half[2]:getID(),playerImage,0.7,eAnimationID.idle,0,-50)

playerController:setHeadIcon(widget,widgetIndex.head,{iconInfo=data.icon,scale=HEAD_SCALE_TYPE.e60x60})
if data.actorId then
widget:SetChildButtonClick(widgetIndex.headBtn,function()
otherPlayerController:openOtherPlayerInfoWin(data.actorId)
end)
end
self:stopSpeak(1)
self:startSpeak(widget,1,8)
else
widget:SetChildActive(widgetIndex.show,false)
widget:SetChildActive(widgetIndex.hide,true)

local playerImage=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"good_man_body")


playerImageController.setPlayerModel(self.winid,self.half[2]:getID(),playerImage,0.7,eAnimationID.idle,0,-50)
end
local good_man_conf=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"good_man_conf")
local reward=good_man_conf[3]
widget:SetChildLayoutGroupCreateItems(widgetIndex.gridRoot,2,function(itemIdx)

local itemCmp=widget:GetChildLayoutGroupGridItem(widgetIndex.gridRoot,itemIdx-1)
local conf={itemid=reward[itemIdx][1],itemcount=reward[itemIdx][2]>1 and reward[itemIdx][2]or'',showCountBG=reward[1][2]>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemCmp:SetChildPropData(0,prop)
itemCmp:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
end

function UIGuPiaoRongYuWin:freshJiuShenInfo()
local data=shanmenModel:get_jiushen_data()
local widget=self.rankItem_1:getWidgetBase()
if data and next(data)and data.server~=0 then
widget:SetChildActive(widgetIndex.show,true)
widget:SetChildActive(widgetIndex.hide,false)
widget:SetChildText(widgetIndex.name,data.name)
widget:SetChildText(widgetIndex.yq,FMT.fmt("总资产：{0}",mathHelper.formatNumber5(data.yuquan,2)))
local serverName=loginModel:getServerName(data.server)
widget:SetChildText(widgetIndex.server,serverName)
widget:SetChildText(widgetIndex.zan,data.like)
widget:SetChildText(widgetIndex.cai,data.hate)
local comment_cnt=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"comment_cnt")
widget:SetChildButtonClick(widgetIndex.zanBtn,function()
local cnt=shangHangModel:getLikeOrHateCnt()
if cnt<comment_cnt then
socketManager:send_248_101(2,1,0)
else
UIManager.error("次数不足")
end
end)
widget:SetChildButtonClick(widgetIndex.caiBtn,function()
local cnt=shangHangModel:getLikeOrHateCnt()
if cnt<comment_cnt then
socketManager:send_248_101(2,2,0)
else
UIManager.error("次数不足")
end
end)

local playerImage=data.icon.piList or playerImageModel:getDefaultImage()
playerImageController.setPlayerModel(self.winid,self.half[1]:getID(),playerImage,0.7,eAnimationID.idle,0,-50)
playerController:setHeadIcon(widget,widgetIndex.head,{iconInfo=data.icon,scale=HEAD_SCALE_TYPE.e60x60})
self:stopSpeak(2)
self:startSpeak(widget,2,6)
if data.actorId then
widget:SetChildButtonClick(widgetIndex.headBtn,function()
otherPlayerController:openOtherPlayerInfoWin(data.actorId)
end)
end
else
widget:SetChildActive(widgetIndex.show,false)
widget:SetChildActive(widgetIndex.hide,true)

local playerImage=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"bad_man_body")
playerImageController.setPlayerModel(self.winid,self.half[1]:getID(),playerImage,0.7,eAnimationID.idle,0,-50)
end
local bad_man_conf=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"bad_man_conf")
local reward=bad_man_conf[3]
widget:SetChildLayoutGroupCreateItems(widgetIndex.gridRoot,2,function(itemIdx)
local itemCmp=widget:GetChildLayoutGroupGridItem(widgetIndex.gridRoot,itemIdx-1)
local conf={itemid=reward[itemIdx][1],itemcount=reward[itemIdx][2]>1 and reward[itemIdx][2]or'',showCountBG=reward[1][2]>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemCmp:SetChildPropData(0,prop)
itemCmp:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)

end

function UIGuPiaoRongYuWin:onCloseBtn()
self:closeSelf()
end

function UIGuPiaoRongYuWin:startSpeak(widget,idx,delay)
local cfg=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"yurongSpeakText")
local list=cfg[idx]
self.speak[idx]=self:setTimer(delay,0,function()
widget:SetChildCanvasGroupAlpha(13,0)
widget:SetChildCanvasGroupDOFade(13,1,0.2)

widget:SetChildText(14,list[math.random(1,#list)])
local hide=widget:SetChildCanvasGroupDOFade(13,0,0.2)
hide:SetDelay(2)
end)
end

function UIGuPiaoRongYuWin:stopSpeak(idx)
if self.speak[idx]then
self:stopTimerByID(self.speak[idx])
self.speak[idx]=nil
end
end



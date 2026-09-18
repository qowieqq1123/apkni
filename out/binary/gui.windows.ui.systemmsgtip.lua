







def_class("SystemMsgTip",UIWidgetBase)





SystemMsgTip.abName="preload/ui/systemmsgtip.ab"

SystemMsgTip.assetName="SystemMsgTip"


function SystemMsgTip:bindComponents()

self.topXiaoren=UIObject.get(self,0)
self.ani=UIObject.get(self,1)
self.HorseRaceLamp=UIObject.get(self,2)
self.midXiaoren=UIObject.get(self,3)

end


function SystemMsgTip:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topXiaoren);self.topXiaoren=nil;
_UIObject_release(self.ani);self.ani=nil;
_UIObject_release(self.HorseRaceLamp);self.HorseRaceLamp=nil;
_UIObject_release(self.midXiaoren);self.midXiaoren=nil;
end







local _tipsType=
{
eNone=0,
eTopHourse=1,
eMidHourse=2,
ePlayerNotify=3,
ePlayerWaning=4,
eMoneyTips=5,
}

function SystemMsgTip:onLoaded(...)
self:bindComponents()
end

function SystemMsgTip:__delete()
self:unbindComponents()
end

function SystemMsgTip:onShow()
end

function SystemMsgTip:onHide()

end




function SystemMsgTip:__init(widget,name)
self.__name=name or''
self.widget=widget
self.isClose=false
CS.BindWidget(widget,self)
end

function SystemMsgTip:showTopAni()
if self.isShowTopHorseAni then return end
self.isShowTopHorseAni=true



self.topXiaoren:setChildUIModelShowTarget(2071,1,nil,eAnimationID.enter)
end

function SystemMsgTip:hideTopAni()
if not self.isShowTopHorseAni then return end
self.isShowTopHorseAni=false
self.topXiaoren:setChildUIModelRemoveTarget()


end

function SystemMsgTip:showMidAni()
if self.isShowMidHorseAni then return end
self.isShowMidHorseAni=true
self.midXiaoren:setChildUIModelShowTarget(2071,1,nil,eAnimationID.enter)
end

function SystemMsgTip:hideMidAni()
if not self.isShowMidHorseAni then return end
self.isShowMidHorseAni=false
self.midXiaoren:setChildUIModelRemoveTarget()
end



function SystemMsgTip:onStart(tipsType)
if tipsType==_tipsType.eTopHourse then
self:showTopAni()
end
if tipsType==_tipsType.eMidHourse then
self:showMidAni()
end
end

function SystemMsgTip:onFinish(tipsType)
if tipsType==_tipsType.eTopHourse then
self:hideTopAni()
end
if tipsType==_tipsType.eMidHourse then
self:hideMidAni()
end
end
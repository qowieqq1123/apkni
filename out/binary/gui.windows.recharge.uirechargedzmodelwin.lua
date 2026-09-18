







def_class("UIReChargeDzModelWin",UIWindowBase)









function UIReChargeDzModelWin:bindComponents()

self.dzModel=UIObject.get(self,0)
self.dzSpeak=UIObject.get(self,1)
self.txtDzSpeak=UIText.get(self,2)



end


function UIReChargeDzModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.dzSpeak);self.dzSpeak=nil;
_UIObject_release(self.txtDzSpeak);self.txtDzSpeak=nil;
end

















local _DOTween=Lua.DOTweenProxyExtensions
local _Ease=DG.Tweening.Ease


function UIReChargeDzModelWin:onLoaded(...)
self:bindComponents()
end


function UIReChargeDzModelWin:__delete()
self:unbindComponents()
if self.tween then
self.tween:Kill(false)
self.tween=nil
end
end




function UIReChargeDzModelWin:onShow(argtable,afterOnloaded)
self:flushDzModel()
end


function UIReChargeDzModelWin:onHide()

end



function UIReChargeDzModelWin:flushDzModel()
local dzList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort)
if#dzList>0 then
local rand=math.random(1,#dzList)
local dzData=dzList[rand]
local netdata=dzData.netData
local net=netdata.net
local guid=net.discipleguid

comHelper.setChildHead2(self.dzModel,guid,nil,nil,-62,false)
self.dzSpeak:setActive(true)
self.txtDzSpeak:setText('有问题记得\n找我哦！')
local speakObj=self.winlua:GetChildGameObject(self.dzSpeak:getID())
local speakTrans=speakObj.transform
local speakCanvasGroup=CS.UIHelper.GetCanvasGroup(speakTrans.gameObject)
self:loopSpeak(speakCanvasGroup)
end
end

function UIReChargeDzModelWin:loopSpeak(speakCanvasGroup)
self.tween=_DOTween.DOFade(speakCanvasGroup,0,1)
self.tween:SetEase(_Ease.Linear)
self.tween:SetDelay(8)
self.tween:OnComplete(function()
self.tween=_DOTween.DOFade(speakCanvasGroup,1,1)
self.tween:SetDelay(5)
self.tween:OnComplete(function()
self:loopSpeak(speakCanvasGroup)
end)
end)
end

function UIReChargeDzModelWin:onClickModel()

UIManager.info('打开客服问题反馈界面')
end

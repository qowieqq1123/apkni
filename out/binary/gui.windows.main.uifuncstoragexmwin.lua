







def_class("UIFuncStorageXMWin",UIWindowBase)









function UIFuncStorageXMWin:bindComponents()

self.emailBtn=UIButton.get(self,0)
self.funcList=UIObject.get(self,1)
self.funcListbtn=UIButton.get(self,2)
self.funcListbtnselect=UIObject.get(self,3)
self.funcListReddot=UIObject.get(self,4)
self.xianmengInviteBtn=UIButton.get(self,5)
self.xmdgRewardBtn=UIButton.get(self,6)
self.yuLingZhaiBtn=UIButton.get(self,7)
self.gateApplyBtn=UIButton.get(self,8)

self.emailBtn:setButtonClick(function()self:onEmailBtn()end)

self.funcListbtn:setButtonClick(function()self:onFuncListbtn()end)

self.xianmengInviteBtn:setButtonClick(function()self:onXianmengInviteBtn()end)

self.xmdgRewardBtn:setButtonClick(function()self:onXmdgRewardBtn()end)

self.yuLingZhaiBtn:setButtonClick(function()self:onYuLingZhaiBtn()end)

self.gateApplyBtn:setButtonClick(function()self:onGateApplyBtn()end)



end


function UIFuncStorageXMWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.emailBtn);self.emailBtn=nil;
_UIObject_release(self.funcList);self.funcList=nil;
_UIObject_release(self.funcListbtn);self.funcListbtn=nil;
_UIObject_release(self.funcListbtnselect);self.funcListbtnselect=nil;
_UIObject_release(self.funcListReddot);self.funcListReddot=nil;
_UIObject_release(self.xianmengInviteBtn);self.xianmengInviteBtn=nil;
_UIObject_release(self.xmdgRewardBtn);self.xmdgRewardBtn=nil;
_UIObject_release(self.yuLingZhaiBtn);self.yuLingZhaiBtn=nil;
_UIObject_release(self.gateApplyBtn);self.gateApplyBtn=nil;
end


















function UIFuncStorageXMWin:onLoaded(...)
self:bindComponents()

self.bShowFuncList=simpleModeControl:getFuncStorageSimple()
if self.bShowFuncList then
self.funcList:setChildCanvasGroupAlpha(1)
self.funcList:setActive(true)
self.funcListReddot:setActive(false)
self:doPunchRotation(false)
else
self.funcList:setChildCanvasGroupAlpha(0)
self.funcList:setActive(false)
self:clearTweener_AllBtn()
end

self.funcListbtnselect:setActive(self.bShowFuncList)

self:setTimer(1,-1,function()
self:refreshReddot()
end)
end

function UIFuncStorageXMWin:__delete()
self:doPunchRotation(false)
self:clearTweener_AllBtn()
self:clearFLTweener()
self:unbindComponents()
end

function UIFuncStorageXMWin:onShow(argtable,afterOnloaded)
self:refresh()
self:refreshReddot()
end

function UIFuncStorageXMWin:onHide()
self:doPunchRotation(false)
self:clearTweener_AllBtn()
end





function UIFuncStorageXMWin:onXianmengInviteBtn()
local num=xianmengModel:getInvitationCount()
if num>0 then
UIManager:showWindow('UIXianMengInviteWin')
end
end



function UIFuncStorageXMWin:onEmailBtn()
if mailController:hasReddot()then
mailController:showMailUI()
end
end



function UIFuncStorageXMWin:onXmdgRewardBtn()
xianmengdigongController:openEventRewardWin()
end



function UIFuncStorageXMWin:onFuncListbtn()
self:changeFuncListShow(not self.bShowFuncList)
end


function UIFuncStorageXMWin:refreshReddot()
if not self.bShowFuncList then
local isReddot=self:checkReddot()
self.funcListReddot:setActive(isReddot)
self:doPunchRotation(isReddot)
end
end

function UIFuncStorageXMWin:checkReddot()
return mainCountHelper:checkXMCountWin()
end

function UIFuncStorageXMWin:refresh()
self:refreshXianMengInviteBtn()
self:refreshEmailBtn()
self:refreshxmdgRewardBtn()
self:refreshYuLingZhaiBtn()
self:refreshGateApplyBtn()
end

function UIFuncStorageXMWin:refreshXianMengInviteBtn()
local num=xianmengModel:getInvitationCount()
local check=num>0
self.xianmengInviteBtn:setActive(check)
if not check then
return
end
local widget=self.xianmengInviteBtn:getChildWidgetBase()
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end

function UIFuncStorageXMWin:refreshEmailBtn()
local num=mailModel:getReddotCount()
local check=num>0
self.emailBtn:setActive(check)
if not check then
return
end
local widget=self.emailBtn:getChildWidgetBase()
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end

function UIFuncStorageXMWin:refreshxmdgRewardBtn()
local list=xianmengdigongModel:getAllHasRewardEvent()
local num=0
if list~=nil then
num=#list
end
local check=num>0
self.xmdgRewardBtn:setActive(check)
if not check then
return
end
local widget=self.xmdgRewardBtn:getChildWidgetBase()
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end

function UIFuncStorageXMWin:refreshYuLingZhaiBtn()
local state=YuLingZhaiModel:getHealType()
self.yuLingZhaiBtn:setActive(state==1)
end

function UIFuncStorageXMWin:refreshGateApplyBtn()
local showGateApplyBtn=xianjieModel:checkIsShowGateApplyBtn()
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local check
if showGateApplyBtn then
local num=xianjieModel:checkMoJieGateNotReadAskCountByGateId(selfXmOwnGateId)
check=num>0
local widget=self.gateApplyBtn:getChildWidgetBase()

self.gateApplyBtn:setActive(check)
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
else
check=false
self.gateApplyBtn:setActive(check)
end
end


function UIFuncStorageXMWin:clearFLTweener()
if self.flTweener then
self.flTweener:Kill()
self.flTweener=nil
end
end

function UIFuncStorageXMWin:changeFuncListShow(isShow)
if self.bShowFuncList==isShow then
return
end

self:clearFLTweener()
if isShow then
self.funcList:setActive(true)
self.flTweener=self.funcList:setChildCanvasGroupDOFade(1,0.5,nil)
self.funcListReddot:setActive(false)
else
self.flTweener=self.funcList:setChildCanvasGroupDOFade(0,0.5,function()
self.funcList:setActive(false)
end)
end
self.bShowFuncList=isShow
self.funcListbtnselect:setActive(self.bShowFuncList)
simpleModeControl:setFuncStorageSimple(self.bShowFuncList)
self:refresh()
if not self.bShowFuncList then
self:refreshReddot()
end


UIManager:invokeUIMethod("UIMain","freshSimpleBtn")
end

function UIFuncStorageXMWin:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.reddotTweener==nil then
self.funcListReddot:setRotation(0,0,0)
local tweener=self.funcListReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.funcListReddot:setRotation(0,0,0)
end
end
end

function UIFuncStorageXMWin:doPunchRotation_Btn(widgetId,btnWidget,index,reddot)
if not self.reddotTweener_BtnList then
self.reddotTweener_BtnList={}
end

if reddot then
if self.reddotTweener_BtnList[widgetId]==nil then
btnWidget:SetChildRotation(index,0,0,0)
local tweener=btnWidget:SetChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener_BtnList[widgetId]={}
self.reddotTweener_BtnList[widgetId].tweener=tweener
self.reddotTweener_BtnList[widgetId].cmpIndex=index
self.reddotTweener_BtnList[widgetId].btnWidget=btnWidget
btnWidget:SetChildActive(index,true)
end
else
if self.reddotTweener_BtnList[widgetId]~=nil then
btnWidget:SetChildActive(index,false)
local tweener=self.reddotTweener_BtnList[widgetId].tweener
tweener:Complete()
tweener:Kill()
self.reddotTweener_BtnList[widgetId]=nil
btnWidget:SetChildRotation(index,0,0,0)
end
end
end

function UIFuncStorageXMWin:clearTweener_AllBtn()
if not self.reddotTweener_BtnList then
return
end

for widgetId,v in pairs(self.reddotTweener_BtnList)do
local tweener=v.tweener
local cmpIndex=v.cmpIndex
local btnWidget=v.btnWidget
btnWidget:SetChildActive(cmpIndex,false)
tweener:Complete()
tweener:Kill()
btnWidget:SetChildRotation(cmpIndex,0,0,0)
self.reddotTweener_BtnList[widgetId]=nil
end
end

function UIFuncStorageXMWin:onYuLingZhaiBtn()
UIFullYuLingZhaiControl:showMainWindow()
end

function UIFuncStorageXMWin:onGateApplyBtn()
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
return
end

local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local jumpFunc=function()
xianjieController:jumpMoJieGateByGateId(selfXmOwnGateId,true,true)
end

local sceneType=xianjieModel:getScenceType()
if not sceneType or not xianjienSceneType:isMoJie(sceneType)then

local content="关口通行簿需前往魔界查看，是否前往？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=jumpFunc,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
else
jumpFunc()
return true
end
end
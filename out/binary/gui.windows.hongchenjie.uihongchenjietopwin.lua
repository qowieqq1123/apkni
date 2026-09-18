







def_class("UIHongChenJieTopWin",UIWindowBase)









function UIHongChenJieTopWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.closeRoot=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.selectText=UIText.get(self,3)
self.toMainCloseBtn=UIButton.get(self,4)
self.toMainCloseRoot=UIObject.get(self,5)
self.toMainSelectText=UIText.get(self,6)
self.transitionImg=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.toMainCloseBtn:setButtonClick(function()self:onToMainCloseBtn()end)



end


function UIHongChenJieTopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeRoot);self.closeRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.toMainCloseBtn);self.toMainCloseBtn=nil;
_UIObject_release(self.toMainCloseRoot);self.toMainCloseRoot=nil;
_UIObject_release(self.toMainSelectText);self.toMainSelectText=nil;
_UIObject_release(self.transitionImg);self.transitionImg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIHongChenJieTopWin:onLoaded(...)
self:bindComponents()
end


function UIHongChenJieTopWin:__delete()
self:unbindComponents()
end




function UIHongChenJieTopWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
self.transitionImg:setActive(false)
self.transitionImg:setChildCanvasGroupAlpha(0)

self.closeRoot:setActive(true)

local returnBtnName=hongChenJieConfig.getBaseInfo(self.id,'returnBtnName')
self.selectText:setText(returnBtnName)

local isReturnMainPanel=hongChenJieConfig.getBaseInfo(self.id,'isReturnMainPanel')
local isShowToMainRoot=isReturnMainPanel[1]==1 and UIManager:isActive('UIHongChenJieMainWin')
self.toMainCloseRoot:setActive(isShowToMainRoot)
if isShowToMainRoot then
self.toMainSelectText:setText(isReturnMainPanel[2])
end
end


function UIHongChenJieTopWin:onHide()

end

function UIHongChenJieTopWin:onShowArgRecv()
self:onShow({id=self.id})
end

function UIHongChenJieTopWin:transWin(callback)
local _this=self
self.transitionImg:setActive(true)
self.transitionImg:setChildCanvasGroupAlpha(0)
self.transitionImg:setChildCanvasGroupDOFade(1,0.5,function()
callback()
_this.transitionImg:setChildCanvasGroupDOFade(0,0.5,function()_this.transitionImg:setActive(false)end)
end)
end





function UIHongChenJieTopWin:onCloseBtn()
local _this=self

if UIManager:isActive('UIHongChenJieMainWin')then

local return_jump_param=hongChenJieConfig.getBaseInfo(self.id,'return_jump_param')
jumpManager:jump(return_jump_param)
elseif UIManager:isActive('UIHongChenJiePrepareWin')then
local okfunc=function()
UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showMainWin({id=_this.id})
end)
end
local showdata=
{
type='UIDialouge',
title='提示',
content='身份选择中，是否确认退出？\n(下次进入将以当前进度继续体验)',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=okfunc,
showclosebtn=true,
}
local quitDialog=UIDialogManager.newDialog(showdata)
quitDialog:show()
else
hongChenJieController:checkEndHongChenJieGame(self.id)
end
end

function UIHongChenJieTopWin:onToMainCloseBtn()
local startCallback=function()
UIFullHongChenJieControl:closeUI()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIHongChenJieTopWin:hideBtn()
self.closeRoot:setActive(false)
self.toMainCloseRoot:setActive(false)
end


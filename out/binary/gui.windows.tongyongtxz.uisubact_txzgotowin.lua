







def_class("UISubAct_TXZGotoWin",UIWindowBase)









function UISubAct_TXZGotoWin:bindComponents()

self.back=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.Root=UIObject.get(self,2)
self.tip=UIText.get(self,3)
self.title=UIText.get(self,4)
self.uiRoot=UIObject.get(self,5)
self.wayScrollView=UIScrollView.get(self,6)

self.back:setButtonClick(function()self:onBack()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UISubAct_TXZGotoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.wayScrollView);self.wayScrollView=nil;
end



















function UISubAct_TXZGotoWin:onLoaded(...)
self:bindComponents()

self.wayScrollView:bindScrollWidget(function(...)self:bindwayItem(...)end)
end


function UISubAct_TXZGotoWin:__delete()
self:unbindComponents()
end




function UISubAct_TXZGotoWin:onShow(argtable,afterOnloaded)
self.config=argtable.cfg
self.jumpParam=self.config.jump
local num=#self.jumpParam
self.wayScrollView:freshGridsNum(num,num,1,true)
local jumptoptxt=self.config.jumptoptxt
self.tip:setText(jumptoptxt)
end


function UISubAct_TXZGotoWin:onHide()

end

function UISubAct_TXZGotoWin:onwayClick(index)
if not self.jumpParam or not self.jumpParam[index]then
return
end
local jumpParam=self.jumpParam[index]
if jumpParam then
local jumpType=jumpParam[1]
local jumpId=jumpParam[2]
local args=jumpParam["args"]
local backFlag=nil
if jumpId==JUMP_TYPE.eShiLianTa then
backFlag=JUMP_BACK.eForceBack
elseif jumpId==JUMP_TYPE.eDouFaTai then
backFlag=JUMP_BACK.eNoBack
end
jumpManager:jump({type=jumpType,id=jumpId,args=args},nil,backFlag)
self:closeSelf()
end
end

function UISubAct_TXZGotoWin:bindwayItem(index,item)
if self.config.jumptxt and self.config.jumptxt[index]then
local name=self.config.jumptxt[index]

item:SetChildButtonClick(3,function()
self:onwayClick(index)
end)
item:SetChildText(1,name)
end



















end

function UISubAct_TXZGotoWin:onBack()
self:closeSelf()
end

function UISubAct_TXZGotoWin:onBtnClose()
self:closeSelf()
end



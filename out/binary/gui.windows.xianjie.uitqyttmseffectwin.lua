







def_class("UITQyTTMSeffectWin",UIWindowBase)









function UITQyTTMSeffectWin:bindComponents()

self.root=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.bgModel2=UIObject.get(self,2)
self.bgModel3=UIObject.get(self,3)
self.tgbtn=UIButton.get(self,4)
self.backbg=UIObject.get(self,5)
self.bgModel4=UIObject.get(self,6)

self.tgbtn:setButtonClick(function()self:onTgbtn()end)



end


function UITQyTTMSeffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.bgModel3);self.bgModel3=nil;
_UIObject_release(self.tgbtn);self.tgbtn=nil;
_UIObject_release(self.backbg);self.backbg=nil;
_UIObject_release(self.bgModel4);self.bgModel4=nil;
end
















local _this



function UITQyTTMSeffectWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UITQyTTMSeffectWin:__delete()
self:unbindComponents()
_this=nil
end




function UITQyTTMSeffectWin:onShow(argtable,afterOnloaded)
local ret=argtable._ret
self.ret=ret
self.root:setChildCanvasGroupAlpha(0)
self.backbg:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.bgModel:setChildUIModelShowTarget(6104,1,{},eAnimationID.stand)
self.bgModel3:setChildUIModelShowTarget(6111,1,{},eAnimationID.stand)
if ret==1 then

self.bgModel2:setChildUIModelShowTarget(6105,1,{},3091)

else

self.bgModel2:setChildUIModelShowTarget(6105,1,{},3090)

end

self:delayDo(6,function()
if _this==nil then return end
self.tgbtn:setActive(false)
self:showresult(ret)
end)


self:delayDo(8.5,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(0,0.6,function()
if _this==nil then return end
if ret==1 then
UIManager.info("成功迷惑对方，令其减速50%")
else
UIManager.info("迷惑失败，对方速度提升25%")
end
self:closeSelf()
end)
end)
end

function UITQyTTMSeffectWin:showresult(ret)
self.backbg:setChildCanvasGroupDOFade(1,0.6,function()
if ret==1 then

self.bgModel4:setChildUIModelShowTarget(6106,1,{},3095)
else

self.bgModel4:setChildUIModelShowTarget(6106,1,{},3094)
end
end)
end



function UITQyTTMSeffectWin:onHide()

end

function UITQyTTMSeffectWin:onCloseBtn()
self:closeSelf()
end


function UITQyTTMSeffectWin:onTgbtn()
self.bgModel2:setChildCanvasGroupDOFade(0,0.2,nil)
self.backbg:setChildCanvasGroupDOFade(1,0.2,function()
self:showresult(self.ret)
self:delayDo(2,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(0,0.6,function()
if self.ret==1 then
UIManager.info("成功迷惑对方，令其减速50%")
else
UIManager.info("迷惑失败，对方速度提升25%")
end
self:closeSelf()
end)
end)
end)
end



function UITQyTTMSeffectWin:testttt1(id,id2)
_this.bgModel:setChildUIModelShowTarget(id,1,{},id2)
end
function UITQyTTMSeffectWin:testttt11(id2)
_this.bgModel:setChildModelAnimationState(id2)
end

function UITQyTTMSeffectWin:testttt2(id,id2)
_this.bgModel2:setChildUIModelShowTarget(id,1,{},id2)
end
function UITQyTTMSeffectWin:testttt22(id2)
_this.bgModel2:setChildModelAnimationState(id2)
end

function UITQyTTMSeffectWin:testttt3(id,id2)
_this.bgModel3:setChildUIModelShowTarget(id,1,{},id2)
end
function UITQyTTMSeffectWin:testttt33(id2)
_this.bgModel3:setChildModelAnimationState(id2)
end






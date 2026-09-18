







def_class("UIRuleTipsImageWin",UIWindowBase)









function UIRuleTipsImageWin:bindComponents()

self.back=UIButton.get(self,0)
self.tipstxt=UIText.get(self,1)
self.view=UIScrollView.get(self,2)
self.spinebg=UIObject.get(self,3)
self.leftmovebtn=UIObject.get(self,4)
self.rightmovebtn=UIObject.get(self,5)
self.surebtn=UIButton.get(self,6)
self.content=UIObject.get(self,7)
self.surebtntxt=UIText.get(self,8)
self.closebtn=UIButton.get(self,9)


self.back:setButtonClick(function()self:onBack()end)



end


function UIRuleTipsImageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.view);self.view=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.leftmovebtn);self.leftmovebtn=nil;
_UIObject_release(self.rightmovebtn);self.rightmovebtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.surebtntxt);self.surebtntxt=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
end
















local _this=nil
local _itemCmp={
desc1=0,
desc2=1,
image=2,
}

local subitemwidth=350
local subitemspace=55




function UIRuleTipsImageWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIRuleTipsImageWin:__delete()
self:unbindComponents()
_this=nil
end




function UIRuleTipsImageWin:onShow(argtable,afterOnloaded)
local infos=argtable.info or nil
local tips=argtable.tips or"点击空白处关闭"
local callback=argtable.callback
self.closeCallback=argtable.closeCallback
local btntxt=argtable.btntxt or"确 定"
local isShowClosebtn=argtable.isShowCloseBtn or false
local hideSureBtn=argtable.hideSureBtn

self.surebtn:setActive(not hideSureBtn)

self.surebtn:setButtonClick(function()
if callback then
callback()
end
_this:closeSelf()
end)

self.surebtntxt:setText(btntxt)
self.closebtn:setActive(isShowClosebtn)

self.tipstxt:setText(tips)
self.view:setChildCanvasGroupDOFade(0,0,nil)
self:initView(infos)

self.spinebg:setChildUIModelShowTarget(4086,1,{},0,false,false,0.3,function()
self:delayDo(0.3,function()
_this.view:setChildCanvasGroupDOFade(1,0.2,nil)
end)
end)
end


function UIRuleTipsImageWin:onHide()

end





function UIRuleTipsImageWin:onBack()
if self.closeCallback then
self.closeCallback()
end
self:closeSelf()
end


function UIRuleTipsImageWin:initView(infos)
self.tNum=0
local groupCfg=nil
if infos then
groupCfg=cfgHelper.get1(cfg_ruletipsimagegroupconfig_get,infos)
self.tNum=#groupCfg.group
end
self.space={}
self.view:freshGridsNum(self.tNum,1,self.tNum,not self.isSetZero)
self.isSetZero=true
self.sIndex=0
self.mIndex=self.tNum-2

for i=1,self.tNum do
local info=groupCfg.group[i]
local config=cfgHelper.get1(cfg_ruletipsimageconfig_get,info)
local item=self.view:getGridObjectByindex(i-1)


item:SetChildText(_itemCmp.desc1,config.title)
item:SetChildText(_itemCmp.desc2,FMT.fmt("{0}.{1}",i,config.desc))
if#config.image==1 then
item:SetChildCSImageIcon(_itemCmp.image,config.image[1],true)
else
item:SetChildCSImageSprite(_itemCmp.image,config.image[1],config.image[2])
end
end

self:freshBtns()
end



function UIRuleTipsImageWin:onClickLeftBtn()

self.sIndex=self.sIndex-1

self:jump(self.sIndex)
self:freshBtns()
end

function UIRuleTipsImageWin:onClickRightBtn()

self.sIndex=self.sIndex+1

self:jump(self.sIndex)
self:freshBtns()
end

function UIRuleTipsImageWin:freshBtns()
self.leftmovebtn:setActive(self.sIndex~=0);
self.rightmovebtn:setActive(self.sIndex~=self.mIndex)
end





function UIRuleTipsImageWin:jump(index)
if self.tNum<=0 or self.tNum<index then return end
self.leftmovebtn:setActive(false);
self.rightmovebtn:setActive(false)
local posx=index*(subitemwidth+subitemspace)
self.content:setChildDOLocalMoveX(-posx,0.3,function()
self:freshBtns()
end)
end



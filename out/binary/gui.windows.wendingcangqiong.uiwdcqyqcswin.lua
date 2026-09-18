







def_class("UIWDCQYQCSWin",UIWindowBase)









function UIWDCQYQCSWin:bindComponents()

self.backClickBtn=UIButton.get(self,0)
self.backCloseBtn=UIButton.get(self,1)
self.cloudBgSpine=UIObject.get(self,2)
self.fastShowBtn=UIButton.get(self,3)
self.groupInfo=UIText.get(self,4)
self.layoutLine1=UIObject.get(self,5)
self.mc=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.Root=UIObject.get(self,8)
self.showRoot=UIObject.get(self,9)
self.uiRoot=UIObject.get(self,10)

self.backClickBtn:setButtonClick(function()self:onBackClickBtn()end)

self.backCloseBtn:setButtonClick(function()self:onBackCloseBtn()end)

self.fastShowBtn:setButtonClick(function()self:onFastShowBtn()end)



end


function UIWDCQYQCSWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backClickBtn);self.backClickBtn=nil;
_UIObject_release(self.backCloseBtn);self.backCloseBtn=nil;
_UIObject_release(self.cloudBgSpine);self.cloudBgSpine=nil;
_UIObject_release(self.fastShowBtn);self.fastShowBtn=nil;
_UIObject_release(self.groupInfo);self.groupInfo=nil;
_UIObject_release(self.layoutLine1);self.layoutLine1=nil;
_UIObject_release(self.mc);self.mc=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.showRoot);self.showRoot=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIWDCQYQCSWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQYQCSWin:__delete()
self:unbindComponents()
end




function UIWDCQYQCSWin:onShow(argtable,afterOnloaded)
self.group=argtable.group
self.rank=argtable.rank

self.cloudBgSpine:setChildUIModelShowTarget(5596,1,nil,eAnimationID.stand)

self:initPlayEnv()

self:startPlay()

end


function UIWDCQYQCSWin:onHide()

end

function UIWDCQYQCSWin:initPlayEnv()
self.showRoot:setActive(true)

self.backCloseBtn:setActive(false)
self.backClickBtn:setActive(false)
self.fastShowBtn:setActive(false)


local groupName=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,self.group,'name')
local str=table.concat(string.toTable(groupName),"\n")
self.groupInfo:setText(str)
self.mc:setText(self.rank)

self.showRoot:setAnimatorInteger('showState',0,true)

self.winlua:ForceLayoutRect(self.layoutLine1:getID())
end

function UIWDCQYQCSWin:startPlay()
self.model:setChildUIModelShowTarget(5597,1,{},2902,false,false,0.2,function()
self.backClickBtn:setActive(true)
self.winlua:ForceLayoutRect(self.layoutLine1:getID())
end)
end

function UIWDCQYQCSWin:nextPlay()
local callBack=function()
self.showRoot:setAnimatorInteger('showState',1,true)
self:delayDo(1,function()
self.backCloseBtn:setActive(true)
end)
end
self.fastShowBtn:setActive(true)
self:delayDo(0.2,function()
self.fastShowBtn:setActive(false)
callBack()
end)

self.model:setChildModelAnimationState(2904,1,nil)
end





function UIWDCQYQCSWin:onBackClickBtn()
self:nextPlay()
self.backClickBtn:setActive(false)
end



function UIWDCQYQCSWin:onBackCloseBtn()

jumpManager:jump({id=JUMP_TYPE.eWDCangQiong})
WDCQController.setMsgWinOpenFlag(msgWinType.eWDCQYQCS,UIXianFaWenDaoControl:getSessionBeginTime(),nil)
end

function UIWDCQYQCSWin:onFastShowBtn()
self.fastShowBtn:setActive(false)
self.showRoot:setChildAnimatorParameter("fastShow","trigger","")
end










def_class("UIEnterExtend",UICloneObject)





UIEnterExtend.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterExtend.assetName="UIEnterNomalItem"


function UIEnterExtend:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterExtend:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end






local iconname='button_zjmgengduohd_1'



function UIEnterExtend:onLoaded(...)
self:bindComponents()

self.onActivityReddotChange_=function(...)
self:onActivityReddotChange(...)
end
notifySystem:listenNotify(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
end


function UIEnterExtend:__delete()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
self.onActivityReddotChange_=nil
end




function UIEnterExtend:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
self.info=argtable.info
local enterIconType=self.info.enterIconType
local enterType=self.info.enterType
self.cfg=enterConfig.getConfig(enterIconType,enterType)

local abname=enterConfig.getSpriteAB()

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)
self.reddot:setActive(false)

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self.qipao:setActive(false)


self:freshReddot()
self.extendbg:setActive(argtable.isEx or false)
end


function UIEnterExtend:onHide()

end

function UIEnterExtend:onActivityReddotChange(act_id)
if self.act_id~=act_id then return end

self:refreshReddot()
end

function UIEnterExtend:freshReddot()

local flag=self.info.getReddotFun()
self.reddot:setActive(flag)
end

function UIEnterExtend:onIcon()
UIManager:showWindow("UIAct_ExtendEnterWin")
end

function UIEnterExtend:onClickBg()
UIManager:showWindow("UIAct_ExtendEnterWin")
end



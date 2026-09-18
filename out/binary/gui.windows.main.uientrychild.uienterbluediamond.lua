







def_class("UIEnterBlueDiamond",UICloneObject)





UIEnterBlueDiamond.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterBlueDiamond.assetName="UIEnterNomalItem"


function UIEnterBlueDiamond:bindComponents()

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


function UIEnterBlueDiamond:unbindComponents()
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






local iconname='button_hdrk_0098'




function UIEnterBlueDiamond:onLoaded(...)
self:bindComponents()
end


function UIEnterBlueDiamond:__delete()
self:unbindComponents()
end




function UIEnterBlueDiamond:onShow(argtable,afterOnloaded)
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

if deviceHelper.getAPILevel()>=380 and pfCommonHelper:isRunPC()then
self.widget:SetChildButtonPointEnterEvent(self.clickBg:getID(),function()
self:onEenterPoint()
end)

self.widget:SetChildButtonPointExitEvent(self.clickBg:getID(),function()
self:onExitPoint()
end)
end
end


function UIEnterBlueDiamond:onHide()

end

function UIEnterBlueDiamond:freshReddot()

local flag=self.info.getReddotFun()
self.reddot:setActive(flag)
end

function UIEnterBlueDiamond:onIcon()
UIFullBlueDiamondController:showMyWindow()
end

function UIEnterBlueDiamond:onClickBg()
UIFullBlueDiamondController:showMyWindow()
end


function UIEnterBlueDiamond:onEenterPoint()
UIManager:showWindow('UIEnterRuleFloatWin',{
item=self.widget,move_pos='bottom',
ruleStr="蓝钻用户可以享受以下特权：\n1.蓝钻每日礼包\n2.蓝钻新手礼包\n3.蓝钻升级礼包\n4.蓝钻专属标识",
})
end

function UIEnterBlueDiamond:onExitPoint()
UIManager:closeWindow('UIEnterRuleFloatWin')
end











def_class("UIEnterQQLobbyAct",UICloneObject)





UIEnterQQLobbyAct.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterQQLobbyAct.assetName="UIEnterNomalItem"


function UIEnterQQLobbyAct:bindComponents()

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


function UIEnterQQLobbyAct:unbindComponents()
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






local iconname='button_hdrk_0097'



function UIEnterQQLobbyAct:onLoaded(...)
self:bindComponents()
end


function UIEnterQQLobbyAct:__delete()
self:unbindComponents()
end




function UIEnterQQLobbyAct:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)

local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

self.reddot:setActive(false)
self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.timeBg:setActive(false)

self:freshReddot()

if deviceHelper.getAPILevel()>=380 and pfCommonHelper:isRunPC()then
self.widget:SetChildButtonPointEnterEvent(self.clickBg:getID(),function()
self:onEenterPoint()
end)

self.widget:SetChildButtonPointExitEvent(self.clickBg:getID(),function()
self:onExitPoint()
end)
end
end


function UIEnterQQLobbyAct:onHide()

end

function UIEnterQQLobbyAct:freshReddot()
self.reddot:setActive(qqLobbyActController:getEnterReddot())
end

function UIEnterQQLobbyAct:onClickBg()
UIManager:showWindow("UIQQLobbyGiftWin")
end


function UIEnterQQLobbyAct:onEenterPoint()

UIManager:showWindow('UIEnterRuleFloatWin',{
item=self.widget,move_pos='bottom',
ruleStr="从QQ大厅登录享受以下特权：\n1.每日活跃礼包\n2.新手注册礼包\n3.游戏成长礼包",
})
end

function UIEnterQQLobbyAct:onExitPoint()

UIManager:closeWindow('UIEnterRuleFloatWin')
end




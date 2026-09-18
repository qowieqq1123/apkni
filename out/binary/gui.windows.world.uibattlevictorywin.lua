







def_class("UIBattleVictoryWin",UIWindowBase)







function UIBattleVictoryWin:bindComponents()












self.TitleTx=UIText.get(self,0)
self.TitleIcon=UIImage.get(self,1)
self.TextNum=UIText.get(self,2)

self.ResRoot=UIObject.get(self,3)
self.ResIcon=UIImage.get(self,4)
self.ResTx=UIText.get(self,5)

self.ScrollView=UIScrollView.get(self,6)
self.ScrollContent=UIObject.get(self,7)

self.buttonRoot=UIObject.get(self,8)
self.continueText=UIText.get(self,9)

self.fullScreenQuit=UIObject.get(self,10)

self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)



end


function UIBattleVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release






_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.ScrollContent);self.ScrollContent=nil;
_UIObject_release(self.buttonRoot);self.buttonRoot=nil;
_UIObject_release(self.continueText);self.continueText=nil;
_UIObject_release(self.fullScreenQuit);self.fullScreenQuit=nil;
end



















function UIBattleVictoryWin:onLoaded(...)
self:bindComponents()
end


function UIBattleVictoryWin:__delete()
self:unbindComponents()
end

































function UIBattleVictoryWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}

local title=self.argtable.title
if title then
self.TitleTx:setActive(title.text~=nil)
if title.text then self.TitleTx:setText(title.text)end
self.TitleIcon:setActive(title.icon~=nil)
if title.icon then self.TitleIcon:setSprite(title.icon.abName,title.icon.assetName)end
self.TextNum:setActive(title.num~=nil)
if title.num then self.TextNum:setText(title.num)end
else
self.TitleTx:setActive(true)
self.TitleTx:setText("<color=#7D3B17>获得物品</color>")
end

local money=self.argtable.money
self.ResRoot:setActive(money~=nil)
if money then
self.ResIcon:setActive(money.icon~=nil)
if money.icon then self.ResIcon:setSprite(money.icon.abName,money.icon.assetName)end
self.ResTx:setActive(money.text~=nil)
if money.text then self.ResTx:setText(money.text)end
end

local items=self.argtable.items
if items then
local propData={}
for i,v in ipairs(items)do
table.insert(propData,itemsComponentHelper.getCommonFillData(v,{showname=false}))
end
local propDataCnt=#propData
self.ScrollView:freshGridsNum(propDataCnt,1,propDataCnt,false)
self.ScrollView:initPropData(propData)
if propDataCnt<=7 then
self.ScrollContent:setAnchors(0.5,1,0.5,1)
end
end

local continueInfo=self.argtable.continue
local haveContinue=continueInfo~=nil and continueInfo.callback~=nil
self.buttonRoot:setActive(haveContinue)
self.fullScreenQuit:setActive(not haveContinue)
if haveContinue then
if continueInfo.cd then
local cd=continueInfo.cd
local callback=continueInfo.callback
local times=cd
self.continueText:setText(FMT.fmt("继续({0})",cd))
local id=self:setTimer(1,times,function()
cd=cd-1
self.continueText:setText(FMT.fmt("继续({0})",cd))
if cd<=0 then
self:onContinueButton()
end
end)
else
self.continueText:setText("继续")
end
end
end


function UIBattleVictoryWin:onHide()

end



function UIBattleVictoryWin:onClickClose()
local cb=self.argtable.callback
if UIManager:findActiveWindow("UIBattleVictoryWin")then
self:closeSelf()
end
if cb then cb()end
end

function UIBattleVictoryWin:onContinueButton()
local cb=nil
if self.argtable.continue then
cb=self.argtable.continue.callback()
end
if UIManager:findActiveWindow("UIBattleVictoryWin")then
self:closeSelf()
end
if cb then cb()end
end

function UIBattleVictoryWin:onQuitButton()
self:onClickClose()
end
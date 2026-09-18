







def_class("UIYuJingMainWin",UIWindowBase)









function UIYuJingMainWin:bindComponents()

self.bgeffect=UIObject.get(self,0)
self.bgeffect2=UIObject.get(self,1)
self.btnBangYu=UIButton.get(self,2)
self.btnBaoKu=UIButton.get(self,3)
self.btnClose=UIButton.get(self,4)
self.btnGroup=UIObject.get(self,5)
self.btnShiLi=UIButton.get(self,6)
self.btnXianGuan=UIButton.get(self,7)
self.content=UIObject.get(self,8)
self.reddotShiLi=UIObject.get(self,9)
self.reddotXianGongBangYu=UIObject.get(self,10)
self.reddotXianGuan=UIObject.get(self,11)
self.root=UIObject.get(self,12)

self.btnBangYu:setButtonClick(function()self:onBtnBangYu()end)

self.btnBaoKu:setButtonClick(function()self:onBtnBaoKu()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnShiLi:setButtonClick(function()self:onBtnShiLi()end)

self.btnXianGuan:setButtonClick(function()self:onBtnXianGuan()end)



end


function UIYuJingMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgeffect);self.bgeffect=nil;
_UIObject_release(self.bgeffect2);self.bgeffect2=nil;
_UIObject_release(self.btnBangYu);self.btnBangYu=nil;
_UIObject_release(self.btnBaoKu);self.btnBaoKu=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnGroup);self.btnGroup=nil;
_UIObject_release(self.btnShiLi);self.btnShiLi=nil;
_UIObject_release(self.btnXianGuan);self.btnXianGuan=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.reddotShiLi);self.reddotShiLi=nil;
_UIObject_release(self.reddotXianGongBangYu);self.reddotXianGongBangYu=nil;
_UIObject_release(self.reddotXianGuan);self.reddotXianGuan=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil



function UIYuJingMainWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)

xianjieModel:closeForceResetCamera()
end


function UIYuJingMainWin:__delete()
self:unbindComponents()
_this=nil
UIManager:closeActiveWindow("UIXianJieForceWin")
end




function UIYuJingMainWin:onShow(argtable,afterOnloaded)
if not webGLHelper:isRunMiniGame()then
self.bgeffect:setChildShowEffect(20474,true)
end
self.bgeffect2:setChildShowEffect(20511,true)

local showRoot=argtable==nil or argtable.onlyBg~=true
self:showRoot(showRoot)

local open=systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
self.btnGroup:setActive(open)

self:refreshShiLiButton()
end


function UIYuJingMainWin:onHide()

end





function UIYuJingMainWin:onBtnBangYu()
end



function UIYuJingMainWin:onBtnBaoKu()
end



function UIYuJingMainWin:onBtnClose()
UIFullXJForceControl:closeUI()
end



function UIYuJingMainWin:onBtnShiLi()
local args={
parentWin=UIFullXJForceControl,
select=xianjieForceType.eYuJing,
}
UIFullXJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end



function UIYuJingMainWin:onBtnXianGuan()
end


function UIYuJingMainWin:showRoot(show)
self.root:setActive(show)
end

function UIYuJingMainWin:Scrollchange()
local w=self.winlua:GetChildSizeDeltaY(self.content:getID())
local localPosX=self.winlua:GetChildLocalPosition(self.content:getID()).x
UIManager:invokeUIMethod("UIXianJieForceWin","ChangeScrowview",localPosX)
end

function UIYuJingMainWin.refreshShiLiReddot()
if _this==nil then return end
local reddot=xjFactionNPCModel:getFactionReddot(xianjieForceType.eYuJing)
_this.reddotShiLi:setActive(reddot)
end

function UIYuJingMainWin.onXianJieFactionReddotChange(factionList)
if table.containsValue(factionList,xianjieForceType.eYuJing)then
_this.refreshShiLiReddot()
end
end

function UIYuJingMainWin:refreshShiLiButton()
local show=systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)
self.btnShiLi:setActive(show)
if show then
self.refreshShiLiReddot()
end
end

function UIYuJingMainWin.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXianJieShiLiJH then
_this:refreshShiLiButton()
end
end
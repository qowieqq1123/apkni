







def_class("UIJiuYuanMainWin",UIWindowBase)









function UIJiuYuanMainWin:bindComponents()

self.bgeffect=UIObject.get(self,0)
self.bgeffect2=UIObject.get(self,1)
self.btnClose=UIButton.get(self,2)
self.btnGroup=UIObject.get(self,3)
self.btnSHD=UIButton.get(self,4)
self.btnShiLi=UIButton.get(self,5)
self.content=UIObject.get(self,6)
self.effect=UIObject.get(self,7)
self.reddotSHD=UIObject.get(self,8)
self.reddotShiLi=UIObject.get(self,9)
self.root=UIObject.get(self,10)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnSHD:setButtonClick(function()self:onBtnSHD()end)

self.btnShiLi:setButtonClick(function()self:onBtnShiLi()end)



end


function UIJiuYuanMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgeffect);self.bgeffect=nil;
_UIObject_release(self.bgeffect2);self.bgeffect2=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnGroup);self.btnGroup=nil;
_UIObject_release(self.btnSHD);self.btnSHD=nil;
_UIObject_release(self.btnShiLi);self.btnShiLi=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.reddotSHD);self.reddotSHD=nil;
_UIObject_release(self.reddotShiLi);self.reddotShiLi=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil



function UIJiuYuanMainWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)

xianjieModel:closeForceResetCamera()
end


function UIJiuYuanMainWin:__delete()
self:unbindComponents()
_this=nil
if self.shdBT then
behaviorManager:removeBehaviorTree(self.shdBT)
end
UIManager:closeActiveWindow("UIXianJieForceWin")
end




function UIJiuYuanMainWin:onShow(argtable,afterOnloaded)
if not webGLHelper:isRunMiniGame()then
self.bgeffect:setChildShowEffect(20476,true)
end
self.bgeffect2:setChildShowEffect(20513,true)

local showRoot=argtable==nil or argtable.onlyBg~=true
self:showRoot(showRoot)

local open=systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
self.btnGroup:setActive(open)

self:refreshShiLiButton()
self:refreshSHDButton()
end


function UIJiuYuanMainWin:onHide()

end




function UIJiuYuanMainWin:onBtnClose()
UIFullXJForceControl:closeUI()
end


function UIJiuYuanMainWin:onBtnShiLi()
local args={
parentWin=UIFullXJForceControl,
select=xianjieForceType.eJiuYuan,
}
UIFullXJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end

function UIJiuYuanMainWin:Scrollchange()
local w=self.winlua:GetChildSizeDeltaY(self.content:getID())
local localPosX=self.winlua:GetChildLocalPosition(self.content:getID()).x
UIManager:invokeUIMethod("UIXianJieForceWin","ChangeScrowview",localPosX)
end

function UIJiuYuanMainWin.refreshShiLiReddot()
if _this==nil then return end
local reddot=xjFactionNPCModel:getFactionReddot(xianjieForceType.eJiuYuan)
_this.reddotShiLi:setActive(reddot)
end

function UIJiuYuanMainWin.onXianJieFactionReddotChange(factionList)
if table.containsValue(factionList,xianjieForceType.eJiuYuan)then
_this.refreshShiLiReddot()
end
end

function UIJiuYuanMainWin:refreshShiLiButton()
local show=systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)
self.btnShiLi:setActive(show)
if show then
self.refreshShiLiReddot()
end
end

function UIJiuYuanMainWin.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXianJieShiLiJH then
_this:refreshShiLiButton()
end
end

function UIJiuYuanMainWin:refreshSHDButton()
local show=shouhundingController:isOpen()
self.btnSHD:setActive(show)
if show then
self:refreshSHDReddot()
end
end

function UIJiuYuanMainWin:refreshSHDReddot()
local reddot=shouhundingController:getReddot()
self.reddotSHD:setActive(reddot)
end

function UIJiuYuanMainWin:onBtnSHD()


local forceWin=UIManager:findActiveWindow("UIXianJieForceWin")
local args={
forceWin=forceWin.winlua,
forceContent=forceWin.content:getID(),
forceShelter=forceWin.shelter:getID(),
mainWin=self.winlua,
mainRoot=self.root:getID(),
mainEffect=self.effect:getID(),
mainContent=self.content:getID(),
x=self.content:getChildAnchoredPosition().x,
}
self.shdBT=behaviorManager:addBehaviorTree("bt_ui_shouhunding_enter",nil,true,args)
end

function UIJiuYuanMainWin.on_system_open(sysId)
if shouhundingModel:isSysID(sysId)then
_this:refreshSHDButton()
end
end

function UIJiuYuanMainWin.on_money_changed(mType)
if shouhundingModel:isDataType(mType)then
_this:refreshSHDReddot()
end
end


function UIJiuYuanMainWin:showRoot(show)
self.root:setActive(show)
end
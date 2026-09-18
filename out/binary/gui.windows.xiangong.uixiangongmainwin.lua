







def_class("UIXianGongMainWin",UIWindowBase)









function UIXianGongMainWin:bindComponents()

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
self.btnJYZF=UIButton.get(self,13)
self.reddotJYZF=UIObject.get(self,14)

self.btnBangYu:setButtonClick(function()self:onBtnBangYu()end)

self.btnBaoKu:setButtonClick(function()self:onBtnBaoKu()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnShiLi:setButtonClick(function()self:onBtnShiLi()end)

self.btnXianGuan:setButtonClick(function()self:onBtnXianGuan()end)

self.btnJYZF:setButtonClick(function()self:onBtnJYZF()end)



end


function UIXianGongMainWin:unbindComponents()
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
_UIObject_release(self.btnJYZF);self.btnJYZF=nil;
_UIObject_release(self.reddotJYZF);self.reddotJYZF=nil;
end
















local _this




function UIXianGongMainWin:onLoaded(...)
self:bindComponents()
_this=self
self:addProNotify(40,21,self.refreshXianGuanReddot)
self:addProNotify(40,26,self.refreshXianGuanReddot)
self:addProNotify(35,242,self.refreshJYZFButton)
self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)
self:addNotify(notifyConfig.onLimitActReddotChange,self.refreshXianGuanReddot)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.refreshXianGuanReddot)
self:addNotify(notifyConfig.onChangeXianGuanJob,self.refreshXianGuanReddot)
self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
reddotClassManager.register_event(REDDIT_SUB_TYPE.sXianGongBangYu,self.refreshXianGongBangYuReddot)
reddotClassManager.register_event(REDDIT_SUB_TYPE.sXianGongXianGuan,self.refreshXianGuanReddot)
xianjieModel:closeForceResetCamera()
end


function UIXianGongMainWin:__delete()
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sXianGongBangYu,self.refreshXianGongBangYuReddot)
UIManager:closeActiveWindow("UIXianJieForceWin")
self:unbindComponents()

_this=nil
end




function UIXianGongMainWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
if not webGLHelper:isRunMiniGame()then
self.bgeffect:setChildShowEffect(20473,true)
end

self.bgeffect2:setChildShowEffect(20510,true)
end

local open=systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
self.btnGroup:setActive(open)

local showRoot=argtable==nil or argtable.onlyBg~=true
self:showRoot(showRoot)

self.refreshXianGuanReddot()
self.refreshXianGongBangYuReddot()
self:refreshShiLiButton()
self.refreshJYZFButton()
end

function UIXianGongMainWin.refreshXianGuanReddot()
if _this==nil then return end
local reddot=xianguanController.getReddot()
_this.reddotXianGuan:setActive(reddot)
end

function UIXianGongMainWin.refreshXianGongBangYuReddot()

local reddot=XianGongModel:checkXianGongBangYuReddot()
_this.reddotXianGongBangYu:setActive(reddot)
end

function UIXianGongMainWin:refreshShiLiButton()
local show=systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)
self.btnShiLi:setActive(show)
if show then
self.refreshShiLiReddot()
end
end

function UIXianGongMainWin.refreshShiLiReddot()
if _this==nil then return end
local reddot=xjFactionNPCModel:getFactionReddot(xianjieForceType.eXianGong)
_this.reddotShiLi:setActive(reddot)
end


function UIXianGongMainWin:showRoot(show)
self.root:setActive(show)
end

function UIXianGongMainWin:refreshJYZFButton()
if _this==nil then return end
local show=JiuYuZhengFengController:checkSysOpen()
_this.btnJYZF:setActive(show)
_this.reddotJYZF:setActive(false)
end

function UIXianGongMainWin:onBtnBangYu()
UIFullXJForceControl:showWindow("UIXianGongBangYuWin")
end

function UIXianGongMainWin:onBtnBaoKu()
UIFullXJForceControl:showWindow("UIXianGongBaoKuWin",{tab=1})
end

function UIXianGongMainWin:onBtnShiLi()

local args={
parentWin=UIFullXJForceControl,
select=xianjieForceType.eXianGong,
}
UIFullXJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end

function UIXianGongMainWin:onBtnXianGuan()
UIFullXJForceControl:showWindow("UIXianGuanMainWin")
end

function UIXianGongMainWin:onBtnClose()
UIFullXJForceControl:closeUI()
end

function UIXianGongMainWin:Scrollchange()
local w=self.winlua:GetChildSizeDeltaY(self.content:getID())
local localPosX=self.winlua:GetChildLocalPosition(self.content:getID()).x
UIManager:invokeUIMethod("UIXianJieForceWin","ChangeScrowview",localPosX)
end

function UIXianGongMainWin.onXianJieFactionReddotChange(factionList)
if table.containsValue(factionList,xianjieForceType.eXianGong)then
_this.refreshShiLiReddot()
end
end

function UIXianGongMainWin.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXianJieShiLiJH then
_this:refreshShiLiButton()
end
end

function UIXianGongMainWin:onBtnJYZF()



UIFullJiuYuZhengFengController:showMainWindow()





end

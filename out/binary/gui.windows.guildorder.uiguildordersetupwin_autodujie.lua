







def_class("UIGuildOrderSetupWin_autoDuJie",UIWindowBase)









function UIGuildOrderSetupWin_autoDuJie:bindComponents()

self.controllClose=UIObject.get(self,0)
self.controllOpen=UIObject.get(self,1)
self.orderScrollView=UIScrollView.get(self,2)
self.dzEmpty=UIObject.get(self,3)
self.closeBg=UIObject.get(self,4)
self.controllBtn=UIButton.get(self,5)
self.openPanel=UIObject.get(self,6)
self.content=UIObject.get(self,7)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)



end


function UIGuildOrderSetupWin_autoDuJie:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
_UIObject_release(self.orderScrollView);self.orderScrollView=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.closeBg);self.closeBg=nil;
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.openPanel);self.openPanel=nil;
_UIObject_release(self.content);self.content=nil;
end















local _this

function UIGuildOrderSetupWin_autoDuJie:onLoaded(...)
self:bindComponents()
_this=self
end


function UIGuildOrderSetupWin_autoDuJie:__delete()
self:unbindComponents()
uiAIManager:clearUIWinData('UIGuildOrderSetupWin_autoDuJie')
self.currDZ=nil
if self.isChange then
guildOrderModel:changeSetupData(self.orderID)
end
if self.maxLv and self.maxLv>0 then
guildOrderModel:clearDuJieReddot(self.maxLv)
end
end


function UIGuildOrderSetupWin_autoDuJie:onHide()

end




function UIGuildOrderSetupWin_autoDuJie:onShow(argtable,afterOnloaded)
self.orderID=GUILD_ORDER_TYPE.eAutoDuJie
self.isChange=false
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local num=#cfg.jjcengRange
self.orderScrollView:freshGridsNum(num,1,num,true)

local reddot,maxLv=guildOrderModel:checkDuJieReddot()
self.maxLv=maxLv or-1
for idx=1,num do
local item=self.orderScrollView:getGridObjectByindex(idx-1)
self:refreshOrderItem(item,idx)
item:SetChildButtonClick(3,function(...)self:onOrderItemClick(idx)end)
end
if reddot then
for idx,v in ipairs(cfg.jjcengRange)do
if v==maxLv then
self.orderScrollView:jumpToLockY(idx)
end
end
end
self.winlua:SetAsLastSibling(self.dzEmpty:getID())
self:refreshItemControllBtn(self.orderID,true)
self.posX=(setup.jjcengIndex-1)*243+70
local dzData=UIDiscipleModel:getDiscipleByFightIndex(1)
self:createDZ(dzData.discipleguid,{self.posX,0},function(bt)
if self then
self.currDZ=bt
end
end)
end

function UIGuildOrderSetupWin_autoDuJie:refreshOrderItem(item,idx)
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if item==nil then
item=self.orderScrollView:getGridObjectByindex(idx-1)
end
local floor=cfg.jjcengRange[idx]
local str=FMT.fmt('{0}期',UIDiscipleModel:getJJFloorName(floor))

item:SetChildText(0,str)

item:SetChildActive(1,idx==setup.jjcengIndex)

item:SetChildActive(2,floor==self.maxLv)

item:SetChildCSImageSprite(3,globalABLookup.guildordericons,FMT.fmt("image_zidongduijie_0{0}",3+floor))

local isLock=false
local extraUnlock=cfgHelper.get2(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoDuJie,'extraUnlock')
for i,cond in ipairs(extraUnlock[idx])do
local flag,cur,max=guildOrderModel:checkCond(cond)
local cond_str=guildOrderModel:getCondDesc(cond)
if not flag then
isLock=true
item:SetChildText(5,FMT.fmt("{0}解锁",cond_str))
break
end
end
item:SetChildActive(4,isLock)
end

function UIGuildOrderSetupWin_autoDuJie:onOrderItemClick(index)
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if not setup.isOpen then return end
if setup.jjcengIndex~=index then
local prevIdx=setup.jjcengIndex
setup.jjcengIndex=index
local floor=cfg.jjcengRange[index]
if self.maxLv==floor then
guildOrderModel:clearDuJieReddot(self.maxLv)
self.maxLv=-1
end
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
self:refreshOrderItem(nil,prevIdx)
self:refreshOrderItem(nil,index)
local lastPos=self.posX
self.posX=(setup.jjcengIndex-1)*243+70
if self.currDZ then
self.currDZ:setSharedVar('dPos',{self.posX,0})
self.currDZ:setSharedVar('move',1)
self.currDZ:broke()
self.currDZ:reset()
self.currDZ:tick(0)
end
end
end


function UIGuildOrderSetupWin_autoDuJie:onControllBtn(idx)
local orderID=_this.orderID
local setup=guildOrderModel:getSetupData(orderID)
setup.isOpen=not setup.isOpen
guildOrderModel:flushSetupData(orderID)
guildOrderModel:changeSetupOpen(orderID,setup.isOpen)
self:refreshItemControllBtn(orderID)
UIManager:invokeUIMethod('UIGuildOrderWin','checkitemorder',GUILD_ORDER_TYPE.eAutoDuJie)
end


function UIGuildOrderSetupWin_autoDuJie:refreshItemControllBtn(orderID,firstOpen)
local isSetupOpen=guildOrderModel:isOrderSetupOpen(orderID)
_this.winlua:SetChildActive(_this.controllClose:getID(),not isSetupOpen)
_this.winlua:SetChildActive(_this.controllOpen:getID(),isSetupOpen)
_this.winlua:SetChildCanvasGroupDOFade(_this.closeBg:getID(),not isSetupOpen and 1 or 0,firstOpen and 0 or 0.5)
_this.winlua:SetChildCanvasGroupDOFade(_this.openPanel:getID(),isSetupOpen and 1 or 0,firstOpen and 0 or 0.5)
end

function UIGuildOrderSetupWin_autoDuJie:createDZ(dzId,pos,callback)
local initData={
move=0,
dPos={pos[1],pos[2]},
}
local tran=self.dzEmpty:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local otherData={
scale=0.8,
}
self.dzInst=uiAIManager:createUIDisciple('UIGuildOrderSetupWin_autoDuJie','bt_ui_autoDuJie',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end
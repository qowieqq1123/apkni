







def_class("UITopMoneyWin4",UIWindowBase)









function UITopMoneyWin4:bindComponents()

self.root=UIObject.get(self,0)
self.flyIconPanel=UIObject.get(self,1)



end


function UITopMoneyWin4:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.flyIconPanel);self.flyIconPanel=nil;
end
















local _pathType=DG.Tweening.PathType
local _Ease=DG.Tweening.Ease
local _this


function UITopMoneyWin4:onLoaded(...)
_this=self
self:bindComponents()
self.money={}

self.fmTweener={}

self.flyIcon={}
self.flyIconTweener={}

self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemChange=function(...)self:onItemChange(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self._onItemChange)
end


function UITopMoneyWin4:__delete()
_this=nil
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
end


function UITopMoneyWin4:onHide()
self:clearFlyIcon()
end

function UITopMoneyWin4:clearFlyIcon()
for k,v in pairs(self.flyIcon)do
_InstantiateManager.RemoveInstance(k)
end
self.flyIcon={}
for k,v in pairs(self.flyIconTweener)do
v:Kill()
end
self.flyIconTweener={}
end




function UITopMoneyWin4:onShow(argtable,afterOnloaded)
self.money=argtable.moneys
self.defaultPos=self.root:getChildPosition()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener={}
self:freshMoneyList()

if argtable.offsetX and argtable.offsetY then
self.root:setChildAnchoredPos(argtable.offsetX,argtable.offsetY)
end
end

function UITopMoneyWin4:getMoneyList()
return self.money
end

function UITopMoneyWin4:findMoneyIndex(moneyType)
for i,v in ipairs(self.money)do
if v[1]==moneyType then
return i
end
end
return nil
end

function UITopMoneyWin4:freshMoneyList()
local moneyList=self.money
local c=#moneyList
self.root:setChildLayoutGroupCreateItems(c)
local grids=self.root:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local moneyInfo=moneyList[i]
local moneyType=moneyInfo[1]

local isAdd=moneyInfo[2]~=1
item:SetChildActive(2,isAdd)
if isAdd then
item:SetChildButtonClick(2,function()
self:onAddClick(moneyType)
end)
end
item:SetChildButtonClick(3,function()
self:clickMoney(i)
end)
self:refreshItem(item,i)
end
end

function UITopMoneyWin4:refreshItem(item,index)
if item==nil then
item=self.root:getChildLayoutGroupGridItem(index-1)
end
local moneyInfo=self.money[index]
local moneyType=moneyInfo[1]
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagModel.getNotExpireItemCountById(moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
item:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
item:SetChildText(1,moneyStr)
end

function UITopMoneyWin4:freshMoneyValue(index,lastVal)
local item=self.root:getChildLayoutGroupGridItem(index-1)
local moneyInfo=self.money[index]
local moneyType=moneyInfo[1]

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagModel.getNotExpireItemCountById(moneyType)
end
self:clearFMTweener(moneyType)
self.fmTweener[moneyType]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
item:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UITopMoneyWin4:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UITopMoneyWin4:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)



end



function UITopMoneyWin4:flyMoneyIcon(spos,moneyType)
local idx=self:findMoneyIndex(moneyType)
if idx then
local item=self.root:getChildLayoutGroupGridItem(idx-1)
local tp
if item then
tp=item:GetChildPosition(-1)
else
tp=self.defaultPos
end
local count=math.random(3,5)
for i=1,count do
self:handleFly(moneyType,spos,tp)
end
end
end

function UITopMoneyWin4:handleFly(moneyType,spos,tpos)
local parent=self.flyIconPanel:getCommonComponent('Transform')
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFlyIcon,parent,function(iconId)

local icon=_InstantiateManager.GetComponent(iconId,'CSGUIWidgetBase')
icon:SetChildIcon(1,iconHelper.getIconName(moneyType),true)
icon:SetChildPosition(0,spos)
local tran=_InstantiateManager.GetComponent(iconId,'Transform')
local rx=math.random()*4-2
local ry=math.random()*4-2
local tweener=_DOTweenProxy.DoPath(tran,{tpos,Vector3(spos.x+rx,spos.y+ry,0),tpos},1,_pathType.CubicBezier)
tweener:SetEase(_Ease.InSine)
tweener:SetDelay(math.random()*0.5)
tweener:OnComplete(function()

_InstantiateManager.RemoveInstance(iconId)
self.flyIcon[iconId]=nil
self.flyIconTweener[iconId]=nil
end)
self.flyIconTweener[iconId]=tweener
end)
self.flyIcon[id]=true
end



function UITopMoneyWin4:onMoneyChange(moneyType,lastVal,val)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==moneyType then
self:freshMoneyValue(i,lastVal)
break
end
end
end

function UITopMoneyWin4:clickMoney(idx)
local moneyInfo=self.money[idx]
if moneyInfo==nil then return end
local moneyType=moneyInfo[1]

if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end

end


function UITopMoneyWin4:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==itemid then
self:freshMoneyValue(i,lastcount)
break
end
end
end

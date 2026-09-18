







def_class("UITopMoneyHighWin",UIWindowBase)









function UITopMoneyHighWin:bindComponents()

self.root=UIObject.get(self,0)
self.flyIconPanel=UIObject.get(self,1)
self.moneyRoot1=UIObject.get(self,2)
self.moneyRoot2=UIObject.get(self,3)
self.moneyRoot3=UIObject.get(self,4)
self.moneyRoot4=UIObject.get(self,5)



end


function UITopMoneyHighWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.flyIconPanel);self.flyIconPanel=nil;
_UIObject_release(self.moneyRoot1);self.moneyRoot1=nil;
_UIObject_release(self.moneyRoot2);self.moneyRoot2=nil;
_UIObject_release(self.moneyRoot3);self.moneyRoot3=nil;
_UIObject_release(self.moneyRoot4);self.moneyRoot4=nil;
end
















local _pathType=DG.Tweening.PathType
local _Ease=DG.Tweening.Ease




function UITopMoneyHighWin:onLoaded(...)
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


function UITopMoneyHighWin:__delete()
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
end




function UITopMoneyHighWin:onShow(argtable,afterOnloaded)
if argtable then
self.money=argtable
self.defaultPos=self.root:getChildPosition()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener={}
self:freshMoneyList()
end
end


function UITopMoneyHighWin:onHide()
self:clearFlyIcon()
end

function UITopMoneyHighWin:clearFlyIcon()
for k,v in pairs(self.flyIcon)do
_InstantiateManager.RemoveInstance(k)
end
self.flyIcon={}
for k,v in pairs(self.flyIconTweener)do
v:Kill()
end
self.flyIconTweener={}
end




function UITopMoneyHighWin:getMoneyList()
return self.money
end

function UITopMoneyHighWin:freshMoneyList()
local moneyList=self.money
for i=1,4 do
self:fillData(i,moneyList[i])
end
end

function UITopMoneyHighWin:fillData(index,moneyInfo)
local rootStr=FMT.fmt('moneyRoot{0}',index)
if moneyInfo==nil then
self[rootStr]:setActive(false)
return
end
self[rootStr]:setActive(true)
local widget=self.winlua:GetChildWidgetBase(self[rootStr]:getID())
local moneyType=moneyInfo[1]
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
end

function UITopMoneyHighWin:freshMoneyValue(index,moneyInfo,lastVal)
local rootStr=FMT.fmt('moneyRoot{0}',index)
if moneyInfo==nil then
self[rootStr]:setActive(false)
return
end
self[rootStr]:setActive(true)
local moneyType=moneyInfo[1]
local widget=self.winlua:GetChildWidgetBase(self[rootStr]:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweener(moneyType)
self.fmTweener[moneyType]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UITopMoneyHighWin:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UITopMoneyHighWin:getMoneyRoot(moneyType)
for i,v in ipairs(self.money)do
if v[1]==moneyType then
local rootStr=FMT.fmt('moneyRoot{0}',i)
return self[rootStr]
end
end
return nil
end



function UITopMoneyHighWin:flyMoneyIcon(spos,moneyType)
local mr=self:getMoneyRoot(moneyType)
local tp=mr and mr:getChildPosition()or self.defaultPos
local count=math.random(3,5)
for i=1,count do
self:handleFly(moneyType,spos,tp)
end
end

function UITopMoneyHighWin:handleFly(moneyType,spos,tpos)
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



function UITopMoneyHighWin:onMoneyChange(moneyType,lastVal,val)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==moneyType then
self:freshMoneyValue(i,moneyInfo,lastVal)
break
end
end
end


function UITopMoneyHighWin:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==itemid then
self:freshMoneyValue(i,moneyInfo,lastcount)
break
end
end
end
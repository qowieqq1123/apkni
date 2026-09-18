







def_class("UIIOSTiShenTopMoneyWin",UIWindowBase)









function UIIOSTiShenTopMoneyWin:bindComponents()

self.root=UIObject.get(self,0)
self.flyIconPanel=UIObject.get(self,1)
self.moneyRoot1=UIObject.get(self,2)
self.moneyRoot2=UIObject.get(self,3)
self.moneyRoot3=UIObject.get(self,4)
self.moneyRoot4=UIObject.get(self,5)
self.moneyRoot5=UIObject.get(self,6)
self.moneyRoot6=UIObject.get(self,7)
self.moneyRoot7=UIObject.get(self,8)
self.money1Btn=UIButton.get(self,9)
self.money2Btn=UIButton.get(self,10)
self.money3Btn=UIButton.get(self,11)
self.money4Btn=UIButton.get(self,12)
self.money5Btn=UIButton.get(self,13)
self.money6Btn=UIButton.get(self,14)
self.money7Btn=UIButton.get(self,15)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.money2Btn:setButtonClick(function()self:onMoney2Btn()end)

self.money3Btn:setButtonClick(function()self:onMoney3Btn()end)

self.money4Btn:setButtonClick(function()self:onMoney4Btn()end)

self.money5Btn:setButtonClick(function()self:onMoney5Btn()end)

self.money6Btn:setButtonClick(function()self:onMoney6Btn()end)

self.money7Btn:setButtonClick(function()self:onMoney7Btn()end)



end


function UIIOSTiShenTopMoneyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.flyIconPanel);self.flyIconPanel=nil;
_UIObject_release(self.moneyRoot1);self.moneyRoot1=nil;
_UIObject_release(self.moneyRoot2);self.moneyRoot2=nil;
_UIObject_release(self.moneyRoot3);self.moneyRoot3=nil;
_UIObject_release(self.moneyRoot4);self.moneyRoot4=nil;
_UIObject_release(self.moneyRoot5);self.moneyRoot5=nil;
_UIObject_release(self.moneyRoot6);self.moneyRoot6=nil;
_UIObject_release(self.moneyRoot7);self.moneyRoot7=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.money2Btn);self.money2Btn=nil;
_UIObject_release(self.money3Btn);self.money3Btn=nil;
_UIObject_release(self.money4Btn);self.money4Btn=nil;
_UIObject_release(self.money5Btn);self.money5Btn=nil;
_UIObject_release(self.money6Btn);self.money6Btn=nil;
_UIObject_release(self.money7Btn);self.money7Btn=nil;
end
















local _pathType=DG.Tweening.PathType
local _Ease=DG.Tweening.Ease
local _count=7
local shieldTweenMoney={
[eMoneyType.mtXianQi]=true,
[eMoneyType.mtMoQi]=true,
}



function UIIOSTiShenTopMoneyWin:onLoaded(...)
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


function UIIOSTiShenTopMoneyWin:__delete()
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
end




function UIIOSTiShenTopMoneyWin:onShow(argtable,afterOnloaded)
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


function UIIOSTiShenTopMoneyWin:onHide()
self:clearFlyIcon()
end

function UIIOSTiShenTopMoneyWin:clearFlyIcon()
for k,v in pairs(self.flyIcon)do
_InstantiateManager.RemoveInstance(k)
end
self.flyIcon={}
for k,v in pairs(self.flyIconTweener)do
v:Kill()
end
self.flyIconTweener={}
self.isPlayFlyYuBiEnd=false
end




function UIIOSTiShenTopMoneyWin:getMoneyList()
return self.money
end

function UIIOSTiShenTopMoneyWin:freshMoneyList()
local moneyList=self.money
for i=1,_count do
self:fillData(i,moneyList[i])
end
end

function UIIOSTiShenTopMoneyWin:fillData(index,moneyInfo)
local rootStr=FMT.fmt('moneyRoot{0}',index)
if moneyInfo==nil then
self[rootStr]:setActive(false)
return
end
local isShowMoney=true
local limitSysId=moneyInfo[3]
if limitSysId~=nil then
isShowMoney=systemModel.isOpen(limitSysId)
end
self[rootStr]:setActive(isShowMoney)
local widget=self.winlua:GetChildWidgetBase(self[rootStr]:getID())
local moneyType=moneyInfo[1]
local isAdd=moneyInfo[2]~=1
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,isAdd)

end

function UIIOSTiShenTopMoneyWin:freshMoneyValue(index,moneyInfo,lastVal)
local rootStr=FMT.fmt('moneyRoot{0}',index)
if moneyInfo==nil then
self[rootStr]:setActive(false)
return
end
local isShowMoney=true
local limitSysId=moneyInfo[3]
if limitSysId~=nil then
isShowMoney=systemModel.isOpen(limitSysId)
end
self[rootStr]:setActive(isShowMoney)
local moneyType=moneyInfo[1]
local widget=self.winlua:GetChildWidgetBase(self[rootStr]:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
if shieldTweenMoney[moneyType]then
local moneyStr=mathHelper.formatNumber(math.floor(moneyVal),true)
widget:SetChildText(1,moneyStr)
else
self:clearFMTweener(moneyType)
self.fmTweener[moneyType]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end
end

function UIIOSTiShenTopMoneyWin:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UIIOSTiShenTopMoneyWin:onAddClick(moneyType)

if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
end
end

function UIIOSTiShenTopMoneyWin:getMoneyRoot(moneyType)
for i,v in ipairs(self.money)do
if v[1]==moneyType then
local rootStr=FMT.fmt('moneyRoot{0}',i)
return self[rootStr]
end
end
return nil
end



function UIIOSTiShenTopMoneyWin:flyMoneyIcon(spos,moneyType)
local mr=self:getMoneyRoot(moneyType)
local tp=mr and mr:getChildPosition()or self.defaultPos
local count=math.random(_count-1,_count+1)
for i=1,count do
self:handleFly(moneyType,spos,tp)
end
end

function UIIOSTiShenTopMoneyWin:handleFly(moneyType,spos,tpos)
local parent=self.flyIconPanel:getCommonComponent('Transform')
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFlyIcon,parent,function(iconId)

local icon=_InstantiateManager.GetComponent(iconId,'CSGUIWidgetBase')
icon:SetChildIcon(1,iconHelper.getIconName(moneyType),true)
icon:SetChildPosition(0,spos)
local tran=_InstantiateManager.GetComponent(iconId,'Transform')
local rx=math.random()*_count-2
local ry=math.random()*_count-2
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


function UIIOSTiShenTopMoneyWin:flyYuBiIcon(spos,moneyType,moneyNum)
local mr=self:getMoneyRoot(moneyType)
local widget=mr:getChildWidgetBase()
if not widget then return false end
local tp=widget and widget:GetChildPosition(0)or self.defaultPos
self:handleBoomYuBi(spos)
self:handleFlyYuBi(moneyType,spos,tp,moneyNum)
return true
end


function UIIOSTiShenTopMoneyWin:handleBoomYuBi(spos)
local parent=self.flyIconPanel:getCommonComponent('Transform')
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFlyIcon,parent,function(iconId)
local icon=_InstantiateManager.GetComponent(iconId,'CSGUIWidgetBase')
icon:SetChildPosition(0,spos)
icon:SetChildShowEffect(2,20220,true)

local tran=_InstantiateManager.GetComponent(iconId,'Transform')
local tweener=_DOTweenProxy.DOSizeDelta(tran,Vector2(1,1),2,false)
tweener:OnComplete(function()
_InstantiateManager.RemoveInstance(iconId)
self.flyIcon[iconId]=nil
self.flyIconTweener[iconId]=nil
end)
self.flyIconTweener[iconId]=tweener
end)
self.flyIcon[id]=true
end

function UIIOSTiShenTopMoneyWin:handleFlyYuBi(moneyType,spos,tpos,moneyNum)
local parent=self.flyIconPanel:getCommonComponent('Transform')
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFlyIcon,parent,function(iconId)

local icon=_InstantiateManager.GetComponent(iconId,'CSGUIWidgetBase')

icon:SetChildPosition(0,spos)
icon:SetChildShowEffect(2,20221,true)

local tran=_InstantiateManager.GetComponent(iconId,'Transform')
local rx=math.random()*_count-2
local ry=math.random()*_count-2
local tweener=_DOTweenProxy.DoPath(tran,{tpos,Vector3(spos.x+rx,spos.y+ry,0),tpos},2,_pathType.CubicBezier)
tweener:SetEase(_Ease.InSine)
tweener:SetDelay(math.random()*0.5)
tweener:OnComplete(function()

_InstantiateManager.RemoveInstance(iconId)
self.flyIcon[iconId]=nil
self.flyIconTweener[iconId]=nil
self:handleFlyYuBiEnd(tpos)
UIManager.moneyInfo(eMoneyType.mtYuBi,FMT.fmt('+{0}',moneyNum))
end)
self.flyIconTweener[iconId]=tweener
end)
self.flyIcon[id]=true
end

function UIIOSTiShenTopMoneyWin:handleFlyYuBiEnd(tpos)
if self.isPlayFlyYuBiEnd then
return
end
self.isPlayFlyYuBiEnd=true
local parent=self.flyIconPanel:getCommonComponent('Transform')
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFlyIcon,parent,function(iconId)
local icon=_InstantiateManager.GetComponent(iconId,'CSGUIWidgetBase')
icon:SetChildPosition(0,tpos)
icon:SetChildShowEffect(2,20222,true)

local tran=_InstantiateManager.GetComponent(iconId,'Transform')
local tweener=_DOTweenProxy.DOSizeDelta(tran,Vector2(1,1),2,false)
tweener:OnComplete(function()
_InstantiateManager.RemoveInstance(iconId)
self.flyIcon[iconId]=nil
self.flyIconTweener[iconId]=nil
self.isPlayFlyYuBiEnd=false
end)
self.flyIconTweener[iconId]=tweener
end)
self.flyIcon[id]=true
end

function UIIOSTiShenTopMoneyWin:flyMoneyInfoTips(moneyType,index)
local mr=self:getMoneyRoot(moneyType)
local tpos=mr and mr:getChildPosition()or self.defaultPos
moneySystem.moneyList[moneyType][index].pos=tpos
local win=UIManager:findActiveWindow("UITipTextMoney")
if win then
win:refresh()
else
UIManager:showWindow("UITipTextMoney")
end
end


function UIIOSTiShenTopMoneyWin:onMoneyChange(moneyType,lastVal,val)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==moneyType then
self:freshMoneyValue(i,moneyInfo,lastVal)
break
end
end
end

function UIIOSTiShenTopMoneyWin:clickMoney(idx)
local moneyInfo=self.money[idx]
if moneyInfo==nil then return end
local moneyType=moneyInfo[1]

if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end

end

function UIIOSTiShenTopMoneyWin:onMoney1Btn()
self:clickMoney(1)
end

function UIIOSTiShenTopMoneyWin:onMoney2Btn()
self:clickMoney(2)
end

function UIIOSTiShenTopMoneyWin:onMoney3Btn()
self:clickMoney(3)
end

function UIIOSTiShenTopMoneyWin:onMoney4Btn()
self:clickMoney(4)
end

function UIIOSTiShenTopMoneyWin:onMoney5Btn()
self:clickMoney(5)
end

function UIIOSTiShenTopMoneyWin:onMoney6Btn()
self:clickMoney(6)
end

function UIIOSTiShenTopMoneyWin:onMoney7Btn()
self:clickMoney(7)
end


function UIIOSTiShenTopMoneyWin:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==itemid then
self:freshMoneyValue(i,moneyInfo,lastcount)
break
end
end
end

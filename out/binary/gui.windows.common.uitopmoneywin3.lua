







def_class("UITopMoneyWin3",UIWindowBase)









function UITopMoneyWin3:bindComponents()

self.root=UIObject.get(self,0)
self.flyIconPanel=UIObject.get(self,1)
self.moneyRoot1=UIObject.get(self,2)
self.moneyRoot2=UIObject.get(self,3)
self.moneyRoot3=UIObject.get(self,4)
self.moneyRoot4=UIObject.get(self,5)
self.money1Btn=UIButton.get(self,6)
self.money2Btn=UIButton.get(self,7)
self.money3Btn=UIButton.get(self,8)
self.money4Btn=UIButton.get(self,9)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.money2Btn:setButtonClick(function()self:onMoney2Btn()end)

self.money3Btn:setButtonClick(function()self:onMoney3Btn()end)

self.money4Btn:setButtonClick(function()self:onMoney4Btn()end)



end


function UITopMoneyWin3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.flyIconPanel);self.flyIconPanel=nil;
_UIObject_release(self.moneyRoot1);self.moneyRoot1=nil;
_UIObject_release(self.moneyRoot2);self.moneyRoot2=nil;
_UIObject_release(self.moneyRoot3);self.moneyRoot3=nil;
_UIObject_release(self.moneyRoot4);self.moneyRoot4=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.money2Btn);self.money2Btn=nil;
_UIObject_release(self.money3Btn);self.money3Btn=nil;
_UIObject_release(self.money4Btn);self.money4Btn=nil;
end
















local _pathType=DG.Tweening.PathType
local _Ease=DG.Tweening.Ease


function UITopMoneyWin3:onLoaded(...)
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


function UITopMoneyWin3:__delete()
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
end


function UITopMoneyWin3:onHide()
self:clearFlyIcon()
end

function UITopMoneyWin3:clearFlyIcon()
for k,v in pairs(self.flyIcon)do
_InstantiateManager.RemoveInstance(k)
end
self.flyIcon={}
for k,v in pairs(self.flyIconTweener)do
v:Kill()
end
self.flyIconTweener={}
end




function UITopMoneyWin3:onShow(argtable,afterOnloaded)
if argtable then
self.money=argtable.moneys or argtable
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
end

function UITopMoneyWin3:getMoneyList()
return self.money
end

function UITopMoneyWin3:freshMoneyList()
local moneyList=self.money
for i=1,4 do
self:fillData(i,moneyList[i])
end
end

function UITopMoneyWin3:fillData(index,moneyInfo)
local rootStr=FMT.fmt('moneyRoot{0}',index)
if moneyInfo==nil then
self[rootStr]:setActive(false)
return
end
self[rootStr]:setActive(true)
local widget=self.winlua:GetChildWidgetBase(self[rootStr]:getID())
local moneyType=moneyInfo[1]
local isAdd=moneyInfo[2]~=1
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagModel.getNotExpireItemCountById(moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,isAdd)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)
end

function UITopMoneyWin3:freshMoneyValue(index,moneyInfo,lastVal)
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
moneyVal=bagModel.getNotExpireItemCountById(moneyType)
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

function UITopMoneyWin3:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UITopMoneyWin3:onAddClick(moneyType)

gainControl:showCommonGainWin_item(moneyType)



end

function UITopMoneyWin3:getMoneyRoot(moneyType)
for i,v in ipairs(self.money)do
if v[1]==moneyType then
local rootStr=FMT.fmt('moneyRoot{0}',i)
return self[rootStr]
end
end
return nil
end



function UITopMoneyWin3:flyMoneyIcon(spos,moneyType)
local mr=self:getMoneyRoot(moneyType)
local tp=mr and mr:getChildPosition()or self.defaultPos
local count=math.random(3,5)
for i=1,count do
self:handleFly(moneyType,spos,tp)
end
end

function UITopMoneyWin3:handleFly(moneyType,spos,tpos)
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



function UITopMoneyWin3:onMoneyChange(moneyType,lastVal,val)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==moneyType then
self:freshMoneyValue(i,moneyInfo,lastVal)
break
end
end
end

function UITopMoneyWin3:clickMoney(idx)
local moneyInfo=self.money[idx]
if moneyInfo==nil then return end
local moneyType=moneyInfo[1]

if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end

end

function UITopMoneyWin3:onMoney1Btn()
self:clickMoney(1)
end

function UITopMoneyWin3:onMoney2Btn()
self:clickMoney(2)
end

function UITopMoneyWin3:onMoney3Btn()
self:clickMoney(3)
end

function UITopMoneyWin3:onMoney4Btn()
self:clickMoney(4)
end


function UITopMoneyWin3:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local moneyList=self.money
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==itemid then
self:freshMoneyValue(i,moneyInfo,lastcount)
break
end
end
end

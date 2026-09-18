







def_class("UISubAct_ChiSeJinDi_CopyWeaponBuyWin2",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:bindComponents()

self.discipleBtn=UIButton.get(self,0)
self.fazeBtn=UIButton.get(self,1)
self.goBtn=UIButton.get(self,2)
self.goodsList=UIObject.get(self,3)
self.leftBottom=UIObject.get(self,4)
self.moneyBg=UIButton.get(self,5)
self.moneyIcon=UIImage.get(self,6)
self.moneyNum=UIText.get(self,7)
self.refreshBtn=UIButton.get(self,8)
self.refreshCost=UIObject.get(self,9)
self.refreshMoney=UIImage.get(self,10)
self.refreshNum=UIText.get(self,11)
self.sellBtn=UIButton.get(self,12)
self.weaponBtn=UIButton.get(self,13)

self.discipleBtn:setButtonClick(function()self:onDiscipleBtn()end)

self.fazeBtn:setButtonClick(function()self:onFazeBtn()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)

self.weaponBtn:setButtonClick(function()self:onWeaponBtn()end)



end


function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.discipleBtn);self.discipleBtn=nil;
_UIObject_release(self.fazeBtn);self.fazeBtn=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.goodsList);self.goodsList=nil;
_UIObject_release(self.leftBottom);self.leftBottom=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.refreshCost);self.refreshCost=nil;
_UIObject_release(self.refreshMoney);self.refreshMoney=nil;
_UIObject_release(self.refreshNum);self.refreshNum=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
_UIObject_release(self.weaponBtn);self.weaponBtn=nil;
end















local _this=nil
local _itemCmp={
buyBtn=0,
tips=1,
image=2,
starList=3,
costRoot=4,
costIcon=5,
costNum=6,
name=7,
buyed=8,
effectColor=9,
button=10,
root=11,
background=12,
imageBg=13,
effect=14,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"
local _animationID={
enter=2411,
exit=2412,
}



function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onLoaded(...)
self:bindComponents()
_this=self
self.starTweens={}
socketManager:addNotify(249,238,self.on_249_238)
socketManager:addNotify(249,239,self.on_249_239)
socketManager:addNotify(249,241,self.on_249_241)
end


function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:__delete()
self:unbindComponents()
_this=nil

if self.tweener and self.tweener:IsActive()then
self.tweener:Kill()
end
for i,v in pairs(self.starTweens)do
if v:IsActive()then
v:Kill()
end
end

socketManager:removeNotify(249,238,self.on_249_238)
socketManager:removeNotify(249,239,self.on_249_239)
socketManager:removeNotify(249,241,self.on_249_241)
end




function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin
self.callback=argtable.callback


self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.copyData=self.info:getCopy()
self.teamData=self.info:getTeam()

self:updateBuyed()
self:initView()
self:refreshMoneyNum(true)
self:refreshList()
end


function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onHide()

end

















function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onSellBtn()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyWeaponSellWin2",args)
end


function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onRefreshBtn()
if self.tweener or not self.showList then return end

if self.copyData.money<self.config.refresh[3]then
UIManager.error("货币不足")
tipsManager.showTips({itemid=self.config.chanceMoney})
return
end






call_activitiesHandle_func("activitiesHandle_chisejindi","reqRefreshCopyItem",self.actId,self.subId)


AudioManager.playAudio(665)
self:closeList()
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onMoneyBg()
tipsManager.showTips({itemid=self.config.chanceMoney})
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onFazeBtn()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
side=0,
}
self:showWindow("UISubAct_ChiSeJinDi_FaZeBagWin",args)
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onDiscipleBtn()
local discipleList=self.copyData.discipleList
self.copyData:sortDiscipleList()
local lookup=self.info:getTeamLookup_Disciple()
local roleList={}
for index,disciple in ipairs(discipleList)do
local pos=lookup[disciple]
local posData=pos and self.teamData[pos]or nil
local weapon=posData and posData.weapon or nil
local data={
disciple=disciple,
weapon=weapon,
}
table.insert(roleList,data)
end
if#roleList>0 then
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList=roleList,
parentWin=self,
showList=true,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)
else
UIManager.error("无弟子信息可查看")
end
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onWeaponBtn()
local weaponList=self.copyData.weaponList
self.copyData:sortWeaponList()
local lookup=self.info:getTeamLookup_Weapon()
local dataList={}
for index,weapon in ipairs(weaponList)do
local pos=lookup[weapon]
local posData=pos and self.teamData[pos]or nil
local disciple=posData and posData.disciple or nil
local data={
disciple=disciple,
weapon=weapon,
}
table.insert(dataList,data)
end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
dataList=dataList,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyWeaponDetailWin",args)
end


function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onGoBtn()
if self.callback then
self.callback(self.buyed)
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:initView()
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)
self.refreshMoney:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)

self.winlua:ForceLayoutRect(self.refreshCost:getID())
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:updateBuyed()
local roundData=self.copyData.roundData
for index=1,roundData.len do
local data=roundData.list[index]
local buyFlag=data.param_2==1
if buyFlag then
self.buyed=true
return
end
end
self.buyed=false
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:refreshMoneyNum(onlyTab)
local moneyStr=mathHelper.formatNumber(self.copyData.money)
self.moneyNum:setText(moneyStr)

local num=self.config.refresh[3]
local str=num<=self.copyData.money and num or FMT.cfmt2("#ee0000",num)
self.refreshNum:setText(str)

if not onlyTab then
local roundData=self.copyData.roundData
local items=self.goodsList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
local data=roundData.list[i]
local recruitFlag=data.param_2
if recruitFlag~=1 then
local weaponID=data.param_1
local serverCfg=self.config.treasure[weaponID]
local price=serverCfg[4]
local priceStr=price<=self.copyData.money and price or FMT.cfmt2("#ee0000",price)
item:SetChildText(_itemCmp.costNum,priceStr)
end
end
end
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:closeList()
local items=self.goodsList:getChildLayoutGroupGridList()
local exitSeq=Lua.SequenceProxy.New()
exitSeq:AppendInterval(0.5)
for i=1,items.Count do
local item=items[i-1]

local tweener=item:SetChildCanvasGroupDOFade(_itemCmp.root,0,0.2)
exitSeq:Join(tweener)
end
exitSeq:AppendCallback(function()
self.tweener=nil
self.showList=false

if self.waitRefresh then
self:refreshMoneyNum(true)
self:refreshList(true)
self.waitRefresh=nil
end
end)
self.tweener=exitSeq
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:refreshList(onlyAnim)
local roundData=self.copyData.roundData
self.goodsList:setChildLayoutGroupCreateItems(roundData.len)
local items=self.goodsList:getChildLayoutGroupGridList()
local enterSeq=Lua.SequenceProxy.New()
enterSeq:AppendInterval(0.5)
for index=1,items.Count do
local oldTween=self.starTweens[index]
if oldTween and oldTween:IsActive()then
oldTween:Kill()
self.starTweens[index]=nil
end

local item=items[index-1]
local data=roundData.list[index]
local weaponID=data.param_1
local buyFlag=data.param_2==1
local serverCfg=self.config.treasure[weaponID]
local clientCfg=self.config.treasureClient[weaponID]
local levelUpID=nil
local haveID=nil
for idx,id in ipairs(self.copyData.weaponList)do
local newId=self.info:doItemStarUp(id,weaponID)
if newId then
haveID=id
levelUpID=newId
break
end
end
local name=clientCfg[1]
local price=serverCfg[4]
local image=clientCfg[3]
local colorEffect=clientCfg[4]
local color=serverCfg[6]
local effect=clientCfg[6]
local starID=weaponID
if levelUpID then
if buyFlag then
starID=levelUpID-1
else
starID=levelUpID
end
end
local contains=levelUpID~=nil
local star=haveID and self.info:getCopyItemStar(haveID)or 0
local showStar=self.info:getCopyItemStar(starID)
local priceStr=price<=self.copyData.money and price or FMT.cfmt2("#ee0000",price)
item:SetChildButtonClick(_itemCmp.buyBtn,function()
self:onClickBuy(index)
end)
if webGLHelper:isWebGLOptimization()or effect==nil or effect<0 then
item:SetChildCSImageIcon(_itemCmp.image,image,false)
item:SetChildShowEffect(_itemCmp.effect,-1,false)
else
item:SetChildCSImageIcon(_itemCmp.image,"",false)
item:SetChildShowEffect(_itemCmp.effect,effect,true)
end
item:SetChildButtonClick(_itemCmp.button,function()
self:onClickImage(index)
end)
if webGLHelper:isWebGLOptimization()then
item:SetChildCSImageSprite(_itemCmp.imageBg,globalABLookup.gubaomainicons,FMT.fmt("image_gubaoys_{0}",color-1))
item:SetChildShowEffect(_itemCmp.effectColor,-1,false)
else
item:SetChildShowEffect(_itemCmp.effectColor,colorEffect,colorEffect>0)
item:SetChildCSImageIcon(_itemCmp.imageBg,"",false)
end
item:SetChildCSImageIcon(_itemCmp.costIcon,iconHelper.getIconName(self.config.chanceMoney),false)
item:SetChildText(_itemCmp.costNum,priceStr)
item:ForceLayoutRect(_itemCmp.costRoot)
item:SetChildLayoutGroupCreateItems(_itemCmp.starList,showStar,function(starIdx)
local starItem=item:GetChildLayoutGroupGridItem(_itemCmp.starList,starIdx-1)
if starIdx>star then
local tweener=starItem:SetChildCanvasGroupDOFade(-1,0,0.5)
tweener:SetLoops(-1,DG.Tweening.LoopType.Yoyo)
self.starTweens[index]=tweener
else
starItem:SetChildCanvasGroupAlpha(-1,1)
end
end)
item:SetChildText(_itemCmp.name,name)
item:SetChildActive(_itemCmp.buyed,buyFlag)
item:SetChildActive(_itemCmp.buyBtn,not buyFlag)
item:SetChildActive(_itemCmp.costRoot,not buyFlag)
item:SetChildActive(_itemCmp.tips,contains)





local seq=Lua.SequenceProxy.New()
local tweener=item:SetChildCanvasGroupDOFade(_itemCmp.root,1,0.2)
seq:AppendInterval(0.233)
seq:Append(tweener)
enterSeq:Join(tweener)
end
enterSeq:AppendCallback(function()
self.tweener=nil
self.showList=true
end)
self.tweener=enterSeq
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onClickImage(index)
if self.tweener or not self.showList then return end
local roundData=self.copyData.roundData
local data=roundData.list[index]
local weapon=data.param_1
local args={
itemid=weapon,
funType=TIPS_FUNC_TYPE.eChiSeJinDiWeapon,
attach={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
}
tipsManager.showTips(args)
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:onClickBuy(index)
if self.tweener or not self.showList then return end

local roundData=self.copyData.roundData
local data=roundData.list[index]
local recruitFlag=data.param_2==1
if recruitFlag then
UIManager.info("已购买宝物")
return
end


local weaponID=data.param_1
local weaponCfg=self.config.treasure[weaponID]
if self.copyData.money<weaponCfg[4]then
UIManager.error("货币不足")
tipsManager.showTips({itemid=self.config.chanceMoney})
return
end






call_activitiesHandle_func("activitiesHandle_chisejindi","reqSelectCopyItem",self.actId,self.subId,index)

end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2:setItemBuyed(index)
local item=self.goodsList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_itemCmp.buyed,true)
item:SetChildActive(_itemCmp.buyBtn,false)
item:SetChildActive(_itemCmp.costRoot,false)
if self.starTweens[index]then
self.starTweens[index]:Kill()
self.starTweens[index]=nil

local starList=item:GetChildLayoutGroupGridList(_itemCmp.starList)
if starList.Count>0 then
local starItem=starList[starList.Count-1]
starItem:SetChildCanvasGroupAlpha(-1,1)
end
end
self.buyed=true
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2.on_249_238(actId,subId,index)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoneyNum()
_this:setItemBuyed(index)
end
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2.on_249_239(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
if _this.tweener then
_this.waitRefresh=true
else
_this:refreshMoneyNum(true)
_this:refreshList(true)
end
end
end

function UISubAct_ChiSeJinDi_CopyWeaponBuyWin2.on_249_241(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoneyNum()
end
end
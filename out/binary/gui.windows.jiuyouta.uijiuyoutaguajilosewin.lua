







def_class("UIJiuYouTaGuaJiLoseWin",UIWindowBase)









function UIJiuYouTaGuaJiLoseWin:bindComponents()

self.bgRoot=UIObject.get(self,0)
self.closeTips=UIButton.get(self,1)
self.continueButton=UIButton.get(self,2)
self.continueText=UIText.get(self,3)
self.dragonBack=UIObject.get(self,4)
self.effect=UIObject.get(self,5)
self.fgroot=UIObject.get(self,6)
self.fightCountBtn=UIButton.get(self,7)
self.finalHpPanel=UIObject.get(self,8)
self.finalHpProgress=UIProgress.get(self,9)
self.layer=UIText.get(self,10)
self.nextLayer=UIText.get(self,11)
self.noReward=UIText.get(self,12)
self.quitButton=UIButton.get(self,13)
self.quitText=UIText.get(self,14)
self.root=UIObject.get(self,15)
self.shoutongrewards=UIObject.get(self,16)
self.titleRoot=UIObject.get(self,17)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)



end


function UIJiuYouTaGuaJiLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgRoot);self.bgRoot=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.continueText);self.continueText=nil;
_UIObject_release(self.dragonBack);self.dragonBack=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.fgroot);self.fgroot=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.finalHpPanel);self.finalHpPanel=nil;
_UIObject_release(self.finalHpProgress);self.finalHpProgress=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.nextLayer);self.nextLayer=nil;
_UIObject_release(self.noReward);self.noReward=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.quitText);self.quitText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shoutongrewards);self.shoutongrewards=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
end


















local quitDefaultName='退 出'
local continueDefaultName='继续挑战'

function UIJiuYouTaGuaJiLoseWin:onLoaded(...)
self:bindComponents()
end


function UIJiuYouTaGuaJiLoseWin:__delete()
self:unbindComponents()
end




function UIJiuYouTaGuaJiLoseWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgRoot:setChildCanvasGroupAlpha(0)
self.fgroot:setChildCanvasGroupAlpha(0)
self.effect:setChildShowEffect(10522,true)
self:delayDo(1.5,function()
self.bgRoot:setChildCanvasGroupDOFade(1,0.4,function()
self.dragonBack:setActive(true)
end)

end)

local func=function()
self.fgroot:setChildCanvasGroupDOFade(1,0.4,nil)
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(3,func)

end
JiuYouTaModel:setGuaJILoseArgs()
self.fightData=argtable.fightData



self.extraParams=argtable.extraParams or{}
self.battleId=self.extraParams.battleId
self.resultType=self.extraParams.resultType
self.extraParams.fightData=self.fightData
self.extraParams.parentWin=self
self.battleType=self.extraParams.battleType
self.param=argtable.param
self.logPackage=argtable.logPackage


self.callback=argtable.callback


local btnsInfo=nil
self.quitCallBack=btnsInfo~=nil and btnsInfo.quitCallBack or nil
self.continuCallBack=btnsInfo~=nil and btnsInfo.continuCallBack or nil
local haveBtns=btnsInfo~=nil and(btnsInfo.quitCallBack~=nil or
btnsInfo.continuCallBack~=nil)
self.quitButton:setActive(self.quitCallBack~=nil)
self.continueButton:setActive(self.continuCallBack~=nil)
self.closeTips:setActive(not haveBtns)
if self.quitCallBack~=nil then
local quitBtnName=btnsInfo.quitBtnName or quitDefaultName
self.quitText:setText(quitBtnName)
end
if self.continuCallBack~=nil then
local continueBtnName=btnsInfo.continueBtnName or continueDefaultName
self.continueText:setText(continueBtnName)
end


if argtable.isHideFightBtn then
self.fightCountBtn:setActive(false)
end


if not haveBtns then
self.closeTimer=self:delayDo(1.5,function(...)
self.canClose=true
end)
end



self:showGuajiReward()
end

function UIJiuYouTaGuaJiLoseWin:showGuajiReward()

local curLayer=JiuYouTaModel:getClearLayer()

local guajiLayer=JiuYouTaModel:getGuaJILayer()

local isClear=true
if curLayer<guajiLayer then
curLayer=guajiLayer
isClear=false
end



self.layer:setText(FMT.fmt("本次挑战九幽塔：{0}",guajiLayer))
self.nextLayer:setText(curLayer)

local rewardList=JiuYouTaModel:getGuaJIReward()
JiuYouTaModel:clearGuaJIReward()
JiuYouTaModel:setGuaJILayer(nil)


local showReward=(guajiLayer~=curLayer)and next(rewardList)
local list={}
local lookUp={}
if showReward then
for i,v in ipairs(rewardList)do
local itemId=v.itemid
local handle
if v.itemguid then
handle=tostring(v.itemguid)
else
handle=itemId
end
local data=lookUp[handle]
if not data then
lookUp[handle]=v
else
local num=data.num
lookUp[handle]={itemid=itemId,num=num+v.num}
end
end
for i,v in pairs(lookUp)do
table.insert(list,v)
end
table.sort(list,function(a,b)
local itemida,itemidb
local isTeZhia,isTeZhib=false,false
local isGaiLva,isGaiLvb=false,false
local isActReward_a,isActReward_b=false,false
itemida=a.itemid
itemidb=b.itemid
local aConfig=itemsConfig.getConfig(itemida)
local bConfig=itemsConfig.getConfig(itemidb)
local aRareLv=itemsConfig.getRareLv(itemida)
local bRareLv=itemsConfig.getRareLv(itemidb)
local aScore=aRareLv*10000000+itemida
local bScore=bRareLv*10000000+itemidb

if not isGaiLva then
aScore=aScore+1000000
end
if not isGaiLvb then
bScore=bScore+1000000
end

aScore=aScore+aConfig.color*100000
bScore=bScore+bConfig.color*100000

if itemsConfig.isGubao(itemida)then
aScore=aScore+200000000
elseif not itemsConfig.isEquip(itemida)then
aScore=aScore+100000000
end

if itemsConfig.isGubao(itemidb)then
bScore=bScore+200000000
elseif not itemsConfig.isEquip(itemidb)then
bScore=bScore+100000000
end

if isActReward_a then
aScore=aScore+1000000000
end

if isActReward_b then
bScore=bScore+1000000000
end

return aScore>bScore
end)
self.noReward:setActive(false)
else
self.noReward:setActive(true)
end
self.shoutongrewards:setChildLayoutGroupCreateItems(#list)
local items=self.shoutongrewards:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local itemid=list[i+1].itemid
local num=list[i+1].num
local conf={itemid=itemid,showCountBG=num>1,itemcount=num>1 and num or'',showStage=true,showname=false,itemIndex=i}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
end


function UIJiuYouTaGuaJiLoseWin:onHide()

end

function UIJiuYouTaGuaJiLoseWin:onCloseTips()
if not self.canClose then return false end
local cb=self.callback
self:closeSelf()
if cb then cb()end
return true
end

function UIJiuYouTaGuaJiLoseWin:onQuitButton()
local cb=self.quitCallBack
self:closeSelf()
if cb then cb()end
end

function UIJiuYouTaGuaJiLoseWin:onContinueButton()
local cb=self.continuCallBack
self:closeSelf()
if cb then cb()end
end

function UIJiuYouTaGuaJiLoseWin:onFightCountBtn()
if self.isWait then
return
end
if not self.fightData then
local log=self.logPackage.logStr
local battleID=fightController:startBallte(log,false,nil,nil,{})
local battle=fightModel:getBattle(battleID)
if battle then
battle:onSkipAll()
self.isWait=true
self:delayDo(2,function()
self.isWait=false
local resList={}
local list=battle:getStatisticsList()
for i,v in ipairs(list)do
local res=v.statistics
local round=v.round
local maxRound=v.maxRound
res.round=round
res.maxRound=maxRound
table.insert(resList,res)
end
local fightData=resList
self.fightData=fightData
local battleType=self.battleType
UIManager:showWindow('UIFightCountWin',{fightData=fightData,battleId=battleID,battleType=battleType})
end)
end
else
UIManager:showWindow('UIFightCountWin',{fightData=self.fightData,battleId=self.battleId,battleType=self.battleType})
end
end

function UIJiuYouTaGuaJiLoseWin:stopCloseTimer()
if self.closeTimer then
self:stopTimerByID(self.closeTimer)
self.closeTimer=nil
end
end









def_class("UIBaoLingShuPickUp_TipsWin",UIWindowBase)









function UIBaoLingShuPickUp_TipsWin:bindComponents()

self.mask=UIButton.get(self,0)
self.pickUpGBModel=UIObject.get(self,1)
self.gubaoName=UIText.get(self,2)
self.bgModel=UIObject.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.clickGB=UIButton.get(self,5)
self.pickUpShowLBtn=UIButton.get(self,6)
self.pickUpShowRBtn=UIButton.get(self,7)

self.mask:setButtonClick(function()self:onMask()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.clickGB:setButtonClick(function()self:onClickGB()end)

self.pickUpShowLBtn:setButtonClick(function()self:onPickUpShowLBtn()end)

self.pickUpShowRBtn:setButtonClick(function()self:onPickUpShowRBtn()end)



end


function UIBaoLingShuPickUp_TipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.pickUpGBModel);self.pickUpGBModel=nil;
_UIObject_release(self.gubaoName);self.gubaoName=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.clickGB);self.clickGB=nil;
_UIObject_release(self.pickUpShowLBtn);self.pickUpShowLBtn=nil;
_UIObject_release(self.pickUpShowRBtn);self.pickUpShowRBtn=nil;
end
















local _this
local pickUpGBLoopTime=5



function UIBaoLingShuPickUp_TipsWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIBaoLingShuPickUp_TipsWin:__delete()
self:stopPickUpGBShowTimer()
self:stopPickUpGBModelLoadTimer()
self:unbindComponents()
_this=nil
end




function UIBaoLingShuPickUp_TipsWin:onShow(argtable,afterOnloaded)
self.bgModel:setChildUIModelShowTarget(4862,1,{},eAnimationID.enter)


local gbList=baoLingShuModel:getPickUpShowGBList()
if not gbList or not next(gbList)then
return self:onMask()
end
self.defaultModelScale=self.pickUpGBModel:getScale()

self.showPickUpGbSelectIndex=1
local showGBListCount=#gbList
if showGBListCount==1 then
self.showPickUpGbSelectIndex=1
else

self.showPickUpGbSelectIndex=math.random(1,showGBListCount)
end

self.showPickUpGbMaxSelectIndex=showGBListCount
self:refreshPickUpGBModel()
if showGBListCount<=1 then

self.pickUpShowLBtn:setActive(false)
self.pickUpShowRBtn:setActive(false)
self.nextPickUpGBShowTime=nil
else

self.pickUpShowLBtn:setActive(true)
self.pickUpShowRBtn:setActive(true)
local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
end

self:setPickUpGBShowTimer()
end


function UIBaoLingShuPickUp_TipsWin:onHide()
self:stopPickUpGBShowTimer()
self:stopPickUpGBModelLoadTimer()
end

function UIBaoLingShuPickUp_TipsWin:refreshPickUpGBModel()
self.pickUpGBModel:setChildShowEffect(0,false)
local pickUpShowGBList=baoLingShuModel:getPickUpShowGBList()
local showCfg=pickUpShowGBList[self.showPickUpGbSelectIndex]
local showGBItemId=showCfg[1]
local gbId=gubaoLookup:good2GuBao(showGBItemId)
local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local effectId=pram.effectid



local scale=self.defaultModelScale or Vector3.New(1,1,1)
self.pickUpGBModel:setScale(Vector3.zero)
self.pickUpGBModel:setChildShowEffect(effectId,true)
self:stopPickUpGBModelLoadTimer()
self.pickUpModelLoadTimer=self:delayDo(0.2,function()
if _this==nil then return end

_this.pickUpGBModel:setScale(scale)
end)

local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)
local gbName=gbCfg.name
self.gubaoName:setText(gbName)
end

function UIBaoLingShuPickUp_TipsWin:setPickUpGBShowTimer()
self:stopPickUpGBShowTimer()
local timerFun=function(isFirst)
local nowTime=timeHelper.getServerLongTime()
if not isFirst and nowTime>=self.nextPickUpGBShowTime then
self:onPickUpShowRBtn()
end

local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
if not isInPickUpNow then
return self:closeSelf()
end
end
self.pickUpShowTimer=self:setTimer(1,0,function()
return timerFun()
end)
timerFun(true)
end

function UIBaoLingShuPickUp_TipsWin:stopPickUpGBShowTimer()
if self.pickUpShowTimer then
self:stopTimerByID(self.pickUpShowTimer)
self.pickUpShowTimer=nil
end
end

function UIBaoLingShuPickUp_TipsWin:stopPickUpGBModelLoadTimer()
if self.pickUpModelLoadTimer then
self:stopTimerByID(self.pickUpModelLoadTimer)
self.pickUpModelLoadTimer=nil
end
end




function UIBaoLingShuPickUp_TipsWin:onMask()
self:closeSelf()
end


function UIBaoLingShuPickUp_TipsWin:onGotoBtn()
jumpManager:jump({id=JUMP_TYPE.eBuilding,
args={type=SLG_SYSTEM_TYPE.eBaoLingShu,isOpenRepairWin=true}},
function()
if _this==nil then return end
_this:closeSelf()
end,JUMP_BACK.eNoBack)
end



function UIBaoLingShuPickUp_TipsWin:onPickUpShowLBtn()
local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
if self.showPickUpGbSelectIndex<=1 then
self.showPickUpGbSelectIndex=self.showPickUpGbMaxSelectIndex
else
self.showPickUpGbSelectIndex=self.showPickUpGbSelectIndex-1
end
self:refreshPickUpGBModel()
end


function UIBaoLingShuPickUp_TipsWin:onPickUpShowRBtn()

local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
if self.showPickUpGbSelectIndex>=self.showPickUpGbMaxSelectIndex then
self.showPickUpGbSelectIndex=1
else
self.showPickUpGbSelectIndex=self.showPickUpGbSelectIndex+1
end
self:refreshPickUpGBModel()
end

function UIBaoLingShuPickUp_TipsWin:onClickGB()

local pickUpShowGBList=baoLingShuModel:getPickUpShowGBList()
local showCfg=pickUpShowGBList[self.showPickUpGbSelectIndex]
local showGBItemId=showCfg[1]
itemsComponentHelper.onItemClickEx(showGBItemId)
end
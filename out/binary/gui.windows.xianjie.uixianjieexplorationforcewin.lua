







def_class("UIXianJieExplorationForceWin",UIWindowBase)









function UIXianJieExplorationForceWin:bindComponents()

self.chooseGrid=UIObject.get(self,0)
self.maskBlock=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)
self.uiPanel=UIObject.get(self,4)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)



end


function UIXianJieExplorationForceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end
















local reddotFuncList={
[xianjieForceType.eYuJing]=function()
return xjFactionNPCModel:getFactionReddot(xianjieForceType.eYuJing)
end,
[xianjieForceType.eXianGong]=function()
return XianGongController.getReddot()or xjFactionNPCModel:getFactionReddot(xianjieForceType.eXianGong)
end,
[xianjieForceType.ePengLai]=function()
return xjFactionNPCModel:getFactionReddot(xianjieForceType.ePengLai)
end,
[xianjieForceType.eJiuYuan]=function()
return shouhundingController:getReddot()or xjFactionNPCModel:getFactionReddot(xianjieForceType.eJiuYuan)
end,
}
local _this=nil



local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"

function UIXianJieExplorationForceWin:onLoaded(...)
self:bindComponents()
_this=self
self:addProNotify(40,26,self.on_40_26)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.onXianGuanJingXuanSegmentChange)
self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
end


function UIXianJieExplorationForceWin:__delete()
self:unbindComponents()
_this=nil
end
local itemcmp=
{
bgicon=1,
nameicon=2,
stageicon=3,
reddot=4,
}



function UIXianJieExplorationForceWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
self:refreshview()
end


function UIXianJieExplorationForceWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end

function UIXianJieExplorationForceWin:playLeaveAnim()

self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end


function UIXianJieExplorationForceWin:onHide()

end


function UIXianJieExplorationForceWin:refreshview()
local num=xianjieModel:GetForceNum()

self.scrollView:setChildScrollViewCreateGrids(num,1)
local grid=self.scrollView:getChildScrollViewItemWidgets()
for i=1,num do
local cfgdata=xianjieModel:GetForceCfg(i)

local explore_paixu=cfgdata.explore_paixu
local item=grid[explore_paixu-1]
local data,havetask=taskModel:GetHighTaskbyForceid(i)
item:SetChildNewBieComponentId(itemcmp.bgicon,'UIXianJieExplorationForceWinindex'..i)
item:SetChildActive(itemcmp.stageicon,havetask)
if api_Available_SetChildCSImage()then
item:SetChildCSImage(itemcmp.bgicon,abname,cfgdata.explore_image,true)
item:SetChildCSImage(itemcmp.nameicon,abname,cfgdata.explore_title,true)

else
item:SetChildCSImageSprite(itemcmp.bgicon,abname,cfgdata.explore_image)
item:SetChildCSImageSprite(itemcmp.nameicon,abname,cfgdata.explore_title)
end


local isReddot=false
if reddotFuncList[i]then
isReddot=reddotFuncList[i]()
end
item:SetChildActive(itemcmp.reddot,isReddot)

item:SetChildButtonClick(itemcmp.bgicon,function()
xianjieModel:JumptoForce(i)
end)
end
end




function UIXianJieExplorationForceWin:onMaskBlock()
end

function UIXianJieExplorationForceWin:refreshItemReddot(id)
local cfgdata=xianjieModel:GetForceCfg(id)
local explore_paixu=cfgdata.explore_paixu
local item=grid[explore_paixu-1]
local isReddot=false
if reddotFuncList[id]then
isReddot=reddotFuncList[id]()
end
item:SetChildActive(itemcmp.reddot,isReddot)
end

function UIXianJieExplorationForceWin.on_40_26()
_this:refreshItemReddot(xianjieForceType.eXianGong)
end

function UIXianJieExplorationForceWin.on_system_open(sysId)
if shouhundingModel:isSysID(sysId)then
_this:refreshItemReddot(xianjieForceType.eJiuYuan)
end
end

function UIXianJieExplorationForceWin.onXianGuanJingXuanSegmentChange(campaignType)
if campaignType==XianGuanCampaignType.eWuXuan then
_this:refreshItemReddot(xianjieForceType.eXianGong)
end
end

function UIXianJieExplorationForceWin.onXianJieFactionReddotChange(factionList)
for i,v in ipairs(factionList)do
_this:refreshItemReddot(v)
end
end

function UIXianJieExplorationForceWin.on_money_changed(mType)
if shouhundingModel:isDataType(mType)then
_this:refreshItemReddot(xianjieForceType.eJiuYuan)
end
end
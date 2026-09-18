







def_class("UICJXYChapterOpenSystemWin",UIWindowBase)









function UICJXYChapterOpenSystemWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.descTx=UIText.get(self,2)
self.descTx2=UIText.get(self,3)
self.jumpBtn=UIButton.get(self,4)
self.model=UIObject.get(self,5)
self.nameTx=UIText.get(self,6)
self.rewardList=UIObject.get(self,7)
self.rewardView=UIObject.get(self,8)
self.tabList=UIObject.get(self,9)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UICJXYChapterOpenSystemWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.descTx2);self.descTx2=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.tabList);self.tabList=nil;
end















local _this=nil
local _tabCmp={
root=-1,
clickBtn=0,
nameTx=1,
}
local menu_slot_name='button_dytab'



function UICJXYChapterOpenSystemWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UICJXYChapterOpenSystemWin:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYChapterOpenSystemWin:onShow(argtable,afterOnloaded)
self.configs=argtable.configs
self.parentWin=argtable.parentWin
self.selectTab=self.selectTab or 1
self:refreshTabList()
self:refreshView()
end


function UICJXYChapterOpenSystemWin:onHide()

end




function UICJXYChapterOpenSystemWin:onBackground()
self:onCloseBtn()
end


function UICJXYChapterOpenSystemWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UICJXYChapterOpenSystemWin:onJumpBtn()
local config=self.configs[self.selectTab]
local jumpParam=config.jump
if jumpParam then
local jumpEx=config.jumpEx
if jumpEx then
local exType=jumpEx[1]
local exParam=jumpEx[2]
if exType==1 then
local stage=seasonModel:getStage(exParam[1],exParam[2])
if stage==nil or not stage:isOverBegin()or not stage:checkOpen()then
UIManager.error(jumpEx[3])
return
end
elseif exType==2 then
local stage=seasonModel:getStage(exParam[1],exParam[2])
if stage==nil or not stage:isOverEnd()then
UIManager.error(jumpEx[3])
return
end
end
end

jumpManager:jump(jumpParam)
end
end

function UICJXYChapterOpenSystemWin:onClickTab(index)
if self.banClickTab>0 then return end
if self.selectTab~=index then
self:refreshTabSelectEx(self.selectTab,false)
self.selectTab=index
self:refreshTabSelectEx(self.selectTab,true)
self:refreshView()
end
end

function UICJXYChapterOpenSystemWin:refreshTabList()
self.banClickTab=#self.configs
self.tabList:setChildLayoutGroupCreateItems(self.banClickTab,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local data=self.configs[index]
item:SetChildButtonClick(_tabCmp.clickBtn,function()
self:onClickTab(index)
end)
item:SetChildUIModelShowTarget(_tabCmp.root,2017,1,{},eAnimationID.common_window_enter,false,false,0,function()
self:refreshTabSelect(item,self.selectTab==index)
item:SetChildText(_tabCmp.nameTx,data.name)
item:SetChildCanvasGroupAlpha(_tabCmp.nameTx,0)
local tween=item:SetChildCanvasGroupDOFade(_tabCmp.nameTx,1,0.5)
tween:SetDelay(0.5)
self.banClickTab=self.banClickTab-1
end)
end)
end

function UICJXYChapterOpenSystemWin:refreshTabSelectEx(index,select)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
self:refreshTabSelect(item,select)
end

function UICJXYChapterOpenSystemWin:refreshTabSelect(item,select)
local name=FMT.fmt("{0}_{1}",menu_slot_name,select and 2 or 1)
item:SetChildUIModelShowSlotAttachment(_tabCmp.root,menu_slot_name,name)
end

function UICJXYChapterOpenSystemWin:refreshView()
local config=self.configs[self.selectTab]
local modelParams=config.model
self.model:setChildUIModelShowTarget(modelParams[1],modelParams[3]or 1,modelParams[2]or{},modelParams[4]or eAnimationID.stand,false,false,0)
local offset=modelParams[5]
local offsetX=offset and offset[1]or 0
local offsetY=offset and offset[2]or 0
self.model:setChildUIModelShowTargetOffset(offsetX,offsetY)
self.nameTx:setText(config.name)
local desc=comHelper.getCheckLayoutStr(self.descTx2:getGameObject(),self.descTx2:getChildSizeDeltaX(),config.desc)
self.descTx:setText(desc)
local jump=config.jump
self.jumpBtn:setActive(jump~=nil)
if jump then
local jumpEx=config.jumpEx
local gray=false
if jumpEx then
local exType=jumpEx[1]
local exParam=jumpEx[2]
if exType==1 then
local stage=seasonModel:getStage(exParam[1],exParam[2])
gray=stage==nil or not stage:isOverBegin()or not stage:checkOpen()
elseif exType==2 then
local stage=seasonModel:getStage(exParam[1],exParam[2])
gray=stage==nil or not stage:isOverEnd()
end
end
self.jumpBtn:setChildGraphicGray(gray)
end
local rewards=config.items
local showReward=rewards~=nil and#rewards>0
self.rewardView:setActive(showReward)
if showReward then
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
self.rewardView:setChildScrollRectEnable(#rewards>5)
end
end
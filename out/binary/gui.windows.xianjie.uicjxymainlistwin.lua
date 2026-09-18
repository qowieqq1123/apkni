







def_class("UICJXYMainListWin",UIWindowBase)









function UICJXYMainListWin:bindComponents()

self.bgImage=UIImage.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.blackImg=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.closeTx=UIText.get(self,4)
self.root=UIObject.get(self,5)
self.tabList=UIObject.get(self,6)
self.tabView=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UICJXYMainListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImage);self.bgImage=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tabView);self.tabView=nil;
end















local _this=nil
local _tabCmp={
widget=-1,
name1=0,
name2=1,
select=2,
inactive=3,
finish=4,
lock=5,
reddot=6,
}



function UICJXYMainListWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonOpenAnimationChange,self.onSeasonOpenAnimationChange)
end


function UICJXYMainListWin:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYMainListWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handle=seasonModel:getHandle(self.showParams.handleType)
if self.handle==nil then
self:onCloseBtn()
end
self.showParams.stageIdx=self.showParams.stageIdx or seasonModel:getHandleEnterStage(self.showParams.handleType)
self:refreshView()

local winName=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx,"winName")
self:showWindow(winName,self.showParams)
end


function UICJXYMainListWin:onHide()

end

function UICJXYMainListWin:onShowArgRecv(argtable)
self:onShow(argtable,false)
end




function UICJXYMainListWin:onCloseBtn()
UIFullSeasonControl:closeUI(true,true)
end

function UICJXYMainListWin:refreshView()
local stageCfgs=self.handle:getConfig("chapter_list")
local selectIdx=self.showParams.stageIdx
self.tabList:setChildLayoutGroupCreateItems(#stageCfgs,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local config=stageCfgs[index]
local stage=self.handle:getStage(index)
local name=seasonModel:getStageConfig(config[2],config[1],"name")
local open=stage~=nil and stage:checkOpen()and stage:isOverBegin()
local storyed=seasonModel:readOpenAnimRecord(self.showParams.handleType,index)==2
local reddot=open and(stage:getReddot()or not storyed)or false
local finish=open and stage:isOverEnd()and storyed or false
local nameStr=FMT.fmt("{0}·{1}",index,name)
item:SetChildText(_tabCmp.name1,nameStr)
item:SetChildText(_tabCmp.name2,nameStr)
item:SetChildActive(_tabCmp.select,selectIdx==index)
item:SetChildActive(_tabCmp.inactive,not open)
item:SetChildActive(_tabCmp.lock,not open)
item:SetChildActive(_tabCmp.reddot,reddot)
item:SetChildActive(_tabCmp.finish,finish)
item:SetChildButtonClick(_tabCmp.widget,function()
self:onClickStage(index)
end)
end)
end

function UICJXYMainListWin:onClickStage(index)
local selectIdx=self.showParams.stageIdx
if selectIdx~=index then

local item=self.tabList:getChildLayoutGroupGridItem(selectIdx-1)
item:SetChildActive(_tabCmp.select,false)

if selectIdx then
local winName=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx,"winName")
self:hideWindow(winName)
end


self.showParams.stageIdx=index


local item=self.tabList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_tabCmp.select,true)

local winName=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx,"winName")
self:showWindow(winName,self.showParams)

seasonController:send_39_4(self.showParams.handleType,self.showParams.stageIdx)
end
end

function UICJXYMainListWin:refreshAllItemInfo()
local stageCfgs=self.handle:getConfig("chapter_list")
for i,v in ipairs(stageCfgs)do
self:refreshItemInfo(i)
end
end

function UICJXYMainListWin:refreshItemInfo(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local stage=self.handle:getStage(index)
local open=stage~=nil and stage:checkOpen()and stage:isOverBegin()
local storyed=seasonModel:readOpenAnimRecord(self.showParams.handleType,index)==2
local reddot=open and(stage:getReddot()or not storyed)or false
local finish=open and stage:isOverEnd()and storyed or false
item:SetChildActive(_tabCmp.inactive,not open)
item:SetChildActive(_tabCmp.lock,not open)
item:SetChildActive(_tabCmp.reddot,reddot)
item:SetChildActive(_tabCmp.finish,finish)
end

function UICJXYMainListWin:refreshItemFinish(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local stage=self.handle:getStage(index)
local finish=stage~=nil and stage:isOverBegin()and stage:checkOpen()and stage:isOverEnd()and seasonModel:readOpenAnimRecord(self.showParams.handleType,index)==2 or false
item:SetChildActive(_tabCmp.finish,finish)
end

function UICJXYMainListWin.onSeasonChange()
_this.handle=seasonModel:getHandle(_this.showParams.handleType)
if _this.handle==nil then
_this:onCloseBtn()
return
end

_this:refreshAllItemInfo()
end

function UICJXYMainListWin.onSeasonStageDataChange(season_id,chapter_idx)
if _this.handle and _this.handle.id==season_id then
_this:refreshItemInfo(chapter_idx)
end
end

function UICJXYMainListWin.onSeasonStageChange(season_id,chapter_idx)
if _this.handle and _this.handle.id==season_id then
_this:refreshItemInfo(chapter_idx)
end
end

function UICJXYMainListWin.onSeasonOpenAnimationChange(season_id,chapter_idx,openAnim)
if _this.handle and _this.handle.id==season_id and openAnim==2 then
_this:refreshItemInfo(chapter_idx)
end
end
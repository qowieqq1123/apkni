







def_class("UIMoJieStageAimMainWin",UIWindowBase)








function UIMoJieStageAimMainWin:bindComponents()

self.bgImage=UIImage.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.blackImg=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.closeTx=UIText.get(self,4)
self.frameSpine=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.tabList=UIObject.get(self,7)
self.tabView=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoJieStageAimMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImage);self.bgImage=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.frameSpine);self.frameSpine=nil;
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
lockSpine=7,
}




function UIMoJieStageAimMainWin:onLoaded(...)
self:bindComponents()
_this=self

self.isCanPlayTabAnim=true

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonOpenAnimationChange,self.onSeasonOpenAnimationChange)

self.frameSpine:setChildUIModelShowTarget(5792,1,nil,3440,false,false,0)
end


function UIMoJieStageAimMainWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieStageAimMainWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handle=seasonModel:getHandle(self.showParams.handleType)
if self.handle==nil then
self:onCloseBtn()
end
self.showParams.stageIdx=self.showParams.stageIdx or seasonModel:getHandleEnterStage(self.showParams.handleType)
self:refreshView()
self:refreshFrameBg()

local winName=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx,"winName")
self:showWindow(winName,self.showParams)
local name=self.handle:getConfig('name')
self.closeTx:setText(name)
end


function UIMoJieStageAimMainWin:onHide()

end

function UIMoJieStageAimMainWin:onShowArgRecv(argtable)
self:onShow(argtable,false)
end




function UIMoJieStageAimMainWin:onCloseBtn()
UIFullSeasonControl:closeUI(true,true)
end

function UIMoJieStageAimMainWin:refreshView()
local stageCfgs=self.handle:getConfig("chapter_list")
local selectIdx=self.showParams.stageIdx
self.tabList:setChildLayoutGroupCreateItems(#stageCfgs)

local curStageIdx=self.handle:getCurStageIdx()

local animTabList={}

local grids=self.tabList:getChildLayoutGroupGridList()
for index=1,grids.Count do
local item=grids[index-1]
local config=stageCfgs[index]
local stage=self.handle:getStage(index)
local name=seasonModel:getStageConfig(config[2],config[1],"name")
local storyed=seasonModel:readOpenAnimRecord(self.showParams.handleType,index)==2
local isLock=stage~=nil and stage:checkOpen()and stage:isUnlock()
local open=isLock and storyed
if not isLock then

name=""
end
local noUnlockAnim=seasonModel:readUnlockTabAnimRecord(self.showParams.handleType,index)==0
local reddot=open and(stage:getReddot()or not storyed)or false
local finish=open and stage:isOverEnd()and storyed or false

local nameStr=name
item:SetChildText(_tabCmp.name1,nameStr)
item:SetChildText(_tabCmp.name2,nameStr)
item:SetChildActive(_tabCmp.select,selectIdx==index and not noUnlockAnim)
item:SetChildActive(_tabCmp.inactive,not open and not noUnlockAnim)
item:SetChildActive(_tabCmp.lock,false)
item:SetChildActive(_tabCmp.reddot,reddot)
item:SetChildActive(_tabCmp.finish,finish and not noUnlockAnim)
item:SetChildActive(_tabCmp.lockSpine,noUnlockAnim)

if noUnlockAnim then
local animId=3430
local posOffsetX=-35
if index%2==0 then
animId=3431
posOffsetX=0
end
item:SetChildUIModelShowTarget(_tabCmp.lockSpine,5793,1,{},animId,false,false,0,nil)
item:SetChildAnchoredPos(_tabCmp.lockSpine,posOffsetX,0)
local open=stage~=nil and stage:checkOpen()and stage:isUnlock()
local noUnlockAnim=seasonModel:readUnlockTabAnimRecord(self.showParams.handleType,index)==0
if open and noUnlockAnim then
animTabList[#animTabList+1]=index
end
end


item:SetChildButtonClick(_tabCmp.widget,function()
if not self.isCanPlayTabAnim then return end
self:onClickStage(index)
end)
end




if next(animTabList)and self.isCanPlayTabAnim then

self.isCanPlayTabAnim=false

if self.delayPlayTabAnim then
self:stopTimerByID(self.delayPlayTabAnim)
self.delayPlayTabAnim=nil
end

self.delayPlayTabAnim=self:delayDo(1.5,function()
local isShowAnim=false
for i=1,#animTabList do
local index=animTabList[i]
local item=grids[index-1]

local stage=self.handle:getStage(index)
local open=stage~=nil and stage:checkOpen()and stage:isUnlock()

local noUnlockAnim=seasonModel:readUnlockTabAnimRecord(self.showParams.handleType,index)==0
if noUnlockAnim and open then
seasonModel:markUnlockTabAnimRecord(self.showParams.handleType,index,1)

isShowAnim=true
local animId=3432
if index%2==0 then
animId=3433
end
item:SetChildModelAnimationState(_tabCmp.lockSpine,animId,1,function()
item:SetChildActive(_tabCmp.lockSpine,false)
end)
end
end

if isShowAnim then
self:delayDo(1,function()
self.isCanPlayTabAnim=true
self.delayPlayTabAnim=nil
self:refreshView()
end)
end
end)
end
end

function UIMoJieStageAimMainWin:onClickStage(index)
local stage=self.handle:getStage(index)
local open=stage~=nil and stage:checkOpen()and stage:isUnlock()
if not open then
local curIndex=self.handle:getCurStageIdx()
local isOpenAni=seasonModel:readOpenAnimRecord(self.showParams.handleType,curIndex)==2
local curIndexCh=mathHelper.numberToChinese(curIndex)
if isOpenAni then
local stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,curIndex)
UIManager.info(FMT.fmt("第{0}章节{1}未完成，无法前往后续章节",curIndexCh,stageCfg.name))
else
UIManager.info(FMT.fmt("第{0}章节未解锁，无法前往后续章节",curIndexCh))
end
return
end

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

local nextStage=self.handle:getStage(self.showParams.stageIdx)
if nextStage:isUnlock()then
seasonController:send_39_4(self.showParams.handleType,self.showParams.stageIdx)
end

self:refreshFrameBg()
end
end

function UIMoJieStageAimMainWin:refreshAllItemInfo()
local stageCfgs=self.handle:getConfig("chapter_list")
for i,v in ipairs(stageCfgs)do
self:refreshItemInfo(i)
end
end

function UIMoJieStageAimMainWin:refreshItemInfo(index)

if self.delayPlayTabAnim then return end

local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local stage=self.handle:getStage(index)
local open=stage~=nil and stage:checkOpen()and stage:isOverBegin()
local storyed=seasonModel:readOpenAnimRecord(self.showParams.handleType,index)==2
local reddot=open and stage:getReddot()or false
local finish=open and stage:isOverEnd()and storyed or false

if storyed then
local configs=self.handle:getConfig("chapter_list")
local config=configs[index]
local name=seasonModel:getStageConfig(config[2],config[1],"name")
item:SetChildText(_tabCmp.name1,name)
item:SetChildText(_tabCmp.name2,name)
end
item:SetChildActive(_tabCmp.inactive,not open)
item:SetChildActive(_tabCmp.lock,false)
item:SetChildActive(_tabCmp.reddot,reddot)
item:SetChildActive(_tabCmp.finish,finish)
end

function UIMoJieStageAimMainWin:refreshItemFinish(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local stage=self.handle:getStage(index)
local finish=stage~=nil and stage:isOverBegin()and stage:checkOpen()and stage:isOverEnd()and seasonModel:readOpenAnimRecord(self.showParams.handleType,index)==2 or false
item:SetChildActive(_tabCmp.finish,finish)
end

function UIMoJieStageAimMainWin:refreshFrameBg()
local index=self.showParams.stageIdx
local stage=self.handle:getStage(index)
local open=stage~=nil and stage:checkOpen()and stage:isUnlock()
local isOverEnd=stage~=nil and stage:isOverEnd()
local storyed=seasonModel:readOpenAnimRecord(self.showParams.handleType,index)==2 or isOverEnd
local curAnim=3440
if open and storyed then
curAnim=stage:getConfig("frameStandAnimId")
end
self.frameSpine:setChildModelAnimationState(curAnim,1)
end

function UIMoJieStageAimMainWin:openFrameBg(callback)
local index=self.showParams.stageIdx
local stage=self.handle:getStage(index)
local curAnim=stage:getConfig("frameOpenAnimId")
self.frameSpine:setChildModelAnimationState(curAnim,1,function()
if callback then
callback()
end
end)
end

function UIMoJieStageAimMainWin.onSeasonChange()
_this.handle=seasonModel:getHandle(_this.showParams.handleType)
if _this.handle==nil then
_this:onCloseBtn()
return
end

_this:refreshAllItemInfo()
end

function UIMoJieStageAimMainWin.onSeasonStageDataChange(season_id,chapter_idx)
_this.handle=seasonModel:getHandle(_this.showParams.handleType)
if _this.handle and _this.handle.id==season_id then
_this:refreshItemInfo(chapter_idx)
end
end

function UIMoJieStageAimMainWin.onSeasonStageChange(season_id,chapter_idx)
_this.handle=seasonModel:getHandle(_this.showParams.handleType)
if _this.handle and _this.handle.id==season_id then
_this:refreshView()
end
end

function UIMoJieStageAimMainWin.onSeasonOpenAnimationChange(season_id,chapter_idx,openAnim)
if _this.handle and _this.handle.id==season_id and openAnim==2 then
_this:refreshItemInfo(chapter_idx)
end
end

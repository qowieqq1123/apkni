







def_class("UIXBSL_targetWin",UIWindowBase)









function UIXBSL_targetWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.commonItemModelShow=UIObject.get(self,1)
self.scrollview=UIObject.get(self,2)
self.rwScrollView=UIObject.get(self,3)
self.receive=UIObject.get(self,4)
self.receiveBtn=UIButton.get(self,5)
self.rwTips=UIText.get(self,6)
self.menuModel_1=UIObject.get(self,7)
self.menuModel_2=UIObject.get(self,8)
self.modeMenuGroup=UIObject.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)
self.menuModel={
self.menuModel_1,
self.menuModel_2,
}



end


function UIXBSL_targetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.commonItemModelShow);self.commonItemModelShow=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.receive);self.receive=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.rwTips);self.rwTips=nil;
_UIObject_release(self.menuModel_1);self.menuModel_1=nil;
_UIObject_release(self.menuModel_2);self.menuModel_2=nil;
_UIObject_release(self.modeMenuGroup);self.modeMenuGroup=nil;
self.menuModel=nil;
end
















local _item_index={
title=0,
recv_btn=1,
wc_icon=2,
items={3,4,5,6},
recv_btn_text=7,
wwc_icon=8,
}

local _itemModelShowCmpIndex={
root=0,
itemModel=1,
itemEffectBg=2,
itemEffect=3,
itemImg=4,
itemClick=5,
zuShiModel1=6,
zuShiModel2=7,
bubbleframeRoot=8,
bubbleModel=9,
headKuang=10,
emotRoot=11,
emoticon=12,
}
local _this




function UIXBSL_targetWin:onLoaded(...)
_this=self
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXBSL_targetWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXBSL_targetWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.menuModel[1]:setChildUIModelShowTarget(5538,1,{},eAnimationID.enter)
self.menuModel[2]:setChildUIModelShowTarget(5538,1,{},eAnimationID.enter)
end
self.modeMenuList={XBSL_DIFFICULTY_MODE.Normal,XBSL_DIFFICULTY_MODE.Hard}
self.selectModeIndex=1
self.modeId=self.modeMenuList[self.selectModeIndex]
self.receiveList={}
self:refresh(true)
end


function UIXBSL_targetWin:onHide()

end

function UIXBSL_targetWin:refresh(resetPos)
self:refreshModeMenu()
self:refreshPage(resetPos)
end

function UIXBSL_targetWin:refreshModeMenu()
local grids=self.modeMenuGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local modeId=self.modeMenuList[i]
if modeId then
widget:SetChildActive(-1,true)
local isSelect=self.selectModeIndex==i

widget:SetChildButtonClick(-1,function()
if not _this then return end
if _this.modeId==modeId then return end

return _this:selectMode(i)
end,true)

self.menuModel[i]:setChildModelAnimationState(isSelect and eAnimationID.stand or eAnimationID.stand2)

local reddot=xunBaoShiLianModel:checkTargetReddotByModeId(modeId)
widget:SetChildActive(0,reddot)
else
widget:SetChildActive(-1,false)
end
end
end

function UIXBSL_targetWin:selectMode(selectModeIndex)
if selectModeIndex==self.selectModeIndex then
return
end
self.selectModeIndex=selectModeIndex
self.modeId=self.modeMenuList[self.selectModeIndex]
self:refresh(true)
end

function UIXBSL_targetWin:refreshPage(resetPos)
self:setTargetList(resetPos)
self:setSpecialReward()
end

function UIXBSL_targetWin:setSpecialReward()

local targetCfg=xunBaoShiLianModel:getTargetCfgByModeId(self.modeId)
local specialRewardCfg=targetCfg.specialShowList or{}
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
local isChapterUnlock=xunBaoShiLianModel:checkChapterIsUnlock(clearChapterId,self.modeId)
local showChapterId=clearChapterId
if not clearChapterId or clearChapterId==0 then
showChapterId=1
elseif not isChapterUnlock then

showChapterId=clearChapterId-1
end
local chapterSpecialCfg=specialRewardCfg[showChapterId]
local showMaxChapterId=1
local baseCfg=cfgHelper.get(cfg_treasuretrainningbasicconfig_get,1)
local showTargetList
if self.modeId==XBSL_DIFFICULTY_MODE.Normal then
showTargetList=baseCfg.simpleShowTargetList
elseif self.modeId==XBSL_DIFFICULTY_MODE.Hard then
showTargetList=baseCfg.difficultyShowTargetList
end
if showTargetList and next(showTargetList)then
for _,chapterId in ipairs(showTargetList)do
if chapterId>showMaxChapterId and showChapterId<=chapterId then
showMaxChapterId=chapterId
break
end
end

if showChapterId>showTargetList[#showTargetList]then
showMaxChapterId=showTargetList[#showTargetList]
end

if showMaxChapterId>=showChapterId then
for i=showChapterId,showMaxChapterId do
local cfg=specialRewardCfg[i]
if cfg and cfg.modelParam then
local isAllGot=xunBaoShiLianModel:checkTargetChapterIsAllGot(self.modeId,i)
if not isAllGot then
chapterSpecialCfg=cfg
showChapterId=i
break
end
end
end
else
chapterSpecialCfg=specialRewardCfg[showMaxChapterId]
showChapterId=showMaxChapterId
end
else
local maxChapterId
for chapterId,cfg in ipairs(specialRewardCfg)do
if not maxChapterId or(chapterId<=showChapterId and chapterId>maxChapterId)then
maxChapterId=chapterId
end
local isAllGot=xunBaoShiLianModel:checkTargetChapterIsAllGot(self.modeId,chapterId)
if not isAllGot then
chapterSpecialCfg=cfg
showChapterId=chapterId
break
end
end

if showChapterId>maxChapterId then
chapterSpecialCfg=specialRewardCfg[maxChapterId]
showChapterId=maxChapterId
end
end
local modelParam=chapterSpecialCfg and chapterSpecialCfg.modelParam or nil
if modelParam then
local offset=modelParam.offset or{0,0}
local size=modelParam.size or 1
local widget=self.commonItemModelShow:getWidgetBase()
if modelParam.modelid then
offset=offset or{0,0}
size=size or 1
local modelId=modelParam.modelid
local animationId=eAnimationID.stand
widgetHelper.clearItemModelShow(widget)
widget:SetChildUIModelShowTarget(_itemModelShowCmpIndex.itemModel,modelId,size,nil,animationId)
widget:SetChildScale(_itemModelShowCmpIndex.root,Vector3.New(size,size,size))
widget:SetChildAnchoredPosition(_itemModelShowCmpIndex.root,Vector2.New(offset[1],offset[2]))
elseif modelParam.itemid then
local itemId=modelParam.itemid
widgetHelper.setItemModelShow(widget,itemId,offset,size)
end
end


local rewards=chapterSpecialCfg.rewardList
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,4))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local rwdata=rewards[i+1]
widgetHelper.setNormalRewardItem(item,0,rwdata)
end

local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(self.modeId)
local finishLevelIdx
if clearChapterId<showChapterId then
finishLevelIdx=0
elseif showChapterId==clearChapterId then
finishLevelIdx=clearLevelIdx
else
finishLevelIdx=chapterSpecialCfg.guanqiaCount
end
local difficultyName=""
if self.modeId==XBSL_DIFFICULTY_MODE.Hard then
difficultyName="困难"
end
self.rwTips:setText(FMT.fmt('完成第{0}章所有{1}关卡<color=#ca631d>({2}/{3})</color>',showChapterId,difficultyName,finishLevelIdx,chapterSpecialCfg.guanqiaCount))
end

function UIXBSL_targetWin:setTargetList(resetPos)
local targetList=self:getSortTargetList()
local len=#targetList
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local cfg=targetList[i+1].cfg
local chapterId=cfg.chapterId
local levelIdx=cfg.levelIdx
item:SetChildText(_item_index.title,FMT.fmt("完成章节关卡：<color=#ca631d>{0}-{1}</color>",chapterId,levelIdx))

local rewards=cfg.rewardList
for i,v in ipairs(_item_index.items)do
local data=rewards[i]
if data then
item:SetChildActive(v,true)
widgetHelper.setNormalRewardItem(item,v,data)
else
item:SetChildActive(v,false)
end
end

local state=targetList[i+1].state

if state==1 then
item:SetChildActive(_item_index.wc_icon,true)
item:SetChildActive(_item_index.wwc_icon,false)
item:SetChildActive(_item_index.recv_btn,false)
elseif state==0 then
item:SetChildActive(_item_index.wc_icon,false)
item:SetChildActive(_item_index.wwc_icon,false)
item:SetChildActive(_item_index.recv_btn,true)
item:SetChildButtonClick(_item_index.recv_btn,function()

self:receiveAll()
end)
item:SetChildText(_item_index.recv_btn_text,'领取奖励')
else
item:SetChildActive(_item_index.wc_icon,false)
item:SetChildActive(_item_index.wwc_icon,true)
item:SetChildActive(_item_index.recv_btn,false)
item:SetChildButtonClick(_item_index.recv_btn,function()
UIManager.info('该关卡未完成')
end)
end
end

if resetPos then
self.scrollview:setChildScrollRectEnable(false)
self.scrollview:setChildScrollViewSelectItem(0,false,false,false)
self.scrollview:setChildScrollRectEnable(true)
end
end

function UIXBSL_targetWin:getSortTargetList()
local targetCfg=xunBaoShiLianModel:getTargetCfgByModeId(self.modeId)
local targetList=targetCfg.targetList or{}
local sortList={}
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(self.modeId)
local isChapterUnlock=xunBaoShiLianModel:checkChapterIsUnlock(clearChapterId,self.modeId)
local showMaxChapterId=1
local baseCfg=cfgHelper.get(cfg_treasuretrainningbasicconfig_get,1)
local showTargetList
if self.modeId==XBSL_DIFFICULTY_MODE.Normal then
showTargetList=baseCfg.simpleShowTargetList
elseif self.modeId==XBSL_DIFFICULTY_MODE.Hard then
showTargetList=baseCfg.difficultyShowTargetList
end
local showChapterId=clearChapterId
if not clearChapterId or clearChapterId==0 then
showChapterId=1
elseif not isChapterUnlock then

showChapterId=clearChapterId-1
end

if showTargetList and next(showTargetList)then
for _,chapterId in ipairs(showTargetList)do
if chapterId>showMaxChapterId and showChapterId<=chapterId then
showMaxChapterId=chapterId
break
end
end

if showChapterId>showTargetList[#showTargetList]then
showMaxChapterId=showTargetList[#showTargetList]
end
else
showMaxChapterId=showChapterId
end

if showMaxChapterId<1 then
showMaxChapterId=1
end

for i,cfg in ipairs(targetList)do
local chapterId=cfg.chapterId
local levelIdx=cfg.levelIdx
local rewardIdx=cfg.rewardIdx
local weight=i
local state=-1


local isGot=xunBaoShiLianModel:checkTargetIsGot(self.modeId,chapterId,rewardIdx)
if chapterId<=showMaxChapterId then

if isGot then

state=1
weight=weight+1000
elseif chapterId<clearChapterId or(chapterId==clearChapterId and levelIdx<=clearLevelIdx)then

state=0
weight=weight-1000
end


local item={
cfg=cfg,
state=state,
weight=weight,
}
sortList[#sortList+1]=item
end
end

table.sort(sortList,function(a,b)
return a.weight<b.weight
end)
return sortList
end




function UIXBSL_targetWin:onReceiveBtn()
self:receiveAll()
end

function UIXBSL_targetWin:receiveAll()
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(self.modeId)
local targetCfg=xunBaoShiLianModel:getTargetCfgByModeId(self.modeId)
local targetList=targetCfg.targetList or{}
local clearKey=clearChapterId*100+clearLevelIdx
local maxGetKey
local maxGetRewardIdx
for i,cfg in ipairs(targetList)do
local chapterId=cfg.chapterId
local levelIdx=cfg.levelIdx
local rewardIdx=cfg.rewardIdx
local key=chapterId*100+levelIdx
if clearKey>=key then


local isGot=xunBaoShiLianModel:checkTargetIsGot(self.modeId,chapterId,rewardIdx)
if not isGot then
if not maxGetKey or key>maxGetKey then
maxGetKey=key
maxGetRewardIdx=rewardIdx
end
end
end
end

if maxGetKey then
local maxGetChapterId=math.floor(maxGetKey/100)

xunBaoShiLianController:reqGetTargetReward(self.modeId,maxGetChapterId,maxGetRewardIdx)
end
end

function UIXBSL_targetWin:onCloseBtn()
self:closeSelf()
end

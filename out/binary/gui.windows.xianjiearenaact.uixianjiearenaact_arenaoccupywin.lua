







def_class("UIXianJieArenaAct_arenaOccupyWin",UIWindowBase)









function UIXianJieArenaAct_arenaOccupyWin:bindComponents()

self.root=UIObject.get(self,0)
self.rankPanel=UIObject.get(self,1)
self.rankScrollView=UIObject.get(self,2)
self.noRankTips=UIObject.get(self,3)
self.arenaItemGroup=UIObject.get(self,4)
self.titleName=UIText.get(self,5)



end


function UIXianJieArenaAct_arenaOccupyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.noRankTips);self.noRankTips=nil;
_UIObject_release(self.arenaItemGroup);self.arenaItemGroup=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end
















local _this
local allArenaIndexList={
[1]=xjClientBuildType.flcbLeiTai6,
[2]=xjClientBuildType.flcbLeiTai4,
[3]=xjClientBuildType.flcbLeiTai2,
[4]=xjClientBuildType.flcbLeiTai7,
[5]=xjClientBuildType.flcbLeiTai8,
[6]=xjClientBuildType.flcbLeiTai1,
[7]=xjClientBuildType.flcbLeiTai3,
[8]=xjClientBuildType.flcbLeiTai5,
}

local arenaItemCmpIndex={
selectBg=0,
bdModel=1,
nameBg=2,
name=3,
arrow=4,
clickMask=5,
reddot=6,
numberBg=7,
numberText=8,
}

local rankItemCmpIndex={
rankNum=0,
xyName=1,
timeText=2,
}



function UIXianJieArenaAct_arenaOccupyWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJieArenaAct_arenaOccupyWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJieArenaAct_arenaOccupyWin:onShow(argtable,afterOnloaded)
self.selectArenaId=argtable and argtable.arenaId
if not self.selectArenaId then
self.selectArenaId=self:getDefaultSelectArenaId()
end

if argtable and argtable.isAutoOpen then
UIManager:invokeUIMethod("UIXianJieArenaAct_rankBgWin","changeExtraArgs",nil)

local winShowFlag=xianJieArenaActModel:getArenaRewardWinShowFlag()
if winShowFlag==0 then

xianJieArenaActController:reqGetXJArenaSetRewardWinShowFlag(1)
end
end


xianJieArenaActController:reqGetXJArenaActData()

self:refresh(true)
end

function UIXianJieArenaAct_arenaOccupyWin:onShowArgRecv(argtable,afterOnloaded)
self:refresh()
end


function UIXianJieArenaAct_arenaOccupyWin:onHide()

end

function UIXianJieArenaAct_arenaOccupyWin:refresh(isInit)

self.needGotRewardArenaList={}
local grids=self.arenaItemGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local arenaId=allArenaIndexList[i]
local widget=grids[i-1]
if arenaId then
widget:SetChildActive(-1,true)
local isArenaOpen=xianJieArenaActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if isArenaOpen then
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
if cfg then















local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local sceneIdx=arenaData.sceneidx
local name

local hasOccupy=sceneIdx and sceneIdx~=0 or nil
if hasOccupy then
name=xianjieController:getCrossServerNamebySCidx(sceneIdx)
local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=occupyServerId==cross_sid
if isSelfXianYu then
name=FMT.fmt("<color=#2be71d>{0}</color>",name)
end
else
name="暂无归属"
end
widget:SetChildText(arenaItemCmpIndex.name,name)
widget:SetChildActive(arenaItemCmpIndex.nameBg,isArenaOpen)


local number=cfg.clientParam.number
widget:SetChildText(arenaItemCmpIndex.numberText,number)

if isInit then

widget:SetChildActive(arenaItemCmpIndex.clickMask,isArenaOpen)
if isArenaOpen then
widget:SetChildButtonClick(arenaItemCmpIndex.clickMask,function()
if not _this then return end
return self:onArenaItemClick(arenaId)
end,true)
end
end
end


local isSelect=arenaId==self.selectArenaId
widget:SetChildActive(arenaItemCmpIndex.selectBg,isSelect)
widget:SetChildActive(arenaItemCmpIndex.arrow,isSelect)


local gotFlag=xianJieArenaActModel:getArenaRewardGotFlag()
local cross_sid=loginModel:getCrossServerId()
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local isSelfXianYu=occupyServerId==cross_sid
local isReddot=gotFlag==0 and isSelfXianYu
widget:SetChildActive(arenaItemCmpIndex.reddot,isReddot)
if isReddot then
self.needGotRewardArenaList[arenaId]=true
end
else
widget:SetChildActive(-1,false)
end
else
widget:SetChildActive(-1,false)
end
end


self:refreshRankPanel(isInit)


local actCfg=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eLeiTaiYanWu)
local actName=actCfg and actCfg.name or""
self.titleName:setText(actName)


self:checkEmptyOccupyPrint()
end

function UIXianJieArenaAct_arenaOccupyWin:getDefaultSelectArenaId()
local lastSelectArenaId=xianJieArenaActModel:getLastSelectArenaId()
if lastSelectArenaId then
return lastSelectArenaId
end

local openArenaList=xianJieArenaActModel:getArenaBuildList()or{}
local maxArenaId
for i,v in pairs(openArenaList)do
if not maxArenaId or v.buildId>maxArenaId then
maxArenaId=v.buildId
end
end

return maxArenaId
end

function UIXianJieArenaAct_arenaOccupyWin:selectArena(arenaId)
if not arenaId or self.selectArenaId==arenaId then
return
end
self.selectArenaId=arenaId
xianJieArenaActModel:setLastSelectArenaId(arenaId)
self:refresh()
end

function UIXianJieArenaAct_arenaOccupyWin:refreshRankPanel(isReset)

local occupySortList=self:getArenaOccupySortList(self.selectArenaId,isReset)
local count=#occupySortList
self.rankScrollView:setChildScrollViewCreateGrids(count,1)

local arenaData=xianJieArenaActModel:getArenaBuildData(self.selectArenaId)or{}
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx

local girds=self.rankScrollView:getChildScrollViewItemWidgets()
local rankNum=0
local overLimitList=xianJieArenaActModel:getArenaBuildServerOverLimitOccupyList()
local arenaSortId=xianJieArenaActModel:getArenaBuildSortId(self.selectArenaId)
for i=1,girds.Count do
local widget=girds[i-1]
local data=occupySortList[i]
local occupyTime=data and data.occupyTime or 0
local serverId=data and data.serverId
local sceneIdx=data and data.sceneIdx
local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=serverId==cross_sid
local isValid=true

if overLimitList[serverId]then

local validSortId=overLimitList[serverId]
if arenaSortId>validSortId then
isValid=false
end
end
if isValid then
rankNum=rankNum+1
end


local numStr
if isValid then
numStr=tostring(rankNum)
else
numStr="上限"
end


local xyNameStr=xianjieController:getCrossServerNamebySCidx(sceneIdx)


local timeStr=timeHelper.format_time_stamp3(occupyTime)

if isSelfXianYu then
numStr=FMT.cfmt(FONT_COLOR.eGreenColor,numStr)
xyNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,xyNameStr)
timeStr=FMT.cfmt(FONT_COLOR.eGreenColor,timeStr)
end
widget:SetChildText(rankItemCmpIndex.rankNum,numStr)
widget:SetChildText(rankItemCmpIndex.xyName,xyNameStr)
widget:SetChildText(rankItemCmpIndex.timeText,timeStr)
end
self.noRankTips:setActive(count<=0)
end

function UIXianJieArenaAct_arenaOccupyWin:getArenaOccupySortList(arenaId,isReset)
if not isReset and self.arenaOccupySortList and self.arenaOccupySortList[arenaId]and next(self.arenaOccupySortList[arenaId])then
return self.arenaOccupySortList[arenaId]
end

if isReset or not self.arenaOccupySortList then
self.arenaOccupySortList={}
end

local sortList={}
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
if arenaData.occupyHis then
for i,v in ipairs(arenaData.occupyHis)do
local serverId=v.param_1
local occupyTime=v.param_2
local sceneIdx=v.param_3
sortList[#sortList+1]={
serverId=serverId,
occupyTime=occupyTime,
sceneIdx=sceneIdx,
}
end
end
table.sort(sortList,function(a,b)
return a.occupyTime>b.occupyTime
end)

self.arenaOccupySortList[arenaId]=sortList
return self.arenaOccupySortList[arenaId]
end


function UIXianJieArenaAct_arenaOccupyWin:checkEmptyOccupyPrint()
local isAllEmpty=true
local printList={}
for i=1,#allArenaIndexList do
local arenaId=allArenaIndexList[i]
local isArenaOpen=xianJieArenaActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if isArenaOpen then
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local sceneIdx=arenaData.sceneidx
local hasOccupy=sceneIdx and sceneIdx~=0 or nil
if hasOccupy then
isAllEmpty=false
break
else
printList[#printList+1]=arenaData
end
end
end

if isAllEmpty then

local str=serializeHelper.serialize(printList)
platformSDK.printSDK("UIXianJieArenaAct_arenaOccupyWin 擂台结算空占用打印:",str)

end
end


function UIXianJieArenaAct_arenaOccupyWin:onArenaItemClick(arenaId)

if self.needGotRewardArenaList[arenaId]then
local isCanGet=xianJieArenaActModel:checkIsCanGetArenaReward()
if isCanGet then

xianJieArenaActController:reqGetXJArenaActOccupyReward()
end
end


self:selectArena(arenaId)
end


function UIXianJieArenaAct_arenaOccupyWin:test_occupyPrint()
local printList={}
for i=1,#allArenaIndexList do
local arenaId=allArenaIndexList[i]
local isArenaOpen=xianJieArenaActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if isArenaOpen then
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
printList[#printList+1]=arenaData
end
end


local str=serializeHelper.serialize(printList)

end

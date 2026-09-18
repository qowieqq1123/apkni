







def_class("UIXianJieArenaAct_ovArenaWin",UIWindowBase)









function UIXianJieArenaAct_ovArenaWin:bindComponents()

self.root=UIObject.get(self,0)
self.rankPanel=UIObject.get(self,1)
self.rankScrollView=UIObject.get(self,2)
self.noRankTips=UIObject.get(self,3)
self.arenaItemGroup=UIObject.get(self,4)
self.xyName=UIText.get(self,5)
self.infoBtn=UIButton.get(self,6)
self.gotoBtn=UIButton.get(self,7)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIXianJieArenaAct_ovArenaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.noRankTips);self.noRankTips=nil;
_UIObject_release(self.arenaItemGroup);self.arenaItemGroup=nil;
_UIObject_release(self.xyName);self.xyName=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
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
numberBg=6,
numberText=7,
}

local rankItemCmpIndex={
rankNum=0,
xyName=1,
timeText=2,
}



function UIXianJieArenaAct_ovArenaWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJieArenaAct_ovArenaWin:__delete()
self:clearUpdateTimer()
_this=nil
self:unbindComponents()
end




function UIXianJieArenaAct_ovArenaWin:onShow(argtable,afterOnloaded)
self.selectArenaId=argtable and argtable.arenaId
self.page=argtable and argtable.page
self.parentWin=argtable and argtable.parentWin
if not self.selectArenaId then
self.selectArenaId=self:getDefaultSelectArenaId()
end

self:refresh(true)
end

function UIXianJieArenaAct_ovArenaWin:onShowArgRecv(argtable,afterOnloaded)
self:refresh()
end


function UIXianJieArenaAct_ovArenaWin:onHide()
self:clearUpdateTimer()
end

function UIXianJieArenaAct_ovArenaWin:refresh(isInit,isResetRank)
self:clearUpdateTimer()

local grids=self.arenaItemGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local arenaId=allArenaIndexList[i]
local widget=grids[i-1]
if arenaId then
local isArenaOpen=xianJieArenaActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if isArenaOpen then
widget:SetChildActive(-1,true)
if isInit then
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
if cfg then















local number=cfg.clientParam.number
widget:SetChildText(arenaItemCmpIndex.numberText,number)


widget:SetChildActive(arenaItemCmpIndex.clickMask,isArenaOpen)
if isArenaOpen then
widget:SetChildButtonClick(arenaItemCmpIndex.clickMask,function()
if not _this then return end
return self:selectArena(arenaId)
end,true)
end
end
end


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


local isSelect=arenaId==self.selectArenaId
widget:SetChildActive(arenaItemCmpIndex.selectBg,isSelect)
widget:SetChildActive(arenaItemCmpIndex.arrow,isSelect)
else
widget:SetChildActive(-1,false)
end
else
widget:SetChildActive(-1,false)
end
end


self:refreshRankPanel(isInit or isResetRank)


local arenaData=xianJieArenaActModel:getArenaBuildData(self.selectArenaId)or{}
local occupyServerId=arenaData.occupyServerId
local sceneIdx=arenaData.sceneidx

local hasOccupyXy=sceneIdx and sceneIdx~=0
local xyName="无"
if hasOccupyXy then

xyName=xianjieController:getCrossServerNamebySCidx(sceneIdx)
end
self.xyName:setText(FMT.fmt("当前归属仙域：<color=#ca631d>{0}</color>",xyName))

if hasOccupyXy then
self:setUpdateTimer()
end


self:checkEmptyOccupyPrint()
end

function UIXianJieArenaAct_ovArenaWin:getDefaultSelectArenaId()
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

function UIXianJieArenaAct_ovArenaWin:selectArena(arenaId)
if not arenaId or self.selectArenaId==arenaId then
return
end
self.selectArenaId=arenaId
xianJieArenaActModel:setLastSelectArenaId(arenaId)
self:refresh()
end

function UIXianJieArenaAct_ovArenaWin:refreshRankPanel(isReset)

local occupySortListData=self:getArenaOccupySortListData(self.selectArenaId,isReset)or{}
local occupySortList=occupySortListData.sortList or{}
local selfOccupyData=occupySortListData.selfOccupyData
local arenaData=xianJieArenaActModel:getArenaBuildData(self.selectArenaId)or{}
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupyXy=occupyServerId and occupyServerId~=0
local count=#occupySortList
local nowOccupyXyTime=0
local isSetNowOccupyXy=false
if hasOccupyXy then
count=count+1
local occupyStartTime=arenaData.occupyStartTime or 0
if occupyStartTime>0 then
local nowTime=timeHelper.getServerShortTime()
nowOccupyXyTime=nowTime-occupyStartTime
end

local occupiedTime=selfOccupyData and selfOccupyData.occupyTime or 0
nowOccupyXyTime=nowOccupyXyTime+occupiedTime
end
self.rankScrollView:setChildScrollViewCreateGrids(count,1)
local girds=self.rankScrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local dataIndex=isSetNowOccupyXy and i-1 or i
local data=occupySortList[dataIndex]
local occupyTime=data and data.occupyTime or 0
local serverId=data and data.serverId
local sceneIdx=data and data.sceneIdx
local isNowOccupyXy=false
if not isSetNowOccupyXy and nowOccupyXyTime>occupyTime then
occupyTime=nowOccupyXyTime
serverId=occupyServerId
sceneIdx=occupySceneIdx
isNowOccupyXy=true
isSetNowOccupyXy=true
end
local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=serverId==cross_sid


local numStr=tostring(i)



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

function UIXianJieArenaAct_ovArenaWin:getArenaOccupySortListData(arenaId,isReset)
if not isReset and self.arenaOccupySortList and self.arenaOccupySortList[arenaId]and next(self.arenaOccupySortList[arenaId])then
return self.arenaOccupySortList[arenaId]
end

if isReset or not self.arenaOccupySortList then
self.arenaOccupySortList={}
end

local sortList={}
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local selfOccupyData
if arenaData.occupyHis then
local occupyNowServerId=arenaData.occupyServerId
for i,v in ipairs(arenaData.occupyHis)do
local serverId=v.param_1
local occupyTime=v.param_2
local sceneIdx=v.param_3
local occupyData={
serverId=serverId,
occupyTime=occupyTime,
sceneIdx=sceneIdx,
}
if serverId~=occupyNowServerId then
sortList[#sortList+1]=occupyData
else
selfOccupyData=occupyData
end
end
end
table.sort(sortList,function(a,b)
return a.occupyTime>b.occupyTime
end)

self.arenaOccupySortList[arenaId]={sortList=sortList,selfOccupyData=selfOccupyData}
return self.arenaOccupySortList[arenaId]
end

function UIXianJieArenaAct_ovArenaWin:setUpdateTimer()
self:clearUpdateTimer()
if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
if not _this then
return
end
return self:refreshRankPanel()
end)
end
end

function UIXianJieArenaAct_ovArenaWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end


function UIXianJieArenaAct_ovArenaWin:checkEmptyOccupyPrint()
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
platformSDK.printSDK("UIXianJieArenaAct_ovArenaWin 擂台战况空占用打印:",str)

end
end


function UIXianJieArenaAct_ovArenaWin:onInfoBtn()

local arenaId=self.selectArenaId
xianjieController:openArenaInfoWin(arenaId,2,{isFromOvArenaWin=true})


UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end

function UIXianJieArenaAct_ovArenaWin:onGotoBtn()

local arenaId=self.selectArenaId

local openWinFunc=function()
return xianjieController:openArenaInfoWin(arenaId)
end

local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaData then
UIManager.error("找不到目标擂台")
return
end
local sceneidx=arenaData.sceneidx
local gridX_c=arenaData.gridX_c
local gridZ_c=arenaData.gridZ_c
xianjieController:jumpGrid(sceneidx,gridX_c,gridZ_c,openWinFunc,nil)


UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end

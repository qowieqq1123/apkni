







def_class("UIMoGongZhengDuoAct_OccupyWin",UIWindowBase)









function UIMoGongZhengDuoAct_OccupyWin:bindComponents()

self.arenaItem=UIObject.get(self,0)
self.belongName=UIText.get(self,1)
self.menuGridPanel=UIObject.get(self,2)
self.noRankTips=UIObject.get(self,3)
self.noTeamTips=UIObject.get(self,4)
self.rankPanel=UIObject.get(self,5)
self.rankScrollView=UIObject.get(self,6)
self.rewardBtn=UIButton.get(self,7)
self.root=UIObject.get(self,8)
self.teamPanel=UIObject.get(self,9)
self.teamScrollView=UIObject.get(self,10)
self.titleName=UIText.get(self,11)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIMoGongZhengDuoAct_OccupyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arenaItem);self.arenaItem=nil;
_UIObject_release(self.belongName);self.belongName=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.noRankTips);self.noRankTips=nil;
_UIObject_release(self.noTeamTips);self.noTeamTips=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.teamPanel);self.teamPanel=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end


















local _this

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


function UIMoGongZhengDuoAct_OccupyWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMoGongZhengDuoAct_OccupyWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoGongZhengDuoAct_OccupyWin:onShow(argtable,afterOnloaded)
self.selectArenaId=xjClientBuildType.flcbMoGong1

if argtable and argtable.isAutoOpen then
UIManager:invokeUIMethod("UIMoGongZhengDuoAct_rankBgWin","changeExtraArgs",nil)

local winShowFlag=moGongZhengDuoActModel:getArenaRewardWinShowFlag()
if winShowFlag==0 then

moGongZhengDuoActController:reqMoGongSetRewardWinShowFlag(1)
end
end


moGongZhengDuoActController:reqMoGongActData()

self:refresh(true)
end


function UIMoGongZhengDuoAct_OccupyWin:onHide()

end

function UIMoGongZhengDuoAct_OccupyWin:onShowArgRecv(argtable,afterOnloaded)
self:refresh()
end

function UIMoGongZhengDuoAct_OccupyWin:refresh(isInit)

self.needGotRewardArenaList={}

local arenaId=xjClientBuildType.flcbMoGong1

local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
if cfg then

local arenaData=moGongZhengDuoActModel:getArenaBuildData(arenaId)or defaultT
local xmGuid=arenaData.xmGuid
local name=FMT.fmt("当前所属：{0}",arenaData.xmName)
local isReddot=false
local hasOccupy=mathHelper.validInt64(xmGuid)
if hasOccupy then
local isSelf=xianmengModel:compareTwoGuildID(xmGuid,xianmengModel:myXMGuildID())
if isSelf then
name=FMT.fmt("<color=#2be71d>{0}</color>",name)
end

local gotFlag=moGongZhengDuoActModel:getArenaRewardGotFlag()
isReddot=gotFlag==0 and isSelf
else
name="暂无归属"
end

self.belongName:setText(name)

if isReddot then
self.needGotRewardArenaList[arenaId]=true
end
end



self:refreshRankPanel(isInit)


local actCfg=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eMoGongZhengDuo)
local actName=actCfg and actCfg.name or""
self.titleName:setText(actName)


self:checkEmptyOccupyPrint()
end

function UIMoGongZhengDuoAct_OccupyWin:refreshRankPanel(isReset)

local now=timeHelper.getServerShortTime()
local occupySortList=self:getArenaOccupySortList(self.selectArenaId,isReset)

local count=#occupySortList
self.rankScrollView:setChildScrollViewCreateGrids(count,1)
local girds=self.rankScrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local data=occupySortList[i]
local occupyTime=data and data.occupyTime or 0
local xmGuid=data and data.xmGuid

local isSelf=xianmengModel:compareTwoGuildID(xmGuid,xianmengModel:myXMGuildID())


local numStr=tostring(i)


local xmNameStr=data.xmName


local timeStr=timeHelper.format_time_stamp3(occupyTime)

if isSelf then
numStr=FMT.cfmt(FONT_COLOR.eGreenColor,numStr)
xmNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,xmNameStr)
timeStr=FMT.cfmt(FONT_COLOR.eGreenColor,timeStr)
end
widget:SetChildText(rankItemCmpIndex.rankNum,numStr)
widget:SetChildText(rankItemCmpIndex.xyName,xmNameStr)
widget:SetChildText(rankItemCmpIndex.timeText,timeStr)
end
self.noRankTips:setActive(count<=0)
end

function UIMoGongZhengDuoAct_OccupyWin:getArenaOccupySortList(arenaId,isReset)
if not isReset and self.arenaOccupySortList and self.arenaOccupySortList[arenaId]and next(self.arenaOccupySortList[arenaId])then
return self.arenaOccupySortList[arenaId]
end

if isReset or not self.arenaOccupySortList then
self.arenaOccupySortList={}
end

local sortList={}
local arenaData=moGongZhengDuoActModel:getArenaBuildData(arenaId)or{}

if arenaData.occupyHis then
for i,v in ipairs(arenaData.occupyHis)do
sortList[#sortList+1]=v
end
end
table.sort(sortList,function(a,b)
return a.occupyTime>b.occupyTime
end)

self.arenaOccupySortList[arenaId]=sortList
return self.arenaOccupySortList[arenaId]
end


function UIMoGongZhengDuoAct_OccupyWin:checkEmptyOccupyPrint()
local isAllEmpty=true
local printList={}

local arenaId=xjClientBuildType.flcbMoGong1
local isArenaOpen=moGongZhengDuoActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if isArenaOpen then
local arenaData=moGongZhengDuoActModel:getArenaBuildData(arenaId)or{}
local xmGuid=arenaData.xmGuid
local hasOccupy=mathHelper.validInt64(xmGuid)
if hasOccupy then
isAllEmpty=false
else
printList[#printList+1]=arenaData
end
end

if isAllEmpty then

local str=serializeHelper.serialize(printList)
platformSDK.printSDK("UIMoGongZhengDuoAct_OccupyWin 魔宫结算空占用打印:",str)

end
end



function UIMoGongZhengDuoAct_OccupyWin:onRewardBtn()
if self.needGotRewardArenaList[xjClientBuildType.flcbMoGong1]then
local isCanGet=moGongZhengDuoActModel:checkIsCanGetArenaReward()
if isCanGet then

moGongZhengDuoActController:reqMoGongActOccupyReward()
end
end
end


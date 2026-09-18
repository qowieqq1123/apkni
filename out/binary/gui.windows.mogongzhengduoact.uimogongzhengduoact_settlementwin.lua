







def_class("UIMoGongZhengDuoAct_SettlementWin",UIWindowBase)









function UIMoGongZhengDuoAct_SettlementWin:bindComponents()

self.belong=UIText.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.centerLayout=UIObject.get(self,2)
self.mogongBuildModel=UIObject.get(self,3)
self.rankScrollview=UIScrollView.get(self,4)
self.rewardBtn=UIButton.get(self,5)
self.rightPart=UIObject.get(self,6)
self.Root=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIMoGongZhengDuoAct_SettlementWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.belong);self.belong=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.mogongBuildModel);self.mogongBuildModel=nil;
_UIObject_release(self.rankScrollview);self.rankScrollview=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rightPart);self.rightPart=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local rankItemCmpIndex={
rankNum=0,
xyName=1,
timeText=2,
}




function UIMoGongZhengDuoAct_SettlementWin:onLoaded(...)
self:bindComponents()

_this=self

local _bindScrollView=function(index,item)
if _this==nil then return end

_this:bindScrollWidget(index,item)
end
self.rankScrollview:bindScrollWidget(_bindScrollView)


moGongZhengDuoActController:reqMoGongActData()
end


function UIMoGongZhengDuoAct_SettlementWin:__delete()
_this=nil
moGongZhengDuoActController:reqMoGongSetRewardWinShowFlag(1)
self:unbindComponents()
end




function UIMoGongZhengDuoAct_SettlementWin:onShow(argtable,afterOnloaded)

self.buildID=xjClientBuildType.flcbMoGong1

self:refreshAll(true)
end


function UIMoGongZhengDuoAct_SettlementWin:onHide()

end

function UIMoGongZhengDuoAct_SettlementWin:refreshAll(isInit)
self:refreshBuildInfo(isInit)
self:refreshRankScrollView(isInit)
end

function UIMoGongZhengDuoAct_SettlementWin:refreshBuildInfo(isInit)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.buildID)
if cfg then

local param=cfg.clientParam
local modelId=param.model
local scale=0.7
local offset={0,30}



local buildData=moGongZhengDuoActModel:getArenaBuildData(self.buildID)or{}
local xyNameStr="无"
local hasOccupy=buildData and buildData.xmGuidStr~="0"or nil
if hasOccupy then
local xmGuid=xianmengModel:myXMGuildID()
local isSelf=xianmengModel:compareTwoGuildID(xmGuid,buildData.xmGuid)
local color="#ff3636"
if isSelf then
color="#00ba27"
end
xyNameStr=toColorStringX(color,buildData.xmName)
end
self.belong:setText(FMT.fmt("归属：{0}",xyNameStr))
end

local isCanGet=moGongZhengDuoActModel:checkIsCanGetArenaReward()
local isGot=moGongZhengDuoActModel:getArenaRewardGotFlag()==1
self.rewardBtn:setActive(isCanGet and not isGot)
end

function UIMoGongZhengDuoAct_SettlementWin:refreshRankScrollView(isReset)
self.occupySortList=self:getArenaOccupySortList(self.buildID,isReset)

local count=#self.occupySortList
self.rankScrollview:freshGridsNum(count,count,1,self.zero_sc)
self.zero_sc=true
end

function UIMoGongZhengDuoAct_SettlementWin:bindScrollWidget(index,item)
local widget=item
local data=self.occupySortList[index]

local isShow=data~=nil
widget:SetChildActive(-1,isShow)
if not isShow then return end

local occupyTime=data and data.occupyTime or 0
local xmGuid=data and data.xmGuid

local isSelf=xianmengModel:compareTwoGuildID(xmGuid,xianmengModel:myXMGuildID())


local numStr=tostring(index)


local xmNameStr=data.xmName


local timeStr=timeHelper.format_time_stamp3(occupyTime)

if isSelf then
numStr=toColorStringX("#aae252",numStr)
xmNameStr=toColorStringX("#aae252",xmNameStr)
timeStr=toColorStringX("#aae252",timeStr)
end
widget:SetChildText(rankItemCmpIndex.rankNum,numStr)
widget:SetChildText(rankItemCmpIndex.xyName,xmNameStr)
widget:SetChildText(rankItemCmpIndex.timeText,timeStr)
end

function UIMoGongZhengDuoAct_SettlementWin:getArenaOccupySortList(arenaId,isReset)
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

function UIMoGongZhengDuoAct_SettlementWin:onRewardBtn()
local isCanGet=moGongZhengDuoActModel:checkIsCanGetArenaReward()
if isCanGet then

moGongZhengDuoActController:reqMoGongActOccupyReward()
end
end



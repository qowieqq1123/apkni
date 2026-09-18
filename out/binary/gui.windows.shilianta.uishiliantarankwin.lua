







def_class("UIShiLianTaRankWin",UIWindowBase)









function UIShiLianTaRankWin:bindComponents()

self.title=UIText.get(self,0)
self.name=UIText.get(self,1)
self.rank=UIText.get(self,2)
self.layer=UIText.get(self,3)
self.icon=UIObject.get(self,4)
self.rankList=UILoopListView.new(self,5)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIShiLianTaRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.icon);self.icon=nil;
self.rankList:deleteSelf();self.rankList=nil;
end


















local ItemCmpIndex=
{
icon=0,
name=1,
layer=2,
rank=3,
bg=4,
rankBg=5,
rankBg21=6,
rankBg22=7,

headList=8,
}

local imageAb="ui/windows/shilianta/sharedtextures/shiliantasprite.ab"

local rankBgName=
{
"image_bmdk_1",
"image_bmdk_2",
"image_bmdk_3"
}

local rankBg2Name=
{
"frame_paimingkuang_1",
"frame_paimingkuang_2",
"frame_paimingkuang_3"
}



function UIShiLianTaRankWin:onLoaded(...)
self:bindComponents()













end


function UIShiLianTaRankWin:__delete()
self:unbindComponents()
end




function UIShiLianTaRankWin:onShow(argtable,afterOnloaded)
shiLianTaController.req_13_5()


end


function UIShiLianTaRankWin:onHide()
self.rankList:setActive(false)
end

function UIShiLianTaRankWin:refreshRankList()
local rankList=shiLianTaModel:getRankData()
local rankCount=#rankList
if rankCount>0 then
self.rankList:setActive(true)
local createCount=rankCount
local soloRankNum=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,'soloRankNum')
if soloRankNum and rankCount>soloRankNum then
local rankShowRangeList=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,'rankShowRange')or{}
local rangeShowIndex=0
for i=1,#rankShowRangeList do
rangeShowIndex=i
local range=rankShowRangeList[i]
if rankCount<=range[2]then
break
end
end
createCount=soloRankNum+rangeShowIndex
end
self.soloRankNum=soloRankNum










local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.rankList:initData('item',createList)
else
self.rankList:setActive(false)
end
end

function UIShiLianTaRankWin:onFreshAction(i,grid)
local rankList=shiLianTaModel:getRankData()
local soloRankNum=self.soloRankNum
local isRangeShow=soloRankNum and i>soloRankNum or false

if not isRangeShow then

local info=rankList[i]
if grid then
if info.rank==1 then
grid:SetChildActive(ItemCmpIndex.rankBg21,true)
grid:SetChildActive(ItemCmpIndex.rankBg22,true)
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg,imageAb,rankBgName[1])
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg21,imageAb,rankBg2Name[1])
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg22,imageAb,rankBg2Name[1])
grid:SetChildActive(ItemCmpIndex.rankBg,true)
elseif info.rank==2 then
grid:SetChildActive(ItemCmpIndex.rankBg21,true)
grid:SetChildActive(ItemCmpIndex.rankBg22,true)
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg,imageAb,rankBgName[2])
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg21,imageAb,rankBg2Name[2])
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg22,imageAb,rankBg2Name[2])
grid:SetChildActive(ItemCmpIndex.rankBg,true)
elseif info.rank==3 then
grid:SetChildActive(ItemCmpIndex.rankBg21,true)
grid:SetChildActive(ItemCmpIndex.rankBg22,true)
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg,imageAb,rankBgName[3])
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg21,imageAb,rankBg2Name[3])
grid:SetChildCSImageSprite(ItemCmpIndex.rankBg22,imageAb,rankBg2Name[3])
grid:SetChildActive(ItemCmpIndex.rankBg,true)
else
grid:SetChildActive(ItemCmpIndex.rankBg21,false)
grid:SetChildActive(ItemCmpIndex.rankBg22,false)
grid:SetChildActive(ItemCmpIndex.rankBg,false)
end

playerController:setHeadIcon(grid,ItemCmpIndex.icon,{scale=0.5,iconInfo=info.iconInfo})

grid:SetChildText(ItemCmpIndex.rank,info.rank)
grid:SetChildText(ItemCmpIndex.name,playerModel:getOtherActorName(info.name))
grid:SetChildText(ItemCmpIndex.layer,FMT.fmt("{0}层",info.layer))


grid:SetChildActive(ItemCmpIndex.name,true)
grid:SetChildActive(ItemCmpIndex.layer,true)
grid:SetChildActive(ItemCmpIndex.icon,true)
grid:SetChildActive(ItemCmpIndex.headList,false)
grid:SetChildActive(9,true)
grid:SetChildButtonClick(9,function()
otherPlayerController:openOtherPlayerInfoWin(info.actorId,nil,actorInterFromType.eSuoYaoTa)
end)
end
else
local rankCount=#rankList

grid:SetChildActive(ItemCmpIndex.rankBg21,false)
grid:SetChildActive(ItemCmpIndex.rankBg22,false)
grid:SetChildActive(ItemCmpIndex.rankBg,false)
grid:SetChildActive(ItemCmpIndex.name,false)
grid:SetChildActive(ItemCmpIndex.layer,false)
grid:SetChildActive(ItemCmpIndex.icon,false)
grid:SetChildActive(ItemCmpIndex.headList,true)
grid:SetChildActive(9,false)

local rankShowRangeList=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,'rankShowRange')or{}
local rangeIndex=i-soloRankNum
local range=rankShowRangeList[rangeIndex]
local range_s=range[1]
local range_e=range[2]
grid:SetChildText(ItemCmpIndex.rank,FMT.fmt("{0}~{1}",range_s,range_e))

local showHeadRankNum_e=rankCount<range_e and rankCount or range_e
local showCount=showHeadRankNum_e-range_s+1
if showCount>4 then
showCount=4
end
grid:SetChildLayoutGroupCreateItems(ItemCmpIndex.headList,showCount)
local headGrids=grid:GetChildLayoutGroupGridList(ItemCmpIndex.headList)
for i=1,headGrids.Count do
local widget=headGrids[i-1]
local rankIndex=i+range_s-1
local rankInfo=rankList[rankIndex]
if rankInfo then
local actorId=rankInfo.actorId
playerController:setHeadIcon(widget,0,{scale=0.5,iconInfo=rankInfo.iconInfo})
widget:SetChildButtonClick(1,function(...)
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,actorInterFromType.eSuoYaoTa)
end)
else
widget:SetChildActive(-1,false)
end
end
end
end

function UIShiLianTaRankWin:onStartAction()

end

function UIShiLianTaRankWin:refreshMyRank()
local myRankData=shiLianTaModel:getMyRank()
local clearLayer=shiLianTaModel:getCurLayer()
local myName=playerModel:getActorName()
self.name:setText(myName)
playerController:setHeadIcon(self.winid,self.icon:getID(),{scale=0.5})

local isClearAll=shiLianTaModel:isClearAll()
self.layer:setText(FMT.fmt("{0}层",isClearAll and clearLayer or clearLayer-1))
self.rank:setText(myRankData and FMT.fmt("第{0}名",myRankData.rank)or"未上榜")
end




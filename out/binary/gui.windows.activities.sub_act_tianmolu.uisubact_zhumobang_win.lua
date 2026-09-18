







def_class("UISubAct_zhumobang_win",UIWindowBase)









function UISubAct_zhumobang_win:bindComponents()

self.time=UIText.get(self,0)
self.nohaveReward=UIText.get(self,1)
self.myRankItem=UIObject.get(self,2)
self.scrollerView=UIScrollViewSlow.get(self,3)
self.panelText=UIText.get(self,4)
self.noHaveRankList=UIObject.get(self,5)
self.help=UIButton.get(self,6)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,7)

self.help:setButtonClick(function()self:onHelp()end)



end


function UISubAct_zhumobang_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.nohaveReward);self.nohaveReward=nil;
_UIObject_release(self.myRankItem);self.myRankItem=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.panelText);self.panelText=nil;
_UIObject_release(self.noHaveRankList);self.noHaveRankList=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
end















local _this=nil
local _rankCmp={
rankImg=0,
rank=1,
name=2,
havepeople=3,
itemList=4,
score=5,
bg_3=6,
bg_4=7,
bg_6=8,
iconHeadItem={9,10,11,12},
noHeadKuang={13,14,15,16},
}



local UIPrepareEnScroller=simple_class(UIEnhancedScroller)
function UISubAct_zhumobang_win:onLoaded(...)
self:bindComponents()
_this=self






self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
end


function UISubAct_zhumobang_win:__delete()
self:unbindComponents()
_this=nil
end

function UISubAct_zhumobang_win:onHelp()






if not self.helpPos then
self.helpPos=self.help:getChildAnchoredPosition()
end

local contentStr='诛魔功勋可通过<color=#CA971D>挑战天魔</color>\n或<color=#CA971D>天魔排名</color>奖励获得'








local pos=Vector2.New(-16.5,-20)
self:showWindow('UIConditionTipsOne',{showType=3,str=contentStr,posWidget=self.help:getChildWidgetBase(),pos=pos})
end




function UISubAct_zhumobang_win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eRankAct1
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.beginTime=self.info.start_time
self.endTime=self.info.end_time
self:onRankList(true)

self:setRemainingTimeTimer()
end


function UISubAct_zhumobang_win:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

self.reqTime=self.reqTime or 55
self.reqTime=self.reqTime+1
if self.reqTime>=60 then
activitiesController:sendProtocol(actSendType.eComonReqInfo,self.actid,self.subType,self.subid)
self.reqTime=0
end
else
self.time:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_zhumobang_win:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_zhumobang_win:onRankList(fresh)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local rankList=data.rankList

local maxNum=self.config.rankNum or 50
local zhumobangData={}
if rankList then
local playerId=playerModel:getActorID()
local playerRankData=nil
local playerRank=nil
for i,v in ipairs(rankList)do
if mathHelper.compareInt64(playerId,v.actorid)then
playerRankData=v
playerRank=i
end
table.insert(zhumobangData,v)
end
local num=#zhumobangData
if num<maxNum then
for i=num+1,maxNum do
table.insert(zhumobangData,{actorid=-1,actorname="虚位以待",sectname='',iconInfo=-1,score=0,rank=i})
end
end
self.playerRankData=playerRankData
self.playerRank=playerRank
else
for i=1,maxNum do
table.insert(zhumobangData,{actorid=-1,actorname="虚位以待",sectname='',iconInfo=-1,score=0,rank=i})
end
end
self.zhumobangData=zhumobangData
self:onRefreshRank(fresh)
end

function UISubAct_zhumobang_win.sortRank(a,b)
return a.rank<b.rank
end
local doufataiabName='ui/windows/doufatai/doufatai_atlas_pak.ab'

function UISubAct_zhumobang_win:fillBagData(index,item)
local zhumobangData=self.zhumobangData
local rewardLists=self.config.rank[index]

if not zhumobangData and not rewardLists then
return
end

local param1=rewardLists[1]
local param2=rewardLists[2]

item:SetChildActive(_rankCmp.bg_3,param1==param2)
item:SetChildActive(_rankCmp.bg_4,param1==param2)
item:SetChildActive(_rankCmp.bg_6,param1~=param2)
if param1==param2 and param1<4 then
local imgName=FMT.fmt('icon_phbmingci_{0}',param1)
item:SetChildActive(_rankCmp.rankImg,true)
item:SetChildCSImageSprite(_rankCmp.rankImg,doufataiabName,imgName)
item:SetChildText(_rankCmp.rank,FMT.cfmt(FONT_COLOR.eNomalBlackColor,param1))
else
item:SetChildActive(_rankCmp.rankImg,false)
item:SetChildIcon(_rankCmp.rankImg,"",false)
if param1==param2 then
item:SetChildText(_rankCmp.rank,param1)
else
item:SetChildText(_rankCmp.rank,FMT.fmt("{0}~{1}",param1,param2))
end
end

local count=param2-param1+1
for i,v in ipairs(_rankCmp.iconHeadItem)do
local rankData=zhumobangData[param1+i-1]
if i<=count and rankData.actorid~=-1 then
item:SetChildActive(v,true)
local hItem=item:GetChildWidgetBase(v)
playerController:setHeadIcon(hItem,0,{scale=0.55,iconInfo=rankData.iconInfo})
hItem:SetChildButtonClickWithID(2,function(index)
self:onClickHead(rankData.actorid,rankData.rank,index)
end,i)
else
item:SetChildActive(v,false)
end
end
for i,v in ipairs(_rankCmp.noHeadKuang)do
local rankData=zhumobangData[param1+i-1]
if i<=count and rankData.actorid==-1 then
item:SetChildActive(v,true)
else
item:SetChildActive(v,false)
end
end
item:SetChildActive(_rankCmp.havepeople,param1==param2)
if param1==param2 then
local rankData=zhumobangData[param1]
if rankData.actorid==-1 then
item:SetChildText(_rankCmp.score,"暂无")
item:SetChildText(_rankCmp.name,rankData.actorname)
else
item:SetChildText(_rankCmp.name,FMT.fmt("{0}\n<color=#efb150>{1}</color>",rankData.sectname,rankData.actorname))
item:SetChildText(_rankCmp.score,mathHelper.formatNumber3(rankData.score))
end
end

local rewardList=rewardLists[3]
if rewardList then
local rLen=#rewardList
item:SetChildLayoutGroupCreateItems(_rankCmp.itemList,rLen)
local gridList=item:GetChildLayoutGroupGridList(4)
for ii=1,rLen do
local grid=gridList[ii-1]
if grid then
local reward=rewardList[ii]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count<=1 and""or count,showCountBG=count>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end


function UIPrepareEnScroller:RefreshCell(i,cellIndex,item)
if self.window and self.window.isClose then
return
end
self.window:fillBagData(i,item)
end

function UISubAct_zhumobang_win:onRefreshRank(freshList)

local zhumobangData=self.zhumobangData
local playerRankData=self.playerRankData

local rewardLists=self.config.rank


if freshList then

self.enhancedscrollscript:initData(rewardLists,95,#rewardLists)
self.scrollerView:setChildScrollRectEnable(true)
end




local playerItem=self.myRankItem:getChildWidgetBase()
local hItem=playerItem:GetChildWidgetBase(5)
local myZongMen=UISettingModel:getZMName()
local myName=playerModel:getActorName()
playerController:setHeadIcon(hItem,0,{scale=0.55})
playerItem:SetChildText(2,FMT.fmt("{0}\n<color=#efb150>{1}</color>",myZongMen,myName))

local notHaveReward=false
if playerRankData then
local rank=self.playerRank

local rewardList
for i,v in ipairs(rewardLists)do
if rank>=v[1]and rank<=v[2]then
rewardList=v[3]
end
end
if rank<4 then
local imgName=FMT.fmt('icon_phbmingci_{0}',rank)
playerItem:SetChildCSImageSprite(0,doufataiabName,imgName)
playerItem:SetChildText(1,FMT.cfmt(FONT_COLOR.eNomalBlackColor,rank))
else
playerItem:SetChildText(1,rank)
end

if rewardList then
local rLen=#rewardList
playerItem:SetChildLayoutGroupCreateItems(4,rLen)
local gridList=playerItem:GetChildLayoutGroupGridList(4)
for ii=1,rLen do
local grid=gridList[ii-1]
if grid then
local reward=rewardList[ii]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count<=1 and""or count,showCountBG=count>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end
playerItem:SetChildText(6,mathHelper.formatNumber3(playerRankData.score))
else
playerItem:SetChildText(1,"未上榜")
notHaveReward=true
playerItem:SetChildText(6,mathHelper.formatNumber3(playerRankData.score))
end
else
playerItem:SetChildText(1,"未上榜")
playerItem:SetChildText(6,0)
notHaveReward=true
end
self.nohaveReward:setActive(notHaveReward)




end


function UISubAct_zhumobang_win:onHide()
self.scrollerView:setChildScrollRectEnable(false)
end
function UISubAct_zhumobang_win:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UISubAct_zhumobang_win:onClickHead(actorId,index)
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,nil)
end











def_class("UISubAct_wzdjRankWin",UIWindowBase)









function UISubAct_wzdjRankWin:bindComponents()

self.changeBtn=UIButton.get(self,0)
self.changeBtnIcon=UIImage.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.frameSp=UIObject.get(self,3)
self.menu2GridPanel=UIObject.get(self,4)
self.menuGridPanel=UIObject.get(self,5)
self.noItemTips=UIText.get(self,6)
self.rankItem=UIObject.get(self,7)
self.rankPanel=UIObject.get(self,8)
self.rankScrollView=UIEnhancedScrollerLua.get(self,9)
self.root=UIObject.get(self,10)
self.timeTxt=UIText.get(self,11)
self.tipsTxt=UIText.get(self,12)
self.titleTxt=UIText.get(self,13)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_wzdjRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.changeBtnIcon);self.changeBtnIcon=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.menu2GridPanel);self.menu2GridPanel=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end
















local UISubAct_wzdjRankScroller=simple_class(UIEnhancedScroller)
local _this


function UISubAct_wzdjRankWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self.scrollscript=UISubAct_wzdjRankScroller(self.rankScrollView:getGameObject(),self.rankScrollView:getCSharpObject(),nil,nil)
end

function UISubAct_wzdjRankWin.onNewDay()
if _this==nil then return end
_this:refreshAllMenuState()
end


function UISubAct_wzdjRankWin:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_wzdjRankWin:onHide()

end




function UISubAct_wzdjRankWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.tasklist=self.sub_actInfo:getTaskList()
self.onlyone=#self.tasklist==1
self.curTaskIndex=argtable.curTaskIndex
if self.curTaskIndex==0 then
self.curTaskIndex=-1
end
self:initTaskData()
self.showRank=true

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()
self:initPages()
self:refreshChangeBtn()
self:refreshView()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(6199,1,{},0,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UISubAct_wzdjRankWin:initTaskData()
if self.curTaskIndex>0 then
self.curTaskData=self.sub_actInfo:getTaskData(self.curTaskIndex)
else
self.curTaskData=self.sub_actInfo:getTaskData(0)
end
end

function UISubAct_wzdjRankWin:refreshActTime()
local lerp,str
local pageIndex=self.curTaskIndex>0 and 1 or 2
lerp=self.curTaskData:getEndLeftTime()
if pageIndex==2 then
if lerp<0 then
lerp=0
end
if lerp==0 then
str='已结束'
else
str=timeHelper.format_time_stamp3(lerp)
end
else
if lerp==0 then
str='已结束'
elseif lerp>0 then
str=timeHelper.format_time_stamp3(lerp)
else
str='活动未开始'
end
end
local time_str=FMT.fmt('结算倒计时：{0}',str)
self.timeTxt:setText(time_str)
end

function UISubAct_wzdjRankWin:refreshView()
self:refreshInfo()

local pageIndex=self.curTaskIndex>0 and 1 or 2
self.menu2GridPanel:setActive(pageIndex==1)
if pageIndex==1 then
if self.isMenusInit==nil then
self:initMenus()
self.isMenusInit=true
else
self:refreshAllMenuState()
end
end

self:initRank()
self:refreshRankItem()
end

function UISubAct_wzdjRankWin:refreshInfo()

local str=self.showRank==true and'排名'or'奖励'
local title_str=FMT.fmt('{0}{1}',self.curTaskData.name,str)
self.titleTxt:setText(title_str)

local limit=self.curTaskData.rank_min_score
local tips_str=FMT.fmt('排名前100且至少达到{0}积分的祖师，在活动结束后可获得排名奖励',limit)
self.tipsTxt:setText(tips_str)
end

function UISubAct_wzdjRankWin:refreshChangeBtn()
local icon=self.showRank==true and'button_wzdjui_9'or'button_wzdjui_10'
self.changeBtnIcon:setSprite(globalABLookup.wanzongduijueicons,icon)
end



function UISubAct_wzdjRankWin:initPages()
local isshow=not self.onlyone
self.menuGridPanel:setActive(isshow)
if isshow==true then
self.menuGridPanel:setChildLayoutGroupCreateItems(2,function(index)
if _this==nil then return end
local item=_this.menuGridPanel:getChildLayoutGroupGridItem(index-1)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onPageClick(index)
end)

local name_str=index==1 and'阶段'or'总榜'
item:SetChildText(1,name_str)

local isSelect
if index==1 then
isSelect=self.curTaskIndex>0
else
isSelect=self.curTaskIndex<0
end
_this:onPageSelected(item,index,isSelect)
end)
end
end

function UISubAct_wzdjRankWin:onPageClick(index)
if index==1 then
if self.curTaskIndex>0 then return end
self:onPageSelected(nil,2,false)
self:onPageSelected(nil,1,true)

else
if self.curTaskIndex<0 then return end
self:onPageSelected(nil,1,false)
self:onPageSelected(nil,2,true)
end
self.curTaskIndex=-self.curTaskIndex
self:initTaskData()
self:refreshView()
self:refreshActTime()
end

function UISubAct_wzdjRankWin:onPageSelected(item,index,isSelect)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(index-1)
end
local icon=isSelect==true and'button_wzdjui_8'or'button_wzdjui_7'
item:SetChildCSImageSprite(0,globalABLookup.wanzongduijueicons,icon)
end





function UISubAct_wzdjRankWin:initMenus()
local n=#self.tasklist
local isshow=n>1
self.menu2GridPanel:setActive(isshow)
if isshow==true then
self.menu2GridPanel:setChildLayoutGroupCreateItems(n,function(index)
if _this==nil then return end
local item=_this.menu2GridPanel:getChildLayoutGroupGridItem(index-1)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuClick(index)
end)

local taskData=_this.tasklist[index]
item:SetChildText(2,taskData.name)

_this:onMenuSelected(item,index,index==self.curTaskIndex)

self:refreshMenuState(item,index)
end)
end
end

function UISubAct_wzdjRankWin:refreshAllMenuState()
local grids=self.menu2GridPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshMenuState(item,i)
end
end

function UISubAct_wzdjRankWin:onMenuClick(index)
if self.curTaskIndex==index then
return
end






self:onMenuSelected(nil,self.curTaskIndex,false)
self:onMenuSelected(nil,index,true)
self.curTaskIndex=index
self:initTaskData()
self:refreshInfo()
self:initRank()
self:refreshRankItem()
self:refreshActTime()
end

function UISubAct_wzdjRankWin:onMenuSelected(item,index,isSelect)
if item==nil then
item=self.menu2GridPanel:getChildLayoutGroupGridItem(index-1)
end
item:SetChildActive(1,isSelect)
end

function UISubAct_wzdjRankWin:refreshMenuState(item,index)
if item==nil then
item=self.menu2GridPanel:getChildLayoutGroupGridItem(index-1)
end
if item==nil then return end
local taskData=self.tasklist[index]
local lerp=taskData:getEndLeftTime()
local bgicon,signicon
if lerp==0 then

bgicon='button_wzdjui_3'
signicon='image_wzdjyijieshu'
elseif lerp>0 then

bgicon='button_wzdjui_1'
signicon='image_wzdjjinxingzhong'
else

bgicon='button_wzdjui_1'
signicon='image_wzdjweikaishi'
end

item:SetChildCSImageSprite(0,globalABLookup.wanzongduijueicons,bgicon)

item:SetChildCSImageSprite(3,globalABLookup.wanzongduijueicons,signicon)
end





function UISubAct_wzdjRankWin:initRank(reqBack)
local index=self.curTaskIndex
if index<0 then index=0 end
local ranklist,lerp,isshow
ranklist,lerp=self.sub_actInfo:getRankList(index)
isshow=ranklist~=nil
if not self.showRank then
self.rankList=self.curTaskData.rank_reward
else
self.rankList=ranklist
end
local showTips=false
self.rankPanel:setActive(isshow)
self.curRank=nil
self.curScore=nil
if isshow then
local num=#self.rankList
showTips=num<=0
local myActorid=playerModel:getActorID()
for i,data in ipairs(ranklist)do
if mathHelper.compareInt64(myActorid,data.actorid)then
self.curRank=data.rank
self.curScore=data.score
break
end
end
self.scrollscript:initData(ranklist,118,num)
else
showTips=false
if not reqBack then
if self.reqRankLookup==nil then
self.reqRankLookup={}
end
local index_=self.onlyone==true and 1 or index
local func=function()

self.reqRankLookup[index_]=nil
local jstr=jsonHelper.encode({2,index_})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,jstr)
end
if lerp~=nil then
if self.reqRankLookup[index_]==nil then
self.reqRankLookup[index_]=self:delayDo(lerp,func)
end
else
if self.reqRankLookup[index_]~=nil then
self:stopTimerByID(self.reqRankLookup[index_])
self.reqRankLookup[index_]=nil
end
func()
end
end
end
self.noItemTips:setActive(showTips)
end

function UISubAct_wzdjRankScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_wzdjRankScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_wzdjRankScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
if _this.showRank==true then
self:RefreshCell1(dataIndex,item)
else
self:RefreshCell2(dataIndex,item)
end
end

function UISubAct_wzdjRankScroller:RefreshCell1(dataIndex,item)
if _this==nil then return end
local data=_this.rankList[dataIndex]

local rank=data.rank

local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(0,showRankIcon)
item:SetChildActive(2,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(0,globalABLookup.global,rankIcon)
item:SetChildText(1,rank_str)
else
item:SetChildText(2,rank_str)
end

item:SetChildActive(3,true)

item:SetChildText(4,data.actorname)

item:SetChildText(5,FMT.fmt('{0}积分',data.score))
item:SetChildActive(6,false)
item:SetChildActive(7,false)
end

function UISubAct_wzdjRankScroller:RefreshCell2(dataIndex,item)
if _this==nil then return end
local data=_this.rankList[dataIndex]

local rank=data.rank
local rank2=data.rank2

local rankIcon
local rank_str=tostring(rank)
if rank<=3 and rank2==nil then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(0,showRankIcon)
item:SetChildActive(2,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(0,globalABLookup.global,rankIcon)
item:SetChildText(1,tostring(rank))
else
item:SetChildText(2,FMT.fmt('{0}-{1}',rank,rank2))
end

item:SetChildActive(3,false)

local rewardList=data.rewardList
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(6,showReward)
item:SetChildActive(7,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(6,c)
local grids2=item:GetChildLayoutGroupGridList(6)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end



function UISubAct_wzdjRankWin:getRewardList(rank,score)
return self.curTaskData:getRewardInRank(rank,score)
end

function UISubAct_wzdjRankWin:refreshRankItem()
local item=self.rankItem:getChildWidgetBase()

local rank=self.curRank
local score=self.curScore
if rank==nil then
score=self.curTaskData:getScore()
rank=self.curTaskData:getRank()
end
local rankIcon
local rank_str
local isNotRank=rank==nil or rank==0
if isNotRank then
rank_str='暂无名次'
else
rank_str=tostring(rank)
end
if not isNotRank and rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(0,showRankIcon)
item:SetChildActive(2,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(0,globalABLookup.global,rankIcon)
item:SetChildText(1,rank_str)
else
item:SetChildText(2,rank_str)
end

if self.showRank==true then

item:SetChildActive(3,true)
item:SetChildActive(6,false)
item:SetChildActive(7,false)

item:SetChildText(4,playerModel:getActorName())

item:SetChildText(5,FMT.fmt('{0}积分',score))
else

item:SetChildActive(3,false)
local rewardList=self:getRewardList(rank,score)
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(6,showReward)
item:SetChildActive(7,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(6,c)
local grids2=item:GetChildLayoutGroupGridList(6)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end
end

function UISubAct_wzdjRankWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_wzdjRankWin:onChangeBtn()
self.showRank=not self.showRank
self:refreshChangeBtn()
self:initRank()
self:refreshRankItem()
end

function UISubAct_wzdjRankWin:onCloseBtn()
self:closeSelf()
end



function UISubAct_wzdjRankWin:rec_ranklist(index_)
local index=self.curTaskIndex
if index<0 then index=0 end
if self.onlyone==true or index_==index then
self:initRank(true)
self:refreshRankItem()
end
end


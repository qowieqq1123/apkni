







def_class("UISubAct_wzdjMainWin",UIWindowBase)









function UISubAct_wzdjMainWin:bindComponents()

self.frame2Sp=UIObject.get(self,0)
self.frameSp=UIObject.get(self,1)
self.itemsGridPanel=UIObject.get(self,2)
self.jumpMain2Btn=UIButton.get(self,3)
self.jumpMainBtn=UIButton.get(self,4)
self.jumpMainReddot=UIObject.get(self,5)
self.menuGridPanel=UIObject.get(self,6)
self.partTimeTxt=UIText.get(self,7)
self.rank2Btn=UIButton.get(self,8)
self.rankBtn=UIButton.get(self,9)
self.rankItem=UIObject.get(self,10)
self.rankRoot=UIObject.get(self,11)
self.rankTxt=UIText.get(self,12)
self.root=UIObject.get(self,13)
self.root2=UIObject.get(self,14)
self.rule2Btn=UIButton.get(self,15)
self.ruleBtn=UIButton.get(self,16)
self.scoreBtn=UIButton.get(self,17)
self.scoreTxt=UIText.get(self,18)
self.timeTxt=UIText.get(self,19)

self.jumpMain2Btn:setButtonClick(function()self:onJumpMain2Btn()end)

self.jumpMainBtn:setButtonClick(function()self:onJumpMainBtn()end)

self.rank2Btn:setButtonClick(function()self:onRank2Btn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rule2Btn:setButtonClick(function()self:onRule2Btn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.scoreBtn:setButtonClick(function()self:onScoreBtn()end)



end


function UISubAct_wzdjMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frame2Sp);self.frame2Sp=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.itemsGridPanel);self.itemsGridPanel=nil;
_UIObject_release(self.jumpMain2Btn);self.jumpMain2Btn=nil;
_UIObject_release(self.jumpMainBtn);self.jumpMainBtn=nil;
_UIObject_release(self.jumpMainReddot);self.jumpMainReddot=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.partTimeTxt);self.partTimeTxt=nil;
_UIObject_release(self.rank2Btn);self.rank2Btn=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
_UIObject_release(self.rankRoot);self.rankRoot=nil;
_UIObject_release(self.rankTxt);self.rankTxt=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.rule2Btn);self.rule2Btn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.scoreBtn);self.scoreBtn=nil;
_UIObject_release(self.scoreTxt);self.scoreTxt=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
end
















local _this


function UISubAct_wzdjMainWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_wzdjMainWin:__delete()
_this=nil
self:unbindComponents()
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
end

function UISubAct_wzdjMainWin.onNewDay()
if _this==nil then return end
_this:changePageAuto()
end


function UISubAct_wzdjMainWin:onHide()

end




function UISubAct_wzdjMainWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin


self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.tasklist=self.sub_actInfo:getTaskList()
self.onlyone=#self.tasklist==1
self.page,self.curTaskIndex=self:getPage()
self.curTaskData=self.sub_actInfo:getTaskData(self.curTaskIndex)

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()

if afterOnloaded then
self:refreshPageAnim()
end
self:refreshView()
self:tryReqScoreRank()
end

function UISubAct_wzdjMainWin:refreshView()
if self.page==1 then
self:refreshInfo()
self:refreshJumpMain2Btn()
self:initMenus()
self:initItems()
else
self:refreshRankGrid()
self:refreshInfo2()
self:refreshJumpMainBtn()
end
end

function UISubAct_wzdjMainWin:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('活动倒计时：{0}',timeHelper.format_time_stamp3(lerp))
self.timeTxt:setText(time_str)
lerp=self.curTaskData:getEndLeftTime()
local str
if lerp==0 then
str='已结束'
elseif lerp>0 then
str=timeHelper.format_time_stamp3(lerp)
else
str='未开始'
end
time_str=FMT.fmt('结算倒计时：{0}',str)
self.partTimeTxt:setText(time_str)
end

function UISubAct_wzdjMainWin:refreshInfo()

local score=self.curTaskData:getScore()or 0
local score_str=FMT.fmt('我的积分：<color=#171311>{0}</color>',mathHelper.formatNumber3(score))
self.scoreTxt:setText(score_str)

local rank=self.curTaskData:getRank()
local rank_str=rank==0 and'无'or tostring(rank)
rank_str=FMT.fmt('我的排名：<color=#171311>{0}</color>',rank_str)
self.rankTxt:setText(rank_str)
end

function UISubAct_wzdjMainWin:tryReqScoreRank(needRefresh)
if needRefresh==true then
if self.page==1 then
self:refreshInfo()
else
self:refreshInfo2()
end
end
local index=self.onlyone==true and 1 or self.curTaskIndex
local flag,lerp=self.sub_actInfo:checkReqNewScore(index)
if flag then
if self.reqScoreLookup==nil then
self.reqScoreLookup={}
end
local func=function()

self.reqScoreLookup[index]=nil
local jstr=jsonHelper.encode({3,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,jstr)
end
if lerp~=nil then
if self.reqScoreLookup[index]==nil then
self.reqScoreLookup[index]=self:delayDo(lerp,func)
end
else
if self.reqScoreLookup[index]~=nil then
self:stopTimerByID(self.reqScoreLookup[index])
self.reqScoreLookup[index]=nil
end
func()
end
end
end



function UISubAct_wzdjMainWin:getPage()
local index=self.sub_actInfo:getCurTaskIndex()
local page=index>0 and 1 or 2
return page,index
end

function UISubAct_wzdjMainWin:changePageAuto()
if not self.onlyone then
if self.page==1 then
self:refreshJumpMain2Btn()
local page,index=self:getPage()
self:refreshMenuState(nil,index)
if self.curTaskIndex~=index then
self:refreshMenuState(nil,self.curTaskIndex)
end
else

end
end
end

function UISubAct_wzdjMainWin:refreshPage()
self:refreshPageAnim()
self:refreshView()
self:refreshActTime()
end

function UISubAct_wzdjMainWin:refreshPageAnim()
if self.page==1 then
self.root2:setActive(false)
self.root:setActive(true)
if self.init1==nil then
self.init1=true
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(6198,1,{},0,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
else
self.root2:setActive(true)
self.root:setActive(false)
if self.init2==nil then
self.init2=true
self.root2:setChildCanvasGroupAlpha(0)
self.frame2Sp:setChildUIModelShowTarget(6200,1,{},0,false,false,0,function()
if _this==nil then return end
_this.root2:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end
end





function UISubAct_wzdjMainWin:initMenus()
local n=#self.tasklist
local isshow=n>1
self.menuGridPanel:setActive(isshow)
if isshow==true then
self.menuGridPanel:setChildLayoutGroupCreateItems(n,function(index)
if _this==nil then return end
local item=_this.menuGridPanel:getChildLayoutGroupGridItem(index-1)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuClick(index)
end)

local taskData=_this.tasklist[index]
item:SetChildText(1,taskData.name)

_this:onMenuSelected(item,index,index==self.curTaskIndex)

self:refreshMenuState(item,index)
end)
end
end

function UISubAct_wzdjMainWin:refreshAllMenuState()
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshMenuState(item,i)
end
end

function UISubAct_wzdjMainWin:onMenuClick(index)
if self.curTaskIndex==index then
return
end
local taskData=self.tasklist[index]
local lerp=taskData:getEndLeftTime()
if lerp<0 then
self:openScoreWin(index)
return
end
self:onMenuSelected(nil,self.curTaskIndex,false)
self:onMenuSelected(nil,index,true)
self.curTaskIndex=index
self.curTaskData=self.sub_actInfo:getTaskData(self.curTaskIndex)
self:initItems()
self:refreshActTime()
self:tryReqScoreRank(true)
end

function UISubAct_wzdjMainWin:onMenuSelected(item,index,isSelect)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(index-1)
end
item:SetChildActive(4,isSelect)
end

function UISubAct_wzdjMainWin:refreshMenuState(item,index)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(index-1)
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

local isReddot=taskData:checkReddot()
item:SetChildActive(2,isReddot)
end





function UISubAct_wzdjMainWin:initItems()
self.curTargets=self.curTaskData:getSortTargets()
local n=#self.curTargets
self.itemsGridPanel:setChildLayoutGroupCreateItems(n,function(index)
if _this==nil then return end
local item=_this.itemsGridPanel:getChildLayoutGroupGridItem(index-1)

item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onItemRewardClick(index)
end)

item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onItemGotoClick(index)
end)

local target=_this.curTargets[index]
local str=FMT.fmt('目标积分：<color=#549327>{0}</color>',target[2])
item:SetChildText(1,str)

local rewardList=target[3]
local c=#rewardList
item:SetChildLayoutGroupCreateItems(0,c)
local grids2=item:GetChildLayoutGroupGridList(0)
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

self:refreshItem(item,index)
end)
end

function UISubAct_wzdjMainWin:refreshAllItems()
local grids=self.itemsGridPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshItem(item,i)
end
end

function UISubAct_wzdjMainWin:refreshItem(item,index)
if item==nil then
item=self.itemsGridPanel:getChildLayoutGroupGridItem(index-1)
end
local target=self.curTargets[index]
local isfinish,hasreward=self.curTaskData:checkTargetState(target)

local bgicon
if hasreward then
bgicon='image_wzdjui_3'
else
bgicon='image_wzdjui_1'
end
item:SetChildCSImageSprite(4,globalABLookup.wanzongduijueicons,bgicon)
item:SetChildImageExGray(4,not isfinish)

item:SetChildActive(3,isfinish and not hasreward)

item:SetChildActive(2,isfinish and hasreward)

local showGoto=not isfinish
item:SetChildActive(5,showGoto)
if showGoto==true then
local lerp=self.curTaskData:getEndLeftTime()
item:SetChildImageExGray(5,lerp<=0)
end

local max=target[2]
local cur=self.curTaskData:getScore()or 0
local fix=false
if cur>=max then
cur=max
fix=true
end
local progressStr
if fix==true then
progressStr=FMT.fmt('{0}/{1}',cur,max)
else
progressStr=FMT.fmt('<color=#c82c2c>{0}</color>/{1}',cur,max)
end
item:SetChildText(6,progressStr)
end

function UISubAct_wzdjMainWin:onItemRewardClick(index)
local list={}
for _,t in ipairs(self.curTargets)do
local isfinish,hasreward=self.curTaskData:checkTargetState(t)
if hasreward then
table.insert(list,t[1]-1)
end
end
if#list>0 then

local jstr=jsonHelper.encode({1,self.curTaskIndex,list})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,jstr)
end
end

function UISubAct_wzdjMainWin:onItemGotoClick(index)
self:onScoreBtn()
end





function UISubAct_wzdjMainWin:refreshRankGrid(reqBack)
local taskIndex=0
local ranklist,lerp=self.sub_actInfo:getRankList(taskIndex)
self.ranklist=ranklist
local isshow=self.ranklist~=nil
self.rankRoot:setActive(isshow)
if isshow then
local grids=self.rankRoot:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local rankData=self.ranklist[i]
local has=rankData~=nil
item:SetChildActive(0,has)
item:SetChildActive(1,not has)
if has then

local replace={[PLAYER_IMAGE_TYPE.eBodyOrnament]=1}
playerController:setImage(item,2,nil,rankData.iconInfo,false,nil,replace)

local args={iconInfo=rankData.iconInfo,scale=0.8}
playerController:setHeadIcon(item,3,args)

local serverName=FMT.fmt("[{0}]",loginModel:getServerName(rankData.serverid))
item:SetChildText(4,serverName)

item:SetChildText(5,rankData.actorname)

item:SetChildText(6,FMT.fmt('积分：{0}',mathHelper.formatNumber3(rankData.score)))
end

item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onRankClick(i)
end)
end
else
if not reqBack then
local func=function()

self.reqRankTimer=nil
local taskIndex_=self.onlyone==true and 1 or taskIndex
local jstr=jsonHelper.encode({2,taskIndex_})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,jstr)
end
if lerp~=nil then
if self.reqRankTimer==nil then
self.reqRankTimer=self:delayDo(lerp,func)
end
else
if self.reqRankTimer~=nil then
self:stopTimerByID(self.reqRankTimer)
self.reqRankTimer=nil
end
func()
end
end
end
end

function UISubAct_wzdjMainWin:onRankClick(index)
local rankData=self.ranklist[index]
if rankData then
otherPlayerController:openOtherPlayerInfoWin(rankData.actorid,nil,nil,{serverid=rankData.serverid})
end
end



function UISubAct_wzdjMainWin:refreshInfo2()
local item=self.rankItem:getChildWidgetBase()
local taskData=self.curTaskData
local rank=taskData:getRank()
local score=taskData:getScore()
local rank_str
local isNotRank=rank==nil or rank==0
if isNotRank then
rank_str='无'
else
rank_str=tostring(rank)
end
item:SetChildText(0,rank_str)

local args={iconInfo=nil,scale=0.8}
playerController:setHeadIcon(item,1,args)

item:SetChildText(2,playerModel:getActorName())

local serverName=FMT.fmt("[{0}]",loginModel:getMyServerName())
item:SetChildText(3,serverName)

item:SetChildText(4,tostring(score))
end

function UISubAct_wzdjMainWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_wzdjMainWin:onRankBtn()
local index=self.onlyone==true and 1 or self.curTaskIndex
self:showWindow('UISubAct_wzdjRankWin',{act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid,curTaskIndex=index})
end

function UISubAct_wzdjMainWin:onRank2Btn()
self:onRankBtn()
end

function UISubAct_wzdjMainWin:onRuleBtn()
local d={}
d.title='万宗对决规则'
d.mode=3
d.name='wanzongduijue_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_wzdjMainWin:onRule2Btn()
self:onRuleBtn()
end

function UISubAct_wzdjMainWin:onScoreBtn()
local index=self.curTaskIndex
if index~=nil then
self:openScoreWin(index)
end
end

function UISubAct_wzdjMainWin:openScoreWin(index)
local taskData=self.tasklist[index]
local lerp=taskData:getEndLeftTime()
if lerp<0 then
UIManager.error('未开启，该阶段正在筹备中')
elseif lerp==0 then
UIManager.error('该阶段已结束')
end
self:showWindow('UISubAct_wzdjScoreWin',{act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid,curTaskIndex=index})
end

function UISubAct_wzdjMainWin:onJumpMainBtn()
if self.page==1 then return end
self.page=1
local index=self.sub_actInfo:getCurTaskIndex()
if index==0 then
index=1
end
self.curTaskIndex=index
self.curTaskData=self.sub_actInfo:getTaskData(self.curTaskIndex)
self:refreshPage()
self:tryReqScoreRank()
end

function UISubAct_wzdjMainWin:onJumpMain2Btn()
if self.page==2 then return end
self.page=2
self.curTaskIndex=0
self.curTaskData=self.sub_actInfo:getTaskData(self.curTaskIndex)
self:refreshPage()
self:tryReqScoreRank()
end

function UISubAct_wzdjMainWin:refreshJumpMain2Btn()
local index=self.sub_actInfo:getCurTaskIndex()
self.jumpMain2Btn:setActive(index==0)

end

function UISubAct_wzdjMainWin:refreshJumpMainBtn()
local isReddot=self.sub_actInfo:checkReddot()
self.jumpMainBtn:setActive(isReddot)
if isReddot then
self.jumpMainReddot:setActive(isReddot)
end
end



function UISubAct_wzdjMainWin:rec_score(index,changeScore)
if self.onlyone==true or index==self.curTaskIndex then
if self.page==1 then
self:refreshInfo()
if changeScore==true then
self:refreshAllItems()

end
else
self:refreshRankGrid(true)
self:refreshInfo2()
end
end
if self.page==1 then
self:refreshMenuState(nil,index)
end
end

function UISubAct_wzdjMainWin:rec_rank(index)
if self.onlyone==true or index==self.curTaskIndex then
if self.page==1 then
self:refreshInfo()
else
self:refreshInfo2()
end
end
end

function UISubAct_wzdjMainWin:rec_reward(index)
if index==self.curTaskIndex then
if self.page==1 then
self:initItems()
end
end
if self.page==1 then
self:refreshMenuState(nil,index)
end
end

function UISubAct_wzdjMainWin:rec_ranklist(index)
if self.onlyone==true or index==self.curTaskIndex then
if self.page==2 then
self:refreshRankGrid(true)
end
end
end


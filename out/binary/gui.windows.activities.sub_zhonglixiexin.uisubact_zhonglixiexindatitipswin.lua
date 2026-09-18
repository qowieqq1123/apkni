







def_class("UISubAct_ZhongLiXieXinDaTiTipsWin",UIWindowBase)









function UISubAct_ZhongLiXieXinDaTiTipsWin:bindComponents()

self.cdText=UIText.get(self,0)
self.chooseItem_1=UIObject.get(self,1)
self.chooseItem_2=UIObject.get(self,2)
self.chooseItem_3=UIObject.get(self,3)
self.chooseItem_4=UIObject.get(self,4)
self.chooseList=UIObject.get(self,5)
self.desc=UIText.get(self,6)
self.leftBtn=UIButton.get(self,7)
self.mbg=UIObject.get(self,8)
self.myRank=UIObject.get(self,9)
self.notRank=UIText.get(self,10)
self.panel1=UIObject.get(self,11)
self.panel2=UIObject.get(self,12)
self.playerList=UIObject.get(self,13)
self.rankContent=UIObject.get(self,14)
self.rankScrollView=UIObject.get(self,15)
self.rightBtn=UIButton.get(self,16)
self.root=UIObject.get(self,17)
self.tabContent=UIObject.get(self,18)
self.tabScrollView=UIObject.get(self,19)
self.title1=UIObject.get(self,20)
self.title2=UIObject.get(self,21)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)
self.chooseItem={
self.chooseItem_1,
self.chooseItem_2,
self.chooseItem_3,
self.chooseItem_4,
}



end


function UISubAct_ZhongLiXieXinDaTiTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdText);self.cdText=nil;
_UIObject_release(self.chooseItem_1);self.chooseItem_1=nil;
_UIObject_release(self.chooseItem_2);self.chooseItem_2=nil;
_UIObject_release(self.chooseItem_3);self.chooseItem_3=nil;
_UIObject_release(self.chooseItem_4);self.chooseItem_4=nil;
_UIObject_release(self.chooseList);self.chooseList=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.myRank);self.myRank=nil;
_UIObject_release(self.notRank);self.notRank=nil;
_UIObject_release(self.panel1);self.panel1=nil;
_UIObject_release(self.panel2);self.panel2=nil;
_UIObject_release(self.playerList);self.playerList=nil;
_UIObject_release(self.rankContent);self.rankContent=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tabContent);self.tabContent=nil;
_UIObject_release(self.tabScrollView);self.tabScrollView=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
self.chooseItem=nil;
end
















local _this




function UISubAct_ZhongLiXieXinDaTiTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ZhongLiXieXinDaTiTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ZhongLiXieXinDaTiTipsWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

local curDay=self.sub_actInfo:getCurDay()
self.day=argtable.day
self.isToday=curDay==self.day

self.title1:setActive(not self.isToday)
self.title2:setActive(self.isToday)

self.selectQuesIdx=1

if self.isToday then
local cur,max=self.sub_actInfo:getCurProgress(self.day)
for i=1,max do
local checkIdx=self.sub_actInfo:getRoleQuesCheckIdx(self.day,i)
if not checkIdx then
self.selectQuesIdx=i
break
end
end
end

self:refreshAll()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(self.isToday and 6228 or 6229,1,nil,eAnimationID.enter)
self:delayDo(0.3,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
end


function UISubAct_ZhongLiXieXinDaTiTipsWin:onHide()

end

function UISubAct_ZhongLiXieXinDaTiTipsWin:refreshAll()
self:refreshTabInfo()
self:refreshPanel()
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:refreshTabInfo()
if not self.initTab then
local cur,max=self.sub_actInfo:getCurProgress(self.day)
self.quesList={}
if not self.isToday then
table.insert(self.quesList,0)
end
for i=1,max do
table.insert(self.quesList,i)
end
self.tabContent:setChildLayoutGroupCreateItems(#self.quesList,self.bindTabWidget)
self.tabScrollView:setChildSizeDelta(max>10 and 789 or 717,65)
self.initTab=true
end
end

function UISubAct_ZhongLiXieXinDaTiTipsWin.bindTabWidget(index)
local widget=_this.tabContent:getChildLayoutGroupGridItem(index-1)
local quesIdx=_this.quesList[index]

if _this.isToday then
local checkIdx=_this.sub_actInfo:getRoleQuesCheckIdx(_this.day,quesIdx)
widget:SetChildActive(2,checkIdx~=nil)
else
widget:SetChildActive(2,false)
end

local isSelect=_this.selectQuesIdx==index
_this:refreshTabSelect(widget,isSelect)

widget:SetChildActive(0,isSelect)
if quesIdx==0 then
widget:SetChildText(1,"总览")
else
widget:SetChildText(1,quesIdx)
end

widget:SetChildButtonClick(3,function()
local oldIdx=_this.selectQuesIdx
_this.selectQuesIdx=index

if oldIdx and oldIdx>0 then
local old_widget=_this.tabContent:getChildLayoutGroupGridItem(oldIdx-1)
_this:refreshTabSelect(old_widget,false)
end
_this:refreshTabSelect(widget,true)

_this:refreshPanel()
end,true)
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:refreshTabSelect(widget,isSelect)
widget:SetChildActive(0,isSelect)
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:refreshPanel()
if self.cdTimer then
self:stopCDTimer()
end
local quesIdx=self.quesList[self.selectQuesIdx]
if quesIdx>0 then
self:refreshPanel1()
else
self:refreshPanel2()
end
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:refreshPanel1()
self.panel1:setActive(true)
self.panel2:setActive(false)

local quesIdx=self.quesList[self.selectQuesIdx]
local quesId=self.sub_actcfg.ques_list[self.day][1][quesIdx]
self.quesCfg=cfgHelper.get1(cfg_zhonglixiexinquestionconfig_get,quesId)

self.desc:setText(self.quesCfg.ques_str)

for i=1,#self.chooseItem do
self:bindChooseItem(i)
end
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:bindChooseItem(index)
local widget=_this.chooseItem[index]:getChildWidgetBase()

local checkStr=_this.quesCfg.check_list[index]
widget:SetChildActive(-1,checkStr~=nil)
if checkStr~=nil then
local quesIdx=_this.quesList[_this.selectQuesIdx]
local checkIdx=_this.sub_actInfo:getRoleQuesCheckIdx(_this.day,quesIdx)
local isSelect=checkIdx==index
widget:SetChildActive(0,isSelect)
widget:SetChildText(1,checkStr)
widget:SetChildText(5,checkStr)
widget:SetChildText(6,checkStr)

widget:SetChildActive(1,not _this.isToday)
widget:SetChildActive(2,not _this.isToday)
widget:SetChildActive(3,not _this.isToday)
widget:SetChildActive(5,_this.isToday and not isSelect)
widget:SetChildActive(6,_this.isToday and isSelect)

if not _this.isToday then
local quesInfo=_this.sub_actInfo:getDayQuesInfo(_this.day,quesIdx)

if quesInfo then
local num=quesInfo[index].check_cnt or 0
local max=quesInfo[index].totleCnt or 1
local rank=quesInfo[index].rank
widget:SetChildProgressValue(2,num,max)
widget:SetChildProgressText(2,FMT.fmt("{0}%",math.floor((num*1000)/max+0.5)/10))
if num>0 then
widget:SetChildText(3,FMT.fmt("{0}+{1}",_this.sub_actcfg.score_name,_this.sub_actcfg.score_rule[rank]or 0))
else
widget:SetChildText(3,FMT.fmt("{0}+{1}",_this.sub_actcfg.score_name,0))
end
else
widget:SetChildProgressValue(2,0,1)
widget:SetChildProgressText(2,"0%")
widget:SetChildText(3,FMT.fmt("{0}+{1}",_this.sub_actcfg.score_name,0))
end
end

widget:SetChildButtonClick(4,function()
local today=_this.sub_actInfo:getStart2NowDay()
local curCheckIdx=_this.sub_actInfo:getRoleQuesCheckIdx(_this.day,quesIdx)
if curCheckIdx~=index and today==_this.day then
_this.sub_actInfo:reqSelectCheck(quesIdx,index)
end
end,true)
end
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:refreshPanel2()
self.panel1:setActive(false)
self.panel2:setActive(true)

if not self.initRank then
local scoreName=self.sub_actcfg.score_name
local rankList=self.sub_actInfo:getLastRankList()
local isShow=rankList and#rankList>0
if isShow then
local bindWidget=function(index)
local widget=self.rankContent:getChildLayoutGroupGridItem(index-1)
local data=rankList[index]
local actorList=data.list
local rank=data.rank
local score=data.score
local isme=data.isMe
local serverid=data.server_id

widget:SetChildText(0,FMT.fmt("{0}+{1}",scoreName,score))
widget:SetChildText(4,rank)
widget:SetChildActive(1,rank==1)
widget:SetChildActive(2,rank==2)
widget:SetChildActive(3,rank==3)
widget:SetChildActive(5,isme)


local bindItem=function(idx)
local item=widget:GetChildLayoutGroupGridItem(6,idx-1)
local actorData=actorList[idx]
if actorData then
local actorid=actorList[idx].actor_id
local iconInfo=actorList[idx].iconInfo

local incoinfo_table={iconInfo=iconInfo,scale=0.6}
playerController:setHeadIcon(item,0,incoinfo_table)

local isMe=playerModel:checkActorId(actorid)
item:SetChildActive(1,not isMe)
item:SetChildButtonClick(1,function()
local attach={serverid=serverid}
otherPlayerController:openOtherPlayerInfoWin(actorid,true,nil,attach)
end,true)
end
item:SetChildActive(-1,actorData~=nil)
end
widget:SetChildLayoutGroupCreateItems(6,4,bindItem)
end
self.rankContent:setChildLayoutGroupCreateItems(#rankList,bindWidget)
end

self.rankScrollView:setActive(isShow)
self.notRank:setActive(not isShow)

local myWidget=self.myRank:getChildWidgetBase()
local myRankData=self.sub_actInfo:getMyLastRankData()
if myRankData then
myWidget:SetChildText(0,FMT.fmt("我的排名：{0}",myRankData.rank))
myWidget:SetChildText(1,FMT.fmt("{0}+{1}",scoreName,myRankData.score))
else
myWidget:SetChildText(0,"未上榜")
myWidget:SetChildText(1,"0")
end

self.initRank=true
end
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:rectSelectCheckIdx(day,ques_idx,check_idx,old_check_idx)
if _this.day~=day then
return
end
_this.bindTabWidget(ques_idx)

local quesIdx=_this.quesList[_this.selectQuesIdx]
if ques_idx~=quesIdx then
return
end
if old_check_idx~=nil then
local old_widget=_this.chooseItem[old_check_idx]:getChildWidgetBase()
old_widget:SetChildActive(0,false)
if _this.isToday then
old_widget:SetChildActive(5,true)
old_widget:SetChildActive(6,false)
end
end
local widget=_this.chooseItem[check_idx]:getChildWidgetBase()
widget:SetChildActive(0,true)
widget:SetChildActive(5,false)
widget:SetChildActive(6,true)

if _this.cdTimer then
_this:stopCDTimer()
end
local cur,max=_this.sub_actInfo:getCurProgress(self.day)
if cur>=max then
return
end
_this.cdTime=3
_this.cdText:setActive(true)
local cdFunc=function()
if _this.cdTime<0 then
for i=1,max-1 do
local idx=ques_idx+i
if idx>max then
idx=idx-max
end
local checkIdx=_this.sub_actInfo:getRoleQuesCheckIdx(_this.day,idx)
if not checkIdx then
_this:setSelectQuesIdx(idx)
return
end
end

_this:stopCDTimer()
return
end
_this.cdText:setText(FMT.fmt("（{0}）跳转",_this.cdTime))
_this.cdTime=_this.cdTime-1
end
_this.cdTimer=_this:setTimer(1,0,cdFunc)
cdFunc()
end


function UISubAct_ZhongLiXieXinDaTiTipsWin:stopCDTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
self.cdText:setActive(false)
end
end

function UISubAct_ZhongLiXieXinDaTiTipsWin:setSelectQuesIdx(idx)
local min=1
local max=#self.quesList
local oldIdx=self.selectQuesIdx
if idx>max then
idx=min
elseif idx<min then
idx=max
end
self.selectQuesIdx=idx

local old_widget=self.tabContent:getChildLayoutGroupGridItem(oldIdx-1)
self:refreshTabSelect(old_widget,false)

local widget=self.tabContent:getChildLayoutGroupGridItem(self.selectQuesIdx-1)
self:refreshTabSelect(widget,true)

if self.selectQuesIdx>4 then
local maxX=-max*72+3+(max>10 and 789 or 717)
local _x=-(self.selectQuesIdx-4)*72+3
self.tabContent:setLocalPosX(math.max(_x,maxX))
else
self.tabContent:setLocalPosX(0)
end
self:refreshPanel()
end






function UISubAct_ZhongLiXieXinDaTiTipsWin:onLeftBtn()
self:setSelectQuesIdx(self.selectQuesIdx-1)
end



function UISubAct_ZhongLiXieXinDaTiTipsWin:onRightBtn()
self:setSelectQuesIdx(self.selectQuesIdx+1)
end


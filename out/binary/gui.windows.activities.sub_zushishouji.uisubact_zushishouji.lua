







def_class("UISubAct_zushishouji",UIWindowBase)









function UISubAct_zushishouji:bindComponents()

self.bgImg=UIImage.get(self,0)
self.bottomRoot=UIObject.get(self,1)
self.timebg=UIObject.get(self,2)
self.rewadProgress=UIObject.get(self,3)
self.rewardContent=UIObject.get(self,4)
self.rewardGrid=UIObject.get(self,5)
self.rewardNumTxt=UIText.get(self,6)
self.rewardProgressBar=UIObject.get(self,7)
self.rewardScrollView=UIObject.get(self,8)
self.leftRoot=UIObject.get(self,9)
self.root=UIObject.get(self,10)
self.timeTxt=UIText.get(self,11)
self.topRoot=UIObject.get(self,12)
self.roleotem=UIObject.get(self,13)
self.ztscrollview=UIObject.get(self,14)
self.ztitemlist=UIObject.get(self,15)
self.center=UIObject.get(self,16)
self.btnlist=UIObject.get(self,17)
self.taskScroller=UIObject.get(self,18)
self.packScrollerView=UIObject.get(self,19)
self.Closebtn=UIButton.get(self,20)
self.roleotem2=UIObject.get(self,21)

self.Closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UISubAct_zushishouji:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.timebg);self.timebg=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.roleotem);self.roleotem=nil;
_UIObject_release(self.ztscrollview);self.ztscrollview=nil;
_UIObject_release(self.ztitemlist);self.ztitemlist=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.btnlist);self.btnlist=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.Closebtn);self.Closebtn=nil;
_UIObject_release(self.roleotem2);self.roleotem2=nil;
end
















local _this
local pageConfig=
{
[1]={
page=1,
name='修行',
checkReddot=function(ztid)
local flag=_this.activityData:TaskReddot(ztid)
return flag
end,
open=function(self_)
self_:openTaskPage()
end,
close=function(self_)
self_:closeTaskPage()
end,
},
[2]={
page=2,
name='礼包',
checkReddot=function(ztid)
local flag=_this.activityData:LiBaoReddot(ztid)
return flag
end,
open=function(self_)
self_:openLiBaoPage()
end,
close=function(self_)
self_:closeLiBaoPage()
end,
},
}
local ztindex=
{
ztitem=0,
bgbtn=1,
name=2,
select=3,
lock=4,
reddot=5,
select2=6,
}
local btnlistidx=
{
selfitem=0,
btn=1,
name=2,
select=3,
reddot=4,
select2=5,
}
local taskidx=
{
selfitem=0,
desc=1,
gobtn=2,
rewardbtn=3,
gotflag=4,
rewscrollview=5
}
local cmpItemIndex=
{
name=0,
item1=1,
buyLimit=6,
buyBtn=7,
freeBtn=8,
buyText=9,
resetFlag=10,
got=11,
selectBtn=12,
buyIcon=13,
content=14,
}
local contentX=
{
[0]=400,
[1]=190,
[2]=190,
[3]=260,
[4]=330,
[5]=400,
}
local itemCIndex=
{
item=0,
addRoot=1,
button=2,
change=3,
star=4,
suitIcon=5,
}
local itemIndexList={1,2,3,4,5}
local abname='ui/windows/activities/sub_zushishouji/zssj_atlas_pak.ab'



function UISubAct_zushishouji:onLoaded(...)
self:bindComponents()
_this=self
self.selectid=1
self.pageid=0
self._pageidx=1
end


function UISubAct_zushishouji:__delete()
self:unbindComponents()
self.isOver=nil
_this=nil
self:clearTimer()
end

function UISubAct_zushishouji:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UISubAct_zushishouji:onClickGotoBtn(jumpParam)
jumpManager:jump(jumpParam,nil,JUMP_BACK.eNoBack)
end

function UISubAct_zushishouji:reqGetGoalReward(ztid,taskid)

self.activityData:reqReceiveReward(ztid)
end

function UISubAct_zushishouji:onClickItem(index)
local target=self.config.jdList
local total=self.actData.TfinishNum
local flag=self.actData.jdrwMax
local d=target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num

local rewardFlag=flag>=num
local itemid=reward[1]
if fix and not rewardFlag then
self.activityData:reqReceiveJinDu()
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eCenter})
end
end


function UISubAct_zushishouji:onMenuItemClick(idx,isfresh)
if self.pageid==idx and not isfresh then
return
end
local old_idx=self.pageid
self.pageid=idx

if old_idx>0 then
local old_item=self.btnlist:getChildLayoutGroupGridItem(old_idx-1)
if old_item then

local img=self:getBtnImg(old_idx,false)
if old_idx==1 then
old_item:SetChildCSImageSprite(btnlistidx.select,abname,img)
else
old_item:SetChildCSImageSprite(btnlistidx.select2,abname,img)
end
self:refreshMenuPage(old_idx,false)
end
end
local item=self.btnlist:getChildLayoutGroupGridItem(idx-1)
if item then

local img=self:getBtnImg(idx,true)
if idx==1 then
item:SetChildCSImageSprite(btnlistidx.select,abname,img)
else
item:SetChildCSImageSprite(btnlistidx.select2,abname,img)
end
end


self:refreshMenuPage(self.pageid,true)
end
function UISubAct_zushishouji:refreshMenuPage(page,flag)
local cfg=pageConfig[page]
if flag then
cfg.open(self)
else
cfg.close(self)
end
end


function UISubAct_zushishouji:onZTItemClick(index,ztid,dayLimit)
if self.selectid==index then
return
end
local isUnLock,todayIndex=self:checkDayUnLock(dayLimit)
if not isUnLock then
local num=dayLimit-todayIndex
if num<0 then num=0 end
local curTime=timeHelper.getServerShortTime()
local todayZeroTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
local dtime=todayZeroTime+num*86400-curTime

UIManager.info(FMT.fmt("{0}后开放",timeHelper.format_time_stamp3(dtime)))
return
end

local old_index=self.selectid
self.selectid=index

if old_index>0 then
local old_item=self.ztitemlist:getChildLayoutGroupGridItem(old_index-1)
if old_item then
old_item:SetChildActive(ztindex.select,true)
old_item:SetChildActive(ztindex.select2,false)
end
end
local item=self.ztitemlist:getChildLayoutGroupGridItem(index-1)
if item then
item:SetChildActive(ztindex.select,false)
item:SetChildActive(ztindex.select2,true)
end


local pageid=1
for index=1,#pageConfig do
local pageitem=_this.btnlist:getChildLayoutGroupGridItem(index-1)
if pageitem then
local cfg=pageConfig[index]
local isReddot=cfg.checkReddot(ztid)
if isReddot then
pageid=index
end
pageitem:SetChildActive(btnlistidx.reddot,isReddot)
end
end



self:onMenuItemClick(pageid,true)
end





function UISubAct_zushishouji:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgImg:setChildUIModelShowTarget(6409,1,{},eAnimationID.stand)

end
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.actData=self.activityData.data
self.start_time_l=self.activityData.start_time_l
self.start_time=self.activityData.start_time
self.end_time=self.activityData.end_time
if not self.activityData or not self.actData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

if afterOnloaded then


local _data=self.activityData:printtask()

end


self:refreshActivityTime()










self.selectid=1
self._pageidx=self.config.pageidx
self:freshPageIndex()


self:refreshDZItem()
self:freshZTlist()
self:freshBtnlist()
self:initRewardPanel(false,true)
self:onMenuItemClick(self._pageidx,true)
end

function UISubAct_zushishouji:refreshActivityTime()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then

self.timeTxt:setText(FMT.fmt('{0}<color=#fd8950>后结束</color>',timeHelper.format_time_stamp3(lerp)))
else
self.timeTxt:setText("活动已结束")
self.isOver=true
self:clearTimer()
self:onClosebtn()
UIManager.error("活动已结束")
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_zushishouji:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_zushishouji:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
local time_str=FMT.fmt('{0}<color=#fd8950>后结束</color>',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end

function UISubAct_zushishouji:onHide()

end
function UISubAct_zushishouji:onClosebtn()
local win=UIManager:findActiveWindow('UI_activity_main_Win_onlyBg')
if win then
win:onBtnClose()
end
end



function UISubAct_zushishouji:severfreshZTReddot(actID,subType,subid)
if actID==_this.activityId and subType==_this.subType and subid==_this.subId then
local ztlist=_this.config.ztlist
local len=#ztlist
for index=1,len do
local ztid=_this.config.ztlist[index]
local item=_this.ztitemlist:getChildLayoutGroupGridItem(index-1)
local reddot=_this.activityData:SingleZTReddot(ztid)
item:SetChildActive(ztindex.reddot,reddot)

end
end
end

function UISubAct_zushishouji:severfreshBtnReddot(actID,subType,subid)
if actID==_this.activityId and subType==_this.subType and subid==_this.subId then
local ztid=_this.config.ztlist[_this.selectid]
local len=#pageConfig
for index=1,len do
local item=_this.btnlist:getChildLayoutGroupGridItem(index-1)
local cfg=pageConfig[index]
local isReddot=cfg.checkReddot(ztid)
item:SetChildActive(btnlistidx.reddot,isReddot)
end
end
end

function UISubAct_zushishouji:sever_tagReward(actID,subType,subid)
if actID==_this.activityId and subType==_this.subType and subid==_this.subId then
_this:initRewardPanel()
end
end

function UISubAct_zushishouji:sever_taskreward(actID,subType,subid,ztid)
if actID==_this.activityId and subType==_this.subType and subid==_this.subId then
local _ztid=_this.config.ztlist[_this.selectid]
if ztid and _ztid==ztid then
if _this.pageid==1 then
_this:openTaskPage()
elseif _this.pageid==2 then
_this:openLiBaoPage()
end
end
end
end

function UISubAct_zushishouji:rec_newday(actID,subType,subid)
if actID==_this.activityId and subType==_this.subType and subid==_this.subId then
_this:freshZTlist()
end
end


function UISubAct_zushishouji:freshPageIndex()
self.selectid=1

for idx,ztid in ipairs(self.config.ztlist)do
local singleReddot=self.activityData:SingleZTReddot(ztid)
if singleReddot then
self.selectid=idx
break
end
end

local ztid=self.config.ztlist[self.selectid]
local taskred=self.activityData:TaskReddot(ztid)
if taskred then
self._pageidx=1
else
local lbred=self.activityData:LiBaoReddot(ztid)
if lbred then
self._pageidx=2
end
end
end


function UISubAct_zushishouji:freshZTlist()
local ztlist=self.config.ztlist
local len=#ztlist
self.ztitemlist:setChildLayoutGroupCreateItems(len,function(index)
self:refreshSingleZT(index,ztlist[index])
end)
end
function UISubAct_zushishouji:refreshSingleZT(index,ztid)
local item=self.ztitemlist:getChildLayoutGroupGridItem(index-1)
local ztcfg=cfg_zushishoujitagconfig_get(ztid)
local dayLimit=ztcfg.dayLimit

item:SetChildText(ztindex.name,ztcfg.name)

local isUnLock=self:checkDayUnLock(dayLimit)
if isUnLock then
item:SetChildActive(ztindex.lock,false)
else
item:SetChildActive(ztindex.lock,true)
end

local reddot=self.activityData:SingleZTReddot(ztid)
item:SetChildActive(ztindex.reddot,reddot)

if self.selectid==index then
item:SetChildActive(ztindex.select,false)
item:SetChildActive(ztindex.select2,true)
else
item:SetChildActive(ztindex.select,true)
item:SetChildActive(ztindex.select2,false)
end

item:SetChildButtonClick(ztindex.bgbtn,function()
if _this==nil then return end
self:onZTItemClick(index,ztid,dayLimit)
end)
end


function UISubAct_zushishouji:freshBtnlist()
local ztid=_this.config.ztlist[_this.selectid]
local len=#pageConfig
self.btnlist:setChildLayoutGroupCreateItems(len,function(index)
self:refreshSingleBtn(index,ztid)
end)
end
function UISubAct_zushishouji:refreshSingleBtn(index,ztid)
local item=self.btnlist:getChildLayoutGroupGridItem(index-1)
local page=self.config.page
local cfg=pageConfig[index]


item:SetChildText(btnlistidx.name,page[index])


local img=self:getBtnImg(index,self.pageid==index)
if index==1 then
item:SetChildActive(btnlistidx.select,true)
item:SetChildCSImageSprite(btnlistidx.select,abname,img)
else
item:SetChildActive(btnlistidx.select2,true)
item:SetChildCSImageSprite(btnlistidx.select2,abname,img)
end




local isReddot=cfg.checkReddot(ztid)
item:SetChildActive(btnlistidx.reddot,isReddot)

item:SetChildButtonClick(btnlistidx.btn,function()
if _this==nil then return end
self:onMenuItemClick(index)
end)
end
function UISubAct_zushishouji:getBtnImg(index,flag)
if index==1 then
if flag then
return'button_zhushishouji_01'
else
return'button_zhushishouji_01A'
end
else
if flag then
return'button_zhushishouji_02'
else
return'button_zhushishouji_02A'
end
end
end

function UISubAct_zushishouji:refreshMenuItemReddot(idx)
local ztid=_this.config.ztlist[_this.selectid]
local item=self.btnlist:getChildLayoutGroupGridItem(idx-1)
local cfg=pageConfig[idx]
local isReddot=cfg.checkReddot(ztid)
item:SetChildActive(btnlistidx.reddot,isReddot)
end


function UISubAct_zushishouji:initRewardPanel(anim,isInit)
local speed=400
local stepWidth=100
local contentOffset={0,80}
self.rewardProgressBar:setChildAnchoredPosition(Vector2(contentOffset[1],-42))
self.rewardGrid:setChildAnchoredPosition(Vector2(contentOffset[1],19))

local target=self.config.jdList
local max=#target
local total=self.actData.TfinishNum
local flag=self.actData.jdrwMax
local curIndex=0
for i,d in ipairs(target)do
if total>=d[1]then
curIndex=i
end
end

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num

local rewardFlag=flag>=num



local posX=i*stepWidth
item:SetChildAnchoredPosition(-1,Vector2(posX,0))

local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=not fix
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(i)
end)

item:SetChildText(1,num)

item:SetChildActive(2,fix and rewardFlag)

item:SetChildActive(6,fix and not rewardFlag)

item:SetChildActive(3,fix and rewardFlag)

item:SetChildActive(4,fix)
end
local content_width=max*stepWidth+contentOffset[1]+contentOffset[2]
self.rewardContent:setChildSizeDelta(content_width,220)


local max_width=max*stepWidth
self.rewardProgressBar:setChildSizeDelta(max_width,8)

local cur_width
if curIndex>=max then
cur_width=max_width
elseif curIndex<=0 then
cur_width=total/target[curIndex+1][1]*stepWidth
else
local rate=(total-target[curIndex][1])/(target[curIndex+1][1]-target[curIndex][1])
cur_width=(curIndex+rate)*stepWidth
end
if anim then
local old_width=self.rewardProgressBar:getChildSizeDeltaY()
local lerp=math.abs(cur_width-old_width)
self.rewadProgress:setChildDOSizeDelta(Vector2(cur_width,8),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(cur_width,8)
end

self.rewardNumTxt:setText(tostring(total))

if isInit then
local showWidth=self.rewardScrollView:getChildRectWidth()
local moveX
local halfWidth=showWidth/2
local width=cur_width+contentOffset[1]+contentOffset[2]
if width>showWidth then
moveX=width-showWidth+halfWidth
local max_width_=content_width-halfWidth
if moveX>max_width_ then
moveX=max_width_
end
else
if width>halfWidth then
moveX=width-halfWidth
else
moveX=0
end
end
self.rewardContent:setLocalPosX(-moveX)
end
end


function UISubAct_zushishouji:openTaskPage()
local ztid=self.config.ztlist[self.selectid]
local list=self:getTaskList(ztid)
local dataNum=#list
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local data=list[i]
local taskid=data.taskid
local taskdata=data.taskdata
local cfg=cfg_zushishoujitaskconfig_get(taskid)

local isfix=data.fix
local isgot=data.isgot
local sever_finishNum=self.activityData:getGoalProgress(ztid,taskid)


if taskdata then
local _sever_finishNum=taskdata.finishNum or 0
if _sever_finishNum>sever_finishNum then
sever_finishNum=_sever_finishNum
end
end
local aimnum=cfg.aimnum



local value=''
if sever_finishNum<aimnum then
if sever_finishNum<0 then
sever_finishNum=0
end
value=FMT.fmt("（<color=#ca631d>{0}/{1}</color>）",sever_finishNum,aimnum)
else
value=FMT.fmt("（<color=#549327>{0}/{1}</color>）",aimnum,aimnum)
end

local desc=FMT.fmt(cfg.desc,value)
item:SetChildText(taskidx.desc,desc)


local jumpParam=cfg.jump
local hasJump=jumpParam~=nil
item:SetChildActive(taskidx.gobtn,false)
item:SetChildActive(taskidx.rewardbtn,false)
item:SetChildActive(taskidx.gotflag,false)


if isgot then
item:SetChildActive(taskidx.gotflag,true)
else
if isfix then

item:SetChildActive(taskidx.rewardbtn,true)
else
item:SetChildActive(taskidx.gobtn,hasJump)
end
end

item:SetChildButtonClick(taskidx.gobtn,function()
self:onClickGotoBtn(jumpParam)
end)

item:SetChildButtonClick(taskidx.rewardbtn,function()
self:reqGetGoalReward(ztid,taskid)
end)

self:setWidgetRewards(item,cfg)
end
end
end

function UISubAct_zushishouji:getTaskList(ztid)
self.canRewards={}
local list={}
local severData=self.activityData:getZTTaskData(ztid)or{}
local taskList=self.config.taskList[ztid]
for i,taskid in ipairs(taskList)do
local cfg=cfg_zushishoujitaskconfig_get(taskid)
local taskdata=severData[taskid]
local sever_finishNum=self.activityData:getGoalProgress(ztid,taskid)

local sever_rwFlag=0

local aimnum=cfg.aimnum
if taskdata then

sever_rwFlag=taskdata.rwFlag or 0
local _sever_finishNum=taskdata.finishNum or 0
if _sever_finishNum>sever_finishNum then
sever_finishNum=_sever_finishNum
end
end
local fix=sever_finishNum>=aimnum
local flag=sever_rwFlag==1
if fix and not flag then
table.insert(self.canRewards,taskid)
end
local state=0
if fix then
if flag then
state=1
else
state=-1
end
end
local weight=state*10000+i
table.insert(list,{taskid=taskid,taskdata=taskdata,fix=fix,isgot=flag,weight=weight})

end
table.sort(list,function(a,b)
return a.weight<b.weight
end)

return list
end

function UISubAct_zushishouji:setWidgetRewards(grid,cfg)
local rewardList=cfg.reward
if rewardList then
local len=#rewardList
grid:SetChildScrollViewCreateGrids(taskidx.rewscrollview,len,len)
local reward_grids=grid:GetChildScrollViewItemWidgets(taskidx.rewscrollview)
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local widget=reward_grids[j-1]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end
function UISubAct_zushishouji:closeTaskPage()
self.taskScroller:setActive(false)
end


function UISubAct_zushishouji:openLiBaoPage()
self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
local ztid=self.config.ztlist[self.selectid]
local libaoList=self.config.libaoList[ztid]
local giftAllData=self.activityData:getZTLiBaoData(ztid)or{}
self.showList=self:sortReward(libaoList,giftAllData)

self.packScrollerView:setActive(true)
self.packScrollerView:setChildScrollViewCreateGrids(#self.showList,1)
self.packScrollerView:setChildScrollViewSelectItem(0,false,false,true)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
self:refreshGiftItem(item,i,giftAllData,ztid)
end
end
end
function UISubAct_zushishouji:refreshGiftItem(cmp,sortIndex,giftAllData,ztid)
local libaodata=self.showList[sortIndex]
local libaoid=libaodata.libaoid
local listIndex=libaodata.listIndex
local cfg=cfg_zushishoujilibaoconfig_get(libaoid)
local giftData=giftAllData[libaoid]

if self.isGuoFu then
cmp:SetChildText(cmpItemIndex.name,cfg.name)
else
local index=pfwindowslController:showDescSix_ByIndex(sortIndex)
cmp:SetChildText(cmpItemIndex.name,FMT.fmt("礼包{0}",index))
end

local buyLimit=cfg.buyMax
local isZeroReset=false
local buyCount=0
if giftData then
buyCount=giftData.param_2 or 0
end
local isSold=buyCount>=buyLimit
local buyCostType
local buyCostVal

local rechargeId=cfg.rechargeId
local itemBuy=cfg.itemBuy

if rechargeId then
buyCostType=-1
buyCostVal=rechargeId
end

if itemBuy then
buyCostType=itemBuy[1][1]
buyCostVal=itemBuy[1][2]
end

if not buyCostType and not buyCostVal then
buyCostType=0
buyCostVal=0
end

local itemList=self:setRewards(cfg.reward)
local isSelectFin=true
local _len=#itemList
cmp:SetChildSizeDelta(cmpItemIndex.content,contentX[_len],80)

for i,index in ipairs(itemIndexList)do
local itemKu=itemList[i]
if itemKu then
cmp:SetChildActive(index,true)
local itemWidget=cmp:GetChildWidgetBase(index)
local num=#itemKu
local longPressFunc=function(...)
local idx=1
if not self.isOver then
idx=activitiesHandle_xianshilibao:getLiBaoSelectData(self.activityId,self.subId,listIndex,i)
end
itemsComponentHelper.onItemClickEx(itemKu[idx][1],index)
end
if num>1 then
local selectIndex=nil
if not self.isOver then
selectIndex=activitiesHandle_xianshilibao:getLiBaoSelectData(self.activityId,self.subId,listIndex,i)
end
if selectIndex then
local isYunZhouEquip=itemsConfig.isYunZhouComponents(itemKu[selectIndex][1])
itemWidget:SetChildActive(itemCIndex.item,true)
itemWidget:SetChildActive(itemCIndex.addRoot,false)
itemWidget:SetChildActive(itemCIndex.change,true)
local conf={showname=true,showcount=true,showCountBG=itemKu[selectIndex][2]>1,itemcount=itemKu[selectIndex][2]==1 and"",nomalname=true,select=false,showStageBg=not isYunZhouEquip}
local item={itemid=itemKu[selectIndex][1],itemcount=itemKu[selectIndex][2]==1 and 0 or itemKu[selectIndex][2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
itemWidget:SetChildPropData(itemCIndex.item,prop)

itemWidget:SetChildActive(itemCIndex.suitIcon,isYunZhouEquip)
itemWidget:SetChildActive(itemCIndex.star,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(itemKu[selectIndex][1])
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
itemWidget:SetChildIcon(itemCIndex.suitIcon,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=itemWidget:GetChildWidgetBase(itemCIndex.star)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end
itemWidget:SetChildLongTouch(itemCIndex.button,i,0.5,longPressFunc)
itemWidget:SetChildButtonClick(itemCIndex.change,function()
if not isSold then
self:onAddClick(listIndex,sortIndex,itemList)
end
end)
else
isSelectFin=false
itemWidget:SetChildActive(itemCIndex.star,false)
itemWidget:SetChildActive(itemCIndex.suitIcon,false)
itemWidget:SetChildActive(itemCIndex.item,false)
itemWidget:SetChildActive(itemCIndex.addRoot,true)
itemWidget:SetChildLongTouch(itemCIndex.button,i,0.5,nil)
itemWidget:SetChildActive(itemCIndex.change,false)
end
itemWidget:SetChildActive(itemCIndex.button,true)
itemWidget:SetChildButtonClick(itemCIndex.button,function()
if not isSold then
self:onAddClick(listIndex,sortIndex,itemList)
end
end)
else
local isYunZhouEquip=itemsConfig.isYunZhouComponents(itemKu[1][1])
itemWidget:SetChildActive(itemCIndex.change,false)
itemWidget:SetChildActive(itemCIndex.item,true)
itemWidget:SetChildActive(itemCIndex.addRoot,false)
itemWidget:SetChildActive(itemCIndex.button,true)
local conf={showname=false,showcount=true,showCountBG=itemKu[1][2]>1,itemcount=itemKu[1][2]==1 and"",nomalname=true,select=false,showStageBg=not isYunZhouEquip}
local item={itemid=itemKu[1][1],itemcount=itemKu[1][2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
itemWidget:SetChildPropData(itemCIndex.item,prop)

itemWidget:SetChildActive(itemCIndex.suitIcon,isYunZhouEquip)
itemWidget:SetChildActive(itemCIndex.star,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(itemKu[1][1])
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
itemWidget:SetChildIcon(itemCIndex.suitIcon,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=itemWidget:GetChildWidgetBase(itemCIndex.star)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end
itemWidget:SetChildButtonClick(itemCIndex.button,function()
itemsComponentHelper.onItemClickEx(itemKu[1][1],index)
end)
itemWidget:SetChildLongTouch(itemCIndex.button,i,0.5,longPressFunc)
end
else
cmp:SetChildActive(index,false)
end
end
local isActiveFreeBtn=false
local isActiveBuyBtn=false
local isActiveselectBtn=false
if isSelectFin then
isActiveselectBtn=false
isActiveBuyBtn=not isSold
isActiveFreeBtn=false
if buyCostType==-1 then

local rconfig=cfgHelper.get(cfg_rechargeconfig_get,buyCostVal)
local str=pfwindowslController:showDescFour_ByMoneyType(rconfig)
cmp:SetChildText(cmpItemIndex.buyText,str)
cmp:SetChildActive(cmpItemIndex.buyIcon,false)
cmp:SetChildLocalPosX(cmpItemIndex.buyText,0)
else
if buyCostVal==0 then

isActiveFreeBtn=not isSold
isActiveBuyBtn=false
cmp:SetChildButtonClick(cmpItemIndex.freeBtn,function()
self:onBuyClick(listIndex,buyCostType,buyCostVal,itemList,buyCount,buyLimit,ztid,libaoid)
end,true)
else

isActiveFreeBtn=false
local iconName=iconHelper.getIconName(buyCostType)
cmp:SetChildLocalPosX(cmpItemIndex.buyText,10)
cmp:SetChildActive(cmpItemIndex.buyIcon,true)
cmp:SetChildIcon(cmpItemIndex.buyIcon,iconName,true)
cmp:SetChildText(cmpItemIndex.buyText,buyCostVal)
end
end
cmp:SetChildButtonClick(cmpItemIndex.buyBtn,function()
self:onBuyClick(listIndex,buyCostType,buyCostVal,itemList,buyCount,buyLimit,ztid,libaoid)
end,true)
else
isActiveFreeBtn=false
isActiveBuyBtn=false
isActiveselectBtn=not isSold
cmp:SetChildButtonClick(cmpItemIndex.selectBtn,function()
self:onAddClick(listIndex,sortIndex,itemList)
end,true)
end
cmp:SetChildText(cmpItemIndex.buyLimit,(isSold or buyCostVal==0)and""or FMT.fmt("限购：{0}/{1}",buyCount,buyLimit))
cmp:SetChildActive(cmpItemIndex.freeBtn,isActiveFreeBtn)
cmp:SetChildActive(cmpItemIndex.buyBtn,isActiveBuyBtn)
cmp:SetChildActive(cmpItemIndex.got,isSold)
cmp:SetChildActive(cmpItemIndex.selectBtn,isActiveselectBtn)
cmp:SetChildActive(cmpItemIndex.resetFlag,isZeroReset==1)
end
function UISubAct_zushishouji:setRewards(reward)
local list={}
for k,v in ipairs(reward)do
table.insert(list,{v})
end
return list
end

function UISubAct_zushishouji:sortReward(libaoList,giftAllData)
local showList={}



for i,libaoid in ipairs(libaoList)do
local cfg=cfg_zushishoujilibaoconfig_get(libaoid)
local sortId=i
local item={}
local listIndex=i
item.listIndex=listIndex
item.sortId=sortId
item.libaoid=libaoid

local giftData=giftAllData[libaoid]
if giftData then
local buyCount=giftData.param_2 or 0
local buyLimit=cfg.buyMax











local isSold=buyCount>=buyLimit
if isSold then
item.sortId=sortId+10000
end
end
local isCanShow=true
if isCanShow then
table.insert(showList,item)
end
end
table.sort(showList,function(a,b)
return a.sortId<b.sortId
end)
return showList
end

function UISubAct_zushishouji:onBuyClick(listIndex,buyCostType,buyCostVal,itemList,buyCount,buyLimit,ztid,libaoid)

if self.isOver or(not self.config)then
UIManager.error("活动已结束")
return
end
local showItem={}
local indexList={}
for i,v in ipairs(itemList)do
local selectIndex=false
if selectIndex then
indexList[i]=selectIndex
table.insert(showItem,v[selectIndex])
else
indexList[i]=1
table.insert(showItem,v[1])
end
end
local conf={}
for i,v in ipairs(showItem)do
local itemid=v[1]
local count=v[2]
table.insert(conf,{itemid=itemid,num=count})
end
if buyCostVal==0 then

self.activityData:reqReceiveFreeLiBao(ztid)
self.showRewardFunc=function()
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
end
if buyCostType==-1 then

if self.payTimer then
return
end
local rechargeAmount=payControl:getRechargeAmount(buyCostVal)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)
local buyFunc=function(count,isItem)
if(not self.config)then
UIManager.error("活动已结束")
return
end
local info={ztid,libaoid,count}
for i,v in ipairs(indexList)do
table.insert(info,v)
end
local params=payControl.getActivityPayParams(self.activityId,self.subType,self.subId,info)
if isItem then
local pram=jsonHelper.encode({buyCostVal,params})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
local batch_buy=self.config.batch_buy or{}
if batch_buy[buyCostVal]and batch_buy[buyCostVal][count]then
buyCostVal=batch_buy[buyCostVal][count]
end
payControl.reqPay(buyCostVal,count,params)
end
self.showRewardFunc=function()
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
if not self.payTimer then
self.payTimer=self:setTimer(1,1,function()
self.payTimer=nil
end)
end
end
local batchBuyFixedNum=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.batchBuyFixedNum)
if buyLimit-buyCount>1 and voucherCount>=twoTimeCostNum then
local args={
rewards=showItem,
name="礼包",
price={titemid,rechargeAmount},
leftNum=buyCount,
maxcount=buyLimit,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end
}
UIManager:showWindow("UICommonBuyDialogWin",args)
elseif buyLimit-buyCount>=10 and batchBuyFixedNum then
local args={
rewards=showItem,
name="礼包",
leftNum=buyCount,
maxcount=buyCount+2,
numArray={1,10},
isCheckMaxSelectCount=true,
}
args.callback=function(num)
buyFunc(num,false)
end
UIManager:showWindow("UIFBuyFixedNumDialogWin",args)
else
buyFunc(1,false)
end
else

if buyLimit-buyCount>1 then
UIManager:showWindow("UICommonBuyDialogWin",{rewards=showItem,name="礼包",price={buyCostType,buyCostVal},leftNum=buyCount,maxcount=buyLimit,isCheckMaxSelectCount=true,callback=function(num)
if self.isOver then
UIManager.error("活动已结束")
return
end
self.activityData:reqBuyLiBao(ztid,libaoid,num)
self.showRewardFunc=function()
local conf={}
for i,v in ipairs(showItem)do
local itemid=v[1]
local count=v[2]*num
table.insert(conf,{itemid=itemid,num=count})
end
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
end})
else
local flag=moneySystem:useMoney(buyCostType,buyCostVal,function(...)
self.activityData:reqBuyLiBao(ztid,libaoid,1)
self.showRewardFunc=function()
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
end,WARNING_TYPE.eWarning)
end
end
end
function UISubAct_zushishouji:closeLiBaoPage()
self.packScrollerView:setActive(false)
end


function UISubAct_zushishouji:refreshDZItem()
local dzModelParam2=self.config.dzModelParam2
if dzModelParam2 then
self.roleotem:setActive(false)
local widegt2=self.roleotem2:getWidgetBase()
local itemID=dzModelParam2.itemID
local spineID=dzModelParam2.spineID
local scale=dzModelParam2.scale
local flipx=dzModelParam2.flipx

widegt2:SetChildUIModelEnableInitUISpinePara(0,true,true)
widegt2:SetChildUIModelShowTarget(0,spineID,scale,{},eAnimationID.stand)
widegt2:SetChildUIModelShowTargetOffset(0,dzModelParam2.offset[1],dzModelParam2.offset[2])
widegt2:SetChildUIModelShowFlipX(0,flipx)

widegt2:SetChildButtonClick(1,function()
if _this==nil then return end
self:onViewBtn(itemID)
end)
else
self.roleotem:setActive(true)
local dzModelParam=self.config.dzModelParam
local widegt=self.roleotem:getWidgetBase()
local itemID=dzModelParam.itemID
local typo=dzModelParam.typo
local scale=dzModelParam.scale
local flipx=dzModelParam.flipx
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

local modelParams
local anim
if typo==1 then
local args={isNotBg=true}
modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
anim=dzModelParam.animId or eAnimationID.stand
else
modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
anim=dzModelParam.animId or eAnimationID.stand
end
widegt:SetChildUIModelEnableInitUISpinePara(0,true,true)
widegt:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,anim,true)
widegt:SetChildUIModelShowTargetOffset(0,dzModelParam.offset[1],dzModelParam.offset[2])
widegt:SetChildUIModelShowFlipX(0,flipx)


widegt:SetChildButtonClick(1,function()
if _this==nil then return end
self:onViewBtn(itemID)
end)
end
end
function UISubAct_zushishouji:onViewBtn(itemid)
UIRecruitControl:showItemDiscipleInfoByItemId2(itemid)
end



function UISubAct_zushishouji:checkDayUnLock(day)

local todayIndex=self.activityData:getOpenDayIndex()
if todayIndex==0 then
local nowTime=timeHelper.getServerLongTime()
if nowTime==self.start_time_l then

todayIndex=1
end
end
local isUnLock=todayIndex>=day
return isUnLock,todayIndex
end


function UISubAct_zushishouji:testttttt()
local ztid=_this.config.ztlist[_this.selectid]
local giftAllData=_this.activityData:getZTLiBaoData(ztid)or{}

end

function UISubAct_zushishouji:testttttt2()
local list={358,359,360,361,362,363,364,365,366,367,368,369}
for k,taskid in ipairs(list)do
local sever_finishNum=_this.activityData:getGoalProgress(1,taskid)

end
end

function UISubAct_zushishouji:testttttt3()
local ztid=_this.config.ztlist[_this.selectid]
local list=_this:getTaskList(ztid)
for k,data in ipairs(list)do
local taskid=data.taskid
local taskdata=data.taskdata
local cfg=cfg_zushishoujitaskconfig_get(taskid)

end
end

function UISubAct_zushishouji:testttttt4()
local data=_this.activityData:printtask()

end









def_class("UIXM_ZZSH_WeekTaskWin",UIWindowBase)









function UIXM_ZZSH_WeekTaskWin:bindComponents()

self.TaskList=UIObject.get(self,0)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,1)
self.notLog=UIObject.get(self,2)
self.remianTimerTips=UIText.get(self,3)
self.resetTimerTips=UIText.get(self,4)
self.rewardProgressBar=UIObject.get(self,5)
self.rewadProgress=UIObject.get(self,6)
self.rewardGrid=UIObject.get(self,7)
self.completeTaskCount=UIText.get(self,8)
self.rewardContent=UIObject.get(self,9)
self.PvePanel=UIObject.get(self,10)
self.PvPPanel=UIObject.get(self,11)



end


function UIXM_ZZSH_WeekTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.TaskList);self.TaskList=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.remianTimerTips);self.remianTimerTips=nil;
_UIObject_release(self.resetTimerTips);self.resetTimerTips=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.completeTaskCount);self.completeTaskCount=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.PvePanel);self.PvePanel=nil;
_UIObject_release(self.PvPPanel);self.PvPPanel=nil;
end


















local _this



local UIXM_ZZSH_WeekTaskItem=
{
itemList=0,
taskText=1,
goBtn=2,
rewardBtn=3,
complete=4,
dagou=5,
}

local stringF=string.format


function UIXM_ZZSH_WeekTaskWin:onLoaded(...)
_this=self
self:bindComponents()
self:bindEnScroller()
end


function UIXM_ZZSH_WeekTaskWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXM_ZZSH_WeekTaskWin:onShow(argtable,afterOnloaded)
self.allcfg=zhengzhanshanhaiController:getZZSHCfg_weekTaskAllCfg()
local isShowTask=zhengzhanshanhaiModel:getIsShowTask()
self.PvePanel:setActive(isShowTask)
self.PvPPanel:setActive(not isShowTask)
if isShowTask then
self.target=zhengzhanshanhaiModel:getTargetRewardList()
self:initTargetPanel(false,true)
self.taskList=zhengzhanshanhaiModel:getSortTaskList()
self.enhancedscrollscript:initData(self.taskList,129,#self.taskList)
self:setCompleteCount()
end
self:setRemianTimerTips()
end


function UIXM_ZZSH_WeekTaskWin:onHide()
UIManager:invokeUIMethod("UIXM_ZZSH_PvEMainWin","checkWeekTaskOpen")
end


local UIWeekTaskEnScroller=simple_class(UIEnhancedScroller)

function UIXM_ZZSH_WeekTaskWin:bindEnScroller()

self.enhancedscrollscript=UIWeekTaskEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
end



function UIXM_ZZSH_WeekTaskWin:initTargetPanel(anim,isInit)
local target=self.target
local speed=400
local stepWidth=90
local contentOffset={70,0}
local max=#target


local flag=zhengzhanshanhaiModel:get_ex_reward_flag()
local total=zhengzhanshanhaiModel:getcompleteTaskCount()
local curIndex=zhengzhanshanhaiModel:getWeekTaskTargetRewardIndex()

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local posX=i*stepWidth
item:SetChildAnchoredPosition(-1,Vector2(posX,0))

local rewardFlag=zhengzhanshanhaiModel:checkTargetReddot_byIndex(flag,i)

local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGot=(fix and not rewardFlag)
local grayNum=isGot and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=grayNum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(i)
end)

item:SetChildText(1,num)

item:SetChildActive(2,isGot)

item:SetChildActive(3,(fix and rewardFlag))
item:SetChildActive(5,isGot)
end

local content_width=max*stepWidth+contentOffset[1]+contentOffset[2]
self.rewardContent:setChildSizeDelta(content_width,117)


local max_width=max*stepWidth
self.rewardProgressBar:setChildSizeDelta(max_width,20)

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
self.rewadProgress:setChildDOSizeDelta(Vector2(cur_width,12),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(cur_width,12)
end

if isInit then
local showWidth=501
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


function UIXM_ZZSH_WeekTaskWin:onClickItem(index)
local total=zhengzhanshanhaiModel:getcompleteTaskCount()
local flag=zhengzhanshanhaiModel:get_ex_reward_flag()



local d=self.target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,index-1)

local itemid=reward[1]
if fix and not rewardFlag then
zhengzhanshanhaiController:req_weekTaskReward(0)
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end
end

function UIXM_ZZSH_WeekTaskWin:onCloseClick()
self:closeSelf()
end



function UIXM_ZZSH_WeekTaskWin:setRemianTimerTips()
local raceState=zhengzhanshanhaiModel:getLunState()
local startTime,endTime
if raceState==eZZSH_State.ePVEFight then
startTime,endTime=zhengzhanshanhaiModel:getPvETime()
else
startTime,endTime=zhengzhanshanhaiModel:getPvPTime()
end
if endTime then
local IsShowTask=zhengzhanshanhaiModel:getIsShowTask()
local isAddTime=zhengzhanshanhaiModel:isAddTime()
if isAddTime then
if raceState==eZZSH_State.ePVEFight then
startTime,endTime=zhengzhanshanhaiModel:getPvETime()
endTime=endTime+(86400*7)
else
startTime,endTime=zhengzhanshanhaiModel:getPvETime()
end
end

local func=function()
if _this then
local leftTime=(endTime-gameUtilityModel.getServerLongTime())
if leftTime>0 then
if IsShowTask then

self.remianTimerTips:setText(FMT.fmt("<color=#994E25>本期剩余时间：</color>{0}",timeHelper.format_time_stamp11(leftTime,true)))
else
self.resetTimerTips:setText(FMT.fmt("<color=#FF0B0B>{0}</color>后重置任务",timeHelper.format_time_stamp11(leftTime,true)))
end
else
_this:stopTimerByID(_this.pvetimer)
end
end
end
if not self.pvetimer then
self.pvetimer=self:setTimer(1,0,func)
end
func()
end
end



function UIXM_ZZSH_WeekTaskWin:setCompleteCount()
local count=zhengzhanshanhaiModel:getcompleteTaskCount()
self.completeTaskCount:setText(count)
end



function UIXM_ZZSH_WeekTaskWin:RefreshShow()
self:doRefreshActiveCellViews()
self:setCompleteCount()
self:initTargetPanel(true,false)
end



function UIXM_ZZSH_WeekTaskWin:doRefreshActiveCellViews()
self.taskList=zhengzhanshanhaiModel:getSortTaskList()
self.enhancedscrollscript:doRefreshActiveCellViews()
end


function UIWeekTaskEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIWeekTaskEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIWeekTaskEnScroller:RefreshCell(dataIndex,cellIndex,cell)


local curdata=_this.taskList[dataIndex].Data
local complete_cnt,rewardflag,needComplete_cnt=zhengzhanshanhaiModel:getComplete_cntAndrewardflag(curdata)
local curCfg=_this.allcfg[curdata.id]

local desc
if complete_cnt>=needComplete_cnt then
desc=stringF("(<color=%s>%s</color>)",FONT_COLOR_VAL[FONT_COLOR.eGreenColor],stringF("%s/%s",needComplete_cnt,needComplete_cnt))
else
desc=stringF("(<color=%s>%s</color>)",FONT_COLOR_VAL[FONT_COLOR.eRedColor],stringF("%s/%s",complete_cnt,needComplete_cnt))
end
cell:SetChildText(UIXM_ZZSH_WeekTaskItem.taskText,stringF("%s%s",curCfg.Desc,desc))

local rewardList=curCfg.rewards
cell:SetChildLayoutGroupCreateItems(UIXM_ZZSH_WeekTaskItem.itemList,#rewardList)
cell:SetChildButtonClickWithID(UIXM_ZZSH_WeekTaskItem.goBtn,function(id)self:onClickGoBtn_EnScroller(id)end,dataIndex)
cell:SetChildButtonClickWithID(UIXM_ZZSH_WeekTaskItem.rewardBtn,function(id)self:onClickRewardBtn_EnScroller(id)end,dataIndex)

local grids=cell:GetChildLayoutGroupGridList(UIXM_ZZSH_WeekTaskItem.itemList)
for i=1,#rewardList do
local widget=grids[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=mathHelper.formatNumber(count),showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickItem_EnScroller(...)
end)
end
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.goBtn,false)
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.rewardBtn,false)
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.complete,false)
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.dagou,false)
if rewardflag~=1 then
if complete_cnt>=needComplete_cnt then
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.rewardBtn,true)
else
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.goBtn,true)
end
else
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.complete,true)
cell:SetChildActive(UIXM_ZZSH_WeekTaskItem.dagou,true)
end
end

function UIWeekTaskEnScroller:onClickItem_EnScroller(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end


function UIWeekTaskEnScroller:onClickGoBtn_EnScroller(dataIndex,cellIndex,cell)
local curdata=_this.taskList[dataIndex].Data
local curCfg=_this.allcfg[curdata.id]
local jumpParam=curCfg.Jump
if jumpParam then
local jumpType=0
local jumpId=jumpParam.id
local args=jumpParam.args
local backFlag=nil
if jumpId==JUMP_TYPE.eShiLianTa then
backFlag=JUMP_BACK.eForceBack
elseif jumpId==JUMP_TYPE.eDouFaTai then
backFlag=JUMP_BACK.eNoBack
end
_this:onCloseClick()
jumpManager:jump({type=jumpType,id=jumpId,args=args},nil,backFlag)
end
end

function UIWeekTaskEnScroller:onClickRewardBtn_EnScroller(dataIndex,cellIndex,cell)

zhengzhanshanhaiController:req_weekTaskReward(1)
end

function UIWeekTaskEnScroller:onItemClick(dataIndex,cellIndex,cell)

end


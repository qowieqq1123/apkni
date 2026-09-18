







def_class("UIBaoLingShuPickUp_TargetWin",UIWindowBase)









function UIBaoLingShuPickUp_TargetWin:bindComponents()

self.pickUpTime=UIText.get(self,0)
self.listScroller=UIObject.get(self,1)
self.pickUpAd=UIImage.get(self,2)
self.bgModel=UIObject.get(self,3)



end


function UIBaoLingShuPickUp_TargetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pickUpTime);self.pickUpTime=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.pickUpAd);self.pickUpAd=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this=nil
local taskItemIndex={
select=0,
taskDesc=1,
rewardList=2,
getRewardBtn=3,
gotFlag=4,
gotoBtn=5,
}



function UIBaoLingShuPickUp_TargetWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIBaoLingShuPickUp_TargetWin:__delete()
self:clearTimer()
self:unbindComponents()
_this=nil
end




function UIBaoLingShuPickUp_TargetWin:onShow(argtable,afterOnloaded)
self.allTaskCfg=cfg_baolingtreegoalconfig()


local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
if not isInPickUpNow then
UIManager.error("本期许愿目标已结束")
UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
return
end
if afterOnloaded then
if webGLHelper:isRunWebGL()then
local abName=webGLHelper:getReplaceResourceAB('baoLingShuLiBaoMuBiaoBG')
self.bgModel:setSprite(abName[1],abName[2])
else

self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),4858,1,{},eAnimationID.stand)
end
end

local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
self.endTime=eTime

self:refresh(afterOnloaded)
end


function UIBaoLingShuPickUp_TargetWin:onHide()
self:clearTimer()
end

function UIBaoLingShuPickUp_TargetWin:refresh(isInit)
if isInit then

self:refreshTaskList()
end


self:setRemainingTimeTimer()
end


function UIBaoLingShuPickUp_TargetWin:refreshTaskList()
self:sortTaskCfgList()
local count=#self.taskSortList
self.listScroller:setChildScrollViewCreateGrids(count,1)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTaskItem(grids[i-1],i)

end
end


function UIBaoLingShuPickUp_TargetWin:sortTaskCfgList()
self.taskSortList={}
local nowMaxGotRewardId=baoLingShuModel:getGotTargetRewardMaxId()or 0
for i,v in ipairs(self.allTaskCfg)do
local isGot=nowMaxGotRewardId>=i
local sortWeight=i
if isGot then
sortWeight=sortWeight+1000
end
local task={id=i,needCount=v.xynum,sortWeight=sortWeight,isGot=isGot,reward=v.items}
table.insert(self.taskSortList,task)
end
table.sort(self.taskSortList,function(a,b)return a.sortWeight<b.sortWeight end)
end


function UIBaoLingShuPickUp_TargetWin:refreshTaskItem(item,index)
if item==nil then
item=self.listScroller:getChildScrollViewItemWidget(index-1)
end


local taskData=self.taskSortList[index]
if item and taskData then

local needCount=taskData.needCount
local drawNum=baoLingShuModel:getTotalGBDrawNum()
local isFinish=drawNum>=needCount
local isGot=taskData.isGot
local descStr
if isFinish then
descStr=FMT.fmt("宝灵树许愿{0}次<color=#ca631d>（{1}/{0}）</color>",needCount,drawNum)
else
descStr=FMT.fmt("宝灵树许愿{0}次（{1}/{0}）",needCount,drawNum)
end
item:SetChildText(taskItemIndex.taskDesc,descStr)


item:SetChildActive(taskItemIndex.gotoBtn,not isFinish)
item:SetChildButtonClick(taskItemIndex.gotoBtn,function()
self:onClickGotoBtn()
end)


item:SetChildActive(taskItemIndex.getRewardBtn,isFinish and not isGot)
item:SetChildButtonClick(taskItemIndex.getRewardBtn,function()
self:onClickGetRewardBtn(taskData.id)
end)


item:SetChildActive(taskItemIndex.gotFlag,isFinish and isGot)





local rewardList=taskData.reward or{}
local grids=item:GetChildCommonLayoutGroupWidgetList(taskItemIndex.rewardList)

for i=1,grids.Count do
local widget=grids[i-1]
local reward=rewardList[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end

end

end

function UIBaoLingShuPickUp_TargetWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerLongTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.pickUpTime:setText(FMT.fmt("重置时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

else
self.pickUpTime:setText("活动已结束")
UIManager.error("本期许愿目标已结束")
self:clearTimer()

return UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
end
end
func()
self.timer=self:setTimer(1,0,func)
end



function UIBaoLingShuPickUp_TargetWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIBaoLingShuPickUp_TargetWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UIBaoLingShuPickUp_TargetWin:onClickGetRewardBtn(taskId)


baoLingShuController:req_getBLSPickUpTargetReward()
end


function UIBaoLingShuPickUp_TargetWin:onClickGotoBtn()


UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
end
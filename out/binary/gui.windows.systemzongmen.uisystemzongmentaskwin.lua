







def_class("UISystemZongMenTaskWin",UIWindowBase)









function UISystemZongMenTaskWin:bindComponents()

self.root=UIObject.get(self,0)
self.none=UIObject.get(self,1)
self.taskDesc=UIText.get(self,2)
self.lockTipsBg=UIObject.get(self,3)
self.completed=UIObject.get(self,4)
self.jumpBtn=UIButton.get(self,5)
self.rewardBtn=UIButton.get(self,6)
self.getBtn=UIButton.get(self,7)
self.goodGrid=UIObject.get(self,8)
self.taskName=UIText.get(self,9)
self.taskCondition=UIObject.get(self,10)
self.lockTips=UIText.get(self,11)
self.taskConditionTxt=UIText.get(self,12)
self.rewardBtnTx=UIText.get(self,13)
self.taskModel=UIObject.get(self,14)
self.taskIcon=UIImage.get(self,15)
self.taskSpeDesc=UIObject.get(self,16)
self.taskProgressDesc=UIText.get(self,17)
self.taskIconObj=UIObject.get(self,18)
self.taskCostNum=UIText.get(self,19)
self.taskCostItem=UIBaseItem.get(self,20)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.getBtn:setButtonClick(function()self:onGetBtn()end)



end


function UISystemZongMenTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.taskDesc);self.taskDesc=nil;
_UIObject_release(self.lockTipsBg);self.lockTipsBg=nil;
_UIObject_release(self.completed);self.completed=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.getBtn);self.getBtn=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
_UIObject_release(self.taskName);self.taskName=nil;
_UIObject_release(self.taskCondition);self.taskCondition=nil;
_UIObject_release(self.lockTips);self.lockTips=nil;
_UIObject_release(self.taskConditionTxt);self.taskConditionTxt=nil;
_UIObject_release(self.rewardBtnTx);self.rewardBtnTx=nil;
_UIObject_release(self.taskModel);self.taskModel=nil;
_UIObject_release(self.taskIcon);self.taskIcon=nil;
_UIObject_release(self.taskSpeDesc);self.taskSpeDesc=nil;
_UIObject_release(self.taskProgressDesc);self.taskProgressDesc=nil;
_UIObject_release(self.taskIconObj);self.taskIconObj=nil;
_UIObject_release(self.taskCostNum);self.taskCostNum=nil;
_UIObject_release(self.taskCostItem);self.taskCostItem=nil;
end















local _this=nil
local _costTask={
[taskTypeClientCheckType.eCostGoodNum]=true
}



function UISystemZongMenTaskWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)


notifySystem:listenNotify(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
end


function UISystemZongMenTaskWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)


notifySystem:removelistener(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
end




function UISystemZongMenTaskWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eTask)then
self:refreshData()
self:refreshView(true)
end
end


function UISystemZongMenTaskWin:onHide()

end



function UISystemZongMenTaskWin:onGetBtn()
local taskInfo=taskModel:getTaskInfo(self.taskId)
local taskState=taskModel:getTaskState_transfromstate(taskInfo)
if taskState==taskModel.taskAcceptState then
local fit,str=taskModel:fitAcceptCondition(self.taskId)
if fit then

taskController:doAcceptTask(self.taskId)
else
UIManager.error(str)
end
end
end

function UISystemZongMenTaskWin:onRewardBtn()
local taskInfo=taskModel:getTaskInfo(self.taskId)
local taskState=taskModel:getTaskState_transfromstate(taskInfo)
if taskState==taskModel.taskRewardState then

taskController:doGetTaskReward(self.taskId)
end
end

function UISystemZongMenTaskWin:onJumpBtn()
local taskInfo=taskModel:getTaskInfo(self.taskId)
local taskState=taskModel:getTaskState_transfromstate(taskInfo)
if taskState==taskModel.taskDoingState then
taskController:doJump(self.taskId)
end
end

function UISystemZongMenTaskWin:refreshData()
self.dataInfo=systemZongMenModel:getInfoData(self.serial)
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eTask)
self.zmCfg=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)

local renown=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
self.renownIdx=systemZongMenModel:getRenownIndex(self.dataInfo.id,renown)

local lastTaskId=self.detailInfo.taskId
if lastTaskId>0 then
local cfg=cfgHelper.get1(cfg_taskconfig_get,lastTaskId)
self.taskId=cfg.nextid
else
if taskModel:hasTask(self.zmCfg.firstTaskId)then
self.taskId=self.zmCfg.firstTaskId
end
end

self.limitIdx=-1
if self.taskId then
for i,v in ipairs(self.zmCfg.renownRewards)do
for j,w in ipairs(v)do
if w[1]==systemZongMenRenownRewardType.eTask then







if w[2]<=self.taskId then
self.limitIdx=math.max(self.limitIdx,i)
end
end
end
end
end
end

function UISystemZongMenTaskWin:refreshView(init)
if not self.taskId then
self.root:setActive(false)
self.none:setActive(true)
return
end

local taskInfo=taskModel:getTaskInfo(self.taskId)
if taskInfo==nil then
return
end
local taskstateResult=taskModel:getTaskState(taskInfo)
local taskState=taskstateResult.state
local taskcfg=taskInfo.cfg
self.root:setActive(true)
self.none:setActive(false)

if init then
local name_str=taskcfg.name
local zmName=systemZongMenModel:getNameStr(self.dataInfo.id,self.dataInfo.nameIdx)
local descStr=string.replace(taskcfg.taskdesc,'[ZM]',zmName)





self.taskName:setText(name_str)
self.taskDesc:setText(descStr)

local aimicon=taskcfg.aimicon
local showIcon=nil
local showModel=nil
if aimicon~=nil then
if aimicon[1]==1 then
showIcon=aimicon[2]
elseif aimicon[1]==2 then
showModel=aimicon[2]
end
end
self.taskIcon:setActive(showIcon~=nil)
if showIcon then
self.taskIcon:setImageIcon(iconHelper.getIconName(showIcon),true)
end
self.taskModel:setActive(showModel~=nil)
if showModel then
local models=cfgHelper.get2(cfg_monijybuildconfig_get,showModel[1],'model')
local lv=showModel[2]
local modelID=models[lv]
local scale=isometricMapSystem:getModelScale(modelID,true)
self.taskModel:setChildUIModelShowTarget(modelID,scale*showModel[3],nil,eAnimationID.bd_stand)
end
self.taskIconObj:setActive(aimicon~=nil)

local rewardlist=taskModel:getTaskRewardList(self.taskId)
if taskcfg.syssectRewards then
local list={}
for moneyType,num in pairsBySortKey(taskcfg.syssectRewards)do
local itemId=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"money_show_item",moneyType)
table.insert(list,{itemId,num})
end
rewardlist=table.concatTableXX(list,rewardlist)
end
self.goodGrid:setChildLayoutGroupCreateItems(#rewardlist,function(index)
local item=self.goodGrid:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardlist[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
end

if _costTask[taskcfg.tasktype]then
self.taskProgressDesc:setText("")
self.taskSpeDesc:setActive(true)
local itemId=taskcfg.params[1]
local needNum=taskcfg.aimnum
local haveNum=itemsModel.getCount(itemId)
local countStr=FMT.fmt("{0}/{1}",mathHelper.formatNumber(haveNum),mathHelper.formatNumber(needNum))
if needNum>haveNum then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
local conf={itemid=itemId,itemcount="",showname=false,showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.taskCostItem:setChildPropData(prop)
self.taskCostItem:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
self.taskCostNum:setText(countStr)
self.rewardBtnTx:setText("提交材料")
else
local desc_str=taskcfg.taskaimdesc
local progress_str
if taskState~=taskModel.taskAcceptState then
local cur=taskstateResult.curnum
local max=taskstateResult.maxnum
if cur>=max then
progress_str=FMT.fmt('<color=#549327>{0}/{1}</color>',cur,max)
else
progress_str=FMT.fmt('<color=#c82c2c>{0}/{1}</color>',cur,max)
end
progress_str=FMT.fmt('进度：{0}',progress_str)
end
if progress_str~=nil then
desc_str=FMT.fmt('{0}\n{1}',desc_str,progress_str)
end
self.taskProgressDesc:setText(desc_str)
self.taskSpeDesc:setActive(false)
self.rewardBtnTx:setText("领 取")
end

local lock=self.renownIdx<self.limitIdx
local lockStr=lock and FMT.fmt("声望达到{0}或以上可接取",systemZongMenModel:getRenownName(self.limitIdx))or""
self.lockTips:setText(lockStr)
self.lockTipsBg:setActive(lock)
self.getBtn:setActive(not lock and taskState==taskModel.taskAcceptState)
self.jumpBtn:setActive(not lock and taskState==taskModel.taskDoingState)
self.rewardBtn:setActive(not lock and taskState==taskModel.taskRewardState)

end

function UISystemZongMenTaskWin.onSystemZMDetailInfo(partType,serial)
if mathHelper.compareInt64(_this.serial,serial)and partType==systemZongMenDetailDataPart.eTask then
_this:refreshData()
_this:refreshView(true)
end
end

function UISystemZongMenTaskWin.onTaskChange(taskid,new_state,cur_num,old_num)
if _this.taskId then
local cTaskCfg=cfgHelper.get1(cfg_taskconfig_get,taskid)
local sTaskCfg=cfgHelper.get1(cfg_taskconfig_get,_this.taskId)
if cTaskCfg.tasklineid==sTaskCfg.tasklineid then
local init=_this.taskId~=taskid or new_state==taskModel.taskAcceptState
_this:refreshData()
_this:refreshView(init)
end
end
end













function UISystemZongMenTaskWin.onSystemZMMoneyNumChange(serial,money_type,val,oldVal)
if mathHelper.compareInt64(_this.serial,serial)and money_type==systemZongMenInfoMoneyType.eShengWang then
local newIdx=systemZongMenModel:getRenownIndex(_this.dataInfo.id,val)
if newIdx~=_this.renownIdx then
_this:refreshView(false)
end
end
end

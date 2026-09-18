







def_class("UIZongMenXianTuInfoWin",UIWindowBase)









function UIZongMenXianTuInfoWin:bindComponents()

self.background=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.shield=UIObject.get(self,2)
self.content=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.titleImg=UIImage.get(self,5)
self.descTx=UIText.get(self,6)
self.taskView=UIObject.get(self,7)
self.rewardList=UIObject.get(self,8)
self.stageBtn=UIButton.get(self,9)
self.rewardBtn=UIButton.get(self,10)
self.payBtn=UIButton.get(self,11)
self.progressTx=UIText.get(self,12)
self.getted=UIObject.get(self,13)
self.stageReddot=UIObject.get(self,14)
self.taskList=UIObject.get(self,15)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.stageBtn:setButtonClick(function()self:onStageBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.payBtn:setButtonClick(function()self:onPayBtn()end)



end


function UIZongMenXianTuInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shield);self.shield=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.taskView);self.taskView=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.stageBtn);self.stageBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.getted);self.getted=nil;
_UIObject_release(self.stageReddot);self.stageReddot=nil;
_UIObject_release(self.taskList);self.taskList=nil;
end















local _this=nil
local _itemCmp={
reward=0,
desc=1,
rewardBtn=2,
jumpBtn=3,
getted=4
}
local _ab="ui/windows/xiantuchengjiu/xiantuchengjiu_atlas_pak.ab"



function UIZongMenXianTuInfoWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskProgress,self.onXianTuChengJiuTaskProgress)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskComplete)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskReward)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskOpen)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuReward,self.onZongMenXianTuReward)
end


function UIZongMenXianTuInfoWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskProgress,self.onXianTuChengJiuTaskProgress)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskComplete)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskReward)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskOpen)
notifySystem:removelistener(notifyConfig.onZongMenXianTuReward,self.onZongMenXianTuReward)
notifySystem:removelistener(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)
end




function UIZongMenXianTuInfoWin:onShow(argtable,afterOnloaded)
if argtable==nil then
UIFullXianTuChengJiuControl:closeWindow("UIZongMenXianTuInfoWin")
return
end

self.id=argtable.id
self.nextid=argtable.next
self.config=cfgHelper.get1(cfg_sectxiantuconfig_get,self.id)
self.titleImg:setSprite(_ab,self.config.title)
self.descTx:setText(self.config.descEx)

self:refreshTaskReward()
self:refreshTaskView()
self:refreshProgress()

if afterOnloaded then
self.root:setChildUIModelShowTarget(2016,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.3,function()
self.content:setChildCanvasGroupDOFade(1,0.533)
end)
end)
end
end


function UIZongMenXianTuInfoWin:onHide()

end




function UIZongMenXianTuInfoWin:onBackground()
if self.animation then return end
UIFullXianTuChengJiuControl:closeWindow("UIZongMenXianTuInfoWin")
end


function UIZongMenXianTuInfoWin:onCloseBtn()
if self.closeFlag then
UIManager:invokeUIMethod("UIZongMenXianTuWin","resetContent")
end
UIFullXianTuChengJiuControl:closeWindow("UIZongMenXianTuInfoWin")
end


function UIZongMenXianTuInfoWin:onStageBtn()
if self.fHave>=self.fCount then
local times=xiantuchengjiuModel:getZMXTTimes(self.id)
if times<1 and xiantuchengjiuModel:checkZMXTOpen(self.id,self.nextid)then
self.closeFlag=true
xiantuchengjiuController.send_30_7(self.nextid)
end
else
UIManager.error("完成所有进阶任务后即可进阶")
end
end


function UIZongMenXianTuInfoWin:onRewardBtn()
if self.fHave>=self.fCount then
local times=xiantuchengjiuModel:getZMXTTimes(self.id)
if times<1 then
self.closeFlag=true
xiantuchengjiuController.send_30_3(self.id)
end
end
end


function UIZongMenXianTuInfoWin:onPayBtn()
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,self.id)
local times=xiantuchengjiuModel:getZMXTTimes(self.id)
if cfg.max>times and times>0 then
local params=tostring(self.id)
payControl.reqPay(cfg.recharge,1,params)
xiantuchengjiuController.recv_30_3(self.id,times+1)
end
end

function UIZongMenXianTuInfoWin:startAnimation()
self.root:setActive(false)
self.background:setActive(false)
end

function UIZongMenXianTuInfoWin:endAnimation()
self.root:setActive(true)
self.background:setActive(true)
self:refreshProgress()
end

function UIZongMenXianTuInfoWin.sortList(a,b)
if a.sort~=b.sort then
return a.sort<b.sort
else
return a.key<b.key
end
end

function UIZongMenXianTuInfoWin:refreshTaskReward()
local rewards={}
if self.config.max<=1 then
rewards=self.config.rewardEx or self.config.reward
else
local times=xiantuchengjiuModel:getZMXTTimes(self.id)
if times>=1 then
rewards=self.config.reward
else
rewards=self.config.rewardEx or self.config.reward
end
end
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local id=data[1]
local num=data[2]
local showCountBG=num>1
local countStr=showCountBG and mathHelper.formatNumber(num)or''
local conf={itemid=id,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)itemsComponentHelper.onItemClick(...)end)
item:SetChildPropData(-1,prop)

local suitName=equipsHelper.getEquipSuitIconByFix(id)
item:SetChildIcon(10,suitName,false)
end)
end

function UIZongMenXianTuInfoWin:refreshTaskView()
self.sortTask={}
local datas=xiantuchengjiuModel:getTasksByTypeKey(eXianTuChengJiuTabType.ZongMenXianTu,self.id)
for i,v in pairs(datas)do

local taskCfg=xiantuchengjiuModel:getTaskConfig(v.type,v.key1,v.key2)
table.insert(self.sortTask,{key=i,sort=taskCfg.order})

end
table.sort(self.sortTask,self.sortList)
self.taskList:setChildLayoutGroupCreateItems(#self.sortTask,function(index)
self:refreshTask(index,true)
end)
end

function UIZongMenXianTuInfoWin:refreshAllTask()
for i,v in ipairs(self.sortTask)do
self:refreshTask(i)
end
end

function UIZongMenXianTuInfoWin:refreshTask(index,isInit)
local key=self.sortTask[index].key
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local show=data.show
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local desc=over and xiantuchengjiuModel:findTaskDescEx(config,#data.aims,true)or xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
local progressMax=over and aim or data.aims[#data.aims]
local str=FMT.fmt("{0}<color=#7D3B17>({1}/{2})</color>",desc,mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2))
item:SetChildText(_itemCmp.desc,str)
item:SetChildActive(_itemCmp.getted,show and over)
local reddot=xiantuchengjiuModel:getTaskReddotEx(data)
item:SetChildActive(_itemCmp.jumpBtn,not show or(not over and not reddot))
item:SetChildImageExGray(_itemCmp.jumpBtn,not show)
item:SetChildActive(_itemCmp.rewardBtn,show and not over and reddot)
item:SetChildNewBieComponentId(_itemCmp.rewardBtn,FMT.fmt("UIZongMenXianTuInfoWin.task_{0}_{1}.rewardBtn",self.id,key))
local rewardCfg=over and config.taskaims[#data.aims][2]or config.taskaims[aimIdx][2]
local rData=rewardCfg[1]
local rId=rData[1]
local rNum=rData[2]
local showCountBG=rNum>1
local countStr=showCountBG and mathHelper.formatNumber(rNum)or''
local conf={itemid=rId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(_itemCmp.reward,function(...)itemsComponentHelper.onItemClick(...)end)
item:SetChildPropData(_itemCmp.reward,prop)
if isInit then
item:SetChildButtonClick(_itemCmp.jumpBtn,function()
self:onClickTaskJump(key)
end)
item:SetChildButtonClick(_itemCmp.rewardBtn,function()
self:onClickTaskReward(key)
end)
end
end

function UIZongMenXianTuInfoWin:findTaskIndexByKey(key)
for i,v in ipairs(self.sortTask)do
if v.key==key then
return i
end
end
end

function UIZongMenXianTuInfoWin:refreshTaskProgressByKey(key)
local index=self:findTaskIndexByKey(key)
if index then
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local desc=over and xiantuchengjiuModel:findTaskDescEx(config,#data.aims,true)or xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
local progressMax=over and aim or data.aims[#data.aims]
local str=FMT.fmt("{0}<color=#7D3B17>({1}/{2})</color>",desc,mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2))
item:SetChildText(_itemCmp.desc,str)
end
end

function UIZongMenXianTuInfoWin:refreshTaskStatusByKey(key)
local index=self:findTaskIndexByKey(key)
if index then
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local show=data.show
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local desc=over and xiantuchengjiuModel:findTaskDescEx(config,#data.aims,true)or xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
local progressMax=over and aim or data.aims[#data.aims]
local str=FMT.fmt("{0}<color=#7D3B17>({1}/{2})</color>",desc,mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2))
item:SetChildText(_itemCmp.desc,str)
item:SetChildActive(_itemCmp.getted,show and over)
local reddot=xiantuchengjiuModel:getTaskReddotEx(data)
item:SetChildActive(_itemCmp.jumpBtn,not show or(not over and not reddot))
item:SetChildImageExGray(_itemCmp.jumpBtn,not show)
item:SetChildActive(_itemCmp.rewardBtn,show and not over and reddot)
end
end

function UIZongMenXianTuInfoWin:refreshTaskByKey(key)
local index=self:findTaskIndexByKey(key)
if index then
self:refreshTask(index)
end
end

function UIZongMenXianTuInfoWin:refreshProgress()
local taskCfg=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.ZongMenXianTu,self.id)
self.fCount=0
for key,cfg in pairs(taskCfg)do
self.fCount=self.fCount+#cfg.taskaims
end
self.fHave=0
for i,v in ipairs(self.sortTask)do
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.ZongMenXianTu,self.id,v.key)
local temp=data.flag
self.fHave=self.fHave+temp
end


if self.fHave<self.fCount then
self.stageBtn:setActive(true)
self.stageReddot:setActive(false)
self.rewardBtn:setActive(false)
self.payBtn:setActive(false)
self.getted:setActive(false)
else
local times=xiantuchengjiuModel:getZMXTTimes(self.id)
if times<1 then
local showStage=xiantuchengjiuModel:checkZMXTOpen(self.id,self.nextid)
self.stageBtn:setActive(showStage)
self.stageReddot:setActive(showStage)
self.rewardBtn:setActive(not showStage)
self.payBtn:setActive(false)
self.getted:setActive(false)
else
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,self.id)
self.stageBtn:setActive(false)
self.rewardBtn:setActive(false)
self.payBtn:setActive(cfg.max>1 and times<cfg.max)
self.getted:setActive(times>=cfg.max)
end
end
end

function UIZongMenXianTuInfoWin.onXianTuChengJiuSystemInit()
_this:refreshAllTask()
_this:refreshProgress()
end

function UIZongMenXianTuInfoWin.onXianTuChengJiuTaskProgress(list)
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.ZongMenXianTu and v[2]==_this.id then
_this:refreshTaskProgressByKey(v[3])
end
end
end

function UIZongMenXianTuInfoWin.onXianTuChengJiuTaskComplete(list)
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.ZongMenXianTu and v[2]==_this.id then
_this:refreshTaskStatusByKey(v[3])
end
end
end

function UIZongMenXianTuInfoWin.onXianTuChengJiuTaskReward(list)
local have=false
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.ZongMenXianTu and v[2]==_this.id then
_this:refreshTaskByKey(v[3])
have=true
end
end
if have then
_this:refreshProgress()
_this:refreshTaskReward()
end
end

function UIZongMenXianTuInfoWin.onXianTuChengJiuTaskOpen(list)
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.ZongMenXianTu and v[2]==_this.id then
_this:refreshAllTask()
return
end
end
end

function UIZongMenXianTuInfoWin.onZongMenXianTuReward(id)
if id==_this.id then
local times=xiantuchengjiuModel:getZMXTTimes(id)
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,id)
_this.stageBtn:setActive(false)
_this.rewardBtn:setActive(false)
_this.payBtn:setActive(cfg.max>1 and times<cfg.max)
_this.getted:setActive(cfg.max<=times)
end
end

function UIZongMenXianTuInfoWin.onZongMenXianTuStage(id)



end

function UIZongMenXianTuInfoWin:onClickTaskJump(key)
local taskData=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local cfg=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
if not taskData.show then
local warningStr=xiantuchengjiuModel:getConditionWarning(cfg.show,"、",nil,"解锁任务")
UIManager.error(warningStr)
return
end
if cfg.jump then
jumpManager:jump(cfg.jump)
end
end

function UIZongMenXianTuInfoWin:onClickTaskReward(key)
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.ZongMenXianTu,self.id,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local info={{eXianTuChengJiuTabType.ZongMenXianTu,self.id,key},aimIdx}
xiantuchengjiuController.send_30_2({info})
end

function UIZongMenXianTuInfoWin:startSheild()
self.shield:setActive(true)
if self.checkTick then
self:stopTimerByID(self.checkTick)
self.checkTick=nil
end
self.checkTick=self:delayDo(5,function()
self.shield:setActive(false)
end)
end

function UIZongMenXianTuInfoWin:endSheild()
self.shield:setActive(false)
if self.checkTick then
self:stopTimerByID(self.checkTick)
self.checkTick=nil
end
end
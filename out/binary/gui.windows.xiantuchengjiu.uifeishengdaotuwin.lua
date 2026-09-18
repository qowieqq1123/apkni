







def_class("UIFeiShengDaoTuWin",UIWindowBase)









function UIFeiShengDaoTuWin:bindComponents()

self.root=UIObject.get(self,0)
self.sheild=UIObject.get(self,1)
self.descImg=UIImage.get(self,2)
self.taskView=UIObject.get(self,3)
self.dzModel=UIObject.get(self,4)
self.taskList=UIObject.get(self,5)



end


function UIFeiShengDaoTuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sheild);self.sheild=nil;
_UIObject_release(self.descImg);self.descImg=nil;
_UIObject_release(self.taskView);self.taskView=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.taskList);self.taskList=nil;
end
















local _this=nil
local _itemCmp={
name=0,
desc=1,
rewardBtn=2,
jumpBtn=3,
getted=4,
rewardList=5,
}
local _ab="ui/windows/xiantuchengjiu/xiantuchengjiu_atlas_pak.ab"



function UIFeiShengDaoTuWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskProgress,self.onXianTuChengJiuTaskProgress)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskComplete)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskReward)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskOpen)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)
self._afterAnimation=function()
self.taskList:setChildCanvasGroupAlpha(1)
self:endSheild()
end
self._afterLoaded=function()
local tween=self.taskList:setChildCanvasGroupDOFade(1,10/30,self._afterAnimation)
tween:SetDelay(8/30)
self.tweener=tween
end
self:refreshDzModel()

self:startSheild()
self.root:setChildUIModelShowTarget(4223,1,{},eAnimationID.enter,false,false,0,self._afterLoaded)
end


function UIFeiShengDaoTuWin:__delete()
if self.tweener:IsActive()then
self.tweener:Kill()
end
self:endSheild()

self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskProgress,self.onXianTuChengJiuTaskProgress)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskComplete)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskReward)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskOpen)
notifySystem:removelistener(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)
end




function UIFeiShengDaoTuWin:onShow(argtable,afterOnloaded)
self:refreshView()
end


function UIFeiShengDaoTuWin:onHide()
self.taskList:setChildCanvasGroupAlpha(0)
end

function UIFeiShengDaoTuWin:onShowArgRecv(argtable)
self:startSheild()
self.root:setChildModelAnimationState(eAnimationID.enter)
local tween=self.taskList:setChildCanvasGroupDOFade(1,10/30,self._afterAnimation)
tween:SetDelay(8/30)
end


function UIFeiShengDaoTuWin:refreshDzModel()
local temp=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)or{}
local firstData=temp[1]or UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(firstData.discipleguid,false,1)
self.dzModel:setChildUIModelShowTarget(modelParams.body,0.7,modelParams.componets,eAnimationID.stand,false,false,0)
self.dzModel:setChildUIModelShowFlipX(true)
end

function UIFeiShengDaoTuWin.sortList(a,b)
if a.sort~=b.sort then
return a.sort<b.sort
else
return a.key<b.key
end
end

function UIFeiShengDaoTuWin:refreshView()
self.current=xiantuchengjiuModel:getFSDTCurrent()
if self.current<=0 then
local list=cfgHelper.get1(cfg_lookupfeishengdaotuconfig_get,1)
self.current=list[1]
end

local cfg=cfgHelper.get1(cfg_feishengdaotuconfig_get,self.current)
self.descImg:setSprite(_ab,cfg.image)
self:refreshTaskList()

end

function UIFeiShengDaoTuWin:refreshTaskList()
self.list={}
local datas=xiantuchengjiuModel:getTasksByTypeKey(eXianTuChengJiuTabType.FeiShengDaoTu,self.current)
for i,v in pairs(datas)do
if v.show then
local taskCfg=xiantuchengjiuModel:getTaskConfig(v.type,v.key1,v.key2)
table.insert(self.list,{key=i,sort=taskCfg.order})
end
end
table.sort(self.list,self.sortList)
self.taskList:setChildLayoutGroupCreateItems(#self.list,function(index)
self:refreshTask(index,true)
end)
end

function UIFeiShengDaoTuWin:refreshAllTask()
for i,v in ipairs(self.list)do
self:refreshTask(i,false)
end
end

function UIFeiShengDaoTuWin:refreshTask(index,isInit)
local key=self.list[index].key
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local desc=over and xiantuchengjiuModel:findTaskDescEx(config,#data.aims,true)or xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
local progressMax=over and data.aims[#data.aims]or aim
local str=FMT.fmt("{0}({1}/{2})",desc,mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2))
item:SetChildText(_itemCmp.desc,str)
item:SetChildActive(_itemCmp.getted,over)
local rewardCfg=over and config.taskaims[#data.aims][2]or config.taskaims[aimIdx][2]
item:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,#rewardCfg,function(index)
local rItem=item:GetChildLayoutGroupGridItem(_itemCmp.rewardList,index-1)
local rData=rewardCfg[index]
local rId=rData[1]
local rNum=rData[2]
local showCountBG=rNum>1
local countStr=showCountBG and mathHelper.formatNumber(rNum)or''
local conf={itemid=rId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rItem:SetBaseItemClickEvent(-1,function(...)itemsComponentHelper.onItemClick(...)end)
rItem:SetChildPropData(-1,prop)
end)
local reddot=xiantuchengjiuModel:getTaskReddotEx(data)
item:SetChildActive(_itemCmp.jumpBtn,not over and not reddot)
item:SetChildActive(_itemCmp.rewardBtn,not over and reddot)

if isInit then
item:SetChildText(_itemCmp.name,config.taskname)
item:SetChildButtonClick(_itemCmp.jumpBtn,function()
self:onClickJump(key)
end)
item:SetChildButtonClick(_itemCmp.rewardBtn,function()
self:onClickReward(key)
end)
end
end

function UIFeiShengDaoTuWin:findTaskIndexByKey(key)
for i,v in ipairs(self.list)do
if v.key==key then
return i
end
end
end

function UIFeiShengDaoTuWin:refreshTaskByKey(key,isInit)
local index=self:findTaskIndexByKey(key)
if index then
self:refreshTask(index,isInit)
end
end

function UIFeiShengDaoTuWin:refreshTaskProgressByKey(key)
local index=self:findTaskIndexByKey(key)
if index then
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local desc=over and xiantuchengjiuModel:findTaskDescEx(config,#data.aims,true)or xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
local progressMax=over and data.aims[#data.aims]or aim
local str=FMT.fmt("{0}({1}/{2})",desc,mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2))
item:SetChildText(_itemCmp.desc,str)
end
end

function UIFeiShengDaoTuWin:refreshTaskStatusByKey(key)
local index=self:findTaskIndexByKey(key)
if index then
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local desc=over and xiantuchengjiuModel:findTaskDescEx(config,#data.aims,true)or xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
local progressMax=over and data.aims[#data.aims]or aim
local str=FMT.fmt("{0}({1}/{2})",desc,mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2))
item:SetChildText(_itemCmp.desc,str)
item:SetChildActive(_itemCmp.getted,over)
local reddot=xiantuchengjiuModel:getTaskReddotEx(data)
item:SetChildActive(_itemCmp.jumpBtn,not over and not reddot)
item:SetChildActive(_itemCmp.rewardBtn,not over and reddot)
end
end

function UIFeiShengDaoTuWin:onClickJump(key)
if not xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.FeiShengDaoTu,self.current)then
UIManager.error(FMT.fmt("请先达到{0}",cfgHelper.get2(cfg_sectxiantuconfig_get,self.current,"name")))
return
end
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
if config.jump then
jumpManager:jump(config.jump)
end
end

function UIFeiShengDaoTuWin:onClickReward(key)
if not xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.FeiShengDaoTu,self.current)then
UIManager.error(FMT.fmt("请先达到{0}",cfgHelper.get2(cfg_sectxiantuconfig_get,self.current,"name")))
return
end
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local info={{eXianTuChengJiuTabType.FeiShengDaoTu,self.current,key},aimIdx}
xiantuchengjiuController.send_30_2({info})
end

function UIFeiShengDaoTuWin.onXianTuChengJiuSystemInit()
_this:refreshView()
end

function UIFeiShengDaoTuWin.onXianTuChengJiuTaskProgress(list)
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.FeiShengDaoTu and v[2]==_this.current then
_this:refreshTaskProgressByKey(v[3])
end
end
end

function UIFeiShengDaoTuWin.onXianTuChengJiuTaskComplete(list)
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.FeiShengDaoTu and v[2]==_this.current then
_this:refreshTaskStatusByKey(v[3])
end
end
end

function UIFeiShengDaoTuWin.onXianTuChengJiuTaskReward(list)
local temp={}
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.FeiShengDaoTu and v[2]==_this.current then
table.insert(temp,v)
end
end

local itemsList={}
if#temp>0 then
for i,v in ipairs(temp)do
local taskCfg=xiantuchengjiuModel:getTaskConfig(v[1],v[2],v[3])
local aimIdx=v[4]
local taskRewards=taskCfg.taskaims[aimIdx][2]
for j,w in ipairs(taskRewards)do
table.insert(itemsList,{itemid=w[1],num=w[2]})
end
end
end

if _this.current==xiantuchengjiuModel:getFSDTCurrent()then
if#itemsList>0 then
showPrizeControl.showWindow(itemsList)
end
for i,v in ipairs(temp)do
_this:refreshTaskByKey(v[3],false)
end
else

showPrizeControl.showWindow(itemsList,function()
_this:doAnimation(temp)
end)
end
end

function UIFeiShengDaoTuWin:doAnimation(list)
_this:startSheild()
for i,v in ipairs(list)do
_this:refreshTaskByKey(v[3],false)
end

_this:delayDo(0.5,function()
local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(10/30)
local tweener1=_this.taskList:setChildCanvasGroupDOFade(0,10/30)
sequence:Append(tweener1)
local tweener3=_this.taskList:setChildDOAnchorPosY(-600,10/30)
sequence:Join(tweener3)
sequence:AppendCallback(function()
_this:refreshView()
end)
sequence:AppendInterval(20/30)
local tweener2=_this.taskList:setChildCanvasGroupDOFade(1,10/30)
sequence:Append(tweener2)
local tweener4=_this.taskList:setChildDOAnchorPosY(0,10/30)
sequence:Join(tweener4)
sequence:AppendCallback(function()
_this._afterAnimation()
end)
_this.tweener=sequence
_this.root:setChildModelAnimationState(2092)
_this:delayDo(0.2,function()
if _this==nil then return end

AudioManager.playAudio(602)
end)

_this:delayDo(1.2,function()
if _this==nil then return end

AudioManager.playAudio(603)
end)
end)
end

function UIFeiShengDaoTuWin.onXianTuChengJiuTaskOpen(list)
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.FeiShengDaoTu and v[2]==_this.current then
_this:refreshTaskList()
return
end
end
end

function UIFeiShengDaoTuWin.onZongMenXianTuStage(id)
if _this.current~=xiantuchengjiuModel:getFSDTCurrent()then
_this:refreshView()
end
end

function UIFeiShengDaoTuWin:startSheild()
self.sheild:setActive(true)
if self.checkTick then
self:stopTimerByID(self.checkTick)
self.checkTick=nil
end
self.checkTick=self:delayDo(5,function()
self.sheild:setActive(false)
end)
end

function UIFeiShengDaoTuWin:endSheild()
self.sheild:setActive(false)
if self.checkTick then
self:stopTimerByID(self.checkTick)
self.checkTick=nil
end
end








def_class("UIZheXianLingZJWin",UIWindowBase)









function UIZheXianLingZJWin:bindComponents()

self.spine=UIObject.get(self,0)
self.lingpaModel=UIObject.get(self,1)
self.lingpaiTarget=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.name=UIText.get(self,4)
self.nextTitleRoot=UIObject.get(self,5)
self.wanfaRoot=UIObject.get(self,6)
self.nextTitleIcon=UIImage.get(self,7)
self.nextLimit=UIText.get(self,8)
self.nextTitle=UIText.get(self,9)
self.wanfaName=UIText.get(self,10)
self.btnblight=UIButton.get(self,11)
self.wanfaDesc=UIText.get(self,12)
self.huiyiDesc=UIText.get(self,13)
self.juanName=UIText.get(self,14)
self.wanfaIcon=UIObject.get(self,15)
self.funDesc1=UIText.get(self,16)
self.funIcon1=UIObject.get(self,17)
self.funIcon2=UIObject.get(self,18)
self.funDesc2=UIText.get(self,19)
self.itemsRoot=UIObject.get(self,20)
self.funItem2=UIObject.get(self,21)
self.funItem1=UIObject.get(self,22)
self.point4=UIObject.get(self,23)
self.point3=UIObject.get(self,24)
self.point1=UIObject.get(self,25)
self.point2=UIObject.get(self,26)
self.btnPrize=UIButton.get(self,27)
self.ScrollView=UIScrollView.get(self,28)
self.item2=UIObject.get(self,29)
self.item1=UIObject.get(self,30)
self.progressBar=UIProgressBarAni.get(self,31)
self.zjRoot=UIObject.get(self,32)
self.nextRoot=UIObject.get(self,33)
self.finishTxt=UIText.get(self,34)
self.showClick1=UIButton.get(self,35)
self.showClick2=UIButton.get(self,36)

self.btnblight:setButtonClick(function()self:onBtnblight()end)

self.btnPrize:setButtonClick(function()self:onBtnPrize()end)

self.showClick1:setButtonClick(function()self:onShowClick1()end)

self.showClick2:setButtonClick(function()self:onShowClick2()end)



end


function UIZheXianLingZJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.lingpaModel);self.lingpaModel=nil;
_UIObject_release(self.lingpaiTarget);self.lingpaiTarget=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.nextTitleRoot);self.nextTitleRoot=nil;
_UIObject_release(self.wanfaRoot);self.wanfaRoot=nil;
_UIObject_release(self.nextTitleIcon);self.nextTitleIcon=nil;
_UIObject_release(self.nextLimit);self.nextLimit=nil;
_UIObject_release(self.nextTitle);self.nextTitle=nil;
_UIObject_release(self.wanfaName);self.wanfaName=nil;
_UIObject_release(self.btnblight);self.btnblight=nil;
_UIObject_release(self.wanfaDesc);self.wanfaDesc=nil;
_UIObject_release(self.huiyiDesc);self.huiyiDesc=nil;
_UIObject_release(self.juanName);self.juanName=nil;
_UIObject_release(self.wanfaIcon);self.wanfaIcon=nil;
_UIObject_release(self.funDesc1);self.funDesc1=nil;
_UIObject_release(self.funIcon1);self.funIcon1=nil;
_UIObject_release(self.funIcon2);self.funIcon2=nil;
_UIObject_release(self.funDesc2);self.funDesc2=nil;
_UIObject_release(self.itemsRoot);self.itemsRoot=nil;
_UIObject_release(self.funItem2);self.funItem2=nil;
_UIObject_release(self.funItem1);self.funItem1=nil;
_UIObject_release(self.point4);self.point4=nil;
_UIObject_release(self.point3);self.point3=nil;
_UIObject_release(self.point1);self.point1=nil;
_UIObject_release(self.point2);self.point2=nil;
_UIObject_release(self.btnPrize);self.btnPrize=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.zjRoot);self.zjRoot=nil;
_UIObject_release(self.nextRoot);self.nextRoot=nil;
_UIObject_release(self.finishTxt);self.finishTxt=nil;
_UIObject_release(self.showClick1);self.showClick1=nil;
_UIObject_release(self.showClick2);self.showClick2=nil;
end


















function UIZheXianLingZJWin:onLoaded(...)
self:bindComponents()
self.itemlist={}
local itemlist=self.itemlist
itemlist[#itemlist+1]=self.item1
itemlist[#itemlist+1]=self.item2

self.pointlist={}
local pointlist=self.pointlist
pointlist[#pointlist+1]=self.point1
pointlist[#pointlist+1]=self.point2
pointlist[#pointlist+1]=self.point3
pointlist[#pointlist+1]=self.point4

self.lookupTaskIdx={}

self._onTaskChange=function(...)
self:onTaskChange(...)
end
notifySystem:listenNotify(notifyConfig.onTaskChange,self._onTaskChange)
end

function UIZheXianLingZJWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onTaskChange,self._onTaskChange)
end

function UIZheXianLingZJWin:onShow(argtable,afterOnloaded)
local lastIdx=argtable.lastIdx
self:playAni(lastIdx)

end

function UIZheXianLingZJWin:onHide()
if self.playtimer1 then
self:stopTimerByID(self.playtimer1)
end
if self.playtimer2 then
self:stopTimerByID(self.playtimer2)
end
self.playtimer=nil
self.winlua:SetChildCanvasGroupAlpha(self.spine:getID(),0)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
end

function UIZheXianLingZJWin:playAni(lastIdx)
local isDaotu=lastIdx==UIFullZheXianControl.winType.eDaoTu
self.winlua:SetChildCanvasGroupAlpha(self.spine:getID(),0)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
local func=function()
if self and not self.isClose then
self.winlua:SetChildCanvasGroupAlpha(self.spine:getID(),1)
self:playBg()
self.playtimer1=nil
end
end
local delay=isDaotu and 1 or 0.3
self.playtimer1=self:delayDo(delay,func)
end

function UIZheXianLingZJWin:playBg()

self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.winlua:SetChildUIModelShowTarget(self.spine:getID(),3040,1,{},2051,false,false,0.5,
function()
if self and not self.isClose then
self:freshInfo()
end
end)
local func=function()
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
self.playtimer2=nil
end
self.playtimer2=self:delayDo(0.5,func)
end

function UIZheXianLingZJWin:freshInfo()
local finishBook=zheXianLingModel:isFinishCurrentBook()
local rewardBook=zheXianLingModel:isRewardCurrentBook()
local visNomal=not finishBook and not rewardBook
self.zjRoot:setActive(visNomal)
self.nextRoot:setActive(finishBook or rewardBook)
self.wanfaRoot:setActive(finishBook)
self.nextTitleRoot:setActive(rewardBook)
if visNomal then
self:freshNomalPanel()
elseif finishBook then
self:freshWanFaPanel()
elseif rewardBook then
self:freshNextTitlePanel()
end
end

function UIZheXianLingZJWin:freshNomalPanel()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local chapter_id=data.chapter_id
local taskids=zheXianLingConfig.getTaskIds(chapter_id)
self:freshTask(taskids)
self:freshUnlockInfo()
self:freshRewardItems()
self:freshProgress()
local bookid,index=zheXianLingConfig.getChapterIndex(chapter_id)
local chapterStr=mathHelper.numberToChinese(index)
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
self.name:setText(FMT.fmt('第{0}章 · {1}',chapterStr,chapterCfg.name))
end

function UIZheXianLingZJWin:freshWanFaPanel()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local book_id_str=mathHelper.numberToChinese(book_id)
local wanfamodel=bookCfg.wanfamodel1
self.juanName:setText(FMT.fmt('卷{0} . {1}',book_id_str,bookCfg.name))
self.huiyiDesc:setText(bookCfg.plot)
self.wanfaDesc:setText(bookCfg.wanfadesc)
self.wanfaName:setText(bookCfg.wanfatitle)
local offsetX=wanfamodel[3]or 0
local offsetY=wanfamodel[4]or 0
self.wanfaIcon:setChildUIModelShowTarget(wanfamodel[1],wanfamodel[2],nil,eAnimationID.idle)
if offsetX~=0 or offsetY~=0 then
self.wanfaIcon:setLocalPos(offsetX,offsetY,0)
end
end

function UIZheXianLingZJWin:freshNextTitlePanel()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local nextid=bookCfg.nextid
if nextid then
local desc=zheXianLingModel:getOpenBookCnd(nextid)
self.nextLimit:setText(desc)
self.nextTitle:setText('全新卷章即将开启')
else
self.nextLimit:setText('')
self.nextTitle:setText('所有卷章已完成')
end
end



function UIZheXianLingZJWin:freshTask(taskids)
self.lookupTaskIdx={}
local len=#taskids

local sortTable={}
for i,taskid in ipairs(taskids)do
local taskdata=taskModel:getTaskInfo(taskid)
local has=taskdata~=nil
local t_taskstate=taskModel.taskFinishState
if taskdata then
t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
end
local hasReward=t_taskstate==taskModel.taskRewardState
local isDoing=t_taskstate==taskModel.taskDoingState
local isFinish=t_taskstate==taskModel.taskFinishState
local sortTag=hasReward and(-1000000+i)or isDoing and i or(1000000+i)
sortTable[#sortTable+1]=
{
taskid,sortTag
}
end
table.sort(sortTable,function(a,b)
return a[2]<b[2]
end)
self.tasksCfg=sortTable

self.ScrollView:freshGridsNum(len,len,1,not(self.isSetZero or false))
self.isSetZero=true
for i=1,len do
self:fillItem(i,self.tasksCfg[i][1])
end
self:freshBtnPrize()
end

function UIZheXianLingZJWin:freshBtnPrize()
local vis=zheXianLingModel:isFinishCurrentChapter()
local len,tlen=zheXianLingModel:getCurrentChapterTaskFinishCount()
self.finishTxt:setText(not vis and FMT.fmt('完成章节任务({0}/{1})',len,tlen)or'')
self.btnPrize:setActive(vis)
end

function UIZheXianLingZJWin:fillItem(index,taskid)
self.lookupTaskIdx[taskid]=index
local taskCfg=taskModel:getTaskConfig(taskid)
local taskdata=taskModel:getTaskInfo(taskid)
local has=taskdata~=nil
local desc=taskCfg.taskaimdesc
local taskReward=taskCfg.taskReward


local t_taskstate=taskModel.taskFinishState
if taskdata then
t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
end
local hasReward=t_taskstate==taskModel.taskRewardState
local isDoing=t_taskstate==taskModel.taskDoingState
local isFinish=t_taskstate==taskModel.taskFinishState

local widget=self.ScrollView:getGridObjectByindex(index-1)
if has then
local taskstateResult=taskModel:getTaskState(taskdata)


local cur=taskstateResult.curnum
local max=taskstateResult.maxnum
if cur>max then cur=max end
if hasReward or isFinish then cur=max end

if deviceHelper.isRunEditor()then
desc=FMT.fmt('{0}（{1}）',taskCfg.taskaimdesc,taskid)
else
desc=taskCfg.taskaimdesc
end
widget:SetChildProgressValue(5,cur,max)
widget:SetChildText(6,FMT.fmt('{0}/{1}',cur,max))
else
local cur=cfg_taskconfig_get(taskid).aimnum
local max=cur
widget:SetChildProgressValue(5,cur,max)
widget:SetChildText(6,FMT.fmt('{0}/{1}',cur,max))
desc=taskCfg.taskaimdesc
end
widget:SetChildText(0,desc)

widget:SetChildActive(1,isDoing)
if isDoing then
local guideCall=function()
UIFullZheXianControl:closeUI()
end
widget:SetChildButtonClick(1,function()
taskController:doJump(taskid,guideCall)
end,true)
end

widget:SetChildActive(2,hasReward)
if hasReward then
widget:SetChildButtonClick(2,function()
taskController:doGetTaskReward(taskid)
end,true,0)
widget:SetChildNewBieComponentId(2,FMT.fmt('UIZheXianLingZJWin.zjTaskItem.btnPrize_{0}',taskid))
end

widget:SetChildActive(3,isFinish)

local itemid=taskReward[1][1]
local count=taskReward[1][2]
local widget1=widget:GetChildWidgetBase(4)
local widget2=widget1:GetChildWidgetBase(0)
local conf={itemid=itemid,itemcount=count>1 and count or'',showCountBG=count>1,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
widget2:SetPropData(propData)
widget2:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)

end

function UIZheXianLingZJWin:freshUnlockInfo()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local chapter_id=data.chapter_id
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
local unlockCfgs=chapterCfg.unlock
local unlockCfg1=unlockCfgs[1]
local unlockCfg2=unlockCfgs[2]

local hasCfg1=unlockCfg1~=nil
local hasCfg2=unlockCfg2~=nil
self.funItem1:setActive(hasCfg1)
self.funItem2:setActive(hasCfg2)

if hasCfg1 then
local args=unlockCfg1[2]
local iconName=args[1]
local desc=args[4]
self.funIcon1:setChildIcon(iconName,true)
self.funDesc1:setText(desc)
end
if hasCfg2 then
local args=unlockCfg2[2]
local iconName=args[1]
local desc=args[4]
self.funIcon2:setChildIcon(args[1],true)
self.funDesc2:setText(desc)
end
end

function UIZheXianLingZJWin:freshRewardItems()
local data=zheXianLingModel:getData()
local chapter_id=data.chapter_id
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
local rewards=chapterCfg.rewards
local temp={}
for i,v in ipairs(rewards)do
local t=cfgHelper.get(cfg_awardconfig_get,v).showItems
temp=table.concatTableXX(temp,t)
end
for i=1,2 do
local reward=temp[i]
local hasReward=reward~=nil
local itemSlot=self.itemlist[i]
itemSlot:setActive(hasReward)
local widget=itemSlot:getWidgetBase()
if hasReward then
local itemid=reward[1]
local num=reward[2]or 1
local conf={itemid=itemid,itemcount=num>1 and num or'',showCountBG=num>1,showname=false,range=reward.range}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
local widget1=widget:GetChildWidgetBase(0)
widget1:SetPropData(propData)
widget1:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end
end
end

function UIZheXianLingZJWin:freshProgress()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local chapter_id=data.chapter_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
local chapterids=bookCfg.chapterids
local idx=0
local len=#chapterids
local rlen,trlen=zheXianLingModel:getCurrentChapterTaskFinishCount()

self.progressBar:animateThreeParams(rlen*100,trlen*100,self.isPlayAni and 0.2 or 0)
self.isPlayAni=true
end




function UIZheXianLingZJWin:onBtnPrize()
local data=zheXianLingModel:getData()
local chapter_id=data.chapter_id
socketManager:send_27_3(2,chapter_id)
end

function UIZheXianLingZJWin:onBtnblight()
zheXianLingController:freshMainWindow('onBtnDaoTu')
end

function UIZheXianLingZJWin:onTaskChange(taskid,state)
local idx=self.lookupTaskIdx[taskid]
if idx==nil then return end
local data=zheXianLingModel:getData()
local chapter_id=data.chapter_id
local taskids=zheXianLingConfig.getTaskIds(chapter_id)
self:freshTask(taskids)
if state==taskModel.taskFinishState then
self:freshBtnPrize()
self:freshProgress()
end
end

function UIZheXianLingZJWin:onChapterPrize()
self:freshBtnPrize()
end

function UIZheXianLingZJWin:onShowClick1()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local chapter_id=data.chapter_id
local bookid,index=zheXianLingConfig.getChapterIndex(chapter_id)
UIManager:showWindow('UIZheXianLingZJDescWin',{index=index,bookid=book_id,chapterid=chapter_id})
end

function UIZheXianLingZJWin:onShowClick2()
self:onShowClick1()
end

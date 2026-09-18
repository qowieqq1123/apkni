







def_class("UITouZiXianShuWin",UIWindowBase)









function UITouZiXianShuWin:bindComponents()

self.topRoot=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.taskRoot=UIObject.get(self,2)
self.exp=UIText.get(self,3)
self.expPB=UIObject.get(self,4)
self.taskBtn=UIButton.get(self,5)
self.timeText=UIText.get(self,6)
self.buyLevelBtn=UIButton.get(self,7)
self.level=UIText.get(self,8)
self.scrollView=UIObject.get(self,9)
self.spReward=UIObject.get(self,10)
self.oneKeyGetRewardBtn=UIButton.get(self,11)
self.tipsPanel=UIObject.get(self,12)
self.activeBtn=UIButton.get(self,13)
self.rwTitle=UIObject.get(self,14)
self.rwImage=UIObject.get(self,15)
self.taskScrollView=UIObject.get(self,16)
self.taskBtnA=UIButton.get(self,17)
self.taskBtnA2=UIObject.get(self,18)
self.reddotA=UIObject.get(self,19)
self.taskBtnB=UIButton.get(self,20)
self.taskBtnB2=UIObject.get(self,21)
self.reddotB=UIObject.get(self,22)
self.taskBtnC=UIButton.get(self,23)
self.taskBtnC2=UIObject.get(self,24)
self.reddotC=UIObject.get(self,25)
self.taskBtnTxt=UIText.get(self,26)
self.retuenbtnBg=UIObject.get(self,27)
self.taskA=UIObject.get(self,28)
self.taskB=UIObject.get(self,29)
self.taskC=UIObject.get(self,30)
self.taskBtnReddot=UIObject.get(self,31)

self.taskBtn:setButtonClick(function()self:onTaskBtn()end)

self.buyLevelBtn:setButtonClick(function()self:onBuyLevelBtn()end)

self.oneKeyGetRewardBtn:setButtonClick(function()self:onOneKeyGetRewardBtn()end)

self.activeBtn:setButtonClick(function()self:onActiveBtn()end)

self.taskBtnA:setButtonClick(function()self:onTaskBtnA()end)

self.taskBtnB:setButtonClick(function()self:onTaskBtnB()end)

self.taskBtnC:setButtonClick(function()self:onTaskBtnC()end)



end


function UITouZiXianShuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.taskRoot);self.taskRoot=nil;
_UIObject_release(self.exp);self.exp=nil;
_UIObject_release(self.expPB);self.expPB=nil;
_UIObject_release(self.taskBtn);self.taskBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.buyLevelBtn);self.buyLevelBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.spReward);self.spReward=nil;
_UIObject_release(self.oneKeyGetRewardBtn);self.oneKeyGetRewardBtn=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.activeBtn);self.activeBtn=nil;
_UIObject_release(self.rwTitle);self.rwTitle=nil;
_UIObject_release(self.rwImage);self.rwImage=nil;
_UIObject_release(self.taskScrollView);self.taskScrollView=nil;
_UIObject_release(self.taskBtnA);self.taskBtnA=nil;
_UIObject_release(self.taskBtnA2);self.taskBtnA2=nil;
_UIObject_release(self.reddotA);self.reddotA=nil;
_UIObject_release(self.taskBtnB);self.taskBtnB=nil;
_UIObject_release(self.taskBtnB2);self.taskBtnB2=nil;
_UIObject_release(self.reddotB);self.reddotB=nil;
_UIObject_release(self.taskBtnC);self.taskBtnC=nil;
_UIObject_release(self.taskBtnC2);self.taskBtnC2=nil;
_UIObject_release(self.reddotC);self.reddotC=nil;
_UIObject_release(self.taskBtnTxt);self.taskBtnTxt=nil;
_UIObject_release(self.retuenbtnBg);self.retuenbtnBg=nil;
_UIObject_release(self.taskA);self.taskA=nil;
_UIObject_release(self.taskB);self.taskB=nil;
_UIObject_release(self.taskC);self.taskC=nil;
_UIObject_release(self.taskBtnReddot);self.taskBtnReddot=nil;
end


















local _rw_index={
level=0,
item1=1,
item2=2,
item3=3,
lock=4,
rclick=5,
rIcon1=6,
rIcon2=7,
levelbg1=8,
levelbg2=9,
select1=10,
select2=11,
select3=12,
mask=13,
effect1=14,
effect2=15,
effect3=16,
spPanel=17,
tips=18,
spItem=19,
expCount=20,
norPanel=21,
effect4=22,
tipsBtn=23,
}

local _this

local _tabType=
{
eBuy=1,
eTask=2,
}
local TaskConditionType=
{
system=1,
build=2,
}


function UITouZiXianShuWin:onLoaded(...)
_this=self
self:bindComponents()

self.tipsPanel:setActive(false)

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.winlua:SetChildScrollViewInitScrollEvent(self.scrollView:getID(),240,60,function(index)
local slevel=self:getNextSPRewardLevel(index+2)
if self.showSPLevel~=slevel then
self.showSPLevel=slevel
local clevel=self:getNextSPRewardLevel()
local maxLevel=#self.datas
local isFinish=clevel>=maxLevel
if not isFinish then
self:setSpecialReward(slevel)
end
end
end)

self.taskScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UITouZiXianShuWin:__delete()

self:doPunchRotation(false)
self:doPunchRotationA(false)
self:doPunchRotationB(false)
self:doPunchRotationC(false)
self.scrollView:setChildScrollViewStopGridCreate()
self:clearTimer()
self:unbindComponents()
_this=nil
end


function UITouZiXianShuWin:onHide()


end




function UITouZiXianShuWin:onShow(argtable,afterOnloaded)
self.subInfo=argtable.subInfo
self.extraParams=argtable.extraParams
self.tabType=self.extraParams or _tabType.eBuy
self.isSpecialRewardEffectInit_1=false
self.isSpecialRewardEffectInit_2=false
self:refresh()
end

function UITouZiXianShuWin:onShowArgRecv(argtable)


self:refresh()
end

function UITouZiXianShuWin:refresh()
local isTask=self.tabType==_tabType.eTask
self.root:setActive(not isTask)
self.taskRoot:setActive(isTask)
self:freshTop()

if isTask then
self:freshTaskRoot()
else
self:freshBuyRoot()
end

if UIXianShuControl:checkCurrentXsIDShowChangeRewardDialouge()then
self:showWindow("UITouZiXianShuRewardChangeWin")
end
end

function UITouZiXianShuWin:freshTop()
local isTask=self.tabType==_tabType.eTask
self.currLevel=UIXianShuControl:getLevel()
self.norRLevel=UIXianShuControl:getReceiveLevel(1)
self.speRLevel=UIXianShuControl:getReceiveLevel(2)

self.datas=cfgHelper.get1(cfg_fairybooklevelconfig_get,UIXianShuControl:getCurrentId())

local rId=UIXianShuControl:getRechargeId()
self.rechargeState=rId>0 and 1 or 0

local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local maxLevel=cfg.max_lv

self.level:setText(FMT.fmt('{0}级',self.currLevel))

local needExp=cfgHelper.get2(cfg_fairybookbaseconfig_get,1,'lv_exp')
self.needExp=needExp
if self.currLevel<maxLevel then
local exp=UIXianShuControl:getExp()
self.exp:setText(FMT.fmt('{0}/{1}',exp,needExp))
self.expPB:setChildUIProgressbar(exp,needExp,false)
else
self.exp:setText('已满级')
self.expPB:setChildUIProgressbar(1,1,false)
end

self:setBuyLevelBtnShow()
self:setRemainingTimeTimer()
self.taskBtnTxt:setText(isTask and'返回仙书'or'仙书任务')
self.retuenbtnBg:setActive(isTask)
local reddotFlag
if isTask then
reddotFlag=UIXianShuControl:checkRewardReddot()
else
reddotFlag=UIXianShuControl:checkTaskReddot()
end
self.taskBtnReddot:setActive(reddotFlag)
self:doPunchRotation(reddotFlag)
end

function UITouZiXianShuWin:freshBuyRoot()
self:setRewardList()
self:setSpecialReward()
self:setShowReward()
self:setActiveBtnShow()
end

function UITouZiXianShuWin:freshTaskRoot()
self.bRefresh=true
self.taskDatas=self:getTaskDatas()
local istypea=UIXianShuControl:checkTaskReddotByType(1)
local istypeb=UIXianShuControl:checkTaskReddotByType(2)
if not istypea and istypeb and not self.currShowType then
self.currShowType=2
end
self:refreshTaskList(self.currShowType or 1)
self.bRefresh=false
end

function UITouZiXianShuWin:setShowReward()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local modelData=cfg.rw_image[1][1]
local model=modelData[1]
local scale=isometricMapSystem:getModelScale(model,true)
scale=scale*modelData[2]
self.rwImage:setChildUIModelShowTarget(model,scale,nil,eAnimationID.stand)
self.rwImage:setLocalPos(modelData[3],modelData[4],0)
self.rwTitle:setImageSprite(modelData[5],true)
end

function UITouZiXianShuWin:setActiveBtnShow()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local rechargeCfg=cfg.recharge_rw
local rId=UIXianShuControl:getRechargeId()
local isActiveComplete=rId==rechargeCfg[2][1]or rId==rechargeCfg[3][1]
self.activeBtn:setActive(not isActiveComplete)
end

function UITouZiXianShuWin:setBuyLevelBtnShow()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local maxLevel=cfg.max_lv
local level=UIXianShuControl:getLevel()
local canShow=level<maxLevel
if canShow and cfg.buy_need_day then
local ltime=UIXianShuControl:getRemainingTime()
canShow=ltime<cfg.buy_need_day*86400
end
self.buyLevelBtn:setActive(canShow)
end




















function UITouZiXianShuWin:onRewardImageClick()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local rw=cfg.rw_image[1][2]
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNoBtns,itemid=rw,showModel=true})
end

function UITouZiXianShuWin:setRewardList()
local len=#self.datas
self.scrollView:setChildScrollViewDelayCreateGrids(len,0,0.1,5,false,false,function(index,item)
local level=index+1
self:setRewardItem(level,item)
if level==self.currLevel then
local jumpIndex=self.norRLevel and self.norRLevel-1 or 0
if jumpIndex<0 then
jumpIndex=0
end

self.scrollView:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end
end)
end

function UITouZiXianShuWin:setRewardItem(index,item,isOnSpecialReward)
local data=self.datas[index]
local canReceive=data.level_id<=self.currLevel


item:SetChildActive(_rw_index.mask,self.rechargeState==0)
item:SetChildText(_rw_index.level,FMT.fmt('{0}级',data.level_id))
local rw=data.general_rewards[1]
widgetHelper.setNormalRewardItem(item,_rw_index.item1,rw)
rw=data.luxury_rewards[1]
widgetHelper.setNormalRewardItem(item,_rw_index.item2,rw)
rw=data.luxury_rewards[2]
if rw then
item:SetChildActive(_rw_index.item3,true)
widgetHelper.setNormalRewardItem(item,_rw_index.item3,rw)
else
item:SetChildActive(_rw_index.item3,false)
end
item:SetChildActive(_rw_index.lock,self.rechargeState==0)
item:SetChildActive(_rw_index.rclick,canReceive)
if canReceive then
item:SetChildButtonClick(_rw_index.rclick,function()
self:onReqReward()
end)
end
local cr1=index<=self.norRLevel
local cr2=index<=self.speRLevel
item:SetChildActive(_rw_index.rIcon1,cr1)
item:SetChildActive(_rw_index.rIcon2,cr2)

item:SetChildActive(_rw_index.levelbg1,index>self.currLevel)
item:SetChildActive(_rw_index.levelbg2,index<=self.currLevel)


local rId=UIXianShuControl:getRechargeId()
local checkR=rId>0








local effectId="xianshu_light"













local select1=canReceive and not cr1
local select2=canReceive and not cr2 and checkR
item:SetChildActive(_rw_index.effect1,select1)
item:SetChildActive(_rw_index.effect2,select2)
item:SetChildActive(_rw_index.effect3,select2)
if not isOnSpecialReward or not self.isSpecialRewardEffectInit_1 or not self.isSpecialRewardEffectInit_2 then
if select1 then
item:SetChildAnimationStringID(_rw_index.effect1,effectId,false)
if isOnSpecialReward and not self.isSpecialRewardEffectInit_1 then
self.isSpecialRewardEffectInit_1=true;
end
end
if select2 then
item:SetChildAnimationStringID(_rw_index.effect2,effectId,false)
item:SetChildAnimationStringID(_rw_index.effect3,effectId,false)
if isOnSpecialReward and not self.isSpecialRewardEffectInit_2 then
self.isSpecialRewardEffectInit_2=true;
end
end
end
end

function UITouZiXianShuWin:onReqReward()
if self.norRLevel<self.currLevel then
UIXianShuControl:reqReward(1)
return
end
if self.rechargeState~=0 and self.speRLevel<self.currLevel then
UIXianShuControl:reqReward(1)
return
end
end

function UITouZiXianShuWin:getNextSPRewardLevel(level)
if not level then
level=math.min(self.norRLevel,self.speRLevel)
if level<1 then
level=1
end
end
for i=level,#self.datas do
local cfg=self.datas[i]
if cfg.is_sp_reward then
return i
end
end
return#self.datas
end

function UITouZiXianShuWin:setSpecialReward(index)
local item=self.spReward:getChildWidgetBase()
local slevel=self:getNextSPRewardLevel()
local maxLevel=#self.datas

local level=UIXianShuControl:getLevel()
local isFinish=level>=maxLevel

self:setRewardItem(index or slevel,item,true)

item:SetChildActive(_rw_index.spPanel,isFinish)
item:SetChildActive(_rw_index.norPanel,not isFinish)
item:SetChildActive(_rw_index.tipsBtn,isFinish)
if isFinish then
item:SetChildText(_rw_index.level,'满级')
local exp=UIXianShuControl:getExp()

item:SetChildText(_rw_index.expCount,FMT.fmt('{0}/{1}',exp,self.needExp))
local canReceive=exp>=self.needExp
item:SetChildActive(_rw_index.rclick,canReceive)
item:SetChildActive(_rw_index.effect4,canReceive)
if canReceive then
if not self.isPlayEffect4 then
self.isPlayEffect4=true
item:SetChildAnimationStringID(_rw_index.effect4,'xianshu_light',false)
end
item:SetChildButtonClick(_rw_index.rclick,function()
if level>=maxLevel then
UIXianShuControl:reqReward(2)
else













if self.rechargeState~=0 then

UIXianShuControl:reqReward(1)
return
end
end
end)
end
local spReward=cfgHelper.get2(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId(),'gifts')
local rwId=spReward[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
widgetHelper.setNormalRewardItem(item,_rw_index.spItem,rewards[1])
item:SetChildButtonClick(_rw_index.tipsBtn,function()
self.tipsPanel:setActive(true)
end,true)
end
end

function UITouZiXianShuWin:showDialog(content,callback,ok,cancel)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext=ok or'确定',
canceltext=cancel or'取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function UITouZiXianShuWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local lerp=UIXianShuControl:getRemainingTime()
if lerp>0 then

self.timeText:setText(FMT.fmt("剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("本期仙书已结束")
UIXianShuControl:closeAllXianShuWindow()

end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UITouZiXianShuWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UITouZiXianShuWin:getTaskDatas()
local datas=UIXianShuControl:getTaskDatas()

local slist={[0]=2,2,1,3}
local sortFunc=function(a,b)
local cv1=slist[a.taskstate]
local cv2=slist[b.taskstate]
if cv1<cv2 then
return true
elseif cv1==cv2 then
return a.taskid<b.taskid
else
return false
end
end


local newdatas={}
for k,v in pairs(datas)do
local newtaskList={}
for kk,vv in pairs(v)do
local taskid=vv.taskid
if taskid then
local task_condition=cfgHelper.get2(cfg_fairybooktaskconfig_get,taskid,'condition')
if task_condition and task_condition[1]and task_condition[2]then
local _type=task_condition[1]
local _id=task_condition[2]
local isOpen=false
if _type==TaskConditionType.system then
if systemModel.isOpen(_id)then
isOpen=true
end
elseif _type==TaskConditionType.build then
if zongmenModel:haveBuildByBuildIdEx(_id)then
isOpen=true
end
end
if isOpen then
newtaskList[vv.taskid]=vv
end
else
newtaskList[vv.taskid]=vv
end
end
end
newdatas[k]=newtaskList
end


local taskDatas={}
for k,v in pairs(newdatas)do
local taskList={}
for kk,vv in pairs(v)do
table.insert(taskList,vv)
end
table.sort(taskList,sortFunc)
taskDatas[k]=taskList
end


return taskDatas
end

function UITouZiXianShuWin:showSelectBtn(ttype)
local check1=ttype==1
local check2=ttype==2
local check3=ttype==3
self.taskA:setActive(true)
self.taskB:setActive(true)
self.taskBtnA:setActive(not check1)
self.taskBtnA2:setActive(check1)
self.taskBtnB:setActive(not check2)
self.taskBtnB2:setActive(check2)
local data3=self.taskDatas[3]
local hasData3=data3 and#data3>0 or false
self.taskC:setActive(hasData3)
self.taskBtnC:setActive(hasData3 and not check3)
self.taskBtnC2:setActive(hasData3 and check3)

self.reddotA:setActive(UIXianShuControl:checkTaskReddotByType(1))
self:doPunchRotationA(UIXianShuControl:checkTaskReddotByType(1))
self.reddotB:setActive(UIXianShuControl:checkTaskReddotByType(2))
self:doPunchRotationB(UIXianShuControl:checkTaskReddotByType(2))
self.reddotC:setActive(hasData3 and UIXianShuControl:checkTaskReddotByType(3))
self:doPunchRotationC(hasData3 and UIXianShuControl:checkTaskReddotByType(3))
end

function UITouZiXianShuWin:refreshTaskList(ttype)
if self.currShowType==ttype and not self.bRefresh then
return
end

self:showSelectBtn(ttype)

self.currShowType=ttype

local taskList=self.taskDatas[ttype]
local len=#taskList
self.taskScrollView:setChildScrollViewCreateGrids(len,1)

local grids=self.taskScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local task=taskList[i]
local cfg=cfgHelper.get1(cfg_fairybooktaskconfig_get,task.taskid)
item:SetChildText(0,cfg.name)
item:SetChildText(1,FMT.fmt('{0}({1}/{2})',cfg.taskaimdesc,task.taskprogress,cfg.aimnum))
local jumpArgs=cfg.jump
local state=task.taskstate
local check1=state==1 and jumpArgs~=nil
local check2=state==2
local check3=state==3
item:SetChildActive(2,check1)
if check1 then
item:SetChildButtonClick(2,function()
jumpManager:jump(jumpArgs)
end)
end
item:SetChildActive(3,check2)
if check2 then
item:SetChildButtonClick(3,function()
UIXianShuControl:reqTaskReward(task.taskid)
end)
end
item:SetChildActive(4,check3)
widgetHelper.setNormalRewardItem(item,5,cfg.taskReward[1])
end
end

function UITouZiXianShuWin:onTaskBtnA()
self:refreshTaskList(1)
end

function UITouZiXianShuWin:onTaskBtnB()
self:refreshTaskList(2)
end

function UITouZiXianShuWin:onTaskBtnC()
self:refreshTaskList(3)
end



function UITouZiXianShuWin:onActiveBtn()
UIManager:showWindow('UIXianShuActiveWin')
end

function UITouZiXianShuWin:onBuyLevelBtn()
UIManager:showWindow('UIXianShuBuyLevelWin')
end

function UITouZiXianShuWin:onTipsPanel()
self.tipsPanel:setActive(false)
end

function UITouZiXianShuWin:onOneKeyGetRewardBtn()


end

function UITouZiXianShuWin:onTaskBtn()
if self.tabType==_tabType.eBuy then
self.tabType=_tabType.eTask
else
self.tabType=_tabType.eBuy
end
self:refresh()
end

function UITouZiXianShuWin:doPunchRotation(isreddot)
if isreddot then
if self.reddotTweener==nil then
self.taskBtnReddot:setRotation(0,0,0)
local tweener=self.taskBtnReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.taskBtnReddot:setRotation(0,0,0)
end
end
end

function UITouZiXianShuWin:doPunchRotationA(isreddot)
if isreddot then
if self.reddotATweener==nil then
self.reddotA:setRotation(0,0,0)
local tweener=self.reddotA:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotATweener=tweener
end
else
if self.reddotATweener~=nil then
self.reddotATweener:Complete()
self.reddotATweener:Kill()
self.reddotATweener=nil
self.reddotA:setRotation(0,0,0)
end
end
end

function UITouZiXianShuWin:doPunchRotationB(isreddot)
if isreddot then
if self.reddotBTweener==nil then
self.reddotB:setRotation(0,0,0)
local tweener=self.reddotB:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotBTweener=tweener
end
else
if self.reddotBTweener~=nil then
self.reddotBTweener:Complete()
self.reddotBTweener:Kill()
self.reddotBTweener=nil
self.reddotB:setRotation(0,0,0)
end
end
end

function UITouZiXianShuWin:doPunchRotationC(isreddot)
if isreddot then
if self.reddotCTweener==nil then
self.reddotC:setRotation(0,0,0)
local tweener=self.reddotC:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotCTweener=tweener
end
else
if self.reddotCTweener~=nil then
self.reddotCTweener:Complete()
self.reddotCTweener:Kill()
self.reddotCTweener=nil
self.reddotC:setRotation(0,0,0)
end
end
end

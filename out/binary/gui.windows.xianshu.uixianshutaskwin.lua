







def_class("UIXianShuTaskWin",UIWindowBase)









function UIXianShuTaskWin:bindComponents()

self.speakContent=UIText.get(self,0)
self.scrollView=UIObject.get(self,1)
self.taskBtnA=UIButton.get(self,2)
self.taskBtnB=UIButton.get(self,3)
self.taskBtnC=UIButton.get(self,4)
self.taskBtnA2=UIObject.get(self,5)
self.taskBtnB2=UIObject.get(self,6)
self.taskBtnC2=UIObject.get(self,7)
self.reddotA=UIObject.get(self,8)
self.reddotB=UIObject.get(self,9)
self.reddotC=UIObject.get(self,10)
self.tqmodel=UIObject.get(self,11)
self.speakKuang=UIObject.get(self,12)

self.taskBtnA:setButtonClick(function()self:onTaskBtnA()end)

self.taskBtnB:setButtonClick(function()self:onTaskBtnB()end)

self.taskBtnC:setButtonClick(function()self:onTaskBtnC()end)



end


function UIXianShuTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.speakContent);self.speakContent=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.taskBtnA);self.taskBtnA=nil;
_UIObject_release(self.taskBtnB);self.taskBtnB=nil;
_UIObject_release(self.taskBtnC);self.taskBtnC=nil;
_UIObject_release(self.taskBtnA2);self.taskBtnA2=nil;
_UIObject_release(self.taskBtnB2);self.taskBtnB2=nil;
_UIObject_release(self.taskBtnC2);self.taskBtnC2=nil;
_UIObject_release(self.reddotA);self.reddotA=nil;
_UIObject_release(self.reddotB);self.reddotB=nil;
_UIObject_release(self.reddotC);self.reddotC=nil;
_UIObject_release(self.tqmodel);self.tqmodel=nil;
_UIObject_release(self.speakKuang);self.speakKuang=nil;
end

















local TaskConditionType=
{
system=1,
build=2,
}

local _this


function UIXianShuTaskWin:onLoaded(...)
self:bindComponents()
_this=self
self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXianShuTaskWin:__delete()
_this=nil
self:stopTqModelSpeak()
self:unbindComponents()
end




function UIXianShuTaskWin:onShow(argtable,afterOnloaded)


self:refresh()
end


function UIXianShuTaskWin:onHide()

end

function UIXianShuTaskWin:refresh()
self.bRefresh=true
self.taskDatas=self:getTaskDatas()
local istypea=UIXianShuControl:checkTaskReddotByType(1)
local istypeb=UIXianShuControl:checkTaskReddotByType(2)
if not istypea and istypeb and not self.currShowType then
self.currShowType=2
end
self:refreshTaskList(self.currShowType or 1)
self.bRefresh=false

self:refreshTQModel()
end




function UIXianShuTaskWin:getTaskDatas()
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
if UIXianShuControl:checkTaskOpenCondition(taskid)then
newtaskList[taskid]=vv
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

function UIXianShuTaskWin:showSelectBtn(ttype)
local check1=ttype==1
local check2=ttype==2
local check3=ttype==3
self.taskBtnA:setActive(not check1)
self.taskBtnA2:setActive(check1)
self.taskBtnB:setActive(not check2)
self.taskBtnB2:setActive(check2)
local data3=self.taskDatas[3]
local hasData3=data3 and#data3>0 or false

self.taskBtnC:setActive(hasData3 and not check3)
self.taskBtnC2:setActive(hasData3 and check3)

self.reddotA:setActive(UIXianShuControl:checkTaskReddotByType(1))
self.reddotB:setActive(UIXianShuControl:checkTaskReddotByType(2))
self.reddotC:setActive(hasData3 and UIXianShuControl:checkTaskReddotByType(3))
end

function UIXianShuTaskWin:refreshTaskList(ttype)
if self.currShowType==ttype and not self.bRefresh then
return
end

self:showSelectBtn(ttype)

self.currShowType=ttype

local taskList=self.taskDatas[ttype]
local len=#taskList
self.scrollView:setChildScrollViewCreateGrids(len,1)

local grids=self.scrollView:getChildScrollViewItemWidgets()
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

function UIXianShuTaskWin:onTaskBtnA()
self:refreshTaskList(1)
end

function UIXianShuTaskWin:onTaskBtnB()
self:refreshTaskList(2)
end

function UIXianShuTaskWin:onTaskBtnC()
self:refreshTaskList(3)
end

function UIXianShuTaskWin:refreshTQModel()
local tqState=UIXianShuControl:getOpenTQState()
self.tqmodel:setActive(tqState)

if tqState then

local params=UIXianShuControl:getTqModelParams()
if params then
local npcImgId=params[1]
local npcInfo=npcModel:getImageInfoOutSide(npcImgId)
local modelid=npcInfo.body
local scale=params[2]or npcInfo.scale
local compoments=npcInfo.componets
local animation=params[3]or npcInfo.anim
local pos=params[4]or{0,0}
local flipx=params[5]or 0
local kuangOffset=params[6]or{0,0}
local modelOffset=params[7]or{0,0}

local cb=function()

self:startTqModelSpeak()
end
self.tqmodel:setChildUIModelShowTarget(modelid,scale,compoments,animation,false,false,0.2,cb)
self.tqmodel:setChildAnchoredPos(pos[1],pos[2])
self.tqmodel:setChildUIModelShowFlipX(flipx==1)
self.speakKuang:setChildAnchoredPos(kuangOffset[1],kuangOffset[2])
self.tqmodel:setChildUIModelShowTargetOffset(modelOffset[1],modelOffset[2])
else

end
else


self:stopTqModelSpeak()
end
end

function UIXianShuTaskWin:stopTqModelSpeak()
if self.tqModelSpeakTimeId then
self:stopTimerByID(self.tqModelSpeakTimeId)
self.tqModelSpeakTimeId=nil
end
self.speakKuang:setActive(false)
end

function UIXianShuTaskWin:startTqModelSpeak()
local speakList=UIXianShuControl:getTqSpeakList()

self:stopTqModelSpeak()

local stamp=timeHelper.getServerShortTime()
local interval=0
local durationInterval
local state=0
local content
local speakIndex=0
local speakLen=#speakList
local func=function()
if not _this then return end

local curStamp=timeHelper.getServerShortTime()

if curStamp-stamp>=interval and state==0 then
content=speakList[speakIndex+1]
_this.speakKuang:setActive(true)
_this.speakContent:setText(content)
state=1
stamp=curStamp
durationInterval=Mathf.Random(5,6)
end

if state==1 and curStamp-stamp>=durationInterval then
_this.speakKuang:setActive(false)
state=0
interval=1
stamp=curStamp
speakIndex=(speakIndex+1)%speakLen
end
end

self.tqModelSpeakTimeId=self:setTimer(1,0,func)
end

function UIXianShuTaskWin:onJumpTQAct()
local openState,actInfo=UIXianShuControl:checkActOpenAndHasTQEffect()
if openState then
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=actInfo.sub_act_type,subid=actInfo.sub_act_id}},function()

end)
end
end

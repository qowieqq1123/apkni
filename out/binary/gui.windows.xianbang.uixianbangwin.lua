







def_class("UIXianBangWin",UIWindowBase)









function UIXianBangWin:bindComponents()

self.aiRoot=UIObject.get(self,0)
self.cddjzbProgress=UIObject.get(self,1)
self.centerpanel=UIObject.get(self,2)
self.cloud=UIButton.get(self,3)
self.duilieBtn=UIButton.get(self,4)
self.posCenter=UIObject.get(self,5)
self.posLeft1=UIObject.get(self,6)
self.posLeft2=UIObject.get(self,7)
self.posRight1=UIObject.get(self,8)
self.posRight2=UIObject.get(self,9)
self.ruleBtn=UIButton.get(self,10)
self.sxtime=UIText.get(self,11)
self.taskScrollerView=UIObject.get(self,12)
self.taskscrollerview2=UIObject.get(self,13)
self.timedjzb=UIText.get(self,14)
self.tipsbtn=UIButton.get(self,15)
self.xblvl=UIText.get(self,16)
self.XWZSBtn=UIButton.get(self,17)
self.xwzsreddot=UIObject.get(self,18)

self.cloud:setButtonClick(function()self:onCloud()end)

self.duilieBtn:setButtonClick(function()self:onDuilieBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.XWZSBtn:setButtonClick(function()self:onXWZSBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXianBangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.aiRoot);self.aiRoot=nil;
_UIObject_release(self.cddjzbProgress);self.cddjzbProgress=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.duilieBtn);self.duilieBtn=nil;
_UIObject_release(self.posCenter);self.posCenter=nil;
_UIObject_release(self.posLeft1);self.posLeft1=nil;
_UIObject_release(self.posLeft2);self.posLeft2=nil;
_UIObject_release(self.posRight1);self.posRight1=nil;
_UIObject_release(self.posRight2);self.posRight2=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.sxtime);self.sxtime=nil;
_UIObject_release(self.taskScrollerView);self.taskScrollerView=nil;
_UIObject_release(self.taskscrollerview2);self.taskscrollerview2=nil;
_UIObject_release(self.timedjzb);self.timedjzb=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.xblvl);self.xblvl=nil;
_UIObject_release(self.XWZSBtn);self.XWZSBtn=nil;
_UIObject_release(self.xwzsreddot);self.xwzsreddot=nil;
end

















local _this
local abname="ui/windows/xianbang/xianbang_atlas_pak.ab"
local itemidx=
{
taskitem=0,
root=1,
coloricon=2,
icon=3,
btn=4,
effect=5,
bg=6,
stageimg=7,
}
local dizilist={{body=101011,compont={101011}},
{body=109011,compont={109011}},
{body=103011,compont={103011}},
}



function UIXianBangWin:onLoaded(...)
self:bindComponents()
_this=self
self.isduilie=false
self:addNotify(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
end


function UIXianBangWin:__delete()
self:unbindComponents()
self:clearTimer()
_this=nil
end
function UIXianBangWin.onChangeXianGuanJob()
_this:refreshBtn()
end



function UIXianBangWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.data
self.sfId=zongmenModel:getMountainId()
self.xbcfg=cfg_xianbangbaseconfig_get(1)
self.isduilie=false
self.centerpanel:setChildCanvasGroupAlpha(0)
self.centerpanel:setChildCanvasGroupDOFade(1,0.6,function()
if _this==nil then return end
end)





self.sxtime:setText(FMT.fmt('每周一5点刷新仙榜任务'))
self:initdata(true)






















self:refreshBtn()
end


function UIXianBangWin:getRandomSpeakText(bt,tkey,idx)
local speakList=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"speakText")[idx]
local speakStr=speakList[math.random(1,#speakList)]or''
bt:setSharedVar(tkey,speakStr)
end
function UIXianBangWin:createDZ(dzData,pos,stateId,isEnter,callback)
local posList=
{
posCenter=self.posCenter:getChildAnchoredPosition(),
posLeft1=self.posLeft1:getChildAnchoredPosition(),
posLeft2=self.posLeft2:getChildAnchoredPosition(),
posRight1=self.posRight1:getChildAnchoredPosition(),
posRight2=self.posRight2:getChildAnchoredPosition(),
}
local initData={
sepaktime=3,
speakrate=0.5,
speakHUDParent=1,
stateId=stateId,
isEnter=isEnter or 0,

offset={0,120},

posCenter={posList.posCenter.x,posList.posCenter.y},
posLeft1={posList.posLeft1.x,posList.posLeft1.y},
posLeft2={posList.posLeft2.x,posList.posLeft2.y},
posRight1={posList.posRight1.x,posList.posRight1.y},
posRight2={posList.posRight2.x,posList.posRight2.y},
}
local tran=self.aiRoot:getCommonComponent('Transform')
uiAIManager:createUIObject('UIShangHangWin','bt_shanghang_enter',INSTANCE_TYPE.eUIDisciple,dzData.body,tran,pos,initData,{scale=0.8,componets=dzData.compont},function(bt)
callback(bt)
end)
end


function UIXianBangWin:onHide()

end
function UIXianBangWin:onCloud()
end

function UIXianBangWin:oncloseClick()
UIFullXianBangControl:closeUI()
end

function UIXianBangWin:severfresh()
_this:initdata()
end

function UIXianBangWin:severfreshtime()
_this:startCountDown()
end

function UIXianBangWin:onRuleBtn()
local d={}
d.title='规则'
d.mode=3
d.name='UIXianBangWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIXianBangWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIXianBangWin:onDuilieBtn()
self.isduilie=not self.isduilie
if self.isduilie then

self.winlua:SetChildCSImageSprite(self.duilieBtn:getID(),abname,"button_duilie_2")
else
self.winlua:SetChildCSImageSprite(self.duilieBtn:getID(),abname,"button_duilie_1")
end
end

function UIXianBangWin:onTipsbtn()
self:showWindow("UIXBTipsWin")
end

function UIXianBangWin:onClickBtn(index)

















local taskdata=xianjiexianbangModel:getXBTaskData()
local data=taskdata[index]

local _taskId=data.taskId
local _finishFlag=data.finishFlag
if _finishFlag==1 then
xianjiexianbangController:send_37_82()
elseif _finishFlag==0 then
local temp=
{
taskId=_taskId
}
self:showWindow("UIXianBanTaskWin",temp)
end
end


function UIXianBangWin:ReqTaskFresh()
local xblevel=xianjiexianbangModel:getXBLevel()
local lvlcfg=cfg_xianbanglevelconfig_get(xblevel)
if lvlcfg then
local taskMax=lvlcfg.taskMax
local alltask=xianjiexianbangModel:getXBTaskData()
if#alltask<taskMax then
xianjiexianbangController:send_37_84()
end
end
end

function UIXianBangWin:cheakReqNewTask()
local todayZeroTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
local lasttime=xianjiexianbangModel:getXBrefreshTime()
local nowtime=timeHelper.getServerShortTime()

if lasttime<nowtime then
local newidx=0
local oldidx=0
local cfgTime=self.xbcfg.refreshTime
for k,v in ipairs(cfgTime)do
local dtime=todayZeroTime+v*3600
if nowtime>dtime then
newidx=k
end
if lasttime>dtime then
oldidx=k
end
end

if newidx>oldidx then

self:ReqTaskFresh()
end
end
end

function UIXianBangWin:startCountDown()
self:clearTimer()
local todayZeroTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
local cfgTime=self.xbcfg.refreshTime
local nowtime=timeHelper.getServerShortTime()
local index=1
local djstime=0
for k,v in ipairs(cfgTime)do
local dtime=todayZeroTime+v*3600
if nowtime>dtime then
index=k+1
end
end
if index>#cfgTime then
djstime=todayZeroTime+86400+cfgTime[1]*3600
else
djstime=todayZeroTime+cfgTime[index]*3600
end

local tick=function()
local dt=djstime-gameUtilityModel.getServerShortTime()+3
if dt>0 then

else
self:clearTimer()
self:ReqTaskFresh()
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end


function UIXianBangWin:sortlist()
local list=xianjiexianbangModel:getXBTaskData()or{}
for k,v in ipairs(list)do
local flag=cfg_xianbangtaskconfig_get(v.taskId).flag
local color=cfg_xianbangtaskconfig_get(v.taskId).color
v.sortflag=color
if flag then
v.sortflag=color+100000
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.sortflag>b.sortflag
end)
end
return list
end


function UIXianBangWin:freshicon(widget,taskcfg)
local taskicons=taskcfg.taskicon
widget:SetChildCSImageSprite(itemidx.icon,abname,taskicons)
end

function UIXianBangWin:initdata(init)
self.taskScrollerView:setActive(false)
self.taskscrollerview2:setActive(false)

local xblevel=xianjiexianbangModel:getXBLevel()
self.xblvl:setText(xblevel)


local finishNum=xianjiexianbangModel:getXBfinishNum()
local cfg=cfg_xianbanglevelconfig_get(xblevel)
local maxNum=cfg.upLevel
self.cddjzbProgress:setChildUIProgressbar(finishNum,maxNum,true)
self.timedjzb:setText(FMT.fmt("{0}/{1}",finishNum,maxNum))
if not cfg_xianbanglevelconfig_get(xblevel+1)then
self.timedjzb:setText("已满级")
end


local taskdata=self:sortlist()
local len=#taskdata
if len>0 then
if len>6 then
self.taskScrollerView:setActive(true)
self.taskScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.taskScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local data=taskdata[i]
local taskId=data.taskId
local taskcfg=cfg_xianbangtaskconfig_get(taskId)
widget:SetChildCSImageSprite(itemidx.coloricon,abname,taskcfg.tasknameimg)
widget:SetChildCSImageSprite(itemidx.bg,abname,taskcfg.taskimg)

self:freshicon(widget,taskcfg)







widget:SetChildActive(itemidx.stageimg,false)
local finishFlag=data.finishFlag
local runFlag=data.runFlag
if finishFlag==1 then
widget:SetChildActive(itemidx.stageimg,true)
widget:SetChildCSImageSprite(itemidx.stageimg,abname,"image_xianbangui_14")
else
if runFlag==1 then
widget:SetChildCSImageSprite(itemidx.stageimg,abname,"image_xianbangui_13")
end
end
widget:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onClickBtn(i)
end)
end
else
self.taskscrollerview2:setActive(true)
for i=1,6 do
local widget2=self.taskscrollerview2:getWidgetBase()
local data=taskdata[i]
if data then
widget2:SetChildActive(i-1,true)
local item=widget2:GetChildWidgetBase(i-1)
if item then
local taskId=data.taskId
local taskcfg=cfg_xianbangtaskconfig_get(taskId)
item:SetChildCSImageSprite(itemidx.coloricon,abname,taskcfg.tasknameimg)
item:SetChildCSImageSprite(itemidx.bg,abname,taskcfg.taskimg)
self:freshicon(item,taskcfg)






item:SetChildActive(itemidx.stageimg,false)
local finishFlag=data.finishFlag
local runFlag=data.runFlag
if finishFlag==1 then
item:SetChildActive(itemidx.stageimg,true)
item:SetChildCSImageSprite(itemidx.stageimg,abname,"image_xianbangui_14")
else
if runFlag==1 then
item:SetChildActive(itemidx.stageimg,true)
item:SetChildCSImageSprite(itemidx.stageimg,abname,"image_xianbangui_13")
end
end
item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onClickBtn(i)
end)
end
else
widget2:SetChildActive(i-1,false)
end
end
end
else
self.taskScrollerView:setActive(false)
if init then
UIManager.info("暂无任务刷新")
end
end
end



function UIXianBangWin:testprintxbtask(taskid)
local cfg=cfg_xianbangtaskconfig_get(taskid)
UIManager.info(FMT.fmt("{0} 资源点类型{1} 资源点id{2}  品质{3}",cfg.name,cfg.xjres[1],cfg.xjres[2]or 0,cfg.color))
end
function UIXianBangWin:testprintxbtask2()

end


function UIXianBangWin:refreshBtn()
if not xianguanHelper.checkTeQuanPlatformLimit(10)then
_this.XWZSBtn:setActive(false)
return
end

local jobflag=xianguanController:checkSelfHasJobByType(10)
local reddotflag=xianguanModel:getSelecttask()
_this.xwzsreddot:setActive(xianguanController.getSelfPrivilegeUseReddot()or reddotflag)
_this.XWZSBtn:setActive(jobflag)
end

function UIXianBangWin:onXWZSBtn()
self.jobflag,self.xgid=xianguanController:checkSelfHasJobByType(10)
self.tqId=10
local state=xianguanHelper.checkTeQuanUseCondition(self.xgid,self.tqId,false)
local flag=xianguanModel:getSelecttask()
if flag then
self:showWindow("UIXianBanTeQuanTaskWin",{jobflag=self.jobflag,xgid=self.xgid})
elseif state then
self:showWindow("UIXianBanTeQuanTaskWin",{jobflag=self.jobflag,xgid=self.xgid})
else
local nexttime=xianguanConfig.getResetCD(self.tqId)
local time_str
if nexttime>0 then
time_str=timeHelper.format_time_stamp5(nexttime)
if time_str==""then
time_str=tostring(nexttime)..'秒'
end
UIManager.info((string.format("本周已发布过任务，%s后重置次数",time_str)))
end

end
end









def_class("UITaskMainWin",UIWindowBase)









function UITaskMainWin:bindComponents()

self.comboScrollView=UIComboScrollView.get(self,0)
self.commitBtn=UIButton.get(self,1)
self.commitBtnIcon=UIImage.get(self,2)
self.commitTxt=UIText.get(self,3)
self.goodGrid=UIObject.get(self,4)
self.noTaskTips=UIObject.get(self,5)
self.rightPanel=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.showTypeClick_1=UIButton.get(self,8)
self.taskCondition=UIObject.get(self,9)
self.taskConditionTxt=UIText.get(self,10)
self.taskDesc=UIText.get(self,11)
self.taskGrid=UIScrollView.get(self,12)
self.taskName=UIText.get(self,13)
self.taskProgress=UIObject.get(self,14)
self.taskTimeTxt=UIText.get(self,15)
self.zhuizong=UIToggleButton.get(self,16)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.showTypeClick_1:setButtonClick(function()self:onShowTypeClick_1()end)
self.showTypeClick={
self.showTypeClick_1,
}



end


function UITaskMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.comboScrollView);self.comboScrollView=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnIcon);self.commitBtnIcon=nil;
_UIObject_release(self.commitTxt);self.commitTxt=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
_UIObject_release(self.noTaskTips);self.noTaskTips=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showTypeClick_1);self.showTypeClick_1=nil;
_UIObject_release(self.taskCondition);self.taskCondition=nil;
_UIObject_release(self.taskConditionTxt);self.taskConditionTxt=nil;
_UIObject_release(self.taskDesc);self.taskDesc=nil;
_UIObject_release(self.taskGrid);self.taskGrid=nil;
_UIObject_release(self.taskName);self.taskName=nil;
_UIObject_release(self.taskProgress);self.taskProgress=nil;
_UIObject_release(self.taskTimeTxt);self.taskTimeTxt=nil;
_UIObject_release(self.zhuizong);self.zhuizong=nil;
self.showTypeClick=nil;
end
















local _this=nil
local comboIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
zhuizong=4,
newsign=5,
}

local comboChildIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
zhuizong=4,
newsign=5,
xiyou=6,
flag=7,
}

local _flagHandle={
[4]=function(taskdata)
local faction=taskModel:getXJFactionByTaskFlag(taskdata.cfg.xianjietype)
local config=cfgHelper.get1(cfg_xianjieforceconfig_get,faction)
return config.factionTaskFlagIcon
end
}

function UITaskMainWin:onLoaded(...)
self:bindComponents()
_this=self






local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.comboScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

self.zhuizong:setToggleChange(function(name,isOn)
local taskdata=_this:Gettaskdata()
if isOn then

if self.zhuizongMainindex and self.zhuizongSubindex then
local oldsubItem=self.comboScrollView:getSubItem(self.zhuizongMainindex-1,self.zhuizongSubindex-1)
local oldMainItem=self.comboScrollView:getMainItem(self.zhuizongMainindex-1)
if oldsubItem then
oldsubItem:SetChildActive(comboChildIndex.zhuizong,false)
end
if oldMainItem then
oldMainItem:SetChildActive(comboChildIndex.zhuizong,false)
end
end

local newsubItem=self.comboScrollView:getSubItem(self.mainIndex-1,self.subIndex-1)
local newMainItem=self.comboScrollView:getMainItem(self.mainIndex-1)
if newsubItem then
newsubItem:SetChildActive(comboChildIndex.zhuizong,true)
end
if newMainItem then
newMainItem:SetChildActive(comboChildIndex.zhuizong,true)
end

taskModel:SaveZhuizong(taskdata.taskline)
self:recordZhuiZongIndex(self.mainIndex,self.subIndex)
else
local flag=taskModel:isZhuiZongTask(taskdata.taskline)

if flag then
taskModel:SaveZhuizong()
if self.zhuizongMainindex and self.zhuizongSubindex then
local oldsubItem=self.comboScrollView:getSubItem(self.zhuizongMainindex-1,self.zhuizongSubindex-1)
local oldMainItem=self.comboScrollView:getMainItem(self.zhuizongMainindex-1)
if oldsubItem then
oldsubItem:SetChildActive(comboChildIndex.zhuizong,false)
end
if oldMainItem then
oldMainItem:SetChildActive(comboChildIndex.zhuizong,false)
end
self:recordZhuiZongIndex(nil,nil)
end
end
end
end)

notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
self:addNotify(notifyConfig.onSystemZMInfoChange,self.onSystemZMInfoChange)
end


function UITaskMainWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
end


function UITaskMainWin:onHide()

end

function UITaskMainWin.onTaskChange(taskid,taskstate)
if _this==nil then return end
local taskcfg=taskModel:getTaskConfig(taskid)
if not _this:hasTask(taskid)and not _this:hasTaskLine(taskcfg.tasklineid)then return end

local o_s_mainindex=_this.mainindex
local o_s_subindex=_this.subindex

local taskdata=_this:Gettaskdata()
local old_taskid=taskdata.taskid

if _this:getAllTaskNum()>0 then
if old_taskid==taskid then
if taskstate==taskModel.taskFinishState then
_this.mainindex=1
_this.subindex=1
end













end
else
_this.mainindex=1
_this.subindex=nil
end
_this:rebuildSub()


_this:refreshDescWin()
end

function UITaskMainWin.onSystemZMInfoChange(serial,type,oldVal,param)
if type==systemZongMenInfoUpdateType.eRelation then
if oldVal==systemZongMenRelationType.eDiDui or param==systemZongMenRelationType.eDiDui then

local o_s_mainindex=_this.mainindex
local o_s_subindex=_this.subindex

local taskdata=_this:Gettaskdata()
local old_taskid=taskdata.taskid

if _this:getAllTaskNum()>0 then
if old_taskid==taskid then
if taskstate==taskModel.taskFinishState then
_this.mainindex=1
_this.subindex=1
end













end
else
_this.mainindex=1
_this.subindex=nil
end
_this:rebuildSub()


_this:refreshDescWin()
end
end
end




function UITaskMainWin:onShow(argtable,afterOnloaded)

self:GetAllTaskList()
self.curTaskIndex=1
self.defaultMainIndex=1
self:refreshComboWidget()


self:refreshDescWin()
end

function UITaskMainWin:refreshComboWidget()
self.zhuxianNew,self.xianjieNew,self.zhixianNew=taskModel:GetHaveNewTask()
self.taksIDLookUp={}
self.taksLineIDLookUp=self.taksLineIDLookUp or{}
local c=#self.tagList
self.comboScrollView:createMainGrids(c,1,true)




for i,v in ipairs(self.tagList)do
local data=v.data
if data then
for a,b in ipairs(data)do
self.taksIDLookUp[b.taskid]=true
local taskcfg=taskModel:getTaskConfig(b.taskid)
self.taksLineIDLookUp[taskcfg.tasklineid]=true
end
end

end
end
function UITaskMainWin:rebuildSub()
self.comboScrollView:removeAllGrids()
self.defaultMainIndex=1

self:refreshComboWidget()

end


function UITaskMainWin:GetAllTaskList()
self.tagList=taskModel:GetShowTaskList()

end

function UITaskMainWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local data=self.tagList[index]
if data then
local zhuizongflag=taskModel:GetZhuiZongTaskType()

mainItem:SetChildText(comboIndex.name,data.name)
if data.name=="主线"then
mainItem:SetChildActive(comboIndex.newsign,self.zhuxianNew)
mainItem:SetChildActive(comboIndex.zhuizong,zhuizongflag==1)
elseif data.name=="仙界"then
mainItem:SetChildActive(comboIndex.newsign,self.xianjieNew)
mainItem:SetChildActive(comboIndex.zhuizong,zhuizongflag==2)
elseif data.name=="支线"then
mainItem:SetChildActive(comboIndex.newsign,self.zhixianNew)
mainItem:SetChildActive(comboIndex.zhuizong,zhuizongflag==3)
else
mainItem:SetChildActive(comboIndex.zhuizong,false)
mainItem:SetChildActive(comboIndex.newsign,false)
end

self:refreshMainItemSelect(mainItem,index,false)

if data.data and#data.data>0 then
self.subIndex=1
mainItem:SetAddExpandColumCount(#data.data)
else
self.subIndex=nil
mainItem:SetAddExpandColumCount(0)
end
local reddot=false

mainItem:SetChildActive(comboIndex.reddot,reddot)
end

if index==#self.tagList then
if self.defaultMainIndex~=nil then
self.comboScrollView:clickItem(self.defaultMainIndex-1)
self.defaultMainIndex=nil
end
end
end

function UITaskMainWin:refreshMainItemSelect(mainItem,mainIndex,flag)
if mainItem==nil then
mainItem=self.comboScrollView:getMainItem(mainIndex-1)
end
if mainItem then
mainItem:SetChildActive(comboIndex.select,flag)
if self.zhuizongMainindex then
mainItem:SetChildActive(comboIndex.zhuizong,self.zhuizongMainindex==mainIndex)
end

end
end

function UITaskMainWin:mainClickAction(mainItem)
local oldMainIndex=self.mainIndex
local index=mainItem.Index+1
if index==oldMainIndex then
return
end
self.mainIndex=index
self:refreshMainItemSelect(mainItem,index,true)
if oldMainIndex~=nil then
self:refreshMainItemSelect(nil,oldMainIndex,false)
end
local data=self.tagList[self.mainIndex]
if data and data.data and#data.data>0 then
self.subIndex=1

self:refreshDescWin()
else
self.subIndex=nil
end
end

function UITaskMainWin:subClickAction(subItem)

local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local oldSubIndex=self.subIndex
if subIndex==oldSubIndex then
return
end
self.subIndex=subIndex

if oldSubIndex then
local oldSubItem=self.comboScrollView:getSubItem(mainIndex-1,oldSubIndex-1)
oldSubItem:SetChildActive(comboChildIndex.select,false)

AudioManager.playBtnClick()
end
subItem:SetChildActive(comboChildIndex.select,true)

local data=self.tagList[mainIndex]
if data.data then

self:refreshDescWin()
end
end

function UITaskMainWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.tagList[mainIndex]
if data then
local taskdata=data.data
if taskdata and#taskdata>0 then

local cfg=taskdata[index].cfg

subItem:SetChildText(comboChildIndex.name,cfg.name)
subItem:SetChildActive(comboChildIndex.select,index==self.subIndex)
local reddot=false
subItem:SetChildActive(comboChildIndex.reddot,reddot)
local flag=taskModel:isZhuiZongTask(taskdata[index].taskline)
subItem:SetChildActive(comboChildIndex.zhuizong,flag)
if flag then
self:recordZhuiZongIndex(mainIndex,index)
end
local newflag=taskModel:GetisNewTask(taskdata[index].taskline)
subItem:SetChildActive(comboChildIndex.newsign,newflag)

local isShow,type=taskModel:isRareTask(cfg.id)
isShow=isShow and type==1
subItem:SetChildActive(comboChildIndex.xiyou,isShow)
if isShow then
subItem:SetChildCSImageSprite(comboChildIndex.xiyou,globalABLookup.global,"image_xi_1")
end

local flagHandle=_flagHandle[data.flag]
local flagName=flagHandle and flagHandle(taskdata[index])or""
if flagName==""then

subItem:SetChildCSImageIcon(comboChildIndex.flag,"",true)
else
subItem:SetChildCSImageSprite(comboChildIndex.flag,globalABLookup.globa4,flagName)
end
end
end
end

function UITaskMainWin:recordZhuiZongIndex(mainIndex,index)
self.zhuizongMainindex=mainIndex
self.zhuizongSubindex=index
self:SetMainZhuiZong()
end

function UITaskMainWin:SetMainZhuiZong()
if self.zhuizongMainindex then
local MainItem=self.comboScrollView:getMainItem(self.zhuizongMainindex-1)
if MainItem then
MainItem:SetChildActive(comboChildIndex.zhuizong,true)
end
end
end

function UITaskMainWin:onExpandAction(index)
local mainIndex=index+1
local data=self.tagList[mainIndex]
if data then
if self.mainIndex~=nil then

AudioManager.playBtnClick()
end

self:afterClickMain(mainIndex)
elseif index==-1 then

AudioManager.playBtnClick()
end
end


function UITaskMainWin:afterClickMain(mainIndex)







end

function UITaskMainWin:initIndex()

end

function UITaskMainWin:getTaskList()
self.taksIDLookUp={}
self.taksLineIDLookUp=self.taksLineIDLookUp or{}
self.tasklist=taskModel:getTaskList_show()





if#self.tasklist>1 then
table.sort(self.tasklist,function(a,b)
local a_line=a.taskline==taskModel.lineMain and 1 or 0
local b_line=b.taskline==taskModel.lineMain and 1 or 0
if a_line==b_line then
return a.taskid<b.taskid
else
return a_line>b_line
end
end)
end
for i,v in ipairs(self.tasklist)do
self.taksIDLookUp[v.taskid]=true
local taskcfg=taskModel:getTaskConfig(v.taskid)
self.taksLineIDLookUp[taskcfg.tasklineid]=true
end
end

function UITaskMainWin:getTaskIDByIndex(index)
local taskdata=self.tasklist[index]
if taskdata~=nil then
return taskdata.taskid
end
return nil
end

function UITaskMainWin:getTaskIndexByID(taskid)
for i,v in ipairs(self.tasklist)do
if v.taskid==taskid then
return i
end
end
return nil
end

function UITaskMainWin:hasTask(taskid)
return self.taksIDLookUp[taskid]==true
end

function UITaskMainWin:hasTaskLine(tasklineid)
return self.taksLineIDLookUp[tasklineid]==true
end



function UITaskMainWin:getTaskNum()
self:GetAllTaskList()
local data=self.tagList[self.mainIndex]
local taskdata=data.data
return#taskdata
end

function UITaskMainWin:getAllTaskNum()
self:GetAllTaskList()
local data=self.tagList
local num=0
for k,v in ipairs(self.tagList)do
local sublist=v.data
num=num+#sublist
end
return num
end

function UITaskMainWin:getTaskName(taskcfg,isSelect)
local name=taskModel:getTaskPrefixAndName(taskcfg)



return name
end



















function UITaskMainWin:changItemBG(item,idx,isSelect)
local taskdata=self:Gettaskdata()

local name=self:getTaskName(taskdata.cfg,isSelect)
item:SetChildText(1,name)

local icon
if isSelect then
icon='frame_renwukuang_1'
else
icon='frame_renwukuang_2'
end
item:SetChildCSImageSprite(0,globalABLookup.task,icon)
end

function UITaskMainWin:on_select_task(id,index,guid,attach)
local taskid=self:getTaskIDByIndex(index)
if taskid==nil then return end
if self.curTaskIndex==index then return end

local old=self.curTaskIndex
self.curTaskIndex=index
self.curTaskID=taskid
if old then
local olditem=self.taskGrid:getGridObjectByindex(old-1)
self:changItemBG(olditem,old,false)
end
local item=self.taskGrid:getGridObjectByindex(self.curTaskIndex-1)
self:changItemBG(item,index,true)

self:refreshDescWin()
end

function UITaskMainWin:clearTaskTimer()
if self.taskTimer~=nil then
self:stopTimerByID(self.taskTimer)
self.taskTimer=nil
end
end

function UITaskMainWin:refreshDescWin()
local tNum=self:getAllTaskNum()
local isshow=tNum>0
self.rightPanel:setActive(isshow)
self.noTaskTips:setActive(not isshow)
self:clearTaskTimer()
self.taskTimeTxt:setText('')
if isshow then

local taskdata=self:Gettaskdata()
local taskcfg=taskdata.cfg
local taskid=taskdata.taskid
local taskstateResult=taskModel:getTaskState(taskdata)
local taskstate=taskstateResult.state

local name_str=taskcfg.name





self.taskName:setText(name_str)

local descStr=taskcfg.taskdesc
local systemZM_ID=systemZongMenModel:getTaskBelong(taskid)
if systemZM_ID then
local infoData=systemZongMenModel:findInfoDataById(systemZM_ID)
if infoData then
local zmName=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
descStr=string.replace(descStr,'[ZM]',zmName)
else
descStr=string.replace(descStr,'[ZM]',"")
end
end
self.taskDesc:setText(descStr)


local show_cond=false
local cond_str
if taskstate==taskModel.taskAcceptState then
local fit
fit,cond_str=taskModel:fitAcceptCondition(taskid)
if not fit then
show_cond=true
cond_str=FMT.fmt('{0}可继续任务',cond_str)
end
end
self.taskCondition:setActive(show_cond)
if show_cond then
self.taskConditionTxt:setText(cond_str)
end


self.taskProgress:setActive(not show_cond)
if not show_cond then
local widget=self.taskProgress:getChildWidgetBase()

local aimicon=taskcfg.aimicon
local taskItem=taskcfg.taskItem
local showIcon=nil
local showModel=nil
if aimicon~=nil then
if aimicon[1]==1 then
showIcon=aimicon[2]
elseif aimicon[1]==2 then
showModel=aimicon[2]
end
end
widget:SetChildActive(0,showIcon~=nil)
if showIcon then
widget:SetChildCSImageIcon(0,iconHelper.getIconName(showIcon),true)
end
widget:SetChildActive(3,showModel~=nil)
if showModel then
local models=cfgHelper.get2(cfg_monijybuildconfig_get,showModel[1],'model')
local lv=showModel[2]
local modelID=models[lv]
local scale=isometricMapSystem:getModelScale(modelID,true)
widget:SetChildUIModelShowTarget(3,modelID,scale*showModel[3],nil,eAnimationID.bd_stand)
end
widget:SetChildActive(2,aimicon~=nil)

widget:SetChildActive(4,taskItem~=nil)
if taskItem then

widget:SetChildActive(2,false)
local itemwid=widget:GetChildWidgetBase(4)
local data=taskItem[1]
local show=data~=nil
itemwid:SetChildActive(1,show)
if show then
local itemID=data[1]
local num=data[2]
local str=''
if num>0 then
num=mathHelper.formatNumber(num)
str=tostring(num)
end
local conf={itemid=itemID,itemcount=str,showname=true,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemwid:SetChildPropData(0,prop)
itemwid:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end

local desc_str=taskcfg.taskaimdesc
local progress_str
if taskstate~=taskModel.taskAcceptState then
local cur=mathHelper.formatNumber(taskstateResult.curnum)
local max=mathHelper.formatNumber(taskstateResult.maxnum)
if taskstateResult.curnum>=taskstateResult.maxnum then
progress_str=FMT.fmt('<color=#549327>{0}/{1}</color>',cur,max)
else
progress_str=FMT.fmt('<color=#c82c2c>{0}/{1}</color>',cur,max)
end
progress_str=FMT.fmt('进度：{0}',progress_str)
end
if progress_str~=nil then
desc_str=FMT.fmt('{0}\n{1}',desc_str,progress_str)
end
widget:SetChildText(1,desc_str)
end


local rewardlist=taskModel:getTaskRewardList(taskid)
local grid=self.goodGrid:getChildCommonLayoutGroupWidgetList()
for i=1,5 do
local data=rewardlist[i]
local item=grid[i-1]
local show=data~=nil
item:SetChildActive(1,show)
if show then
local itemID=data[1]
local num=data[2]
local str=''
if num>0 then
str=tostring(num)
end
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end


if not show_cond then
local showBtn=true
local btn_str
local btn_icon
if taskstate==taskModel.taskAcceptState then
btn_str='接取任务'

elseif taskstate==taskModel.taskDoingState then
showBtn=taskModel.checkTaskCanJump(taskcfg)
btn_str='前往'

else
if taskcfg.finish_npc then
btn_str='提交任务'
else
btn_str='完成任务'
end


end
self.commitBtn:setActive(showBtn)
if showBtn then
self.commitTxt:setText(btn_str)
end

else
self.commitBtn:setActive(false)
end

local showTimer=taskdata.timesec>0
if showTimer then
self.taskTimer=self:setTimer(1,-1,function()
self:refreshTaskTimeView()
end)
self:refreshTaskTimeView()
end

if taskdata.taskline==1 then
self.zhuizong:setActive(false)
else
self.zhuizong:setActive(true)
local flag=taskModel:isZhuiZongTask(taskdata.taskline)
self.zhuizong:setToggle(flag)
end

local isnew=taskModel:GetisNewTask(taskdata.taskline)
if isnew then
self:ClearNewFlag(taskdata.taskline)
end
end
end

function UITaskMainWin:ClearNewFlag(taskline)

taskModel:SavetaskModel_newtask(taskline,nil)
local subItem=self.comboScrollView:getSubItem(self.mainIndex-1,self.subIndex-1)
local MainItem=self.comboScrollView:getMainItem(self.mainIndex-1)
self.zhuxianNew,self.xianjieNew,self.zhixianNew=taskModel:GetHaveNewTask()
if subItem then
subItem:SetChildActive(comboChildIndex.newsign,false)
end
if MainItem then
MainItem:SetChildActive(comboChildIndex.newsign,false)
end
local data=self.tagList[self.mainIndex]
if data then
if data.name=="主线"then
MainItem:SetChildActive(comboIndex.newsign,self.zhuxianNew)
elseif data.name=="仙界"then
MainItem:SetChildActive(comboIndex.newsign,self.xianjieNew)
elseif data.name=="支线"then
MainItem:SetChildActive(comboIndex.newsign,self.zhixianNew)
end
end
end


function UITaskMainWin:refreshTaskTimeView()
local taskdata=self:Gettaskdata()
local lerp=taskdata.timesec-gameUtilityModel.getServerShortTime()
if lerp<0 then lerp=0 end
local time_str=FMT.fmt('限时：{0}',timeHelper.format_time_stamp(lerp,true))
self.taskTimeTxt:setText(time_str)
end

function UITaskMainWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UITaskMainWin:onCommitBtn()
local taskdata=self:Gettaskdata()
if not taskdata then
printError("Error: 没有任务数据")()
return
end
local taskid=taskdata.taskid
local taskstateResult=taskModel:getTaskState(taskdata)
local taskstate=taskstateResult.state
if taskstate==taskModel.taskAcceptState then
if taskModel:fitAcceptCondition(taskid)then

taskController:doAcceptTask(taskid)
end
elseif taskstate==taskModel.taskDoingState then

fullScreenUI.closeActiveUI()
taskController:doJump(taskid)
else

taskController:doGetTaskReward_before(taskid)
end
end

function UITaskMainWin:Gettaskdata()
if not self.mainIndex or not self.subIndex then
return nil
end
local data=self.tagList[self.mainIndex]
local taskdata=data.data[self.subIndex]
return taskdata
end


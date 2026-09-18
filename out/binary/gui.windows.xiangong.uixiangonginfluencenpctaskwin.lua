







def_class("UIXianGongInfluenceNPCTaskWin",UIWindowBase)









function UIXianGongInfluenceNPCTaskWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.panel_1=UIObject.get(self,1)
self.panel_2=UIObject.get(self,2)
self.panel_3=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.titleTx=UIText.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.panel={
self.panel_1,
self.panel_2,
self.panel_3,
}



end


function UIXianGongInfluenceNPCTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.panel_1);self.panel_1=nil;
_UIObject_release(self.panel_2);self.panel_2=nil;
_UIObject_release(self.panel_3);self.panel_3=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
self.panel=nil;
end















local _this=nil
local _panel1Cmp={
root=-1,
desc=0,
costItem=1,
progressBar=2,
rewardView=3,
rewardList=4,
submitBtn=5,
acceptBtn=6,
completeImg=7,
limitTx=8,
}
local _panel2Cmp={
headKuang=0,
icon=1,
lvBg=2,
lvTx=3,
nameTx=4,
jjTx=5,
descTx=6,
rewardView=7,
rewardList=8,
acceptBtn=9,
completeBtn=10,
gotoBtn=11,
limitTx=12,
completeImg=13,
}
local _panel3Cmp={
headKuang=0,
icon=1,
lvBg=2,
lvTx=3,
nameTx=4,
descTx=5,
rewardView=6,
rewardList=7,
acceptBtn=8,
completeBtn=9,
gotoBtn=10,
limitTx=11,
completeImg=12,
}


local _taskTypeInfo={
[273]={
panel=2,
refresh=function(win,all)
if all then
win:refreshView2()
else
win:refreshState2()
end
end,
},
[27]={
panel=1,
refresh=function(win,all)
if all then
win:refreshView1()
else
win:refreshState1()
end
end,
},
[310]={
panel=3,
refresh=function(win,all)
if all then
win:refreshView3()
else
win:refreshState3()
end
end,
},
[272]={
panel=3,
refresh=function(win,all)
if all then
win:refreshView3()
else
win:refreshState3()
end
end,
},
}



function UIXianGongInfluenceNPCTaskWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onTaskChange,self.onTaskChange)
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
local widget=self.panel_1:getChildWidgetBase()
widget:SetChildButtonClick(_panel1Cmp.acceptBtn,function()
self:onAcceptTask()
end)
widget:SetChildButtonClick(_panel1Cmp.submitBtn,function()
self:onRewardTask()
end)

local widget=self.panel_2:getChildWidgetBase()
widget:SetChildButtonClick(_panel2Cmp.acceptBtn,function()
self:onAcceptTask()
end)
widget:SetChildButtonClick(_panel2Cmp.gotoBtn,function()
self:onGotoTask()
end)
widget:SetChildButtonClick(_panel2Cmp.completeBtn,function()
self:onRewardTask()
end)

local widget=self.panel_3:getChildWidgetBase()
widget:SetChildButtonClick(_panel3Cmp.acceptBtn,function()
self:onAcceptTask()
end)
widget:SetChildButtonClick(_panel3Cmp.gotoBtn,function()
self:onGotoTask()
end)
widget:SetChildButtonClick(_panel3Cmp.completeBtn,function()
self:onRewardTask()
end)
end


function UIXianGongInfluenceNPCTaskWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGongInfluenceNPCTaskWin:onShow(argtable,afterOnloaded)
self.taskId=argtable.id
self.parentWin=argtable.parentWin
self.npcId=argtable.npc
self.callback=argtable.callback

local taskData=taskModel:getTask(self.taskId)

self.taskCfg=taskModel:getTaskConfig(self.taskId)
self.npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,self.npcId)

self.titleTx:setText(self.taskCfg.name)
local handle=_taskTypeInfo[self.taskCfg.tasktype]
for i,v in ipairs(self.panel)do
v:setActive(handle.panel==i)
end
if handle and handle.refresh then
handle.refresh(self,true)
end
end


function UIXianGongInfluenceNPCTaskWin:onHide()

end




function UIXianGongInfluenceNPCTaskWin:onCloseBtn()
if self.callback then
self.callback()
end

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIXianGongInfluenceNPCTaskWin.onTaskChange(taskId,taskState)
if taskId==_this.taskId then
local handle=_taskTypeInfo[_this.taskCfg.tasktype]
if handle and handle.refresh then
handle.refresh(_this,false)
end
end
end

function UIXianGongInfluenceNPCTaskWin.on_item_list_changed(array,guidLookup,idLookup)
local handle=_taskTypeInfo[_this.taskCfg.tasktype]
if handle.type==1 then
local costId=tonumber(_this.taskCfg.params[1])
if idLookup[costId]then
local widget=_this.panel_1:getChildWidgetBase()
local costNum=_this.taskCfg.aimnum
local costNumStr=mathHelper.formatNumber(costNum)
local haveNum=itemsModel.getCount(costId)
local haveNumStr=mathHelper.formatNumber(haveNum)
local colorStr=haveNum<costNum and'#f63030'or'#f9f9f9'
widget:SetChildProgressValue(_panel1Cmp.progressBar,haveNum,costNum)
widget:SetChildProgressText(_panel1Cmp.progressBar,FMT.cfmt2(colorStr,"{0}/{1}",haveNumStr,costNumStr))
end
end
end

function UIXianGongInfluenceNPCTaskWin:refreshView1()
local widget=self.panel_1:getChildWidgetBase()
local costId=tonumber(self.taskCfg.params[1])
local costNum=self.taskCfg.aimnum
local costNumStr=mathHelper.formatNumber(costNum)
local costConf={itemid=costId,itemcount=costNumStr,showCountBG=true,showname=false,showStage=true}
local costProp=itemsComponentHelper.getCommonFillDataSmall(costConf)

widget:SetChildText(_panel1Cmp.desc,self.taskCfg.taskdesc)
widget:SetChildPropData(_panel1Cmp.costItem,costProp)
widget:SetBaseItemClickEvent(_panel1Cmp.costItem,function(id)
tipsManager.showTips({itemid=id,move=TIPS_MOVE_POS.eLeft})
end)

local haveNum=itemsModel.getCount(costId)
local haveNumStr=mathHelper.formatNumber(haveNum)
local colorStr=haveNum<costNum and'#f63030'or'#f9f9f9'
widget:SetChildProgressValue(_panel1Cmp.progressBar,haveNum,costNum)
widget:SetChildProgressText(_panel1Cmp.progressBar,FMT.cfmt2(colorStr,"{0}/{1}",haveNumStr,costNumStr))

local rewards=self.taskCfg.taskReward
local relationCfg=cfgHelper.get1(cfg_xianjieshilijiaohutaskconfig_get,self.taskCfg.id)
local relation=0
for i,v in ipairs(relationCfg.feel_add)do
if v[1]==self.npcId then
relation=v[2]
break
end
end
local count=#rewards+(relation>0 and 1 or 0)
widget:SetChildLayoutGroupCreateItems(_panel1Cmp.rewardList,count,function(index)
local item=widget:GetChildLayoutGroupGridItem(_panel1Cmp.rewardList,index-1)
local data=rewards[index]
local itemId=data and data[1]or xjFactionNPCModel.npcRelationItem
local itemNum=data and data[2]or relation
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,false)
end)
widget:SetChildScrollRectEnable(_panel1Cmp.rewardView,count>=5)

local taskData=taskModel:getTask(self.taskId)
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
widget:SetChildActive(_panel1Cmp.acceptBtn,taskState==taskModel.taskAcceptState)
widget:SetChildActive(_panel1Cmp.submitBtn,taskState==taskModel.taskRewardState)
widget:SetChildActive(_panel1Cmp.completeImg,taskState==taskModel.taskFinishState)
widget:SetChildText(_panel1Cmp.limitTx,"")

widget:SetChildActive(_panel1Cmp.progressBar,taskState==taskModel.taskAcceptState or taskState==taskModel.taskDoingState)
end

function UIXianGongInfluenceNPCTaskWin:refreshState1()
local widget=self.panel_1:getChildWidgetBase()

local taskData=taskModel:getTask(self.taskId)
if taskData then
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
widget:SetChildActive(_panel1Cmp.acceptBtn,taskState==taskModel.taskAcceptState)
widget:SetChildActive(_panel1Cmp.submitBtn,taskState==taskModel.taskRewardState)
widget:SetChildActive(_panel1Cmp.completeImg,taskState==taskModel.taskFinishState)
widget:SetChildActive(_panel1Cmp.progressBar,taskState==taskModel.taskAcceptState or taskState==taskModel.taskDoingState)

if taskState==taskModel.taskFinishState and taskData.cfg.speBeforeReward==nil and taskData.cfg.finishPlot==nil then
UIManager:showWindow("UICommonEffectWin",{effect=18063})
end
else
local isFinish=taskModel:checkTaskFinish(self.taskId)
widget:SetChildActive(_panel1Cmp.acceptBtn,false)
widget:SetChildActive(_panel1Cmp.submitBtn,false)
widget:SetChildActive(_panel1Cmp.completeImg,isFinish)
widget:SetChildActive(_panel1Cmp.progressBar,false)

if isFinish then
local taskCfg=taskModel:getTaskConfig(self.taskId)
if taskCfg.speBeforeReward==nil and taskCfg.finishPlot==nil then
UIManager:showWindow("UICommonEffectWin",{effect=18063})
end
end
end
end

function UIXianGongInfluenceNPCTaskWin:refreshView2()
local widget=self.panel_2:getChildWidgetBase()
local params=self.taskCfg.params
local target=params[1]
local infos=string.split(target,'_')
local rpType=tonumber(infos[1])
if rpType==XJ_ResPoint_TYPE.eMonster then
local rpId=tonumber(infos[2])
local posIdx=tonumber(infos[3])
local rpCfg=xianjieModel:getXJResPointClassifyCfg(rpType,rpId)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,rpCfg.monster_id)
widget:SetChildCSImageSprite(_panel2Cmp.headKuang,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",rpCfg.type))
comHelper.setChildModelRawImage_monsterGroup(widget,rpCfg.monster_id,_panel2Cmp.icon,eAnimationID.stand,eHeadCenterType.eHead)
widget:SetChildText(_panel2Cmp.nameTx,FMT.fmt('名称：{0}',monsterCfg.name))
widget:SetChildText(_panel2Cmp.jjTx,FMT.fmt('境界：{0}',UIDiscipleModel:getJJFloorNameEx(monsterCfg.level)))
widget:SetChildText(_panel2Cmp.descTx,self.taskCfg.taskdesc)
widget:SetChildActive(_panel2Cmp.jjTx,true)
elseif rpType==XJ_ResPoint_TYPE.eEvent then
local rpId=tonumber(infos[2])
local posIdx=tonumber(infos[3])
local rpCfg=xianjieModel:getXJResPointClassifyCfg(rpType,rpId)
local dbcfg=cfgHelper.get1(cfg_dbbodyconfig_get,rpCfg.modelSet.model)
local scales=dbcfg.scales or{}
local modelParams={
body=rpCfg.modelSet.model,
componets=rpCfg.modelSet.components,
scale=scales[1]or 1,
anim=eAnimationID.stand,
}
local eventCfg=MysteryEventModel.get_option_cfg(rpCfg.event,1)
comHelper.setChildModelRawImageEx(_panel2Cmp.icon,widget,modelParams,eHeadCenterType.eHead)
widget:SetChildText(_panel2Cmp.nameTx,FMT.fmt('名称：{0}',eventCfg.title))
widget:SetChildText(_panel2Cmp.descTx,self.taskCfg.taskdesc)
widget:SetChildActive(_panel2Cmp.jjTx,false)
else
return
end

local rewards=self.taskCfg.taskReward
local relationCfg=cfgHelper.get1(cfg_xianjieshilijiaohutaskconfig_get,self.taskCfg.id)
local relation=0
for i,v in ipairs(relationCfg.feel_add)do
if v[1]==self.npcId then
relation=v[2]
break
end
end
local count=#rewards+(relation>0 and 1 or 0)
widget:SetChildLayoutGroupCreateItems(_panel2Cmp.rewardList,count,function(index)
local item=widget:GetChildLayoutGroupGridItem(_panel2Cmp.rewardList,index-1)
local data=rewards[index]
local itemId=data and data[1]or xjFactionNPCModel.npcRelationItem
local itemNum=data and data[2]or relation
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,false)
end)
widget:SetChildScrollRectEnable(_panel2Cmp.rewardView,count>=5)

local taskData=taskModel:getTask(self.taskId)
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
widget:SetChildActive(_panel2Cmp.acceptBtn,taskState==taskModel.taskAcceptState)
widget:SetChildActive(_panel2Cmp.completeBtn,taskState==taskModel.taskRewardState)
widget:SetChildActive(_panel2Cmp.gotoBtn,taskState==taskModel.taskDoingState)
widget:SetChildActive(_panel2Cmp.completeImg,taskState==taskModel.taskFinishState)
widget:SetChildText(_panel2Cmp.limitTx,"")
end

function UIXianGongInfluenceNPCTaskWin:refreshState2()
local widget=self.panel_2:getChildWidgetBase()
local taskData=taskModel:getTask(self.taskId)
if taskData then
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
widget:SetChildActive(_panel2Cmp.acceptBtn,taskState==taskModel.taskAcceptState)
widget:SetChildActive(_panel2Cmp.completeBtn,taskState==taskModel.taskRewardState)
widget:SetChildActive(_panel2Cmp.gotoBtn,taskState==taskModel.taskDoingState)
widget:SetChildActive(_panel2Cmp.completeImg,taskState==taskModel.taskFinishState)

if taskState==taskModel.taskFinishState and taskData.cfg.speBeforeReward==nil and taskData.cfg.finishPlot==nil then
UIManager:showWindow("UICommonEffectWin",{effect=18063})
end
else
local isFinish=taskModel:checkTaskFinish(self.taskId)
widget:SetChildActive(_panel2Cmp.acceptBtn,false)
widget:SetChildActive(_panel2Cmp.completeBtn,false)
widget:SetChildActive(_panel2Cmp.gotoBtn,false)
widget:SetChildActive(_panel2Cmp.completeImg,isFinish)

if isFinish then
local taskCfg=taskModel:getTaskConfig(self.taskId)
if taskCfg.speBeforeReward==nil and taskCfg.finishPlot==nil then
UIManager:showWindow("UICommonEffectWin",{effect=18063})
end
end
end
end

function UIXianGongInfluenceNPCTaskWin:refreshView3()
local widget=self.panel_3:getChildWidgetBase()
local npcId=self.taskCfg.jump[3].npcid
local npcCfg=cfgHelper.get1(cfg_tasknpcconfig_get,npcId)
widget:SetChildCSImageIcon(_panel3Cmp.icon,npcCfg.headimage,false)
widget:SetChildText(_panel3Cmp.nameTx,FMT.fmt('名称：{0}',npcCfg.name))
widget:SetChildText(_panel3Cmp.descTx,self.taskCfg.taskdesc)

local rewards=self.taskCfg.taskReward
local relationCfg=cfgHelper.get1(cfg_xianjieshilijiaohutaskconfig_get,self.taskCfg.id)





local relation=0
if relationCfg then
for i,v in ipairs(relationCfg.feel_add)do
if v[1]==self.npcId then
relation=v[2]
break
end
end
end
local count=#rewards+(relation>0 and 1 or 0)
widget:SetChildLayoutGroupCreateItems(_panel3Cmp.rewardList,count,function(index)
local item=widget:GetChildLayoutGroupGridItem(_panel3Cmp.rewardList,index-1)
local data=rewards[index]
local itemId=data and data[1]or xjFactionNPCModel.npcRelationItem
local itemNum=data and data[2]or relation
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,false)
end)
widget:SetChildScrollRectEnable(_panel3Cmp.rewardView,count>=5)

local taskData=taskModel:getTask(self.taskId)
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
widget:SetChildActive(_panel3Cmp.acceptBtn,taskState==taskModel.taskAcceptState)
widget:SetChildActive(_panel3Cmp.completeBtn,taskState==taskModel.taskRewardState)
widget:SetChildActive(_panel3Cmp.gotoBtn,taskState==taskModel.taskDoingState)
widget:SetChildActive(_panel3Cmp.completeImg,taskState==taskModel.taskFinishState)
widget:SetChildText(_panel3Cmp.limitTx,"")
end

function UIXianGongInfluenceNPCTaskWin:refreshState3()
local widget=self.panel_3:getChildWidgetBase()
local taskData=taskModel:getTask(self.taskId)
if taskData then
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
widget:SetChildActive(_panel3Cmp.acceptBtn,taskState==taskModel.taskAcceptState)
widget:SetChildActive(_panel3Cmp.completeBtn,taskState==taskModel.taskRewardState)
widget:SetChildActive(_panel3Cmp.gotoBtn,taskState==taskModel.taskDoingState)
widget:SetChildActive(_panel3Cmp.completeImg,taskState==taskModel.taskFinishState)

if taskState==taskModel.taskFinishState and taskData.cfg.speBeforeReward==nil and taskData.cfg.finishPlot==nil then
UIManager:showWindow("UICommonEffectWin",{effect=18063})
end
else
local isFinish=taskModel:checkTaskFinish(self.taskId)
widget:SetChildActive(_panel3Cmp.acceptBtn,false)
widget:SetChildActive(_panel3Cmp.completeBtn,false)
widget:SetChildActive(_panel3Cmp.gotoBtn,false)
widget:SetChildActive(_panel3Cmp.completeImg,isFinish)

if isFinish then
local taskCfg=taskModel:getTaskConfig(self.taskId)
if taskCfg.speBeforeReward==nil and taskCfg.finishPlot==nil then
UIManager:showWindow("UICommonEffectWin",{effect=18063})
end
end
end
end

function UIXianGongInfluenceNPCTaskWin:onAcceptTask()
local taskData=taskModel:getTask(self.taskId)
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
if taskState==taskModel.taskAcceptState then
local fit,str=taskModel:fitAcceptCondition(self.taskId)
if fit then
fit,str=xjFactionNPCModel:checkTaskAcceptExtraCondition(self.taskId)
if fit then
taskController:doAcceptTask(self.taskId)
return
end
end
UIManager.error(str)
end
end

function UIXianGongInfluenceNPCTaskWin:onGotoTask()
local taskData=taskModel:getTask(self.taskId)
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
if taskState==taskModel.taskDoingState then
taskController:doJump(self.taskId)
end
end

function UIXianGongInfluenceNPCTaskWin:onRewardTask()
local taskData=taskModel:getTask(self.taskId)
local taskState=taskData and taskModel:getTaskState_transfromstate(taskData)or(taskModel:checkTaskFinish(self.taskId)and taskModel.taskFinishState or nil)
if taskState==taskModel.taskRewardState then
taskController:doGetTaskReward(self.taskId)
end
end

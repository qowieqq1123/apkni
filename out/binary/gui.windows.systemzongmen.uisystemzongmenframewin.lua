







def_class("UISystemZongMenFrameWin",UIWindowBase)









function UISystemZongMenFrameWin:bindComponents()

self.cage_1=UIObject.get(self,0)
self.dzNameBg=UIObject.get(self,1)
self.dzModel=UIObject.get(self,2)
self.planBtn=UIButton.get(self,3)
self.switchBtn=UIButton.get(self,4)
self.slanderBtn=UIButton.get(self,5)
self.rubbingBtn=UIButton.get(self,6)
self.cage_2=UIObject.get(self,7)
self.negotiateBtn=UIButton.get(self,8)
self.dzName=UIText.get(self,9)
self.menuList=UIObject.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.noise=UIObject.get(self,12)

self.planBtn:setButtonClick(function()self:onPlanBtn()end)

self.switchBtn:setButtonClick(function()self:onSwitchBtn()end)

self.slanderBtn:setButtonClick(function()self:onSlanderBtn()end)

self.rubbingBtn:setButtonClick(function()self:onRubbingBtn()end)

self.negotiateBtn:setButtonClick(function()self:onNegotiateBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.cage={
self.cage_1,
self.cage_2,
}



end


function UISystemZongMenFrameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cage_1);self.cage_1=nil;
_UIObject_release(self.dzNameBg);self.dzNameBg=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.planBtn);self.planBtn=nil;
_UIObject_release(self.switchBtn);self.switchBtn=nil;
_UIObject_release(self.slanderBtn);self.slanderBtn=nil;
_UIObject_release(self.rubbingBtn);self.rubbingBtn=nil;
_UIObject_release(self.cage_2);self.cage_2=nil;
_UIObject_release(self.negotiateBtn);self.negotiateBtn=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.noise);self.noise=nil;
self.cage=nil;
end
















local _this=nil
local _menuCmp={
owner=-1,
selected=0,
name=1,
lock=2,
lockIcon1=3,
lockIcon2=4,
reddot=5,
}
local _flagClose={
[systemZongMenFightFlagType.eSurrender]=true,
[systemZongMenFightFlagType.eExpel]=true,
[systemZongMenFightFlagType.eVassal]=true,
}
local _menuData={
[systemZongMenDetailDataPart.eBase]={
name="信息",
win="UISystemZongMenInfoWin",
},
[systemZongMenDetailDataPart.eDZList]={
name="大殿",
win="UISystemZongMenDaDianWin",
isLock=function(winlua)
return not mathHelper.validInt64(winlua.discipleGuid)
end,
lockTips=function(winlua)
return"需要弟子潜入"
end,
lockStyle=1
},
[systemZongMenDetailDataPart.eBag]={
name="库房",
win="UISystemZongMenKuFangWin",
isLock=function(winlua)
return not mathHelper.validInt64(winlua.discipleGuid)
end,
lockTips=function(winlua)
return"需要弟子潜入"
end,
lockStyle=1
},
[systemZongMenDetailDataPart.eCangJingGe]={
name="藏经阁",
win="UISystemZongMenCangJingGeWin",
isLock=function(winlua)
return not mathHelper.validInt64(winlua.discipleGuid)
end,
lockTips=function(winlua)
return"需要弟子潜入"
end,
lockStyle=1
},
[systemZongMenDetailDataPart.eTask]={
name="委托",
win="UISystemZongMenTaskWin",
isLock=function(winlua)
local relation=systemZongMenModel:getInfoDataRelation(winlua.serial)
return relation==systemZongMenRelationType.eDiDui
end,
lockTips=function(winlua)
return"敌对状态无法查看委托"
end,
lockStyle=2,
reddot=function(winlua)
local taskDetail=systemZongMenModel:getDetailPartInfo(winlua.serial,systemZongMenDetailDataPart.eTask)
if taskDetail then
local lastTaskId=taskDetail.taskId
local taskId=nil
if lastTaskId>0 then
local cfg=cfgHelper.get1(cfg_taskconfig_get,lastTaskId)
taskId=cfg and cfg.nextid or nil
else
taskId=winlua.config.firstTaskId
end
if taskId then
if systemZongMenModel:checkTaskOperateImp(winlua.infoData,taskId)then
local task=taskModel:getTask(taskId)
if task then
if task.cfg.tasktype==taskTypeClientCheckType.eCostGoodNum then
return task.taskstate~=taskModel.taskFinishState
else
return task.taskstate==taskModel.taskAcceptState or task.taskstate==taskModel.taskRewardState
end
end
end
end
end
return false
end,
},
[systemZongMenDetailDataPart.eShop]={
name="商店",
win="UISystemZongMenShopWin",
isLock=function(winlua)
local relation=systemZongMenModel:getInfoDataRelation(winlua.serial)
return relation==systemZongMenRelationType.eDiDui
end,
lockTips=function(winlua)
return"敌对状态无法查看商店"
end,
lockStyle=2
},
}



function UISystemZongMenFrameWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSystemZMInit,self.onSystemZMInit)
self:addNotify(notifyConfig.onSystemZMDelete,self.onSystemZMDelete)
self:addNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
self:addNotify(notifyConfig.onSystemZMFunctionResult,self.onSystemZMFunctionResult)
self:addNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self:addNotify(notifyConfig.onSystemZMInfoChange,self.onSystemZMInfoChange)
self:addNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
self:addNotify(notifyConfig.onSystemZMDefenseInfoServerChange,self.onSystemZMDefenseInfoServerChange)
self:addNotify(notifyConfig.onTaskChange,self.onTaskChange)
self:addNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
end


function UISystemZongMenFrameWin:__delete()
self:unbindComponents()
_this=nil
systemZongMenModel:clearDetailInfo(self.serial)
end




function UISystemZongMenFrameWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.infoData=systemZongMenModel:getInfoData(self.serial)

self.discipleGuid=self.infoData.disciple_guid
self.config=cfgHelper.get1(cfg_syssectconfig_get,self.infoData.id)
self.defaultMenuIndex=argtable.defaultMenuIndex
local _onCreateMenuItem=function(...)
self:onCreateMenuItem(...)
end
self.winlua:SetChildLayoutGroupCreateItems(self.menuList:getID(),#_menuData,_onCreateMenuItem)
self:refreshDisciple()
self:refreshFuncButton()
self:onClickMenuItem(self.defaultMenuIndex or systemZongMenDetailDataPart.eBase)


systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eTask,self.serial)

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.OpenUISystemZongMenFrameWin)
end


function UISystemZongMenFrameWin:onHide()

end




function UISystemZongMenFrameWin:onCloseBtn()
UIFullSystemZongMenControl:closeUI(nil,true)
end


function UISystemZongMenFrameWin:onPlanBtn()
self:openSelectDisciple()
end


function UISystemZongMenFrameWin:onSwitchBtn()
self:openSelectDisciple()
end

function UISystemZongMenFrameWin:openSelectDisciple()
if self.infoData.tayin>0 and mathHelper.validInt64(self.discipleGuid)then
UIManager.error("弟子拓印中，无法更换潜入弟子")
return
end

local winParams={
titleName="弟子潜入",
extraWin="UISystemZongMenQianRuSelectWin",
extraParams={
serial=self.serial,
current=self.discipleGuid,
},
}
UIFullSystemZongMenControl:showWindow('UICommonDragonBoneWin',winParams)
end


function UISystemZongMenFrameWin:onSlanderBtn()
if self.infoData.flag==systemZongMenFightFlagType.eBeAttacked then
UIManager.error("正在进攻该宗门")
return
end
if not UIDiscipleModel:checkDiscipleState2(self.discipleGuid,DISCIPLE_STATE_TYPE.eBeiBu)then
local winParams={
serial=self.serial
}
UIFullSystemZongMenControl:showWindow('UISystemZongMenZaoYaoWin',winParams)
else
UIManager.error("潜入弟子已被捕")
end
end


function UISystemZongMenFrameWin:onRubbingBtn()
if self.infoData.flag==systemZongMenFightFlagType.eBeAttacked then
UIManager.error("正在进攻该宗门")
return
end
if not UIDiscipleModel:checkDiscipleState2(self.discipleGuid,DISCIPLE_STATE_TYPE.eBeiBu)then
if systemModel.isOpen(SYSTEM_DEFINE.eSystemZongMenTaYin)then
local winParams={
serial=self.serial
}
UIFullSystemZongMenControl:showWindow('UISystemZongMenTaYinWin1',winParams)
else
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eSystemZongMenTaYin)
UIManager.info(str)
end




else
UIManager.error("潜入弟子已被捕")
end
end


function UISystemZongMenFrameWin:onNegotiateBtn()
if UIDiscipleModel:checkDiscipleState2(self.discipleGuid,DISCIPLE_STATE_TYPE.eBeiBu)then
UIFullSystemZongMenControl:showWindow("UISystemZongMenRansomWin",{serial=self.serial})
else
UIManager.error("潜入弟子未被捕")
end
end

function UISystemZongMenFrameWin:onCreateMenuItem(idx)
local item=self.winlua:GetChildLayoutGroupGridItem(self.menuList:getID(),idx-1)
local data=_menuData[idx]
local lock=false
if data.isLock then
lock=data.isLock(self)
end
local reddot=false
if data.reddot then
reddot=data.reddot(self)
end
item:SetChildActive(_menuCmp.selected,idx==self.selected)
item:SetChildText(_menuCmp.name,data.name)
item:SetChildActive(_menuCmp.lock,lock)
item:SetChildButtonClickWithID(_menuCmp.owner,function(index)
self:onClickMenuItem(index)
end,idx)
item:SetChildActive(_menuCmp.lockIcon1,data.lockStyle==1)
item:SetChildActive(_menuCmp.lockIcon2,data.lockStyle==2)
item:SetChildNewBieComponentId(_menuCmp.owner,FMT.fmt("UISystemZongMenFrameWin.#MenuItem_{0}",idx))

item:SetChildActive(_menuCmp.reddot,not lock and reddot)
end

function UISystemZongMenFrameWin:refreshMenuItems()
local items=self.winlua:GetChildLayoutGroupGridList(self.menuList:getID())
for i=1,items.Count do
local item=items[i-1]
local data=_menuData[i]
local lock=false
if data.isLock then
lock=data.isLock(self)
end
local reddot=false
if data.reddot then
reddot=data.reddot(self)
end
item:SetChildActive(_menuCmp.lock,lock)
item:SetChildActive(_menuCmp.reddot,not lock and reddot)
end
end

function UISystemZongMenFrameWin:refreshMenuItemReddot(types)
for i,v in pairs(_menuData)do
if table.containsValue(types,i)then
local item=self.menuList:getChildLayoutGroupGridItem(i-1)
local lock=false
if v.isLock then
lock=v.isLock(self)
end
local reddot=false
if v.reddot then
reddot=v.reddot(self)
end
item:SetChildActive(_menuCmp.reddot,not lock and reddot)
end
end
end

function UISystemZongMenFrameWin:onClickMenuItem(idx)
if self.selected~=idx then
local data=_menuData[idx]
local lock=false
if data.isLock then
lock=data.isLock(self)
end
if lock then
if data.lockTips then
local tips=data.lockTips(self)
UIManager.info(tips)
end
else
if self.selected then
local oData=_menuData[self.selected]
local item=self.winlua:GetChildLayoutGroupGridItem(self.menuList:getID(),self.selected-1)
item:SetChildActive(_menuCmp.selected,false)

end
for i,v in pairs(_menuData)do
if i~=idx then
UIFullSystemZongMenControl:hideWindow(v.win)
end
end

self.selected=idx
local item=self.winlua:GetChildLayoutGroupGridItem(self.menuList:getID(),self.selected-1)
item:SetChildActive(_menuCmp.selected,true)

self:refreshFuncButton()
UIManager:setArgs(self.__name,{serial=self.serial,defaultMenuIndex=idx})



if not systemZongMenModel:checkDetailPartInfo(self.serial,self.selected)then
systemZongMenController:req_detailInfo(self.selected,self.serial)
end

UIFullSystemZongMenControl:showWindow(data.win,{serial=self.serial})
end
end
end

function UISystemZongMenFrameWin:refreshFuncButton()
local checkState=not mathHelper.validInt64(self.discipleGuid)or UIDiscipleModel:checkDiscipleState2(self.discipleGuid,DISCIPLE_STATE_TYPE.eBeiBu)
self.rubbingBtn:setActive(not checkState and self.selected==systemZongMenDetailDataPart.eCangJingGe and systemModel.isOpen(SYSTEM_DEFINE.eSystemZongMenTaYin))
self.slanderBtn:setActive(false)
self.switchBtn:setActive(not checkState)
end

function UISystemZongMenFrameWin:refreshDisciple()
if mathHelper.validInt64(self.discipleGuid)then




self.dzNameBg:setActive(true)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.discipleGuid,false,1)
local dzCmp=self.dzModel:getID()
self.winlua:SetChildUIModelShowTarget(dzCmp,modelParams.body,0.8,modelParams.componets,modelParams.anim)
self.winlua:SetChildUIModelShowFlipX(dzCmp,true)
self.dzName:setText(UIDiscipleModel:getDiscipleName(self.discipleGuid))
self.planBtn:setActive(false)
local checkState=UIDiscipleModel:checkDiscipleState2(self.discipleGuid,DISCIPLE_STATE_TYPE.eBeiBu)
for i,v in ipairs(self.cage)do
v:setActive(checkState)
end
self.noise:setActive(checkState)
self.negotiateBtn:setActive(checkState)
else
local dzCmp=self.dzModel:getID()
self.winlua:SetChildUIModelRemoveTarget(dzCmp)
self.dzName:setText("潜入弟子")
self.planBtn:setActive(true)
self.switchBtn:setActive(false)
self.dzNameBg:setActive(false)
self:onClickMenuItem(1)
end
end

function UISystemZongMenFrameWin.onSystemZMDiscipleChange(serial,discipleGuid,oldGuid)

if serial==_this.serial then
_this.discipleGuid=discipleGuid
_this:refreshDisciple()
_this:refreshFuncButton()
_this:refreshMenuItems()
if not mathHelper.validInt64(discipleGuid)then
_this:onClickMenuItem(systemZongMenDetailDataPart.eBase)
else
UIFullSystemZongMenControl:showWindow("UISystemZongMenQianRuWin",{disciple=discipleGuid})
end
end
end

function UISystemZongMenFrameWin.onSystemZMFunctionResult(serial)
if mathHelper.compareInt64(_this.serial,serial)then
systemZongMenController:handleResult()
end
end

function UISystemZongMenFrameWin.onSystemZMInit()
local infoData=systemZongMenModel:getInfoData(_this.serial)
if not infoData then
UIFullSystemZongMenControl.closeActiveUI(true)
end
end

function UISystemZongMenFrameWin.onSystemZMDelete(serial)
if mathHelper.compareInt64(_this.serial,serial)then
UIFullSystemZongMenControl.closeActiveUI(true)
end
end

function UISystemZongMenFrameWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if mathHelper.compareInt64(_this.discipleGuid,discipleguid)and stateType==DISCIPLE_STATE_TYPE.eBeiBu then
_this:refreshDisciple()
_this:refreshFuncButton()
end
end

function UISystemZongMenFrameWin.onSystemZMInfoChange(serial,type,oldVal,param)
if mathHelper.compareInt64(_this.serial,serial)and type==systemZongMenInfoUpdateType.eRelation then
_this:refreshMenuItems()
end
end

function UISystemZongMenFrameWin.onNewDay5am()
systemZongMenController:req_look_dazhen(_this.serial)
end

function UISystemZongMenFrameWin.onSystemZMFightFlagChanged(serial,oldFlag,flag)
if mathHelper.compareInt64(_this.serial,serial)and _flagClose[flag]then
_this:onCloseBtn()
end
end

function UISystemZongMenFrameWin.onSystemZMDefenseInfoServerChange(serial)
if mathHelper.compareInt64(_this.serial,serial)then
systemZongMenController:req_look_dazhen(serial)
end
end

function UISystemZongMenFrameWin.onTaskChange(taskid,taskState)
local firstTaskCfg=taskModel:getTaskConfig(_this.config.firstTaskId)
local taskCfg=taskModel:getTaskConfig(taskid)
if firstTaskCfg.tasklineid==taskCfg.tasklineid then
_this:refreshMenuItemReddot({systemZongMenDetailDataPart.eTask})
end
end

function UISystemZongMenFrameWin.onSystemZMMoneyNumChange(serial,money_type,val,oldVal)
if mathHelper.compareInt64(_this.serial,serial)and money_type==systemZongMenInfoMoneyType.eShengWang then
_this:refreshMenuItemReddot({systemZongMenDetailDataPart.eTask})
end
end

function UISystemZongMenFrameWin.onSystemZMDetailInfo(partType,serial)
if mathHelper.compareInt64(_this.serial,serial)and partType==systemZongMenDetailDataPart.eTask then
_this:refreshMenuItemReddot({systemZongMenDetailDataPart.eTask})
end
end

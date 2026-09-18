







wanBaoXunBaoDuiModel=gameState.addListener({})



wanBaoXunBaoDuiModel.data={}

local _responseTime=300


function wanBaoXunBaoDuiModel:onAppStart()

end


function wanBaoXunBaoDuiModel:onEnterState(isReconnect)
self:initModelData()
end


function wanBaoXunBaoDuiModel:onLeaveState(isReconnect)

self.data={}
self:delModelData()
end



function wanBaoXunBaoDuiModel:initModelData()
self:initChannelData()

self.adventureMapPointList={}
self.employeeList={}
self.employeeLookUp={}
self.workingEmployees={}

self.uplevelCatList={}
self.qiyuList={}

self.selectEquipDressState=true
end



function wanBaoXunBaoDuiModel:delModelData()

wanBaoXunBaoDuiModel:resetAllChannelData()

if self.recruitTimer then
self.recruitTimer:cancel()
self.recruitTimer=nil
end

if self.tili_Update_Timer then
self.tili_Update_Timer:cancel()
self.tili_Update_Timer=nil
end

self.adventureMapPointList=nil
self.employeeList=nil
self.employeeLookUp=nil

self.workingEmployees=nil

end




function wanBaoXunBaoDuiModel:getWBXBDsBuild()
if self.data and self.data.wbxbd_isBuild~=nil then
return self.data.wbxbd_isBuild
end

return nil
end




function wanBaoXunBaoDuiModel:setWBXBDIsBuild(flag)
self.data.wbxbd_isBuild=flag
end




function wanBaoXunBaoDuiModel:getWBXBDIsFinishBuild()
if self.data and self.data.wbxbd_isFinishBuild~=nil then
return self.data.wbxbd_isFinishBuild
end

return nil
end




function wanBaoXunBaoDuiModel:setWBXBDIsFinishBuild(flag)
self.data.wbxbd_isFinishBuild=flag
end




function wanBaoXunBaoDuiModel:setWBXBDIsNotNeedHide(flag)
self.data.wbxbd_isNotNeedHide=flag
end




function wanBaoXunBaoDuiModel:getWBXBDIsNotNeedHide()
if self.data and self.data.wbxbd_isNotNeedHide~=nil then
return self.data.wbxbd_isNotNeedHide
end

return false
end




function wanBaoXunBaoDuiModel:getPropNameList()
return{"力量","智慧","灵巧","耐力","运气"}
end




function wanBaoXunBaoDuiModel:getConstDef()
return cfg_catconfig().const_def
end




function wanBaoXunBaoDuiModel:doOperation(option)
if option.state==WanBaoXunBaoDuiOperationType.DoTask then

local channelData=self.channelDatas[option.channelId]
local teamData=self:getChannelConditionDataByIndex(option.channelId)
if channelData.sendTick then
local t=timeHelper.getServerShortTime()
if t-channelData.sendTick<_responseTime then
return
end
end
if self.channelDatas[option.channelId].bt_num==0 then
if wanBaoXunBaoDuiModel:checkDispatchTili(self.channelDatas[option.channelId])then
if teamData.conditionState then

local list={}
for k,v in pairs(self.channelDatas[option.channelId].employeeList)do
table.insert(list,v)
end
local func=function()
channelData.sendTick=timeHelper.getServerShortTime()
wanBaoXunBaoDuiController:reqGoAdventure(option.channelId,self.channelDatas[option.channelId].employeeLen,list)
end
if#list==3 then
func()
else
local showdata=
{
type='UIDialouge',
title='提示',
content='派遣的雇员不足3位，探险额外收益会减少，是否继续冒险？',
oktext='继续',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
func()
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
else
UIManager.info(teamData.conditionDesc)
end
end
else
wanBaoXunBaoDuiModel:showChannelGoInfoTip(option.channelId)
end
elseif option.state==WanBaoXunBaoDuiOperationType.StopTask then

wanBaoXunBaoDuiController:reqEarlyReturn(option.channelId,WBXBD_Adventure_Return_Type.return_break)
elseif option.state==WanBaoXunBaoDuiOperationType.Return then
wanBaoXunBaoDuiController:reqEarlyReturn(option.channelId,WBXBD_Adventure_Return_Type.return_finish)
elseif option.state==WanBaoXunBaoDuiOperationType.FinishTask then

wanBaoXunBaoDuiController:reqFinishReturn({option.channelId})
elseif option.state==WanBaoXunBaoDuiOperationType.Recruit then

UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_RecruitWin")
elseif option.state==WanBaoXunBaoDuiOperationType.QuickDispath then
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MTSceneWin','doQuickStartAdventrue',option.channelId)
end
end




function wanBaoXunBaoDuiModel:getEmployeeQualityOptionTxts()
return{
"蓝色品质以上",
"紫色品质以上",
"橙色品质以上",
"红色品质以上",
}
end





function wanBaoXunBaoDuiModel:getBuildCost(color)
local cfg=cfgHelper.get1(cfg_catequipmakeconfig_get,color)
local cost=0
local costtype=1
for k,v in pairs(cfg.consume)do
if itemsConfig.isMoney(v[1])then
cost=v[2]
costtype=v[1]
break
end
end
return cost,costtype
end




function wanBaoXunBaoDuiModel:getMaomaoBagitemQualityTypes()
return{
"绿色品质及以下",
"蓝色品质及以下",
"紫色品质及以下",
"橙色品质及以下",
"红色品质及以下",
}
end





function wanBaoXunBaoDuiModel:getTaskConfig(id)
return cfgHelper.get1(cfg_catmapconfig_get,id)
end





function wanBaoXunBaoDuiModel:getTerrainConfig(id)
return cfgHelper.get1(cfg_catmappointconfig_get,id)
end



function wanBaoXunBaoDuiModel:showAdventureFinishSettlementWin()
if self.startShowResult and(not wanBaoXunBaoDuiController:getXZSReceiveFlag())then

if not UIManager:isActive('UIWanBaoXunBaoDui_EmployeeUpWin')then
if next(self.uplevelCatList)~=nil then
UIFullWanBaoXunBaoDuiController:showWindow('UIWanBaoXunBaoDui_EmployeeUpWin',self.uplevelCatList)
self.uplevelCatList={}
return
end
else
return
end


if not UIManager:isActive('UIWanBaoXunBaoDui_ShowPrizeWin')then
if self.prizeReward~=nil and#self.prizeReward>0 then
wanBaoXunBaoDuiController.showPrizeWindow(self.prizeReward,function()
wanBaoXunBaoDuiModel:showAdventureFinishSettlementWin()
end,{})
self.prizeReward=nil
return
end
else
return
end














local new=MysteryModel:getWanBaoXunBaoDuichannel_MiJinid()
if new then
UIManager:showWindow('UIWanBaoXunBaoDui_MiJinTipsWin',{new})
end
MysteryModel:setWanBaoXunBaoDuichannel_MiJinid(nil)


wanBaoXunBaoDuiModel:dealFinishAdventure()
self.startShowResult=false
end
end















def_class("UIDrawDianJiTouZiWin",UIWindowBase)









function UIDrawDianJiTouZiWin:bindComponents()

self.leftRoot=UIObject.get(self,0)
self.rightRoot=UIObject.get(self,1)
self.modelBg=UIObject.get(self,2)
self.root=UIObject.get(self,3)



end


function UIDrawDianJiTouZiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIDrawDianJiTouZiWin:onLoaded(...)
self:bindComponents()
self:showWindow('UITopMoneyWin2',{{eMoneyType.mtLingYu}})





end

function UIDrawDianJiTouZiWin:__delete()
local widget=self.leftRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
local widget=self.rightRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
if self.dialog then
self.dialog:hide()
end
self:unbindComponents()
end

function UIDrawDianJiTouZiWin:onShow(argtable,afterOnloaded)
self.modelBg:setChildUIModelShowTarget(5390,1,{},0)
if argtable then
self.taskList=argtable.taskList
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
end
self.activityData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.cfg={}

for k,v in ipairs(self.taskList)do
self.cfg[v]=cfgHelper.get1(cfg_huihuadianjiactgoalconfig_get,v)
end
self:freshInfo()
end

function UIDrawDianJiTouZiWin:onHide()

end


function UIDrawDianJiTouZiWin:freshInfo()

local hasTouziMoney=true
local hasTouziRecharge=true
self.leftRoot:setActive(hasTouziMoney)
self.rightRoot:setActive(hasTouziRecharge)
if hasTouziMoney and hasTouziRecharge then
self:freshLeft()
self:freshRight()
elseif hasTouziRecharge then

self:freshRight()
else

self:freshLeft()
end
end

function UIDrawDianJiTouZiWin:freshLeft()

local widget=self.leftRoot:getChildWidgetBase()
local rewards={}
for k,v in pairs(self.cfg)do
for k1,v1 in ipairs(v.tzReward1)do

local flag=true
for k2,v2 in ipairs(rewards)do
if v2[1]==v1[1]then
rewards[k2][2]=v1[2]+v2[2]
flag=false
break
end

end
if flag then
local data={}
data[1]=v1[1]
data[2]=v1[2]
data.showStage=true
rewards[#rewards+1]=data
end

end
end
local tzcfg=self.config.tzReward[1]
local buytype=tzcfg[1]
if buytype==1 then
local cost=tzcfg[2][1]
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
widget:SetChildText(2,FMT.fmt("{0}{1}",need,moneyname))
elseif buytype==2 then
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,tzcfg[2])
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(2,str)

end

local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
widget:SetChildActive(1,self.activityData.tzRewardFlag1~=1)
widget:SetChildText(6,"绘画积分满值可累计获得")

if self.activityData.tzRewardFlag1==0 then
widget:SetChildButtonClick(1,function()

local tzcfg=self.config.tzReward[1]
local buytype=tzcfg[1]
if buytype==1 then
local cost=tzcfg[2][1]
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
local func1=function()
local func=function()
activitiesHandle_drawdianji:reqtaskReward(self.activityId,self.subId,2)
UIManager:closeWindow('UIDrawDianJiTouZiWin')
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end

local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买大师密卷？',need,moneyname)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1)
elseif buytype==2 then
local func=function()
local cost=tzcfg[2]
local rechargeId=cost
local params=payControl.getActivityPayParams(self.activityId,self.subType,self.subId,{1})
payControl.reqPay(rechargeId,1,params)
UIManager:closeWindow('UIDrawDianJiTouZiWin')
end
func()
end

end)
end
end

function UIDrawDianJiTouZiWin:freshRight()
local widget=self.rightRoot:getChildWidgetBase()
local rewards={}
for k,v in pairs(self.cfg)do
for k1,v1 in ipairs(v.tzReward2)do

local flag=true
for k2,v2 in ipairs(rewards)do
if v2[1]==v1[1]then
rewards[k2][2]=v1[2]+v2[2]
flag=false
break
end

end
if flag then
local data={}
data[1]=v1[1]
data[2]=v1[2]
data.showStage=true
rewards[#rewards+1]=data
end
end
end
local tzcfg=self.config.tzReward[2]
local buytype=tzcfg[1]
if buytype==1 then
local cost=tzcfg[2][1]
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
widget:SetChildText(2,FMT.fmt("{0}{1}",need,moneyname))
elseif buytype==2 then
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,tzcfg[2])
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(2,str)
end
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
widget:SetChildText(6,"绘画积分满值可累计获得")
widget:SetChildActive(1,self.activityData.tzRewardFlag2~=1)
if self.activityData.tzRewardFlag2==0 then
widget:SetChildButtonClick(1,function()
local tzcfg=self.config.tzReward[2]
local buytype=tzcfg[1]
if buytype==1 then
local cost=tzcfg[2][1]
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
local func1=function()
local func=function()
activitiesHandle_drawdianji:reqtaskReward(self.activityId,self.subId,3)
UIManager:closeWindow('UIDrawDianJiTouZiWin')
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end

local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买灵玉投资？',need,moneyname)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1)
elseif buytype==2 then
local func=function()
local cost=tzcfg[2]
local rechargeId=cost
local params=payControl.getActivityPayParams(self.activityId,self.subType,self.subId,{2})
payControl.reqPay(rechargeId,1,params)
UIManager:closeWindow('UIDrawDianJiTouZiWin')
end
func()
end
end)
end
end

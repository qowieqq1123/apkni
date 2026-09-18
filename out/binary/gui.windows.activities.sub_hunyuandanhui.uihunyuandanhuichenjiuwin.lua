







def_class("UIHunYuanDanHuiChenJiuWin",UIWindowBase)









function UIHunYuanDanHuiChenJiuWin:bindComponents()

self.chenjiuRoot=UIObject.get(self,0)
self.chenjiuScrollView=UILoopListView.new(self,1)
self.closeBtn=UIButton.get(self,2)
self.mbg=UIObject.get(self,3)
self.Root=UIObject.get(self,4)
self.TabPanel=UIObject.get(self,5)
self.tujianRoot=UIObject.get(self,6)
self.tujianScrollView=UILoopListView.new(self,7)

self.chenjiuScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tujianScrollView:bindLoopListView(function(...)
self:onFreshAction_2(...)
end,function(...)
self:onStartAction_2(...)
end)


end


function UIHunYuanDanHuiChenJiuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chenjiuRoot);self.chenjiuRoot=nil;
self.chenjiuScrollView:deleteSelf();self.chenjiuScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.TabPanel);self.TabPanel=nil;
_UIObject_release(self.tujianRoot);self.tujianRoot=nil;
self.tujianScrollView:deleteSelf();self.tujianScrollView=nil;
end
















local _this

local CmpChenJiuSlotIndex={
danIcon=0,
taskDesc=1,
rewardList=2,
receive=3,
receiveClickBtn=4,
reddot=5,
day=6,
gotoClickBtn=7,
iconBg=12,
icon=13,
progressBar=14,
}
local rewardIndexList={8,9,10,11}

local CmpTuJianSlotIndex={
icon1=0,
icon2=1,
icon3=2,
name1=3,
name2=4,
score=5,
}

local _abname="ui/windows/activities/sub_hunyuandanhui/hunyuandanhui_atlas_pak.ab"




function UIHunYuanDanHuiChenJiuWin:onLoaded(...)
self:bindComponents()
_this=self
self.chenjiuScrollView:bindScrollWidget(function(...)self:onFreshAction(...)end)
self.tujianScrollView:bindScrollWidget(function(...)self:onFreshAction_2(...)end)
end


function UIHunYuanDanHuiChenJiuWin:__delete()
self:unbindComponents()
end




function UIHunYuanDanHuiChenJiuWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self:refreshTabList()

if afterOnloaded then
self.Root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6449,1,nil,eAnimationID.enter)
self:delayDo(1,function()
if not _this then return end
return _this.Root:setChildCanvasGroupDOFade(1,0.5)
end)
end
end


function UIHunYuanDanHuiChenJiuWin:onHide()

end

function UIHunYuanDanHuiChenJiuWin:refreshPanel()
if self.selectTab==0 then
self:refreshChenJiu()
else
self:refreshTuJian()
end
self.chenjiuRoot:setActive(self.selectTab==0)
self.tujianRoot:setActive(self.selectTab==1)
end

function UIHunYuanDanHuiChenJiuWin:refreshChenJiu()
local cfgs=cfg_hunyuandanhuitaskconfig()
local len=#cfgs
self.chenjiuDataList={}
for i,cfg in ipairs(cfgs)do
local weight=cfg.id
local taskData=self.myData.taskList[cfg.id]or{}
local num=taskData.param_2 or 0
local isReceive=taskData.param_3==2
local isFinish=taskData.param_3==1
if isReceive then
weight=weight+len*10
elseif isFinish then
weight=weight-len*10
end

table.insert(self.chenjiuDataList,{id=cfg.id,weight=weight})
end

table.sort(self.chenjiuDataList,function(a,b)
return a.weight<b.weight
end)

local taskLen=#self.chenjiuDataList

self.chenjiuScrollView:freshGridsNum(taskLen,taskLen,1,self.chenjiuZeroFlag)
self.chenjiuZeroFlag=true
end

function UIHunYuanDanHuiChenJiuWin:refreshTuJian()
local cfgs=cfg_hunyuandanhuielementconfig()
local len=#cfgs
self.dataList={}
for i=2,len do
table.insert(self.dataList,i)
end

local taskLen=#self.dataList

self.tujianScrollView:freshGridsNum(taskLen,taskLen,1,self.tujianZeroFlag)
self.tujianZeroFlag=true
end

function UIHunYuanDanHuiChenJiuWin:onFreshAction(id,item)
local taskId=self.chenjiuDataList[id].id
local cfg=cfgHelper.get2(cfg_hunyuandanhuitaskconfig_get,taskId)
local taskData=self.myData.taskList[taskId]or{}
local isReceive=taskData.param_3==2
local isFinish=taskData.param_3==1
local num=isFinish and cfg.aim_num or(taskData.param_2 or 0)

item:SetChildActive(CmpChenJiuSlotIndex.iconBg,cfg.task_type==2)
item:SetChildActive(CmpChenJiuSlotIndex.danIcon,cfg.task_type==1)
if cfg.task_type==1 then
item:SetChildCSImageSprite(CmpChenJiuSlotIndex.danIcon,_abname,self.info:getHYDHSrc(cfg.task_param))
elseif cfg.task_type==2 then
local iconName=iconHelper.getIconName(cfg.task_param)
item:SetChildIcon(CmpChenJiuSlotIndex.icon,iconName,false)
end

local color=num<cfg.aim_num and"#C82C2C"or"#549327"
item:SetChildText(CmpChenJiuSlotIndex.taskDesc,FMT.fmt("{0}(<color={3}>{1}/{2}</color>)",cfg.name,num,cfg.aim_num,color))
item:SetChildProgressValue(CmpChenJiuSlotIndex.progressBar,num,cfg.aim_num)
item:SetChildProgressText(CmpChenJiuSlotIndex.progressBar,FMT.fmt("{0}/{1}",num,cfg.aim_num))

item:SetChildActive(CmpChenJiuSlotIndex.receive,isReceive)

item:SetChildActive(CmpChenJiuSlotIndex.reddot,isFinish)
item:SetChildActive(CmpChenJiuSlotIndex.receiveClickBtn,isFinish)
item:SetChildButtonClick(CmpChenJiuSlotIndex.receiveClickBtn,function()
if isFinish then
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_getTaskReward",self.actID,self.subType,self.subid,taskId)
end
end,true)

item:SetChildActive(CmpChenJiuSlotIndex.gotoClickBtn,not isFinish and not isReceive)
item:SetChildButtonClick(CmpChenJiuSlotIndex.gotoClickBtn,function()
self:onCloseBtn()
end,true)


item:SetChildActive(CmpChenJiuSlotIndex.day,cfg.if_daily==1)

local rewardList=self.sub_actcfg.task_conf[taskId]or{}
local isShowRewardList=#rewardList>0
item:SetChildActive(CmpChenJiuSlotIndex.rewardList,isShowRewardList)
if isShowRewardList then
local propDataList={}
for index,rewardData in ipairs(rewardList)do
local itemId=rewardData[1]
local itemCount=rewardData[2]
local isShowCount=itemCount>1
local itemCountStr=isShowCount and itemCount or""
local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=isShowCount,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
propDataList[#propDataList+1]=propData
end

for index,rindex in ipairs(rewardIndexList)do
local propData=propDataList[index]
local isShow=propData~=nil
item:SetChildActive(rindex,isShow)
if isShow then
item:SetChildPropData(rindex,propData)
item:SetBaseItemClickEvent(rindex,function(...)
itemsComponentHelper.onItemClick(...)
end)
end
end

item:SetChildScrollRectEnable(CmpChenJiuSlotIndex.rewardList,#rewardList>2)
end
end

function UIHunYuanDanHuiChenJiuWin:onStartAction()

end


function UIHunYuanDanHuiChenJiuWin:onFreshAction_2(id,item)
local id=self.dataList[id]
local lastCfg=cfgHelper.get1(cfg_hunyuandanhuielementconfig_get,id-1)
local cfg=cfgHelper.get1(cfg_hunyuandanhuielementconfig_get,id)

item:SetChildCSImageSprite(CmpTuJianSlotIndex.icon1,_abname,self.info:getHYDHSrc(lastCfg.id))
item:SetChildCSImageSprite(CmpTuJianSlotIndex.icon2,_abname,self.info:getHYDHSrc(lastCfg.id))
item:SetChildCSImageSprite(CmpTuJianSlotIndex.icon3,_abname,self.info:getHYDHSrc(cfg.id))
item:SetChildText(CmpTuJianSlotIndex.name1,lastCfg.name)
item:SetChildText(CmpTuJianSlotIndex.name2,cfg.name)

item:SetChildText(CmpTuJianSlotIndex.score,FMT.fmt("积分<color=#549327>+{0}</color>",lastCfg.point))
end

function UIHunYuanDanHuiChenJiuWin:onStartAction_2()

end

function UIHunYuanDanHuiChenJiuWin:refreshTabList()
local _checkRedFunc1=function()

end
local _checkRedFunc2=function()

end
local tabList={
{name="成就",checkRedFunc=_checkRedFunc1},
{name="图鉴",checkRedFunc=_checkRedFunc2}
}
local length=#tabList
self.TabPanel:setChildScrollViewCreateGrids(length,1)

local grids=self.TabPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local grid=grids[i]
local tab=tabList[i+1]
grid:SetChildText(1,tab.name)
grid:SetChildButtonClick(2,function()
self:onTabClick(i,tab)
end)
grid:SetChildActive(3,tab.checkRedFunc()or false)
end

self:onInitTabClick()
end

function UIHunYuanDanHuiChenJiuWin:setToggleOn(index,on)
local sitem=self.TabPanel:getChildScrollViewItemWidget(index)
sitem:SetChildActive(0,on)
end

function UIHunYuanDanHuiChenJiuWin:onInitTabClick()
if self.selectTab~=nil then
return
end
self:onTabClick(0)
end

function UIHunYuanDanHuiChenJiuWin:onTabClick(index)
if self.selectTab==index then
return
end
if self.selectTab~=nil then
self:setToggleOn(self.selectTab,false)
end
self.selectTab=index
self:setToggleOn(index,true)

self:refreshPanel()
end




function UIHunYuanDanHuiChenJiuWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


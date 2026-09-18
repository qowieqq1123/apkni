







def_class("UISubAct_HYPTTaskWin",UIWindowBase)









function UISubAct_HYPTTaskWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.menuGridPanel=UIObject.get(self,1)
self.rankScrollView=UIObject.get(self,2)
self.rankItem=UIObject.get(self,3)
self.rewardScrollView=UIObject.get(self,4)
self.tipsTxt=UIText.get(self,5)
self.noItemTips=UIText.get(self,6)
self.rewardGridPanel=UIObject.get(self,7)
self.rankGridPanel=UIObject.get(self,8)
self.tipsTxt2=UIText.get(self,9)
self.tipIcon=UIImage.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.descone=UIText.get(self,12)
self.desctwo=UIText.get(self,13)
self.taskdesc=UIText.get(self,14)
self.item_1=UIObject.get(self,15)
self.tipsdesc=UIText.get(self,16)
self.linkImageText=UILinkImageText.get(self,17)
self.costtext=UIText.get(self,18)
self.changebtn=UIButton.get(self,19)
self.querenbtn=UIButton.get(self,20)
self.center=UIObject.get(self,21)
self.effect1=UIObject.get(self,22)
self.effect2=UIObject.get(self,23)
self.effect3=UIObject.get(self,24)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.changebtn:setButtonClick(function()self:onChangebtn()end)

self.querenbtn:setButtonClick(function()self:onQuerenbtn()end)
self.item={
self.item_1,
}



end


function UISubAct_HYPTTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rewardGridPanel);self.rewardGridPanel=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.tipsTxt2);self.tipsTxt2=nil;
_UIObject_release(self.tipIcon);self.tipIcon=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descone);self.descone=nil;
_UIObject_release(self.desctwo);self.desctwo=nil;
_UIObject_release(self.taskdesc);self.taskdesc=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.tipsdesc);self.tipsdesc=nil;
_UIObject_release(self.linkImageText);self.linkImageText=nil;
_UIObject_release(self.costtext);self.costtext=nil;
_UIObject_release(self.changebtn);self.changebtn=nil;
_UIObject_release(self.querenbtn);self.querenbtn=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
self.item=nil;
end

















local _this


function UISubAct_HYPTTaskWin:onLoaded(...)
self:bindComponents()
_this=self
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end


function UISubAct_HYPTTaskWin:__delete()
self:unbindComponents()
if self.isgetbtnTimer then
self:stopTimerByID(self.isgetbtnTimer)
self.isgetbtnTimer=nil
end
UIManager:hideWindow('UITopMoneyWin')
_this=nil
end




function UISubAct_HYPTTaskWin:onShow(argtable,afterOnloaded)
if argtable then
self.task_id=argtable.task_id
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self.desc=''
self.iscanchange=false
self.isfree=true
self.moneyType=nil
self.isgetbtn=false




UISubAct_HYPTTaskWin:refreshdata({self.actID,self.subType,self.subid,self.task_id})
end
end


function UISubAct_HYPTTaskWin:onHide()

end


function UISubAct_HYPTTaskWin:refreshdata(args)
local task_id=args[4]

if _this.actID==args[1]and _this.subType==args[2]and _this.subid==args[3]then
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local taskList=mydata.taskList
local puzzle_id=mydata.puzzle_id
local use_times=mydata.use_times
local cfg=cfg_paintedpuzzleactivityconfig_get(_this.subid)
local task_pools=cfg.task_pools
local cfg_reward=cfg.debris
_this.task_id=task_id
local taskIndex=taskList[task_id].task_idx

_this.descone:setText(cfg.desc_one)


local taskdata=task_pools[taskIndex]
_this.taskdesc:setText(taskdata[3])

local dataitem=cfg_reward[puzzle_id][taskList[task_id].reward_idx][1]
local item=_this.item_1:getWidgetBase()
widgetHelper.setNormalRewardItem(item,-1,dataitem)
item:SetChildButtonClick(14,function()
if _this==nil then return end
_this:ontipsClick(dataitem[1])
end)


_this.tipsdesc:setText(cfg.desc_tips)

_this.iscanchange=false


if use_times<cfg.free_times then
_this.linkImageText:setActive(false)
_this.costtext:setActive(true)
_this.costtext:setText(FMT.fmt('费用：<color=#549327>{0}/{1}免费</color>',use_times,cfg.free_times))
_this.desc='本次变更消耗：<color=#549327>免费</color>'
_this.iscanchange=true
_this.isfree=true
else
_this.isfree=false
_this.linkImageText:setActive(true)
_this.costtext:setActive(false)
local cost_items=cfg.cost_items
local cost=cost_items









local haveItem
if moneyConfig.isMoney(cost[1])then
haveItem=moneyModel.getMoney(cost[1])
else
haveItem=bagControl.invokeFuncByItemId(cost[1],'getItemCountByItemID',cost[1])
end

if haveItem>=cost[2]then
_this.iscanchange=true
end
_this.moneyType=cost[1]
_this.moneyNum=cost[2]

local colorStr=haveItem>=cost[2]and"549327FF"or"549327FF"
local iconStr=iconHelper.getIconName(cost[1])
local costStr=FMT.fmt("费用：quad-icon={2}-quad<color=#{0}> {1}</color>",colorStr,cost[2],iconStr)
_this.linkImageText:setText(costStr)
_this.desc=FMT.fmt("本次变更消耗：quad-icon={2}-quad<color=#{0}> {1}</color>",colorStr,cost[2],iconStr)

end
end
end






function UISubAct_HYPTTaskWin:onCloseBtn()
self:closeSelf()
end


function UISubAct_HYPTTaskWin:onChangebtn()

if _this.isgetbtn then
UIManager.error('祖师点击太频繁，请稍后再试')
return
end
if not _this.isgetbtn then
if _this.isfree then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHuiYinPinTu)
if not flag then
local show_data=
{
title='提示',
contentStr=_this.desc or'',
okcallback=function()
local json_str=jsonHelper.encode({2,_this.task_id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
}
UIManager:showWindow('UIDialougeHYPTtips',show_data)
else
local json_str=jsonHelper.encode({2,_this.task_id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
else

local buyCost={_this.moneyType,_this.moneyNum}
local isEnough=moneyModel.checkEnoughMoney(buyCost[1],buyCost[2])
if not isEnough and buyCost[1]==eMoneyType.mtLingYu then

local hasLingYuCount=moneyModel.getMoney(buyCost[1])
local needXianYuCount=buyCost[2]-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end
if not isEnough then
local MoneyName=moneyModel.getMoneyName(buyCost[1])
UIManager.error(FMT.fmt("{0}不足",MoneyName))
gainControl:showGainWin(buyCost[1])
return
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHuiYinPinTu)
if not flag then
local show_data=
{
title='提示',
contentStr=_this.desc or'',
okcallback=function()
local cb=function(...)
local json_str=jsonHelper.encode({2,_this.task_id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
moneySystem:useMoney(buyCost[1],buyCost[2],cb,WARNING_TYPE.eWarning)
end
}
UIManager:showWindow('UIDialougeHYPTtips',show_data)
else
local cb=function(...)
local json_str=jsonHelper.encode({2,_this.task_id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
moneySystem:useMoney(buyCost[1],buyCost[2],cb,WARNING_TYPE.eWarning)
end
end
_this.isgetbtn=true
end

if not _this.isgetbtnTimer and _this.isgetbtn==true then
_this.isgetbtnTimer=_this:delayDo(1,function()
if _this==nil then return end
_this.isgetbtnTimer=nil
_this.isgetbtn=false
end)
end
end


function UISubAct_HYPTTaskWin:onQuerenbtn()
self:closeSelf()
end


function UISubAct_HYPTTaskWin:ontipsClick(itemId)
if not itemId or itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end


function UISubAct_HYPTTaskWin:playeffec()


_this.winlua:SetChildShowEffect(_this.effect2:getID(),10503,true)
_this.winlua:SetChildShowEffect(_this.effect3:getID(),10503,true)
end








def_class("UISubAct_DrawDianJiWin",UIWindowBase)









function UISubAct_DrawDianJiWin:bindComponents()

self.modelBg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.unlockText=UIText.get(self,2)
self.unlcokBtn=UIButton.get(self,3)
self.unlcokbg=UIButton.get(self,4)
self.timeRoot=UIObject.get(self,5)
self.jumpBtn=UIButton.get(self,6)
self.introduceBtn=UIButton.get(self,7)
self.shopScrollerView=UIObject.get(self,8)
self.name=UIObject.get(self,9)
self.title=UIText.get(self,10)
self.ratio1=UIImage.get(self,11)
self.suo2=UIObject.get(self,12)
self.touziName=UIText.get(self,13)
self.ratio2=UIImage.get(self,14)
self.suo1=UIObject.get(self,15)
self.lefttime=UIText.get(self,16)
self.all_jifen=UIText.get(self,17)
self.jifenroot=UIObject.get(self,18)
self.rewadProgress=UIObject.get(self,19)
self.jifenitem=UIObject.get(self,20)
self.rewardProgressBar=UIObject.get(self,21)
self.rewadProgressbg=UIObject.get(self,22)
self.Content=UIObject.get(self,23)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)

self.unlcokbg:setButtonClick(function()self:onUnlcokbg()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.introduceBtn:setButtonClick(function()self:onIntroduceBtn()end)
self.all={
["jifen"]=self.all_jifen,
}



end


function UISubAct_DrawDianJiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
_UIObject_release(self.unlcokbg);self.unlcokbg=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.introduceBtn);self.introduceBtn=nil;
_UIObject_release(self.shopScrollerView);self.shopScrollerView=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.touziName);self.touziName=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.all_jifen);self.all_jifen=nil;
_UIObject_release(self.jifenroot);self.jifenroot=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.jifenitem);self.jifenitem=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewadProgressbg);self.rewadProgressbg=nil;
_UIObject_release(self.Content);self.Content=nil;
self.all=nil;
end



















local itemsize=98

function UISubAct_DrawDianJiWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_DrawDianJiWin:__delete()
self:unbindComponents()
end




function UISubAct_DrawDianJiWin:onShow(argtable,afterOnloaded)
self.modelBg:setChildUIModelShowTarget(5382,1,{},0)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end



end
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.shopScrollerView:setActive(true)
self:initdata()

end


function UISubAct_DrawDianJiWin:onHide()
self.shopScrollerView:setActive(false)
end

local itemcmp=
{
freeCreat=1,
moneyCreat=2,
rmbCreat=3,
}

local item2cmp=
{
normalReward=0,
select=1,
spriteani=2,
lock=3,
gray=4,
}
local jifencmp=
{
activebg=0,
jifennum=1,
}

function UISubAct_DrawDianJiWin:initdata()
self:startCDTick()

self.activityData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
if not self.activityData.hhjifen then
self.activityData.hhjifen=0
end
local taskList=self.config.taskList
self.temp={}

local maxindex=0
for i,v in ipairs(taskList)do
self.temp[#self.temp+1]=v
local cfg=cfgHelper.get1(cfg_huihuadianjiactgoalconfig_get,v)
local hhjf=cfg.hhjf
if self.activityData.hhjifen>=hhjf and maxindex<i then

maxindex=i
end
end
local len=#self.temp
self.shopScrollerView:setChildScrollViewCreateGrids(len,1)
local grids=self.shopScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
self:SetItemData(grids[i-1],i)
end


local nowindex=1
self.jifenroot:setChildLayoutGroupCreateItems(len,function(index)
local cfg=cfgHelper.get1(cfg_huihuadianjiactgoalconfig_get,self.temp[index])
local hhjf=cfg.hhjf
local item=self.jifenroot:getChildLayoutGroupGridItem(index-1)

item:SetChildActive(jifencmp.activebg,self.activityData.hhjifen>=hhjf)
if self.activityData.hhjifen>=hhjf and nowindex<index then
nowindex=index
end
end)

self.shopScrollerView:setChildScrollViewSelectItem(nowindex,false,false,true)
self.winlua:SetAsLastSibling(self.rewardProgressBar:getID())

self.rewardProgressBar:setChildSizeDelta(18,itemsize*len)

local jindu=0

local deno=1

if maxindex==0 then
local hhjf2=cfgHelper.get2(cfg_huihuadianjiactgoalconfig_get,self.temp[maxindex+1],"hhjf")
deno=hhjf2
jindu=self.activityData.hhjifen
elseif

maxindex<#self.temp then
local hhjf=cfgHelper.get2(cfg_huihuadianjiactgoalconfig_get,self.temp[maxindex],"hhjf")
local hhjf2=cfgHelper.get2(cfg_huihuadianjiactgoalconfig_get,self.temp[maxindex+1],"hhjf")
deno=hhjf2-hhjf
jindu=self.activityData.hhjifen-hhjf
end
self.rewadProgressbg:setActive(self.activityData.hhjifen>0)

self.rewadProgress:setChildSizeDelta(8,(itemsize*maxindex)+(itemsize*jindu/deno))

self.all_jifen:setText(FMT.fmt("累计积分：{0}",self.activityData.hhjifen))
self.suo1:setActive(self.activityData.tzRewardFlag1==0)
self.suo2:setActive(self.activityData.tzRewardFlag2==0)

self.unlcokbg:setActive(true)
self.unlcokBtn:setActive(true)
self.unlockText:setActive(true)
if self.activityData.tzRewardFlag1==1 and self.activityData.tzRewardFlag2==1 then
self.unlcokbg:setActive(false)
self.unlcokBtn:setActive(false)
self.unlockText:setActive(false)
end

end


function UISubAct_DrawDianJiWin:SetItemData(widget,index)
if widget==nil then
widget=self.rankRewardListScroller:getChildScrollViewItemWidget(index-1)
end

local cfg=cfgHelper.get1(cfg_huihuadianjiactgoalconfig_get,self.temp[index])
if widget and cfg then
local freeReward=cfg.freeReward
local jifen=cfg.hhjf
widget:SetChildActive(10,jifen<=self.activityData.hhjifen)
local hhjf_str=""
if self.activityData.hhjifen>=jifen then
hhjf_str=string.format("<color=#549327>%d</color>",jifen)
else
hhjf_str=string.format("<color=#efeded>%d</color>",jifen)
end
widget:SetChildText(11,hhjf_str)

widget:SetChildLayoutGroupCreateItems(itemcmp.freeCreat,#freeReward,function(index2)
local data={}
local reward=freeReward[index2]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true

local widget1=widget:GetChildLayoutGroupGridItem(itemcmp.freeCreat,index2-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
local wid=widget1:GetChildWidgetBase(0)


widget1:SetChildActive(item2cmp.gray,jifen>self.activityData.hhjifen)
widget1:SetChildActive(item2cmp.lock,false)
widget1:SetChildActive(2,false)
widget1:SetChildActive(item2cmp.select,false)
if self.activityData.CangetReward and self.activityData.CangetReward[index]then

if self.activityData.CangetReward[index][1]then
widget1:SetChildActive(2,true)
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
elseif self.activityData.hhjifen>=jifen then

widget1:SetChildActive(item2cmp.gray,true)
widget1:SetChildActive(item2cmp.select,true)
end
end

end)

local tzReward1=cfg.tzReward1
widget:SetChildLayoutGroupCreateItems(itemcmp.moneyCreat,#tzReward1,function(index2)
local data={}
local reward=tzReward1[index2]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true

local widget1=widget:GetChildLayoutGroupGridItem(itemcmp.moneyCreat,index2-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
widget1:SetChildActive(item2cmp.gray,(jifen>self.activityData.hhjifen)or(self.activityData.tzRewardFlag1==0))
widget1:SetChildActive(item2cmp.lock,self.activityData.tzRewardFlag1==0)
widget1:SetChildActive(2,false)
widget1:SetChildActive(item2cmp.select,false)
if self.activityData.CangetReward and self.activityData.CangetReward[index]then
if self.activityData.CangetReward[index][2]then
widget1:SetChildActive(2,true)
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
elseif self.activityData.hhjifen>=jifen and self.activityData.tzRewardFlag1==1 then

widget1:SetChildActive(item2cmp.gray,true)
widget1:SetChildActive(item2cmp.select,true)
end

end
end)

local tzReward2=cfg.tzReward2
widget:SetChildLayoutGroupCreateItems(itemcmp.rmbCreat,#tzReward2,function(index2)
local data={}
local reward=tzReward2[index2]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true

local widget1=widget:GetChildLayoutGroupGridItem(itemcmp.rmbCreat,index2-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
widget1:SetChildActive(item2cmp.gray,(jifen>self.activityData.hhjifen)or(self.activityData.tzRewardFlag2==0))
widget1:SetChildActive(item2cmp.lock,self.activityData.tzRewardFlag2==0)
widget1:SetChildActive(2,false)
widget1:SetChildActive(item2cmp.select,false)
if self.activityData.CangetReward and self.activityData.CangetReward[index]then
if self.activityData.CangetReward[index][3]then
widget1:SetChildActive(2,true)
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
elseif self.activityData.hhjifen>=jifen and self.activityData.tzRewardFlag2==1 then

widget1:SetChildActive(item2cmp.gray,true)
widget1:SetChildActive(item2cmp.select,true)
end
end
end)
end
end




function UISubAct_DrawDianJiWin:onUnlcokBtn()
UIManager:showWindow("UIDrawDianJiTouZiWin",{taskList=self.config.taskList,activityId=self.activityId,subType=self.subType,subId=self.subId})
end



function UISubAct_DrawDianJiWin:onCloseBtn()
end



function UISubAct_DrawDianJiWin:onBuyBtn()
end


function UISubAct_DrawDianJiWin:onJumpBtn()
local JumpParam=self.config.JumpParam
local args=JumpParam.args
local id=JumpParam.id
if id==JUMP_TYPE.eActivity then
local _subType=args.subType
local _subid=args.subid
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=_subType,subid=_subid}},function()
jumpManager:clearJump()
end)
elseif id==JUMP_TYPE.eLimitActivity then
local actID=args.actID
if limitActivitiesModel:checkAct_Open_Doing(actID)then
jumpManager:jump(JumpParam)
else
UIManager.info("灵阵绘画每周一、三、五开启")
end
end
end


function UISubAct_DrawDianJiWin:onIntroduceBtn()
local descFMT='UIDrawDianJiWin_wanfa_%s'
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=descFMT})
end
function UISubAct_DrawDianJiWin:onPrize()
call_activitiesHandle_func('activitiesHandle_drawdianji','reqtaskReward',self.activityId,self.subId,1)
end

function UISubAct_DrawDianJiWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_DrawDianJiWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_DrawDianJiWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.lefttime:setText(FMT.fmt("{0}后结束",timeHelper.format_time_stamp3(time)))
end

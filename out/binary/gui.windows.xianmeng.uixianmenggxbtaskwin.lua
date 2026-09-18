







def_class("UIXianMengGXBTaskWin",UIWindowBase)









function UIXianMengGXBTaskWin:bindComponents()

self.progressBg=UIProgressBarAni.get(self,0)
self.progressSprite=UIObject.get(self,1)
self.progressRoot=UIObject.get(self,2)
self.score=UIText.get(self,3)
self.taskList=UIObject.get(self,4)
self.leftContent=UIObject.get(self,5)



end


function UIXianMengGXBTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.progressBg);self.progressBg=nil;
_UIObject_release(self.progressSprite);self.progressSprite=nil;
_UIObject_release(self.progressRoot);self.progressRoot=nil;
_UIObject_release(self.score);self.score=nil;
_UIObject_release(self.taskList);self.taskList=nil;
_UIObject_release(self.leftContent);self.leftContent=nil;
end
















local _this=nil
local _rewardCmp={
root=-1,
light=0,
reward=1,
numRoot=2,
numIcon=3,
numTx=4,
}
local _taskCmp={
bg=0,
icon=1,
name=2,
desc=3,
state=4,
time=5,
iconBg=6,
reddot=7,
}
local _money=19
local _rewardInterval=83.5
local _rewardBottom=100
local _rewardTop=25
local _rewardOver=7
local _ab='ui/windows/xianmeng/gongxunbangicons_atlas_pak.ab'



function UIXianMengGXBTaskWin:onLoaded(...)
self:bindComponents()
_this=self

self:refreshRewardList()
self:refreshTaskList()
end


function UIXianMengGXBTaskWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianMengGXBTaskWin:onShow(argtable,afterOnloaded)

end


function UIXianMengGXBTaskWin:onHide()

end



function UIXianMengGXBTaskWin:refreshRewardList()
local cfgId=xianmengModel:getGXBRewardId()
local flag=xianmengModel:getGXBRewardFlag()
local value=xianmengModel:getGXBValue()
local config=cfgHelper.get1(cfg_guildweekscoreconfig_get,cfgId)
self.info={}
local len=(#config.rewards-1)*_rewardInterval+_rewardBottom+_rewardTop
local pass=nil
for i,v in ipairs(config.rewards)do
local temp={
num=v[1],
flag=mathHelper.getBitValue(flag,i-1)
}
table.insert(self.info,temp)
local first=config.rewards[i-1]==nil
local min=not first and config.rewards[i-1][1]or 0
local max=v[1]
if value>=min and value<=max then
if first then
pass=(value-min)/(max-min)*_rewardBottom
else
pass=_rewardBottom+(i-2)*_rewardInterval+(value-min)/(max-min)*_rewardInterval
end
end
if value>=max and i>=#config.rewards then
pass=nil
end
end
pass=pass or len
self.progressBg:setChildSizeDelta(len+_rewardOver,34)
self.progressBg:animateThreeParams(math.floor(pass/len*10000),10000,0)

self.progressRoot:setChildLayoutGroupCreateItems(#self.info,function(index)
local item=self.progressRoot:getChildLayoutGroupGridItem(index-1)
local data=self.info[index]
local side=(index-1)%2
local widget=item:GetChildWidgetBase(side)
widget:SetChildActive(_rewardCmp.root,true)
widget:SetChildText(_rewardCmp.numTx,data.num)
widget:SetChildCSImageIcon(_rewardCmp.numIcon,iconHelper.getIconName(_money),false)
widget:SetChildActive(_rewardCmp.light,not data.flag and value>=data.num)
widget:ForceLayoutRect(_rewardCmp.numRoot)
widget:SetChildButtonClick(_rewardCmp.root,function()
self:onClickReward(index)
end)
if data.flag then
widget:SetChildUIModelShowTarget(_rewardCmp.reward,4222,1,{},eAnimationID.stand3,false,false,0)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,true)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.gray)
end
elseif value>=data.num then
widget:SetChildUIModelShowTarget(_rewardCmp.reward,4222,1,{},eAnimationID.stand2,false,false,0)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,false)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.white)
end
else
widget:SetChildUIModelShowTarget(_rewardCmp.reward,4222,1,{},eAnimationID.stand,false,false,0)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,false)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.white)
end
end
end)
self.score:setText(mathHelper.formatNumber(value,true))
self.winlua:ForceLayoutRect(self.leftContent:getID())
end

function UIXianMengGXBTaskWin:onClickReward(index)
local cfgId=xianmengModel:getGXBRewardId()
local value=xianmengModel:getGXBValue()
local flag=xianmengModel:getGXBRewardFlag()
local config=cfgHelper.get1(cfg_guildweekscoreconfig_get,cfgId)
local cfg=config.rewards[index]
if not mathHelper.getBitValue(flag,index-1)and cfg and cfg[1]<=value then
xianmengController.req_protocol_20_36(index)
return
end

local args=
{
title='功勋奖励',
desc=FMT.fmt("本周累计获得<color=#549327>{0}功勋</color>可领取",cfg[1]),
rewards=cfg[2],
finish=mathHelper.getBitValue(flag,index-1),
}
self:showWindow('UIXianMengGXBTaskRewardDialouge',args)
end








function UIXianMengGXBTaskWin:refreshTaskList()
local config=cfg_gongxunbangjumpconfig()
self.jumpList={}
for i,v in pairs(config)do
local temp0=xianmengModel:getGXBTaskCheck(v.param[1],v.param[2])
local temp1=xianmengModel:getGXBTypeWeight(v.param[1])or 10
local temp2=(temp0 and 0 or 10000)+temp1*100+v.id
local temp={
id=v.id,
check=temp0,
sort=temp2,
}
table.insert(self.jumpList,temp)
end
table.sort(self.jumpList,function(a,b)
return a.sort<b.sort
end)
self.taskList:setChildLayoutGroupCreateItems(#self.jumpList,function(index)
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local data=self.jumpList[index]
local cfg=config[data.id]
local check=data.check
local reddot=check and xianmengModel:getGXBTaskReddot(cfg.id)

item:SetChildText(_taskCmp.name,cfg.name)
item:SetChildText(_taskCmp.desc,cfg.desc)
item:SetChildButtonClick(_taskCmp.bg,function()
self:onClickTask(index)
end)
item:SetChildCSImageSprite(_taskCmp.icon,cfg.icon[1],cfg.icon[2])
item:SetChildCSImageSprite(_taskCmp.iconBg,cfg.iconBg[1],cfg.iconBg[2])

item:SetChildActive(_taskCmp.reddot,reddot)

item:SetChildCSImageSprite(_taskCmp.state,_ab,xianmengModel:getGXBTaskStateImageEx(cfg.param[1],check))
if check then
if cfg.progress then
item:SetChildText(_taskCmp.time,FMT.fmt(cfg.progress,xianmengModel:getGXBTaskValue(cfg.id)))
item:SetChildActive(_taskCmp.time,true)
else
item:SetChildActive(_taskCmp.time,false)
end
else
local tipsStr=xianmengModel:getGXBTaskTips(cfg.param[1],cfg.param[2])
item:SetChildActive(_taskCmp.time,tipsStr~=nil)
if tipsStr then
item:SetChildText(_taskCmp.time,xianmengModel:getGXBTaskTips(cfg.param[1],cfg.param[2]))
end
end
end)
end

function UIXianMengGXBTaskWin:onClickTask(index)
local id=self.jumpList[index].id
local cfg=cfgHelper.get1(cfg_gongxunbangjumpconfig_get,id)
xianmengModel:doGXBTaskJump(cfg.param[1],cfg.param[2],cfg.jump)




end

function UIXianMengGXBTaskWin:refreshTaskItem(index)

local flag=xianmengModel:getGXBRewardFlag()
local value=xianmengModel:getGXBValue()
local info=self.info[index]
info.flag=mathHelper.getBitValue(flag,index-1)
local show=not info.flag and value>=info.num
local item=self.progressRoot:getChildLayoutGroupGridItem(index-1)
local side=(index-1)%2
local widget=item:GetChildWidgetBase(side)
widget:SetChildActive(_rewardCmp.light,not info.flag and value>=info.num)
if info.flag then
widget:SetChildModelAnimationState(_rewardCmp.reward,eAnimationID.stand3)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,true)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.gray)
end
elseif value>=data.num then
widget:SetChildModelAnimationState(_rewardCmp.reward,eAnimationID.stand2)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,false)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.white)
end
else
widget:SetChildModelAnimationState(_rewardCmp.reward,eAnimationID.stand)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,false)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.white)
end
end
end

function UIXianMengGXBTaskWin:refreshRewardValue()
local cfgId=xianmengModel:getGXBRewardId()
local config=cfgHelper.get1(cfg_guildweekscoreconfig_get,cfgId)
local value=xianmengModel:getGXBValue()
local len=(#config.rewards-1)*_rewardInterval+_rewardBottom+_rewardTop
local pass=nil
for i,v in ipairs(self.info)do
local item=self.progressRoot:getChildLayoutGroupGridItem(i-1)
local side=(i-1)%2
local widget=item:GetChildWidgetBase(side)
widget:SetChildActive(_rewardCmp.light,not v.flag and value>=v.num)
if v.flag then
widget:SetChildModelAnimationState(_rewardCmp.reward,eAnimationID.stand3)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,true)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.gray)
end
elseif value>=v.num then
widget:SetChildModelAnimationState(_rewardCmp.reward,eAnimationID.stand2)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,false)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.white)
end
else
widget:SetChildModelAnimationState(_rewardCmp.reward,eAnimationID.stand)
if api_Available_SetChildUIModelGray()then
widget:SetChildUIModelGray(_rewardCmp.reward,false)
else
widget:SetChildUIModelShowColor(_rewardCmp.reward,Color.white)
end
end

local first=config.rewards[i-1]==nil
local min=not first and config.rewards[i-1][1]or 0
local max=v.num
if value>=min and value<=max then
if first then
pass=(value-min)/(max-min)*_rewardBottom
else
pass=_rewardBottom+(i-2)*_rewardInterval+(value-min)/(max-min)*_rewardInterval
end
end
if value>=max and i>=#self.info then
pass=nil
end
end
pass=pass or len
self.progressBg:animateThreeParams(math.floor(pass/len*10000),10000,0)
self.score:setText(mathHelper.formatNumber(value,true))
end
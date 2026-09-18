







def_class("UILingShanTeamInfoWin",UIWindowBase)









function UILingShanTeamInfoWin:bindComponents()

self.bhTime=UIText.get(self,0)
self.bhTips=UIText.get(self,1)
self.cheLiBtn=UIButton.get(self,2)
self.fvalue=UIText.get(self,3)
self.headshot_1=UIObject.get(self,4)
self.headshot_2=UIObject.get(self,5)
self.headshot_3=UIObject.get(self,6)
self.headshot_4=UIObject.get(self,7)
self.headshot_5=UIObject.get(self,8)
self.headshotRoot=UIObject.get(self,9)
self.name=UIText.get(self,10)
self.player=UIObject.get(self,11)
self.signBGIcon=UIImage.get(self,12)
self.signIcon=UIImage.get(self,13)
self.signKuangIcon=UIImage.get(self,14)
self.tmTips=UIText.get(self,15)
self.xmName=UIText.get(self,16)
self.zhengDuoBtn=UIButton.get(self,17)

self.cheLiBtn:setButtonClick(function()self:onCheLiBtn()end)

self.zhengDuoBtn:setButtonClick(function()self:onZhengDuoBtn()end)
self.headshot={
self.headshot_1,
self.headshot_2,
self.headshot_3,
self.headshot_4,
self.headshot_5,
}



end


function UILingShanTeamInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bhTime);self.bhTime=nil;
_UIObject_release(self.bhTips);self.bhTips=nil;
_UIObject_release(self.cheLiBtn);self.cheLiBtn=nil;
_UIObject_release(self.fvalue);self.fvalue=nil;
_UIObject_release(self.headshot_1);self.headshot_1=nil;
_UIObject_release(self.headshot_2);self.headshot_2=nil;
_UIObject_release(self.headshot_3);self.headshot_3=nil;
_UIObject_release(self.headshot_4);self.headshot_4=nil;
_UIObject_release(self.headshot_5);self.headshot_5=nil;
_UIObject_release(self.headshotRoot);self.headshotRoot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.player);self.player=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.tmTips);self.tmTips=nil;
_UIObject_release(self.xmName);self.xmName=nil;
_UIObject_release(self.zhengDuoBtn);self.zhengDuoBtn=nil;
self.headshot=nil;
end
















local _this




function UILingShanTeamInfoWin:onLoaded(...)
self:bindComponents()

_this=self

self.countType={
eMoneyType.mtLingShanBattleTimes1,

}
end


function UILingShanTeamInfoWin:__delete()
self:unbindComponents()

_this=nil
end




function UILingShanTeamInfoWin:onShow(argtable,afterOnloaded)
self.mountId=argtable.mountId
self.areaId=argtable.areaId
self.pos=argtable.pos

self:refresh()
end


function UILingShanTeamInfoWin:onHide()

end

function UILingShanTeamInfoWin:refresh()
self:clearTimer()

local pdata=UILSZDControl:getAreaPosDataById(self.mountId,self.areaId,self.pos)
playerController:setHeadIcon(self.winlua,self.player:getID(),{scale=0.75,iconInfo=pdata.iconInfo})

local image=xianmengModel.splitGuildIcon(pdata.guildicon)
local abname=globalABLookup.xianmengicons
if image.icon>0 then
self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
end
if image.bg>0 then
self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
end
if image.kuang>0 then
self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

self.xmName:setText(pdata.guild_name)
self.name:setText(pdata.name)
local fvalue=tonumber(tostring(pdata.fight))
self.fvalue:setText(mathHelper.formatNumber(fvalue))


















self:setTeamList(pdata.disciple_list or{})

local xmId=xianmengModel:getMyXMGuildID()
if xmId==pdata.guild_id then
self.zhengDuoBtn:setActive(false)
self.bhTips:setActive(false)
local pId=playerModel:getActorID()
if pId==pdata.actor_id then
self.cheLiBtn:setActive(true)
self.tmTips:setActive(false)
else
self.cheLiBtn:setActive(false)
self.tmTips:setActive(true)
end
else
self.cheLiBtn:setActive(false)
self.tmTips:setActive(false)
local currtime=gameUtilityModel.getServerShortTime()
if currtime>pdata.protect_end_sec then
self.zhengDuoBtn:setActive(true)
self.bhTips:setActive(false)
else
self.zhengDuoBtn:setActive(false)
self.bhTips:setActive(true)
local ltime=pdata.protect_end_sec-currtime
self.bhTime:setText(timeHelper.format_time_stamp11(ltime,true))
self:startTimer(pdata.protect_end_sec)
end
end
end

function UILingShanTeamInfoWin:setTeamList(disciple_list)
self.headshotRoot:setActive(true)
for i=1,5 do
local headshot=self.headshot[i]

local tdata=disciple_list[i]
if tdata and tdata.flag==1 then
headshot:setActive(true)
local widget=headshot:getChildWidgetBase()
local image=UIDiscipleModel.calculationDiscipleImageBase(tdata)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,widget,modelParams)
local jobIcon=UIDiscipleModel:getJobIconName(image.job)
widget:SetChildCSImageSprite(2,globalABLookup.global,jobIcon)
comHelper.setChildModelHeadIconBGByColor(widget,0,image.color)

UIDiscipleModel:setDiscipleXianMoHeadImage(widget,3,tdata)
else
headshot:setActive(false)
end
end
end

function UILingShanTeamInfoWin:startTimer(etime)
self.timerId=self:setTimer(1,0,function()
local currtime=gameUtilityModel.getServerShortTime()
local dtime=etime-currtime
if dtime>=0 then
self.bhTime:setText(timeHelper.format_time_stamp11(dtime,true))
else
self:clearTimer()
self:refresh()
end
end)
end

function UILingShanTeamInfoWin:clearTimer()
if self.timerId then
self:stopTimerByID(self.timerId)
self.timerId=nil
end
end




function UILingShanTeamInfoWin:onCheLiBtn()
UILSZDControl:reqLeaveMount(self.mountId,self.areaId,self.pos)
self:onCloseClick()
end

function UILingShanTeamInfoWin:onZhengDuoBtn()
if self.isWaitDZData then
return
end

local cfg=UILSZDControl:getLingShanConfig(self.mountId)
local num=moneyModel.getMoney(self.countType[1])
if num>0 then
if UILSZDControl:checkTeamLimit(cfg.mount_type)then
UILSZDControl:handleFight(self.mountId,self.areaId,self.pos,1)
else
UIManager.error('您的入驻队伍数量已达上限')
end
else
UIManager.error('挑战次数不足')
end
end

function UILingShanTeamInfoWin:onCloseClick()
self:closeSelf()
end

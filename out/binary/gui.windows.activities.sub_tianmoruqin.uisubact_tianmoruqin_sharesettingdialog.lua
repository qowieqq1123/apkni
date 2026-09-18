







def_class("UISubAct_TianMoRuQin_ShareSettingDialog",UIWindowBase)









function UISubAct_TianMoRuQin_ShareSettingDialog:bindComponents()

self.background=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.confirmBtn=UIButton.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.shareChannelTips=UIText.get(self,4)
self.shareTypeTips=UIText.get(self,5)
self.switchBtn=UIButton.get(self,6)
self.channelList=UIObject.get(self,7)
self.typeList=UIObject.get(self,8)
self.switchClose=UIObject.get(self,9)
self.switchOpen=UIObject.get(self,10)

self.background:setButtonClick(function()self:onBackground()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.switchBtn:setButtonClick(function()self:onSwitchBtn()end)



end


function UISubAct_TianMoRuQin_ShareSettingDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.shareChannelTips);self.shareChannelTips=nil;
_UIObject_release(self.shareTypeTips);self.shareTypeTips=nil;
_UIObject_release(self.switchBtn);self.switchBtn=nil;
_UIObject_release(self.channelList);self.channelList=nil;
_UIObject_release(self.typeList);self.typeList=nil;
_UIObject_release(self.switchClose);self.switchClose=nil;
_UIObject_release(self.switchOpen);self.switchOpen=nil;
end















local _this=nil
local _chooseCmp={
toggle=0,
tick=1,
lock=2,
name=3,
toggleBg=4,
}
local _channelShow={
[CHAT_CHANNNEL.eXianmeng]=function(config)
if config.xmChannelLimit then
return timeHelper.getServerOpenLongTime()<timeHelper.getDateStamp(config.xmChannelLimit)
end
return true
end
}



function UISubAct_TianMoRuQin_ShareSettingDialog:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_TianMoRuQin_ShareSettingDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_TianMoRuQin_ShareSettingDialog:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.bgModel:setChildUIModelShowTarget(4851,1,nil,eAnimationID.stand,false,false,0)

self.settings=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getShareSettings")

self.autoShare=self.settings.autoShare or false
self.channels=self.settings.channels or 0
self.types=self.settings.types or 0

self.chatChannels=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getShareChannels")
self.showChannels={}
for i,v in ipairs(self.chatChannels)do
local check=_channelShow[v]
if check==nil or check(self.config)then
table.insert(self.showChannels,v)
end
end

if#self.showChannels==1 then
self.channelList:setActive(false)
self.shareChannelTips:setActive(false)
self.shareTypeTips:setChildAnchoredPos(-115,91)
self.typeList:setChildAnchoredPos(0,17)

self.channels=mathHelper.setbit(0,self.showChannels[1])
self.settings={
autoShare=self.autoShare,
channels=self.channels,
types=self.types,
}
call_activitiesHandle_func("activitiesHandle_tianmoruqin","setShareSettings",self.settings)
else
self.channelList:setChildLayoutGroupCreateItems(#self.showChannels,function(index)
local item=self.channelList:getChildLayoutGroupGridItem(index-1)
local channelID=self.showChannels[index]
local channelCfg=cfgHelper.get1(cfg_chatchannnelconfig_get,channelID)








local tick=mathHelper.getBitValue(self.channels,channelID)
item:SetChildButtonClick(_chooseCmp.toggle,function()
self:onClickChannel(index)
end)
item:SetChildText(_chooseCmp.name,CHAT_CHANNNEL_NAME[channelID])

item:SetChildActive(_chooseCmp.tick,tick)
item:SetChildActive(_chooseCmp.toggleBg,not tick)
end)
end

self.monsterTypes=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getShareMonsterTypes")
self.typeList:setChildLayoutGroupCreateItems(#self.monsterTypes,function(index)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
local monsterType=self.monsterTypes[index]
local monsterInfo=self.config.monster[monsterType]
local nameStr=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getFilterMonsterName",monsterType)

item:SetChildButtonClick(_chooseCmp.toggle,function()
self:onClickType(index)
end)
local tick=mathHelper.getBitValue(self.types,monsterType)
item:SetChildText(_chooseCmp.name,nameStr)
item:SetChildActive(_chooseCmp.tick,tick)
item:SetChildActive(_chooseCmp.toggleBg,not tick)
end)

self.switchOpen:setActive(self.autoShare)
self.switchClose:setActive(not self.autoShare)
end


function UISubAct_TianMoRuQin_ShareSettingDialog:onHide()

end




function UISubAct_TianMoRuQin_ShareSettingDialog:onBackground()
self:closeSelf()
end


function UISubAct_TianMoRuQin_ShareSettingDialog:onConfirmBtn()
self.settings={
autoShare=self.autoShare,
channels=self.channels,
types=self.types,
}
call_activitiesHandle_func("activitiesHandle_tianmoruqin","setShareSettings",self.settings)

local nowTime=timeHelper.getServerShortTime()
for i=1,TianMoRuQinMonsterCount do
local monsterData=self.info:getMonsterData(i)
if monsterData then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType

local deadTime=self.info:getMonsterDeadTimeEx(monsterData)
if monsterData.since>0 and nowTime<deadTime then
local maxBloodNum=tonumber(tostring(self.info:getMaxBloods(monType)))
local damageNum=tonumber(tostring(monsterData.damage))
if maxBloodNum>damageNum then
local share=self.info:checkShareChannel(monsterCfg.monType,monsterData.shareFlag)
if share>0 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqShareMonster",self.actId,self.subId,monsterData.guid,share)
end
end
end
end
end

self:closeSelf()
end


function UISubAct_TianMoRuQin_ShareSettingDialog:onCancelBtn()
self:closeSelf()
end


function UISubAct_TianMoRuQin_ShareSettingDialog:onSwitchBtn()
self.autoShare=not self.autoShare
self.switchOpen:setActive(self.autoShare)
self.switchClose:setActive(not self.autoShare)
end

function UISubAct_TianMoRuQin_ShareSettingDialog:onClickChannel(index)
local channel=self.chatChannels[index]











local check=mathHelper.getBitValue(self.channels,channel)
local item=self.channelList:getChildLayoutGroupGridItem(index-1)
if check then
self.channels=mathHelper.clrbit(self.channels,channel)
item:SetChildActive(_chooseCmp.tick,false)
item:SetChildActive(_chooseCmp.toggleBg,true)
else
self.channels=mathHelper.setbit(self.channels,channel)
item:SetChildActive(_chooseCmp.tick,true)
item:SetChildActive(_chooseCmp.toggleBg,false)
end
end

function UISubAct_TianMoRuQin_ShareSettingDialog:onClickType(index)
local monsterType=self.monsterTypes[index]
local monsterInfo=self.config.monster[monsterType]





local check=mathHelper.getBitValue(self.types,monsterType)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
if check then
self.types=mathHelper.clrbit(self.types,monsterType)
item:SetChildActive(_chooseCmp.tick,false)
item:SetChildActive(_chooseCmp.toggleBg,true)
else
self.types=mathHelper.setbit(self.types,monsterType)
item:SetChildActive(_chooseCmp.tick,true)
item:SetChildActive(_chooseCmp.toggleBg,false)
end
end
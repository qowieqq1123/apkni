







def_class("UISubAct_TianMoRuQin_ShareDialog",UIWindowBase)









function UISubAct_TianMoRuQin_ShareDialog:bindComponents()

self.background=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.shareBtn=UIButton.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.model=UIObject.get(self,4)
self.progressBar=UIProgress.get(self,5)
self.channels=UIObject.get(self,6)
self.nameTx=UIText.get(self,7)
self.levelTx=UIText.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UISubAct_TianMoRuQin_ShareDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.channels);self.channels=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.levelTx);self.levelTx=nil;
end















local _this=nil

local _chooseCmp={
root=-1,
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



function UISubAct_TianMoRuQin_ShareDialog:onLoaded(...)
self:bindComponents()
_this=self


end


function UISubAct_TianMoRuQin_ShareDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_TianMoRuQin_ShareDialog:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.shared=argtable.shared
self.guid=argtable.guid
self.monster=argtable.monster
self.leaveTime=argtable.leaveTime
self.precent=argtable.precent
self.level=argtable.level


self.config=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)

self.bgModel:setChildUIModelShowTarget(4851,1,nil,eAnimationID.stand,false,false,0)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.monster)

self.selectedChannels={}
self.enableChannels={}
self.allChannels=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getShareChannels")
for i,v in ipairs(self.allChannels)do
if not mathHelper.getBitValue(self.shared,i-1)then
self.enableChannels[v]=true
end
end

self.showChannels={}
for i,v in ipairs(self.allChannels)do
local check=_channelShow[v]
if check==nil or check(self.config)then
table.insert(self.showChannels,v)
end
end

local none={}
self.channels:setChildLayoutGroupCreateItems(#self.showChannels,function(index)
local item=self.channels:getChildLayoutGroupGridItem(index-1)
local channelID=self.showChannels[index]
local channelCfg=cfgHelper.get1(cfg_chatchannnelconfig_get,channelID)
local isOpen=true
if channelCfg.sysid then
isOpen=systemModel.isOpen(channelCfg.sysid)
if channelCfg.sysid==SYSTEM_DEFINE.eXianMeng then
isOpen=isOpen and xianmengModel:hasXM()
end
end
item:SetChildButtonClick(_chooseCmp.toggle,function()
self:onClickChannel(index)
end)
item:SetChildText(_chooseCmp.name,CHAT_CHANNNEL_NAME[channelID])
item:SetChildActive(_chooseCmp.lock,not isOpen)
if not self.enableChannels[channelID]then
item:SetChildActive(_chooseCmp.toggleBg,false)
item:SetChildActive(_chooseCmp.tick,true)
item:SetChildGraphicGray(_chooseCmp.root,true,true,true)
elseif isOpen then
table.insert(none,index)
end
end)

local modelParams=comHelper.getMonsterGroupModelParams(self.monster)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,11)
self.model:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])
self.nameTx:setText(monsterCfg.name)
self.levelTx:setText(FMT.fmt("境界：{0}",UIDiscipleModel:getJJName3(self.level)))

self.progressBar:setProgressValue(math.ceil(self.precent*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}%",math.ceil(self.precent*100)))

if#none==1 then
self:onClickChannel(none[1])
end
end


function UISubAct_TianMoRuQin_ShareDialog:onHide()

end




function UISubAct_TianMoRuQin_ShareDialog:onBackground()
self:closeSelf()
end


function UISubAct_TianMoRuQin_ShareDialog:onShareBtn()
local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.leaveTime then
return UIManager.error("天魔已离开")
end

local flag=0
for channel,isSelected in pairs(self.selectedChannels)do
if isSelected then
local index=table.findValue(self.allChannels,channel)
flag=mathHelper.setbit(flag,index-1)
end
end
if flag>0 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqShareMonster",self.actId,self.subId,self.guid,flag)
self:closeSelf()
else
UIManager.error("请先选择需要分享的频道")
end
end


function UISubAct_TianMoRuQin_ShareDialog:onCancelBtn()
self:closeSelf()
end

function UISubAct_TianMoRuQin_ShareDialog:onClickChannel(index)
local channel=self.allChannels[index]
if not self.enableChannels[channel]then
return UIManager.error("该频道已分享过")
end

local channelCfg=cfgHelper.get1(cfg_chatchannnelconfig_get,channel)
if channelCfg.sysid then
if not systemModel.isOpen(channelCfg.sysid)then
UIManager.error(FMT.fmt("{0}系统尚未开启",systemConfig.getSystemName(channelCfg.sysid)))
return
end
if channelCfg.sysid==SYSTEM_DEFINE.eXianMeng and not xianmengModel:hasXM()then
UIManager.error(cfgHelper.getlang("haveNotXianMengTips"))
return
end
end

self.selectedChannels[channel]=not self.selectedChannels[channel]
local item=self.channels:getChildLayoutGroupGridItem(index-1)
local tick=self.selectedChannels[channel]or false
item:SetChildActive(_chooseCmp.tick,tick)
item:SetChildActive(_chooseCmp.toggleBg,not tick)
end
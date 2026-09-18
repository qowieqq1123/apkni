







def_class("UIWDCQQFZYWin",UIWindowBase)









function UIWDCQQFZYWin:bindComponents()

self.backCloseBtn=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.bgModel2=UIObject.get(self,2)
self.buffIcon=UIObject.get(self,3)
self.buffInfo=UIText.get(self,4)
self.buffName=UIText.get(self,5)
self.buffTimeInfo=UIText.get(self,6)
self.head=UIObject.get(self,7)
self.loseHead=UIObject.get(self,8)
self.loseModel=UIObject.get(self,9)
self.playerModel=UIObject.get(self,10)
self.playerName=UIText.get(self,11)
self.playerNameBg=UIObject.get(self,12)
self.qfInfo=UIText.get(self,13)
self.qfInfoBg=UIObject.get(self,14)
self.roleInfo=UIObject.get(self,15)
self.Root=UIObject.get(self,16)
self.titleInfo=UIText.get(self,17)
self.uiRoot=UIObject.get(self,18)

self.backCloseBtn:setButtonClick(function()self:onBackCloseBtn()end)



end


function UIWDCQQFZYWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backCloseBtn);self.backCloseBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.buffInfo);self.buffInfo=nil;
_UIObject_release(self.buffName);self.buffName=nil;
_UIObject_release(self.buffTimeInfo);self.buffTimeInfo=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.loseHead);self.loseHead=nil;
_UIObject_release(self.loseModel);self.loseModel=nil;
_UIObject_release(self.playerModel);self.playerModel=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.playerNameBg);self.playerNameBg=nil;
_UIObject_release(self.qfInfo);self.qfInfo=nil;
_UIObject_release(self.qfInfoBg);self.qfInfoBg=nil;
_UIObject_release(self.roleInfo);self.roleInfo=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.titleInfo);self.titleInfo=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIWDCQQFZYWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQQFZYWin:__delete()
self:unbindComponents()
end




function UIWDCQQFZYWin:onShow(argtable,afterOnloaded)




self.group=argtable.group
self.championRoleInfo=argtable.championRoleInfo

self:refreshAll()

self.bgModel:setChildUIModelShowTarget(5573,1,nil,eAnimationID.enter,false,false,0.2,nil)
self.bgModel2:setChildUIModelShowTarget(5572,1,nil,eAnimationID.enter,false,false,0.2,nil)
end


function UIWDCQQFZYWin:onHide()

end

function UIWDCQQFZYWin:refreshAll()
local serverId=self.championRoleInfo.serverId
local championName=self.championRoleInfo.name
local isLose=mathHelper.validInt64(self.championRoleInfo.actorid)and championName==''

local groupName=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,self.group,'name')
local serverName=loginModel:getServerName(serverId)



local titleInfo=FMT.fmt("<color=#7d3b17>[{0}]{1}</color>在问鼎苍穹-{2}夺得冠军\n本域所有祖师获得宗门状态",serverName,championName,groupName)
self.titleInfo:setText(titleInfo)





if not isLose then
playerController:setImage(self.winlua,self.playerModel:getID(),self.championRoleInfo.sex,self.championRoleInfo.iconInfo,playerController:supportDynamic(),0.8)
local headWb=self.head:getWidgetBase()
playerController:setHeadIcon(headWb,-1,{scale=0.7,iconInfo=self.championRoleInfo.iconInfo})
end
self.head:setActive(not isLose)
self.playerModel:setActive(not isLose)
self.loseHead:setActive(isLose)
self.loseModel:setActive(isLose)
serverName=FMT.fmt("[{0}]",serverName)
self.qfInfo:setText(serverName)
self.playerName:setText(playerModel:getOtherActorName(championName))



local buffList=cfgHelper.get3(cfg_wendingcangqiongrankconfig_get,self.group,1,'zm_buff_id')
local isShowBuff=buffList~=nil
if isShowBuff then
local buffid=buffList[1]
local guildstateconfig=cfg_guildstateconfig_get(buffid)
local iconName=iconHelper.getzmStateIcon(guildstateconfig.icon)
self.buffIcon:setIcon(iconName,false)
self.buffName:setText(guildstateconfig.name)
local durationTimeStr=timeHelper.format_time_stamp4(guildstateconfig.duration)
self.buffTimeInfo:setText(FMT.fmt("持续时间：{0}",toColorStringX("#7d3b17",durationTimeStr)))

local desc=homeBuffModel:getBuffDescByStateId(buffid)

desc=string.gsub(desc,'[+-]%d+%%',function(s)return toColorStringX("#549327",s)end)

self.buffInfo:setText(desc)
else
logErr(FMT.fmt("WDCQ group [{0}] zm_buff_id is nil",self.group))
end

end





function UIWDCQQFZYWin:onBackCloseBtn()
self:closeSelf()
end


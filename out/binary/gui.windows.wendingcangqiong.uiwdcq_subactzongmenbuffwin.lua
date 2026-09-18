







def_class("UIWDCQ_SubActZongMenBuffWin",UIWindowBase)









function UIWDCQ_SubActZongMenBuffWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.buffDurationTime=UIText.get(self,1)
self.buffIcon=UIObject.get(self,2)
self.buffName=UIText.get(self,3)
self.buffStateDesc=UIText.get(self,4)
self.buffStateList=UIObject.get(self,5)
self.head=UIObject.get(self,6)
self.loseHead=UIObject.get(self,7)
self.loserModel=UIObject.get(self,8)
self.nameTxt=UIText.get(self,9)
self.playerModel=UIObject.get(self,10)
self.Root=UIObject.get(self,11)
self.serverTxt=UIText.get(self,12)
self.sloganTxt=UIText.get(self,13)
self.uiRoot=UIObject.get(self,14)



end


function UIWDCQ_SubActZongMenBuffWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.buffDurationTime);self.buffDurationTime=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.buffName);self.buffName=nil;
_UIObject_release(self.buffStateDesc);self.buffStateDesc=nil;
_UIObject_release(self.buffStateList);self.buffStateList=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.loseHead);self.loseHead=nil;
_UIObject_release(self.loserModel);self.loserModel=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.playerModel);self.playerModel=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.serverTxt);self.serverTxt=nil;
_UIObject_release(self.sloganTxt);self.sloganTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIWDCQ_SubActZongMenBuffWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQ_SubActZongMenBuffWin:__delete()
self:unbindComponents()
end




function UIWDCQ_SubActZongMenBuffWin:onShow(argtable,afterOnloaded)


self.championRoleInfo=WDCQController.getQuFuZYRoleInfo()




self.group=self.championRoleInfo.groupId


local roleInfo=WDCQModel:getRankRoleInfoLookUp(self.championRoleInfo.actorid)
local isLose=mathHelper.validInt64(self.championRoleInfo.actorid)and roleInfo.name==''




self.loseHead:setActive(isLose)
self.loserModel:setActive(isLose)
self.playerModel:setActive(not isLose)
self.head:setActive(not isLose)




if not isLose then
playerController:setImage(self.winlua,self.playerModel:getID(),roleInfo.sex,roleInfo.iconInfo,playerController:supportDynamic(),0.6)
playerController:setHeadIcon(self.winlua,self.head:getID(),{scale=0.7,iconInfo=roleInfo.iconInfo})
end

local serverId=roleInfo.serverId
local championName=playerModel:getOtherActorName(roleInfo.name)
local serverName=loginModel:getServerName(serverId)

local groupName=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,self.group,'name')
local playerInfoStr=FMT.fmt("[{0}]{1}",serverName,championName)
local sloganTxt=FMT.fmt("{0}在问鼎苍穹-{1}夺得冠军\n本域所有祖师获得宗门状态",toColorStringX("#f1ce78",playerInfoStr),groupName)

self.sloganTxt:setText(sloganTxt)
self.serverTxt:setText(serverName)
self.nameTxt:setText(championName)

local buffList=cfgHelper.get3(cfg_wendingcangqiongrankconfig_get,self.group,1,'zm_buff_id')
local isShowBuff=buffList~=nil
if isShowBuff then
local buffid=buffList[1]
local guildstateconfig=cfg_guildstateconfig_get(buffid)
local iconName=iconHelper.getzmStateIcon(guildstateconfig.icon)
self.buffIcon:setIcon(iconName,false)
self.buffName:setText(guildstateconfig.name)
local durationTimeStr=timeHelper.format_time_stamp4(guildstateconfig.duration)
self.buffDurationTime:setText(FMT.fmt("持续时间：<color=#7d3b17>{0}</color>",durationTimeStr))

local desc=homeBuffModel:getBuffDescByStateId(buffid)

desc=string.gsub(desc,'[+-]%d+%%',function(s)return toColorStringX("#549327",s)end)


self.buffStateDesc:setText(desc)
else
logErr(FMT.fmt("WDCQ group [{0}] zm_buff_id is nil",self.group))
end

self.bgModel:setChildUIModelShowTarget(5577,1,nil,eAnimationID.stand)
end


function UIWDCQ_SubActZongMenBuffWin:onHide()

end



function UIWDCQ_SubActZongMenBuffWin:getTestData()

local tt={}

tt.actorid=playerModel:getActorID()
tt.groupId=1
tt.rank=1
tt.isReceive=false



return tt
end
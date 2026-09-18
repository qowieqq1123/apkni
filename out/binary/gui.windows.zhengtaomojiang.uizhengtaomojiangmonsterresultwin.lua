







def_class("UIZhengTaoMoJiangMonsterResultWin",UIWindowBase)









function UIZhengTaoMoJiangMonsterResultWin:bindComponents()

self.background=UIButton.get(self,0)
self.buffTx=UIText.get(self,1)
self.head=UIObject.get(self,2)
self.headBG=UIButton.get(self,3)
self.headEmpty=UIObject.get(self,4)
self.killTime=UIText.get(self,5)
self.leftBtn=UIButton.get(self,6)
self.monsterName=UIText.get(self,7)
self.playerName=UIText.get(self,8)
self.rewardBtn=UIButton.get(self,9)
self.rightBtn=UIButton.get(self,10)
self.serverName=UIText.get(self,11)
self.xmBGIcon=UIButton.get(self,12)
self.xmEmpty=UIObject.get(self,13)
self.xmIcon=UIImage.get(self,14)
self.xmKuangIcon=UIImage.get(self,15)
self.xmName=UIText.get(self,16)

self.background:setButtonClick(function()self:onBackground()end)

self.headBG:setButtonClick(function()self:onHeadBG()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.xmBGIcon:setButtonClick(function()self:onXmBGIcon()end)



end


function UIZhengTaoMoJiangMonsterResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.buffTx);self.buffTx=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBG);self.headBG=nil;
_UIObject_release(self.headEmpty);self.headEmpty=nil;
_UIObject_release(self.killTime);self.killTime=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.serverName);self.serverName=nil;
_UIObject_release(self.xmBGIcon);self.xmBGIcon=nil;
_UIObject_release(self.xmEmpty);self.xmEmpty=nil;
_UIObject_release(self.xmIcon);self.xmIcon=nil;
_UIObject_release(self.xmKuangIcon);self.xmKuangIcon=nil;
_UIObject_release(self.xmName);self.xmName=nil;
end















local _this=nil



function UIZhengTaoMoJiangMonsterResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIZhengTaoMoJiangMonsterResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UIZhengTaoMoJiangMonsterResultWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

self:updateData()
self:refreshView()
end


function UIZhengTaoMoJiangMonsterResultWin:onHide()

end




function UIZhengTaoMoJiangMonsterResultWin:onBackground()
self:closeSelf()
end


function UIZhengTaoMoJiangMonsterResultWin:onHeadBG()
if mathHelper.validInt64(self.entityData.actor_id)then
otherPlayerController:openOtherPlayerInfoWin(self.entityData.actor_id,nil,nil,{serverid=mojiangData.actor_server,isXianJie=true})
end
end


function UIZhengTaoMoJiangMonsterResultWin:onRewardBtn()
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIZhengTaoMoJiangMonsterStateWin",args)
end

function UIZhengTaoMoJiangMonsterResultWin:onXmBGIcon()
if mathHelper.validInt64(self.entityData.guildID)then
local wincfg=UIManager.get_window_config(self.__name)
xianmengController:openXMDetailInfoWin(self.entityData.guildID,wincfg.canvas+1)
end
end

function UIZhengTaoMoJiangMonsterResultWin:updateData()
self.entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
self.sortData=xianjieModel:getMoJiangSortList(self.seasonType,self.stageIndex)
for i,v in ipairs(self.sortData)do
if v.id==self.build_id then
self.sortIndex=i
break
end
end
end

function UIZhengTaoMoJiangMonsterResultWin:onLeftBtn()
self.sortIndex=self.sortIndex-1
if self.sortIndex<0 then
self.sortIndex=#self.sortData
end
self.build_id=self.sortData[self.sortIndex].id
self.entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
self:refreshView()
end

function UIZhengTaoMoJiangMonsterResultWin:onRightBtn()
self.sortIndex=self.sortIndex+1
if self.sortIndex>#self.sortData then
self.sortIndex=1
end
self.build_id=self.sortData[self.sortIndex].id
self.entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
self:refreshView()
end

function UIZhengTaoMoJiangMonsterResultWin:refreshView()
if mathHelper.validInt64(self.entityData.guildID)then
self.xmEmpty:setActive(false)
self.xmBGIcon:setActive(true)
self.xmName:setText(self.entityData.guildName)

local image=xianmengModel.splitGuildIcon(self.entityData.guildicon)
local abname=globalABLookup.xianmengicons
self.xmIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
self.xmBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
self.xmKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
self.xmEmpty:setActive(true)
self.xmBGIcon:setActive(false)
self.xmName:setText("——")
end

if mathHelper.validInt64(self.entityData.actorId)then
self.headEmpty:setActive(false)
playerController:setHeadIcon(self.winlua,self.head:getID(),{infoInfo=self.entityData.infoIcon})
self.playerName:setText(self.entityData.actorName)
self.serverName:setText(loginModel:getServerName(self.entityData.serverId))
else
self.headEmpty:setActive(true)
playerController:setHeadIcon(self.winlua,self.head:getID(),nil)
self.playerName:setText("")
self.serverName:setText("")
end

local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
local str=FMt.fmt("斩杀{0}时刻",buildCfg.name)
self.monsterName:setText(str)
self.killTime:setText(timeHelper.getFormatByShortStamp3(self.entityData.killTime))
end
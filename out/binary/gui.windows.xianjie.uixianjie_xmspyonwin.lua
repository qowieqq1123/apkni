







def_class("UIXianJie_XMSpyOnWin",UIWindowBase)









function UIXianJie_XMSpyOnWin:bindComponents()

self.buttonPanel=UIObject.get(self,0)
self.clickMask=UIButton.get(self,1)
self.costCount=UILinkImageText.get(self,2)
self.guildBG=UIButton.get(self,3)
self.guildIcon=UIImage.get(self,4)
self.guildKuangIcon=UIImage.get(self,5)
self.mbg=UIObject.get(self,6)
self.nameTx=UIText.get(self,7)
self.oldTimeText=UIText.get(self,8)
self.posText=UILinkImageText.get(self,9)
self.searchBtn=UIButton.get(self,10)
self.seeBtn=UIButton.get(self,11)
self.serverTx=UIText.get(self,12)
self.timeText=UIText.get(self,13)
self.tipsText=UIText.get(self,14)
self.titleName=UIText.get(self,15)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.guildBG:setButtonClick(function()self:onGuildBG()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.seeBtn:setButtonClick(function()self:onSeeBtn()end)



end


function UIXianJie_XMSpyOnWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buttonPanel);self.buttonPanel=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.guildBG);self.guildBG=nil;
_UIObject_release(self.guildIcon);self.guildIcon=nil;
_UIObject_release(self.guildKuangIcon);self.guildKuangIcon=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.oldTimeText);self.oldTimeText=nil;
_UIObject_release(self.posText);self.posText=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.seeBtn);self.seeBtn=nil;
_UIObject_release(self.serverTx);self.serverTx=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end















local _this=nil



function UIXianJie_XMSpyOnWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJie_XMSpyOnWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UIXianJie_XMSpyOnWin:onShow(argtable,afterOnloaded)
self.guildData=xianjieModel:getXianMengData(argtable.guild)
if self.guildData==nil then
self:onClickMask()
return
end

local gridX,gridZ=self.guildData:getCenterGridPosFloor()
local pos_str=FMT.fmt('(X:{0},Y:{1})',gridX,gridZ)
self.posText:setText(pos_str)
self.nameTx:setText(self.guildData.guildname)
self.serverTx:setText(loginModel:getServerName(self.guildData.serverid))
local image=xianmengModel.splitGuildIcon(self.guildData.guildicon)
self.guildIcon:setSprite(globalABLookup.xianmengicons,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
self.guildBG:setSprite(globalABLookup.xianmengicons,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
self.guildKuangIcon:setSprite(globalABLookup.xianmengicons,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
local costs=order[xjOrderType.eLook][4]
local s=FMT.fmt('消耗：{0}quad-icon={1}-quad',costs[1][2],iconHelper.getIconName(costs[1][1]))
self.costCount:setText(s)

local time_str=timeHelper.format_time_stamp3(self.guildData:getBaseWayTime())
self.timeText:setText(time_str)

local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
local nowTime=timeHelper.getServerShortTime()
local logData=xianjieModel:Get_searchLogLookup2(self.guildData.guildid)
local spyTime=logData and logData.sec or 0
local left=nowTime-spyTime
self.seeBtn:setActive(left<maxTime)
if left<maxTime then
self.oldTimeText:setText(FMT.fmt("上次侦查:{0}",timeHelper.format_time_stamp14(left)))
self:startCDTick(spyTime+maxTime)
else
self:stopCDTick()
end


self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6011,1,nil,eAnimationID.stand,false,false,0,nil)
end


function UIXianJie_XMSpyOnWin:onHide()

end




function UIXianJie_XMSpyOnWin:onClickMask()
self:closeSelf()
end


function UIXianJie_XMSpyOnWin:onGuildBG()
xianmengController:openXMDetailInfoWin(self.guildData.guildid)
end


function UIXianJie_XMSpyOnWin:onSearchBtn()
local flag,g_list,errorParams=self.guildData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法侦查本阵内的其他仙盟"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法侦查阵外的仙盟"
else

errStr="处于本阵内无法侦查其他本阵内的其他仙盟"
end
UIManager.error(errStr)
end
return
end

local orderType=xjOrderType.eLook
local timeStr=timeHelper.format_time_stamp3(self.guildData:getBaseWayTime())
local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
local costs=order[orderType][4]
local itemName=itemsConfig.getItemName(costs[1][1])
local itemNum=costs[1][2]
local content=FMT.fmt('是否花费{0}{1}前往侦查\n【{2}】堡垒的驻守情报？\n<color=#549327>立即获得情报</color>',itemNum,itemName,self.guildData.guildname)
local guildId=self.guildData.guildid
UIDialogManager.getCommonDialog(nil,content,function()
if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end
local have=itemsModel.getCount(costs[1][1])
if have<costs[1][2]then
gainControl:showGainWin(costs[1][1])
UIManager.error('消耗不足')
return
end
xianjieController:reqOrder(guildId,orderType,{},{},"",nil,nil,g_list)
_this:onClickMask()
end)
end


function UIXianJie_XMSpyOnWin:onSeeBtn()
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
local nowTime=timeHelper.getServerShortTime()
local logData=xianjieModel:Get_searchLogLookup2(self.guildData.guildid)
local spyTime=logData and logData.sec or 0
local left=nowTime-spyTime
if left>=maxTime then
UIManager.error('侦查信息已过期，请重新侦查')
return
end
local garrison=xianjieModel:getXianMengGarrison(self.guildData.guildid)
if garrison==nil or(nowTime-garrison.serverTime)>=maxTime then
xianjieController:send_35_43(logData.guid)
end
local winArgs={
guild=self.guildData.guildid
}
UIManager:showWindow("UIXianJie_XMBLDefendInfoWin",winArgs)
_this:onClickMask()
end

function UIXianJie_XMSpyOnWin:stopCDTick()
self.cdTime=nil
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXianJie_XMSpyOnWin:startCDTick(time)
self.cdTime=time
if self.cdTick==nil then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXianJie_XMSpyOnWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.cdTime then
self.seeBtn:setActive(false)
self:stopCDTick()
else
local left=self.cdTime-nowTime
self.oldTimeText:setText(FMT.fmt("上次侦查:{0}",timeHelper.format_time_stamp14(left)))
end
end
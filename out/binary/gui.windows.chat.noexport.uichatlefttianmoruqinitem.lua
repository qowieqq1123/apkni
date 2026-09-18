







def_class("UIChatLeftTianMoRuQinItem",UICloneObject)





UIChatLeftTianMoRuQinItem.abName=""

UIChatLeftTianMoRuQinItem.assetName="UIChatLeftTianMoRuQinItem"


function UIChatLeftTianMoRuQinItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.headBg=UIButton.get(self,1)
self.head=UIObject.get(self,2)
self.name=UIText.get(self,3)
self.bg=UIButton.get(self,4)
self.descBg=UIImage.get(self,5)
self.descTx=UIText.get(self,6)
self.symbol=UIImage.get(self,7)
self.bottombg=UIImage.get(self,8)
self.Image1=UIImage.get(self,9)
self.monsterImage=UIObject.get(self,10)
self.monsterName=UIText.get(self,11)
self.monsterJingjie=UIText.get(self,12)
self.time=UIText.get(self,13)

self.headBg:setButtonClick(function()self:onHeadBg()end)

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatLeftTianMoRuQinItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.symbol);self.symbol=nil;
_UIObject_release(self.bottombg);self.bottombg=nil;
_UIObject_release(self.Image1);self.Image1=nil;
_UIObject_release(self.monsterImage);self.monsterImage=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.monsterJingjie);self.monsterJingjie=nil;
_UIObject_release(self.time);self.time=nil;
end









function UIChatLeftTianMoRuQinItem:onLoaded(...)
self:bindComponents()
self.symbol:setSprite(globalABLookup.tianmoruqinsprite,'image_qingbao_1')
self.bottombg:setSprite(globalABLookup.tianmoruqinsprite,'frame_jiugp_04')
self.Image1:setSprite(globalABLookup.tianmoruqinsprite,'image_ltfenxiangui_5')
self.descBg:setSprite(globalABLookup.tianmoruqinsprite,'image_lthuodongtp_1')
self.widget:SetChildCSImageSprite(self.bg:getID(),globalABLookup.tianmoruqinsprite,'frame_zjmkuang_7')
end


function UIChatLeftTianMoRuQinItem:__delete()
self:unbindComponents()
end




function UIChatLeftTianMoRuQinItem:onShow(argtable,afterOnloaded)
local widget=self.widget
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local isSelf=chatInfo:isSelfActor()
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId
local chatId=actorInfo.chatId
local iconInfo=actorInfo.iconInfo

local timeFlag=chatInfo.timeFlag or false
self.timeFlag=timeFlag
self.timeRoot:setActive(timeFlag)
if timeFlag then
local txt=''
if timeHelper.isTodayStamp(timeStamp)then
txt=timeHelper.getTwoFormatByStamp(timeStamp)
else
txt=timeHelper.getFourFormatByStamp(timeStamp)
end
self.time:setText(txt)
end

if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'{0}',actorName))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}]{1}',loginModel:getServerName(serverId),actorName))
end

playerController:setRawImageHeadIcon(self.widget,self.head:getID(),{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildButtonClick(self.headBg:getID(),function()
local attach=nil
if channelId==CHAT_CHANNNEL.eKuafu then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)

local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
if regexType and regexInfo then
self.regexData=chatEmotHelper.getTMRQInfoByRegex(regexInfo)
local modelParams=comHelper.getMonsterGroupModelParams(self.regexData.monsterId)
comHelper.setChildModelRawImageEx(self.monsterImage:getID(),self.widget,modelParams,eHeadCenterType.eFullBody,nil,false)

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.regexData.monsterId)
self.monsterName:setText(monsterCfg and monsterCfg.name or"")
self.monsterJingjie:setText(UIDiscipleModel:getJJName3(self.regexData.monsterLevel))
end

self:freshRect()
end


function UIChatLeftTianMoRuQinItem:onHide()

end




function UIChatLeftTianMoRuQinItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=225
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

function UIChatLeftTianMoRuQinItem:onBg()
local info=activitiesModel:getSubActInfo(self.regexData.actId,SUB_ACTIVITY_TYPE.eTianMoRuQin,self.regexData.subId)
if info and info:checkDoing()then

call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterDetail",self.regexData.actId,self.regexData.subId,self.regexData.monsterGuid,0)
else
UIManager.error("您所在的服不在活动期间，暂无法参与")
end
end

function UIChatLeftTianMoRuQinItem:onHeadBg()

end
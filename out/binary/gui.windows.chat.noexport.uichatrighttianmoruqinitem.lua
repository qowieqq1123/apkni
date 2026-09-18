







def_class("UIChatRightTianMoRuQinItem",UICloneObject)





UIChatRightTianMoRuQinItem.abName=""

UIChatRightTianMoRuQinItem.assetName="UIChatRightTianMoRuQinItem"


function UIChatRightTianMoRuQinItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.descBg=UIImage.get(self,1)
self.descTx=UIText.get(self,2)
self.symbol=UIImage.get(self,3)
self.bottombg=UIImage.get(self,4)
self.Image1=UIImage.get(self,5)
self.monsterImage=UIObject.get(self,6)
self.monsterName=UIText.get(self,7)
self.monsterJingjie=UIText.get(self,8)
self.head=UIObject.get(self,9)
self.name=UIText.get(self,10)
self.bg=UIButton.get(self,11)
self.time=UIText.get(self,12)

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatRightTianMoRuQinItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.symbol);self.symbol=nil;
_UIObject_release(self.bottombg);self.bottombg=nil;
_UIObject_release(self.Image1);self.Image1=nil;
_UIObject_release(self.monsterImage);self.monsterImage=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.monsterJingjie);self.monsterJingjie=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.time);self.time=nil;
end









function UIChatRightTianMoRuQinItem:onLoaded(...)
self:bindComponents()
self.symbol:setSprite(globalABLookup.tianmoruqinsprite,'image_qingbao_1')
self.bottombg:setSprite(globalABLookup.tianmoruqinsprite,'frame_jiugp_03')
self.Image1:setSprite(globalABLookup.tianmoruqinsprite,'image_ltfenxiangui_5')
self.descBg:setSprite(globalABLookup.tianmoruqinsprite,'image_lthuodongtp_1')
self.widget:SetChildCSImageSprite(self.bg:getID(),globalABLookup.tianmoruqinsprite,'frame_zjmkuang_6')
end


function UIChatRightTianMoRuQinItem:__delete()
self:unbindComponents()
end




function UIChatRightTianMoRuQinItem:onShow(argtable,afterOnloaded)
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

local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
if regexType and regexInfo then
self.regexData=chatEmotHelper.getTMRQInfoByRegex(regexInfo)
local modelParams=comHelper.getMonsterGroupModelParams(self.regexData.monsterId)
comHelper.setChildModelRawImageEx(self.monsterImage:getID(),self.widget,modelParams,eHeadCenterType.eFullBody,nil,false)

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.regexData.monsterId)
self.monsterName:setText(monsterCfg and monsterCfg.name or nil)
self.monsterJingjie:setText(UIDiscipleModel:getJJName3(self.regexData.monsterLevel))
end

self:freshRect()
end


function UIChatRightTianMoRuQinItem:onHide()

end



function UIChatRightTianMoRuQinItem:onBg()
local info=activitiesModel:getSubActInfo(self.regexData.actId,SUB_ACTIVITY_TYPE.eTianMoRuQin,self.regexData.subId)
if info and info:checkDoing()then

local args={
subType=SUB_ACTIVITY_TYPE.eTianMoRuQin,
subid=self.regexData.subId,
extraParams={
tab_idx=activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main),
}
}
jumpManager:jump({id=JUMP_TYPE.eActivity,args=args})
else
UIManager.error("您所在的服不在活动期间，暂无法参与")
end
end

function UIChatRightTianMoRuQinItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=214
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end
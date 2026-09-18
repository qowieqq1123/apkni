







def_class("UIChatRightChildItem",UICloneObject)





UIChatRightChildItem.abName="ui/windows/chat/child/uichatrightchilditemex.ab"

UIChatRightChildItem.assetName="UIChatRightChildItem"


function UIChatRightChildItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.time=UIText.get(self,1)
self.head=UIObject.get(self,2)
self.name=UIText.get(self,3)
self.signGrid=UIObject.get(self,4)
self.effectRoot=UIObject.get(self,5)
self.modeTopRight=UIObject.get(self,6)
self.modeTopLeft=UIObject.get(self,7)
self.modeBottomRight=UIObject.get(self,8)
self.modeBottomLeft=UIObject.get(self,9)
self.bg=UIImage.get(self,10)
self.mesg=UILinkImageText.get(self,11)
self.layout=UIObject.get(self,12)
self.mesg1=UIText.get(self,13)

end


function UIChatRightChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.signGrid);self.signGrid=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.modeTopRight);self.modeTopRight=nil;
_UIObject_release(self.modeTopLeft);self.modeTopLeft=nil;
_UIObject_release(self.modeBottomRight);self.modeBottomRight=nil;
_UIObject_release(self.modeBottomLeft);self.modeBottomLeft=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.mesg);self.mesg=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.mesg1);self.mesg1=nil;
end










local _layoutWidth=375
local _layoutPosX=10
local _layoutPosY=-10
local _maxMsgSize=355
local _minMsgSize=30
function UIChatRightChildItem:onLoaded(...)
self:bindComponents()



end


function UIChatRightChildItem:__delete()

self:unbindComponents()
end




function UIChatRightChildItem:onShow(argtable,afterOnloaded)
self:stopAllTimer()
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local isVoice=chatInfo.isVoice
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local actorInfo=chatInfo.actorInfo
if actorInfo==nil then
loggerUtil.logErrFMT('没有找到发出消息的对象信息! msg：{0}',tostring(mesg))
end
actorInfo=actorInfo or{}
actorInfo.args=actorInfo.args or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId
local chatId=actorInfo.chatId or 1
local iconInfo=actorInfo.iconInfo
local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo

local chatBgCfg=cfg_bubbleframeconfig_get(chatId)


local offset=chatBgCfg.offsetsend
self.offsetY=0
self.offsetX=0
if offset then
self.offsetX=offset[1]or 0
self.offsetY=offset[2]or 0
end


local bgoffset=chatBgCfg.bgoffsetsend
self.bgoffsetX=0
self.bgoffsetY=0
self.bgCenoffsetX=0
self.bgCenoffsetY=0
if bgoffset then
self.bgoffsetX=bgoffset[1]or 0
self.bgoffsetY=bgoffset[2]or 0
self.bgCenoffsetX=bgoffset[3]or 0
self.bgCenoffsetY=bgoffset[4]or 0
end
self.widget:SetChildAttachRectThreeOffset(self.mesg:getID(),
self.bgoffsetX,self.bgoffsetY,self.bgCenoffsetX,self.bgCenoffsetY)


local bgIconName=chatBgCfg.icon
self.bg:setImageIcon(iconHelper.getChatKuangIcon(bgIconName),false)


local bgmodel=chatBgCfg.model
local scale=1
local offsetValue=5
local spineOffsetY=chatBgCfg.spineOffsetY or 0
if bgmodel then
local topright=bgmodel.topright
if topright then
local model=topright
self.widget:SetChildUIModelEnableInitUISpinePara(self.modeTopRight:getID(),false,true)
self.widget:SetChildUIModelShowTarget(self.modeTopRight:getID(),model,scale,{},eAnimationID.stand)
self.widget:SetChildLocalPos(self.modeTopRight:getID(),-offsetValue,-offsetValue,0)
end
local topleft=bgmodel.topleft
if topleft then
local model=topleft
self.widget:SetChildUIModelEnableInitUISpinePara(self.modeTopLeft:getID(),false,true)
self.widget:SetChildUIModelShowTarget(self.modeTopLeft:getID(),model,scale,{},eAnimationID.stand)
self.widget:SetChildLocalPos(self.modeTopLeft:getID(),offsetValue,-offsetValue,0)
end
local bottomright=bgmodel.bottomright
if bottomright then
local model=bottomright
self.widget:SetChildUIModelEnableInitUISpinePara(self.modeBottomRight:getID(),false,true)
self.widget:SetChildUIModelShowTarget(self.modeBottomRight:getID(),model,scale,{},eAnimationID.stand)
self.widget:SetChildLocalPos(self.modeBottomRight:getID(),-offsetValue,offsetValue+spineOffsetY,0)
end
local bottomleft=bgmodel.bottomleft
if bottomleft then
local model=bottomleft
self.widget:SetChildUIModelEnableInitUISpinePara(self.modeBottomLeft:getID(),false,true)
self.widget:SetChildUIModelShowTarget(self.modeBottomLeft:getID(),model,scale,{},eAnimationID.stand)
self.widget:SetChildLocalPos(self.modeBottomLeft:getID(),offsetValue,offsetValue+spineOffsetY,0)
end
else
self.widget:SetChildUIModelRemoveTarget(self.modeTopRight:getID())
self.widget:SetChildUIModelRemoveTarget(self.modeTopLeft:getID())
self.widget:SetChildUIModelRemoveTarget(self.modeBottomRight:getID())
self.widget:SetChildUIModelRemoveTarget(self.modeBottomLeft:getID())
end


local timeStr=timeHelper.dateServerStamp('[%m-%d %H:%M:%S]',timeStamp)

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

if channelId~=CHAT_CHANNNEL.eKuafu and channelId~=CHAT_CHANNNEL.eBattleField and channelId~=CHAT_CHANNNEL.eSeasonZZSH then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[我]'))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}][我]',loginModel:getServerName(serverId),actorName))
end

playerController:setRawImageHeadIcon(self.widget,self.head:getID(),{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
local chatFlag=actorInfo.args.chatFlag or{}

local len=#chatFlag
self.signGrid:setChildLayoutGroupCreateItems(len)
local items=self.signGrid:getChildLayoutGroupGridList()
for i=1,len do
local item=items[i-1]
local flag=chatFlag[i]
local isShow=flag>0
item:SetChildActive(-1,isShow)

if isShow then
local flagCfg=cfgHelper.get1(cfg_chatflagconfig_get,chatFlag[i])
item:SetChildActive(1,flagCfg.showType==2)
if flagCfg.showType==1 then
local icon=chatModel:getSignIcon(flagCfg.icon)
if icon then
item:SetChildIcon(0,icon,true)
end
elseif flagCfg.showType==2 then
item:SetChildText(3,flagCfg.name)
local icon=chatModel:getSignIcon(flagCfg.icon)
if icon then
item:SetChildIcon(0,icon,true)
end
if flagCfg.spriteAnimation then
item:SetChildAnimationStringID(2,flagCfg.spriteAnimation)
end
end
end
end


local mgMinSize=chatBgCfg.minSizeSend or{0,0}
local minSizeX=mgMinSize[1]
local minSizeY=mgMinSize[2]
local maxSize=_maxMsgSize


if string.find(mesg,"<#SHARE_ROLEINFO=(.*)>")~=nil or
regexType==CHAT_REGEX_TYPE.eSharedz then
mesg="[弟子分享]"
elseif regexType==CHAT_REGEX_TYPE.eShareLingShou then
mesg="[灵兽分享]"
elseif regexType==CHAT_REGEX_TYPE.eZZSHPosShare then
local regexData=chatEmotHelper.getZZSHInfoByRegex(regexInfo)
mesg=zhengzhanshanhaiModel:getShareStr(regexData)
elseif regexType==CHAT_REGEX_TYPE.csFairyLand then
local regexData=chatEmotHelper.getXJInfoByRegex(regexInfo)
mesg=xianjieController:getShareLTStr(regexData)
elseif regexType==CHAT_REGEX_TYPE.csPuTongZhenJi then
local regexData=chatEmotHelper.getPTZJInfoByRegex(regexInfo)
mesg=xianjieController:getShareLTStr(regexData)
end

self.mesg:setText(FMT.cfmt(FONT_COLOR.eNomalColor,mesg))


local sizeX=self.widget:GetChildPreferredSize(self.mesg:getID(),0)


local dSize1=self.bgoffsetX
local dSize2=self.bgoffsetX+self.offsetX
if dSize2>0 then
maxSize=_maxMsgSize-dSize2
end

if sizeX<minSizeX then
sizeX=minSizeX
self.widget:SetChildTextAlignment(self.mesg:getID(),4)
else
if sizeX>maxSize then
sizeX=maxSize
end
self.widget:SetChildTextAlignment(self.mesg:getID(),3)
end


self.widget:SetChildLayoutElementMinHeight(self.mesg:getID(),minSizeY)

self.widget:SetChildSizeWithCurrentAnchors(self.mesg:getID(),0,sizeX)

self.widget:SetChildAttachRectThreeOffset(self.mesg:getID(),
self.bgoffsetX,self.bgoffsetY,self.bgCenoffsetX,self.bgCenoffsetY,1)

self.widget:SetChildAttachRectThreeOffset(self.mesg:getID(),
self.bgoffsetX,self.bgoffsetY,self.bgCenoffsetX,self.bgCenoffsetY,2)

self.widget:SetChildSizeDelta(self.layout:getID(),_layoutWidth-dSize2,0)
self.widget:SetChildAnchoredPos(self.layout:getID(),
_layoutPosX+dSize1,_layoutPosY-self.offsetY)
self.widget:ForceLayoutVertical(self.layout:getID())


self.widget:ForceLayoutVertical(self.mesg:getID())

self:freshRect()
end

function UIChatRightChildItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local sizeY=self.widget:GetChildSizeDeltaY(self.mesg:getID())
local timeY=0
if self.timeFlag then timeY=35 end
local topY=45
local msgY=sizeY+self.bgoffsetY+self.offsetY
local tSize=timeY+topY+msgY+30
self.widget:SetChildSizeWithCurrentAnchors(-1,1,tSize)
end










function UIChatRightChildItem:onHide()

end



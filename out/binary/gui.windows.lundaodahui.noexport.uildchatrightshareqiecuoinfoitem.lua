







def_class("UILDChatRightShareQieCuoInfoItem",UICloneObject)





UILDChatRightShareQieCuoInfoItem.abName=""

UILDChatRightShareQieCuoInfoItem.assetName="UILDChatRightShareQieCuoInfoItem"


function UILDChatRightShareQieCuoInfoItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.head=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.bg=UIObject.get(self,3)
self.discipleinfo=UIButton.get(self,4)
self.time=UIText.get(self,5)
self.default=UIButton.get(self,6)
self.bgteo=UIObject.get(self,7)
self.myplayer=UIObject.get(self,8)
self.otherplayer=UIObject.get(self,9)
self.myname=UIText.get(self,10)
self.myseverid=UIText.get(self,11)
self.othername=UIText.get(self,12)
self.otherseverid=UIText.get(self,13)
self.btnzhanbao=UIButton.get(self,14)
self.winnerimg=UIObject.get(self,15)
self.loseimg=UIObject.get(self,16)

self.discipleinfo:setButtonClick(function()self:onDiscipleinfo()end)

self.default:setButtonClick(function()self:onDefault()end)

self.btnzhanbao:setButtonClick(function()self:onBtnzhanbao()end)

end


function UILDChatRightShareQieCuoInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.discipleinfo);self.discipleinfo=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.default);self.default=nil;
_UIObject_release(self.bgteo);self.bgteo=nil;
_UIObject_release(self.myplayer);self.myplayer=nil;
_UIObject_release(self.otherplayer);self.otherplayer=nil;
_UIObject_release(self.myname);self.myname=nil;
_UIObject_release(self.myseverid);self.myseverid=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.otherseverid);self.otherseverid=nil;
_UIObject_release(self.btnzhanbao);self.btnzhanbao=nil;
_UIObject_release(self.winnerimg);self.winnerimg=nil;
_UIObject_release(self.loseimg);self.loseimg=nil;
end







local this


function UILDChatRightShareQieCuoInfoItem:onLoaded(...)
self:bindComponents()
this=self
end


function UILDChatRightShareQieCuoInfoItem:__delete()
self:unbindComponents()
end




function UILDChatRightShareQieCuoInfoItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local mesg=chatInfo.mesg
local isSelf=chatInfo:isSelfActor()
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId
local iconInfo=actorInfo.iconInfo



















if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[我]'))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}][我]',loginModel:getServerName(serverId),actorName))
end








local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
local discipleData
local qiecuoData
if regexType and regexInfo then
qiecuoData=chatEmotHelper.getDZQieCuoInfoByRegex(regexInfo)
this.qiecuoData=qiecuoData
else

end




if false then


local guid=discipleData.guid
local item=self.discipleinfo:getWidgetBase()

local image=UIDiscipleModel.calculationDiscipleImageBase(discipleData)
local color=image.color

item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconName(discipleData.job)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=netData.id and UIDiscipleModel:isSPDisciple(discipleData.id)or false
item:SetChildActive(29,isSpDz)

item:SetChildText(2,discipleData.name)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(3,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(discipleData.level)
item:SetChildText(5,lv_str)
if self.sortType==eDiscipleSortType.eJingJieSort then

item:SetChildActive(6,false)

local jjlv=discipleData.level
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(4,jj_str)




















else

item:SetChildActive(6,true)
item:SetChildText(6,discipleData.fightvalue)

item:SetChildText(4,'')
end

































local data=UIDiscipleModel:getDiscipleDataX(guid)

















local tmlv=discipleData.tmlv
local isshow=tmlv>0
item:SetChildActive(19,isshow)
if isshow then
local widget=item:GetChildWidgetBase(19)
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
widget:SetChildLayoutGroupCreateItems(0,chong)
local grids=widget:GetChildLayoutGroupGridList(0)
for i=1,chong do
local fireItem=grids[i-1]
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
fireItem:SetChildCSImageSprite(0,abName,iconName)
end
end


if data then
local data=otherPlayerModel.discipleStruct_to_discipleStruct3(data.netData.net)
otherPlayerModel:addDZData(actorID,data,false)
end
else







end

if regexType and regexInfo then

local iconInfo={piList=qiecuoData.mypiList}
local playerImage=iconInfo.piList
if playerImage==nil or next(playerImage)==nil then
playerImage=playerImageModel:getPlayerImage()

end
playerImageController.setPlayerModel(self.widget,8,playerImage,0.4,eAnimationID.idle,0,0)
self.myname:setText(qiecuoData.myname)
local serverName=loginModel:getServerName(qiecuoData.myseverid)
local str=FMT.fmt('[{0}]',serverName)
self.myseverid:setText(str)

local othericonInfo={piList=qiecuoData.otherpiList}
local otherplayerImage=othericonInfo.piList
if otherplayerImage==nil or next(otherplayerImage)==nil then
otherplayerImage=playerImageModel:getDefaultImage(1)

end
playerImageController.setPlayerModel(self.widget,9,otherplayerImage,0.4,eAnimationID.idle,0,0)
self.othername:setText(qiecuoData.othername)
local otherserverName=loginModel:getServerName(qiecuoData.otherseverid)
local otherstr=FMT.fmt('[{0}]',otherserverName)
self.otherseverid:setText(otherstr)

if qiecuoData.fightresult==1 then
self.winnerimg:setActive(true)
self.loseimg:setActive(false)
elseif qiecuoData.fightresult==2 then
self.winnerimg:setActive(false)
self.loseimg:setActive(true)
end




local func=function()

fightController:send_log_list({qiecuoData.zhanbao},{eReplayType=eRePlayerType.diziqiecuo,showBattle=true,showWinTimes=true,data=qiecuoData},true)
end
self.widget:SetChildButtonClick(self.btnzhanbao:getID(),func,true)

self:freshRect()
end
end


function UILDChatRightShareQieCuoInfoItem:onHide()

end

























function UILDChatRightShareQieCuoInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=252
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

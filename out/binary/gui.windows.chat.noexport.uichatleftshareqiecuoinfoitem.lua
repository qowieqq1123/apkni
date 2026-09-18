







def_class("UIChatLeftShareQieCuoInfoItem",UICloneObject)





UIChatLeftShareQieCuoInfoItem.abName="ui/windows/chat/child/uichatleftshareqiecuoinfoitem.ab"

UIChatLeftShareQieCuoInfoItem.assetName="UIChatLeftShareQieCuoInfoItem"


function UIChatLeftShareQieCuoInfoItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.discipleinfo=UIButton.get(self,1)
self.default=UIButton.get(self,2)
self.tianmingObj=UIObject.get(self,3)
self.back=UIImage.get(self,4)
self.rawImage=UIObject.get(self,5)
self.btnzhanbao=UIButton.get(self,6)
self.Image=UIImage.get(self,7)
self.otherseverid=UIText.get(self,8)
self.othername=UIText.get(self,9)
self.Image4=UIImage.get(self,10)
self.myseverid=UIText.get(self,11)
self.myname=UIText.get(self,12)
self.Image3=UIImage.get(self,13)
self.Image2=UIObject.get(self,14)
self.winnerimg=UIImage.get(self,15)
self.Image1=UIImage.get(self,16)
self.loseimg=UIImage.get(self,17)
self.name=UIText.get(self,18)
self.head=UIObject.get(self,19)
self.headBg=UIButton.get(self,20)
self.bgteo=UIObject.get(self,21)
self.bg=UIObject.get(self,22)
self.myplayer=UIObject.get(self,23)
self.otherplayer=UIObject.get(self,24)
self.time=UIText.get(self,25)

self.discipleinfo:setButtonClick(function()self:onDiscipleinfo()end)

self.default:setButtonClick(function()self:onDefault()end)

self.btnzhanbao:setButtonClick(function()self:onBtnzhanbao()end)

self.headBg:setButtonClick(function()self:onHeadBg()end)

end


function UIChatLeftShareQieCuoInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.discipleinfo);self.discipleinfo=nil;
_UIObject_release(self.default);self.default=nil;
_UIObject_release(self.tianmingObj);self.tianmingObj=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.btnzhanbao);self.btnzhanbao=nil;
_UIObject_release(self.Image);self.Image=nil;
_UIObject_release(self.otherseverid);self.otherseverid=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.Image4);self.Image4=nil;
_UIObject_release(self.myseverid);self.myseverid=nil;
_UIObject_release(self.myname);self.myname=nil;
_UIObject_release(self.Image3);self.Image3=nil;
_UIObject_release(self.Image2);self.Image2=nil;
_UIObject_release(self.winnerimg);self.winnerimg=nil;
_UIObject_release(self.Image1);self.Image1=nil;
_UIObject_release(self.loseimg);self.loseimg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.bgteo);self.bgteo=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.myplayer);self.myplayer=nil;
_UIObject_release(self.otherplayer);self.otherplayer=nil;
_UIObject_release(self.time);self.time=nil;
end






local _this=nil



function UIChatLeftShareQieCuoInfoItem:onLoaded(...)
self:bindComponents()
self.tianmingObj:setSprite(globalABLookup.diciplemain,'image_xianjiehdk_1')
self.back:setSprite(globalABLookup.diciplecolorframe,'frame_dzkpchengse')
self.rawImage:setSprite(globalABLookup.dicipleroleinfo,'image_weizhidizi_2')

self.Image:setSprite(globalABLookup.qiecuosprite,'image_ltfenxiangui_9')
self.Image1:setSprite(globalABLookup.qiecuosprite,'image_ltfenxiangui_7')
self.Image2:setSprite(globalABLookup.qiecuosprite,'image_ltfenxiangui_6')
self.Image3:setSprite(globalABLookup.qiecuosprite,'image_ltfenxiangui_8')

self.winnerimg:setSprite(globalABLookup.qiecuosprite,'image_ltfenxiangui_10')
self.loseimg:setSprite(globalABLookup.qiecuosprite,'image_ltfenxiangui_11')
_this=self
end


function UIChatLeftShareQieCuoInfoItem:__delete()
self:unbindComponents()
end




function UIChatLeftShareQieCuoInfoItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local mesg=chatInfo.mesg
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId

local iconInfo=actorInfo.iconInfo

self.chatInfo=chatInfo
self:freshRect()



local timeStr=timeHelper.dateServerStamp('[%m-%d %H:%M:%S]',timeStamp)
local timeFlag=chatInfo.timeFlag or false
self.timeFlag=timeFlag
self.timeRoot:setActive(timeFlag)
local txt=''
if timeFlag then
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








self.widget:SetChildButtonClick(self.headBg:getID(),function()
local attach=nil
if channelId==CHAT_CHANNNEL.eKuafu then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)


local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
local discipleNetData
local qiecuoData
if regexType and regexInfo then
qiecuoData=chatEmotHelper.getDZQieCuoInfoByRegex(regexInfo)
_this.qiecuoData=qiecuoData
local iconInfo={piList=qiecuoData.mypiList}
local playerImage=iconInfo.piList
if playerImage==nil or next(playerImage)==nil then
playerImage=playerImageModel:getPlayerImage()

end
playerImageController.setPlayerModel(self.widget,self.myplayer:getID(),playerImage,0.4,eAnimationID.idle,0,0)
self.myname:setText(qiecuoData.myname)
local serverName=loginModel:getServerName(qiecuoData.myseverid)
local str=FMT.fmt('[{0}]',serverName)
self.myseverid:setText(str)

local othericonInfo={piList=qiecuoData.otherpiList}
local otherplayerImage=othericonInfo.piList
if otherplayerImage==nil or next(otherplayerImage)==nil then
otherplayerImage=playerImageModel:getDefaultImage(1)

end
playerImageController.setPlayerModel(self.widget,self.otherplayer:getID(),otherplayerImage,0.4,eAnimationID.idle,0,0)
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
if not fightModel:haveBattleShow()then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.lthuifang)
fightController:send_log_list({qiecuoData.zhanbao},{eReplayType=eRePlayerType.diziqiecuo,showBattle=true,showWinTimes=true,data=qiecuoData},true)
else
UIManager.info("战斗中无法操作")
end
end
self.widget:SetChildButtonClick(self.btnzhanbao:getID(),func,true)
end

end


function UIChatLeftShareQieCuoInfoItem:onHide()

end

function UIChatLeftShareQieCuoInfoItem:onHeadBg()

end

























function UIChatLeftShareQieCuoInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=252
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

function UIChatLeftShareQieCuoInfoItem:freshDiscipleInfo(otherData,actorID,serverId)

self.default:setActive(otherData==nil)
self.discipleinfo:setActive(otherData~=nil)
if otherData then
local netData=otherData
local guid=netData.guid

local item=self.discipleinfo:getWidgetBase()

local netdata=netData
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)

local color=image.color

item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=netData.id and UIDiscipleModel:isSPDisciple(netData.id)or false
item:SetChildActive(22,isSpDz)

item:SetChildText(2,netdata.name or netdata.disciplename)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(3,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netdata.level)
item:SetChildText(5,lv_str)

item:SetChildActive(6,true)
item:SetChildText(6,tostring(netdata.fightvalue))

item:SetChildText(4,'')


local tmlv=netdata.tmlv
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


local func=function()

local discipleNetData=otherPlayerModel:getDZData(guid)
if discipleNetData then
local args={}
args.dis_guid=guid
args.dislist={discipleNetData}
UIManager:showWindow('UIOtherDiscipleMainWin',args)
else
otherPlayerController:reqCommonInfo(actorID,otherPlayerInfoType.eDZInfoList,{serverid=serverId,guidList={guid}},function(otherData)

local data=otherData.discipleList[1]

if data and(data.flag==0 or data.teamtype==0)then
UIManager.error('弟子信息过期，暂无法查看')
else
local data=otherPlayerModel.detailDisciple_to_discipleStruct3(data)
otherPlayerModel:addDZData(actorID,data,false,true)
local args={}
args.dis_guid=guid
args.dislist={data}
UIManager:showWindow('UIOtherDiscipleMainWin',args)
end
end)
end
end
item:SetChildButtonClick(-1,func,true)
else
local item=self.default:getWidgetBase()
local func=function()
UIManager.error('弟子信息过期，暂无法查看')
end
item:SetChildButtonClick(-1,func,true)
end
end

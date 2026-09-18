







def_class("UIChatLeftShareDiscipleInfoItem",UICloneObject)





UIChatLeftShareDiscipleInfoItem.abName=""

UIChatLeftShareDiscipleInfoItem.assetName="UIChatLeftShareDiscipleInfoItem"


function UIChatLeftShareDiscipleInfoItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.head=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.bg=UIObject.get(self,3)
self.discipleinfo=UIButton.get(self,4)
self.headBg=UIButton.get(self,5)
self.time=UIText.get(self,6)
self.default=UIButton.get(self,7)
self.tianmingObj=UIImage.get(self,8)
self.back=UIImage.get(self,9)
self.rawImage=UIImage.get(self,10)

self.discipleinfo:setButtonClick(function()self:onDiscipleinfo()end)

self.headBg:setButtonClick(function()self:onHeadBg()end)

self.default:setButtonClick(function()self:onDefault()end)

end


function UIChatLeftShareDiscipleInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.discipleinfo);self.discipleinfo=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.default);self.default=nil;
_UIObject_release(self.tianmingObj);self.tianmingObj=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
end






local _this=nil



function UIChatLeftShareDiscipleInfoItem:onLoaded(...)
self:bindComponents()
self.tianmingObj:setSprite(globalABLookup.diciplemain,'image_xianjiehdk_1')
self.back:setSprite(globalABLookup.diciplecolorframe,'frame_dzkpchengse')
self.rawImage:setSprite(globalABLookup.dicipleroleinfo,'image_weizhidizi_2')
_this=self
end


function UIChatLeftShareDiscipleInfoItem:__delete()
self:unbindComponents()
end




function UIChatLeftShareDiscipleInfoItem:onShow(argtable,afterOnloaded)
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
self.bg:setActive(true)
local widget=self.widget
widget:SetChildButtonClick(self.headBg:getID(),function()
local attach=nil
if channelId==CHAT_CHANNNEL.eKuafu then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)


local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
local discipleNetData
if regexType then
discipleNetData=chatEmotHelper.getDZInfoByRegex(regexInfo)
else
discipleNetData=chatEmotHelper.decodeShareDiscipleInfo(mesg)
end
self:freshDiscipleInfo(discipleNetData,actorID,serverId)
























end


function UIChatLeftShareDiscipleInfoItem:onHide()

end

function UIChatLeftShareDiscipleInfoItem:onHeadBg()

end



function UIChatLeftShareDiscipleInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=252
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

function UIChatLeftShareDiscipleInfoItem:freshDiscipleInfo(otherData,actorID,serverId)

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
item:SetChildActive(23,isSpDz)

item:SetChildText(2,netdata.name or netdata.disciplename)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(3,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netdata.level)
item:SetChildText(5,lv_str)

item:SetChildActive(6,true)
item:SetChildText(6,tostring(netdata.fightvalue))

item:SetChildText(4,'')


local tmlv=netData.tmlv
local dylv=netData.daoyan_lv or 0
local dyUnlock=netData.daoyan_unlock
local isshow_tm=tmlv>0
local isShow_dy=dylv>0 and dyUnlock>0
local isShow=isshow_tm or isShow_dy
item:SetChildActive(19,isShow)
if isshow_tm and(not isShow_dy)then
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
elseif isShow_dy then
local widget=item:GetChildWidgetBase(19)
local chong,floor=UIDiscipleModel.getDaoYanLevelFloor(dylv)
local abName,iconName=UIDiscipleModel.getDaoYanFloorIcon(chong)
widget:SetChildLayoutGroupCreateItems(0,floor)
local grids=widget:GetChildLayoutGroupGridList(0)
for i=1,floor do
local fireItem=grids[i-1]
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


local isLD=liandonModel:getLianDonLinkageIdByDZId(otherData.id)>0
item:SetChildActive(22,isLD)
else
local item=self.default:getWidgetBase()
local func=function()
UIManager.error('弟子信息过期，暂无法查看')
end
item:SetChildButtonClick(-1,func,true)
end

end









def_class("UIChatRightShareDiscipleInfoItem",UICloneObject)





UIChatRightShareDiscipleInfoItem.abName="ui/windows/chat/child/uichatrightsharediscipleinfoitem.ab"

UIChatRightShareDiscipleInfoItem.assetName="UIChatRightShareDiscipleInfoItem"


function UIChatRightShareDiscipleInfoItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.head=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.bg=UIObject.get(self,3)
self.discipleinfo=UIButton.get(self,4)
self.default=UIButton.get(self,5)
self.tianmingObj=UIImage.get(self,6)
self.back=UIImage.get(self,7)
self.rawImage=UIImage.get(self,8)
self.time=UIText.get(self,9)

self.discipleinfo:setButtonClick(function()self:onDiscipleinfo()end)

self.default:setButtonClick(function()self:onDefault()end)

end


function UIChatRightShareDiscipleInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.discipleinfo);self.discipleinfo=nil;
_UIObject_release(self.default);self.default=nil;
_UIObject_release(self.tianmingObj);self.tianmingObj=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.time);self.time=nil;
end









function UIChatRightShareDiscipleInfoItem:onLoaded(...)
self:bindComponents()
self.tianmingObj:setSprite(globalABLookup.diciplemain,'image_xianjiehdk_1')
self.back:setSprite(globalABLookup.diciplecolorframe,'frame_dzkpchengse')
self.rawImage:setSprite(globalABLookup.dicipleroleinfo,'image_weizhidizi_2')
end


function UIChatRightShareDiscipleInfoItem:__delete()
self:unbindComponents()
end




function UIChatRightShareDiscipleInfoItem:onShow(argtable,afterOnloaded)
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
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[我]'))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}][我]',loginModel:getServerName(serverId),actorName))
end


playerController:setRawImageHeadIcon(self.widget,self.head:getID(),{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
self.bg:setActive(true)


local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
local discipleData
if regexType then
discipleData=chatEmotHelper.getDZInfoByRegex(regexInfo)
else
discipleData=chatEmotHelper.decodeShareDiscipleInfo(mesg)
end

self.default:setActive(discipleData==nil)
self.discipleinfo:setActive(discipleData~=nil)
if discipleData then


local guid=discipleData.guid
local item=self.discipleinfo:getWidgetBase()

local image=UIDiscipleModel.calculationDiscipleImageBase(discipleData)
local color=image.color

item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconName(discipleData.job)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=discipleData.id and UIDiscipleModel:isSPDisciple(discipleData.id)or false
item:SetChildActive(23,isSpDz)

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
local func=function()
local args={}
args.dis_guid=guid

if data then
args.dislist={{base=data.netData.net}}
UIManager:showWindow('UIOtherDiscipleMainWin',args)
else
UIManager.info("弟子信息过期，暂无法查看")
end
end
item:SetChildButtonClick(-1,func,true)



local tmlv=discipleData.tmlv
local dylv=discipleData.daoyan_lv or 0
local dyUnlock=discipleData.daoyan_unlock
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


if data then
local data=otherPlayerModel.discipleStruct_to_discipleStruct3(data.netData.net)
otherPlayerModel:addDZData(actorID,data,false)
end


local dzId=UIDiscipleModel:getDiscipleID(guid)
local isLD=liandonModel:getLianDonLinkageIdByDZId(dzId)>0
item:SetChildActive(22,isLD)
else
local item=self.default:getWidgetBase()
local func=function()
UIManager.error('弟子信息过期，暂无法查看')
end
item:SetChildButtonClick(-1,func,true)
end
end


function UIChatRightShareDiscipleInfoItem:onHide()

end




function UIChatRightShareDiscipleInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=252
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end
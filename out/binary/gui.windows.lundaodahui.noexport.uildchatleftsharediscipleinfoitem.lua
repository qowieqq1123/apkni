







def_class("UILDChatLeftShareDiscipleInfoItem",UICloneObject)





UILDChatLeftShareDiscipleInfoItem.abName=""

UILDChatLeftShareDiscipleInfoItem.assetName="UILDChatLeftShareDiscipleInfoItem"


function UILDChatLeftShareDiscipleInfoItem:bindComponents()

self.name=UIText.get(self,0)
self.bg=UIObject.get(self,1)
self.discipleinfo=UIButton.get(self,2)

self.discipleinfo:setButtonClick(function()self:onDiscipleinfo()end)

end


function UILDChatLeftShareDiscipleInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.discipleinfo);self.discipleinfo=nil;
end









function UILDChatLeftShareDiscipleInfoItem:onLoaded(...)
self:bindComponents()
end


function UILDChatLeftShareDiscipleInfoItem:__delete()
self:unbindComponents()
end




function UILDChatLeftShareDiscipleInfoItem:onShow(argtable,afterOnloaded)
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

if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'{0}',actorName))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}]{1}',loginModel:getServerName(serverId),actorName))
end


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


function UILDChatLeftShareDiscipleInfoItem:onHide()

end




function UILDChatLeftShareDiscipleInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local topY=45
local bottomY=252
local size=topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

function UILDChatLeftShareDiscipleInfoItem:freshDiscipleInfo(otherData,actorID,serverId)

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
item:SetChildActive(29,isSpDz)

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








def_class("UILDChatRightShareDiscipleInfoItem",UICloneObject)





UILDChatRightShareDiscipleInfoItem.abName=""

UILDChatRightShareDiscipleInfoItem.assetName="UILDChatRightShareDiscipleInfoItem"


function UILDChatRightShareDiscipleInfoItem:bindComponents()

self.name=UIText.get(self,0)
self.bg=UIObject.get(self,1)
self.discipleinfo=UIButton.get(self,2)

self.discipleinfo:setButtonClick(function()self:onDiscipleinfo()end)

end


function UILDChatRightShareDiscipleInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.discipleinfo);self.discipleinfo=nil;
end









function UILDChatRightShareDiscipleInfoItem:onLoaded(...)
self:bindComponents()
end


function UILDChatRightShareDiscipleInfoItem:__delete()
self:unbindComponents()
end




function UILDChatRightShareDiscipleInfoItem:onShow(argtable,afterOnloaded)
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
if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[我]'))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}][我]',loginModel:getServerName(serverId),actorName))
end

local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
local discipleData
if regexType then
discipleData=chatEmotHelper.getDZInfoByRegex(regexInfo)
else
discipleData=chatEmotHelper.decodeShareDiscipleInfo(mesg)
end

self.discipleinfo:setActive(discipleData~=nil)
if discipleData then


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
local item=self.default:getWidgetBase()
local func=function()
UIManager.error('弟子信息过期，暂无法查看')
end
item:SetChildButtonClick(-1,func,true)
end
end


function UILDChatRightShareDiscipleInfoItem:onHide()

end




function UILDChatRightShareDiscipleInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)

local topY=45
local bottomY=252
local size=topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end
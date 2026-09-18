







def_class("UIWDCQSecondQFWin",UIWindowBase)









function UIWDCQSecondQFWin:bindComponents()

self.addTypeInfo_1=UIText.get(self,0)
self.addTypeInfo_2=UIText.get(self,1)
self.benFuFlag=UIObject.get(self,2)
self.buffDurationInfo=UIText.get(self,3)
self.buffIcon=UIObject.get(self,4)
self.buffTitle=UIText.get(self,5)
self.defaultRoot=UIObject.get(self,6)
self.dropDownRoot=UIObject.get(self,7)
self.head=UIObject.get(self,8)
self.loseHead=UIObject.get(self,9)
self.loseRoot=UIObject.get(self,10)
self.playerName=UIText.get(self,11)
self.qfInfo=UIText.get(self,12)
self.rewardInfoRoot=UIObject.get(self,13)
self.roleInfo=UIObject.get(self,14)
self.roleInfoRoot=UIObject.get(self,15)
self.roleModel=UIObject.get(self,16)
self.Root=UIObject.get(self,17)
self.addTypeInfo={
self.addTypeInfo_1,
self.addTypeInfo_2,
}



end


function UIWDCQSecondQFWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addTypeInfo_1);self.addTypeInfo_1=nil;
_UIObject_release(self.addTypeInfo_2);self.addTypeInfo_2=nil;
_UIObject_release(self.benFuFlag);self.benFuFlag=nil;
_UIObject_release(self.buffDurationInfo);self.buffDurationInfo=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.buffTitle);self.buffTitle=nil;
_UIObject_release(self.defaultRoot);self.defaultRoot=nil;
_UIObject_release(self.dropDownRoot);self.dropDownRoot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.loseHead);self.loseHead=nil;
_UIObject_release(self.loseRoot);self.loseRoot=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.qfInfo);self.qfInfo=nil;
_UIObject_release(self.rewardInfoRoot);self.rewardInfoRoot=nil;
_UIObject_release(self.roleInfo);self.roleInfo=nil;
_UIObject_release(self.roleInfoRoot);self.roleInfoRoot=nil;
_UIObject_release(self.roleModel);self.roleModel=nil;
_UIObject_release(self.Root);self.Root=nil;
self.addTypeInfo=nil;
end
















local mainItemIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
txtImg=4,
}

local subItemIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
txtImg=4,
}

local abName="ui/windows/wendingcangqiong/wdcq_atlas_pak.ab"
local txtImageList=
{
["凡修组"]="image_wdcqwz_1",
["地仙组"]="image_wdcqwz_2",
["天尊组"]="image_wdcqwz_3",
["帝君组"]="image_wdcqwz_4",
["32强赛"]="image_wdcqszwz_1",
["16强赛"]="image_wdcqszwz_2",
["8强赛"]="image_wdcqszwz_3",
["4强赛"]="image_wdcqszwz_4",
["半决赛"]="image_wdcqszwz_5",
["季军赛"]="image_wdcqszwz_6",
["冠军赛"]="image_wdcqszwz_7",
}




function UIWDCQSecondQFWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQSecondQFWin:__delete()
self:unbindComponents()
end




function UIWDCQSecondQFWin:onShow(argtable,afterOnloaded)

self:refreshAll()
end


function UIWDCQSecondQFWin:onHide()

end

function UIWDCQSecondQFWin:refreshAll()
self:refreshDropDown()

self:refreshInfo()
end

function UIWDCQSecondQFWin:refreshInfo()

self:refreshLeftInfo()
self:refreshRightInfo()

end

function UIWDCQSecondQFWin:refreshLeftInfo()
local championRoleInfo=WDCQModel:getRankRoleInfo(self.selectGroup,1)or{}
championRoleInfo=championRoleInfo[1]
local isEnd=WDCQController.checkChampionStageEnd(self.selectGroup)
local isHasChampion=championRoleInfo~=nil
local isShowDefault=(not isEnd)or(not isHasChampion)
local isSHowRoleInfo=isEnd and isHasChampion
local isLose=false
if isHasChampion then
isLose=mathHelper.validInt64(championRoleInfo.actorid)and championRoleInfo.name==''
end
self.defaultRoot:setActive(isShowDefault)
self.roleInfoRoot:setActive(isSHowRoleInfo or isLose)
self.loseRoot:setActive(isLose)
self.head:setActive(not isLose)
self.loseHead:setActive(isLose)
if isSHowRoleInfo then




playerController:setImage(self.winlua,self.roleModel:getID(),championRoleInfo.sex,championRoleInfo.iconInfo,playerController:supportDynamic(),0.8)

playerController:setHeadIcon(self.winlua,self.head:getID(),{scale=0.6,iconInfo=championRoleInfo.iconInfo})


local serverName=loginModel:getServerName(championRoleInfo.serverId)
serverName=FMT.fmt("[{0}]",serverName)
self.qfInfo:setText(serverName)

self.playerName:setText(playerModel:getOtherActorName(championRoleInfo.name))


local isSelfServer=(loginModel.server_id or 0)==championRoleInfo.serverid
self.benFuFlag:setActive(isSelfServer)
end
end

function UIWDCQSecondQFWin:refreshRightInfo()
local buffList=cfgHelper.get3(cfg_wendingcangqiongrankconfig_get,self.selectGroup,1,'zm_buff_id')
local isShowBuff=buffList~=nil
if isShowBuff then
local buffid=buffList[1]
local guildstateconfig=cfg_guildstateconfig_get(buffid)
local iconName=iconHelper.getzmStateIcon(guildstateconfig.icon)
self.buffIcon:setIcon(iconName,false)
self.buffTitle:setText(guildstateconfig.name)
local durationTimeStr=timeHelper.format_time_stamp4(guildstateconfig.duration)
self.buffDurationInfo:setText(FMT.fmt("持续时间：<color=#7d3b17>{0}</color>",durationTimeStr))

local desc=homeBuffModel:getBuffDescByStateId(buffid)

desc=string.gsub(desc,'[+-]%d+%%',function(s)return toColorStringX("#549327",s)end)

self.addTypeInfo_1:setText(desc)
else
logErr(FMT.fmt("WDCQ group [{0}] zm_buff_id is nil",self.selectGroup))
end
end


local CmpDropDownWidgetIndex={
scrollView=0,
list=1,
selectItem=2,
open=3,
selectIcon=4,
}


local _dropOptionItemHeight=55
local _dropOptionListTopPadding=5
local _dropOptionListBottonPadding=30
local _dropOptionListSpacing=5
local _dropOptionScrollViewWidth=184


local _aniMoveDuration=0.2


function UIWDCQSecondQFWin:refreshDropDown()

self.selectGroup=1
self.isOpenOptionList=false

self.dropDownWidget=self.dropDownRoot:getWidgetBase()

self.dropItemInfoList=WDCQController:getUnlockGroupCfgList()
self.dropItemNum=#self.dropItemInfoList

local maxGroup=WDCQController:getMaxChampionGroupIndex()
if maxGroup then
self.selectGroup=maxGroup
end

self:refreshSelectItem()

self:refreshSubItemList()
end

function UIWDCQSecondQFWin:refreshSelectItem()

self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.open,self.isOpenOptionList)


local id=self.dropItemInfoList[self.selectGroup].id
local iconName=WDCQController.getGroupIconName(id)
self.dropDownWidget:SetChildCSImageSprite(CmpDropDownWidgetIndex.selectIcon,globalABLookup.wendingcangqiong,iconName)
self.dropDownWidget:SetChildButtonClick(CmpDropDownWidgetIndex.selectItem,function()

self.isOpenOptionList=not self.isOpenOptionList
self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.open,self.isOpenOptionList)

if self.isOpenOptionList then
self:playOpenAni()
else
self:hideOptionList()
end
end,true)
end

function UIWDCQSecondQFWin:refreshSubItemList()

local createFunc=function(index)
local dropItem=self.dropDownWidget:GetChildLayoutGroupGridItem(CmpDropDownWidgetIndex.list,index-1)

local id=self.dropItemInfoList[index].id

local groupIconName=WDCQController.getGroupIconName(id)

dropItem:SetChildCSImageSprite(0,globalABLookup.wendingcangqiong,groupIconName)

dropItem:SetBaseItemClickEvent(-1,function()
self.selectGroup=index

self.isOpenOptionList=false

self:hideOptionList()

self:refreshSelectItem()

self:onDropClickCallBack()
end)
end

self.dropDownWidget:SetChildLayoutGroupCreateItems(CmpDropDownWidgetIndex.list,self.dropItemNum,createFunc)
end

function UIWDCQSecondQFWin:playOpenAni()
self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.scrollView,true)


local totalHeight=self:caculateDropListHeight()

self.openDropDownListDt=self.dropDownWidget:SetChildDOSizeDelta(CmpDropDownWidgetIndex.scrollView,Vector2(_dropOptionScrollViewWidth,totalHeight),_aniMoveDuration)
end

function UIWDCQSecondQFWin:hideOptionList()
self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.scrollView,false)

if self.openDropDownListDt then
self.openDropDownListDt:Complete()
self.openDropDownListDt:Kill()
end

self.dropDownWidget:SetChildSizeDelta(CmpDropDownWidgetIndex.scrollView,_dropOptionScrollViewWidth,0)
end

function UIWDCQSecondQFWin:caculateDropListHeight()
local num=self.dropItemNum

return(num*_dropOptionItemHeight)+((num-1)*_dropOptionListSpacing)+_dropOptionListTopPadding+_dropOptionListBottonPadding
end

function UIWDCQSecondQFWin:onDropClickCallBack()
self:refreshInfo()
end



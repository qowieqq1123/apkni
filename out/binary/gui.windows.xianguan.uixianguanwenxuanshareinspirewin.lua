







def_class("UIXianGuanWenXuanShareInspireWin",UIWindowBase)









function UIXianGuanWenXuanShareInspireWin:bindComponents()

self.againstTx=UIText.get(self,0)
self.agreeTx=UIText.get(self,1)
self.background=UIButton.get(self,2)
self.channelList=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.contentTx=UILinkImageText.get(self,5)
self.descTitle=UIText.get(self,6)
self.head=UIObject.get(self,7)
self.mbg=UIObject.get(self,8)
self.modelHead=UIObject.get(self,9)
self.modelHeadIcon=UIImage.get(self,10)
self.nameTx=UIText.get(self,11)
self.playerInfo=UIObject.get(self,12)
self.privateShare=UIButton.get(self,13)
self.publicShare=UIButton.get(self,14)
self.publicShareText=UIText.get(self,15)
self.root=UIObject.get(self,16)
self.serverNameTx=UIText.get(self,17)
self.xmNameTx=UIText.get(self,18)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.privateShare:setButtonClick(function()self:onPrivateShare()end)

self.publicShare:setButtonClick(function()self:onPublicShare()end)



end


function UIXianGuanWenXuanShareInspireWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.againstTx);self.againstTx=nil;
_UIObject_release(self.agreeTx);self.agreeTx=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.channelList);self.channelList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.contentTx);self.contentTx=nil;
_UIObject_release(self.descTitle);self.descTitle=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.modelHead);self.modelHead=nil;
_UIObject_release(self.modelHeadIcon);self.modelHeadIcon=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.playerInfo);self.playerInfo=nil;
_UIObject_release(self.privateShare);self.privateShare=nil;
_UIObject_release(self.publicShare);self.publicShare=nil;
_UIObject_release(self.publicShareText);self.publicShareText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.serverNameTx);self.serverNameTx=nil;
_UIObject_release(self.xmNameTx);self.xmNameTx=nil;
end
















local _this
local channelCmp={
button=0,
unselect=1,
select=2,
name=3,
}
local privateMainCmp={
name=0,
select=1,
arrowAni=2,
}
local privateSubCmp={
name=0,
select=1,
bg=2,
head=3,
shareBtn=4,
shareTx=5,
cantShare=6,
}



function UIXianGuanWenXuanShareInspireWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectChannels={}
end


function UIXianGuanWenXuanShareInspireWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGuanWenXuanShareInspireWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.curJobId=argtable.job
self.actorId=argtable.actorId

self:refreshPanel()
self:refreshPublicShareShow()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(5901,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end


function UIXianGuanWenXuanShareInspireWin:onHide()

end

function UIXianGuanWenXuanShareInspireWin:refreshPanel()
local rank=xianguanModel:getWenXuanElectionRecordRankByActorId(self.curJobId,self.actorId)
local myRecordData=xianguanModel:getWenXuanRecordData(self.curJobId,rank)
local agreeStr=FMT.fmt("支持数：{0}",myRecordData.agree_num)
local againstStr=FMT.fmt("反对数：{0}",myRecordData.against_num)
self.agreeTx:setText(agreeStr)
self.againstTx:setText(againstStr)

local serverName=loginModel:getServerName(myRecordData.server_id)
serverName=FMT.fmt('[{0}]',serverName)
local guild_name=myRecordData.guild_name~=""and FMT.fmt('[{0}]',myRecordData.guild_name)or"暂无"

self.nameTx:setText(myRecordData.name)
self.serverNameTx:setText(serverName)
self.xmNameTx:setText(guild_name)

local jobCfg=xianguanConfig.getJobConfig(1,self.curJobId)
local declarationStr=cfgHelper.get2(cfg_officerelectiondeclarationconfig_get,myRecordData.declaration_idx,"desc")
local isInWbMatch=false
if jobCfg.campaignType==XianGuanCampaignType.eWenXuan then
isInWbMatch=xianguanController:isInMatchStage_enter_WenXuan_BW()
elseif jobCfg.campaignType==XianGuanCampaignType.eWuXuan then
isInWbMatch=xianguanController:isInMatchStage_enter_WuXuan_BW()
end
local descTitleStr
if isInWbMatch then
descTitleStr=FMT.fmt("帮帮我，我正在参加<color=#ca631d>【{0}】</color>仙官文选补位！\n我的参选宣言是：",jobCfg.name)
else
descTitleStr=FMT.fmt("帮帮我，我正在参加<color=#ca631d>【{0}】</color>仙官文选！\n我的参选宣言是：",jobCfg.name)
end

self.descTitle:setText(descTitleStr)
self.contentTx:setText(chatEmotHelper.decodeEmot(declarationStr))

local iconInfo=myRecordData.iconInfo
playerController:setHeadIcon(self.winlua,self.head:getID(),{scale=1,iconInfo=iconInfo})
playerController:setImage(self.winlua,self.modelHeadIcon:getID(),nil,iconInfo,false,nil,nil)

local channelCfg=cfgHelper.get2(cfg_officerelectionbasic1config_get,1,"ttchat_conf")
self.channels={}
for channel,v in pairs(channelCfg)do
if chatCommonHelper.isChannelUnlock(channel)and channel~=6 then
table.insert(self.channels,channel)
end
end
table.sort(self.channels)
self.channelList:setChildLayoutGroupCreateItems(#self.channels,function(index)
local item=self.channelList:getChildLayoutGroupGridItem(index-1)
local channel=self.channels[index]
item:SetChildButtonClick(channelCmp.button,function()
self:onClickChannel(index)
end)

local nameStr=CHAT_CHANNNEL_NAME[channel]
item:SetChildText(channelCmp.name,nameStr)
item:SetChildActive(channelCmp.unselect,not self.selectChannels[channel])
item:SetChildActive(channelCmp.select,self.selectChannels[channel]or false)
end)
end

function UIXianGuanWenXuanShareInspireWin:refreshPublicShareShow()
local nowTime=timeHelper.getServerShortTime()
if not xianguanModel:checkWenXuanShareTime(nowTime)then
if not self.short_timer then
local tick=function()
local left=xianguanModel:getWenXuanShareLeftTime()
_this.publicShareText:setText(timeHelper.format_time_stamp3(left))
if left<=0 then
_this:stopShortTimer()
end
end

self.short_timer=self:setTimer(0.1,-1,tick)
end
self.publicShare:setGray(true)
else
self:stopShortTimer()
end
end

function UIXianGuanWenXuanShareInspireWin:stopShortTimer()
if self.short_timer then
self:stopTimerByID(self.short_timer)
self.short_timer=nil
end
self.publicShare:setGray(false)
self.publicShareText:setText("频道分享")
end





function UIXianGuanWenXuanShareInspireWin:onBackground()
self:onCloseBtn()
end



function UIXianGuanWenXuanShareInspireWin:onCloseBtn()
if self.parentwin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end



function UIXianGuanWenXuanShareInspireWin:onPrivateShare()
local args={
parentWin=self,
formTypes={CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent,CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend},
mainPrefab="UIShareMainItem",
subPrefab="UIShareSubItem",
mainRefresh=function(widget,formType,expanding,name)
local rotation=Vector3.forward*(expanding and 90 or 0)
widget:SetChildText(privateMainCmp.name,name)
widget:SetChildActive(privateMainCmp.select,expanding)
widget:SetChildRotation(privateMainCmp.arrowAni,rotation.x,rotation.y,rotation.z)
end,
subRefresh=function(widget,formType,isSelected,actorInfo)
widget:SetChildText(privateSubCmp.name,actorInfo.actorName)
widget:SetChildActive(privateSubCmp.select,isSelected)
local online=actorInfo.offline==0


playerController:setHeadIcon(widget,privateSubCmp.head,{iconInfo=actorInfo.iconInfo,scale=0.5,gray=not online})

local shareStatus=xianguanModel:getJingXuanShareRecord(XianGuanCampaignType.eWenXuan,actorInfo.actorId)
local canShare=actorInfo.actorLevel>=45
local shared=shareStatus==XianGuanJingXuanShareState.eDone
widget:SetChildActive(privateSubCmp.cantShare,not canShare)
widget:SetChildActive(privateSubCmp.shareBtn,canShare)
widget:SetChildGraphicGray(privateSubCmp.shareBtn,shared)
widget:SetChildText(privateSubCmp.shareTx,shared and"已分享"or"分享")
widget:SetChildButtonClick(privateSubCmp.shareBtn,function()
local status=xianguanModel:getJingXuanShareRecord(XianGuanCampaignType.eWenXuan,actorInfo.actorId)
if status==XianGuanJingXuanShareState.eNormal then
local jsonStr=""
chatControl:reqShare(CHAT_REGEX_TYPE.csOfficerElectionHelp,jsonStr,{},{actorInfo.actorId})

xianguanModel:setJingXuanShareRecord(XianGuanCampaignType.eWenXuan,actorInfo.actorId,XianGuanJingXuanShareState.eDone)
widget:SetChildText(privateSubCmp.shareTx,"已分享")
widget:SetChildGraphicGray(privateSubCmp.shareBtn,true)
elseif status==XianGuanJingXuanShareState.eDone then
UIManager.info("已分享")
end
end)
end,
}
self:showWindow("UICommonPrivateListWin",args)
end



function UIXianGuanWenXuanShareInspireWin:onPublicShare()
if next(self.selectChannels)==nil then
UIManager.info("请先选择分享频道")
return
end
local nowTime=timeHelper.getServerShortTime()
if not xianguanModel:checkWenXuanShareTime(nowTime)then
local left=xianguanModel:getWenXuanShareLeftTime(nowTime)
UIManager.info(FMT.fmt("{0}后才可分享",timeHelper.format_time_stamp3(left)))
return
end
local sendChannels={}
for i,v in pairs(self.selectChannels)do
table.insert(sendChannels,i)
end

local jsonStr=""
chatControl:reqShare(CHAT_REGEX_TYPE.csOfficerElectionHelp,jsonStr,sendChannels,{})
end

function UIXianGuanWenXuanShareInspireWin:onClickChannel(index)
local channel=self.channels[index]
if chatCommonHelper.isChannelUnlock(channel)then
if channel==CHAT_CHANNNEL.eXianmeng and not xianmengModel:hasXM()then
return UIManager.info("请先加入一个仙盟")
end
local select=not self.selectChannels[channel]
self.selectChannels[channel]=select

local item=self.channelList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(channelCmp.unselect,not select)
item:SetChildActive(channelCmp.select,select)
end
end
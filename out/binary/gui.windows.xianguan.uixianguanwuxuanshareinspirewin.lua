







def_class("UIXianGuanWuXuanShareInspireWin",UIWindowBase)









function UIXianGuanWuXuanShareInspireWin:bindComponents()

self.background=UIButton.get(self,0)
self.channelList=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.content=UILinkImageText.get(self,3)
self.modelHead=UIObject.get(self,4)
self.modelHeadIcon=UIImage.get(self,5)
self.peopleTx=UIText.get(self,6)
self.privateShare=UIButton.get(self,7)
self.publicShare=UIButton.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.privateShare:setButtonClick(function()self:onPrivateShare()end)

self.publicShare:setButtonClick(function()self:onPublicShare()end)



end


function UIXianGuanWuXuanShareInspireWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.channelList);self.channelList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.modelHead);self.modelHead=nil;
_UIObject_release(self.modelHeadIcon);self.modelHeadIcon=nil;
_UIObject_release(self.peopleTx);self.peopleTx=nil;
_UIObject_release(self.privateShare);self.privateShare=nil;
_UIObject_release(self.publicShare);self.publicShare=nil;
end















local _this=nil
local _channelCmp={
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



function UIXianGuanWuXuanShareInspireWin:onLoaded(...)
self:bindComponents()
_this=self

self.selectChannels={}
end


function UIXianGuanWuXuanShareInspireWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGuanWuXuanShareInspireWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

playerController:setImage(self.winlua,self.modelHeadIcon:getID(),nil,playerModel:getActorIconInfo(),false,nil,nil)

local xgName=cfgHelper.get2(cfg_xianguanconfig_get,argtable.job,"name")
local declarationStr=cfgHelper.get2(cfg_officerelectiondeclaration2config_get,argtable.declaration,"desc")
local contentStr=FMT.fmt("帮帮我，我正在参加【{0}】仙官武选！\n我的参选宣言是：\n{1}",xgName,chatEmotHelper.decodeEmot(declarationStr))
self.content:setText(contentStr)

local job=xianguanModel:getWuXuanPlayerJob()
local registerData=xianguanModel:getWuXuanRegisterJobData(job)
local peopleCnt=0
for i,v in ipairs(registerData)do
if playerModel:checkActorId(v.actor_id)then
peopleCnt=v.inspired_num
break
end
end
local peopleStr=FMT.fmt("当前鼓舞人数：{0}人",peopleCnt)
self.peopleTx:setText(peopleStr)

local channelCfg=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"ttchat_conf")
self.channels={}
for i,v in pairs(channelCfg)do
if chatCommonHelper.isChannelUnlock(i)then
table.insert(self.channels,i)
end
end
table.sort(self.channels)
self.channelList:setChildLayoutGroupCreateItems(#self.channels,function(index)
local item=self.channelList:getChildLayoutGroupGridItem(index-1)
local channel=self.channels[index]
item:SetChildButtonClick(_channelCmp.button,function()
self:onClickChannel(index)
end)
local nameStr=CHAT_CHANNNEL_NAME[channel]
item:SetChildText(_channelCmp.name,nameStr)
item:SetChildActive(_channelCmp.unselect,not self.selectChannels[channel])
item:SetChildActive(_channelCmp.select,self.selectChannels[channel]or false)
end)
end


function UIXianGuanWuXuanShareInspireWin:onHide()

end




function UIXianGuanWuXuanShareInspireWin:onBackground()
self:onCloseBtn()
end


function UIXianGuanWuXuanShareInspireWin:onCloseBtn()
if self.parentwin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianGuanWuXuanShareInspireWin:onPrivateShare()
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

local shareStatus=xianguanModel:getJingXuanShareRecord(XianGuanCampaignType.eWuXuan,actorInfo.actorId)
local canShare=actorInfo.actorLevel>=45
local shared=shareStatus==XianGuanJingXuanShareState.eDone
widget:SetChildActive(privateSubCmp.cantShare,not canShare)
widget:SetChildActive(privateSubCmp.shareBtn,canShare)
widget:SetChildGraphicGray(privateSubCmp.shareBtn,shared)
widget:SetChildText(privateSubCmp.shareTx,shared and"已分享"or"分享")
widget:SetChildButtonClick(privateSubCmp.shareBtn,function()
local status=xianguanModel:getJingXuanShareRecord(XianGuanCampaignType.eWuXuan,actorInfo.actorId)
if status==XianGuanJingXuanShareState.eNormal then
local jsonStr=""
chatControl:reqShare(CHAT_REGEX_TYPE.csOfficerElection2Help,jsonStr,{},{actorInfo.actorId})

xianguanModel:setJingXuanShareRecord(XianGuanCampaignType.eWuXuan,actorInfo.actorId,XianGuanJingXuanShareState.eDone)
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


function UIXianGuanWuXuanShareInspireWin:onPublicShare()
if next(self.selectChannels)==nil then
UIManager.info("请先选择分享频道")
return
end













local nowTime=timeHelper.getServerShortTime()
if not xianguanModel:checkWuXuanShareTime(nowTime)then
local left=xianguanModel:getWuXuanShareLeftTime(nowTime)
UIManager.info(FMT.fmt("{0}后才可分享",timeHelper.format_time_stamp3(left)))
return
end
local sendChannels={}
for i,v in pairs(self.selectChannels)do
table.insert(sendChannels,i)
end

local jsonStr=""
chatControl:reqShare(CHAT_REGEX_TYPE.csOfficerElection2Help,jsonStr,sendChannels,{})
xianguanModel:markWuXuanShareTime()
end

function UIXianGuanWuXuanShareInspireWin:onClickChannel(index)
local channel=self.channels[index]
if chatCommonHelper.isChannelUnlock(channel)then
if channel==CHAT_CHANNNEL.eXianmeng and not xianmengModel:hasXM()then
return UIManager.info("请先加入一个仙盟")
end
local select=not self.selectChannels[channel]
self.selectChannels[channel]=select or nil

local item=self.channelList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_channelCmp.unselect,not select)
item:SetChildActive(_channelCmp.select,select)
end
end
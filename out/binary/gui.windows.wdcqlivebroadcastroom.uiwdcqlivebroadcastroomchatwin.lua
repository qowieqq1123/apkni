







def_class("UIWDCQLiveBroadcastRoomChatWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomChatWin:bindComponents()

self.background=UIButton.get(self,0)
self.btnSend=UIButton.get(self,1)
self.InputField=UIInputField.get(self,2)
self.InputNode=UIObject.get(self,3)
self.inputText=UIText.get(self,4)
self.ScrollView=UILoopListView.new(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.btnSend:setButtonClick(function()self:onBtnSend()end)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIWDCQLiveBroadcastRoomChatWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.btnSend);self.btnSend=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.InputNode);self.InputNode=nil;
_UIObject_release(self.inputText);self.inputText=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
end















local _this=nil



function UIWDCQLiveBroadcastRoomChatWin:onLoaded(...)
self:bindComponents()

self.linkTable={}
self.linkNum=0

self.loopListView=self.winlua:GetChildUILoopListView(self.ScrollView:getID())
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
self.mesgWin={}
self.msgIDLookup={}
end


function UIWDCQLiveBroadcastRoomChatWin:__delete()
self:recycleViewItem()
self:unregChatHandle()

self.loopListView:SetAction(nil,nil)
self.loopListView=nil

self:unbindComponents()
end




function UIWDCQLiveBroadcastRoomChatWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.channelId=argtable.channelId
self:regChatHandle()
self:freshMesgPanel()



end


function UIWDCQLiveBroadcastRoomChatWin:onHide()
self:unregChatHandle()
end

function UIWDCQLiveBroadcastRoomChatWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end

function UIWDCQLiveBroadcastRoomChatWin:onStartView()
self.isStart=true
self:freshMesgPanel()
end


function UIWDCQLiveBroadcastRoomChatWin:addMesg(typo,addInfo)
local mesg=self.InputField:getInputFieldValue()
local linkNum=self.linkNum
local isEmot=typo==CHAT_DECODE_TYPE.eEmot

if isEmot then
mesg=FMT.fmt('{0}{1}',mesg,addInfo)
else
local key=addInfo[1]
local val=addInfo[2]
key=FMT.fmt('[{0}]',key)
if linkNum>0 then
local key1,val1=self:getLink()
mesg=string.replace(mesg,key1,key)
self.linkTable={}
self.linkNum=0
linkNum=0
else
mesg=FMT.fmt('{0}{1}',mesg,key)
end
self.linkTable[key]=val
linkNum=self.linkNum+1
end

if not chatCommonHelper.checkMesgLen(mesg)then
UIManager.error('字数超过限制')
return
end

if not isEmot and linkNum>1 then
UIManager.error('超链接不能超过一个')
return
end

if not isEmot then
self.linkNum=self.linkNum+1
end
self.InputField:setInputFieldValue(mesg)
end

function UIWDCQLiveBroadcastRoomChatWin:clearInput(sendguid)
if self.sendguid==sendguid then
self.InputField:setInputFieldValue('')
self.linkNum=0
self.linkTable={}
end
end

function UIWDCQLiveBroadcastRoomChatWin:sendMesg(mesg)
if mesg==''then return end
local channelId=self.channelId
mesg=chatLinkHelper.replaceLink(mesg,self.linkTable)
local sendguid=chatControl.reqPublicMesg(channelId,mesg)

if chatCommonHelper.canNeedShowInput(mesg)then
if sendguid then
self.sendguid=sendguid
end
end
end

function UIWDCQLiveBroadcastRoomChatWin:onInputChanged()
local mesg=self.InputField:getInputFieldValue()
local linkname=self:getLink()
if linkname and not string.findStr(mesg,linkname)then
self.linkTable[linkname]=nil
self.linkNum=0
end
end

function UIWDCQLiveBroadcastRoomChatWin:getLink()
for name,link in pairs(self.linkTable)do
return name,link
end
end



function UIWDCQLiveBroadcastRoomChatWin:onBtnSend()
local mesg=self.InputField:getInputFieldValue()
self:sendMesg(mesg)
end

function UIWDCQLiveBroadcastRoomChatWin:onSpeakClick()

end

function UIWDCQLiveBroadcastRoomChatWin:onEmotClick()
UIManager:showWindow('UIChatEmotWin',{rootPos=Vector3.New(354,372,0),anchor={0,0,0,0}})
end


function UIWDCQLiveBroadcastRoomChatWin:regChatHandle()
local handler=self.handler
if handler then return end

local channelId=self.channelId

handler=chatMessageHandler.create(channelId,self)

self.handler=handler
chatControl.addHandler(channelId,handler)
end

function UIWDCQLiveBroadcastRoomChatWin:unregChatHandle()
local handler=self.handler
if not handler then return end
local channelId=self.channelId
self.handle=nil
chatControl.deleteHandler(channelId,handler)
end


function UIWDCQLiveBroadcastRoomChatWin:freshMesgListData()
local channelId=self.channelId
local actorId=self.selectPlayer and self.selectPlayer.actorId or nil
local mesglist=chatControl.getTotalInfoList(channelId,actorId)or{}
self.mesglist=mesglist
end


function UIWDCQLiveBroadcastRoomChatWin:freshMesgPanel()
if not self.isStart then return end
self:recycleViewItem()

self:freshMesgListData()

local mesglist=self.mesglist
local len=#mesglist
local prefablist={}
local itemidlist={}
for i,v in ipairs(mesglist)do
local chatInfo=v
local msgType=chatInfo.msgType
if msgType~=CHAT_MESSAGE_TYPE.ePrivate then
local msgID=chatInfo.msgID
local compName=self:getCompName(chatInfo)
prefablist[#prefablist+1]=compName
itemidlist[#itemidlist+1]=msgID
end
end
self.loopListView:InitDataList(len,prefablist,itemidlist,nil,nil)
self.loopListView:JumpNewestIndex()
end


function UIWDCQLiveBroadcastRoomChatWin:jumpMsgIndex(index)
self.loopListView:JumpIndex(index)
end


function UIWDCQLiveBroadcastRoomChatWin:onDeleteMesgListByIndex(channelId,indexlist)
self.loopListView:DeleteItemListByDataIndex(indexlist)
end


function UIWDCQLiveBroadcastRoomChatWin:onDeleteMesgListByMsgID(channelId,idlist)
self.loopListView:DeleteItemListByItemId(idlist)
end


function UIWDCQLiveBroadcastRoomChatWin:onRecvPublicMessageList(channelId,chatInfoList)

self:freshMesgListData()

local prefabNamelist={}
local msgIDlist={}
local len=0
for i,chatInfo in ipairs(chatInfoList)do
local msgID=chatInfo.msgID
if not self.msgIDLookup[msgID]then
self.msgIDLookup[msgID]=true
prefabNamelist[#prefabNamelist+1]=self:getCompName(chatInfo)
msgIDlist[#msgIDlist+1]=msgID
len=len+1
end
end
self.loopListView:AddItemList(len,prefabNamelist,msgIDlist,nil,nil)
end


function UIWDCQLiveBroadcastRoomChatWin:onRecvPublicMessage(channelId,chatInfo)
local msgID=chatInfo.msgID
if self.msgIDLookup[msgID]then return end
self.msgIDLookup[msgID]=true
self:freshMesgListData()
local compName=self:getCompName(chatInfo)

self.loopListView:AddItem(compName,msgID,0,'',true)
end


function UIWDCQLiveBroadcastRoomChatWin:createLuaObject(index,widget)
local chatInfo=self.mesglist[index]
local compName=self:getCompName(chatInfo)
local luaObject=UICloneObject.get(compName)
local msgID=chatInfo.msgID
self.msgIDLookup[msgID]=true
self.mesgWin[index]=luaObject
luaObject:setWidget(widget)
luaObject:onLoaded()
end

function UIWDCQLiveBroadcastRoomChatWin:onFreshListView(index,widget)
index=index+1
local chatInfo=self.mesglist[index]
local luaObject=self.mesgWin[index]
local isLast=luaObject and luaObject.widget==widget or false


if luaObject then
UICloneObject.release(luaObject)
end
self:createLuaObject(index,widget)
luaObject=self.mesgWin[index]
local func=function()
luaObject:onShow({chatInfo=chatInfo,index=index})
end
xpcall(func,function(err)
logErr('UIWDCQLiveBroadcastRoomChatWin onFreshList err:',err)
end)
end

function UIWDCQLiveBroadcastRoomChatWin:recycleViewItem()
for _,luaObject in pairs(self.mesgWin or{})do
UICloneObject.release(luaObject)
end
self.mesgWin={}
self.msgIDLookup={}
end

function UIWDCQLiveBroadcastRoomChatWin:getCompName(chatInfo)
return chatConfig.getCompName(chatInfo)
end








def_class("UILunDaoChatWin",UIWindowBase)









function UILunDaoChatWin:bindComponents()

self.InputNode=UIObject.get(self,0)
self.InputField=UIInputField.get(self,1)
self.btnSend=UIButton.get(self,2)
self.inputText=UIText.get(self,3)
self.ScrollView=UIObject.get(self,4)

self.btnSend:setButtonClick(function()self:onBtnSend()end)



end


function UILunDaoChatWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.InputNode);self.InputNode=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.btnSend);self.btnSend=nil;
_UIObject_release(self.inputText);self.inputText=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end



















function UILunDaoChatWin:onLoaded(...)
self:bindComponents()

self.linkTable={}
self.linkNum=0
self.channelId=CHAT_CHANNNEL.eKuafu

self.loopListView=self.winlua:GetChildUILoopListView(self.ScrollView:getID())
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
self.mesgWin={}
self.msgIDLookup={}
end


function UILunDaoChatWin:__delete()
self:recycleViewItem()
self:unregChatHandle()

self.loopListView:SetAction(nil,nil)
self.loopListView=nil

self:unbindComponents()
end




function UILunDaoChatWin:onShow(argtable,afterOnloaded)
self:regChatHandle()

self:freshMesgPanel()

lundaodahuiController:send_17_32()
end


function UILunDaoChatWin:onHide()
self:unregChatHandle()
end

function UILunDaoChatWin:onStartView()
self.isStart=true
self:freshMesgPanel()
end


function UILunDaoChatWin:addMesg(typo,addInfo)
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

function UILunDaoChatWin:clearInput(sendguid)
if self.sendguid==sendguid then
self.InputField:setInputFieldValue('')
self.linkNum=0
self.linkTable={}
end
end

function UILunDaoChatWin:sendMesg(mesg)
if mesg==''then return end
local channelId=CHAT_CHANNNEL.eKuafu
mesg=chatLinkHelper.replaceLink(mesg,self.linkTable)
local sendguid=chatControl.reqPublicMesg(channelId,mesg)

if chatCommonHelper.canNeedShowInput(mesg)then
if sendguid then
self.sendguid=sendguid
end
end
end

function UILunDaoChatWin:onInputChanged()
local mesg=self.InputField:getInputFieldValue()
local linkname=self:getLink()
if linkname and not string.findStr(mesg,linkname)then
self.linkTable[linkname]=nil
self.linkNum=0
end
end

function UILunDaoChatWin:getLink()
for name,link in pairs(self.linkTable)do
return name,link
end
end




function UILunDaoChatWin:onBtnSend()

local mesg=self.InputField:getInputFieldValue()
self:sendMesg(mesg)
end

function UILunDaoChatWin:onSpeakClick()

end

function UILunDaoChatWin:onEmotClick()
UIManager:showWindow('UIChatEmotWin',{rootPos=Vector3.New(-353,372,0),anchor={1,0,1,0}})
end


function UILunDaoChatWin:regChatHandle()
local handler=self.handler
if handler then return end

local channelId=self.channelId

handler=chatMessageHandler.create(channelId,self)

self.handler=handler
chatControl.addHandler(channelId,handler)
end

function UILunDaoChatWin:unregChatHandle()
local handler=self.handler
if not handler then return end
local channelId=self.channelId
self.handle=nil
chatControl.deleteHandler(channelId,handler)
end


function UILunDaoChatWin:freshMesgListData()
local channelId=self.channelId
local actorId=self.selectPlayer and self.selectPlayer.actorId or nil
local mesglist=chatControl.getTotalInfoList(channelId,actorId)or{}
self.mesglist=mesglist
end


function UILunDaoChatWin:freshMesgPanel()
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


function UILunDaoChatWin:jumpMsgIndex(index)
self.loopListView:JumpIndex(index)
end


function UILunDaoChatWin:onDeleteMesgListByIndex(channelId,indexlist)
self.loopListView:DeleteItemListByDataIndex(indexlist)
end


function UILunDaoChatWin:onDeleteMesgListByMsgID(channelId,idlist)
self.loopListView:DeleteItemListByItemId(idlist)
end


function UILunDaoChatWin:onRecvPublicMessageList(channelId,chatInfoList)

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


function UILunDaoChatWin:onRecvPublicMessage(channelId,chatInfo)
local msgID=chatInfo.msgID
if self.msgIDLookup[msgID]then return end
self.msgIDLookup[msgID]=true
self:freshMesgListData()
local compName=self:getCompName(chatInfo)

self.loopListView:AddItem(compName,msgID,0,'',true)
end


function UILunDaoChatWin:createLuaObject(index,widget)
local chatInfo=self.mesglist[index]
local compName=self:getCompName(chatInfo)
local luaObject=UICloneObject.get(compName)
local msgID=chatInfo.msgID
self.msgIDLookup[msgID]=true
self.mesgWin[index]=luaObject
luaObject:setWidget(widget)
luaObject:onLoaded()
end

function UILunDaoChatWin:onFreshListView(index,widget)
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
logErr('UILunDaoChatWin onFreshList err:',err)
end)
end

function UILunDaoChatWin:recycleViewItem()
for _,luaObject in pairs(self.mesgWin or{})do
UICloneObject.release(luaObject)
end
self.mesgWin={}
self.msgIDLookup={}
end

function UILunDaoChatWin:getCompName(chatInfo)
return chatConfig.getLunDaoCompName(chatInfo)
end

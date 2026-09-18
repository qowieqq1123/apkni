







def_class("UIChatSimpleItem",UICloneObject)





UIChatSimpleItem.abName="ui/windows/chat/child/uichatsimpleitem.ab"

UIChatSimpleItem.assetName="UIChatSimpleItem"


function UIChatSimpleItem:bindComponents()

self.icon=UIImage.get(self,0)
self.name=UIText.get(self,1)
self.mesg=UIText.get(self,2)

end


function UIChatSimpleItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.mesg);self.mesg=nil;
end








function UIChatSimpleItem:onLoaded(...)
self:bindComponents()
self.widget:SetChildLinkImageExTextBuildFinishAction(self.mesg:getID(),function()
self:rebuildRect()
end)
end

function UIChatSimpleItem:__delete()
self.name:setText('')
self.mesg:setText('')
self.widget:SetChildLinkImageExTextBuildFinishAction(self.mesg:getID(),nil)
self:unbindComponents()
end

function UIChatSimpleItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable.chatInfo
local timeStamp=chatInfo.timeStamp
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local isVoice=chatInfo.isVoice
local args=chatInfo.args or{}
local timeStr=timeHelper.dateServerStamp(' [%m-%d %H:%M:%S]',timeStamp)
local showTitle=args.showTitle
local txt=showTitle
if txt==nil then
if args.filterType==CHAT_MSG_TYPE.eGuildNewMember or args.filterType==CHAT_MSG_TYPE.eHongChenYiShi then
local filterCfg=chatMesgFilterControl.getCfg(args.filterType)
txt=filterCfg.name
else
txt='系统'
end
end
self.name:setText(txt)
self.mesg:setText(mesg)

self:freshRect()
end

function UIChatSimpleItem:onHide()

end



function UIChatSimpleItem:rebuildRect()

self:stopAllTimer()
self:delayDo(0.05,function()
self:freshRect()
end)
end

function UIChatSimpleItem:freshRect()
self.widget:ForceLayoutVertical(self.mesg:getID())
local sizeY=self.widget:GetChildPreferredSize(self.mesg:getID(),1)
self.widget:SetChildSizeWithCurrentAnchors(self.mesg:getID(),1,sizeY)
self.widget:SetChildSizeWithCurrentAnchors(-1,1,sizeY+55)
end








def_class("UIXianGongInfluenceNPCTalkWin",UIWindowBase)









function UIXianGongInfluenceNPCTalkWin:bindComponents()

self.background=UIButton.get(self,0)
self.emotBg=UIObject.get(self,1)
self.emotIcon=UIImage.get(self,2)
self.itemBg=UIObject.get(self,3)
self.itemIcon=UIImage.get(self,4)
self.modelImage=UIObject.get(self,5)
self.modelObj=UIObject.get(self,6)
self.nameObj=UIObject.get(self,7)
self.nametxt=UIText.get(self,8)
self.root=UIObject.get(self,9)
self.shakeRoot=UIObject.get(self,10)
self.talkdesc=UIText.get(self,11)
self.talkframe=UIObject.get(self,12)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIXianGongInfluenceNPCTalkWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.emotBg);self.emotBg=nil;
_UIObject_release(self.emotIcon);self.emotIcon=nil;
_UIObject_release(self.itemBg);self.itemBg=nil;
_UIObject_release(self.itemIcon);self.itemIcon=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.nameObj);self.nameObj=nil;
_UIObject_release(self.nametxt);self.nametxt=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shakeRoot);self.shakeRoot=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.talkframe);self.talkframe=nil;
end















local _this=nil



function UIXianGongInfluenceNPCTalkWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianGongInfluenceNPCTalkWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGongInfluenceNPCTalkWin:onShow(argtable,afterOnloaded)
self.npcId=argtable.npc
self.message=argtable.id
self.parentWin=argtable.parentWin
self.callback=argtable.callback

self.messageCfg=cfgHelper.get1(cfg_xianjieshilijiaohuchatconfig_get,self.message)
self.npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,self.npcId)

local modelParams=npcModel:getImageInfo(self.npcCfg.image)
self.modelImage:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand,false,true)

local nameStr=npcModel:getName(self.npcCfg.image)
self.nametxt:setText(nameStr)

self.itemBg:setActive(self.messageCfg.gift_id~=nil)
if self.messageCfg.gift_id then
local iconName=iconHelper.getIconName(self.messageCfg.gift_id)
self.itemIcon:setImageIcon(iconName,false)
end

self.emotBg:setActive(self.messageCfg.chat_emot~=nil)
if self.messageCfg.chat_emot then
local emotIcon=iconHelper.getEmotIcon(self.messageCfg.chat_emot)
self.emotIcon:setImageIcon(emotIcon,true)
end

self.descPlaying=self.messageCfg.chat_content~=nil
self.shakeRoot:setActive(self.descPlaying)
self.talkdesc:setChildTrendsTextStop()
self.talkdesc:setText("")
if self.messageCfg.chat_content then
self.descStr=gameplotModel:replaceName(self.messageCfg.chat_content,nameStr)
self.descStr=FMT.fmt('{0}{1}','　　',self.descStr)
self.talkdesc:setChildTrendsTextPlay(self.descStr,40,function()
self.descPlaying=false
end)
end
end


function UIXianGongInfluenceNPCTalkWin:onHide()

end




function UIXianGongInfluenceNPCTalkWin:onBackground()
if self.descPlaying then
self.descPlaying=false
self.talkdesc:setChildTrendsTextStop()
self.talkdesc:setText(self.descStr)
return
end

if self.callback then
self.callback()
end

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


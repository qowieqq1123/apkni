







def_class("UIQieCuoFightExtraWin",UIWindowBase)









function UIQieCuoFightExtraWin:bindComponents()

self.selfHeadIcon=UIImage.get(self,0)
self.selfHeadKuang=UIImage.get(self,1)
self.selfSpeak=UIObject.get(self,2)
self.otherHeadIcon=UIImage.get(self,3)
self.otherHeadKuang=UIImage.get(self,4)
self.selfSpeakTxt=UIText.get(self,5)
self.Placeholder=UIText.get(self,6)
self.editSpeak=UIObject.get(self,7)
self.selfInfo=UIObject.get(self,8)
self.otherInfo=UIObject.get(self,9)
self.otherSpeakTxt=UIText.get(self,10)
self.InputSentence=UIInputField.get(self,11)



end


function UIQieCuoFightExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.selfHeadIcon);self.selfHeadIcon=nil;
_UIObject_release(self.selfHeadKuang);self.selfHeadKuang=nil;
_UIObject_release(self.selfSpeak);self.selfSpeak=nil;
_UIObject_release(self.otherHeadIcon);self.otherHeadIcon=nil;
_UIObject_release(self.otherHeadKuang);self.otherHeadKuang=nil;
_UIObject_release(self.selfSpeakTxt);self.selfSpeakTxt=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.editSpeak);self.editSpeak=nil;
_UIObject_release(self.selfInfo);self.selfInfo=nil;
_UIObject_release(self.otherInfo);self.otherInfo=nil;
_UIObject_release(self.otherSpeakTxt);self.otherSpeakTxt=nil;
_UIObject_release(self.InputSentence);self.InputSentence=nil;
end

















local this


function UIQieCuoFightExtraWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIQieCuoFightExtraWin:__delete()
self:unbindComponents()
end




function UIQieCuoFightExtraWin:onShow(argtable,afterOnloaded)
local lookType=argtable[1]
local actorId=argtable[2]
local otherSpeakStr=argtable[3]or''
self.otheractorid=argtable[4]
self.editSpeak:setActive(lookType==DOUFATAI_LOOK_TYPE.eSelf)
self.otherInfo:setActive(lookType~=DOUFATAI_LOOK_TYPE.eSelf)
self.selfSpeak:setActive(lookType~=DOUFATAI_LOOK_TYPE.eSelf)
self.selfInfo:setActive(lookType==DOUFATAI_LOOK_TYPE.eSelf or lookType==DOUFATAI_LOOK_TYPE.eBeatBack or lookType==DOUFATAI_LOOK_TYPE.eChallenge)
self:refreshSelfInfo(lookType)
if lookType==DOUFATAI_LOOK_TYPE.eSelf then

local doufataiData=douFaTaiModel:get_doufatai_data()
local selfSpeakStr='无尽岁月，未尝一败！'






self.InputSentence:setInputFieldValue(selfSpeakStr)
else
self:refreshOtherInfo(lookType,actorId,otherSpeakStr)
end
end


function UIQieCuoFightExtraWin:onHide()

end

function UIQieCuoFightExtraWin:getInputStr()
local editStr=self.InputSentence:getInputFieldValue()
return editStr
end

function UIQieCuoFightExtraWin:refreshSelfInfo(lookType)











playerController:setHeadIcon(self.winid,self.selfHeadIcon:getID(),{scale=0.7})

if lookType~=DOUFATAI_LOOK_TYPE.eSelf then
local config=douFaTaiModel:getDouFaTaiBasicConfig()

local doufataiData=douFaTaiModel:get_doufatai_data()
local selfSpeakStr='无尽岁月，未尝一败！'




self.selfSpeakTxt:setText(selfSpeakStr)
end
end

function UIQieCuoFightExtraWin:refreshOtherInfo(lookType,actorId,otherSpeakStr)
local actorInfo,index
if lookType==DOUFATAI_LOOK_TYPE.eBeatBack or lookType==DOUFATAI_LOOK_TYPE.eRecord then
actorInfo=douFaTaiModel:getRecordActorInfo(actorId)
elseif lookType==DOUFATAI_LOOK_TYPE.eRank or lookType==DOUFATAI_LOOK_TYPE.eMain then
actorInfo=douFaTaiModel:getRankActorInfo(actorId)
else
index,actorInfo=douFaTaiModel:getChallengeActorIndex(actorId)
if otherSpeakStr==''then
otherSpeakStr=douFaTaiModel:getPiPeiActoreSpeak(index)
end
end
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local defaults=config.sentence


local otheractordata=otherPlayerModel:getActorData(this.otheractorid).iconInfo
if otheractordata then
if otheractordata and otheractordata.actoricon~=0 then
playerController:setHeadIcon(self.winid,self.otherHeadIcon:getID(),{scale=0.7,iconInfo=otheractordata})
else
local otherHead,otherKuang=douFaTaiModel:getDouFaTaiActorInfo(otheractordata)
local iconInfo=playerModel:getActorIconInfoByCfg(otherHead,otherKuang)
playerController:setHeadIcon(self.winid,self.otherHeadIcon:getID(),{scale=0.7,iconInfo=iconInfo})
end


if otherSpeakStr==''then
local rand=math.random(1,#defaults)
otherSpeakStr=defaults[rand]
end
self.otherSpeakTxt:setText(otherSpeakStr)
end
end

function UIQieCuoFightExtraWin:onClickInput()
self.Placeholder:setText('')
end



function UIQieCuoFightExtraWin:onCheckStringLegal(str,legalStr)
local guidList,speakStr=douFaTaiModel:getTemporaryData()
if legalStr~=speakStr then
UIManager.error('助战语中含有敏感字符')
return
end
douFaTaiController:req_edit_defense(speakStr,#guidList,guidList)
end
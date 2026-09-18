







def_class("UIDZSpeakWin",UIWindowBase)









function UIDZSpeakWin:bindComponents()

self.UIDZSpeakWin=UIWindowLua.new(self,0)
self.root=UIObject.get(self,1)
self.dressToggle=UIToggleButton.get(self,2)
self.gainRoot=UIObject.get(self,3)
self.bagRoot=UIObject.get(self,4)
self.back=UIImage.get(self,5)
self.model=UIObject.get(self,6)
self.attrRoot=UIObject.get(self,7)
self.bookitem=UIBaseItem.get(self,8)
self.desc=UIText.get(self,9)
self.bagScrollView=UIScrollViewSlow.get(self,10)
self.gainScrollView=UIScrollView.get(self,11)
self.gainTitle=UIText.get(self,12)
self.ScrollView=UIScrollViewSlow.get(self,13)
self.dressToggleText=UIText.get(self,14)
self.dzname=UIText.get(self,15)
self.dzJobBtn=UIButton.get(self,16)
self.attr_3=UIText.get(self,17)
self.attr_2=UIText.get(self,18)
self.attr_1=UIText.get(self,19)
self.discipleJobIcon=UIImage.get(self,20)
self.mountName=UIText.get(self,21)
self.mask=UIObject.get(self,22)
self.discipleModelRoot=UIObject.get(self,23)
self.speakObj=UIObject.get(self,24)
self.speakText=UIText.get(self,25)
self.discipleModelRootnew=UIObject.get(self,26)
self.taskScroller=UIObject.get(self,27)
self.discipleJobIcon2=UIImage.get(self,28)
self.spBg=UIObject.get(self,29)

self.dzJobBtn:setButtonClick(function()self:onDzJobBtn()end)
self.attr={
self.attr_1,
self.attr_2,
self.attr_3,
}



end


function UIDZSpeakWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UIDZSpeakWin:deleteSelf();self.UIDZSpeakWin=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.gainRoot);self.gainRoot=nil;
_UIObject_release(self.bagRoot);self.bagRoot=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.bookitem);self.bookitem=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.gainTitle);self.gainTitle=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.dressToggleText);self.dressToggleText=nil;
_UIObject_release(self.dzname);self.dzname=nil;
_UIObject_release(self.dzJobBtn);self.dzJobBtn=nil;
_UIObject_release(self.attr_3);self.attr_3=nil;
_UIObject_release(self.attr_2);self.attr_2=nil;
_UIObject_release(self.attr_1);self.attr_1=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.mountName);self.mountName=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.discipleModelRootnew);self.discipleModelRootnew=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
self.attr=nil;
end

















local _this
local abname='ui/windows/dizispeak/dizispeak_atlas_pak.ab'


function UIDZSpeakWin:onLoaded(...)
self:bindComponents()
_this=self
self.notearry={'note_1','note_2','note_3','note_4','note_5','note_6','note_7'}
end


function UIDZSpeakWin:__delete()
self:unbindComponents()
if _this.ProgressTimeId then
_this:stopTimerByID(_this.ProgressTimeId)
_this.ProgressTimeId=nil
end
roleAudioController:stopRoleSpeak()
_this=nil
end




function UIDZSpeakWin:onShow(argtable,afterOnloaded)
local guid=argtable.guid
self.disciple_guid=guid
_this.voiceData={}
local diziid=UIDiscipleModel:getDiscipleID(guid)
if diziid then
local netData=UIDiscipleModel:getDiscipleData(guid)
local disguise=netData.disguise
if disguise and disguise>0 then
diziid=disguise
end
local cfg_voice=cfg_jianwendisciplevoiceconfig_get(diziid)
if cfg_voice then

_this.voiceData=cfg_voice.voicearry
self.selectidx=1
self.isplayingidx=0
self:clearSpeakProgress()
roleAudioController:stopRoleSpeak()

self:discipleModel()
self:refreshRightVoice()


self:onClickBtn(1,_this.voiceData[1])
else





end
end
end


function UIDZSpeakWin:onHide()

end





function UIDZSpeakWin:onDzJobBtn()
end


function UIDZSpeakWin:discipleModel()


local args={isNotBg=true}

comHelper.setChildInSideModel(_this.discipleModelRoot,_this.disciple_guid,nil,nil,0,-15,false,true)

_this.dzname:setText(UIDiscipleModel:getDiscipleName(_this.disciple_guid))

local jobicon=UIDiscipleModel:getJobIconNameX(_this.disciple_guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(_this.disciple_guid)
_this.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
_this.discipleJobIcon2:setActive(isSPdz)
_this.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(_this.disciple_guid,switchidx)
_this.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
_this.discipleJobIcon:setChildAnchoredPos(7,10)
local scale=54/68
_this.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
_this.discipleJobIcon:setChildAnchoredPos(0,0)
_this.discipleJobIcon:setScale(Vector3.one)
end
end


function UIDZSpeakWin:refreshRightVoice()

local dataNum=#_this.voiceData
if dataNum<=0 then
_this.taskScroller:setActive(false)
else
_this.taskScroller:setActive(true)
_this.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local item=grids[i-1]
local _data=_this.voiceData[i]
if item then



local desc=_data[2]or'触碰'
item:SetChildText(4,desc)
item:SetChildCSImageSprite(3,abname,"icon_diziyuyinui_1")
item:SetChildCSImageSprite(1,abname,"image_diziyuyinui_1")
item:SetChildProgressValue(1,0,1)
item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onClickBtn(i,_data)
end)
end
end

end
end


function UIDZSpeakWin:onClickBtn(index,_data)

if _this.isplayingidx==index then

local gridsthis=_this.taskScroller:getChildScrollViewItemWidgets()
local thisItem=gridsthis[_this.isplayingidx-1]
if _this.askforTween~=nil then
if not _this.askforTween:IsComplete()then
_this.askforTween:OnComplete(nil)
_this.askforTween:Complete()
end
_this.askforTween=nil
end
thisItem:SetChildProgressValue(1,0,1)
thisItem:SetChildCSImageSprite(3,abname,"icon_diziyuyinui_1")
thisItem:SetChildCSImageSprite(1,abname,"image_diziyuyinui_2")
_this.selectidx=_this.isplayingidx
_this.isplayingidx=0
roleAudioController:stopRoleSpeak()

elseif _this.isplayingidx~=index then
local old=_this.isplayingidx
if old>0 then
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local oldItem=grids[old-1]

if _this.askforTween~=nil then
if not _this.askforTween:IsComplete()then
_this.askforTween:OnComplete(nil)
_this.askforTween:Complete()
end
_this.askforTween=nil
end
oldItem:SetChildProgressValue(1,0,1)
oldItem:SetChildCSImageSprite(3,abname,"icon_diziyuyinui_1")
oldItem:SetChildCSImageSprite(1,abname,"image_diziyuyinui_1")
_this.isplayingidx=0
roleAudioController:stopRoleSpeak()
end

local oldselectidx=_this.selectidx
local oldselectidxItem=nil
if oldselectidx>0 then
local oldselectidxgrids=_this.taskScroller:getChildScrollViewItemWidgets()
oldselectidxItem=oldselectidxgrids[oldselectidx-1]
oldselectidxItem:SetChildProgressValue(1,0,1)
oldselectidxItem:SetChildCSImageSprite(1,abname,"image_diziyuyinui_1")
end

_this.isplayingidx=index
_this.selectidx=_this.isplayingidx

local grids2=_this.taskScroller:getChildScrollViewItemWidgets()
local newItem=grids2[_this.isplayingidx-1]

_this:playRoleSpeakVoice(_data[1])
_this:chooseSpeakTxtShow(_data[1])
_this:handelSpeakProgress(newItem,_data[3],oldselectidxItem)
end
end


function UIDZSpeakWin:clearSpeakProgress()
if _this.ProgressTimeId then
_this:stopTimerByID(_this.ProgressTimeId)
_this.ProgressTimeId=nil
end
end

function UIDZSpeakWin:handelSpeakProgress(newItem,voiceTime,oldselectidxItem)
if _this.isplayingidx==0 then return end

local times=voiceTime or 5

if _this.askforTween~=nil then
if not _this.askforTween:IsComplete()then
_this.askforTween:OnComplete(nil)
_this.askforTween:Complete()
end
_this.askforTween=nil
end
local func=function()
if _this==nil then return end
_this.askforTween=nil

_this:clearSpeakProgress()
newItem:SetChildProgressValue(1,0,1)
newItem:SetChildCSImageSprite(3,abname,"icon_diziyuyinui_1")
newItem:SetChildCSImageSprite(1,abname,"image_diziyuyinui_2")
_this.isplayingidx=0
roleAudioController:stopRoleSpeak()
end
_this.askforTween=newItem:SetChildImageDOFillAmount(5,1,times,func)
_this.askforTween:SetEase(_Ease.Linear)
newItem:SetChildCSImageSprite(3,abname,"icon_diziyuyinui_2")
newItem:SetChildCSImageSprite(1,abname,"image_diziyuyinui_2")
end


function UIDZSpeakWin:chooseSpeakTxtShow(voiceID)


local yinxiaoID=voiceID or 1
local rolespeaktxt="展示气泡展示气泡展示气泡"
local speaktxtdata=cfg_soundconfig_get(yinxiaoID)
if speaktxtdata and speaktxtdata.speaktxt then
rolespeaktxt=speaktxtdata.speaktxt
end

UIDZSpeakWin:doSpeaking(rolespeaktxt)
end
function UIDZSpeakWin:doSpeaking(rolespeaktxt)
local speakStr=rolespeaktxt
local speed=30
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
_this:doTalkAnim()
end
function UIDZSpeakWin:doTalkAnim()
if _this.talkTween~=nil then
_this.talkTween:Kill()
_this.talkTween=nil
end
_this.speakObj:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.talkTween=_this.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end


function UIDZSpeakWin:playRoleSpeakVoice(yinxiaoID)
roleAudioController:playRoleSpeakByVoiceid(yinxiaoID)

end
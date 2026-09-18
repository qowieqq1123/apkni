







def_class("UIDialougeXianZhantips",UIWindowBase)









function UIDialougeXianZhantips:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.handleImg=UIObject.get(self,1)
self.maxCnt=UIButton.get(self,2)
self.subBtn=UIButton.get(self,3)
self.addBtn=UIButton.get(self,4)
self.cancelText=UIText.get(self,5)
self.okText=UIText.get(self,6)
self.selectCntText=UIText.get(self,7)
self.cancelButton=UIButton.get(self,8)
self.okButton=UIButton.get(self,9)
self.titleText=UIText.get(self,10)
self.linkImageText1=UILinkImageText.get(self,11)
self.linkImageText2=UILinkImageText.get(self,12)
self.sliderRoot=UIObject.get(self,13)
self.selectCntSlider=UIObject.get(self,14)
self.tipsRoot=UIButton.get(self,15)
self.tipsPanel=UIObject.get(self,16)
self.tipsTx=UIText.get(self,17)
self.tipsBtn=UIButton.get(self,18)
self.fightSaveMode=UIToggleButton.get(self,19)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeXianZhantips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.linkImageText1);self.linkImageText1=nil;
_UIObject_release(self.linkImageText2);self.linkImageText2=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.fightSaveMode);self.fightSaveMode=nil;
end

















local _this


function UIDialougeXianZhantips:onLoaded(...)
self:bindComponents()
_this=self
self.fightSaveMode:setToggleChange(function(name,isOn)
self:onToggleChangetips(1,isOn)
end)
end


function UIDialougeXianZhantips:__delete()
self:unbindComponents()
end




function UIDialougeXianZhantips:onShow(argtable,afterOnloaded)

self.okText:setText('确认')
self.cancelText:setText('取消')
self.allow=false
self.fightSaveMode:setToggle(self.allow)
if argtable then
self.titleText:setText(argtable.title)

local buildname=argtable.buildname
local costid=argtable.costid
local haveCnt=0
if moneyConfig.isMoney(costid)then
haveCnt=moneyModel.getMoney(costid)
else
haveCnt=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
end
local needCnt=argtable.needCnt
local colorStr=haveCnt>=needCnt and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costid)
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,mathHelper.formatNumber2(needCnt),iconStr)
local contentStr=FMT.fmt('是否花费{0}改建<color=#7D3B17>{1}</color>',costStr,buildname)
self.linkImageText1:setText(contentStr)

self.roomId=argtable.thisroomId
self.rebuildRoomType=argtable.thisrebuildRoomType








end
end



function UIDialougeXianZhantips:onHide()

end





function UIDialougeXianZhantips:onCloseBtn()

UIManager:closeWindow('UIDialougeXianZhantips')
end



function UIDialougeXianZhantips:onMaxCnt()
end



function UIDialougeXianZhantips:onSubBtn()
end



function UIDialougeXianZhantips:onAddBtn()
end



function UIDialougeXianZhantips:onCancelButton()

UIManager:closeWindow('UIDialougeXianZhantips')
end



function UIDialougeXianZhantips:onOkButton()
if _this.allow then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianZhanGaiJianTips,_this.allow)
end
if _this.roomId then
xianzhanController:req_room_rebuild(_this.roomId,_this.rebuildRoomType)
end
UIManager:closeWindow('UIDialougeXianZhantips')
end



function UIDialougeXianZhantips:onTipsRoot()
end



function UIDialougeXianZhantips:onTipsBtn()
end


function UIDialougeXianZhantips:onToggleChangetips(name,isOn)

_this.allow=isOn==true
end

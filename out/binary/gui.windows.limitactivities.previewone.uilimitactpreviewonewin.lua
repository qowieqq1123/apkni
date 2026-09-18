







def_class("UILimitActPreviewOneWin",UIWindowBase)









function UILimitActPreviewOneWin:bindComponents()

self.root=UIObject.get(self,0)
self.bgImg=UIImage.get(self,1)
self.iconImg=UIImage.get(self,2)
self.titleTxt=UIText.get(self,3)
self.title2Txt=UIText.get(self,4)
self.timeDescTxt=UIText.get(self,5)
self.gotoBtn=UIButton.get(self,6)
self.showToggle=UIToggleButton.get(self,7)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UILimitActPreviewOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.title2Txt);self.title2Txt=nil;
_UIObject_release(self.timeDescTxt);self.timeDescTxt=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.showToggle);self.showToggle=nil;
end
















local actConfig={
[LIMIT_ACT_TYPE.eTianYuanShouChao]={
bgicon='',
nameicon='',
descicon='',
},
[LIMIT_ACT_TYPE.eShiJieShouLing]=
{
bgicon='',
nameicon='',
descicon='',
},
}


function UILimitActPreviewOneWin:onLoaded(...)
self:bindComponents()
end


function UILimitActPreviewOneWin:__delete()
local flag=self.showToggle:getToggle()
self:unbindComponents()

if flag then
limitActivitiesController:markActPreview(self.actID)
end
end


function UILimitActPreviewOneWin:onHide()

end




function UILimitActPreviewOneWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.parentWin=argtable.parentWin

self:refershView()
end

function UILimitActPreviewOneWin:refershView()
local actCfg=limitActivitiesModel:getActConfig(self.actID)

local iconInfo,iconInfo2=limitActivitiesModel.getActBigIcon(self.actID)
self.iconImg:setSprite(iconInfo[1],iconInfo[2])

self.titleTxt:setText(actCfg.name)

self.title2Txt:setText('短描述')

local time_str=limitActivitiesModel:invokeMethod(self.actID,'getStartTimeDesc1')
time_str=FMT.fmt('今日 {0}开启',time_str)
self.timeDescTxt:setText(time_str)
end

function UILimitActPreviewOneWin:onCloseBtn()
UIManager:invokeUIMethod(self.parentWin,'onBlackBG')
end

function UILimitActPreviewOneWin:onGotoBtn()
limitActivitiesController:jump(self.actID)
end


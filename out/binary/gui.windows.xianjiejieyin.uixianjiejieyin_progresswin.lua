







def_class("UIXianJieJieYin_ProgressWin",UIWindowBase)









function UIXianJieJieYin_ProgressWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.content=UIObject.get(self,2)
self.desc=UIText.get(self,3)
self.nextBtn=UIButton.get(self,4)
self.nextBtnDesc=UIText.get(self,5)
self.picture=UIObject.get(self,6)
self.Root=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)



end


function UIXianJieJieYin_ProgressWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.nextBtnDesc);self.nextBtnDesc=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end















local _this

local _showUIRootTime=0.2
local _showUIRootDuration=1

local _testProgressList={
{439,"插画进程1","按钮描述1"},
{440,"插画进程2","按钮描述2"},
{441,"插画进程3","按钮描述2"},
{442,"插画进程4","完成"},
}




function UIXianJieJieYin_ProgressWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieJieYin_ProgressWin:__delete()
self:unbindComponents()
end




function UIXianJieJieYin_ProgressWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgSpine:setChildUIModelShowTarget(6038,1,{},eAnimationID.enter)

self.uiRoot:setChildCanvasGroupAlpha(0)
self:delayDo(_showUIRootTime,function()
self.uiRoot:setChildCanvasGroupDOFade(1,_showUIRootDuration)
end)
end

self.isFull=argtable and argtable.isFull

self.curIndex=1
self.progressList=cfgHelper.get2(cfg_jctjbaseconfig_get,1,'guideProgressPlot')
self.maxIndex=#self.progressList

self:showInfo()
end


function UIXianJieJieYin_ProgressWin:onHide()

end

function UIXianJieJieYin_ProgressWin:checkSHowNext()
return self.curIndex<self.maxIndex
end

function UIXianJieJieYin_ProgressWin:playAnim()
self.content:setChildCanvasGroupDOFade(0,0.4,function()
self:showInfo()
self.content:setChildCanvasGroupDOFade(1,0.4)
end)
end

function UIXianJieJieYin_ProgressWin:showInfo()
local info=self.progressList[self.curIndex]
local iconName=iconHelper.getEventChahuaIcon(info[1])
self.picture:setChildIcon(iconName,true)
self.desc:setText(self:replaceDesc(info[2]))
self.nextBtnDesc:setText(info[3])
end

function UIXianJieJieYin_ProgressWin:onFinish()

jumpManager:jump({id=JUMP_TYPE.eJiuChongTianJie,args={sysType=JIUCHONGTIANJIE_SYS_TYPE.eZhuXieMo,additionalWin='UIXianJieJieYin_FinishWin'}})
end





function UIXianJieJieYin_ProgressWin:onCloseBtn()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end



function UIXianJieJieYin_ProgressWin:onNextBtn()
if self:checkSHowNext()then
self.curIndex=self.curIndex+1
self:playAnim()
else

self:onFinish()
end
end



function UIXianJieJieYin_ProgressWin:replaceDesc(desc)
local supportActorData=jiuchongtianjieGuideModel:getGuideActorInfo()
local actorName=playerModel:getOtherActorName(supportActorData.actorname)
desc=string.gsub(desc,'%[NAME%]',actorName)
return desc
end
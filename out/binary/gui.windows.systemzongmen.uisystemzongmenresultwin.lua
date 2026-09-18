







def_class("UISystemZongMenResultWin",UIWindowBase)









function UISystemZongMenResultWin:bindComponents()

self.root=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.bgModel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.contentRoot=UIObject.get(self,4)
self.contentImg=UIImage.get(self,5)
self.contentTx=UIText.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISystemZongMenResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.contentRoot);self.contentRoot=nil;
_UIObject_release(self.contentImg);self.contentImg=nil;
_UIObject_release(self.contentTx);self.contentTx=nil;
end
















local _this=nil
local _effect={
[systemZongMenResultType.eSuccess]={10060,2},
[systemZongMenResultType.eExcape]={10064,3},
[systemZongMenResultType.eExpel]={10064,3},
[systemZongMenResultType.eCapture]={10064,3},
}
local _jump={
[systemZongMenFuncType.eZaoYao]=false,
[systemZongMenFuncType.eTaYin]=true,
}



function UISystemZongMenResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenResultWin:onShow(argtable,afterOnloaded)
self.result=argtable.result
self.funcType=argtable.funcType
self.param=argtable.param
self.callback=argtable.callback

local lib
local cfg=cfgHelper.get1(cfg_syssectresultconfig_get,self.funcType)
if self.result==systemZongMenResultType.eSuccess then
local list=cfg.success
local seed=math.random(1,#list)
lib=list[seed]
else
lib=cfg.fail[self.result]
end
local libCfg=cfgHelper.get1(cfg_syssectresultlibconfig_get,lib)
local str=FMT.fmt(libCfg.text,self.param[1],self.param[2],self.param[3],self.param[4],self.param[5])
self.contentImg:setIcon(libCfg.image,true)
self.contentTx:setText(str)

local strId=cfg.chat[self.result+1]
libCfg=cfgHelper.get1(cfg_syssectresultlibconfig_get,strId)
str=FMT.fmt(libCfg.text,self.param[1],self.param[2],self.param[3],self.param[4],self.param[5])
chatControl.addJianWenMesg(0,str)

if _jump[self.funcType]then
self:effectShow()
else
self:startShow()
end
end


function UISystemZongMenResultWin:onHide()

end




function UISystemZongMenResultWin:onCloseBtn()
if self.enabled then
self:closeShow()
end
end

function UISystemZongMenResultWin:doClose()
if self.callback then
self.callback()
else
self:closeSelf()
end
end

function UISystemZongMenResultWin:startShow()
self.bgModel:setActive(true)
self.bgModel:setChildModelAnimationState(eAnimationID.juanzhoubi_dakai)
self:delayDo(1,function()
self.contentRoot:setChildCanvasGroupDOFade(1,0.5,function()
self.enabled=true
end)
end)
end

function UISystemZongMenResultWin:closeShow()
self.enabled=false
self.bgModel:setChildModelAnimationState(2068)
self.contentRoot:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
self.bgModel:setActive(false)
self:effectShow()
end)
end

function UISystemZongMenResultWin:effectShow()
self.root:setActive(false)
local effectData=_effect[self.result]
self.effect:setChildShowEffect(effectData[1],true)
self:delayDo(effectData[2],function()
self:doClose()
end)
end

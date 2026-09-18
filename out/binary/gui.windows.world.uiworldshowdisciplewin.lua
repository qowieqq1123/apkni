







def_class("UIWorldShowDiscipleWin",UIWindowBase)









function UIWorldShowDiscipleWin:bindComponents()

self.Root=UIButton.get(self,0)
self.modelImage=UIObject.get(self,1)
self.NameTx=UIText.get(self,2)
self.JobTx=UIText.get(self,3)
self.DescImg=UIImage.get(self,4)
self.modelObj=UIObject.get(self,5)

self.Root:setButtonClick(function()self:onRoot()end)



end


function UIWorldShowDiscipleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.NameTx);self.NameTx=nil;
_UIObject_release(self.JobTx);self.JobTx=nil;
_UIObject_release(self.DescImg);self.DescImg=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
end
















local _need_flipX={
[discipleSrcType.ePlot2]=true
}




function UIWorldShowDiscipleWin:onLoaded(...)
self:bindComponents()
end


function UIWorldShowDiscipleWin:__delete()
self:unbindComponents()





end




function UIWorldShowDiscipleWin:onShow(argtable,afterOnloaded)
self.disciple=argtable.disciple
self.callback=argtable.callback
local scr=UIDiscipleModel:getDiscipleSrcType(self.disciple)
local scrCfg=cfgHelper.get1(cfg_disciplesourcedescconfig_get,scr)
self.NameTx:setText(UIDiscipleModel:getDiscipleName(self.disciple))
self.JobTx:setText(UIDiscipleModel:getJobName(UIDiscipleModel:getDiscipleJob(self.disciple)))
if scrCfg and scrCfg.desc then
self.DescImg:setSprite("ui/windows/world/sharedtextures/dashijie_showdisciple_altas.ab",scrCfg.desc)
end
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.disciple)
if image then
self.modelImage:setChildUIModelShowTarget(image.body,image.scale,image.componets,0)

else
loggerUtil.logErrFMT("没有弟子GUID:{0}",tostring(self.disciple))
end
end


function UIWorldShowDiscipleWin:onHide()

end





function UIWorldShowDiscipleWin:onRoot()
local cb=self.callback
UIFullStoryBoardControl:closeUI()
if cb then
cb()
end
end


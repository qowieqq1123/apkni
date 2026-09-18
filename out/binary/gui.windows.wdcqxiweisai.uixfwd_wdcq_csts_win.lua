







def_class("UIXFWD_WDCQ_CSTS_Win",UIWindowBase)









function UIXFWD_WDCQ_CSTS_Win:bindComponents()

self.Root=UIObject.get(self,0)
self.grouptxt=UIText.get(self,1)
self.targettxt=UIText.get(self,2)
self.levelIcon=UIImage.get(self,3)
self.icon=UIImage.get(self,4)
self.bgmodel=UIObject.get(self,5)



end


function UIXFWD_WDCQ_CSTS_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.grouptxt);self.grouptxt=nil;
_UIObject_release(self.targettxt);self.targettxt=nil;
_UIObject_release(self.levelIcon);self.levelIcon=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
end



















function UIXFWD_WDCQ_CSTS_Win:onLoaded(...)
self:bindComponents()
self.abName='ui/windows/xianfawendao/xfwd_atlas_pak.ab'
self.levelIcons={
'icon_zongmendjhz_4',
'icon_zongmendjhz_3',
'icon_zongmendjhz_2',
'icon_zongmendjhz_1',
}
self.levelname={
'黄阶',
'玄阶',
'地阶',
'天阶',
}
self.bgmodel:setChildUIModelShowTarget(5642,1,nil,eAnimationID.enter,false,false,0,function()end)
self:delayDo(0.4,function()
self.Root:setChildCanvasGroupDOFade(1,0.5,function()end)
end)
end


function UIXFWD_WDCQ_CSTS_Win:__delete()
self:unbindComponents()
end




function UIXFWD_WDCQ_CSTS_Win:onShow(argtable,afterOnloaded)
local cfgxfwdstage=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'wfwd_stage')
self.levelIcon:setSprite(self.abName,self.levelIcons[cfgxfwdstage])
local icon=UIXianFaWenDaoControl:getScoreIconName()
self.icon:setChildIcon(icon,true)
self.grouptxt:setText(self.levelname[cfgxfwdstage])
local scores=UIXianFaWenDaoControl:getScore()
local gcfg=cfgHelper.get1(cfg_xianfawendaoscoreconfig_get,cfgxfwdstage)
local flag=scores>=gcfg.min
local str=FMT.fmt(flag and"{0}/{1}"or"<color=#171311>{0}/</color>{1}",scores,gcfg.min)
self.targettxt:setText(str)
self.levelIcon:setGray(not flag)
end



function UIXFWD_WDCQ_CSTS_Win:onHide()

end




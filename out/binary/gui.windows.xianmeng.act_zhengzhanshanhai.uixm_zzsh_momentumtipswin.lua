







def_class("UIXM_ZZSH_MomentumTipsWin",UIWindowBase)









function UIXM_ZZSH_MomentumTipsWin:bindComponents()

self.root=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.progressBar=UIProgressBarAni.get(self,2)
self.progressVal=UIText.get(self,3)
self.zengyiEffectText=UIText.get(self,4)
self.cengshuvalue=UIText.get(self,5)
self.TipsPanel=UIObject.get(self,6)



end


function UIXM_ZZSH_MomentumTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressVal);self.progressVal=nil;
_UIObject_release(self.zengyiEffectText);self.zengyiEffectText=nil;
_UIObject_release(self.cengshuvalue);self.cengshuvalue=nil;
_UIObject_release(self.TipsPanel);self.TipsPanel=nil;
end



















local descparmlen=
{
one=1,
two=2,
three=3,
}

function UIXM_ZZSH_MomentumTipsWin:onLoaded(...)
self:bindComponents()
self.ruleTipsShow=false
end


function UIXM_ZZSH_MomentumTipsWin:__delete()
self:unbindComponents()
end

local zeroSesc="与其他仙盟仙阵战斗时，仙阵所有弟子造成的伤害暂无增幅"



function UIXM_ZZSH_MomentumTipsWin:onShow(argtable,afterOnloaded)
local MomentNum=zhengzhanshanhaiModel:getMomentNum()

self.MomentumCfg=zhengzhanshanhaiController:getZZSHCfg('momentum')
self.cengshuindex=0
for i=#self.MomentumCfg[2],1,-1 do
local v=self.MomentumCfg[2][i]
if MomentNum>=v[1]then
self.cengshuindex=#self.MomentumCfg[2]-i+1
end
end
if self.cengshuindex>#self.MomentumCfg[2]then
self.cengshuindex=#self.MomentumCfg[2]
end

local desc=zeroSesc
if self.cengshuindex~=0 then
self.cengshuBuff=self.MomentumCfg[2][self.cengshuindex][2][1]
local ruleCfg=cfgHelper.getSSlawRule(self.cengshuBuff[1])
desc=ruleCfg.desc
if ruleCfg.descparm then
desc=string.format(desc,tostring(ruleCfg.descparm[self.cengshuindex][1]))
end
end

self.cengshuvalue:setText(self.cengshuindex)
self.zengyiEffectText:setText(desc)



self.bgModel:setChildUIModelShowTarget(5288,1,{},0,false,false,0.3,function()
self:delayDo(0.3,function()

end)
end)
end


function UIXM_ZZSH_MomentumTipsWin:onHide()

end




function UIXM_ZZSH_MomentumTipsWin:onCloseClick()
self:closeSelf()
end

function UIXM_ZZSH_MomentumTipsWin:ruleTipsClick()
self.ruleTipsShow=not self.ruleTipsShow
self.TipsPanel:setActive(self.ruleTipsShow)
end

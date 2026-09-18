







def_class("UIXM_LXWJ_result_win",UIWindowBase)









function UIXM_LXWJ_result_win:bindComponents()

self.desc1Txt=UIText.get(self,0)
self.desc2Txt=UIText.get(self,1)
self.desc3Txt=UIText.get(self,2)
self.desc4Txt=UIText.get(self,3)
self.desc4Icon=UIImage.get(self,4)



end


function UIXM_LXWJ_result_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.desc3Txt);self.desc3Txt=nil;
_UIObject_release(self.desc4Txt);self.desc4Txt=nil;
_UIObject_release(self.desc4Icon);self.desc4Icon=nil;
end

















function UIXM_LXWJ_result_win:onLoaded(...)
self:bindComponents()
end


function UIXM_LXWJ_result_win:__delete()
self:unbindComponents()
end


function UIXM_LXWJ_result_win:onHide()

end




function UIXM_LXWJ_result_win:onShow(argtable,afterOnloaded)
local data=argtable.data
self.parentWin=argtable.parentWin
local lxwjtype=data.lxwjtype
local lxwjkey=data.lxwjkey
local score=data.score
local result=data.result

local desc1
local desc2
local desc3
local desc4
local icon4
if result==1 then
desc1='击败敌方防守阵容。'
elseif result==2 then
desc1='观察战斗过程，总结失败要点，胜利尽在眼前。'
else
desc1='酣战已久，你与敌方最终战至平局。'
end
if lingxuwenjianModel:checkInDef()then
if score>0 then
desc2=FMT.fmt('仙盟积分+{0}',score)
desc3=FMT.fmt('个人积分+{0}',score)
elseif score<0 then
desc2=FMT.fmt('仙盟积分{0}',score)
desc3=FMT.fmt('个人积分{0}',score)
end
end
local rewards=cfgHelper.get5(cfg_lingxuwenjianconfig_get,1,'reward',1,2,result)
local money
if rewards~=nil then
money=rewards[1]
end
if money then
icon4=money[1]
desc4=FMT.fmt('{0}+{1}',moneyModel.getMoneyName(money[1]),money[2])
end

self.desc1Txt:setActive(desc1~=nil)
if desc1~=nil then
self.desc1Txt:setText(desc1)
end
self.desc2Txt:setActive(desc2~=nil)
if desc2~=nil then
self.desc2Txt:setText(desc2)
end
self.desc3Txt:setActive(desc3~=nil)
if desc3~=nil then
self.desc3Txt:setText(desc3)
end
self.desc4Txt:setActive(desc4~=nil)
if desc4~=nil then
self.desc4Txt:setText(desc4)
self.desc4Icon:setImageIcon(moneyModel.getIconNameEx(icon4),false)
end

if self.parentWin~=nil then
UIManager:invokeUIMethod(self.parentWin,'setCloudClose')
lingxuwenjianController:setMarkCloud(true)
end
end

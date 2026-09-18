







def_class("UIMoJie_ZongMenMoveTipsWin",UIWindowBase)









function UIMoJie_ZongMenMoveTipsWin:bindComponents()

self.numTx=UIText.get(self,0)



end


function UIMoJie_ZongMenMoveTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.numTx);self.numTx=nil;
end



















function UIMoJie_ZongMenMoveTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMoJie_ZongMenMoveTipsWin:__delete()
self:unbindComponents()
end




function UIMoJie_ZongMenMoveTipsWin:onShow(argtable,afterOnloaded)
local cur=xianjieModel:getMoJieZongMenMoveCount()
local configs=cfgHelper.get2(cfg_devildombaseconfig_get,1,"actormove")
local max=0
for i,v in ipairs(configs)do
if next(v)==nil then
max=max+1
else
break
end
end
cur=Mathf.Min(cur,max)
local least=max-cur
if least<=0 then
least=FMT.cfmt1(FONT_COLOR.eRedColor,tostring(least))
end
self.numTx:setText(FMT.fmt("本日剩余：{0}/{1}",least,max))
end


function UIMoJie_ZongMenMoveTipsWin:onHide()

end




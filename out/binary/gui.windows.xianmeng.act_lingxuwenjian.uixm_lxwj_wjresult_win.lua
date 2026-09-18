







def_class("UIXM_LXWJ_wjresult_win",UIWindowBase)









function UIXM_LXWJ_wjresult_win:bindComponents()

self.desc1Txt=UIText.get(self,0)



end


function UIXM_LXWJ_wjresult_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
end

















function UIXM_LXWJ_wjresult_win:onLoaded(...)
self:bindComponents()
end


function UIXM_LXWJ_wjresult_win:__delete()
self:unbindComponents()
end


function UIXM_LXWJ_wjresult_win:onHide()

end




function UIXM_LXWJ_wjresult_win:onShow(argtable,afterOnloaded)
local data=argtable.data
self.parentWin=argtable.parentWin
local src=data[1]
local lxwjtype=data[2]
local lxwjkey=data[3]
local result=data[4]

local desc1
local fightState=lingxuwenjianModel:getFightState()
local str_fmt='下轮问剑将于<color=#171311>{0}</color>开启'
if fightState==eLXWJ_Fight_State.eWJ1 then
desc1=FMT.fmt(str_fmt,lingxuwenjianModel:getWJTFightTimeDesc(2))
elseif fightState==eLXWJ_Fight_State.eWJ2 then
desc1=FMT.fmt(str_fmt,lingxuwenjianModel:getWJTFightTimeDesc(3))
else
desc1='三轮问剑已全部结束'
end
self.desc1Txt:setActive(desc1~=nil)
if desc1~=nil then
self.desc1Txt:setText(desc1)
end

if self.parentWin~=nil then
UIManager:invokeUIMethod(self.parentWin,'setCloudClose')
lingxuwenjianController:setMarkCloud(true)
end
end









def_class("UIXM_ZZSH_ldSelectWin",UIWindowBase)









function UIXM_ZZSH_ldSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.ldInfoBtn=UIButton.get(self,1)
self.xmInfoBtn=UIButton.get(self,2)

self.ldInfoBtn:setButtonClick(function()self:onLdInfoBtn()end)

self.xmInfoBtn:setButtonClick(function()self:onXmInfoBtn()end)



end


function UIXM_ZZSH_ldSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ldInfoBtn);self.ldInfoBtn=nil;
_UIObject_release(self.xmInfoBtn);self.xmInfoBtn=nil;
end

















function UIXM_ZZSH_ldSelectWin:onLoaded(...)
self:bindComponents()
end


function UIXM_ZZSH_ldSelectWin:__delete()
self:unbindComponents()
end


function UIXM_ZZSH_ldSelectWin:onHide()

end




function UIXM_ZZSH_ldSelectWin:onShow(argtable,afterOnloaded)
self.cfgID=argtable.cfgID
local moveX=argtable.moveX
local moveY=argtable.moveY
self.root:setLocalPos(moveX+50,moveY,0)
end

function UIXM_ZZSH_ldSelectWin:onLdInfoBtn()
UIManager:showWindow('UIXM_ZZSH_lindiWin',{cfgID=self.cfgID})
self:closeSelf()
end

function UIXM_ZZSH_ldSelectWin:onXmInfoBtn()
local ldData=zhengzhanshanhaiModel:getLDData(self.cfgID)
local xmData
if ldData then
xmData=ldData:getXM()
end
local hasXM=xmData~=nil
if hasXM then
zhengzhanshanhaiController:openXMDetailInfoWin(ldData.guildid)
end
self:closeSelf()
end

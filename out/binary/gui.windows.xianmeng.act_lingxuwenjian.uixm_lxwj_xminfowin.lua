







def_class("UIXM_LXWJ_XMInfoWin",UIWindowBase)









function UIXM_LXWJ_XMInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.infoPanel=UIObject.get(self,1)



end


function UIXM_LXWJ_XMInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
end

















function UIXM_LXWJ_XMInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXM_LXWJ_XMInfoWin:__delete()
self:unbindComponents()
end


function UIXM_LXWJ_XMInfoWin:onHide()

end




function UIXM_LXWJ_XMInfoWin:onShow(argtable,afterOnloaded)
local pos=argtable.pos
self.root:setChildLocalPosition(Vector3.New(pos.x,pos.y,0))
local needRefresh=lingxuwenjianModel:checkRefreshEnemyXMInfo()
if not needRefresh then
self:refreshView()
else
self.root:setActive(false)
end
end

function UIXM_LXWJ_XMInfoWin:refreshView()
self.root:setActive(true)
local widget=self.infoPanel:getWidgetBase()

local info=lingxuwenjianModel:getEnemyXMInfo()






local leadername=FMT.fmt('盟主：<color=#f7f7f7>{0}</color>',info.leadername)
widget:SetChildText(0,leadername)

local rank_str
local rank=info.rank
if rank==0 then
rank_str='未上榜'
else
rank_str=tostring(rank)
end
rank_str=FMT.fmt('仙盟排名：<color=#f7f7f7>{0}</color>',rank_str)
widget:SetChildText(1,rank_str)

local fight_str=FMT.fmt('仙盟总战力：<color=#f7f7f7>{0}</color>',tostring(info.memberfight_num))
widget:SetChildText(2,fight_str)

local rate_str=FMT.fmt('仙盟胜率：<color=#f7f7f7>{0}%</color>',info.winrate/100)
widget:SetChildText(3,rate_str)
end


function UIXM_LXWJ_XMInfoWin:rec_xmInfo()
self:refreshView()
end

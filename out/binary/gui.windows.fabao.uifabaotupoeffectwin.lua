







def_class("UIFabaoTuPoEffectWin",UIWindowBase)









function UIFabaoTuPoEffectWin:bindComponents()

self.rewardGrid=UIObject.get(self,0)
self.rewadProgress=UIObject.get(self,1)



end


function UIFabaoTuPoEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
end


















function UIFabaoTuPoEffectWin:onLoaded(...)
self:bindComponents()
end

function UIFabaoTuPoEffectWin:__delete()
self:unbindComponents()
end

function UIFabaoTuPoEffectWin:onShow(argtable,afterOnloaded)
local itemguid=argtable.itemguid
local item=fabaoHelper.getFabao(itemguid)
local itemid=item.itemid
local jllv=fabaoModel.getFabaoJilianLevel(itemguid)
local cfgs=cfg_disciplefabaojilianconfig()

local maxlv=fabaoHelper.getCanMaxJilianLv(itemid)
local temp={}
for i,v in ipairs(cfgs)do
if v.id<=maxlv and v.tupoargs then
temp[#temp+1]=v
end
end
local len=#temp
local tupodesc=cfgHelper.getdef1(cfg_disciplefabaojilianconfig,'tupodesc')
self.rewardGrid:setChildLayoutGroupCreateItems(len)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
local enoughNum=0
self.max=len
for i=1,len do
local widget=grids[i-1]
local cfg=temp[i]
local lv=cfg.id
local enough=jllv>=lv
local desc=FMT.fmt('[精炼{0}]',lv)
for i,v in ipairs(cfg.tupoargs)do
local desc_=fabaoHelper.getTuPoDesc(item,tupodesc,v)
desc=i==1 and FMT.fmt('{0} {1}',desc,desc_)or
FMT.fmt('{0}\n{1}',desc,desc_)
end
if not enough then
desc=FMT.cfmt(FONT_COLOR.eGrayColor,desc)
else
enoughNum=enoughNum+1
desc=FMT.cfmt(FONT_COLOR.eGreenColor,desc)
end
widget:SetChildText(0,desc)
widget:SetChildActive(1,enough)
widget:SetChildActive(2,not enough)
end
self.progressNum=enoughNum
self:freshProgress()
end

function UIFabaoTuPoEffectWin:onHide()

end



function UIFabaoTuPoEffectWin:freshProgress()
local height=self.progressNum*86
self.rewadProgress:setChildSizeDelta(12,height)
end








def_class("UIXianGongPingDingRewardWin",UIWindowBase)









function UIXianGongPingDingRewardWin:bindComponents()

self.Content=UIObject.get(self,0)
self.btnClose=UIButton.get(self,1)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIXianGongPingDingRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
end


















function UIXianGongPingDingRewardWin:onLoaded(...)
self:bindComponents()
end

function UIXianGongPingDingRewardWin:__delete()
self:unbindComponents()
end

function UIXianGongPingDingRewardWin:onShow(argtable,afterOnloaded)
self:freshInfo()
end

function UIXianGongPingDingRewardWin:onHide()

end


function UIXianGongPingDingRewardWin:onBtnClose()
self:closeSelf()
end



function UIXianGongPingDingRewardWin:freshInfo()
local qishu=xiangongpingdingModel:getQiShu()
local cfgs=cfg_xiangongpingdinglevelconfig_get(qishu)
local len=#cfgs
self.len=len
self.winlua:SetChildLayoutGroupCreateItems(self.Content:getID(),len,function(index)
self:fillItem(index,cfgs[index])
end)
end

function UIXianGongPingDingRewardWin:fillItem(index,cfg)
local qishu=xiangongpingdingModel:getQiShu()
local widget=self.winlua:GetChildLayoutGroupGridItem(self.Content:getID(),index-1)
local name=cfg.name
local pf=cfg.pf
local pingji=cfg.pjid
local str=index==1 and FMT.fmt('仙宫评定\n总评分<color=#c82c2c>{0}分</color>以上',pf[1])or
index==self.len and FMT.fmt('仙宫评定\n总评分<color=#c82c2c>{0}分</color>以下',pf[2])or
FMT.fmt('仙宫评定\n总评分<color=#c82c2c>{0}分~{1}分</color>',pf[1],pf[2])
local assetname=xiangongpingdingModel:getPJImage(pingji)
widget:SetChildCSImageSprite(0,globalABLookup.xdpdicons,assetname)
widget:SetChildText(1,str)
local rewards=cfgHelper.get3(cfg_xiangongpingdingtasklibconfig_get,qishu,'rwList',pingji)
for i=1,5 do
local reward=rewards[i]
local has=reward~=nil
local index=i+1
widget:SetChildActive(index,has)
if has then
local widget1=widget:GetChildWidgetBase(index)
widgetHelper.setNormalRewardItem(widget1,0,reward)
end
end
end










def_class("UIChuanSongZhenWorldTips",UIWindowBase)









function UIChuanSongZhenWorldTips:bindComponents()

self.background=UIButton.get(self,0)
self.nameTx=UIText.get(self,1)
self.descTx=UIText.get(self,2)
self.conditionTx=UIText.get(self,3)
self.blockList=UIObject.get(self,4)
self.effectTx=UIText.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIChuanSongZhenWorldTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.conditionTx);self.conditionTx=nil;
_UIObject_release(self.blockList);self.blockList=nil;
_UIObject_release(self.effectTx);self.effectTx=nil;
end















local _this=nil
local _blockCmp={
name=0,
cha=1,
gou=2,
}



function UIChuanSongZhenWorldTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIChuanSongZhenWorldTips:__delete()
self:unbindComponents()
_this=nil
end




function UIChuanSongZhenWorldTips:onShow(argtable,afterOnloaded)
local world=argtable.world
local config=cfgHelper.get1(cfg_worldtransportconfig_get,world)
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)

self.nameTx:setText(config.name)
self.descTx:setText(config.desc)
self.effectTx:setText(FMT.fmt("作用：游历时获得的所有奖励+{0}%",config.bonus))
local temp=chuanSongZhenModel:checkAllFlag(world)and FMT.cfmt(FONT_COLOR.eGreenColor,"(已激活)")or FMT.cfmt(FONT_COLOR.eRedColor,"(未激活)")
self.conditionTx:setText(FMT.fmt("激活条件：修复{0}全部传送阵{1}",worldCfg.name,temp))

local transportCfg=cfgHelper.get1(cfg_worldblocktransportconfig_get,world)
local blocks={}
for block,blockCfg in pairs(transportCfg)do
table.insert(blocks,block)
end
table.sort(blocks)
self.blockList:setChildLayoutGroupCreateItems(#blocks,function(index)
local item=self.blockList:getChildLayoutGroupGridItem(index-1)
local block=blocks[index]
local cfg=transportCfg[block]
local repaired=chuanSongZhenModel:getFlagBit(world,block)
item:SetChildActive(_blockCmp.gou,repaired)
item:SetChildActive(_blockCmp.cha,not repaired)
item:SetChildText(_blockCmp.name,cfg.name)
end)
end


function UIChuanSongZhenWorldTips:onHide()

end





function UIChuanSongZhenWorldTips:onBackground()
self:closeSelf()
end


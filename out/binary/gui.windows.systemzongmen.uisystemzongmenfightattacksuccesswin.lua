







def_class("UISystemZongMenFightAttackSuccessWin",UIWindowBase)









function UISystemZongMenFightAttackSuccessWin:bindComponents()

self.tip=UIText.get(self,0)
self.list=UIObject.get(self,1)



end


function UISystemZongMenFightAttackSuccessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.list);self.list=nil;
end















local _this=nil
local _itemCmp={
bg=0,
head=1,
progressBar=2,
hurt=3,
name=4,
}



function UISystemZongMenFightAttackSuccessWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenFightAttackSuccessWin:__delete()
self:unbindComponents()
_this=self
end




function UISystemZongMenFightAttackSuccessWin:onShow(argtable,afterOnloaded)
self.battle=fightModel:getBattle(argtable.battleId)
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
local param=baseCfg.attackFS[1]
local finalStastics=self.battle:getStasticsListFinal()
local datas={}
for guid_str,data in pairs(finalStastics)do
if UIDiscipleModel:getDiscipleData(data.dis_guid)~=nil then
table.insert(datas,data)
end
end
self.list:setChildLayoutGroupCreateItems(#datas,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local imageInfo=data.image
local bgName=FMT.fmt('image_gwtouxiangpjk_{0}',imageInfo.color)
item:SetChildCSImageSprite(_itemCmp.bg,globalABLookup.global,bgName)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildModelRawImageEx(_itemCmp.head,item,modelParams,eHeadCenterType.eHead)
local progressValue=math.floor(data.hp/data.max_hp*10000)
item:SetChildProgressValue(_itemCmp.progressBar,progressValue,10000)

local temp=data.max_hp>data.hp and math.floor(data.hp/data.max_hp*10000)or 10000
local hurt=math.floor(param[1]+(10000-temp)*param[2])
item:SetChildText(_itemCmp.hurt,FMT.fmt("负伤值:+{0}",hurt))
item:SetChildText(_itemCmp.name,UIDiscipleModel:getDiscipleName(data.dis_guid))
end)
self.tip:setText(argtable.tips or"")
end


function UISystemZongMenFightAttackSuccessWin:onHide()

end




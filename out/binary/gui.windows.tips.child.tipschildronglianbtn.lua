







def_class("tipsChildRongLianBtn",UICloneObject)





tipsChildRongLianBtn.abName="ui/windows/tips/child/tipschildronglianbtn.ab"

tipsChildRongLianBtn.assetName="tipsChildRongLianBtn"


function tipsChildRongLianBtn:bindComponents()

self.itembg=UIImage.get(self,0)
self.ronglian=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.Text=UIText.get(self,3)

self.ronglian:setButtonClick(function()self:onRonglian()end)

end


function tipsChildRongLianBtn:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itembg);self.itembg=nil;
_UIObject_release(self.ronglian);self.ronglian=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Text);self.Text=nil;
end









function tipsChildRongLianBtn:onLoaded(...)
self:bindComponents()
end


function tipsChildRongLianBtn:__delete()
self:unbindComponents()
end




function tipsChildRongLianBtn:onShow(argtable,afterOnloaded)
self.data=argtable.argtable
self.itemid=self.data.itemid
self.itemguid=self.data.itemguid
self.tipsType=self.data.tipsType
end


function tipsChildRongLianBtn:onHide()

end

function tipsChildRongLianBtn:onRonglian()
local itemguid=self.itemguid
local equip=bagModel.getItem(itemguid)
if equip and bagHelper.isLock(equip)then
UIManager.error('物品已锁定，无法熔炼')
return
end


local itemConfig=itemsConfig.getConfig(equip.itemid)
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(equip.itemid)
local isninglian=false
if isxmEquip>0 then
local ninglian_star=equipsModel.getNingLianStar(equip)
if ninglian_star>0 then
isninglian=true
end
end

local callback=function()
tipsManager.closeTips()
local item=itemsModel.getItem(itemguid)
local rlitems=equipsHelper.returnRonglianItems(item)










UIFullBaGuaLuControl:setRongLianGUID({itemguid},rlitems,false,true,true)

end
local str='是否确认熔炼选中的装备?'
if isxmEquip>0 then
local fenjie_rand_reward=equipsModel.getEquipXMFenJie(equip.itemid)
local _itemConfig=itemsConfig.getConfig(fenjie_rand_reward[3])
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
str=FMT.fmt("选中的装备为稀有的<color=#c82c2c>仙魔装备</color>\n分解会有概率获得{0}~{1}个<color=#c82c2c>【{2}】</color>\n是否确认熔炼？",fenjie_rand_reward[1],fenjie_rand_reward[2],_itemConfig.name)
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
str=FMT.fmt("选中的装备为稀有的<color=#c82c2c>仙魔装备</color>\n分解会有概率获得{0}~{1}个<color=#c82c2c>【{2}】</color>\n是否确认熔炼？",fenjie_rand_reward[1],fenjie_rand_reward[2],_itemConfig.name)
end
end

local showdata=
{
type='UIDialougeRongLian',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
allowclickBG=true,
itemInfoList={equip},
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end



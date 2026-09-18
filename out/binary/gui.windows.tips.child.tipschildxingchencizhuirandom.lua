







def_class("tipsChildXingChenCiZhuiRandom",UICloneObject)





tipsChildXingChenCiZhuiRandom.abName="ui/windows/tips/child/tipschildxingchencizhuirandom.ab"

tipsChildXingChenCiZhuiRandom.assetName="tipsChildXingChenCiZhuiRandom"


function tipsChildXingChenCiZhuiRandom:bindComponents()

self.desc=UIText.get(self,0)
self.pageGrid=UIObject.get(self,1)
self.title=UIText.get(self,2)

end


function tipsChildXingChenCiZhuiRandom:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.pageGrid);self.pageGrid=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildXingChenCiZhuiRandom:onLoaded(...)
self:bindComponents()
end


function tipsChildXingChenCiZhuiRandom:__delete()
self:unbindComponents()
end




function tipsChildXingChenCiZhuiRandom:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
self.itemid=itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach=attach

local equip=equipsHelper.getEquip(itemguid)

self.title:setText("随机词缀")

local affixList=equip and xingChenHelper.getAffixList(equip)or{}
local preview=false
if#affixList==0 and not equip then
local config=itemsConfig.getConfig(itemid)
local preview_affix=config.preview_affix
if preview_affix then
preview=true
self.title:setText("词缀预览")

affixList=preview_affix
end
end
self.desc:setActive(preview)
self.pageGrid:setChildLayoutGroupCreateItems(#affixList)
local grids=self.pageGrid:getChildLayoutGroupGridList()
if#affixList>0 then
for i=1,grids.Count do
local grid=grids[i-1]
local affix=affixList[i]

local config=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildButtonClick(0,function()
UIManager:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
end
else
self:recycleSelf()
end
end


function tipsChildXingChenCiZhuiRandom:onHide()

end



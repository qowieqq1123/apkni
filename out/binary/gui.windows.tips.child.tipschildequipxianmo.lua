







def_class("tipsChildEquipXianMo",UICloneObject)





tipsChildEquipXianMo.abName="ui/windows/tips/child/tipschildequipxianmo.ab"

tipsChildEquipXianMo.assetName="tipsChildEquipXianMo"


function tipsChildEquipXianMo:bindComponents()

self.attr1=UIText.get(self,0)
self.attr2=UIText.get(self,1)
self.attr3=UIText.get(self,2)
self.attr4=UIText.get(self,3)
self.attrRoot1=UIObject.get(self,4)
self.attrRoot2=UIObject.get(self,5)
self.attrRoot3=UIObject.get(self,6)
self.attrRoot4=UIObject.get(self,7)
self.line=UIObject.get(self,8)
self.suitIcon=UIObject.get(self,9)
self.title=UIText.get(self,10)
self.xmiconep=UIObject.get(self,11)
self.xmicon1=UIImage.get(self,12)
self.xmicon2=UIImage.get(self,13)
self.xmicon3=UIImage.get(self,14)

end


function tipsChildEquipXianMo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.suitIcon);self.suitIcon=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.xmiconep);self.xmiconep=nil;
_UIObject_release(self.xmicon1);self.xmicon1=nil;
_UIObject_release(self.xmicon2);self.xmicon2=nil;
_UIObject_release(self.xmicon3);self.xmicon3=nil;
end






local abname="ui/windows/equip/chongzhu_atlas_pak.ab"

function tipsChildEquipXianMo:onLoaded()
self:bindComponents()
end

function tipsChildEquipXianMo:__delete()
self:unbindComponents()
end

function tipsChildEquipXianMo:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid

local equip=equipsHelper.getEquip(itemguid)
local itemData=equip and equip.itemData or{}






self.xmicon1:setActive(false)
self.xmicon2:setActive(false)
self.xmicon3:setActive(false)
self.attrRoot1:setActive(false)
self.attrRoot2:setActive(false)
self.attrRoot3:setActive(false)
self.attrRoot4:setActive(false)


local xmtype=equipsHelper.getEquipXMTypebyItemid(itemid)
local name=""
local asset=""
if xmtype==EQUIP_XianMo_TYPES.eXian then
name="仙道传承"
asset="image_dzzb_jinlian1"
elseif xmtype==EQUIP_XianMo_TYPES.eMo then
name="魔道传承"
asset="image_dzzb_moyan1"
end
self.title:setText(name)


local effect_idlist=self:getChuangChenIdList(itemid)
local ninglian_star=equip and equipsModel.getNingLianStar(equip)or 0
self.xmiconep:setActive(false)
if ninglian_star>=1 then
self.xmiconep:setActive(true)
end


if effect_idlist[1]then
local effect_id=effect_idlist[1][1]
local cfg=cfg_discipleequipxmccconfig_get(effect_id)
local desclist=cfg.desc
local str1=''
if desclist[1]then
str1=desclist[1]
end
if#desclist>1 then
for i=2,#desclist do

str1=FMT.fmt('{0}\n{1}',str1,desclist[i])
end
end
if str1 then
str1=string.gsub(str1," ","\194\160")
self.attrRoot1:setActive(true)
if ninglian_star>=1 then
str1=string.gsub(str1,"<[^>]+>","")
self.attr1:setText(str1)
if asset~=""then
self.xmicon1:setActive(true)
self.xmicon1:setSprite(abname,asset)
end
else
local clearRichStr=string.gsub(str1,"<[^>]+>","")
local _str=FMT.fmt('<color=#827f78>{0}</color> <color=#aae252>[1次凝炼激活]</color>',clearRichStr)
self.attr1:setText(_str)
end
end
end
if effect_idlist[2]then
local effect_id=effect_idlist[2][1]
local cfg=cfg_discipleequipxmccconfig_get(effect_id)
local desclist=cfg.desc
local str1=''
if desclist[1]then
str1=desclist[1]
end
if#desclist>1 then
for i=2,#desclist do
str1=FMT.fmt('{0}\n{1}',str1,desclist[i])
end
end
if str1 then
str1=string.gsub(str1," ","\194\160")
self.attrRoot2:setActive(true)
if ninglian_star>=2 then
str1=string.gsub(str1,"<[^>]+>","")
self.attr2:setText(str1)
if asset~=""then
self.xmicon2:setActive(true)
self.xmicon2:setSprite(abname,asset)
end
else
local clearRichStr=string.gsub(str1,"<[^>]+>","")
local _str=FMT.fmt('<color=#827f78>{0}</color> <color=#aae252>[2次凝炼激活]</color>',clearRichStr)
self.attr2:setText(_str)
end
end
end
if effect_idlist[3]then
local effect_id=effect_idlist[3][1]
local cfg=cfg_discipleequipxmccconfig_get(effect_id)
local desclist=cfg.desc
local str1=''
if desclist[1]then
str1=desclist[1]
end
if#desclist>1 then
for i=2,#desclist do
str1=FMT.fmt('{0}\n{1}',str1,desclist[i])
end
end
if str1 then
str1=string.gsub(str1," ","\194\160")
self.attrRoot3:setActive(true)
if ninglian_star>=3 then
str1=string.gsub(str1,"<[^>]+>","")
self.attr3:setText(str1)
if asset~=""then
self.xmicon3:setActive(true)
self.xmicon3:setSprite(abname,asset)
end
else
local clearRichStr=string.gsub(str1,"<[^>]+>","")
local _str=FMT.fmt('<color=#827f78>{0}</color> <color=#aae252>[3次凝炼激活]</color>',clearRichStr)
self.attr3:setText(_str)
end
end
end


self.attrRoot4:setActive(true)

if not equipsHelper.isDressed(itemguid)and not bagModel.getItem(itemguid)then
self.attrRoot4:setActive(false)
else
local joblist=equipsModel.getEquipXMJobList(itemid)
local str=''
for k,v in pairs(joblist)do
local jobName=cfgHelper.get2(cfg_disciplevocationconfig_get,k,"name")
str=FMT.fmt('{0}[{1}]',str,jobName)
end
if str~=''then
if equipsHelper.isDressed(itemguid)then
str=FMT.fmt('传承职业：{0}<color=#aae252>（已激活）</color>',str)
else
str=FMT.fmt('传承职业：{0}<color=#f36666>（未激活）</color>',str)
end
self.attr4:setText(str)
end
end

self.line:setActive(true)
end

function tipsChildEquipXianMo:onRecycle()
self.line:setActive(not self:isLastItem())
end


function tipsChildEquipXianMo:getChuangChenIdList(itemid)
local list={}
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(itemid)
if ninglian_conf then
for k,v in ipairs(ninglian_conf)do
if v.effect_id and v.effect_id~=0 then
table.insert(list,{v.effect_id,k})
end
end
end
return list
end
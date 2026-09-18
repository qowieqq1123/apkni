







def_class("UIFightReport",UIWindowBase)









function UIFightReport:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.diZiInfo=UIScrollView.get(self,1)
self.RootCloseClick=UIButton.get(self,2)
self.diZiDetailInfo=UIScrollView.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.RootCloseClick:setButtonClick(function()self:onRootCloseClick()end)



end


function UIFightReport:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.diZiInfo);self.diZiInfo=nil;
_UIObject_release(self.RootCloseClick);self.RootCloseClick=nil;
_UIObject_release(self.diZiDetailInfo);self.diZiDetailInfo=nil;
end

















local _cmpItemWidgetIdx=
{
item1=0,
item2=1,
item3=2,
item4=3,
item5=4,
item6=5,
item7=6,
item8=7,
item9=8,
}


function UIFightReport:onLoaded(...)
self:bindComponents()
self.diZiInfo:setRecyleData(self:getRecyleData())

local function _onClickItem(itemid,index,guid,attach)
self:flushDetailData(index)
end
self.diZiInfo:setClickAction(_onClickItem)

self.diZiDetailInfo:setRecyleData(self:getRecyleDetailData())
end


function UIFightReport:__delete()
self:unbindComponents()
Time.timeScale=1
end




function UIFightReport:onShow(str,afterOnloaded)
self.diZiInfo:freshGridsNum(10,2,5,false)
self.diZiDetailInfo:freshGridsNum(90,30,3,false)
Time.timeScale=0
self:flushData()
self.RootCloseClick:setActive(false)
end


function UIFightReport:OnEnable()

end


function UIFightReport:OnDisable()

end




function UIFightReport:onCloseBtn()
UIManager:closeWindow("UIFightReport")
end



function UIFightReport:flushData()
local data={}
local battle=fightController.curBattle
if battle~=nil then
for i=1,10 do
local ent=battle:getEntity(i)
if ent~=nil then
data[#data+1]=self:fillBuffData(ent,i)
else
data[#data+1]=self:getRecyleData()
end
end
self.diZiInfo:initPropData(data)
end
end

function UIFightReport:getAttributeStr(ent,id)

local cfg=cfgHelper.get1(cfg_attributesconfig_get,id)
if cfg~=nil then
local value=ent:getAttribute(id)
if cfg.ifMod then
return string.format("%s:<color=#BFA215>%.2f%</color>",cfg.attrname,value/100)
else
return FMT.fmt("{0}:<color=#BFA215>{1}</color>",cfg.attrname,value)
end
else
return FMT.fmt('属性表没有定义属性名称:<color=#BFA215>{0}</color>',id)
end
end


function UIFightReport:fillBuffData(ent,index)
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item1)]=FMT.fmt("ID:{0}",ent:getIndex())
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item2)]=FMT.fmt("姓名:{0}",ent.name)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item3)]=getEntityFmtAttr(ent,entityAttr.hp)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item4)]=getEntityFmtAttr(ent,entityAttr.max_hp)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item5)]=getEntityFmtAttr(ent,entityAttr.gem_power)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item6)]=getEntityFmtAttr(ent,entityAttr.max_gem_power)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item7)]=FMT.fmt("血量变化:{0}",ent.lastHPChange or 0)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item8)]=FMT.fmt("技能:{0}",ent.lastUseSkillID or-1)
local buffs=ent:getAllBuff()
local count=0
for i,v in pairs(buffs)do
count=count+1
end
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item9)]=FMT.fmt("buff数量:{0}",count)
prop[DataPropKey.eItemID]=index
prop[DataPropKey.eItemSeries]=index
return prop
end

function UIFightReport:getRecyleData()
return
{
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item1)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item2)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item3)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item4)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item5)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item6)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item7)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item8)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.item9)]='',
[DataPropKey.eItemID]=-1,
[DataPropKey.eItemSeries]=-1,
}
end


function UIFightReport:onRootCloseClick(...)
self.RootCloseClick:setActive(false)
end



function UIFightReport:flushDetailData(index)
local battle=fightController.curBattle
if battle~=nil then
local ent=battle:getEntity(index)
if ent~=nil then
self.RootCloseClick:setActive(true)
local data={}
local battle=fightController.curBattle
if battle~=nil then
local attKey={}
for i,v in pairs(entityAttr)do
attKey[#attKey+1]=v
end
table.sort(attKey)

for i,v in ipairs(attKey)do
local count=#data
if count<90 then
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,0)]=getEntityFmtAttr(ent,v)
data[#data+1]=prop
else
break
end
end

local count=#data
for i=count,68 do
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,0)]=''
data[#data+1]=prop
end
local buffs=ent:getAllBuff()
local buffGUID={}
for i,v in pairs(buffs)do
buffGUID[#buffGUID+1]=i
end
table.sort(buffGUID)
for i,v in ipairs(buffGUID)do
if i<=20 then
local buffInfo=buffs[v]
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,0)]=FMT.fmt('b{0}:{1}_{2}_round:{3}_layer:{4}',buffInfo.guid,buffInfo.id,buffInfo.cfg.name,buffInfo.round,buffInfo.layer)
data[#data+1]=prop
end
end
for i=69+#buffGUID,89 do
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,0)]=FMT.fmt('',i)
data[#data+1]=prop
end
self.diZiDetailInfo:initPropData(data)
end
end
end

end

function UIFightReport:getRecyleDetailData()
return
{
[PropIndex(DataPropKey.eWidgetText,0)]='',
[DataPropKey.eItemID]=-1,
[DataPropKey.eItemSeries]=-1,
}
end

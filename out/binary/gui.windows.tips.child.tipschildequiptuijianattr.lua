







def_class("tipsChildEquipTuijianAttr",UICloneObject)





tipsChildEquipTuijianAttr.abName="ui/windows/tips/child/tipschildequiptuijianattr.ab"

tipsChildEquipTuijianAttr.assetName="tipsChildEquipTuijianAttr"


function tipsChildEquipTuijianAttr:bindComponents()

self.attr1=UIText.get(self,0)
self.attr3=UIText.get(self,1)
self.attr2=UIText.get(self,2)
self.attrRoot1=UIObject.get(self,3)
self.attrRoot2=UIObject.get(self,4)
self.attrRoot3=UIObject.get(self,5)
self.attrRoot4=UIObject.get(self,6)
self.attrRoot5=UIObject.get(self,7)
self.line=UIObject.get(self,8)
self.attr5=UIText.get(self,9)
self.title=UIText.get(self,10)
self.attr4=UIText.get(self,11)

end


function tipsChildEquipTuijianAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.attr4);self.attr4=nil;
end








function tipsChildEquipTuijianAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildEquipTuijianAttr:__delete()
self:unbindComponents()
end

function tipsChildEquipTuijianAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

local itemConfig=itemsConfig.getConfig(itemid)
local recommend=itemConfig.recommend
if recommend==nil then
self:recycleSelf()
return
end
local colorrandnum=equipsConfig.getEquipConstConfig().colorrandnum
local color=itemConfig.color
local recommendcolor=itemConfig.recommendcolor
local num=colorrandnum[color]

if num==nil or num<=0 then
self:recycleSelf()
return
end
self.title:setText(FMT.fmt('极品属性 (随机生成{0}条极品属性)',num))
local vis=#recommend
for i=1,num do
local v=recommend[i]
if v then
local name,valstr=equipsHelper.getAttr(v[1],v[2])
local strColor=recommendcolor[i]
local str=strColor and FMT.cfmt(strColor,'[推荐] {0}：+{1}',name,valstr)or FMT.fmt(strColor,'[推荐] {0}：+{1}',name,valstr)
self[FMT.fmt('attr{0}',i)]:setText(str)
self[FMT.fmt('attrRoot{0}',i)]:setActive(true)
end
end
if vis<5 then
for i=vis+1,5 do
self[FMT.fmt('attrRoot{0}',i)]:setActive(false)
end
end
self.line:setActive(not self:isLastItem())

if vis~=num then
loggerUtil.logErrFMT('装备推荐属性个数{0}与品质对应随机属性个数{1}配置不匹配',vis,num)
end
end

function tipsChildEquipTuijianAttr:onHide()

end



function tipsChildEquipTuijianAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end

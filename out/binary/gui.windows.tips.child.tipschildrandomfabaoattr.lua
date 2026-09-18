







def_class("tipsChildRandomFabaoAttr",UICloneObject)





tipsChildRandomFabaoAttr.abName="ui/windows/tips/child/tipschildrandomfabaoattr.ab"

tipsChildRandomFabaoAttr.assetName="tipsChildRandomFabaoAttr"


function tipsChildRandomFabaoAttr:bindComponents()

self.attrRoot6=UIObject.get(self,0)
self.attrRoot1=UIObject.get(self,1)
self.line=UIObject.get(self,2)
self.attrRoot10=UIObject.get(self,3)
self.attrRoot2=UIObject.get(self,4)
self.attrRoot9=UIObject.get(self,5)
self.attrRoot8=UIObject.get(self,6)
self.attrRoot3=UIObject.get(self,7)
self.attrRoot7=UIObject.get(self,8)
self.descRoot=UIObject.get(self,9)
self.attrRoot4=UIObject.get(self,10)
self.attrRoot5=UIObject.get(self,11)
self.title=UIText.get(self,12)
self.attr1=UIText.get(self,13)
self.add1=UIText.get(self,14)
self.add2=UIText.get(self,15)
self.attr2=UIText.get(self,16)
self.add3=UIText.get(self,17)
self.attr3=UIText.get(self,18)
self.attr4=UIText.get(self,19)
self.add4=UIText.get(self,20)
self.attr5=UIText.get(self,21)
self.add5=UIText.get(self,22)
self.attr6=UIText.get(self,23)
self.add6=UIText.get(self,24)
self.attr7=UIText.get(self,25)
self.add7=UIText.get(self,26)
self.attr8=UIText.get(self,27)
self.add8=UIText.get(self,28)
self.attr9=UIText.get(self,29)
self.add9=UIText.get(self,30)
self.attr10=UIText.get(self,31)
self.add10=UIText.get(self,32)
self.desc=UIText.get(self,33)

end


function tipsChildRandomFabaoAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot6);self.attrRoot6=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.attrRoot10);self.attrRoot10=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot9);self.attrRoot9=nil;
_UIObject_release(self.attrRoot8);self.attrRoot8=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot7);self.attrRoot7=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.add1);self.add1=nil;
_UIObject_release(self.add2);self.add2=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.add3);self.add3=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.add4);self.add4=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.add5);self.add5=nil;
_UIObject_release(self.attr6);self.attr6=nil;
_UIObject_release(self.add6);self.add6=nil;
_UIObject_release(self.attr7);self.attr7=nil;
_UIObject_release(self.add7);self.add7=nil;
_UIObject_release(self.attr8);self.attr8=nil;
_UIObject_release(self.add8);self.add8=nil;
_UIObject_release(self.attr9);self.attr9=nil;
_UIObject_release(self.add9);self.add9=nil;
_UIObject_release(self.attr10);self.attr10=nil;
_UIObject_release(self.add10);self.add10=nil;
_UIObject_release(self.desc);self.desc=nil;
end







local _maxLen=10

function tipsChildRandomFabaoAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildRandomFabaoAttr:__delete()
self:unbindComponents()
end

function tipsChildRandomFabaoAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
local attrList=fabaoHelper.getRandomBaseAttr(itemConfig)
local len=#attrList
local index=len
if len==0 then
self:recycleSelf()
return
end
self.line:setActive(not self:isLastItem())

self.title:setText('基础属性')

for i,v in ipairs(attrList)do
local attrType=v[1]
local valTable=v[2]
local min=valTable[1]
local max=valTable[2]
local name,minstr=equipsHelper.getAttr(attrType,min)
local name,maxstr=equipsHelper.getAttr(attrType,max)
local attrStr=FMT.fmt('{0}：{1}~{2}',name,minstr,maxstr)
self[FMT.fmt('attr{0}',i)]:setText(attrStr)
self[FMT.fmt('attrRoot{0}',i)]:setActive(true)
end
local desc='五行威力：根据主材料的类型随机生成'
self.descRoot:setActive(true)
self.desc:setText(desc)

if index<_maxLen then
for i=index+1,_maxLen do
self[FMT.fmt('attrRoot{0}',i)]:setActive(false)
end
end
end

function tipsChildRandomFabaoAttr:onHide()

end



function tipsChildRandomFabaoAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end

function tipsChildRandomFabaoAttr:fillAttr(idx,attrType,attrValue)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
self[FMT.fmt('attr{0}',idx)]:setText(attrStr)
self[FMT.fmt('attrRoot{0}',idx)]:setActive(true)
end

function tipsChildRandomFabaoAttr:fillAttr(idx,attrType,attrValue)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
self[FMT.fmt('attr{0}',idx)]:setText(attrStr)
self[FMT.fmt('attrRoot{0}',idx)]:setActive(true)
end








def_class("tipsChildEquipVoc",UICloneObject)





tipsChildEquipVoc.abName="ui/windows/tips/child/tipschildequipvoc.ab"

tipsChildEquipVoc.assetName="tipsChildEquipVoc"


function tipsChildEquipVoc:bindComponents()

self.title=UIText.get(self,0)
self.voc=UIText.get(self,1)

end


function tipsChildEquipVoc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.voc);self.voc=nil;
end






function tipsChildEquipVoc:onLoaded()
self:bindComponents()
end

function tipsChildEquipVoc:__delete()
self:unbindComponents()
end

function tipsChildEquipVoc:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local type2=itemsConfig.getConfig(itemid).type2
local vocList=equipsHelper.getLimitVoc(type2)or{}
local vocDesc=''
local hasLimit=false
for i,v in ipairs(vocList)do
local vocationConfig=equipsConfig.getDiziVocationConfig(v)
local hide=vocationConfig.hide
if not hide then
local name=vocationConfig.name
local split=i~=1 and' 'or''
vocDesc=FMT.fmt('{0}{1}[\194\160{2}\194\160]',vocDesc,split,name)
hasLimit=true
end
end
if not hasLimit then
self:recycleSelf()
return
end
self.voc:setText(vocDesc)
end
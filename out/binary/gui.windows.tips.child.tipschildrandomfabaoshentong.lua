







def_class("tipsChildRandomFabaoShentong",UICloneObject)





tipsChildRandomFabaoShentong.abName="ui/windows/tips/child/tipschildrandomfabaoshentong.ab"

tipsChildRandomFabaoShentong.assetName="tipsChildRandomFabaoShentong"


function tipsChildRandomFabaoShentong:bindComponents()

self.name=UIText.get(self,0)
self.desc=UIText.get(self,1)
self.Icon=UIImage.get(self,2)

end


function tipsChildRandomFabaoShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.Icon);self.Icon=nil;
end








function tipsChildRandomFabaoShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildRandomFabaoShentong:__delete()
self:unbindComponents()
end

function tipsChildRandomFabaoShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)

local shentongIcon=iconHelper.getSkillIcon(11011)

self.Icon:setImageIcon(shentongIcon)
self.name:setText('神通')
self.desc:setText('神通技能类型根据主材料类型随机生成')
end

function tipsChildRandomFabaoShentong:onHide()

end



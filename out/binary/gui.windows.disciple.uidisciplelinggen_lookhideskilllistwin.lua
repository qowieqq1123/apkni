







def_class("UIDiscipleLinggen_LookHideSkillListWin",UIWindowBase)









function UIDiscipleLinggen_LookHideSkillListWin:bindComponents()

self.list=UIObject.get(self,0)
self.root=UIObject.get(self,1)



end


function UIDiscipleLinggen_LookHideSkillListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIDiscipleLinggen_LookHideSkillListWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLinggen_LookHideSkillListWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_LookHideSkillListWin:onShow(argtable,afterOnloaded)
self.mcList=argtable.mcList

local len=#self.mcList

self.list:setChildLayoutGroupCreateItems(len,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)

local data=self.mcList[index]

local isShow=data~=nil
item:SetChildActive(-1,isShow)
if isShow then
self:freshRecordItem(item,data)
end
end)
end


function UIDiscipleLinggen_LookHideSkillListWin:onHide()

end

local CmpRecordItemIndex={
name=0,
type=1,
icon=2,
showAttrBtn=3,
desc=4,
quality=5,
}
function UIDiscipleLinggen_LookHideSkillListWin:freshRecordItem(item,data)
local skillIconName=iconHelper.getSkillIcon(data.icon)
local desc=data.mz_desc or''

local elementIconName,ab=ELEMENT_TYPE.getVaryIcon(data.element)


local nameColor=UIDiscipleModel:getHoardNameColor(data.color)
item:SetChildText(CmpRecordItemIndex.name,toColorStringX(nameColor,data.name))
item:SetChildCSImageSprite(CmpRecordItemIndex.type,ab,elementIconName)
item:SetChildIcon(CmpRecordItemIndex.icon,skillIconName,false)
item:SetChildText(CmpRecordItemIndex.desc,desc)

local qualityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(data.color)
item:SetChildCSImageSprite(CmpRecordItemIndex.quality,qab,qualityName)
end




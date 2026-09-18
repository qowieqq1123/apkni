







def_class("UIAirGameInitAttrDetailWin",UIWindowBase)









function UIAirGameInitAttrDetailWin:bindComponents()

self.infoAttrGridGroup=UIObject.get(self,0)
self.infoTitle=UIText.get(self,1)
self.Root=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)



end


function UIAirGameInitAttrDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoAttrGridGroup);self.infoAttrGridGroup=nil;
_UIObject_release(self.infoTitle);self.infoTitle=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIAirGameInitAttrDetailWin:onLoaded(...)
self:bindComponents()
end


function UIAirGameInitAttrDetailWin:__delete()
self:unbindComponents()
end




function UIAirGameInitAttrDetailWin:onShow(argtable,afterOnloaded)
self.discipleGuid=argtable and argtable.discipleGuid

self.attrInfoList=airGameEnterModel:getGameInitAttrList(self.discipleGuid)

self.attrList=self:getAttrSortList()

local len=#self.attrList

self.infoAttrGridGroup:setChildLayoutGroupCreateItems(len,function(index)
local attrWidget=self.infoAttrGridGroup:getChildLayoutGroupGridItem(index-1)
local attr=self.attrList[index]
local isEmpty=attr.isEmpty
if isEmpty then
attrWidget:SetChildActive(3,false)
else
attrWidget:SetChildActive(3,true)
local attrId=attr.attrId
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.simpleName or attrCfg.attrname
attrWidget:SetChildText(0,attrName)
local attrValStr=airController:getAttrStr(attrId,attr.attrVal)
if attr.attrVal<0 then
attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
attrWidget:SetChildText(1,attrValStr)
attrWidget:SetChildButtonClick(2,function()
self:onAttrItemClick(index,attrId)
end,true)
end
end)
end


function UIAirGameInitAttrDetailWin:onHide()

end

function UIAirGameInitAttrDetailWin:getAttrSortList()

local sortList={}
for index,attrInfo in pairs(self.attrInfoList)do
local attrId=attrInfo[1]
local attrVal=attrInfo[2]
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local isHide=attrCfg.isHide
if not isHide then
local weight=attrCfg.sort
sortList[#sortList+1]={
attrId=attrId,
attrVal=attrVal,
weight=weight,
}
end
end

table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

local checkNameList={}
local attrItemCount=0
for i,v in ipairs(sortList)do
local attrId=v.attrId
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local isSingleRow=attrCfg.isSingleRow

if isSingleRow then
if attrItemCount%2>0 then
attrItemCount=attrItemCount+1
table.insert(checkNameList,{isEmpty=true})
end

attrItemCount=attrItemCount+2
v.isSingleRow=true
table.insert(checkNameList,v)
table.insert(checkNameList,{isEmpty=true})
else
attrItemCount=attrItemCount+1
table.insert(checkNameList,v)
end
end

return checkNameList
end












def_class("UIGongFaStudyAttrWin",UIWindowBase)









function UIGongFaStudyAttrWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollContent=UIObject.get(self,1)
self.levelGrid=UIObject.get(self,2)
self.attrGrid=UIObject.get(self,3)
self.tipsTxt=UIText.get(self,4)



end


function UIGongFaStudyAttrWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollContent);self.scrollContent=nil;
_UIObject_release(self.levelGrid);self.levelGrid=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end

















function UIGongFaStudyAttrWin:onLoaded(...)
self:bindComponents()
end


function UIGongFaStudyAttrWin:__delete()
self:unbindComponents()
end


function UIGongFaStudyAttrWin:onHide()

end




function UIGongFaStudyAttrWin:onShow(argtable,afterOnloaded)
self.gflist=argtable.gflist
self.dis_guid=argtable.dis_guid

self:refreshView()
end

function UIGongFaStudyAttrWin:refreshView()

local num1=#self.gflist
self.levelGrid:setChildLayoutGroupCreateItems(num1)
if num1>0 then
local gridlist=self.levelGrid:getChildLayoutGroupGridList()
for i=1,num1 do
local item=gridlist[i-1]
local data=self.gflist[i]
local gfID=data[1]
local studylv=data[2]
local name=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'name')
item:SetChildText(0,FMT.fmt('{0} +{1}',name,studylv))
end
end

local attrlist={}
local attrlookup={}
UIGongFaModel:calculationGFStudyAttrLookup(self.dis_guid,attrlookup)
UIGongFaStudyAttrWin.addAttrDescStr(attrlist,attrlookup)
local num2=#attrlist
self.attrGrid:setChildLayoutGroupCreateItems(num2)
if num2>0 then
local gridlist=self.attrGrid:getChildLayoutGroupGridList()
for i=1,num2 do
local item=gridlist[i-1]
local desc=attrlist[i]
item:SetChildText(0,desc)
end
end
end

function UIGongFaStudyAttrWin.addAttrDescStr(res,attrs)
if attrs==nil then
return
end
for i,v in pairsBySortKey(attrs)do
local str=helper.getAttributeStr(i,v,1,'{0} +{1}')
table.insert(res,str)
end
end
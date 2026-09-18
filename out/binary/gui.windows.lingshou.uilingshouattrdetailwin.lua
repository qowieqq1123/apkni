







def_class("UILingShouAttrDetailWin",UIWindowBase)









function UILingShouAttrDetailWin:bindComponents()

self.attrCreater1=UIObject.get(self,0)
self.attrCreater2=UIObject.get(self,1)
self.questionBtn=UIImage.get(self,2)
self.contentRoot=UIObject.get(self,3)



end


function UILingShouAttrDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrCreater1);self.attrCreater1=nil;
_UIObject_release(self.attrCreater2);self.attrCreater2=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
_UIObject_release(self.contentRoot);self.contentRoot=nil;
end


















function UILingShouAttrDetailWin:onLoaded(...)
self:bindComponents()
end


function UILingShouAttrDetailWin:__delete()
self:unbindComponents()
end




function UILingShouAttrDetailWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.guid
local attrsDetail=cfgHelper.getdef(cfg_attributesconfig,'attrsDetail')
self.attrlist2=lingshouModel:getAttrListByType(self.ls_guid,attrsDetail,true,1)
self.curPage=false
self:refreshQuestionBtn()
self:RefreshAttrList1(true)
self:RefreshAttrList2(true)

self.contentRoot:setChildCanvasGroupAlpha(0)
local func=function()
self.contentRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.1,func)
end


function UILingShouAttrDetailWin:OnEnable()

end


function UILingShouAttrDetailWin:OnDisable()

end

function UILingShouAttrDetailWin:RefreshAttrList1(isInit)

if self.attrlist1==nil then
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
self.attrlist1=lingshouModel:getAttrListByType(self.ls_guid,attrsBase,1)
end
local c1=#self.attrlist1
if isInit then
self.attrCreater1:setChildLayoutGroupCreateItems(c1)
end
local gridlist1=self.attrCreater1:getChildLayoutGroupGridList()
for i=1,c1 do
local item=gridlist1[i-1]
local attr=self.attrlist1[i]
local attr_v=attr[2]
if attr_v<0 then
attr_v=0
end
item:SetChildText(0,cfgHelper.get2(cfg_attributesconfig_get,attr[1],'attrname'))
item:SetChildText(1,helper.getAttributeStrEx(attr[1],attr_v))
end
end

function UILingShouAttrDetailWin:RefreshAttrList2(isInit)

local c2=#self.attrlist2
if isInit then
self.attrCreater2:setChildLayoutGroupCreateItems(c2)
end
local gridlist2=self.attrCreater2:getChildLayoutGroupGridList()
for i=1,c2 do
local item=gridlist2[i-1]
local attr=self.attrlist2[i]
local attrID=attr[1]
local attr_v=attr[2]
if attr_v<0 then
attr_v=0
end
local cfg=cfg_attributesconfig_get(attrID)
item:SetChildText(0,cfg.attrname)
if not self.curPage then
item:SetChildText(1,helper.getAttributeStrEx(attrID,attr_v))
item:SetChildText(2,'')
else
item:SetChildText(1,'')
item:SetChildText(2,cfg.desc or'')
end
end
end

function UILingShouAttrDetailWin:refreshQuestionBtn()
local iconname
if self.curPage then
iconname='button_tyjieshao_2'
else
iconname='button_tyjieshao_1'
end
self.questionBtn:setSprite(globalABLookup.global,iconname)
end

function UILingShouAttrDetailWin:onQuestionClick()
self.curPage=not self.curPage
self:refreshQuestionBtn()
self:RefreshAttrList2()
end
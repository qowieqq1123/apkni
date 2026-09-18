







def_class("UIZaoWuGeSelectSuitWin",UIWindowBase)









function UIZaoWuGeSelectSuitWin:bindComponents()

self.back=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.closeButton=UIButton.get(self,2)
self.Root=UIObject.get(self,3)
self.suitList=UIObject.get(self,4)
self.suitScrollView=UIObject.get(self,5)
self.uiRoot=UIObject.get(self,6)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIZaoWuGeSelectSuitWin")end)



end


function UIZaoWuGeSelectSuitWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.suitList);self.suitList=nil;
_UIObject_release(self.suitScrollView);self.suitScrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local CmpSuitItemIndex={
name=0,
icon=1,
desc=2,
selectButton=3,
}

local _ab="ui/windows/zaowuge/zaowuge_atlas_pak.ab"




function UIZaoWuGeSelectSuitWin:onLoaded(...)
_this=self

self:bindComponents()
end


function UIZaoWuGeSelectSuitWin:__delete()
_this=nil

self:unbindComponents()
end




function UIZaoWuGeSelectSuitWin:onShow(argtable,afterOnloaded)

if afterOnloaded then
self.bgSpine:setChildUIModelShowTarget(6028,1,{},eAnimationID.enter)
end


local cfgs=cfg_zaowugesuitconfig()

local cfgLen=#cfgs

local createSuitFunc=function(index)
if _this==nil then return end

local item=self.suitList:getChildLayoutGroupGridItem(index-1)

local data=cfgs[index]

local isShow=data~=nil
item:SetChildActive(-1,isShow)

if isShow then
item:SetChildText(CmpSuitItemIndex.name,data.name)

item:SetChildCSImageSprite(CmpSuitItemIndex.icon,_ab,data.icon)

local desc
for index,info in ipairs(data.attrTypeList)do
if desc then
desc=FMT.fmt("{0}\n{1}",desc,info)
else
desc=info
end
end
item:SetChildText(CmpSuitItemIndex.desc,desc)


item:SetChildButtonClick(CmpSuitItemIndex.selectButton,function()
if _this==nil then return end

UIManager:invokeUIMethod("UIZaoWuGeWin",'refreshSelectItem',data.suitId)
_this:closeSelf()
end,true)
else
logErr("缺少对应云舟阵器套装的配置,suitId =",data.suitId)
end
end

self.suitList:setChildLayoutGroupCreateItems(cfgLen,createSuitFunc)
end


function UIZaoWuGeSelectSuitWin:onHide()

end

function UIZaoWuGeSelectSuitWin:onBack()
self:closeSelf()
end




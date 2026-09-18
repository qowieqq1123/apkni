







def_class("UIBonusPreviewWin",UIWindowBase)









function UIBonusPreviewWin:bindComponents()

self.creater=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.notInfo=UIObject.get(self,2)
self.tabList=UIObject.get(self,3)
self.tabScrollView=UIObject.get(self,4)



end


function UIBonusPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.notInfo);self.notInfo=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tabScrollView);self.tabScrollView=nil;
end
















local _this




function UIBonusPreviewWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIBonusPreviewWin:__delete()
self:unbindComponents()
_this=nil
end




function UIBonusPreviewWin:onShow(argtable,afterOnloaded)
self.treeType=argtable.treeType
self.tabSelect=argtable.tabSelect

self:initTabList()
self:refreshWin()
end


function UIBonusPreviewWin:onHide()

end
function UIBonusPreviewWin:refreshWin()
self.treeId=yandaotaiModel:getTreeIdByTypeAndTabIdx(self.treeType,self.tabSelect)
self.list=yandaotaiModel:getPreviewList(self.treeId)
self:refreshGrid()
end

function UIBonusPreviewWin:initTabList()
local showLen=0
local list=yandaotaiModel:getTechnologyTabList(self.treeType)
for i,cfg in ipairs(list)do
if yandaotaiModel:getIsShowTree(cfg.id)then
showLen=showLen+1
end
end

local len=#list
if showLen>1 then
self.tabList:setActive(true)
self.tabList:setChildLayoutGroupCreateItems(len,function(index)
local widget=_this.tabList:getChildLayoutGroupGridItem(index-1)
local cfg=list[index]
local isShow=yandaotaiModel:getIsShowTree(cfg.id)
widget:SetChildActive(-1,isShow)
if isShow then
widget:SetChildActive(0,_this.tabSelect==index)
widget:SetChildText(1,cfg.name)

widget:SetChildButtonClick(2,function()
local oldWidget=_this.tabList:getChildLayoutGroupGridItem(_this.tabSelect-1)
oldWidget:SetChildActive(0,false)
widget:SetChildActive(0,true)
_this.tabSelect=index

_this:refreshWin()
end,true)
end
end)
else
self.tabList:setActive(false)
end
end




function UIBonusPreviewWin:refreshGrid()
local tNum=#self.list
local func=function(idx)
local name=self.list[idx].name
self:freshPageItem(idx,name)
end
self.creater:setChildLayoutGroupCreateItems(tNum,func)

self.notInfo:setActive(tNum==0)
end

function UIBonusPreviewWin:freshPageItem(pageidx,name)
local widget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local pageCfg=self:addAllBonus(self.list[pageidx].list)
local len=#pageCfg
local func=function(idx)
self:freshChildItem(pageidx,idx,pageCfg)
end
widget:SetChildText(2,name)
widget:SetChildLayoutGroupCreateItems(3,len,func)
end

function UIBonusPreviewWin:freshChildItem(pageidx,index,datas)
local pageWidget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildLayoutGroupGridItem(3,index-1)
local data=datas[index]
local text=yandaotaiModel:getTypeAttrDesc(data)

item:SetChildText(1,text)
end

function UIBonusPreviewWin:addAllBonus(list)
local dataList={}
for k,v in ipairs(list)do
local level=yandaotaiModel:getTechnologyListLevel(v)
table.insert(dataList,{param_1=v,param_2=level})
end
local effectList={}
local addrateDatas=yandaotaiModel:getTechnologyAddrateDatas(dataList)
for effectType,v in pairs(addrateDatas)do
if effectType==1 then
for strKey,val in pairs(v)do
if val>0 then
local key=tonumber(strKey)
table.insert(effectList,{effectType,{[key]=val}})
end
end
elseif effectType==2 then
if v[1]and v[1]>0 then
table.insert(effectList,{effectType,{v[1],0}})
end

if v[2]and v[2]>0 then
table.insert(effectList,{effectType,{0,v[2]}})
end
elseif effectType==3 then
if v[1]and v[1]>0 then
table.insert(effectList,{effectType,v})
end
elseif effectType==4 then
if v[1]and v[1]>0 then
table.insert(effectList,{effectType,v})
end
elseif effectType==5 then
for attrId,val in pairs(v)do
if val>0 then
table.insert(effectList,{effectType,{{attrId,val}}})
end
end
elseif effectType==6 then
if v>0 then
table.insert(effectList,{effectType,v})
end
elseif effectType==7 then
for xmType,vv in pairs(v)do
if vv and next(vv)~=nil then
for attrId,val in pairs(vv)do
if val>0 then
table.insert(effectList,{effectType,xmType,{{attrId,val}}})
end
end
end
end
end
end



return effectList
end

function UIBonusPreviewWin:onClickClose()
self:closeSelf()
end
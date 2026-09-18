







def_class("UIRuleWin",UIWindowBase)









function UIRuleWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.descRoot=UIObject.get(self,3)



end


function UIRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
end

















function UIRuleWin:onLoaded(...)
self:bindComponents()
end


function UIRuleWin:__delete()
self:unbindComponents()
local cb=self.closeCB
if cb then
cb()
end
end


function UIRuleWin:onHide()

end




function UIRuleWin:onShow(argtable,afterOnloaded)

local showBlack=argtable.showBlack
if showBlack==nil then showBlack=false end
self.blackBG:setActive(showBlack)

self.closeCB=argtable.closeCB
self.title:setText(argtable.title or'规则说明')
self.desclist=nil
if argtable.mode==1 then
if argtable.datas~=nil and#argtable.datas>0 then
self.desclist=argtable.datas
end
elseif argtable.mode==2 then
if argtable.num~=nil and argtable.num>0 then
self.desclist={}
local name=argtable.name
for i=1,argtable.num do
table.insert(self.desclist,cfgHelper.get1(cfg_lang_get,string.format(name,i)))
end
end
elseif argtable.mode==3 then
self.desclist={}
local num=argtable.num or 10
local name=argtable.name
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(self.desclist,str)
end
end
end
self:refreshDesc()


local moveSortOrder=argtable.moveSortOrder
if moveSortOrder then
local pos=self:getChildCanvas(-1)
self:setChildCanvas(-1,pos[1],pos[2]+moveSortOrder)
end

self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.05)
tween:SetDelay(0.25)
end

function UIRuleWin:refreshDesc()
if self.desclist==nil then return end
local c=#self.desclist
if c<=0 then return end
self.descRoot:setChildLayoutGroupCreateItems(c)
local gridlist=self.descRoot:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
item:SetChildText(0,self.desclist[i])
end
end
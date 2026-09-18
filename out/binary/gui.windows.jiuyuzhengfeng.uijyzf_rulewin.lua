







def_class("UIJYZF_RuleWin",UIWindowBase)









function UIJYZF_RuleWin:bindComponents()

self.list=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.scrollview=UIObject.get(self,2)
self.title=UIText.get(self,3)



end


function UIJYZF_RuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIJYZF_RuleWin:onLoaded(...)
self:bindComponents()
end


function UIJYZF_RuleWin:__delete()
self:unbindComponents()
end




function UIJYZF_RuleWin:onShow(argtable,afterOnloaded)

argtable={mode=3,name='UIJYZF_RuleWin_%d',title="规则说明"}

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


function UIJYZF_RuleWin:onHide()

end

function UIJYZF_RuleWin:refreshDesc()
if self.desclist==nil then return end
local c=#self.desclist
if c<=0 then return end
self.list:setChildLayoutGroupCreateItems(c)
local gridlist=self.list:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
item:SetChildText(0,self.desclist[i])
end
end












def_class("UIRuleListWin",UIWindowBase)









function UIRuleListWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.descRoot=UIObject.get(self,3)
self.btnListPanel=UIObject.get(self,4)



end


function UIRuleListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.btnListPanel);self.btnListPanel=nil;
end
















function UIRuleListWin:onLoaded(...)
self:bindComponents()
end


function UIRuleListWin:__delete()
local cb=self.closeCB
if cb then
cb()
end
self:unbindComponents()
end


function UIRuleListWin:onHide()

end




function UIRuleListWin:onShow(argtable,afterOnloaded)

local showBlack=argtable.showBlack
if showBlack==nil then showBlack=false end
self.blackBG:setActive(showBlack)

self.closeCB=argtable.closeCB
self.selectIndex=argtable.selectIndex or 1
self.btnList=nil
local ruleList=argtable.ruleList
for i,v in ipairs(ruleList)do
if not self.btnList then
self.btnList={}
end
local desclist=nil
if v.mode==1 then
if v.datas~=nil and#v.datas>0 then
desclist=v.datas
end
elseif v.mode==2 then
if v.num~=nil and v.num>0 then
desclist={}
local name=v.name
for i=1,v.num do
table.insert(desclist,cfgHelper.get1(cfg_lang_get,string.format(name,i)))
end
end
elseif v.mode==3 then
desclist={}
local num=v.num or 10
local name=v.name
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(desclist,str)
end
end
end
local temp={btnTxt=v.btnTxt,desclist=desclist,title=v.title}
table.insert(self.btnList,temp)
end

self:refreshBtn()
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

function UIRuleListWin:refreshDesc()
self.descRoot:setChildLayoutGroupClearAllItems()
self.title:setText(self.btnList[self.selectIndex].title or'规则说明')
local desclist=self.btnList[self.selectIndex].desclist
if desclist==nil then return end
local c=#desclist
if c<=0 then return end
self.descRoot:setChildLayoutGroupCreateItems(c)
local gridlist=self.descRoot:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
item:SetChildText(0,desclist[i])
end
end

function UIRuleListWin:refreshBtn()
if self.btnList==nil then return end
local c=#self.btnList
if c<=0 then return end
self.btnListPanel:setChildLayoutGroupCreateItems(c)
local gridlist=self.btnListPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
item:SetChildActive(0,self.selectIndex==i)
item:SetChildText(1,self.btnList[i].btnTxt)
item:SetChildButtonClick(-1,function()
self:onclickBtn(i)
end)
end
end

function UIRuleListWin:onclickBtn(index)
if self.selectIndex~=index then
local item=self.btnListPanel:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,true)
if self.selectIndex then
local olditem=self.btnListPanel:getChildLayoutGroupGridItem(self.selectIndex-1)
olditem:SetChildActive(0,false)
end
self.selectIndex=index
self:refreshDesc()
end
end









def_class("UIServerTransferRuleWin",UIWindowBase)









function UIServerTransferRuleWin:bindComponents()

self.ruleContent=UIObject.get(self,0)
self.rulePanel=UIObject.get(self,1)
self.tabContent=UIObject.get(self,2)
self.title=UIText.get(self,3)



end


function UIServerTransferRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ruleContent);self.ruleContent=nil;
_UIObject_release(self.rulePanel);self.rulePanel=nil;
_UIObject_release(self.tabContent);self.tabContent=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIServerTransferRuleWin:onLoaded(...)
self:bindComponents()

end


function UIServerTransferRuleWin:__delete()
self:unbindComponents()
end




function UIServerTransferRuleWin:onShow(argtable,afterOnloaded)
self.ruleCfg=cfgHelper.get2(cfg_switchserverlevelbasicconfig_get,1,"transferRules")

self.descLookup={}
self.selectRightTabIdx=1
self.selectTopTabIdx=1
self:refreshRuleTitle()
self:refreshRulePanel()


local tabNames={}
for i,v in ipairs(self.ruleCfg)do
table.insert(tabNames,v.tabName)
end
local args={
init=1,
names=tabNames,
click=function(idx)
if self and not self.isClose then
self:onClickRightTab(idx)
end
end,
}
self:showWindow("UITabListComponent8",args)
end

function UIServerTransferRuleWin:refreshRuleTitle()
local tabTitle=self.ruleCfg[self.selectRightTabIdx].tabTitle
self.title:setText(tabTitle)
end

function UIServerTransferRuleWin:onClickRightTab(idx)
self.selectRightTabIdx=idx
self.selectTopTabIdx=1
self:refreshRuleTitle()
self:refreshRulePanel()
end

function UIServerTransferRuleWin:refreshRulePanel()
local rules=self.ruleCfg[self.selectRightTabIdx].rules
local len=#rules
if len>1 then
self.rulePanel:setChildSizeDelta(1057,489)
self.tabContent:setActive(true)
self.tabContent:setChildLayoutGroupCreateItems(len,function(index)
local item=self.tabContent:getChildLayoutGroupGridItem(index-1)
local name=rules[index].name
item:SetChildButtonClick(0,function()
if self and not self.isClose then
self:onClickTopTab(index)
end
end)
item:SetChildActive(1,index==self.selectTopTabIdx)
item:SetChildText(2,name)
end)
else
self.rulePanel:setChildSizeDelta(1057,545)
self.tabContent:setActive(false)
end
self:refreshRuleDesc()
end

function UIServerTransferRuleWin:onClickTopTab(idx)
if self.selectTopTabIdx==idx then
return
end
local item=self.tabContent:getChildLayoutGroupGridItem(self.selectTopTabIdx-1)
item:SetChildActive(1,false)
self.selectTopTabIdx=idx
item=self.tabContent:getChildLayoutGroupGridItem(self.selectTopTabIdx-1)
item:SetChildActive(1,true)
self:refreshRuleDesc()
end

function UIServerTransferRuleWin:refreshRuleDesc()
local rules=self.ruleCfg[self.selectRightTabIdx].rules
local prefix=rules[self.selectTopTabIdx].prefix
local descList={}
if self.descLookup[prefix]then
descList=self.descLookup[prefix]
else
local max=99
for i=1,max do
local str=cfgHelper.get1(cfg_lang_get,string.format(prefix,i))
if str~=nil then
table.insert(descList,str)
else
break
end
end
self.descLookup[prefix]=descList
end
local len=#descList
self.ruleContent:setChildLayoutGroupCreateItems(len,function(index)
local item=self.ruleContent:getChildLayoutGroupGridItem(index-1)
local str=descList[index]
item:SetChildText(0,str)
end)
end
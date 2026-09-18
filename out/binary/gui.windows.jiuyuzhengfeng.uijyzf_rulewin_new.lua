







def_class("UIJYZF_RuleWin_New",UIWindowBase)









function UIJYZF_RuleWin_New:bindComponents()

self.list=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.scrollview=UILoopListView.new(self,2)
self.title=UIText.get(self,3)

self.scrollview:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIJYZF_RuleWin_New:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.root);self.root=nil;
self.scrollview:deleteSelf();self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end
















local ItemType={
eEmpty=0,
eDesc=1,
eRuleItem_1=2,
eRuleItem_2=3,
eRuleItem_3=4,
eRuleItem_5=5,
eRuleItem_Auto=6,
}

local prefabNames={
[ItemType.eEmpty]="emptyItem",
[ItemType.eDesc]="descItem",
[ItemType.eRuleItem_1]="ruleItem_1",
[ItemType.eRuleItem_2]="ruleItem_2",
[ItemType.eRuleItem_3]="ruleItem_3",
[ItemType.eRuleItem_5]="ruleItem_5",
[ItemType.eRuleItem_Auto]="ruleItem_auto",
}

local refreshFuncName={
[ItemType.eEmpty]="refreshFunc_EmptyItem",
[ItemType.eDesc]="refreshFunc_DescItem",
[ItemType.eRuleItem_1]="refreshFunc_RuleItem_1",
[ItemType.eRuleItem_2]="refreshFunc_RuleItem_2",
[ItemType.eRuleItem_3]="refreshFunc_RuleItem_3",
[ItemType.eRuleItem_5]="refreshFunc_RuleItem_5",
[ItemType.eRuleItem_Auto]="refreshFunc_RuleItem_auto",
}




function UIJYZF_RuleWin_New:onLoaded(...)
self:bindComponents()
end


function UIJYZF_RuleWin_New:__delete()
self:unbindComponents()
end




function UIJYZF_RuleWin_New:onShow(argtable,afterOnloaded)
self.title:setText('规则说明')















local baseCfg=cfg_xianyulevelbasicconfig_get(1)
local list=baseCfg.ruleCfg
















































if list and#list>0 then
local tempList={}
local prefabnameList={}
for i,temp in ipairs(list)do
local name=prefabNames[temp.itemType]
if not name then
logErr("prefabNames 为 nil",temp.itemType)
return
end
table.insert(prefabnameList,name)
end
self.scrollview:initDataEx(prefabnameList,list)
else
self.scrollview:initData(nil,nil,0)
end
end


function UIJYZF_RuleWin_New:onHide()

end

function UIJYZF_RuleWin_New:onFreshAction(index,widget,data)
local item=widget

local funcName=refreshFuncName[data.itemType]
if funcName and self[funcName]then
self[funcName](self,item,data)
else
logErr("UIJYZF_RuleWin_New refreshFuncName 没有刷新方法",data.itemType)
end
end


function UIJYZF_RuleWin_New:onStartAction()
end

function UIJYZF_RuleWin_New:refreshFunc_EmptyItem(item,data)
item:SetChildSizeDelta(0,1070,data.hight)
end

function UIJYZF_RuleWin_New:refreshFunc_DescItem(item,data)
item:SetChildText(2,data.desc)
item:ForceLayoutVertical(0)
local txtY=item:GetChildRectHeight(2)
local itemHiget=txtY
item:SetChildSizeDelta(0,1070,itemHiget+15)
end

function UIJYZF_RuleWin_New:refreshFunc_RuleItem_1(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
end

function UIJYZF_RuleWin_New:refreshFunc_RuleItem_2(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
item:SetChildText(3,data.txt2)
end

function UIJYZF_RuleWin_New:refreshFunc_RuleItem_3(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
item:SetChildText(3,data.txt2)
item:SetChildText(4,data.txt3)
end

function UIJYZF_RuleWin_New:refreshFunc_RuleItem_5(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
item:SetChildText(3,data.txt2)
item:SetChildText(4,data.txt3)
item:SetChildText(5,data.txt4)
item:SetChildText(6,data.txt5)
end

function UIJYZF_RuleWin_New:refreshFunc_RuleItem_auto(item,data)
item:SetChildText(1,data.title)
local list=data.list
local layouH=114
if#list>0 then
local num=math.ceil(#list/3)
item:SetChildLayoutGroupCreateItems(3,num,function(index)
local grid=item:GetChildLayoutGroupGridItem(3,index-1)
grid:SetChildActive(0,index%2==1)
for i=1,3,1 do
local dataIndex=(index-1)*3+i
local txt=list[dataIndex]
if txt then
grid:SetChildText(i,txt)
else
grid:SetChildText(i,"")
end
end
end)
layouH=64+num*50+(num-1)*18
else
item:SetChildLayoutGroupClearAllItems(3)
end
item:ForceLayoutVertical(3)
item:SetChildSizeDelta(2,1030,layouH+19)
item:SetChildSizeDelta(0,1070,layouH+21)
end




































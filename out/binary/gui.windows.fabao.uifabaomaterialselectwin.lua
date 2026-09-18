







def_class("UIFabaoMaterialSelectWin",UIWindowBase)









function UIFabaoMaterialSelectWin:bindComponents()

self.title=UIText.get(self,0)
self.Dropdown1=UIDropdownEx.get(self,1)
self.Dropdown2=UIDropdownEx.get(self,2)
self.Contect=UIObject.get(self,3)



end


function UIFabaoMaterialSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.Contect);self.Contect=nil;
end


















function UIFabaoMaterialSelectWin:onLoaded(...)
self:bindComponents()
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(2,...)end)


local stagelist=table.toTable(1,fabaoConfig.maxStage())
self.stagelist=stagelist
local stageNames=itemsFilterHelper.getFilterNames(stagelist,function(stage)
return FMT.fmt('{0}阶及以上',stage)
end,'所有阶数')
self.dropnames={}
self.dropnames[1]=stageNames

self.filterData={}
self.filterData[1]=0
self.filterData[2]=0
end

function UIFabaoMaterialSelectWin:__delete()
self:unbindComponents()
tipsManager.closeTips()
end

function UIFabaoMaterialSelectWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.fbType=argtable.fbType
self.titleTxt=argtable.title
self.holeIdx=argtable.holeIdx
self.filterlist=argtable.filterlist
self.needcolor=argtable.color

local filterlist=self.filterlist or{}
local selectGuids={}
for i=1,3 do
local itemguid=filterlist[i]
if itemguid then
selectGuids[tostring(itemguid)]=true
end
end
self.selectGuids=selectGuids


local colorlist=table.toTable(self.needcolor,eQualityColor.eRed)
self.colorlist=colorlist
local colorNames=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以上',eQualityColorName[color])
end)
self.dropnames[2]=colorNames

self:initDrop()

self:freshInfo()
end

function UIFabaoMaterialSelectWin:onHide()

end




function UIFabaoMaterialSelectWin:freshInfo()
self.title:setText(self.titleTxt)

local filter={}

filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eNot,{FABAO_TYPE.eBenMing}}


local filterIdx=self.filterData[1]
if filterIdx>0 then
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eGreaterEquals,self.stagelist[filterIdx]}
end


local filterIdx=self.filterData[2]+1
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,self.colorlist[filterIdx]}






filter[ITEM_FILTER_TYPE.eFaBaoMaterialsType]=self.fbType

local list=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter)

local sortTag={}
for i,v in ipairs(list)do
local itemid=v.itemid
local itemguid=v.itemguid
local itemCfg=itemsConfig.getConfig(itemid)
local jllv=fabaoModel.getFabaoJilianLevel(itemguid)
local lhtimes=fabaoModel.getFabaoLianhuanum(itemguid)
local selectTag=self.selectGuids[tostring(itemguid)]==true and 1 or 0
sortTag[tostring(itemguid)]=selectTag*100000000+itemCfg.stage*10000000+itemCfg.color*1000000+(jllv+lhtimes)*1000-i
end
if#list>1 then
table.sort(list,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end
local len=#list
self.list=list
self.Contect:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
local item=list[i]
local itemid=item.itemid
local itemguid=item.itemguid
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local stage=itemCfg.stage
local item=fabaoHelper.getFabao(itemguid)
local name=fabaoHelper.getFabaoName(item)
local jllv=fabaoModel.getFabaoJilianLevel(itemguid)
local lhtimes=fabaoModel.getFabaoLianhuanum(itemguid)
local desc=FMT.fmt('精炼+{0}      炼化+{1}',jllv,lhtimes)
local isSelect=tostring(self.selectguid)==tostring(itemguid)
local isput=self.selectGuids[tostring(itemguid)]==true
desc=string.replaceSpace(desc)
if isput then
self:onSelect(i,itemguid,itemid,i)
end


widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildButtonClick(5,function()
self:onSelect(i,itemguid,itemid,i)
end)
widget:SetChildIcon(1,itemsModel.getIconName(item),false)
widget:SetChildText(2,name)
widget:SetChildText(3,desc)
widget:SetChildActive(4,isSelect)
widget:SetChildActive(5,true)
widget:SetChildActive(6,true)
widget:SetChildText(7,FMT.fmt('{0}阶',stage))
widget:SetChildActive(8,isput)
end)
end

function UIFabaoMaterialSelectWin:onSelect(i,itemguid,itemid,formType)
if tostring(self.selectguid)==tostring(itemguid)then return end
local isput=self.selectGuids[tostring(itemguid)]==true
local formType=TIPS_FORM_TYPE.eFaBaoMaterialSelect
if isput then formType=nil end
self.selectguid=itemguid

local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
widget:SetChildActive(5,true)
widget:SetChildActive(6,true)
tipsManager.showTips({formType=formType,
backType=TIPS_BACK_TYPE.eNone,
itemguid=itemguid,
itemid=itemid,
attach={index=self.holeIdx}})

for i,v in ipairs(self.list)do
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
if widget then
local isSelect=tostring(self.selectguid)==tostring(v.itemguid)
widget:SetChildActive(4,isSelect)
end
end
end

function UIFabaoMaterialSelectWin:initDrop()
self.Dropdown1:setOption(self.dropnames[1])
self.Dropdown1:setValue(0)

self.Dropdown2:setOption(self.dropnames[2])
self.Dropdown2:setValue(0)
end

function UIFabaoMaterialSelectWin:onDropdownChange(dropIdx,index)
local filterIdx=self.filterData[dropIdx]
if filterIdx==index then return end
self.filterData[dropIdx]=index
self:freshInfo()
end
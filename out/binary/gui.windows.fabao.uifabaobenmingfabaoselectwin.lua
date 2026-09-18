







def_class("UIFabaoBenMingFaBaoSelectWin",UIWindowBase)









function UIFabaoBenMingFaBaoSelectWin:bindComponents()

self.Dropdown=UIDropdownEx.get(self,0)
self.Dropdown2=UIDropdownEx.get(self,1)
self.equipLine=UIObject.get(self,2)
self.fabaoScrollView=UILoopListView.new(self,3)
self.Item_Label1=UIText.get(self,4)
self.Item_Label2=UIText.get(self,5)
self.title=UIText.get(self,6)

self.fabaoScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIFabaoBenMingFaBaoSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Dropdown);self.Dropdown=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.equipLine);self.equipLine=nil;
self.fabaoScrollView:deleteSelf();self.fabaoScrollView=nil;
_UIObject_release(self.Item_Label1);self.Item_Label1=nil;
_UIObject_release(self.Item_Label2);self.Item_Label2=nil;
_UIObject_release(self.title);self.title=nil;
end
















local CmpFaBaoItemIndex={
quality=0,
icon=1,
stage=2,
name1=3,
name2=4,
select=5,
stageBg=6,
count=7,
countBg=8,
star=9,
suitIcon=10,
liandon=11,
liandonL=12,
lock=13,
headBg=14,
head=15,
xmhead=16,
equipFlag=17,
select2=18,
jumpDz=19,
}



function UIFabaoBenMingFaBaoSelectWin:onLoaded(...)
self:bindComponents()

self.Dropdown:setChangeAction(function(...)self:onDropdownChange(1,...)end)

self.dropnames={{"全部"}}
end


function UIFabaoBenMingFaBaoSelectWin:__delete()
self:unbindComponents()
end




function UIFabaoBenMingFaBaoSelectWin:onShow(argtable,afterOnloaded)

self.selectGuid=argtable and argtable.itemguid

self:initDropdown()

self:refreshAll()

end


function UIFabaoBenMingFaBaoSelectWin:onHide()

end



function UIFabaoBenMingFaBaoSelectWin:refreshAll()

self:refreshLoopView()

end

function UIFabaoBenMingFaBaoSelectWin:refreshLoopView()
self.fbDatalist=self:getFaBaoDataList()

self.fabaoScrollView:initData('equipItem',self.fbDatalist,#self.fbDatalist)
end

function UIFabaoBenMingFaBaoSelectWin:initDropdown()
self.Dropdown:setOption(self.dropnames[1])
self.Dropdown:setValue(0)
end

function UIFabaoBenMingFaBaoSelectWin:onDropdownChange(dIdx,index)

end


function UIFabaoBenMingFaBaoSelectWin:onStartAction()
end

function UIFabaoBenMingFaBaoSelectWin:onFreshAction(index,widget)
local item=self.fbDatalist[index][2]

local isShow=item~=nil
widget:SetChildActive(-1,isShow)
if not isShow then return end

local itemid=item.itemid
local itemguid=item.itemguid
local name=''
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local fightStr=''
local jinglianStr=''
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local iconName
local star=0
local suitIcon=''
local isLD=false
local isEquipLD=false
local isLock=false
if itemsConfig.isEquip(itemid)then
local equip=equipsHelper.getEquip(itemguid)
local suitid=item.itemData and item.itemData.suitid or 0
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitName=suitConfig and FMT.fmt('[{0}]',suitConfig.name)or''
name=itemsModel.getNameByItem(item)
name=FMT.fmt('{0}{1}',suitName,name)
fightStr=equipsHelper.getEquipFightX(itemid,itemguid)
iconName=itemsModel.getIconName(item)
isEquipLD=liandonModel:getIsLianDonItem(itemid)
local jinglianlv=itemsConfig.isEquip(itemid)and item.itemData.jinglianlv
jinglianStr=(jinglianlv and jinglianlv>0)and FMT.fmt('+{0}',jinglianlv)or''
suitIcon=equipsHelper.getEquipSuitIcon(item)
isLock=bagHelper.isLock(equip)
elseif itemsConfig.isFabao(itemid)then
name=item.itemData.name
fightStr=fabaoHelper.getBaseFight(itemid,itemguid)
iconName=itemsModel.getIconName(item)
local jinglianlv=item.itemData and item.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
elseif itemsConfig.isDaoBing(itemid)then
name=itemConfig.name
fightStr=daobingHelper.getEquipFightX(itemid,itemguid)
iconName=iconHelper.getIconName(itemid)
isLD=liandonModel:getIsLianDonItem(itemid)
local jinglianlv=daobingModel:getJilianLv(itemguid)
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
star=daobingModel:getStarLv(itemguid)
stageStr=''
elseif itemsConfig.isMount(itemid)then
name=itemConfig.name
fightStr=mountHelper.getFight(itemid)
iconName=iconHelper.getIconName(itemid)
isLD=liandonModel:getIsLianDonItem(itemid)
jinglianStr=''
stageStr=''
end
name=FMT.cfmt(color,name)



local isSelect=mathHelper.compareInt64(itemguid,self.selectGuid)

if isSelect then
self.selectIdx=index
end


widgetHelper.setItemQulaity(widget,itemid,CmpFaBaoItemIndex.quality)
widget:SetChildIcon(CmpFaBaoItemIndex.icon,iconName,false)
widget:SetChildText(CmpFaBaoItemIndex.stage,stageStr)
widget:SetChildText(CmpFaBaoItemIndex.name1,FMT.cfmt(color,name))
widget:SetChildText(CmpFaBaoItemIndex.name2,fightStr)
widget:SetChildActive(CmpFaBaoItemIndex.select,isSelect)
widget:SetChildActive(CmpFaBaoItemIndex.stageBg,stageStr~='')
widget:SetChildText(CmpFaBaoItemIndex.count,jinglianStr)
widget:SetChildActive(CmpFaBaoItemIndex.countBg,jinglianStr~='')
widget:SetChildStarNumber(CmpFaBaoItemIndex.star,star)
widget:SetChildIcon(CmpFaBaoItemIndex.suitIcon,suitIcon,false)
widget:SetChildActive(CmpFaBaoItemIndex.liandon,isLD)
widget:SetChildActive(CmpFaBaoItemIndex.liandonL,isEquipLD)
widget:SetChildActive(CmpFaBaoItemIndex.lock,isLock)

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)

local isDressed=fabaoHelper.isDressed(itemguid)
widget:SetChildActive(CmpFaBaoItemIndex.headBg,false)
widget:SetChildActive(CmpFaBaoItemIndex.equipFlag,isDressed and(not isSelect))
widget:SetChildActive(CmpFaBaoItemIndex.select2,isSelect)












widget:SetBaseItemClickEvent(-1,function(...)
if self.selectIdx then
local pItem=self.fabaoScrollView:getListViewItemWidgetByDataIndex(self.selectIdx)
if pItem then
pItem:SetChildActive(CmpFaBaoItemIndex.select,false)
end
end

self.selectIdx=index
self.selectGuid=itemguid
widget:SetChildActive(CmpFaBaoItemIndex.select,true)

local attach={}
if not isSelect then
attach.insertBtnList={TIPS_BTNS_TYPE.eRefineBenMingFaBao}
end
tipsManager.showTips({itemguid=itemguid,attach=attach})
end)

widget:SetChildButtonClick(CmpFaBaoItemIndex.jumpDz,function()
self:jumpDiscipleInfoWin(item.itemData.discipleguid)
end,true)
end

function UIFabaoBenMingFaBaoSelectWin:getFaBaoDataList()
local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao

filter[ITEM_FILTER_TYPE.eIsBenMingFabao]={ITEM_FILTER_COMPARE.eEquals,true}

local equipList=fabaoModel.getEquipByFilter(filter)
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter)

for i,v in ipairs(bagList)do
equipList[#equipList+1]=v
end

local equipWeigetList={}
local widget,isDressed,itemCfg,itemJinLianLevel,isSelect
for index,item in ipairs(equipList)do
widget=0

isSelect=mathHelper.compareInt64(self.selectGuid,item.itemguid)
widget=widget+(isSelect and 1000000 or 0)

isDressed=fabaoHelper.isDressed(item.itemguid)
widget=widget+(isDressed and 100000 or 0)

itemCfg=itemsConfig.getConfig(item.itemid)

widget=widget+itemCfg.color*10000
widget=widget+itemCfg.stage*1000

itemJinLianLevel=item.itemData and item.itemData.jilianlv or 0
widget=widget+itemJinLianLevel

equipWeigetList[#equipWeigetList+1]={widget,item}
end

table.sort(equipWeigetList,function(a,b)
return a[1]>b[1]
end)

return equipWeigetList
end

function UIFabaoBenMingFaBaoSelectWin:jumpDiscipleInfoWin(guid)
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid},FULL_TAB_TYPE.eDiscipleInfo)
end








def_class("UINewEquipGainWin",UIWindowBase)









function UINewEquipGainWin:bindComponents()

self.root=UIObject.get(self,0)
self.filterPage=UIObject.get(self,1)
self.gainPage=UIObject.get(self,2)
self.dressToggle=UIToggleButton.get(self,3)
self.gainScrollView=UIScrollView.get(self,4)
self.gainTitle=UIText.get(self,5)
self.bagEndLine=UIObject.get(self,6)
self.bagLine=UIObject.get(self,7)
self.bagScrollView=UIEnhancedScrollerLua.get(self,8)
self.canEquipTitle=UIText.get(self,9)
self.title=UIText.get(self,10)
self.equipLine=UIObject.get(self,11)
self.dressToggleText=UIText.get(self,12)
self.Dropdown1=UIDropdownEx.get(self,13)
self.Dropdown2=UIDropdownEx.get(self,14)
self.nameText=UIText.get(self,15)
self.bagPage=UIObject.get(self,16)
self.equipItem=UIBaseItem.get(self,17)
self.unEquipTitle=UIObject.get(self,18)
self.Item_Label=UIText.get(self,19)
self.equipFilterBtn=UIButton.get(self,20)
self.tipsDi=UIButton.get(self,21)
self.filterRoot=UIObject.get(self,22)
self.titleName=UIText.get(self,23)
self.pageCreater=UIObject.get(self,24)
self.btnReset=UIButton.get(self,25)
self.btnConfirm=UIButton.get(self,26)
self.closeFilterBtn=UIButton.get(self,27)

self.equipFilterBtn:setButtonClick(function()self:onEquipFilterBtn()end)

self.tipsDi:setButtonClick(function()self:onTipsDi()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.closeFilterBtn:setButtonClick(function()self:onCloseFilterBtn()end)



end


function UINewEquipGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.filterPage);self.filterPage=nil;
_UIObject_release(self.gainPage);self.gainPage=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.gainTitle);self.gainTitle=nil;
_UIObject_release(self.bagEndLine);self.bagEndLine=nil;
_UIObject_release(self.bagLine);self.bagLine=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.canEquipTitle);self.canEquipTitle=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.equipLine);self.equipLine=nil;
_UIObject_release(self.dressToggleText);self.dressToggleText=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.bagPage);self.bagPage=nil;
_UIObject_release(self.equipItem);self.equipItem=nil;
_UIObject_release(self.unEquipTitle);self.unEquipTitle=nil;
_UIObject_release(self.Item_Label);self.Item_Label=nil;
_UIObject_release(self.equipFilterBtn);self.equipFilterBtn=nil;
_UIObject_release(self.tipsDi);self.tipsDi=nil;
_UIObject_release(self.filterRoot);self.filterRoot=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.closeFilterBtn);self.closeFilterBtn=nil;
end

















local _filterType=
{
efitler1=1,
efitler2=2,
}

local _movePosX=
{
[TIPS_MOVE_POS.eRight]=20,
[TIPS_MOVE_POS.eLeft]=-280,
}
local _dropItemHeight=50
local _dropViewHeight=280

local pageItemCmpIndex={
name=0,
childCreater=1,
toggle=2,
checkMark=3,
}

local childItemCmpIndex={
toggle=0,
name=1,
icon=2,
bg=3,
}
local _this=nil
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)

function UINewEquipGainWin:onLoaded(...)
self:bindComponents()
_this=self
self.filterFlag={}
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(2,...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(1,...)end)
self.Dropdown2:setDropdownLayoutedAction(function(...)self:onDropdownCreate(2,...)end)
self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)
self.equipItem:setBaseItemClickEvent(function(...)self:onEquipItemClick(...)end)

self.enhancedscrollscript=UIPrepareEnScroller(self.bagScrollView:getGameObject(),self.bagScrollView:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self.gainScrollView:bindScrollWidget(function(...)
self:fillGainData(...)
end)
self.isToggleDress=false
self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self.dressToggleText:setText('显示已穿戴')
self:freshToggle()

self:addNotify(notifyConfig.closeUI,function(...)self:onCloseUI(...)end)

self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
UIManager:showWindow('UIDialgueBackPanel')
end


function UINewEquipGainWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)

self.child=nil
if self.isShowTips then
tipsManager.closeTips()
end
UIManager:closeWindow('UIDialgueBackPanel')
end

function UINewEquipGainWin:onShow(args,afterOnloaded)
args=args or{}
self.gainname=args.name or'获取途径'
self.item=args.item
self.list=args.list
self.produce=args.produce
self.filter=args.filter
self.filterfunc=args.filterfunc
self.diziguid=args.diziguid
self.itemid=args.itemid

self.titleTxt=args.title

self.filterList={}
local filterList=self.filterList
for _,filterTable in ipairs(self.filter)do
local filterType=filterTable.type
local valuelist=filterTable.list
if valuelist then
filterList[filterType]=valuelist
end
end
local itemid=self.itemid
local isEquip=itemsConfig.isEquip(itemid)
local isFabao=itemsConfig.isFabao(itemid)
self.gainTitleTxt='可通过以下途径获取'
self.nameTxt=args.name or'装备列表'
self.canEquipTxt=args.gainTitle


self.selectFilter={}
self.filterItems={}

self.itemType=itemsConfig.getMainType(itemid)



self:freshName()
self:initFilter(self.filter)
self:freshBagPage(true)
self:freshEquipPage()
self:freshGainPage()

if UIManager:isActive('UITipsExWin')then
if UIManager:isActive('UIDialgueBackPanel')then
local wincfg=UIManager.get_window_config('UIDialgueBackPanel')
local canvasIdx=wincfg.canvas
self:setCanvasIndex(-1,canvasIdx)
else
self:setAsFirstSibling(-1)
end
end
end


function UINewEquipGainWin:onHide()

end


function UINewEquipGainWin:freshName()
self.nameText:setText(self.gainname)
self.title:setText(self.titleTxt)
end

function UINewEquipGainWin:freshEquipPage(isCloseTips)
local hasItem=self.item~=nil
self.equipItem:setActive(hasItem)
self.unEquipTitle:setActive(not hasItem)






if isCloseTips then
if self.selectguid then
local guid=self.selectguid
self.selectguid=nil
self:refreshItem(guid)
end
self:closeTips()
elseif hasItem and self.selectguid==nil then
self.selectguid=self.item.itemguid
self.isSelectEquip=true
self:showTips(self.item.itemid,self.item.itemguid)
elseif not hasItem and self.selectguid==nil and self.isShowTips then
self:closeTips()
elseif self.selectguid and not self.isShowTips then
self.isSelectEquip=true
local itemid=bagModel.getItemIdByGUID(self.selectguid)
self:showTips(itemid,self.selectguid)
else
self:showTipsDi()
end

self:fillItem(self.item)
end

function UINewEquipGainWin:fillItem(item)
if item==nil then return end
local prop={}
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
local isxmEquip=0
local asset=""
local xmstageStr=''
local ninglianStar=0

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

isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=itemConfig.stage and FMT.fmt('仙·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_jinlian1"
ninglianStar=equipsModel.getNingLianStar(equip)
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=itemConfig.stage and FMT.fmt('魔·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_moyan1"
ninglianStar=equipsModel.getNingLianStar(equip)
end
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

local widget=self.equipItem:getWidgetBase()

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconName,false)
widget:SetChildText(2,stageStr)
widget:SetChildText(3,FMT.cfmt(color,name))
widget:SetChildText(4,fightStr)
widget:SetChildActive(5,self.selectguid==itemguid)
widget:SetChildActive(6,stageStr~=''or xmstageStr~='')
widget:SetChildText(7,jinglianStr)
widget:SetChildActive(8,jinglianStr~='')
widget:SetChildStarNumber(9,star)
widget:SetChildIcon(10,suitIcon,false)
widget:SetChildActive(11,isLD)
widget:SetChildActive(12,isEquipLD)
widget:SetChildActive(13,isLock)
widget:SetChildText(15,xmstageStr)
if asset~=""and ninglianStar and ninglianStar>0 then
widget:SetChildActive(14,true)
local xmWidget=widget:GetChildWidgetBase(14)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
else
widget:SetChildActive(14,false)
end
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
end


function UINewEquipGainWin:freshGainPage()
local noitem=self.filterItems==nil or#self.filterItems==0
if self.showGainPage==noitem then return end
local hasMainItem=self.item~=nil
self.showGainPage=noitem
self.gainTitle:setText(noitem and self.gainTitleTxt or'')
self.canEquipTitle:setText(noitem and self.canEquipTxt or'')
self.gainPage:setActive(noitem)

self.dressToggle:setActive(true)
if noitem then
local produce=self.produce or{}
local len=#produce
self.gainScrollView:freshGridsNum(len,len,1,self.initGain~=true)
self.initGain=true
end
end

function UINewEquipGainWin:fillGainData(index,widget)
local info=self.produce[index]
local jump=info.jump
local hasjump=jump~=nil
local unLock,err=self:checkGainUnLock(info)
local isUnlock=jump and unLock or false
widget:SetChildText(0,info.desc)
widget:SetChildActive(1,not unLock)
widget:SetChildActive(2,isUnlock)
widget:SetChildButtonClick(3,function()
if not hasjump then

return
end
if isUnlock then
jumpManager:jump(jump)
else
UIManager.error(err)
end
end)
end

function UINewEquipGainWin:checkGainUnLock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
return false,systemModel.getOpenTips(sysid)
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,FMT.fmt('宗门等级不足{0}级，无法跳转',lv)
end
end
return true
end


function UINewEquipGainWin:freshBagPage(isInit)

local list=self:getFilterList(self.list)
self.filterBagList=list or{}
local haslist=list~=nil and#list>0



if self.itemType==ITEM_MAIN_TYPE.eEquip then
if isInit and not self.item then
if haslist then
if self.selectguid==nil then
local item=list[1]
self.selectguid=item.itemguid
self.isSelectEquip=false

end
else
self.selectguid=nil
end
end
end
if haslist then
local hasItem=self.item~=nil
local showBagLine=true
if hasItem then showBagLine=false end
self.bagLine:setActive(showBagLine)
self.bagEndLine:setActive(true)
local len=#list
self.enhancedscrollscript:initData(self.filterBagList,102,#self.filterBagList)
self.isInit=true
else
self.enhancedscrollscript:initData({},102,0)
self.isInit=false
self.bagLine:setActive(false)
self.bagEndLine:setActive(false)
end
end

function UINewEquipGainWin:getFilterList(list)
if list==nil or#list==0 then
self.filterItems={}
return
end
local selectfilters=self.selectFilter
local filterfunc=self.filterfunc
local filterList=self.filterList
local filter={}
if self.itemType~=ITEM_MAIN_TYPE.eEquip then
for filterType,index in pairs(selectfilters)do
local filterList=filterList[filterType]or{}
if index==0 then
filter[filterType]=nil
else
filter[filterType]=filterList[index]or index
end
end
else

local hasFilter=false
local filterFlag=self.filterFlag
for _,vt in pairs(self._filter)do
local filterType=vt.filterType
local _list=vt.list
local filterTypeData=filterFlag[filterType]or{}
local has=false
for i,v in ipairs(_list)do
local isToggle=filterTypeData[i]or false
if isToggle then
if filter[filterType]==nil then filter[filterType]={}end
filter[filterType][1]=ITEM_FILTER_COMPARE.eEquals
if filter[filterType][2]==nil then filter[filterType][2]={}end
local filterTable=filter[filterType][2]
filterTable[#filterTable+1]=v
end
has=has or isToggle
end

if not has then
if filter[filterType]==nil then filter[filterType]={}end
filter[filterType]={ITEM_FILTER_COMPARE.eEquals,nil}
end
hasFilter=hasFilter or has
end
end



if filterfunc==nil then
return list
end
if not self.isToggleDress then
filter[ITEM_FILTER_TYPE.eIsDress]=false
end
local temp=filterfunc(filter)
self.filterItems=temp
return temp
end

function UINewEquipGainWin:onStartAction()

end

function UINewEquipGainWin:onRefreshRankItem(widget,itemInfo)
if itemInfo==nil or not widget then return end
widget:SetChildActive(-1,true)
local count=itemInfo.itemcount
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local diziguid=0
local itemData=itemInfo.itemData or{}
local name=''
local fightStr=''
local jinglianStr=''
local hasEquiped=false
local iconName
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local star=0
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local suitIcon=''
local isLD=false
local isEquipLD=false
local isLock=false
local isxmEquip=0
local asset=""
local xmstageStr=''
local ninglianStar=0
local switchidx=0

if itemsConfig.isEquip(itemid)then
local equip=equipsHelper.getEquip(itemguid)
local suitid=itemInfo.itemData and itemInfo.itemData.suitid or 0
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitName=suitConfig and FMT.fmt('[{0}]',suitConfig.name)or''
name=itemsModel.getNameByItem(itemInfo)
name=FMT.fmt('{0}{1}',suitName,name)
fightStr=equipsHelper.getEquipFightX(itemid,itemguid)
local jinglianlv=itemsConfig.isEquip(itemid)and itemData.jinglianlv
jinglianStr=(jinglianlv and jinglianlv>0)and FMT.fmt('+{0}',jinglianlv)or''
diziguid=equipsModel.getDiziguidByItemguid(itemguid)
switchidx=equipsModel.getEquipSwitchIdx(itemguid)or 0
iconName=itemsModel.getIconName(itemInfo)
suitIcon=equipsHelper.getEquipSuitIcon(itemInfo)
isEquipLD=liandonModel:getIsLianDonItem(itemid)
isLock=bagHelper.isLock(equip)

isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_jinlian1"
ninglianStar=equipsModel.getNingLianStar(equip)
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_moyan1"
ninglianStar=equipsModel.getNingLianStar(equip)
end
elseif itemsConfig.isFabao(itemid)then
name=itemInfo.itemData.name or''
fightStr=fabaoHelper.getBaseFight(itemid,itemguid)
diziguid=fabaoModel.getDiziguidByItemguid(itemguid)
switchidx=fabaoModel.getFabaoSwitchIdx(itemguid)or 0
iconName=itemsModel.getIconName(itemInfo)
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
elseif itemsConfig.isDaoBing(itemid)then
name=itemConfig.name
fightStr=daobingHelper.getEquipFightX(itemid,itemguid)
iconName=iconHelper.getIconName(itemid)
diziguid=daobingModel:getDiziguidByItemguid(itemguid)
switchidx=daobingModel:getEquipSwitchIdx(itemguid)or 0
isLD=liandonModel:getIsLianDonItem(itemid)
local jinglianlv=daobingModel:getJilianLv(itemguid)
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
star=daobingModel:getStarLv(itemguid)
stageStr=''
elseif itemsConfig.isMount(itemid)then
name=itemConfig.name
fightStr=mountHelper.getFight(itemid)
iconName=iconHelper.getIconName(itemid)
diziguid=mountModel:getDzguidByItemguid(itemguid)
isLD=liandonModel:getIsLianDonItem(itemid)
jinglianStr=''
stageStr=''
end
hasEquiped=diziguid~=nil
local isSelect=self.selectguid==itemguid
name=FMT.cfmt(color,name)

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconName,false)
widget:SetChildText(2,stageStr)
widget:SetChildText(3,name)
widget:SetChildText(4,fightStr)
widget:SetChildActive(5,isSelect)
widget:SetChildActive(6,hasEquiped)
widget:SetChildText(8,jinglianStr)
widget:SetChildActive(9,stageStr~=''or xmstageStr~='')
widget:SetChildActive(10,jinglianStr~='')
widget:SetChildStarNumber(11,star)
widget:SetChildIcon(12,suitIcon,false)
widget:SetChildActive(13,isLD)
widget:SetChildActive(14,isEquipLD)
widget:SetChildActive(15,isLock)
widget:SetChildText(17,xmstageStr)
if asset~=""and ninglianStar and ninglianStar>0 then
widget:SetChildActive(16,true)
local xmWidget=widget:GetChildWidgetBase(16)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
else
widget:SetChildActive(16,false)
end
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetBaseItemClickEvent(-1,function(...)self:onBagItemClick(...)end)

local isShowVoc=false
if hasEquiped then
local isSPdz=UIDiscipleModel:isSPDiscipleEx(diziguid)
isShowVoc=isSPdz
comHelper.setChildModelRawImage(widget,diziguid,7,0,eHeadCenterType.eHead,0.6,nil,nil,switchidx)
end
widget:SetChildActive(18,isShowVoc)
widget:SetChildActive(19,isShowVoc)
if isShowVoc then
local switchJobIcon=UIDiscipleModel:getJobIconNameX(diziguid,switchidx)
widget:SetChildCSImageSprite(18,globalABLookup.global,switchJobIcon)
end
end

function UINewEquipGainWin:freshToggle(isToggle)
self.dressToggle:setToggle(self.isToggleDress)
end



function UINewEquipGainWin:freshFilterPage()
local filter=self.filter or{}
local filterLen=#filter
local hasOne=filterLen>=_filterType.efitler1
local hasTwo=filterLen>=_filterType.efitler2
self.Dropdown1:setActive(hasOne)
self.Dropdown2:setActive(hasTwo)
if hasOne then
local filter1=table.deepCopy(self.filter[_filterType.efitler1])
local options=table.reverse(filter1)
self.dropdown1Option=options
self.Dropdown1:setOption(options)
local dropType=filter1.type
local suitLen=self:getFilterLen(dropType)
local idx=self.selectFilter[dropType]or 0
local reIdx=suitLen-1-idx

self.Dropdown1:setValue(reIdx)
end
if hasTwo then
local filter2=table.deepCopy(self.filter[_filterType.efitler2])
local options=table.reverse(filter2)
self.dropdown2Option=options
self.Dropdown2:setOption(options)
local dropType=filter2.type
local weaponLen=self:getFilterLen(dropType)
local idx=self.selectFilter[dropType]or 0
local reIdx=weaponLen-1-idx

self.Dropdown2:setValue(reIdx)
end
end

function UINewEquipGainWin:getFilterLen(filterType)
for i,v in ipairs(self.filter)do
if v.type==filterType then
return#v
end
end
end

function UINewEquipGainWin:onChanged()

end


function UINewEquipGainWin:onDropdownChange(dropidx,reIdx)

local filter=self.filter[dropidx]
local selectFilterType=filter.type
local len=#filter
local idx=len-1-reIdx

if self.selectFilter[selectFilterType]==idx then return end
self.selectFilter[selectFilterType]=idx
if not self.isSelectEquip then self.selectguid=nil end

self:freshBagPage(true)
self:freshGainPage()
if self.selectguid==nil and self.item then
self:freshEquipPage()
end
end

function UINewEquipGainWin:onDropdownCreate(dropidx,scrollTrans,contentTrans)
local filter=self.filter[dropidx]
local dropType=filter.type
local len=self:getFilterLen(dropType)
local idx=self.selectFilter[dropType]or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end

contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UINewEquipGainWin:onToggleChanged(name,isToggle,data)
if self.isToggleDress==isToggle then return end
self.isToggleDress=isToggle

self:freshToggle()
if not self.isSelectEquip then
self.selectguid=nil
end
self:freshBagPage(true)
self:freshGainPage()
if self.selectguid==nil and self.item then
self:freshEquipPage()
end
end


function UINewEquipGainWin:onGainItemClick(id,index,guid,attach)

local produce=self.produce
local jumpArgs=produce[id].jump
if jumpArgs then
jumpManager:jump(jumpArgs)
else
loggerUtil.logErrFMT('道具{0}获取途径中跳转没有配置',self.itemid)
end
end

function UINewEquipGainWin:onBagItemClick(id,index,guid,attach)
self:onSelectItem(id,guid)
end

function UINewEquipGainWin:onEquipItemClick(id,index,guid,attach)
self:onSelectItem(id,guid)
end

function UINewEquipGainWin:onCloseUI(name)
if name=='UITipsWin'then
self:clearSelectFlag()
end
end

function UINewEquipGainWin:clearSelectFlag()
local oldguid=self.selectguid
self.selectguid=nil
if oldguid then
self:refreshItem(oldguid)
end
end

function UINewEquipGainWin:onSelectItem(id,guid)
if self.selectguid==guid then return end
local oldguid=self.selectguid
self.selectguid=guid
local item=self.item
local itemguid
if item then itemguid=item.itemguid end
self.isSelectEquip=guid==itemguid
self.equipItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetActive,5,itemguid==guid)
if oldguid then
self:refreshItem(oldguid)
end
self:refreshItem(guid)
self:freshEquipPage()
self:showTips(id,guid)
end

function UINewEquipGainWin:showTips(itemid,itemguid)

local backType=TIPS_BACK_TYPE.eNone
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipListWin,
itemid=itemid,
itemguid=itemguid,
showModel=false,
movepos=TIPS_MOVE_POS.eRight,
backType=backType,
attach={diziguid=self.diziguid}})

self.isShowTips=true
self:showTipsDi()
end

function UINewEquipGainWin:closeTips()

tipsManager.closeTips()

self.isShowTips=false
self:showTipsDi()
end

function UINewEquipGainWin:doAni()
if self.movepos then
self.winlua:SetChildDOLocalMoveX(self.root:getID(),_movePosX[self.movepos],0.5)
end
end

function UINewEquipGainWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:refreshItem(itemguid)
self:freshEquipPage()
end

function UINewEquipGainWin:refreshItem(itemguid)

local startIdx=_this.enhancedscrollscript:getStartCellViewIndex()
local endIdx=_this.enhancedscrollscript:getEndCellViewIndex()

for i=startIdx,endIdx do
local dataIndex=i+1
local data=_this.filterBagList[dataIndex]
if data and data.itemguid==itemguid then
local cell=_this.enhancedscrollscript:GetCell(i)
_this.enhancedscrollscript:RefreshCell(dataIndex,dataIndex,cell)
end
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end


function UIPrepareEnScroller:RefreshCell(i,cellIndex,item)
local data=self.window.filterBagList[i]
self.window:onRefreshRankItem(item,data)
end




function UINewEquipGainWin:initFilter(filterdata)
self._filter={}
for i,_data in ipairs(filterdata)do
if _data.type then
local Datatemp={}
Datatemp.filterType=_data.type
if _data.type==ITEM_FILTER_TYPE.eWeapon then
Datatemp.name="武器"





Datatemp.list=_data.list
Datatemp.childNameList={}
for k,v in ipairs(Datatemp.list)do
Datatemp.childNameList[#Datatemp.childNameList+1]=_data[k+1]or""
end
Datatemp.sortid=1
elseif _data.type==ITEM_FILTER_TYPE.eSuitEquip then
Datatemp.name="套装"
Datatemp.list=_data.list
Datatemp.childNameList={}
for k,v in ipairs(Datatemp.list)do
Datatemp.childNameList[#Datatemp.childNameList+1]=_data[k+1]or""
end
Datatemp.sortid=2
elseif _data.type==ITEM_FILTER_TYPE.eEquipRandomAttr then
Datatemp.name="随机属性"
Datatemp.list=_data.list
Datatemp.childNameList={}
for k,v in ipairs(Datatemp.list)do
Datatemp.childNameList[#Datatemp.childNameList+1]=_data[k]or""
end
Datatemp.sortid=3
end
self._filter[#self._filter+1]=Datatemp
end
end

if self._filter and#self._filter then
table.sort(self._filter,function(a,b)
return a.sortid<b.sortid
end)
end
end
function UINewEquipGainWin:onEquipFilterBtn()
if self.isShowFilter then
self:onCloseFilterBtn()
return
end
self.isShowFilter=true
self.filterRoot:setActive(true)
self:updateView()
self:freshEquipPage(true)
self:freshGainPage()
end
function UINewEquipGainWin:onCloseFilterBtn()
self.isShowFilter=false
self.filterRoot:setActive(false)

self:freshBagPage(true)
self:freshEquipPage()
self:freshGainPage()
end
function UINewEquipGainWin:onBtnReset()
for i,v in pairs(self.filterFlag)do
for i1,v1 in pairs(v)do
self.filterFlag[i][i1]=false
end
end
self:updateView()
self:freshBagPage()
self:freshEquipPage(true)
self:freshGainPage()
end
function UINewEquipGainWin:onTipsDi()
self:freshEquipPage(true)
end
function UINewEquipGainWin:showTipsDi()
local oldMovepos=self.movepos
if self.isShowTips or self.isShowFilter then
self.movepos=TIPS_MOVE_POS.eLeft
else
self.movepos=TIPS_MOVE_POS.eRight
end

if oldMovepos~=self.movepos then
self:doAni()
end
self.tipsDi:setActive(self.isShowTips and self.isShowFilter)
end
function UINewEquipGainWin:updateView()
local pagenum=#self._filter
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end
function UINewEquipGainWin:refreshPageItem(item,pageidx)
local pageData=self._filter[pageidx]
local pageTitle=pageData.name
local childNameList=pageData.childNameList
self.filterFlag[pageData.filterType]=self.filterFlag[pageData.filterType]or{}
local childFlagList=self.filterFlag[pageData.filterType]

item:SetChildText(pageItemCmpIndex.name,pageTitle)

local childnum=#childNameList
item:SetChildLayoutGroupCreateItems(pageItemCmpIndex.childCreater,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
self:refreshChildItem(childItem,i,childNameList,childFlagList,pageidx)
end

item:SetChildActive(pageItemCmpIndex.toggle,false)
end
function UINewEquipGainWin:refreshChildItem(childItem,idx,childNameList,childFlagList,pageidx)
local desc_str=childNameList[idx]
local isselect=childFlagList[idx]or false
childItem:SetChildToggleChange(childItemCmpIndex.toggle,nil)
childItem:SetChildToggle(childItemCmpIndex.toggle,isselect)
childItem:SetChildToggleChange(childItemCmpIndex.toggle,function(name,isOn)
childFlagList[idx]=isOn
_this:freshBagPage(true)
_this:freshBagPage()
_this:freshGainPage()
end)
childItem:SetChildText(childItemCmpIndex.name,desc_str)
end

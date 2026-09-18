







def_class("UIEquipGainWin",UIWindowBase)









function UIEquipGainWin:bindComponents()

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



end


function UIEquipGainWin:unbindComponents()
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

local _this=nil

local UIPrepareEnScroller=simple_class(UIEnhancedScroller)

function UIEquipGainWin:onLoaded(...)
self:bindComponents()
_this=self
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(2,...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(1,...)end)
self.Dropdown2:setDropdownLayoutedAction(function(...)self:onDropdownCreate(2,...)end)
self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)
self.equipItem:setBaseItemClickEvent(function(...)self:onEquipItemClick(...)end)
UIManager:showWindow('UIDialgueBackPanel')

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
end


function UIEquipGainWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)

self.child=nil
if self.isShowTips then
tipsManager.closeTips()
end
UIManager:closeWindow('UIDialgueBackPanel')
end

function UIEquipGainWin:onShow(args,afterOnloaded)
args=args or{}
self.gainname=args.name or'获取途径'
self.item=args.item
self.list=args.list
self.produce=args.produce
self.filter=args.filter
self.filterfunc=args.filterfunc
self.diziguid=args.diziguid
self.itemid=args.itemid
self.movepos=args.movepos
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

self:freshName()
self:freshEquipPage()
self:freshBagPage()
self:freshGainPage()
self:freshFilterPage()
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


function UIEquipGainWin:onHide()

end


function UIEquipGainWin:freshName()
self.nameText:setText(self.gainname)
self.title:setText(self.titleTxt)
end

function UIEquipGainWin:freshEquipPage()
local hasItem=self.item~=nil
self.equipItem:setActive(hasItem)
self.unEquipTitle:setActive(not hasItem)
if hasItem and self.selectguid==nil then
self.selectguid=self.item.itemguid
self.isSelectEquip=true
self:showTips(self.item.itemid,self.item.itemguid)
end
self:fillItem(self.item)
end

function UIEquipGainWin:fillItem(item)
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

local widget=self.equipItem:getWidgetBase()

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconName,false)
widget:SetChildText(2,stageStr)
widget:SetChildText(3,FMT.cfmt(color,name))
widget:SetChildText(4,fightStr)
widget:SetChildActive(5,self.selectguid==itemguid)
widget:SetChildActive(6,stageStr~='')
widget:SetChildText(7,jinglianStr)
widget:SetChildActive(8,jinglianStr~='')
widget:SetChildStarNumber(9,star)
widget:SetChildIcon(10,suitIcon,false)
widget:SetChildActive(11,isLD)
widget:SetChildActive(12,isEquipLD)
widget:SetChildActive(13,isLock)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
end


function UIEquipGainWin:freshGainPage()
local noitem=self.filterItems==nil or#self.filterItems==0
if self.showGainPage==noitem then return end
local hasMainItem=self.item~=nil
self.showGainPage=noitem
self.gainTitle:setText(noitem and self.gainTitleTxt or'')
self.canEquipTitle:setText(noitem and self.canEquipTxt or'')
self.gainPage:setActive(noitem)
self.filterPage:setActive(true)
self.dressToggle:setActive(true)
if noitem then
local produce=self.produce or{}
local len=#produce
self.gainScrollView:freshGridsNum(len,len,1,self.initGain~=true)
self.initGain=true
end
end

function UIEquipGainWin:fillGainData(index,widget)
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

function UIEquipGainWin:checkGainUnLock(v)
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


function UIEquipGainWin:freshBagPage(setZero)
local isZero=self.isInit==nil or setZero==true or false
local list=self:getFilterList(self.list)
self.filterBagList=list or{}
local haslist=list~=nil and#list>0
if not haslist and self.item==nil then
self:closeTips()
end
if haslist then
local hasItem=self.item~=nil
local showBagLine=true
if hasItem then showBagLine=false end
self.bagLine:setActive(showBagLine)
self.bagEndLine:setActive(true)
local len=#list
if self.selectguid==nil then
local item=list[1]
self.selectguid=item.itemguid
self.isSelectEquip=false
self:showTips(item.itemid,item.itemguid)
end
self.enhancedscrollscript:initData(self.filterBagList,102,#self.filterBagList)
self.isInit=true
else
self.enhancedscrollscript:initData({},102,0)
self.isInit=false
self.bagLine:setActive(false)
self.bagEndLine:setActive(false)
end
end

function UIEquipGainWin:getFilterList(list)
if list==nil or#list==0 then
self.filterItems={}
return
end
local selectfilters=self.selectFilter
local filterfunc=self.filterfunc
local filterList=self.filterList
local filter={}
for filterType,index in pairs(selectfilters)do
local filterList=filterList[filterType]or{}
if index==0 then
filter[filterType]=nil
else
filter[filterType]=filterList[index]or index
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

function UIEquipGainWin:onStartAction()

end

function UIEquipGainWin:onRefreshRankItem(widget,itemInfo)
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
widget:SetChildActive(9,stageStr~='')
widget:SetChildActive(10,jinglianStr~='')
widget:SetChildStarNumber(11,star)
widget:SetChildIcon(12,suitIcon,false)
widget:SetChildActive(13,isLD)
widget:SetChildActive(14,isEquipLD)
widget:SetChildActive(15,isLock)
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

function UIEquipGainWin:freshToggle(isToggle)
self.dressToggle:setToggle(self.isToggleDress)
end



function UIEquipGainWin:freshFilterPage()
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

function UIEquipGainWin:getFilterLen(filterType)
for i,v in ipairs(self.filter)do
if v.type==filterType then
return#v
end
end
end

function UIEquipGainWin:onChanged()

end


function UIEquipGainWin:onDropdownChange(dropidx,reIdx)

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

function UIEquipGainWin:onDropdownCreate(dropidx,scrollTrans,contentTrans)
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

function UIEquipGainWin:onToggleChanged(name,isToggle,data)
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


function UIEquipGainWin:onGainItemClick(id,index,guid,attach)

local produce=self.produce
local jumpArgs=produce[id].jump
if jumpArgs then
jumpManager:jump(jumpArgs)
else
loggerUtil.logErrFMT('道具{0}获取途径中跳转没有配置',self.itemid)
end
end

function UIEquipGainWin:onBagItemClick(id,index,guid,attach)
self:onSelectItem(id,guid)
end

function UIEquipGainWin:onEquipItemClick(id,index,guid,attach)
self:onSelectItem(id,guid)
end

function UIEquipGainWin:onCloseUI(name)
if name=='UITipsWin'then
self:clearSelectFlag()
end
end

function UIEquipGainWin:clearSelectFlag()
local oldguid=self.selectguid
self.selectguid=nil
if oldguid then
self:refreshItem(oldguid)
end
end

function UIEquipGainWin:onSelectItem(id,guid)
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

function UIEquipGainWin:showTips(itemid,itemguid)
self.movepos=TIPS_MOVE_POS.eLeft
local backType=TIPS_BACK_TYPE.eNone
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipListWin,
itemid=itemid,
itemguid=itemguid,
showModel=false,
movepos=TIPS_MOVE_POS.eRight,
backType=backType,
attach={diziguid=self.diziguid}})
self:doAni()
self.isShowTips=true
end

function UIEquipGainWin:closeTips()
self.movepos=TIPS_MOVE_POS.eRight
tipsManager.closeTips()
self:doAni()
self.isShowTips=false
end

function UIEquipGainWin:doAni()
if self.movepos then
self.winlua:SetChildDOLocalMoveX(self.root:getID(),_movePosX[self.movepos],0.2)
end
end

function UIEquipGainWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:refreshItem(itemguid)
self:freshEquipPage()
end

function UIEquipGainWin:refreshItem(itemguid)

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

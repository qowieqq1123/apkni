







def_class("UIVocEquipGainWin",UIWindowBase)









function UIVocEquipGainWin:bindComponents()

self.bagScrollView=UIEnhancedScrollerLua.get(self,0)
self.btnConfirm=UIButton.get(self,1)
self.btnReset=UIButton.get(self,2)
self.closeFilterBtn=UIButton.get(self,3)
self.dressToggle=UIToggleButton.get(self,4)
self.filterRoot=UIObject.get(self,5)
self.equipFilterBtn=UIButton.get(self,6)
self.equipItem=UIBaseItem.get(self,7)
self.gainPage=UIObject.get(self,8)
self.gainBtn=UIButton.get(self,9)
self.gainTitle=UIText.get(self,10)
self.pageCreater=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.tipsDi=UIButton.get(self,13)
self.titleName=UIText.get(self,14)
self.unEquipTitle=UIObject.get(self,15)
self.equipRoot=UIObject.get(self,16)
self.btnClose=UIButton.get(self,17)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.closeFilterBtn:setButtonClick(function()self:onCloseFilterBtn()end)

self.equipFilterBtn:setButtonClick(function()self:onEquipFilterBtn()end)

self.gainBtn:setButtonClick(function()self:onGainBtn()end)

self.tipsDi:setButtonClick(function()self:onTipsDi()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIVocEquipGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.closeFilterBtn);self.closeFilterBtn=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.filterRoot);self.filterRoot=nil;
_UIObject_release(self.equipFilterBtn);self.equipFilterBtn=nil;
_UIObject_release(self.equipItem);self.equipItem=nil;
_UIObject_release(self.gainPage);self.gainPage=nil;
_UIObject_release(self.gainBtn);self.gainBtn=nil;
_UIObject_release(self.gainTitle);self.gainTitle=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsDi);self.tipsDi=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.unEquipTitle);self.unEquipTitle=nil;
_UIObject_release(self.equipRoot);self.equipRoot=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
end
















local _this
local _movePosX=
{
[TIPS_MOVE_POS.eRight]=20,
[TIPS_MOVE_POS.eLeft]=-280,
}

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

local UIPrepareEnScroller=simple_class(UIEnhancedScroller)




function UIVocEquipGainWin:onLoaded(...)
self:bindComponents()

_this=self

self.filterFlag={}

self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle()

self.enhancedscrollscript=UIPrepareEnScroller(self.bagScrollView:getGameObject(),self.bagScrollView:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self.equipItem:setBaseItemClickEvent(function(...)self:onEquipItemClick(...)end)
self:addNotify(notifyConfig.closeUI,function(...)self:onCloseUI(...)end)

UIManager:showWindow('UIDialgueBackPanel')
end


function UIVocEquipGainWin:__delete()
self:unbindComponents()

_this=nil

if self.isShowTips then
tipsManager.closeTips()
end
UIManager:closeWindow('UIDialgueBackPanel')
end




function UIVocEquipGainWin:onShow(argtable,afterOnloaded)
self.diziguid=argtable.diziguid
self.item=vocEquipModel:getEquipByDizi(self.diziguid)


self:freshBagPage()
self:freshEquipPage()
self:freshGainPage()
end


function UIVocEquipGainWin:onHide()

end

function UIVocEquipGainWin:freshToggle(isToggle)
self.dressToggle:setToggle(self.isToggleDress)
end

function UIVocEquipGainWin:freshBagPage(setZero)
local isZero=self.isInit==nil or setZero==true or false
local list=self:getFilterList(self.list)
self.filterBagList=list or{}
local haslist=list~=nil and#list>0
if not haslist and self.item==nil then
self:closeTips()
end
if haslist then
self.enhancedscrollscript:initData(self.filterBagList,102,#self.filterBagList)
self.isInit=true
else
self.enhancedscrollscript:initData({},102,0)
self.isInit=false
end
end

function UIVocEquipGainWin:freshEquipPage()
local hasItem=self.item~=nil
self.equipRoot:setActive(true)
self.equipItem:setActive(hasItem)
self.unEquipTitle:setActive(not hasItem)
self:fillItem(self.item)
end

function UIVocEquipGainWin:freshGainPage()
local noitem=self.item==nil and#self.filterBagList==0
self.equipRoot:setActive(not noitem)
self.gainPage:setActive(noitem)
self.dressToggle:setActive(not noitem)
if noitem then

self.initGain=true
end
end

function UIVocEquipGainWin:getFilterList()
local checkDress=self.dressToggle:getToggle()
local filter={}
if not self.isToggleDress then
filter[ITEM_FILTER_TYPE.eIsDress]=false
end

local diziInfo=UIDiscipleModel:getDiscipleImageInfo(self.diziguid)
local voc=diziInfo.job

local itemguid=-1
if self.item then
itemguid=self.item.itemguid
end

local items=equipListManager.getVocEquipFilterFunc(self.diziguid,itemguid,ITEM_MAIN_TYPE.eVocEquip,voc,filter)
return items
end

function UIVocEquipGainWin:refreshItem(itemguid)

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

function UIVocEquipGainWin:fillItem(item)
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
if itemsConfig.isVocEquip(itemid)then
local equip=equipsHelper.getEquip(itemguid)
name=itemConfig.name
fightStr=vocEquipHelper.getEquipFightX(itemid,itemguid)
iconName=itemsModel.getIconName(item)
isEquipLD=liandonModel:getIsLianDonItem(itemid)
local jinglianlv=item.itemData and item.itemData.enhancelv or 0
jinglianStr=(jinglianlv and jinglianlv>0)and FMT.fmt('+{0}',jinglianlv)or''
isLock=bagHelper.isLock(equip)
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

function UIVocEquipGainWin:onRefreshRankItem(widget,itemInfo)
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

local showStage=false
local stageTitile=itemsConfig.getStageName(itemid)
local star=0
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local suitIcon=''
local isLD=false
local isEquipLD=false
local isLock=false
local switchidx=0
if itemsConfig.isVocEquip(itemid)then
local equip=equipsHelper.getEquip(itemguid)
name=itemConfig.name
fightStr=vocEquipHelper.getEquipFightX(itemid,itemguid)
iconName=itemsModel.getIconName(itemInfo)
isEquipLD=liandonModel:getIsLianDonItem(itemid)
diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
switchidx=vocEquipModel:getEquipSwitchIdx(itemguid)or 0
local jinglianlv=itemInfo.itemData and itemInfo.itemData.enhancelv or 0
jinglianStr=(jinglianlv and jinglianlv>0)and FMT.fmt('+{0}',jinglianlv)or''
isLock=bagHelper.isLock(equip)
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



widget:SetChildButtonClick(18,function()
self:onBagItemClick(itemid,nil,itemguid)
end,true)

local isShowVoc=false
if hasEquiped then
local isSPdz=UIDiscipleModel:isSPDiscipleEx(diziguid)
isShowVoc=isSPdz
comHelper.setChildModelRawImage(widget,diziguid,7,0,eHeadCenterType.eHead,0.6,nil,nil,switchidx)
end
widget:SetChildActive(19,isShowVoc)
widget:SetChildActive(20,isShowVoc)
if isShowVoc then
local switchJobIcon=UIDiscipleModel:getJobIconNameX(diziguid,switchidx)
widget:SetChildCSImageSprite(19,globalABLookup.global,switchJobIcon)
end
end

function UIVocEquipGainWin:onSelectItem(id,guid)
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

function UIVocEquipGainWin:showTips(itemid,itemguid)

local args={
formType=TIPS_FORM_TYPE.eEquipListWin,
itemid=itemid,
itemguid=itemguid,
movepos=TIPS_MOVE_POS.eRight,

attach={
diziguid=self.diziguid,
pos=self.pos,
},
}
tipsManager.showTips(args)
self.isShowTips=true

end

function UIVocEquipGainWin:closeTips()
tipsManager.closeTips()
self.isShowTips=false

end

function UIVocEquipGainWin:doAni()
if self.movepos then
self.winlua:SetChildDOAnchorPosX(self.root:getID(),_movePosX[self.movepos],0.5)
end
end

function UIVocEquipGainWin:showTipsDi()
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




function UIVocEquipGainWin:onBtnConfirm()
end



function UIVocEquipGainWin:onBtnReset()
end



function UIVocEquipGainWin:onCloseFilterBtn()
end



function UIVocEquipGainWin:onEquipFilterBtn()
end



function UIVocEquipGainWin:onGainBtn()

local sfId=mapIdType.zhufeng
local bdId=SLG_SYSTEM_TYPE.eBaGuaLu1
local bdData=zongmenModel:findBuildingDataByID(sfId,bdId)
if bdData then
local diziInfo=UIDiscipleModel:getDiscipleImageInfo(self.diziguid)
local voc=diziInfo.job
local dzguid=self.diziguid
local vocEquipItemId=vocEquipHelper:get_voc_items(voc)
if vocEquipItemId then
UIFullBaGuaLuControl:showMyWindowByBuild({data=bdData,args={tabType=FULL_TAB_TYPE.eHechengLianHua}})
UIFullBaGuaLuControl:showWindow('UIHeChengLianHuaPeiFangWin',{sfId=sfId,bdData=bdData,selectPage=3,itemid=vocEquipItemId})

local args={}
args.disciple_guid=dzguid
local func=function(args_)
local guid=args_.disciple_guid
return UIFullDiscipleMainControl:myShowWindow({dis_guid=guid},FULL_TAB_TYPE.eDiscipleEquip)
end
fullScreenUI.setNextActiveUICallback(func,args)

self:closeSelf()
else

UIManager.info("暂无对应职业装备，敬请期待")
end
else
UIManager.info("请先建造八卦炉")
end
end



function UIVocEquipGainWin:onTipsDi()
end

function UIVocEquipGainWin:onBtnClose()
self:closeSelf()
end

function UIVocEquipGainWin:onToggleChanged(name,isToggle,data)
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

function UIVocEquipGainWin:onBagItemClick(id,index,guid,attach)
self:onSelectItem(id,guid)
end

function UIVocEquipGainWin:onEquipItemClick(id,index,guid,attach)
self:onSelectItem(id,guid)
end

function UIVocEquipGainWin:onCloseUI(name)
if name=='UITipsWin'then
self:clearSelectFlag()
end
end

function UIVocEquipGainWin:clearSelectFlag()
local oldguid=self.selectguid
self.selectguid=nil
if oldguid then
self:refreshItem(oldguid)
end
end

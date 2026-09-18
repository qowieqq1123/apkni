







def_class("UIBagWin",UIWindowBase)









function UIBagWin:bindComponents()

self.btnbg_1=UIImage.get(self,0)
self.btnbg_2=UIImage.get(self,1)
self.btnbg_3=UIImage.get(self,2)
self.btnbg_4=UIImage.get(self,3)
self.btnbg_5=UIImage.get(self,4)
self.btnbg_6=UIImage.get(self,5)
self.btnEMSAllImg=UIObject.get(self,6)
self.btnEMSImg=UIObject.get(self,7)
self.btnEquipMutipleSelect=UIButton.get(self,8)
self.btnfbfenjie=UIButton.get(self,9)
self.btnFilter=UIButton.get(self,10)
self.btnGoRonglian=UIButton.get(self,11)
self.btnJingLian=UIButton.get(self,12)
self.btnReddot_1=UIObject.get(self,13)
self.btnReddot_2=UIObject.get(self,14)
self.btnReddot_3=UIObject.get(self,15)
self.btnReddot_4=UIObject.get(self,16)
self.btnReddot_5=UIObject.get(self,17)
self.btnReddot_6=UIObject.get(self,18)
self.btnRonglian=UIButton.get(self,19)
self.btnSelecEquiptAll=UIButton.get(self,20)
self.btnSortImg=UIObject.get(self,21)
self.btnsRoot=UIObject.get(self,22)
self.Content=UIObject.get(self,23)
self.Dropdown1=UIDropdownEx.get(self,24)
self.filterQuickScrollView=UIObject.get(self,25)
self.filterRoot=UIObject.get(self,26)
self.limit=UIText.get(self,27)
self.ScrollView=UIScrollViewSlow.get(self,28)
self.tybg=UIImage.get(self,29)

self.btnEquipMutipleSelect:setButtonClick(function()self:onBtnEquipMutipleSelect()end)

self.btnfbfenjie:setButtonClick(function()self:onBtnfbfenjie()end)

self.btnFilter:setButtonClick(function()self:onBtnFilter()end)

self.btnGoRonglian:setButtonClick(function()self:onBtnGoRonglian()end)

self.btnJingLian:setButtonClick(function()self:onBtnJingLian()end)

self.btnRonglian:setButtonClick(function()self:onBtnRonglian()end)

self.btnSelecEquiptAll:setButtonClick(function()self:onBtnSelecEquiptAll()end)
self.btnbg={
self.btnbg_1,
self.btnbg_2,
self.btnbg_3,
self.btnbg_4,
self.btnbg_5,
self.btnbg_6,
}
self.btnReddot={
self.btnReddot_1,
self.btnReddot_2,
self.btnReddot_3,
self.btnReddot_4,
self.btnReddot_5,
self.btnReddot_6,
}



end


function UIBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnbg_1);self.btnbg_1=nil;
_UIObject_release(self.btnbg_2);self.btnbg_2=nil;
_UIObject_release(self.btnbg_3);self.btnbg_3=nil;
_UIObject_release(self.btnbg_4);self.btnbg_4=nil;
_UIObject_release(self.btnbg_5);self.btnbg_5=nil;
_UIObject_release(self.btnbg_6);self.btnbg_6=nil;
_UIObject_release(self.btnEMSAllImg);self.btnEMSAllImg=nil;
_UIObject_release(self.btnEMSImg);self.btnEMSImg=nil;
_UIObject_release(self.btnEquipMutipleSelect);self.btnEquipMutipleSelect=nil;
_UIObject_release(self.btnfbfenjie);self.btnfbfenjie=nil;
_UIObject_release(self.btnFilter);self.btnFilter=nil;
_UIObject_release(self.btnGoRonglian);self.btnGoRonglian=nil;
_UIObject_release(self.btnJingLian);self.btnJingLian=nil;
_UIObject_release(self.btnReddot_1);self.btnReddot_1=nil;
_UIObject_release(self.btnReddot_2);self.btnReddot_2=nil;
_UIObject_release(self.btnReddot_3);self.btnReddot_3=nil;
_UIObject_release(self.btnReddot_4);self.btnReddot_4=nil;
_UIObject_release(self.btnReddot_5);self.btnReddot_5=nil;
_UIObject_release(self.btnReddot_6);self.btnReddot_6=nil;
_UIObject_release(self.btnRonglian);self.btnRonglian=nil;
_UIObject_release(self.btnSelecEquiptAll);self.btnSelecEquiptAll=nil;
_UIObject_release(self.btnSortImg);self.btnSortImg=nil;
_UIObject_release(self.btnsRoot);self.btnsRoot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.filterQuickScrollView);self.filterQuickScrollView=nil;
_UIObject_release(self.filterRoot);self.filterRoot=nil;
_UIObject_release(self.limit);self.limit=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.tybg);self.tybg=nil;
self.btnbg=nil;
self.btnReddot=nil;
end

















local _colomn=5
local _menuBody=2017
local _dropItemHeight=40
local _dropViewHeight=150









local _bagIdx=
{
[SHOW_BAG_TYPE.eItemBag]=1,
[SHOW_BAG_TYPE.eMaterialsBag]=2,
[SHOW_BAG_TYPE.eEquipBag]=3,
[SHOW_BAG_TYPE.eFabaoBag]=4,
[SHOW_BAG_TYPE.eFubaoBag]=5,
[SHOW_BAG_TYPE.eRareBag]=6,
}

local _bagReddotFunc=
{
[SHOW_BAG_TYPE.eItemBag]=function()
return itemBagModel:checkReddot()
end,
[SHOW_BAG_TYPE.eRareBag]=function()
return daobingHelper.isCanAnyCombine()or vocEquipController:checkVocEquipZhuanHuanReddot_Bag()
end,
[SHOW_BAG_TYPE.eFubaoBag]=function()
return lingzhenBagModel:checkReddot()
end,
}

local _menu_slot_name='button_dytab'
local _cmpItemWidgetIdx=
{
cmpQuality=0,
cmpIcon=1,
cmpCountTxt=2,
cmpLock=3,
cmpStageTxt=4,
cmpSelect=5,
cmpBg=6,
cmpStageBg=7,
cmpNewFlag=8,
cmpCountBg=9,
cmpFabaoTag=10,
cmpReddot=11,
cmpStar=12,
cmpSuit=13,
cmpLianDon=14,
cmptask=15,
cmpReuseCountBg=16,
cmpReuseCount=17,
cmpCDTimeTxt=18,
xmicons=19,
xmstagetxt=20,
mSelect=21,
mSelectGou=22,
mSelectClick=23,
grayMask=24,
}
local _creatGirdPrecent=100

local spriteab="ui/windows/bag/bag_atlas_pak.ab"
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"




function UIBagWin:onLoaded(...)
self.tnbg={
self.tnbg_1,
self.tnbg_2,
self.tnbg_3,
self.tnbg_4,
self.tnbg_5,
}
self:bindComponents()

self.changeItemFBFUpdateFirstIndex=0
self.changeItemFBFUpdateEndIndex=0
self.changeItemFBFUpdateList={}

self.filterQuickScrollView_Active_Equip_Filter=true
self.equipFilterPartAcive=false
self.fubaoFilterPartAcive=false
self.filterQuickScrollView_Active_fubao_Filter=true


self.yuanpeiFilterWinActiveState=false

webGLHelper:uiWindowCloseCamera(self.tybg)

self._onItemListChanged=function(...)self:onItemListChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self._onItemListChanged)

self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)

self.ScrollView:setSlowClickAction(function(...)self:onScrollItemClick(...)end)

local _onFilterQuickScrollItemClick=function(...)
self:onFilterQuickScrollItemClick(...)
end
self.filterQuickScrollView:setChildScrollViewInit(0.5,true,_onFilterQuickScrollItemClick,nil)

self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(...)end)

self.selectBagType=SHOW_BAG_TYPE.eItemBag
self.curPageIndex=1
self.filterQuickIndex={}
self.lookup={}
self.space={}
self.filter={}
self.sortCompareTypes={}
self.selectDropIdxs={}
self.filterSelectList={}
self.filterFlag={}
self.cdItemlookup={}
self.sortConfigs=bagSortConfig.getAllSortConfig()
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

local _recv_ronglian=function(...)
self:recv_ronglian(...)
end
self:addProNotify(3,241,_recv_ronglian)

local _onBagYuFuFenJie=function(...)
self:onBagYuFuFenJie(...)
end
self:addProNotify(2,64,_onBagYuFuFenJie)
end

function UIBagWin:onHide()
end


function UIBagWin:__delete()
webGLHelper:uiWindowShowCamera()
self:clearTimer()
self:stopCurPosFreshAll()
self:stopFBFUpdateTimer()
self:unbindComponents()

tipsManager.closeTips()
local bagTypeList=SHOW_BAG_TYPE.getBagTypeList(self.selectBagType)
for i,v in ipairs(bagTypeList)do
bagNewHelper.clearBagNewFlag(self.selectBagType)
end

notifySystem:removelistener(notifyConfig.on_item_list_changed,self._onItemListChanged)
notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
end

function UIBagWin:onShow(argtable,afterOnloaded)
self.args=argtable
local inputBagType=argtable and argtable.bagType
local bagType=inputBagType or BAG_TYPE.eItemBag
self.selectBagType=SHOW_BAG_TYPE.getShowBagType(bagType)or self.selectBagType
if argtable and argtable.filter then
self.filter[self.selectBagType]=argtable.filter
end

self.isSelectMutipleEquip=false
self.isSelectAllEquip=false

self:freshInfo(true)
end


function UIBagWin:OnEnable()

end


function UIBagWin:OnDisable()

end



function UIBagWin:refreshfilterQuickItem(item,flag)
item:SetChildActive(0,flag)
item:SetChildActive(2,not flag)
if flag then
item:SetChildLocalPosition(1,Vector3(-12,15,0))
else
item:SetChildLocalPosition(1,Vector3(-17,19,0))
end
end

function UIBagWin:freshInfo(freshData)
self:freshGirds(freshData)
self:freshDropdowns()
self:freshSelectBtns()
self:freshAllBtnReddot()
self:freshFilterQuickGirds()
self:setLimit()
self:freshMutipleSelect()
local equipBag=SHOW_BAG_TYPE.isIncluded(self.selectBagType,BAG_TYPE.eEquipBag)
local count=zongmenModel:getBuildingCount(SLG_SYSTEM_TYPE.eBaGuaLu1,mapIdType.zhufeng)
local isInMutipleSelectMode=self:checkInMutipleSelectMode()
local iseEquip=self:isEEquipBagCheckInMutiple()
local isfubao=self:isEFuBaoBagCheckInMutiple()
local isInMutipleJingLian=self:checkInMutipleJingLianModel()
self.btnRonglian:setActive(iseEquip and isInMutipleSelectMode)
self.btnGoRonglian:setActive(iseEquip and equipBag and count>0 and(not isInMutipleSelectMode))
self.btnfbfenjie:setActive(isfubao)
self.btnJingLian:setActive(iseEquip and systemModel.isOpen(SYSTEM_DEFINE.eBagMutipleEquipJingLian)and(not isInMutipleSelectMode)and(not isInMutipleJingLian))


end

function UIBagWin:freshMutipleSelect()
local isInMutipleSelectMode=self:checkInMutipleSelectMode()
local isInMutipleJingLian=self:checkInMutipleJingLianModel()
local iseEquip=self:isEEquipBagCheckInMutiple()
local isfubao=self:isEFuBaoBagCheckInMutiple()
self.btnEquipMutipleSelect:setActive((iseEquip or isfubao)and(not isInMutipleJingLian))
if isfubao then
self.btnEquipMutipleSelect:setLocalPosY(-197)
else
self.btnEquipMutipleSelect:setLocalPosY(-140)
end
self.btnEMSImg:setActive(isInMutipleSelectMode)
self.btnSelecEquiptAll:setActive(isInMutipleSelectMode)
self.btnEMSAllImg:setActive(isInMutipleSelectMode and self.isSelectAllEquip)
self.btnRonglian:setActive(iseEquip and isInMutipleSelectMode)
self.btnfbfenjie:setActive(isfubao)
end

function UIBagWin:setLimit()
local maxNum=bagConfig.getShowBagMaxNum(self.selectBagType)
local num=0
local bagTypeList=SHOW_BAG_TYPE.getBagTypeList(self.selectBagType)
for i,v in ipairs(bagTypeList)do
num=num+bagControl.invokeFuncByBagType(v,'getBagNum')
end
self.limit:setText(FMT.fmt('库房空间：{0}/{1}',num,maxNum))
end

function UIBagWin:handleItemCDTime()
self.cdItemlookup={}
for i,v in ipairs(self.itemsList or{})do
local itemInfo=v
if itemInfo then
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local isShowCDTime=bagUseControl.getItemShowCDTime(itemid)
if isShowCDTime then
self.cdItemlookup[tostring(itemguid)]=true
end
end
end
self:setItemCDTimer()
end


function UIBagWin:setItemCDTimer()
self:clearTimer()
local func=function()
for itemguid,flag in pairs(self.cdItemlookup)do
if flag then
self:freshItemCDTime(itemguid)
end
end
end

self.timer=self:setTimer(1,0,func)
func()
end

function UIBagWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIBagWin:freshGirds(freshData)
local selectBagType=self.selectBagType
if freshData then
self.itemsList=bagControl.getShowBagItemsByFilter(selectBagType,self:getFilter(),false)
local itemsLen=#self.itemsList
self.itemsLen=itemsLen
self:onSortItems()
self:handleLookup(self.itemsList)
self:handleItemCDTime()
if self.selectBagType==BAG_TYPE.eEquipBag and self.isSelectAllEquip then
UIBagWin:mutipleSelectAll()
end
end
local itemsList=self.itemsList
local itemsLen=#itemsList
self.tPage=math.ceil(itemsLen/_creatGirdPrecent)
local curPageIndex=self.curPageIndex
local tNum=curPageIndex*_creatGirdPrecent
tNum=math.min(tNum,itemsLen)
local row=math.ceil(tNum/_colomn)+7
tNum=(row+7)*_colomn
local row=math.ceil(tNum/_colomn)
self.space={}
self.ScrollView:freshSlowGrids(tNum,row,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIBagWin:getItemIdx(itemguid)
for i,v in ipairs(self.itemsList)do
if tostring(v.itemguid)==tostring(itemguid)then
return i
end
end
end

function UIBagWin:bindGrid(index,item)
local itemInfo=self.itemsList[index]
local isTemp=itemInfo==nil
if not isTemp then
local count=itemInfo.itemcount
local showCount=count>1
local countStr=showCount and count or''
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local type1=itemConfig.type1
local isEquip=itemsConfig.isEquip(itemid)
local isFabao=itemsConfig.isFabao(itemid)
local isDaoBing=itemsConfig.isDaoBing(itemid)
local isDaoBingMaterials=itemsConfig.isDaoBingMaterials(itemid)
local isVocEquip=itemsConfig.isVocEquip(itemid)
local itemData=itemInfo.itemData or{}
local suitIcon=''
local isxmEquip=0
local asset=""
local xmstageStr=''
local ninglianStar=0

local jinglianlv=0
local isLD=false
if isDaoBing then
jinglianlv=daobingModel:getJilianLv(itemguid)
elseif isEquip then
jinglianlv=itemData.jinglianlv or 0
local suitid=itemData.suitid or 0
if suitid>0 then
local suitConfig=equipsConfig.getSuitConfig(suitid)
suitIcon=iconHelper.getSuitIcon(suitConfig.icon)
end
isLD=liandonModel:getIsLianDonItem(itemid)
elseif isFabao then
jinglianlv=itemData.jilianlv or 0
elseif isVocEquip then

jinglianlv=itemData.enhancelv or 0
end
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''

if pfwindowslController:getGameVersion()==3 then
if itemid==10532 or itemid==10533 then
if count>=1000 and count<1000000 then
local str=string.format("%.3f",count/1000)
str=str:gsub("0+$",""):gsub("%.$","")
countStr=FMT.fmt('{0}K',str)
elseif count>=1000000 and count<1000000000 then
local str=string.format("%.3f",count/1000000)
str=str:gsub("0+$",""):gsub("%.$","")
countStr=FMT.fmt('{0}Tr',str)
elseif count>=1000000000 then
local str=string.format("%.3f",count/1000000000)
str=str:gsub("0+$",""):gsub("%.$","")
countStr=FMT.fmt('{0}Tỷ',str)
end
end
end
local txt=(isEquip or isFabao or isDaoBing or isVocEquip)and jinglianStr or countStr
local iconName=itemsModel.getIconName(itemInfo)


local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
if isDaoBing or isVocEquip then
stageStr=''
end

local lzLock=false
if itemsConfig.isLingZhen(itemid)then
stageStr=FMT.fmt('{0}级',itemConfig.level)
lzLock=UIYuFuLingZhenControl:getItemLock(itemguid)
end
local hasStage=stageStr~=''
local isSelect=tostring(itemguid)==tostring(self.selectguid)
local newFlag=bagNewHelper.getNewFlag(itemguid)


local reddot=false
local hasReddot=itemConfig.hasReddot
if hasReddot and(hasReddot==1 or hasReddot==2)then
reddot=true
end
if isDaoBingMaterials then
reddot=daobingHelper.isCanCombine(itemid)
elseif isDaoBing then
reddot=false
end
if itemConfig.special_limit then
local lerp=bagUseControl.getItemCDTime(itemguid)
if lerp<=0 then
reddot=true
end
end
if itemsConfig.isLingZhen(itemid)then
local convertCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"convert")
local lv_limit=convertCfg[2]
if itemConfig.level>=lv_limit and UIYuFuLingZhenControl:checkZhuanHuanLZReddot()then
reddot=true
end
end
if isVocEquip then
reddot=vocEquipController:checkVocEquipZhuanHuanReddot()
end

local star=0
if isDaoBing then
star=daobingModel:getStarLv(itemguid)
end


local isExpire=bagUseControl.isItemExpire(itemguid)
local isGray=false
if isExpire then
isGray=true
color=0
else
local funcparam=itemConfig.funcparam
if funcparam and funcparam.type==item_funtion_type.eItemExchange and funcparam.act_check and funcparam.show_gray==1 then
local subActs=activitiesModel:getActSubList_subType_open_doing(funcparam.act_type)
local subActCnt=#subActs
if funcparam.act_check==1 and subActCnt>0 then
isGray=true
color=0
elseif funcparam.act_check==0 and subActCnt<=0 then
isGray=true
color=0
end
end
end

local istask=false
if type1 and type1==30 then
istask=true
end


local reuseCount=bagUseControl.getItemReuseCount(itemguid)

local isShowCDTime=bagUseControl.getItemShowCDTime(itemid)
local lerp=bagUseControl.getItemCDTime(itemguid)
local isShowCDTimeTxt=isShowCDTime and lerp>0

if isEquip then
isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=itemConfig.stage and FMT.fmt('仙·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_jinlian1"
ninglianStar=equipsModel.getNingLianStar(itemInfo)
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=itemConfig.stage and FMT.fmt('魔·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_moyan1"
ninglianStar=equipsModel.getNingLianStar(itemInfo)
end
end

item:SetChildGray(_cmpItemWidgetIdx.cmpIcon,isGray)

widgetHelper.setItemQulaity(item,itemid,_cmpItemWidgetIdx.cmpQuality,color)
widgetHelper.setItemQulaity(item,itemid,_cmpItemWidgetIdx.grayMask,color)
item:SetChildActive(_cmpItemWidgetIdx.grayMask,false)
item:SetChildIcon(_cmpItemWidgetIdx.cmpIcon,iconName,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpIcon,true)
item:SetChildText(_cmpItemWidgetIdx.cmpCountTxt,txt)
item:SetChildActive(_cmpItemWidgetIdx.cmpStageBg,hasStage or xmstageStr~='')
item:SetChildText(_cmpItemWidgetIdx.cmpStageTxt,stageStr)
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,isSelect)
item:SetChildActive(_cmpItemWidgetIdx.cmpBg,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpLock,bagHelper.isLock(itemInfo)or lzLock)
item:SetChildActive(_cmpItemWidgetIdx.cmpNewFlag,newFlag and(not self:checkInMutipleSelectMode()))
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,txt~=''or isShowCDTimeTxt)
item:SetChildActive(_cmpItemWidgetIdx.cmpFabaoTag,isFabao)
item:SetChildActive(_cmpItemWidgetIdx.cmpReddot,reddot)
item:SetChildActive(_cmpItemWidgetIdx.cmpLianDon,isLD)
item:SetChildActive(_cmpItemWidgetIdx.cmptask,istask)
item:SetChildStarNumber(_cmpItemWidgetIdx.cmpStar,star)
item:SetChildIcon(_cmpItemWidgetIdx.cmpSuit,suitIcon,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpReuseCountBg,reuseCount>0)
item:SetChildText(_cmpItemWidgetIdx.cmpReuseCount,reuseCount>0 and reuseCount or'')
item:SetChildText(_cmpItemWidgetIdx.cmpCDTimeTxt,isShowCDTimeTxt and timeHelper.format_time_stamp(lerp,true)or'')
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,1,itemid,false)

item:SetChildText(_cmpItemWidgetIdx.xmstagetxt,xmstageStr)
if asset~=""and ninglianStar and ninglianStar>0 then
item:SetChildActive(_cmpItemWidgetIdx.xmicons,true)
local xmWidget=item:GetChildWidgetBase(_cmpItemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
else
item:SetChildActive(_cmpItemWidgetIdx.xmicons,false)
end
item:SetBaseItemChildID(-1,itemid)
item:SetBaseItemChildGUID(-1,itemguid)

local isOpenMutipleSelect=self:checkInMutipleSelectMode()
local isInMutippleJingLianModel=self:checkInMutipleJingLianModel()
local otherState=true
if isInMutippleJingLianModel then
otherState=equipsHelper.isCanShowJinglian2(itemguid,false)
item:SetChildActive(_cmpItemWidgetIdx.grayMask,not otherState)
end
item:SetChildActive(_cmpItemWidgetIdx.mSelect,(isOpenMutipleSelect or isInMutippleJingLianModel)and otherState)
if isOpenMutipleSelect or isInMutippleJingLianModel then
local mutipleIdx=table.findValueEx(self.equipMutipleSelectList,itemInfo,function(itemData)return tostring(itemData.itemguid)end)
item:SetChildActive(_cmpItemWidgetIdx.mSelectGou,mutipleIdx~=nil)



end
else
item:SetChildActive(_cmpItemWidgetIdx.cmpQuality,false)
item:SetChildIcon(_cmpItemWidgetIdx.cmpIcon,'',false)
item:SetChildActive(_cmpItemWidgetIdx.cmpIcon,false)
item:SetChildText(_cmpItemWidgetIdx.cmpCountTxt,'')
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpStageBg,false)
item:SetChildText(_cmpItemWidgetIdx.cmpStageTxt,'')
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpBg,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpLock,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpNewFlag,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpFabaoTag,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpReddot,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpLianDon,false)
item:SetChildActive(_cmpItemWidgetIdx.cmptask,false)
item:SetChildStarNumber(_cmpItemWidgetIdx.cmpStar,0)
item:SetChildIcon(_cmpItemWidgetIdx.cmpSuit,'',false)
item:SetChildActive(_cmpItemWidgetIdx.cmpReuseCountBg,false)
item:SetChildText(_cmpItemWidgetIdx.cmpReuseCount,'')
item:SetChildText(_cmpItemWidgetIdx.cmpCDTimeTxt,'')
item:SetChildActive(_cmpItemWidgetIdx.xmicons,false)
item:SetChildActive(_cmpItemWidgetIdx.mSelect,false)
item:SetChildText(_cmpItemWidgetIdx.xmstagetxt,'')
item:SetChildCommonItemSign(1,INSTANCE_TYPE.eCommonItemSignUIExpand,nil)
item:SetBaseItemChildID(-1,-1)
item:SetBaseItemChildGUID(-1,-1)
end
end

function UIBagWin:freshSelectFlag(index,guid)
if guid==nil then return end
local isSelect=tostring(guid)==tostring(self.selectguid)
local item=self.ScrollView:getSlowItemByIndex(index-1)
if item then
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,isSelect)
end
end

function UIBagWin:freshLockFlag(itemguid)
if itemguid==nil then return end
local index=self:getIndexOnlookup(itemguid)
if index then
local item=bagModel.getItem(itemguid)
local isLock=bagHelper.isLock(item)
local widget=self.ScrollView:getSlowItemByIndex(index)
if widget then
widget:SetChildActive(_cmpItemWidgetIdx.cmpLock,isLock)
end
end
end

function UIBagWin:clearSelectFlag(itemguid)
if itemguid==nil then return end
local index=self:getIndexOnlookup(itemguid)
if index and tostring(itemguid)==tostring(self.selectguid)then
self.selectguid=nil
self.selectIdx=nil
local item=self.ScrollView:getSlowItemByIndex(index)
if item then
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
end
end
end

function UIBagWin:freshNewFlag(itemguid)
if itemguid==nil then return end
local index=self:getIndexOnlookup(itemguid)
if index then
local isNew=bagNewHelper.getNewFlag(itemguid)
local item=self.ScrollView:getSlowItemByIndex(index)
if item then
item:SetChildActive(_cmpItemWidgetIdx.cmpNewFlag,isNew)
end
end
end

function UIBagWin:freshItemCDTime(itemguid)
if itemguid==nil then return end
local index=self:getIndexOnlookup(itemguid)
if index then
local lerp=bagUseControl.getItemCDTime(itemguid)
local item=self.ScrollView:getSlowItemByIndex(index)
if item then
if lerp>0 then
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,true)
item:SetChildText(_cmpItemWidgetIdx.cmpCDTimeTxt,timeHelper.format_time_stamp(lerp,true))
else
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,false)
item:SetChildText(_cmpItemWidgetIdx.cmpCDTimeTxt,'')
end
end
end
end

function UIBagWin:onEquipJinglian(itemguid)
local item=equipsHelper.getEquip(itemguid)
local index,itemid=self:getIndexOnlookup(itemguid)

if itemid and not SHOW_BAG_TYPE.isIncluded(self.selectBagType,itemsConfig.getBagType(itemid))then return end
if index then
self.itemsList[index+1]=item
self.ScrollView:freshSlowItem(index)
end
end

function UIBagWin:onVocEquipStrengthen(itemguid)
local item=equipsHelper.getEquip(itemguid)
local index,itemid=self:getIndexOnlookup(itemguid)

if itemid and not SHOW_BAG_TYPE.isIncluded(self.selectBagType,itemsConfig.getBagType(itemid))then return end
if index then
self.itemsList[index+1]=item
self.ScrollView:freshSlowItem(index)
end
end

function UIBagWin:onFabaoJinglian(itemguid)
local item=fabaoHelper.getFabao(itemguid)
local index,itemid=self:getIndexOnlookup(itemguid)

if itemid and not SHOW_BAG_TYPE.isIncluded(self.selectBagType,itemsConfig.getBagType(itemid))then return end
if index then
self.itemsList[index+1]=item
self.ScrollView:freshSlowItem(index)
end
end


function UIBagWin:freshItemByGuid(itemguid)
if itemguid==nil then return end
local index=self:getIndexOnlookup(itemguid)
if index then
self.ScrollView:freshSlowItem(index)
end
end

function UIBagWin:freshSelectBtns()
local idx=_bagIdx[self.selectBagType]
for i,v in ipairs(self.btnbg)do
v:setSprite(spriteab,i==idx and"button_beibaoui_2"or"button_beibaoui_1")
end
end

function UIBagWin:freshSingleSelectBtn(i)
local idx=_bagIdx[self.selectBagType]
local v=self.btnbg[i]
v:setSprite(spriteab,i==idx and"button_beibaoui_2"or"button_beibaoui_1")
end

function UIBagWin:freshAllBtnReddot()
for bagType,func in pairs(_bagReddotFunc)do
local ret=func()
local index=_bagIdx[bagType]
self.btnReddot[index]:setActive(ret)
end
end

function UIBagWin:freshBagBtnReddot(bagType)
local func=_bagReddotFunc[bagType]
if func==nil then return end
local ret=func()
local index=_bagIdx[bagType]
self.btnReddot[index]:setActive(ret)
end


function UIBagWin:freshDropdowns()
local showBagType=self.selectBagType
local idx=self.selectDropIdxs[showBagType]or 0

local sortConfig=self.sortConfigs[showBagType]
local desclist={}

for i=#sortConfig,1,-1 do
desclist[#desclist+1]=sortConfig[i].name
end
self.filterLen=#sortConfig
self.Dropdown1:setOption(desclist)
self.Dropdown1:setValue(self.filterLen-1-idx)
end


function UIBagWin:clearItem(itemguid)
local index,itemid=self:getIndexOnlookup(itemguid)
if itemid and not SHOW_BAG_TYPE.isIncluded(self.selectBagType,itemsConfig.getBagType(itemid))then return end
if index then
self:addSpace(index,itemguid)
self:delelookup(itemguid)
self:deleteItemOnList(index+1,itemguid)
self:setLimit()
self.tPage=math.ceil(self.itemsLen/_creatGirdPrecent)
self.ScrollView:freshSlowItem(index)
else
if itemid then
local itemConfig=itemsConfig.getConfig(itemid)
loggerUtil.logErrFMT("没有找到要删除的道具:{0}",itemConfig.name)
end
end
end


function UIBagWin:clearItems(array)
for _,itemguid in ipairs(array or{})do
self:clearItem(itemguid)
end
end


function UIBagWin:addItem(item)
if not SHOW_BAG_TYPE.isIncluded(self.selectBagType,itemsConfig.getBagType(item.itemid))then return end
if not itemsFilterHelper.isFilter(self:getFilter(),item)then return end
local index=self:getFillIndex()
self:deleteSpace(index)
self:addlookup(index,item)
self:addItemOnList(index+1,item)
self.tPage=math.ceil(self.itemsLen/_creatGirdPrecent)

self.ScrollView:freshSlowItem(index)
self:setLimit()
end


function UIBagWin:freshItem(item)
if not SHOW_BAG_TYPE.isIncluded(self.selectBagType,itemsConfig.getBagType(item.itemid))then return end
if not itemsFilterHelper.isFilter(self:getFilter(),item)then return end
local itemguid=item.itemguid
local index,itemid=self:getIndexOnlookup(itemguid)

if index then
self:changeItemOnList(index+1,item)

self.ScrollView:freshSlowItem(index)
end
end


function UIBagWin:onSortBag(bagType)
if not SHOW_BAG_TYPE.isIncluded(self.selectBagType,bagType)then return end
self:init()
end

function UIBagWin:init()
self.curPageIndex=1
self:dofresh()
end


function UIBagWin:dofresh()
self.isSetZero=nil
self.ScrollView:clearSlowItems()
self:freshInfo(true)
self:freshSortImg()
end




function UIBagWin:handleLookup(itemsList)
local onBagType=self.selectBagType
if self.lookup==nil then self.lookup={}end
if self.lookup.lookguid==nil then self.lookup.lookguid={}end
if self.lookup.lookitemid==nil then self.lookup.lookitemid={}end

local lookup=self.lookup
if lookup.lookBagType==nil then lookup.lookBagType={}end

lookup.lookguid[onBagType]={}
lookup.lookitemid[onBagType]={}
local lookguid=lookup.lookguid[onBagType]
local lookitemid=lookup.lookitemid[onBagType]
local lookBagType=lookup.lookBagType
for i,v in ipairs(itemsList)do
local handle=tostring(v.itemguid)
lookguid[handle]=i-1
lookitemid[handle]=v.itemid
lookBagType[handle]=onBagType

end
end

function UIBagWin:getIndexOnlookup(itemguid)
if itemguid==nil then return end
local handle=tostring(itemguid)
if self.lookup==nil then self.lookup={}end
if self.lookup.lookBagType==nil then self.lookup.lookBagType={}end
local onBagType=self.lookup.lookBagType[handle]
if onBagType==nil then return end

if self.lookup.lookguid==nil then self.lookup.lookguid={}end
if self.lookup.lookitemid==nil then self.lookup.lookitemid={}end
if self.lookup.lookguid[onBagType]==nil then self.lookup.lookguid[onBagType]={}end
if self.lookup.lookitemid[onBagType]==nil then self.lookup.lookitemid[onBagType]={}end

local idx=self.lookup.lookguid[onBagType][handle]
local itemid=self.lookup.lookitemid[onBagType][handle]
if idx then return idx,itemid end
return nil,itemid
end



function UIBagWin:delelookup(itemguid)
if itemguid==nil then return end
local handle=tostring(itemguid)
if self.lookup==nil then self.lookup={}end
if self.lookup.lookBagType==nil then self.lookup.lookBagType={}end
local onBagType=self.lookup.lookBagType[handle]
if onBagType==nil or not SHOW_BAG_TYPE.isIncluded(self.selectBagType,onBagType)then return end

if self.lookup.lookguid==nil then self.lookup.lookguid={}end
if self.lookup.lookitemid==nil then self.lookup.lookitemid={}end
if self.lookup.lookguid[onBagType]==nil then self.lookup.lookguid[onBagType]={}end
if self.lookup.lookitemid[onBagType]==nil then self.lookup.lookitemid[onBagType]={}end

local lookguid=self.lookup.lookguid[onBagType]
local lookitemid=self.lookup.lookitemid[onBagType]
local lookBagType=self.lookup.lookBagType
lookguid[handle]=nil
lookitemid[handle]=nil
lookBagType[handle]=nil
end



function UIBagWin:addlookup(index,item)
local itemguid=item.itemguid
local itemid=item.itemid
local handle=tostring(itemguid)
if self.lookup==nil then self.lookup={}end
if self.lookup.lookBagType==nil then self.lookup.lookBagType={}end
local onBagType=itemsConfig.getBagType(itemid)
if not SHOW_BAG_TYPE.isIncluded(self.selectBagType,onBagType)then return end
if self.lookup.lookguid==nil then self.lookup.lookguid={}end
if self.lookup.lookitemid==nil then self.lookup.lookitemid={}end
if self.lookup.lookguid[onBagType]==nil then self.lookup.lookguid[onBagType]={}end
if self.lookup.lookitemid[onBagType]==nil then self.lookup.lookitemid[onBagType]={}end

local lookguid=self.lookup.lookguid[onBagType]
local lookitemid=self.lookup.lookitemid[onBagType]
local lookBagType=self.lookup.lookBagType
local itemid=item.itemid
lookguid[handle]=index
lookitemid[handle]=itemid
lookBagType[handle]=onBagType
end



function UIBagWin:addItemOnList(index,item)
local itemguid=item.itemguid
local itemsList=self.itemsList
local lastItem=itemsList[index]
self:deleteItemOnList(nil,itemguid)
itemsList[index]=item
if not lastItem then
self.itemsLen=self.itemsLen+1
end

end


function UIBagWin:changeItemOnList(index,item)
local itemguid=item.itemguid
local itemsList=self.itemsList
local lastItem=self.itemsList[index]
if tostring(lastItem.itemguid)==tostring(itemguid)then
self.itemsList[index]=item
else

self:dofresh()
tipsManager.closeTips()
end
end


function UIBagWin:deleteItemOnList(index,itemguid)
if index==nil and self.itemsList[index]==nil then return end
local lastItem=self.itemsList[index]
if lastItem and tostring(lastItem.itemguid)==tostring(itemguid)then
self.itemsList[index]=nil
self.itemsLen=self.itemsLen-1
else

self:dofresh()
tipsManager.closeTips()
end
end



function UIBagWin:addSpace(sapceIdx,itemguid)
if self.space==nil then self.space={}end
local space=self.space
if space.list==nil then space.list={}end
if space.lookup==nil then space.lookup={}end
local list=space.list
local lookup=space.lookup
if lookup[sapceIdx]then return end

lookup[sapceIdx]=itemguid
list[#list+1]=sapceIdx
if#list>1 then

table.sort(list,function(a,b)return a<b end)
end
end


function UIBagWin:deleteSpace(sapceIdx)
if self.space==nil then self.space={}end
local space=self.space
if space.list==nil then space.list={}end
if space.lookup==nil then space.lookup={}end
local list=space.list
local lookup=space.lookup
if not lookup[sapceIdx]then return end
local itemguid=lookup[sapceIdx]
lookup[sapceIdx]=false

for i,v in ipairs(list)do
if v==sapceIdx then

table.remove(list,i)
break
end
end
if#list>1 then
table.sort(list,function(a,b)return a<b end)
end
end


function UIBagWin:getFillIndexBySpace()
if self.space==nil then self.space={}end
local space=self.space
if space.list==nil then space.list={}end
if space.lookup==nil then space.lookup={}end
local list=space.list
return list[1]
end


function UIBagWin:getFillIndex()
local index=self:getFillIndexBySpace()
if index==nil then
index=self.itemsLen
end
return index
end



function UIBagWin:selectBag(showBagType)
if showBagType==self.selectBagType then return end
local args=self.args or{}

if UIManager:isActive("UIBagEquipFilterPartWin")then
UIManager:closeWindow("UIBagEquipFilterPartWin")
end
if UIManager:isActive("UIYuFuFilterPartWin")then
UIManager:closeWindow("UIYuFuFilterPartWin")
end

if self.isMutipleJingLian then
self:outMutipleJingLianModel()
end

self:tryCloseYuanPeiFilterWinWhenWinActive()
self:clearFaBaoYuanPeiFilterCache()

self.equipFilterPartAcive=false
self.fubaoFilterPartAcive=false
self.filterQuickScrollView_Active_Equip_Filter=true
self.filterQuickScrollView_Active_fubao_Filter=true
UIManager:setArgs(self.__name,args)
tipsManager.closeTips()
self.selectBagType=showBagType
self.curPageIndex=1
self.isSelectMutipleEquip=false
self.isSelectAllEquip=false
AudioManager.playBtnClick()
self:stopCurPosFreshAll()
self:stopFBFUpdateTimer()
self:dofresh()
end


function UIBagWin:onSelectGrid(idx,itemid)

end


function UIBagWin:onFilter(argstable)
local selectBagType=argstable.attach
local bagType=self.selectBagType
if selectBagType~=bagType then return end
local filterFlag=argstable.filterFlag
self.filterFlag[bagType]=filterFlag
self:freshFilterflags(bagType)
self.isSetZero=nil
self.ScrollView:clearSlowItems()
self:freshGirds(true)
end

function UIBagWin:freshFilterflags(bagType)
local filterflags=self.filterFlag[bagType]
for k,v in pairs(filterflags)do
local noSelect=true
for _,flag in ipairs(v)do
if flag==true then
noSelect=false
break
end
end
if noSelect==true then
filterflags[k]=nil
end
end
end

function UIBagWin:getFilterUIArgs(bagType)
local filterNames={}
local filterCfg=bagFilterConfig.getFilter(bagType)

if self.filterFlag[bagType]==nil then self.filterFlag[bagType]={}end
local filterflags=self.filterFlag[bagType]

for i,cfgs in ipairs(filterCfg)do
local filterType=cfgs.type
local nameInfo={}
local filterName=filterType and bagFilterConfig.getCommonFilterName(filterType)or nil
nameInfo[1]=filterName
nameInfo[2]={}
local namelist=nameInfo[2]
if filterflags[i]==nil then filterflags[i]={}end
local flags=filterflags[i]
for ii,cfg in ipairs(cfgs)do
local subName=cfg.name()
local iconname=cfg.icon and cfg.icon()or''
namelist[#namelist+1]={name=subName,icon=iconname}
if flags[ii]==nil then flags[ii]=false end
end
filterNames[#filterNames+1]=nameInfo
end
return filterNames,filterflags
end


function UIBagWin:getFilter()
local selectBagType=self.selectBagType
if selectBagType==BAG_TYPE.eEquipBag and self.filterQuickIndex[self.selectBagType]==1 then
return self.equipBagFilter or{}
end
if selectBagType==BAG_TYPE.eFubaoBag and self.filterQuickIndex[self.selectBagType]==1 then
return self.fubaoBagFilter or{}
end


if self:isOnlyYuanPeiTypeFilterActive()and(self.yuanpeiFilter and next(self.yuanpeiFilter)~=nil)then
return self.yuanpeiFilter
end

if self.filterFlag[selectBagType]==nil then return end
local filter={}
local filterCfg=bagFilterConfig.getFilter(selectBagType)
local flags=self.filterFlag[selectBagType]
for i,cfgs in ipairs(filterCfg)do
for ii,cfg in ipairs(cfgs)do
if flags[i]and flags[i][ii]==true then
local filterTable=cfg.filter()
for itemFilterType,v in pairs(filterTable)do
if filter[itemFilterType]==nil then filter[itemFilterType]={}end
local filters=filter[itemFilterType]
for compareType,vv in pairs(v)do
if filters[compareType]==nil then filters[compareType]={}end
local comFilters=filters[compareType]
for _,val in ipairs(vv)do
comFilters[#comFilters+1]=val
end
end
end
end
end
end
return filter
end




function UIBagWin:onSortItems()
if self.itemsLen<=1 then return end
local selectBagType=self.selectBagType
local itemsList=self.itemsList
local sortConfig=self.sortConfigs[selectBagType]
local selectDropIdx=self.selectDropIdxs[selectBagType]or 0
local idx=selectDropIdx+1
local cfg=sortConfig[idx]
local sortType=self.sortCompareTypes[selectBagType]
if cfg.sortFun then
cfg.sortFun(itemsList,sortType)
else
local sortTag={}
for i,v in ipairs(itemsList)do
v.guidStr=v.guidStr or tostring(v.itemguid)
sortTag[v.guidStr]=cfg.sortTag(v,sortType)
end

table.sort(itemsList,function(a,b)
if sortType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
if sortTag[a.guidStr]==sortTag[b.guidStr]then
return a.itemguid<b.itemguid
end
return sortTag[a.guidStr]>sortTag[b.guidStr]
end

if sortTag[a.guidStr]==sortTag[b.guidStr]then
return a.itemguid<b.itemguid
end
return sortTag[a.guidStr]>sortTag[b.guidStr]
end)
end
end






local _onePageMaxNum=40
function UIBagWin:onItemListChanged(list)
if list==nil then return end

local fbfLen=self:getFBFUpdateListLen()
local len=#list

local endCallBack=function()
self:freshAllBtnReddot()
end

if fbfLen==0 and len<=_onePageMaxNum then
for i,v in ipairs(list)do
self:freshSingleItemChange(v)
end
endCallBack()
else
self:pushFBFUpdataList(list)
self:startFBFUpdateTimer(endCallBack)
end
end

function UIBagWin:freshSingleItemChange(itemInfo)
local changeType=itemInfo[1]
local itemguid=itemInfo[2]
local item=bagModel.getItem(itemguid)
if changeType==CHANGE_TYPE.eAdd then
if item==nil then
self:clearItem(itemguid)
else
self:addItem(item)
end
elseif changeType==CHANGE_TYPE.eChanged then
if item==nil then
self:clearItem(itemguid)
else
self:freshItem(item)
end
elseif changeType==CHANGE_TYPE.eDelete then
self:clearItem(itemguid)
end
end

function UIBagWin:onScrollItemClick(id,index,guid,attach)
if id==-1 then return end
bagNewHelper.setNewFlag(guid,false)

self:showItemTips(id,index,guid)

local lastSelectguid=self.selectguid
local lastSelectIdx=self.selectIdx
if tostring(lastSelectguid)==tostring(guid)then return end
self.selectId=id
self.selectguid=guid
self.selectIdx=index
if lastSelectguid then
self:freshSelectFlag(lastSelectIdx,lastSelectguid)
end
self:freshSelectFlag(index,guid)
self:freshNewFlag(lastSelectguid)
self:freshNewFlag(guid)
end

function UIBagWin:showItemTips(id,index,guid)
id=id or self.selectId
index=index or self.selectIdx
guid=guid or self.selectguid

if self:checkInMutipleJingLianModel()then
self:onMutitpleJingLian(index,guid)
return
end

local itemConfig=itemsConfig.getConfig(id)
if itemConfig then
local item=bagModel.getItem(guid)
local num=item.itemcount
local isExpire=bagUseControl.isItemExpire(guid)
local isShowBatchBody=true
local funcparam=itemConfig.funcparam
if funcparam then
local ftype=funcparam.type

if ftype and BAG_ITEM_CAN_SHOW_BATCH_SPECIAL_FUN[ftype]then
local fun=BAG_ITEM_CAN_SHOW_BATCH_SPECIAL_FUN[ftype]
isShowBatchBody=fun(id,funcparam)
end
end
local hasNumSelect=(itemsConfig.isItem(id)or itemsConfig.isMaterials(id))and itemsConfig.getConfig(id).batch~=nil
and not isExpire
and isShowBatchBody
local selectNumCmpArgs
if hasNumSelect then
local maxUseCount=num
if itemConfig.gain then

local gainItemId=itemConfig.gain[1]
local gainItemCount=itemConfig.gain[2]
local gainItemCfg=itemsConfig.getConfig(gainItemId)
if gainItemCfg.max then
maxUseCount=math.floor(gainItemCfg.max/gainItemCount)
end
end
if funcparam and funcparam.type then

local ftype=funcparam.type
local fun=BAG_ITEM_CAN_BATCH_USE_MAX_NUM_FUN[ftype]
if fun then
local max=fun(id,funcparam)
maxUseCount=math.min(max,maxUseCount)
end
end
local canUseMaxCount=num<maxUseCount and num or maxUseCount
selectNumCmpArgs={numFormat='使用：<color=#f1ce78>{0}/{1}</color>',
min=1,max=canUseMaxCount,val=canUseMaxCount}
end


local hasNumSelectSell=itemsConfig.getConfig(id).dealPrice~=nil and isExpire
if hasNumSelectSell then
selectNumCmpArgs={numFormat='出售：<color=#f1ce78>{0}/{1}</color>',min=1,max=num,val=num}
end
if itemConfig.type1==13 and systemModel.isOpen(SYSTEM_DEFINE.eGongFaRecycle)then
local gfID=gongfaLookup:checkGongfaPiece(id)
if gfID and UIGongFaModel:checkFullStudy(gfID)then
selectNumCmpArgs={numFormat='转换：<color=#f1ce78>{0}/{1}</color>',min=1,max=num,val=num}
end
end

self.tipsAgrs={
index=index,
guid=guid,
args={
formType=TIPS_FORM_TYPE.eBagGrids,
itemid=id,
showModel=true,

itemguid=guid,
attach={selectNumCmpArgs=selectNumCmpArgs},
closeCallback=function()
if self.equipFilterPartAcive then
if self.selectBagType==BAG_TYPE.eEquipBag then
self:onFilterClick()
end
end
if self.fubaoFilterPartAcive then
if self.selectBagType==BAG_TYPE.eFubaoBag then
self:onFilterClick()
end
end


if self.yuanpeiFilterWinActiveState
and(self.selectBagType==BAG_TYPE.eItemBag
and self.filterQuickIndex[self.selectBagType]==eBagItemSubType.eYuanPei)then
self:onFilterClick()
end
end,
}
}

if self.selectBagType==BAG_TYPE.eEquipBag or self.selectBagType==BAG_TYPE.eFubaoBag then
self.tipsAgrs.args.move=TIPS_MOVE_POS.eRightThree
self.tipsAgrs.args.backType=TIPS_BACK_TYPE.eNone
self.tipsAgrs.args.offsetY=25
end

if self:checkInMutipleSelectMode()then
local itemWiget=self.ScrollView:getSlowItemByIndex(index-1)
self:onSelectMutiple(index,itemWiget,item)

local mutipleIdx=table.findValueEx(self.equipMutipleSelectList,item,function(itemData)return tostring(itemData.itemguid)end)
self.tipsAgrs.args.formType=TIPS_FORM_TYPE.eBagEquipMutipleSelect
self.tipsAgrs.args.attach={index=index-1,itemInfo=self.itemsList[index],isSelect=mutipleIdx~=nil}
end

tipsManager.showTips(self.tipsAgrs.args)
else
loggerUtil.logErrFMT('没有找到此道具：',id)
end

if UIManager:isActive('UIBagEquipFilterPartWin')then
UIManager:closeWindow('UIBagEquipFilterPartWin')
end
if UIManager:isActive('UIYuFuFilterPartWin')then
UIManager:closeWindow('UIYuFuFilterPartWin')
end

if self:tryCloseYuanPeiFilterWinWhenWinActive(true)then return end
end


function UIBagWin:onShowTips()
if self.tipsAgrs then
tipsManager.showTips(self.tipsAgrs.args)

local guid=self.tipsAgrs.guid
local index=self.tipsAgrs.index
self.selectguid=guid
self.selectIdx=index
self:freshSelectFlag(index,guid)
self:freshNewFlag(guid)
end
end

function UIBagWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshInfo()
end


function UIBagWin:onDropdownChange(reIdx)

local idx=self.filterLen-1-reIdx
local selectBagType=self.selectBagType
if self.selectDropIdxs[selectBagType]==idx then return end
tipsManager.closeTips()
self.selectDropIdxs[selectBagType]=idx

self.curPageIndex=1
self.isSetZero=nil
self.ScrollView:clearSlowItems()
self:freshGirds(true)
end

function UIBagWin:onDropdownCreate(scrollTrans,contentTrans)
local selectBagType=self.selectBagType
local reidx=self.selectDropIdxs[selectBagType]or 0

local idx=reidx
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

function UIBagWin:onFubaoClick()
self:selectBag(SHOW_BAG_TYPE.eFubaoBag)
end

function UIBagWin:onFabaoClick()
self:selectBag(SHOW_BAG_TYPE.eFabaoBag)
end

function UIBagWin:onEquipClick()
self:selectBag(SHOW_BAG_TYPE.eEquipBag)
end

function UIBagWin:onItemClick()
self:selectBag(SHOW_BAG_TYPE.eItemBag)
end

function UIBagWin:onCailiaoClick()
self:selectBag(SHOW_BAG_TYPE.eMaterialsBag)
end

function UIBagWin:onDaoBingClick()
self:selectBag(SHOW_BAG_TYPE.eRareBag)
end


function UIBagWin:onSortTypeClick()
local selectBagType=self.selectBagType
if self.sortCompareTypes[selectBagType]==nil then self.sortCompareTypes[selectBagType]=ITEM_SORT_COMPARE_TYPE.eDownOrder end
local sortCompareType=self.sortCompareTypes[selectBagType]
if sortCompareType==ITEM_SORT_COMPARE_TYPE.eDownOrder then
self.sortCompareTypes[selectBagType]=ITEM_SORT_COMPARE_TYPE.eUpOrder
elseif sortCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
self.sortCompareTypes[selectBagType]=ITEM_SORT_COMPARE_TYPE.eDownOrder
end
self.selectguid=nil
self.selectIdx=nil
self.curPageIndex=1
self.isSetZero=nil
self.ScrollView:clearSlowItems()
self:freshGirds(true)
self:freshSortImg()
end

function UIBagWin:freshSortImg()
local rotation=0
local sortType=self.sortCompareTypes[self.selectBagType]
if sortType==ITEM_SORT_COMPARE_TYPE.eDownOrder then
rotation=180
elseif sortType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
rotation=0
else
rotation=180
end
self.btnSortImg:setRotation(0,0,rotation)
end


function UIBagWin:onFilterClick()
tipsManager.closeTips()
local win=UIManager:findActiveWindow('UIFilterThreeWin')
if win then
win:myClose()
else
if self.selectBagType==BAG_TYPE.eEquipBag then
local filterNames,filterflags=self:getFilterUIArgs(self.selectBagType)


















if UIManager:isActive("UIBagEquipFilterPartWin")then
UIManager:invokeUIMethod('UIBagEquipFilterPartWin','onCloseBtn')
self.equipFilterPartAcive=false
return
end

self.filterQuickScrollView:setActive(false)
self.filterQuickScrollView_Active_Equip_Filter=false
self:onSelectFilterQuickItem(1)

local comfirmCallback=function(equipBagFilter)
self.equipBagFilter=equipBagFilter
if self.filterQuickPage then
self:onSelectFilterQuickItem(1)
end
self.isSetZero=nil

self.equipMutipleSelectList={}
self:freshMutipleSelect()
self.ScrollView:clearSlowItems()
self:freshGirds(true)
end

local closeCallBack=function()
self.filterQuickScrollView_Active_Equip_Filter=true
self.filterQuickScrollView:setActive(true)
self.equipFilterPartAcive=false
end

local args={
attach=self.selectBagType,
equipBagFilter=self.equipBagFilter,
comfirmCallback=comfirmCallback,
closeCallBack=closeCallBack,
}
self:showWindow("UIBagEquipFilterPartWin",args)
self.equipFilterPartAcive=true

if self.isMutipleJingLian then
self:outMutipleJingLianModel()
end

elseif self.selectBagType==BAG_TYPE.eFubaoBag then
local filterNames,filterflags=self:getFilterUIArgs(self.selectBagType)
if UIManager:isActive("UIYuFuFilterPartWin")then
UIManager:invokeUIMethod('UIYuFuFilterPartWin','onCloseBtn')
self.fubaoFilterPartAcive=false
return
end
self.filterQuickScrollView:setActive(false)
self.filterQuickScrollView_Active_Equip_Filter=false
self:onSelectFilterQuickItem(1)
local comfirmCallback=function(equipBagFilter)
self.fubaoBagFilter=equipBagFilter
if self.filterQuickPage then
self:onSelectFilterQuickItem(1)
end
self.isSetZero=nil
self.equipMutipleSelectList={}
self:freshMutipleSelect()
self.ScrollView:clearSlowItems()
self:freshGirds(true)
end
local closeCallBack=function()
self.filterQuickScrollView_Active_Equip_Filter=true
self.filterQuickScrollView:setActive(true)
self.fubaoFilterPartAcive=false
end
local args={
attach=self.selectBagType,
fubaoBagFilter=self.fubaoBagFilter,
comfirmCallback=comfirmCallback,
closeCallBack=closeCallBack,
}
self:showWindow("UIYuFuFilterPartWin",args)
self.fubaoFilterPartAcive=true


elseif self:isOnlyYuanPeiTypeFilterActive()then
self:showYuanPeiFilterWin()
else
local filterNames,filterflags=self:getFilterUIArgs(self.selectBagType)
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')

args.extraWin="UIFilterThreeWin"
local extraParams={attach=self.selectBagType,filterName=filterNames,filterFlag=filterflags,comfirmCallback=function(...)
if self.filterQuickPage then
self:onSelectFilterQuickItem(1)
end
self:onFilter(...)
end}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end

end
end




function UIBagWin:isOnlyYuanPeiTypeFilterActive()
return self.selectBagType==BAG_TYPE.eItemBag
and self.filterQuickIndex[self.selectBagType]==eBagItemSubType.eYuanPei
end

function UIBagWin:clearFaBaoYuanPeiFilterCache()
self.yuanpeiFilter={}
end

function UIBagWin:showYuanPeiFilterWin()
if self:tryCloseYuanPeiFilterWinWhenWinActive()then
return
end
self.filterQuickScrollView:setActive(false)
self.yuanpeiFilterWinActiveState=true

local args={
selectBagType=self.selectBagType,
yuanpeiFilter=self.yuanpeiFilter or{},


safeguardCachedFilterDataCallback=function(filter)
self.yuanpeiFilter=filter
end,


refreshItemsCallback=function(filter)
self.yuanpeiFilter=filter
self.isSetZero=nil

self.ScrollView:clearSlowItems()
self:freshGirds(true)
end,

closeCallback=function()
self.filterQuickScrollView:setActive(true)
self.yuanpeiFilterWinActiveState=false
end
}
self:showWindow("UIFaBaoYuanPeiFilterWin",args)
end




function UIBagWin:tryCloseYuanPeiFilterWinWhenWinActive(nonCallCloseFunc)
local shouldClosed=false
if UIManager:isActive("UIFaBaoYuanPeiFilterWin")then
if nonCallCloseFunc then
UIManager:closeWindow("UIFaBaoYuanPeiFilterWin")
else
UIManager:invokeUIMethod('UIFaBaoYuanPeiFilterWin','onCloseBtn')
end
shouldClosed=true
end
return shouldClosed
end



function UIBagWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:freshLockFlag(itemguid)
end

function UIBagWin:onBtnRonglian()
if next(self.equipMutipleSelectList)then
local callback=function(itemGuidList,rlitems,xmEquipType)
UIFullBaGuaLuControl:setRongLianGUID(itemGuidList,rlitems,false,true,true)
end

local showdata=
{
type='UIDialougeRongLian',
title='提示',
oktext='确定',
canceltext='取消',
okcallback=callback,
showclosebtn=true,
allowclickBG=true,
itemInfoList=self.equipMutipleSelectList,
}

local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
UIManager.info("祖师尚未选择熔炼装备")
end
end

function UIBagWin:onBtnGoRonglian()
local sfId=mapIdType.zhufeng
local bdId=SLG_SYSTEM_TYPE.eBaGuaLu1
local bdData=zongmenModel:findBuildingDataByID(sfId,bdId)
isometricMapSystem:openBuildingWin(bdData)
end

function UIBagWin:onBtnFilter()

end


function UIBagWin:onBtnEquipMutipleSelect()
self.isSelectMutipleEquip=not self.isSelectMutipleEquip
if not self.isSelectMutipleEquip then
self.isSelectAllEquip=false
end
local isInSelectMode=self:checkInMutipleSelectMode()
local isInMutipleJingLian=self:checkInMutipleJingLianModel()
local iseEquip=self:isEEquipBagCheckInMutiple()
local isfubao=self:isEFuBaoBagCheckInMutiple()
self.btnEMSImg:setActive(isInSelectMode)
self.btnSelecEquiptAll:setActive(isInSelectMode)
self.btnRonglian:setActive(iseEquip and isInSelectMode)
self.btnGoRonglian:setActive(iseEquip and not isInSelectMode)
self.btnfbfenjie:setActive(isfubao)
self.btnEMSAllImg:setActive(self.isSelectAllEquip)
self.btnJingLian:setActive(iseEquip and systemModel.isOpen(SYSTEM_DEFINE.eBagMutipleEquipJingLian)and(not self.isSelectMutipleEquip)and(not isInMutipleJingLian))
if isInSelectMode then
self.equipMutipleSelectList={}
end
self:startCurPosFreshAll()
if isInSelectMode and self.selectguid~=nil and itemsModel.getItem(self.selectguid)~=nil then
self:showItemTips()
end

end

function UIBagWin:onBtnSelecEquiptAll()
self.isSelectAllEquip=not self.isSelectAllEquip
self.btnEMSAllImg:setActive(self.isSelectAllEquip)
if self.isSelectAllEquip then
self:mutipleSelectAll()
else
self.equipMutipleSelectList={}
end
self:startCurPosFreshAll()

end

function UIBagWin:onSelectMutiple(index,item,itemInfo)
local idx=table.findValueEx(self.equipMutipleSelectList,itemInfo,function(itemData)return tostring(itemData.itemguid)end)
if idx~=nil then

table.remove(self.equipMutipleSelectList,idx)
item:SetChildActive(_cmpItemWidgetIdx.mSelectGou,false)
tipsManager.closeTips()
else

self:mutipleSelectSingle(itemInfo,true)
if not bagHelper.isLock(itemInfo)and self:isYuFuitem(itemInfo)then
item:SetChildActive(_cmpItemWidgetIdx.mSelectGou,true)
end

end


self.isSelectAllEquip=self:getCanMutipleSelectItemLen()==#self.equipMutipleSelectList
self.btnEMSAllImg:setActive(self.isSelectAllEquip)
end

function UIBagWin:onTipsSelectMutiple(index,itemInfo)

self:onScrollItemClick(itemInfo.itemid,index+1,itemInfo.itemguid)
end

function UIBagWin:onTipsNotSelectMutiple(index,itemInfo)
self:onScrollItemClick(itemInfo.itemid,index+1,itemInfo.itemguid)
end

function UIBagWin:mutipleSelectSingle(item,warning)
if not self:isYuFuitem(item,warning)then
return false
end
if bagHelper.isLock(item)then
if warning then
UIManager.error('物品已锁定，无法熔炼')
end
else
self.equipMutipleSelectList[#self.equipMutipleSelectList+1]=item
end
end

function UIBagWin:mutipleSelectAll()
self.equipMutipleSelectList={}
for index,item in pairs(self.itemsList or{})do
self:mutipleSelectSingle(item)
end
end

function UIBagWin:getCanMutipleSelectItemLen()
local len=0
for index,item in pairs(self.itemsList)do
if not bagHelper.isLock(item)then
len=len+1
end
end
return len
end


function UIBagWin:isYuFuitem(itemInfo,warning)
if not self:isEFuBaoBagCheckInMutiple()then
return true
end
if itemsConfig.isFubao(itemInfo.itemid)then
return true
else
if warning then
UIManager.error('灵阵无法分解')
end
end
return false
end

function UIBagWin:onBtnfbfenjie()
if self.equipMutipleSelectList and next(self.equipMutipleSelectList)then
local list={}
for k,v in pairs(self.equipMutipleSelectList)do
if v then
table.insert(list,v.itemguid)


end
end
local len=#list
if len>0 then
local callback=function()
UIFullFuLuFangControl:reqDecomposeFuBao(len,list)


end
local showdata=
{
type='UIDialouge',
title='提示',
content='确定要分解所选中的玉符吗？',
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,

}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
else
UIManager.info("未选择需分解的玉符")
end
end





function UIBagWin:freshFilterQuickGirds()
if self.filterQuickIndex[self.selectBagType]==nil then
self.filterQuickIndex[self.selectBagType]=1
end
self.filterQuickPage=nil
local list={}
local cfg={
name='全部'
}
table.insert(list,cfg)
local filterNames,filterflags=self:getFilterUIArgs(self.selectBagType)
for i,v in ipairs(filterNames)do
if v[1]==nil and#v[2]>0 then
self.filterQuickPage=i
for ii,vv in pairs(v[2])do
table.insert(list,vv)
end
break
end
end
local flag=self.filterQuickPage~=nil and self.filterQuickScrollView_Active_Equip_Filter
self.filterQuickScrollView:setActive(flag)
if not flag then return end

self.filterQuickList=list
local tNum=#list
self.filterQuickScrollView:setChildScrollViewCreateGrids(tNum,1)

local grids=self.filterQuickScrollView:getChildScrollViewItemWidgets()
for i=1,tNum do
local item=grids[i-1]
local data=self.filterQuickList[i]
local flag=i==self.filterQuickIndex[self.selectBagType]
item:SetChildText(1,data.name)
self:refreshfilterQuickItem(item,flag)
end
end

function UIBagWin:onFilterQuickScrollItemClick(clickCount,index)
local idx=index+1
if self.filterQuickIndex[self.selectBagType]==idx then
return
end

self:onSelectFilterQuickItem(idx)

if idx>1 then
local filterFlags={}
local filterCfg=bagFilterConfig.getFilter(self.selectBagType)
for i,cfgs in ipairs(filterCfg)do
if not filterFlags[i]then
filterFlags[i]={}
end
for ii,cfg in ipairs(cfgs)do
local flag=i==self.filterQuickPage and ii==index
filterFlags[i][ii]=flag
end
end
if self.selectBagType==BAG_TYPE.eEquipBag then
self.equipBagFilter=nil
end
self:onFilter({filterFlag=filterFlags,attach=self.selectBagType})
else
self:onFilter({filterFlag={},attach=self.selectBagType})
end

tipsManager.closeTips()
end

function UIBagWin:onSelectFilterQuickItem(index)
local old=self.filterQuickIndex[self.selectBagType]
self.filterQuickIndex[self.selectBagType]=index
if old and old~=index then
local item=self.filterQuickScrollView:getChildScrollViewItemWidget(old-1)
self:refreshfilterQuickItem(item,false)
end
local item=self.filterQuickScrollView:getChildScrollViewItemWidget(index-1)
self:refreshfilterQuickItem(item,true)
end

function UIBagWin:recv_ronglian()
self.equipMutipleSelectList={}
if self.isSelectMutipleEquip then
self:onBtnEquipMutipleSelect()
end


end
function UIBagWin:onBagYuFuFenJie()
self.equipMutipleSelectList={}
end

function UIBagWin:checkInMutipleSelectMode()
if self.selectBagType==BAG_TYPE.eEquipBag then
return self.isSelectMutipleEquip
elseif self.selectBagType==BAG_TYPE.eFubaoBag then
return self.isSelectMutipleEquip
end
return false
end
function UIBagWin:isEEquipBagCheckInMutiple()
if self.selectBagType==BAG_TYPE.eEquipBag then
return true
end
return false
end
function UIBagWin:isEFuBaoBagCheckInMutiple()
if self.selectBagType==BAG_TYPE.eFubaoBag then
return true
end
return false
end

function UIBagWin:onCloseBagWin()
if UIManager:isActive("UIBagEquipFilterPartWin")then
UIManager:invokeUIMethod('UIBagEquipFilterPartWin','onCloseBtn')
return
end
if UIManager:isActive("UIYuFuFilterPartWin")then
UIManager:invokeUIMethod('UIYuFuFilterPartWin','onCloseBtn')
return
end

if self:tryCloseYuanPeiFilterWinWhenWinActive()then return end

if UIManager:isActive("UITipsWin")then
tipsManager.closeTips()
else
self:closeSelf()
end
end

function UIBagWin:startCurPosFreshAll()
self:stopCurPosFreshAll()

local curPos=self.Content:getChildAnchoredPosition()
local curY=curPos.y
local curLayer=Mathf.Floor(curY/100)
local curIndex=curLayer*5
local maxIndex=#self.itemsList

local grid,leftIndex,rightIndex
local total=0
local isStop=false
local func=function()
for index=1,40 do
leftIndex=curIndex-total
if leftIndex>=0 then
self.ScrollView:freshSlowItem(leftIndex)
end

total=total+1

rightIndex=curIndex+total
if rightIndex<maxIndex then
self.ScrollView:freshSlowItem(rightIndex)
end

if leftIndex<0 and rightIndex>maxIndex then
isStop=true
break
end
end
if isStop then
self:stopCurPosFreshAll()
end
end

self.curPosFreshAllTimer=self:setTimer(0.025,-1,func)
func()
end

function UIBagWin:stopCurPosFreshAll()
if self.curPosFreshAllTimer then
self:stopTimerByID(self.curPosFreshAllTimer)
self.curPosFreshAllTimer=nil
end
end


function UIBagWin:resetFBFUpdateList()
self.changeItemFBFUpdateList={}
self.changeItemFBFUpdateFirstIndex=0
self.changeItemFBFUpdateEndIndex=0
end

function UIBagWin:pushFBFUpdataList(list)
self.changeItemFBFUpdateList=table.concatTable(self.changeItemFBFUpdateList,list)
self.changeItemFBFUpdateEndIndex=#self.changeItemFBFUpdateList
end

function UIBagWin:getFBFUpdateListLen()
return self.changeItemFBFUpdateEndIndex-self.changeItemFBFUpdateFirstIndex
end

function UIBagWin:startFBFUpdateTimer(endCallBack)
self:stopFBFUpdateTimer()

local isStop=false
local func=function()
for index=1,40 do
self.changeItemFBFUpdateFirstIndex=self.changeItemFBFUpdateFirstIndex+1

if self.changeItemFBFUpdateList[self.changeItemFBFUpdateFirstIndex]~=nil then
self:freshSingleItemChange(self.changeItemFBFUpdateList[self.changeItemFBFUpdateFirstIndex])
end

if self.changeItemFBFUpdateFirstIndex>=self.changeItemFBFUpdateEndIndex then
isStop=true
break
end
end

if isStop then
self:resetFBFUpdateList()
self:stopFBFUpdateTimer()
if endCallBack then
endCallBack()
end
end
end

self.changeItemFBFUpdateTimer=self:setTimer(0.025,0,func)
func()
end

function UIBagWin:stopFBFUpdateTimer()
if self.changeItemFBFUpdateTimer then
self:stopTimerByID(self.changeItemFBFUpdateTimer)
self.changeItemFBFUpdateTimer=nil
end
end



function UIBagWin:onBtnJingLian()
tipsManager.closeTips()

self:inMutipleJingLianModel()


self:showWindow("UIBagMutipleJingLianEquipWin",{bagPanel=self,selectGuidList=self.equipMutipleSelectList})
end

function UIBagWin:inMutipleJingLianModel()

if UIManager:isActive('UIBagEquipFilterPartWin')then
UIManager:closeWindow('UIBagEquipFilterPartWin')
end

self.isMutipleJingLian=true
self.equipMutipleSelectList={}

self.btnJingLian:setActive(false)
if self.isSelectAllEquip then
self.isSelectAllEquip=false
end
self:freshMutipleSelect()

self:startCurPosFreshAll()
end

function UIBagWin:outMutipleJingLianModel()
self.isMutipleJingLian=false
self.equipMutipleSelectList={}

self.btnJingLian:setActive(true)
self:freshMutipleSelect()
self:startCurPosFreshAll()

self:closeWindow("UIBagMutipleJingLianEquipWin")
end

function UIBagWin:checkInMutipleJingLianModel()
return self.isMutipleJingLian
end

function UIBagWin:onMutitpleJingLian(index,guid)
local item=self.ScrollView:getSlowItemByIndex(index-1)
local itemInfo=bagModel.getItem(guid)

local idx=table.findValueEx(self.equipMutipleSelectList,itemInfo,function(itemData)return tostring(itemData.itemguid)end)
local isSelected=idx~=nil
local type=isSelected and 2 or 1
local result=UIManager:invokeUIMethod("UIBagMutipleJingLianEquipWin","opJingLianEquip",type,guid)

if not result then return end

if isSelected then

table.remove(self.equipMutipleSelectList,idx)
item:SetChildActive(_cmpItemWidgetIdx.mSelectGou,false)
else

table.insert(self.equipMutipleSelectList,itemInfo)
item:SetChildActive(_cmpItemWidgetIdx.mSelectGou,true)
end
end

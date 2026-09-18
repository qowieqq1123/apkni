







def_class("UIFuBaoGainWin",UIWindowBase)









function UIFuBaoGainWin:bindComponents()

self.bagScrollView=UIEnhancedScrollerLua.get(self,0)
self.btnConfirm=UIButton.get(self,1)
self.btnReset=UIButton.get(self,2)
self.closeFilterBtn=UIButton.get(self,3)
self.dressToggle=UIToggleButton.get(self,4)
self.filterRoot=UIObject.get(self,5)
self.fubaoFilterBtn=UIButton.get(self,6)
self.fubaoItem=UIBaseItem.get(self,7)
self.gainPage=UIObject.get(self,8)
self.gainScrollView=UIScrollView.get(self,9)
self.gainTitle=UIText.get(self,10)
self.pageCreater=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.tipsDi=UIButton.get(self,13)
self.titleName=UIText.get(self,14)
self.unEquipTitle=UIObject.get(self,15)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.closeFilterBtn:setButtonClick(function()self:onCloseFilterBtn()end)

self.fubaoFilterBtn:setButtonClick(function()self:onFubaoFilterBtn()end)

self.tipsDi:setButtonClick(function()self:onTipsDi()end)



end


function UIFuBaoGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.closeFilterBtn);self.closeFilterBtn=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.filterRoot);self.filterRoot=nil;
_UIObject_release(self.fubaoFilterBtn);self.fubaoFilterBtn=nil;
_UIObject_release(self.fubaoItem);self.fubaoItem=nil;
_UIObject_release(self.gainPage);self.gainPage=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.gainTitle);self.gainTitle=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsDi);self.tipsDi=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.unEquipTitle);self.unEquipTitle=nil;
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



function UIFuBaoGainWin:onLoaded(...)
self:bindComponents()

_this=self

self.filterFlag={}

self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)

self.enhancedscrollscript=UIPrepareEnScroller(self.bagScrollView:getGameObject(),self.bagScrollView:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self.fubaoItem:setBaseItemClickEvent(function(...)
self:onClickBaseItem(...)
end)
self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)

self.gainScrollView:bindScrollWidget(function(...)
self:fillGainData(...)
end)

UIManager:showWindow('UIDialgueBackPanel')
end


function UIFuBaoGainWin:__delete()
self:unbindComponents()

_this=nil

if self.isShowTips then
tipsManager.closeTips()
end
UIManager:closeWindow('UIDialgueBackPanel')
end

function UIFuBaoGainWin.on_item_click(data,id,index,guid,attach)
if _this.selectguid==guid then return end
local oldguid=_this.selectguid
_this.selectguid=guid
if oldguid then
_this:refreshItem(oldguid)
end
_this:refreshItem(guid)

if id then
_this:showTips(id,guid)
end
_this:freshEquipPage()
end

function UIFuBaoGainWin:onClickBaseItem(id,index,guid,attach)
if self.selectguid==guid then return end
self.selectguid=guid

local item=self.item
local itemguid
if item then itemguid=item.itemguid end
self.fubaoItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetActive,3,itemguid==guid)
self:showTips(item.itemid,item.itemguid)
self:refreshFuBaoList(self.filterFlag)
end

function UIFuBaoGainWin:onToggleChanged(name,isToggle,data)
self:refreshFuBaoList(self.filterFlag)
self:freshEquipPage()
self:freshGainPage()
end




function UIFuBaoGainWin:onShow(argtable,afterOnloaded)
self.diziguid=argtable.diziguid
self.pos=argtable.pos
self.item=UIFuLuFangModel:getFubaoData(self.diziguid,self.pos)
local voc=UIDiscipleModel:getDiscipleJob(self.diziguid)
self.tuijianItemid=equipsConfig.getDiziFubaoTuijian(voc,self.pos)
self:initFilter()
self:refreshFuBaoList(self.filterFlag,true)
self:freshEquipPage()
self:freshGainPage()
end


function UIFuBaoGainWin:onHide()

end


function UIFuBaoGainWin:freshEquipPage(isCloseTips)
local hasItem=self.item~=nil
self.fubaoItem:setActive(hasItem)
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

function UIFuBaoGainWin:fillItem(item)
if item==nil then return end
local prop={}
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local iconName=iconHelper.getIconName(itemid)

prop[PropIndex(DataPropKey.eWidgetQuality,0)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,2)]=itemConfig.name
prop[PropIndex(DataPropKey.eWidgetActive,3)]=self.selectguid==itemguid
prop[PropIndex(DataPropKey.eWidgetActive,4)]=stageStr~=''
prop[PropIndex(DataPropKey.eWidgetText,5)]=stageStr
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
self.fubaoItem:setChildPropData(prop)
end



function UIFuBaoGainWin:getFuBaoDatas(filterFlag)
local checkDress=self.dressToggle:getToggle()
local filter={}

local hasFilter=false
for _,vt in pairs(self.filter)do
local filterType=vt.filterType
local list=vt.list
local filterTypeData=filterFlag[filterType]or{}
local has=false
for i,v in ipairs(list)do
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
local itemguid=-1
if self.item then
itemguid=self.item.itemguid
end

local items=UIFuLuFangModel.getAllFuBao(self.diziguid,filter,checkDress,nil,hasFilter)
return items
end

function UIFuBaoGainWin:refreshFuBaoList(filterFlag,isInit)
self.fubaoDatas=self:getFuBaoDatas(filterFlag)
if isInit and not self.item then
if#self.fubaoDatas>0 then
self.selectguid=self.fubaoDatas[1].itemguid
else
self.selectguid=nil
end
end
self.enhancedscrollscript:initData(self.fubaoDatas,95,#self.fubaoDatas)
end

function UIFuBaoGainWin:onRefreshRankItem(widget,data)
if data==nil or not widget or _this==nil then return end
widget:SetChildActive(-1,true)
local diziguid_=_this.diziguid
local itemId=data.itemid
local itemguid=data.itemguid
local isSelect=_this.selectguid==itemguid
local switchidx=UIFuLuFangModel:getSwitchidxByItemGuid(itemguid)or 0
widget:SetChildActive(0,isSelect)
widgetHelper.setNormalRewardItem(widget,1,{itemId,0})
local cfg=itemsConfig.getConfig(itemId)
widget:SetChildText(2,cfg.name)

local stageTitile=itemsConfig.getStageName(itemId)
local stageStr=cfg.stage and pfwindowslController:getStageStr(itemId,stageTitile)or''
widget:SetChildActive(5,stageStr~='')
widget:SetChildText(6,stageStr)

local hasEquiped=UIFuLuFangModel:isEquipedOnAnyDizi(itemguid)
widget:SetChildActive(3,hasEquiped)
local showDizi=false
local isShowVoc=false
if hasEquiped then
local diziguid=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
widget:SetChildActive(7,diziguid==diziguid_)
widget:SetChildActive(3,diziguid~=diziguid_)
showDizi=diziguid~=diziguid_
if diziguid and diziguid~=diziguid_ then
local isSPdz=UIDiscipleModel:isSPDiscipleEx(diziguid)
isShowVoc=isSPdz
comHelper.setChildModelRawImage(widget,diziguid,4,0,eHeadCenterType.eHead,nil,nil,nil,switchidx)

end
widget:SetChildActive(11,isShowVoc)
widget:SetChildActive(12,isShowVoc)
if isShowVoc then
local switchJobIcon=UIDiscipleModel:getJobIconNameX(diziguid,switchidx)
widget:SetChildCSImageSprite(11,globalABLookup.global,switchJobIcon)
end
else
widget:SetChildActive(11,false)
end

local data=UIYuFuLingZhenControl:getLingZhenData(itemguid)
if data and data.zhentuId>0 and not showDizi then
local abName,imgName=UIYuFuLingZhenControl:getImageName(data.zhentuId,true)
widget:SetChildActive(10,true)
widget:SetChildCSImageSprite(10,abName,imgName)
else
widget:SetChildActive(10,false)
end

widget:SetBaseItemChildID(-1,itemId)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetBaseItemClickEvent(-1,function(...)self:on_item_click(...)end)
end

function UIFuBaoGainWin:freshGainPage()
local noitem=self.item==nil and#self.fubaoDatas==0
self.gainPage:setActive(noitem)
self.dressToggle:setActive(not noitem)
if noitem then
local tuijianItemid=self.tuijianItemid
local itemConf=itemsConfig.getConfig(tuijianItemid)
self.produce=itemConf.produce

local produce=self.produce or{}
local len=#produce
self.gainScrollView:freshGridsNum(len,len,1,self.initGain~=true)
self.initGain=true
end
end

function UIFuBaoGainWin:fillGainData(index,widget)
local info=self.produce[index]
local jump=info.jump
local unLock,err=self:checkGainUnLock(info)
local isUnlock=jump and unLock or false
widget:SetChildText(0,info.desc)
widget:SetChildActive(1,not unLock)
widget:SetChildActive(2,isUnlock)
widget:SetChildButtonClick(3,function()
if isUnlock then
jumpManager:jump(jump)
else
UIManager.error(err)
end
end)
end

function UIFuBaoGainWin:checkGainUnLock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
local name=systemConfig.getSystemName(sysid)
return false,FMT.fmt('请先开启{0}系统，无法跳转',name)
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,FMT.fmt('宗门等级不足{0}级，无法跳转',lv)
end
end
return true
end



function UIFuBaoGainWin:showTips(itemid,itemguid)
local backType=TIPS_BACK_TYPE.eNone
local args={
formType=TIPS_FORM_TYPE.eEquipListWin,
itemid=itemid,
itemguid=itemguid,
movepos=TIPS_MOVE_POS.eRight,
backType=backType,
attach={
diziguid=self.diziguid,
pos=self.pos,
},
}
tipsManager.showTips(args)
self.isShowTips=true
self:showTipsDi()
end

function UIFuBaoGainWin:closeTips()
tipsManager.closeTips()
self.isShowTips=false
self:showTipsDi()
end

function UIFuBaoGainWin:doAni()
if self.movepos then
self.winlua:SetChildDOAnchorPosX(self.root:getID(),_movePosX[self.movepos],0.5)
end
end

function UIFuBaoGainWin:showTipsDi()
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



function UIFuBaoGainWin:onCloseClick()
self:closeSelf()
end

function UIFuBaoGainWin:onTipsDi()
self:freshEquipPage(true)
end



function UIFuBaoGainWin:initFilter()
self.filter={}
local filterAttr={}
filterAttr.childNameList={}
filterAttr.childNameList[#filterAttr.childNameList+1]="攻击"
filterAttr.childNameList[#filterAttr.childNameList+1]="生命"
filterAttr.childNameList[#filterAttr.childNameList+1]="防御"
filterAttr.filterType=ITEM_FILTER_TYPE.eFubaoAttr
filterAttr.name='基础属性'
filterAttr.list={{FUBAO_EFFECT_TYPE.eBaseAttr,eAttributeType.eATK},
{FUBAO_EFFECT_TYPE.eBaseAttr,eAttributeType.eHP},
{FUBAO_EFFECT_TYPE.eBaseAttr,eAttributeType.eDEF}}
self.filter[#self.filter+1]=filterAttr

local filterSixAttr={}
filterSixAttr.childNameList={}
filterSixAttr.childNameList[#filterSixAttr.childNameList+1]="潜力"
filterSixAttr.childNameList[#filterSixAttr.childNameList+1]="根骨"
filterSixAttr.childNameList[#filterSixAttr.childNameList+1]="资质"
filterSixAttr.childNameList[#filterSixAttr.childNameList+1]="聪慧"
filterSixAttr.childNameList[#filterSixAttr.childNameList+1]="魅力"
filterSixAttr.childNameList[#filterSixAttr.childNameList+1]="机缘"
filterSixAttr.filterType=ITEM_FILTER_TYPE.eFubaoRandomSixAttr
filterSixAttr.name='六维'
filterSixAttr.list={{FUBAO_EFFECT_TYPE.eSixAttr,DISCIPLE_BASE_ATTR_TYPE.eQianLi},
{FUBAO_EFFECT_TYPE.eSixAttr,DISCIPLE_BASE_ATTR_TYPE.eGenGu},
{FUBAO_EFFECT_TYPE.eSixAttr,DISCIPLE_BASE_ATTR_TYPE.eZiZhi},
{FUBAO_EFFECT_TYPE.eSixAttr,DISCIPLE_BASE_ATTR_TYPE.eCongHui},
{FUBAO_EFFECT_TYPE.eSixAttr,DISCIPLE_BASE_ATTR_TYPE.eMeiLi},
{FUBAO_EFFECT_TYPE.eSixAttr,DISCIPLE_BASE_ATTR_TYPE.eJiYuan}}
self.filter[#self.filter+1]=filterSixAttr

local filterGfExp={}
filterGfExp.filterType=ITEM_FILTER_TYPE.eFubaoRandomAttrGongFaExp
filterGfExp.name='功法经验'
filterGfExp.childNameList={}
filterGfExp.list={}
local list=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
for _,element in ipairs(list)do
table.insert(filterGfExp.childNameList,FMT.fmt('{0}系功法',ELEMENT_TYPE.getName(element)))
table.insert(filterGfExp.list,{FUBAO_EFFECT_TYPE.eGongFaExpSpeed,element})
end
self.filter[#self.filter+1]=filterGfExp

local filterProfession={}
filterProfession.filterType=ITEM_FILTER_TYPE.eFubaoRandomAttrProfessionExp
filterProfession.name='专业技能经验'
filterProfession.childNameList={}
filterProfession.list={}
local cfgs=cfg_discipleproskillconfig()
for i,v in ipairs(cfgs)do
table.insert(filterProfession.childNameList,FMT.fmt('{0}经验',v.name))
table.insert(filterProfession.list,{FUBAO_EFFECT_TYPE.eProfessionExp,v.id})
end
self.filter[#self.filter+1]=filterProfession


local filterZhenTu={}
filterZhenTu.filterType=ITEM_FILTER_TYPE.eFubaoZhenTu
filterZhenTu.name='激活阵图'
filterZhenTu.childNameList={}
filterZhenTu.childNameList[#filterZhenTu.childNameList+1]="鹤舞玉轮阵"
filterZhenTu.childNameList[#filterZhenTu.childNameList+1]="双鸾缠羽阵"
filterZhenTu.childNameList[#filterZhenTu.childNameList+1]="灵鹿踏云阵"
filterZhenTu.childNameList[#filterZhenTu.childNameList+1]="洛神飞天阵"
filterZhenTu.childNameList[#filterZhenTu.childNameList+1]="龙骧九天阵"
filterZhenTu.childNameList[#filterZhenTu.childNameList+1]="未激活阵图"
filterZhenTu.list={}
filterZhenTu.list={{FUBAO_EFFECT_TYPE.eZhenTu,1},
{FUBAO_EFFECT_TYPE.eZhenTu,2},
{FUBAO_EFFECT_TYPE.eZhenTu,3},
{FUBAO_EFFECT_TYPE.eZhenTu,4},
{FUBAO_EFFECT_TYPE.eZhenTu,5},
{FUBAO_EFFECT_TYPE.eZhenTu,0}}
self.filter[#self.filter+1]=filterZhenTu

end

function UIFuBaoGainWin:updateView()
local pagenum=#self.filter
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UIFuBaoGainWin:refreshPageItem(item,pageidx)
local pageData=self.filter[pageidx]
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

function UIFuBaoGainWin:refreshChildItem(childItem,idx,childNameList,childFlagList,pageidx)
local desc_str=childNameList[idx]
local isselect=childFlagList[idx]or false
childItem:SetChildToggleChange(childItemCmpIndex.toggle,nil)
childItem:SetChildToggle(childItemCmpIndex.toggle,isselect)
childItem:SetChildToggleChange(childItemCmpIndex.toggle,function(name,isOn)
childFlagList[idx]=isOn
_this:refreshFuBaoList(self.filterFlag)
_this:freshEquipPage(true)
_this:freshGainPage()
end)
childItem:SetChildText(childItemCmpIndex.name,desc_str)
end

function UIFuBaoGainWin:onFubaoFilterBtn()
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

function UIFuBaoGainWin:onCloseFilterBtn()
self.isShowFilter=false
self.filterRoot:setActive(false)

self:refreshFuBaoList(self.filterFlag,true)
self:freshEquipPage()
self:freshGainPage()
end

function UIFuBaoGainWin:onBtnReset()
for i,v in pairs(self.filterFlag)do
for i1,v1 in pairs(v)do
self.filterFlag[i][i1]=false
end
end
self:updateView()
self:refreshFuBaoList(self.filterFlag)
self:freshEquipPage(true)
self:freshGainPage()
end

function UIFuBaoGainWin:onBtnConfirm()

end



function UIFuBaoGainWin:refreshItem(itemguid)

local startIdx=_this.enhancedscrollscript:getStartCellViewIndex()
local endIdx=_this.enhancedscrollscript:getEndCellViewIndex()

for i=startIdx,endIdx do
local dataIndex=i+1
local data=_this.fubaoDatas[dataIndex]
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
local data=self.window.fubaoDatas[i]
self.window:onRefreshRankItem(item,data)
end

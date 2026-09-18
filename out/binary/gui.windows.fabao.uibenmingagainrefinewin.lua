







def_class("UIBenMingAgainRefineWin",UIWindowBase)









function UIBenMingAgainRefineWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.btnLianzhi=UIButton.get(self,1)
self.changeMainFabaoBtn=UIButton.get(self,2)
self.changeMainFabaoBtn2=UIButton.get(self,3)
self.costRoot=UIObject.get(self,4)
self.dzRoot=UIObject.get(self,5)
self.effect1=UIObject.get(self,6)
self.effect2=UIObject.get(self,7)
self.effect3=UIObject.get(self,8)
self.effect4=UIObject.get(self,9)
self.fabaoClick=UIButton.get(self,10)
self.fabaoRoot=UIObject.get(self,11)
self.fbicon=UIObject.get(self,12)
self.help=UIButton.get(self,13)
self.itemFaBao=UIBaseItem.get(self,14)
self.itemFaBaoSlot_1=UIBaseItem.get(self,15)
self.itemFaBaoSlot_2=UIBaseItem.get(self,16)
self.itemFaBaoSlot_3=UIBaseItem.get(self,17)
self.items_1=UIBaseItem.get(self,18)
self.items_2=UIBaseItem.get(self,19)
self.items_3=UIBaseItem.get(self,20)
self.items_4=UIBaseItem.get(self,21)
self.parent=UIObject.get(self,22)
self.previewRoot=UIObject.get(self,23)
self.root=UIObject.get(self,24)
self.selectBenMing=UIObject.get(self,25)
self.selectBenMingBtn=UIButton.get(self,26)
self.ypicon=UIImage.get(self,27)

self.btnLianzhi:setButtonClick(function()self:onBtnLianzhi()end)

self.changeMainFabaoBtn:setButtonClick(function()self:onChangeMainFabaoBtn()end)

self.changeMainFabaoBtn2:setButtonClick(function()self:onChangeMainFabaoBtn2()end)

self.fabaoClick:setButtonClick(function()self:onFabaoClick()end)

self.help:setButtonClick(function()self:onHelp()end)

self.selectBenMingBtn:setButtonClick(function()self:onSelectBenMingBtn()end)
self.itemFaBaoSlot={
self.itemFaBaoSlot_1,
self.itemFaBaoSlot_2,
self.itemFaBaoSlot_3,
}
self.items={
self.items_1,
self.items_2,
self.items_3,
self.items_4,
}



end


function UIBenMingAgainRefineWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btnLianzhi);self.btnLianzhi=nil;
_UIObject_release(self.changeMainFabaoBtn);self.changeMainFabaoBtn=nil;
_UIObject_release(self.changeMainFabaoBtn2);self.changeMainFabaoBtn2=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.dzRoot);self.dzRoot=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.fabaoClick);self.fabaoClick=nil;
_UIObject_release(self.fabaoRoot);self.fabaoRoot=nil;
_UIObject_release(self.fbicon);self.fbicon=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.itemFaBao);self.itemFaBao=nil;
_UIObject_release(self.itemFaBaoSlot_1);self.itemFaBaoSlot_1=nil;
_UIObject_release(self.itemFaBaoSlot_2);self.itemFaBaoSlot_2=nil;
_UIObject_release(self.itemFaBaoSlot_3);self.itemFaBaoSlot_3=nil;
_UIObject_release(self.items_1);self.items_1=nil;
_UIObject_release(self.items_2);self.items_2=nil;
_UIObject_release(self.items_3);self.items_3=nil;
_UIObject_release(self.items_4);self.items_4=nil;
_UIObject_release(self.parent);self.parent=nil;
_UIObject_release(self.previewRoot);self.previewRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBenMing);self.selectBenMing=nil;
_UIObject_release(self.selectBenMingBtn);self.selectBenMingBtn=nil;
_UIObject_release(self.ypicon);self.ypicon=nil;
self.itemFaBaoSlot=nil;
self.items=nil;
end
















local _this

local _stateEnum={
eSelectBenMing=1,
eSelectMaterial=2,
eSelectMainMaterial=3,
ePrepareAgainRefine=4,
}

local _colorBg=fabaoConfig.bmQualityBg

local _previewBg=
{
[eQualityColor.ePurple]='image_benmingfbdpz_1',
[eQualityColor.eOrange]='image_benmingfbdpz_2',
[eQualityColor.eRed]='image_benmingfbdpz_3',
}

local _clickRefineBtnCD=3




function UIBenMingAgainRefineWin:onLoaded(...)
self:bindComponents()

_this=self

self.stage=_stateEnum.eSelectBenMing

self.bmfbGuid=Int64_0
self.materials={}
self.mainMaterialIndex=0

self.checkList={}

self.clickRefinebtnStamp=0

self.oldBmfbGuid=Int64_0

self._on_item_list_changed=function(...)
if not self or self.isClose then return end
self:on_item_list_changed(...)
end

self:addNotify(notifyConfig.on_item_list_changed,self._on_item_list_changed)

self.on_money_changed=function(mtype,last,curr)
if self.checkList[mtype]then
self:refreshCost()
end
end

self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIBenMingAgainRefineWin:__delete()
_this=nil
uiAIManager:clearUIWinData('UIBenMingAgainRefineWin')
self:unbindComponents()
end




function UIBenMingAgainRefineWin:onShow(argtable,afterOnloaded)

self.checkList={}

self:refreshAll()

if afterOnloaded then
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end
self.bgModel:setChildUIModelShowTarget(6122,1,nil,eAnimationID.stand)
end
end


function UIBenMingAgainRefineWin:onHide()

end


function UIBenMingAgainRefineWin:refreshAll()
self:refreshStage()
end

function UIBenMingAgainRefineWin:refreshStage()
local isShowStageSelctBM=self.stage==_stateEnum.eSelectBenMing
local isShowCost=self.stage==_stateEnum.ePrepareAgainRefine

self.selectBenMing:setActive(isShowStageSelctBM)
self.fabaoRoot:setActive(not isShowStageSelctBM)
self.costRoot:setActive(isShowCost)

if not isShowStageSelctBM then
self:refreshBMSlot()
self:refreshAllMaterialSlotItem()
end

self:refreshDzRoot()

self:freshPreview()


if isShowCost then
self:refreshCost()
end
end

function UIBenMingAgainRefineWin:refreshBMSlot()
local widget=self.itemFaBao:getWidgetBase()
widget:SetChildButtonClick(6,function()
self:onClickChangeBMFB()
end,true)
local itemData=bagModel.getItem(self.bmfbGuid)or fabaoModel.getFabao(self.bmfbGuid)
local itemCfg=itemsConfig.getConfig(itemData.itemid)
widget:SetChildActive(0,true)
widget:SetChildCSImageSprite(0,globalABLookup.global,_colorBg[itemCfg.color])
widget:SetChildActive(1,true)
widget:SetChildIcon(1,itemsModel.getIconName(itemData),false)
widget:SetChildActive(4,true)
widget:SetChildActive(5,false)
widget:SetChildText(8,FMT.fmt("{0}阶",itemCfg.stage))
end

function UIBenMingAgainRefineWin:refreshAllMaterialSlotItem()
for index,_ in ipairs(self.itemFaBaoSlot)do
self:refreshMaterialSlotItem(index)
end
end

function UIBenMingAgainRefineWin:refreshMaterialSlotItem(index)
local item=self.itemFaBaoSlot[index]
local widget=item:getWidgetBase()
local itemguid=self.materials[index]
widget:SetChildButtonClick(7,function()
self:onClickChangeCLFB(index)
end,true)
local name='<color=#C39962>材料法宝</color>'
local ypitem=bagModel.getItem(self.bmfbGuid)or fabaoModel.getFabao(self.bmfbGuid)
local rawList=ypitem.itemData.rawList
local rawItemId=rawList[index].param_2
local rawConfig=itemsConfig.getConfig(rawItemId)
local fbtype=rawConfig.type2
local fbtypeCfg=cfg_fabaoyuanpeitypeconfig_get(fbtype)
if itemguid then
local equip=fabaoHelper.getFabao(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local iconname=itemsModel.getIconName(equip)
name=FMT.fmt('<color=#C39962>{0}</color>',equip.itemData.name)
widget:SetChildActive(0,true)
widget:SetChildCSImageSprite(0,globalABLookup.global,_colorBg[itemCfg.color])
widget:SetChildActive(1,true)
widget:SetChildIcon(1,iconname,false)
widget:SetChildText(3,name)
widget:SetChildActive(4,false)
widget:SetChildActive(5,true)
widget:SetChildActive(8,true)
widget:SetChildText(9,FMT.fmt("{0}阶",itemCfg.stage))
widget:SetChildCSImageSprite(6,globalABLookup.benmingFaBaoSmallSprite,
iconHelper.getFaBaoTypeSmallIcon(fbtypeCfg.smallicon))
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)
widget:SetChildText(3,name)
widget:SetChildActive(4,true)
widget:SetChildActive(5,false)
widget:SetChildActive(8,false)
widget:SetChildCSImageSprite(6,globalABLookup.benmingFaBaoSmallSprite,"icon_daojusl_0000")
end
widget:SetChildCSImageSprite(7,globalABLookup.benmingFaBaoSprite,'image_benmingfbui_3')
widget:SetChildActive(6,true)
end

function UIBenMingAgainRefineWin:freshPreview()
local isFabaoFull=self:isFabaoFull()
local show=self.bmfbGuid and self:isFabaoFull()and self.mainMaterialIndex~=0 or false
self.changeMainFabaoBtn2:setActive(isFabaoFull and self.mainMaterialIndex==0)
self.previewRoot:setActive(show)
self.btnLianzhi:setActive(show)
if not show then return end
local color=itemsConfig.getConfig(self.bmfbItemId).color
self.fabaoClick:setSprite(globalABLookup.benmingFaBaoSprite,_previewBg[color])
local itemData=bagModel.getItem(self.bmfbGuid)or fabaoModel.getFabao(self.bmfbGuid)
self.fbicon:setChildIcon(itemsModel.getIconName(itemData),false)
self.changeMainFabaoBtn:setActive(true)
end

function UIBenMingAgainRefineWin:refreshCost()
self.remakeCostList=self:getRemakeCostList()

local costs=self.remakeCostList
for i,v in ipairs(self.items)do
local cost=costs[i]
v:setActive(cost~=nil)
if cost~=nil then
local widget=v:getWidgetBase()

local itemid=cost[1]
local need=cost[2]
self.checkList[itemid]=true
local itemCfg=itemsConfig.getConfig(itemid)
local countStr=UIDanYaoModel:getItemCountStr(itemid,need)
widget:SetChildButtonClick(0,function()
self:clickItem(itemid)
end,true)

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconHelper.getIconName(itemCfg.icon),true)
widget:SetChildText(3,countStr)
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
end
end
end

function UIBenMingAgainRefineWin:removeDzAI()
if self.aiBt then
uiAIManager:removeUIInstance(self.aiBt)
self.aiBt=nil
end
end

function UIBenMingAgainRefineWin:refreshDzRoot()
local isShow=mathHelper.validInt64(self.bmfbGuid)
local isChange=not mathHelper.compareInt64(self.oldBmfbGuid,self.bmfbGuid)

if isChange then
uiAIManager:clearUIWinData('UIBenMingAgainRefineWin')
end

self.dzRoot:setActive(isShow)
if not isShow then

self:removeDzAI()
return
end

if isShow and self.bmfbDzGuid~=nil then
return
end

local item=itemsModel.getItem(self.bmfbGuid)
self.bmfbDzGuid=item.itemData.discipleguid
self.equipBMFBDzGuid=fabaoModel.getDiziguidByItemguid(self.bmfbGuid)

local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=0,
leftPos={-250,-20},
rightPos={0,-20},
waitspeak=0,
}
local tran=self.dzRoot:getCommonComponent('Transform')
local vpos=Vector2.New(-100,-20)

local otherData=
{
keepButtonEvent=true,
}

uiAIManager:createUIDisciple('UIBenMingAgainRefineWin','bt_ui_bmfb_refine_dzai',self.bmfbDzGuid,tran,vpos,initData,otherData,function(bt)
if _this==nil then
behaviorManager:removeBehaviorTree(bt)
return
end
_this.aiBt=bt
end)
end

function UIBenMingAgainRefineWin:getSpeakText(bt,tkey)
local txt=self:getBuildSpeakConfig(self.bmfbDzGuid)

bt:setSharedVar(tkey,txt)
end

function UIBenMingAgainRefineWin:getBuildSpeakConfig(diziguid)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'bmfb_refine')
local txt=speakList[math.random(1,#speakList)]or''
return txt
end


function UIBenMingAgainRefineWin:isFabaoFull()
return table.numsEx(self.materials)==3
end

function UIBenMingAgainRefineWin:getRemakeCostList()
local costDataList={}

local costTemp={}
local item=itemsModel.getItem(self.bmfbGuid)
local mainId=item.itemData.mainid
local ypItemCfg=itemsConfig.getConfig(mainId)
local comsume=ypItemCfg.consume

local itemCfg=itemsConfig.getConfig(item.itemid)
local oldStage=itemCfg.stage

local mainMaterialGuid=self.materials[self.mainMaterialIndex]
local metarialItemData=itemsModel.getItem(mainMaterialGuid)
local metarialItemStage=itemsConfig.getConfig(metarialItemData.itemid).stage

local oldConsumeMap={}
for index,data in ipairs(comsume[oldStage])do
oldConsumeMap[data[1]]=data[2]
end

local newConsumeMap={}
for index,data in ipairs(comsume[metarialItemStage])do
newConsumeMap[data[1]]=data[2]
end

for id,num in pairs(oldConsumeMap)do
newConsumeMap[id]=newConsumeMap[id]-num
end
for id,num in pairs(newConsumeMap)do
if num>0 then
costTemp[id]=num
end
end

local bmfbJinLianLevel=fabaoModel.getFabaoJilianLevel(self.bmfbGuid)
if bmfbJinLianLevel>0 then
local jinlianResetCost=fabaoConfig.getJilianResetCost()
for index,data in ipairs(jinlianResetCost)do
costTemp[data[1]]=data[2]
end
end

local remake=cfgHelper.get2(cfg_disciplefabaoconfig_get,1,'remake')
local remakeCost=remake[metarialItemStage]
if remakeCost and next(remakeCost)then
local itemId,itemNum,costCount
for index,data in ipairs(remakeCost)do
itemId=data[1]
itemNum=data[2]

costTemp[itemId]=costTemp[itemId]and costTemp[itemId]+itemNum or itemNum
end
end

for itemId,itemNum in pairs(costTemp)do
costDataList[#costDataList+1]={itemId,itemNum}
end

table.sort(costDataList,function(a,b)
return a[1]>b[1]
end)

return costDataList
end



function UIBenMingAgainRefineWin:pushTempBenMingFaBao(itemguid)
self.tempItemGuid=itemguid
end

function UIBenMingAgainRefineWin:pushBenMingFaBao(itemguid)
if mathHelper.validInt64(self.bmfbGuid)then
self.materials={}
self.reMaterials={}
end

self.oldBmfbGuid=self.bmfbGuid
self.bmfbGuid=itemguid
local item=itemsModel.getItem(self.bmfbGuid)
self.bmfbItemId=item.itemid
self.bmfbDzGuid=nil
self.equipBMFBDzGuid=nil

self.stage=_stateEnum.eSelectMaterial
self:refreshStage()
end

function UIBenMingAgainRefineWin:pushMaterialFaBao(index,itemguid)
if self:isFabaoFull()then
self.stage=_stateEnum.eSelectMainMaterial
self.mainMaterialIndex=0
self:refreshStage()
end

self.materials[index]=itemguid

self:refreshMaterialSlotItem(index)

if self:isFabaoFull()then
self:rebuildMaterials()
self:onChangeMainFabaoBtn()
self.stage=_stateEnum.eSelectMainMaterial
self.oldBmfbGuid=self.bmfbGuid
self:refreshStage()
end
end

function UIBenMingAgainRefineWin:onSelectMainFaBao(index,itemguid)


local okCallBack=function()
self.mainMaterialIndex=index
self.stage=_stateEnum.ePrepareAgainRefine
self.previewItemguid=nil
self:rebuildMaterials()
self:refreshStage()
self:showResetTipsWin(index,self.bmfbGuid)
end

local cancelCallBack=function()
self:onChangeMainFabaoBtn()
end

self:checkShowSmallerStageDialouge(index,itemguid,okCallBack,cancelCallBack)
end

function UIBenMingAgainRefineWin:checkShowSmallerStageDialouge(index,itemguid,okCallBack,cancelCallBack)
local bmfbItemStage=itemsConfig.getConfig(self.bmfbItemId).stage
local metarialItemData=itemsModel.getItem(itemguid)
local metarialItemStage=itemsConfig.getConfig(metarialItemData.itemid).stage
if metarialItemStage<bmfbItemStage then
local content="所选主法宝的阶数<color=#f36666>低于</color>原本命法宝\n祖师是否依然要选择该主法宝"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确认',
canceltext='取消',
okcallback=okCallBack,
cancelcallback=cancelCallBack,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()

else
okCallBack()
end
end

function UIBenMingAgainRefineWin:showResetTipsWin(index,itemguid)
local okCallBack=function()
self.mainMaterialIndex=index
self.stage=_stateEnum.ePrepareAgainRefine
self:refreshStage()
end

local cancelCallBack=function()
self:onChangeMainFabaoBtn()
end

local lv,exp=fabaoModel.getFabaoJilianLevel(itemguid)

if lv>0 then
local args={
itemguid=self.bmfbGuid,
continueCallBack=okCallBack,
cancelCallBack=cancelCallBack,
}
self:showWindow("UIBMFBRefineResetLevelTipsWin",args)
else
okCallBack()
end
end

function UIBenMingAgainRefineWin:refineFinish()
self.stage=_stateEnum.eSelectBenMing
self.bmfbGuid=Int64_0
self.bmfbItemId=nil
self.mainMaterialIndex=0
self.materials={}
self.bmfbDzGuid=nil
self.equipBMFBDzGuid=nil
self.reDressDzGuid=nil

self:refreshStage()
end

function UIBenMingAgainRefineWin:rebuildMaterials()
local materials={}
materials[1]=self.materials[self.mainMaterialIndex]
for index,guid in ipairs(self.materials)do
if index~=self.mainMaterialIndex then
materials[#materials+1]=guid
end
end
self.reMaterials=materials
end


function UIBenMingAgainRefineWin:on_item_list_changed(argsTable,lookup_guidStr)

local checkFunc=function(itemguid,itemid)
if _this==nil then return end

if mathHelper.compareInt64(self.dzEquipFaBaoItemGuid,itemguid)and _this.stage==_stateEnum.ePrepareAgainRefine then
fabaoProtocolControl.reqBenMingFaBaoRemake(self.bmfbGuid,self.reMaterials)
end

if _this.checkList[itemid]then
_this:refreshCost()
end
end

local itemguid,itemid
for index,data in ipairs(argsTable)do
itemguid=data[2]
itemid=data[3]
checkFunc(itemguid,itemid)
end
end


function UIBenMingAgainRefineWin:clickItem(itemid)
tipsManager.showTips({itemid=itemid,move=TIPS_MOVE_POS.eCenter})
end

function UIBenMingAgainRefineWin:onClickChangeBMFB()
self:onSelectBenMingBtn()
end

function UIBenMingAgainRefineWin:onClickChangeCLFB(index)
local itemData=bagModel.getItem(self.bmfbGuid)or fabaoModel.getFabao(self.bmfbGuid)
local itemCfg=itemsConfig.getConfig(itemData.itemid)
local color=itemCfg.color
local rawList=itemData.itemData.rawList
local rawItemId=rawList[index].param_2
local rawConfig=itemsConfig.getConfig(rawItemId)
local fbtype=rawConfig.type2
local yptypeName=cfg_fabaoyuanpeitypeconfig_get(fbtype).name
local selfMaterial=self:getBMFBDiscipleEquipMaterialFB(fbtype)

local args={}
args.titleName="法宝选择"
args.pos=1
args.extraWin='UIFabaoRefineMaterialSelectWin'
local extraParams={}
extraParams.color=color
extraParams.fbType=fbtype
extraParams.filterlist=self.materials
extraParams.holeIdx=index
local desc=FMT.fmt('{0}以上的{1}类法宝可作为材料法宝',
eQualityColorName[color],yptypeName)
extraParams.title=desc
extraParams.selectguid=self.materials[index]
extraParams.selfMaterial=selfMaterial
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end


local _mItemAnimationTime=1
function UIBenMingAgainRefineWin:playRefineAnimation(newBmfbGuid)

self.newBmfbGuid=newBmfbGuid or self.bmfbGuid

if self.reDressDzGuid~=nil then
local fbItem=fabaoModel.getFabaoByDizi(self.reDressDzGuid)
if fbItem==nil and newBmfbGuid~=nil then
fabaoProtocolControl.reqDressFabao(self.reDressDzGuid,newBmfbGuid,true)
end
end

local initData={
waitFinish=0.78
}

behaviorManager:addBehaviorTree("bt_ui_bmfb_refine",nil,true,initData,true)
end

function UIBenMingAgainRefineWin:prepareAnimation()
local itemWidget
for index,mItem in ipairs(self.itemFaBaoSlot)do
itemWidget=mItem:getWidgetBase()

itemWidget:SetChildActive(2,false)
itemWidget:SetChildActive(5,false)
itemWidget:SetChildActive(6,false)
itemWidget:SetChildActive(7,false)
itemWidget:SetChildActive(8,false)
itemWidget:SetChildActive(10,false)
end

local mainItemWidget=self.itemFaBao:getWidgetBase()

mainItemWidget:SetChildActive(4,false)
mainItemWidget:SetChildActive(7,false)

self.previewRoot:setActive(false)
self.costRoot:setActive(false)

self.btnLianzhi:setActive(false)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
self.bgModel:setChildModelAnimationState(3100,1,nil)

uiAIManager:clearUIWinData('UIBenMingAgainRefineWin')

self.effect2:setChildShowEffect(20660,true)
end


function UIBenMingAgainRefineWin:showBMFBCreateWin()
UIManager:showWindow('UIBenMingFabaoCreateWin',{itemguid=self.newBmfbGuid,closeCallBack=function()
fabaoProtocolControl:delayShowJlLvPrize()
end})
end

function UIBenMingAgainRefineWin:endAnimation()
local itemWidget
for index,mItem in ipairs(self.itemFaBaoSlot)do
itemWidget=mItem:getWidgetBase()

itemWidget:SetChildActive(2,true)
itemWidget:SetChildActive(5,true)
itemWidget:SetChildActive(6,false)
itemWidget:SetChildActive(7,true)
itemWidget:SetChildActive(8,false)
itemWidget:SetChildActive(10,true)
end

local mainItemWidget=self.itemFaBao:getWidgetBase()

mainItemWidget:SetChildActive(4,true)










self.winlua:SetChildCanvasGroupAlpha(self.itemFaBaoSlot[1]:getID(),1)
self.winlua:SetChildCanvasGroupAlpha(self.itemFaBaoSlot[2]:getID(),1)
self.winlua:SetChildCanvasGroupAlpha(self.itemFaBaoSlot[3]:getID(),1)

self.bgModel:setChildModelAnimationState(eAnimationID.stand,1,nil)

self:refineFinish()
end

function UIBenMingAgainRefineWin:mFabaoAnimation(index)
local fbSlot=self.itemFaBaoSlot[index]

self.winlua:SetChildCanvasGroupDOFade(fbSlot:getID(),0,0.5)



end


function UIBenMingAgainRefineWin:getBMFBDiscipleEquipMaterialFB(type2)
if self.bmfbDzGuid==nil then return end

local fabaoItem=fabaoModel.getFabaoByDizi(self.bmfbDzGuid)

if fabaoItem==nil then return end

local mcfg=itemsConfig.getConfig(fabaoItem.itemData.mainid)
local itemCfg=itemsConfig.getConfig(fabaoItem.itemid)
if itemCfg.type1~=FABAO_TYPE.eBenMing and mcfg.type2==type2 then
return fabaoItem
end
end





function UIBenMingAgainRefineWin:onBtnLianzhi()
local curTime=timeHelper.getServerShortTime()
if _clickRefineBtnCD>curTime-self.clickRefinebtnStamp then
UIManager.error("重炼中")
return
end
self.clickRefinebtnStamp=curTime

local isNeedTakeOff=false
if self.equipBMFBDzGuid~=nil then
isNeedTakeOff=true
self.reDressDzGuid=self.equipBMFBDzGuid
self.dzEquipFaBaoItemGuid=self.bmfbGuid
else
local dzEquipFaBaoItem=fabaoModel.getFabaoByDizi(self.bmfbDzGuid)

if dzEquipFaBaoItem~=nil then
local guid=dzEquipFaBaoItem.itemguid
self.dzEquipFaBaoItemGuid=guid

if mathHelper.compareInt64(guid,self.bmfbGuid)then
isNeedTakeOff=true
end

if table.findValueEx(self.materials,guid,function(val)return tostring(val)end)then
isNeedTakeOff=true
self.reDressDzGuid=self.bmfbDzGuid
end
end
end



local callback=function()
if isNeedTakeOff then
fabaoProtocolControl.reqTakeoffFabao(_this.reDressDzGuid)
else
fabaoProtocolControl.reqBenMingFaBaoRemake(_this.bmfbGuid,_this.reMaterials)
end
end

local isAllOk=true
for index,costData in ipairs(self.remakeCostList)do
if not itemsModel:useItem(costData[1],costData[2],function()end,WARNING_TYPE.eWarning)then
isAllOk=false
break
end
end

if isAllOk then
local bmfbItemStage=itemsConfig.getConfig(self.bmfbItemId).stage
local metarialItemData=itemsModel.getItem(self.reMaterials[1])
local metarialItemStage=itemsConfig.getConfig(metarialItemData.itemid).stage
if metarialItemStage<bmfbItemStage then
local content="重炼后的本命法宝阶数<color=#C82C2C>低于</color>原本命法宝，\n是否继续选择当前主法宝进行重炼？"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确认',
canceltext='取消',
okcallback=callback,
cancelcallback=nil,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
callback()
end
end
end



function UIBenMingAgainRefineWin:onChangeMainFabaoBtn()
local argstable={}
argstable.tipsList={}
local tipsList=argstable.tipsList
for i=1,3 do
local itemguid=self.materials[i]
local args={itemguid=itemguid}
args.attach={}
args.attach.insertBtnList={TIPS_SRC_TYPE.tipsChildRefineMainFabaoButton}
args.attach.index=i
args.removeBodyList={TIPS_SRC_TYPE.tipsChildFabaoLianhuaAttr}
tipsList[#tipsList+1]=args
end
tipsList.posY=20

argstable.extList={}
local extList=argstable.extList
extList[#extList+1]=
{
childType=TIPS_SRC_TYPE.tipsChildSelectMainFabaoDesc,
argtable=
{
desc='本命法宝将继承主法宝的精炼等级、词缀属性和五行属性',
title='设置主法宝'
},
}
UIManager:showWindow('UIMultiTipsWin',argstable)
end



function UIBenMingAgainRefineWin:onChangeMainFabaoBtn2()
self:onChangeMainFabaoBtn()
end



function UIBenMingAgainRefineWin:onDzBtn()
end



function UIBenMingAgainRefineWin:onFabaoClick()
if self.previewItemguid then
local args={itemguid=self.previewItemguid}
args.formType=TIPS_FORM_TYPE.eFaBaoRefineCompare
args.attach={
oldItemGuid=self.bmfbGuid,
baseOldItemGuid=self.previewBaseOldItemGuid,
baseNewItemGuid=self.previewBaseNewItemGuid,
}
tipsManager.showTips(args)
else
self.previewItemguid=fabaoPreviewModel:create_refine(self.bmfbGuid,self.reMaterials)

self.previewBaseOldItemGuid=fabaoPreviewModel:create_Compare_refine(self.bmfbGuid)
self.previewBaseNewItemGuid=fabaoPreviewModel:create_Compare_refine(self.previewItemguid)

local args={itemguid=self.previewItemguid}
args.formType=TIPS_FORM_TYPE.eFaBaoRefineCompare
args.attach={
oldItemGuid=self.bmfbGuid,
baseOldItemGuid=self.previewBaseOldItemGuid,
baseNewItemGuid=self.previewBaseNewItemGuid,
}
tipsManager.showTips(args)
end
end



function UIBenMingAgainRefineWin:onHelp()
local d={}
d.title='说明'
d.mode=3
d.name='bmfb_refine_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIBenMingAgainRefineWin:onSelectBenMingBtn()
local args={}
args.titleName="本命法宝"
args.pos=1
args.extraWin='UIFabaoBenMingFaBaoSelectWin'
local extraParams={}
extraParams.itemguid=self.bmfbGuid
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end


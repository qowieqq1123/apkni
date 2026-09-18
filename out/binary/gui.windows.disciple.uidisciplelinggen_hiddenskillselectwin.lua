







def_class("UIDiscipleLinggen_HiddenSkillSelectWin",UIWindowBase)









function UIDiscipleLinggen_HiddenSkillSelectWin:bindComponents()

self.activeHiddenSkillitem=UIObject.get(self,0)
self.autoFindCountAni=UIText.get(self,1)
self.autoFindingBtn=UIButton.get(self,2)
self.autoFindingBtnTxt=UIText.get(self,3)
self.autoFindRoot=UIObject.get(self,4)
self.autoStartFindBtn=UIButton.get(self,5)
self.barModel=UIObject.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.costicon=UIObject.get(self,8)
self.costRoot=UIObject.get(self,9)
self.costvalue=UIText.get(self,10)
self.findBtn=UIButton.get(self,11)
self.findBtnTxt=UIText.get(self,12)
self.findMask=UIObject.get(self,13)
self.freeFindBtn=UIButton.get(self,14)
self.giveupBtn=UIButton.get(self,15)
self.heidong=UIObject.get(self,16)
self.hiddenPreviewBtn=UIButton.get(self,17)
self.hiddenSkill_0=UIBaseItem.get(self,18)
self.hiddenSkill_1=UIBaseItem.get(self,19)
self.hiddenSkill_2=UIBaseItem.get(self,20)
self.hiddenSkill_3=UIBaseItem.get(self,21)
self.hiddenSkill_4=UIBaseItem.get(self,22)
self.hiddenSkill_5=UIBaseItem.get(self,23)
self.hiddenSkillList=UIObject.get(self,24)
self.hiddenSkillRecordItem_1=UIBaseItem.get(self,25)
self.hiddenSkillRecordItem_2=UIBaseItem.get(self,26)
self.hiddenSkillRecordItem_3=UIBaseItem.get(self,27)
self.hiddenSkillRoot=UIObject.get(self,28)
self.itemlist=UIScrollView.get(self,29)
self.lbroot=UIObject.get(self,30)
self.lefteffect=UIObject.get(self,31)
self.mibaofuroot=UIBaseItem.get(self,32)
self.mibaofuSelectPanel=UIObject.get(self,33)
self.mibaofuSelectPanelMask=UIObject.get(self,34)
self.mzbkBtn=UIButton.get(self,35)
self.mzbkCount=UIText.get(self,36)
self.mzbkRoot=UIObject.get(self,37)
self.progressBar=UIObject.get(self,38)
self.quickBgModel=UIObject.get(self,39)
self.quickFindProgressRoot=UIObject.get(self,40)
self.remainingTimesRoot=UIObject.get(self,41)
self.remainingTimesTxt=UIText.get(self,42)
self.righteffect=UIObject.get(self,43)
self.rightroot=UIObject.get(self,44)
self.root=UIObject.get(self,45)
self.rtip=UIText.get(self,46)
self.selectBtn=UIButton.get(self,47)
self.selectBtn2=UIButton.get(self,48)
self.showActiveHoardBtn=UIButton.get(self,49)
self.showActiveHoardBtnEffect=UIObject.get(self,50)
self.showActiveHoardIcon=UIImage.get(self,51)
self.showActiveHoardInfo=UIText.get(self,52)
self.showActiveRoot=UIObject.get(self,53)
self.showInfoBtn=UIButton.get(self,54)
self.spCostDirection=UIObject.get(self,55)
self.stopAutoFindBtn=UIButton.get(self,56)
self.tequanBtn=UIButton.get(self,57)
self.tequanRoot=UIObject.get(self,58)
self.title=UIText.get(self,59)
self.typeList=UIObject.get(self,60)
self.wordModel=UIObject.get(self,61)

self.autoFindingBtn:setButtonClick(function()self:onAutoFindingBtn()end)

self.autoStartFindBtn:setButtonClick(function()self:onAutoStartFindBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.findBtn:setButtonClick(function()self:onFindBtn()end)

self.freeFindBtn:setButtonClick(function()self:onFreeFindBtn()end)

self.giveupBtn:setButtonClick(function()self:onGiveupBtn()end)

self.hiddenPreviewBtn:setButtonClick(function()self:onHiddenPreviewBtn()end)

self.mzbkBtn:setButtonClick(function()self:onMzbkBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.selectBtn2:setButtonClick(function()self:onSelectBtn2()end)

self.showActiveHoardBtn:setButtonClick(function()self:onShowActiveHoardBtn()end)

self.showInfoBtn:setButtonClick(function()self:onShowInfoBtn()end)

self.stopAutoFindBtn:setButtonClick(function()self:onStopAutoFindBtn()end)

self.tequanBtn:setButtonClick(function()self:onTequanBtn()end)
self.hiddenSkill={
[0]=self.hiddenSkill_0,
[1]=self.hiddenSkill_1,
[2]=self.hiddenSkill_2,
[3]=self.hiddenSkill_3,
[4]=self.hiddenSkill_4,
[5]=self.hiddenSkill_5,
}
self.hiddenSkillRecordItem={
self.hiddenSkillRecordItem_1,
self.hiddenSkillRecordItem_2,
self.hiddenSkillRecordItem_3,
}



end


function UIDiscipleLinggen_HiddenSkillSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeHiddenSkillitem);self.activeHiddenSkillitem=nil;
_UIObject_release(self.autoFindCountAni);self.autoFindCountAni=nil;
_UIObject_release(self.autoFindingBtn);self.autoFindingBtn=nil;
_UIObject_release(self.autoFindingBtnTxt);self.autoFindingBtnTxt=nil;
_UIObject_release(self.autoFindRoot);self.autoFindRoot=nil;
_UIObject_release(self.autoStartFindBtn);self.autoStartFindBtn=nil;
_UIObject_release(self.barModel);self.barModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.costvalue);self.costvalue=nil;
_UIObject_release(self.findBtn);self.findBtn=nil;
_UIObject_release(self.findBtnTxt);self.findBtnTxt=nil;
_UIObject_release(self.findMask);self.findMask=nil;
_UIObject_release(self.freeFindBtn);self.freeFindBtn=nil;
_UIObject_release(self.giveupBtn);self.giveupBtn=nil;
_UIObject_release(self.heidong);self.heidong=nil;
_UIObject_release(self.hiddenPreviewBtn);self.hiddenPreviewBtn=nil;
_UIObject_release(self.hiddenSkill_0);self.hiddenSkill_0=nil;
_UIObject_release(self.hiddenSkill_1);self.hiddenSkill_1=nil;
_UIObject_release(self.hiddenSkill_2);self.hiddenSkill_2=nil;
_UIObject_release(self.hiddenSkill_3);self.hiddenSkill_3=nil;
_UIObject_release(self.hiddenSkill_4);self.hiddenSkill_4=nil;
_UIObject_release(self.hiddenSkill_5);self.hiddenSkill_5=nil;
_UIObject_release(self.hiddenSkillList);self.hiddenSkillList=nil;
_UIObject_release(self.hiddenSkillRecordItem_1);self.hiddenSkillRecordItem_1=nil;
_UIObject_release(self.hiddenSkillRecordItem_2);self.hiddenSkillRecordItem_2=nil;
_UIObject_release(self.hiddenSkillRecordItem_3);self.hiddenSkillRecordItem_3=nil;
_UIObject_release(self.hiddenSkillRoot);self.hiddenSkillRoot=nil;
_UIObject_release(self.itemlist);self.itemlist=nil;
_UIObject_release(self.lbroot);self.lbroot=nil;
_UIObject_release(self.lefteffect);self.lefteffect=nil;
_UIObject_release(self.mibaofuroot);self.mibaofuroot=nil;
_UIObject_release(self.mibaofuSelectPanel);self.mibaofuSelectPanel=nil;
_UIObject_release(self.mibaofuSelectPanelMask);self.mibaofuSelectPanelMask=nil;
_UIObject_release(self.mzbkBtn);self.mzbkBtn=nil;
_UIObject_release(self.mzbkCount);self.mzbkCount=nil;
_UIObject_release(self.mzbkRoot);self.mzbkRoot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.quickBgModel);self.quickBgModel=nil;
_UIObject_release(self.quickFindProgressRoot);self.quickFindProgressRoot=nil;
_UIObject_release(self.remainingTimesRoot);self.remainingTimesRoot=nil;
_UIObject_release(self.remainingTimesTxt);self.remainingTimesTxt=nil;
_UIObject_release(self.righteffect);self.righteffect=nil;
_UIObject_release(self.rightroot);self.rightroot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rtip);self.rtip=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.selectBtn2);self.selectBtn2=nil;
_UIObject_release(self.showActiveHoardBtn);self.showActiveHoardBtn=nil;
_UIObject_release(self.showActiveHoardBtnEffect);self.showActiveHoardBtnEffect=nil;
_UIObject_release(self.showActiveHoardIcon);self.showActiveHoardIcon=nil;
_UIObject_release(self.showActiveHoardInfo);self.showActiveHoardInfo=nil;
_UIObject_release(self.showActiveRoot);self.showActiveRoot=nil;
_UIObject_release(self.showInfoBtn);self.showInfoBtn=nil;
_UIObject_release(self.spCostDirection);self.spCostDirection=nil;
_UIObject_release(self.stopAutoFindBtn);self.stopAutoFindBtn=nil;
_UIObject_release(self.tequanBtn);self.tequanBtn=nil;
_UIObject_release(self.tequanRoot);self.tequanRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.typeList);self.typeList=nil;
_UIObject_release(self.wordModel);self.wordModel=nil;
self.hiddenSkill=nil;
self.hiddenSkillRecordItem=nil;
end
















local _this

local hiddenListPosY=-220.202


local hiddenListPosList={
[1]={377.3419,196},
[2]={747.272,565.93},
[3]={562.3069,935.86}
}

local lockType={
changeHorad=1,
lockBtn=2
}

local findCd=1.5

local _barModelSPosX=-170
local _barModelEPosX=335
local _barModelPosY=-35



function UIDiscipleLinggen_HiddenSkillSelectWin:onLoaded(...)
self:bindComponents()

_this=self

local wb=self.mibaofuroot:getWidgetBase()
wb:SetBaseItemClickEvent(-1,function()
self:activeUseItemPanel()
end)

self.randHoardRecordItems={}
for index,obj in ipairs(self.hiddenSkillRecordItem)do
self.randHoardRecordItems[index]=obj:getWidgetBase()
end

self.isShowActiveHoardItem=true
self.selectTw={}
self.selectIndex=1

self.lockBtn=false
UIManager:showWindow("UITopMaskWin")

local _on_system_open=function(sysId)
if sysId==SYSTEM_DEFINE.eMiZangBaoKu then
_this:initRefreshTeQuan()
end
end
self:addNotify(notifyConfig.on_system_open,_on_system_open)

self:addNotify(notifyConfig.onDiscipleLingGenRandomBoard,function(...)self:onDiscipleLingGenRandomBoard(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenEquipBoard,function(...)self:onDiscipleLingGenEquipBoard(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenGiveUpBoard,function(...)self:onDiscipleLingGenGiveUpBoard(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenQuickFind,function(...)self:onDiscipleLingGenQuickFind(...)end)

self:addNotify(notifyConfig.onDisciplePushMCToBK,function(...)self:onDiscipleLingGenGiveUpBoard(...)end)

local _recv_2_204=function()
_this:refresh()
end
self:addProNotify(2,204,_recv_2_204)

local _recv_2_200=function(discipleGuid)
if mathHelper.compareInt64(_this.disciple_guid,discipleGuid)then
_this:refresh()
end
end
self:addProNotify(2,200,_recv_2_200)

local _recv_2_201=function(discipleGuid)
if mathHelper.compareInt64(_this.disciple_guid,discipleGuid)then
_this:refreshMZBK()
end
end
self:addProNotify(2,201,_recv_2_201)

local _recv_2_203=function(discipleGuid)
if mathHelper.compareInt64(_this.disciple_guid,discipleGuid)then
_this:refresh()
end
end
self:addProNotify(2,203,_recv_2_203)
end


function UIDiscipleLinggen_HiddenSkillSelectWin:__delete()

for k,v in pairs(self.selectTw)do
if v then
v:Kill()
end
end
self.selectTw={}
if not(UIManager:isActive("UIDiscipleLinggen_StrengthenLinggenWin")or UIManager:isActive("UIDiscipleLinggen_variationLinggenWin"))then
UIManager:closeWindow("UITopMaskWin")
end

self:clearRemainingTimesFmTweener()

self:clearAutoFindCountAniFmTweener()

self:unbindComponents()
end




function UIDiscipleLinggen_HiddenSkillSelectWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.quickBgModel:setChildUIModelShowTarget(6166,1,nil,eAnimationID.stand)
self.wordModel:setChildUIModelShowTarget(6165,1,nil,eAnimationID.stand)
self.barModel:setChildUIModelShowTarget(6164,1,nil,eAnimationID.stand)
self.quickFindProgressRoot:setActive(false)
end

self.disciple_guid=argtable.disciple_guid
self.boardPosData=argtable.boardPosData or{}
self.closeCallBack=argtable.closeCallBack

self:refresh()
self:refreshOther()

if mzbkModel:getOneTimeReddot()then
self:onTequanBtn()
end

self:showWindow("UITopMoneyWin2",{moneys={{63,},{12187}}})
end


function UIDiscipleLinggen_HiddenSkillSelectWin:onHide()
self:hideWindow("UITopMoneyWin2")
end

function UIDiscipleLinggen_HiddenSkillSelectWin:initData()
self.randlist,self.randpos,self.randlistlen=UIDiscipleModel:getDiscipleRandomHoard(self.disciple_guid)
self.tempRandList=self.boardPosData.pos==self.randpos and table.deepCopy(self.randlist)or{}
self.activeList=self.boardPosData.activeList or{}
self.lglist,self.lglist_lookup,self.lglist_len=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.lgBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)

self.varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)

self.typeDatalist=UIDiscipleModel:getPreViewHoardList(self.disciple_guid,false,self.boardPosData.pos<0)

self:initRefreshTeQuan()
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refresh()
self:initData()
self:changeHiddenPos()
self:refreshSearchPart()

self:refreshActiveRecordItem()
self:refreshActivePart()
self:refreshBottonPart()
self:refreshItemSlot()
self:refreshHiddenSkillPart()
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshSelf(argtable)
self.disciple_guid=argtable.disciple_guid
self.boardPosData=argtable.boardPosData or{}



self:initData()
self:refreshSearchPart()
self:refreshActiveRecordItem()
self:refreshActivePart()
self:refreshBottonPart()
self:refreshItemSlot()
self:refreshHiddenSkillPart()
self:refreshMZBK()


self:refreshOther()

if self.isShowActiveHoardItem then
if self.boardPosData.activelistlen>0 and self.randpos==self.boardPosData.pos and self.randlistlen>0 then
self:playShowActiveAnimation(true)
end
self:changeHiddenPos()
end

end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshOther()
local title=self.boardPosData.activelistlen>0 and"洗练秘藏"or"激活秘藏"
self.title:setText(title)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshSearchPart()


self.hiddenSkillRecordItem_1:setActive(#self.tempRandList>0)
self.hiddenSkillRecordItem_2:setActive(#self.tempRandList>0)

if self.boardPosData.activelistlen>0 then
local item=self.hiddenSkillRecordItem[3]
self:freshSingleHoardCard(3,item:getWidgetBase(),self.boardPosData.activeList[1],false)
end

if self.randlistlen>0 and self.boardPosData.pos==self.randpos then
for i=1,self.randlistlen do
local item=self.hiddenSkillRecordItem[i]
self:freshSingleHoardCard(i,item:getWidgetBase(),self.randlist[i],self.selectIndex==i)
end
end
end


local CmpHoardRecordItemIndex={
root=0,
name=1,
icon=2,
typeicon=3,
attrs=4,
desc=5,
activebtn=6,
changebtn=7,
skilleffectBtn=8,
select=9,
quality=10,
standEffect=11,
expondEffect=12,
equiped=13,
dissolveQuality=14,
dissolveEffect=15,
shadow=16,
descSV=17,
pushBtn=18,
}

local standEffect={[4]=10402,[5]=10401,[6]=10400}
function UIDiscipleLinggen_HiddenSkillSelectWin:freshSingleHoardCard(pos,item,data,isSelect)
if data==nil then return end

local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
local desc=UIDiscipleModel:getDiscipleHoardDesc(data)
local skillIconName=iconHelper.getSkillIcon(boardCfg.icon)

local typeIconName,ab=ELEMENT_TYPE.getVaryIcon(boardCfg.element)
item:SetChildWidgetMaterialFloat(CmpHoardRecordItemIndex.quality,'_DissovleProgress',0)


item:SetChildText(CmpHoardRecordItemIndex.name,boardCfg.name)
item:SetChildIcon(CmpHoardRecordItemIndex.icon,skillIconName,false)
item:SetChildCSImageSprite(CmpHoardRecordItemIndex.typeicon,ab,typeIconName)
item:SetChildLayoutGroupCreateItems(CmpHoardRecordItemIndex.attrs,data.len1,function(index)
local aitem=item:GetChildLayoutGroupGridItem(4,index-1)
local data=data.list1[index]
aitem:SetChildActive(-1,data~=nil)
if data then
local str=helper.getAttributeStr(data.param_1,data.param_2,nil,"{0}+{1}")
aitem:SetChildText(1,str)
end
end)
item:SetChildText(CmpHoardRecordItemIndex.desc,desc)

item:SetChildActive(CmpHoardRecordItemIndex.activebtn,self.boardPosData.activelistlen==0)
item:SetChildActive(CmpHoardRecordItemIndex.changebtn,self.boardPosData.activelistlen>0)

item:SetChildActive(CmpHoardRecordItemIndex.activebtn,false)
item:SetChildActive(CmpHoardRecordItemIndex.changebtn,false)

item:SetChildActive(CmpHoardRecordItemIndex.select,isSelect)
item:SetChildActive(CmpHoardRecordItemIndex.equiped,pos==3)

local qulaityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(boardCfg.color)
item:SetChildCSImageSprite(CmpHoardRecordItemIndex.quality,qab,qulaityName)


local effectName=standEffect[boardCfg.color]
item:SetChildActive(CmpHoardRecordItemIndex.standEffect,effectName~=nil)
if effectName~=nil then
item:SetChildShowEffect(CmpHoardRecordItemIndex.standEffect,effectName,true)
end

item:SetChildShowEffect(CmpHoardRecordItemIndex.expondEffect,0,false)

item:SetChildActive(CmpHoardRecordItemIndex.skilleffectBtn,boardCfg.additionskillid~=nil)
item:SetChildButtonClick(CmpHoardRecordItemIndex.skilleffectBtn,function()
local hiddenCfg=boardCfg
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})
if skillid and gfUpValue then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
skillid=skillid,
addSkillLv=gfUpValue,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true
})
elseif hiddenCfg.skillid then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true
})
end
end)


item:SetBaseItemClickEvent(-1,function()
if pos==_this.selectIndex then return end
if pos>0 and pos~=3 then
local hasEquip=self.boardPosData.activelistlen>0

local preItem=_this.hiddenSkillRecordItem[self.selectIndex]:getWidgetBase()
preItem:SetChildActive(CmpHoardRecordItemIndex.select,false)
preItem:SetChildActive(CmpHoardRecordItemIndex.pushBtn,false)

_this.selectIndex=pos
item:SetChildActive(CmpHoardRecordItemIndex.select,true)
item:SetChildActive(CmpHoardRecordItemIndex.pushBtn,_this.isShowMZBK and hasEquip)
end
end)

local isRankItem=pos~=3
local isOpen=self.isShowMZBK
local isHas=self.boardPosData.activelistlen and self.boardPosData.activelistlen>0 or false
local isSelectShowPush=self.selectIndex==pos
local isShowPushBtn=isOpen and isRankItem and isHas
item:SetChildActive(CmpHoardRecordItemIndex.pushBtn,isShowPushBtn and isSelectShowPush)
if not isShowPushBtn then return end
item:SetChildButtonClick(CmpHoardRecordItemIndex.pushBtn,function()
mzbkController.checkSaveRankMC(_this.disciple_guid,_this,_this.boardPosData.pos,pos)
end,true)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshEquipPart()
local isEquiped=self.boardPosData.activelistlen>0
self.hiddenSkillRecordItem:setActive(isEquiped)
self.rtip:setActive(not isEquiped)
if isEquiped then

local data=self.activeList[1]
local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,boardCfg.skillid)
local skillDesc=skillModel:getSkillDescEx(boardCfg.skillid,data.skilllv)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
local typeIconName=ELEMENT_TYPE.getIcon(boardCfg.element)

local item=self.hiddenSkillRecordItem:getWidgetBase()
item:SetChildText(0,boardCfg.name)
item:SetChildIcon(1,skillIconName,false)

item:SetChildLayoutGroupCreateItems(3,data.len1,function(index)
local aitem=item:GetChildLayoutGroupGridItem(3,index-1)
local data=data.list1[index]
aitem:SetChildActive(-1,data~=nil)
if data then
local attrName=helper.getAttributeName(data.param_1)
aitem:SetChildText(1,FMT.fmt("{0}+{1}",attrName,data.param_2))
end
end)
item:SetChildText(4,skillDesc)
else

end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshBottonPart()

self.typeList:setChildLayoutGroupCreateItems(#self.typeDatalist,function(index)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
local typedata=self.typeDatalist[index]
local type=typedata.type

item:SetChildActive(-1,type~=nil)
if type then
local element=typedata.type
if typedata.showVary==1 then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local cfg=UIDiscipleModel:getSpecialityConfigEx(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,self.lglist_lookup[typedata.type].source)
element=cfg.element
end
local typeIconName,ab=ELEMENT_TYPE.getVaryIcon({element})
item:SetChildCSImageSprite(0,ab,typeIconName)
end
end)

local isNotInAutoPos=self.autoFindPos and self.autoFindPos~=self.boardPosData.pos


local isFree=UIDiscipleModel:checkDiscipleHoardFree(self.disciple_guid,self.boardPosData.pos,true)

self.findBtn:setActive(not isFree)
self.freeFindBtn:setActive(isFree)
self.selectBtn:setActive(self.randpos==self.boardPosData.pos and(not self.isInAutoFind or isNotInAutoPos))
self.giveupBtn:setActive(self.randpos==self.boardPosData.pos and(not self.isInAutoFind or isNotInAutoPos))
self.costicon:setActive(not isFree)
local findBtnTxt=(self.randlistlen>0 and self.boardPosData.pos==self.randpos)and'再次搜寻'or'搜寻秘藏'
self.findBtnTxt:setText(findBtnTxt)
if not isFree then


local searchCost=self.lgBaseCfg.search

local isVary=self.boardPosData.pos<0
if isVary then
searchCost=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'varysearch')
end

local costItemId=searchCost[1][1]
local costItemNeedNum=searchCost[1][2]
local hasCostItemNum=itemsModel.getCount(costItemId)
local costItemIconName=itemsModel.getItemIconName(costItemId)
local discount=mzbkModel:getTeQuanFindMoneyDiscount(isVary)
costItemNeedNum=mathHelper.safe_ceil(costItemNeedNum*discount)
local fontColor=hasCostItemNum>=costItemNeedNum and FONT_COLOR.eGrayWhiteTxtColor or FONT_COLOR.eRedColor
local costValueStr
if self.boardPosData.pos<0 then
costValueStr=FMT.fmt("{0}/{1}",costItemNeedNum,hasCostItemNum)
else
costValueStr=toColorString(fontColor,costItemNeedNum)
end
self.costicon:setChildIcon(costItemIconName,false)
self.costvalue:setText(costValueStr)
else
self.costvalue:setText("初次免费")
end

local isOpenAutoFind=UIDiscipleModel:checkDiscipleCanAutoFindHiddenSkill(self.disciple_guid)
local isShowAutoFindRoot=isOpenAutoFind and(self.isInAutoFind or self.autoFindPause)and(not isNotInAutoPos)and not isFree

self.autoStartFindBtn:setActive(isOpenAutoFind and self:checkIsCanShowAutoStartFindBtn()and not isFree)
self.autoFindRoot:setActive(isShowAutoFindRoot)
if isShowAutoFindRoot then
self.findBtn:setActive(not self.isInAutoFind)
self.selectBtn2:setActive(self.autoFindPause and self.randlistlen>0)
self.stopAutoFindBtn:setActive(self.autoFindPause or self.randlistlen>0)
if self.isInAutoFind and isOpenAutoFind then
self.remainingTimesTxt:setText(FMT.fmt("剩余次数：{0}",self.autoCount))
self.autoFindingBtnTxt:setText("自动搜寻中")
end

if self.autoFindPause or self.randlistlen>0 then
self.autoFindingBtnTxt:setText("自动搜寻")
end
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshItemSlot()
local list=UIDiscipleModel:getUseItemList(self.disciple_guid,self.boardPosData.pos)
local hasItem=#list>0
local isFree=UIDiscipleModel:checkDiscipleHoardFree(self.disciple_guid,self.boardPosData.pos,true)

self.mibaofuroot:setActive(hasItem and not isFree and self.boardPosData.pos>0 and(self.useItemData~=nil or(not self.isInAutoFind)))
local wb=self.mibaofuroot:getWidgetBase()
wb:SetChildActive(0,self.useItemData==nil)
wb:SetChildActive(1,self.useItemData~=nil)
wb:SetChildActive(2,self.useItemData~=nil)
wb:SetChildActive(5,self.useItemData~=nil)
if#list>0 then
if self.useItemData then

local itemCfg=itemsConfig.getConfig(self.useItemData.itemid)
local desc=itemCfg.funcparam and itemCfg.funcparam.desc or''
wb:SetChildText(3,desc)
local itemIconName=itemsModel.getItemIconName(self.useItemData.itemid)
wb:SetChildIcon(1,itemIconName,false)

local count=itemsModel.getCount(self.useItemData.itemid)
local isShow=count>1
wb:SetChildActive(4,isShow)
if isShow then
wb:SetChildText(4,FMT.fmt("剩余数量：{0}",count))
end
wb:SetChildButtonClick(5,function()
if not _this then return end
_this:onCancelMiBaoFu()
end,true)
else
wb:SetChildActive(4,false)
end
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshActiveRecordItem()
if self.boardPosData.activelistlen>0 then
local activeData=self.boardPosData.activeList[1]
local item=self.hiddenSkillRecordItem_3:getWidgetBase()
self:freshSingleHoardCard(3,item,activeData,false)
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshActivePart()
local state=self.isShowActiveHoardItem
local isShow=self.boardPosData.activelistlen>0
self.showActiveRoot:setActive(isShow)
self.hiddenSkillRecordItem_3:setChildCanvasGroupAlpha(state and 1 or 0)
self.hiddenSkillRecordItem_3:setActive(state and isShow)
if self.boardPosData.activelistlen>0 then
local activeData=self.boardPosData.activeList[1]
self.showActiveHoardBtnEffect:setChildShowEffect(10412,true)
self.showActiveHoardInfo:setText(state and'收起秘藏'or'展示秘藏')

local color=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,activeData.hoardid,'color')
local iconName=FMT.fmt('image_linggen_micangxiao{0}',color)
self.showActiveHoardIcon:setCSImageSprite(globalABLookup.varylinggensprite,iconName)
self.showActiveHoardIcon:setActive(not state)
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:activeUseItemPanel()
local args={
disciple_guid=self.disciple_guid,
boardPosData=self.boardPosData,
parentWin=self,
useItemData=self.useItemData,
}
self:showWindow("UIDiscipleLinggen_SelectMiBaoFuSelectWin",args)
end


function UIDiscipleLinggen_HiddenSkillSelectWin:refreshHiddenSkillPart()
local hoardDatas=UIDiscipleModel:getDiscipleHoard(self.disciple_guid)
local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
local isAssertVary=UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
for k,hiddenSkillItem in pairs(self.hiddenSkill)do
local widgetbase=hiddenSkillItem:getWidgetBase()
local data
local islock

if k==0 then
varySrid=varySrid==0 and 1 or varySrid
data=hoardDatas[-varySrid]
local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
islock=varySrid~=0 and isAssertVary
else
data=hoardDatas[k]
islock=UIDiscipleModel:checkHoardLockState(self.disciple_guid,k)
end
local isEquiped=data.activelistlen>0

if self.boardPosData.pos==data.pos then
self.selectHiddenSkillIndex=k
end

widgetbase:SetChildActive(0,islock and(not isEquiped))
widgetbase:SetChildActive(1,isEquiped)
widgetbase:SetChildActive(2,self.boardPosData.pos==data.pos)
widgetbase:SetChildActive(3,not islock)
if data.activelistlen>0 and islock then
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.activeList[1].hoardid)
local skillIconName
skillIconName=iconHelper.getSkillIcon(hoardCfg.icon)
widgetbase:SetChildIcon(1,skillIconName,false)
end

widgetbase:SetBaseItemClickEvent(-1,function()
if islock then
if self.selectHiddenSkillIndex~=k then
if not self.lockBtn then

self.useItemData=nil
self:refreshSelf({
disciple_guid=self.disciple_guid,
boardPosData=data
})

local preitem=self.hiddenSkill[self.selectHiddenSkillIndex]
local preWidgetBase=preitem:getWidgetBase()
preWidgetBase:SetChildActive(2,false)

widgetbase:SetChildActive(2,true)
else
if self.lockTipInfo then
UIManager.info(self.lockTipInfo)
end
end
end
else
if k==0 then
UIManager.info('灵根变异解锁')
else
UIManager.info('秘藏未解锁')
end
end
end)
end
end


function UIDiscipleLinggen_HiddenSkillSelectWin:onDiscipleLingGenRandomBoard(dz_guid,pos)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)and self.boardPosData.pos==pos then
self.lockBtn=false
self.selectIndex=1
if self.useItemData then
local count=itemsModel.getCount(self.useItemData.itemid)
if count<=0 then
local itemId=self.useItemData.itemid
local itemName=itemsConfig.getItemName(itemId)
self.useItemData=nil
UIManager.info(FMT.fmt("{0}已消耗完毕",itemName))
end
end

self.mibaofuroot:setActive(false)

local func=function()
_this:initData()
_this:playFindAnimation()
_this:refreshSearchPart()
_this:refreshBottonPart()
_this:refreshItemSlot()
_this:changeHiddenPos()
_this:refreshActiveRecordItem()
end

if self.boardPosData.activelistlen>0 and self.isShowActiveHoardItem then
self.randHoardRecordItems[1]:SetChildActive(CmpHoardRecordItemIndex.pushBtn,false)
self.randHoardRecordItems[2]:SetChildActive(CmpHoardRecordItemIndex.pushBtn,false)
self:playShowActiveAnimation(false,func)
else
func()
end
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onDiscipleLingGenEquipBoard(dz_guid,pos,data)
if self.disciple_guid==dz_guid and self.boardPosData.pos==pos then

local func=function()
self.boardPosData=data
self.isShowActiveHoardItem=true
self:refresh()
self.lockBtn=false
end

local ablation_item=self.selectIndex==1 and self.hiddenSkillRecordItem_2 or self.hiddenSkillRecordItem_1
local ablation_data=self.selectIndex==1 and self.randlist[2]or self.randlist[1]
local index=self.selectIndex==1 and 2 or 1

AudioManager.playAudio(637)
self:playSelectHoardAnimation(index,ablation_item,ablation_data,func)

if self.isShowActiveHoardItem and self.boardPosData.activelistlen>0 then
self:playSelectHoardAnimation(3,self.hiddenSkillRecordItem_3,self.boardPosData.activeList[1],nil)
end

self:initData()

self:refreshBottonPart()
else
self:initData()
self:changeHiddenPos()
self:refreshBottonPart()
self:refreshSearchPart()
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onDiscipleLingGenGiveUpBoard(dz_guid)
local func=function()

self.lockBtn=false

self:initData()

self:refreshSearchPart()
self:refreshActiveRecordItem()
self:refreshActivePart()
self:refreshBottonPart()
self:refreshHiddenSkillPart()
self:refreshMZBK()
if self.isFind then
self.isFind=false
local isFree=UIDiscipleModel:checkDiscipleHoardFree(self.disciple_guid,self.boardPosData.pos,true)
if isFree then
self:onFreeFindBtn()
else
self:onFindBtn()
end
else
self:changeHiddenPos()
if self.waitAutoFind then
self.waitAutoFind=false
self:waitAutoFindCallBack()
end
end
end
if mathHelper.compareInt64(dz_guid,self.disciple_guid)and self.randpos==self.boardPosData.pos then

AudioManager.playAudio(636)
self.randHoardRecordItems[1]:SetChildActive(CmpHoardRecordItemIndex.pushBtn,false)
self.randHoardRecordItems[2]:SetChildActive(CmpHoardRecordItemIndex.pushBtn,false)
self:playSelectHoardAnimation(1,self.hiddenSkillRecordItem_1,self.randlist[1],nil)
self:playSelectHoardAnimation(2,self.hiddenSkillRecordItem_2,self.randlist[2],func)
self:initData()
self:refreshBottonPart()
else
func()
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onDiscipleLingGenQuickFind(discipleguid,pos,times)
if not mathHelper.compareInt64(discipleguid,self.disciple_guid)then return end
if self.boardPosData.pos~=pos then return end

if self.useItemData then
local itemCount=itemsModel.getCount(self.useItemData.itemid)
if itemCount<=0 then
self.useItemData=nil
end
end
self.mibaofuroot:setActive(false)

local oldAutoCount=self.autoCount
self.autoCount=self.autoCount-times

self:finishQuickFindProgress(oldAutoCount,times)
end


















































function UIDiscipleLinggen_HiddenSkillSelectWin:checkCanFind()
if not self.findCdStamp then
self.findCdStamp=timeHelper.getServerShortTime()
return true
end

local curTime=timeHelper.getServerShortTime()
if curTime-self.findCdStamp>=findCd then
return true
end

return false
end

function UIDiscipleLinggen_HiddenSkillSelectWin:setUseItemData(itemData)
self.useItemData=itemData
self:refreshItemSlot()
end





function UIDiscipleLinggen_HiddenSkillSelectWin:onFindBtn()

if not self:checkCanFind()then
UIManager.error('搜寻冷却中')
return
end

local searchCost=self.lgBaseCfg.search


local isVary=self.boardPosData.pos<0
if isVary then
searchCost=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'varysearch')
end

local costItemId=searchCost[1][1]
local costItemNeedNum=searchCost[1][2]
local hasCostItemNum=itemsModel.getCount(costItemId)

local discount=mzbkModel:getTeQuanFindMoneyDiscount(isVary)

costItemNeedNum=mathHelper.safe_ceil(costItemNeedNum*discount)

if hasCostItemNum>=costItemNeedNum then
self:doFind(0)
else
gainControl:showCommonGainWin_item(costItemId)
end
end



function UIDiscipleLinggen_HiddenSkillSelectWin:onHiddenPreviewBtn()
self:showWindow("UIDiscipleLinggen_HiddenSkillSelectQualityWin",{
disciple_guid=self.disciple_guid,
typeDatalist=self.typeDatalist,
isShowVary=self.boardPosData.pos<0,
})
end



function UIDiscipleLinggen_HiddenSkillSelectWin:onCloseBtn()
if self.closeCallBack then
self.closeCallBack()
end
self:closeSelf()
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onFreeFindBtn()
self:doFind(1)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onSelectBtn()
if self.lockBtn then
UIManager.info(self.lockTipInfo)
return
end

local selectData=self.tempRandList[self.selectIndex]

local selectFunc=function()
if not self.lockBtn then
self.lockBtn=true
self.lockTipInfo='正在装备秘藏，请稍等'
UIDiscipleController:do_send_2_136(self.disciple_guid,self.boardPosData.pos,self.selectIndex)
end
end

if self:checkSelect()then
if self.boardPosData.activelistlen>0 then
local activeData=self.boardPosData.activeList[1]
local selectDataQuality=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,selectData.hoardid,'color')
local activeDataQuality=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,activeData.hoardid,'color')

if activeDataQuality>selectDataQuality then
local show_data={
type='UIDialouge',
title='提示',
content='所选秘藏品质较低，是否更换？',
oktext='确定',
canceltext='取消',
okcallback=function()
selectFunc()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
selectFunc()
end
else
selectFunc()
end
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onShowActiveHoardBtn(callback)
if not self.lockBtn then
self.isShowActiveHoardItem=not self.isShowActiveHoardItem


self:playShowActiveAnimation(self.isShowActiveHoardItem,function()
self:changeHiddenPos()
self:refreshActivePart()
if self.showActiveHoardIconTw then
self.showActiveHoardIconTw:Kill()
self.showActiveHoardIconTw=nil
end

local endValue=self.isShowActiveHoardItem and 0 or 1
self.showActiveHoardIconTw=self.showActiveHoardIcon:setChildCanvasGroupDOFade(endValue,0.2)

if callback then
callback()
end
end)
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onShowInfoBtn()
local d={}
d.title='提示'
d.mode=3
d.name='linggen_findHoard_rule_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onGiveupBtn()
if self.lockBtn then
UIManager.info(self.lockTipInfo)
return
end

local content

local isFill=self.boardPosData.activelistlen==0
if isFill then
content='尚未选择秘藏,是否放弃？'
end

local choosetext
local choosecallback

local tips3=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips3)
if content==nil and tips3~=true then
for k,v in pairs(self.randlist)do
local color=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,v.hoardid,'color')
if color==4 then
content='秘藏列表中有橙色品质的秘藏，是否放弃？'
choosetext="今日不再提示"
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips3,flag)
end
break
end
end
end

local tips4=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips4)
if content==nil and tips4~=true then
for k,v in pairs(self.randlist)do
local color=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,v.hoardid,'color')
if color==5 then
content='秘藏列表中有红色品质的秘藏，是否放弃？'
choosetext="今日不再提示"
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips4,flag)
end
break
end
end
end



if content~=nil then
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='放弃',
canceltext='取消',
okcallback=function()
self.lockBtn=true
self.lockTipInfo='秘藏消散中，请稍后'
UIDiscipleController:do_send_2_137(_this.disciple_guid)
end,
choosetext=choosetext,
choosecallback=choosecallback
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self.lockBtn=true
self.lockTipInfo='秘藏消散中，请稍后'
UIDiscipleController:do_send_2_137(_this.disciple_guid)
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:doFind(type)
if self.lockBtn then
UIManager.info(self.lockTipInfo)
return
end

local okCallBack=function()
_this:stopQuickFind()
_this:doFind(type)
end
if not self:checkInOtherHoldAutoFind(okCallBack)then
return
end

local state,dialogdata=self:checkFind(type)
if state then
if not self.lockBtn then
self.lockBtn=true
self.lockTipInfo='正在搜寻秘藏，请稍等'
self.findCdStamp=timeHelper.getServerShortTime()
UIDiscipleController:do_send_2_135(self.disciple_guid,self.boardPosData.pos,type,1,self.useItemData and self.useItemData.itemid or 0)
end
else
local show_data={
type='UIDialouge',
title='提示',
content=dialogdata.content,
oktext=dialogdata.oktext or'确定',
canceltext=dialogdata.canceltext or'取消',
okcallback=dialogdata.okcallback,
cancelcallback=dialogdata.cancelcallback,
choosetext=dialogdata.choosetext,
choosecallback=dialogdata.choosecallback
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:checkFind(type)
if self.randpos~=self.boardPosData.pos and self.randlistlen>0 then
local pos=self.randpos>0 and FMT.fmt("{0}号",self.randpos)or"变异"
return false,{
content=FMT.fmt('{0}秘藏栏有秘藏尚未选择，是否放弃并搜寻秘藏？',pos),
okcallback=function()
if self.isInAutoFind then
self:stopQuickFind()
end
UIDiscipleController:do_send_2_137(_this.disciple_guid)
self.isFind=true
end,
cancelcallback=function()

end,
oktext="放弃",
}
end


if self.boardPosData.activelistlen==0 and self.randpos==self.boardPosData.pos and self.randlistlen>0 then
return false,{
content='尚未选择秘藏,是否放弃？',
okcallback=function()
UIDiscipleController:do_send_2_137(_this.disciple_guid)
self.isFind=true
end,
cancelcallback=function()

end,
oktext="放弃",




}
end


local isShowQualityTip=false
local color=0
if self.randlistlen>0 then
for k,hoardData in pairs(self.randlist)do
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,hoardData.hoardid)
isShowQualityTip=hoardCfg.color>3
if isShowQualityTip then
color=hoardCfg.color>color and hoardCfg.color or color
break
end
end
end

local tips6=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips6)
if tips6~=true then
local totallv=UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)

if totallv<100 then
local content="灵根总等级不足100级，无法搜寻到红色秘藏，是否继续搜寻？"
return false,{
content=content,
okcallback=function()
self.lockBtn=true
self.lockTipInfo='正在搜寻秘藏，请稍等'
UIDiscipleController:do_send_2_135(self.disciple_guid,self.boardPosData.pos,type,1,self.useItemData and self.useItemData.itemid or 0)
end,
cancelcallback=function()

end,
oktext="确定",
choosetext="今日不再提示",
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips6,flag)
end
}
end
end

local tips2=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips2)
if color==4 and tips2~=true then
if isShowQualityTip then
if self.randpos==self.boardPosData.pos and self.randlistlen>0 then
local content=FMT.fmt('秘藏列表中有{0}色秘藏，是否放弃并继续\n搜寻？','橙')
return false,{
content=content,
okcallback=function()
UIDiscipleController:do_send_2_137(_this.disciple_guid)
self.lockBtn=true
self.isFind=true
self.lockTipInfo='放弃秘藏中，请稍等'
end,
cancelcallback=function()

end,
oktext="放弃",
choosetext="今日不再提示",
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips2,flag)
end
}
end
end
end

local tips5=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips5)
if color==5 and tips5~=true then
if isShowQualityTip then
if self.randpos==self.boardPosData.pos and self.randlistlen>0 then
local content=FMT.fmt('秘藏列表中有{0}色秘藏，是否放弃并继续\n搜寻？','红')
return false,{
content=content,
okcallback=function()
UIDiscipleController:do_send_2_137(_this.disciple_guid)
self.lockBtn=true
self.isFind=true
self.lockTipInfo='放弃秘藏中，请稍等'
end,
cancelcallback=function()

end,
oktext="放弃",
choosetext="今日不再提示",
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangTips5,flag)
end
}
end
end
end

return true
end

function UIDiscipleLinggen_HiddenSkillSelectWin:checkSelect()
local hoardDatas=UIDiscipleModel:getDiscipleHoardTotal(self.disciple_guid)
local lookuplist={}
for k,v in pairs(hoardDatas)do
if v.activelistlen>0 then
local data=v.activeList[1]
local activeHoardGroup=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,data.hoardid,'group')
lookuplist[activeHoardGroup]=v
end
end
if self.randlistlen>0 then
local selectData=self.randlist[self.selectIndex]
local selectHoardGroup=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,selectData.hoardid,'group')
if lookuplist[selectHoardGroup]and self.randpos~=lookuplist[selectHoardGroup].pos then

if UIDiscipleModel:checkHiddenSkillSlotUnlock(self.disciple_guid,lookuplist[selectHoardGroup].pos)then

self:showWindow('UIDiscipleLinggen_ChangeSelectHoardWin',{
disciple_guid=self.disciple_guid,
sourceData=selectData,
destData=lookuplist[selectHoardGroup],
idx=self.selectIndex,
})
else
local show_data={
type='UIDialouge',
title='提示',
content="被锁的秘藏栏中有相同的秘藏，是否放弃被锁秘藏？",
oktext='确定',
canceltext='取消',
okcallback=function()
UIDiscipleController:do_send_2_136(self.disciple_guid,self.boardPosData.pos,self.selectIndex,lookuplist[selectHoardGroup].pos)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

return false
end
end

if not mzbkController.checkMutexGroupEquipRankMC(self.disciple_guid,_this,self.randpos,self.selectIndex)then
return false
end

return true
end

local expondEffectList={[1]=10520,[2]=10520,[3]=10406,[4]=10405,[5]=10404,[6]=10403}
function UIDiscipleLinggen_HiddenSkillSelectWin:playFindAnimation()
self.heidong:setActive(true)
self.lefteffect:setActive(true)
self.righteffect:setActive(true)

AudioManager.playAudio(635)

local randlist=UIDiscipleModel:getDiscipleRandomHoard(self.disciple_guid)
local lefth=randlist[1]
local righth=randlist[2]
local leftColor=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,lefth.hoardid,'color')
local rightColor=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,righth.hoardid,'color')

local leftEffectId=leftColor>3 and 10408 or 10407
local rightEffectId=rightColor>3 and 10410 or 10409
local leftExpondEffectId=expondEffectList[leftColor]
local rightExpondEffectId=expondEffectList[rightColor]


self.lefteffect:setChildShowEffect(leftEffectId,true)
self.righteffect:setChildShowEffect(rightEffectId,true)

self.hiddenSkillRecordItem_1:setChildCanvasGroupAlpha(0)
self.hiddenSkillRecordItem_2:setChildCanvasGroupAlpha(0)

local leftItem=self.hiddenSkillRecordItem_1:getWidgetBase()
local rightItem=self.hiddenSkillRecordItem_2:getWidgetBase()

leftItem:SetChildActive(CmpHoardRecordItemIndex.pushBtn,false)
rightItem:SetChildActive(CmpHoardRecordItemIndex.pushBtn,false)

leftItem:SetChildActive(CmpHoardRecordItemIndex.standEffect,false)
rightItem:SetChildActive(CmpHoardRecordItemIndex.standEffect,false)
rightItem:SetChildActive(CmpHoardRecordItemIndex.expondEffect,true)
rightItem:SetChildActive(CmpHoardRecordItemIndex.expondEffect,true)
self.findMask:setActive(true)

if leftExpondEffectId~=nil then
leftItem:SetChildShowEffect(CmpHoardRecordItemIndex.expondEffect,leftExpondEffectId,false)
end
if rightExpondEffectId~=nil then
rightItem:SetChildShowEffect(CmpHoardRecordItemIndex.expondEffect,rightExpondEffectId,false)
end

self:delayDo(0.5,function()


if leftExpondEffectId~=nil then
leftItem:SetChildShowEffect(CmpHoardRecordItemIndex.expondEffect,leftExpondEffectId,true)
end
if rightExpondEffectId~=nil then
rightItem:SetChildShowEffect(CmpHoardRecordItemIndex.expondEffect,rightExpondEffectId,true)
end

self.lefteffect:setChildShowEffect(leftEffectId,false)
self.righteffect:setChildShowEffect(rightEffectId,false)

self:delayDo(0.1,function()

self.hiddenSkillRecordItem_1:setChildCanvasGroupDOFade(1,0.5,nil)
self.hiddenSkillRecordItem_2:setChildCanvasGroupDOFade(1,0.5,function()
self.findMask:setActive(false)
end)
if leftColor>3 then
leftItem:SetChildActive(CmpHoardRecordItemIndex.standEffect,true)
end
if rightColor>3 then
rightItem:SetChildActive(CmpHoardRecordItemIndex.standEffect,true)
end


self.lockBtn=false


if self.boardPosData.activelistlen>0 and self.isShowActiveHoardItem then
self:playShowActiveAnimation(true)
end
end)
end)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:changeHiddenPos()
local state=self.boardPosData.activelistlen>0 and self.isShowActiveHoardItem
if state then

self.hiddenSkillRecordItem_1:setChildAnchoredPosition(Vector3.New(hiddenListPosList[1][2],hiddenListPosY,0))
self.hiddenSkillRecordItem_2:setChildAnchoredPosition(Vector3.New(hiddenListPosList[2][2],hiddenListPosY,0))
else
self.hiddenSkillRecordItem_1:setChildAnchoredPosition(Vector3.New(hiddenListPosList[1][1],hiddenListPosY,0))
self.hiddenSkillRecordItem_2:setChildAnchoredPosition(Vector3.New(hiddenListPosList[2][1],hiddenListPosY,0))
end

if self.randpos==self.boardPosData.pos and self.randlistlen>0 then
self.hiddenSkillRecordItem_3:setChildAnchoredPosition(Vector3.New(hiddenListPosList[3][2],hiddenListPosY,0))
else

self.hiddenSkillRecordItem_3:setChildAnchoredPosition(Vector3.New(hiddenListPosList[3][1],hiddenListPosY,0))
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:playShowActiveAnimation(state,func)

local duration=0.3

if state then
self.hiddenSkillRecordItem_3:setActive(true)
self.hiddenSkillRecordItem_3:setChildCanvasGroupAlpha(0)
self.hiddenSkillRecordItem_3:setScale(Vector3.zero)

self.hiddenSkillRecordItem_1:setChildDOAnchorPosX(hiddenListPosList[1][2],duration,nil)
self.hiddenSkillRecordItem_2:setChildDOAnchorPosX(hiddenListPosList[2][2],duration,nil)

self.hiddenSkillRecordItem_3:setChildDOScale(1,duration,nil)
self.hiddenSkillRecordItem_3:setChildCanvasGroupDOFade(1,duration,function()
if func then
func()
end
end)
else



self.hiddenSkillRecordItem_1:setChildDOAnchorPosX(hiddenListPosList[1][1],duration,nil)
self.hiddenSkillRecordItem_2:setChildDOAnchorPosX(hiddenListPosList[2][1],duration,nil)

self.hiddenSkillRecordItem_3:setChildDOScale(0.1,duration,nil)
self.hiddenSkillRecordItem_3:setChildCanvasGroupDOFade(0,duration,function()
self.hiddenSkillRecordItem_3:setActive(false)
self.hiddenSkillRecordItem_3:setScale(Vector3(1,1,1))
if func then
func()
end
end)
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:playSelectHoardAnimation(index,ablation_item,ablation_data,func)
local ablation_widget=ablation_item:getWidgetBase()
local hoard_quality=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,ablation_data.hoardid,'color')
local ablation_effect_id=UIDiscipleModel:getHoardAblationEffectIdByQuality(hoard_quality)

local ablation_effect_duration=1

ablation_widget:SetChildShowEffect(CmpHoardRecordItemIndex.standEffect,0,false)
ablation_widget:SetChildActive(CmpHoardRecordItemIndex.select,false)
ablation_widget:SetChildWidgetMaterialFloat(CmpHoardRecordItemIndex.quality,'_DissovleProgress',0)
ablation_widget:SetChildCanvasGroupDOFade(CmpHoardRecordItemIndex.root,0,0.1,nil)
ablation_widget:SetChildShowEffect(CmpHoardRecordItemIndex.dissolveEffect,ablation_effect_id,true)

self.selectTw[index]=_DOTweenProxy.DoValueTo(
function()
return self.tweenerVal or 0
end,
function(val)
self.tweenerVal=val
ablation_widget:SetChildWidgetMaterialFloat(CmpHoardRecordItemIndex.quality,'_DissovleProgress',val)
end,
1,ablation_effect_duration)
local moveItem=self.hiddenSkillRecordItem[self.selectIndex]
local moveItemWb=moveItem:getWidgetBase()
moveItemWb:SetChildActive(CmpHoardRecordItemIndex.select,false)
moveItemWb:SetChildShowEffect(CmpHoardRecordItemIndex.standEffect,0,false)
self:delayDo(ablation_effect_duration-0.2,function()
moveItem:setChildDOAnchorPosX(hiddenListPosList[3][1],0.2,nil)
end)

self:delayDo(ablation_effect_duration+0.05,function()
self.tweenerVal=0
self.selectTw[index]:Kill()
self.selectTw[index]=nil
ablation_widget:SetChildShowEffect(CmpHoardRecordItemIndex.dissolveEffect,0,false)
if func then
func()
end
ablation_widget:SetChildCanvasGroupAlpha(CmpHoardRecordItemIndex.root,1)
ablation_widget:SetChildActive(CmpHoardRecordItemIndex.shadow,true)
end)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onCancelMiBaoFu()
if self.isInAutoFind then
local show_data={
type='UIDialouge',
title='提示',
content="是否退出自动搜寻？",
oktext='确定',
canceltext='取消',
okcallback=function()

self.useItemData=nil


self:refreshItemSlot()


self:stopQuickFind()
self:refresh()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
end



self.useItemData=nil

self:refreshItemSlot()
end



function UIDiscipleLinggen_HiddenSkillSelectWin:onAutoStartFindBtn()

local okCallBack=function()
self:stopQuickFind()
self:onAutoStartFindBtn()
end
if not self:checkInOtherHoldAutoFind(okCallBack)then
return
end

if not self:checkHasWaitSelectBoard()then
return
end

if not self.isInAutoFind and self.optionDataList~=nil and self.boardPosData.pos~=self.autoFindPos then
self.optionDataList=nil
self.colorList=nil
self.modeType=nil
self.autoCountRecord=nil
end

local isVary=self.selectHiddenSkillIndex==0
local modeType=isVary and 2 or 1

local optionDataList=self.optionDataList and table.weakCopy(self.optionDataList)or{}
local colorDataList=self.colorList and table.weakCopy(self.colorList)or{}
local autoCountRecord=self.autoCountRecord~=nil and self.autoCountRecord
if self.randlistlen>0 then
optionDataList={}
colorDataList={}
autoCountRecord=nil
end

if self.lastAutoFindModel and(self.lastAutoFindModel~=modeType)then
optionDataList={}
colorDataList={}
end

UIManager:showWindow('UIDiscipleLinggen_AutoFindOptionWin',{
discipleGuid=self.disciple_guid,
modeType=modeType,
optionDataList=optionDataList,
colorDataList=colorDataList,
autoCountRecord=autoCountRecord,
boardPosData=self.boardPosData,

})
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onAutoFindingBtn()
if self.autoCount>0 then
local callback=function()
self.waitAutoFind=true
self.waitAutoFindCallBack=function()self:startQuickFindProgress(self.mcDataList,self.autoCount,self.optionDataList,self.colorList,self.modeType,true,self.useItemData)end
self:playShowActiveAnimation(false,function()
UIDiscipleController:do_send_2_137(_this.disciple_guid)
end)
end

if self.randlistlen>0 then
local show_data={
type='UIDialouge',
title='提示',
content="是否放弃当前搜寻到的秘藏，并继续自动搜寻",
oktext='确定',
canceltext='取消',
okcallback=callback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self:startQuickFindProgress(self.mcDataList,self.autoCount,self.optionDataList,self.colorList,self.modeType,true,self.useItemData)
end
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onStopAutoFindBtn()
local callback=function()
self:stopQuickFind()
self:refresh()

end
local show_data={
type='UIDialouge',
title='提示',
content="是否终止自动搜寻秘藏？",
oktext='确定',
canceltext='取消',
okcallback=callback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

end

function UIDiscipleLinggen_HiddenSkillSelectWin:onSelectBtn2()
self:onSelectBtn()
end




function UIDiscipleLinggen_HiddenSkillSelectWin:finishQuickFindProgress(oldAutoCount,usedAutoCount)
if self.progressBarTweenerProxy then

self.progressBarTweenerProxy:Kill()
end

if self.barModelMoveTweenerProxy then

self.barModelMoveTweenerProxy:Kill()
end

self:stopPrecautionNoRecvTimer()

self.remainingTimesRoot:setActive(true)

_this:initData()
local result,findIndex=_this:checkQuickFindMCIndex()
local func=function()
if self.autoCount<=0 then
self:stopQuickFind(true)
else
self.autoFindPause=true
end
if result then
self.selectIndex=findIndex
UIManager.info("已搜寻到")
_this:playFindAnimation()
_this:refreshSearchPart()
_this:refreshBottonPart()
_this:refreshItemSlot()
_this:changeHiddenPos()
_this:refreshActiveRecordItem()
else
UIManager.info("暂未搜寻到指定秘藏")
_this.lockBtn=false
_this:refreshItemSlot()

UIDiscipleController:do_send_2_137(_this.disciple_guid)
end
end

self.wordModel:setActive(false)
self.autoFindCountAni:setActive(true)

local totalUseTime=usedAutoCount*0.05
local duration=Mathf.Max(totalUseTime,1)
self:startAutoFindCountAni(usedAutoCount,duration)
self:startFreshRemainingTimes(oldAutoCount,duration)




local pwt=self.progressBar:setChildImageDOFillAmount(1,duration+0.05,function()

self.quickFindProgressRoot:setActive(false)
self.isShowActiveHoardItem=true
if result then
self:playShowActiveAnimation(false,func)
else
self:playShowActiveAnimation(true,func)
end
self:refreshItemSlot()
end)
pwt:SetEase(_Ease.Linear)

local bwt=self.barModel:setChildDOAnchorPosX(_barModelEPosX,duration)
bwt:SetEase(_Ease.Linear)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:startQuickFindProgress(mcDataList,autoCount,optionDataList,colorList,modeType,isNoRecordCount,useItemData)

self.mcDataList=mcDataList
self.autoCount=autoCount
self.optionDataList=optionDataList
self.colorList=colorList
self.modeType=modeType
if not isNoRecordCount then
self.autoCountRecord=autoCount
end

if not self:checkQuickFindCost()then return end



self.useItemData=useItemData
self:refreshItemSlot()

self.autoFindMcLookUp={}
for index,mcCfg in ipairs(self.mcDataList)do
self.autoFindMcLookUp[mcCfg.id]=mcCfg
end

self.isShowActiveHoardItem=false
self:refreshActivePart()
self.quickFindProgressRoot:setActive(true)

self.remainingTimesRoot:setActive(false)
self.wordModel:setActive(true)
self.autoFindCountAni:setActive(false)

self.mibaofuroot:setActive(false)
self.barModel:setChildAnchoredPos(_barModelSPosX,_barModelPosY)
self.progressBar:setChildIconFillAmount(0)
self:delayDo(0.1,function()
self.progressBarTweenerProxy=self.progressBar:setChildImageDOFillAmount(0.1,5,function()
if self.progressBarTweenerProxy then
self.progressBarTweenerProxy=nil
end
end)

local posx=_barModelSPosX+(_barModelEPosX-_barModelSPosX)*0.1

self.barModelMoveTweenerProxy=self.barModel:setChildDOAnchorPosX(posx,5,function()
if self.barModelMoveTweenerProxy then
self.barModelMoveTweenerProxy=nil
end
end)

local itemid=0
if self.useItemData then
itemid=self.useItemData.itemid
end

local list={}
for index,data in ipairs(mcDataList)do
list[#list+1]=data.id
end

self.autoFindPos=self.boardPosData.pos
self.isInAutoFind=true
self.autoFindPause=false
self.lockBtn=true
self.lockTipInfo='正在快速搜寻秘藏，请稍等'
UIDiscipleController:do_send_2_140(self.disciple_guid,self.boardPosData.pos,0,0,itemid,autoCount,#list,list)
self:precautionNoRecvQuickFind()
self:refreshBottonPart()
end)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:precautionNoRecvQuickFind()
self:stopPrecautionNoRecvTimer()

self.precautionNoRecvTimer=self:delayDo(20,function()
UIManager.error('请求无响应')
self.isInAutoFind=false
self.autoFindPos=nil
self.autoFindPause=false
self.lockBtn=false
self.quickFindProgressRoot:setActive(false)
self:refresh()
end)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:stopPrecautionNoRecvTimer()
if self.precautionNoRecvTimer then
self:stopTimerByID(self.precautionNoRecvTimer)
self.precautionNoRecvTimer=nil
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:checkHasWaitSelectBoard()
if self.randpos~=self.boardPosData.pos and self.randlistlen>0 then
local pos=self.randpos>0 and FMT.fmt("{0}号",self.randpos)or"变异"
local dialogdata={
content=FMT.fmt('{0}秘藏栏有秘藏尚未选择，是否放弃并搜寻秘藏？',pos),
okcallback=function()
UIDiscipleController:do_send_2_137(_this.disciple_guid)
self.waitAutoFind=true
self.waitAutoFindCallBack=function()self:onAutoStartFindBtn()end
end,
cancelcallback=function()

end,
oktext="放弃",
}

local show_data={
type='UIDialouge',
title='提示',
content=dialogdata.content,
oktext=dialogdata.oktext or'确定',
canceltext=dialogdata.canceltext or'取消',
okcallback=dialogdata.okcallback,
cancelcallback=dialogdata.cancelcallback,
choosetext=dialogdata.choosetext,
choosecallback=dialogdata.choosecallback
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end

return true
end

function UIDiscipleLinggen_HiddenSkillSelectWin:checkInOtherHoldAutoFind(okCallBack)
if self.isInAutoFind then
if self.boardPosData.pos~=self.autoFindPos then
local miCangOtherHoldAutoFind=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangOtherHoldAutoFind)
if not miCangOtherHoldAutoFind then
local pos=self.autoFindPos>0 and FMT.fmt("{0}号",self.autoFindPos)or"变异"
local content=FMT.fmt("{0}号秘藏栏尚未退出自动搜寻，是否退出并搜寻秘藏？",pos)
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
if okCallBack then
okCallBack()
end
end,
choosetext='今日不再提示',
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangOtherHoldAutoFind,flag)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
else
self:stopQuickFind()
end
end
end
return true
end

function UIDiscipleLinggen_HiddenSkillSelectWin:checkIsCanShowAutoStartFindBtn()
if not systemModel.isOpen(SYSTEM_DEFINE.eDiscipleMCQuickFind)then
return false
end

if self.boardPosData.activelistlen==0 then
return false
end

if self.boardPosData.pos==self.randpos then
if self.randlistlen>0 then
return false
end

if self.isInAutoFind or self.autoFindPause then
return false
end
end

if self.autoFindPos and(self.autoFindPause or self.isInAutoFind)then
if self.autoFindPos==self.boardPosData.pos then
return false
end
end

return true
end

function UIDiscipleLinggen_HiddenSkillSelectWin:checkQuickFindCost()
local costList
local modeType=self.boardPosData.pos<0 and 2 or 1
if modeType==1 then
costList=self.lgBaseCfg.search
elseif modeType==2 then
costList=self.lgBaseCfg.varysearch
end
local result,itemid=itemsModel:canUseItemlist(costList)

if not result then
gainControl:showGainWin(itemid)
end

return result
end

function UIDiscipleLinggen_HiddenSkillSelectWin:checkQuickFindMCIndex()
local findList={}
local board
for index=1,self.randlistlen do
board=self.randlist[index]
if self.autoFindMcLookUp[board.hoardid]~=nil then
findList[#findList+1]={index,board,self.autoFindMcLookUp[board.hoardid]}
end
end

local findLen=#findList
if findLen==1 then
return true,findList[1][1]
elseif findLen==2 then
table.sort(findList,function(a,b)
if a[3].color==b[3].color then
return a[1]<b[1]
else
return a[3].color>b[3].color
end
end)
return true,findList[1][1]
else
return false,1
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:stopQuickFind(isNotClearFindRecords)
self.isInAutoFind=false
self.autoFindPause=false

if not isNotClearFindRecords then
self.autoFindPos=nil
self.optionDataList=nil
self.colorList=nil
self.modeType=nil
self.autoCountRecord=nil
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:startFreshRemainingTimes(oldAutoCount,duration)
self:clearRemainingTimesFmTweener()
local lastVal=oldAutoCount
self.remainingTimesFmTweener=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
self.remainingTimesTxt:setText(FMT.fmt("剩余次数：{0}",moneyStr))
end,self.autoCount,duration)
self.remainingTimesFmTweener:SetEase(_Ease.Linear)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:clearRemainingTimesFmTweener()
if self.remainingTimesFmTweener then
self.remainingTimesFmTweener:Kill()
self.remainingTimesFmTweener=nil
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:startAutoFindCountAni(endCount,duration)

self:clearAutoFindCountAniFmTweener()
local lastVal=1
self.autoFindCountFmTweener=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local numStr=mathHelper.formatNumber(math.floor(val),true)
self.autoFindCountAni:setText(FMT.fmt("{0}次",numStr))
end,endCount,duration)
self.autoFindCountFmTweener:SetEase(_Ease.Linear)
end

function UIDiscipleLinggen_HiddenSkillSelectWin:clearAutoFindCountAniFmTweener()
if self.autoFindCountFmTweener then
self.autoFindCountFmTweener:Kill()
self.autoFindCountFmTweener=nil
end
end


function UIDiscipleLinggen_HiddenSkillSelectWin:initRefreshTeQuan()
self.isOpenMZBKTeQaunSys=systemModel.isOpen(SYSTEM_DEFINE.eMiZangBaoKu)
self.isActiveTeQuan=mzbkModel:getActiveTeQuanState()
self.isShowMZBK=self.isOpenMZBKTeQaunSys and self.isActiveTeQuan
self.isShowTeQuanEnter=self.isOpenMZBKTeQaunSys and not self.isActiveTeQuan

self.tequanRoot:setActive(self.isShowTeQuanEnter)
self.mzbkRoot:setActive(self.isShowMZBK)



if self.isOpenMZBKTeQaunSys then
self:refreshTeQuan()
self:refreshMZBK()
end
end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshTeQuan()


end

function UIDiscipleLinggen_HiddenSkillSelectWin:refreshMZBK()
if not self.isShowMZBK then return end

local isFree=UIDiscipleModel:checkDiscipleHoardFree(self.disciple_guid,self.boardPosData.pos,true)
local isShowSpDiscountKuang=self.isShowMZBK and(not isFree)and self.boardPosData.pos>0
self.spCostDirection:setActive(isShowSpDiscountKuang)

local pos=self.boardPosData.pos
local maxCount=mzbkModel:getMZBKPosMaxSaveCount(pos)
self.curMZBKCount=mzbkModel:getDiscipleMZBKPosSaveCount(tostring(self.disciple_guid),pos)

local bstr=FMT.fmt("{0}/{1}",self.curMZBKCount,maxCount)
bstr=self.curMZBKCount>=maxCount and toColorString(FONT_COLOR.eRedColor,bstr)or toColorString(FONT_COLOR.eGreenTxtColor,bstr)
self.mzbkCount:setText(bstr)
end


function UIDiscipleLinggen_HiddenSkillSelectWin:onTequanBtn()

self:showWindow("UIDiscipleLinggen_MCBKTeQuanWin")
end

function UIDiscipleLinggen_HiddenSkillSelectWin:onMzbkBtn()
if self.curMZBKCount<=0 then
UIManager.info("宝库空空如也，祖师快寻些秘藏放入吧")
return
end


local args={}
args.disciple_guid=self.disciple_guid
args.select_pos=self.boardPosData.pos
self:showWindow("UIDiscipleLinggen_MCBKInfoWin",args)
end

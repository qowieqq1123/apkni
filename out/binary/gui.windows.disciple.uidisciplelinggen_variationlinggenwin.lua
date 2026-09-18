







def_class("UIDiscipleLinggen_variationLinggenWin",UIWindowBase)









function UIDiscipleLinggen_variationLinggenWin:bindComponents()

self.fishSpine=UIObject.get(self,0)
self.previewVaryAttrMask=UIObject.get(self,1)
self.varyMask=UIObject.get(self,2)
self.skiphalfVaryAniBtn=UIButton.get(self,3)
self.disciple=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.dzVaryEffect=UIObject.get(self,6)
self.varyCovergeEffect=UIObject.get(self,7)
self.linggenList=UIObject.get(self,8)
self.lbroot=UIObject.get(self,9)
self.varyResultEffect=UIObject.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.varyPanel=UIObject.get(self,12)
self.varyPanelCanvasGroup=UIObject.get(self,13)
self.varybgspine=UIObject.get(self,14)
self.lbbgspine=UIObject.get(self,15)
self.lbCanvasGroup=UIObject.get(self,16)
self.hiddenPreviewBtn=UIButton.get(self,17)
self.fullLevelInfoRoot=UIObject.get(self,18)
self.previewtip=UIText.get(self,19)
self.bylgnameroot=UIObject.get(self,20)
self.lgnameroot=UIObject.get(self,21)
self.byactiveimg=UIObject.get(self,22)
self.bylgdk=UIImage.get(self,23)
self.lgdk=UIImage.get(self,24)
self.selectLgState=UIObject.get(self,25)
self.bylgname=UIText.get(self,26)
self.bylgicon=UIImage.get(self,27)
self.lgname=UIText.get(self,28)
self.lgicon=UIImage.get(self,29)
self.costicon=UIObject.get(self,30)
self.varyTitle=UIText.get(self,31)
self.fullLevelInfo2Root=UIObject.get(self,32)
self.lbTitle=UIText.get(self,33)
self.baseAttrList=UIObject.get(self,34)
self.unlockhoardtip=UIText.get(self,35)
self.variationInfo=UIText.get(self,36)
self.varyAttrCountBtn=UIButton.get(self,37)
self.costnum=UIText.get(self,38)
self.varyAttrCount2Btn=UIButton.get(self,39)

self.skiphalfVaryAniBtn:setButtonClick(function()self:onSkiphalfVaryAniBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.hiddenPreviewBtn:setButtonClick(function()self:onHiddenPreviewBtn()end)

self.varyAttrCountBtn:setButtonClick(function()self:onVaryAttrCountBtn()end)

self.varyAttrCount2Btn:setButtonClick(function()self:onVaryAttrCount2Btn()end)



end


function UIDiscipleLinggen_variationLinggenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fishSpine);self.fishSpine=nil;
_UIObject_release(self.previewVaryAttrMask);self.previewVaryAttrMask=nil;
_UIObject_release(self.varyMask);self.varyMask=nil;
_UIObject_release(self.skiphalfVaryAniBtn);self.skiphalfVaryAniBtn=nil;
_UIObject_release(self.disciple);self.disciple=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dzVaryEffect);self.dzVaryEffect=nil;
_UIObject_release(self.varyCovergeEffect);self.varyCovergeEffect=nil;
_UIObject_release(self.linggenList);self.linggenList=nil;
_UIObject_release(self.lbroot);self.lbroot=nil;
_UIObject_release(self.varyResultEffect);self.varyResultEffect=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.varyPanel);self.varyPanel=nil;
_UIObject_release(self.varyPanelCanvasGroup);self.varyPanelCanvasGroup=nil;
_UIObject_release(self.varybgspine);self.varybgspine=nil;
_UIObject_release(self.lbbgspine);self.lbbgspine=nil;
_UIObject_release(self.lbCanvasGroup);self.lbCanvasGroup=nil;
_UIObject_release(self.hiddenPreviewBtn);self.hiddenPreviewBtn=nil;
_UIObject_release(self.fullLevelInfoRoot);self.fullLevelInfoRoot=nil;
_UIObject_release(self.previewtip);self.previewtip=nil;
_UIObject_release(self.bylgnameroot);self.bylgnameroot=nil;
_UIObject_release(self.lgnameroot);self.lgnameroot=nil;
_UIObject_release(self.byactiveimg);self.byactiveimg=nil;
_UIObject_release(self.bylgdk);self.bylgdk=nil;
_UIObject_release(self.lgdk);self.lgdk=nil;
_UIObject_release(self.selectLgState);self.selectLgState=nil;
_UIObject_release(self.bylgname);self.bylgname=nil;
_UIObject_release(self.bylgicon);self.bylgicon=nil;
_UIObject_release(self.lgname);self.lgname=nil;
_UIObject_release(self.lgicon);self.lgicon=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.varyTitle);self.varyTitle=nil;
_UIObject_release(self.fullLevelInfo2Root);self.fullLevelInfo2Root=nil;
_UIObject_release(self.lbTitle);self.lbTitle=nil;
_UIObject_release(self.baseAttrList);self.baseAttrList=nil;
_UIObject_release(self.unlockhoardtip);self.unlockhoardtip=nil;
_UIObject_release(self.variationInfo);self.variationInfo=nil;
_UIObject_release(self.varyAttrCountBtn);self.varyAttrCountBtn=nil;
_UIObject_release(self.costnum);self.costnum=nil;
_UIObject_release(self.varyAttrCount2Btn);self.varyAttrCount2Btn=nil;
end















local _this

local selectScaleValue=Vector3(1.2,1.2,1.2)

local CmpLingGenItemIndex={
selectEffect=0,
iconeffect=1,
info=2,
varyeffect=3,
}

local CmpVaryPanelIndex={
top=0,
lgbg=1,
lgicon=2,
lgname=3,
lgclick=4,
varyPart=5,
noVaryPart=6,
okPart=7,
varyOtherPart=8,
changeVaryPart=9,
}

local CmpVaryPartIndex={
byProgress=0,
bycglTxt=1,
byTip=2,
costList=3,
varyBtn=4,
costNum=5,
costIcon=6,
}

local CmpNoVaryPartIndex={
ncbytip=0,
tip=1,
jumpStrengthBtn=2,
}

local CmpOkPartIndex={
maxNameIcon=0,
flagIcon=1,
}

local CmpVaryOtherIndex={
sureChangeBtn=0,
}

local CmpChangeVaryIndex={
varyAttrList=0,
tip1=1,
unlockhoard=2,
changeVaryBtn=3,
}

local CmpVarySkillIndex={
varySkillIcon=0,
varySkillName=1,
varySkillDesc=2,
}

local spritRootPostionList={
[1]={{0,0}},
[2]={{-142,4},{145,-75}},
[3]={{-211,22},{215,23},{-23,-114}},
[4]={{-212,35},{118,35},{-100,-113},{190,-141}},
[5]={{-264,21},{17,42},{268,7},{-122,-129.5},{150.7,-150.7}},
}

local spriteNameColor={'0xc5b776','0x8bb576','0x9dc5da','0xdaa2a2','c3a27e'}

local varyEffectList={
[1]={18021,18022},
[2]={18023,18024},
[3]={18017,18018},
[4]={18019,18020},
[5]={18025,18026},
}

local varyResultEffectList={10395,10396}

local varySkipEffectList={10399,10398}

local _inPos={0,-150}




function UIDiscipleLinggen_variationLinggenWin:onLoaded(...)
self:bindComponents()

_this=self

self.dwlist={}

self:addNotify(notifyConfig.onDiscipleLingGenVary,function(...)self:onDiscipleLingGenVary(...)end)
self:addNotify(notifyConfig.onDiscipleLingGenChangeVary,function(...)self:onDiscipleLingGenChangeVary(...)end)
UIManager:showWindow("UITopMaskWin")
end


function UIDiscipleLinggen_variationLinggenWin:__delete()
self:unbindComponents()

self:delBt()

for k,v in pairs(_this.linggenItemList)do
if _this.dwlist[k]then
_this.dwlist[k]:Kill()
_this.dwlist[k]=nil
end
end

_this=nil
if not(UIManager:isActive("UIDiscipleLinggen_StrengthenLinggenWin")or UIManager:isActive("UIDiscipleLinggen_HiddenSkillSelectWin"))then
UIManager:closeWindow("UITopMaskWin")
end
end




function UIDiscipleLinggen_variationLinggenWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.parentWin=argtable.parentWin

self:initData()

self:refresh()

if afterOnloaded then
self.lbCanvasGroup:setChildCanvasGroupAlpha(0)
self.varyPanelCanvasGroup:setChildCanvasGroupAlpha(0)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.disciple_guid,true,nil,nil)
self.disciple:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,0,false,false,0,nil)

self:startAnimationCallBack()
end
end


function UIDiscipleLinggen_variationLinggenWin:onHide()

end

function UIDiscipleLinggen_variationLinggenWin:initData()
self.lglist,self.lglist_lookup,self.lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.linggenBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)
self.lgVarySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)

if not self.selectIndex then
self.selectIndex=1
for k,v in ipairs(self.lglist)do
if v.type==self.lgVarySrid then
self.selectIndex=k
end
end
end
end

function UIDiscipleLinggen_variationLinggenWin:initStage()

end

function UIDiscipleLinggen_variationLinggenWin:refresh()
self:initData()
self:refreshLingGenList()
self:refreshVaryPanel()
self:refreshPreviewVaryPanel()
end

function UIDiscipleLinggen_variationLinggenWin:selectLingGen(index)
local preitem=self.linggenList:getChildLayoutGroupGridItem(self.selectIndex-1)
if preitem then
preitem:SetChildShowEffect(CmpLingGenItemIndex.selectEffect,0,false)
end

self.selectIndex=index
local item=self.linggenList:getChildLayoutGroupGridItem(index-1)
item:SetChildShowEffect(CmpLingGenItemIndex.selectEffect,10415,true)

self:refreshVaryPanel()
self:refreshPreviewVaryPanel()
end

function UIDiscipleLinggen_variationLinggenWin:refreshLingGenList()
self.linggenItemList={}
self.lgItems={}
self.linggenList:setChildLayoutGroupCreateItems(self.lglen,function(index)
local item=_this.linggenList:getChildLayoutGroupGridItem(index-1)
local data=_this.lglist[index]
self.linggenItemList[data.type]=item


local lgCfg=UIDiscipleModel:getLinggenSpecialCfg(data.type,data.varyState==1)

local isSelect=index==_this.selectIndex
local name=lgCfg.name

local iconEffectId=lgCfg.showlist[LingGenShowListIndex.varyEffect]
item:SetChildShowEffect(CmpLingGenItemIndex.iconeffect,iconEffectId,true)


item:SetChildShowEffect(CmpLingGenItemIndex.selectEffect,10415,isSelect)

local info=FMT.fmt('{0}{1}级',toColorStringX(spriteNameColor[data.type],name),data.lv)
item:SetChildText(CmpLingGenItemIndex.info,info)

local pos=spritRootPostionList[_this.lglen][index]
item:SetChildLocalPosition(-1,Vector3(pos[1],pos[2],0))

item:SetBaseItemClickEvent(-1,function()
if _this.selectIndex~=index then
_this:selectLingGen(index)
end
end)



item:SetChildNewBieComponentId(-1,FMT.fmt('UIDiscipleLinggen_variationLinggenWin.lgitem{0}',index))
end)
end

function UIDiscipleLinggen_variationLinggenWin:refreshVaryPanel(state)
state=state or{}
local vpwb=self.varyPanel:getChildWidgetBase()

local data=_this.lglist[self.selectIndex]
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local lgCfg=UIDiscipleModel:getSpecialityConfigEx(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,data.source)

local name=lgCfg.name

self.lgname:setText(name)
self.lgdk:setCSImageSprite(globalABLookup.varylinggensprite,lgCfg.showlist[LingGenShowListIndex.Dikuang])
self.lgicon:setCSImageSprite(globalABLookup.varylinggensprite,lgCfg.showlist[LingGenShowListIndex.SmalIcon])



local totallv=UIDiscipleModel:getDiscipleTotalLinggenLevel(self.disciple_guid)
local varysrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
local vary=self.linggenBaseCfg.vary

local varyOk=UIDiscipleModel:checkHasVaryLinggen(self.disciple_guid)
local isCanVary=data.lv>=vary[1]and totallv>=vary[2]
local isVaryed=data.varyState==1
local isVaryOther=varysrid~=data.type
local changeVarying=data.varyState<0


self.selectLgState:setActive(isVaryed)

_this.skiphalfVaryAniBtn:setActive(false)



vpwb:SetChildActive(CmpVaryPanelIndex.varyPart,isCanVary and(not varyOk or state.sureVary or changeVarying)and not isVaryed)
if isCanVary and(not varyOk or state.sureVary or changeVarying)and not isVaryed then
local varyPartWb=vpwb:GetChildWidgetBase(CmpVaryPanelIndex.varyPart)
local maxValue=100
local varyedNum=Mathf.Abs(data.varyState)
local curValue=vary[3]+varyedNum*vary[4]
curValue=Mathf.Min(curValue,maxValue)
varyPartWb:SetProgressBarAniWithThreeParams(CmpVaryPartIndex.byProgress,curValue,maxValue,0.5)
varyPartWb:SetChildText(CmpVaryPartIndex.bycglTxt,FMT.fmt("变异成功率\n<color=#f1ce78>{0}%</color>",curValue))

local costlist=vary[5][data.type]

local initPropDatas={}
for i=2,#costlist do
local data=costlist[i]
local itemid=data[1]
local needNum=data[2]
local hasNum=itemsModel.getCount(itemid)

local hasColor=hasNum>=needNum and FONT_COLOR.eGrayWhiteTxtColor or FONT_COLOR.eRedColor
local countdesc=FMT.fmt('{0}/{1}',toColorString(hasColor,hasNum),needNum)

local conf={itemid=itemid,itemcount=countdesc,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(initPropDatas,prop)
end
varyPartWb:SetChildLayoutGroupCreateItems(CmpVaryPartIndex.costList,#initPropDatas,function(index)
local item=varyPartWb:GetChildLayoutGroupGridItem(CmpVaryPartIndex.costList,index-1)
local propdata=initPropDatas[index]
item:SetChildPropData(-1,propdata)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end)

local hbconsume=costlist[1]
local hbIconName=itemsModel.getItemIconName(hbconsume[1])
local hbHasNum=itemsModel.getCount(hbconsume[1])

local hbTxtColor=hbHasNum>=hbconsume[2]and FONT_COLOR.eNomalColor or FONT_COLOR.eRedColor
varyPartWb:SetChildIcon(CmpVaryPartIndex.costIcon,hbIconName,false)
varyPartWb:SetChildText(CmpVaryPartIndex.costNum,toColorString(hbTxtColor,hbconsume[2]))

varyPartWb:SetChildButtonClick(CmpVaryPartIndex.varyBtn,function()
local isCostEnough=true
local lackItemid
for k,v in pairs(costlist)do
local hasnum=itemsModel.getCount(v[1])
local neednum=v[2]
isCostEnough=isCostEnough and hasnum>=neednum
if not isCostEnough then
lackItemid=v[1]
break
end
end

if isCostEnough then
UIDiscipleController:do_send_2_133(_this.disciple_guid,data.type)
else
UIManager.info("变异材料不足")
gainControl:showCommonGainWin_item(lackItemid)
end
end,true)
end


vpwb:SetChildActive(CmpVaryPanelIndex.noVaryPart,not isCanVary)
if not isCanVary then
local noVaryPartWb=vpwb:GetChildWidgetBase(CmpVaryPanelIndex.noVaryPart)
noVaryPartWb:SetChildText(CmpNoVaryPartIndex.ncbytip,"灵根等级不足，无法变异")
noVaryPartWb:SetChildText(CmpNoVaryPartIndex.tip,FMT.fmt("灵根强化<color=#ca631d>{0}级</color>后解锁变异\n当前灵根等级:<color=#ca631d>{1}级</color>",vary[1],data.lv))
noVaryPartWb:SetChildButtonClick(CmpNoVaryPartIndex.jumpStrengthBtn,function()
_this.parentWin:showWindow("UIDiscipleLinggen_StrengthenLinggenWin",{
disciple_guid=_this.disciple_guid,
data=data,
isShowStrengthenPanel=true,
})
_this:closeSelf()
end,true)
end


vpwb:SetChildActive(CmpVaryPanelIndex.okPart,varyOk and isVaryed and not isVaryOther and isCanVary)
if varyOk and isVaryed and not isVaryOther then
local okVaryPartWb=vpwb:GetChildWidgetBase(CmpVaryPanelIndex.okPart)
okVaryPartWb:SetChildCSImageSprite(CmpOkPartIndex.maxNameIcon,globalABLookup.varylinggensprite,lgCfg.showlist[LingGenShowListIndex.BidWold])
okVaryPartWb:SetChildCSImageSprite(CmpOkPartIndex.flagIcon,globalABLookup.varylinggensprite,lgCfg.showlist[LingGenShowListIndex.BigIcon])
end


vpwb:SetChildActive(CmpVaryPanelIndex.varyOtherPart,isCanVary and(varyOk and not state.sureVary and not changeVarying)and not isVaryed and isVaryOther)
if isCanVary and(varyOk and not state.sureVary and not changeVarying)and not isVaryed and isVaryOther then
local cfg=UIDiscipleModel:getSpecialityConfigEx(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,data.source)
local varyOtherPartWb=vpwb:GetChildWidgetBase(CmpVaryPanelIndex.varyOtherPart)
varyOtherPartWb:SetChildButtonClick(CmpVaryOtherIndex.sureChangeBtn,function()
local content=FMT.fmt("多个变异灵根仅可选择一个变异灵根生效，是否继续变异？")
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
UIManager.info(FMT.fmt("开始变异{0}",cfg.name))
UIManager:invokeUIMethod("UIDiscipleLinggen_variationLinggenWin","refreshVaryPanel",{sureVary=true})
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end,true)
end


vpwb:SetChildActive(CmpVaryPanelIndex.changeVaryPart,varyOk and isVaryed and isVaryOther and isCanVary)
if varyOk and isVaryed and isVaryOther then
local changeVaryPartWb=vpwb:GetChildWidgetBase(CmpVaryPanelIndex.changeVaryPart)
local varyCfg=cfgHelper.get2(cfg_disciplespiritrootvaryconfig_get,self.lglen,data.type)
local CommonName=UIDiscipleModel:getSpecialityName(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,data.type)
local varylgCfg=UIDiscipleModel:getLinggenSpecialCfg(data.type,true)
local uplv=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')

changeVaryPartWb:SetChildLayoutGroupCreateItems(CmpChangeVaryIndex.varyAttrList,#varyCfg.attr,function(index)
local item=changeVaryPartWb:GetChildLayoutGroupGridItem(CmpChangeVaryIndex.varyAttrList,index-1)
local attrdata=varyCfg.attr[index]
local attrName=helper.getAttributeName(attrdata[1])
local attrValue=helper.getAttributeStrEx(attrdata[1],attrdata[2],2)
attrName=FMT.fmt("{0}",attrName)
attrValue=FMT.fmt("+{0}",attrValue)
if attrdata[1]>100 then
attrName=toColorStringX('#ca631d',attrName)
attrValue=toColorStringX('#ca631d',attrValue)
end
item:SetChildText(0,attrName)
item:SetChildText(1,attrValue)
item:SetChildActive(-1,true)
end)

local unlockhoardStr=FMT.fmt("解锁变异秘藏：{0}",varylgCfg.elementname)
changeVaryPartWb:SetChildText(CmpChangeVaryIndex.unlockhoard,unlockhoardStr)

changeVaryPartWb:SetChildText(CmpChangeVaryIndex.tip1,FMT.fmt('{0}强化上限+{1}级',CommonName,uplv))

changeVaryPartWb:SetChildButtonClick(CmpChangeVaryIndex.changeVaryBtn,function()
if self:checkIsNeedRestitution()then
self:showWindow("UIDiscipleLinggen_ChangeDialogeWin",{
disciple_guid=_this.disciple_guid,
changeData=data,
})
else
UIDiscipleController:do_send_2_134(self.disciple_guid,data.type)
end
end,true)
end



end

function UIDiscipleLinggen_variationLinggenWin:refreshPreviewVaryPanel()
local data=_this.lglist[self.selectIndex]

local isVaryed=data.varyState==1


if self.lgVarySrid==data.type then
self.lbTitle:setText("当前变异")
else

self.lbTitle:setText("变异预览")
data=table.deepCopy(data)
data.source.param_3=1





end

local varyCfg=cfgHelper.get2(cfg_disciplespiritrootvaryconfig_get,self.lglen,data.type)
local lgCfg=UIDiscipleModel:getLinggenSpecialCfg(data.type,true)

local isCanVary=UIDiscipleModel:checkDiscipleCanVary(self.disciple_guid,data.type)
self.byactiveimg:setActive(self.lgVarySrid==data.type and isCanVary)


self.bylgname:setText(lgCfg.name)
self.bylgdk:setCSImageSprite(globalABLookup.varylinggensprite,lgCfg.showlist[LingGenShowListIndex.Dikuang])
self.bylgicon:setCSImageSprite(globalABLookup.varylinggensprite,lgCfg.showlist[LingGenShowListIndex.SmalIcon])

local unlockhoardtipStr=FMT.fmt("解锁变异秘藏：{0}",lgCfg.elementname)
self.unlockhoardtip:setText(unlockhoardtipStr)

local baseLgCfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,data.type)
local upLevelNum=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')
self.variationInfo:setText(FMT.fmt('{0}强化上限+{1}级',baseLgCfg.name,upLevelNum))

local attrs=varyCfg.attr
local totalAttr=self.transFunc(attrs)
local averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)

local attrStrList=self:getVaryAttrDvalueStrList(data.type,totalAttr,data.lv,averageLv)

self.baseAttrList:setChildLayoutGroupCreateItems(#attrStrList,function(index)
local item=self.baseAttrList:getChildLayoutGroupGridItem(index-1)
local attrdata=attrStrList[index]
item:SetChildText(0,attrdata[1])
item:SetChildText(1,attrdata[2])
item:SetChildActive(-1,true)
end)
end



function UIDiscipleLinggen_variationLinggenWin:onDiscipleLingGenVary(dz_guid,linggen_id,vary)
if mathHelper.compareInt64(dz_guid,self.disciple_guid)then
self.varyLg=linggen_id
self.varyResult=vary==1
self.showVaryAni=true
self:playBtAnimation(linggen_id,vary==1)
end
end

function UIDiscipleLinggen_variationLinggenWin:onDiscipleLingGenChangeVary(dz_guid,linggen_id)
local varyid=UIDiscipleModel:getDiscipleVarysrid(dz_guid)
if dz_guid==self.disciple_guid and varyid>0 and not self.showVaryAni then

self:refresh()
UIManager.info("更换变异成功")
end
end


function UIDiscipleLinggen_variationLinggenWin:checkIsNeedRestitution()
local varysrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
if varysrid==0 then
return false
end

local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
local lgBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)
local maxlv=lgBaseCfg.max/lglen
return lglist_lookup[varysrid].lv>maxlv
end

function UIDiscipleLinggen_variationLinggenWin.transFunc(attrs)
local temp={}
for k,v in pairs(attrs)do
temp[v[1]]=v[2]
end
return temp
end

function UIDiscipleLinggen_variationLinggenWin:getVaryAttrDvalueStrList(type,total_list,max_lv,base_lv,spec,vspec)
local baseMaxAttrs=cfgHelper.get4(cfg_disciplespiritrootlevelconfig_get,self.lglen,type,base_lv,'attr')
local curAttrs=cfgHelper.get4(cfg_disciplespiritrootlevelconfig_get,self.lglen,type,max_lv,'attr')

vspec=vspec or'#CA631D'
spec=spec or'#CA631D'


local t_b=self.transFunc(baseMaxAttrs)
local t_c=self.transFunc(curAttrs)
local totalAttr=total_list

for attrId_c,attrVal_c in pairs(t_c)do
local interval
if t_b[attrId_c]then
interval=t_c[attrId_c]-t_b[attrId_c]
else
interval=t_c[attrId_c]
end
if totalAttr[attrId_c]then
totalAttr[attrId_c]=totalAttr[attrId_c]+interval
else
totalAttr[attrId_c]=interval
end

end

local attrlist={}
for k,v in pairs(totalAttr)do
table.insert(attrlist,{k,v})
end

table.sort(attrlist,function(a,b)
return a[1]<b[1]
end)

local attrStrList={}
for index,attrdata in ipairs(attrlist)do
local attrName=helper.getAttributeName(attrdata[1])
local attrValue=helper.getAttributeStrEx(attrdata[1],attrdata[2],2)
attrValue=FMT.fmt("+{0}",attrValue)
if attrdata[1]>100 then
attrName=toColorStringX(spec,attrName)
attrValue=toColorStringX(spec,attrValue)
end
table.insert(attrStrList,{attrName,attrValue})
end

local effects_vary_dvalue_desc=cfgHelper.get4(cfg_disciplespiritrootlevelconfig_get,self.lglen,type,max_lv,'effects_vary_dvalue_desc')or{}
local effectList=effects_vary_dvalue_desc[self.lglen]or{}
for index,effectStr in ipairs(effectList)do
local slist=string.split(effectStr,'+')
local attrValue=FMT.fmt("+{0}",slist[2])
local attrName=toColorStringX(vspec,slist[1])
attrValue=toColorStringX(vspec,attrValue)

table.insert(attrStrList,{attrName,attrValue})
end

return attrStrList
end





function UIDiscipleLinggen_variationLinggenWin:onCloseBtn()
self:closeSelf()
end

function UIDiscipleLinggen_variationLinggenWin:onSkiphalfVaryAniBtn()
local lgData=self.lglist[self.selectIndex]
local lgItem=self.linggenItemList[lgData.type]

lgItem:SetChildAnchoredPos(-1,_inPos[1],_inPos[2])

local lg=self.varyLg
self:playBtAnimation(lg,self.varyResult,4)

self.skiphalfVaryAniBtn:setActive(false)
end

function UIDiscipleLinggen_variationLinggenWin:onHiddenPreviewBtn()
local index=self.selectIndex






self:showWindow("UIDiscipleLinggen_HiddenSkillPreViewWin",{
data=self.lglist[index],
disciple_guid=self.disciple_guid,
})
end

function UIDiscipleLinggen_variationLinggenWin:onVaryAttrCountBtn()
self.fullLevelInfoState=not self.fullLevelInfoState
if self.fullLevelInfoState then

local averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)
local uplv=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')

local data

data=_this.lglist[self.selectIndex]



local attrStrList=self:getVaryAttrDvalueStrList(data.type,{},averageLv+uplv,averageLv,'#fd8950','#fd8950')

local fullLevelInfoRootWb=self.fullLevelInfoRoot:getWidgetBase()

fullLevelInfoRootWb:SetChildLayoutGroupCreateItems(0,#attrStrList,function(index)
local item=fullLevelInfoRootWb:GetChildLayoutGroupGridItem(0,index-1)
local attrStrData=attrStrList[index]
item:SetChildActive(-1,attrStrData~=nil)
if attrStrData then
item:SetChildText(0,attrStrData[1])
item:SetChildText(1,attrStrData[2])
end
end)
end

self.previewVaryAttrMask:setActive(true)
self.fullLevelInfoRoot:setActive(self.fullLevelInfoState)
self.winlua:ForceLayoutRect(self.fullLevelInfoRoot:getID())
end

function UIDiscipleLinggen_variationLinggenWin:onVaryAttrCount2Btn()
self.fullLevelInfoState2=not self.fullLevelInfoState2
if self.fullLevelInfoState2 then

local averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(self.disciple_guid)
local uplv=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')

local data=_this.lglist[self.selectIndex]
local attrStrList=self:getVaryAttrDvalueStrList(data.type,{},averageLv+uplv,averageLv,'#fd8950','#fd8950')

local fullLevelInfoRootWb=self.fullLevelInfo2Root:getWidgetBase()

fullLevelInfoRootWb:SetChildLayoutGroupCreateItems(0,#attrStrList,function(index)
local item=fullLevelInfoRootWb:GetChildLayoutGroupGridItem(0,index-1)
local attrStrData=attrStrList[index]
item:SetChildActive(-1,attrStrData~=nil)
if attrStrData then
item:SetChildText(0,attrStrData[1])
item:SetChildText(1,attrStrData[2])
end
end)
end

self.previewVaryAttrMask:setActive(true)
self.fullLevelInfo2Root:setActive(self.fullLevelInfoState2)
self.winlua:ForceLayoutRect(self.fullLevelInfo2Root:getID())
end



function UIDiscipleLinggen_variationLinggenWin:startAnimationCallBack()

self:delayDo(1,function()
_this.lbbgspine:setChildUIModelShowTarget(4880,1,{},eAnimationID.enter,false,false,0,function()
_this:delayDo(1,function()
_this.lbCanvasGroup:setChildCanvasGroupDOFade(1,1,nil)
end)
end)
_this.varybgspine:setChildUIModelShowTarget(4880,1,{},eAnimationID.enter,false,false,0,function()
_this:delayDo(1,function()
_this.varyPanelCanvasGroup:setChildCanvasGroupDOFade(1,1,nil)
end)
end)
end)







for k,v in pairs(self.linggenItemList)do
v:SetChildScale(-1,Vector3.New(0,0,0))
end

_this:delayDo(1,function()
for k,v in pairs(_this.linggenItemList)do
_this.dwlist[k]=v:SetChildDOScale(-1,1,3,function()
_this.dwlist[k]=nil
end)
end
end)
end

function UIDiscipleLinggen_variationLinggenWin:startVariationAnimation(state)
local fadeSpeed=1
local val=state and 1 or 0
_this.lbroot:setChildCanvasGroupDOFade(val,fadeSpeed)
_this.varyPanel:setChildCanvasGroupDOFade(val,fadeSpeed)

for k,v in pairs(_this.linggenItemList)do
if _this.dwlist[k]then
_this.dwlist[k]:Kill()
_this.dwlist[k]=nil
end
end

for k,data in pairs(_this.lglist)do
local item=_this.linggenItemList[data.type]
if k~=self.selectIndex then
item:SetChildDOScale(-1,val,fadeSpeed/2)
end
end

_this.skiphalfVaryAniBtn:setActive(not state)
end

function UIDiscipleLinggen_variationLinggenWin:playBtAnimation(linggen_id,is_success,startStateId)
local lgData=self.lglist[self.selectIndex]
local lgItem=self.linggenItemList[lgData.type]

local index=is_success and 1 or 2

startStateId=startStateId or 1

local initData={
wight=lgItem:GetChildWidgetBase(-1),
inPos=_inPos,
outPos=spritRootPostionList[self.lglen][self.selectIndex],
moveSpeed=0.5,
moveSpeed2=0.5,

resultEffectIndex=4,
varyEffectIndex=3,
selectEffectIndex=0,
selectEffectId=10415,
varyEffectId=varyEffectList[linggen_id][index],
varyResultEffectId=varyResultEffectList[index],
varyState=is_success,
fishSpineName='fishSpineTran',
fishSpineTran=self.winlua:GetCommonComponent(self.fishSpine:getID(),'RectTransform'),
fishScale=1.2,
lgScale=1.5,
scaleDuration=0.3,
mainWight=self.winlua,
varymaskIndex=self.varyMask:getID(),
stateId=startStateId,
skipVaryEffectId=varySkipEffectList[index],
varyMaskIndex=self.varyMask:getID(),
}

self:delBt()

self.bt=behaviorManager:addBehaviorTree('bt_ui_bylg',{},true,initData)
end


function UIDiscipleLinggen_variationLinggenWin:doMoveToPosition(wight,pos,speed)
wight:SetChildDOAnchorPos(-1,Vector2.New(pos[1],pos[2]),speed,nil)
end


function UIDiscipleLinggen_variationLinggenWin:doShake(wight)end

function UIDiscipleLinggen_variationLinggenWin:delBt()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end

function UIDiscipleLinggen_variationLinggenWin:varyCallBack(state)
self:initData()
self:refreshLingGenList()
self:refreshVaryPanel({isSuccess=state})
self:refreshPreviewVaryPanel()

self.showVaryAni=false
end

function UIDiscipleLinggen_variationLinggenWin:varyRefreshVaryLinggen()
self:initData()
local index=self.selectIndex

local item=_this.linggenList:getChildLayoutGroupGridItem(index-1)
local data=_this.lglist[index]

local lgCfg=UIDiscipleModel:getLinggenSpecialCfg(data.type,data.varyState==1)

local iconEffectId=lgCfg.showlist[LingGenShowListIndex.varyEffect]
item:SetChildShowEffect(CmpLingGenItemIndex.iconeffect,iconEffectId,true)
end

function UIDiscipleLinggen_variationLinggenWin:showVaryMask()


self.varyCovergeEffect:setActive(true)
local item=_this.linggenList:getChildLayoutGroupGridItem(self.selectIndex-1)
local lgTrans=item:GetCommonComponent(-1,'RectTransform')
self.winlua:SetGuideMaskTargetX(self.varyCovergeEffect:getID(),lgTrans,0,0,0,0)
self.winlua:StartGuideMask(self.varyCovergeEffect:getID(),0,1)
end

function UIDiscipleLinggen_variationLinggenWin:stopVaryMask()
self.varyCovergeEffect:setActive(false)
newbieManager.stopMask()
end

function UIDiscipleLinggen_variationLinggenWin:closePreviewAttrMask()
self.fullLevelInfoRoot:setActive(false)
self.fullLevelInfo2Root:setActive(false)
self.previewVaryAttrMask:setActive(false)

self.fullLevelInfoState=false
self.fullLevelInfoState2=false
end










def_class("UICommonLookRivalWin",UIWindowBase)









function UICommonLookRivalWin:bindComponents()

self.mask=UIButton.get(self,0)
self.bg1=UIObject.get(self,1)
self.bg2=UIObject.get(self,2)
self.title=UIText.get(self,3)
self.otherInfo=UIObject.get(self,4)
self.roleList=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.stSlot=UIButton.get(self,7)
self.shentong=UIObject.get(self,8)
self.polygonAttrPanel=UIObject.get(self,9)
self.infoBtn=UIButton.get(self,10)
self.equipslist=UIObject.get(self,11)
self.notInfoTips=UIText.get(self,12)
self.dzInfoPanel=UIObject.get(self,13)
self.totalFightText=UIText.get(self,14)
self.sixAttrText=UIText.get(self,15)
self.model_2=UIObject.get(self,16)
self.model_5=UIObject.get(self,17)
self.model_1=UIObject.get(self,18)
self.model_4=UIObject.get(self,19)
self.model_3=UIObject.get(self,20)
self.jingjie=UIText.get(self,21)
self.gfSlot_1=UIButton.get(self,22)
self.gfSlot_2=UIButton.get(self,23)
self.lianti=UIText.get(self,24)
self.name=UIText.get(self,25)
self.headIcon=UIObject.get(self,26)
self.headKuang=UIImage.get(self,27)
self.speak=UIObject.get(self,28)
self.name2=UIText.get(self,29)
self.speakTxt=UIText.get(self,30)
self.equipRoot=UIObject.get(self,31)
self.vocSkillRoot=UIObject.get(self,32)
self.gongfaRoot=UIObject.get(self,33)
self.vocSkillSlot_1=UIObject.get(self,34)
self.vocSkillSlot_2=UIObject.get(self,35)
self.vocSkillSlot_3=UIObject.get(self,36)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.stSlot:setButtonClick(function()self:onStSlot()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.gfSlot_1:setButtonClick(function()self:onGfSlot_1()end)

self.gfSlot_2:setButtonClick(function()self:onGfSlot_2()end)
self.model={
self.model_1,
self.model_2,
self.model_3,
self.model_4,
self.model_5,
}
self.gfSlot={
self.gfSlot_1,
self.gfSlot_2,
}
self.vocSkillSlot={
self.vocSkillSlot_1,
self.vocSkillSlot_2,
self.vocSkillSlot_3,
}



end


function UICommonLookRivalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.bg1);self.bg1=nil;
_UIObject_release(self.bg2);self.bg2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.otherInfo);self.otherInfo=nil;
_UIObject_release(self.roleList);self.roleList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.stSlot);self.stSlot=nil;
_UIObject_release(self.shentong);self.shentong=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.equipslist);self.equipslist=nil;
_UIObject_release(self.notInfoTips);self.notInfoTips=nil;
_UIObject_release(self.dzInfoPanel);self.dzInfoPanel=nil;
_UIObject_release(self.totalFightText);self.totalFightText=nil;
_UIObject_release(self.sixAttrText);self.sixAttrText=nil;
_UIObject_release(self.model_2);self.model_2=nil;
_UIObject_release(self.model_5);self.model_5=nil;
_UIObject_release(self.model_1);self.model_1=nil;
_UIObject_release(self.model_4);self.model_4=nil;
_UIObject_release(self.model_3);self.model_3=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.gfSlot_1);self.gfSlot_1=nil;
_UIObject_release(self.gfSlot_2);self.gfSlot_2=nil;
_UIObject_release(self.lianti);self.lianti=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.speak);self.speak=nil;
_UIObject_release(self.name2);self.name2=nil;
_UIObject_release(self.speakTxt);self.speakTxt=nil;
_UIObject_release(self.equipRoot);self.equipRoot=nil;
_UIObject_release(self.vocSkillRoot);self.vocSkillRoot=nil;
_UIObject_release(self.gongfaRoot);self.gongfaRoot=nil;
_UIObject_release(self.vocSkillSlot_1);self.vocSkillSlot_1=nil;
_UIObject_release(self.vocSkillSlot_2);self.vocSkillSlot_2=nil;
_UIObject_release(self.vocSkillSlot_3);self.vocSkillSlot_3=nil;
self.model=nil;
self.gfSlot=nil;
self.vocSkillSlot=nil;
end

















local _this
local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_4",
[3]="image_gwtouxiangpjk_3",
[4]="image_gwtouxiangpjk_6",
[5]="image_gwtouxiangpjk_2",
}

local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
[EQUIP_TYPE.eFabao]=4,
[EQUIP_TYPE.eDaoBing]=5,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpLiandon=13,
}

local _this


function UICommonLookRivalWin:onLoaded(...)
_this=self
self:bindComponents()
self.speakTweens={}

self.equipListWidget=self.equipslist:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do
self.equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget:SetBaseItemChildIndex(idx,equipType)
end
end


function UICommonLookRivalWin:__delete()

if self.subWinName then
self:closeWindow(self.subWinName)
end

self:unbindComponents()
_this=nil
end




function UICommonLookRivalWin:onShow(argtable,afterOnloaded)
if argtable then
local teamList=argtable.teamList or{}
local bgType=argtable.bgType or 1
self.bg1:setActive(bgType==1)
self.bg2:setActive(bgType==2)
self.lookType=argtable.lookType
self.otherArgs=argtable.otherArgs
local titleText=argtable.title or'防守阵容'

if argtable.bgImg then
self.bg2:setCSImageSprite(argtable.bgImg[1],argtable.bgImg[2])
end

local showFight=argtable.showFight or{}

self.title:setText(titleText)

self.teamMaxDiscipleCount=5
local teamFightValue={}
local disciplesList={}
for i,v in pairs(teamList)do
local data=v
if data then
local teamIndex=math.ceil(i/self.teamMaxDiscipleCount)
local index=i%self.teamMaxDiscipleCount
if index==0 then

index=self.teamMaxDiscipleCount
end

if not teamFightValue[teamIndex]then
teamFightValue[teamIndex]=0
end
if showFight[i]then
teamFightValue[teamIndex]=teamFightValue[teamIndex]+mathHelper.int64_to_number(showFight[i])
else
teamFightValue[teamIndex]=teamFightValue[teamIndex]+data:fightValNum_get()
end


if not disciplesList[teamIndex]then
disciplesList[teamIndex]={}
end
table.insert(disciplesList[teamIndex],{index=index,data=data,extraFight=showFight[i]})
end
end

self.teamList={}
for teamIndex,v in pairs(disciplesList)do
self.teamList[teamIndex]={disciplesList=disciplesList[teamIndex],fightValue=teamFightValue[teamIndex]}
end

self.selectTeamIndex=1

self:refresh()


self.subWinName=argtable.winName or nil
local subWinArgs=argtable.winArgs or nil
if self.subWinName then
self:showWindow(self.subWinName,{parentWin='UICommonLookRivalWin',data=subWinArgs,lookType=self.lookType,canvasIndex=argtable.canvasIndex})
end

if argtable.canvasIndex then
self:setCanvasIndex(-1,argtable.canvasIndex)
end
end
end


function UICommonLookRivalWin:onHide()

if self.subWinName then
self:closeWindow(self.subWinName)
end
end

function UICommonLookRivalWin:refresh()
if not self.teamList[self.selectTeamIndex]then
self.teamList[self.selectTeamIndex]={}
end

local totalFight=self.teamList[self.selectTeamIndex].fightValue or 0
self.totalFightText:setText(UIDiscipleModel:fightValueConversion(totalFight))



if self.lookType~=DOUFATAI_LOOK_TYPE.eLunDaoTeam and
self.lookType~=DOUFATAI_LOOK_TYPE.eXianFaWenDao and
self.lookType~=DOUFATAI_LOOK_TYPE.eWDCQ_OtherTeam and
self.lookType~=DOUFATAI_LOOK_TYPE.eWDCQ_SelfTeam and
self.lookType~=DOUFATAI_LOOK_TYPE.eXingYu_OtherTeam and
self.lookType~=DOUFATAI_LOOK_TYPE.eXingYu_SelfTeam
then
self.polygonAttrPanel:setActive(true)
else
self.polygonAttrPanel:setActive(false)
end

if self.lookType==DOUFATAI_LOOK_TYPE.eLunDaoTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eXianFaWenDao or
self.lookType==DOUFATAI_LOOK_TYPE.eWDCQ_OtherTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eWDCQ_SelfTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eXingYu_OtherTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eXingYu_SelfTeam
then
self.shentong:setActive(true)
else
self.shentong:setActive(false)
end
self:freshDisciplesList()
self:freshModels()
self:freshOther()
end

function UICommonLookRivalWin:freshDisciplesList()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList or{}
local num=#disciplesList
self.roleList:setChildLayoutGroupCreateItems(num,function(index)
local item=self.roleList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(-1,true)
item:SetChildButtonClickWithID(0,function(index)
self.onClickRoleItem(index)
end,index)

local dzData=self.teamList[self.selectTeamIndex].disciplesList[index].data
local extraFight=self.teamList[self.selectTeamIndex].disciplesList[index].extraFight
local fight
if extraFight then
fight=mathHelper.int64_to_number(extraFight)
else
fight=dzData:fightValNum_get()
end
local baseData=dzData.base
local isLD=liandonModel:getLianDonLinkageIdByDZId(baseData.id)>0
item:SetChildText(2,baseData.disciplename)
item:SetChildText(3,FMT.fmt('{0}',UIDiscipleModel:fightValueConversion(fight)))
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(baseData)
comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eHead)

comHelper.setChildModelHeadIconBGByColor(item,5,dzData.color or 1)
item:SetChildActive(4,false)
item:SetChildActive(6,isLD)
UIDiscipleModel:setDiscipleXianMoHeadImage(item,7,baseData)
end)
self.onClickRoleItem(1)
end

function UICommonLookRivalWin:freshOther()
local otherArgs=self.otherArgs
if otherArgs then
self.otherInfo:setActive(true)
local actorInfo=otherArgs
if actorInfo then

if actorInfo.playerHeadInfo then
playerController:setHeadIcon(self.winid,self.headIcon:getID(),{scale=0.7,iconInfo=actorInfo.playerHeadInfo})
end
if actorInfo.name and not actorInfo.serverId then
self.name:setText(actorInfo.name)
self.name:setActive(true)
end
if actorInfo.sentence then
self.speakTxt:setText(actorInfo.sentence)
end
self.speak:setActive(actorInfo.sentence~=nil)
if actorInfo.serverId then
local serverName=loginModel:getServerName(actorInfo.serverId)
self.name:setActive(false)
self.name2:setActive(true)
self.name2:setText(FMT.fmt("[{0}]\n{1}",serverName,actorInfo.name or''))
end
end
else
self.otherInfo:setActive(false)
end
end

function UICommonLookRivalWin.onClickRoleItem(index)
if _this.selectRoleIdx==index then return end
if _this.selectRoleIdx then
local lastItem=_this.roleList:getChildLayoutGroupGridItem(_this.selectRoleIdx-1)
lastItem:SetChildActive(4,false)
_this:refreshModelSelect(false)
end
_this.selectRoleIdx=index
local item=_this.roleList:getChildLayoutGroupGridItem(_this.selectRoleIdx-1)
if item then
item:SetChildActive(4,true)
end
_this:freshInfo()
_this:refreshModelSelect(true)
end

function UICommonLookRivalWin:refreshModelSelect(flag)
self:killSpeakTween(self.selectRoleIdx)
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList or{}
local data=disciplesList[self.selectRoleIdx]
if data then
local index=data.index
local widget=self.model[index]:getChildWidgetBase(-1)
widget:SetChildCanvasGroupAlpha(1,flag and 1 or 0)
if flag then
self.speakTweens[self.selectRoleIdx]=widget:SetChildCanvasGroupDOFade(1,0,0.5)
self.speakTweens[self.selectRoleIdx]:SetDelay(5)
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local speakList=config.xiaoren_speak
local speakStr=speakList[math.random(1,#speakList)]
widget:SetChildText(2,speakStr)
end
widget:SetChildShowEffect(4,10125,flag)
end
end

function UICommonLookRivalWin:killSpeakTween(index)
if self.speakTweens[index]then
self.speakTweens[index]:Kill(false)
self.speakTweens[index]=nil
end
end

function UICommonLookRivalWin:killAllSpeakTween()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList or{}
for i,v in ipairs(disciplesList)do
self:killSpeakTween(i)
end
end


function UICommonLookRivalWin:freshModels()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList or{}
for _,model in ipairs(self.model)do
model:setActive(false)
end

for i,v in ipairs(disciplesList)do
local index=v.index
self.model[index]:setActive(true)

local widget=self.model[index]:getChildWidgetBase(-1)

local dzData=v.data
local baseData=dzData.base
local image=UIDiscipleModel.calculationDiscipleImageBase(baseData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
widget:SetChildUIModelShowTarget(0,modelParams.body,0.8,modelParams.componets,modelParams.anim)

if modelParams.hideWeapon==nil then
local Slot=cfgHelper.get2(cfg_disciplevocationconfig_get,image.job,'lybslotname')
local slotName=Slot[2]
local weaponID=UIDiscipleModel:getDiscipleWeaponIDByDzData(dzData,true)or 0

if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
if equipCfg~=nil then
weaponID=equipCfg.imageID
else
weaponID=0
end
end
if weaponID>0 then
local out=cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side')
widget:SetChildLoadSlot(0,slotName or"wuqi",out)
end
end
widget:SetChildUIModelShowTargetOffset(0,0,-50)
widget:SetChildText(3,UIDiscipleModel:getJobName(image.job))
end
end


function UICommonLookRivalWin:freshInfo()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList or{}
local dzData=disciplesList[self.selectRoleIdx]and disciplesList[self.selectRoleIdx].data or nil

if dzData then
self.dzInfoPanel:setActive(true)
self.notInfoTips:setActive(false)
local netData=dzData.base


local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end
self.jingjie:setText(jj_str)

local ltlv=netData.liantilv
local n1,p1,pN=UIDiscipleModel:getLTNameX(ltlv)
local lt_lv_str=FMT.fmt('{0}层',p1 or 0)
local lt_str=FMT.fmt('{0}{1}',n1,pN)
self.lianti:setText(lt_str)

self:freshLayout()
self:freshGFSkillSlot()


if self.lookType~=DOUFATAI_LOOK_TYPE.eZongMenDaBiWatchOtherTeam and
self.lookType~=DOUFATAI_LOOK_TYPE.eWDCQ_OtherTeam and
self.lookType~=DOUFATAI_LOOK_TYPE.eXingYu_OtherTeam
then
self.infoBtn:setActive(true)
else
self.infoBtn:setActive(false)
end

if self.lookType==DOUFATAI_LOOK_TYPE.eLunDaoTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eXianFaWenDao or
self.lookType==DOUFATAI_LOOK_TYPE.eWDCQ_OtherTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eWDCQ_SelfTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eXingYu_OtherTeam or
self.lookType==DOUFATAI_LOOK_TYPE.eXingYu_SelfTeam
then
self:freshFaBaoSkill()
else
self:freshPolygonAtrrPanel()
end
else
self.dzInfoPanel:setActive(false)
self.notInfoTips:setActive(true)
end
end


function UICommonLookRivalWin:freshEquip()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
for equipType,idx in ipairs(equipSlotIndex)do
local equip
local equipLookup=dzData.equipLookup
if equipLookup~=nil then
equip=equipLookup[equipType]
end
self:fillItem(equip,idx)
end
end

function UICommonLookRivalWin:fillItem(equip,equipSlotIdx)
local prop={}
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
local scaleTable={}
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local star=0
local isLD=false
if itemsConfig.isFabao(itemid)then
isFabao=true
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
isLD=liandonModel:getIsLianDonItem(itemid)
elseif itemsConfig.isFubao(itemid)then
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isDaoBing(itemid)then
iconName=iconHelper.getIconName(itemid)
star=equip.itemData and equip.itemData.star or 0
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
stageStr=''
isLD=liandonModel:getIsLianDonItem(itemid)
end

if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,true)
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)

else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UICommonLookRivalWin:fillLingShouItem(lsData,equipSlotIdx)
local prop={}
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if lsData then
local ls_guid=lsData.guid
local color=lingshouModel:getColor(ls_guid)

prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemIconIdx)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemAdd)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemNew)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemReddot)]=false
prop[DataPropKey.eItemID]=lsData.id
prop[DataPropKey.eItemSeries]=ls_guid
else
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemQualityIdx)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemIconIdx)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemAdd)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemNew)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemReddot)]=false
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
end
self.equipListWidget:SetChildPropData(equipSlotIdx,prop)
if lsData then
comHelper.setChildModelRawImage_lingshou(widget,lsData.id,_itemWidgetIdx.cmpItemIconIdx,0,eHeadCenterType.eHead,1)
end
end


function UICommonLookRivalWin:freshGFSkillSlot()
for i=1,2 do
self:freshGFSkillSlotEx(i)
end
end

function UICommonLookRivalWin:freshGFSkillSlotEx(idx)
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
local gflist={}
local baseData=dzData.base

for i,v in ipairs(baseData.gongfaidList)do
local gfid=v
local gflv=0
if gfid>0 then gflv=baseData.gongfaListlookup[gfid].param_2 end
gflist[i]={gfid,gflv}
end
self.usingGFListLevel=gflist
self.usingGFList=baseData.gongfaidList

local slot=self.gfSlot[idx]
local slotItem=slot:getChildWidgetBase()
local gfID=self.usingGFList[idx]
local hasGF=gfID>0

slotItem:SetChildActive(0,hasGF)
if hasGF then
local gfIcon=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'icon')
slotItem:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)
end

slotItem:SetChildActive(1,hasGF)
if hasGF then
slotItem:SetChildText(2,UIGongFaModel:getGFLeverlStr(gflist[idx][2]))
end

local name_str=''
if hasGF then
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'name')
name_str=string.format('<color=#7d3b17>%s</color>',gfname)
else
name_str='尚未习得功法'
end

local showType=baseData.disType
if showType==dicipleType.eTemp then
name_str=''
end
slotItem:SetChildText(3,name_str)

if hasGF then
local isLD=liandonModel:getLianDonLinkageIdByGFId(gfID)>0
slotItem:SetChildActive(4,isLD)
else
slotItem:SetChildActive(4,false)
end
end

function UICommonLookRivalWin:freshFaBaoSkill()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
local equipItem=dzData.equipLookup and dzData.equipLookup[EQUIP_TYPE.eFabao]or nil
local shentongid,shentongLv
if equipItem then
shentongid,shentongLv=fabaoHelper.getShentongid(equipItem)
end
local slotItem=self.stSlot:getChildWidgetBase()
local has=shentongid~=nil

slotItem:SetChildActive(0,has)

slotItem:SetChildActive(1,has)
local name_str=''
if has then
local shentongConfig=fabaoConfig.getShentongConfig(shentongid)
local shentongIcon=iconHelper.getSkillIcon(shentongConfig.icon)
local shentongName=shentongConfig.name
slotItem:SetChildIcon(0,shentongIcon,false)
slotItem:SetChildText(2,FMT.fmt('{0}级',shentongLv))
name_str=string.format('<color=#7d3b17>%s</color>',shentongName)
self.stSlotFunc=function()
self:onStSlotFunc(shentongid,shentongLv)
end

else
name_str='尚未穿戴法宝'
self.stSlotFunc=nil
end

slotItem:SetChildText(3,name_str)
end


function UICommonLookRivalWin:freshPolygonAtrrPanel()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
local netData=dzData.base
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local color=image.color
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
for i,v in ipairs(netData.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
self.sixAttrText:setText(FMT.fmt('总值：{0}',allnum))

local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0} <color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
end


function UICommonLookRivalWin:freshVocSkillSlot()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
local netData=dzData.base
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local groupid=netData.vocsgidx
local skillList=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,image.job,netData.jingjielv,netData)

for i,v in ipairs(self.vocSkillSlot)do
if skillList[i]then
local widget=v:getWidgetBase()
local skillItem=widget:GetChildWidgetBase(0)
local data={}
data.skillID=skillList[i][1]
data.skillLv=skillList[i][2]
self:freshVocSkillSlotEx(skillItem,data)
end
end
end

function UICommonLookRivalWin:freshVocSkillSlotEx(item,data)

local skillID=data.skillID
local skillLv=data.skillLv
local skillCfg

skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

item:SetChildActive(4,not islock)
if not islock then
local c_skillLv=skillLv
item:SetChildText(2,skillModel:getSkillLvStr(c_skillLv))
end

item:SetChildActive(5,islock)


item:SetChildButtonClick(3,function()
self:onVocSkillItemClick(skillID,skillLv)
end)
end

function UICommonLookRivalWin:onVocSkillItemClick(skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZSkill,dis_guid=nil,changLv=false,fromCfg=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end


function UICommonLookRivalWin:freshLayout()
if self.lookType~=DOUFATAI_LOOK_TYPE.eWDCQ_OtherTeam and
self.lookType~=DOUFATAI_LOOK_TYPE.eXingYu_OtherTeam
then
self.equipRoot:setActive(true)
self.vocSkillRoot:setActive(false)
self.gongfaRoot:setChildAnchoredPos(0,0)
self.shentong:setChildAnchoredPos(5.5,-218)
self.polygonAttrPanel:setChildAnchoredPos(10,-193)
self:freshEquip()
else
self.equipRoot:setActive(false)
self.vocSkillRoot:setActive(true)
self.gongfaRoot:setChildAnchoredPos(0,30)
self.shentong:setChildAnchoredPos(5.5,-182.6)
self.polygonAttrPanel:setChildAnchoredPos(10,-180)
self:freshVocSkillSlot()
end
end





function UICommonLookRivalWin:onCloseBtn()
self:closeSelf()
end



function UICommonLookRivalWin:onInfoBtn()
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
self:showWindow('UICommonLookRival_attrDetailWin',{dzData=dzData})
end



function UICommonLookRivalWin:onGfSlot_1()
self:onGFSlotClick(1)
end



function UICommonLookRivalWin:onGfSlot_2()
self:onGFSlotClick(2)
end

function UICommonLookRivalWin:onStSlotFunc(skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZSTSkill,dis_guid=nil,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UICommonLookRivalWin:onStSlot()
if self.stSlotFunc then
self.stSlotFunc()
end
end

function UICommonLookRivalWin:onMask()
self:closeSelf()
end

function UICommonLookRivalWin:onBaseItemClick(id,equipType,guid,attach)
if id~=-1 then
if self.lookType==DOUFATAI_LOOK_TYPE.eZongMenDaBiWatchOtherTeam or self.lookType==DOUFATAI_LOOK_TYPE.eXianFaWenDao then
UIManager.error("无法查看装备信息")
return
end
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
local dzguid=dzData.base.discipleguid
tipsManager.showTips({itemid=id,itemguid=guid,formType=TIPS_FORM_TYPE.eWatchRoleItem,attach={diziguid=dzguid}})
end
end

function UICommonLookRivalWin:onLingShouItemClick(id,equipType,guid,attach)
if id>0 then
if self.lookType==DOUFATAI_LOOK_TYPE.eZongMenDaBiWatchOtherTeam then
UIManager.error("无法查看灵兽信息")
return
end
local disciplesList=self.teamList[self.selectTeamIndex].disciplesList
local dzData=disciplesList[self.selectRoleIdx].data
local dzguid=dzData.base.discipleguid
local lsData=otherPlayerModel:getDZLingShouData2(dzData)
UIManager:showWindow('UILingShouTipsWin',{dzOwner=dzguid,ls_guid=guid,lsData=lsData})
end
end

function UICommonLookRivalWin:onGFSlotClick(idx)
local gfID=self.usingGFList[idx]
local hasGF=gfID>0
if hasGF then
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=nil,gfID=gfID,gfLevel=self.usingGFListLevel[idx][2]})
end
end


function UICommonLookRivalWin:changeTitle(titleText)
self.title:setText(titleText)
end

function UICommonLookRivalWin:selectTeam(teamIndex)
self:refreshModelSelect(false)
self.selectTeamIndex=teamIndex
self.selectRoleIdx=nil
self:refresh()
end








def_class("UIDouFaTaiLookRivalWin",UIWindowBase)









function UIDouFaTaiLookRivalWin:bindComponents()

self.title=UIText.get(self,0)
self.roleList=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.sixAttrText=UIText.get(self,3)
self.jingjie=UIText.get(self,4)
self.model_5=UIObject.get(self,5)
self.model_3=UIObject.get(self,6)
self.model_2=UIObject.get(self,7)
self.model_1=UIObject.get(self,8)
self.model_4=UIObject.get(self,9)
self.infoBtn=UIButton.get(self,10)
self.equipslist=UIObject.get(self,11)
self.polygonAttrPanel=UIObject.get(self,12)
self.shentong=UIObject.get(self,13)
self.name=UIText.get(self,14)
self.speak=UIObject.get(self,15)
self.headKuang=UIImage.get(self,16)
self.name2=UIText.get(self,17)
self.headIcon=UIImage.get(self,18)
self.totalFightText=UIText.get(self,19)
self.lianti=UIText.get(self,20)
self.gfSlot_1=UIButton.get(self,21)
self.gfSlot_2=UIButton.get(self,22)
self.speakTxt=UIText.get(self,23)
self.stSlot=UIButton.get(self,24)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.gfSlot_1:setButtonClick(function()self:onGfSlot_1()end)

self.gfSlot_2:setButtonClick(function()self:onGfSlot_2()end)

self.stSlot:setButtonClick(function()self:onStSlot()end)
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



end


function UIDouFaTaiLookRivalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.roleList);self.roleList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.sixAttrText);self.sixAttrText=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.model_5);self.model_5=nil;
_UIObject_release(self.model_3);self.model_3=nil;
_UIObject_release(self.model_2);self.model_2=nil;
_UIObject_release(self.model_1);self.model_1=nil;
_UIObject_release(self.model_4);self.model_4=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.equipslist);self.equipslist=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.shentong);self.shentong=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.speak);self.speak=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.name2);self.name2=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.totalFightText);self.totalFightText=nil;
_UIObject_release(self.lianti);self.lianti=nil;
_UIObject_release(self.gfSlot_1);self.gfSlot_1=nil;
_UIObject_release(self.gfSlot_2);self.gfSlot_2=nil;
_UIObject_release(self.speakTxt);self.speakTxt=nil;
_UIObject_release(self.stSlot);self.stSlot=nil;
self.model=nil;
self.gfSlot=nil;
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
}


function UIDouFaTaiLookRivalWin:onLoaded(...)
self:bindComponents()
_this=self
self.speakTweens={}

self.equipListWidget=self.equipslist:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do

self.equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget:SetBaseItemChildIndex(idx,equipType)
end
end


function UIDouFaTaiLookRivalWin:__delete()
_this=nil
self:killAllSpeakTween()
self:unbindComponents()
end




function UIDouFaTaiLookRivalWin:onShow(argtable,afterOnloaded)
local lookType=argtable.lookType
local actor_id=argtable.actor_id
local sentence=argtable.sentence
local teamList=argtable.teamList
local extra=argtable.extra
self.argtable=argtable

self.lookType=lookType
local totalFight=0
local disciplesList={}
for i,v in ipairs(teamList)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
if UIDiscipleModel:isMyActorDZ(v.unitId)then
totalFight=totalFight+UIDiscipleModel:getDiscipleFightValue(v.unitId)
else
local data=otherPlayerModel:getDZData(v.unitId)
if data then
totalFight=totalFight+data:fightValNum_get()
end
end
table.insert(disciplesList,{guid=v.unitId,index=i})
end
end
self.disciplesList=disciplesList
self.totalFightText:setText(totalFight)

self:freshOtherInfo(lookType,actor_id,sentence,extra)
self:freshDisciplesList()
self:freshModels()
end

function UIDouFaTaiLookRivalWin:recv_actor_defense()

end


function UIDouFaTaiLookRivalWin:onHide()

end


function UIDouFaTaiLookRivalWin:freshOtherInfo(lookType,actorid,sentence,extra)
local actorInfo
actorid=tostring(actorid)
local isLunDao=false
if lookType==DOUFATAI_LOOK_TYPE.eRecord then
actorInfo=douFaTaiModel:getRecordActorInfo(actorid)
elseif lookType==DOUFATAI_LOOK_TYPE.eRank or lookType==DOUFATAI_LOOK_TYPE.eMain then
actorInfo=douFaTaiModel:getRankActorInfo(actorid)
elseif lookType==DOUFATAI_LOOK_TYPE.eLunDaoTeam then
isLunDao=true
self.polygonAttrPanel:setActive(false)
self.shentong:setActive(true)
self.infoBtn:setActive(false)
self.title:setText("战斗阵容")
end
if isLunDao then
playerController:setHeadIcon(self.winid,self.headIcon:getID(),{scale=0.7,iconInfo=extra[2]})
local serverName=loginModel:getServerName(extra[1])
self.name2:setText(FMT.fmt("[{0}]\n{1}",serverName,extra[3]))
self.speak:setActive(false)
else
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local defaults=config.sentence

if actorInfo then
local otherHead,otherKuang,name,wendao,playerHeadInfo=douFaTaiModel:getDouFaTaiActorInfo(actorInfo)

if playerHeadInfo then
playerController:setHeadIcon(self.winid,self.headIcon:getID(),{scale=0.7,iconInfo=playerHeadInfo})
end

self.name:setText(name)

if sentence==''then
local rand=math.random(1,#defaults)
sentence=defaults[rand]
end
self.speakTxt:setText(sentence)
else

end
end

end


function UIDouFaTaiLookRivalWin:freshDisciplesList()
local num=#self.disciplesList
self.roleList:setChildLayoutGroupCreateItems(num,function(index)
local item=self.roleList:getChildLayoutGroupGridItem(index-1)
local data=self.disciplesList[index]
local diziguid=data.guid
item:SetChildActive(-1,true)
item:SetChildButtonClickWithID(0,function(index)
self.onClickRoleItem(index)
end,index)

if UIDiscipleModel:isMyActorDZ(diziguid)then
local name=UIDiscipleModel:getDiscipleName(diziguid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(diziguid)
item:SetChildText(2,name)
comHelper.setChildModelRawImage(item,diziguid,1,0,eHeadCenterType.eHead)
local fight=UIDiscipleModel:getDiscipleFightValue(diziguid)
item:SetChildText(3,FMT.fmt('{0}',fight))

comHelper.setChildModelHeadIconBGByColor(item,5,imageInfo.color)
else
local dzData=otherPlayerModel:getDZData(diziguid)
local baseData=dzData.base
item:SetChildText(2,baseData.disciplename)
item:SetChildText(3,FMT.fmt('{0}',dzData:fightValNum_get()))
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(baseData)
comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eHead)

comHelper.setChildModelHeadIconBGByColor(item,5,dzData.color or 1)
end


end)
self.onClickRoleItem(1)
end

function UIDouFaTaiLookRivalWin.onClickRoleItem(index)
if _this.selectRoleIdx==index then return end
if _this.selectRoleIdx then
local lastItem=_this.roleList:getChildLayoutGroupGridItem(_this.selectRoleIdx-1)
lastItem:SetChildActive(4,false)
_this:refreshModelSelect(false)
end
_this.selectRoleIdx=index
local item=_this.roleList:getChildLayoutGroupGridItem(_this.selectRoleIdx-1)
item:SetChildActive(4,true)
_this:freshInfo()
_this:refreshModelSelect(true)
end


function UIDouFaTaiLookRivalWin:freshModels()
for i,v in ipairs(self.disciplesList)do
local diziguid=v.guid
local index=v.index
self.model[index]:setActive(true)

local widget=self.model[index]:getChildWidgetBase(-1)
if UIDiscipleModel:isMyActorDZ(diziguid)then

local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(diziguid)
widget:SetChildUIModelShowTarget(0,modelParams.body,0.8,modelParams.componets,modelParams.anim)

if modelParams.hideWeapon==nil then
local job=UIDiscipleModel:getDiscipleJob(diziguid)
local Slot=cfgHelper.get2(cfg_disciplevocationconfig_get,job,'lybslotname')
local slotName=Slot[2]
local weaponID=UIDiscipleModel:getDiscipleShowWeaponID(diziguid,true)or 0
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
widget:SetChildText(3,UIDiscipleModel:getJobNameX(diziguid))
else
local dzData=otherPlayerModel:getDZData(diziguid)
local baseData=dzData.base
local image=UIDiscipleModel.calculationDiscipleImageBase(baseData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
widget:SetChildUIModelShowTarget(0,modelParams.body,0.8,modelParams.componets,modelParams.anim)

if modelParams.hideWeapon==nil then
local Slot=cfgHelper.get2(cfg_disciplevocationconfig_get,image.job,'lybslotname')
local slotName=Slot[2]
local weaponID=UIDiscipleModel:getDiscipleShowWeaponID(diziguid,true)or 0

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
end

function UIDouFaTaiLookRivalWin:refreshModelSelect(flag)
self:killSpeakTween(self.selectRoleIdx)
local data=self.disciplesList[self.selectRoleIdx]
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

function UIDouFaTaiLookRivalWin:killSpeakTween(index)
if self.speakTweens[index]then
self.speakTweens[index]:Kill(false)
self.speakTweens[index]=nil
end
end

function UIDouFaTaiLookRivalWin:killAllSpeakTween()
for i,v in ipairs(self.disciplesList)do
self:killSpeakTween(i)
end
end


function UIDouFaTaiLookRivalWin:freshInfo()
local data=self.disciplesList[self.selectRoleIdx]
local diziguid=data.guid
self.diziguid=diziguid

local netData
if UIDiscipleModel:isMyActorDZ(diziguid)then
netData=UIDiscipleModel:getDiscipleData(diziguid)
else
netData=otherPlayerModel:getDZBaseData(diziguid)
end


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

self:freshEquip()
self:freshGFSkillSlot()
if self.lookType==DOUFATAI_LOOK_TYPE.eLunDaoTeam then
self:freshFaBaoSkill()
else
self:freshPolygonAtrrPanel()
end

end


function UIDouFaTaiLookRivalWin:freshEquip()
local diziguid=self.diziguid
for equipType,idx in ipairs(equipSlotIndex)do

local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if not equip then
equip=otherPlayerModel:getDZEquipData(diziguid,equipType)
end
self:fillItem(equip,idx)
end
end

function UIDouFaTaiLookRivalWin:fillItem(equip,equipSlotIdx)
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
if itemsConfig.isFabao(itemid)then
isFabao=true
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isFubao(itemid)then
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isDaoBing(itemid)then
iconName=iconHelper.getIconName(itemid)
star=equip.itemData and equip.itemData.star or 0
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
stageStr=''
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
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIDouFaTaiLookRivalWin:fillLingShouItem(lsData,equipSlotIdx)
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

function UIDouFaTaiLookRivalWin:onBaseItemClick(id,equipType,guid,attach)

if equipType==EQUIP_TYPE.eZhuZhan then

end
if self.lookType==DOUFATAI_LOOK_TYPE.eLunDaoTeam then
UIManager.error("无法查看装备信息")
return
end
if id~=-1 then
local move=TIPS_MOVE_POS.eLeft
if itemsConfig.isFabao(id)and fabaoConfig.isBenMingFabao(id)then move=TIPS_MOVE_POS.eDefault end
tipsManager.showTips({itemid=id,itemguid=guid,move=move,formType=TIPS_FORM_TYPE.eWatchRoleItem,attach={diziguid=self.diziguid}})
end
end

function UIDouFaTaiLookRivalWin:onLingShouItemClick(id,equipType,guid,attach)
if id>0 then
UIManager:showWindow('UILingShouTipsWin',{dzOwner=self.diziguid,ls_guid=guid})
end
end


function UIDouFaTaiLookRivalWin:freshGFSkillSlot()
for i=1,2 do
self:freshGFSkillSlotEx(i)
end
end

function UIDouFaTaiLookRivalWin:freshGFSkillSlotEx(idx)
local diziguid=self.diziguid
local gflist={}
if UIDiscipleModel:isMyActorDZ(diziguid)then
local netData=UIDiscipleModel:getDiscipleData(diziguid)
self.usingGFList=UIDiscipleModel:getDiscipleUsingGFList(netData)
else
local dzData=otherPlayerModel:getDZData(diziguid)
local baseData=dzData.base

for i,v in ipairs(baseData.gongfaidList)do
local gfid=v
local gflv=0
if gfid>0 then gflv=baseData.gongfaListlookup[gfid].param_2 end
gflist[i]={gfid,gflv}
end
self.usingGFListLevel=gflist
self.usingGFList=baseData.gongfaidList
end
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
if UIDiscipleModel:isMyActorDZ(diziguid)then
local gflv=UIDiscipleModel:getDiscipleGFLevel(diziguid,gfID)
slotItem:SetChildText(2,UIGongFaModel:getGFLeverlStr(gflv))
else

slotItem:SetChildText(2,UIGongFaModel:getGFLeverlStr(gflist[idx][2]))
end
end

local name_str=''
if hasGF then
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'name')
name_str=string.format('<color=#7d3b17>%s</color>',gfname)
else
name_str='尚未习得功法'
end
if self.showType==dicipleType.eTemp then
name_str=''
end
slotItem:SetChildText(3,name_str)
end

function UIDouFaTaiLookRivalWin:onGFSlotClick(idx)
local gfID=self.usingGFList[idx]
local hasGF=gfID>0
if hasGF then
if UIDiscipleModel:isMyActorDZ(self.diziguid)then
local gflv=UIDiscipleModel:getDiscipleGFLevel(self.diziguid,gfID)
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=nil,gfID=gfID,gfLevel=gflv})
else
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=nil,gfID=gfID,gfLevel=self.usingGFListLevel[idx][2]})
end

end
end

function UIDouFaTaiLookRivalWin:freshFaBaoSkill()
local diziguid=self.diziguid
local equipItem
if UIDiscipleModel:isMyActorDZ(diziguid)then
equipItem=equipsHelper.getEquipByDizi(diziguid,EQUIP_TYPE.eFabao)
else
equipItem=otherPlayerModel:getDZEquipData(diziguid,EQUIP_TYPE.eFabao)
end
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
self:onStSlotFunc(shentongid,shentongLv,diziguid)
end

else
name_str='尚未穿戴法宝'
self.stSlotFunc=nil
end

slotItem:SetChildText(3,name_str)
end

function UIDouFaTaiLookRivalWin:onStSlotFunc(skillID,skillLv,diziguid)
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZSTSkill,dis_guid=nil,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UIDouFaTaiLookRivalWin:onStSlot()
if self.stSlotFunc then
self.stSlotFunc()
end
end


function UIDouFaTaiLookRivalWin:freshPolygonAtrrPanel()
local diziguid=self.diziguid
local netData,color
if UIDiscipleModel:isMyActorDZ(diziguid)then
netData=UIDiscipleModel:getDiscipleData(diziguid)
color=UIDiscipleModel:getDiscipleColor(diziguid)
else
local dzData=otherPlayerModel:getDZData(diziguid)
netData=dzData.base
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
color=image.color
end
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


function UIDouFaTaiLookRivalWin:onCloseBtn()
UIFullDouFaTaiControl:closeWindow(self.winlua.name)
end

function UIDouFaTaiLookRivalWin:onInfoBtn()
UIManager:showWindow('UIDouFaTaiRivalAttrDetailWin',{guid=self.diziguid})
end

function UIDouFaTaiLookRivalWin:onGfSlot_1()
self:onGFSlotClick(1)
end

function UIDouFaTaiLookRivalWin:onGfSlot_2()
self:onGFSlotClick(2)
end

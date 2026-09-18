







def_class("UIXianJie_marchTeamDetailWin",UIWindowBase)









function UIXianJie_marchTeamDetailWin:bindComponents()

self.actorListPanel=UIScrollView.get(self,0)
self.attrListContent=UIObject.get(self,1)
self.attrPanel=UIObject.get(self,2)
self.attrTitle=UIObject.get(self,3)
self.detailBtn=UIButton.get(self,4)
self.dzPanel=UIObject.get(self,5)
self.equipItem_1=UIBaseItem.get(self,6)
self.equipItem_2=UIBaseItem.get(self,7)
self.equipItem_3=UIBaseItem.get(self,8)
self.equipSlot=UIBaseItem.get(self,9)
self.inifGrid=UIObject.get(self,10)
self.mbg=UIObject.get(self,11)
self.playerName=UIText.get(self,12)
self.roleListPanel=UIObject.get(self,13)
self.skillItem_1=UIObject.get(self,14)
self.skillItem_2=UIObject.get(self,15)
self.skillItem_3=UIObject.get(self,16)
self.teamXSCountText=UIText.get(self,17)
self.xsTotleCountText=UIText.get(self,18)
self.yunZhouPanel=UIObject.get(self,19)
self.zhuzaPanel=UIObject.get(self,20)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)
self.equipItem={
self.equipItem_1,
self.equipItem_2,
self.equipItem_3,
}
self.skillItem={
self.skillItem_1,
self.skillItem_2,
self.skillItem_3,
}



end


function UIXianJie_marchTeamDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorListPanel);self.actorListPanel=nil;
_UIObject_release(self.attrListContent);self.attrListContent=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.attrTitle);self.attrTitle=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.dzPanel);self.dzPanel=nil;
_UIObject_release(self.equipItem_1);self.equipItem_1=nil;
_UIObject_release(self.equipItem_2);self.equipItem_2=nil;
_UIObject_release(self.equipItem_3);self.equipItem_3=nil;
_UIObject_release(self.equipSlot);self.equipSlot=nil;
_UIObject_release(self.inifGrid);self.inifGrid=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.skillItem_1);self.skillItem_1=nil;
_UIObject_release(self.skillItem_2);self.skillItem_2=nil;
_UIObject_release(self.skillItem_3);self.skillItem_3=nil;
_UIObject_release(self.teamXSCountText);self.teamXSCountText=nil;
_UIObject_release(self.xsTotleCountText);self.xsTotleCountText=nil;
_UIObject_release(self.yunZhouPanel);self.yunZhouPanel=nil;
_UIObject_release(self.zhuzaPanel);self.zhuzaPanel=nil;
self.equipItem=nil;
self.skillItem=nil;
end
















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
cmpSuitIcon=13,
cmpLiandon=14,
cmpBtn=15,
}

local _this




function UIXianJie_marchTeamDetailWin:onLoaded(...)
self:bindComponents()
_this=self
self.actorList={}

self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.actorListPanel:setClickAction(self._on_select_dis)
end


function UIXianJie_marchTeamDetailWin:__delete()
self:unbindComponents()
self.actorList=nil
_this=nil
end

function UIXianJie_marchTeamDetailWin:showModel()

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6010,1,nil,eAnimationID.stand,false,false,0,nil)
end




function UIXianJie_marchTeamDetailWin:onShow(argtable,afterOnloaded)
self.massActorId=argtable.massActorId
self.massGuid=argtable.massGuid
self.actorList=argtable.list or{}
self.curActorIndex=1
self.curActorId=self.actorList[self.curActorIndex].actorid
self.actorListPanel:setActive(#self.actorList>1)

for i=1,#self.actorList do
local bonusList=self.actorList[i].bonusList or{}
if#bonusList>0 then
if not self.bonusList then
self.bonusList={}
end
for ii=1,#bonusList do
local attr=bonusList[ii]
self.bonusList[attr.param_1]=(self.bonusList[attr.param_1]or 0)+attr.param_2
end
end
end

if#self.actorList>1 then
self:refreshActorList()
for i=1,#self.actorList do
if self.actorList[i].isleader==1 then
self.boatList=self.actorList[i].boatList
end
end
end
self.detailBtn:setActive(self.massGuid~=nil)

self:refreshWin()
self:setXiuShiTotle()
self:showModel()

local canvas=argtable.canvas
if canvas then
self:setCanvasIndex(-1,canvas)
end
end

function UIXianJie_marchTeamDetailWin:refreshWin()
local actorData=self.actorList[self.curActorIndex]

local zmData=xianjieModel:getZongMenData(actorData.actorid)
self.playerName:setText(FMT.fmt("所属玩家：{0}",zmData.actorname))

local discipleList=actorData.discipleList or{}

self.dzPanel:setActive(#discipleList>0)
if#discipleList>0 then
self.roleListPanel:setChildScrollViewCreateGrids(#discipleList,5)
local teamGrids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=teamGrids.Count
for i=1,count do
local item=teamGrids[i-1]
local netdata=discipleList[i]
local has=netdata~=nil and netdata.flag>0
item:SetChildActive(-1,has)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)


local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)
item:SetChildCSImageSprite(0,abname,iconname)

UIDiscipleModel:setDiscipleXianMoBackImage(item,28,netdata)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

item:SetChildText(2,netdata.disciplename)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(3,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netdata.jingjielv)
item:SetChildText(5,lv_str)

item:SetChildActive(6,true)
item:SetChildText(6,tostring(mathHelper.int64_to_number(netdata.fightvalue)))

item:SetChildText(4,'')

UIDiscipleController.refreshCommonItemTianMing(item,netdata)

local isLD=liandonModel:getLianDonLinkageIdByDZId(netdata.id)>0
item:SetChildActive(27,isLD)


local func=function()
if _this==nil then return end
_this:onHeadClick(i)
end
item:SetChildButtonClick(-1,func,true)
end
end
end


local totleNum=0
if actorData.moneylistlen>0 then
local XBlist={}
local listLockup={}
for i,v in pairs(actorData.moneyList)do
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(v.param_1)
if soldierLevel and soldierLevel>0 then
if not listLockup[soldierLevel]then
listLockup[soldierLevel]={}
listLockup[soldierLevel].type=soldierLevel
listLockup[soldierLevel].num=0
end
listLockup[soldierLevel].num=listLockup[soldierLevel].num+v.param_2
totleNum=totleNum+v.param_2
end
end
for i,v in pairs(listLockup)do
XBlist[#XBlist+1]=v
end
local XBlistLen=#XBlist
self.inifGrid:setChildLayoutGroupCreateItems(XBlistLen)
local inifGrids=self.inifGrid:getChildLayoutGroupGridList()
for i=1,XBlistLen do
local data=XBlist[i]
local item=inifGrids[i-1]
item:SetChildActive(-1,data~=nil)
if data then
local type=data.type
local num=data.num

local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,type)
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
item:SetChildCSImageSprite(0,iconAb,cfg.bgIcon)
item:SetChildCSImageSprite(1,iconAb,cfg.nameIcon)
item:SetChildText(2,num)
end
end
end
self.teamXSCountText:setText(FMT.fmt("随队修士总数：{0}",totleNum))
self.inifGrid:setActive(actorData.moneylistlen>0)

local boatList=self.boatList or actorData.boatList or{}
local isShowBoat=#boatList>0 and boatList[1].zq4listlen>0
self.yunZhouPanel:setActive(isShowBoat)
if isShowBoat then

self:refreshBoatEquipList()

end
self.attrPanel:setActive(true)
self:refreshAttrPanel()
end

function UIXianJie_marchTeamDetailWin:refreshBoatEquipList()
local actorData=self.actorList[self.curActorIndex]
local boatList=self.boatList or actorData.boatList
local zq4List=boatList[1].zq4List or{}
self.equipList={}
for i,v in ipairs(zq4List)do
local itemid=v.itemid
local type1=itemsConfig.getConfig(itemid).type1
self.equipList[type1]=v
end

for i=1,3 do
self:refreshEquipItemEx(i)
end
end

function UIXianJie_marchTeamDetailWin:refreshEquipItemEx(idx)
local widget=self.equipItem[idx]:getChildWidgetBase()
local equip=self.equipList[idx]
local typename
if idx==1 then
typename="龙首"
elseif idx==2 then
typename="龙骨"
else
typename="阵炉"
end
widget:SetChildText(_itemWidgetIdx.cmpItemAdd,typename)
widget:SetChildText(_itemWidgetIdx.cmpItemName,typename)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=false
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=''
local star=stage

local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local iconName=iconHelper.getIconName(itemid)
local reddot=false
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)


widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
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
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIXianJie_marchTeamDetailWin:onClickYunZhouComponents(pos)
local equip=self.equipList[pos]
local suitData=XianYunGangModel:getOtherPlayerYunZhouComponentsSuitData(self.equipList)
if equip then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchRoleItem,itemguid=equip.itemguid,itemid=equip.itemid,attach={suitData=suitData,itemData=equip.itemData,pos=pos}})
end
end

function UIXianJie_marchTeamDetailWin:refreshBoatEquipSlot()
self.skillList={}

local widget=self.equipSlot:getChildWidgetBase()
local equip=nil
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local star=0

local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local iconName=itemsModel.getIconName(equip)
local reddot=false
local suitIconName=equipsHelper.getEquipSuitIcon(equip)


widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildText(_itemWidgetIdx.cmpItemName,"")
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)


if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end
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
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end

for i=1,3 do
self:refreshSkillSlotEx(i)
end
end

function UIXianJie_marchTeamDetailWin:refreshSkillSlotEx(idx,showEffect)
local skillItem=self.skillItem[idx]
local item=skillItem:getChildWidgetBase()
local d=self.skillList[idx]
if d then
local skillID=d[1]
local skillLv=d[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
item:SetChildActive(-1,true)

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

item:SetChildActive(4,not islock)
if not islock then
local c_skillLv=skillLv
if st==eSkillTipsType.eDZGFSkill then
c_skillLv=UIDiscipleModel:getSkillLv(self.disciple_guid,skillID,c_skillLv)
end
item:SetChildText(2,skillModel:getSkillLvStr(c_skillLv))
end

item:SetChildActive(5,islock)

item:SetChildText(7,skillCfg.name)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(eSkillTipsType.eDZGFSkill,skillID,skillLv)
end)
else
item:SetChildActive(-1,false)
end
end

function UIXianJie_marchTeamDetailWin:refreshAttrPanel()
local attrList=self.bonusList or{}
local attrTypes={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eYZ_Speed,
eAttributeType.ePoZhen,
eAttributeType.eJunSha,
}
local attrTypeData={
[eAttributeType.eJZATK_PCT]={icon=6},
[eAttributeType.eJZDEF_PCT]={icon=1},
[eAttributeType.eJZHP_PCT]={icon=2},
[eAttributeType.eYZ_Speed]={icon=3,attr=10000},
[eAttributeType.ePoZhen]={icon=5,attr=10000},
[eAttributeType.eJunSha]={icon=7,attr=0},
}

self.attrTitle:setActive(#self.actorList>1)

self.attrListContent:setChildLayoutGroupCreateItems(#attrTypes)
local grids=self.attrListContent:getChildLayoutGroupGridList()
for i=1,#attrTypes do
local item=grids[i-1]
local attrID=attrTypes[i]

local attrValue=(attrTypeData[attrID].attr or 0)+(attrList[attrID]or 0)
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attrID)

item:SetChildText(0,attrCfg.attrname)
item:SetChildText(1,helper.getAttributeStrEx(attrID,attrValue))
item:SetChildCSImageSprite(2,YUNZHOU_ABNAME,FMT.fmt("icon_yunzhoushuxing_{0}",attrTypeData[attrID].icon))
end
end

function UIXianJie_marchTeamDetailWin:setXiuShiTotle()
local totle=0
for i,v in pairs(self.actorList)do
local moneyList=v.moneyList or{}
for ii,vv in pairs(moneyList)do
totle=totle+vv.param_2
end
end

self.xsTotleCountText:setText(FMT.fmt("集结队伍修士总数：{0}",totle))
end

function UIXianJie_marchTeamDetailWin:refreshActorList()
local tNum=#self.actorList
self.actorListPanel:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.actorListPanel:getGridObjectByindex(i-1)
local actorData=self.actorList[i]


local zmData=xianjieModel:getZongMenData(actorData.actorid)
playerController:setHeadIcon(item,0,{iconInfo=zmData.iconInfo,scale=0.8})


item:SetChildActive(2,i==1)


item:SetChildActive(3,actorData.isleader==1)


local isSelect=self.curActorId==actorData.actorid
if isSelect then
idx=i
self.curActorIndex=idx
end
self:changItemSelect(item,isSelect)

end
self.actorListPanel:jumpToLockX(idx)
end

function UIXianJie_marchTeamDetailWin:changItemSelect(item,isSelect)
item:SetChildActive(1,isSelect)
end

function UIXianJie_marchTeamDetailWin:on_select_dis(id,index,guid,attach)
if self.curActorIndex==index then return end

local old=self.curActorIndex
self.curActorIndex=index
if old then
local olditem=self.actorListPanel:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.actorListPanel:getGridObjectByindex(self.curActorIndex-1)
self:changItemSelect(item,true)

self:refreshWin()
end

function UIXianJie_marchTeamDetailWin:onHeadClick(index)
local actorData=self.actorList[self.curActorIndex]
local actorId=actorData.actorid
local dzlist=actorData.discipleList or{}
local isSelf=playerModel:checkActorId(actorId)
local netData=dzlist[index]
local dzGuidList={}
local dzDataList={}
local needNewData=false
for posIndex,netData in ipairs(dzlist)do
local guid=netData.discipleguid
local has=netData~=nil and netData.flag>0
if has then
local dzData_=otherPlayerModel:getDZData(guid)
if not dzData_ then
needNewData=true
end
dzGuidList[#dzGuidList+1]=guid
dzDataList[#dzDataList+1]=dzData_
end
end
if isSelf then
otherPlayerController:openSelfPlayerDZInfoWin(dzGuidList,netData.discipleguid)
else
if not needNewData then

otherPlayerController:openOtherPlayerDZInfoWin2(netData.discipleguid,dzDataList)
else
local zmData=xianjieModel:getZongMenData(actorId)
local serverid=zmData.serverid

local attach={serverid=serverid}
otherPlayerController:openOtherPlayerDZInfoWin(actorId,netData.discipleguid,needNewData,true,attach,dzGuidList)
end
end

end


function UIXianJie_marchTeamDetailWin:onHide()

end





function UIXianJie_marchTeamDetailWin:onDetailBtn()
self:showWindow("UIXianJie_JiJie_teamInfoWin",{
isTeamInfo=true,
massActorId=self.massActorId,
massGuid=self.massGuid,
showMemberIndex=self.curActorIndex,
})
end
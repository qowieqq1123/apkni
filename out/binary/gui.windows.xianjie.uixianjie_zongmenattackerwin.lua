







def_class("UIXianJie_ZongMenAttackerWin",UIWindowBase)









function UIXianJie_ZongMenAttackerWin:bindComponents()

self.animFan=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.dazhenBtn=UIButton.get(self,2)
self.menu=UIObject.get(self,3)
self.notLog=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.scrollView=UIScrollView.get(self,6)
self.ScrollView=UILoopListView.new(self,7)
self.ToggleGroup=UIObject.get(self,8)
self.toggleTip=UIToggleButton.get(self,9)
self.zhiyuanBtn=UIButton.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.dazhenBtn:setButtonClick(function()self:onDazhenBtn()end)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.zhiyuanBtn:setButtonClick(function()self:onZhiyuanBtn()end)



end


function UIXianJie_ZongMenAttackerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animFan);self.animFan=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dazhenBtn);self.dazhenBtn=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
_UIObject_release(self.toggleTip);self.toggleTip=nil;
_UIObject_release(self.zhiyuanBtn);self.zhiyuanBtn=nil;
end















local _this=nil
local menu_slot_name='button_dytab'
local _iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
local itemCmp={
teamGrid=0,
fightValue=1,
xmName=2,
playerName=3,
time=4,
signIcon=5,
signBGIcon=6,
signKuangIcon=7,
levelNameIcon=8,
nameIcon=9,
num=10,
xuhao=11,
headIcon=12,
clock=13,
gotoBtn=14,
suiduiRoot=15,
m_headicon=16,
m_headKuang=17,
}

local _showType={
[ATTACKTYPE.eMoJun]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_mojieui_wz1"},
}
local _colorKuang={
[monType.LittleMonster]=2,
[monType.EliteMonster]=3,
[monType.Boss]=5,
[monType.BigBoss]=5,
[monType.GodAnimal]=5,
}
local _showColorType={
[ATTACKTYPE.eMoJun]=monType.Boss,
}




local menuList=
{
{
name="仙界",
checkOpen=function()
return xianjieModel:isUnderAttack_Type(ATTACKTYPE.eXJActor)
end,
getData=function()
return xianjieModel:getAttackInfoList(ATTACKTYPE.eXJActor)
end,
tabType=ATTACKTABTYPE.eXJ
},
{
name="魔界",
checkOpen=function()
local flag=xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMJActor)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMoZong)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMoJun)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eZhenYan)
return flag
end,
getData=function()
local list={}
local typeList=xianjieModel:getListAttackType(ATTACKTABTYPE.eMJ)
for _,attackType in ipairs(typeList)do
local infoList=xianjieModel:getAttackInfoList(attackType)
if infoList then
for __,v in ipairs(infoList)do
table.insert(list,v)
end
end
end
return list
end,
tabType=ATTACKTABTYPE.eMJ
},
{
name="魔宫",
checkOpen=function()
return xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMoGong)
end,
getData=function()
local list={}
local typeList=xianjieModel:getListAttackType(ATTACKTABTYPE.eMG)
for _,attackType in ipairs(typeList)do
local infoList=xianjieModel:getAttackInfoList(attackType)
if infoList then
for __,v in ipairs(infoList)do
table.insert(list,v)
end
end
end
return list
end,
tabType=ATTACKTABTYPE.eMG
},
}


function UIXianJie_ZongMenAttackerWin:onLoaded(...)
self:bindComponents()




_this=self
xianjieController:reqAttackerList()
end

function UIXianJie_ZongMenAttackerWin:__delete()
self:unbindComponents()
_this=nil
end

function UIXianJie_ZongMenAttackerWin:onShow(argtable,afterOnloaded)
self.tabType=argtable.tabType or ATTACKTABTYPE.eXJ





self:onRecvUpdate(afterOnloaded)


local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZMAttacktipEx)
self.toggleTip:setToggle(flag==true)
self.toggleTip:setToggleChange(function(name,isOn)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZMAttacktipEx,isOn)


if isOn then
UIManager:closeWindow('UIXianJie_ZMttackerWin')
else
if xianjieModel:isUnderAttack()then

UIManager:showWindow('UIXianJie_ZMttackerWin',{notifyAttack=false,attackType=nil})
end
end
end)
end

function UIXianJie_ZongMenAttackerWin:onHide()

end

function UIXianJie_ZongMenAttackerWin:onRecvUpdate(afterOnloaded)
self:freshMenuList(afterOnloaded)
if#self.menuList<=0 then
self:onRefresh()
return
end
local menuItem=self.menuList[self.curSelectPage]
self:onRefresh(menuItem.getData())
end



function UIXianJie_ZongMenAttackerWin:freshMenuList(afterOnloaded)

local default
local menu={}
self.curSelectPage=1
for i,v in ipairs(menuList)do
if v.checkOpen()then
table.insert(menu,v)



if self.tabType==v.tabType then
self.curSelectPage=#menu
end
end
end
self.menuList=menu

if#menu>0 then
self.ToggleGroup:setActive(true)

local tNum=#menu



















self.ToggleGroup:setChildLayoutGroupCreateItems(tNum)
for i=1,tNum do
local data=menu[i]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildButtonClickWithID(0,self.onToggleChange,i,true)
item:SetChildNewBieComponentId(0,FMT.fmt('UIXianJie_ZongMenAttackerWin.toggleListItem_{0}',i))
item:SetChildText(1,data.name)

local isSelected=self.curSelectPage==i

local func=function()
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end

if afterOnloaded then
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
else
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_stand,false,false,0,func)
end

















item:SetChildActive(3,false)
end
else
self.ToggleGroup:setActive(false)
end


end

function UIXianJie_ZongMenAttackerWin:triggerToggle(idx)
self.onToggleChange(idx)
end


function UIXianJie_ZongMenAttackerWin.onToggleChange(idx)

if _this.curSelectPage~=idx then
if _this.curSelectPage then
_this:setToggleOn(_this.curSelectPage,false)
end
_this.curSelectPage=idx
_this.tabType=_this.menuList[idx].tabType
_this:setToggleOn(_this.curSelectPage,true)

_this:onRecvUpdate()
local menuItem=_this.menuList[idx]
_this:onRefresh(menuItem.getData())
end
end

function UIXianJie_ZongMenAttackerWin:setToggleOn(index,on)
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpSelectRoot=2,
cmpSelectIcon=3,
cmpReddot=4,
}

function UIXianJie_ZongMenAttackerWin:fillMenu(index,config)
local tabType=config.name
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selectMenuIdx=self.selectMenuIdx

local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,selectMenuIdx==index)

item:SetChildNewBieComponentId(-1,FMT.fmt('UIXianJie_ZongMenAttackerWin.btnClick.{0}',index))
end

function UIXianJie_ZongMenAttackerWin:on_click_callback(id,index,guid,attach)
local oldIndex=self.selectMenuIdx
self.selectMenuIdx=index
self:freshMenuSelect(oldIndex)
self:freshMenuSelect(index)

local menuItem=self.menuList[index]
self:onRefresh(menuItem.getData())
end

function UIXianJie_ZongMenAttackerWin:freshMenuSelect(index)
if index==nil then
return
end
local item=self.winlua:GetChildCSGUIBaseItem(index-1)
if item then
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,self.selectMenuIdx==index)
end
end




function UIXianJie_ZongMenAttackerWin:onCloseBtn()
self:closeSelf()
end



function UIXianJie_ZongMenAttackerWin:onZhiyuanBtn()
if not xianmengModel:hasXM()then
UIManager.error('请先加入仙盟')
return
end
local data,mountid,buildid=zongmenControl:getBuilding({type=SLG_SYSTEM_TYPE.eYingXianGe})
local fit=data~=nil
if not fit then
UIManager.error('未建造迎仙阁，无法发起求援')
return
end


local zmData=xianjieModel:getMyZongMenData()
if not zmData then
logErr("没有宗门数据 分享错误 这个界面应该在仙魔界打开 ")
return
end
local posX=zmData.gridX
local posZ=zmData.gridZ
local sceneidx=zmData.sceneidx
local params=chatEmotHelper.getXJQiuYuanShareJson(sceneidx,posX,posZ,self.tabType)
local channelIds={CHAT_CHANNNEL.eXianmeng}
chatControl:reqShare(CHAT_REGEX_TYPE.csFairyLandHelp,params,channelIds,{})
jumpManager:jump({id=JUMP_TYPE.eChatWin,args={channelId=CHAT_CHANNNEL.eXianmeng}})
end


function UIXianJie_ZongMenAttackerWin:onDazhenBtn()
self:showWindow('UITianShuDaZhenUseWin')
end

function UIXianJie_ZongMenAttackerWin:onRefresh(attackerList)
if self.menuList==nil or next(self.menuList)==nil then self:onCloseBtn()return end
self.attackerList=attackerList or{}
self.notLog:setActive(#self.attackerList==0)
self.zhiyuanBtn:setChildImageExGray(not xianmengModel:hasXM())
self.dazhenBtn:setActive(not(self.menuList[self.curSelectPage].tabType==ATTACKTABTYPE.eMG))
if#self.attackerList>0 then
self.ScrollView:initData('item',self.attackerList)
self:startLeftTimer()
else
self.ScrollView:initData('item',{})
self:stopLeftTimer()

return
end
end

function UIXianJie_ZongMenAttackerWin:onStartAction()

end

function UIXianJie_ZongMenAttackerWin:onFreshAction(index,widget,attacker)
widget:SetChildText(itemCmp.xuhao,index)

local attacktype=attacker.attacktype
if not attacktype then
logErr("数据没有袭击类型")
return
end
local playerNamePosY=-31.5
local fightStr,xMName,actorName="","",""
local showXmIcon=false
local showSuiDuiRoot=false
local bzId,bzCnt

if attacktype==ATTACKTYPE.eXJActor or attacktype==ATTACKTYPE.eMJActor or attacktype==ATTACKTYPE.eMJActor_dazhen or attacktype==ATTACKTYPE.eMoGong then
local actorid=attacker.actorid
fightStr=FMT.fmt("队伍实力：<color=#000000>{0}</color>",mathHelper.formatNumber3(mathHelper.int64_to_number(attacker.fightvalue)))
xMName=attacker.guildname
actorName=attacker.actorname
showXmIcon=true
showSuiDuiRoot=attacker.moneylistlen>0
if showSuiDuiRoot then
local firstData=attacker.moneyList[1]
local maxtype=-1
for i,v in ipairs(attacker.moneyList)do
if maxtype<v.param_1 then
maxtype=v.param_1
firstData=v
end
end
local type=firstData.param_1
bzId=yunjiayingModel:getSoldierLevelByMoneyType(type)
bzCnt=firstData.param_2
end

local dzList={}
local dzList_={}
local dzlen=attacker.disciplelistlen
for i=1,dzlen do
local baseData=table.weakCopy(attacker.discipleList[i])
if baseData.flag>0 then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(baseData)
table.insert(dzList,dzData)
table.insert(dzList_,dzData.base.discipleguid)
end
end


widget:SetChildLayoutGroupCreateItems(itemCmp.teamGrid,#dzList)
local teamGrids=widget:GetChildLayoutGroupGridList(itemCmp.teamGrid)
for i=1,#dzList do
local dzData=dzList[i]
local baseData=dzData.base
local dizi_guid=baseData.discipleguid
local discipledata=baseData.discipledata
local discipleimage=baseData.discipleimage
local jingjielv=baseData.jingjielv

local item=teamGrids[i-1]
local image=UIDiscipleModel.calculationDiscipleImage(discipledata,discipleimage)


local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildActive(2,true)
local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(2,globalABLookup.global,jobicon)
item:SetChildActive(3,false)
item:SetChildText(4,jingjielv)

comHelper.setChildModelHeadIconBGByColor(item,0,image.color or 1)

local func=function()
otherPlayerController:reqOtherPlayerDZList(actorid,#dzList_,dzList_,0,{isXianJie=true,stilsid=true})
end
item:SetChildButtonClick(-1,func,true)
end
widget:SetChildActive(itemCmp.headIcon,true)
widget:SetChildActive(itemCmp.m_headKuang,false)
playerController:setHeadIcon(widget,itemCmp.headIcon,{iconInfo=attacker.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

elseif attacktype==ATTACKTYPE.eMoZong or attacktype==ATTACKTYPE.eMoJun or attacktype==ATTACKTYPE.eZhenYan then
local infoid=attacker.infoid
local infoguid=attacker.infoguid
local entitytype=attacker.entitytype
local name=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,entitytype,'configname')
local func=cfgHelper.getCofingGetFunction(name)
local cfg=cfgHelper.get1(func,infoid)
local groupid=(attacktype==ATTACKTYPE.eMoZong or attacktype==ATTACKTYPE.eZhenYan)and cfg.monster[2]or cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
actorName=groupcfg.name
showSuiDuiRoot=attacker.soldierlistlen>0
if showSuiDuiRoot then
bzId=-1
for i,v in ipairs(attacker.soldierList)do
if bzId<v.param_1 then
bzId=v.param_1
bzCnt=v.param_2
end
end
end
widget:SetChildActive(itemCmp.headIcon,false)
widget:SetChildActive(itemCmp.m_headKuang,true)
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,itemCmp.m_headicon,0,eHeadCenterType.eHead)
local monList=groupcfg.monList
local monListEx={}
for i,v in ipairs(monList)do
if v~=0 then
table.insert(monListEx,v)
end
end

widget:SetChildLayoutGroupCreateItems(itemCmp.teamGrid,#monListEx)
local teamGrids=widget:GetChildLayoutGroupGridList(itemCmp.teamGrid)
for i=1,#monListEx do
local monId=monListEx[i]
local item=teamGrids[i-1]


local mcfg=cfgHelper.get1(cfg_monsterconfig_get,monId)
if mcfg.job then
item:SetChildActive(2,true)
local jobicon=UIDiscipleModel:getJobIconName(mcfg.job)
item:SetChildCSImageSprite(2,globalABLookup.global,jobicon)
else
item:SetChildActive(2,false)
end

item:SetChildActive(3,false)
item:SetChildText(4,"")
local monType=mcfg.monType
if _showColorType[attacktype]then
monType=_showColorType[attacktype]
end

comHelper.setChildModelHeadIconBGByColor(item,0,_colorKuang[monType]or 0)

local func=function()

end
item:SetChildButtonClick(-1,func,true)
comHelper.setChildModelRawImage_monster(item,monId,1,0,eHeadCenterType.eHead)
end
if(attacktype==ATTACKTYPE.eMoZong or attacktype==ATTACKTYPE.eZhenYan)and groupcfg.fightVal then
fightStr=FMT.fmt("队伍实力：<color=#000000>{0}</color>",mathHelper.formatNumber3(groupcfg.fightVal))
else
playerNamePosY=-61
end
end

if _showType[attacktype]then
widget:SetChildCSImageSprite(18,_showType[attacktype][1],_showType[attacktype][2])
end

widget:SetChildLocalPosY(itemCmp.playerName,playerNamePosY)
widget:SetChildText(itemCmp.fightValue,fightStr)
widget:SetChildText(itemCmp.xmName,xMName)
widget:SetChildText(itemCmp.playerName,actorName)
widget:SetChildActive(itemCmp.signBGIcon,showXmIcon)
if showXmIcon then
local image=xianmengModel.splitGuildIcon(attacker.guildicon)
local abname=globalABLookup.xianmengicons

local iconCfg=cfgHelper.get2(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon)
if iconCfg and iconCfg.icon then
widget:SetChildCSImageSprite(itemCmp.signIcon,abname,iconCfg.icon)
end


local bgCfg=cfgHelper.get2(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg)
if bgCfg and bgCfg.icon then
widget:SetChildCSImageSprite(itemCmp.signBGIcon,abname,bgCfg.icon)
end


local kuangCfg=cfgHelper.get2(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang)
if kuangCfg and kuangCfg.icon then
widget:SetChildCSImageSprite(itemCmp.signKuangIcon,abname,kuangCfg.icon)
end
end

local teamData=xianjieModel:getMarchTeamData(attacker.marchguid)
local teamHandle=teamData and teamData:getTeamHandle()or nil
if teamHandle then
local lerpTime=teamHandle:geLerpTime()
if lerpTime<0 then lerpTime=0 end
widget:SetChildText(itemCmp.time,timeHelper.format_time_stamp(lerpTime))
widget:SetChildActive(itemCmp.clock,true)
widget:SetChildActive(itemCmp.gotoBtn,false)
else
widget:SetChildText(itemCmp.time,"")
widget:SetChildActive(itemCmp.clock,false)
widget:SetChildActive(itemCmp.gotoBtn,true)
local tabType=self.tabType
widget:SetChildButtonClick(itemCmp.gotoBtn,function()
local sName=""
if attacktype==ATTACKTYPE.eXJActor then
sName="仙界"
elseif attacktype==ATTACKTYPE.eMJActor_dazhen then
else
sName="魔界"
end
local content=FMT.fmt("是否前往{0}？",sName)
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
if attacktype~=ATTACKTYPE.eXJActor then
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eMoJie,tabType=tabType}})
else
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eSelfZMPos}})
end
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end)
end

widget:SetChildActive(itemCmp.suiduiRoot,showSuiDuiRoot)
if showSuiDuiRoot then
local cfg=cfg_fairylandsoldierconfig_get(bzId)
widget:SetChildCSImageSprite(itemCmp.levelNameIcon,_iconAb,cfg.bgIcon)
widget:SetChildCSImageSprite(itemCmp.nameIcon,_iconAb,cfg.nameIcon)
widget:SetChildText(itemCmp.num,mathHelper.formatNumber2(bzCnt))
end


end

function UIXianJie_ZongMenAttackerWin:startLeftTimer()
if self.tickTimer then return end
local tick=function()
local startindex,endindex=self.ScrollView:getVisableIndex()
for i=endindex,startindex,-1 do
local attacker=self.attackerList[i]
if attacker then
local widget=self.ScrollView:getItemWidget(i)
local teamData=xianjieModel:getMarchTeamData(attacker.marchguid)
local teamHandle=teamData and teamData:getTeamHandle()or nil
if teamHandle then
local lerpTime=teamHandle:geLerpTime()
if lerpTime<0 then lerpTime=0 end
widget:SetChildText(4,timeHelper.format_time_stamp(lerpTime))


end
end
end
end
self.tickTimer=self:setTimer(1,0,tick)
end

function UIXianJie_ZongMenAttackerWin:stopLeftTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
end

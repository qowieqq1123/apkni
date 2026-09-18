







def_class("UIYingXianGeWDYJWin",UIWindowBase)









function UIYingXianGeWDYJWin:bindComponents()

self.chehuiAllBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.notLog=UIObject.get(self,3)
self.progress=UIProgress.get(self,4)
self.progressText=UIText.get(self,5)
self.root=UIObject.get(self,6)
self.tabItem_1=UIObject.get(self,7)
self.tabItem_2=UIObject.get(self,8)
self.tabItem_3=UIObject.get(self,9)
self.tabList=UIObject.get(self,10)
self.yuanjunGrid=UIObject.get(self,11)

self.chehuiAllBtn:setButtonClick(function()self:onChehuiAllBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)
self.tabItem={
self.tabItem_1,
self.tabItem_2,
self.tabItem_3,
}



end


function UIYingXianGeWDYJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chehuiAllBtn);self.chehuiAllBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tabItem_1);self.tabItem_1=nil;
_UIObject_release(self.tabItem_2);self.tabItem_2=nil;
_UIObject_release(self.tabItem_3);self.tabItem_3=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.yuanjunGrid);self.yuanjunGrid=nil;
self.tabItem=nil;
end


















local yjCmp={
teamGrid=0,
chejunBtn=1,
selfImage=2,
panel2=3,
headBG=4,
fightValue=5,
head=6,
xbValue=7,
levelTx=8,
playerName=9,
item=10,
inifGrid=11,
jtBtn=12,
jt1=13,
jt2=14,
}

local _tabCmp={
root=-1,
clickBtn=0,
nameTx=1,
}

local menu_slot_name="button_dytab"


local _tabConfig={
{
name="仙界",
sceneidx=xianjienSceneIndexType.eXianJie,
isOpen=function()
return true
end,
isSelect=function()
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx==nil then return false end
return sceneidx==xianjienSceneIndexType.eXianJie or xianjienSceneIndexType:isXianYu(sceneidx)
end,
reqData=function(actorID)
YingXianGeController.reqZhiYuan_MoJie(actorID)
end,
},
{
name="魔界",
sceneidx=xianjienSceneIndexType.eMoJie,
isOpen=function()

return xianjieModel:checkCurrentMoJieEnterTime()
end,
isSelect=function()
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx==nil then return false end
return xianjienSceneIndexType:isMoJie(sceneidx)
end,
reqData=function(actorID)
YingXianGeController.reqZhiYuan_XianJie(actorID)
end,
},
{
name="魔宫",
sceneidx=xianjienSceneIndexType.eMoGongZhengDuo,
isOpen=function()

return xianjieController:checkInMoGongZhengDuo()
end,
isSelect=function()
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx==nil then return false end
return xianjieController:checkInMoGongZhengDuo(sceneidx)
end,
reqData=function(actorID)
YingXianGeController.reqZhiYuan_MoGong(actorID)
end,
}
}



function UIYingXianGeWDYJWin:onLoaded(...)
self:bindComponents()

self.tabSelectIdx=1
self.sceneidx=_tabConfig[self.tabSelectIdx].sceneidx

local _onSeasonChange=function(...)
self:onSeasonChange(...)
end
self:addNotify(notifyConfig.onSeasonChange,_onSeasonChange)
end


function UIYingXianGeWDYJWin:__delete()
self:unbindComponents()
end




function UIYingXianGeWDYJWin:onShow(argtable,afterOnloaded)
self:refreshTabList()
self:refresh()
end


function UIYingXianGeWDYJWin:onHide()

end

function UIYingXianGeWDYJWin:refresh()
self.seleIdx=nil
self:refreshList()
self:refreshYuanZhu()
end

function UIYingXianGeWDYJWin:refreshTabList()

self.tabConfig={}
for index,config in ipairs(_tabConfig)do
if config.isOpen()then
self.tabConfig[#self.tabConfig+1]=config
end
end

self.tablen=#self.tabConfig
local isShowTab=self.tablen>1
self.tabList:setActive(isShowTab)

self.tabSelectIdx=1
self.sceneidx=self.tabConfig[self.tabSelectIdx].sceneidx

if not isShowTab then
return
end

for index,config in ipairs(self.tabConfig)do
if config:isSelect()then
self.tabSelectIdx=index
self.sceneidx=self.tabConfig[self.tabSelectIdx].sceneidx
break
end
end

self:reqCurrentData()

if self.tablen>1 then
self.banClickTab=#self.tabConfig
for i,v in ipairs(self.tabItem)do
local config=self.tabConfig[i]
local isShow=config~=nil
local widget=v:getChildWidgetBase()
widget:SetChildActive(-1,isShow)

if isShow then
widget:SetChildButtonClick(_tabCmp.clickBtn,function()
self:onClickTab(i)
end)
widget:SetChildUIModelShowTarget(_tabCmp.root,2017,1,{},eAnimationID.common_window_enter,false,false,0,function()
self:refreshTabSelect(widget,self.tabSelectIdx==i)
widget:SetChildCanvasGroupAlpha(_tabCmp.nameTx,1)
self.banClickTab=self.banClickTab-1
widget:SetChildText(_tabCmp.nameTx,config.name)
end)
end
end
end
end

function UIYingXianGeWDYJWin:reqCurrentData()
local config=self.tabConfig[self.tabSelectIdx]
config.reqData(playerModel:getActorID())
end

function UIYingXianGeWDYJWin:onClickTab(index)

if self.banClickTab>0 then return end
if self.tabSelectIdx~=index then
self:refreshTabSelectEx(self.tabSelectIdx,false)
self.tabSelectIdx=index
self:refreshTabSelectEx(self.tabSelectIdx,true)
self.sceneidx=self.tabConfig[self.tabSelectIdx].sceneidx
self:reqCurrentData()
self:refresh()
end
end

function UIYingXianGeWDYJWin:refreshTabSelectEx(index,select)
local item=self.tabItem[index]:getChildWidgetBase()
self:refreshTabSelect(item,select)
end

function UIYingXianGeWDYJWin:refreshTabSelect(item,select)
local name=FMT.fmt("{0}_{1}",menu_slot_name,select and 2 or 1)
item:SetChildUIModelShowSlotAttachment(_tabCmp.root,menu_slot_name,name)
end

function UIYingXianGeWDYJWin:refreshYuanZhu()
local actorId=playerModel:getActorID()
local list=YingXianGeModel:getYZMYList(actorId,self.sceneidx)
self.chehuiAllBtn:setActive(#list>0)

local cur,max=YingXianGeModel:getYZMYTotleXB(actorId,self.sceneidx)
self.progress:setProgressValue(cur,max)
self.progress:setChildProgressText(FMT.fmt("{0}/{1}",cur,max))
end

function UIYingXianGeWDYJWin:refreshList()
local actorId=playerModel:getActorID()
local list=YingXianGeModel:getYZMYList(actorId,self.sceneidx)
local len=#list

self.notLog:setActive(len<=0)

self.yuanjunGrid:setChildLayoutGroupCreateItems(len)
local grids=self.yuanjunGrid:getChildLayoutGroupGridList()
for idx=1,len do











local yjData=list[idx]
local itemCmp=grids[idx-1]
local isSelfPlayer=playerModel:checkActorId(yjData.actor_id)
local fightStr=mathHelper.formatNumber(tonumber(tostring(yjData.fightvalue)))

playerController:setHeadIcon(itemCmp,yjCmp.head,{iconInfo=yjData.icon})

itemCmp:SetChildText(yjCmp.levelTx,yjData.sectlevel)
itemCmp:SetChildText(yjCmp.playerName,yjData.actorname)
itemCmp:SetChildText(yjCmp.fightValue,FMT.fmt("战力：{0}",fightStr))
itemCmp:SetChildActive(yjCmp.selfImage,isSelfPlayer)
itemCmp:SetChildActive(yjCmp.panel2,false)
itemCmp:SetChildActive(yjCmp.jt1,false)
itemCmp:SetChildActive(yjCmp.jt2,true)

local dzList={}
for i=1,yjData.disciplelistlen do
local baseData=table.weakCopy(yjData.guidlist[i])
if baseData.flag>0 then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(baseData)
table.insert(dzList,dzData)
end
end
local disciplelistlen=#dzList
itemCmp:SetChildLayoutGroupCreateItems(yjCmp.teamGrid,disciplelistlen)
local teamGrids=itemCmp:GetChildLayoutGroupGridList(yjCmp.teamGrid)
for i=1,disciplelistlen do
local dzData=dzList[i]
local baseData=dzData.base
local dizi_guid=baseData.discipleguid
local discipledata=baseData.discipledata
local discipleimage=baseData.discipleimage
local jingjielv=baseData.jingjielv

local item=teamGrids[i-1]
local image=UIDiscipleModel.calculationDiscipleImage(discipledata,discipleimage)

comHelper.setChildModelHeadIconBGByColor(item,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,item,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
item:SetChildCSImageSprite(4,globalABLookup.diciplecolorframe,discipleColorToFrame3[image.color])
item:SetChildActive(4,jingjielv>0)
item:SetChildText(5,jingjielv)


local func=function()
otherPlayerController:openOtherPlayerDZInfoWinEXX(yjData.actor_id,dzList,dizi_guid)
end
item:SetChildButtonClick(-1,func,true)
end

local totleNum=0
if yjData.moneylistlen>0 then
local XBlist={}
local listLockup={}
for i,v in pairs(yjData.moneylist)do
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
local moneylistlen=#XBlist
itemCmp:SetChildLayoutGroupCreateItems(yjCmp.inifGrid,moneylistlen)
local inifGrids=itemCmp:GetChildLayoutGroupGridList(yjCmp.inifGrid)
for i=1,moneylistlen do
local data=XBlist[i]
local item=inifGrids[i-1]
item:SetChildActive(-1,data~=nil)
if data then
local type=data.type
local num=data.num

local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,type)
item:SetChildCSImageSprite(0,iconAb,cfg.bgIcon)
item:SetChildCSImageSprite(1,iconAb,cfg.nameIcon)
item:SetChildText(2,num)
end
end
end
itemCmp:SetChildText(yjCmp.xbValue,FMT.fmt("修士：{0}",totleNum))
itemCmp:SetChildActive(yjCmp.jtBtn,yjData.moneylistlen>0)

itemCmp:SetChildButtonClick(yjCmp.chejunBtn,function()
local showdata=
{
type='UIDialouge',
title='提示',
content='祖师是否要撤回援军？',
oktext='撤回',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
local infoguid_str=tostring(yjData.guid)
local guid=int64.new(infoguid_str)
local params={tostring(yjData.actor_id),1}
local pstr=jsonHelper.encode(params)
local sceneidx=self.tabConfig[self.tabSelectIdx].sceneidx
xianjieController:reqOrder(guid,xjOrderType.eCheHuiYuanZhu,{},{},pstr,nil,nil,nil,sceneidx)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end)

itemCmp:SetChildButtonClick(yjCmp.jtBtn,function()
if idx==self.seleIdx then
self.seleIdx=nil
itemCmp:SetChildActive(yjCmp.panel2,false)
itemCmp:SetChildActive(yjCmp.jt1,false)
itemCmp:SetChildActive(yjCmp.jt2,true)
else
local oldIdx=self.seleIdx
if oldIdx then
grids[oldIdx-1]:SetChildActive(yjCmp.panel2,false)
grids[oldIdx-1]:SetChildActive(yjCmp.jt1,false)
grids[oldIdx-1]:SetChildActive(yjCmp.jt2,true)
end
self.seleIdx=idx
itemCmp:SetChildActive(yjCmp.panel2,true)
itemCmp:SetChildActive(yjCmp.jt1,true)
itemCmp:SetChildActive(yjCmp.jt2,false)
end
end)
end
end





function UIYingXianGeWDYJWin:onCloseBtn()
self:closeSelf()
end



function UIYingXianGeWDYJWin:onHelpBtn()
local d={}
d.title='我的援军规则'
d.mode=3
d.name='yxg_wdyj_help_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIYingXianGeWDYJWin:onChehuiAllBtn()

if self.touchTime and timeHelper.getServerShortTime()<self.touchTime+2 then
return
end
self.touchTime=timeHelper.getServerShortTime()
local actorId=playerModel:getActorID()
local sceneidx=self.tabConfig[self.tabSelectIdx].sceneidx
local list=YingXianGeModel:getYZMYList(actorId,sceneidx)
for i,v in ipairs(list)do
local infoguid_str=tostring(v.guid)
local guid=int64.new(infoguid_str)
local params={tostring(v.actor_id),1}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,xjOrderType.eCheHuiYuanZhu,{},{},pstr,nil,nil,nil,sceneidx)
end
end

function UIYingXianGeWDYJWin:onSeasonChange()
self:refreshTabList()
self:refresh()
end

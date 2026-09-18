







def_class("UIYingXianGeMYYJWin",UIWindowBase)









function UIYingXianGeMYYJWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.notLog=UIObject.get(self,2)
self.progress=UIProgress.get(self,3)
self.progressText=UIText.get(self,4)
self.root=UIObject.get(self,5)
self.tips=UIText.get(self,6)
self.yuanjunGrid=UIObject.get(self,7)
self.yuanzhuBtn=UIButton.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.yuanzhuBtn:setButtonClick(function()self:onYuanzhuBtn()end)



end


function UIYingXianGeMYYJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.yuanjunGrid);self.yuanjunGrid=nil;
_UIObject_release(self.yuanzhuBtn);self.yuanzhuBtn=nil;
end


















local yjCmp={
teamGrid=0,
chejunBtn=1,
selfImage=2,
panel2=3,
headBg=4,
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

local _this


function UIYingXianGeMYYJWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onXianJieWaiPaiChange,function(...)self:onXianJieWaiPaiChange(...)end)
end


function UIYingXianGeMYYJWin:__delete()
self:unbindComponents()
_this=nil
end

function UIYingXianGeMYYJWin:onXianJieWaiPaiChange(changeType,param)
if _this==nil then return end
local cur,max=YingXianGeModel:getYZMYTotleXB(self.actorId,self.sceneidx)
self.progress:setProgressValue(cur,max)
self.progress:setChildProgressText(FMT.fmt("{0}/{1}",cur,max))
end




function UIYingXianGeMYYJWin:onShow(argtable,afterOnloaded)
self.actorId=argtable.actorId
self.sceneidx=xianjieModel:getSceneIndex()
self:refresh()
end


function UIYingXianGeMYYJWin:onHide()

end

function UIYingXianGeMYYJWin:refresh()
self.seleIdx=nil
self:refreshList()
self:refreshYuanZhu()
end

function UIYingXianGeMYYJWin:refreshYuanZhu()
local cur,max=YingXianGeModel:getYZMYTotleXB(self.actorId,self.sceneidx)
self.progress:setProgressValue(cur,max)
self.progress:setChildProgressText(FMT.fmt("{0}/{1}",cur,max))

local actorId=playerModel:getActorID()
local isYuanZhu=YingXianGeModel:getYZMYItem(self.actorId,actorId,self.sceneidx)~=nil
local actorData=xianmengModel:getXMMemberData(self.actorId)
local hasWaiPai=YingXianGeModel:getHasYZXJ(self.actorId)
self.yuanzhuBtn:setActive(not isYuanZhu and actorData~=nil and actorData.yxg_lv>0 and not hasWaiPai)
end

function UIYingXianGeMYYJWin:refreshList()
self.yjList=YingXianGeModel:getYZMYList(self.actorId,self.sceneidx)
local len=#self.yjList

self.notLog:setActive(len<=0)

self.yuanjunGrid:setChildLayoutGroupCreateItems(len)
local grids=self.yuanjunGrid:getChildLayoutGroupGridList()
for idx=1,len do











local yjData=self.yjList[idx]
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

if isSelfPlayer then
local color=UIDiscipleModel:getDiscipleColor(dizi_guid)or 1

comHelper.setChildModelHeadIconBGByColor(item,1,color)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(dizi_guid)
comHelper.setChildModelRawImageEx(2,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(3,globalABLookup.global,UIDiscipleModel:getDiscipleJob(dizi_guid))
item:SetChildCSImageSprite(4,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
item:SetChildActive(4,jingjielv>0)
item:SetChildText(5,jingjielv)
else
local image=UIDiscipleModel.calculationDiscipleImage(discipledata,discipleimage)

comHelper.setChildModelHeadIconBGByColor(item,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,item,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
item:SetChildCSImageSprite(4,globalABLookup.diciplecolorframe,discipleColorToFrame3[image.color])
item:SetChildActive(4,jingjielv>0)
item:SetChildText(5,jingjielv)
end


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

local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,type)
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
item:SetChildCSImageSprite(0,iconAb,cfg.bgIcon)
item:SetChildCSImageSprite(1,iconAb,cfg.nameIcon)
item:SetChildText(2,num)
end
end
end
itemCmp:SetChildActive(yjCmp.jtBtn,yjData.moneylistlen>0)
itemCmp:SetChildText(yjCmp.xbValue,FMT.fmt("修士：{0}",totleNum))
itemCmp:SetChildActive(yjCmp.chejunBtn,isSelfPlayer)
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
local params={tostring(_this.actorId),0}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,xjOrderType.eCheHuiYuanZhu,{},{},pstr)
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






function UIYingXianGeMYYJWin:onCloseBtn()
self:closeSelf()
end



function UIYingXianGeMYYJWin:onHelpBtn()
local d={}
d.title='盟友援助规则'
d.mode=3
d.name='yxg_myyz_help_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIYingXianGeMYYJWin:onYuanzhuBtn()
local level=YingXianGeController:getBuildingLevel()
if not level or level==0 then
UIManager.error('祖师尚无迎仙阁，请前往建造')
return
end
local actorId=self.actorId
local zmData=xianjieModel:getZongMenData(actorId)
local flag,g_list,errorParams=zmData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法向本阵内祖师进行援助"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法向阵外祖师进行援助 "
else

errStr="处于阵内无法向其他本阵内祖师进行援助"
end
UIManager.error(errStr)
end
return
end
if not xianjieModel:checkWaiPaiTeamNum(true)then
UIManager.error('行军队伍不足')
return
end

local cur,max=YingXianGeModel:getYZMYTotleXB(actorId,self.sceneidx)
if max==0 then
UIManager.error('盟友未建迎仙阁，暂不能援助')
return
end
if cur>=max then
UIManager.error('盟友可容纳的援军队伍已达上限')
return
end


local orderType=xjOrderType.eYuanZhu
local isChuZheng,isCanChuZheng,errStr=xianjieModel:checkXJIsChuZheng(orderType,true)
if not isChuZheng or not isCanChuZheng then
local orderCfg=xianjieModel:getOrderConfig(orderType)
local needYzType=orderCfg[1]
if needYzType==1 then
UIManager.error("当前没有可用云舟")
end

return
end
local extraCost={}
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eYuanZhu,1)
local gridX=zmData.gridX
local gridZ=zmData.gridZ
local sceneidx=zmData.sceneidx
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX,gridZ,speed,nil,nil,nil)
wayTime=math.ceil(wayTime)

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(actorId)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local pstr=''
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end

return UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=orderType})
end


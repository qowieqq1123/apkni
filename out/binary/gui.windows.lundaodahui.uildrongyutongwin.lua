







def_class("UILDRongYuTongWin",UIWindowBase)









function UILDRongYuTongWin:bindComponents()

self.bgAnim=UIObject.get(self,0)
self.comboScrollView=UIComboScrollView.get(self,1)
self.jieShu=UIText.get(self,2)
self.lijieButton=UIButton.get(self,3)
self.rankInfo=UIObject.get(self,4)
self.spineOBJ=UIObject.get(self,5)
self.top1=UIObject.get(self,6)
self.top2=UIObject.get(self,7)
self.top3=UIObject.get(self,8)
self.top3Btn=UIButton.get(self,9)
self.topRankInfo=UIObject.get(self,10)
self.zanbg=UIObject.get(self,11)
self.zanNum=UIText.get(self,12)

self.lijieButton:setButtonClick(function()self:onLijieButton()end)

self.top3Btn:setButtonClick(function()self:onTop3Btn()end)



end


function UILDRongYuTongWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgAnim);self.bgAnim=nil;
_UIObject_release(self.comboScrollView);self.comboScrollView=nil;
_UIObject_release(self.jieShu);self.jieShu=nil;
_UIObject_release(self.lijieButton);self.lijieButton=nil;
_UIObject_release(self.rankInfo);self.rankInfo=nil;
_UIObject_release(self.spineOBJ);self.spineOBJ=nil;
_UIObject_release(self.top1);self.top1=nil;
_UIObject_release(self.top2);self.top2=nil;
_UIObject_release(self.top3);self.top3=nil;
_UIObject_release(self.top3Btn);self.top3Btn=nil;
_UIObject_release(self.topRankInfo);self.topRankInfo=nil;
_UIObject_release(self.zanbg);self.zanbg=nil;
_UIObject_release(self.zanNum);self.zanNum=nil;
end
















local RankTypeEnum={
LunDaoBang=1,
XianFaBang=2,
WenDingBang=3,
}

local RankTypeFuncGroup={
[RankTypeEnum.LunDaoBang]={
name="论道榜",
getSubItems=function(data)
return{}
end,
onRecv=function(self)
self:refreshTopPanel()
self.zanbg:setActive(true)
end,
freshPanel=function(self)
lundaodahuiController.req_17_30()
end,
subClickItem=function(self)
end,
getDiZanNum=function(self)
return lundaodahuiModel:getDzNum()
end,
getSpineInfo=function()
return 4032,0.5,eAnimationID.stand
end,
onClickLiJieBtn=function(self)
self:showWindow("UILDRongYuTongListWin")
end,
preFreshPanel=function(self)

self.jieShu:setActive(true)
self.rankInfo:setActive(true)
self.topRankInfo:setActive(false)
self.top3Btn:setActive(false)
self.lijieButton:setActive(true)
end,
checkUnlock=function()
return true
end,
getNumDescFmt=function()
return"点赞剩余次数：{0}"
end,
},
[RankTypeEnum.XianFaBang]={
name="仙法榜",
getSubItems=function(data)
local temp={}
local maxlv=zongmenModel:getZongMenLimitLv()
local cfgs=cfg_xianfawendaolevelconfig()
for i,v in ipairs(cfgs)do
local min=UIXianFaWenDaoControl:getPlatFormIdCfg(v.min)
if maxlv>=min then
temp[i]=v.name
end
end
return temp
end,
onRecv=function(self)
self:refreshTopPanelXF()
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
self.zanbg:setActive(isTruce)
end,
freshPanel=function(self)
self.level=UIXianFaWenDaoControl:getLevel()or 1
self.level=math.max(self.level,1)
self:refreshZanNum()
self:refreshTopPanelXF()
end,
subClickItem=function(self)
UIXianFaWenDaoControl:reqPreviousTopList(self.subSelectIndex+1)
end,
getDiZanNum=function(self)
return UIXianFaWenDaoControl:getLastLikestimes()
end,
getSpineInfo=function()
return 4712,1,eAnimationID.stand
end,
onClickLiJieBtn=function(self)
UIXianFaWenDaoControl:reqPreviousList()
self:showWindow("UIXFWDPreviousWin")
end,
preFreshPanel=function(self)

self.jieShu:setActive(true)
self.rankInfo:setActive(true)
self.topRankInfo:setActive(false)
self.top3Btn:setActive(false)
self.lijieButton:setActive(true)
end,
checkUnlock=function()
return true
end,
getNumDescFmt=function()
return"点赞剩余次数：{0}"
end,
},
[RankTypeEnum.WenDingBang]={
name="问鼎榜",
getSubItems=function(data)
local temp={}
local wdCfgs=WDCQController:getUnlockGroupCfgList()
for i,v in ipairs(wdCfgs)do
temp[i]=v.name
end
return temp
end,
onRecv=function(self)
self:refreshWDCQMBInfo()
self.zanbg:setActive(true)
end,
freshPanel=function(self)
self.level=WDCQController:getMaxChampionGroupIndex()
self.level=math.max(self.level,1)
self:refreshWDCQ()
self:refreshZanNum()
end,
subClickItem=function(self)
self:refreshWDCQ()
self:refreshZanNum()
end,
getDiZanNum=function(self)
return WDCQController.getHonorDianZanNum()
end,
getSpineInfo=function()
return 5588,0.55,eAnimationID.stand,{0,5}
end,
onClickLiJieBtn=function(self)end,
preFreshPanel=function(self)

self.jieShu:setActive(false)
self.rankInfo:setActive(false)
self.topRankInfo:setActive(true)
self.top3Btn:setActive(true)
self.lijieButton:setActive(false)

end,
checkUnlock=function()
return WDCQController.checkSysOpen()
end,
getNumDescFmt=function()
return"膜拜剩余次数：{0}"
end,
},
}

local CmpTop1WidgetIndex={
model=0,
noHave=1,
have=2,
name=3,
server=4,
iconHead=5,
mobai=6,
rank=7,
loseHave=8,
loseHead=9,
}



local cmpIndex=
{
model=0,
noHave=1,
headItem=2,
name=3,
zanBtn=4,
zanNum=5,
}

function UILDRongYuTongWin:onLoaded(...)
self:bindComponents()

if webGLHelper:isRunMiniGame()then
cameraControl.setCameraActive(false)
end

self.topWidget=
{
self.top1,self.top2,self.top3
}

notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:refreshTopPanel()
end)

self.cbMainTag={}
self.cbSubTag={}

self.subSelectIndex=0

for index,funcs in ipairs(RankTypeFuncGroup)do
if funcs.checkUnlock()then
self.cbMainTag[#self.cbMainTag+1]=funcs.name

local temp=funcs.getSubItems()
self.cbSubTag[#self.cbSubTag+1]=temp
end
end

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.comboScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
self.comboScrollView:createMainGrids(#self.cbMainTag,1,true)


self.requestServerNameCallBack=function()
if self and not self.isClose then
self:refreshWDBServerName()
end
end
loginRequestUpdate:registerRequest(REQUEST_TYPE.eRequestServer,self.requestServerNameCallBack)
end

function UILDRongYuTongWin:mainClickAction(mainItem)
if self.mainSelectIndex then
local item=self.comboScrollView:getMainItem(self.mainSelectIndex)
item:SetChildActive(0,false)
end
self.mainSelectIndex=mainItem.Index
local isExpanded=mainItem.isExpanded
mainItem:SetChildActive(0,isExpanded)
self.isExpanded=isExpanded





self:refresh(self.mainSelectIndex+1)
end

function UILDRongYuTongWin:subClickAction(subItem)
if self.subSelectIndex then
local item=self.comboScrollView:getSubItem(subItem.Mainindex,self.subSelectIndex)
if item then
item:SetChildActive(0,false)
end
end
self.subSelectIndex=subItem.Index
subItem:SetChildActive(0,true)

self:handleSubItemClick()

end

function UILDRongYuTongWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local isExpanded=mainItem.isExpanded
local name=self.cbMainTag[index]
local sublist=self.cbSubTag[index]
mainItem:SetChildActive(0,isExpanded)
mainItem:SetChildText(1,name)
mainItem:SetAddExpandColumCount(#sublist)
end

function UILDRongYuTongWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local sublist=self.cbSubTag[mainIndex]
local name=sublist[index]
local select=self.level==index
subItem:SetChildActive(0,select)
subItem:SetChildText(1,name)
if select then
self:subClickAction(subItem)
end
end

function UILDRongYuTongWin:onExpandAction(index)

end

function UILDRongYuTongWin:handleSubItemClick()
self.rankFunc.subClickItem(self)
end


function UILDRongYuTongWin:__delete()
loginRequestUpdate:unregisterRequest(REQUEST_TYPE.eRequestServer,self.requestServerNameCallBack)

self:unbindComponents()

if webGLHelper:isRunMiniGame()then
cameraControl.setCameraActive(true)
end
end




function UILDRongYuTongWin:onShow(argtable,afterOnloaded)
if argtable then
local ftype=argtable.ftype
self:refresh(ftype)
self.comboScrollView:clickItem(ftype-1)
self.comboScrollView:setActive(UIXianFaWenDaoControl:checkUnlockEx())
else
self.comboScrollView:setActive(false)
self:refresh()
end
end

function UILDRongYuTongWin:updateRankTypeFun(ftype)
self.rankFunc=RankTypeFuncGroup[ftype]
end

function UILDRongYuTongWin:refresh(ftype)
if ftype then
self.ftype=ftype
self:updateRankTypeFun(self.ftype)

self.rankFunc.freshPanel(self)
local spineId,scale,anim,offset=self.rankFunc.getSpineInfo()
self.spineOBJ:setChildUIModelShowTarget(spineId,scale,{},anim,false,false)
if offset then
self.spineOBJ:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

self:refreshZanNum()
end
end


function UILDRongYuTongWin:onHide()

end

function UILDRongYuTongWin:onRecv()
self.rankFunc.onRecv(self)
self:refreshZanNum()
end

function UILDRongYuTongWin:refreshTopPanelXF()
if not self.isExpanded then
return
end
self.rankFunc.preFreshPanel(self)

local level=self.subSelectIndex+1
local datas=UIXianFaWenDaoControl:getPreviousTopData(level)
local session=UIXianFaWenDaoControl:getSession()
self.jieShu:setText(FMT.fmt("第\n{0}\n届",session))
for i=1,3 do
local data=datas[i]
local widget=self.topWidget[i]:getChildWidgetBase()
if data then
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(6,true)

local grid=widget:GetChildWidgetBase(2)

local sname=loginModel:getServerName(data.serverid)
local name=playerModel:getOtherActorName(data.actorname)
if not data.actorname or data.actorname==""then
widget:SetChildText(3,FMT.fmt('<color=#f1ce78>[{0}]\n</color>{1}','未知区服',name))
playerController:setHeadIcon(grid,0,nil)
grid:SetChildActive(3,true)
else
widget:SetChildText(3,FMT.fmt('<color=#f1ce78>[{0}]\n</color>{1}',sname,name))
playerController:setHeadIcon(grid,0,{scale=0.55,iconInfo=data.iconInfo})
grid:SetChildActive(3,false)
end


if UIXianFaWenDaoControl:isInTruceTime()then
grid:SetChildActive(2,true)
grid:SetChildButtonClick(2,function()
if not data.actorname or data.actorname==""then
return
end
UIXianFaWenDaoControl:showActorInfo(data)
end)
else
grid:SetChildActive(2,false)
end

widget:SetChildText(5,data.times)

local image=UIDiscipleModel.calculationDiscipleImageBase(data)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
widget:SetChildUIModelShowTarget(0,modelParams.body,0.9,modelParams.componets,eAnimationID.stand)

widget:SetChildButtonClick(4,function()
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
if not isTruce then
UIManager.error('赛季期间不可点赞')
return
end
local zan=UIXianFaWenDaoControl:getLastLikestimes()
if zan>0 then
UIXianFaWenDaoControl:reqLike(level,i)
else
UIManager.error("次数不足")
end
end)
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
widget:SetChildActive(6,false)
end
end
end

function UILDRongYuTongWin:refreshTopPanel()
self.rankFunc.preFreshPanel(self)

local topData=lundaodahuiModel:getNewTop3Data()
if topData then
local jieshu=topData.jieShu or 1
local sanjieList={}
if topData.sjList then
for i,v in ipairs(topData.sjList)do
sanjieList[v.pos]=v
end
end
self.sanjieList=sanjieList
self.jieShu:setText(FMT.fmt("第\n{0}\n届",jieshu))
for i=1,3 do
local data=sanjieList[i]
local widget=self.topWidget[i]:getChildWidgetBase()
self:refreshTopWidget(widget,data,jieshu)
end
end
end

function UILDRongYuTongWin:refreshTopWidget(topWidget,playerData,jieshu)
if playerData then
topWidget:SetChildActive(0,true)
topWidget:SetChildActive(1,false)
topWidget:SetChildActive(6,true)
local serverName=loginModel:getServerName(playerData.serverId)
local name=playerModel:getOtherActorName(playerData.name)
local grid=topWidget:GetChildWidgetBase(2)
if not playerData.name or playerData.name==""then
topWidget:SetChildText(3,FMT.fmt("<color=#f1ce78>[{0}]\n</color>{1}",'未知区服',name))
grid:SetChildActive(3,true)
else
topWidget:SetChildText(3,FMT.fmt("<color=#f1ce78>[{0}]\n</color>{1}",serverName,name))
grid:SetChildActive(3,false)
lundaodahuiController:setHead(grid,playerData.iconInfo)
end



grid:SetChildButtonClick(2,function()
if not playerData.name or playerData.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(playerData.playerId,{playerData.serverId,playerData.iconInfo,playerData.name},true)
end,true)
topWidget:SetChildText(5,playerData.dzNum)
if tostring(playerData.discipleimage)~='0'then
if playerData.dressId~=0 then
playerData.clothingId=playerData.dressId
playerData.clothingStar=playerData.dressStar
end

local image=UIDiscipleModel.calculationDiscipleImageBase(playerData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)

topWidget:SetChildUIModelShowTarget(0,modelParams.body,0.9,modelParams.componets,eAnimationID.stand)
else
loggerUtil.logErrFMT("{0}形象数据为0，无法显示形象",playerData.name)
end
topWidget:SetChildButtonClick(4,function()
self:onClickDZ(jieshu,playerData.serverId,playerData.playerId)
end)
else
topWidget:SetChildActive(0,false)
topWidget:SetChildActive(1,true)
topWidget:SetChildActive(6,false)
end
end

function UILDRongYuTongWin:refreshTopZanNum()
local topData=lundaodahuiModel:getNewTop3Data()
if topData then
local sanjieList={}
if topData.sjList then
for i,v in ipairs(topData.sjList)do
sanjieList[v.pos]=v
end
end
for i=1,3 do
local data=sanjieList[i]
local widget=self.topWidget[i]:getChildWidgetBase()
if data then
widget:SetChildText(5,data.dzNum)
end
end
end
end

function UILDRongYuTongWin:refreshZanNum()
local zan=self.rankFunc.getDiZanNum()
local descFmt=self.rankFunc.getNumDescFmt()
self.zanNum:setText(FMT.fmt(descFmt,zan))
end

function UILDRongYuTongWin:onLijieButton()
self.rankFunc.onClickLiJieBtn(self)
end

function UILDRongYuTongWin:onClickDZ(jieShu,serverId,playerId)
local zan=lundaodahuiModel:getDzNum()
if zan<=0 then
UIManager.error("次数不足")
return
end
lundaodahuiController.req_17_29(jieShu,serverId,playerId)
end



function UILDRongYuTongWin:refreshWDCQ()
self.rankFunc.preFreshPanel(self)

local group=self.subSelectIndex+1


local top1RoleId
local top1RoleIconInfo
top1RoleId=WDCQModel:getRYBRankInfo(group,1)
if top1RoleId then
top1RoleIconInfo=WDCQModel:getRYBRankIconInfo(top1RoleId)
if not top1RoleIconInfo then
logErr("缺少 冠军 iconInfo ")
end
end



local isHasRole=top1RoleId~=nil and top1RoleIconInfo~=nil
local isLose=false
if isHasRole then
isLose=mathHelper.compareInt64(top1RoleIconInfo.actorId,Int64_0)
end

local widget=self.topRankInfo:getWidgetBase()
widget:SetChildActive(CmpTop1WidgetIndex.have,isHasRole)
widget:SetChildActive(CmpTop1WidgetIndex.noHave,not isHasRole and not isLose)
widget:SetChildActive(CmpTop1WidgetIndex.model,isHasRole)
widget:SetChildActive(CmpTop1WidgetIndex.loseHave,isLose)
widget:SetChildActive(CmpTop1WidgetIndex.loseHead,isLose)
widget:SetChildActive(CmpTop1WidgetIndex.iconHead,isHasRole and(not isLose))
widget:SetChildActive(CmpTop1WidgetIndex.mobai,isHasRole and(not isLose))

local actEnterState=WDCQController:checkRongYuBangEnter()
self:refreshWDCQMBInfo()
self.zanbg:setActive(isHasRole and actEnterState)

if isHasRole and(not isLose)then



playerController:setImage(widget,CmpTop1WidgetIndex.model,top1RoleIconInfo.sex,top1RoleIconInfo.iconInfo,playerController:supportDynamic(),0.7)
playerController:setHeadIcon(widget,CmpTop1WidgetIndex.iconHead,{scale=0.55,iconInfo=top1RoleIconInfo.iconInfo})

self.wdbServerId=top1RoleIconInfo.serverid
local serverName=loginModel:getServerName(top1RoleIconInfo.serverid)
serverName=FMT.fmt("[{0}]",serverName)
widget:SetChildText(CmpTop1WidgetIndex.server,serverName)
widget:SetChildText(CmpTop1WidgetIndex.name,playerModel:getOtherActorName(top1RoleIconInfo.actor_name))

widget:SetChildButtonClick(CmpTop1WidgetIndex.mobai,function()
local data=WDCQModel:getData()
local dznum=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'daily_like_max')
local num=data.dian_zan_cnt or 0
if dznum>num then
WDCQController.req_38_7()
else
UIManager.info('次数不足')
end
end,true)
end

if isLose then
local serverName=loginModel:getServerName(top1RoleIconInfo.serverid)
serverName=FMT.fmt("[{0}]",serverName)
widget:SetChildText(CmpTop1WidgetIndex.server,serverName)
widget:SetChildText(CmpTop1WidgetIndex.name,playerModel:getOtherActorName(top1RoleIconInfo.actor_name))
end
end

function UILDRongYuTongWin:refreshWDCQMBInfo()
local actEnterState=WDCQController:checkRongYuBangEnter()
local widget=self.topRankInfo:getWidgetBase()

widget:SetChildActive(CmpTop1WidgetIndex.mobai,actEnterState)
end

function UILDRongYuTongWin:onTop3Btn()
local group=self.subSelectIndex+1

local args={group=group}
self:showWindow('UIWDCQTop3Win',args)
end

function UILDRongYuTongWin:refreshWDBServerName()
if self.wdbServerId then
local widget=self.topRankInfo:getWidgetBase()
local serverName=loginModel:getServerName(self.wdbServerId)
serverName=FMT.fmt("[{0}]",serverName)
widget:SetChildText(CmpTop1WidgetIndex.server,serverName)
end
end





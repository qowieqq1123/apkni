







def_class("UIOthePlayerInfoWin",UIWindowBase)









function UIOthePlayerInfoWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.bgModel2=UIObject.get(self,1)
self.boatListPanel=UIObject.get(self,2)
self.boatTitle=UIObject.get(self,3)
self.btn1=UIButton.get(self,4)
self.btn1Txt=UIText.get(self,5)
self.btn2=UIButton.get(self,6)
self.btn2Txt=UIText.get(self,7)
self.btn3=UIButton.get(self,8)
self.btn3Txt=UIText.get(self,9)
self.buttonGridPanel=UIObject.get(self,10)
self.discipleModel=UIObject.get(self,11)
self.doufatai=UIText.get(self,12)
self.fight=UIText.get(self,13)
self.fightPanel=UIObject.get(self,14)
self.head=UIObject.get(self,15)
self.headReddot=UIObject.get(self,16)
self.iconGridPanel=UIObject.get(self,17)
self.ipBelongObj=UIObject.get(self,18)
self.ipBelongTxt=UIText.get(self,19)
self.level=UIText.get(self,20)
self.liandonBtn=UIButton.get(self,21)
self.moreBtn=UIButton.get(self,22)
self.notBoatListTips=UIText.get(self,23)
self.notRoleListTips=UIText.get(self,24)
self.pNameText=UIText.get(self,25)
self.pSexImg=UIImage.get(self,26)
self.roleListPanel=UIObject.get(self,27)
self.root=UIObject.get(self,28)
self.shaqiPanel=UIButton.get(self,29)
self.shaQiTitle=UIButton.get(self,30)
self.suoyaota=UIText.get(self,31)
self.titleText=UIText.get(self,32)
self.top5fight=UIText.get(self,33)
self.xianjiePanel=UIObject.get(self,34)
self.xianMengText=UIText.get(self,35)
self.xjBaoLeiLevelText=UIText.get(self,36)
self.xjJobInfoListPanel=UIObject.get(self,37)
self.xjShaQiNumText=UIText.get(self,38)
self.xjShiLiNameText=UIText.get(self,39)
self.xjTabBtn=UIButton.get(self,40)
self.xjTabText=UIText.get(self,41)
self.xjXiuShiNumText=UIText.get(self,42)
self.xjYunZhouFightText=UIText.get(self,43)
self.yuanzhuBtn=UIButton.get(self,44)
self.yuanzhuCount=UIText.get(self,45)
self.yuanzhuImage=UIImage.get(self,46)
self.zFight=UIObject.get(self,47)
self.zNameText=UIText.get(self,48)
self.zongmenPanel=UIObject.get(self,49)

self.btn1:setButtonClick(function()self:onBtn1()end)

self.btn2:setButtonClick(function()self:onBtn2()end)

self.btn3:setButtonClick(function()self:onBtn3()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.moreBtn:setButtonClick(function()self:onMoreBtn()end)

self.shaqiPanel:setButtonClick(function()self:onShaqiPanel()end)

self.shaQiTitle:setButtonClick(function()self:onShaQiTitle()end)

self.xjTabBtn:setButtonClick(function()self:onXjTabBtn()end)

self.yuanzhuBtn:setButtonClick(function()self:onYuanzhuBtn()end)



end


function UIOthePlayerInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.boatListPanel);self.boatListPanel=nil;
_UIObject_release(self.boatTitle);self.boatTitle=nil;
_UIObject_release(self.btn1);self.btn1=nil;
_UIObject_release(self.btn1Txt);self.btn1Txt=nil;
_UIObject_release(self.btn2);self.btn2=nil;
_UIObject_release(self.btn2Txt);self.btn2Txt=nil;
_UIObject_release(self.btn3);self.btn3=nil;
_UIObject_release(self.btn3Txt);self.btn3Txt=nil;
_UIObject_release(self.buttonGridPanel);self.buttonGridPanel=nil;
_UIObject_release(self.discipleModel);self.discipleModel=nil;
_UIObject_release(self.doufatai);self.doufatai=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.fightPanel);self.fightPanel=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headReddot);self.headReddot=nil;
_UIObject_release(self.iconGridPanel);self.iconGridPanel=nil;
_UIObject_release(self.ipBelongObj);self.ipBelongObj=nil;
_UIObject_release(self.ipBelongTxt);self.ipBelongTxt=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.moreBtn);self.moreBtn=nil;
_UIObject_release(self.notBoatListTips);self.notBoatListTips=nil;
_UIObject_release(self.notRoleListTips);self.notRoleListTips=nil;
_UIObject_release(self.pNameText);self.pNameText=nil;
_UIObject_release(self.pSexImg);self.pSexImg=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shaqiPanel);self.shaqiPanel=nil;
_UIObject_release(self.shaQiTitle);self.shaQiTitle=nil;
_UIObject_release(self.suoyaota);self.suoyaota=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.top5fight);self.top5fight=nil;
_UIObject_release(self.xianjiePanel);self.xianjiePanel=nil;
_UIObject_release(self.xianMengText);self.xianMengText=nil;
_UIObject_release(self.xjBaoLeiLevelText);self.xjBaoLeiLevelText=nil;
_UIObject_release(self.xjJobInfoListPanel);self.xjJobInfoListPanel=nil;
_UIObject_release(self.xjShaQiNumText);self.xjShaQiNumText=nil;
_UIObject_release(self.xjShiLiNameText);self.xjShiLiNameText=nil;
_UIObject_release(self.xjTabBtn);self.xjTabBtn=nil;
_UIObject_release(self.xjTabText);self.xjTabText=nil;
_UIObject_release(self.xjXiuShiNumText);self.xjXiuShiNumText=nil;
_UIObject_release(self.xjYunZhouFightText);self.xjYunZhouFightText=nil;
_UIObject_release(self.yuanzhuBtn);self.yuanzhuBtn=nil;
_UIObject_release(self.yuanzhuCount);self.yuanzhuCount=nil;
_UIObject_release(self.yuanzhuImage);self.yuanzhuImage=nil;
_UIObject_release(self.zFight);self.zFight=nil;
_UIObject_release(self.zNameText);self.zNameText=nil;
_UIObject_release(self.zongmenPanel);self.zongmenPanel=nil;
end
















local _maxBtnNum=3
local _this


function UIOthePlayerInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
local func=function()
if not self or self.isClose then return end
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.5)
end
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),
4047,
1,
nil,
eAnimationID.juanzhoubi_dakai,
false,
false,
-1,function()
if not self or self.isClose then return end
self:delayDo(0.2,func)
end)








local btnList={}
btnList[#btnList+1]=self.btn1
btnList[#btnList+1]=self.btn2
btnList[#btnList+1]=self.btn3
self.btnList=btnList

local btnListTxt={}
btnListTxt[#btnListTxt+1]=self.btn1Txt
btnListTxt[#btnListTxt+1]=self.btn2Txt
btnListTxt[#btnListTxt+1]=self.btn3Txt
self.btnListTxt=btnListTxt

self.xjTabBtn:setActive(false)
self.yuanzhuBtn:setActive(false)
end


function UIOthePlayerInfoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIOthePlayerInfoWin:onHide()

end




function UIOthePlayerInfoWin:onShow(argtable,afterOnloaded)
self.actorId=argtable.actorId
self.fromType=argtable.fromType or actorInterFromType.eCommon
self.attach=argtable.attach or{}
self.serverid=self.attach.serverid or playerModel:getActorServerID()
self.actorData=otherPlayerModel:getActorData(self.actorId)
self.selectZMTab=true
self.isXianJie=self.attach.isXianJie
self:updateModel()
self:updateInfo()
self:initRoleListPanel()
self:updateBtns()
self:updateIcons()

local hideGuiShuDi=pfwindowslController:checkPFWinState_ByWinType(pfwindowslController.winType.hideGuiShuDi)
self.ipBelongObj:setActive(hideGuiShuDi)
if hideGuiShuDi then
local args={actorid=self.actorId,serverid=self.serverid,markRecored=true}
args.callback=function(belong)
if _this==nil then return end
_this:refreshIPBelong(belong)
end
belongIPAddressController:reqBelong(args)
end

local isSelfPlayer=playerModel:checkActorId(self.actorId)
local isOpenYXG=YingXianGeModel:checkOpen()
local actorData=xianmengModel:getXMMemberData(self.actorId)
if not isSelfPlayer and isOpenYXG and actorData~=nil and actorData.yxg_lv>0 then
YingXianGeController.reqZhiYuan(self.actorId)
end

local args={actorid=self.actorId,serverid=self.serverid,stationguid=0,markRecored=true}
local callback=function(args,other)
if _this==nil then return end
_this:updateXianJieInfo(args)
end
otherPlayerModel:reqActorXianJieInfo(otherPlayerInfoType.eXianJieInfo,self.actorId,args,callback)

if self.attach.canvasIdx then
self:setCanvasIndex(-1,self.attach.canvasIdx)
end
end

function UIOthePlayerInfoWin:updateModel()
self.linkageId=liandonModel:getLianDonLinkageIdByPlayerImage(self.actorData.iconInfo.piList,self.actorData.sex)
self.liandonBtn:setActive(self.linkageId>0)
playerController:setImage(self.widget,self.discipleModel:getID(),self.actorData.sex,self.actorData.iconInfo,true)
end

function UIOthePlayerInfoWin:updateInfo()

playerController:setHeadIcon(self.winlua,self.head:getID(),{iconInfo=self.actorData.iconInfo,scale=1})

local zmName=self.actorData.zmName
if zmName==nil or zmName==''then zmName='暂无'end
self.zNameText:setText(zmName)
self.level:setText(self.actorData.zmLevel)

local fightnum=tonumber(tostring(self.actorData.zmFight2))
if systemModel.isOpen(SYSTEM_DEFINE.eTopThreeTeams)and fightnum>0 then
self.fight:setText(mathHelper.formatNumber3(fightnum))
self.zFight:setActive(true)
else
self.zFight:setActive(false)
end

if not systemModel.isOpen(SYSTEM_DEFINE.eTopThreeTeams)then
local fightnum=tonumber(tostring(self.actorData.zmFight))
self.top5fight:setText(mathHelper.formatNumber3(fightnum))
end

local sexIcon=self.actorData.sex==1 and 1 or 2
local sexName=iconHelper.getPlayerSexIcon(sexIcon)
self.pSexImg:setImageIcon(sexName,false)

self.pNameText:setText(self.actorData.name)

local guildName=self.actorData.guildName
if guildName==nil or guildName==''then guildName='暂无'end
self.xianMengText:setText(guildName)

local rankStr
if self.actorData.dftRank>0 then
rankStr=FMT.fmt('{0}名',tostring(self.actorData.dftRank))
else
rankStr='暂无'
end
self.doufatai:setText(rankStr)

self.suoyaota:setText(FMT.fmt('{0}层',self.actorData.sltLayer))

self:freshXjTabBtn()
end

function UIOthePlayerInfoWin:updateXianJieInfo(args)

local isShow=args and args.allow==1
self.xjTabBtn:setActive(isShow)
if isShow then
self.fortresslv=args.fortresslv
self:initBoatListPanel(args.boatList)


self.xjBaoLeiLevelText:setText(FMT.fmt(args.fortresslv))

self.xjXiuShiNumText:setText(mathHelper.formatNumber3(mathHelper.int64_to_number(args.soldiernum)))

self.xjYunZhouFightText:setText(mathHelper.formatNumber3(mathHelper.int64_to_number(args.fortfight)))

local forceCfg=xianjieModel:GetForceCfg(args.power)
self.xjShiLiNameText:setText(forceCfg and forceCfg.name or"尚未加入势力")

self.xjShaQiNumText:setText(mathHelper.formatNumber3(args.leak))

local xjJobLen=args.xglistlen
self.xjJobInfoListPanel:setActive(xjJobLen>0)
if xjJobLen>0 then
local xjJobList=args.xgList
self.xjJobInfoListPanel:setChildScrollViewCreateGrids(xjJobLen,1)
local grids=self.xjJobInfoListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local jobCfg=xianguanConfig.getJobConfig(i,xjJobList[i])
local item=grids[i-1]

local icon=chatModel:getSignIcon(jobCfg.chatFlagId)
if icon then
item:SetChildIcon(0,icon,false)
end

item:SetChildText(1,jobCfg.name)
end
end
end
end

function UIOthePlayerInfoWin:updateYuanZhuBtn()

local isSelfPlayer=playerModel:checkActorId(self.actorId)
local isOpenYXG=YingXianGeModel:checkOpen()
local actorData=xianmengModel:getXMMemberData(self.actorId)
local inXianJie=mainControl:isSceneType(eSceneType.eXianJie)
if not isSelfPlayer and isOpenYXG and actorData~=nil and actorData.yxg_lv>0 and inXianJie then
local hasYuanJun=YingXianGeModel:checkYuanZhuPlayer(self.actorId)
local cur,max=YingXianGeModel:getYZMYTotleXB(self.actorId)
local hasWaiPai=YingXianGeModel:getHasYZXJ(self.actorId)
self.yuanzhuBtn:setActive(true)
local iconAb="ui/windows/yingxiange/yingxiange_atlas_pak.ab"
local imageType=(not hasYuanJun and not hasWaiPai)and 2 or 1
self.yuanzhuImage:setCSImageSprite(iconAb,FMT.fmt("image_yinxiange_wz{0}",imageType))
self.yuanzhuCount:setText(FMT.fmt("{0}/{1}",cur,max))
else
self.yuanzhuBtn:setActive(false)
end
end

function UIOthePlayerInfoWin:getNetDataList()
local list={}
local viewDatas=self.actorData.dzDataSet.viewDatas
if viewDatas~=nil then
for k,vData in pairs(viewDatas)do
table.insert(list,vData)
end
end
if#list>1 then
if not systemModel.isOpen(SYSTEM_DEFINE.eTeamShowcase)then
table.sort(list,function(a,b)
return a:fightValNum_get()>b:fightValNum_get()
end)
else
table.sort(list,function(a,b)
return a.idx<b.idx
end)
end
end
return list
end

function UIOthePlayerInfoWin:initRoleListPanel()
self.disciplesList=self:getNetDataList()
local dataNum=#self.disciplesList
local isHideRoleData=dataNum<=0
if not isHideRoleData and self.fromType==actorInterFromType.eXianMeng then

local actorData=xianmengModel:getXMMemberData(self.actorId)
local offlineDayCount=0
if actorData and actorData.online>0 then
local offline=gameUtilityModel.getServerShortTime()-actorData.online
offlineDayCount=math.floor(offline/86400)
end
isHideRoleData=not actorData or offlineDayCount>=7
end
self.notRoleListTips:setActive(isHideRoleData)
self.fightPanel:setActive(not isHideRoleData)
if isHideRoleData then
dataNum=0
end
local fightnum=0


self.roleListPanel:setChildScrollViewCreateGrids(dataNum,5)

local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netdata=self.disciplesList[i]
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)
local item=grids[i-1]

local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)
item:SetChildCSImageSprite(0,abname,iconname)

UIDiscipleModel:setDiscipleXianMoBackImage(item,28,netdata)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

item:SetChildText(2,netdata.name)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(3,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netdata.level)
item:SetChildText(5,lv_str)

item:SetChildActive(6,true)
local fightVal=netdata:fightValNum_get()
item:SetChildText(6,tostring(fightVal))
fightnum=fightnum+mathHelper.int64_to_number(fightVal)

item:SetChildText(4,'')

UIDiscipleController.refreshCommonItemTianMing(item,netdata)

local isLD=liandonModel:getLianDonLinkageIdByDZId(netdata.id)>0
item:SetChildActive(27,isLD)


local func=function()
self:OnClickRoleItemCallback(1,i)
end
item:SetChildButtonClick(-1,func,true)
end

if systemModel.isOpen(SYSTEM_DEFINE.eTeamShowcase)then
self.top5fight:setText(mathHelper.formatNumber3(fightnum))
end
end

function UIOthePlayerInfoWin:OnClickRoleItemCallback(clicknum,index)
local actorId=self.actorId
local netdata=self.disciplesList[index]
local disguid=netdata.discipleguid

otherPlayerController:openOtherPlayerDZInfoWin(actorId,disguid,false,true,self.attach)
end

function UIOthePlayerInfoWin:initBoatListPanel(boatList)
self.boatList=boatList or{}
local dataNum=#self.boatList
local isHideBoatData=dataNum<=0
if not isHideBoatData and self.fromType==actorInterFromType.eXianMeng then

local actorData=xianmengModel:getXMMemberData(self.actorId)
local offlineDayCount=0
if actorData and actorData.online>0 then
local offline=gameUtilityModel.getServerShortTime()-actorData.online
offlineDayCount=math.floor(offline/86400)
end
isHideBoatData=not actorData or offlineDayCount>=7
end
self.notBoatListTips:setActive(isHideBoatData)
self.boatListPanel:setActive(not isHideBoatData)
self.boatTitle:setActive(not isHideBoatData)
if isHideBoatData then
dataNum=0
end
self.boatListPanel:setChildScrollViewCreateGrids(dataNum,4)

local fortCfg=cfgHelper.get1(cfg_tianshudianconfig_get,self.fortresslv)
local grids=self.boatListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local boatData=self.boatList[i]
local item=grids[i-1]

item:SetChildText(1,boatData.name)

local boatCfg=cfgHelper.get1(cfg_fairylandboatconfig_get,boatData.boatid)

item:SetChildUIModelShowTarget(2,boatCfg.model,0.5,nil,eAnimationID.stand)
local boatFight=XianYunGangModel:getBoatFight(boatData)
item:SetChildText(3,FMT.fmt("实力：{0}",mathHelper.formatNumber(boatFight)))


item:SetChildButtonClick(4,function()
_this:OnClickBoatItemCallback(1,i)
end,true)
end
end

function UIOthePlayerInfoWin:OnClickBoatItemCallback(clicknum,index)
UIManager:showWindow('UIOtherBoatDetailsMainWin',{list=self.boatList,index=index,fortresslv=self.fortresslv})
end

function UIOthePlayerInfoWin:updateBtns()
self.buttonDatas=actorInterButtonHelper.getButtonList(self.actorId,self.fromType,self.serverid,self.isXianJie)
self.moreButtonDatas={}
self.hasMoreButton=false

local fixBtnsData={}
for i=1,_maxBtnNum do
local data=self.buttonDatas[i]
self:refreshFixButtonItem(i,data)
end

local c=#self.buttonDatas
local fixnum=math.min(_maxBtnNum,c)

local num=c-fixnum
local hasMore=num>0
self.hasMoreButton=hasMore
self.moreBtn:setActive(hasMore)


if hasMore then
for i=_maxBtnNum+1,c do
table.insert(self.moreButtonDatas,self.buttonDatas[i])
end
end

local func=function(index)
local item=self.buttonGridPanel:getChildLayoutGroupGridItem(index-1)
self:refreshMoreButtonItem(item,index)
end
self.buttonGridPanel:setChildLayoutGroupCreateItems(num,func)
end

function UIOthePlayerInfoWin:refreshMoreButtonItem(item,index)
local btncfg=self.moreButtonDatas[index]
self:setButton(item,btncfg)
end

function UIOthePlayerInfoWin:refreshFixButtonItem(index,btncfg)
local btn=self.btnList[index]
local txt=self.btnListTxt[index]
local hasData=btncfg~=nil
btn:setActive(hasData)
if hasData then
local btnID=btn:getID()
self.winlua:SetChildButtonClick(btnID,function()
self:hideMore()
actorInterButtonHelper.buttonJump(btncfg.id,self.actorId,self.fromType,self.serverid)
end,true)

local enable=actorInterButtonHelper.checkEnable(btncfg.id,self.actorId,self.fromType)
self.winlua:SetChildButtonEnable(btnID,enable,not enable)

local name=btncfg.name
txt:setText(name)
end
end

function UIOthePlayerInfoWin:setButton(widget,btncfg)
widget:SetChildButtonClick(0,function()
if actorInterButtonHelper.checkEnable(btncfg.id,self.actorId,self.fromType)then
self:hideMore()
actorInterButtonHelper.buttonJump(btncfg.id,self.actorId,self.fromType,self.serverid)
end
end)

local name=btncfg.name
widget:SetChildText(1,name)

local enable=actorInterButtonHelper.checkEnable(btncfg.id,self.actorId,self.fromType)

widget:SetChildButtonEnable(0,enable,not enable)
end

function UIOthePlayerInfoWin:rebuildBtns()
self:updateBtns()







end

function UIOthePlayerInfoWin:updateIcons()
self.iconDatas=actorInterButtonHelper.getIconList(self.actorId,self.fromType,self.serverid,self.isXianJie)
local func=function(index)
local item=self.iconGridPanel:getChildLayoutGroupGridItem(index-1)
self:refreshIconItem(item,index)
end
self.iconGridPanel:setChildLayoutGroupCreateItems(#self.iconDatas,func)
end

function UIOthePlayerInfoWin:refreshIconItem(item,index)
local iconCfg=self.iconDatas[index]
item:SetChildButtonClick(0,function()
actorInterButtonHelper.buttonJump(actorInterButtonType[iconCfg.enum],self.actorId,self.fromType,self.serverid)
end)
local enable=actorInterButtonHelper.checkEnable(actorInterButtonType[iconCfg.enum],self.actorId,self.fromType)
item:SetChildButtonEnable(0,enable,not enable)
if iconCfg.icon then
item:SetChildCSImageIcon(1,iconCfg.icon,true)
elseif iconCfg.image then
item:SetChildCSImageSprite(1,iconCfg.image[1],iconCfg.image[2])
else
item:SetChildIcon(1,"",false)
end
end


function UIOthePlayerInfoWin:onMoreBtn()
self.showMore=not self.showMore
self.buttonGridPanel:setActive(self.showMore)
end

function UIOthePlayerInfoWin:hideMore()
self.showMore=false
self.buttonGridPanel:setActive(false)
end

function UIOthePlayerInfoWin:onBtn1()

end

function UIOthePlayerInfoWin:onBtn2()

end

function UIOthePlayerInfoWin:onBtn3()

end

function UIOthePlayerInfoWin:onLiandonBtn()
UIManager:showWindow('UITipLianDonWin',{linkageId=self.linkageId})
end

function UIOthePlayerInfoWin:onYuanzhuBtn()
UIManager:showWindow('UIYingXianGeMYYJWin',{actorId=self.actorId})
end

function UIOthePlayerInfoWin:refreshIPBelong(belong)
self.ipBelongObj:setActive(true)
self.ipBelongTxt:setText(belong)
end

function UIOthePlayerInfoWin:onXjTabBtn()
self.selectZMTab=not self.selectZMTab
self:freshXjTabBtn()
end

function UIOthePlayerInfoWin:freshXjTabBtn()
self.zongmenPanel:setActive(self.selectZMTab)
self.xianjiePanel:setActive(not self.selectZMTab)
self.xjTabText:setText(self.selectZMTab and"仙界信息"or"基本信息")
end

function UIOthePlayerInfoWin:onShaQiTitle()
self.shaqiPanel:setActive(true)
end

function UIOthePlayerInfoWin:onShaqiPanel()
self.shaqiPanel:setActive(false)
end









def_class("UIXMZZSH_YuBeiDuiSetWin",UIWindowBase)









function UIXMZZSH_YuBeiDuiSetWin:bindComponents()

self.controllClose=UIObject.get(self,0)
self.controllOpen=UIObject.get(self,1)
self.controllBtn=UIButton.get(self,2)
self.blackBG=UIObject.get(self,3)
self.clickMask=UIButton.get(self,4)
self.infoPanel=UIObject.get(self,5)
self.btnClose=UIButton.get(self,6)
self.centerpanel=UIObject.get(self,7)
self.bagroud=UIObject.get(self,8)
self.shlnum=UIText.get(self,9)
self.crbtn=UIButton.get(self,10)
self.qcbtn=UIButton.get(self,11)
self.sortTypeDropdown=UIDropdown.get(self,12)
self.jijietxt=UIText.get(self,13)
self.listItem=UIObject.get(self,14)
self.kongitem=UIObject.get(self,15)
self.addbtn=UIButton.get(self,16)
self.changeBtn=UIButton.get(self,17)
self.jumpAnimation=UIObject.get(self,18)
self.jumpAnimation2=UIObject.get(self,19)
self.jumpAnimation3=UIObject.get(self,20)
self.jumpAnimation4=UIObject.get(self,21)
self.jumpAnimation5=UIObject.get(self,22)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.crbtn:setButtonClick(function()self:onCrbtn()end)

self.qcbtn:setButtonClick(function()self:onQcbtn()end)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)



end


function UIXMZZSH_YuBeiDuiSetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.bagroud);self.bagroud=nil;
_UIObject_release(self.shlnum);self.shlnum=nil;
_UIObject_release(self.crbtn);self.crbtn=nil;
_UIObject_release(self.qcbtn);self.qcbtn=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.jijietxt);self.jijietxt=nil;
_UIObject_release(self.listItem);self.listItem=nil;
_UIObject_release(self.kongitem);self.kongitem=nil;
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.jumpAnimation2);self.jumpAnimation2=nil;
_UIObject_release(self.jumpAnimation3);self.jumpAnimation3=nil;
_UIObject_release(self.jumpAnimation4);self.jumpAnimation4=nil;
_UIObject_release(self.jumpAnimation5);self.jumpAnimation5=nil;
end

















local _this
local sortTypeName={'1阶及以上','2阶及以上','3阶及以上','4阶及以上','5阶及以上'}
local lastnum=30
local Maxnum=300




function UIXMZZSH_YuBeiDuiSetWin:onLoaded(...)
self:bindComponents()
_this=self
self.citemlist={self.jumpAnimation,self.jumpAnimation2,self.jumpAnimation3,self.jumpAnimation4,self.jumpAnimation5}
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIXMZZSH_YuBeiDuiSetWin:__delete()
self:unbindComponents()
if _this.isOpen then
local openflag=zhengzhanshanhaiModel:getybd_openflag()
if _this.isOpen~=openflag then
zhengzhanshanhaiController:send_20_246(_this.isOpen)
end
end
if _this.sortType then
local stage=zhengzhanshanhaiModel:getybd_ybdstage()
if _this.sortType~=stage then
zhengzhanshanhaiController:send_20_248(_this.sortType)
end
end
_this=nil
end




function UIXMZZSH_YuBeiDuiSetWin:onShow(argtable,afterOnloaded)
self.infoPanel:setChildCanvasGroupAlpha(0)
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)

_this.isOpen=zhengzhanshanhaiModel:getybd_openflag()
local isSetupOpen=_this.isOpen==1
_this.winlua:SetChildActive(_this.controllClose:getID(),not isSetupOpen)
_this.winlua:SetChildActive(_this.controllOpen:getID(),isSetupOpen)
if isSetupOpen then
self.bagroud:setChildCanvasGroupAlpha(0)
self.centerpanel:setChildCanvasGroupAlpha(1)
else
self.bagroud:setChildCanvasGroupAlpha(1)
self.centerpanel:setChildCanvasGroupAlpha(0)
end

local cfg_ybdnums=zhengzhanshanhaiController:getZZSHCfg_YBD(1).ybdnums
self.lastnum=cfg_ybdnums[1]
self.Maxnum=cfg_ybdnums[2]
self.mapId=zhengzhanshanhaiController:getZZSHCfg_YBD(1).mapId


self:refreshshlnum()


self.sortTypeDropdown:setOption(sortTypeName)
self.sortType=zhengzhanshanhaiModel:getybd_ybdstage()
if self.sortType==0 then
self.sortType=4
end
self.sortTypeDropdown:setValue(self.sortType-1)















self:refreshybdlist()

local isFirst=userActorSetting.get('UIXMZZSH_YuBeiDuiSetWin_first',false)
if not isFirst then
userActorSetting.set('UIXMZZSH_YuBeiDuiSetWin_first',true)
userActorSetting.flush()
UIManager:invokeUIMethod("UIXM_ZZSH_PvEMainWin","refreshSetbyd")
UIManager:invokeUIMethod("UIXM_ZZSH_PvPMainWin","refreshSetbyd")
end
end


function UIXMZZSH_YuBeiDuiSetWin:onHide()

end
function UIXMZZSH_YuBeiDuiSetWin:onCloseClick()
self:closeSelf()
end
function UIXMZZSH_YuBeiDuiSetWin:onBtnClose()
self:onCloseClick()
end
function UIXMZZSH_YuBeiDuiSetWin:onClickMask()
self:onCloseClick()
end

function UIXMZZSH_YuBeiDuiSetWin:clearallchoose()
for i=1,#_this.citemlist do
local widget=_this.citemlist[i]:getWidgetBase()
widget:SetChildActive(1,false)
end
end

function UIXMZZSH_YuBeiDuiSetWin:onChangecolorClick(widget,index)
if _this.sortType==index then
return
end
self:clearallchoose()
_this.sortType=index
widget:SetChildActive(1,true)
end


function UIXMZZSH_YuBeiDuiSetWin:onCrbtn()

local money_ybd=zhengzhanshanhaiModel:getybd_ybdmoney()
local money_self=moneyModel.getMoney(eMoneyType.mtXuKongLing)
if money_self<=0 then
gainControl:showGainWin(eMoneyType.mtXuKongLing)
return
end
if money_ybd>=_this.Maxnum then
UIManager.info("预备队山海令存储已达上限")
return
end

local costnum=1
local getnum=1
local refresh=function(num)

return""
end
local MaxneedNum=_this.Maxnum-money_ybd
local MaxLimitNum=math.min(money_self,MaxneedNum)
local color1=money_self>=30 and"#549327"or"#c82c2c"
local color2=money_ybd>=30 and"#549327"or"#c82c2c"

local tipContent=FMT.fmt("目前祖师拥有的山海令: <color={0}>{1}</color>",color1,money_self)
local tipContent2=FMT.fmt("目前预备队可用山海令: <color={0}>{1}</color>",color2,money_ybd)
local tipContent3="请选择存入给预备队用的山海令数量："

local show_data={
type='UIDialougeKuFangCount',
title='存入山海令',
refreshcallback=refresh,
max=MaxLimitNum,
tips=" ",
tips2=" ",
tips3=" ",
paneltipsa="",
paneltipsb=tipContent2,
paneltipsc=tipContent3,
oktext='存入',
canceltext='取消',
tipContent="",
singlenum=costnum or 1,
sliderRootposY=-55,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local _jxNum=costnum*num


local _money_ybd=zhengzhanshanhaiModel:getybd_ybdmoney()
local ybdmoney=_money_ybd+_jxNum
zhengzhanshanhaiController:send_20_247(ybdmoney)
end,

}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

end

function UIXMZZSH_YuBeiDuiSetWin:onQcbtn()


local money_ybd=zhengzhanshanhaiModel:getybd_ybdmoney()
local money_self=moneyModel.getMoney(eMoneyType.mtXuKongLing)
if money_ybd<=0 then
UIManager.info("预存的山海令不足，无法取出")
return
end

local costnum=1
local getnum=1
local refresh=function(num)

return""
end
local MaxLimitNum=money_ybd
local color1=money_self>=30 and"#549327"or"#c82c2c"
local color2=money_ybd>=30 and"#549327"or"#c82c2c"

local tipContent=FMT.fmt("目前祖师拥有的山海令: <color={0}>{1}</color>",color1,money_self)
local tipContent2=FMT.fmt("目前预备队可用山海令: <color={0}>{1}</color>",color2,money_ybd)
local tipContent3="请选择取出预存山海令的数量："

local show_data={
type='UIDialougeKuFangCount',
title='取出山海令',
refreshcallback=refresh,
max=MaxLimitNum,
tips=" ",
tips2=" ",
tips3=" ",
paneltipsa="",
paneltipsb=tipContent2,
paneltipsc=tipContent3,
oktext='取出',
canceltext='取消',
tipContent="",
singlenum=costnum or 1,
sliderRootposY=-55,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local _jxNum=costnum*num


local _money_ybd=zhengzhanshanhaiModel:getybd_ybdmoney()
local ybdmoney=_money_ybd-_jxNum
zhengzhanshanhaiController:send_20_247(ybdmoney)
end,

}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function UIXMZZSH_YuBeiDuiSetWin:onDropdownChange(idx)

idx=idx+1
self.sortType=idx
end

function UIXMZZSH_YuBeiDuiSetWin:onControllBtn(idx)
if _this.isOpen==1 then
_this.isOpen=0
elseif _this.isOpen==0 then
_this.isOpen=1
end
local isSetupOpen=_this.isOpen==1

self:refreshItemControllBtn(isSetupOpen)
end

function UIXMZZSH_YuBeiDuiSetWin:onAddbtn()

local isnil=true
local selflist=zhengzhanshanhaiModel:getybd_guildlist()
if selflist and next(selflist)then
isnil=false
end
local winArgs=
{
enterCallBack=function(guidList,zfId,mapId)
local dzlist={}
for i,v in ipairs(guidList)do
table.insert(dzlist,v[2])
end

if dzlist then
zhengzhanshanhaiController:send_20_249(#dzlist,dzlist)
UIManager.info("设置成功")
end
local func=function()
UIManager:closeWindow('UIXMZZSH_YuBeiDuiExtraWin')
zhengzhanshanhaiController:finishFightOpen({showCloud=false})
fightController:closeSelectStage()
UIManager:showWindow("UIXMZZSH_YuBeiDuiSetWin")
end
loadingControl.openCloud(func,2)
end,
enterTxt="设置预备队",
cancelCallBack=function()
UIManager:closeWindow('UIXMZZSH_YuBeiDuiExtraWin')
zhengzhanshanhaiController:finishFightOpen({showCloud=false})
fightController:closeSelectStage()
UIManager:showWindow("UIXMZZSH_YuBeiDuiSetWin")

end,


closeByCloud=true,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
mapId=_this.mapId or 818004,
needSaveTeam=true,
shanhaiyubeidui=true,
setteamlist_nil=isnil,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
zhengzhanshanhaiController:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end


zhengzhanshanhaiController:setFigthReady(true)
fightController.showPrepareWin(fightPreSelectModel.fightType.zzshPvEYPD,winArgs,function(...)
UIManager:showWindow("UIXMZZSH_YuBeiDuiExtraWin")
end)
end

function UIXMZZSH_YuBeiDuiSetWin:onChangeBtn()

local isnil=true
local selflist=zhengzhanshanhaiModel:getybd_guildlist()
if selflist and next(selflist)then
isnil=false
end
local winArgs=
{
enterCallBack=function(guidList,zfId,mapId)
local dzlist={}
for i,v in ipairs(guidList)do
table.insert(dzlist,v[2])
end

if dzlist then
zhengzhanshanhaiController:send_20_249(#dzlist,dzlist)
UIManager.info("设置成功")
end
local func=function()
UIManager:closeWindow('UIXMZZSH_YuBeiDuiExtraWin')
zhengzhanshanhaiController:finishFightOpen({showCloud=false})
fightController:closeSelectStage()
UIManager:showWindow("UIXMZZSH_YuBeiDuiSetWin")
end
loadingControl.openCloud(func,2)
end,
enterTxt="设置预备队",
cancelCallBack=function()
UIManager:closeWindow('UIXMZZSH_YuBeiDuiExtraWin')
zhengzhanshanhaiController:finishFightOpen({showCloud=false})
fightController:closeSelectStage()
UIManager:showWindow("UIXMZZSH_YuBeiDuiSetWin")

end,


closeByCloud=true,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
mapId=_this.mapId or 818004,
needSaveTeam=true,
shanhaiyubeidui=true,
setteamlist_nil=isnil,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
zhengzhanshanhaiController:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end


zhengzhanshanhaiController:setFigthReady(true)
fightController.showPrepareWin(fightPreSelectModel.fightType.zzshPvEYPD,winArgs,function(...)
UIManager:showWindow("UIXMZZSH_YuBeiDuiExtraWin")
end)
end


function UIXMZZSH_YuBeiDuiSetWin:refreshItemControllBtn(isSetupOpen)
_this.winlua:SetChildActive(_this.controllClose:getID(),not isSetupOpen)
_this.winlua:SetChildActive(_this.controllOpen:getID(),isSetupOpen)

if isSetupOpen then
self.bagroud:setChildCanvasGroupDOFade(0,0.1,nil)
self.centerpanel:setChildCanvasGroupDOFade(1,0.1,nil)
else
self.bagroud:setChildCanvasGroupDOFade(1,0.1,nil)
self.centerpanel:setChildCanvasGroupDOFade(0,0.1,nil)
end
end

function UIXMZZSH_YuBeiDuiSetWin:refreshshlnum()
local num=zhengzhanshanhaiModel:getybd_ybdmoney()
local str="目前预备队可用山海令：0"
if num<_this.lastnum then
str=FMT.fmt("目前预备队可用山海令：<color=#c82c2c>{0}/{1}</color>",num,_this.Maxnum)
else
str=FMT.fmt("目前预备队可用山海令：<color=#549327>{0}/{1}</color>",num,_this.Maxnum)
end
self.shlnum:setText(str)
end


function UIXMZZSH_YuBeiDuiSetWin:refreshybdlist()
local selflist=zhengzhanshanhaiModel:getybd_guildlist()

if selflist and next(selflist)then
self.listItem:setActive(true)
self.kongitem:setActive(false)


local isFree=true
local fight=0
local item=_this.listItem:getWidgetBase()
local dznum=5
item:SetChildLayoutGroupCreateItems(1,dznum)
local grids=item:GetChildLayoutGroupGridList(1)
for i=1,dznum do
local diziguid=selflist[i]
local netData=UIDiscipleModel:getDiscipleData(diziguid)

local dzitem=grids[i-1]
local has=netData~=nil
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)


local onefight=UIDiscipleModel:getDiscipleFightValue(diziguid)
fight=fight+onefight


local isfree=zhengzhanshanhaiModel:checkDZFreeSelfYBD(diziguid,false)
if isFree then
isFree=isfree
end
dzitem:SetChildActive(4,not isfree)
end
end


item:SetChildText(2,mathHelper.formatNumber5(fight,2))


item:SetChildActive(5,isFree)
item:SetChildActive(6,not isFree)
else
self.listItem:setActive(false)
self.kongitem:setActive(true)
end
end

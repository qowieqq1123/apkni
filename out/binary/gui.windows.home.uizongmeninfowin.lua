







def_class("UIZongmenInfoWin",UIWindowBase)








function UIZongmenInfoWin:bindComponents()

self.exchargeItem=UIButton.get(self,0)
self.itemsCreater=UIObject.get(self,1)
self.tenMoneyTxt=UIText.get(self,2)
self.tenMoneyImg=UIObject.get(self,3)
self.oneMoneyTxt=UIText.get(self,4)
self.oneMoneyImg=UIObject.get(self,5)
self.tenBtn=UIButton.get(self,6)
self.oneBtn=UIButton.get(self,7)
self.maxLevel=UIText.get(self,8)
self.relationSEDesc=UIText.get(self,9)
self.relationLCDesc=UIText.get(self,10)
self.lichangText=UIText.get(self,11)
self.unlockScrollerView=UIObject.get(self,12)
self.shangeImg=UIObject.get(self,13)
self.shangeText=UIText.get(self,14)
self.valueEmpty=UIObject.get(self,15)
self.dzCount=UIText.get(self,16)
self.fightValue=UIText.get(self,17)
self.worldLvTip=UIButton.get(self,18)
self.worldLevel=UIText.get(self,19)
self.progressbar=UIProgress.get(self,20)
self.zmLevel=UIText.get(self,21)
self.shaneFlagImg=UIImage.get(self,22)
self.noCondition=UIObject.get(self,23)
self.haveCondition=UIObject.get(self,24)
self.unlockPanel=UIObject.get(self,25)
self.title=UIText.get(self,26)
self.exchargeRoot=UIObject.get(self,27)
self.shaneInfoPanel=UIObject.get(self,28)
self.back=UIObject.get(self,29)
self.mask=UIObject.get(self,30)
self.dfpanel=UIObject.get(self,31)
self.dfwidget=UIObject.get(self,32)
self.dfdesc2=UIText.get(self,33)
self.dfdesc1=UIText.get(self,34)
self.dfxqbtn=UIButton.get(self,35)
self.dfzmpanel=UIObject.get(self,36)
self.dfprogressbar=UIProgress.get(self,37)
self.dfmsbtn=UIButton.get(self,38)
self.dfmodel=UIButton.get(self,39)
self.worldimg=UIObject.get(self,40)
self.worldimg2=UIImage.get(self,41)

self.exchargeItem:setButtonClick(function()self:onExchargeItem()end)

self.tenBtn:setButtonClick(function()self:onTenBtn()end)

self.oneBtn:setButtonClick(function()self:onOneBtn()end)

self.worldLvTip:setButtonClick(function()self:onWorldLvTip()end)

self.dfxqbtn:setButtonClick(function()self:onDfxqbtn()end)

self.dfmsbtn:setButtonClick(function()self:onDfmsbtn()end)

self.dfmodel:setButtonClick(function()self:onDfmodel()end)



end


function UIZongmenInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.exchargeItem);self.exchargeItem=nil;
_UIObject_release(self.itemsCreater);self.itemsCreater=nil;
_UIObject_release(self.tenMoneyTxt);self.tenMoneyTxt=nil;
_UIObject_release(self.tenMoneyImg);self.tenMoneyImg=nil;
_UIObject_release(self.oneMoneyTxt);self.oneMoneyTxt=nil;
_UIObject_release(self.oneMoneyImg);self.oneMoneyImg=nil;
_UIObject_release(self.tenBtn);self.tenBtn=nil;
_UIObject_release(self.oneBtn);self.oneBtn=nil;
_UIObject_release(self.maxLevel);self.maxLevel=nil;
_UIObject_release(self.relationSEDesc);self.relationSEDesc=nil;
_UIObject_release(self.relationLCDesc);self.relationLCDesc=nil;
_UIObject_release(self.lichangText);self.lichangText=nil;
_UIObject_release(self.unlockScrollerView);self.unlockScrollerView=nil;
_UIObject_release(self.shangeImg);self.shangeImg=nil;
_UIObject_release(self.shangeText);self.shangeText=nil;
_UIObject_release(self.valueEmpty);self.valueEmpty=nil;
_UIObject_release(self.dzCount);self.dzCount=nil;
_UIObject_release(self.fightValue);self.fightValue=nil;
_UIObject_release(self.worldLvTip);self.worldLvTip=nil;
_UIObject_release(self.worldLevel);self.worldLevel=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.zmLevel);self.zmLevel=nil;
_UIObject_release(self.shaneFlagImg);self.shaneFlagImg=nil;
_UIObject_release(self.noCondition);self.noCondition=nil;
_UIObject_release(self.haveCondition);self.haveCondition=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.exchargeRoot);self.exchargeRoot=nil;
_UIObject_release(self.shaneInfoPanel);self.shaneInfoPanel=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.dfpanel);self.dfpanel=nil;
_UIObject_release(self.dfwidget);self.dfwidget=nil;
_UIObject_release(self.dfdesc2);self.dfdesc2=nil;
_UIObject_release(self.dfdesc1);self.dfdesc1=nil;
_UIObject_release(self.dfxqbtn);self.dfxqbtn=nil;
_UIObject_release(self.dfzmpanel);self.dfzmpanel=nil;
_UIObject_release(self.dfprogressbar);self.dfprogressbar=nil;
_UIObject_release(self.dfmsbtn);self.dfmsbtn=nil;
_UIObject_release(self.dfmodel);self.dfmodel=nil;
_UIObject_release(self.worldimg);self.worldimg=nil;
_UIObject_release(self.worldimg2);self.worldimg2=nil;
end


















local _format=string.format
local _this

local zmInfoAB='ui/windows/home/sharedtextures/zminfo.ab'
local shangeImgStr={
[STAND_POINT_TYPE.evil]='icon_sebiaoshi_2',
[STAND_POINT_TYPE.neutrality]='icon_sebiaoshi_3',
[STAND_POINT_TYPE.decent]='icon_sebiaoshi_1',
}
local systemname=
{
[173]="<color=#ca631d>九重天劫</color>"
}
local abname='ui/windows/dianfengzhibao/dianfengzhibao_atlas_pak.ab'

function UIZongmenInfoWin:onLoaded(...)
self:bindComponents()
_this=self
self.unlockScrollerView:setChildScrollViewInit(0.5,true,nil,nil)
self:addNotify(notifyConfig.building_event,function(...)self:handleBuildingEvent(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
local nWidget=self.noCondition:getChildWidgetBase()
nWidget:SetChildButtonClick(1,function(...)self:onUpBtn()end)
nWidget:SetChildButtonClick(2,function(...)self:onBreakBtn()end)
local hWidget=self.haveCondition:getChildWidgetBase()
hWidget:SetChildButtonClick(3,function(...)self:onUpBtn()end)
hWidget:SetChildButtonClick(4,function(...)self:onBreakBtn()end)
hWidget:SetChildButtonClick(6,function(...)self:onJumpBtn()end)
end


function UIZongmenInfoWin:__delete()
self:unbindComponents()
_this=nil
end




function UIZongmenInfoWin:onShow(argtable,afterOnloaded)
if argtable and argtable.showback then
self.back:setActive(true)
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
self.mask:setActive(true)
else
self.back:setActive(false)
self.mask:setActive(false)
end
local tabConfig=fullScreenModel.getFullTabConfig(FULL_TAB_TYPE.eShanMenInfo)
self.title:setText(tabConfig.titleName)
self.punchIntervalTime=5
self:refreshInfo()
end

function UIZongmenInfoWin:refreshInfo()
self.isDFState=DianFengLevelController.isShowDF()
self.isDFLvlMax=DianFengLevelModel:checkDianFengLvlMax()
self:refreshProgress()
self:refreshUnlockContent()
self:refreshUpRewards()
self:refreshExcharge()
end

function UIZongmenInfoWin:refreshExcharge()
local level=zongmenModel:getLevel()
local cfg=cfg_guildexpconfig_get(level+1)
local isMax=zongmenModel:isMaxLv()
if self.isDFState and not self.isDFLvlMax then
self.exchargeRoot:setActive(false)
else
self.exchargeRoot:setActive(isMax)
end
if not isMax then return end
local expreward=cfgHelper.get2(cfg_guildbasicconfig_get,1,'expreward')
local dropid=expreward[2]
local cost=expreward[1]
self.exchargeCost=cost
self.dropid=dropid
local showItems=cfgHelper.get2(cfg_awardconfig_get,dropid,'showItems')
local temp={}
for i,v in ipairs(showItems)do
if v[2]~=0 then
temp[#temp+1]=v
end
end
local len=#temp
self.itemsCreater:setChildLayoutGroupCreateItems(len,function(index)
local item=self.itemsCreater:getChildLayoutGroupGridItem(index-1)
local data=temp[index]
local itemid=data[1]
local conf={itemid=itemid,itemcount='',showCountBG=false,showname=false,showStage=false,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetPropData(prop)
end)

self.oneMoneyImg:setIcon(iconHelper.getMoneyIconName(eMoneyType.mtExp),false)
self.tenMoneyImg:setIcon(iconHelper.getMoneyIconName(eMoneyType.mtExp),false)

self.oneMoneyTxt:setText(cost)
self.tenMoneyTxt:setText(cost*10)

self.exchargeItem:setIcon(iconHelper.getChongZhiIcon(23),false)
end

function UIZongmenInfoWin:refreshProgress()
local level=zongmenModel:getLevel()
local cur_cfg=cfg_guildexpconfig_get(level)
local next_cfg=cfg_guildexpconfig_get(level+1)
local isMax=zongmenModel:isMaxLv()
local maxlv=zongmenModel:getZongMenLimitLv()
local standPoint=UISectPalaceModel:getZongMenLiChang()
self.shaneFlagImg:setSprite(zmInfoAB,shangeImgStr[standPoint])

self.zmLevel:setText(FMT.fmt('宗门等级：{0}/{1}',level,maxlv))

if self.isDFState and not self.isDFLvlMax then
self.dfzmpanel:setActive(true)
self.progressbar:setActive(false)
self.worldLvTip:setActive(false)
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
self.worldLevel:setText(_format('当前巅峰等级：%s级',dflevel))

local curExp=DianFengLevelModel:getExp()
local maxexp=cfglvl.exp
self.dfprogressbar:setProgressValue(curExp,maxexp)
self.dfprogressbar:setChildProgressText(_format('%s/%s',curExp,maxexp))
else
self.dfzmpanel:setActive(false)
self.progressbar:setActive(true)
self.worldLvTip:setActive(true)

local curExp=tonumber(tostring(zongmenModel:getExp()))
local maxexp=next_cfg.exp
self.progressbar:setProgressValue(curExp,maxexp)
self.progressbar:setChildProgressText(_format('%s/%s',curExp,maxexp))
self.worldLevel:setText(_format('当前世界等级：%s级',cur_cfg.worldlevel))
end
if self.isDFState then
self.worldimg:setActive(false)
self.worldimg2:setActive(true)
self.winlua:SetChildCSImageSprite(self.worldimg2:getID(),abname,'image_zmcmwz_2')
else
self.worldimg:setActive(true)
self.worldimg2:setActive(false)
end
end

function UIZongmenInfoWin:refreshUnlockContent()
local isMax=zongmenModel:isMaxLv()
self.unlockPanel:setActive(not isMax)
if isMax then return end
local level=zongmenModel:getLevel()
local contentList=self:getUnlockContent(level)
self.unlockScrollerView:setChildScrollViewCreateGrids(#contentList,#contentList)
local grids=self.unlockScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local list=contentList[i]
local config=list[1]
local index=list[2]
local unlockInfo=config.unlockinfo[index]
local icon=unlockInfo[1]
local content=unlockInfo[2]
local titile=content[1]
local tipsTitle=content[3]
local tipsDesc=content[4]
item:SetChildText(0,titile)
local iconName=FMT.fmt('icon_zmleveluplock_{0}',icon)
item:SetChildCSImageIcon(1,iconName,false)
item:SetChildText(2,_format('（%s级解锁）',config.id))

local showTips=tipsTitle~=nil and tipsTitle~=""
item:SetChildActive(3,showTips)
if showTips then
item:SetChildToggleChange(3,function(name,isOn,data)
if isOn then
local args={}
args.posWidget=item
args.pivot=Vector2(0,0)
args.title=tipsTitle
args.iconName=iconName
args.iconnative=true
args.desclist={tipsDesc}
args.callback=function(...)
item:SetChildToggle(3,false)
end
UIManager:showWindow('UIDescribeTips4',args)
end
end)
end
end
end

function UIZongmenInfoWin:refreshUpRewards()
self.canUp=false
self.isBreak=false
self.isMeet=false
local level=zongmenModel:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
local isMax=zongmenModel:isMaxLv()
self.maxLevel:setActive(isMax)
if isMax then
self.haveCondition:setActive(false)
self.noCondition:setActive(false)
if self.isDFState and not self.isDFLvlMax then
self.dfpanel:setActive(true)
self:freshdfpanel()
else
self.dfpanel:setActive(false)
end
else
self.dfpanel:setActive(false)
self.canUp=zongmenModel:getExp()>=int64.new(next_cfg.exp)
self.isBreak=next_cfg.condition~=nil or next_cfg.sysid~=nil

self.haveCondition:setActive(self.isBreak)
self.noCondition:setActive(not self.isBreak)
if self.isBreak then
self:refreshHaveCondition(next_cfg)
else
self:refreshNoCondition(next_cfg)
end
end
end

function UIZongmenInfoWin:refreshHaveCondition(next_cfg)
if next_cfg.sysid then
local widget=self.haveCondition:getChildWidgetBase()
local conditionStr=FMT.fmt("完成{0}，让1名弟子<color=#ca631d>飞升</color>",systemname[next_cfg.sysid])
self.conditionsysid=next_cfg.sysid
local bindItem=function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
local data=next_cfg.rewards[index]
local cfg={showCountBG=data[2]>1,showname=false,showcount=data[2]>1}
local prop=itemsComponentHelper.getCommonFillData({itemid=data[1],itemcount=data[2]},cfg)
item=item:GetChildCSGUIBaseItem(-1)
item:SetItemListData(prop)
item:SetClickEvent(itemsComponentHelper.onItemClick)
end
widget:SetChildLayoutGroupCreateItems(0,#next_cfg.rewards,bindItem)
widget:SetChildText(1,conditionStr)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildActive(6,true)

elseif next_cfg.condition then
local widget=self.haveCondition:getChildWidgetBase()
local need_jingjie=next_cfg.condition[1][3]
local need_count=next_cfg.condition[1][1]
local count=UISettingModel:getDiziCountByJingjieLv(need_jingjie)
self.isMeet=count>=need_count
local color2=self.isMeet and'#549327'or'#c82c2c'

local n,p,pN=UIDiscipleModel:getJJNameX(need_jingjie)
local targetJJName=FMT.fmt("{0}{1}",n,pN)
local conditionStr=_format('拥有%s及以上弟子数（<color=%s>%s/%s</color>）',targetJJName,color2,count,need_count)

local bindItem=function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
local data=next_cfg.rewards[index]
local cfg={showCountBG=data[2]>1,showname=false,showcount=data[2]>1}
local prop=itemsComponentHelper.getCommonFillData({itemid=data[1],itemcount=data[2]},cfg)
item=item:GetChildCSGUIBaseItem(-1)
item:SetItemListData(prop)
item:SetClickEvent(itemsComponentHelper.onItemClick)
end
widget:SetChildLayoutGroupCreateItems(0,#next_cfg.rewards,bindItem)
widget:SetChildText(1,conditionStr)
widget:SetChildActive(2,self.isMeet)
widget:SetChildActive(3,not self.canUp)
widget:SetChildActive(4,self.canUp)
widget:SetChildActive(5,self.canUp and self.isMeet)
end
end

function UIZongmenInfoWin:refreshNoCondition(next_cfg)
local widget=self.noCondition:getChildWidgetBase()
local bindItem=function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
local data=next_cfg.rewards[index]
local cfg={showCountBG=data[2]>1,showname=false,showcount=data[2]>1}
local prop=itemsComponentHelper.getCommonFillData({itemid=data[1],itemcount=data[2]},cfg)
item=item:GetChildCSGUIBaseItem(-1)
item:SetItemListData(prop)
item:SetClickEvent(itemsComponentHelper.onItemClick)
end
widget:SetChildLayoutGroupCreateItems(0,#next_cfg.rewards,bindItem)
widget:SetChildActive(1,not self.canUp)
widget:SetChildActive(2,self.canUp)



local isShowCatAccountBoookBtn=rechargeModel:checkMonthCardCatAccountBtnActive()and not channelHelper.isXianLing()
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
isShowCatAccountBoookBtn=false
end
widget:SetChildActive(3,isShowCatAccountBoookBtn)
if isShowCatAccountBoookBtn then

widget:SetChildActive(4,rechargeModel:checkMonthCardCatAccountReddot())
widget:SetChildButtonClick(3,function()
self:onCatAccountBookBtn()
end)
end

self:mingShengBtnDoPunchRotation(isShowCatAccountBoookBtn)
end

function UIZongmenInfoWin:refreshCatAccountBoookReddot()
local widget=self.noCondition:getChildWidgetBase()
local isShowCatAccountBoookBtn=rechargeModel:checkMonthCardCatAccountBtnActive()and not channelHelper.isXianLing()
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
isShowCatAccountBoookBtn=false
end
widget:SetChildActive(3,isShowCatAccountBoookBtn)
if isShowCatAccountBoookBtn then

widget:SetChildActive(4,rechargeModel:checkMonthCardCatAccountReddot())
end
end

function UIZongmenInfoWin:refreshShanEInfo()
local shaneValue=UISectPalaceModel:getShanEValue()
self.shangeText:setText(FMT.fmt('善恶值：{0}',shaneValue))
local shaneConfig=cfgHelper.get2(cfg_guilddadianconfig_get,1,'shane_conf')
local standPoint=UISectPalaceModel:getZongMenLiChang()
self.shaneFlagImg:setSprite(zmInfoAB,shangeImgStr[standPoint])
local shaneObj=self.valueEmpty:getGameObject()
local shaneRect=CS.UIHelper.GetRectTransform(shaneObj)
local shaneWidth=shaneRect.sizeDelta.x
local section=shaneConfig[3][2]-shaneConfig[1][1]
local posX=(shaneValue-shaneConfig[1][1])/section*shaneWidth
self.shangeImg:setChildAnchoredPosition(mathHelper.convertArrayToVector({posX,-0.6}))
end

function UIZongmenInfoWin:getUnlockContent(cur_lv)
if zongmenModel:isMaxLv(cur_lv)then return{}end
local all_cfg=cfg_guildexpconfig()
local list={}
for i=cur_lv+1,#all_cfg do
local config=all_cfg[i]
local unlockInfo=config.unlockinfo
if unlockInfo then
for index,v in ipairs(unlockInfo)do
table.insert(list,{config,index})
if#list>=4 then
return list
end
end
end
end
return list
end

function UIZongmenInfoWin:mingShengBtnDoPunchRotation(isShow)
local widget=self.noCondition:getChildWidgetBase()
if isShow then
if self.mingShengBtnTweener==nil then
widget:SetChildRotation(3,0,0,0)
local tweener=widget:SetChildDOPunchRotation(3,Vector3(0,0,15),2,6,1,function()
if _this==nil then return end
return _this:delayDo(_this.punchIntervalTime,function()
if _this==nil then return end
if _this.mingShengBtnTweener then
_this:mingShengBtnDoPunchRotation(false)
_this:mingShengBtnDoPunchRotation(isShow)
end
end)
end)
tweener:SetEase(_Ease.Linear)

self.mingShengBtnTweener=tweener
end
else
if self.mingShengBtnTweener~=nil then
self.mingShengBtnTweener:Complete()
self.mingShengBtnTweener:Kill()
self.mingShengBtnTweener=nil
widget:SetChildRotation(3,0,0,0)
end
end
end


function UIZongmenInfoWin:OnEnable()

end


function UIZongmenInfoWin:OnDisable()

end



function UIZongmenInfoWin:onClickClose()
self:closeSelf()
end

function UIZongmenInfoWin:onUpBtn()
gainControl:showGainWin(eMoneyType.mtExp)
end

function UIZongmenInfoWin:onBreakBtn()
if self.canUp then
if self.isBreak then
if not self.isMeet then

local config=zongmenModel:getNextCondition()
local need_jingjie=config.condition[1][3]
jumpManager:jump({type=0,id=1302,args={jjlevel=need_jingjie}})
return
end
end
zongmenControl:reqBreakZongmenLv()
else
UIManager.error(FMT.fmt('{0}未满足',moneyModel.getMoneyName(eMoneyType.mtExp)))
end
end

function UIZongmenInfoWin:onJumpBtn()
if self.conditionsysid then

jumpManager:jump({id=JUMP_TYPE.eJiuChongTianJie})
end
end

function UIZongmenInfoWin:onWorldLvTip()
local datas={}
local name='zongmen_info_help_'
for i=1,8 do
local name_str=name..i
local str=cfgHelper.get1(cfg_lang_get,name_str)
if str then
table.insert(datas,str)
end
end
local d={}
d.title='宗门等级'
d.mode=1
d.datas=datas
UIManager:showWindow('UIRuleWin',d)
end

function UIZongmenInfoWin:onCatAccountBookBtn()
UIFullRechargeController:showMonthInvestorCatAccountBookWin()
end

function UIZongmenInfoWin:onExchargeItem()
UIManager:showWindow('UIItemGaiLvWin',self.dropid)
end

function UIZongmenInfoWin:onTenBtn()
local has=tonumber(tostring(zongmenModel:getExp()))
if has>=self.exchargeCost*10 then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZMSWBXGetTips)
if flag then
socketManager:send_3_251(10)
return
end
local str=FMT.fmt('使用<color=red>{0}</color>名声值开启<color=red>玄天造化匣</color>,\n确定要使用吗？',self.exchargeCost*10)
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
choosetext='今日不再提示',
allowclickBG=false,
okcallback=function(...)
socketManager:send_3_251(10)
end,
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZMSWBXGetTips,flag)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
local moneytype=eMoneyType.mtExp
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(moneytype)))
gainControl:showGainWin(moneytype)
end
end

function UIZongmenInfoWin:onOneBtn()
local has=tonumber(tostring(zongmenModel:getExp()))
if has>=self.exchargeCost then
socketManager:send_3_251(1)
else
local moneytype=eMoneyType.mtExp
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(moneytype)))
gainControl:showGainWin(moneytype)
end
end

function UIZongmenInfoWin:handleBuildingEvent(etype,arg1,arg2)
if etype==buildingEvent.zongmenLevelUp then
self:refreshInfo()
end
end

function UIZongmenInfoWin:onMoneyChanged(moneytype)
if moneytype==eMoneyType.mtExp then
self:refreshInfo()
end
end

function UIZongmenInfoWin:showShanEValueInfo()
self.showShanETip=not self.showShanETip
self.shaneInfoPanel:setActive(self.showShanETip)
if self.showShanETip then
local lichang=UISectPalaceModel:getZongMenLiChangName()
self.lichangText:setText(FMT.fmt('当前立场：{0}',lichang))

local shaneConfig=cfgHelper.get2(cfg_guilddadianconfig_get,1,'shane_conf')
local shanEStr
local lichangStr
for i=#shaneConfig,1,-1 do
local info=shaneConfig[i]
local desc=FMT.fmt('善恶值：{0}~{1}',info[1],info[2])
shanEStr=shanEStr and shanEStr..'\n'..desc or desc
local lcName=STAND_POINT_NAME[i]
lichangStr=lichangStr and lichangStr..'\n'..lcName or lcName
end
self.relationSEDesc:setText(shanEStr)
self.relationLCDesc:setText(lichangStr)
end
end


function UIZongmenInfoWin:DFSeverFresh()
_this:freshdfpanel()
_this:refreshProgress()
end

function UIZongmenInfoWin:freshdfpanel()
local dfwidget=self.dfwidget:getChildWidgetBase()
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local attrs=cfglvl.attrs or{}
for i=1,3 do
if attrs[i]then
dfwidget:SetChildActive(i-1,true)
local name,valstr=equipsHelper.getAttr(attrs[i][1],attrs[i][2])
dfwidget:SetChildText(i-1,FMT.fmt('{0}：{1}',name,valstr))
else
dfwidget:SetChildActive(i-1,false)
end
end

local maxpoint=cfglvl.point
local usepoint=DianFengLevelModel:getaddPointNum()
local num=maxpoint-usepoint
if num<0 then num=0 end
local desc1=FMT.fmt('天道感悟点数：{0}（剩余{1}点未分配）',maxpoint,num)
self.dfdesc2:setText(desc1)

local _cfg=cfg_dianfenglevelbaseconfig_get(1)
local zongmentxt=_cfg.zongmentxt or''
self.dfdesc1:setText(zongmentxt)

local xbid=DianFengLevelModel:getDianFengXianBaoID()
local xbType=XianBaoTypeEnum.eXianBao
local xbCfg=xianbaoConfig.getTypeFuncResult(xbType,'getConfig',xbid)
self.dfmodel:setImageIcon(xbCfg.bigicon,true)
end

function UIZongmenInfoWin:onDfxqbtn()
local _flag=2
if DianFengLevelController:checkShengJiReddot()then
_flag=1
end
DianFengLevelController:showDFWin({flag=_flag})
end

function UIZongmenInfoWin:onDfmodel()
self:onDfxqbtn()
end

function UIZongmenInfoWin:onDfmsbtn()
local moneytype=eMoneyType.mtExp
gainControl:showGainWin(moneytype)
end


function UIZongmenInfoWin.test_changePunchIntervalTime(time)
if _this==nil then return end
_this.punchIntervalTime=time
end
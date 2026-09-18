







def_class("UIMoJieExp_monsterWin",UIWindowBase)









function UIMoJieExp_monsterWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.gwlvl=UIText.get(self,1)
self.handleImg=UIObject.get(self,2)
self.jumpBtn=UIButton.get(self,3)
self.maxCnt=UIButton.get(self,4)
self.monname=UIText.get(self,5)
self.noSign=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.selectCntSlider=UIObject.get(self,8)
self.selectCntText=UIText.get(self,9)
self.subBtn=UIButton.get(self,10)
self.tabtn=UIButton.get(self,11)
self.taskScroller=UIObject.get(self,12)
self.uiPanel=UIObject.get(self,13)
self.tapanel=UIObject.get(self,14)
self.sgpanel=UIObject.get(self,15)
self.mjcost=UIText.get(self,16)
self.mjicon=UIImage.get(self,17)
self.mjscbtn=UIButton.get(self,18)
self.mjsxbtn=UIButton.get(self,19)
self.llpanel=UIObject.get(self,20)
self.lltabtn=UIButton.get(self,21)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)

self.mjscbtn:setButtonClick(function()self:onMjscbtn()end)

self.mjsxbtn:setButtonClick(function()self:onMjsxbtn()end)

self.lltabtn:setButtonClick(function()self:onLltabtn()end)



end


function UIMoJieExp_monsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.gwlvl);self.gwlvl=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.monname);self.monname=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.tabtn);self.tabtn=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.tapanel);self.tapanel=nil;
_UIObject_release(self.sgpanel);self.sgpanel=nil;
_UIObject_release(self.mjcost);self.mjcost=nil;
_UIObject_release(self.mjicon);self.mjicon=nil;
_UIObject_release(self.mjscbtn);self.mjscbtn=nil;
_UIObject_release(self.mjsxbtn);self.mjsxbtn=nil;
_UIObject_release(self.llpanel);self.llpanel=nil;
_UIObject_release(self.lltabtn);self.lltabtn=nil;
end
















local _this
local itemidx=
{
itemself=0,
back=1,
choose=2,
iconbg=3,
ibgchoose=4,
icon=5,
name=6,
btn=7,
iconji=8,
icname=9,
}
local iswzsy=
{
[1]=true,
}
local widths=
{
[1]={52,52},
[2]={70,70},
[3]={70,70},
[4]={70,70},
[5]={70,70},
}
local tipspanel=
{
descitems={0,1,2},
desctxts={3,4,5},
jishatxt=6,
}
local abname="ui/windows/xianjie/xianjiehud2icons_atlas_pak.ab"
local mojieLvl={1,15}


local issgtype=
{
[xjServerEnityType.eMoJieShangGuMoster]=true,
}
local nameColor=
{
[xjServerEnityType.eMoJieShangGuMoster]="d03497",
}
local isliliantype=
{
[20]=true,
}


function UIMoJieExp_monsterWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectid=1
self.selecttype=16
self.selectsttype=16
self.selectCnt=1
self.min=1
self.max=5
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
self.monster_check_lastidx=0




self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)
end

function UIMoJieExp_monsterWin.onXianJieMonsterChange(typo,infoGuid)
if _this==nil then return end

end

function UIMoJieExp_monsterWin:getMapView()
return self.mapView
end


function UIMoJieExp_monsterWin:__delete()
self:unbindComponents()
_this=nil
end


function UIMoJieExp_monsterWin:onHide()

end



function UIMoJieExp_monsterWin:onChooseBtn(idx,selecttype,selectsttype)
if idx==self.selectid then
return
end
local oldselect=self.selectid
self.selectid=idx
self.selecttype=selecttype
self.selectsttype=selectsttype
local grids=self.taskScroller:getChildScrollViewItemWidgets()
if grids then
local olditem=grids[oldselect-1]
if olditem then
olditem:SetChildActive(itemidx.choose,false)
end
local item=grids[self.selectid-1]
if item then
item:SetChildActive(itemidx.choose,true)
end
end

local monterTypeParams=self.montertype[self.selectid]
local moname=monterTypeParams.name
if monterTypeParams.sttype==xjServerEnityType.eMoJieShangGuMoster then
moname=xianjieModel:getSgMonsterTypeName()
end
self.monname:setText(moname)
self.selectCnt=1
local ussr_data=userActorSetting.get('UIMoJieExp_monsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
if ussr_data and self.selectid and self.selectCnt then
if type(ussr_data[self.selectid])=='userdata'then
ussr_data[self.selectid]=1
end
self.selectCnt=ussr_data[self.selectid]or 1
end
self:freshSXpanel()
self:freshsilder()
self.monster_check_lastidx=0

end
function UIMoJieExp_monsterWin:onSliderChange(value)
self.selectCnt=value
local str=FMT.fmt('{0}阶',self.selectCnt)
self.gwlvl:setText(str)
end
function UIMoJieExp_monsterWin:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

end
function UIMoJieExp_monsterWin:onAddBtn()
if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

end

function UIMoJieExp_monsterWin:onTabtn()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
if selectCnt<self.min then
selectCnt=self.min
end

local _selecttype=self.selecttype
local _selectCnt=selectCnt
local _selectsttype=self.selectsttype
local _selectid=self.selectid
local ussr_data=userActorSetting.get('UIMoJieExp_monsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
local ussr_selectid=userActorSetting.get('UIMoJieExp_monsterWinselectid',1)
if ussr_data and ussr_selectid and self.selectid and self.selectCnt then
ussr_data[self.selectid]=self.selectCnt
ussr_selectid=self.selectid
userActorSetting.set('UIMoJieExp_monsterWindata',ussr_data)
userActorSetting.set('UIMoJieExp_monsterWinselectid',ussr_selectid)
userActorSetting.flush()
end
local _fun=function()
local temp=
{
selectCnt=_selectCnt,
selecttype=_selecttype,
selectsttype=_selectsttype,
selectid=_selectid,
isdo=true,
}
UIManager:showWindow('UIMoJieExplorationWin',{page=1,extra=temp})
end

local check=false
local zmData=xianjieModel:getMyZongMenData()
if zmData~=nil and not zmData:checkInCurScene()then
check=true
end
if check then



UIManager:invokeUIMethod('UIMoJieExplorationWin',"onCloseBtn")
xianjieModel:jumpMyZongMen(_fun,false)
else
self:handlejump(self.selecttype,selectCnt)
end
end


function UIMoJieExp_monsterWin:onMjscbtn()

local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
if selectCnt<self.min then
selectCnt=self.min
end
local ussr_data=userActorSetting.get('UIMoJieExp_monsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
local ussr_selectid=userActorSetting.get('UIMoJieExp_monsterWinselectid',1)
if ussr_data and ussr_selectid and self.selectid and self.selectCnt then
ussr_data[self.selectid]=self.selectCnt
ussr_selectid=self.selectid
userActorSetting.set('UIMoJieExp_monsterWindata',ussr_data)
userActorSetting.set('UIMoJieExp_monsterWinselectid',ussr_selectid)
userActorSetting.flush()
end
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
local monsterTypeSimpleName=xianjieModel:getSgMonsterTypeName(2)
local itemid=self.sgitemId
if itemid then
local haveNum=0
if moneyConfig.isMoney(itemid)then
haveNum=moneyModel.getMoney(itemid)
else
haveNum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if haveNum<1 then
if moneyConfig.isMoney(itemid)then
local str=FMT.fmt('{0}不足，难觅【{1}】踪迹',moneyModel.getMoneyName(itemid),monsterTypeName)
UIManager.info(str)
else
local str=FMT.fmt('{0}不足，难觅【{1}】踪迹',itemsConfig.getItemName(itemid),monsterTypeName)
UIManager.info(str)
end
gainControl:showGainWin(itemid)
return
end
else
return
end


local _fun=function()
local raduis=cfgHelper.get2(cfg_devildombaseconfig_get,1,'finddistance')
self:creat_MjJieDuanSan_Entity(itemid,raduis)
end
local strtip=''
if moneyConfig.isMoney(itemid)then
strtip=FMT.fmt('是否消耗 <color=#d03497>{0}*1</color> 来召唤{1}？\n<color=#ca631d>（击败{2}的祖师所属仙盟会获得仙盟宝箱）</color>',moneyModel.getMoneyName(itemid),monsterTypeName,monsterTypeSimpleName)
else
strtip=FMT.fmt('是否消耗 <color=#d03497>{0}*1</color> 来召唤{1}？\n<color=#ca631d>（击败{2}的祖师所属仙盟会获得仙盟宝箱）</color>',itemsConfig.getItemName(itemid),monsterTypeName,monsterTypeSimpleName)
end

local showdata=
{
type='UIDialouge',
title='使用提示',
content=strtip,
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
end

function UIMoJieExp_monsterWin:onMjsxbtn()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
if selectCnt<self.min then
selectCnt=self.min
end
local ussr_data=userActorSetting.get('UIMoJieExp_monsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
local ussr_selectid=userActorSetting.get('UIMoJieExp_monsterWinselectid',1)
if ussr_data and ussr_selectid and self.selectid and self.selectCnt then
ussr_data[self.selectid]=self.selectCnt
ussr_selectid=self.selectid
userActorSetting.set('UIMoJieExp_monsterWindata',ussr_data)
userActorSetting.set('UIMoJieExp_monsterWinselectid',ussr_selectid)
userActorSetting.flush()
end
local isInMoJie=xianjienSceneIndexType:isMoJie(self._sceneidx)or false
if isInMoJie then
self:SG_handlejump(self.selecttype)
else
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
UIManager.info(FMT.fmt('没有【{0}】踪迹',monsterTypeName))
end
end

function UIMoJieExp_monsterWin:onLltabtn()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
if selectCnt<self.min then
selectCnt=self.min
end
local ussr_data=userActorSetting.get('UIMoJieExp_monsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
local ussr_selectid=userActorSetting.get('UIMoJieExp_monsterWinselectid',1)
if ussr_data and ussr_selectid and self.selectid and self.selectCnt then
ussr_data[self.selectid]=self.selectCnt
ussr_selectid=self.selectid
userActorSetting.set('UIMoJieExp_monsterWindata',ussr_data)
userActorSetting.set('UIMoJieExp_monsterWinselectid',ussr_selectid)
userActorSetting.flush()
end
if isliliantype[self.selecttype]then
self:LL_handlejump(self.selecttype)
end
end





function UIMoJieExp_monsterWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local areaID_zm=xianjieModel:checkMapGridDataAreaID(sceneidx,gridX,gridZ)
if areaID_zm~=0 then
self.MJJD_flag=1
else
self.MJJD_flag=2
end

self.extra=argtable.extra
self.isSGshow=xianjieController:CheckMjJieDuanSanShow()
self._sceneidx=xianjieModel:getSceneIndex()
self:isShowSGpage()
self.selectCnt=1
self.min=1
self.max=5
self.selecttype=16
self.selectsttype=16
self.tipsopen=false
if self.isSGshow then
self.sgitemId=xianjieController:get_MjJieDuanSan_ItemId()
end


local enterData=xianjieModel:getMoJieEnterData()
local sId=enterData.sId
local old_sId=userActorSetting.get('UIMoJieExp_monsterWin_sId',-1)
if sId~=old_sId then
userActorSetting.set('UIMoJieExp_monsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
userActorSetting.set('UIMoJieExp_monsterWinselectid',1)
userActorSetting.set('UIMoJieExp_monsterWin_sId',sId)
end


local ussr_data=userActorSetting.get('UIMoJieExp_monsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
local ussr_selectid=userActorSetting.get('UIMoJieExp_monsterWinselectid',1)
if ussr_selectid then
if type(ussr_selectid)=='userdata'then
ussr_selectid=1
end
if ussr_selectid<0 or ussr_selectid>5 then
ussr_selectid=1
end
self.selectid=ussr_selectid
end
if ussr_data then
if ussr_data[self.selectid]then
if type(ussr_data[self.selectid])=='userdata'then
ussr_data[self.selectid]=1
end
self.selectCnt=ussr_data[self.selectid]
else
ussr_data[self.selectid]=1
end
end
if self.extra then
self.selectCnt=self.extra.selectCnt or self.selectCnt
self.selecttype=self.extra.selecttype or self.selecttype
self.selectsttype=self.extra.selectsttype or self.selectsttype
local selectid=self.extra.selectid
if self.extra.selecttype and not self.extra.selectid then
for i,v in ipairs(self.montertype)do
if v.type==self.extra.selecttype then
selectid=i
break
end
end
end
self.selectid=selectid or self.selectid
self.isdo=self.extra.isdo


self.isguMonster=self.extra.isguMonster
end

if not self.selectid or self.selectid>#self.montertype then

self.selectid=1
end


self:inititem()
self:freshSXpanel()
self:freshsilder()

self.root:setChildCanvasGroupAlpha(1)


if self.isdo and not self.isguMonster then
self:handlejump(self.selecttype,self.selectCnt)
self.isdo=false
end

if self.isdo and self.isguMonster then
UIMoJieExp_monsterWin:SG_handlejump(17)
end

self:refreshreddot()
end
function UIMoJieExp_monsterWin:refreshreddot()

end

function UIMoJieExp_monsterWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIMoJieExplorationWin','playEnterAnim')
end

function UIMoJieExp_monsterWin:playLeaveAnim()
self.tipsopen=false

self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end


function UIMoJieExp_monsterWin:freshSXpanel()
if issgtype[self.selecttype]then
self.tapanel:setActive(false)
self.sgpanel:setActive(true)
self.llpanel:setActive(false)
self:freshSGnum()
else
if isliliantype[self.selecttype]then
self.tapanel:setActive(false)
self.sgpanel:setActive(false)
self.llpanel:setActive(true)
else
self.tapanel:setActive(true)
self.sgpanel:setActive(false)
self.llpanel:setActive(false)
end
end
end

function UIMoJieExp_monsterWin:isShowSGpage()

local montertype=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'MoJietanchalist')
local temp={}
local seasonHandle=seasonModel:getHandleByType(eSeasonType.eMJMB)
local seasonId=seasonHandle and seasonHandle.id or-1
local checkHideSeasonFunc=function(params)
local isHide=false
if params.hideSeason then
local lookup=params.hideSeason
if lookup[seasonId]then
isHide=true
end
end
return isHide
end

for k,v in ipairs(montertype)do
if self.isSGshow then
local isHide=checkHideSeasonFunc(v)
if not isHide then
table.insert(temp,v)
end
else
if not issgtype[v.sttype]then
local isHide=checkHideSeasonFunc(v)
if not isHide then
table.insert(temp,v)
end
end
end
end
self.montertype=temp
end

function UIMoJieExp_monsterWin:freshSGnum()
local itemid=self.sgitemId
if itemid then
local haveNum=0
if moneyConfig.isMoney(itemid)then
haveNum=moneyModel.getMoney(itemid)
else
haveNum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
self.winlua:SetChildIcon(self.mjicon:getID(),iconHelper.getIconName(itemid),false)
local hasNumStr=''
if haveNum>=1 then
hasNumStr=FMT.cfmt(FONT_COLOR.eGreenColor,"{0}/{1}",1,haveNum)
else
hasNumStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",1,haveNum)
end
self.mjcost:setText(hasNumStr)
end
end

function UIMoJieExp_monsterWin:severfreshSG(guid,isjump)
_this:freshSGnum()

if isjump then
local monsterData=xianjieModel:getMonsterData(guid)
if monsterData and monsterData.infoid~=0 then
local info_guid=monsterData.infoguid
monsterData:selectEntity(true)
xianjieController:openMonsterInfoWin(info_guid)
else
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
logErr(FMT.fmt('{1}数据为nil,guid={0}',guid,monsterTypeName))
end
end
end


function UIMoJieExp_monsterWin:inititem()
local dataNum=#self.montertype
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local item=grids[i-1]
if item then

local motype=self.montertype[i].type
local sttype=self.montertype[i].sttype
local moname=self.montertype[i].name
if sttype==xjServerEnityType.eMoJieShangGuMoster then
moname=xianjieModel:getSgMonsterTypeName()
end
local icon=self.montertype[i].icon

if nameColor[sttype]then
local color=nameColor[sttype]
item:SetChildText(itemidx.name,FMT.fmt('<color=#{0}>{1}</color>',color,moname))
else
item:SetChildText(itemidx.name,moname)
end
item:SetChildCSImageSprite(itemidx.icon,abname,icon)
item:SetChildSizeDelta(itemidx.icon,widths[i][1],widths[i][2])
if self.selectid==i then
self.selecttype=motype
self.selectsttype=sttype
item:SetChildActive(itemidx.choose,true)
else
item:SetChildActive(itemidx.choose,false)
end
item:SetChildActive(itemidx.iconji,false)
item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i,motype,sttype)
end)
end
end
local monterTypeParams=self.montertype[self.selectid]
local moname=monterTypeParams.name
if monterTypeParams.sttype==xjServerEnityType.eMoJieShangGuMoster then
moname=xianjieModel:getSgMonsterTypeName()
end
self.monname:setText(moname)
if self.selectid>=5 then
self.taskScroller:setChildScrollViewSelectItem(self.selectid-1,false,false,false)
end
end

function UIMoJieExp_monsterWin:freshsilder()
local _min,_max=xianjieController:getMoJieMonsterMaxlevel(16,self.MJJD_flag)


self.max=_max
local func=function(...)
self:onSliderChange(...)
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIMoJieExp_monsterWin:handlejump(_monstertype,_jjid)
local Raduis=xianjieModel:getFindDistanceRaduis(3)
local list=xianjieModel:findMonsterByDistance(Raduis)


local zmData=xianjieModel:getZongMenData(playerModel:getActorID())
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local sceneidx=zmPos[1]
local zm_gridX=zmPos[2]
local zm_gridZ=zmPos[3]
local areaID_zm=xianjieModel:checkMapGridDataAreaID(sceneidx,zm_gridX,zm_gridZ)
local monstertype=_monstertype
local jjid=_jjid
local templist={}
for i,infoguid in ipairs(list)do
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData and monsterData.infoid~=0 then
local cfg=monsterData:getCfg()
local entitytype=monsterData.entitytype
local stage=cfg.stage
local areaID=self:checkMapGridDataAreaIDHuJian(sceneidx,monsterData.gridX,monsterData.gridZ)
local isInArea=self:checkZM_MonsterArea(areaID_zm,areaID)
if monstertype==entitytype and jjid==stage and isInArea then
local dis=mathHelper.distance2(monsterData.gridX,monsterData.gridZ,zmData.gridX,zmData.gridZ)
table.insert(templist,{infoguid,dis})
end
end
end
if#templist>1 then
table.sort(templist,function(a,b)
return a[2]<b[2]
end)
end



local getlist={}
for k,v in ipairs(templist)do
table.insert(getlist,v[1])
end
if#getlist==0 then
UIManager.info("魔界宗门附近搜寻不到所选阶数魔物")
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
return
end

if self.monster_type==monstertype and self.monster_stage==jjid then
else
self.monster_type=monstertype
self.monster_stage=jjid
self.monster_check_idx=1
end
local istips=false
local chooseguid
if getlist[self.monster_check_idx]then
chooseguid=getlist[self.monster_check_idx]
self.monster_check_idx=self.monster_check_idx+1
else
if getlist[1]then
chooseguid=getlist[1]
self.monster_check_idx=1
end
end
if chooseguid then
local monsterData=xianjieModel:getMonsterData(chooseguid)
if monsterData and monsterData.infoid~=0 then
local info_guid=monsterData.infoguid
if self.monster_check_idx==1 and#getlist==1 then
UIManager.info("魔界宗门附近搜寻不到其他所选阶数魔物")
end
monsterData:selectEntity(true)
xianjieController:openMonsterInfoWin(info_guid)
else
istips=true
end
else
istips=true
end
if istips then
UIManager.info("魔界宗门附近搜寻不到所选阶数魔物")
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
end
end

function UIMoJieExp_monsterWin:SG_handlejump(_monstertype)




local zmData=xianjieModel:getZongMenData(playerModel:getActorID())
local monstertype=_monstertype
local templist={}
local allMonsterData=xianjieModel:getAllMonsterData()
for i,monsterData in pairs(allMonsterData)do

local infoguid=monsterData.infoguid
if monsterData and monsterData.infoid~=0 and not monsterData.isExpire then
local entitytype=monsterData.entitytype
if monstertype==entitytype then
local dis=mathHelper.distance2(monsterData.gridX,monsterData.gridZ,zmData.gridX,zmData.gridZ)
table.insert(templist,{infoguid,dis})
end
end
end
if#templist>1 then
table.sort(templist,function(a,b)
return a[2]<b[2]
end)
end



local getlist={}
for k,v in ipairs(templist)do
table.insert(getlist,v[1])
end
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
if#getlist==0 then
UIManager.info(FMT.fmt("魔界宗门附近搜寻不到【{0}】踪迹",monsterTypeName))
self.sg_monster_type=0
self.sg_monster_check_idx=1
return
end

if self.sg_monster_type==monstertype then
else
self.sg_monster_type=monstertype
self.sg_monster_check_idx=1
end
local istips=false
local chooseguid
if getlist[self.sg_monster_check_idx]then
chooseguid=getlist[self.sg_monster_check_idx]
self.sg_monster_check_idx=self.sg_monster_check_idx+1
else
if getlist[1]then
chooseguid=getlist[1]
self.sg_monster_check_idx=1
end
end
if chooseguid then
local monsterData=xianjieModel:getMonsterData(chooseguid)
if monsterData and monsterData.infoid~=0 then
local info_guid=monsterData.infoguid
if self.sg_monster_check_idx==1 and#getlist==1 then
UIManager.info(FMT.fmt("魔界宗门附近搜寻不到其他【{0}】踪迹",monsterTypeName))
end
monsterData:selectEntity(true)
xianjieController:openMonsterInfoWin(info_guid)
else
istips=true
end
else
istips=true
end
if istips then
UIManager.info(FMT.fmt("魔界宗门附近搜寻不到【{0}】踪迹",monsterTypeName))
self.sg_monster_type=0
self.sg_monster_check_idx=1
end
end

function UIMoJieExp_monsterWin:checkZM_MonsterArea(areaID_zm,areaID)
if areaID_zm>0 then

if areaID>0 then
return true
end
else

if areaID>0 then
return false
else
return true
end
end
end

function UIMoJieExp_monsterWin:LL_handlejump(_monstertype)
local monstertype=_monstertype
local Pointlist=xianjieModel:getResPointDatasByType(XJ_ResPoint_TYPE.eMonster)



local templist={}
for i,data in ipairs(Pointlist)do
local cfg=data:getCfg()
local gridX_c=data.gridX_c
local gridZ_c=data.gridZ_c
local sceneidx=data.sceneidx
if xianjienSceneIndexType:isMoJie(sceneidx)then
local dis=xianjieModel:getPointDistanc2ZongMen(sceneidx,gridX_c,gridZ_c,true)
if not dis then
dis=-1
end
local rpGuid=data.rpGuid
table.insert(templist,{rpGuid,dis})
end
end
if#templist>1 then
table.sort(templist,function(a,b)
return a[2]<b[2]
end)
end


local getlist={}
for k,v in ipairs(templist)do
table.insert(getlist,v[1])
end
if#getlist==0 then
UIManager.info("魔界宗门附近搜寻不到历练魔物")
self.ll_monster_type=0
self.ll_monster_check_idx=1
return
end

if self.ll_monster_type==monstertype then
else
self.ll_monster_type=monstertype
self.ll_monster_check_idx=1
end
local istips=false
local chooseguid
if getlist[self.ll_monster_check_idx]then
chooseguid=getlist[self.ll_monster_check_idx]
self.ll_monster_check_idx=self.ll_monster_check_idx+1
else
if getlist[1]then
chooseguid=getlist[1]
self.ll_monster_check_idx=1
end
end
if chooseguid then
local rpGuid=chooseguid
local data=xianjieModel:getResPointData(rpGuid)
if data then
if self.ll_monster_check_idx==1 and#getlist==1 then
UIManager.info("魔界宗门附近搜寻不到其他历练魔物")
end
data:selectEntity(true)
local winParams={
guid=rpGuid,
lookAtPos=data:getWorldPos(),
}
xianjieController:openWin('UIXianJie_RPMonsterWin',winParams)
else
istips=true
end
else
istips=true
end
if istips then
UIManager.info("魔界宗门附近搜寻不到历练魔物")
self.ll_monster_type=0
self.ll_monster_check_idx=1
end
end



function UIMoJieExp_monsterWin:creat_MjJieDuanSan_Entity(item_id,raduis)
if xianjieController:check_MjJieDuanSan_ZongMenBenZhen()then
local name=itemsConfig.getItemName(item_id)
UIManager.info(FMT.fmt('仙域本阵内受阵法保护，无法使用{0}',name))
return
end
local arry=self:get_MjJieDuanSan_Pos(raduis)
if arry then
local x=arry[1]
local y=arry[2]
xianjieController:send_35_238(item_id,x,y)
else
UIManager.info('附近没有空位置，暂时无法使用')
end
end

function UIMoJieExp_monsterWin:get_MjJieDuanSan_Pos(raduis)
local sceneType=xianjieModel:getScenceType()
if xianjienSceneType:isMoJie(sceneType)then
raduis=raduis or 10
local arry={0,0,0}
local entityType=xjServerEnityType.eMoJieShangGuMoster
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
local cfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,entityType)






local list=self:findPointByDistance(sceneidx,gridX_c,gridZ_c,raduis,cfg.size[1],cfg.size[2])
if#list>1 then
table.sort(list,function(a,b)
return a[3]<b[3]
end)
end


local templist={}
if#list>4 then
for k=1,4 do
table.insert(templist,list[k])
end
else
templist=list
end

local count=#templist
if count>0 then
local point=count>1 and templist[math.random(1,#templist)]or templist[1]
arry[1]=point[1]
arry[2]=point[2]
arry[3]=sceneidx
else
if xianjieController:checkGridInMap(gridX+5,gridZ,sceneidx)then
arry[1]=gridX+5
arry[2]=gridZ
arry[3]=sceneidx
else
arry[1]=gridX-5
arry[2]=gridZ
arry[3]=sceneidx
end
local areaID_=self:checkMapGridDataAreaIDHuJian(arry[3],arry[1],arry[2])
if areaID_>0 then
return
end
end
return arry
else
return
end
end

function UIMoJieExp_monsterWin:findPointByDistance(sceneidx,gridX_c,gridZ_c,raduis,width,height,findOne)
local raduis=raduis or xianjieModel:getFindDistanceRaduis(2)
local interval=xianjieController:getMapGridSize()
local minX_c=gridX_c-raduis
local maxX_c=gridX_c+raduis
local minZ_c=gridZ_c-raduis
local maxZ_c=gridZ_c+raduis
local list={}
local Allarea=xianjieModel:getMoJieEnterConfig("area")
local csid=xianjieModel:getMoJieEnterConfig("csid")

for x=minX_c,maxX_c,interval do
for z=minZ_c,maxZ_c,interval do
local distance=math.sqrt((x-gridX_c)^2+(z-gridZ_c)^2)
if distance<=raduis then
local gridX=math.floor(x)
local gridZ=math.floor(z)
local areaID=self:checkMapGridDataAreaIDHuJian(sceneidx,gridX,gridZ)
local chapter_idx=Allarea[areaID]
if areaID<=0 and seasonController:checkSeasonStageBegined(csid,chapter_idx)and xianjieController:checkGridInMap(gridX,gridZ,sceneidx)then
local check=xianjieModel:checkScopeGridsCanPlace(sceneidx,gridX,gridZ,width,height)
if check then
if findOne then
return gridX,gridZ
else
table.insert(list,{gridX,gridZ,distance})
end
end
end
end
end
end
return list
end

function UIMoJieExp_monsterWin:checkMapGridDataAreaIDHuJian(sceneidx,gridX,gridZ)
local data=xianjieModel:getMapGridData(sceneidx)
if data then
local range=data.mapRange
local pos=gridX*range.height+gridZ
local id=data.gridData[pos]or 0
local cfg=data.gridConfig[id]
if cfg then
local areaId=cfg.areaId or 0
return areaId
end
end
return 0
end




function UIMoJieExp_monsterWin:tessttt(rpGuid)
local data2=xianjieModel:getResPointData(rpGuid)

end
function UIMoJieExp_monsterWin:checktestttt(gridX,gridZ)
local check=xianjieModel:checkScopeGridsCanPlace(100,gridX,gridZ,3,3)

end




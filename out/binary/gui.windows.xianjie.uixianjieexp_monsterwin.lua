







def_class("UIXianJieExp_monsterWin",UIWindowBase)









function UIXianJieExp_monsterWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.gwlvl=UIText.get(self,1)
self.handleImg=UIObject.get(self,2)
self.jumpBtn=UIButton.get(self,3)
self.lvltips=UIButton.get(self,4)
self.maxCnt=UIButton.get(self,5)
self.monname=UIText.get(self,6)
self.noSign=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.selectCntSlider=UIObject.get(self,9)
self.selectCntText=UIText.get(self,10)
self.subBtn=UIButton.get(self,11)
self.tabtn=UIButton.get(self,12)
self.taskScroller=UIObject.get(self,13)
self.tipspanel=UIObject.get(self,14)
self.uiPanel=UIObject.get(self,15)
self.xunyouXJ=UIButton.get(self,16)
self.xunyouXJImg=UIObject.get(self,17)
self.xywjreddot=UIObject.get(self,18)
self.zyxsBtn=UIButton.get(self,19)
self.zyxsImg=UIObject.get(self,20)
self.zyxsReddot=UIObject.get(self,21)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.lvltips:setButtonClick(function()self:onLvltips()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)

self.xunyouXJ:setButtonClick(function()self:onXunyouXJ()end)

self.zyxsBtn:setButtonClick(function()self:onZyxsBtn()end)



end


function UIXianJieExp_monsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.gwlvl);self.gwlvl=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.lvltips);self.lvltips=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.monname);self.monname=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.tabtn);self.tabtn=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.tipspanel);self.tipspanel=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.xunyouXJ);self.xunyouXJ=nil;
_UIObject_release(self.xunyouXJImg);self.xunyouXJImg=nil;
_UIObject_release(self.xywjreddot);self.xywjreddot=nil;
_UIObject_release(self.zyxsBtn);self.zyxsBtn=nil;
_UIObject_release(self.zyxsImg);self.zyxsImg=nil;
_UIObject_release(self.zyxsReddot);self.zyxsReddot=nil;
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
[2]={52,52},
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

function UIXianJieExp_monsterWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectid=1
self.selecttype=1
self.selectsttype=3
self.selectCnt=1
self.min=1
self.max=5
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
self.monster_check_lastidx=0
self:addNotify(notifyConfig.onXianJieResPointDataChange,self.onXianJieResPointDataChange)
self:addNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)
self:addNotify(notifyConfig.onTeQuanInfoReset,self.onTeQuanInfoReset)
self:addNotify(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)
end

function UIXianJieExp_monsterWin.onTeQuanInfoChange(tqData)
if _this==nil then return end
local tqid=tqData.tqid

if tqid==14 then
_this:refreshreddot()
UIManager:invokeUIMethod('UIXianJieExplorationWin','refreshAllMenuItemSingleReddot',1)
elseif tqid==XIANGUAN_PRIVILEGE_ENUM.eZhenYuXunShou then
_this:refreshPublishWantedReddot()
end
end
function UIXianJieExp_monsterWin.onTeQuanInfoReset()
_this:refreshreddot()
end
function UIXianJieExp_monsterWin.onChangeXianGuanJob()

_this:refreshreddot()
_this:refreshPublishWantedReddot()
UIManager:invokeUIMethod('UIXianJieExplorationWin','refreshAllMenuItemSingleReddot',1)
end

function UIXianJieExp_monsterWin.onXianJieMonsterChange(typo,infoGuid)
if _this==nil then return end
_this:refreshPublishWantedReddot()
end

function UIXianJieExp_monsterWin:getMapView()
return self.mapView
end


function UIXianJieExp_monsterWin:__delete()
self:unbindComponents()
_this=nil
end


function UIXianJieExp_monsterWin:onHide()

end




function UIXianJieExp_monsterWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end

self.extra=argtable.extra
self.montertype=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'tanchalist')
self.selectCnt=1
self.min=1
self.max=5
self.selecttype=1
self.selectsttype=3
self.tipsopen=false


local ussr_data=userActorSetting.get('UIXianJieExpmonsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
local ussr_selectid=userActorSetting.get('UIXianJieExpmonsterWinselectid',1)

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
self.selectid=self.extra.selectid or self.selectid
self.isdo=self.extra.isdo
end


self:inititem()
self:freshsilder()

self.root:setChildCanvasGroupAlpha(1)


if self.isdo then

self:handlejump(self.selecttype,self.selectCnt)
self.isdo=false
end



local isopenbtn=xianjieController:checkjieshudata()
self.lvltips:setActive(isopenbtn)

self:refreshreddot()
self:refreshPublishWantedReddot()

end

function UIXianJieExp_monsterWin:refreshreddot()
if not xianguanHelper.checkTeQuanPlatformLimit(14)then
_this.xunyouXJImg:setActive(false)
_this.xywjreddot:setActive(false)
return
end
local jobflag=xianguanController:checkSelfHasJobByType(5)
_this.xywjreddot:setActive(xianguanController.getSelfPrivilegeUseReddot())
_this.xunyouXJImg:setActive(jobflag)
end

function UIXianJieExp_monsterWin:refreshPublishWantedReddot()
local isTeQuan=xianguanController:checkSelfHasTeQuanByType(XIANGUAN_PRIVILEGE_ENUM.eZhenYuXunShou,XIANGUAN_TYPE_ENUM.eZhenYuXianGuan)
if not isTeQuan or not xianguanHelper.checkTeQuanPlatformLimit(XIANGUAN_PRIVILEGE_ENUM.eZhenYuXunShou)then
_this.zyxsImg:setActive(false)
return
end

local isZYXS=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eZhenYuXianGuan)
_this.zyxsImg:setActive(isZYXS and systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter))
_this.zyxsReddot:setActive(xianguanModel:getPublishWantedReddot()or false)
end


function UIXianJieExp_monsterWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end

function UIXianJieExp_monsterWin:playLeaveAnim()
self.tipsopen=false
self.tipspanel:setActive(false)
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end


function UIXianJieExp_monsterWin:onChooseBtn(idx,selecttype,selectsttype)
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
self.monname:setText(self.montertype[self.selectid].name)
self.selectCnt=1
local ussr_data=userActorSetting.get('UIXianJieExpmonsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
if ussr_data and self.selectid and self.selectCnt then
if type(ussr_data[self.selectid])=='userdata'then
ussr_data[self.selectid]=1
end
self.selectCnt=ussr_data[self.selectid]or 1
end
self:freshsilder()
self.monster_check_lastidx=0
self:freshjspanel()
end
function UIXianJieExp_monsterWin:onSliderChange(value)
self.selectCnt=value
local str=FMT.fmt('{0}阶',self.selectCnt)
self.gwlvl:setText(str)
end
function UIXianJieExp_monsterWin:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

end
function UIXianJieExp_monsterWin:onAddBtn()
if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

end

function UIXianJieExp_monsterWin:onTabtn()
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

local ussr_data=userActorSetting.get('UIXianJieExpmonsterWindata',{[1]=1,[2]=1,[3]=1,[4]=1,[5]=1})
local ussr_selectid=userActorSetting.get('UIXianJieExpmonsterWinselectid',1)
if ussr_data and ussr_selectid and self.selectid and self.selectCnt then
ussr_data[self.selectid]=self.selectCnt
ussr_selectid=self.selectid
userActorSetting.set('UIXianJieExpmonsterWindata',ussr_data)
userActorSetting.set('UIXianJieExpmonsterWinselectid',ussr_selectid)
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
UIManager:showWindow('UIXianJieExplorationWin',{page=1,extra=temp})
end

local check=false
local zmData=xianjieModel:getMyZongMenData()
if zmData~=nil and not zmData:checkInCurScene()then
check=true
end
if check then



UIManager:invokeUIMethod('UIXianJieExplorationWin',"onCloseBtn")
xianjieModel:jumpMyZongMen(_fun,false)
else
self:handlejump(self.selecttype,selectCnt)
end
end

function UIXianJieExp_monsterWin:inititem()
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
local icon=self.montertype[i].icon

item:SetChildText(itemidx.name,moname)
item:SetChildCSImageSprite(itemidx.icon,abname,icon)
item:SetChildSizeDelta(itemidx.icon,widths[i][1],widths[i][2])
if self.selectid==i then
self.selecttype=motype
self.selectsttype=sttype
item:SetChildActive(itemidx.choose,true)


else
item:SetChildActive(itemidx.choose,false)


end
local icname=''
if i==2 then icname='缉'end
if i==5 then icname='界'end
if icname~=''then
item:SetChildActive(itemidx.iconji,true)
item:SetChildText(itemidx.icname,icname)
else
item:SetChildActive(itemidx.iconji,false)
end
item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i,motype,sttype)
end)
end
end
self.monname:setText(self.montertype[self.selectid].name)

if self.selectid>=5 then
self.taskScroller:setChildScrollViewSelectItem(self.selectid-1,false,false,false)
end
end

function UIXianJieExp_monsterWin:freshsilder()
local _min,_max=xianjieController:getMonsterMaxlevel(self.selectsttype)
self.max=_max
local func=function(...)
self:onSliderChange(...)
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIXianJieExp_monsterWin:handlejump(_monstertype,_jjid)
local Raduis=xianjieModel:getFindDistanceRaduis(1)
local list=xianjieModel:findMonsterByDistance(Raduis)


local monstertype=_monstertype
local jjid=_jjid
local getlist={}
for i,infoguid in ipairs(list)do
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData and monsterData.infoid~=0 then
local cfg=monsterData:getCfg()
local type=cfg.type
local stage=cfg.stage

if monstertype==type and jjid==stage then
table.insert(getlist,infoguid)
end
end
end

if#getlist==0 then
local xyisopen=seasonController:checkSeasonStageBegined(0,2)
local sysopen=systemModel.isOpen(SYSTEM_DEFINE.eMonsterFind)

if sysopen and xyisopen then

if iswzsy[_monstertype]then
local mysteryRPDatas=xianjieModel:getResPointDatasByType(XJ_ResPoint_TYPE.eMonster)
local zyishave=false

local zydata
for i,v in ipairs(mysteryRPDatas)do
local cfg=v:getCfg()
if v.source.srctype==3 then
if cfg.stage==jjid and cfg.type==monstertype then
zyishave=true
zydata=v

break
end
end
end
if not zyishave then
local zmpos,sceneidx=xianjieModel:getZongMenWorldPos()
if sceneidx then
local is_fairyland
if sceneidx==0 then
is_fairyland=1
elseif sceneidx>0 then
is_fairyland=2
end
xianjieController:send_37_72(monstertype,jjid,is_fairyland)
end
else
if zydata then
local func=function()
local winParams={
guid=zydata.rpGuid,
lookAtPos=zydata:getWorldPos(),
}

xianjieController:openWin('UIXianJie_RPMonsterWin',winParams)
end
xianjieController:jumpGrid(zydata.sceneidx,zydata.gridX,zydata.gridZ,func)
end
end
else
UIManager.info("宗门附近搜寻不到所选阶数魔物")
end
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
return
end
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
UIManager.info("宗门附近搜寻不到其他所选阶数魔物")
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
UIManager.info("宗门附近搜寻不到所选阶数魔物")
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
end
end


function UIXianJieExp_monsterWin.onXianJieResPointDataChange(etype,guid,isInit,data)




if etype==xjResPointChangeEventType.eAdd then
local Autoflag=xianjieModel:GetAutoStage()
if Autoflag then
return
end
local srctype=data.source.srctype

if xjResPointSourceType.eExploration==srctype then
local gridX=data.gridX
local gridZ=data.gridZ
local sceneidx=data.sceneidx

local winParams={
guid=data.rpGuid,
lookAtPos=data:getWorldPos(),
}
xianjieController:openWin('UIXianJie_RPMonsterWin',winParams)

local func=function()




data:createEntity(true)
_this:showEffect(data.rpGuid)
end
xianjieController:jumpGrid(sceneidx,gridX,gridZ,func)
end
end
end
function UIXianJieExp_monsterWin:tessttt(rpGuid)
local data2=xianjieModel:getResPointData(rpGuid)

end

function UIXianJieExp_monsterWin:hideModel(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
if rpData and rpData.ent_key then
xianjieController:invokeEntityFunc(rpData.ent_key,'hideModel')
end
end
function UIXianJieExp_monsterWin:showEffect(rpGuid)
local rpData=xianjieModel:getResPointData(rpGuid)
if rpData and rpData.ent_key then
xianjieController:invokeEntityFunc(rpData.ent_key,'showEffect')
end
end


function UIXianJieExp_monsterWin:onLvltips()
self.tipsopen=not self.tipsopen
self:openjspanel()
self:freshjspanel()
end
function UIXianJieExp_monsterWin:openjspanel()
if self.tipsopen then
self.tipspanel:setActive(true)
self.tipspanel:setChildCanvasGroupAlpha(0)
self.tipspanel:setChildCanvasGroupDOFade(1,0.6,nil)
else
self.tipspanel:setActive(false)
end
end

function UIXianJieExp_monsterWin:freshjspanel()
if self.tipsopen then
local widget=self.tipspanel:getWidgetBase()
local cfg=xianjieController:getJiShaDatacdg(self.selectsttype)
if cfg.desc then
local desc=cfg.desc
if cfg.zmMaxLv and xianjieController:checkJieShuMax(self.selectsttype,cfg.sid)then
desc=cfg.zmMaxLv[2]
end

for i=1,3 do
if desc[i]then
widget:SetChildActive(tipspanel.descitems[i],true)
widget:SetChildText(tipspanel.desctxts[i],desc[i])
else
widget:SetChildActive(tipspanel.descitems[i],false)
end
end
end
local maxjisha=cfg.maxjisha
local canjieduan=cfg.jieduan
if maxjisha and canjieduan then
local nownum=xianjieController:getJiShaDatajsnum(self.selectsttype,canjieduan)
local numstr
if maxjisha>nownum then
numstr=FMT.fmt("当前积累击败进度：<color=#f36666>{0}</color>/{1}",nownum,maxjisha)
elseif maxjisha==nownum then
numstr=""
else
numstr=FMT.fmt("当前积累击败进度：{0}/{1}",nownum,maxjisha)
end
widget:SetChildText(tipspanel.jishatxt,numstr)
else
widget:SetChildText(tipspanel.jishatxt,"")
end
end
end


function UIXianJieExp_monsterWin:onZyxsBtn()
UIManager:showWindow('UIXianJiePublishWantedWin')
end


function UIXianJieExp_monsterWin:onXunyouXJ()
UIFullXJForceControl:jumpXGTQ_XYWJ_Win()
end

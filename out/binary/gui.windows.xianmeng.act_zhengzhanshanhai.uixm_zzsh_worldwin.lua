







def_class("UIXM_ZZSH_worldWin",UIWindowBase)









function UIXM_ZZSH_worldWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.filterBtn=UIButton.get(self,1)
self.infoPanel=UIButton.get(self,2)
self.topView=UIObject.get(self,3)
self.block=UIButton.get(self,4)
self.filter2Panel=UIObject.get(self,5)
self.toggleFilterSelect=UIObject.get(self,6)
self.toggleSignSelect=UIObject.get(self,7)
self.signPageLeftBtn=UIButton.get(self,8)
self.signNumTxt=UIText.get(self,9)
self.signPageRightBtn=UIButton.get(self,10)
self.signGridPanel=UIObject.get(self,11)
self.signInfoTwo=UIObject.get(self,12)
self.signInfoOne=UIObject.get(self,13)
self.signPageTxt=UIText.get(self,14)
self.filterAllBtnTxt=UIText.get(self,15)
self.filterAllBtn=UIButton.get(self,16)
self.filterGridPanel=UIObject.get(self,17)
self.signSetupBtn=UIButton.get(self,18)
self.signAllBtn=UIButton.get(self,19)
self.signDelBtn=UIButton.get(self,20)
self.signBackBtn=UIButton.get(self,21)
self.filterAllSelect=UIObject.get(self,22)
self.itemsGrid=UIObject.get(self,23)
self.frameImg=UIImage.get(self,24)
self.filter2GridPanel=UIObject.get(self,25)
self.noSign=UIObject.get(self,26)
self.filterPanel=UIObject.get(self,27)
self.toggleSignBtn=UIButton.get(self,28)
self.toggleFilterBtn=UIButton.get(self,29)
self.signPanel=UIObject.get(self,30)
self.leftView=UIObject.get(self,31)
self.rightView=UIObject.get(self,32)
self.root=UIObject.get(self,33)
self.tipsTxt=UIText.get(self,34)
self.frameBG=UIObject.get(self,35)
self.areaBtn=UIButton.get(self,36)
self.worldBtn=UIButton.get(self,37)
self.mapSlider=UISlider.get(self,38)
self.backMyBtn=UIButton.get(self,39)
self.posTxt=UIText.get(self,40)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.infoPanel:setButtonClick(function()self:onInfoPanel()end)

self.block:setButtonClick(function()self:onBlock()end)

self.signPageLeftBtn:setButtonClick(function()self:onSignPageLeftBtn()end)

self.signPageRightBtn:setButtonClick(function()self:onSignPageRightBtn()end)

self.filterAllBtn:setButtonClick(function()self:onFilterAllBtn()end)

self.signSetupBtn:setButtonClick(function()self:onSignSetupBtn()end)

self.signAllBtn:setButtonClick(function()self:onSignAllBtn()end)

self.signDelBtn:setButtonClick(function()self:onSignDelBtn()end)

self.signBackBtn:setButtonClick(function()self:onSignBackBtn()end)

self.toggleSignBtn:setButtonClick(function()self:onToggleSignBtn()end)

self.toggleFilterBtn:setButtonClick(function()self:onToggleFilterBtn()end)

self.areaBtn:setButtonClick(function()self:onAreaBtn()end)

self.worldBtn:setButtonClick(function()self:onWorldBtn()end)

self.backMyBtn:setButtonClick(function()self:onBackMyBtn()end)



end


function UIXM_ZZSH_worldWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.topView);self.topView=nil;
_UIObject_release(self.block);self.block=nil;
_UIObject_release(self.filter2Panel);self.filter2Panel=nil;
_UIObject_release(self.toggleFilterSelect);self.toggleFilterSelect=nil;
_UIObject_release(self.toggleSignSelect);self.toggleSignSelect=nil;
_UIObject_release(self.signPageLeftBtn);self.signPageLeftBtn=nil;
_UIObject_release(self.signNumTxt);self.signNumTxt=nil;
_UIObject_release(self.signPageRightBtn);self.signPageRightBtn=nil;
_UIObject_release(self.signGridPanel);self.signGridPanel=nil;
_UIObject_release(self.signInfoTwo);self.signInfoTwo=nil;
_UIObject_release(self.signInfoOne);self.signInfoOne=nil;
_UIObject_release(self.signPageTxt);self.signPageTxt=nil;
_UIObject_release(self.filterAllBtnTxt);self.filterAllBtnTxt=nil;
_UIObject_release(self.filterAllBtn);self.filterAllBtn=nil;
_UIObject_release(self.filterGridPanel);self.filterGridPanel=nil;
_UIObject_release(self.signSetupBtn);self.signSetupBtn=nil;
_UIObject_release(self.signAllBtn);self.signAllBtn=nil;
_UIObject_release(self.signDelBtn);self.signDelBtn=nil;
_UIObject_release(self.signBackBtn);self.signBackBtn=nil;
_UIObject_release(self.filterAllSelect);self.filterAllSelect=nil;
_UIObject_release(self.itemsGrid);self.itemsGrid=nil;
_UIObject_release(self.frameImg);self.frameImg=nil;
_UIObject_release(self.filter2GridPanel);self.filter2GridPanel=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.filterPanel);self.filterPanel=nil;
_UIObject_release(self.toggleSignBtn);self.toggleSignBtn=nil;
_UIObject_release(self.toggleFilterBtn);self.toggleFilterBtn=nil;
_UIObject_release(self.signPanel);self.signPanel=nil;
_UIObject_release(self.leftView);self.leftView=nil;
_UIObject_release(self.rightView);self.rightView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.frameBG);self.frameBG=nil;
_UIObject_release(self.areaBtn);self.areaBtn=nil;
_UIObject_release(self.worldBtn);self.worldBtn=nil;
_UIObject_release(self.mapSlider);self.mapSlider=nil;
_UIObject_release(self.backMyBtn);self.backMyBtn=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
end
















local _this=nil
local minDefaultScale=0.1
local mapDefaultScale=0.15
local maxDefaultScale=0.2
local recordscale=nil
local minSlider=1
local maxSlider=50
local signNumOnPage=5
local filterOrder={
eDongTian=1,
eFuDi=2,
eMonster=3,
eResource=4,
eXianMeng=5,
eLingShan=6,
}


function UIXM_ZZSH_worldWin:onLoaded(...)
_this=self
self:bindComponents()


self.filterCfg={
{'洞天','icon_sjdtfdbiaoshi_2',true,filterOrder.eDongTian,nil},
{'福地','icon_sjdtfdbiaoshi_1',true,filterOrder.eFuDi,nil},
{'异兽','icon_sjbiaoshi_2',true,filterOrder.eMonster,1},
{'宝地','icon_sjbiaoshi_3',true,filterOrder.eResource,2},
}

if UILSZDControl:isLingShanOpen(true)then
self.filterCfg[#self.filterCfg+1]={'灵山','icon_lsbsi_2',true,filterOrder.eLingShan,3,abName=globalABLookup.zzshicons}
end

local scale=zhengzhanshanhaiController:getZZSHCfg('mapScale2')
minDefaultScale=scale[1]
mapDefaultScale=scale[3]
maxDefaultScale=scale[2]

if not newbieControl.isInNewbie()then
self.leftView:setChildAnchoredPosition(Vector2.New(-200,0))
self.rightView:setChildAnchoredPosition(Vector2.New(200,0))
self.topView:setChildAnchoredPosition(Vector2.New(0,200))
self.leftView:setChildDOAnchorPosX(0,0.35)
self.rightView:setChildDOAnchorPosX(0,0.35)
self.topView:setChildDOAnchorPosY(0,0.35)
end
end


function UIXM_ZZSH_worldWin:__delete()
zhengzhanshanhaiModel:setMapRecord(self.mapScale)
_this=nil
self:unbindComponents()
if UIManager:isActive('UIXM_ZZSH_posInfoWin')then
UIManager:closeWindow('UIXM_ZZSH_posInfoWin')
end


end


function UIXM_ZZSH_worldWin:onHide()

end




function UIXM_ZZSH_worldWin:onShow(argtable,afterOnloaded)
local maskLookup={}
local raceState=zhengzhanshanhaiModel:getLunState()
self.raceState=raceState
if self.raceState~=eZZSH_State.ePVEFight then
maskLookup[filterOrder.eMonster]=true
maskLookup[filterOrder.eResource]=true
end

self.maskLookup=maskLookup
self.startPos=argtable.startPos
self.filterPage=1
self.signModle=1
self.curSignPage=1
self:onFilterBtn()
self:initMap()
self:refreshItemList()
self.mapTimer=self:setTimer(0.2,0,function()
self:mapUpdate()
end)
self.tipsTxt:setText('点击标识可<color=#efb150>查看详情</color>')

end



function UIXM_ZZSH_worldWin:mapUpdate()
local view_pos=self.frameBG:getChildLocalPosition()
if view_pos.x~=self.centerPos_view[1]or view_pos.y~=self.centerPos_view[2]then
self.centerPos_view={view_pos.x,view_pos.y}
local g_x,g_y=self:refreshMapViewPos()
self.centerPos={g_x,g_y}
end
end

function UIXM_ZZSH_worldWin:refreshMapViewPos()
local scale=self.mapScale
local view_pos=self.centerPos_view

local x=math.floor((0-view_pos[1])/scale)
local y=math.floor((0-view_pos[2])/scale)

local g_x,g_y=zhengzhanshanhaiModel:localPos2gridPos(x,y)
local pos_str=FMT.fmt('X：<color=#ebe0ce>{0}</color>  Y：<color=#ebe0ce>{1}</color>',g_x,g_y)
self.posTxt:setText(pos_str)
return g_x,g_y
end

function UIXM_ZZSH_worldWin:calculationItemList()
local list={}
local x1,y1=zhengzhanshanhaiModel:gridPos2localPos(self.centerPos[1],self.centerPos[2])
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
for pos,v in pairs(baseCfg.domain)do
local a=math.floor(pos/100)

local typo
if a==2 and self.filterRecord[filterOrder.eDongTian]==true then
typo=filterOrder.eDongTian
elseif a==3 and self.filterRecord[filterOrder.eFuDi]==true then
typo=filterOrder.eFuDi
end
if typo~=nil then
local d={x=v[1],y=v[2]}
d.typo=typo
d.icon1=self.filterCfg[typo][2]
local cfg=zhengzhanshanhaiModel:getLingDiCfgByPos(pos)
d.cfgID=cfg.domain
local x2,y2=zhengzhanshanhaiModel:gridPos2localPos(d.x,d.y)
d.disSort=mathHelper.distance2(x1,y1,x2,y2)
d.iconScale=1.2
table.insert(list,d)
end
end
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})

if self.raceState==eZZSH_State.ePVEFight then
local qblist=zhengzhanshanhaiModel:getAllQingBaoLookup()
if qblist then
for guid,qbData in pairs(qblist)do
local typo
local icon1,icon2
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
local cfg=qbData:getCfg()
local sidx_=cfg.stage
local check
if record.fliterMonster~=nil and record.fliterMonster[sidx_]~=nil then
check=record.fliterMonster[sidx_]
else
check=self.filterRecord[filterOrder.eMonster]==true
end
if check then
typo=filterOrder.eMonster
icon1=FMT.fmt('icon_sjysbiaoshi_{0}',cfg.stage)
end
elseif qbData.infotype==zhengzhanshanhaiModel.qbType.eResource then
local cfg=qbData:getCfg()
local sidx_=cfg.stage
local check
if record.fliterRes~=nil and record.fliterRes[sidx_]~=nil then
check=record.fliterRes[sidx_]
else
check=self.filterRecord[filterOrder.eResource]==true
end
if check then
typo=filterOrder.eResource
icon1=FMT.fmt('icon_sjwpbiaoshi_{0}',cfg.stage)
icon2=moneyModel.getIconNameEx(cfg.moneytype)
end
end
if typo~=nil then
local d={x=qbData.x,y=qbData.y}
d.typo=typo
d.icon1=icon1
d.icon2=icon2
d.abname=globalABLookup.zzshicons
d.guid=guid
local x2,y2=zhengzhanshanhaiModel:gridPos2localPos(d.x,d.y)
d.disSort=mathHelper.distance2(x1,y1,x2,y2)
table.insert(list,d)
end
end
end
end

local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x then
local d={x=g_x,y=g_y}
d.typo=filterOrder.eXianMeng
d.icon1='icon_zhongmenbiaoshi_02'
d.abname=globalABLookup.zzshicons
d.guid=xianmengModel:getMyXMGuildID()
local x2,y2=zhengzhanshanhaiModel:gridPos2localPos(d.x,d.y)
d.disSort=mathHelper.distance2(x1,y1,x2,y2)
table.insert(list,d)
end


local lsdatas=UILSZDControl:getDatas()
for mId,mdata in pairs(lsdatas)do
local mtype=mdata.mountType
local check
if record.fliterLingShan and record.fliterLingShan[mtype]~=nil then
check=record.fliterLingShan[mtype]
else
check=self.filterRecord[filterOrder.eLingShan]==true
end
if check then
local info=UILSZDControl:getLingShanInfo(mtype)
local d={x=mdata.x,y=mdata.y}
d.typo=filterOrder.eLingShan
d.icon1=info.mapIcon
d.abname=globalABLookup.zzshicons
d.guid=mId
local x2,y2=zhengzhanshanhaiModel:gridPos2localPos(d.x,d.y)
d.disSort=mathHelper.distance2(x1,y1,x2,y2)
table.insert(list,d)
end
end


if#list>1 then
table.sort(list,function(a,b)
return a.disSort<b.disSort
end)
end
self.itemsList=list
end

function UIXM_ZZSH_worldWin:refreshItemList()
self:calculationItemList()

self.itemsGrid:setChildLayoutGroupCreateItems(#self.itemsList,function(idx)
if _this==nil then return end
local item=_this.itemsGrid:getChildLayoutGroupGridItem(idx-1)
_this:initMapItem(item,idx)
end)
end

function UIXM_ZZSH_worldWin:scale2sliderNum(scale)
local sNum=minSlider+math.floor((1-(scale-minDefaultScale)/(maxDefaultScale-minDefaultScale))*(maxSlider-minSlider))
return sNum
end

function UIXM_ZZSH_worldWin:slider2scaleNum(sNum)
local scale=minDefaultScale+(1-(sNum-minSlider)/(maxSlider-minSlider))*(maxDefaultScale-minDefaultScale)
return scale
end

function UIXM_ZZSH_worldWin:initMap()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local bgAbName
local bgImageName
if shSeasonId==-1 then

bgAbName="ui/windows/xianmeng/act_zhengzhanshanhai/sharedtextures/shanhaimap.ab"
bgImageName="shanhaiMap"
else

local bgMapId=zhengzhanshanhaiController:getZZSHCfg("bgmapid")
local mapCfg=cfgHelper.get(cfg_zhengzhanshanhaimapnewconfig_get,bgMapId)
bgAbName=mapCfg.bgAbName
bgImageName=mapCfg.bgImageName
end
self.frameImg:setCSImageSprite(bgAbName,bgImageName)

local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local w=baseCfg.w*baseCfg.gw+baseCfg.bw*2
local h=baseCfg.h*baseCfg.gh+baseCfg.bh*2
self.mapWidth=w
self.mapHeight=h

self.itemScale=1.0/mapDefaultScale

recordscale=zhengzhanshanhaiModel:getMapRecord()
self.mapScale=recordscale and recordscale or mapDefaultScale
local width=self.mapWidth*self.mapScale
local height=self.mapHeight*self.mapScale
self.frameBG:setChildSizeDelta(width,height)
local scale=self.mapScale/mapDefaultScale
if recordscale then
scale=self.mapScale/recordscale
end
self.frameImg:setChildSizeDelta(width,height)

self.frameImg:setScale(Vector3(scale,scale,scale))
self.itemsGrid:setChildSizeDelta(self.mapWidth,self.mapHeight)
self.itemsGrid:setScale(Vector3(self.mapScale,self.mapScale,self.mapScale))


local g_x,g_y=zhengzhanshanhaiModel:localPos2gridPos(self.startPos[1],self.startPos[2])
self.centerPos={g_x,g_y}

local view_x=-self.startPos[1]*self.mapScale
local view_y=-self.startPos[2]*self.mapScale
self.centerPos_view={view_x,view_y}

local sNum=self:scale2sliderNum(self.mapScale)
self.lockSlider=true
self.mapSlider:setSlider(sNum,minSlider,maxSlider,function(v)
if _this==nil then return end
_this:onSliderChange(v)
end)
self.lockSlider=false

self.frameBG:setLocalPos(view_x,view_y,0)
local pos_str=FMT.fmt('X：<color=#ebe0ce>{0}</color>  Y：<color=#ebe0ce>{1}</color>',g_x,g_y)
self.posTxt:setText(pos_str)

end

function UIXM_ZZSH_worldWin:onSliderChange(v)
if self.lockSlider then return end
local old_mapScale=self.mapScale
self.mapScale=self:slider2scaleNum(v)
local width=self.mapWidth*self.mapScale
local height=self.mapHeight*self.mapScale
self.frameBG:setChildSizeDelta(width,height)
local scale=self.mapScale/mapDefaultScale
if recordscale then
scale=self.mapScale/recordscale
end

self.frameImg:setScale(Vector3(scale,scale,scale))
self.itemsGrid:setScale(Vector3(self.mapScale,self.mapScale,self.mapScale))

local posx=(0-self.centerPos_view[1])/old_mapScale
local posy=(0-self.centerPos_view[2])/old_mapScale

local view_x=-posx*self.mapScale
local view_y=-posy*self.mapScale
self.frameBG:setLocalPos(view_x,view_y,0)
self.centerPos_view={view_x,view_y}
local g_x,g_y=self:refreshMapViewPos()
self.centerPos={g_x,g_y}
if v<=minSlider then
self:onCloseBtn()
end
end

function UIXM_ZZSH_worldWin:jumpGridPos(g_x,g_y,anim,func)
local posx,posy=zhengzhanshanhaiModel:gridPos2localPos(g_x,g_y)
local scale=self.mapScale
local func2=function()
if _this==nil then return end
if func then
func()
end
end
local x=-posx*scale
local y=-posy*scale
if anim then
self.frameBG:setChildDOAnchorPos(Vector2.New(x,y),0.3,func2)
else
self.frameBG:setLocalPos(x,y,0)
end
return x,y
end

function UIXM_ZZSH_worldWin:initMapItem(item,idx)
if item==nil then return end

local d=self.itemsList[idx]
local typo=d.typo
item:SetChildScale(-1,Vector3(self.itemScale,self.itemScale,self.itemScale))
local posx,posy=zhengzhanshanhaiModel:gridPos2localPos(d.x,d.y)
item:SetChildLocalPos(-1,posx,posy,0)

if d.abname then
item:SetChildCSImageSprite(0,d.abname,d.icon1)
else
item:SetChildCSImageIcon(0,d.icon1,true)
end
local scale=d.iconScale or 1
item:SetChildScale(0,Vector3(scale,scale,scale))

local showIcon2=d.icon2~=nil
item:SetChildActive(1,showIcon2)
if showIcon2 then
item:SetChildCSImageIcon(1,d.icon2,true)
end

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMapItemClick(idx)
end)
end

function UIXM_ZZSH_worldWin:onMapItemClick(idx)
local d=self.itemsList[idx]
if self.filterPage==1 then

self:jumpSignPos(d.x,d.y)
else
local typo=d.typo
local data={x=d.x,y=d.y}
data.abname=d.abname
data.icon1=d.icon1
data.icon2=d.icon2
if typo==filterOrder.eDongTian or typo==filterOrder.eFuDi then
data.cfgID=d.cfgID
data.entityType=eZZSHEntityType.eLingDi
elseif typo==filterOrder.eMonster then
local qbData=zhengzhanshanhaiModel:getQingBaoData(d.guid)
if qbData==nil then
UIManager.error('该异兽已被击杀')
return
end
data.guid=d.guid
data.entityType=eZZSHEntityType.eMonster
elseif typo==filterOrder.eResource then
local qbData=zhengzhanshanhaiModel:getQingBaoData(d.guid)
if qbData==nil then
UIManager.error('该宝地已被采完')
return
end
data.guid=d.guid
data.entityType=eZZSHEntityType.eResource
elseif typo==filterOrder.eXianMeng then
data.guid=d.guid
data.icon1=nil
data.entityType=eZZSHEntityType.ePvEXianMeng
end
UIManager:showWindow('UIXM_ZZSH_posInfoWin',data)
end
end

function UIXM_ZZSH_worldWin:onAreaBtn()
self:onCloseBtn()
end

function UIXM_ZZSH_worldWin:onWorldBtn()
if self.mapScale~=mapDefaultScale then
self.mapScale=mapDefaultScale
local sNum=self:scale2sliderNum(self.mapScale)
self.mapSlider:setChildSliderRefresh(sNum)
end
end

function UIXM_ZZSH_worldWin:onCloseBtn()

local posx=(0-self.centerPos_view[1])/self.mapScale
local posy=(0-self.centerPos_view[2])/self.mapScale
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','quitMiniMapModel',posx,posy,true)
self:closeSelf()







end





function UIXM_ZZSH_worldWin:refreshInfoPanel()
local isshow=self.filterFlag==true
self.infoPanel:setActive(isshow)
self.toggleFilterSelect:setActive(self.filterPage==1)
self.toggleSignSelect:setActive(self.filterPage==2)
if isshow then
if self.filterPage==1 then
self.filterPanel:setActive(true)
self.noSign:setActive(false)
self.signPanel:setActive(false)
if self.filterList==nil then
local filterList={}
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
local filterRecord=record.fliter or{}
for i,v in ipairs(self.filterCfg)do
local idx=v[4]
if not self.maskLookup[idx]then
table.insert(filterList,v)
if filterRecord[idx]==nil then
filterRecord[idx]=v[3]
end
filterList[i]=v
end
end
self.filterList=filterList
self.filterRecord=filterRecord

local c=#self.filterList
self.filterGridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.filterGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local d=self.filterList[i]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onFilterItemClick(i)
end)

if d.abName then
item:SetChildCSImageSprite(1,d.abName,d[2])
else
item:SetChildCSImageIcon(1,d[2],true)
end

item:SetChildText(2,d[1])

self:refeshFilterItemSelect(item,i,d[4])
end
end
self:refreshFilterAllBtn()
else
if self.signList==nil then
self:initSignList()
end
local c=#self.signList
local isshow=c>0
self.filterPanel:setActive(false)
self.noSign:setActive(not isshow)
self.signPanel:setActive(true)
self.signInfoOne:setActive(isshow and self.signModle==1)
self.signInfoTwo:setActive(isshow and self.signModle==2)
self:refreshSingNum()
self.signGridPanel:setActive(isshow)
if isshow then
self:refreshSignGridPanel()
end
self:refreshSingPageNum()
end
end
end

function UIXM_ZZSH_worldWin:onFilterItemClick(idx)
local d=self.filterList[idx]
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.fliter==nil then
record.fliter={}
end
local filter2Type=d[5]
if filter2Type==nil then
local idx_=d[4]
local flag=not self.filterRecord[idx_]
self.filterRecord[idx_]=flag
record.fliter=self.filterRecord
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)

self:refeshFilterItemSelect(nil,idx,idx_)
self:refreshFilterAllBtn()
self:refreshItemList()
end

if not self:checkOpenFilter2(idx)then
local item=self.filterGridPanel:getChildLayoutGroupGridItem(idx-1)
local pos=item:GetChildScreenPointToLocalPointRectangle(-1)
self:openFilter2(true,idx,pos.x,pos.y)
else
self:openFilter2(false)
end
end

function UIXM_ZZSH_worldWin:refeshFilterItemSelect(item,idx,idx_)
if item==nil then
item=self.filterGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local isblack=self.filterRecord[idx_]==false
item:SetChildActive(3,isblack)
end

function UIXM_ZZSH_worldWin:onFilterBtn()
self.filterFlag=not self.filterFlag
local icon=self.filterFlag and'button_sjbiaoshi_2'or'button_sjbiaoshi_1'
self.filterBtn:setCSImageSprite(globalABLookup.zzshicons,icon)
self:refreshInfoPanel()
if not self.filterFlag then
self:openFilter2(false)
end
end

function UIXM_ZZSH_worldWin:onFilterAllBtn()
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.fliter==nil then
record.fliter={}
end
local isall=true
for k,v in pairs(self.filterRecord)do
if v==false then
isall=false
break
end
end
local flag=not isall
for idx,d in ipairs(self.filterList)do
local idx_=d[4]
self.filterRecord[idx_]=flag
local filter2Type_=d[5]
if filter2Type_ then
if filter2Type_==1 then
if record.fliterMonster then
for sidx,_ in pairs(record.fliterMonster)do
record.fliterMonster[sidx]=flag
end
end
elseif filter2Type_==2 then
if record.fliterRes then
for sidx,_ in pairs(record.fliterRes)do
record.fliterRes[sidx]=flag
end
end
elseif filter2Type_==3 then
if record.fliterLingShan then
for sidx,_ in pairs(record.fliterLingShan)do
record.fliterLingShan[sidx]=flag
end
end
end
end
end
record.fliter=self.filterRecord
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)
local c=#self.filterList
local grids=self.filterGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local d=self.filterList[i]
self:refeshFilterItemSelect(item,i,d[4])
end
self:refreshFilterAllBtn()
self:refreshAllFilter2ItemSelect()
self:refreshItemList()
self:openFilter2(false)
end

function UIXM_ZZSH_worldWin:refreshFilterAllBtn()
local isall=true
for k,v in pairs(self.filterRecord)do
if v==false then
isall=false
break
end
end
self.filterAllSelect:setActive(isall)
local str=isall and'显示'or'隐藏'
self.filterAllBtnTxt:setText(str)
end

function UIXM_ZZSH_worldWin:checkOpenFilter2(idx)
local d=self.filterList[idx]
local filter2Type=d[5]
return filter2Type==nil or self.filter2Type==filter2Type
end

function UIXM_ZZSH_worldWin:openFilter2(flag,idx,moveX,moveY)
local isshow=false
if flag then
local d=self.filterList[idx]
local filter2Type=d[5]
isshow=filter2Type~=nil
self.filter2Panel:setActive(isshow)
if isshow then
self.filter2Panel:setLocalPos(moveX+315,moveY-37,0)
self.filter2Index=idx
self.filter2Type=filter2Type
local filter2List={}
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
local filter2Record
if filter2Type==1 then
filter2Record=record.fliterMonster or{}
for i=1,5 do
table.insert(filter2List,i)
if filter2Record[i]==nil then
filter2Record[i]=self.filterRecord[idx]
end
end
elseif filter2Type==2 then
filter2Record=record.fliterRes or{}
for i=1,5 do
table.insert(filter2List,i)
if filter2Record[i]==nil then
filter2Record[i]=self.filterRecord[idx]
end
end
elseif filter2Type==3 then
filter2Record=record.fliterLingShan or{}
for i=1,2 do
table.insert(filter2List,i)
if filter2Record[i]==nil then
filter2Record[i]=self.filterRecord[idx]
end
end
else
filter2Record={}
end
self.filter2List=filter2List
self.filter2Record=filter2Record

local c=#self.filter2List
self.filter2GridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.filter2GridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local d=self.filter2List[i]
local icon,name
if self.filter2Type==1 then
icon=FMT.fmt('icon_sjysbiaoshi_{0}',d)
name=FMT.fmt('{0}阶异兽',d)
elseif self.filter2Type==2 then
icon=FMT.fmt('icon_sjwpbiaoshibaodi_0{0}',d)
name=FMT.fmt('{0}阶宝地',d)
elseif self.filter2Type==3 then
local info=UILSZDControl:getLingShanInfo(i)
icon=info.mapIcon
name=info.name
end

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onFilter2ItemClick(i)
end)

item:SetChildCSImageSprite(1,globalABLookup.zzshicons,icon)

item:SetChildText(2,name)

self:refeshFilter2ItemSelect(item,i)
end
else
self.filter2Index=nil
self.filter2Type=nil
end
else
self.filter2Panel:setActive(false)
self.filter2Index=nil
self.filter2Type=nil
end
self.block:setActive(isshow)
end

function UIXM_ZZSH_worldWin:onFilter2ItemClick(sidx)
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
local flag=not self.filter2Record[sidx]
self.filter2Record[sidx]=flag
if self.filter2Type==1 then
record.fliterMonster=self.filter2Record
elseif self.filter2Type==2 then
record.fliterRes=self.filter2Record
elseif self.filter2Type==3 then
record.fliterLingShan=self.filter2Record
end
local hasone=false
for k,v in pairs(self.filter2Record)do
if v==true then
hasone=true
break
end
end
local d=self.filterList[self.filter2Index]
self.filterRecord[d[4]]=hasone
record.fliter=self.filterRecord
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)

self:refeshFilter2ItemSelect(nil,sidx)
self:refeshFilterItemSelect(nil,self.filter2Index,d[4])
self:refreshFilterAllBtn()
self:refreshItemList()
end

function UIXM_ZZSH_worldWin:refeshFilter2ItemSelect(item,sidx)
if item==nil then
item=self.filter2GridPanel:getChildLayoutGroupGridItem(sidx-1)
end
local isblack=self.filter2Record[sidx]==false
item:SetChildActive(3,isblack)
end

function UIXM_ZZSH_worldWin:refreshAllFilter2ItemSelect()
if self.filter2Type then
local c=#self.filter2List
local grids=self.filter2GridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refeshFilter2ItemSelect(item,i)
end
end
end



function UIXM_ZZSH_worldWin:onToggleSignBtn()
if self.filterPage==2 then return end
self.filterPage=2
self:refreshInfoPanel()
self:openFilter2(false)
end

function UIXM_ZZSH_worldWin:onToggleFilterBtn()
if self.filterPage==1 then return end
self.filterPage=1
self:refreshInfoPanel()
end

function UIXM_ZZSH_worldWin:onInfoPanel()
self:openFilter2(false)
end

function UIXM_ZZSH_worldWin:onBlock()
self:openFilter2(false)
end



function UIXM_ZZSH_worldWin:initSignList()
local signList=zhengzhanshanhaiModel:getSignRecord()
self.signList=table.weakCopy(signList)

local c=#self.signList
local maxSignPage
if c>0 then
maxSignPage=math.ceil(c/signNumOnPage)
else
maxSignPage=0
end
self.maxSignPage=maxSignPage
if self.curSignPage and self.curSignPage>self.maxSignPage then
if self.maxSignPage>0 then
self.curSignPage=self.maxSignPage
end
end
local isGray=self.maxSignPage<=0
self.signPageLeftBtn:setChildImageExGray(isGray)
self.signPageRightBtn:setChildImageExGray(isGray)
end

function UIXM_ZZSH_worldWin:refreshSingNum()
local cur=#self.signList
local max=zhengzhanshanhaiController:getZZSHCfg('maxSignNum')
local str=FMT.fmt('收藏 {0}/{1}',cur,max)
self.signNumTxt:setText(str)
end

function UIXM_ZZSH_worldWin:refreshSingPageNum()
local page_str
if self.maxSignPage>0 then
page_str=FMT.fmt('{0}/{1}',self.curSignPage,self.maxSignPage)
else
page_str='--'
end
self.signPageTxt:setText(page_str)
end

function UIXM_ZZSH_worldWin:refreshSignGridPanel()
local list={}
local c=#self.signList
local min=(self.curSignPage-1)*signNumOnPage+1
local max=math.min(c,self.curSignPage*signNumOnPage)
if min<=max then
for i=min,max do
table.insert(list,self.signList[i])
end
end
self.signPageList=list
local cc=#self.signPageList

self.signGridPanel:setChildLayoutGroupCreateItems(cc)
local grids=self.signGridPanel:getChildLayoutGroupGridList()
for i=1,cc do
local item=grids[i-1]
local d=self.signPageList[i]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onSignItemClick(i)
end)

local idx=(self.curSignPage-1)*signNumOnPage+i
item:SetChildText(4,tostring(idx))

local name_str=d.name or'未知'
item:SetChildText(1,name_str)

local pos_str=FMT.fmt('（{0},{1}）',d.x,d.y)
item:SetChildText(2,pos_str)

self:refeshSigntemToggle(item,i)
end
end

function UIXM_ZZSH_worldWin:jumpSignPos(x,y)

UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','quitMiniMapModel',x,y)
self:closeSelf()







end

function UIXM_ZZSH_worldWin:onSignItemClick(idx)
if self.lockClick then return end
if self.signModle==1 then

local d=self.signPageList[idx]
self:jumpSignPos(d.x,d.y)
else
local idx_=(self.curSignPage-1)*signNumOnPage+idx
local flag=self:checkSignSelected(idx_)
if self.signSelect==nil then
self.signSelect={}
end
if flag then
self.signSelect[idx_]=nil
else
self.signSelect[idx_]=true
end
self:refeshSigntemToggle(nil,idx)
end
end

function UIXM_ZZSH_worldWin:refeshSigntemToggle(item,idx)
if item==nil then
item=self.signGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local idx_=(self.curSignPage-1)*signNumOnPage+idx
local showToggle=self.signModle==2
item:SetChildActive(3,showToggle)
if showToggle then
local isSelected=self:checkSignSelected(idx_)
local icon=isSelected and'image_dygou_2'or'image_dygou_1'
item:SetChildCSImageSprite(3,globalABLookup.global,icon)
end
end

function UIXM_ZZSH_worldWin:checkSignSelected(idx)
local isSelected=false
if self.signSelect then
isSelected=self.signSelect[idx]==true
end
return isSelected
end

function UIXM_ZZSH_worldWin:onSignPageLeftBtn()
if self.maxSignPage<=0 then return end
local old=self.curSignPage
local cur=old
if cur>1 then
cur=cur-1
else
cur=self.maxSignPage
end
if old~=cur then
self.curSignPage=cur
self:refreshSignGridPanel()
self:refreshSingPageNum()
end
end

function UIXM_ZZSH_worldWin:onSignPageRightBtn()
if self.maxSignPage<=0 then return end
local old=self.curSignPage
local cur=old
if cur<self.maxSignPage then
cur=cur+1
else
cur=1
end
if old~=cur then
self.curSignPage=cur
self:refreshSignGridPanel()
self:refreshSingPageNum()
end
end

function UIXM_ZZSH_worldWin:onSignSetupBtn()
self.signModle=2
self:refreshInfoPanel()
end

function UIXM_ZZSH_worldWin:onSignBackBtn()
self.signModle=1
self.signSelect=nil
self:refreshInfoPanel()
end

function UIXM_ZZSH_worldWin:onSignDelBtn()
if self.signSelect==nil or next(self.signSelect)==nil then
UIManager.error('请选择要删除的标记')
return
end
local idxs={}
for idx,v in pairs(self.signSelect)do
table.insert(idxs,idx)
end
self.signSelect=nil
self.signList=nil
zhengzhanshanhaiModel:removeSignRecord(idxs)
self:refreshInfoPanel()
UIManager:invokeUIMethod('UIXM_ZZSH_signWin','handleSignRefresh')
end

function UIXM_ZZSH_worldWin:handleSignRefresh()
self.signList=nil
self.signSelect=nil
self:refreshInfoPanel()
end

function UIXM_ZZSH_worldWin:onSignAllBtn()
local c=#self.signList
if self.signSelect==nil then
self.signSelect={}
end
local cc=#self.signPageList
local isall=true
for i=1,cc do
local idx_=(self.curSignPage-1)*signNumOnPage+i
if self.signSelect[idx_]==nil then
isall=false
break
end
end
for i=1,cc do
local idx_=(self.curSignPage-1)*signNumOnPage+i
if isall then
self.signSelect[idx_]=nil
else
self.signSelect[idx_]=true
end
end
local grids=self.signGridPanel:getChildLayoutGroupGridList()
for i=1,cc do
local item=grids[i-1]
self:refeshSigntemToggle(item,i)
end
end

function UIXM_ZZSH_worldWin:onBackMyBtn()
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x then
self:jumpGridPos(g_x,g_y,true,nil)
end
end

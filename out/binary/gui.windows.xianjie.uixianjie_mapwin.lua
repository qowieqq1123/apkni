







def_class("UIXianJie_mapWin",UIWindowBase)









function UIXianJie_mapWin:bindComponents()

self.areaBtn=UIButton.get(self,0)
self.blockMask=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.filterBtn=UIButton.get(self,3)
self.frameBG=UIImage.get(self,4)
self.iconGrid=UIObject.get(self,5)
self.leftView=UIObject.get(self,6)
self.mapContent=UIObject.get(self,7)
self.mapRoot=UIObject.get(self,8)
self.mapSlider=UISlider.get(self,9)
self.overWidthMaskLayout=UIObject.get(self,10)
self.posTxt=UIText.get(self,11)
self.rightView=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.topView=UIObject.get(self,14)
self.uiroot=UIObject.get(self,15)
self.worldBtn=UIButton.get(self,16)
self.xianjiebg=UIImage.get(self,17)
self.xainyuEnter_1=UIButton.get(self,18)
self.xainyuEnter_2=UIButton.get(self,19)
self.xainyuEnter_3=UIButton.get(self,20)
self.xainyuEnter_4=UIButton.get(self,21)
self.xainyuEnter_5=UIButton.get(self,22)
self.xainyuEnter_6=UIButton.get(self,23)
self.xainyuEnter_7=UIButton.get(self,24)
self.xainyuEnter_8=UIButton.get(self,25)
self.relalbg=UIObject.get(self,26)
self.xianyubg=UIImage.get(self,27)
self.xainjieEnter_1=UIButton.get(self,28)
self.xainjieEnter_2=UIButton.get(self,29)
self.xainjieEnter_3=UIButton.get(self,30)
self.xainjieEnter_4=UIButton.get(self,31)
self.xainjieEnter_5=UIButton.get(self,32)
self.xainjieEnter_6=UIButton.get(self,33)
self.xainjieEnter_7=UIButton.get(self,34)
self.xainjieEnter_8=UIButton.get(self,35)
self.XJshili_XianGong=UIButton.get(self,36)
self.XJshili_PengLai=UIButton.get(self,37)
self.XJshili_YuJing=UIButton.get(self,38)
self.XJshili_JiuYuan=UIButton.get(self,39)
self.XYshili_LingMai=UIButton.get(self,40)
self.xianjieBtn=UIButton.get(self,41)
self.myxianyuBtn=UIButton.get(self,42)
self.zongmengBtn=UIButton.get(self,43)
self.cloudRoot=UIObject.get(self,44)
self.xainjieRoot=UIObject.get(self,45)
self.xainyuRoot=UIObject.get(self,46)
self.miniBg=UIObject.get(self,47)
self.mojiebg=UIImage.get(self,48)
self.mojieRoot=UIObject.get(self,49)
self.moyuEnter_1=UIButton.get(self,50)
self.moyuEnter_2=UIButton.get(self,51)
self.moyuEnter_3=UIButton.get(self,52)
self.moyuEnter_4=UIButton.get(self,53)
self.moyuEnter_5=UIButton.get(self,54)
self.moyuEnter_6=UIButton.get(self,55)
self.moyuEnter_7=UIButton.get(self,56)
self.moyuEnter_8=UIButton.get(self,57)
self.mjbgpanel=UIObject.get(self,58)
self.mjbgone=UIObject.get(self,59)
self.mjbgtwo=UIObject.get(self,60)
self.mjbgthiree=UIObject.get(self,61)
self.mojieArearoot=UIObject.get(self,62)

self.areaBtn:setButtonClick(function()self:onAreaBtn()end)

self.blockMask:setButtonClick(function()self:onBlockMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.worldBtn:setButtonClick(function()self:onWorldBtn()end)

self.xainyuEnter_1:setButtonClick(function()self:onXainyuEnter_1()end)

self.xainyuEnter_2:setButtonClick(function()self:onXainyuEnter_2()end)

self.xainyuEnter_3:setButtonClick(function()self:onXainyuEnter_3()end)

self.xainyuEnter_4:setButtonClick(function()self:onXainyuEnter_4()end)

self.xainyuEnter_5:setButtonClick(function()self:onXainyuEnter_5()end)

self.xainyuEnter_6:setButtonClick(function()self:onXainyuEnter_6()end)

self.xainyuEnter_7:setButtonClick(function()self:onXainyuEnter_7()end)

self.xainyuEnter_8:setButtonClick(function()self:onXainyuEnter_8()end)

self.xainjieEnter_1:setButtonClick(function()self:onXainjieEnter_1()end)

self.xainjieEnter_2:setButtonClick(function()self:onXainjieEnter_2()end)

self.xainjieEnter_3:setButtonClick(function()self:onXainjieEnter_3()end)

self.xainjieEnter_4:setButtonClick(function()self:onXainjieEnter_4()end)

self.xainjieEnter_5:setButtonClick(function()self:onXainjieEnter_5()end)

self.xainjieEnter_6:setButtonClick(function()self:onXainjieEnter_6()end)

self.xainjieEnter_7:setButtonClick(function()self:onXainjieEnter_7()end)

self.xainjieEnter_8:setButtonClick(function()self:onXainjieEnter_8()end)

self.XJshili_XianGong:setButtonClick(function()self:onXJshili_XianGong()end)

self.XJshili_PengLai:setButtonClick(function()self:onXJshili_PengLai()end)

self.XJshili_YuJing:setButtonClick(function()self:onXJshili_YuJing()end)

self.XJshili_JiuYuan:setButtonClick(function()self:onXJshili_JiuYuan()end)

self.XYshili_LingMai:setButtonClick(function()self:onXYshili_LingMai()end)

self.xianjieBtn:setButtonClick(function()self:onXianjieBtn()end)

self.myxianyuBtn:setButtonClick(function()self:onMyxianyuBtn()end)

self.zongmengBtn:setButtonClick(function()self:onZongmengBtn()end)

self.moyuEnter_1:setButtonClick(function()self:onMoyuEnter_1()end)

self.moyuEnter_2:setButtonClick(function()self:onMoyuEnter_2()end)

self.moyuEnter_3:setButtonClick(function()self:onMoyuEnter_3()end)

self.moyuEnter_4:setButtonClick(function()self:onMoyuEnter_4()end)

self.moyuEnter_5:setButtonClick(function()self:onMoyuEnter_5()end)

self.moyuEnter_6:setButtonClick(function()self:onMoyuEnter_6()end)

self.moyuEnter_7:setButtonClick(function()self:onMoyuEnter_7()end)

self.moyuEnter_8:setButtonClick(function()self:onMoyuEnter_8()end)
self.xainyuEnter={
self.xainyuEnter_1,
self.xainyuEnter_2,
self.xainyuEnter_3,
self.xainyuEnter_4,
self.xainyuEnter_5,
self.xainyuEnter_6,
self.xainyuEnter_7,
self.xainyuEnter_8,
}
self.xainjieEnter={
self.xainjieEnter_1,
self.xainjieEnter_2,
self.xainjieEnter_3,
self.xainjieEnter_4,
self.xainjieEnter_5,
self.xainjieEnter_6,
self.xainjieEnter_7,
self.xainjieEnter_8,
}
self.moyuEnter={
self.moyuEnter_1,
self.moyuEnter_2,
self.moyuEnter_3,
self.moyuEnter_4,
self.moyuEnter_5,
self.moyuEnter_6,
self.moyuEnter_7,
self.moyuEnter_8,
}
self.XJshili={
["XianGong"]=self.XJshili_XianGong,
["PengLai"]=self.XJshili_PengLai,
["YuJing"]=self.XJshili_YuJing,
["JiuYuan"]=self.XJshili_JiuYuan,
}
self.XYshili={
["LingMai"]=self.XYshili_LingMai,
}



end


function UIXianJie_mapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.areaBtn);self.areaBtn=nil;
_UIObject_release(self.blockMask);self.blockMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.frameBG);self.frameBG=nil;
_UIObject_release(self.iconGrid);self.iconGrid=nil;
_UIObject_release(self.leftView);self.leftView=nil;
_UIObject_release(self.mapContent);self.mapContent=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.mapSlider);self.mapSlider=nil;
_UIObject_release(self.overWidthMaskLayout);self.overWidthMaskLayout=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.rightView);self.rightView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.topView);self.topView=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.worldBtn);self.worldBtn=nil;
_UIObject_release(self.xianjiebg);self.xianjiebg=nil;
_UIObject_release(self.xainyuEnter_1);self.xainyuEnter_1=nil;
_UIObject_release(self.xainyuEnter_2);self.xainyuEnter_2=nil;
_UIObject_release(self.xainyuEnter_3);self.xainyuEnter_3=nil;
_UIObject_release(self.xainyuEnter_4);self.xainyuEnter_4=nil;
_UIObject_release(self.xainyuEnter_5);self.xainyuEnter_5=nil;
_UIObject_release(self.xainyuEnter_6);self.xainyuEnter_6=nil;
_UIObject_release(self.xainyuEnter_7);self.xainyuEnter_7=nil;
_UIObject_release(self.xainyuEnter_8);self.xainyuEnter_8=nil;
_UIObject_release(self.relalbg);self.relalbg=nil;
_UIObject_release(self.xianyubg);self.xianyubg=nil;
_UIObject_release(self.xainjieEnter_1);self.xainjieEnter_1=nil;
_UIObject_release(self.xainjieEnter_2);self.xainjieEnter_2=nil;
_UIObject_release(self.xainjieEnter_3);self.xainjieEnter_3=nil;
_UIObject_release(self.xainjieEnter_4);self.xainjieEnter_4=nil;
_UIObject_release(self.xainjieEnter_5);self.xainjieEnter_5=nil;
_UIObject_release(self.xainjieEnter_6);self.xainjieEnter_6=nil;
_UIObject_release(self.xainjieEnter_7);self.xainjieEnter_7=nil;
_UIObject_release(self.xainjieEnter_8);self.xainjieEnter_8=nil;
_UIObject_release(self.XJshili_XianGong);self.XJshili_XianGong=nil;
_UIObject_release(self.XJshili_PengLai);self.XJshili_PengLai=nil;
_UIObject_release(self.XJshili_YuJing);self.XJshili_YuJing=nil;
_UIObject_release(self.XJshili_JiuYuan);self.XJshili_JiuYuan=nil;
_UIObject_release(self.XYshili_LingMai);self.XYshili_LingMai=nil;
_UIObject_release(self.xianjieBtn);self.xianjieBtn=nil;
_UIObject_release(self.myxianyuBtn);self.myxianyuBtn=nil;
_UIObject_release(self.zongmengBtn);self.zongmengBtn=nil;
_UIObject_release(self.cloudRoot);self.cloudRoot=nil;
_UIObject_release(self.xainjieRoot);self.xainjieRoot=nil;
_UIObject_release(self.xainyuRoot);self.xainyuRoot=nil;
_UIObject_release(self.miniBg);self.miniBg=nil;
_UIObject_release(self.mojiebg);self.mojiebg=nil;
_UIObject_release(self.mojieRoot);self.mojieRoot=nil;
_UIObject_release(self.moyuEnter_1);self.moyuEnter_1=nil;
_UIObject_release(self.moyuEnter_2);self.moyuEnter_2=nil;
_UIObject_release(self.moyuEnter_3);self.moyuEnter_3=nil;
_UIObject_release(self.moyuEnter_4);self.moyuEnter_4=nil;
_UIObject_release(self.moyuEnter_5);self.moyuEnter_5=nil;
_UIObject_release(self.moyuEnter_6);self.moyuEnter_6=nil;
_UIObject_release(self.moyuEnter_7);self.moyuEnter_7=nil;
_UIObject_release(self.moyuEnter_8);self.moyuEnter_8=nil;
_UIObject_release(self.mjbgpanel);self.mjbgpanel=nil;
_UIObject_release(self.mjbgone);self.mjbgone=nil;
_UIObject_release(self.mjbgtwo);self.mjbgtwo=nil;
_UIObject_release(self.mjbgthiree);self.mjbgthiree=nil;
_UIObject_release(self.mojieArearoot);self.mojieArearoot=nil;
self.xainyuEnter=nil;
self.xainjieEnter=nil;
self.moyuEnter=nil;
self.XJshili=nil;
self.XYshili=nil;
end
















local _this=nil
local mapMinScale=0.5
local mapMaxScale=0.9
local mapDefaultScale=0.9
local dragTimeOffset=0.2
local dragDistanceOffset=10
local maskWins={

}

local senceTypeList={xianjienSceneType.eXianYu_1,xianjienSceneType.eXianYu_2,
xianjienSceneType.eXianYu_3,xianjienSceneType.eXianYu_4,xianjienSceneType.eXianYu_5,
xianjienSceneType.eXianYu_6,xianjienSceneType.eXianYu_7,xianjienSceneType.eXianYu_8}

local recordscale=nil
local minSlider=1
local maxSlider=50
local abName="ui/windows/xianjie/xianjiemap/xianjiemap_atlas_pak.ab"
local bgAb="ui/windows/xianjie/sharedtextures/xianjie_xiaoditu_beijingtu.ab"
local xjbgAb="ui/windows/xianjie/sharedtextures/xianjie_xiaoditu_ditu.ab"
local xybgAb="ui/windows/xianjie/sharedtextures/xianyu_xiaoditu_ditu.ab"
local minixjbgAb="ui/windows/xianjie/sharedtextures/xianjie_xiaoditu_ditu2.ab"
local minixybgAb="ui/windows/xianjie/sharedtextures/xianyu_xiaoditu_ditu2.ab"
local mojiebgAb="ui/windows/xianjie/sharedtextures/minimap_8.ab"
local minimojiebgAb="ui/windows/xianjie/sharedtextures/minimap_8.ab"
local areatxtidx={1,2,3,4,5,6,7,8}
local areasidx={9,10,11,12,13,14,15,16}

function UIXianJie_mapWin:onLoaded(...)
self.isRunMiniGame=deviceHelper.isRunMiniGame()
_this=self
self:bindComponents()
self.root:setChildCanvasGroupAlpha(0)
self:addNotify(notifyConfig.showUI,self.showUI)
self:addNotify(notifyConfig.closeUI,self.closeUI)
xianjieController:set2DMapModel(true)
self.winLookup={}
self.mView={}
self.is_enableDrag=true

local s_func=function(pos)
if _this==nil then return end
_this.lockClick=true
_this.lockClickTime=Time.realtimeSinceStartup
_this.lockClickPos=pos
_this.sliderScale=nil
_this:AreaNameOnShow()
end
local e_func=function(pos)
if _this==nil then return end
_this.lockClick=false
_this.zoomCall=false

_this:refreshMapViewPos()
_this:refreshAOI()
if _this==nil then return end
if _this.clickEntity then
local lerpTime=Time.realtimeSinceStartup-_this.lockClickTime
local dis=mathHelper.distance(pos.x,pos.y,_this.lockClickPos.x,_this.lockClickPos.y)
if dis<dragDistanceOffset and lerpTime<dragTimeOffset then
local ent=xianjieController:get2DEntity(_this.clickEntity)
if ent then
ent:onClick()
end
end
if _this==nil then return end
_this.clickEntity=nil
end
if _this.curSignRecordClickPos then
local lerpTime=Time.realtimeSinceStartup-_this.lockClickTime
local dis=mathHelper.distance(pos.x,pos.y,_this.lockClickPos.x,_this.lockClickPos.y)
if dis<dragDistanceOffset and lerpTime<dragTimeOffset then
_this:onMapClickUp(_this.curSignRecordClickPos)
end
if _this==nil then return end
_this.curSignRecordClickPos=nil
end
_this:AreaNameOnHide()
end
self.mapRoot:setChildDragStartAndEndEvent(s_func,e_func)
self.mapRoot:setChildZoomLimit(mapMaxScale,mapMinScale)
local oneFingerDragCallBack=function()

end
local twoFingerDragCallBack=function()

end

local zoomCallBack=function(oldPos,newPos,oldScale,newScale,dis)
if _this==nil then return end
_this.zoomCall=true
self:refreshSlider(newScale)
end
self.mapRoot:setChildDragAndZoomEvent(oneFingerDragCallBack,twoFingerDragCallBack,zoomCallBack)
local onMapUp2=function(num,clickPos)
if _this==nil then return end
_this:onMapClickUp(clickPos)
end
self.frameBG:setChildUITouchEvent(onMapUp2,nil,nil)
xianjieController:getFilterEntity2DCfg(true)
end

function UIXianJie_mapWin:setClickEntity(ojbID)
self.clickEntity=ojbID
end

function UIXianJie_mapWin:checkLockClick()
return self.lockClick
end


function UIXianJie_mapWin:__delete()
_this=nil
self:unbindComponents()
self:stopAreaShowTimer()
xianjieController:set2DMapModel(nil)

xianjieController:removeAll2DEntitys()
clear_xj2DEntityWidgetPool()
xianjieController:clearScene(true)
end


function UIXianJie_mapWin:onHide()
xianjieController:set2DMapModel(nil)
self:clearTimer()

self:enableDrag(false)

xianjieController:removeAll2DEntitys()
end

function UIXianJie_mapWin:checkWinLookup()
for k,v in pairs(self.winLookup)do
if v then
return false
end
end
return true
end

function UIXianJie_mapWin.showUI(name)
if _this==nil or not _this.isVisible then return end
if maskWins[name]==nil then
_this.winLookup[name]=true
local flag_=false
if _this.is_enableDrag~=flag_ then
_this:enableDrag(flag_,true)
end
end
end

function UIXianJie_mapWin.closeUI(name)
if _this==nil then return end
_this.winLookup[name]=nil
if not _this.isVisible then return end
local flag=_this:checkWinLookup()
if flag then
_this:enableDrag(true)
end
end




function UIXianJie_mapWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupDOFade(1,1)
self.scaleFactor=UIManager.defaultCanvas_trans.localScale
xianjieController:set2DMapModel(true)
self.inXianJie=xianjieModel:checkSceneIndex(xianjienSceneIndexType.eXianJie)
local nowSceneIdx=xianjieModel:getSceneIndex()
self.isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
self.isInMGZD=nowSceneIdx and xianjienSceneIndexType:isMoGongZhengDuo(nowSceneIdx)or false
if afterOnloaded then
xianjieController:clearScene(false)
end

self:initAreaId()
self:MoJieCouldCheck()
self:initMap()
self:initCloud()
self:refreshBtn()
self:refreshEnter()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:updataAllEntities()
end)
end
if self.fasttimer==nil then
self.fasttimer=self:setTimer(0.2,0,function()
self:fastUpdate()
end)
end
if not afterOnloaded then
self.rectAOI=nil
end
self:handleJump(argtable)
end

function UIXianJie_mapWin:handleJump(argtable)

local jumpPos=argtable.jumpPos
if jumpPos~=nil then
self:move2GridPos(jumpPos[1],jumpPos[2],-1,false,0)
else
local pos=xianjieController:getCameraLookAtPlanePos()
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
self:move2GridPos(gridX,gridZ,-1,false,0)
end
end

function UIXianJie_mapWin:fastUpdate()
local scale=self.sliderScale
if scale~=nil then
local mView=self.mView
local scaleType=Vector3(scale,scale,scale)
self.changeSliderMark=true
self:move2GridPos(mView.g_x,mView.g_y,-1,false,scaleType,nil)
self.sliderScale=nil
self.changeSliderMark=nil
end
end

function UIXianJie_mapWin:clearTimer()
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
if self.fasttimer~=nil then
self:stopTimerByID(self.fasttimer)
self.fasttimer=nil
end
end


function UIXianJie_mapWin:enableDrag(flag,lockTime)
if self.is_enableDrag~=flag then
self.is_enableDrag=flag
self.mapRoot:setChildDragZoomEnable(flag)
end
if not flag and lockTime then
self.lockTime_blockMask=Time.realtimeSinceStartup+2
end
self.blockMask:setActive(not flag)
end

function UIXianJie_mapWin:getMapView()
local view=self.mView
if view then
local view_={}
view_.g_x=view.g_x
view_.g_y=view.g_y
view_.scale=view.scale
return view_
end
end







function UIXianJie_mapWin:move2GridPos(g_x,g_y,anim,isLocal,scaleType,func)
local old=self.is_enableDrag
local markOld
if not old then
markOld=1
self:enableDrag(true)
end

local mapScale=self.mapContent:getScale()
local view
local scale_
local ease_
if type(scaleType)=='number'then
local scale
if scaleType==1 then
scale_=Vector3(mapMaxScale,mapMaxScale,mapMaxScale)
scale=mapScale
mapScale=scale_
elseif scaleType==2 then
scale_=Vector3(mapMinScale,mapMinScale,mapMinScale)
scale=mapScale
mapScale=scale_
end
if scale then
view={g_x=g_x,g_y=g_y,scale=scale}
end
else
scale_=scaleType
mapScale=scale_
ease_=DG.Tweening.Ease.InQuart
end
local func2=function()
if _this==nil then return end
if func then
func(view)
end
end

local posx,posy
if not isLocal then
posx,posy=xianjieController:gridPos2localPos_2DEnity(g_x,g_y)
else
posx=g_x
posy=g_y
end

posx=posx*mapScale.x
posy=posy*mapScale.y



local scaleFactor=self.scaleFactor
local height=UnityEngine.Screen.height/scaleFactor.y
local width=UnityEngine.Screen.width/scaleFactor.x
local h_w=width/2
local h_h=height/2

local topLeftX=posx-h_w
local topLeftY=posy+h_h
local bottomRightX=posx+h_w
local bottomRightY=posy-h_h



local mapWidth=self.mapWidth*mapScale.x
local mapHeight=self.mapHeight*mapScale.x
local h_w_=mapWidth/2
local h_h_=mapHeight/2

local topLeftX_=-h_w_
local topLeftY_=h_h_
local bottomRightX_=h_w_
local bottomRightY_=-h_h_


if topLeftX<topLeftX_ then
posx=posx+(topLeftX_-topLeftX)
elseif bottomRightX>bottomRightX_ then
posx=posx-(bottomRightX-bottomRightX_)
end
if topLeftY>topLeftY_ then
posy=posy-(topLeftY-topLeftY_)
elseif bottomRightY<bottomRightY_ then
posy=posy+(bottomRightY_-bottomRightY)
end


posx=-posx
posy=-posy

anim=anim or 0
if anim==0 then
anim=0.6
end
local func3=function()
if _this==nil then return end
if markOld~=nil then
local flag=_this:checkWinLookup()
if not flag then
_this:enableDrag(false)
end
end
_this:refreshMapViewPos()
_this:refreshAOI()
end
if anim>0 then
self:delayDo(0.1,function()
func2()
end)
ease_=ease_ or DG.Tweening.Ease.OutExpo

if scale_ then
local tween1=self.mapContent:setChildDOScale(scale_.x,anim,nil)
tween1:SetEase(ease_)
end
local tween2=self.mapContent:setChildDOLocalMove(Vector3(posx,posy,0),anim,func3)
tween2:SetEase(ease_)
self:initFloatSignTimer()
else
if scale_ then
self.mapContent:setScale(scale_)
end
self.mapContent:setLocalPos(posx,posy,0)
func3()
func2()
end
end

function UIXianJie_mapWin:onBlockMask()
if self.lockTime_blockMask then
if Time.realtimeSinceStartup<self.lockTime_blockMask then
return
else
self.lockTime_blockMask=nil
end
end
self:enableDrag(true)
end


function UIXianJie_mapWin:refreshMapViewPos()
local scale=self.mapContent:getScale()
local pos=self.mapContent:getChildLocalPosition()

local x=math.floor((0-pos.x)/scale.x)
local y=math.floor((0-pos.y)/scale.y)

local g_x,g_y=xianjieController:localPos2gridPos_2DEnity(x,y)
local pos_str=FMT.fmt('X：<color=#ebe0ce>{0}</color>  Y：<color=#ebe0ce>{1}</color>',g_x,g_y)
self.posTxt:setText(pos_str)
self.mView.g_x=g_x
self.mView.g_y=g_y
self.mView.scale=scale
end

function UIXianJie_mapWin:scale2sliderNum(scale)
local sNum=minSlider+math.floor((1-(scale-mapMinScale)/(mapMaxScale-mapMinScale))*(maxSlider-minSlider))
return sNum
end

function UIXianJie_mapWin:slider2scaleNum(sNum)
local scale=mapMinScale+(1-(sNum-minSlider)/(maxSlider-minSlider))*(mapMaxScale-mapMinScale)
return scale
end

function UIXianJie_mapWin:initMap()
local baseCfg=xianjieController:get2DMapCfg()

local realW=baseCfg.w*baseCfg.gw
local realH=baseCfg.h*baseCfg.gh
self.relalbg:setChildSizeDelta(realW,realH)
self.relalbg:setActive(false)





















local w=baseCfg.w*baseCfg.gw+baseCfg.bw*2
local h=baseCfg.h*baseCfg.gh+baseCfg.bh*2
self.mapWidth=w
self.mapHeight=h

self.frameBG:setChildSizeDelta(w,h)








self.mapContent:setChildSizeDelta(w,h)
self.mapContent:setScale(Vector3(mapDefaultScale,mapDefaultScale,mapDefaultScale))

local sNum=self:scale2sliderNum(mapDefaultScale)
self.lockSlider=true
self.mapSlider:setSlider(sNum,minSlider,maxSlider,function(v)
if _this==nil then return end
_this:onSliderChange(v)
end)
self.lockSlider=false
self:refreshMapViewPos()

self:delayDo(0.1,function()
self:createEntitys()
end)
end

function UIXianJie_mapWin:initCloud()
self.cloudRoot:setActive(self.inXianJie or self.isInMoJie or self.isInMGZD)
self.worldBtn:setActive(not self.isInMoJie and not self.isInMGZD)
if self.inXianJie then
local baseCfg=xianjieController:get2DMapCfg()
local realW=baseCfg.w*baseCfg.gw
local realH=baseCfg.h*baseCfg.gh

local list=cfg_fairylandcloudconfig()
local teampList={}
for cloudid,cfg in ipairs(list)do
local cloudData=xianjieModel:getCloudData(cloudid)
if not cloudData or not cloudData:isUnlock()then
for i,cloudid_ in ipairs(cfg.ids)do
local temp={}
temp.pos=cloudid_
temp.cloudid=cloudid
table.insert(teampList,temp)
end
end
end

local num=#teampList
local cw=realW/7
local ch=realH/7
self.cloudRoot:setChildLayoutGroupCreateItems(num,function(index)
local cloudItem=self.cloudRoot:getChildLayoutGroupGridItem(index-1)
local temp=teampList[index]
local pos=temp.pos
local rol=math.ceil(pos/7)
local col=pos%7==0 and 7 or pos%7
local posx=baseCfg.bw+(col-1)*cw
local posy=baseCfg.bh+(rol-1)*ch
cloudItem:SetChildAnchoredPos(0,posx,posy)
cloudItem:SetChildSizeDelta(0,cw,ch)
local cfg=self.isRunMiniGame and cfg_minigamefairylandminimapcloudiconconfig_get(pos)or cfg_fairylandminimapcloudiconconfig_get(pos)

cloudItem:SetChildCSImageSprite(1,abName,cfg.mainIcon)
if cfg.mainIconPos then
cloudItem:SetChildAnchoredPos(1,cfg.mainIconPos[1],cfg.mainIconPos[2])
end
if cfg.mainIconScale then
cloudItem:SetChildScale(1,Vector3.New(cfg.mainIconScale,cfg.mainIconScale,cfg.mainIconScale))
end
if cfg.mainIconRota then
cloudItem:SetChildRotation(1,cfg.mainIconRota[1],cfg.mainIconRota[2],cfg.mainIconRota[3])
end


if cfg.otherIcon then
cloudItem:SetChildActive(3,true)
cloudItem:SetChildCSImageSprite(3,abName,cfg.otherIcon)
if cfg.otherIconPos then
cloudItem:SetChildAnchoredPos(3,cfg.otherIconPos[1],cfg.otherIconPos[2])
end
if cfg.otherIconScale then
cloudItem:SetChildScale(3,Vector3.New(cfg.otherIconScale,cfg.otherIconScale,cfg.otherIconScale))
end
if cfg.otherIconRota then
cloudItem:SetChildRotation(3,cfg.otherIconRota[1],cfg.otherIconRota[2],cfg.otherIconRota[3])
end
else
cloudItem:SetChildActive(3,false)
end
end)

elseif self.isInMoJie or self.isInMGZD then
local baseCfg=xianjieController:get2DMapCfg()
local realW=baseCfg.w*baseCfg.gw
local realH=baseCfg.h*baseCfg.gh


end
end
function UIXianJie_mapWin:onSliderChange(v)

if self.lockSlider then






return
end


self.sliderScale=self:slider2scaleNum(v)






end

function UIXianJie_mapWin:refreshSlider(scale)
local sNum=self:scale2sliderNum(scale)
self.lockSlider=true
self.mapSlider:setChildSliderRefresh(sNum)
if not self or self.isClose then return end
self.lockSlider=false
end




function UIXianJie_mapWin:createEntitys()
local iconWidget=self.iconGrid:getWidgetBase()
local lp=xianjieController:getEntityLookup()
for key,ent in pairs(lp)do
xianjieController:add2DEntity2(ent,iconWidget)
end
self:refreshAOI(true)
end


function UIXianJie_mapWin:refreshAOI(needRefresh)
local scale=self.mapContent:getScale()
local pos=self.mapContent:getChildLocalPosition()


local x=(0-pos.x)/scale.x
local y=(0-pos.y)/scale.y


local scaleFactor=self.scaleFactor
local height=UnityEngine.Screen.height/(scaleFactor.y*scale.y)
local width=UnityEngine.Screen.width/(scaleFactor.x*scale.x)
local x1=x-width/2-10
local y1=y-height/2-10
local x2=x+width/2+10
local y2=y+height/2+10
local mapScale=scale.x
local rectAOI=self.rectAOI
local changeScale=false
if needRefresh or rectAOI==nil or not mathHelper.rectInRect(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],x1,y1,x2,y2)then

local rectAOI_old
if rectAOI~=nil then
rectAOI_old=self.rectAOI_old
if rectAOI_old~=nil then
rectAOI_old[1]=rectAOI[1]
rectAOI_old[2]=rectAOI[2]
rectAOI_old[3]=rectAOI[3]
rectAOI_old[4]=rectAOI[4]
rectAOI_old[5]=rectAOI[5]
else
rectAOI_old={rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5]}
self.rectAOI_old=rectAOI_old
end
rectAOI[1]=x1
rectAOI[2]=y1
rectAOI[3]=x2
rectAOI[4]=y2
rectAOI[5]=mapScale
changeScale=rectAOI[5]~=rectAOI_old[5]
else
rectAOI={x1,y1,x2,y2,mapScale}
self.rectAOI=rectAOI
changeScale=true
end
xianjieController:refresh2DMapAOI(x1,y1,x2,y2,mapScale,rectAOI_old)
else
if mapScale~=rectAOI[5]then
changeScale=true
rectAOI[5]=mapScale
xianjieController:refresh2DMapAOIScale(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],mapScale)
end
end
if changeScale and not self.changeSliderMark then
self:refreshSlider(rectAOI[5])
end
end


































function UIXianJie_mapWin:getRectAOI()
return self.rectAOI
end

function UIXianJie_mapWin:updataAllEntities()
xianjieController:updataAll2DEntities()
end




function UIXianJie_mapWin:onFilterBtn()
self.filterFlag=not self.filterFlag
local icon=self.filterFlag and'button_sjbiaoshi_2'or'button_sjbiaoshi_1'
self.filterBtn:setCSImageSprite(globalABLookup.zzshicons,icon)
if self.filterFlag then
self:showWindow('UIXianJie_filteEntity2DWin')
else
self:closeWindow('UIXianJie_filteEntity2DWin')
end
end

function UIXianJie_mapWin:closeFilterWin()
if self.filterFlag then
self:onFilterBtn()
end
end

function UIXianJie_mapWin:closeFilterWin2()
self.filterFlag=nil
end


function UIXianJie_mapWin:onMapClickUp(clickPos)

end

function UIXianJie_mapWin:onMinSlider()
local sceneType=xianjieModel:getScenceType()
local cameraZoom=xianjieController:getCameraZoomRange2(sceneType)
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
local miniMapOffest=sceneCfg.miniMapOffest
local maxH=cameraZoom[2]
local mView=self.mView
local lookpos=xianjieController:worldGridPos2WorldPos4(mView.g_x,mView.g_y)
local hight=maxH-miniMapOffest
xianjieController:lookAtPositionChangeHeight(lookpos,hight,0,nil,nil,nil)
self:closeSelf()
end

function UIXianJie_mapWin:onAreaBtn()
self:onCloseBtn()
end

function UIXianJie_mapWin:onWorldBtn()


UIManager:showWindow("UIXianJie_WorldMapWin")
end

function UIXianJie_mapWin:onCloseBtn()
local mView=self.mView
local lookpos=xianjieController:worldGridPos2WorldPos4(mView.g_x,mView.g_y)
xianjieController:lookAtPosition(lookpos,nil,0,nil,nil,nil)
self:closeSelf()
end


function UIXianJie_mapWin:onCloseBtn2()
self:closeSelf()
end

function UIXianJie_mapWin:onClickXainyuEnter(type)
if self:checkLockClick()then
return
end
if systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)then
xianjieController:jumpXianJie(type)
else
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianYuEnter,nil,"开启仙域")
UIManager.error(tips)
end
self:onCloseBtn2()
end

function UIXianJie_mapWin:onXainyuEnter_1()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_1)
end

function UIXianJie_mapWin:onXainyuEnter_2()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_2)
end

function UIXianJie_mapWin:onXainyuEnter_3()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_3)
end

function UIXianJie_mapWin:onXainyuEnter_4()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_4)
end

function UIXianJie_mapWin:onXainyuEnter_5()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_5)
end

function UIXianJie_mapWin:onXainyuEnter_6()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_6)
end

function UIXianJie_mapWin:onXainyuEnter_7()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_7)
end

function UIXianJie_mapWin:onXainyuEnter_8()
self:onClickXainyuEnter(xianjienSceneType.eXianYu_8)
end

function UIXianJie_mapWin:onClickXainjieEnter(index)
if self:checkLockClick()then
return
end
local flag=xianjieController:jumpXianJie(xianjienSceneType.eXianJie)



self:onCloseBtn2()
end

function UIXianJie_mapWin:onXainjieEnter_1()
self:onClickXainjieEnter(1)
end

function UIXianJie_mapWin:onXainjieEnter_2()
self:onClickXainjieEnter(2)
end

function UIXianJie_mapWin:onXainjieEnter_3()
self:onClickXainjieEnter(3)
end

function UIXianJie_mapWin:onXainjieEnter_4()
self:onClickXainjieEnter(4)
end

function UIXianJie_mapWin:onXainjieEnter_5()
self:onClickXainjieEnter(5)
end

function UIXianJie_mapWin:onXainjieEnter_6()
self:onClickXainjieEnter(6)
end

function UIXianJie_mapWin:onXainjieEnter_7()
self:onClickXainjieEnter(7)
end

function UIXianJie_mapWin:onXainjieEnter_8()
self:onClickXainjieEnter(8)
end

function UIXianJie_mapWin:onXainjieEnter_1()
self:onClickXainjieEnter(1)
end

function UIXianJie_mapWin:onXJshili_XianGong()
if self:checkLockClick()then
return
end
xianjieModel:JumptoForce(2)
end

function UIXianJie_mapWin:onXJshili_PengLai()
if self:checkLockClick()then
return
end
xianjieModel:JumptoForce(3)
end

function UIXianJie_mapWin:onXJshili_YuJing()
if self:checkLockClick()then
return
end
xianjieModel:JumptoForce(1)
end

function UIXianJie_mapWin:onXJshili_JiuYuan()
if self:checkLockClick()then
return
end
xianjieModel:JumptoForce(4)
end

function UIXianJie_mapWin:onXYshili_LingMai()
if self:checkLockClick()then
return
end


local entityId=xjClientBuildType.flcbXianYuLingMai
local entityType=xjServerEnityType.eClientBuild
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,entityType)
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,entityId)
local sceneidx=xianjieModel:getSceneIndex()
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
local pos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c,sceneidx)
xianjieController:lookAtPosition(pos,nil,0.2,nil,DG.Tweening.Ease.Linear)
self:onCloseBtn2()
end

function UIXianJie_mapWin:onXianjieBtn()
local flag=xianjieController:jumpXianJie(xianjienSceneType.eXianJie)



self:onCloseBtn2()
end

function UIXianJie_mapWin:onMyxianyuBtn()





if systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)then
if not xianjieModel:checkJoin()then
xianjieController:reqCreateZMPos()
else
local sceneidx_=xianjieModel:getXianYuSceneIndex()
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx_)
xianjieController:jumpXianJie(sceneType)
end
else
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianYuEnter,nil,"开启仙域")
UIManager.error(tips)
end
self:onCloseBtn2()
end

function UIXianJie_mapWin:onZongmengBtn()
xianjieModel:jumpMyZongMen()
self:onCloseBtn2()

end


function UIXianJie_mapWin:refreshBtn()
local mySceneidx=xianjieModel:getXianYuSceneIndex()
local curSceneType=xianjieModel:getScenceType()
local curSceneidx=xianjieModel:getSceneIndex()
local cross_sid=xianjieModel:getXianYuCrossServerId(mySceneidx)
local xianyuLock=cross_sid and true or false

self.xianjieBtn:setActive(curSceneType~=xianjienSceneType.eXianJie and(not xianjienSceneIndexType:isMoGongZhengDuo(curSceneidx)))
self.myxianyuBtn:setActive(mySceneidx~=curSceneidx and xianyuLock and(not xianjienSceneIndexType:isMoGongZhengDuo(curSceneidx)))
self.zongmengBtn:setActive(not xianjienSceneIndexType:isMoGongZhengDuo(curSceneidx))
end

function UIXianJie_mapWin:refreshEnter()
self.xianjiebg:setActive(self.inXianJie)
self.xainjieRoot:setActive(self.inXianJie)
self.xianyubg:setActive(not self.inXianJie)
self.xainyuRoot:setActive(not self.inXianJie)
self.XYshili_LingMai:setActive(not self.inXianJie)

self.mojiebg:setActive(self.isInMoJie or self.isInMGZD)
self.mojieRoot:setActive(false)

if self.inXianJie then
if self.isRunMiniGame then
self.xianjiebg:setScale(Vector3.New(1.69,1.69,1.69))
self.xianjiebg:setSprite(minixjbgAb,"xianjie_xiaoditu_ditu2")
else
self.xianjiebg:setScale(Vector3.New(1.7,1.7,1.7))
self.xianjiebg:setSprite(xjbgAb,"xianjie_xiaoditu_ditu")
end
if not self.xainyulookup then
self.xainyulookup={}
self.xainyulookup[1]=self.xainyuEnter_1
self.xainyulookup[2]=self.xainyuEnter_5
self.xainyulookup[3]=self.xainyuEnter_7
self.xainyulookup[4]=self.xainyuEnter_3
self.xainyulookup[5]=self.xainyuEnter_8
self.xainyulookup[6]=self.xainyuEnter_4
self.xainyulookup[7]=self.xainyuEnter_2
self.xainyulookup[8]=self.xainyuEnter_6
end
for i,v in ipairs(self.xainyulookup)do
local cross_sid=xianjieModel:getXianYuCrossServerId(i)
local xianyuLock=cross_sid and true or false
v:setActive(xianyuLock)
end
else
if self.isInMoJie then

if self.isRunMiniGame then
self.mojiebg:setChildAnchoredPos(70.5,131.6)
self.mojiebg:setScale(Vector3.New(2.25,2.25,2.25))
self.mojiebg:setSprite(minixybgAb,"xianyu_xiaoditu_ditu2")
else
self.mojiebg:setChildAnchoredPos(-380,-20)
self.mojiebg:setScale(Vector3.New(2.5,2.5,2.5))
self.mojiebg:setSprite(mojiebgAb,"minimap_8")
end
if not self.mojieposlookup then
self.mojieposlookup={}
self.mojieposlookup[1]=self.moyuEnter_5
self.mojieposlookup[2]=self.moyuEnter_1
self.mojieposlookup[3]=self.moyuEnter_3
self.mojieposlookup[4]=self.moyuEnter_7
self.mojieposlookup[5]=self.moyuEnter_4
self.mojieposlookup[6]=self.moyuEnter_8
self.mojieposlookup[7]=self.moyuEnter_6
self.mojieposlookup[8]=self.moyuEnter_2
end


elseif self.isInMGZD then
if self.isRunMiniGame then
self.mojiebg:setChildAnchoredPos(70.5,131.6)
self.mojiebg:setScale(Vector3.New(2.25,2.25,2.25))
self.mojiebg:setSprite(minixybgAb,"xianyu_xiaoditu_ditu2")
else
self.mojiebg:setChildAnchoredPos(-380,-20)
self.mojiebg:setScale(Vector3.New(2.5,2.5,2.5))
self.mojiebg:setSprite(mojiebgAb,"minimap_8")
end
else

if self.isRunMiniGame then
self.xianyubg:setChildAnchoredPos(70.5,131.6)
self.xianyubg:setScale(Vector3.New(2.25,2.25,2.25))
self.xianyubg:setSprite(minixybgAb,"xianyu_xiaoditu_ditu2")
else
self.xianyubg:setChildAnchoredPos(100,150)
self.xianyubg:setScale(Vector3.New(2.4,2.4,2.4))
self.xianyubg:setSprite(xybgAb,"xianyu_xiaoditu_ditu")
end

if not self.xainjieposlookup then
self.xainjieposlookup={}
self.xainjieposlookup[1]=self.xainjieEnter_5
self.xainjieposlookup[2]=self.xainjieEnter_1
self.xainjieposlookup[3]=self.xainjieEnter_3
self.xainjieposlookup[4]=self.xainjieEnter_7
self.xainjieposlookup[5]=self.xainjieEnter_4
self.xainjieposlookup[6]=self.xainjieEnter_8
self.xainjieposlookup[7]=self.xainjieEnter_6
self.xainjieposlookup[8]=self.xainjieEnter_2
end

local curSceneidx=xianjieModel:getSceneIndex()
for i,v in ipairs(self.xainjieposlookup)do
v:setActive(curSceneidx==i)
end
end
end
end


function UIXianJie_mapWin:MoJieCouldCheck()
if self.isInMoJie then
self.mjbgpanel:setActive(true)
mapMinScale=0.35
mapMaxScale=0.7
local seasonId=xianjieController:getMoJieSaiJiWanFaID()
if seasonId then
local unlockcouldid=xianjieController:getSeaonCurFogId(seasonId)
if unlockcouldid then
if unlockcouldid>0 then
if unlockcouldid==1 then
self.mjbgone:setActive(false)
self.mjbgtwo:setActive(true)
self.mjbgthiree:setActive(true)
elseif unlockcouldid==2 then
self.mjbgone:setActive(false)
self.mjbgtwo:setActive(false)
self.mjbgthiree:setActive(true)
else
self.mjbgpanel:setActive(false)
end
else
self.mjbgone:setActive(true)
self.mjbgtwo:setActive(true)
self.mjbgthiree:setActive(true)
end
else
logErr('在当前魔界场景，获取的魔界云雾解锁id为nil')
end
else
logErr('在当前魔界场景，获取的魔界赛季玩法id为nil')
end
end
if self.isInMGZD then
mapMinScale=0.2
mapMaxScale=0.7
end
end


function UIXianJie_mapWin:initAreaId()
if self.isInMoJie then
self.mojieArearoot:setChildCanvasGroupAlpha(0)
self.mojieArearoot:setActive(true)
local widget=self.mojieArearoot:getWidgetBase()
for i=1,8 do
widget:SetChildActive(areasidx[i],true)






local name=self:getCrossServerNamebySCidx(i)or''
widget:SetChildText(areatxtidx[i],name)
end
else
self.mojieArearoot:setActive(false)
end
end
function UIXianJie_mapWin:AreaNameOnHide()
if _this.isInMoJie then
_this:stopAreaShowTimer()
_this.AreaTimer=_this:delayDo(0.8,function()
if _this==nil then return end
_this.mojieArearoot:setChildCanvasGroupDOFade(0,0.5,nil)
end)
end
end
function UIXianJie_mapWin:AreaNameOnShow()
if _this.isInMoJie then
_this.mojieArearoot:setChildCanvasGroupDOFade(1,0.5,nil)
end
end
function UIXianJie_mapWin:stopAreaShowTimer()
if self.AreaTimer then
self:stopTimerByID(self.AreaTimer)
self.AreaTimer=nil
end
end

function UIXianJie_mapWin:getCrossServerNamebySCidx(sceneIndex)


local cross_sid=xianjieModel:getXianYuCrossServerId(sceneIndex)
return cross_sid and loginModel:getCrossZoneName(cross_sid)or''
end


function UIXianJie_mapWin:testMoJieCouldCheck(idx)
if idx>0 then
if idx==1 then
_this.mjbgone:setActive(false)
_this.mjbgtwo:setActive(true)
_this.mjbgthiree:setActive(true)
elseif idx==2 then
_this.mjbgone:setActive(false)
_this.mjbgtwo:setActive(false)
_this.mjbgthiree:setActive(true)
else
_this.mjbgpanel:setActive(false)
end
else
_this.mjbgone:setActive(true)
_this.mjbgtwo:setActive(true)
_this.mjbgthiree:setActive(true)
end
end

function UIXianJie_mapWin:closeSelf()

UIManager:closeWindow('UIXianJie_mapWin')
end


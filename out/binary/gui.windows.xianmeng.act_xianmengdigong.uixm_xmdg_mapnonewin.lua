







def_class("UIXM_XMDG_MapNoneWin",UIWindowBase)









function UIXM_XMDG_MapNoneWin:bindComponents()

self.root=UIObject.get(self,0)
self.mapContent=UIObject.get(self,1)
self.blockMask=UIButton.get(self,2)
self.frameBG=UIObject.get(self,3)
self.topPanel=UIObject.get(self,4)
self.bottomPanel=UIObject.get(self,5)
self.mapGrid=UIObject.get(self,6)
self.enterSpObj=UIObject.get(self,7)
self.topLeftSpGrid=UIObject.get(self,8)
self.topRightSpGrid=UIObject.get(self,9)
self.bottomSpObj=UIObject.get(self,10)
self.bottomLeftSpGrid=UIObject.get(self,11)
self.bottomRightSpGrid=UIObject.get(self,12)
self.enterSp=UIObject.get(self,13)
self.bottomSp=UIObject.get(self,14)

self.blockMask:setButtonClick(function()self:onBlockMask()end)



end


function UIXM_XMDG_MapNoneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.mapContent);self.mapContent=nil;
_UIObject_release(self.blockMask);self.blockMask=nil;
_UIObject_release(self.frameBG);self.frameBG=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.mapGrid);self.mapGrid=nil;
_UIObject_release(self.enterSpObj);self.enterSpObj=nil;
_UIObject_release(self.topLeftSpGrid);self.topLeftSpGrid=nil;
_UIObject_release(self.topRightSpGrid);self.topRightSpGrid=nil;
_UIObject_release(self.bottomSpObj);self.bottomSpObj=nil;
_UIObject_release(self.bottomLeftSpGrid);self.bottomLeftSpGrid=nil;
_UIObject_release(self.bottomRightSpGrid);self.bottomRightSpGrid=nil;
_UIObject_release(self.enterSp);self.enterSp=nil;
_UIObject_release(self.bottomSp);self.bottomSp=nil;
end
















local _this=nil
local mapDefaultScale=0.75
local showUIScal=0.75


function UIXM_XMDG_MapNoneWin:onLoaded(...)
_this=self
self:bindComponents()
xianmengdigongModel:set_xmdgModel(true)
self.m_cav=self:getChildCanvas(-1)
end


function UIXM_XMDG_MapNoneWin:__delete()
_this=nil
self:unbindComponents()
xianmengdigongModel:set_xmdgModel(nil)
end


function UIXM_XMDG_MapNoneWin:onHide()
xianmengdigongModel:set_xmdgModel(nil)
end




function UIXM_XMDG_MapNoneWin:onShow(argtable,afterOnloaded)
xianmengdigongModel:set_xmdgModel(true)
local targetPos,targetLocalPos=xianmengdigongModel:getTargetRoomPos_none()
self.targetPos=targetPos
self.targetLocalPos=targetLocalPos

self:resetMapLimit()
if afterOnloaded then
self:initMap()
else
self:setAsLastSibling(-1)
end
local flag=UIManager:invokeUIMethod('UIXM_XMDG_MainWin','check_enableDrag')
self:enableDrag(flag)
end



function UIXM_XMDG_MapNoneWin:resetMapLimit()
self.root:setChildZoomLimit(1,0.5)
end

function UIXM_XMDG_MapNoneWin:initMap()
local pos=self.targetPos
self.mapGridList=xianmengdigongModel:getmapGridListSort_none(pos)
local mcfg=xianmengdigongModel:getmapcfg_none()
self.mapcfg=mcfg

local mapSkinCfg=xianmengdigongModel:get_mapSkinCfg(mcfg.mapSkinID)
local w1=mcfg.roomCol*mcfg.roomWidth
local h1=mcfg.roomRow*mcfg.roomHeight
local w=w1+mapSkinCfg.mapLeftSide+mapSkinCfg.mapRightSide
local h=h1+mapSkinCfg.mapTopSide+mapSkinCfg.mapBottomSide+mapSkinCfg.topHeight+mapSkinCfg.bottomHeight


self.frameBG:setChildSizeDelta(w1,h1)
self.frameBG:setLocalPosY(xianmengdigongModel:get_mapOffsetY_none())

self.mapContent:setChildSizeDelta(w,h)
self.mapContent:setScale(Vector3(mapDefaultScale,mapDefaultScale,mapDefaultScale))
local localPos=self.targetLocalPos
self.root:subMoveToTargetPos(Vector3(-localPos[1],-localPos[2],0),0.1,true,nil)

self.topPanel:setChildSizeDelta(w,mapSkinCfg.topHeight)
self.enterSpObj:setChildSizeDelta(mapSkinCfg.topEnterSpineWidth,mapSkinCfg.topHeight)
self.enterSp:setChildUIModelShowTarget(mapSkinCfg.topEnterSpineID,1,{},0,false,false,0,nil)
local topSp_num=0
local lerp_topWidth=w/2-mapSkinCfg.topEnterSpineWidth/2
if lerp_topWidth>0 then
topSp_num=math.ceil(lerp_topWidth/mapSkinCfg.topSpineWidth)
end
if topSp_num>0 then
local topEnterSpineWidth_half=math.floor(mapSkinCfg.topEnterSpineWidth/2)
self.topLeftSpGrid:setChildLayoutGroupCreateItems(topSp_num,function(idx)
if _this==nil then return end
local item=_this.topLeftSpGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildSizeDelta(-1,mapSkinCfg.topSpineWidth,mapSkinCfg.topHeight)
item:SetChildUIModelShowTarget(0,mapSkinCfg.topSpineID,1,{},0,false,false,0,nil)
end)
self.topLeftSpGrid:setChildSizeDelta(mapSkinCfg.topSpineWidth*topSp_num,mapSkinCfg.topHeight)
self.topLeftSpGrid:setLocalPosX(-topEnterSpineWidth_half+4)
self.topRightSpGrid:setChildLayoutGroupCreateItems(topSp_num,function(idx)
if _this==nil then return end
local item=_this.topRightSpGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildSizeDelta(-1,mapSkinCfg.topSpineWidth,mapSkinCfg.topHeight)
item:SetChildUIModelShowTarget(0,mapSkinCfg.topSpineID,1,{},0,false,false,0,nil)
end)
self.topRightSpGrid:setChildSizeDelta(mapSkinCfg.topSpineWidth*topSp_num,mapSkinCfg.topHeight)
self.topRightSpGrid:setLocalPosX(topEnterSpineWidth_half-4)
end

self.bottomPanel:setChildSizeDelta(w,mapSkinCfg.bottomHeight)
self.bottomSpObj:setChildSizeDelta(mapSkinCfg.bottomSpineWidth,mapSkinCfg.bottomHeight)
self.bottomSp:setChildUIModelShowTarget(mapSkinCfg.bottomSpineID,1,{},0,false,false,0,nil)
local bottomSp_num=0
local lerp_bottomWidth=w/2-mapSkinCfg.bottomSpineWidth/2
if lerp_bottomWidth>0 then
bottomSp_num=math.ceil(lerp_bottomWidth/mapSkinCfg.bottomSpineWidth)
end
if bottomSp_num>0 then
local bottomSpineWidth_half=math.floor(mapSkinCfg.bottomSpineWidth/2)
self.bottomLeftSpGrid:setChildLayoutGroupCreateItems(bottomSp_num,function(idx)
if _this==nil then return end
local item=_this.bottomLeftSpGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildSizeDelta(-1,mapSkinCfg.bottomSpineWidth,mapSkinCfg.bottomHeight)
item:SetChildUIModelShowTarget(0,mapSkinCfg.bottomSpineID,1,{},0,false,false,0,nil)
end)
self.bottomLeftSpGrid:setChildSizeDelta(mapSkinCfg.bottomSpineWidth*bottomSp_num,mapSkinCfg.bottomHeight)
self.bottomLeftSpGrid:setLocalPosX(-bottomSpineWidth_half+4)
self.bottomRightSpGrid:setChildLayoutGroupCreateItems(bottomSp_num,function(idx)
if _this==nil then return end
local item=_this.bottomRightSpGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildSizeDelta(-1,mapSkinCfg.bottomSpineWidth,mapSkinCfg.bottomHeight)
item:SetChildUIModelShowTarget(0,mapSkinCfg.bottomSpineID,1,{},0,false,false,0,nil)
end)
self.bottomRightSpGrid:setChildSizeDelta(mapSkinCfg.bottomSpineWidth*bottomSp_num,mapSkinCfg.bottomHeight)
self.bottomRightSpGrid:setLocalPosX(bottomSpineWidth_half-4)
end


self.mapGrid:setChildLayoutGroupCreateItems(#self.mapGridList,function(idx)
if _this==nil then return end
_this:initmapGridItem(nil,idx)
end)
end

function UIXM_XMDG_MapNoneWin:enableDrag(flag,lockTime)
self.root:setChildDragZoomEnable(flag)
if not flag and lockTime then
self.lockTime_blockMask=Time.realtimeSinceStartup+2
end
self.blockMask:setActive(not flag)
end

function UIXM_XMDG_MapNoneWin:onBlockMask()
if self.lockTime_blockMask then
if Time.realtimeSinceStartup<self.lockTime_blockMask then
return
else
self.lockTime_blockMask=nil
end
end
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','enableDrag',true)
end





function UIXM_XMDG_MapNoneWin:initmapGridItem(item,idx)
if item==nil then
item=self.mapGrid:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end

local g=self.mapGridList[idx]
item:SetChildSizeDelta(-1,g.width,g.height)
item:SetChildLocalPos(-1,g.posx,g.posy,0)

if g.skinID>0 then
local iconname=xianmengdigongModel:getRoomIconName(g.skinID)
item:SetChildCSImageIcon(0,iconname,false)
end

item:SetChildCanvas(1,self.m_cav[1],self.m_cav[2]+2)
local zs=g.zs
if zs[1]>0 then
local abname,icon=xianmengdigongModel:getZZIconName(zs[1])
item:SetChildCSImageSprite(4,abname,icon)
end
if zs[2]>0 then
local abname,icon=xianmengdigongModel:getZZIconName(zs[2])
item:SetChildCSImageSprite(5,abname,icon)
end
if zs[3]>0 then
local abname,icon=xianmengdigongModel:getHLIconName(zs[3])
item:SetChildCSImageSprite(2,abname,icon)
end
if zs[4]>0 then
local abname,icon=xianmengdigongModel:getHLIconName(zs[4])
item:SetChildCSImageSprite(3,abname,icon)
end
end
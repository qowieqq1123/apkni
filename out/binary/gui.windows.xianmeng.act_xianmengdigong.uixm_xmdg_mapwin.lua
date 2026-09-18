







def_class("UIXM_XMDG_MapWin",UIWindowBase)









function UIXM_XMDG_MapWin:bindComponents()

self.root=UIObject.get(self,0)
self.floatRoot=UIObject.get(self,1)
self.blockMask=UIButton.get(self,2)
self.mapContent=UIObject.get(self,3)
self.floatObj=UIObject.get(self,4)
self.topPanel=UIObject.get(self,5)
self.selectRoot=UIObject.get(self,6)
self.zsGrid=UIObject.get(self,7)
self.roomGrid=UIObject.get(self,8)
self.frameBG=UIObject.get(self,9)
self.mapGrid=UIObject.get(self,10)
self.bottomPanel=UIObject.get(self,11)
self.entityPanel=UIObject.get(self,12)
self.topRightSpGrid=UIObject.get(self,13)
self.topLeftSpGrid=UIObject.get(self,14)
self.enterSpObj=UIObject.get(self,15)
self.selectObj=UIObject.get(self,16)
self.poslist=UIObject.get(self,17)
self.bottomLeftSpGrid=UIObject.get(self,18)
self.bottomSpObj=UIObject.get(self,19)
self.bottomRightSpGrid=UIObject.get(self,20)
self.enterSp=UIObject.get(self,21)
self.bottomSp=UIObject.get(self,22)
self.selectEffect=UIObject.get(self,23)
self.selectSp=UIObject.get(self,24)
self.floatSP=UIObject.get(self,25)
self.floatArrow=UIButton.get(self,26)

self.blockMask:setButtonClick(function()self:onBlockMask()end)

self.floatArrow:setButtonClick(function()self:onFloatArrow()end)



end


function UIXM_XMDG_MapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.floatRoot);self.floatRoot=nil;
_UIObject_release(self.blockMask);self.blockMask=nil;
_UIObject_release(self.mapContent);self.mapContent=nil;
_UIObject_release(self.floatObj);self.floatObj=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.selectRoot);self.selectRoot=nil;
_UIObject_release(self.zsGrid);self.zsGrid=nil;
_UIObject_release(self.roomGrid);self.roomGrid=nil;
_UIObject_release(self.frameBG);self.frameBG=nil;
_UIObject_release(self.mapGrid);self.mapGrid=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.entityPanel);self.entityPanel=nil;
_UIObject_release(self.topRightSpGrid);self.topRightSpGrid=nil;
_UIObject_release(self.topLeftSpGrid);self.topLeftSpGrid=nil;
_UIObject_release(self.enterSpObj);self.enterSpObj=nil;
_UIObject_release(self.selectObj);self.selectObj=nil;
_UIObject_release(self.poslist);self.poslist=nil;
_UIObject_release(self.bottomLeftSpGrid);self.bottomLeftSpGrid=nil;
_UIObject_release(self.bottomSpObj);self.bottomSpObj=nil;
_UIObject_release(self.bottomRightSpGrid);self.bottomRightSpGrid=nil;
_UIObject_release(self.enterSp);self.enterSp=nil;
_UIObject_release(self.bottomSp);self.bottomSp=nil;
_UIObject_release(self.selectEffect);self.selectEffect=nil;
_UIObject_release(self.selectSp);self.selectSp=nil;
_UIObject_release(self.floatSP);self.floatSP=nil;
_UIObject_release(self.floatArrow);self.floatArrow=nil;
end
















local _this=nil
local mapDefaultScale=1
local showUIScal=0.75
local maxDZNum=4
local dzScale=0.4
local dragTimeOffset=0
local dragDistanceOffset=0


function UIXM_XMDG_MapWin:setOffset(time,dis)
dragTimeOffset=time
dragDistanceOffset=dis
end


function UIXM_XMDG_MapWin:onLoaded(...)
_this=self
self:bindComponents()
self.m_cav=self:getChildCanvas(-1)
xianmengdigongModel:set_xmdgModel(true)
self.mapGridWidgetList={}
self.mapRoomWidgetList={}
self.mapZSRoomWidgetList={}
self.selectRoot:setChildCanvas(self.m_cav[1],self.m_cav[2]+6)
self.floatRoot:setChildCanvas(self.m_cav[1],self.m_cav[2]+7)
if deviceHelper.getAPILevel()>=12 then
self:initFloatSign()
local s_func=function(pos)
if _this==nil then return end
_this.lockClick=true
_this.lockClickTime=Time.realtimeSinceStartup
_this.lockClickPos=pos
_this:initFloatSignTimer()
end
local e_func=function(pos)
if _this==nil then return end
_this.lockClick=false
_this:clearFloatSignTimer()
_this:refreshFloatSign()
if _this.clickRoomIdx then
local lerpTime=Time.realtimeSinceStartup-_this.lockClickTime
local dis=mathHelper.distance(pos.x,pos.y,_this.lockClickPos.x,_this.lockClickPos.y)
if dis<dragDistanceOffset and lerpTime<dragTimeOffset then
_this:onroomItemClick(_this.clickRoomIdx)
end
_this.clickRoomIdx=nil
end
end
self.root:setChildDragStartAndEndEvent(s_func,e_func)
end

self.enityWidgetList={}
self.entityPanel:setChildLayoutGroupCreateItems(maxDZNum)
local grids=self.entityPanel:getChildLayoutGroupGridList()
for i=1,maxDZNum do
local entityWidget=grids[i-1]
self.enityWidgetList[i]=entityWidget
end
self.posDataLookup={}



end

function UIXM_XMDG_MapWin:initDZLookup()

self.allDZLookup={}
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local netData=v.netData.net
self.allDZLookup[netData.discipleguidStr]={netData.discipleguid,netData.discipleguidStr}
end
end
end


function UIXM_XMDG_MapWin:__delete()
_this=nil
self:unbindComponents()
xianmengdigongModel:set_xmdgModel(nil)
self:clearAllEntity()
end


function UIXM_XMDG_MapWin:onHide()
xianmengdigongModel:set_xmdgModel(nil)
self:clearAllEntity()
self:clearAutoDZTimer()
end




function UIXM_XMDG_MapWin:onShow(argtable,afterOnloaded)
self.scaleFactor=UIManager.defaultCanvas_trans.localScale
xianmengdigongModel:set_xmdgModel(true)
self.lockClick=false
argtable=argtable or{}
local targetPos=argtable.targetPos
local targetLocalPos=argtable.targetLocalPos
local jumpClick=argtable.jumpClick






self:resetMapLimit()
local flag=UIManager:invokeUIMethod('UIXM_XMDG_MainWin','check_enableDrag')
if afterOnloaded then
if targetPos==nil then
targetPos,targetLocalPos=xianmengdigongModel:getTargetRoomPos()
end
self.targetPos=targetPos
self.targetLocalPos=targetLocalPos
self:initMap()
else
self:setAsLastSibling(-1)
self:refreshAllRoomItemUI()
local f=false
if flag and targetPos then
local room=xianmengdigongModel:getRoom2(targetPos[1],targetPos[2])
if room then
f=true
self:jumpRoom(room,jumpClick)
end
end
if not f then
self:refreshFloatSign()
end
end
self:enableDrag(flag)
self:refreshGL()
self:initTargetRoomsPos()
self:initDZLookup()
self:initAutoAddDZAnim()

if xianmengdigongModel:isUnlockAll()then
if not newbieModel.isFinish(NEWBIE_BRANCH_LUA_FUNC_TYPE.XMDGFreeEventBtnFunc)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.XMDGFreeEventBtnFunc)
end
end
end
















function UIXM_XMDG_MapWin:initTargetRoomsPos()
self.targetPosList={}
self.targetPosList2={}
self.targetPosIndex=1
for i,room in ipairs(self.roomsList)do
if room:checkVisit()then
if room:checkunLock()then
local events=room:getEvents_doing_idle()
if#events>0 then
table.insert(self.targetPosList2,{room.base.posx,room.base.posy})
end
else
table.insert(self.targetPosList,{room.base.posx,room.base.posy})
end
end
end
end

function UIXM_XMDG_MapWin:moveCamera2TargetPos()
if self.isJumping then
return
end
local pos=nil
local c=#self.targetPosList
if c>0 then
self.targetPosIndex=self.targetPosIndex+1
if self.targetPosIndex>c then
self.targetPosIndex=1
end
pos=self.targetPosList[self.targetPosIndex]
end
if pos==nil then
c=#self.targetPosList2
if c>0 then
self.targetPosIndex=self.targetPosIndex+1
if self.targetPosIndex>c then
self.targetPosIndex=1
end
pos=self.targetPosList2[self.targetPosIndex]
end
end
if pos then
if self.isJumping~=true then
self.isJumping=true
end
self:jumpRoom2(pos[1],pos[2],function()
self.isJumping=nil
end)
end
end

function UIXM_XMDG_MapWin:resetMapLimit()
self.root:setChildZoomLimit(1,0.5)
end

function UIXM_XMDG_MapWin:initMap()
local pos=self.targetPos
self.mapGridList=xianmengdigongModel:getmapGridListSort(pos)
self.roomsList=xianmengdigongModel:getroomsListSort(pos)

local mcfg=xianmengdigongModel:getmapcfg()
self.mapcfg=mcfg

local mapSkinCfg=xianmengdigongModel:get_mapSkinCfg(mcfg.mapSkinID)
local w1=mcfg.roomCol*mcfg.roomWidth
local h1=mcfg.roomRow*mcfg.roomHeight
local w=w1+mapSkinCfg.mapLeftSide+mapSkinCfg.mapRightSide
local h=h1+mapSkinCfg.mapTopSide+mapSkinCfg.mapBottomSide+mapSkinCfg.topHeight+mapSkinCfg.bottomHeight
self.mapWidth=w
self.mapHeight=h


self.frameBG:setChildSizeDelta(w1,h1)
self.frameBG:setLocalPosY(xianmengdigongModel:get_mapOffsetY())

self.mapContent:setChildSizeDelta(w,h)
self.mapContent:setScale(Vector3(mapDefaultScale,mapDefaultScale,mapDefaultScale))
local localPos=self.targetLocalPos
self:jumpRoom2(localPos[1],localPos[2],nil)

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
local item=_this.mapGrid:getChildLayoutGroupGridItem(idx-1)
_this.mapGridWidgetList[idx]=item
_this:initmapGridItem(item,idx)
end)

self.roomGrid:setChildLayoutGroupCreateItems(#self.roomsList,function(idx)
if _this==nil then return end
local item=_this.roomGrid:getChildLayoutGroupGridItem(idx-1)
_this.mapRoomWidgetList[idx]=item
_this:initroomItem(item,idx)
end)







end

function UIXM_XMDG_MapWin:finRoomIndex(roomid)
for idx,room in ipairs(self.roomsList)do
if room:compareEx(roomid)then
return idx,room
end
end
end

function UIXM_XMDG_MapWin:enableDrag(flag,lockTime)
self.root:setChildDragZoomEnable(flag)
if not flag and lockTime then
self.lockTime_blockMask=Time.realtimeSinceStartup+2
end
self.blockMask:setActive(not flag)
end

function UIXM_XMDG_MapWin:onBlockMask()
if self.lockTime_blockMask then
if Time.realtimeSinceStartup<self.lockTime_blockMask then
return
else
self.lockTime_blockMask=nil
end
end
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','enableDrag',true)
end

function UIXM_XMDG_MapWin:jumpRoom(room,click)
local scale=self.mapContent:getScale()
local func2=function()
if _this==nil then return end
_this:refreshFloatSign(false)

if click then
local idx,room=_this:finRoomIndex(room.base.id)
if idx then
_this:onroomItemClick(idx)
end
end
end
self.root:subMoveToTargetPos(Vector3(-room.base.posx*scale.x,-room.base.posy*scale.x,0),0.1,true,func2)
end

function UIXM_XMDG_MapWin:jumpRoom2(posx,posy,func,click)
local scale=self.mapContent:getScale()
local func2=function()
if _this==nil then return end
if func then
func()
end
_this:refreshFloatSign(false)
if click then
local id=xianmengdigongModel:getID(posx,posy)
local idx,room=_this:finRoomIndex(id)
if idx then
_this:onroomItemClick(idx)
end
end
end
self.root:subMoveToTargetPos(Vector3(-posx*scale.x,-posy*scale.x,0),0.1,true,func2)
end





function UIXM_XMDG_MapWin:initmapGridItem(item,idx)
if item==nil then
item=self.mapGridWidgetList[idx]
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

self:refreshmapGridItem(item,idx)
end

function UIXM_XMDG_MapWin:refreshmapGridItem(item,idx)
if item==nil then
item=self.mapGridWidgetList[idx]
end
if item==nil then return end

local g=self.mapGridList[idx]
local isshow=g:checkShow()
item:SetChildActive(0,isshow)
end





function UIXM_XMDG_MapWin:initroomItem(item,idx)
if item==nil then
item=self.mapRoomWidgetList[idx]
end
if item==nil then return end

local room=self.roomsList[idx]
local base=room.base
item:SetChildSizeDelta(-1,base.width,base.height)
item:SetChildLocalPos(-1,base.posx,base.posy,0)

self:refreshroomItemBG(item,idx)






item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onroomItemClick(idx)
end)

item:SetChildCanvas(1,self.m_cav[1],self.m_cav[2]+4)




self:refreshroomItemProgress(item,idx)
self:refreshroomItemEvents(item,idx)
self:refreshRoomItemLockTime(item,idx)

if xianmengdigongModel:checkUnlockAnim(base.id)then
xianmengdigongModel:setUnlockRoom(nil)
end
end

function UIXM_XMDG_MapWin:refreshroomItemBG(item,idx)
if item==nil then
item=self.mapRoomWidgetList[idx]
end
if item==nil then return end

local room=self.roomsList[idx]
local skinID
if room:checkCloud()then
skinID=room:getCloudSkin()
else
local roomcfg=cfg_guilddigongroomconfig_get(room.roomConfId)
skinID=roomcfg.skinID
end
local iconname=xianmengdigongModel:getRoomIconName(skinID)
item:SetChildCSImageIcon(0,iconname,false)
item:SetChildActive(-1,room:checkShow())
end

function UIXM_XMDG_MapWin:refreshRoomItemLockTime(item,idx)
if item==nil then
item=self.mapRoomWidgetList[idx]
end
if item==nil then return end

local room=self.roomsList[idx]

local roomcfg=cfg_guilddigongroomconfig_get(room.roomConfId)
local roomType=roomcfg.roomType
local startHour,startMin,endHour,endMin=xianmengdigongModel:getLockRoomHourMin()

local showLock=room:checkunLock()
if startHour and startHour>=0 and(roomType==1 or roomType==2)and not showLock then
item:SetChildActive(18,true)
local startHourStr=startHour>9 and tostring(startHour)or'0'..startHour
local startMinStr=startMin>9 and tostring(startMin)or'0'..startMin
local endHourStr=endHour>9 and tostring(endHour)or'0'..endHour
local endMinStr=endMin>9 and tostring(endMin)or'0'..endMin
item:SetChildText(19,string.format("每日%s:%s~%s:%s允许挑战解锁",startHourStr,startMinStr,endHourStr,endMinStr))
else
item:SetChildActive(18,false)
item:SetChildText(19,"")
end
end

function UIXM_XMDG_MapWin:initRoomUnlockEffect(item,idx)
if item==nil then
item=self.mapRoomWidgetList[idx]
end
if item==nil then return end

local room=self.roomsList[idx]
item:SetChildActive(12,false)
item:SetChildActive(13,true)
item:SetChildCanvasGroupAlpha(13,1)
local effectID=room:getUnlockEffect()
item:SetChildShowEffectEx(12,effectID,self.m_cav[1],self.m_cav[2]+5,true)
local skinID=room:getCloudSkin()
local iconname=xianmengdigongModel:getRoomIconName(skinID)
item:SetChildCSImageIcon(13,iconname,false)
end

function UIXM_XMDG_MapWin:playRoomUnlockEffect(item,idx)
if item==nil then
item=self.mapRoomWidgetList[idx]
end
if item==nil then return end

local tweener=item:SetChildCanvasGroupDOFade(13,0,1,nil)
tweener:SetEase(_Ease.Linear)
item:SetChildActive(12,true)
end

function UIXM_XMDG_MapWin:refreshroomItemProgress(item,idx)
if item==nil then
item=self.mapRoomWidgetList[idx]
end
if item==nil then return end

local room=self.roomsList[idx]

local showLock=room:checkVisit()and not room:checkunLock()
item:SetChildActive(4,showLock)
if showLock then
local cfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,room.ysConfId)
local isboss=cfg.gwtype==MONSTER_TYPE.eShouLing
item:SetChildActive(5,not isboss)
item:SetChildActive(8,isboss)
local rate=room.unlockJinDu/room.maxJinDu
if rate>1 then
rate=1
elseif rate<0 then
rate=0
end

if isboss then
local icon='image_xmdigongboss_3'
if self.roomEffect==nil then
self.roomEffect={}
end
if self.roomEffect[room.base.id]==nil then
item:SetChildShowEffectEx(10,10306,self.m_cav[1],self.m_cav[2]+3,true)
self.roomEffect[room.base.id]=true
end
local showProgress=rate<1
item:SetChildActive(14,showProgress)
local iconPosY=showProgress==true and-52 or-62
item:SetChildLocalPosY(8,iconPosY)
if showProgress then
item:SetChildIconFillAmount(9,rate)
end
else
local icon
if cfg.gwtype==MONSTER_TYPE.eXiaoGuai then
icon='image_xmdigongboss_1'
else
icon='image_xmdigongboss_2'
end
item:SetChildCSImageSprite(7,globalABLookup.xmdgmainicons,icon)
local showProgress=rate>0
item:SetChildActive(11,showProgress)
local iconPosY=showProgress==true and-52 or-62
item:SetChildLocalPosY(5,iconPosY)
if showProgress then
item:SetChildIconFillAmount(6,rate)
end
end
end
end

function UIXM_XMDG_MapWin:refreshroomItemEvents(item,idx)
if item==nil then
item=self.mapRoomWidgetList[idx]
end
if item==nil then return end

local room=self.roomsList[idx]
local showEvent=false
local events
if room:checkunLock()and not xianmengdigongModel:checkUnlockAnim(room.base.id)then
events=room:getEvents_doing_idle()
if#events>0 then
showEvent=true
end
local hasReward=room:hasRankReward()
item:SetChildActive(16,hasReward)
item:SetChildShowEffect(17,10054,hasReward)
if hasReward then
item:SetChildButtonClick(16,function()self:showWindow("UIXM_XMDG_bossRankWin",{roomid=room.base.id})end)
end
end
item:SetChildActive(3,showEvent)
if showEvent then
local eventGrids=item:GetChildCommonLayoutGroupWidgetList(3)
for i=1,8 do
local eventItem=eventGrids[i-1]
local event=events[i]
local isshow=event~=nil
eventItem:SetChildActive(-1,isshow)
if isshow then

local isSpe=event.eventType==xmdgEventType.eLimit
eventItem:SetChildActive(0,isSpe)

for j=1,3 do
local showman=j<=event.maxman
eventItem:SetChildActive(j,showman)
if showman then
local curman=event.curman
local manIcon
if j<=curman then
manIcon='icon_smdgrenshu_1'
else
manIcon='icon_smdgrenshu_2'
end
eventItem:SetChildCSImageSprite(j,globalABLookup.xmdgmainicons,manIcon)
end
end
end
end
end
end











function UIXM_XMDG_MapWin:refreshAllRoomItemUI()
for idx,room in ipairs(self.roomsList)do
local item=self.mapRoomWidgetList[idx]
if item then
self:refreshroomItemBG(item,idx)
self:refreshroomItemProgress(item,idx)
self:refreshroomItemEvents(item,idx)
self:refreshRoomItemLockTime(item,idx)
if xianmengdigongModel:checkUnlockAnim(room.base.id)then
self:initRoomUnlockEffect(item,idx)
local idx_=idx
local item_=item
self:delayDo(1,function()
xianmengdigongModel:setUnlockRoom(nil)
self:playRoomUnlockEffect(item_,idx_)
self:refreshroomItemBG(item_,idx_)
self:refreshroomItemEvents(item_,idx_)
end)
end
end
end
end

function UIXM_XMDG_MapWin:refreshAllRoomItemLookTime()
for idx,room in ipairs(self.roomsList)do
local item=self.mapRoomWidgetList[idx]
if item then
self:refreshRoomItemLockTime(item,idx)
end
end
end

function UIXM_XMDG_MapWin:onroomItemClick(idx)
if self.lockClick then
self.clickRoomIdx=idx
return
end
self.clickRoomIdx=nil
local room=self.roomsList[idx]
local glsign=UIManager:invokeUIMethod('UIXM_XMDG_MainWin','checkSignModel')
if glsign then
local glid=self.glRoomID
local showSelect=glid~=nil and room:compareEx(glid)
if showSelect then
self:refreshGL(nil,true)
else
self:refreshGL(room.base.id)
end
else
if room:checkVisit()then
if room:checkunLock()then
local events=room:getEvents_doing_idle()
if#events>0 then
UIManager:showWindow('UIXM_XMDG_roomWin',{roomid=room.base.id})
else

end
else
local roomcfg=cfg_guilddigongroomconfig_get(room.roomConfId)
local roomType=roomcfg.roomType
local isInLockRoomTime=xianmengdigongModel:checkIsInLockRoomTime()
if(roomType==1 or roomType==2)and not isInLockRoomTime then
UIManager.error("此房间被锁定，请静待房间解锁")
else
local cfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,room.ysConfId)
if cfg.gwtype==MONSTER_TYPE.eShouLing then
UIManager:showWindow('UIXM_XMDG_bossWin',{roomid=room.base.id})
else
UIManager:showWindow('UIXM_XMDG_monsterWin',{roomid=room.base.id})
end
end
end
else
local str=cfgHelper.getlang('xmgd_tips_2')
UIManager.info(str)
end
end
end





function UIXM_XMDG_MapWin:initzsroomItem(item,idx)
if item==nil then
item=self.mapZSRoomWidgetList[idx]
end
if item==nil then return end

local zsroom=self.zsroomsList[idx]
local base=room.base
item:SetChildSizeDelta(-1,base.width,base.height)
item:SetChildLocalPos(-1,base.posx,base.posy,0)







end





function UIXM_XMDG_MapWin:reqGL()
local old=xianmengdigongModel:getGLID()
local cur=self.glRoomID
if old~=nil and cur==nil then
local idx,room=self:finRoomIndex(old)
xianmengdigongController:send_20_108(room.base.x,room.base.y,0)
elseif old~=cur then
local idx,room=self:finRoomIndex(cur)
xianmengdigongController:send_20_108(room.base.x,room.base.y,1)
end
end

function UIXM_XMDG_MapWin:refreshGL(roomid,isclear)
if roomid==nil and not isclear then
roomid=xianmengdigongModel:getGLID()
end
self.glRoomID=roomid
local has=false
local idx
local room
if roomid~=nil then
idx,room=self:finRoomIndex(roomid)
if idx then
has=true
end
end
self.selectObj:setActive(has)
if has then
local base=room.base
self.selectObj:setChildSizeDelta(base.width,base.height)
self.selectObj:setLocalPos(base.posx,base.posy,0)
if self.selectSpID==nil then
self.selectSpID=4108
self.selectSp:setChildUIModelShowTarget(self.selectSpID,1.5,{},0,false,false,0,nil)
end
if self.selectEffectID==nil then
self.selectEffectID=10299
self.selectEffect:setChildShowEffect(self.selectEffectID,true)
end
local scale
if base.w==1 then
scale=1
else
scale=2.1
end
self.selectEffect:setScale(Vector3(scale,scale,scale))
end
end





function UIXM_XMDG_MapWin:initFloatSign()
self.floatSignBoard_h=200
self.floatSignBoard_w=200
self.floatBoard=50
end

function UIXM_XMDG_MapWin:initFloatSignTimer()
local glsign=UIManager:invokeUIMethod('UIXM_XMDG_MainWin','checkSignModel')
if not glsign then
if self.refreshFloatSignTimer==nil then
self.refreshFloatSignTimer=self:setTimer(0.2,0,function()
self:refreshFloatSign()
end)
self:refreshFloatSign(true)
end
end
end

function UIXM_XMDG_MapWin:clearFloatSignTimer()
if self.refreshFloatSignTimer~=nil then
self:stopTimerByID(self.refreshFloatSignTimer)
self.refreshFloatSignTimer=nil
end
end

function UIXM_XMDG_MapWin:hideFloatSign()
if deviceHelper.getAPILevel()<12 then return end
self.floatObj:setActive(false)
end

function UIXM_XMDG_MapWin:refreshFloatSign(anim)
if deviceHelper.getAPILevel()<12 then return end
local check=false
local pos1
local pos2
local pos3
local posTL
local posBR
local scale
local pos
local glsign=UIManager:invokeUIMethod('UIXM_XMDG_MainWin','checkSignModel')
if not glsign then
local glid=xianmengdigongModel:getGLID()
if glid then
local room=xianmengdigongModel:getRoom(glid)
if room then
check=true
pos2={x=room.base.posx,y=room.base.posy}
end
end
end

if check then
scale=self.mapContent:getScale()
pos=self.mapContent:getChildLocalPosition()

local x1=(0-pos.x)/scale.x
local y1=(0-pos.y)/scale.y

pos1={x1,y1}

local scaleFactor=self.scaleFactor
local height=UnityEngine.Screen.height/(scaleFactor.y*scale.y)
local width=UnityEngine.Screen.width/(scaleFactor.x*scale.x)
local h_w=(width-self.floatSignBoard_w)/2
local h_h=(height-self.floatSignBoard_h)/2

local topLeftX=x1-h_w
local topLeftY=y1+h_h
local bottomRightX=x1+h_w
local bottomRightY=y1-h_h
posTL={topLeftX,topLeftY}
posBR={bottomRightX,bottomRightY}

local board=self.floatBoard/scale.x
if pos2.x<topLeftX-board or pos2.x>bottomRightX+board
or pos2.y>topLeftY+board or pos2.y<bottomRightY-board then
local x2=pos2.x
local y2=pos2.y
local lerpX=x2-x1
local lerpY=y2-y1
local plist={}
if lerpX==0 then


if x2>=topLeftX and x2<=bottomRightX then
table.insert(plist,{x2,topLeftY})
table.insert(plist,{x2,bottomRightY})
end
elseif lerpY==0 then


if y2>=topLeftY and y2<=bottomRightY then
table.insert(plist,{topLeftX,y2})
table.insert(plist,{bottomRightX,y2})
end
else

local k=lerpY/lerpX
local b=y2-k*x2

table.insert(plist,{(topLeftY-b)/k,topLeftY})
table.insert(plist,{(bottomRightY-b)/k,bottomRightY})

table.insert(plist,{topLeftX,k*topLeftX+b})
table.insert(plist,{bottomRightX,k*bottomRightX+b})
end

local d=nil
if#plist>0 then
for i,v in ipairs(plist)do
if v[1]>=topLeftX and v[1]<=bottomRightX and v[2]<=topLeftY and v[2]>=bottomRightY then
if pos3==nil then
pos3=v
d=mathHelper.distance(v[1],v[2],x2,y2)
else
local d2=mathHelper.distance(v[1],v[2],x2,y2)
if d2<d then
pos3=v
d=d2
end
end
end
end
end
end
check=pos3~=nil
end
self.floatObj:setActive(check)


if check then

local pos4={pos3[1]*scale.x+pos.x,pos3[2]*scale.y+pos.y}
if anim==nil or anim==true then
self.floatObj:setChildDOAnchorPos(Vector2.New(pos4[1],pos4[2]),0.2)
else
self.floatObj:setLocalPos(pos4[1],pos4[2],0)
end







local v={0,-1}
local v2={pos2.x-pos3[1],pos2.y-pos3[2]}


local dot_v=v[1]*v2[1]+v[2]*v2[2]
local l_A=1
local l_B=math.sqrt(v2[1]*v2[1]+v2[2]*v2[2])
local angle=math.acos(dot_v/(l_A*l_B))
local angle_deg=math.deg(angle)
if pos3[1]<=pos2.x then
self.floatArrow:setRotation(0,0,angle_deg)
else
self.floatArrow:setRotation(0,0,-angle_deg)
end
if self.floatSpID==nil then
self.floatSpID=4108
self.floatSP:setChildUIModelShowTarget(self.floatSpID,1,{},0,false,false,0,nil)
end
end
end

function UIXM_XMDG_MapWin:onFloatArrow()
local glid=xianmengdigongModel:getGLID()
if glid then
local room=xianmengdigongModel:getRoom(glid)
if room then
self:hideFloatSign()
self:jumpRoom(room)
end
end
end






function UIXM_XMDG_MapWin:testPlay()
local entData=self:addEnity()
if entData then
self:doDZAnim(entData)
end
end

function UIXM_XMDG_MapWin:initAutoAddDZAnim()
self:clearAutoDZTimer()

local n=math.random(2,maxDZNum)
for i=1,n do
self:addDZAnim(1,true)
if i==n then
self:autoAddDZ()
end
end
end

function UIXM_XMDG_MapWin:clearAutoDZTimer()
if self.autoAddDZAnimTimer~=nil then
self:stopTimerByID(self.autoAddDZAnimTimer)
self.autoAddDZAnimTimer=nil
end
end

function UIXM_XMDG_MapWin:autoAddDZ()
self:addDZAnim(1)
local r=math.random(2.1,3.1)
self.autoAddDZAnimTimer=self:delayDo(r,function()
self.autoAddDZAnimTimer=nil
self:autoAddDZ()
end)
end

function UIXM_XMDG_MapWin:addDZAnim(rnd_num,isInit)
if rnd_num==1 then
self:addDZAnimEx(nil,isInit)
elseif rnd_num>1 then
local num=math.random(1,rnd_num)
local waitTime=0
for i=1,num do
self:addDZAnimEx(waitTime,isInit)
waitTime=waitTime+0.2
end
end
end

function UIXM_XMDG_MapWin:addDZAnimEx(waitTime,isInit)
waitTime=waitTime or 0
local entData=self:addEnity()
if entData then
self:doDZAnim(entData,waitTime,isInit)
end
end

function UIXM_XMDG_MapWin:addEnity()

local idx
local temp={}
local dzlp={}
for idx=1,maxDZNum do
local entData=self.posDataLookup[idx]
if entData==nil then
table.insert(temp,idx)
else
dzlp[entData.dis_guid_str]=true
end
end
if#temp>1 then
idx=table.randomIndex(temp)
else
idx=temp[1]
end
if idx==nil then return end

local dis_guid_str
local temp2={}
for guid_str,dz in pairs(self.allDZLookup)do
if dzlp[guid_str]==nil then
table.insert(temp2,dz)
end
end
if#temp2<=0 then return end
local dz_=table.randomIndex(temp2)
dis_guid_str=dz_[2]

local entData=self:initEnity(dis_guid_str,idx)
return entData
end

function UIXM_XMDG_MapWin:initEnity(dis_guid_str,idx)
local old_entData=self.posDataLookup[idx]
if old_entData~=nil then
self:removeEntity(idx)
end

local dz=self.allDZLookup[dis_guid_str]
local dis_guid=dz[1]
local entityWidget=self.enityWidgetList[idx]
local offsetX=0
local fadeIn=0.6
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dis_guid,true,nil,nil)
entityWidget:SetChildUIModelShowTarget(0,modelParams.body,dzScale,modelParams.componets,0,false,false,0,nil)
entityWidget:SetChildCanvasGroupAlpha(0,1)
entityWidget:SetChildActive(0,false)

local entData={}
entData.dis_guid=dis_guid
entData.dis_guid_str=dis_guid_str
entData.index=idx
self.posDataLookup[idx]=entData
return entData
end

function UIXM_XMDG_MapWin:removeEntity(idx)
local oldData=self.posDataLookup[idx]
if oldData~=nil then
if oldData.bt then
behaviorManager:removeBehaviorTree(oldData.bt)
oldData.bt=nil
end
local entityWidget=self.enityWidgetList[idx]
entityWidget:SetChildUIModelRemoveTarget(0)
self.posDataLookup[idx]=nil
end
end

function UIXM_XMDG_MapWin:clearAllEntity()
if next(self.posDataLookup)then
for idx,entData in pairsBySortKey(self.posDataLookup)do
local entityWidget=self.enityWidgetList[idx]
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
entityWidget:SetChildUIModelRemoveTarget(0)
end
self.posDataLookup={}
end
end

function UIXM_XMDG_MapWin:doDZAnim(entData,waitTime,isInit)
waitTime=waitTime or 0
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
local idx=entData.index
local entityWidget=self.enityWidgetList[idx]
entityWidget:SetChildCanvasGroupAlpha(0,1)

local selectIndex=math.random(1,6)
local selectType=math.random(1,6)
local startPos
local endPos
local offset=10
local y=0
local h_w=self.mapWidth/2
if selectType==1 then

if isInit then
startPos={math.random(-h_w,-offset),y}
else
startPos={-h_w-offset,y}
end
endPos={h_w+offset,y}
elseif selectType==2 then

if isInit then
startPos={math.random(offset,h_w),y}
else
startPos={h_w+offset,y}
end
endPos={-h_w-offset,y}
elseif selectType==3 then

if isInit then
startPos={math.random(-h_w,-offset),y}
else
startPos={-h_w-offset,y}
end
endPos={0,y}
elseif selectType==4 then

if isInit then
startPos={math.random(offset,h_w),y}
else
startPos={h_w+offset,y}
end
endPos={0,y}
elseif selectType==5 then

startPos={0,y}
endPos={h_w+offset,y}
elseif selectType==6 then

startPos={0,y}
endPos={-h_w-offset,y}
end
local initData={
dzWidget=entityWidget,
dzIndex=0,
dzEffIndex=2,
entIndex=idx,
waitTime=waitTime,
startPos=startPos,
endPos=endPos,
}
local bt=behaviorManager:addBehaviorTree('bt_ui_xianmengdigong',nil,true,initData)
bt:setSharedVar('UIstateId',selectIndex)
entData.bt=bt
end


function UIXM_XMDG_MapWin:levelBack(idx)
local entData=self.posDataLookup[idx]
if entData==nil then return end

if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
local entityWidget=self.enityWidgetList[idx]
entityWidget:SetChildCanvasGroupAlpha(0,0)
self.posDataLookup[idx]=nil
end



function UIXM_XMDG_MapWin:rec_roomProgress(roomid,changeRound,unlockAnim)
local idx,room=self:finRoomIndex(roomid)
if idx then
local item=self.mapRoomWidgetList[idx]
self:refreshroomItemBG(item,idx)
self:refreshroomItemProgress(item,idx)
self:refreshroomItemEvents(item,idx)
self:refreshRoomItemLockTime(item,idx)
if unlockAnim and xianmengdigongModel:checkUnlockAnim(roomid)then
self:initRoomUnlockEffect(item,idx)
local idx_=idx
local item_=item
self:delayDo(1,function()
xianmengdigongModel:setUnlockRoom(nil)
self:playRoomUnlockEffect(item_,idx_)
self:refreshroomItemBG(item_,idx_)
self:refreshroomItemEvents(item_,idx_)
end)
end
if changeRound then
local outRoundRooms=room.outRoundRooms
for i,roomid_ in ipairs(outRoundRooms)do
local idx_,room_=self:finRoomIndex(roomid_)
if idx_ then
self:refreshroomItemProgress(nil,idx_)
end
end
local hide_room=xianmengdigongModel:getHideRoom(roomid)
if hide_room then
local idx_=self:finRoomIndex(hide_room.base.id)
if idx_ then
local item_=self.mapRoomWidgetList[idx_]
self:refreshroomItemBG(item_,idx_)
self:refreshroomItemProgress(item_,idx_)
self:refreshroomItemEvents(item_,idx_)
end
end
end
end
end

function UIXM_XMDG_MapWin:rec_roomEvent(roomid)
local idx=self:finRoomIndex(roomid)
if idx then
self:refreshroomItemEvents(nil,idx)
end
end

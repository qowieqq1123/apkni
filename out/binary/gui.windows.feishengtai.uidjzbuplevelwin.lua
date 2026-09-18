







def_class("UIDJZBuplevelWin",UIWindowBase)









function UIDJZBuplevelWin:bindComponents()

self.btnUpgrade=UIButton.get(self,0)
self.bulidspine=UIObject.get(self,1)
self.firstPanel=UIObject.get(self,2)
self.icon=UIObject.get(self,3)
self.level=UIText.get(self,4)
self.modelspine=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.shengjiBtn=UIText.get(self,7)
self.djtxt=UIText.get(self,8)
self.desc1=UIText.get(self,9)
self.desc2=UIText.get(self,10)
self.fullimg=UIObject.get(self,11)
self.bxbtn=UIButton.get(self,12)
self.leftArrow=UIButton.get(self,13)
self.leftArrowImg=UIObject.get(self,14)
self.rightArrow=UIButton.get(self,15)
self.rightArrowImg=UIObject.get(self,16)
self.buildtitle=UIText.get(self,17)
self.djzbreddot=UIObject.get(self,18)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.bxbtn:setButtonClick(function()self:onBxbtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)



end


function UIDJZBuplevelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.bulidspine);self.bulidspine=nil;
_UIObject_release(self.firstPanel);self.firstPanel=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.modelspine);self.modelspine=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.shengjiBtn);self.shengjiBtn=nil;
_UIObject_release(self.djtxt);self.djtxt=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.fullimg);self.fullimg=nil;
_UIObject_release(self.bxbtn);self.bxbtn=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.buildtitle);self.buildtitle=nil;
_UIObject_release(self.djzbreddot);self.djzbreddot=nil;
end
















local _this
local alldjjz={82,83,84,85,86}
local buildstate=
{
weidoing=0,
doing=1,
finish=2
}



function UIDJZBuplevelWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIDJZBuplevelWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end




function UIDJZBuplevelWin:onShow(argtable,afterOnloaded)
self.sfId=zongmenModel:getMountainId()
if argtable then
local flag=argtable[1]
if flag==1 then
local entityId=argtable[2].entityId
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.ubdId=self.bdData.un_build_id
self.buildid=self.bdData.build_id
self.model=2
self:refreshjzData()
else
self.buildid=argtable[2]
self:refreshjzData()
for k,v in pairs(self.allZhenWudata)do
if v.jzid==self.buildid then
self.model=v.model
self.bdData=v.jzdata
end
end
self.ubdId=self.bdData.un_build_id
self.buildid=self.bdData.build_id
end


self:refreshleftpanel()
self:refreshrightpanel()
self:checkAndShowArrowBtn()
end
end


function UIDJZBuplevelWin:onHide()

end

function UIDJZBuplevelWin:onBxbtn()
self:showWindow("UIDJZBRewardWin",{buildid=_this.buildid})
end

function UIDJZBuplevelWin:onBtnUpgrade()
self.bdData.feishengtai=true
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end


function UIDJZBuplevelWin:refreshjzData()
local templist={}
for k,v in ipairs(alldjjz)do
local temp=
{
stage=0,
jzid=v,
jzdata=nil,
model=1,
isfinish=false
}
templist[v]=temp
end

for k,SLG_type in ipairs(alldjjz)do
local bdDatas=zongmenModel:getBuildingDataByBdType(self.sfId,SLG_type)
if bdDatas and bdDatas[1]then
local v=bdDatas[1]
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if v.flag>10 and v.flag~=22 then
local temp=
{
stage=1,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=false
}
templist[cfg.build_type]=temp
elseif v.flag==22 then
local temp=
{
stage=2,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=true
}
templist[cfg.build_type]=temp
else
local temp=
{
stage=2,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=true
}
templist[cfg.build_type]=temp
end
end
end


local newlist={}
for k,v in pairs(templist)do
local _jzid=v.jzid
if v.isfinish==true then
newlist[_jzid]=v
end
end
self.allZhenWudata=newlist


end


function UIDJZBuplevelWin:refreshleftpanel()

local buildid=self.buildid

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local model=cfg.sp_ui_model
local uplvloffect_cfg=cfg_dujietreasuresconfig_get(buildid).uplvloffect
local bigcfg=uplvloffect_cfg[1]
local scale=bigcfg[1]

self.winlua:SetChildUIModelShowTarget(self.icon:getID(),model[1],scale,nil,eAnimationID.bd_stand)
self.icon:setChildUIModelShowTargetOffset(bigcfg[2],bigcfg[3])
self:djzbRewardReddot(buildid)
end


function UIDJZBuplevelWin:djzbRewardReddot(_jzid)
local reddot=DuJieZhiBaoController:getDJZBSingleReddot(_jzid)
_this.bxbtn:setActive(reddot)
_this.djzbreddot:setActive(reddot)
end


function UIDJZBuplevelWin:refreshrightpanel()
local buildid=self.buildid
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
self.buildtitle:setText(cfg.name or"")

local model=cfg.sp_ui_model
local uplvloffect_cfg=cfg_dujietreasuresconfig_get(buildid).uplvloffect
local smallcfg=uplvloffect_cfg[2]
local scale=smallcfg[1]
self.winlua:SetChildUIModelShowTarget(self.bulidspine:getID(),model[1],scale,nil,eAnimationID.bd_stand)
self.bulidspine:setChildUIModelShowTargetOffset(smallcfg[2],smallcfg[3])



local now_level=self.bdData.level
local str1=FMT.fmt("{0}级镇物",now_level)
self.djtxt:setText(str1)


local cfgdjuplevel=cfg_dujietreasureslevelconfig_get(buildid)[now_level]
local str2=cfgdjuplevel.sxdesc
self.desc1:setText(str2)
end


function UIDJZBuplevelWin:checkAndShowArrowBtn()
local list=self.allZhenWudata or{}
local len=0
for k,v in pairs(list)do
len=len+1
end
local showArrow=len>1
self.leftArrow:setActive(showArrow)
self.rightArrow:setActive(showArrow)
if showArrow and not self.showArrowAnim then
self.showArrowAnim=true
local tween1=self.leftArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
local tween2=self.rightArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
end


function UIDJZBuplevelWin:onLeftArrow()
if self.allZhenWudata then

local thisbuild=self.buildid
local lastidx
local lastbuid
local tempalldjjz={}
for k,v in pairs(self.allZhenWudata)do
if v.isfinish then
tempalldjjz[#tempalldjjz+1]=v.jzid
end
end
local maxlength=#tempalldjjz
for k,v in ipairs(tempalldjjz)do
if v==thisbuild then
lastidx=k-1
end
end
if lastidx then
if lastidx<1 then
lastidx=maxlength
end
lastbuid=tempalldjjz[lastidx]
end
if lastbuid then
self.buildid=lastbuid
self.bdData=self.allZhenWudata[lastbuid].jzdata


self:refreshleftpanel()
self:refreshrightpanel()
end
end
end
function UIDJZBuplevelWin:onRightArrow()
if self.allZhenWudata then

local thisbuild=self.buildid
local nexidx
local nexbuid
local tempalldjjz={}
for k,v in pairs(self.allZhenWudata)do
if v.isfinish then
tempalldjjz[#tempalldjjz+1]=v.jzid
end
end
local maxlength=#tempalldjjz
for k,v in ipairs(tempalldjjz)do
if v==thisbuild then
nexidx=k+1
end
end
if nexidx then
if nexidx>maxlength then
nexidx=nexidx-maxlength
end
nexbuid=tempalldjjz[nexidx]
end
if nexbuid then
self.buildid=nexbuid
self.bdData=self.allZhenWudata[nexbuid].jzdata


self:refreshleftpanel()
self:refreshrightpanel()
end
end
end


function UIDJZBuplevelWin.on_building_event(etype,sfId,ubdId,dzId,olddzId)
local data=zongmenModel:getBuildingData(ubdId)
if not data then
return
end
if data.build_id==_this.buildid then
if etype==buildingEvent.buildStart or etype==buildingEvent.buildComplete
or etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
_this:refreshrightpanel()
end
end
end

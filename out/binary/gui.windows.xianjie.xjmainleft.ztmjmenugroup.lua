







def_class("ztmjmenuGroup",UICloneObject)





ztmjmenuGroup.abName="ui/windows/xianjie/xjmainleft/ztmjmenugroup.ab"

ztmjmenuGroup.assetName="ztmjmenuGroup"


function ztmjmenuGroup:bindComponents()

self.content=UIObject.get(self,0)
self.listBg=UIObject.get(self,1)
self.mjBtn=UIButton.get(self,2)
self.mjPanel=UIObject.get(self,3)
self.mjSelect=UIObject.get(self,4)
self.noneTips=UIObject.get(self,5)
self.scrollView=UIObject.get(self,6)
self.xjBtn=UIButton.get(self,7)
self.xjSelect=UIObject.get(self,8)

self.mjBtn:setButtonClick(function()self:onMjBtn()end)

self.xjBtn:setButtonClick(function()self:onXjBtn()end)

end


function ztmjmenuGroup:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.listBg);self.listBg=nil;
_UIObject_release(self.mjBtn);self.mjBtn=nil;
_UIObject_release(self.mjPanel);self.mjPanel=nil;
_UIObject_release(self.mjSelect);self.mjSelect=nil;
_UIObject_release(self.noneTips);self.noneTips=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.xjBtn);self.xjBtn=nil;
_UIObject_release(self.xjSelect);self.xjSelect=nil;
end





local _this=nil
local _itemCmp={
nameTx=0,
hpTx=1,
bg=2,
headKuang=3,
icon=4,
jumpBtn=5,
open=6,
close=7,
cdTx=8,
dead=9,
}



function ztmjmenuGroup:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addProNotify(39,11,self.on_39_11)
end


function ztmjmenuGroup:__delete()
self:unbindComponents()
_this=nil
end




function ztmjmenuGroup:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parent
self.selectMenuPageIndex=1

self:initView()
self:refreshBtn()
self:refreshPanel()
self:refreshXianJieMainWinSimpleStateChange()
end


function ztmjmenuGroup:onHide()

end




function ztmjmenuGroup:onMjBtn()
if self.selectMenuPageIndex==2 then
self.selectMenuPageIndex=1
if self.dataChange then
self.dataChange=false

local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
self:updateData(seasonType,stageIndex)
end
self:refreshBtn()
self:refreshPanel()
end
end

function ztmjmenuGroup:onXjBtn()
if self.selectMenuPageIndex==1 then
self.selectMenuPageIndex=2
self:refreshBtn()
self:refreshPanel()
end
end

function ztmjmenuGroup.onNewDay()
if _this==nil then return end
if _this.selectMenuPageIndex==1 then
_this:refreshMJPanel()
end
end

function ztmjmenuGroup:getSelectMenuPageIndex()
return self.selectMenuPageIndex
end

function ztmjmenuGroup:updateData(seasonType,stageIndex)
local configs=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojiang")
self.mjLookup={}
self.mjSortList={}
for build_id,config in pairs(configs)do
local data=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
self.mjLookup[build_id]={
id=build_id,
open=config.open,
dead=data and data.killTime>0 and 1 or 0
}
table.insert(self.mjSortList,build_id)
end
table.sort(self.mjSortList,self.sortDataFunc)
end

function ztmjmenuGroup.sortDataFunc(a,b)
local _a=_this.mjLookup[a]
local _b=_this.mjLookup[b]
if _a.dead~=_b.dead then
return _a.dead<_b.dead
elseif _a.open~=_b.open then
return _a.open<_b.open
else
return _a.id>_b.id
end
end

function ztmjmenuGroup:initView(stage)
self.stage=stage or seasonModel:findFirstDoingStage(seasonStageType.eMJHD)
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
self:updateData(seasonType,stageIndex)

local count=#self.mjSortList
self.content:setChildLayoutGroupCreateItems(count,function(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
item:SetChildButtonClick(_itemCmp.jumpBtn,function()
self:onClickJump(index)
end)
item:SetChildButtonClick(_itemCmp.bg,function()
self:onClickItem(index)
end)
end)
self.scrollView:setChildScrollRectEnable(count>3)
end

function ztmjmenuGroup:refreshBtn()
self.xjSelect:setActive(self.selectMenuPageIndex==2)
self.mjSelect:setActive(self.selectMenuPageIndex==1)
end

function ztmjmenuGroup:refreshPanel()
if self.selectMenuPageIndex==1 then
self:refreshMJPanel()
elseif self.selectMenuPageIndex==2 then
self:refreshXJPanel()
end
end

function ztmjmenuGroup:refreshMJPanel()
self.mjPanel:setActive(true)
self.parentWin.xjPanel:setActive(false)

for index,build_id in ipairs(self.mjSortList)do
local item=self.content:getChildLayoutGroupGridItem(index-1)
self:refreshMJItem(build_id,item)
end
end

function ztmjmenuGroup:refreshMJItem(build_id,item)
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local beginTime=self.stage.beginTime
local nowTime=timeHelper.getServerShortTime()

local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local entity=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
local monster_id=entity.monster_id
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monster_id)
local entityData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
local mjCfg=self.stage:getConfig("mojiang",build_id)
local openTime=mjCfg.open+beginTime
local isDead=entityData.killTime>0
local isOpen=nowTime>=openTime

item:SetChildActive(_itemCmp.open,isOpen and not isDead)
item:SetChildActive(_itemCmp.close,not isOpen and not isDead)
item:SetChildActive(_itemCmp.dead,isDead)
item:SetChildText(_itemCmp.nameTx,buildCfg.name)
item:SetChildCSImageSprite(_itemCmp.headKuang,globalABLookup.global,monTypeBg[monsterCfg.monType])
item:SetChildGraphicGray(_itemCmp.headKuang,isDead)
comHelper.setChildModelRawImage_monsterGroup(item,monster_id,_itemCmp.icon,eAnimationID.stand,eHeadCenterType.eHead,nil,isDead)

if not isDead then
if isOpen then
item:SetChildText(_itemCmp.hpTx,FMT.fmt("生命：<color=#f36666>{0}%</color>",entityData.hp/100))
else
item:SetChildText(_itemCmp.cdTx,FMT.fmt("{0}天后开启",math.ceil((openTime-nowTime)/86400)))
end
end
end

function ztmjmenuGroup:refreshMJItemEx(build_id)
local index=table.findValue(self.mjSortList,build_id)
local item=self.content:getChildLayoutGroupGridItem(index-1)
self:refreshMJItem(build_id,item)
end

function ztmjmenuGroup:onClickItem(index)
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local beginTime=self.stage.beginTime
local build_id=self.mjSortList[index]
local nowTime=timeHelper.getServerShortTime()
local stageCfg=self.stage:getConfig("mojiang",build_id)
local entity=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
local openTime=stageCfg.open+beginTime
local isDead=entity.killTime>0
local isOpen=nowTime>=openTime
if isDead then
UIManager.info("魔将已击败")
elseif not isOpen then
local str=FMT.fmt("{0}天后开启",math.ceil((openTime-nowTime)/86400))
UIManager.info(str)
end
xianjieController:openMoJiangWin(seasonType,stageIndex,build_id)
end

function ztmjmenuGroup:onClickJump(index)
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local build_id=self.mjSortList[index]
xianjieController:openMoJiangWin(seasonType,stageIndex,build_id)
end

function ztmjmenuGroup:refreshXJPanel()
self.mjPanel:setActive(false)
self.parentWin.xjPanel:setActive(true)
self.parentWin:refreshTeamPanel()
end

function ztmjmenuGroup.on_39_11(seasonType,stageIndex,build_id,hp)
if _this.selectMenuPageIndex==1 then
local _seasonType=_this.stage.handle.id
local _stageIndex=_this.stage.index
if seasonType==_seasonType and _stageIndex==stageIndex then
_this:refreshMJItemEx(build_id)
end
end
end

function ztmjmenuGroup.onSeasonChange()
if _this.selectMenuPageIndex==1 then
_this.stage=seasonModel:findFirstDoingStage(seasonStageType.eMJHD)
if _this.stage then
_this:initView(_this.stage)
_this:refreshPanel()
end
else
_this.dataChange=true
end
end

function ztmjmenuGroup.onSeasonStageChange(seasonType,stageIndex)
local _seasonType=_this.stage.handle.id
local _stageIndex=_this.stage.index
if seasonType==_seasonType and _stageIndex==stageIndex then
if _this.selectMenuPageIndex==1 then
_this:updateData(_seasonType,_stageIndex)
_this:refreshMJPanel()
else
_this.dataChange=true
end
end
end

local simpleKey="xianjieMainWin.meueGropEx.ztmjmenuGroup"
function ztmjmenuGroup:refreshXianJieMainWinSimpleStateChange()
local simpleState=xianjieMainWinSimpleModeConfig:getRecordState(simpleKey)

self.widget:SetChildActive(-1,not simpleState)
end
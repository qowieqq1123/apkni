







def_class("xfztmenuGroup",UICloneObject)





xfztmenuGroup.abName="ui/windows/xianjie/xjmainleft/xfztmenugroup.ab"

xfztmenuGroup.assetName="xfztmenuGroup"


function xfztmenuGroup:bindComponents()

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


function xfztmenuGroup:unbindComponents()
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
progress=1,
bg=2,
headKuang=3,
jumpBtn=4,
progressTx=5,
}
local abname="ui/windows/mojiezhentai/mojiezhentai_atlas_pak.ab"



function xfztmenuGroup:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addProNotify(39,37,self.on_39_37)
end


function xfztmenuGroup:__delete()
self:unbindComponents()
_this=nil
end




function xfztmenuGroup:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parent
self.selectMenuPageIndex=1

self:initView()
self:refreshBtn()
self:refreshPanel()
self:refreshXianJieMainWinSimpleStateChange()
end


function xfztmenuGroup:onHide()

end




function xfztmenuGroup:onMjBtn()
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

function xfztmenuGroup:onXjBtn()
if self.selectMenuPageIndex==1 then
self.selectMenuPageIndex=2
self:refreshBtn()
self:refreshPanel()
end
end

function xfztmenuGroup.onNewDay()
if _this==nil then return end
if _this.selectMenuPageIndex==1 then
_this:refreshMJPanel()
end
end

function xfztmenuGroup:getSelectMenuPageIndex()
return self.selectMenuPageIndex
end

function xfztmenuGroup:updateData(seasonType,stageIndex)
local client_build_list=self.configs.client_build_list
local fix_conf=self.configs.fix_conf
self.ztLookup={}
self.ztSortList={}
for build_id,client_build_id in ipairs(client_build_list)do
local data=xianjieModel:getZhenTaiEntity(seasonType,stageIndex,build_id)or defaultT
local finish_cnt=data.finish_cnt or 0
local max_finish_cnt=fix_conf[build_id]
local sortVal=build_id
if finish_cnt>=max_finish_cnt then
sortVal=sortVal+10000
end
self.ztLookup[build_id]={
id=build_id,
sortVal=sortVal,
}
table.insert(self.ztSortList,build_id)
end
table.sort(self.ztSortList,self.sortDataFunc)
end

function xfztmenuGroup.sortDataFunc(a,b)
local _a=_this.ztLookup[a]
local _b=_this.ztLookup[b]
return _a.sortVal<_b.sortVal
end

function xfztmenuGroup:initView(stage)
self.stage=stage or seasonModel:findFirstDoingStage(seasonStageType.eMJZT)
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
self.configs=seasonModel:getStageConfigEx(seasonType,stageIndex)
self:updateData(seasonType,stageIndex)

local count=#self.ztSortList
self.content:setChildLayoutGroupCreateItems(count,function(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
item:SetChildButtonClick(_itemCmp.jumpBtn,function()
self:onClickJump(index)
end)
item:SetChildButtonClick(_itemCmp.bg,function()
self:onClickJump(index)
end)
end)
self.scrollView:setChildScrollRectEnable(count>3)
end

function xfztmenuGroup:refreshBtn()
self.xjSelect:setActive(self.selectMenuPageIndex==2)
self.mjSelect:setActive(self.selectMenuPageIndex==1)
end

function xfztmenuGroup:refreshPanel()
if self.selectMenuPageIndex==1 then
self:refreshMJPanel()
elseif self.selectMenuPageIndex==2 then
self:refreshXJPanel()
end
end

function xfztmenuGroup:refreshMJPanel()
self.mjPanel:setActive(true)
self.parentWin.xjPanel:setActive(false)

for index,build_id in ipairs(self.ztSortList)do
local item=self.content:getChildLayoutGroupGridItem(index-1)
self:refreshMJItem(build_id,item)
end
end

function xfztmenuGroup:refreshMJItem(build_id,item)
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local beginTime=self.stage.beginTime
local nowTime=timeHelper.getServerShortTime()

local client_build_list=self.configs.client_build_list
local client_build_id=client_build_list[build_id]
local fix_conf=self.configs.fix_conf
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,client_build_id)
local entityData=xianjieModel:getZhenTaiEntity(seasonType,stageIndex,build_id)
local finish_cnt=entityData.finish_cnt or 0
local max_finish_cnt=fix_conf[build_id]
local percent=finish_cnt/max_finish_cnt
local build_icon_list=self.configs.build_icon_list
local iconName=build_icon_list[build_id]
local showPercent=math.max(math.floor(percent*100*10)/10,finish_cnt>0 and 0.1 or 0)

item:SetChildCSImageSprite(_itemCmp.headKuang,abname,iconName)
item:SetChildText(_itemCmp.nameTx,buildCfg.name)
item:SetChildIconFillAmount(_itemCmp.progress,percent)
item:SetChildText(_itemCmp.progressTx,percent>=1 and"已修复"or string.format("修复度：%s%%",showPercent))
end

function xfztmenuGroup:refreshMJItemEx(build_id)
local index=table.findValue(self.ztSortList,build_id)
local item=self.content:getChildLayoutGroupGridItem(index-1)
self:refreshMJItem(build_id,item)
end

function xfztmenuGroup:onClickJump(index)
local seasonType=self.stage.handle.id
local stageIndex=self.stage.index
local build_id=self.ztSortList[index]
xianjieController:openZhenTaiWin(seasonType,stageIndex,build_id)
end

function xfztmenuGroup:refreshXJPanel()
self.mjPanel:setActive(false)
self.parentWin.xjPanel:setActive(true)
self.parentWin:refreshTeamPanel()
end

function xfztmenuGroup.on_39_37(seasonType,stageIndex,len,zhenTaiList)
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

function xfztmenuGroup.onSeasonChange()
if _this.selectMenuPageIndex==1 then
_this.stage=seasonModel:findFirstDoingStage(seasonStageType.eMJZT)
if _this.stage then
_this:initView(_this.stage)
_this:refreshPanel()
end
else
_this.dataChange=true
end
end

function xfztmenuGroup.onSeasonStageChange(seasonType,stageIndex)
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

local simpleKey="xianjieMainWin.meueGropEx.xfztmenuGroup"
function xfztmenuGroup:refreshXianJieMainWinSimpleStateChange()
local simpleState=xianjieMainWinSimpleModeConfig:getRecordState(simpleKey)
self.widget:SetChildActive(-1,not simpleState)
end
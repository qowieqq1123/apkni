







def_class("UIYanDaoTaiWin",UIWindowBase)









function UIYanDaoTaiWin:bindComponents()

self.AreaRoot=UIObject.get(self,0)
self.bdLevel=UIText.get(self,1)
self.bgModel=UIObject.get(self,2)
self.content=UIObject.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.levelUpBtn=UIButton.get(self,5)
self.levelUpBtnText=UIText.get(self,6)
self.lianhuaModel=UIObject.get(self,7)
self.lineRoot=UIObject.get(self,8)
self.openBtn=UIButton.get(self,9)
self.overviewBtn=UIButton.get(self,10)
self.reddot=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.scrollView=UIObject.get(self,13)
self.tabList=UIObject.get(self,14)
self.tabScrollView=UIObject.get(self,15)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.openBtn:setButtonClick(function()self:onOpenBtn()end)

self.overviewBtn:setButtonClick(function()self:onOverviewBtn()end)



end


function UIYanDaoTaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.AreaRoot);self.AreaRoot=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.lianhuaModel);self.lianhuaModel=nil;
_UIObject_release(self.lineRoot);self.lineRoot=nil;
_UIObject_release(self.openBtn);self.openBtn=nil;
_UIObject_release(self.overviewBtn);self.overviewBtn=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tabScrollView);self.tabScrollView=nil;
end
















local this
local abName='ui/windows/yandaotai/yandaotai_atlas_pak.ab'





function UIYanDaoTaiWin:onLoaded(...)
this=self
self:bindComponents()
self:addNotify(notifyConfig.building_event,self.on_building_event)
end


function UIYanDaoTaiWin:__delete()
this=nil
self:unbindComponents()
end




function UIYanDaoTaiWin:onShow(argtable,afterOnloaded)
self.treeType=YDT_TREE_TYPE.eChuanCheng
self.tabSelect=1
if argtable then
self.treeType=argtable.treeType or YDT_TREE_TYPE.eChuanCheng
if argtable.tabSelect then
self.tabSelect=argtable.tabSelect
else
local treeId
local studyList=yandaotaiModel:getStudyList()
if studyList and studyList.id and studyList.starTime then
treeId=yandaotaiModel:getTechnologyTreeId(studyList.id)
else
treeId=yandaotaiModel:getYanDaoTaiSaveTreeId()
end
if treeId then
local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,treeId)
if cfg.type==self.treeType then
self.tabSelect=cfg.tabIdx
else
self.tabSelect=1
end
else
self.tabSelect=1
end
end
local guid=argtable.entityId
self.entityId=guid
self.bdData=zongmenModel:findBuildingByEntityId(guid)
self.buildLevel=self.bdData.level

self.buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)

end
self.treeId=yandaotaiModel:getTreeIdByTypeAndTabIdx(self.treeType,self.tabSelect)
self.value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)





self:initTabList()
self:refreshWin(true)
self:refreshLevelUpPanel()
end

function UIYanDaoTaiWin:onShowArgRecv(argtable,afterOnloaded)
self:refreshWin(true)
end


function UIYanDaoTaiWin:onHide()

end

function UIYanDaoTaiWin:initTabList()
local showLen=0
local list=yandaotaiModel:getTechnologyTabList(self.treeType)
for i,cfg in ipairs(list)do
if yandaotaiModel:getIsShowTree(cfg.id)then
showLen=showLen+1
end
end

local len=#list
if showLen>1 then
self.tabList:setActive(true)
self.tabList:setChildLayoutGroupCreateItems(len,function(index)
local widget=this.tabList:getChildLayoutGroupGridItem(index-1)
local cfg=list[index]
local isShow=yandaotaiModel:getIsShowTree(cfg.id)
widget:SetChildActive(-1,isShow)
if isShow then
local allLv=yandaotaiModel:getTechnologyAllLevel(cfg.id)
local curLv=yandaotaiModel:getTechnologyCurLevel(cfg.id)
widget:SetChildActive(0,this.tabSelect==index)
widget:SetChildText(1,cfg.name)
widget:SetChildText(3,FMT.fmt("{0}/{1}",curLv,allLv))

widget:SetChildButtonClick(2,function()
local oldWidget=this.tabList:getChildLayoutGroupGridItem(this.tabSelect-1)
oldWidget:SetChildActive(0,false)
widget:SetChildActive(0,true)
this.tabSelect=index

this:refreshWin(true)
end,true)
end
end)
else
self.tabList:setActive(false)
end
end

function UIYanDaoTaiWin:refreshTabList()
local list=yandaotaiModel:getTechnologyTabList(this.treeType)
for i,v in ipairs(list)do
local widget=this.tabList:getChildLayoutGroupGridItem(i-1)
if widget then
local allLv=yandaotaiModel:getTechnologyAllLevel(list[i].id)
local curLv=yandaotaiModel:getTechnologyCurLevel(list[i].id)
widget:SetChildText(3,FMT.fmt("{0}/{1}",curLv,allLv))
end
end
end

function UIYanDaoTaiWin:refreshTabListReddot()
local showLen=0
local list=yandaotaiModel:getTechnologyTabList(this.treeType)
for i,cfg in ipairs(list)do
if yandaotaiModel:getIsShowTree(cfg.id)then
showLen=showLen+1
end
end

if showLen>1 then
for index,cfg in ipairs(list)do
local isShow=yandaotaiModel:getIsShowTree(cfg.id)
if isShow then
local widget=this.tabList:getChildLayoutGroupGridItem(index-1)
if widget then
local isRed=yandaotaiModel:getTreeIdReddot(cfg.id)
widget:SetChildActive(4,isRed)
end
end
end
end
end

function UIYanDaoTaiWin:refreshLevelUpPanel()
self.bdLevel:setText(FMT.fmt("{0}级{1}",self.bdData.level,self.buildCfg.name))
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.levelUpBtnText:setText(nextLvCfg~=nil and'建筑升级'or'建筑信息')
end

function UIYanDaoTaiWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if not this then
return
end

if this.bdData.un_build_id~=bdId then
return
end

if etype==buildingEvent.levelUpComplete then
this.bdData=zongmenModel:findBuildingByEntityId(this.entityId)
this.buildLevel=this.bdData.level

this.buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,this.bdData.build_id)

this:refreshWin()
this:refreshLevelUpPanel()
elseif etype==buildingEvent.levelUpStart then
this.bdData=zongmenModel:findBuildingByEntityId(this.entityId)
end
end

function UIYanDaoTaiWin:refreshWin(isInit)
this.treeId=yandaotaiModel:getTreeIdByTypeAndTabIdx(this.treeType,this.tabSelect)
if isInit then
yandaotaiModel:setYanDaoTaiSaveTreeId(this.treeId)
UIManager:callWindowFunc('UIXianJieBottomMaskWin','showModel',5821,{0,0})
this.cfgIds=yandaotaiModel:getTechnologyIds(this.treeType,this.tabSelect)
this:initLine()

local h=yandaotaiModel:getTechnologyHeight(this.treeId)
local initY=h-500
this.content:setChildSizeDelta(980,h)

local _y=0
if initY>0 then
local studyList=yandaotaiModel:getStudyList()
local isHasYJ=studyList and studyList.id~=nil
local flag=isHasYJ and yandaotaiModel:getTechnologyIsTreeId(this.treeId,studyList.id)or false
for i,id in ipairs(this.cfgIds)do
if flag and studyList.id==id then
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,1)
if cfg.winParams[2][2]<=0 then
_y=0
break
else
if _y==0 then
_y=cfg.winParams[2][2]
else
_y=math.min(_y,cfg.winParams[2][2])
end
end
break
elseif not flag and yandaotaiModel:getTechnologyIdReddot(id)then
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,1)
if cfg.winParams[2][2]<=0 then
_y=0
break
else
if _y==0 then
_y=cfg.winParams[2][2]
else
_y=math.min(_y,cfg.winParams[2][2])
end
end
end
end
end

this.scrollView:setChildScrollRectEnable(false)
this.content:setLocalPosY(math.max(0,initY-_y))

if initY>0 then
this.scrollView:setChildScrollRectEnable(true)
end
end

local len=#this.cfgIds or 0

if len>0 then
this.AreaRoot:setChildLayoutGroupCreateItems(len,this.refreshMapItem)
end

this:refreshTabList()
this:refreshTabListReddot()
this:refreshLine()
local judge=yandaotaiController:checkIsCanStudy(this.treeId)
this.reddot:setActive(judge)
end

function UIYanDaoTaiWin.refreshMapItem(index)
local areaCmp=
{
owner=0,
button=1,
name=2,
lock=3,
reddot=4,
levelText=5,
levelObj=6,
effect=7,
effModel=8,
}

local cfg
local isUnlock=true
local id=this.cfgIds[index]
local cfgs=cfgHelper.get1(cfg_technologyconfig_get,id)
local maxLevel=#cfgs
local level=yandaotaiModel:getTechnologyListLevel(id)
if not level then
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,1)
else
if level+1<=maxLevel then
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
else
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level)
end
end

local maxlv
local isReddot=false
local winParams=cfg.winParams

local flag=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)
if not level and not flag then isUnlock=false end
local limitLevel=yandaotaiModel:getMinLimitLevel(id)
if maxLevel>limitLevel then
maxlv=limitLevel
else
maxlv=maxLevel
end

local time=yandaotaiModel:getStudyListTime(id)
if winParams then
local show=false
local modelId=0
local iconName=winParams[1]
local position=winParams[2]
local cmp=this.AreaRoot:getChildLayoutGroupGridItem(index-1)

if isUnlock then
if time then
local str
local study_time=yandaotaiController.getchangeSpeed(cfg.study_time,this.value2)
local isFinish=yandaotaiModel:checkStudyisFinishTime(id,study_time)
if isFinish then
isReddot=true
str='<color=#F6EA10>研究完成</color>'
else
show=true
modelId=6371
str='<color=#B0FF77>研究中</color>'
end
cmp:SetChildText(areaCmp.levelText,str)
else
if not level then level=0 end
local str=string.format('%s/%s',level,maxlv)
cmp:SetChildText(areaCmp.levelText,str)

local studyList=yandaotaiModel:getStudyList()
if studyList and studyList.id and studyList.starTime then
isReddot=false
else
isReddot=yandaotaiModel:checkIsEnoughCost(cfg.study_cost)and level<maxlv
end
end
end

cmp:SetChildActive(areaCmp.effModel,show)
if show then
cmp:SetChildUIModelShowTarget(areaCmp.effModel,modelId,1,{},eAnimationID.stand,false,false,0,nil)
end
cmp:SetChildActive(areaCmp.levelObj,isUnlock)
cmp:SetChildActive(areaCmp.lock,not isUnlock)
cmp:SetChildActive(areaCmp.reddot,isReddot)
cmp:SetChildText(areaCmp.name,cfg.technology_name)
cmp:SetChildAnchoredPosition(areaCmp.owner,mathHelper.convertArrayToVector(position))
cmp:SetChildButtonEnable(areaCmp.button,true,not isUnlock)
cmp:SetChildIcon(areaCmp.button,iconName,false)
cmp:SetChildButtonClick(areaCmp.button,function()this.onClickArea(index,maxLevel)end)
end
end
function UIYanDaoTaiWin:playEffect(index)
local grid=this.AreaRoot:getChildLayoutGroupGridList()
local item=grid[index]
item:SetChildActive(8,true)
item:SetChildUIModelShowTarget(8,6372,1,{},eAnimationID.stand,false,false,0,nil)
this:delayDo(1,function()
if not this then return end
item:SetChildActive(8,false)
end)
end

function UIYanDaoTaiWin.onClickArea(index,maxLevel)

local cfg
local id=this.cfgIds[index]
local level=yandaotaiModel:getTechnologyListLevel(id)
if not level then
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,1)
else
if level+1<=maxLevel then
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
else
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level)
end
end
local study_time=yandaotaiController.getchangeSpeed(cfg.study_time,this.value2)
local isFinish=yandaotaiModel:checkStudyisFinishTime(id,study_time)

if isFinish then
local grid=this.AreaRoot:getChildLayoutGroupGridList()
local item=grid[index-1]
item:SetChildActive(8,true)
item:SetChildUIModelShowTarget(8,6372,1,{},eAnimationID.stand,false,false,0,nil)
this:delayDo(1,function()
if not this then return end
item:SetChildActive(8,false)
yandaotaiController.send_6_178(1,{id})
end)
else
local args=
{
id=id,
bdData=this.bdData,
treeType=this.treeType,
tabSelect=this.tabSelect,
}
UIManager:showWindow('UITechnologyWin',args)
end
end

function UIYanDaoTaiWin:initLine()
local lineList={}
local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,self.treeId)
for i,v in ipairs(cfg.winParams)do
local pos=v[1]
local id=v[2]
local winParams=cfgHelper.get3(cfg_technologyconfig_get,id,1,"winParams")
table.insert(lineList,{type=1,id=id,initPos=pos,endPos=winParams[2]})
end

for i,id in ipairs(self.cfgIds)do
local config=cfgHelper.get2(cfg_technologyconfig_get,id,1)
local pos=config.winParams[2]

if config.unlock_condition then
for ii,vv in ipairs(config.unlock_condition)do
if vv[1]==1 and yandaotaiModel:getTechnologyIsTreeId(self.treeId,vv[2])then
local winParams=cfgHelper.get3(cfg_technologyconfig_get,vv[2],1,"winParams")
table.insert(lineList,{type=2,id=id,initPos=pos,endPos=winParams[2]})
end
end
end
end
self.lineList=lineList

local len=#self.lineList
if len>0 then
self.lineRoot:setChildLayoutGroupCreateItems(len,function(index)
local widget=this.lineRoot:getChildLayoutGroupGridItem(index-1)
local data=this.lineList[index]
local width=0
local _w=math.abs(data.endPos[1]-data.initPos[1])
local _h=math.abs(data.endPos[2]-data.initPos[2])
local height=math.floor(math.sqrt(math.pow(_w,2)+math.pow(_h,2)))
local angle=mathHelper.getAngleByPos(data.initPos[1],data.initPos[2],data.endPos[1],data.endPos[2])
if data.type==1 then
width=11
widget:SetChildCSImageSprite(0,abName,"frame_yandaotai_03")
widget:SetChildCSImageSprite(1,abName,"frame_yandaotai_01")
else
width=4
widget:SetChildCSImageSprite(0,abName,"frame_yandaotai_04")
widget:SetChildCSImageSprite(1,abName,"frame_yandaotai_02")
end
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)

widget:SetChildLocalPos(-1,data.initPos[1],data.initPos[2],0)
widget:SetChildSizeDelta(-1,width,height)
widget:SetChildRotation(-1,0,0,angle-90)
end)
else
self.lineRoot:setActive(false)
end
end

function UIYanDaoTaiWin:refreshLine()
if self.lineList then
for i,v in pairs(self.lineList)do
local widget=this.lineRoot:getChildLayoutGroupGridItem(i-1)
local isUnlock=true
local cfg
local id=v.id
local level=yandaotaiModel:getTechnologyListLevel(id)

if not level then
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,1)
else
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level)
end
local flag=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)
if not level and not flag then isUnlock=false end

widget:SetChildActive(1,isUnlock)
end
end
end



function UIYanDaoTaiWin:onLevelUpBtn()
self:showWindow("UIXJBuildingInfoWin",self.bdData)
end


function UIYanDaoTaiWin:onOpenBtn()
local call=function()
self.openBtn:setActive(false)
self.lianhuaModel:setActive(true)
self.root:setActive(true)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
self.openBtn:setChildCanvasGroupDOFade(0,1)
self.openBtn:setChildModelAnimationState(2919,1,call)
self.lianhuaModel:setActive(false)
end

function UIYanDaoTaiWin:onReturnBtn()
self.openBtn:setChildCanvasGroupDOFade(1,1)
self.root:setChildCanvasGroupDOFade(0,0.5)
self.root:setActive(false)
self.openBtn:setActive(true)
end


function UIYanDaoTaiWin:onOverviewBtn()
UIManager:showWindow('UIBonusPreviewWin',{treeType=self.treeType,tabSelect=self.tabSelect})
end


function UIYanDaoTaiWin:onHelpBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='ui_yandaotai_help_%d'
self:showWindow('UIRuleWin',d)
end
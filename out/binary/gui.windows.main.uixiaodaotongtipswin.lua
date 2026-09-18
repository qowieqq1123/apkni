







def_class("UIXiaoDaoTongTipsWin",UIWindowBase)









function UIXiaoDaoTongTipsWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.notips=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.setupBtn=UIButton.get(self,3)
self.setupGridPanel=UIObject.get(self,4)
self.setupScrollView=UIObject.get(self,5)
self.tabList=UIObject.get(self,6)
self.tipsGridPanel=UIObject.get(self,7)
self.tipsScrollView=UIObject.get(self,8)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.setupBtn:setButtonClick(function()self:onSetupBtn()end)



end


function UIXiaoDaoTongTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.notips);self.notips=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.setupBtn);self.setupBtn=nil;
_UIObject_release(self.setupGridPanel);self.setupGridPanel=nil;
_UIObject_release(self.setupScrollView);self.setupScrollView=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tipsGridPanel);self.tipsGridPanel=nil;
_UIObject_release(self.tipsScrollView);self.tipsScrollView=nil;
end
















local _this=nil

local tabCfgList={
{
name="全部",
getSortList=function(list)
return list
end,
},
{
name="宗门要务",
getSortList=function(list)
local temp={}
if list then
for index,data in ipairs(list)do
local cfg=data.cfg
local type=(cfg.type or 1)
if type==2 then
temp[#temp+1]=data
end
end
end
return temp
end,
},
{
name="宗门常务",
getSortList=function(list)
local temp={}
if list then
for index,data in ipairs(list)do
local cfg=data.cfg
local type=(cfg.type or 1)
if type==1 then
temp[#temp+1]=data
end
end
end
return temp
end,
}
}

local CmpTablItemIndex={
select=0,
name=1,
link=2,
last=3,
}


function UIXiaoDaoTongTipsWin:onLoaded(...)
_this=self
self.sliderChangelist={}
self:bindComponents()

self.selectTabIndex=1
end


function UIXiaoDaoTongTipsWin:__delete()
_this=nil

self:unbindComponents()
end


function UIXiaoDaoTongTipsWin:onHide()
if self.sliderChangelist[XDT_TIPS_TYPE.eWDCQguess]then
WDCQController.addGuessTimerAndRefreshFlag()
end
end




function UIXiaoDaoTongTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self:changePage(1)
local isChange=xiaodaotongModel:refreshTipsList(nil,true)
if not isChange then
self:refreshPage()
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end
end

function UIXiaoDaoTongTipsWin:changePage(page)
self.curPage=page
self.setupBtn:setActive(self.curPage==1)
self.backBtn:setActive(self.curPage==2)
self.tipsScrollView:setActive(self.curPage==1)
self.setupScrollView:setActive(self.curPage==2)

local isShwoTab=self.curPage==1
self.tabList:setActive(isShwoTab)
if isShwoTab then
self:refreshTabList()
end
end

function UIXiaoDaoTongTipsWin:refreshTabList()
local len=#tabCfgList

self.tabList:setChildLayoutGroupCreateItems(len,function(index)
if _this==nil then return end

local item=_this.tabList:getChildLayoutGroupGridItem(index-1)

local tabCfg=tabCfgList[index]

item:SetChildText(CmpTablItemIndex.name,tabCfg.name)

local isSelect=index==_this.selectTabIndex
item:SetChildActive(CmpTablItemIndex.select,isSelect)

local isLast=len==index
item:SetChildActive(CmpTablItemIndex.last,isLast)
item:SetChildActive(CmpTablItemIndex.link,not isLast)

item:SetBaseItemClickEvent(-1,function()
if _this==nil then return end

if index==_this.selectTabIndex then return end

local preItem=_this.tabList:getChildLayoutGroupGridItem(_this.selectTabIndex-1)
preItem:SetChildActive(CmpTablItemIndex.select,false)

_this.selectTabIndex=index
item:SetChildActive(CmpTablItemIndex.select,true)

_this:refreshPage()
end)
end)
end

function UIXiaoDaoTongTipsWin:refreshPage()
if self.curPage==1 then
self:refreshTipsScrollView()
else
self:refreshSetupScrollView()
end
end


function UIXiaoDaoTongTipsWin:worldsortlist()
if mainControl:isInScene(eSceneType.eWorld)then
if#self.tipsList>1 then
table.sort(self.tipsList,function(a,b)
local aa=0
if a.cfg.worldweight then
aa=a.weight*1000
end
local bb=0
if b.cfg.worldweight then
bb=b.weight*1000
end
return aa>bb
end)
end
end
end

function UIXiaoDaoTongTipsWin:refreshTipsScrollView()
self.tipsList=xiaodaotongModel:getTipsList_sort()
self:worldsortlist()

local tabCfg=tabCfgList[self.selectTabIndex]
if tabCfg and tabCfg.getSortList then
self.tipsList=tabCfg.getSortList(self.tipsList)
end


local c=#self.tipsList
self.tipsGridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.tipsGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local data=self.tipsList[i]
local cfg=data.cfg
local buildType

local scale
if cfg.id==XDT_TIPS_TYPE.eDianPu_1 then
local resultParams=data.args
if resultParams and resultParams.bdData then
local bdData=resultParams.bdData
local icon=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'icon')
item:SetChildCSImageIcon(0,icon,true)
end
scale=0.6
elseif cfg.icon~=nil then
local icon=FMT.fmt('icon_zawubu_{0}',cfg.icon)
item:SetChildCSImageSprite(0,globalABLookup.zawubuicons,icon)
scale=1
else
if cfg.buildType then
buildType=cfg.buildType
elseif cfg.icon_build then
buildType=cfg.icon_build
end
local icon=cfgHelper.get2(cfg_monijybuildconfig_get,buildType,'icon')
item:SetChildCSImageIcon(0,icon,true)
scale=0.6
end
item:SetChildScale(0,Vector3(scale,scale,scale))

if cfg.name~=nil then
item:SetChildText(1,cfg.name)
else
local name=cfgHelper.get2(cfg_monijybuildconfig_get,buildType,name)
item:SetChildText(1,name)
end

local desc_str=xiaodaotongModel:getDesc(cfg)
item:SetChildText(2,desc_str)

item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onGotoBtn(i)
end)

local isReddot=data.isReddot==true and xiaodaotongModel:checkShowReddot(cfg)
item:SetChildActive(4,isReddot)
end
self.notips:setActive(c<=0)
end

function UIXiaoDaoTongTipsWin:refreshItemReddot(item,idx)
if item==nil then
item=self.tipsGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local item=grids[i-1]
local data=self.tipsList[i]
local cfg=data.cfg


local isReddot=data.isReddot==true and xiaodaotongModel:checkShowReddot(cfg)
item:SetChildActive(4,isReddot)
end

function UIXiaoDaoTongTipsWin:onGotoBtn(idx)
local data=self.tipsList[idx]
local cfg=data.cfg
if cfg.id==XDT_TIPS_TYPE.eDianPu_1 then

local resultParams=data.args
if resultParams and resultParams.bdData then
local bdData=resultParams.bdData
local parentWin=self.parentWin
local flag=jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id}}})
if flag then
UIManager:invokeUIMethod(parentWin,'onClickClose')

weakGuideController:beginGuide(3551)
end
end
return
end
if cfg.jump then
local jumpParams=table.deepCopy(cfg.jump)
if jumpParams.id==JUMP_TYPE.eBuilding then
local resultParams=data.args
if resultParams and resultParams.bdData then
if isometricMapSystem:checkLinkRoad(resultParams.bdData,true)then
jumpParams.args=jumpParams.args or{}
jumpParams.args.args=jumpParams.args.args or{}
jumpParams.args.type=resultParams.bdData.build_id
jumpParams.args.args.un_build_id=resultParams.bdData.un_build_id
local parentWin_=self.parentWin
local flag_=jumpManager:jump(jumpParams)
if flag_ then
UIManager:invokeUIMethod(parentWin_,'onClickClose')
end
return
end
end
end
local parentWin=self.parentWin
local flag=jumpManager:jump(jumpParams)
if flag then
UIManager:invokeUIMethod(parentWin,'onClickClose')
end
end
end

function UIXiaoDaoTongTipsWin:refreshSetupScrollView()
self.setupList=xiaodaotongModel:getSetupList()

local c=#self.setupList
self.setupGridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.setupGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local data=self.setupList[i]
local cfg=data.cfg

local scale
if cfg.icon~=nil then
local icon=FMT.fmt('icon_zawubu_{0}',cfg.icon)
item:SetChildCSImageSprite(0,globalABLookup.zawubuicons,icon)
scale=1
else
local icon=cfgHelper.get2(cfg_monijybuildconfig_get,cfg.buildType,'icon')
item:SetChildCSImageIcon(0,icon,true)
scale=0.6
end
item:SetChildScale(0,Vector3(scale,scale,scale))

if cfg.name~=nil then
item:SetChildText(1,cfg.name)
else
local name=cfgHelper.get2(cfg_monijybuildconfig_get,cfg.buildType,name)
item:SetChildText(1,name)
end
local setupData=xiaodaotongModel:getSetup(cfg.id)

local min,max=xiaodaotongModel:getSliderValues(cfg)
local showSlider=min~=nil and min~=max
item:SetChildActive(4,showSlider)
if showSlider then
local cur=setupData.sliderCnt
data.lockSlider=true
item:SetChildSliderInit(4,cur,min,max,function(value)
if _this==nil then return end
_this:onSliderChange(value,i)
end)
item:SetChildSliderValue(4,cur)
data.lockSlider=nil
end

local desc_str=xiaodaotongModel:getSetupDesc(cfg)
item:SetChildText(2,desc_str)
if showSlider then
item:SetChildAnchoredPos(2,-68,-32)
else
item:SetChildAnchoredPos(2,-68,-10)
end

item:SetChildToggle(3,setupData.isSetup)
item:SetChildToggleChange(3,function(name,isOn)
if _this==nil then return end
_this:onToggleChange(name,isOn,i)
end)
end
self.notips:setActive(c<=0)
end

function UIXiaoDaoTongTipsWin:onSliderChange(value,idx)
local data=self.setupList[idx]
if data.lockSlider==true then
return
end
local cfg=data.cfg
local setupData=xiaodaotongModel:getSetup(cfg.id)
setupData.sliderCnt=value
xiaodaotongModel:refreshSetup(setupData)


local item=self.setupGridPanel:getChildLayoutGroupGridItem(idx-1)
local desc_str=xiaodaotongModel:getSetupDesc(cfg)
item:SetChildText(2,desc_str)
self.sliderChangelist[cfg.id]=true
end

function UIXiaoDaoTongTipsWin:onToggleChange(name,isOn,idx)
local data=self.setupList[idx]
local cfg=data.cfg
local setupData=xiaodaotongModel:getSetup(cfg.id)
if isOn then
setupData.isSetup=true
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk',{id=-1,once=-2})
else
setupData.isSetup=false
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk',{id=-1,once=-3})
end
xiaodaotongModel:refreshSetup(setupData)
end

function UIXiaoDaoTongTipsWin:onSetupBtn()
self:changePage(2)
self:refreshPage()
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk',{id=-1})
end

function UIXiaoDaoTongTipsWin:onBackBtn()
self:changePage(1)
self:refreshPage()
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
if self.sliderChangelist[XDT_TIPS_TYPE.eWDCQguess]then
WDCQController.addGuessTimerAndRefreshFlag()
end
end

function UIXiaoDaoTongTipsWin:onTipsChange()
if self.curPage==1 then
self:refreshTipsScrollView()
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
end
end

function UIXiaoDaoTongTipsWin:getTalkList(args)
if self.curPage==1 then
local data=self.tipsList[1]
if data then
return xiaodaotongModel:getTalkList_1(data.cfg.id)
else
return xiaodaotongModel:getTalkList_1(0)
end
elseif self.curPage==2 then
if args==nil then
return xiaodaotongModel:getTalkList_1(-1)
else
if args.once then
local talks=xiaodaotongModel:getTalkList_1(args.once)
if talks then
local str=table.randomIndex(talks)
return xiaodaotongModel:getTalkList_1(args.id or-1),str
end
else
return xiaodaotongModel:getTalkList_1(args.id or-1)
end
end
end
return nil
end








def_class("UIXM_ZZSH_TreasureBoxWin",UIWindowBase)









function UIXM_ZZSH_TreasureBoxWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.itemScrollView=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.allReceiveBtn=UIButton.get(self,3)
self.itemPanel=UIObject.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.pageGroup=UIObject.get(self,6)
self.shLevelBg=UIObject.get(self,7)
self.shLevelText=UIText.get(self,8)
self.bgModel=UIObject.get(self,9)
self.levelHelpBtn=UIButton.get(self,10)
self.animObj=UIObject.get(self,11)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.allReceiveBtn:setButtonClick(function()self:onAllReceiveBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.levelHelpBtn:setButtonClick(function()self:onLevelHelpBtn()end)



end


function UIXM_ZZSH_TreasureBoxWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.allReceiveBtn);self.allReceiveBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.pageGroup);self.pageGroup=nil;
_UIObject_release(self.shLevelBg);self.shLevelBg=nil;
_UIObject_release(self.shLevelText);self.shLevelText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.levelHelpBtn);self.levelHelpBtn=nil;
_UIObject_release(self.animObj);self.animObj=nil;
end



















local ItemIndex={
icon=0,
name_img=1,
count_key=2,
openBtn=3,
reward_panel=4,
reddot=5,
bg_img=6,
cost_icon=7,
reward_panel=8,
count_use=9,
stageBg=10,
stageText=11,
}

local _this=nil
local abname="ui/windows/xianmeng/act_zhengzhanshanhai/treasurebox_atlas_pak.ab"
local _defaultBgModelId=5277
local _defaultRuleLangId="zzsh_baoxia_%s"


function UIXM_ZZSH_TreasureBoxWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXM_ZZSH_TreasureBoxWin:__delete()
self:unbindComponents()
_this=nil
self.config=nil
end




function UIXM_ZZSH_TreasureBoxWin:onShow(argtable,afterOnloaded)
self.selectPageIdx=1
self.isShowPageGroup=false

self.bgModelId=zhengzhanshanhaiController:getZZSHCfg("bxBgModelId")or _defaultBgModelId
self.ruleLangId=zhengzhanshanhaiController:getZZSHCfg("boxRuleLangId")or _defaultRuleLangId


self:refresh(true)
end


function UIXM_ZZSH_TreasureBoxWin:onHide()
end



function UIXM_ZZSH_TreasureBoxWin:sortData(cfg)
table.sort(cfg,
function(a,b)
local weight_a=0
local weight_b=0

if a.avai<=0 then
weight_a=10
end
if b.avai<=0 then
weight_b=10
end
return(a.stage+weight_a)<(b.stage+weight_b)
end)
return cfg
end

function UIXM_ZZSH_TreasureBoxWin:refresh(isInit)
self:refreshPageGroup(isInit)


if self.isShowPageGroup then
local cfg=self.pageCfgList[self.selectPageIdx]
if cfg then
local bgModelId=cfg.bgModelId or _defaultBgModelId
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},eAnimationID.stand)
end
elseif isInit then
self.bgModel:setChildUIModelShowTarget(self.bgModelId,1,{},eAnimationID.stand)
end

self:refreshScroll()
end

function UIXM_ZZSH_TreasureBoxWin:refreshBtn(flag)
self.winlua:SetChildActive(self.allReceiveBtn:getID(),flag)
end


function UIXM_ZZSH_TreasureBoxWin:refreshScroll()
local isShowShLv=false
local pageShSeasonId
if self.isShowPageGroup then
local pageCfg=self.pageCfgList[self.selectPageIdx]
pageShSeasonId=pageCfg.shSeasonId
else
pageShSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
end

if pageShSeasonId==-1 then

self.config=zhengzhanshanhaiModel:getTreasureBoxData_initial()
else

self.config=zhengzhanshanhaiModel:getTreasureBoxData_season()
isShowShLv=true
end

self.shLevelBg:setActive(isShowShLv)
if isShowShLv then
local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 0
self.shLevelText:setText(FMT.fmt("当前宝匣阶级：{0}",shSeasonLv))
end

local isShowAllBtn=false
local count=#self.config
self.itemScrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.itemScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local cfg=self.config[i].cfg
local recv=self.config[i].recv

local showStage=cfg.showStage or 1
local idx=self.config[i].idx
local color=cfg.color

local colorkey
local coloruse
local isProbability
local isGray=false
local consume=cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local box_cost_id=consume[1]
local box_cost_name=cfgHelper.get2(cfg_moneyconfig_get,consume[1],'name')
local isCanOpenBox=recv<cfg.max or false
local isNotLimit=cfg.max>=9999
local canOpenBoxCount=cfg.max-recv
local isEnoughOpen=boxCount>=box_cost or false

if boxCount>0 then colorkey="#aae252"else colorkey="#f36666"end
if canOpenBoxCount>0 then coloruse="green"else coloruse="red"end
if canOpenBoxCount>0 and boxCount>0 then isGray=true end

if isCanOpenBox then
if isEnoughOpen then
isShowAllBtn=true
widget:SetChildActive(ItemIndex.reddot,true)
else
widget:SetChildActive(ItemIndex.reddot,false)
end
else
widget:SetChildActive(ItemIndex.reddot,false)
end

local textkey=FMT.fmt("<color={1}>{0}</color>",mathHelper.formatNumber4(boxCount),colorkey)
local textuse=isNotLimit and""or FMT.fmt("今日次数:<color={1}>{0}</color>",canOpenBoxCount,coloruse)


local isShowStage=false
widget:SetChildActive(ItemIndex.stageBg,isShowStage)
if isShowStage then
local stageStr=FMT.fmt("{0}阶",showStage)
widget:SetChildText(ItemIndex.stageText,stageStr)
end

widget:SetChildIcon(ItemIndex.cost_icon,iconHelper.getIconName(consume[1]),false)
widget:SetChildButtonClick(ItemIndex.cost_icon,function()tipsManager.showTips({itemid=box_cost_id})end)
widget:SetChildIcon(ItemIndex.icon,cfg.icon,false)
widget:SetChildText(ItemIndex.count_key,textkey)
widget:SetChildText(ItemIndex.count_use,textuse)

local nameIconName=cfg.boxNameIcon
if not nameIconName then
nameIconName="image_shanhaibaojiawz_"..color
end

widget:SetChildCSImageSprite(ItemIndex.name_img,abname,nameIconName)
widget:SetChildCSImageSprite(ItemIndex.bg_img,abname,"image_shanhaibaojiaui_"..color)
widget:SetChildImageExGray(ItemIndex.openBtn,not isGray)
widget:SetChildButtonClick(ItemIndex.openBtn,function(...)
self:clickOpenBox(idx,isCanOpenBox,isEnoughOpen,box_cost_id,box_cost_name)
end)
widget:SetChildButtonClick(ItemIndex.icon,function(...)
tipsManager.showTips({itemid=cfg.itemId})
end)
widget:SetChildButtonClick(ItemIndex.name_img,function(...)
tipsManager.showTips({itemid=cfg.itemId})
end)

local rewards=cfg.item
local itemGrids=widget:GetChildCommonLayoutGroupWidgetList(ItemIndex.reward_panel)
for i=1,itemGrids.Count do
local itemWidget=itemGrids[i-1]
local rewardData=rewards[i]
if rewardData then
itemWidget:SetChildActive(-1,true)
local itemid=rewardData[1]
local itemcount=rewardData[2]
if not itemcount then
itemcount=0
end
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local colorEffect=rewardData[3]and rewardData[3]==1 or false
isProbability=rewardData[4]and rewardData[4]==1 or false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetChildActive(2,isProbability)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
itemWidget:SetChildActive(-1,false)
itemWidget:SetChildActive(2,false)
end
end
end
self:refreshBtn(isShowAllBtn)
end

function UIXM_ZZSH_TreasureBoxWin:refreshPageGroup(isInit)

local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if isInit then
if shSeasonId==-1 then

self.isShowPageGroup=false
else

self.isShowPageGroup=zhengzhanshanhaiModel:isHasInitialBXCost()or false
end

if self.isShowPageGroup then

self.pageCfgList={}


local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
local name_initial=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,raceIndex,'name')
local initialCfg={
shSeasonId=-1,
name=name_initial,
bgModelId=_defaultBgModelId,
ruleLangId=_defaultRuleLangId,
}


local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 0
local name_season=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonLv,'name')
local bgModelId_season=self.bgModelId
local ruleLangId_season=self.ruleLangId
local seasonCfg={
shSeasonId=shSeasonId,
shSeasonLv=shSeasonLv,
name=name_season,
bgModelId=bgModelId_season,
ruleLangId=ruleLangId_season,
}

self.pageCfgList[1]=initialCfg
self.pageCfgList[2]=seasonCfg
end
end
self.pageGroup:setActive(self.isShowPageGroup)
if self.isShowPageGroup then
self.pageGroup:setChildLayoutGroupCreateItems(#self.pageCfgList,function(index)
local pageItem=self.pageGroup:getChildLayoutGroupGridItem(index-1)
local pageCfg=self.pageCfgList[index]
if pageCfg then
pageItem:SetChildActive(-1,true)


local isSelect=index==self.selectPageIdx
pageItem:SetChildActive(0,not isSelect)
pageItem:SetChildActive(1,isSelect)


pageItem:SetChildButtonClick(0,function(...)
return self:clickPageItem(index)
end)


local pageSeasonName=pageCfg.name
pageItem:SetChildText(2,pageSeasonName)

local pageSeasonId=pageCfg.shSeasonId


local reddot
if pageSeasonId==-1 then
reddot=zhengzhanshanhaiModel:isBXReddotout_initial()
else
reddot=zhengzhanshanhaiModel:isBXReddotout_season()
end
pageItem:SetChildActive(3,reddot)

else
pageItem:SetChildActive(-1,false)
end

end)
end

end

function UIXM_ZZSH_TreasureBoxWin:clickOpenBox(idx,isCanOpenBox,isEnoughOpen,box_cost_id,box_cost_name)
if not isEnoughOpen then
local text=FMT.fmt("{0}不足",box_cost_name)
UIManager.info(text)
gainControl:showGainWin(box_cost_id)
else
local isSeason=false
local pageShSeasonId
if self.isShowPageGroup then
local pageCfg=self.pageCfgList[self.selectPageIdx]
pageShSeasonId=pageCfg.shSeasonId
else
pageShSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
end

if pageShSeasonId>-1 then

isSeason=true
end
zhengzhanshanhaiController:reqOpenBaoXia(1,{{idx,1}},isCanOpenBox,isSeason)
end
end


function UIXM_ZZSH_TreasureBoxWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIXM_ZZSH_TreasureBoxWin:clickPageItem(index)
if index==self.selectPageIdx then
return
end

self.selectPageIdx=index

self.animObj:setChildCanvasGroupAlpha(0)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.animObj:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.animObj:getID(),2,0,3)
return self:refresh()
end





function UIXM_ZZSH_TreasureBoxWin:onHelpBtn()
local langId=_defaultRuleLangId
if self.isShowPageGroup then
local cfg=self.pageCfgList[self.selectPageIdx]
if cfg then
langId=cfg.ruleLangId or _defaultRuleLangId
end
else
langId=self.ruleLangId
end

UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=langId})
end


function UIXM_ZZSH_TreasureBoxWin:onCliskMask()
self:onCloseBtn()
end


function UIXM_ZZSH_TreasureBoxWin:onCloseBtn()
self:closeSelf()
end


function UIXM_ZZSH_TreasureBoxWin:onAllReceiveBtn()
local temp
local allList={}

for k,v in ipairs(self.config)do
if v.recv<v.cfg.max then
local consume=v.cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local canOpenBoxCount=v.cfg.max-v.recv

if canOpenBoxCount<0 then canOpenBoxCount=0 end
local isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false

if canOpenBoxCount>0 and not isEnoughOpen and boxCount>=box_cost then
canOpenBoxCount=math.floor(boxCount/box_cost)
isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false
end

if isEnoughOpen then
temp={v.idx,canOpenBoxCount}
table.insert(allList,temp)
end
end
end

local isSeason=false
local pageShSeasonId
if self.isShowPageGroup then
local pageCfg=self.pageCfgList[self.selectPageIdx]
pageShSeasonId=pageCfg.shSeasonId
else
pageShSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
end

if pageShSeasonId>-1 then

isSeason=true
end
zhengzhanshanhaiController:reqOpenBaoXia(#allList,allList,true,isSeason)
end

function UIXM_ZZSH_TreasureBoxWin:onLevelHelpBtn()

local pageShSeasonLv
if self.isShowPageGroup then
local pageCfg=self.pageCfgList[self.selectPageIdx]
pageShSeasonLv=pageCfg.shSeasonLv
else
pageShSeasonLv=zhengzhanshanhaiModel:getSeasonLv()
end
local d={}
local langId=zhengzhanshanhaiController:getZZSHCfg("boxLvTipsLangId")or""
d.mode=3
d.title=FMT.fmt("当前宝匣阶级：{0}",pageShSeasonLv)
d.name=langId
d.posItem=self.levelHelpBtn
d.pos=Vector2.New(0,35)
d.posType=3
self:showWindow('UIDescribeTips8',d)
end


function UIXM_ZZSH_TreasureBoxWin:onDoTweenAnimStart()
self.animObj:setChildAnchoredPos(162+50,41)
end


function UIXM_ZZSH_TreasureBoxWin:testFunc_doTweenStart()
self.winlua:SetChildDOTweenAnimation_DOPlay(self.animObj:getID(),'1',0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.animObj:getID(),'2',0,3)
end








def_class("UIDuJieZhiBaoMainWin",UIWindowBase)









function UIDuJieZhiBaoMainWin:bindComponents()

self.title=UIText.get(self,0)
self.jzicon=UIObject.get(self,1)
self.destext=UIText.get(self,2)
self.jzdesc=UIText.get(self,3)
self.descpanel=UIObject.get(self,4)
self.tipsbtn=UIButton.get(self,5)
self.lianhuapanel=UIObject.get(self,6)
self.jdupanel=UIObject.get(self,7)
self.lhpanel=UIObject.get(self,8)
self.lockpanel=UIObject.get(self,9)
self.jdtxt=UIText.get(self,10)
self.bxbtn=UIButton.get(self,11)
self.proSkillInfo=UIObject.get(self,12)
self.proName=UIText.get(self,13)
self.proExpProgressbar=UIProgressBarAni.get(self,14)
self.proAddExp=UIProgressBarAni.get(self,15)
self.progressText=UIText.get(self,16)
self.iconbtn=UIButton.get(self,17)
self.zstxt=UIText.get(self,18)
self.zsicon=UIObject.get(self,19)
self.userbtn=UIButton.get(self,20)
self.locktxt=UIText.get(self,21)
self.leftArrow=UIButton.get(self,22)
self.leftArrowImg=UIObject.get(self,23)
self.rightArrow=UIButton.get(self,24)
self.rightArrowImg=UIObject.get(self,25)
self.itemtxt=UIObject.get(self,26)
self.itemtxt2=UIObject.get(self,27)
self.itemtxt3=UIObject.get(self,28)
self.dazaopanel=UIObject.get(self,29)
self.jdtxt2=UIText.get(self,30)
self.bxbtn2=UIButton.get(self,31)
self.rewardGrid=UIObject.get(self,32)
self.dazaobtn=UIButton.get(self,33)
self.item1=UIBaseItem.get(self,34)
self.item2=UIBaseItem.get(self,35)
self.item3=UIBaseItem.get(self,36)
self.item4=UIBaseItem.get(self,37)
self.item5=UIBaseItem.get(self,38)
self.selectPanel=UIObject.get(self,39)
self.Dropdown1=UIDropdownEx.get(self,40)
self.Dropdown2=UIDropdownEx.get(self,41)
self.ScrollView=UIScrollViewSlow.get(self,42)
self.Content=UIObject.get(self,43)
self.closeBtn=UIButton.get(self,44)
self.btnOnekey=UIButton.get(self,45)
self.btnReset=UIButton.get(self,46)
self.finishbtn=UIButton.get(self,47)
self.selectBg=UIButton.get(self,48)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.bxbtn:setButtonClick(function()self:onBxbtn()end)

self.iconbtn:setButtonClick(function()self:onIconbtn()end)

self.userbtn:setButtonClick(function()self:onUserbtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.bxbtn2:setButtonClick(function()self:onBxbtn2()end)

self.dazaobtn:setButtonClick(function()self:onDazaobtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.btnOnekey:setButtonClick(function()self:onBtnOnekey()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.finishbtn:setButtonClick(function()self:onFinishbtn()end)

self.selectBg:setButtonClick(function()self:onSelectBg()end)



end


function UIDuJieZhiBaoMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.jzicon);self.jzicon=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.jzdesc);self.jzdesc=nil;
_UIObject_release(self.descpanel);self.descpanel=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.lianhuapanel);self.lianhuapanel=nil;
_UIObject_release(self.jdupanel);self.jdupanel=nil;
_UIObject_release(self.lhpanel);self.lhpanel=nil;
_UIObject_release(self.lockpanel);self.lockpanel=nil;
_UIObject_release(self.jdtxt);self.jdtxt=nil;
_UIObject_release(self.bxbtn);self.bxbtn=nil;
_UIObject_release(self.proSkillInfo);self.proSkillInfo=nil;
_UIObject_release(self.proName);self.proName=nil;
_UIObject_release(self.proExpProgressbar);self.proExpProgressbar=nil;
_UIObject_release(self.proAddExp);self.proAddExp=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.iconbtn);self.iconbtn=nil;
_UIObject_release(self.zstxt);self.zstxt=nil;
_UIObject_release(self.zsicon);self.zsicon=nil;
_UIObject_release(self.userbtn);self.userbtn=nil;
_UIObject_release(self.locktxt);self.locktxt=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.itemtxt);self.itemtxt=nil;
_UIObject_release(self.itemtxt2);self.itemtxt2=nil;
_UIObject_release(self.itemtxt3);self.itemtxt3=nil;
_UIObject_release(self.dazaopanel);self.dazaopanel=nil;
_UIObject_release(self.jdtxt2);self.jdtxt2=nil;
_UIObject_release(self.bxbtn2);self.bxbtn2=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.dazaobtn);self.dazaobtn=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.btnOnekey);self.btnOnekey=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.finishbtn);self.finishbtn=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
end
















local _this
local buildstate=
{
weidoing=0,
doing=1,
finish=2
}
local _costid=10
local alldjjz={82,83,84,85,86}
local allelement=
{
[82]=1,
[83]=3,
[84]=2,
[85]=4,
[86]=5,
}
local _colomn=4
local _row=6
local _bag_filter_val={}
local _bag_filter_desc={}
local _dropItemHeight=40
local _dropViewHeight=150

local _equipIdxArray={1,6,2,3,4,5,7}
local _materialIdxArray={1,2,3,4,5}
local _equipIdxOneKeyArray={1,6,2,3,4,5}
local _materialIdxOneKeyArray={1,2,3,4,5}




function UIDuJieZhiBaoMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.ScrollView:setSlowClickAction(nil)
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)

self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(1,...)end)

self.allZhenWudata={}
self.itemtxtarry={self.itemtxt,self.itemtxt2,self.itemtxt3}

local itemsList={}
itemsList={self.item1,self.item2,self.item3,self.item4,self.item5}
self.itemsList=itemsList
for _,v in ipairs(itemsList)do
v:setBaseItemClickEvent(function(...)
if not self.isClose then
self:onSelectItemClick(...)
end
end)
end


local list=table.toTable(1,5)
self.nomalStageVal=list
self.nomalStageDesc=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}阶以下',stage)
end)
self.jingcaiStageDesc={'1阶以下'}
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=self.nomalStageDesc

self.filter={}
self.filter[ITEM_FILTER_TYPE.eElement]=0
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.filter[ITEM_FILTER_TYPE.eColor]=0
self.noweStage=0
self.nowelement=1
self.selectBagType=BAG_TYPE.eMaterialsBag
self.selectList={}
self.selectNumList={}
self.showAttrPanel=false
self.lianzhiType=FABAO_LIANZHI_TYPE.eNomal

self.selectBg:setActive(false)
self.unlockItem={}
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.curPageIndex=1
self.isSetZero=false
self.selectItemguid=nil
self.selectItemguidIdx=nil
self.isSelectGrid=nil
self.funcFilter=0

end


function UIDuJieZhiBaoMainWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDuJieZhiBaoMainWin:onShow(argtable,afterOnloaded)
self.sfId=zongmenModel:getMountainId()
self.model=argtable[1]
self.data=argtable[2]
local buildid=self.data.id
self._buildid=buildid
self.nowelement=allelement[buildid]or 1
self:refreshlefticon(buildid)
self:refreshjzData()
self:refresh(buildid,true,false)
end


function UIDuJieZhiBaoMainWin:onHide()

end
function UIDuJieZhiBaoMainWin:onRepairBtn()
end
function UIDuJieZhiBaoMainWin:onGotoBtn()
end
function UIDuJieZhiBaoMainWin:onClickClose()
self:closeSelf()
tipsManager.closeTips()
end

function UIDuJieZhiBaoMainWin:onBxbtn()
UIManager.info("显示阶段奖励")
tipsManager.closeTips()
end
function UIDuJieZhiBaoMainWin:onBxbtn2()
UIManager.info("显示阶段奖励")
tipsManager.closeTips()
end


function UIDuJieZhiBaoMainWin:onTipsbtn()
tipsManager.closeTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='feishengtai_repair_rule_%d'
d.closeCB=function()
end
UIManager:showWindow('UIRuleWin',d)
end


function UIDuJieZhiBaoMainWin:refresh(buildid,init,playAnim)
local djcfg=cfg_dujietreasuresconfig_get(buildid)
local allcfg=cfg_dujietreasuresbasicconfig_get(1)

local jiachengdesc=djcfg.jiachengdesc
if jiachengdesc then
for k,v in ipairs(self.itemtxtarry)do
if jiachengdesc[k]then
self.itemtxtarry[k]:setActive(true)
local widget=self.itemtxtarry[k]:getWidgetBase()
widget:SetChildText(0,jiachengdesc[k])
else
self.itemtxtarry[k]:setActive(false)
end
end
end


local thisbuilddata=nil
for k,v in ipairs(self.allZhenWudata)do
if v.jzid==buildid then
thisbuilddata=v
end
end

local DuJiedata=DuJieZhiBaoModel:getDJZBData()

self.jdupanel:setActive(false)
self.lhpanel:setActive(false)
self.lockpanel:setActive(false)
self.dazaopanel:setActive(false)
self.rewardGrid:setActive(false)
self.dazaobtn:setActive(false)
self.finishbtn:setActive(false)

local pass,tips=zongmenControl:checkBuildingPassRepairCondition(buildid)
if not pass then

self.jdupanel:setActive(true)
self.lhpanel:setActive(false)
self.lockpanel:setActive(true)
self.dazaopanel:setActive(false)
self.locktxt:setText(tips or"")

local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修建阶段:<color=#c82c2c> 0/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)
local refine_rate=allcfg.refine_rate[1]
local jindstr=FMT.fmt('0/{0}',refine_rate)
self.progressText:setText(jindstr)
self.proAddExp:animateThreeParams(0,1,0)
self.proExpProgressbar:animateThreeParams(0,1,0)
else


local stage=thisbuilddata.stage


if stage==buildstate.weidoing then
self:showpanel(buildid,1,init)
elseif stage==buildstate.doing then
if thisbuilddata.jzdata.flag then
if thisbuilddata.jzdata.flag==11 or thisbuilddata.jzdata.flag==12 then
self:showpanel(buildid,1,init)
elseif thisbuilddata.jzdata.flag==21 or thisbuilddata.jzdata.flag==22 then
self:showpanel(buildid,2,init)
end
end
end
end
self:checkAndShowArrowBtn()
end

function UIDuJieZhiBaoMainWin:showpanel(buildid,flag,init)

self.jinduflag=flag
local djcfg=cfg_dujietreasuresconfig_get(buildid)
local allcfg=cfg_dujietreasuresbasicconfig_get(1)

local thisbuilddata=nil
for k,v in ipairs(self.allZhenWudata)do
if v.jzid==buildid then
thisbuilddata=v
end
end
local DuJiedata=DuJieZhiBaoModel:getDJZBData()

if flag==1 then

local refine_rate=allcfg.refine_rate[1]
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end
if now_rate>=refine_rate then


self.jdupanel:setActive(false)
self.lhpanel:setActive(false)
self.lockpanel:setActive(false)
self.dazaopanel:setActive(true)


local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修建阶段:<color=#c82c2c> 1/{0}</color>',max_stage)
self.jdtxt2:setText(jduanstr)

local _stage=thisbuilddata.stage
if _stage==buildstate.doing then
if thisbuilddata.jzdata.flag==11 then

self.dazaobtn:setActive(true)
self.finishbtn:setActive(false)

elseif thisbuilddata.jzdata.flag==12 then

self.dazaobtn:setActive(false)
self.finishbtn:setActive(true)
end
elseif _stage==buildstate.weidoing then
self:refreshdazaoinfo(buildid,1)
end
else

self.jdupanel:setActive(true)
self.lhpanel:setActive(true)
self.lockpanel:setActive(false)
self.dazaopanel:setActive(false)

local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修建阶段:<color=#c82c2c> 0/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)

self:refreshnowjindu(now_rate,refine_rate,init,true)

self:lhcostnum(0)

self:setDropdowns()
self:setSelectItems()
end

elseif flag==2 then

local refine_rate=allcfg.refine_rate[2]
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end
if now_rate>=refine_rate then


self.jdupanel:setActive(false)
self.lhpanel:setActive(false)
self.lockpanel:setActive(false)
self.dazaopanel:setActive(true)


local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修建阶段:<color=#c82c2c> 2/{0}</color>',max_stage)
self.jdtxt2:setText(jduanstr)

local _stage=thisbuilddata.stage
if _stage==buildstate.doing then
if thisbuilddata.jzdata.flag==12 then

self.dazaobtn:setActive(true)
self.finishbtn:setActive(false)

elseif thisbuilddata.jzdata.flag==22 then

self.dazaobtn:setActive(false)
self.finishbtn:setActive(true)
end
elseif _stage==buildstate.weidoing then
self:refreshdazaoinfo(buildid,2)
end
else

self.jdupanel:setActive(true)
self.lhpanel:setActive(true)
self.lockpanel:setActive(false)
self.dazaopanel:setActive(false)

local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修建阶段:<color=#c82c2c> 1/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)

self:refreshnowjindu(now_rate,refine_rate,init,true)

self:lhcostnum(0)

self:setDropdowns()
self:setSelectItems()
end
end
end

function UIDuJieZhiBaoMainWin:refreshnowjindu(ltexp,nxltexp,init,reverse)
local curexp=ltexp
local maxexp=nxltexp
local allAddValue=self:getjd()

if init then
self.proAddExp:animateThreeParams(curexp+allAddValue,maxexp,0)
self.proExpProgressbar:animateThreeParams(curexp,maxexp,0)
else
if reverse then
self.proAddExp:animateFourParams(curexp+allAddValue,maxexp,0.5,reverse)
else
self:useHideAddProgress(curexp,maxexp,allAddValue)
end
self.proExpProgressbar:animateFourParams(curexp,maxexp,0.5,reverse)
end

local progressStr=''
if curexp>=maxexp then
progressStr=FMT.fmt('{0}/{1}',maxexp,maxexp)
else
if allAddValue>0 then
progressStr=FMT.fmt('{0}<color=#8bf341>（+{1}）</color>/{2}',curexp,allAddValue,maxexp)
else
progressStr=FMT.fmt('{0}/{1}',curexp,maxexp)
end
end
self.progressText:setText(progressStr)
end


function UIDuJieZhiBaoMainWin:lhcostnum(costnum)
local str=""
local needcount=0
if moneyConfig.isMoney(_costid)then
needcount=moneyModel.getMoney(_costid)
end
if needcount<costnum then
str=FMT.fmt('<color=#c82c2c>{0}</color>',costnum)
else
str=tostring(costnum)
end
self.zstxt:setText(str)
end

function UIDuJieZhiBaoMainWin:refreshdazaoinfo(buildid,jieduan)
self.rewardGrid:setActive(true)
self.dazaobtn:setActive(true)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local rewards=cfg.repair_cost[jieduan]
if rewards and#rewards>0 then
local len=#rewards
self.rewardGrid:setChildLayoutGroupCreateItems(len)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,len do
local rewardItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount=""
local needcount=0
local graynum=false
if moneyConfig.isMoney(itemid)then
needcount=moneyModel.getMoney(itemid)
else
needcount=bagModel.getItemCountById(itemid)
end
if itemnum>=needcount then
itemcount=FMT.fmt('{0}/{1}',needcount,itemnum)
else
itemcount=FMT.fmt('<color=#c82c2c>{0}/{1}</color>',needcount,itemnum)
graynum=true
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end


function UIDuJieZhiBaoMainWin:refreshlefticon(id)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
self.title:setText(cfg.name)
self.destext:setText(levelCfg.build_desc)
local repairModel=self:getRepairModel(cfg)
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.jzicon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.stand)
end
function UIDuJieZhiBaoMainWin:getRepairModel(cfg)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[1]
end


function UIDuJieZhiBaoMainWin:refreshjzData()

local templist={}
for k,v in ipairs(alldjjz)do
local temp=
{
stage=0,
jzid=v,
jzdata=nil
}
templist[v]=temp
end

local bdDatas=zongmenModel:getAllBuildingData(self.sfId)
for k,v in pairs(bdDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.build_type==82 or cfg.build_type==83 or cfg.build_type==84 or cfg.build_type==85 or cfg.build_type==86 then
if v.flag>10 then
local temp=
{
stage=1,
jzid=cfg.build_type,
jzdata=v
}
templist[cfg.build_type]=temp
end
end
end

for k,v in pairs(templist)do
local _stage=v.stage
local _jzid=v.jzid
if _stage==buildstate.weidoing then
local _data=isometricMapSystem:getRepairDataByID(self.sfId,_jzid)
local temp=
{
stage=0,
jzid=_jzid,
jzdata=_data
}
templist[k]=temp
end
end

local list={}
for k,v in pairs(templist)do
table.insert(list,v)
end
table.sort(list,function(a,b)
return a.jzid<b.jzid
end)
self.allZhenWudata=list


end


function UIDuJieZhiBaoMainWin:checkAndShowArrowBtn()
local list=self.allZhenWudata or{}
local len=#list
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


function UIDuJieZhiBaoMainWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end



function UIDuJieZhiBaoMainWin:onCloseBtn()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end


function UIDuJieZhiBaoMainWin:onSelectItemClick(itemid,index,itemguid,attach)

local lastIndex=self.lastSelectIndex
if lastIndex and lastIndex==index and UIManager:isActive('UITipsWin',true)then
return
end
self.lastSelectIndex=index
local hasItem=itemid~=nil and itemid>0

local isEquip=hasItem and itemsConfig.isEquip(itemid)or false
local selectBagType=isEquip and BAG_TYPE.eEquipBag or BAG_TYPE.eMaterialsBag
local changeSelectBag=selectBagType~=self.selectBagType
self.selectBagType=selectBagType



if changeSelectBag or not self.showDialogue then
self.ScrollView:clearSlowItems()
self:showProvideSelectGrids()
end

if hasItem then
local isMakeByEquip=false
local isMain=false
tipsManager.showTips({formType=TIPS_FORM_TYPE.eOffFeiShengTaiMaterial,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,isMain=isMain,isMakeByEquip=isMakeByEquip},
move=TIPS_MOVE_POS.eCenter})

self:onSelectOneGrid(itemguid,false,index)
end
end


function UIDuJieZhiBaoMainWin:onSelectOneGrid(itemguid,isBagGrid,index)
local lastSelectGrid=self.isSelectGrid
self.isSelectGrid=isBagGrid
local lastItemguid=self.selectItemguid
self.selectItemguid=itemguid
local lastSelectIndex=self.selectItemguidIdx
self.selectItemguidIdx=index

if itemguid==nil or isBagGrid==nil or index==nil then
loggerUtil.logErrFMT('传入参数有问题：itemguid：{0} isBagGrid：{1} index：{2}',itemguid,isBagGrid,index)
return
end
if lastSelectGrid==isBagGrid and tostring(lastItemguid)==tostring(itemguid)and lastSelectIndex==index then
return
end

if lastItemguid then
if lastSelectGrid then
self:freshProvideGridSelect(lastItemguid)
elseif lastSelectGrid==false then
if lastSelectIndex then
local _lastItemguid=self.selectList[lastSelectIndex]
if lastItemguid and tostring(_lastItemguid)==tostring(lastItemguid)then
self:freshOneSelectItemSelectBg(lastSelectIndex)
else
self:closeAllSelectItemSelectBg()
end
else
self:closeAllSelectItemSelectBg()
end
end
end
if isBagGrid then
self:freshProvideGridSelect(itemguid)
elseif isBagGrid==false then
if index then
self:freshOneSelectItemSelectBg(index)
else
loggerUtil.logErrFMT('传入选中序号为空')
end
end
end


function UIDuJieZhiBaoMainWin:freshProvideGridSelect(itemguid)
local idx=self:getBagItemIdx(itemguid)

if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true)
else
loggerUtil.logErrFMT('没找到序号的widget：{0}',tostring(itemguid))
end
end
end


function UIDuJieZhiBaoMainWin:onClickGridButton(index,itemid,itemguid,selectIndex,isdeletall)
if itemid==-1 then return end
local num=self:getSelectItemNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
tipsManager.closeTips()
local selectIdx=selectIndex or self:getSelectIndex(itemguid)
local isMainItem=self:isMainHole(selectIdx)
local deleteNum=1
if isdeletall then
if self.selectNumList and self.selectNumList[selectIdx]then
deleteNum=self.selectNumList[selectIdx]
end
end
local isFzHole=self:isFzHole(selectIdx)
if isMainItem then
deleteNum=num
elseif isFzHole then
deleteNum=self:getPutNum(selectIdx)
end

self:deleteSelectNum(selectIdx,deleteNum)
num=num-deleteNum
if self:isMainHole(selectIdx)then
if num<=0 or self:getPutNum(selectIdx)<=0 then
self.selectList={}
self.selectNumList={}
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
else
self:freshProvideSelectSingleItemNum(itemguid)
end
else
local onlyHasMainItem=false
local flag=false
if onlyHasMainItem then
flag=self.ScrollView:freshAllItems()
end
if not flag then
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSelectSingleItemNum(itemguid)
end
end
self:setSelectItems()



end


function UIDuJieZhiBaoMainWin:closeAllSelectItemSelectBg()
for i,v in ipairs(self.itemsList)do
local widget=v:getWidgetBase()
widget:SetChildActive(1,false)
end
end

function UIDuJieZhiBaoMainWin:freshOneSelectItemSelectBg(idx)
local slot=self.itemsList[idx]
local itemguid=self.selectList[idx]
local widget=slot:getWidgetBase()
widget:SetChildActive(1,self.isSelectGrid==false and
tostring(self.selectItemguid)==tostring(itemguid)and
self.selectItemguidIdx==idx)
end


function UIDuJieZhiBaoMainWin:showProvideSelectGrids()
if self.showDialogue then
self:freshProvideSelectGrids(true)
return
end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshProvideSelectGrids(true)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UIDuJieZhiBaoMainWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
self.curPageIndex=1
self.isSetZero=false
self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end


function UIDuJieZhiBaoMainWin:onDropdownChange(dropIdx,reIdx)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local len=#_bag_filter_desc[typo]
local idx=len-1-reIdx
if self.filter[typo]==idx then return end
self.curPageIndex=1
self.isSetZero=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end

self.filter[typo]=idx
self.noweStage=idx

self:freshProvideSelectGrids(true)
tipsManager.closeTips()
end
function UIDuJieZhiBaoMainWin:onDropdownCreate(dropIdx,scrollTrans,contentTrans)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local filterType=typo
local idx=self.filter[filterType]or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIDuJieZhiBaoMainWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIDuJieZhiBaoMainWin:freshProvideSelectSingleItemNum(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local itemcount=num>0 and FMT.fmt('{0}/{1}',num,item.itemcount)or item.itemcount
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildText(4,itemcount)
end
end
end
function UIDuJieZhiBaoMainWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i
end
end
end

function UIDuJieZhiBaoMainWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
end
end
end


function UIDuJieZhiBaoMainWin:freshBagList()
local hasMain=false
local filter={}






















local stage=0
local element=1
if self.noweStage then
stage=self.noweStage
end
if stage>4 then
stage=4
end
if self.nowelement then
element=self.nowelement
end
filter={
[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eEquals]={stage+1}},
[ITEM_FILTER_TYPE.eElement]={[ITEM_FILTER_COMPARE.eEquals]={element}}
}


if self.funcFilter>0 then
filter[ITEM_FILTER_TYPE.eFaBaoMaterialsFuncType]={ITEM_FILTER_COMPARE.eEquals,self.funcFilter}
end

local sortFunc=function(items)
if items and#items>1 then
table.sort(items,function(a,b)
local aUseFlag=not self:isLock(a.itemid)and 1 or 0
local bUseFlag=not self:isLock(b.itemid)and 1 or 0
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
local aneedNum=self:getNeedNumByMainHole(a.itemid)
local agray=not hasMain and aneedNum>a.itemcount or false
local bneedNum=self:getNeedNumByMainHole(a.itemid)
local bgray=not hasMain and bneedNum>b.itemcount or false
local agrayNum=agray and 0 or 1
local bgrayNum=bgray and 0 or 1
if aUseFlag~=bUseFlag then
return aUseFlag>bUseFlag
elseif agrayNum~=bgrayNum then
return agrayNum>bgrayNum
elseif aConfig.stage~=bConfig.stage then
return aConfig.stage>bConfig.stage
elseif aConfig.color~=bConfig.color then
return aConfig.color>bConfig.color
elseif a.itemid~=b.itemid then
return-a.itemid>-b.itemid
else
return true
end
end)
end
end
local _bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)

local bagList={}
if _bagList then
for k,v in ipairs(_bagList)do
local config=itemsConfig.getConfig(v.itemid)
if config.element then
table.insert(bagList,v)
end
end
end
local sortTag={}
for i,v in ipairs(bagList)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local isLock=self:isLock(itemid)
local useFlag=not isLock and 1 or 0
local itemCfg=itemsConfig.getConfig(itemid)

local stageUseFlag=useFlag*itemCfg.stage
if hasMain then
stageUseFlag=itemCfg.stage
end
local needNum=0
local gray=not hasMain and(isLock or needNum>v.itemcount)or false
local grayNum=gray and 0 or 1
if gray then
stageUseFlag=0
end
sortTag[itemguidStr]=stageUseFlag*9999999+grayNum*999999+(100-itemCfg.stage)*999+itemid/1000
end
table.sort(bagList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
local list={}
local lookup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
if not lookup[tostring(item.itemguid)]and self:isPutAnyHoleByGUID(item.itemguid)then
list[#list+1]=item
lookup[tostring(item.itemguid)]=true
table.remove(bagList,i)
end
end
for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end

self.bagList=bagList

end

function UIDuJieZhiBaoMainWin:isLock(itemid)
return false
end

function UIDuJieZhiBaoMainWin:isPutAnyHoleByGUID(itemguid)
return false
end


function UIDuJieZhiBaoMainWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
local hasPutMainItem=true
local inGray=not hasPutMainItem or false
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectItemNum(itemguid)
local has=num>0
local itemTxt=num>0 and FMT.fmt('{0}/{1}',num,itemInfo.itemcount)or itemInfo.itemcount>1 and itemInfo.itemcount or''
local showbg=true
local islock=not hasPutMainItem and self:isLock(itemid)or false
local showStage=itemConfig.stage~=nil
local needNum=0
local isGray=needNum>itemcount and inGray or islock or false
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true

widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildImageExGray(2,isGray)
widget:SetChildIcon(3,iconName,false)
widget:SetChildImageExGray(3,isGray)
widget:SetChildText(4,itemTxt)
widget:SetChildActive(5,itemTxt~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,islock)
widget:SetChildActive(10,has)
widget:SetChildButtonClick(10,function()self:onClickGridButton(index,itemid,itemguid)end,true)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(itemid,index,itemguid,nil)
end)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(-1,index,-1,nil)
end)
end
end


function UIDuJieZhiBaoMainWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
local comCfg=fabaoConfig.getCommonConfig()
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local isEquip=itemsConfig.isEquip(itemid)
local refstage=stage
if isEquip then
refstage=comCfg.stage[stage]or nil
end

local hasMain=self:hasPutMainItem()

if refstage and not hasMain then
local systemLimit=comCfg.system
local sysid=systemLimit[refstage]
if sysid then
local isOpen=systemModel.isOpen(sysid)
if not isOpen then
local tips=systemModel.getOpenTips(sysid)
UIManager.info(tips)
return
end
end
end

local item=bagModel.getItem(itemguid)
local num=item.itemcount
local hasPut=self:getSelectItemNum(itemguid)
num=num-hasPut
local needNum=self:getLeftPutNum(itemguid,index)

local maxNum=needNum
if needNum>num then
maxNum=num
end
maxNum=math.min(num,maxNum)

if maxNum<=0 then
UIManager:error("无适合的炼化材料")
return
end
local selectNumCmpArgs={numFormat='放入：<color=#f1ce78>{0}/{1}</color>',
min=1,max=maxNum,val=maxNum}

local isMain=false

tipsManager.showTips({formType=TIPS_FORM_TYPE.ePutFeiShengTaiMaterial,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,
selectNumCmpArgs=selectNumCmpArgs,
isMain=isMain,
isMakeByEquip=false},
move=TIPS_MOVE_POS.eCenter})

self:onSelectOneGrid(itemguid,true,index)
end


function UIDuJieZhiBaoMainWin:getLeftPutNum(itemguid,holeIdx)
local needNum=self:getNeedNumByGUID(nil,itemguid,holeIdx)
return needNum or 0
end


function UIDuJieZhiBaoMainWin:getSelectItemNum(itemguid)
if self.selectList==nil then self.selectList={}end
local handle=tostring(itemguid)
local num=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
if tostring(self.selectList[i])==handle then
num=num+self:getPutNum(i)
end
end
return num
end
function UIDuJieZhiBaoMainWin:getIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxArray
else
array=_materialIdxArray
end
return array
end
function UIDuJieZhiBaoMainWin:getOneKeyIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxOneKeyArray
else
array=_materialIdxOneKeyArray
end
return array
end
function UIDuJieZhiBaoMainWin:isMakeByEquip()
return false
end
function UIDuJieZhiBaoMainWin:getPutNum(idx)
return self.selectNumList[idx]or 0
end
function UIDuJieZhiBaoMainWin:deletePutNum(idx,num)
local num1=self:getPutNum(idx)-num
if num1<=0 then num1=0 end
self.selectNumList[idx]=num1
end
function UIDuJieZhiBaoMainWin:deleteSelectNum(index,num)

self:deletePutNum(index,num)
if self:getPutNum(index)<=0 then
self.selectList[index]=nil
end
end
function UIDuJieZhiBaoMainWin:getSelectIndex(itemguid)
if self.selectList==nil then self.selectList={}end
local array=self:getIdxArray()
local len=#array
for i=len,1,-1 do
local index=array[i]
if tostring(self.selectList[index])==tostring(itemguid)then
return index
end
end
end
function UIDuJieZhiBaoMainWin:isMainHole(idx)
return false
end
function UIDuJieZhiBaoMainWin:isFzHole(idx)
return false
end
function UIDuJieZhiBaoMainWin:isJHIdxHole(idx)
return false
end
function UIDuJieZhiBaoMainWin:hasPutMainItem()
return true
end
function UIDuJieZhiBaoMainWin:getMainGUID()
return nil
end


function UIDuJieZhiBaoMainWin:setDropdowns()
local isMaterilas=self.selectBagType==BAG_TYPE.eMaterialsBag
self.Dropdown1:setActive(true)
local filterType=ITEM_FILTER_TYPE.eStage
local descList=_bag_filter_desc[filterType]
local descCopyList=table.deepCopy(descList)
local options=table.reverse(descCopyList)
self.Dropdown1:setOption(options)
local len=#descList
local idx=self.filter[filterType]or 0
local reIdx=len-1-idx
self.Dropdown1:setValue(reIdx)












end


function UIDuJieZhiBaoMainWin:setSelectItems()

local isNotSelectGrid=self.isSelectGrid==false
local hasSelect=false
































local itemsList=self.itemsList
if self.selectList==nil then self.selectList={}end

for i,v in ipairs(itemsList)do
if not self:isMainHole(i)then
local itemguid=self.selectList[i]
local item=itemguid and bagModel.getItem(itemguid)or nil
local isSelect=itemguid and self.isSelectGrid==false and tostring(self.selectItemguid)==tostring(itemguid)and self.selectItemguidIdx==i or false
hasSelect=isSelect or hasSelect

local itemcount=''
local hasNum=self:getPutNum(i)

if hasNum>1 and item then

itemcount=hasNum
end
local conf={showname=false,itemcount=itemcount,showCountBG=itemcount~='',select=isSelect}
v:setChildPropData(self:getSelectFillData(i,item,conf))
end
end







if isNotSelectGrid and not hasSelect then
self.selectItemguidIdx=nil
self.selectItemguid=nil
end


self:refreshjdandzs()
end

function UIDuJieZhiBaoMainWin:getNeedNumByGUID(mainguid,guid,fillIdx)
local _guid=self.selectList[fillIdx]
if _guid and tostring(guid)~=tostring(guid)then return end
local num=self:getMaxNumByItemguid(guid)
return num
end
function UIDuJieZhiBaoMainWin:getSelectFillData(index,item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData(index)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
end
prop[DataPropKey.eItemIndex]=index
return prop
end
function UIDuJieZhiBaoMainWin:getSelectTempFillData(index)
local conf={}
conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end

function UIDuJieZhiBaoMainWin:freshAllItems()
if self.selectBagType~=BAG_TYPE.eEquipBag then
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
return true
end
return false
end
function UIDuJieZhiBaoMainWin:hasPutAny()
local array=self:getIdxArray()
for _,i in ipairs(array)do
if self:getPutNum(i)>0 then
return true
end
end
return false
end

function UIDuJieZhiBaoMainWin:onBtnReset()
if self:hasPutAny()then
for _,itemguid in pairs(self.selectList)do
self:freshProvideSelectSingleGirid(itemguid,false)
self:freshProvideSelectSingleItemNum(itemguid)
end
self.selectList={}
self.selectNumList={}
self.lastSelectIndex=nil
self:setSelectItems()



self:freshAllItems()

tipsManager.closeTips()
end
end


function UIDuJieZhiBaoMainWin:onBtnOnekey()
local isChange=false
local mainguid=self:getMainGUID()
local moniSelectList={}
local moniSelectNumList={}
local array=self:getIdxArray()
for _,i in ipairs(array)do
moniSelectList[i]=self.selectList[i]
moniSelectNumList[i]=self:getPutNum(i)
end


local _getSelectItemNum=function(itemguid)
local handle=tostring(itemguid)
local num=0
for _,i in ipairs(array)do
if tostring(moniSelectList[i])==handle then
num=num+(moniSelectNumList[i]or 0)
end
end
return num
end


local _getLeftNum=function(itemguid)
local num=_getSelectItemNum(itemguid)or 0
local item=bagModel.getItem(itemguid)
local itemcount=item.itemcount
return itemcount-num
end


local _getNextFillItemGuid=function(holeIdx)
local bagList=self.bagList or{}
for i,v in ipairs(bagList)do
local left=_getLeftNum(v.itemguid)
local needNum=self:getNeedNumByGUID(nil,v.itemguid,holeIdx)
local addNum=needNum
if needNum>left then
addNum=left
end
local fillNum=math.min(left,addNum)
if fillNum>0 then
return v.itemguid,left,i
end
end
end


local _getMainFillGuid=function()
local bagList=self.bagList or{}













return nil
end

local _addItem=function(index,itemguid,num)

local handle=tostring(itemguid)
local ishasidx=false
for _,i in ipairs(array)do
local guid=moniSelectList[i]
local guidStr=tostring(guid)
if guid~=nil and guidStr==handle then
ishasidx=i
break
end
end
if ishasidx then
moniSelectNumList[ishasidx]=moniSelectNumList[ishasidx]+num
else
moniSelectList[index]=itemguid
moniSelectNumList[index]=moniSelectNumList[index]+num
end
end

if mainguid==nil then
local itemguid=_getMainFillGuid()
if itemguid==nil then
UIManager.error('暂无一键放入的合适材料')
return
end
mainguid=itemguid
end
if mainguid==nil then
UIManager.error('暂无一键放入的合适材料')
return
end
local array=self:getOneKeyIdxArray()
for _,i in ipairs(array)do
local hasNum=moniSelectNumList[i]or 0
if self:isMainHole(i)then
local needNum=self:getNeedNumByGUID(nil,mainguid,i)
local canAddNum=needNum-hasNum
local leftNum=_getLeftNum(mainguid)
local fillNum=math.min(leftNum,canAddNum)
if fillNum>0 then
_addItem(i,mainguid,fillNum)
isChange=true
self:freshProvideSelectSingleItemNum(mainguid)
self:freshProvideSelectSingleGirid(mainguid,true)
end
else
local itemguid=moniSelectList[i]
if itemguid==nil then
local guid=_getNextFillItemGuid(i)
itemguid=guid
end
if itemguid then
local leftNum=_getLeftNum(itemguid)
local needNum=self:getNeedNumByGUID(nil,itemguid,i)

local addNum=needNum
if needNum>leftNum then
addNum=leftNum
end
local fillNum=math.min(leftNum,addNum)
_addItem(i,itemguid,fillNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:freshProvideSelectSingleGirid(itemguid,true)
isChange=true
end
end
end

if isChange then
self.lastSelectIndex=nil
for _,i in ipairs(array)do
self.selectList[i]=moniSelectList[i]
self:setPutNum(i,moniSelectNumList[i]or 0)
end

self:freshAllItems()
self:setSelectItems()


end
tipsManager.closeTips()
end


function UIDuJieZhiBaoMainWin:refreshjdandzs()
if self.jinduflag and self._buildid then
local flag=self.jinduflag
local buildid=self._buildid
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local refine_rate=allcfg.refine_rate[flag]
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end
self:refreshnowjindu(now_rate,refine_rate,false,true)
local num=self:getzscost()
self:lhcostnum(num)
end
end

function UIDuJieZhiBaoMainWin:getjd()
local cfg_refine_conf=cfg_dujietreasuresconfig_get(self._buildid).refine_conf
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf[1]
allnumjd=allnumjd+costnum*itemguid_num
end
end

return allnumjd
end

function UIDuJieZhiBaoMainWin:getzscost()
local cfg_refine_conf=cfg_dujietreasuresconfig_get(self._buildid).refine_conf
local allnumcost=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf[2]
allnumcost=allnumcost+costnum*itemguid_num
end
end

return allnumcost
end

function UIDuJieZhiBaoMainWin:getMaxNumByItemguid(guid)





local neednum=0
if self.jinduflag and self._buildid then
local flag=self.jinduflag
local buildid=self._buildid
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local now_rate=0
local refine_rate=allcfg.refine_rate[flag]
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end


local cfg_refine_conf=cfg_dujietreasuresconfig_get(self._buildid).refine_conf
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf[1]
allnumjd=allnumjd+costnum*itemguid_num
end
end
now_rate=now_rate+allnumjd


local chaeNum=refine_rate-now_rate
if chaeNum<=0 then
return 0
end


local this_item=bagModel.getItem(guid)
local this_itemid=this_item.itemid
local this_refine_conf=cfg_refine_conf[this_itemid]
local singlevalue=this_refine_conf[1]
neednum=math.ceil(chaeNum/singlevalue)
end
return neednum
end

function UIDuJieZhiBaoMainWin:getAllJinDu()

end



function UIDuJieZhiBaoMainWin:putItem(index,itemid,itemguid,fillnum)
if itemid==-1 then return end
local putFinish=itemid~=nil
local handle=tostring(itemguid)
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local lastHasMain=self:hasPutMainItem()
local itemcount=item.itemcount
if num>=itemcount then
UIManager.error('物品已达上限')
tipsManager.closeTips()
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
tipsManager.closeTips()
return
end
local lastFillNum=self:getPutNum(fillIdx)
local isMainHole=self:isMainHole(fillIdx)
local fillBagType=BAG_TYPE.eMaterialsBag
local isFzHole=self:isFzHole(fillIdx)
local isJhHole=self:isJHIdxHole(fillIdx)
local changeBagType=fillBagType~=self.selectBagType
if itemsConfig.isEquip(item.itemid)and not isMainHole then
UIManager.error('装备只能作为主材料')
return
end













local lastNum=num
local addNum=1
local curNum=num+addNum
if isMainHole or isFzHole or isJhHole then
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,fillIdx)
local leibie=isMainHole and'主材料'or
isFzHole or'副材料'or
'炼化材料'
if needNum and itemcount<needNum then
local itemName=itemsConfig.getConfig(itemid).name
UIManager.error(FMT.fmt('{0}数量不足以作为{3}({1}/{2})',itemName,itemcount,needNum,leibie))
gainControl:showGainWin(itemid)
return
end
addNum=needNum
curNum=addNum
else
addNum=fillnum
end
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end

self:addSelectHole(itemguid,fillIdx,addNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:setSelectItems()



tipsManager.closeTips()

local isMain=isMainHole and not lastHasMain





if changeBagType then
self:freshProvideGrids(fillBagType)
elseif not lastHasMain then

self.ScrollView:freshAllItems()
end
end

function UIDuJieZhiBaoMainWin:getNextFillIdx(itemguid,containsJh)
local handle=tostring(itemguid)
local array=self:getIdxArray()
for _,i in ipairs(array)do
local isJHIdxHole=self:isJHIdxHole(i)
if not isJHIdxHole or isJHIdxHole and containsJh then
local guid=self.selectList[i]
if guid==nil or tostring(guid)==handle and not self:isfull(i)then
return i
end
end
end
end
function UIDuJieZhiBaoMainWin:isfull(fillIdx)
local guid=self.selectList[fillIdx]
if guid==nil then return false end
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,guid,fillIdx)
local hasNum=self:getPutNum(fillIdx)
return hasNum>=needNum
end

function UIDuJieZhiBaoMainWin:addSelectHole(itemguid,index,num)
if num<=0 then return end
local array=self:getIdxArray()
local handle=tostring(itemguid)
local mainItemguid=self:getMainGUID()
for _,i in ipairs(array)do
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,i)
local hasNum=self:getPutNum(i)
local guid=self.selectList[i]
local guidStr=tostring(guid)

if guid==nil or guidStr==handle and needNum>0 then

local add=math.min(num,needNum)
self:addSelectNum(itemguid,i,add)
num=num-add
if num<=0 then
break
end
end
end
end
function UIDuJieZhiBaoMainWin:addSelectNum(itemguid,index,num)

local array=self:getIdxArray()
local handle=tostring(itemguid)
local ishasidx=false
for _,i in ipairs(array)do
local guid=self.selectList[i]
local guidStr=tostring(guid)
if guid~=nil and guidStr==handle then
ishasidx=i
break
end
end
if ishasidx then
self:addPutNum(ishasidx,num)
else
self.selectList[index]=itemguid
self:addPutNum(index,num)
end
end
function UIDuJieZhiBaoMainWin:addPutNum(idx,num)
self.selectNumList[idx]=self:getPutNum(idx)+num
end
function UIDuJieZhiBaoMainWin:setPutNum(idx,num)
self.selectNumList[idx]=num
end


function UIDuJieZhiBaoMainWin:takeOffByTips(index,itemid,itemguid)
self.lastSelectIndex=nil
if self.isSelectGrid==false then
if index==self.selectItemguidIdx then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
end
self:onClickGridButton(nil,itemid,itemguid,index,true)
end


function UIDuJieZhiBaoMainWin:onLeftArrow()
if self.allZhenWudata then

local thisbuild=self._buildid
local lastidx
local lastbuid
local maxlength=#self.allZhenWudata
if maxlength<=1 then
return
end
for k,v in ipairs(self.allZhenWudata)do
if v.jzid==thisbuild then
lastidx=k-1
end
end
if lastidx then
if lastidx<1 then
lastidx=maxlength
end
lastbuid=self.allZhenWudata[lastidx].jzid
end
if lastbuid then
self:onBtnReset()
self:closeProvideSelectGrids()
self._buildid=lastbuid
self.nowelement=allelement[lastbuid]or 1
self:refreshlefticon(lastbuid)

self:refresh(lastbuid,true,false)
end
end
end
function UIDuJieZhiBaoMainWin:onRightArrow()
if self.allZhenWudata then

local thisbuild=self._buildid
local nexidx
local nexbuid
local maxlength=#self.allZhenWudata
if maxlength<=1 then
return
end
for k,v in ipairs(self.allZhenWudata)do
if v.jzid==thisbuild then
nexidx=k+1
end
end
if nexidx then
if nexidx>maxlength then
nexidx=nexidx-maxlength
end
nexbuid=self.allZhenWudata[nexidx].jzid
end
if nexbuid then
self:onBtnReset()
self:closeProvideSelectGrids()
self._buildid=nexbuid
self.nowelement=allelement[nexbuid]or 1
self:refreshlefticon(nexbuid)

self:refresh(nexbuid,true,false)
end
end
end

function UIDuJieZhiBaoMainWin:onUserbtn()
local buildid=self._buildid
local list={}
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local temp={itemid,itemguid_num}
list[#list+1]=temp
end
end
DuJieZhiBaoController:send_34_32(buildid,#list,list)
end


function UIDuJieZhiBaoMainWin:refreshLHdata(_buid)
self:onBtnReset()
self._buildid=_buid
self.nowelement=allelement[_buid]or 1
self:refreshjzData()
self:refresh(_buid,false,false)
end




function UIDuJieZhiBaoMainWin:testssss()
local a=self.selectList
local b=self.selectNumList


end

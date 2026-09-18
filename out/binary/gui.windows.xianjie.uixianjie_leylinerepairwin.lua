







def_class("UIXianJie_LeyLineRepairWin",UIWindowBase)









function UIXianJie_LeyLineRepairWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.disciplePanel=UIObject.get(self,2)
self.fastSelectBtn=UIButton.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.repairtBtn=UIButton.get(self,5)
self.rewardPanel=UIObject.get(self,6)
self.selectPanel=UIObject.get(self,7)
self.targetPanel=UIObject.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fastSelectBtn:setButtonClick(function()self:onFastSelectBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.repairtBtn:setButtonClick(function()self:onRepairtBtn()end)



end


function UIXianJie_LeyLineRepairWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.disciplePanel);self.disciplePanel=nil;
_UIObject_release(self.fastSelectBtn);self.fastSelectBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.repairtBtn);self.repairtBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.targetPanel);self.targetPanel=nil;
end















local _this=nil
local _targetCmp={
stageList=0,
progressBar=1,
timeTx=2,
model=3,
name=4,
}
local _discipleCmp={
disciple=0,
empty=1,
bg=2,
head=3,
btnClick=4,
name=5,
jingjie=6,
job=7,
change=8,
spDzFlag=9,
}
local _rewardCmp={
progressBar=0,
boxList=1,
num=2,
}
local _selectCmp={
selectView=0,
selectList=1,
}



function UIXianJie_LeyLineRepairWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(35,90,self.on_35_90)
self:addProNotify(35,91,self.on_35_91)

self._onSelectDisciple=function(...)
self:onSelectDisciple(...)
end
self._selectDiscipleFunc=function(...)
return self:selectDiscipleFunc(...)
end
self._sortDiscipleFunc=function(...)
return self:sortDiscipleFunc(...)
end
self._onClickDisciple=function()
self:onClickDisciple()
end

self.targetWidget=self.targetPanel:getChildWidgetBase()
self.discipleWidget=self.disciplePanel:getChildWidgetBase()
self.selectWidget=self.selectPanel:getChildWidgetBase()
self.rewardWidget=self.rewardPanel:getChildWidgetBase()

self.discipleWidget:SetChildButtonClick(_discipleCmp.empty,self._onClickDisciple)
self.discipleWidget:SetChildButtonClick(_discipleCmp.btnClick,self._onClickDisciple)
self.discipleWidget:SetChildButtonClick(_discipleCmp.change,self._onClickDisciple)

self.selectNum={}
end


function UIXianJie_LeyLineRepairWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_LeyLineRepairWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.entityData=xianjieModel:getLeyLineData()
self.stage=xianjieModel:getLeyLineRepairStage()
self:refreshDisciplePanel()
self:refreshTargetPanel()
self:refreshRewardPanel()
self:refreshSelectPanel()
end


function UIXianJie_LeyLineRepairWin:onHide()

end




function UIXianJie_LeyLineRepairWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_LeyLineRepairWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianJie_LeyLineRepairWin:onFastSelectBtn()
for i,v in pairs(self.maxCnts)do
local item=self.selectWidget:GetChildLayoutGroupGridItem(_selectCmp.selectList,i-1)
item:SetChildSliderValue(1,v)
end

local list=UIDiscipleModel:getSortList(self._selectDiscipleFunc,self._sortDiscipleFunc)
if#list>0 then
local first=list[1]
self:onSelectDisciple(first.discipleguid)
else
UIManager.info("没有可选弟子")
end
end


function UIXianJie_LeyLineRepairWin:onHelpBtn()



local d={}
d.title='规则'
d.mode=3
d.name="xianjielingmai_repairrule_%d"
self:showWindow('UIRuleWin',d)
end


function UIXianJie_LeyLineRepairWin:onRepairtBtn()
local flag,g_list=self.entityData:checkMovePathCondition(true)
if not flag then
return
end
if xianjieModel:isLeyLineRepairFinish()then
UIManager.info("灵脉已完成修复")
return
end

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

if not self.discipleguid then
self:onClickDisciple()
UIManager.info("请先安排派遣弟子")
return
end

local check=false
for index,num in pairs(self.selectNum)do
if num>0 then
check=true
break
end
end
if not check then
UIManager.info("请先选择要输送的材料")
return
end

local stage=xianjieModel:getLeyLineRepairStage()
local config=self.entityData:getCfg()
local fixed_build_conf=config.param.fixed_build_conf
local configs2=fixed_build_conf[stage][2]
local configs4=fixed_build_conf[stage][4]
local curValue=0
local maxValue=configs4[#configs4][1]
for i,v in pairs(self.selectNum)do
local config=configs2[i]
local itemid=config[1]
local per=config[2]
local score=config[3]
local useNum=per*v
local haveNum=itemsModel.getCount(itemid)
if haveNum<useNum then
UIManager.error("{0}已不足输送{1}份",itemsConfig.getItemName(itemid),v)
return
end
curValue=curValue+v*score
end

local callback=function()
local params={}
table.insert(params,xianjieModel:getLeyLineRepairStage())
for i,v in ipairs(self.maxCnts)do
table.insert(params,self.selectNum[i]or 0)
end
local json=jsonHelper.encode(params)
local guid=int64.new(tostring(xjClientBuildType.flcbXianYuLingMai))
xianjieController:reqOrder(guid,xjServerMarchType.eCarry,{self.discipleguid},{},json,nil,nil,g_list)

self:onCloseBtn()
end
if curValue<maxValue then
UIDialogManager.getConfirmDialog3(nil,"选择输送的材料还没有激活全部进度奖励\n是否继续输送？",callback,REPEAT_TYPE.eXianJieLeyLineRepair,nil)
else
callback()
end
end

function UIXianJie_LeyLineRepairWin:onClickReward(index)
local config=self.entityData:getCfg()
local fixed_build_conf=config.param.fixed_build_conf
local stage=math.max(xianjieModel:getLeyLineRepairStage(),1)
local configs4=fixed_build_conf[stage][4]
local score=configs4[index][1]
local dropId=configs4[index][2]
local rewards=cfgHelper.get2(cfg_awardconfig_get,dropId,"showItems")
local itemlist={}
for i,v in ipairs(rewards)do
table.insert(itemlist,{itemid=v[1],itemcount=v[2],gailv=v[2]==-1})
end
local tipStr=FMT.fmt("本次输送修复进度达到<color={1}>{0}</color>\n可获得以下奖励：",score,FONT_COLOR_VAL[FONT_COLOR.eOrangeColor])
local show_data={
type='UIDialougeBuyWithReward2',
title='提示',
oktext='确定',
itemlist=itemlist,
tip=tipStr,
showclosebtn=true,
bgClick=true,
canvasindex=9,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIXianJie_LeyLineRepairWin:onClickAdd(index)
local max=self.maxCnts[index]
local cur=self.selectNum[index]or 0
if cur<max then
local item=self.selectWidget:GetChildLayoutGroupGridItem(_selectCmp.selectList,index-1)
item:SetChildSliderValue(1,cur+1)
end
end

function UIXianJie_LeyLineRepairWin:onClickDel(index)
local cur=self.selectNum[index]or 0
if cur>0 then
local item=self.selectWidget:GetChildLayoutGroupGridItem(_selectCmp.selectList,index-1)
item:SetChildSliderValue(1,cur-1)
end
end

function UIXianJie_LeyLineRepairWin:refreshSlider(index,value)
local item=self.selectWidget:GetChildLayoutGroupGridItem(_selectCmp.selectList,index-1)
item:SetChildSliderValue(1,value)
end

function UIXianJie_LeyLineRepairWin:onSliderChange(index,value)
local old=self.selectNum[index]or 0
self.selectNum[index]=value

local config=self.entityData:getCfg()
local fixed_build_conf=config.param.fixed_build_conf
local stage=xianjieModel:getLeyLineRepairStage()
local stage=math.max(stage,1)
local configs4=fixed_build_conf[stage][4]
local configs2=fixed_build_conf[stage][2]
local maxValue=configs4[#configs4][1]

local max=self.maxCnts[index]
local itemnum=configs2[index][2]
local curStr=mathHelper.formatNumber(value*itemnum)
local maxStr=mathHelper.formatNumber(max*itemnum)
local perStr=mathHelper.formatNumber(itemnum)
local item=self.selectWidget:GetChildLayoutGroupGridItem(_selectCmp.selectList,index-1)
item:SetChildText(5,FMT.fmt("输送(每组{2}): <color=#549327>{0}/{1}</color>",curStr,maxStr,perStr))

local curValue=0
for i,v in pairs(self.selectNum)do
curValue=curValue+v*configs2[i][3]
end
local oldValue=curValue-(value-old)*configs2[index][3]
local progressStr=FMT.fmt("{0}/{1}",curValue,maxValue)
if curValue<maxValue then
progressStr=FMT.cfmt(FONT_COLOR.eRedColor,progressStr)
end
self.rewardWidget:SetChildText(_rewardCmp.num,progressStr)

local boxItems=self.rewardWidget:GetChildLayoutGroupGridList(_rewardCmp.boxList)
local curProgress=0
local per=10000/#configs4
for i=1,boxItems.Count do
local item=boxItems[i-1]
local num=configs4[i][1]
local arrival=curValue>=num
item:SetChildText(2,num)
item:SetChildGraphicGray(1,not arrival)
if oldValue<num and curValue>=num then
item:SetChildShowEffect(3,10413,true)
end
if arrival then
curProgress=curProgress+per
else
local last=(configs4[i-1]and configs4[i-1][1]or 0)
if curValue>last then
curProgress=curProgress+(curValue-last)/(num-last)*per
end
end
end

self.rewardWidget:SetChildProgressValue(_rewardCmp.progressBar,math.floor(curProgress),10000)
end

function UIXianJie_LeyLineRepairWin:onClickDisciple()
local args={
disciple=self.discipleguid,
callback=self._onSelectDisciple,
parentWin=self,
tips=nil,
}
self:showWindow("UIDiscipleSelectWin_XianJieLeyLine",args)
end

function UIXianJie_LeyLineRepairWin:onSelectDisciple(discipleguid)
self.discipleguid=discipleguid
self:refreshDisciplePanel()
end

function UIXianJie_LeyLineRepairWin:selectDiscipleFunc(netData)
local stateType=xianjieModel:getDZState(netData.discipleguid,false)
return stateType==nil and netData.jingjielv>=90
end

function UIXianJie_LeyLineRepairWin:sortDiscipleFunc(a,b)
if a.jingjielv~=b.jingjielv then
return a.jingjielv>b.jingjielv
else
return UIDiscipleModel:getDiscipleFightValue(a.discipleguid)>UIDiscipleModel:getDiscipleFightValue(b.discipleguid)
end
end

function UIXianJie_LeyLineRepairWin:refreshDisciplePanel()
self.discipleWidget:SetChildActive(_discipleCmp.empty,self.discipleguid==nil)
self.discipleWidget:SetChildActive(_discipleCmp.disciple,self.discipleguid~=nil)
if self.discipleguid then
comHelper.setChildModelHeadIconBG(self.discipleWidget,_discipleCmp.bg,self.discipleguid)
comHelper.setChildModelRawImage(self.discipleWidget,self.discipleguid,_discipleCmp.head,0,eHeadCenterType.eHead)
self.discipleWidget:SetChildText(_discipleCmp.name,UIDiscipleModel:getDiscipleName(self.discipleguid))
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.discipleguid)
self.discipleWidget:SetChildText(_discipleCmp.jingjie,FMT.fmt("境界：{0}",UIDiscipleModel:getJJNameEx(jjlv)))
local jobicon=UIDiscipleModel:getJobIconNameX(self.discipleguid)
self.discipleWidget:SetChildCSImageSprite(_discipleCmp.job,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(self.discipleguid)
self.discipleWidget:SetChildActive(_discipleCmp.spDzFlag,isSpDz)
end
end

function UIXianJie_LeyLineRepairWin:refreshTargetPanel()
local config=self.entityData:getCfg()
local fixed_build_conf=config.param.fixed_build_conf
local maxStage=#fixed_build_conf
local isFinish=xianjieModel:isLeyLineRepairFinish()

local stage=xianjieModel:getLeyLineRepairStage()
local showStage=isFinish and stage or math.max(stage-1,0)
local curValue=xianjieModel:getLeyLineRepairScore()
local maxValue=isFinish and fixed_build_conf[maxStage][1]or fixed_build_conf[stage][1]
self.targetWidget:SetChildProgressValue(_targetCmp.progressBar,curValue,maxValue)
self.targetWidget:SetChildProgressText(_targetCmp.progressBar,FMT.fmt("{0}/{1}",curValue,maxValue))

self.targetWidget:SetChildLayoutGroupCreateItems(_targetCmp.stageList,maxStage,function(index)
local item=self.targetWidget:GetChildLayoutGroupGridItem(_targetCmp.stageList,index-1)
item:SetChildActive(0,showStage>=index)
item:SetChildActive(1,index>1)
end)

self.targetWidget:SetChildText(_targetCmp.name,config.name)

local modelParams=config.clientParam.model
local modelEx2=config.clientParam.modelEx2
local scale=modelEx2 and modelEx2[1]or 1
local offset=modelEx2 and modelEx2[2]or{0,0}
self.targetWidget:SetChildUIModelShowTarget(_targetCmp.model,modelParams[1],scale,modelParams[2]or{},eAnimationID.stand,false,false,0)
self.targetWidget:SetChildUIModelShowTargetOffset(_targetCmp.model,offset[1],offset[2])

local time=self.entityData:getBaseWayTime()
self.targetWidget:SetChildText(_targetCmp.timeTx,timeHelper.format_time_stamp3(time))
end

function UIXianJie_LeyLineRepairWin:refreshRewardPanel()
local config=self.entityData:getCfg()
local carryBox=config.clientParam.carryBox
local fixed_build_conf=config.param.fixed_build_conf
local stage=xianjieModel:getLeyLineRepairStage()
local index=math.max(stage,1)
local imageConf=carryBox[index]
local configs4=fixed_build_conf[index][4]
local configs2=fixed_build_conf[index][2]
local maxValue=configs4[#configs4][1]
local curValue=0

for i,v in pairs(self.selectNum)do
curValue=curValue+v*configs2[i][3]
end
local per=10000/#configs4
local curProgress=0
self.rewardWidget:SetChildLayoutGroupCreateItems(_rewardCmp.boxList,#configs4,function(index)
local item=self.rewardWidget:GetChildLayoutGroupGridItem(_rewardCmp.boxList,index-1)
local num=configs4[index][1]
local arrival=curValue>=num
if arrival then
curProgress=curProgress+per
else
local last=(configs4[index-1]and configs4[index-1][1]or 0)
if curValue>last then
curProgress=curProgress+(curValue-last)/(num-last)*per
end
end
item:SetChildText(2,num)
item:SetChildCSImageSprite(1,imageConf[index][1],imageConf[index][2])
item:SetChildGraphicGray(1,not arrival)
item:SetChildButtonClick(0,function()
self:onClickReward(index)
end)
end)
local progressStr=FMT.fmt("{0}/{1}",curValue,maxValue)
if curValue<maxValue then
progressStr=FMT.cfmt(FONT_COLOR.eRedColor,progressStr)
end
self.rewardWidget:SetChildText(_rewardCmp.num,progressStr)
self.rewardWidget:SetChildProgressValue(_rewardCmp.progressBar,math.floor(curProgress),10000)
end

function UIXianJie_LeyLineRepairWin:refreshSelectPanel()
local config=self.entityData:getCfg()
local fixed_build_conf=config.param.fixed_build_conf
local stage=math.max(xianjieModel:getLeyLineRepairStage(),1)
local configs=fixed_build_conf[stage][2]
self.maxCnts={}
self.selectWidget:SetChildLayoutGroupCreateItems(_selectCmp.selectList,#configs,function(index)
local item=self.selectWidget:GetChildLayoutGroupGridItem(_selectCmp.selectList,index-1)
local config=configs[index]
local itemid=config[1]
local itemnum=config[2]
local haveNum=itemsModel.getCount(itemid)
local showCountBG=true
local countStr=mathHelper.formatNumber(haveNum)
local conf={itemid=itemid,itemcount=countStr,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)

local itemCount=xianjieModel:getLeyLineRepairItemCount(index)
local curValue=self.selectNum[index]or 0
local maxValue=math.min(config[4],math.max(config[5]-itemCount,0),math.floor(haveNum/itemnum))
self.maxCnts[index]=maxValue
item:SetChildActive(2,config[5]<=itemCount)

item:SetChildSliderInit(1,0,0,maxValue,function(value)
self:onSliderChange(index,value)
end)
local curStr=mathHelper.formatNumber(curValue*itemnum)
local maxStr=mathHelper.formatNumber(maxValue*itemnum)
local perStr=mathHelper.formatNumber(itemnum)

item:SetChildText(5,FMT.fmt("输送(每组{2}): <color=#549327>{0}/{1}</color>",curStr,maxStr,perStr))







item:SetChildLongPress(3,0,function(id)
self:onClickAdd(index)
end,nil)
item:SetChildLongPress(4,0,function(id)
self:onClickDel(index)
end,nil)
end)
self.selectWidget:SetChildScrollRectEnable(_selectCmp.selectView,#configs>4)
end

function UIXianJie_LeyLineRepairWin.on_35_90()
if xianjieModel:isLeyLineRepairFinish()then
local cfg=self.entityData:getCfg()
UIManager.info(FMT.fmt("{0}已修复完成",cfg.name))
_this:onCloseBtn()
end
if _this.stage~=xianjieModel:getLeyLineRepairStage()then
table.clear(_this.selectNum)
end
_this:refreshDisciplePanel()
_this:refreshTargetPanel()
_this:refreshRewardPanel()
_this:refreshSelectPanel()
end

function UIXianJie_LeyLineRepairWin.on_35_91(fairylandFixBuild)
if fairylandFixBuild.fix_build_id==xjClientBuildType.flcbXianYuLingMai then
_this.on_35_90()
end
end

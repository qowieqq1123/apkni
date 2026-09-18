







def_class("UIShanMenDaZhen_batchLevelUpWin",UIWindowBase)









function UIShanMenDaZhen_batchLevelUpWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.skillPanel=UIObject.get(self,2)
self.levelUpBtn=UIButton.get(self,3)
self.originalLvText=UIText.get(self,4)
self.nextLvText=UIText.get(self,5)
self.attrGridGroup=UIObject.get(self,6)
self.skillIconList=UIObject.get(self,7)
self.lvUpReddot=UIObject.get(self,8)
self.titleText=UIText.get(self,9)
self.levelUpBtnText=UIText.get(self,10)
self.costScrollView=UIObject.get(self,11)
self.levelSelectSlider=UIObject.get(self,12)
self.levelSelectText=UIText.get(self,13)
self.subBtn=UIButton.get(self,14)
self.addBtn=UIButton.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UIShanMenDaZhen_batchLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.originalLvText);self.originalLvText=nil;
_UIObject_release(self.nextLvText);self.nextLvText=nil;
_UIObject_release(self.attrGridGroup);self.attrGridGroup=nil;
_UIObject_release(self.skillIconList);self.skillIconList=nil;
_UIObject_release(self.lvUpReddot);self.lvUpReddot=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.costScrollView);self.costScrollView=nil;
_UIObject_release(self.levelSelectSlider);self.levelSelectSlider=nil;
_UIObject_release(self.levelSelectText);self.levelSelectText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
end
















local _this



function UIShanMenDaZhen_batchLevelUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIShanMenDaZhen_batchLevelUpWin:__delete()
_this=nil
self:unbindComponents()
end




function UIShanMenDaZhen_batchLevelUpWin:onShow(argtable,afterOnloaded)

self.bdData=shanMenDaZhenModel:getShanMenBdData()
self.buildLv=self.bdData.level

self:initSelectCnt()
self:refresh(true)
end


function UIShanMenDaZhen_batchLevelUpWin:onHide()

end

function UIShanMenDaZhen_batchLevelUpWin:initSelectCnt()
self.selectCnt=1
self.maxLevelUpCnt=1
local allCfg=cfg_shanmendazhenconfig()
local maxLevel=allCfg[#allCfg].id+1
local addNum=10
if self.buildLv+addNum>maxLevel then
addNum=maxLevel-self.buildLv
end

if addNum>=1 then
local bulidId=self.bdData.build_id
for i=addNum,1,-1 do
local level=self.buildLv+i
local buildCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bulidId,level)
local levelUpCNDList=self:getLevelUpCND(buildCfg.uplevel_condition)
local isPassCnd=true
if levelUpCNDList and next(levelUpCNDList)then
for _,data in ipairs(levelUpCNDList)do
if not data.pass then
isPassCnd=false
break
end
end
end
if isPassCnd then
self.maxLevelUpCnt=i
return
end
end
end
end

function UIShanMenDaZhen_batchLevelUpWin:refresh(isInit)

if isInit then
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildSliderInit(self.levelSelectSlider:getID(),self.selectCnt,1,self.maxLevelUpCnt,func)
self.winlua:SetChildSliderValue(self.levelSelectSlider:getID(),self.selectCnt)
end

self.targetBuildLv=self.buildLv+self.selectCnt

local allCfg=cfg_shanmendazhenconfig()
local maxLevel=allCfg[#allCfg].id+1

if self.targetBuildLv>maxLevel then

UIManager.error("山门大阵已达到最高级")
return self:onCloseBtn()
end

self.showNowLevel=self.buildLv-1
self.showTargetLevel=self.targetBuildLv-1
self.daZhenLevelCfg=allCfg[self.showNowLevel]
self.daZhenTargetLevelCfg=allCfg[self.showTargetLevel]
self:refreshBaseInfo()
self:refreshAttr()
self:refreshSkill()
self:refreshCost()

self.lastTargetLevel=self.showTargetLevel
end

function UIShanMenDaZhen_batchLevelUpWin:onSliderChange(value)
if self.selectCnt==value then
return
end

self.selectCnt=value
self:refresh()
end

function UIShanMenDaZhen_batchLevelUpWin:refreshBaseInfo()


self.originalLvText:setText(FMT.fmt("{0}级",self.showNowLevel))
self.nextLvText:setText(FMT.fmt("{0}级",self.showTargetLevel))
self.levelSelectText:setText(FMT.fmt("升至 <color=#ca631d>{0}</color> 级",self.showTargetLevel))

local titleStr="升级大阵"
if self.showNowLevel==0 and self.showTargetLevel==1 then
titleStr="修复大阵"
end

local lvBtnStr=titleStr
self.titleText:setText(titleStr)
self.levelUpBtnText:setText(lvBtnStr)
end

function UIShanMenDaZhen_batchLevelUpWin:refreshAttr()
local targetLastLevel=self.lastTargetLevel or self.showNowLevel

local attrChangeList={}

local nowBaseAttrList_lookup={}
local nowBaseAttrList=self.daZhenLevelCfg.attr or{}

local nowAttrAddRate=self.daZhenLevelCfg.percent or 0
local nowAttrRate=1+nowAttrAddRate/100
for i,v in ipairs(nowBaseAttrList)do
local attrId=v[1]
local attrCfgVal=v[2]
local attrVal=math.floor(attrCfgVal*nowAttrRate)
nowBaseAttrList_lookup[attrId]=attrVal
end
local nextBaseAttrList=self.daZhenTargetLevelCfg.attr or{}
local nextAttrAddRate=self.daZhenTargetLevelCfg.percent or 0
local nextAttrRate=1+nextAttrAddRate/100
for i,v in ipairs(nextBaseAttrList)do
local attrId=v[1]
local attrCfgVal=v[2]
local attrVal=math.floor(attrCfgVal*nextAttrRate)
local nowAttrVal=nowBaseAttrList_lookup[attrId]
local isChange=false
if not nowAttrVal then
isChange=true
else
if nowAttrVal~=attrVal then
isChange=true
end
end

if isChange then
local name,valStr=equipsHelper.getAttr(attrId,attrVal)
nowAttrVal=nowAttrVal or 0
local _,nowValStr=equipsHelper.getAttr(attrId,nowAttrVal)
local attrItem={FMT.fmt("{0}：",name),nowValStr,valStr}
attrChangeList[#attrChangeList+1]=attrItem
end
end


if self.daZhenTargetLevelCfg.shield>self.daZhenLevelCfg.shield then
local attrItem={"护盾值上限：",self.daZhenLevelCfg.shield,self.daZhenTargetLevelCfg.shield}
attrChangeList[#attrChangeList+1]=attrItem
end
if self.daZhenTargetLevelCfg.recover>self.daZhenLevelCfg.recover then
local attrItem={"每年回复护盾值：",self.daZhenLevelCfg.recover,self.daZhenTargetLevelCfg.recover}
attrChangeList[#attrChangeList+1]=attrItem
end
if self.daZhenTargetLevelCfg.team>self.daZhenLevelCfg.team then
local attrItem={"可进驻队伍：",self.daZhenLevelCfg.team,self.daZhenTargetLevelCfg.team}
attrChangeList[#attrChangeList+1]=attrItem
end
local effectId=20255
self.attrGridGroup:setChildLayoutGroupCreateItems(#attrChangeList,function(idx)
if _this==nil then return end
local item=_this.attrGridGroup:getChildLayoutGroupGridItem(idx-1)
local attrStrList=attrChangeList[idx]
item:SetChildText(0,attrStrList[1])
item:SetChildText(1,attrStrList[2])
item:SetChildText(2,attrStrList[3])

if targetLastLevel<self.showTargetLevel then
item:SetChildShowEffect(4,effectId,true)
else
item:SetChildShowEffect(4,0,false)
end
end)

end

function UIShanMenDaZhen_batchLevelUpWin:refreshSkill()

local isChangeSkill=false
local changeSkillList={}
local originalFazeList=self.daZhenLevelCfg.fazeShow or{}
local originalFazeList_lookup={}
for i,v in ipairs(originalFazeList)do
local fazeId=v[1]
local fazeLv=v[2]
originalFazeList_lookup[fazeId]=fazeLv
end
local nextFazeList=self.daZhenTargetLevelCfg.fazeShow or{}
for i,v in ipairs(nextFazeList)do
local fazeId=v[1]
local fazeLv=v[2]
local cfg=cfgHelper.getSSlawRule(fazeId)
local icon=cfg.image
if originalFazeList_lookup[fazeId]then

local originalLevel=originalFazeList_lookup[fazeId]
if fazeLv>originalLevel then
changeSkillList[#changeSkillList+1]={id=fazeId,level=fazeLv,icon=icon,isChangeLevel=true}
isChangeSkill=true
end
else
changeSkillList[#changeSkillList+1]={id=fazeId,level=fazeLv,icon=icon}
isChangeSkill=true
end
end


local nowBuffId=self.daZhenLevelCfg.buff
local nextBuffId=self.daZhenTargetLevelCfg.buff
if nextBuffId and nowBuffId~=nextBuffId then
isChangeSkill=true
local buffCfg=cfgHelper.get1(cfg_guildstateconfig_get,nextBuffId)
local buffLevel=buffCfg.level
local isChangeLevel=nowBuffId~=nil
local icon=iconHelper.getzmStateIcon(buffCfg.icon)
changeSkillList[#changeSkillList+1]={id=nextBuffId,level=buffLevel,icon=icon,isBuffSkill=true,isChangeLevel=isChangeLevel}
end
self.skillPanel:setActive(isChangeSkill)
if isChangeSkill then
self.skillIconList:setChildLayoutGroupCreateItems(#changeSkillList,function(index)
if _this==nil then return end
local item=_this.skillIconList:getChildLayoutGroupGridItem(index-1)
local skillData=changeSkillList[index]

local skillIcon=skillData.icon
item:SetChildIcon(0,skillIcon,false)

local changeStr=skillData.isChangeLevel and FMT.fmt("{0}级",skillData.level)or"激活"
item:SetChildText(1,changeStr)

item:SetChildButtonClick(0,function()
self:showWindow("UIShanMenDaZhen_skillTipsWin",{id=skillData.id,level=skillData.level,needDaZhenLv=self.showTargetLevel,isBuffSkill=skillData.isBuffSkill})
end)
end)
end

end

function UIShanMenDaZhen_batchLevelUpWin:refreshCost()

self.levelUpCostList=self:getLevelUpCostList()
local costCount=#self.levelUpCostList
self.costScrollView:setChildScrollViewCreateGrids(costCount,costCount)
local grids=self.costScrollView:getChildScrollViewItemWidgets()
local canLevelUp=true
for i=1,grids.Count do
local item=grids[i-1]
local costItem=self.levelUpCostList[i]
if costItem then
local itemId=costItem.itemId
local itemNum=costItem.itemCount
local countStr=mathHelper.formatNumber(itemNum)
local hasCount=itemsModel.getCount(itemId)
if hasCount<itemNum then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
canLevelUp=false
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)



item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end


local reddot=canLevelUp
self.lvUpReddot:setActive(reddot)
end

function UIShanMenDaZhen_batchLevelUpWin:getLevelUpCostList()
local costList={}
local costList_lookup={}
local startBuildLv=self.buildLv+1
local bulidId=self.bdData.build_id
for level=startBuildLv,self.targetBuildLv do
local buildCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bulidId,level)
local lvCostList=buildCfg.uplevel_cost
for i,costCfg in ipairs(lvCostList)do
local itemId=costCfg[1]
local itemNum=costCfg[2]
if costList_lookup[itemId]then
costList_lookup[itemId]=costList_lookup[itemId]+itemNum
else
costList_lookup[itemId]=itemNum
end
end
end

for itemId,itemCount in pairs(costList_lookup)do
local item={itemId=itemId,itemCount=itemCount}
item.color=itemsConfig.getItemColor(itemId)

costList[#costList+1]=item
end


table.sort(costList,function(a,b)
if a.color==b.color then
return a.itemId>b.itemId
else
return a.color>b.color
end
end)

return costList
end

function UIShanMenDaZhen_batchLevelUpWin:getLevelUpCND(cfgs)
local list={}
for i,v in ipairs(cfgs)do
local data={}
data.cfg=v
data.index=i
if v.type==1 then
data.pass=zongmenModel:getLevel()>=v.param
elseif v.type==2 then
data.pass=taskModel:checkTaskFinish(v.param)
elseif v.type==3 then
local bdData
local bdDatas=zongmenModel:getBuildingDataByBdType(self.sfId,v.param[1])
local count=0
local level=v.param[3]
for _,bd in ipairs(bdDatas)do
if bd.level>=level then
count=count+1
else
bdData=bd
end
end
data.data=bdData
data.pass=count>=v.param[2]
data.count=count
data.need=v.param[2]
elseif v.type==4 then
data.pass=zheXianLingModel:checkFinish(v.param[1],v.param[2]or 0)
elseif v.type==5 then
data.pass=shiLianTaModel:getCurLayer()>v.param
end
table.insert(list,data)
end
table.sort(list,function(a,b)
if a.pass and not b.pass then
return true
elseif not a.pass and b.pass then
return false
else
return a.index<b.index
end
end)
return list
end

function UIShanMenDaZhen_batchLevelUpWin:handleLevelUp()

if self.targetBuildLv then
local startBuildLv=self.buildLv+1
local bulidId=self.bdData.build_id
for level=startBuildLv,self.targetBuildLv do
local buildCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bulidId,level)
local levelUpCNDList=self:getLevelUpCND(buildCfg.uplevel_condition)
if levelUpCNDList and next(levelUpCNDList)then
for i,data in ipairs(levelUpCNDList)do
if not data.pass then

return UIManager.error("未满足升级条件")
end
end
end

local flag,lvupData=zongmenControl:checkLevelUp(buildCfg,true,nil,true)
if not flag then
return
end
end



local addLevel=self.targetBuildLv-self.buildLv
zongmenControl:reqBuildingLevelUp_batch(mapIdType.zhufeng,self.bdData.un_build_id,0,{},addLevel)

self:onCloseBtn()
end
end

function UIShanMenDaZhen_batchLevelUpWin:resetSelectCnt()
local selectCnt
local costList_lookup={}


local startBuildLv=self.buildLv+1
local targetBuildLv=startBuildLv
local bulidId=self.bdData.build_id
for level=startBuildLv,self.targetBuildLv do
local buildCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bulidId,level)
local levelUpCNDList=self:getLevelUpCND(buildCfg.uplevel_condition)
local isBreak=false
if levelUpCNDList and next(levelUpCNDList)then
for i,data in ipairs(levelUpCNDList)do
if not data.pass then

isBreak=true
break
end
end
end

local lvCostList=buildCfg.uplevel_cost
for i,costCfg in ipairs(lvCostList)do
local itemId=costCfg[1]
local itemNum=costCfg[2]
if costList_lookup[itemId]then
costList_lookup[itemId]=costList_lookup[itemId]+itemNum
else
costList_lookup[itemId]=itemNum
end

local hasCount=itemsModel.getCount(itemId)
if hasCount<costList_lookup[itemId]then
isBreak=true
break
end
end

if isBreak then
break
end

targetBuildLv=level
end

selectCnt=targetBuildLv-self.buildLv
if selectCnt==0 then
selectCnt=1
end

self.winlua:SetChildSliderValue(self.levelSelectSlider:getID(),selectCnt)
end




function UIShanMenDaZhen_batchLevelUpWin:onCloseBtn()
self:closeSelf()
end



function UIShanMenDaZhen_batchLevelUpWin:onMask()
self:onCloseBtn()
end



function UIShanMenDaZhen_batchLevelUpWin:onLevelUpBtn()
local costList={}
if self.levelUpCostList then
for i,v in ipairs(self.levelUpCostList)do
local itemId=v.itemId
local itemCount=v.itemCount
costList[#costList+1]={itemId,itemCount}
local hasCount=itemsModel.getCount(itemId)
if hasCount<itemCount then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
return self:resetSelectCnt()
end
end
end
moneySystem:countAndExchange(costList,eMoneyType.mtLingYu,function()
self:handleLevelUp()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end



function UIShanMenDaZhen_batchLevelUpWin:onSubBtn()
local selectCnt=self.selectCnt-1
if selectCnt<1 then
selectCnt=1
end
self.winlua:SetChildSliderValue(self.levelSelectSlider:getID(),selectCnt)
end



function UIShanMenDaZhen_batchLevelUpWin:onAddBtn()
local selectCnt=self.selectCnt+1
if selectCnt>self.maxLevelUpCnt then
selectCnt=self.maxLevelUpCnt
end
self.winlua:SetChildSliderValue(self.levelSelectSlider:getID(),selectCnt)
end


function UIShanMenDaZhen_batchLevelUpWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


gainControl:showGainWin(itemId)
end
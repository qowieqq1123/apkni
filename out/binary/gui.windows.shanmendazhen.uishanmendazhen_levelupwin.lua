







def_class("UIShanMenDaZhen_levelUpWin",UIWindowBase)









function UIShanMenDaZhen_levelUpWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.skillPanel=UIObject.get(self,2)
self.costGridsGroup=UIObject.get(self,3)
self.levelUpBtn=UIButton.get(self,4)
self.originalLvText=UIText.get(self,5)
self.nextLvText=UIText.get(self,6)
self.attrGridGroup=UIObject.get(self,7)
self.skillIconList=UIObject.get(self,8)
self.conditionLayout=UIObject.get(self,9)
self.levelUpTimeText=UIText.get(self,10)
self.lvUpReddot=UIObject.get(self,11)
self.titleText=UIText.get(self,12)
self.levelUpBtnText=UIText.get(self,13)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)



end


function UIShanMenDaZhen_levelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.costGridsGroup);self.costGridsGroup=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.originalLvText);self.originalLvText=nil;
_UIObject_release(self.nextLvText);self.nextLvText=nil;
_UIObject_release(self.attrGridGroup);self.attrGridGroup=nil;
_UIObject_release(self.skillIconList);self.skillIconList=nil;
_UIObject_release(self.conditionLayout);self.conditionLayout=nil;
_UIObject_release(self.levelUpTimeText);self.levelUpTimeText=nil;
_UIObject_release(self.lvUpReddot);self.lvUpReddot=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
end
















local _this




function UIShanMenDaZhen_levelUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIShanMenDaZhen_levelUpWin:__delete()
_this=nil
self:unbindComponents()
end




function UIShanMenDaZhen_levelUpWin:onShow(argtable,afterOnloaded)

self.bdData=shanMenDaZhenModel:getShanMenBdData()
self.buildLv=self.bdData.level
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.buildLv+1)

self:refresh()
end


function UIShanMenDaZhen_levelUpWin:onHide()

end

function UIShanMenDaZhen_levelUpWin:refresh()
local nextBuildLv=self.buildLv+1

local allCfg=cfg_shanmendazhenconfig()
local maxLevel=allCfg[#allCfg].id+1

if nextBuildLv>maxLevel then

UIManager.error("山门大阵已达到最高级")
return self:onCloseBtn()
end

local showNowLevel=self.buildLv-1
local showNextLevel=nextBuildLv-1
local daZhenLevelCfg=allCfg[showNowLevel]
local daZhenNextLevelCfg=allCfg[showNextLevel]


self.originalLvText:setText(FMT.fmt("{0}级",showNowLevel))
self.nextLvText:setText(FMT.fmt("{0}级",showNextLevel))

local titleStr="升级大阵"
if showNowLevel==0 and showNextLevel==1 then
titleStr="修复大阵"
end

local lvBtnStr=titleStr
self.titleText:setText(titleStr)
self.levelUpBtnText:setText(lvBtnStr)

local attrChangeList={}

local nowBaseAttrList_lookup={}
local nowBaseAttrList=daZhenLevelCfg.attr or{}

local nowAttrAddRate=daZhenLevelCfg.percent or 0
local nowAttrRate=1+nowAttrAddRate/100
for i,v in ipairs(nowBaseAttrList)do
local attrId=v[1]
local attrCfgVal=v[2]
local attrVal=math.floor(attrCfgVal*nowAttrRate)
nowBaseAttrList_lookup[attrId]=attrVal
end
local nextBaseAttrList=daZhenNextLevelCfg.attr or{}
local nextAttrAddRate=daZhenNextLevelCfg.percent or 0
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
attrChangeList[#attrChangeList+1]={FMT.fmt("{0}：",name),nowValStr,valStr}
end
end


if daZhenNextLevelCfg.shield>daZhenLevelCfg.shield then
attrChangeList[#attrChangeList+1]={"护盾值上限：",daZhenLevelCfg.shield,daZhenNextLevelCfg.shield}
end
if daZhenNextLevelCfg.recover>daZhenLevelCfg.recover then
attrChangeList[#attrChangeList+1]={"每年回复护盾值：",daZhenLevelCfg.recover,daZhenNextLevelCfg.recover}
end
if daZhenNextLevelCfg.team>daZhenLevelCfg.team then
attrChangeList[#attrChangeList+1]={"可进驻队伍：",daZhenLevelCfg.team,daZhenNextLevelCfg.team}
end
self.attrGridGroup:setChildLayoutGroupCreateItems(#attrChangeList,function(idx)
if _this==nil then return end
local item=_this.attrGridGroup:getChildLayoutGroupGridItem(idx-1)
local attrStrList=attrChangeList[idx]
item:SetChildText(0,attrStrList[1])
item:SetChildText(1,attrStrList[2])
item:SetChildText(2,attrStrList[3])
end)


local isChangeSkill=false
local changeSkillList={}
local originalFazeList=daZhenLevelCfg.fazeShow or{}
local originalFazeList_lookup={}
for i,v in ipairs(originalFazeList)do
local fazeId=v[1]
local fazeLv=v[2]
originalFazeList_lookup[fazeId]=fazeLv
end
local nextFazeList=daZhenNextLevelCfg.fazeShow or{}
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

























local nowBuffId=daZhenLevelCfg.buff
local nextBuffId=daZhenNextLevelCfg.buff
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
self:showWindow("UIShanMenDaZhen_skillTipsWin",{id=skillData.id,level=skillData.level,needDaZhenLv=showNextLevel,isBuffSkill=skillData.isBuffSkill})
end)
end)
end

if self.nextLvCfg then

self.levelUpCNDList=self:getLevelUpCND(self.nextLvCfg.uplevel_condition)
local count=#self.levelUpCNDList
self.conditionLayout:setChildLayoutGroupCreateItems(count,function(index)
if _this==nil then return end
local item=_this.conditionLayout:getChildLayoutGroupGridItem(index-1)
local data=self.levelUpCNDList[index]
if data then
local desc
local isShowGotoBtn=false
local gotoFunc
if data.cfg.type==1 then
desc=string.format('需要宗门达到%d级',data.cfg.param)
if not data.pass then
isShowGotoBtn=true
gotoFunc=function()
return self:onGoToButton(data.cfg.type)
end
end
elseif data.cfg.type==2 then
desc=string.format('需要完成任务:%s',data.cfg.param)
elseif data.cfg.type==3 then
local str
if not data.pass then
str=string.format('<color=red>%s/%s</color>',data.count,data.need)
else
str=string.format('<color=green>%s/%s</color>',data.count,data.need)
end
local c=cfgHelper.get1(cfg_monijybuildconfig_get,data.cfg.param[1])
desc=string.format('拥有%s个%s级%s(%s)',data.cfg.param[2],data.cfg.param[3],c.name,str)
if not data.pass then
isShowGotoBtn=true
gotoFunc=function()
return self:onGoToButton(data.cfg.type,data.data,c)
end
end
elseif data.cfg.type==4 then
local param=data.cfg.param
local bookStr=mathHelper.numberToChinese(param[1])
desc=FMT.fmt('完成谪仙令第{0}卷',bookStr)
if param[2]then
desc=FMT.fmt('{0}第{1}章',desc,param[2])
end
if not data.pass then
isShowGotoBtn=true
gotoFunc=function()
return self:onGoToButton(data.cfg.type)
end
end
elseif data.cfg.type==5 then
desc=FMT.fmt('完成锁妖塔第{0}层',data.cfg.param)
if not data.pass then
isShowGotoBtn=true
gotoFunc=function()
return self:onGoToButton(data.cfg.type)
end
end
end


if data.pass then
desc=FMT.fmt("<color=#549327>{0}</color>",desc)
end
item:SetChildText(0,desc)
item:SetChildActive(1,isShowGotoBtn)
item:SetChildButtonClick(1,gotoFunc)
item:SetChildActive(2,data.pass)
item:SetChildActive(3,not data.pass)
item:SetChildActive(4,data.pass)
end
end)


local costList=self.nextLvCfg.uplevel_cost
self.costGridsGroup:setChildLayoutGroupCreateItems(#costList,function(index)
if _this==nil then return end
local item=_this.costGridsGroup:getChildLayoutGroupGridItem(index-1)
local costCfg=costList[index]
if costCfg then
local itemId=costCfg[1]
local itemNum=costCfg[2]
local countStr=mathHelper.formatNumber(itemNum)
local hasCount=itemsModel.getCount(itemId)
if hasCount<itemNum then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)



item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end)


local levelUpTimeStr
local isShowLvUpTime=self.nextLvCfg.uplevel_times>0
self.levelUpTimeText:setActive(isShowLvUpTime)
if isShowLvUpTime then
levelUpTimeStr=FMT.fmt('升级耗时：{0}',timeHelper.format_time_stamp4(self.nextLvCfg.uplevel_times))
self.levelUpTimeText:setText(levelUpTimeStr)
end

local reddot=shanMenDaZhenModel:checkDaZhenCanLevelUp()
self.lvUpReddot:setActive(reddot)
end
end

function UIShanMenDaZhen_levelUpWin:getLevelUpCND(cfgs)
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

function UIShanMenDaZhen_levelUpWin:handleLevelUp()

if self.levelUpCNDList and next(self.levelUpCNDList)then
for i,data in ipairs(self.levelUpCNDList)do
if not data.pass then

return UIManager.error("未满足升级条件")
end
end
end

local flag,lvupData=zongmenControl:checkLevelUp(self.nextLvCfg,true,nil,true)
if not flag then
return
end
zongmenControl:reqBuildingLevelUp(mapIdType.zhufeng,self.bdData.un_build_id,0,{})

self:onCloseBtn()

end




function UIShanMenDaZhen_levelUpWin:onCloseBtn()
self:closeSelf()
end



function UIShanMenDaZhen_levelUpWin:onMask()
self:onCloseBtn()
end



function UIShanMenDaZhen_levelUpWin:onLevelUpBtn()
moneySystem:countAndExchange(self.nextLvCfg.uplevel_cost,eMoneyType.mtLingYu,function()
self:handleLevelUp()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end


function UIShanMenDaZhen_levelUpWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end





gainControl:showGainWin(itemId)
end

function UIShanMenDaZhen_levelUpWin:onGoToButton(ftype,arg1,arg2)
if ftype==1 then
self:onCloseBtn()
fullScreenUI.closeActiveUI()
UIManager:showWindow('UIZongmenInfoWin',{showback=true})
elseif ftype==3 then
self:onCloseBtn()
fullScreenUI.closeActiveUI()
local bdData=arg1
local c=arg2
if bdData then
isometricMapSystem:openBuildingWin(bdData)
else
local rdata=isometricMapSystem:getUnlockRepairDataByID(zongmenModel:getMountainId(),c.id)
if rdata then
isometricMapSystem:moveCameraToObject(rdata.guid,false,nil)
UIManager:showWindow('UIRepairWin',rdata)
else
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,sortType=c.buildTab,bdId=c.id,isBuild=true})
end
end
elseif ftype==4 then
jumpManager:jump({id=JUMP_TYPE.eZheXianLing})
elseif ftype==5 then
jumpManager:jump({id=JUMP_TYPE.eShiLianTa})
end
end








def_class("UISubAct_TianMoRuQin_TuJianWin",UIWindowBase)









function UISubAct_TianMoRuQin_TuJianWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.root=UIButton.get(self,1)
self.scrollView=UIObject.get(self,2)
self.typeList=UIObject.get(self,3)
self.previewBg=UIButton.get(self,4)
self.previewRewards=UIObject.get(self,5)
self.monsterList=UIObject.get(self,6)

self.root:setButtonClick(function()self:onRoot()end)

self.previewBg:setButtonClick(function()self:onPreviewBg()end)



end


function UISubAct_TianMoRuQin_TuJianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.typeList);self.typeList=nil;
_UIObject_release(self.previewBg);self.previewBg=nil;
_UIObject_release(self.previewRewards);self.previewRewards=nil;
_UIObject_release(self.monsterList);self.monsterList=nil;
end















local _this=nil
local _tabCmp={
root=-1,
name=0,
selected=1,
reddot=2,
button=3,
}
local _tabNames={
[monType.EliteMonster]="image_tianmotujianui_5",
[monType.Boss]="image_tianmotujianui_4"
}
local _abName="ui/windows/activities/sub_tianmoruqin/tianmoruqin_tujian_atlas_pak.ab"
local _monsterCmp={
root=-1,
model=0,
rewardBtn=1,
nameTx=2,
button=3,
detailBg=4,
skillList=5,
itemList=6,
rewardIcon=7,
nameBg=8,
previewBtn=9,
}



function UISubAct_TianMoRuQin_TuJianWin:onLoaded(...)
self:bindComponents()
_this=self
local _onDrag=function(...)
self:onDrag(...)
end
self.winlua:SetChildUIDragEvent(self.scrollView:getID(),0,nil,_onDrag,nil)
self.bgModel:setChildUIModelShowTarget(4933,1,{},eAnimationID.stand,false,false,0)
end


function UISubAct_TianMoRuQin_TuJianWin:__delete()
self:unbindComponents()
_this=nil

if self.tween and self.tween:IsActive()then
self.tween:Kill()
end
end




function UISubAct_TianMoRuQin_TuJianWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.actId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
if not old then
self:initView()
end
if self.info and self.info:hasData()then
self:refreshView()
end
end
end


function UISubAct_TianMoRuQin_TuJianWin:onHide()
if self.showPreview then
self:onPreviewBg()
end
end



function UISubAct_TianMoRuQin_TuJianWin:initView()
self:initTabs()

self.selectedTab=nil
self.monsterList:setChildLayoutGroupClearAllItems()
end

function UISubAct_TianMoRuQin_TuJianWin:refreshView()
if self.selectedTab then
for i,v in ipairs(self.monsters)do
self:refreshItem(i)
end
else
self:onClickTab(1)
end
end

function UISubAct_TianMoRuQin_TuJianWin:initTabs()
self.monsterLookup={}
self.monsterTab={}
for i,v in ipairs(self.config.book)do
local monsterId=v[1]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local monsterType=monsterCfg.monType

if not self.monsterLookup[monsterType]then
self.monsterLookup[monsterType]={}
end
table.insert(self.monsterLookup[monsterType],i)
end
for monsterType,monsterList in pairs(self.monsterLookup)do
table.insert(self.monsterTab,monsterType)
end
table.sort(self.monsterTab)


self.typeList:setChildLayoutGroupCreateItems(#self.monsterTab,function(index)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
local mType=self.monsterTab[index]
local monsters=self.monsterLookup[mType]
local reddot=self.info:getBookMonstersReddot(monsters)
item:SetChildButtonClick(_tabCmp.button,function()
self:onClickTab(index)
end)
item:SetChildCSImageSprite(_tabCmp.name,_abName,_tabNames[mType]or"")
item:SetChildActive(_tabCmp.selected,self.selectedTab==index)
item:SetChildActive(_tabCmp.reddot,reddot)
item:SetChildAnchoredPos(_tabCmp.button,0,(index-1)*-10)
end)
end

function UISubAct_TianMoRuQin_TuJianWin:onClickTab(index)
if self.selectedTab~=index then
if self.selectedTab then
local item=self.typeList:getChildLayoutGroupGridItem(self.selectedTab-1)
item:SetChildActive(_tabCmp.selected,false)
end

self.selectedTab=index
self.selectIndex=nil

local item=self.typeList:getChildLayoutGroupGridItem(self.selectedTab-1)
item:SetChildActive(_tabCmp.selected,true)

self:initList()
end
end

function UISubAct_TianMoRuQin_TuJianWin:getSortWeight(monsterIdx)
local monsterId=self.config.book[monsterIdx][1]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local flag=self.info:getBookFlag(monsterIdx)
local killed=mathHelper.getBitValue(flag,0)
if killed then
local getted=mathHelper.getBitValue(flag,1)
return getted and(10000+monsterIdx)or(20000+monsterIdx)
end
return monsterIdx
end

function UISubAct_TianMoRuQin_TuJianWin:initList()
local monsterType=self.monsterTab[self.selectedTab]
self.monsters=self.monsterLookup[monsterType]
table.sort(self.monsters,function(a,b)
return self:getSortWeight(a)>self:getSortWeight(b)
end)

local center=Vector2.one*0.5
self.monsterList:setChildLayoutGroupCreateItems(#self.monsters,function(index)
local item=self.monsterList:getChildLayoutGroupGridItem(index-1)
local monsterIdx=self.monsters[index]
local monsterId=self.config.book[monsterIdx][1]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local flag=self.info:getBookFlag(monsterIdx)

item:SetChildButtonClick(_monsterCmp.button,function()
self:onClickMonster(index)
end)
item:SetChildButtonClick(_monsterCmp.rewardBtn,function()
self:onClickReward(index)
end)

item:SetChildCSImageIcon(_monsterCmp.model,self.config.monster_icons[monsterId]or"",false)

local killed=mathHelper.getBitValue(flag,0)
item:SetChildIconColor(_monsterCmp.model,killed and Color.white or Color.black)
item:SetChildActive(_monsterCmp.nameBg,killed)

item:SetChildText(_monsterCmp.nameTx,monsterCfg.name)
local getted=mathHelper.getBitValue(flag,1)
item:SetChildActive(_monsterCmp.rewardBtn,killed and not getted)

item:SetChildActive(_monsterCmp.previewBtn,not killed)
item:SetChildButtonClick(_monsterCmp.previewBtn,function()
self:onClickPreview(index)
end)

local showSkills=self.config.texing[monsterId]or{}
item:SetChildLayoutGroupCreateItems(_monsterCmp.skillList,#showSkills,function(idx)
local skillItem=item:GetChildLayoutGroupGridItem(_monsterCmp.skillList,idx-1)
local skillData=showSkills[idx]
local skillType=skillData[1]
local skillIndex=skillData[2]
local iconName=""
if skillType==1 then
local skillParam=monsterCfg.showSkills and monsterCfg.showSkills[skillIndex]or nil
if skillParam then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillParam[1])
iconName=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("天魔图鉴无效怪物特性:{0},{1},{2}",monsterId,skillType,skillIndex)
end
else
local skillParam=self.config.faze[monsterId]
if skillParam then
local fazeID=skillParam[skillIndex][1]
local skillCfg=cfgHelper.getSSlawRule(fazeID)
iconName=skillCfg.image
else
loggerUtil.logWarnFMT("天魔图鉴无效怪物特性:{0},{1},{2}",monsterId,skillType,skillIndex)
end
end
skillItem:SetChildCSImageIcon(0,iconName,false)
skillItem:SetChildButtonClick(0,function()
self:onClickSkill(index,idx)
end)
end)
local rewards=self.config.book[monsterIdx][2]
item:SetChildLayoutGroupCreateItems(_monsterCmp.itemList,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(_monsterCmp.itemList,idx-1)
local rewardData=rewards[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)











item:SetChildActive(_monsterCmp.detailBg,self.selectedIndex==index)
end)
end

function UISubAct_TianMoRuQin_TuJianWin:onClickMonster(index)
local monsterIdx=self.monsters[index]
local flag=self.info:getBookFlag(monsterIdx)
local killed=mathHelper.getBitValue(flag,0)
if killed then
self:switchDetail(index)
else
UIManager.info("暂无法查看")
self:cancelDetail()
end
end

function UISubAct_TianMoRuQin_TuJianWin:onClickReward(index)
local mosnterIdx=self.monsters[index]
local flag=self.info:getBookFlag(mosnterIdx)
if flag==1 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqBookReward",self.actId,self.subId,mosnterIdx)
end
end

function UISubAct_TianMoRuQin_TuJianWin:refreshItem(index)
local item=self.monsterList:getChildLayoutGroupGridItem(index-1)
local monsterIdx=self.monsters[index]
local flag=self.info:getBookFlag(monsterIdx)
local killed=mathHelper.getBitValue(flag,0)

item:SetChildIconColor(_monsterCmp.model,killed and Color.white or Color.black)
item:SetChildActive(_monsterCmp.nameBg,killed)
local getted=mathHelper.getBitValue(flag,1)
item:SetChildActive(_monsterCmp.rewardBtn,killed and not getted)
end

function UISubAct_TianMoRuQin_TuJianWin:on_249_140(actId,subType,subId,monsterIndex)
if self.info:compare(actId,subType,subId)then
self:initList()

for i,v in pairs(self.monsterTab)do
local monsters=self.monsterLookup[v]
if table.containsValue(monsters,monsterIndex)then
local item=self.typeList:getChildLayoutGroupGridItem(i-1)
local reddot=self.info:getBookMonstersReddot(monsters)
item:SetChildActive(_tabCmp.reddot,reddot)
return
end
end
end
end

function UISubAct_TianMoRuQin_TuJianWin:on_249_130(actId,subType,subId,bookIdx)
if self.info:compare(actId,subType,subId)and bookIdx then
self:initList()

for i,v in pairs(self.monsterTab)do
local monsters=self.monsterLookup[v]
if table.containsValue(monsters,bookIdx)then
local item=self.typeList:getChildLayoutGroupGridItem(i-1)
local reddot=self.info:getBookMonstersReddot(monsters)
item:SetChildActive(_tabCmp.reddot,reddot)
return
end
end
end
end

function UISubAct_TianMoRuQin_TuJianWin:onRoot()
self:cancelDetail()
end

function UISubAct_TianMoRuQin_TuJianWin:onDrag(id,pos)
self:cancelDetail()
end

function UISubAct_TianMoRuQin_TuJianWin:switchDetail(index)
if self.selectIndex~=index then
if self.selectIndex then
local item=self.monsterList:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildActive(_monsterCmp.detailBg,false)

if self.tween and self.tween:IsActive()then
self.tween:Kill(true)
end
item:SetChildIconColor(_monsterCmp.model,Color.white)
end
self.selectIndex=index
if self.selectIndex then
local item=self.monsterList:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildActive(_monsterCmp.detailBg,true)
item:SetChildCanvasGroupAlpha(_monsterCmp.detailBg,0)
self.tween=Lua.SequenceProxy.New()
local outTween=item:SetChildImageDOColor(_monsterCmp.model,Color.New(1,1,1,0),0.4)
local inTween=item:SetChildCanvasGroupDOFade(_monsterCmp.detailBg,1,0.4)
inTween:SetEase(DG.Tweening.Ease.Linear)
outTween:SetEase(DG.Tweening.Ease.Linear)
self.tween:Join(outTween)
self.tween:Join(inTween)
self.tween:AppendCallback(function()
self.tween=nil
end)




end
else
if self.selectIndex then
local item=self.monsterList:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildActive(_monsterCmp.detailBg,false)
if self.tween and self.tween:IsActive()then
self.tween:Kill(true)
end
item:SetChildIconColor(_monsterCmp.model,Color.white)

end

self.selectIndex=nil
end
end

function UISubAct_TianMoRuQin_TuJianWin:cancelDetail()
if self.selectIndex then
self:switchDetail()
end
end

function UISubAct_TianMoRuQin_TuJianWin:onClickSkill(index,idx)
local monsterIdx=self.monsters[index]
local monsterId=self.config.book[monsterIdx][1]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)



local txInfo=self.config.texing[monsterId][idx]
local txType=txInfo[1]
local txIndex=txInfo[2]
local name,icon,desc,bottomLeft
if txType==1 then
local txParam=monsterCfg.showSkills[txIndex]
local skillId=txParam[1]
local skillLv=txParam[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
name=skillCfg.name
icon=iconHelper.getSkillIcon(skillCfg.icon)
desc=skillModel:getSkillDesc(skillId,skillLv)
bottomLeft=is_bd and{globalABLookup.global,"icon_jnbeidong"}or nil
else
local txParam=self.config.faze[monsterId][txIndex]
local fazeID=txParam[1]
local fazeLv=txParam[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
name=fazeCfg.name
icon=fazeCfg.image
desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc
bottomLeft=nil
end

local item=self.monsterList:getChildLayoutGroupGridItem(index-1)
local sItem=item:GetChildLayoutGroupGridItem(_monsterCmp.skillList,idx-1)
local screenPoint=sItem:GetChildScreenPointToLocalPointRectangle(-1)

local halfVector=Vector2.one*0.5
local pivot=screenPoint.x<=0 and Vector2.zero or Vector2.right
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=pivot,
anchoredPosition=Vector2.New(screenPoint.x,56),
}
}
self:showWindow('UISimpleTeXingTipsWin',args)
end

function UISubAct_TianMoRuQin_TuJianWin:onClickPreview(index)



self.showPreview=true
self.previewBg:setActive(true)
self.previewRewards:setActive(true)
local monsterIdx=self.monsters[index]
local rewards=self.config.book[monsterIdx][2]
local width=math.max(320,#rewards*72+40)
local screenWidth=self.winlua:GetChildRectWidth(self.root:getID())
self.previewRewards:setChildLayoutGroupCreateItems(#rewards,function(idx)
local rewardItem=self.previewRewards:getChildLayoutGroupGridItem(idx-1)
local rewardData=rewards[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
local listPos=self.monsterList:getChildAnchoredPosition()
local x=389*index-56+listPos.x+165
x=Mathf.Clamp(x,165+width/2,screenWidth-width/2)
self.previewRewards:setChildAnchoredPos(x,-35)
end

function UISubAct_TianMoRuQin_TuJianWin:onPreviewBg()
self.showPreview=false
self.previewBg:setActive(false)
self.previewRewards:setActive(false)
end
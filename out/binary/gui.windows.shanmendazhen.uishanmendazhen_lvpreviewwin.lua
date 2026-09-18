







def_class("UIShanMenDaZhen_lvPreviewWin",UIWindowBase)









function UIShanMenDaZhen_lvPreviewWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.levelItemScrollView=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIShanMenDaZhen_lvPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.levelItemScrollView);self.levelItemScrollView=nil;
end
















local _this
local levelItemCmpIndex={
title=0,
attrGridGroup=1,
skillPanel=2,
skillScrollView=3,
icon=4,
notSkillTips=5,
}




function UIShanMenDaZhen_lvPreviewWin:onLoaded(...)
_this=self
self:bindComponents()

self.loopListView=self.winlua:GetChildUILoopListView(self.levelItemScrollView:getID())
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
end


function UIShanMenDaZhen_lvPreviewWin:__delete()
_this=nil
self.loopListView:SetAction(nil,nil)
self.loopListView=nil
self:unbindComponents()
end




function UIShanMenDaZhen_lvPreviewWin:onShow(argtable,afterOnloaded)
self.allDaZhenCfg=cfg_shanmendazhenconfig()
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local count=0
local prefabNameList={}
local itemIdList={}
local jumpIndex
local showCount=10
local allCount=#self.allDaZhenCfg
local index=0
local endIndex=daZhenLv+showCount
if endIndex>allCount then
endIndex=allCount
end
local startIndex=endIndex-showCount+1
self.showCfgList={}
for i=startIndex,endIndex do
if i>0 then
index=index+1
prefabNameList[index]="levelItem"
itemIdList[index]=index
local cfg=self.allDaZhenCfg[i]
self.showCfgList[index]=cfg
count=count+1
if not jumpIndex and i==daZhenLv then
jumpIndex=i
end
end
end
jumpIndex=jumpIndex or 1
self.loopListView:InitDataList(count,prefabNameList,itemIdList,nil,nil)
self.loopListView:JumpIndex(jumpIndex-1)
end


function UIShanMenDaZhen_lvPreviewWin:onHide()

end

function UIShanMenDaZhen_lvPreviewWin:onFreshListView(index,widget)
index=index+1
self:refreshLevelItem(index,widget)
end


function UIShanMenDaZhen_lvPreviewWin:onStartView(index,widget)

end


function UIShanMenDaZhen_lvPreviewWin:refreshLevelItem(index,widget)
if _this==nil then return end
local item=widget
local cfg=self.showCfgList[index]

local level=cfg.id
local levelText=FMT.fmt("山门大阵（{0}级）",level)
item:SetChildText(levelItemCmpIndex.title,levelText)


local abName="ui/windows/shanmendazhen/dazhenicon_atlas_pak.ab"
local iconName=cfg.icon
item:SetChildCSImageSprite(levelItemCmpIndex.icon,abName,iconName)

local attrChangeList={}

local attrAddRate=cfg.percent or 0
local attrRate=1+attrAddRate/100

local baseAttrList=cfg.attr or{}
for i,v in ipairs(baseAttrList)do
local attrId=v[1]
local attrCfgVal=v[2]
local attrVal=math.floor(attrCfgVal*attrRate+0.00001)
local name,valStr=equipsHelper.getAttr(attrId,attrVal)
attrChangeList[#attrChangeList+1]={FMT.fmt("{0}：",name),valStr}
end

attrChangeList[#attrChangeList+1]={"护盾值上限：",cfg.shield}
attrChangeList[#attrChangeList+1]={"每年回复护盾值：",cfg.recover}
attrChangeList[#attrChangeList+1]={"可进驻队伍：",cfg.team}

item:SetChildLayoutGroupCreateItems(levelItemCmpIndex.attrGridGroup,#attrChangeList,function(idx)
if _this==nil then return end
local attrItem=item:GetChildLayoutGroupGridItem(levelItemCmpIndex.attrGridGroup,idx-1)
local attrStrList=attrChangeList[idx]
attrItem:SetChildText(0,attrStrList[1])
attrItem:SetChildText(1,attrStrList[2])
attrItem:SetChildActive(-1,true)
end)


local changeSkillList={}
local lastSkillList={}
local lastLvCfg=self.allDaZhenCfg[level-1]
if lastLvCfg then
for i,v in ipairs(lastLvCfg.fazeShow)do
local fazeId=v[1]
local fazeLv=v[2]
lastSkillList[fazeId]=fazeLv
end
end
for i,v in ipairs(cfg.fazeShow)do
local fazeId=v[1]
local fazeLv=v[2]
local lastLvSkillLv=lastSkillList[fazeId]
local fazeCfg=cfgHelper.getSSlawRule(fazeId)
local icon=fazeCfg.image

local weight=#changeSkillList+1
local isChange=lastLvSkillLv~=fazeLv
if isChange then
weight=weight-1000
end
local skillItem={weight=weight,id=fazeId,level=fazeLv,icon=icon}
if not lastLvSkillLv then
skillItem.isActive=true
end
changeSkillList[#changeSkillList+1]=skillItem
end


















local lastBuffId=lastLvCfg.buff
local buffId=cfg.buff
if buffId then
local buffCfg=cfgHelper.get1(cfg_guildstateconfig_get,buffId)
local buffLevel=buffCfg.level
local icon=iconHelper.getzmStateIcon(buffCfg.icon)
local weight=#changeSkillList+1
local isChange=lastBuffId~=buffId
if isChange then
weight=weight-1000
end
changeSkillList[#changeSkillList+1]={weight=weight,id=buffId,level=buffLevel,isBuffSkill=true,isActive=lastBuffId==nil,icon=icon}
end

if next(changeSkillList)then

table.sort(changeSkillList,function(a,b)return
a.weight<b.weight
end)

item:SetChildActive(levelItemCmpIndex.skillScrollView,true)
item:SetChildActive(levelItemCmpIndex.notSkillTips,false)
local skillCount=#changeSkillList
item:SetChildScrollViewCreateGrids(levelItemCmpIndex.skillScrollView,skillCount,skillCount)
local skillGrids=item:GetChildScrollViewItemWidgets(levelItemCmpIndex.skillScrollView)
for idx=1,skillGrids.Count do
local skillItem=skillGrids[idx-1]
skillItem:SetChildActive(-1,true)
local skillData=changeSkillList[idx]

local skillIcon=skillData.icon

skillItem:SetChildIcon(0,skillIcon,false)

local changeStr=skillData.isActive and"激活"or FMT.fmt("{0}级",skillData.level)
skillItem:SetChildText(1,changeStr)

skillItem:SetChildButtonClick(0,function()
if _this==nil then return end
return _this:showWindow("UIShanMenDaZhen_skillTipsWin",{id=skillData.id,level=skillData.level,needDaZhenLv=level,isBuffSkill=skillData.isBuffSkill,isClientSkill=skillData.isClientSkill})
end)
end
local maxShowNum=3
local isEnableScroll=skillCount>maxShowNum
item:SetChildScrollRectEnable(levelItemCmpIndex.skillScrollView,isEnableScroll)
else
item:SetChildActive(levelItemCmpIndex.skillScrollView,false)
item:SetChildActive(levelItemCmpIndex.notSkillTips,true)
end
end





function UIShanMenDaZhen_lvPreviewWin:onCloseBtn()
self:closeSelf()
end



function UIShanMenDaZhen_lvPreviewWin:onMask()
self:onCloseBtn()
end


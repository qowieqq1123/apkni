







def_class("UILingShouXueMaiUpStageWin",UIWindowBase)









function UILingShouXueMaiUpStageWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.huoGrid=UIObject.get(self,1)
self.infoContent=UIObject.get(self,2)
self.infoScrollView=UIObject.get(self,3)
self.mask=UIObject.get(self,4)
self.modelRoot=UIObject.get(self,5)
self.newStageIcon=UIImage.get(self,6)
self.newStageTxt=UIText.get(self,7)
self.oldStageIcon=UIImage.get(self,8)
self.oldStageTxt=UIText.get(self,9)
self.root=UIObject.get(self,10)
self.root2=UIObject.get(self,11)
self.skillPanel=UIObject.get(self,12)
self.stageGrid=UIObject.get(self,13)
self.stageGrudMlayout=UIObject.get(self,14)
self.successEffect=UIObject.get(self,15)
self.titleBack=UIObject.get(self,16)



end


function UILingShouXueMaiUpStageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.huoGrid);self.huoGrid=nil;
_UIObject_release(self.infoContent);self.infoContent=nil;
_UIObject_release(self.infoScrollView);self.infoScrollView=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.newStageIcon);self.newStageIcon=nil;
_UIObject_release(self.newStageTxt);self.newStageTxt=nil;
_UIObject_release(self.oldStageIcon);self.oldStageIcon=nil;
_UIObject_release(self.oldStageTxt);self.oldStageTxt=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.stageGrid);self.stageGrid=nil;
_UIObject_release(self.stageGrudMlayout);self.stageGrudMlayout=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
end
















local _this

local _skillItemCmpIndex={
line=0,
icon=1,
effect=2,
effect2=3,
lock=4,
xin=5,
up=6,
}

local _attrItemCmpIndex={
item=0,
info1=1,
arraw=2,
info2=3,
moveLayout=4,
}

local _skillInfoItemCmpIndex={
icon=0,
effect=1,
name=2,
state=3,
desc=4,
xin=5,
moveLayout=6,
}

local _attrItemHight=25
local _attrItemPadding=10

local _skillItemHight=180
local _skillItemPadding=10

local _posYOffset=-1000




function UILingShouXueMaiUpStageWin:onLoaded(...)
self:bindComponents()

_this=self


self.attrItemList=self.attrGrid:getChildCommonLayoutGroupWidgetList()
self.skillInfoItemList=self.skillPanel:getChildCommonLayoutGroupWidgetList()
end


function UILingShouXueMaiUpStageWin:__delete()
_this=nil

self:unbindComponents()
end




function UILingShouXueMaiUpStageWin:onShow(argtable,afterOnloaded)

self.lsGuid=argtable.lsGuid
self.oldData=argtable.oldData

self.lsData=lingshouModel:getLingShouData2(self.lsGuid)
self.lsCfg=self.lsData.cfg

self:resetPlayAnim()

self:refreshAll()

self:playAnim()
end


function UILingShouXueMaiUpStageWin:onHide()

end







function UILingShouXueMaiUpStageWin:refreshAll()
self:refreshLeft()
self:refreshRight()
self:refreshOther()
end



function UILingShouXueMaiUpStageWin:refreshLeft()
self:refreshLingShouModel()

end

function UILingShouXueMaiUpStageWin:refreshLingShouModel()
local modelParams=lingshouModel:getLingShouInsideModelInfo(self.lsGuid)
local scale=self.lsCfg.modelScale

self.modelRoot:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,0,false,true)
self.modelRoot:setChildUIModelShowFlipX(true)
end




local _getChangeSkillList=function()
local lsID=_this.lsData.id

local oldjjlv=_this.oldData.jj_lvl
local oldxmlv=_this.oldData.xuemai_val
local oldjnlv=_this.oldData.skill_level
local oldjnplv=lingshouModel.getLingShouPropertyVal(_this.oldData,lingshouPropertyType.MAIN_SKILL_LEVEL)
local oldplv=lingshouModel.getLingShouPropertyVal(_this.oldData,lingshouPropertyType.PASSIVE_SKILL_LEVEL)

local newjjlv=_this.lsData.jj_lvl
local newxmlv=_this.lsData.xuemai_val
local newjnlv=_this.lsData.skill_level
local newjnplv=lingshouModel.getLingShouPropertyVal(_this.lsData,lingshouPropertyType.MAIN_SKILL_LEVEL)
local newplv=lingshouModel.getLingShouPropertyVal(_this.lsData,lingshouPropertyType.PASSIVE_SKILL_LEVEL)

local oldSkillList=lingshouModel.getSkillListEx(lsID,oldjjlv,oldxmlv,oldjnlv,oldjnplv,oldplv)
local newSkillList=lingshouModel.getSkillListEx(lsID,newjjlv,newxmlv,newjnlv,newjnplv,newplv)

for index,data in ipairs(newSkillList)do
local oldData=oldSkillList[index]
data.isNew=data[2]==1 and oldData[2]~=data[2]
data.isChange=oldData~=nil and data[2]>1 and oldData[2]~=data[2]
end
return newSkillList
end
function UILingShouXueMaiUpStageWin:refreshLingShouSkill()
self.skillLeftAnimDataList={}

local changeSkillList=_getChangeSkillList()

for index=1,self.skillItemList.Count do
local item=self.skillItemList[index-1]
local data=changeSkillList[index]
local isShow=data~=nil
item:SetChildActive(-1,isShow)
if isShow then
local skillID=data[1]
local skillLV=data[2]

local isXin=data.isNew and true or false
local isUp=data.isChange and true or false

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)

local isActive=skillLV>0

item:SetChildCSImageIcon(_skillItemCmpIndex.icon,skillIconName)
item:SetChildActive(_skillItemCmpIndex.lock,not isActive)
item:SetChildImageExGray(_skillItemCmpIndex.icon,not isActive)
item:SetChildActive(_skillItemCmpIndex.xin,isXin)
item:SetChildActive(_skillItemCmpIndex.up,isUp)

if isUp then
self.skillLeftAnimDataList[#self.skillLeftAnimDataList+1]={
widget=item,
isUp=true,
}
elseif isXin then
self.skillLeftAnimDataList[#self.skillLeftAnimDataList+1]={
widget=item,
isXin=true,
}
end

item:SetChildButtonClick(_skillItemCmpIndex.icon,function()
local args={skillID=skillID,skillLv=skillLV}
_this:showWindow('UIDiscipleJobSkillTipsWin',args)
end)

end
end
end



function UILingShouXueMaiUpStageWin:refreshRight()
self.hight=0

self:refreshStageChange()
self:refreshAttrChangeList()
self:refreshSkillChangeList()

self.infoContent:setChildSizeDelta(620,self.hight)
end

function UILingShouXueMaiUpStageWin:refreshStageChange()
local oldStageIdx,oldLevelIdx=lingshouModel:switchLevelToStageAndIdx_XueMai(_this.oldData.xuemai_val)
local oldStageIconName=lingshouModel:getStageIconName(oldStageIdx)
self.oldStageIcon:setCSImageSprite(globalABLookup.lingshouxuemai,oldStageIconName)
local isShowoldTxt=oldLevelIdx>0
self.oldStageTxt:setActive(isShowoldTxt)
if isShowoldTxt then
self.oldStageTxt:setText(string.format("+%d",oldLevelIdx))
end

local newStageIdx,newLevelIdx=lingshouModel:switchLevelToStageAndIdx_XueMai(_this.lsData.xuemai_val)
local newStageIconName=lingshouModel:getStageIconName(newStageIdx)
self.newStageIcon:setCSImageSprite(globalABLookup.lingshouxuemai,newStageIconName)
local isShownewTxt=newLevelIdx>0
self.newStageTxt:setActive(isShownewTxt)
if isShownewTxt then
self.newStageTxt:setText(string.format("+%d",newLevelIdx))
end
end



local _getChangeAttrList=function()
local infoList={}


local thispercent=lingshouModel:getLevelConfig2_XueMai(_this.lsData.id,_this.oldData.xuemai_val,'percent',_this.oldData.xuemai_dianshu)
local nextpercent=lingshouModel:getLevelConfig2_XueMai(_this.lsData.id,_this.lsData.xuemai_val,'percent',_this.lsData.xuemai_dianshu)

if nextpercent-thispercent>0 then
infoList[#infoList+1]={-1,thispercent,nextpercent}
end


local thisBaseAttrs=lingshouModel:getLevelConfig2_XueMai(_this.lsData.id,_this.oldData.xuemai_val,'attrs',_this.oldData.xuemai_dianshu)
local nextBaseAttrs=lingshouModel:getLevelConfig2_XueMai(_this.lsData.id,_this.lsData.xuemai_val,'attrs',_this.lsData.xuemai_dianshu)

local thisBaseAttrsLookUp=attrListHelper.tramsformToLookup(thisBaseAttrs)
local nextBaseAttrsLookUp=thisBaseAttrsLookUp
local diffBaseAttrsLookUp=thisBaseAttrsLookUp
local diffBaseAttrs=thisBaseAttrs

if nextBaseAttrs~=nil then
nextBaseAttrsLookUp=attrListHelper.tramsformToLookup(nextBaseAttrs)

diffBaseAttrsLookUp=attrListHelper.getChangeLookup(thisBaseAttrsLookUp,nextBaseAttrsLookUp)
diffBaseAttrs=attrListHelper.transformToList(diffBaseAttrsLookUp,thisBaseAttrs)
else
diffBaseAttrs={}
for index,info in ipairs(thisBaseAttrs)do
diffBaseAttrs[#diffBaseAttrs+1]={info[1],-info[2]}
end
end

for index,attr in ipairs(diffBaseAttrs)do
local bval=thisBaseAttrsLookUp[attr[1]]or 0
local nval=nextBaseAttrsLookUp[attr[1]]or 0
if nval-bval>0 then
table.insert(infoList,{attr[1],bval,nval})
end
end

return infoList
end
function UILingShouXueMaiUpStageWin:refreshAttrChangeList()
self.attrAnimDataList={}

local changeInfoList=_getChangeAttrList()

local isActive=#changeInfoList>0
self.attrGrid:setActive(isActive)
if not isActive then return end

for index=1,self.attrItemList.Count do
local item=self.attrItemList[index-1]
local info=changeInfoList[index]
local isShow=info~=nil and info[3]-info[2]>0
item:SetChildActive(-1,isShow)
if isShow then
local isShowArraw=info[3]>0
item:SetChildActive(_attrItemCmpIndex.arraw,isShowArraw)
item:SetChildActive(_attrItemCmpIndex.info2,isShowArraw)

if info[1]<0 then
local info1=FMT.fmt("基础属性：{0}",string.format("%s%%",info[2]))
item:SetChildText(_attrItemCmpIndex.info1,info1)
if isShowArraw then
item:SetChildText(_attrItemCmpIndex.info2,string.format("%s%%",info[3]))
end
else
local attrstr=helper.getAttributeStr(info[1],info[2],2,"{0}：{1}")
item:SetChildText(_attrItemCmpIndex.info1,attrstr)
if isShowArraw then
item:SetChildText(_attrItemCmpIndex.info2,helper.getAttributeStrEx(info[1],info[3],2))
end
end
end

local posY=-(index-1)*(_attrItemHight+_attrItemPadding)
item:SetChildAnchoredPos(-1,0,posY+_posYOffset)
item:SetChildCanvasGroupAlpha(-1,0)

self.attrAnimDataList[index]={
widget=item,
delayTime=0.05*(index-1),
posY=posY,
}
end
end

function UILingShouXueMaiUpStageWin:refreshSkillChangeList()
self.skillAnimDataList={}

local changeSkillList=_getChangeSkillList()

local newChangeSkillList={}
for _,data in ipairs(changeSkillList)do
if data.isChange then
newChangeSkillList[#newChangeSkillList+1]=data
data.sortWidget=10
end
if data.isNew then
newChangeSkillList[#newChangeSkillList+1]=data
data.sortWidget=100
end
end

table.sort(newChangeSkillList,function(a,b)
if a.sortWidget==b.sortWidget then
return a[1]<b[1]
else
return a.sortWidget>b.sortWidget
end
end)

for index=1,self.skillInfoItemList.Count do
local item=self.skillInfoItemList[index-1]
local data=newChangeSkillList[index]
local isShow=data~=nil
item:SetChildActive(-1,isShow)
if isShow then
local skillID=data[1]
local skillLV=data[2]

local isXin=data.isNew and true or false

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)

item:SetChildCSImageIcon(_skillInfoItemCmpIndex.icon,skillIconName)

local skillName=skillCfg.name
item:SetChildText(_skillInfoItemCmpIndex.name,string.format("【%s】",skillName))

local state=""
if data.isNew then
state="已激活"
elseif data.isChange then
state=FMT.fmt("等级：{0}级",skillLV)
end
item:SetChildText(_skillInfoItemCmpIndex.state,state)

local skillDesc=skillModel:getSkillDesc(skillID,skillLV)
item:SetChildText(_skillInfoItemCmpIndex.desc,skillDesc)

item:SetChildActive(_skillInfoItemCmpIndex.xin,isXin)
end

local posY=-(index-1)*(_skillItemHight+_skillItemPadding)
item:SetChildAnchoredPos(-1,0,posY+_posYOffset)
item:SetChildCanvasGroupAlpha(-1,0)

self.skillAnimDataList[index]={
widget=item,
delayTime=0.2*(index-1),
posY=posY,
}
end
end



function UILingShouXueMaiUpStageWin:refreshOther()

end





function UILingShouXueMaiUpStageWin:resetPlayAnim()
self.root:setChildCanvasGroupAlpha(0)
self.root2:setChildCanvasGroupAlpha(0)
self.attrGrid:setChildCanvasGroupAlpha(0)
self.skillPanel:setChildCanvasGroupAlpha(0)
end



function UILingShouXueMaiUpStageWin:playAnim()
self.successEffect:setChildShowEffect(10010,true)

local delayTime=0

delayTime=delayTime+0.1
self:delayDo(delayTime,function()
self.root2:setChildCanvasGroupDOFade(1,0.3,function()
for _,animData in ipairs(self.skillLeftAnimDataList)do
if animData.isUp then
animData.widget:SetChildEffectPlay(_skillItemCmpIndex.effect,10011,false)
elseif animData.isXin then
animData.widget:SetChildEffectPlay(_skillItemCmpIndex.effect,10012,false)
end
end
end)
end)
delayTime=delayTime+0.3

self:delayDo(delayTime,function()
self.root:setChildCanvasGroupDOFade(1,0.1)
end)
delayTime=delayTime+0.1

local attrTotalDelay=0
self:delayDo(delayTime,function()
self.attrGrid:setChildCanvasGroupDOFade(1,0.1)

for _,animData in ipairs(self.attrAnimDataList)do
self:delayDo(animData.delayTime,function()
animData.widget:SetChildCanvasGroupDOFade(-1,1,0.1)
animData.widget:SetChildDOLocalMoveY(-1,animData.posY,0.1)
end)
attrTotalDelay=attrTotalDelay+animData.delayTime
end
end)
delayTime=delayTime+0.3+attrTotalDelay

self:delayDo(delayTime,function()
self.skillPanel:setChildCanvasGroupDOFade(1,0.3)

for _,animData in ipairs(self.skillAnimDataList)do
self:delayDo(animData.delayTime,function()
animData.widget:SetChildCanvasGroupDOFade(-1,1,0.3)
animData.widget:SetChildDOLocalMoveY(-1,animData.posY,0.3)
end)
end
end)
end




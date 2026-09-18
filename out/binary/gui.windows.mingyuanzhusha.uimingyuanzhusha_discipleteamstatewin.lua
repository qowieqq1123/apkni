







def_class("UIMingYuanZhuSha_DiscipleTeamStateWin",UIWindowBase)









function UIMingYuanZhuSha_DiscipleTeamStateWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.discipleStateScrollView=UILoopListView.new(self,1)
self.highMask=UIButton.get(self,2)
self.Root=UIObject.get(self,3)
self.ruleBtn=UIButton.get(self,4)
self.rulePanel=UIObject.get(self,5)
self.ruleScrollview=UIScrollView.get(self,6)
self.uiRoot=UIObject.get(self,7)

self.discipleStateScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.highMask:setButtonClick(function()self:onHighMask()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UIMingYuanZhuSha_DiscipleTeamStateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
self.discipleStateScrollView:deleteSelf();self.discipleStateScrollView=nil;
_UIObject_release(self.highMask);self.highMask=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.rulePanel);self.rulePanel=nil;
_UIObject_release(self.ruleScrollview);self.ruleScrollview=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _itemCmpIndex={
headInfo=0,
headBg=1,
head=2,
voc=3,
hpBg=4,
hpBar=5,
hpBarTxt=6,
infoList=7,
nameInfo=8,
name=9,
fightInfo=10,
fight=11,
fightDefInfo=12,
fightDef=13,
llValBg=14,
llVal=15,
llEffectDesc=16,
noEffectDesc=17,
}




function UIMingYuanZhuSha_DiscipleTeamStateWin:onLoaded(...)
self:bindComponents()

_this=self








local _bindRuleScrollWidget=function(...)
if _this==nil then return end
_this:bindRuleScrollWidget(...)
end
self.ruleScrollview:bindScrollWidget(_bindRuleScrollWidget)

self.energy_effect=myzsModel:getBaseConfig('energy_effect')
end


function UIMingYuanZhuSha_DiscipleTeamStateWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_DiscipleTeamStateWin:onShow(argtable,afterOnloaded)


self:refreshAll()
end


function UIMingYuanZhuSha_DiscipleTeamStateWin:onHide()

end

function UIMingYuanZhuSha_DiscipleTeamStateWin:onShowArgRecv(argtable)

end

function UIMingYuanZhuSha_DiscipleTeamStateWin:refreshAll()
self:refreshDiscipleStateScrollView()
end


function UIMingYuanZhuSha_DiscipleTeamStateWin:refreshDiscipleStateScrollView()
self.discipleList=myzsModel:getDiscipleList()

table.sort(self.discipleList,function(a,b)
return a.sortWidget>b.sortWidget
end)

self.discipleStateScrollView:initData('myzs_discipleStateItem',self.discipleList)





end

function UIMingYuanZhuSha_DiscipleTeamStateWin:onStartAction()end
function UIMingYuanZhuSha_DiscipleTeamStateWin:onFreshAction(index,item)
self:bindDisicpleStateItem(index,item)
end

function UIMingYuanZhuSha_DiscipleTeamStateWin:bindDisicpleStateItem(index,item)
local discipleData=self.discipleList[index]

local discipleGuid=discipleData.discipleGuid

local isGray=discipleData.hpPercent<=0


comHelper.setChildModelHeadIconBG(item,_itemCmpIndex.headBg,discipleGuid)

comHelper.setChildModelRawImage(item,discipleGuid,_itemCmpIndex.head,0,eHeadCenterType.eHead,1,isGray)

local jobIcon=UIDiscipleModel:getJobIconNameX(discipleGuid)
item:SetChildCSImageSprite(_itemCmpIndex.voc,globalABLookup.global,jobIcon)

item:SetChildGray(_itemCmpIndex.headBg,isGray)
item:SetChildGray(_itemCmpIndex.voc,isGray)


item:SetChildIconFillAmount(_itemCmpIndex.hpBar,discipleData.hpPercent/100)
item:SetChildText(_itemCmpIndex.hpBarTxt,string.format("%d%%",discipleData.hpPercent))


local discipleName=UIDiscipleModel:getDiscipleName(discipleGuid)
item:SetChildText(_itemCmpIndex.name,discipleName)


item:SetChildText(_itemCmpIndex.fight,mathHelper.formatNumber4(discipleData.fightVal,2))


local discount=myzsModel:getFightDiscountForLingLi(discipleData.llPercent)
item:SetChildText(_itemCmpIndex.fightDef,string.format("%d%%",discount))


local llStrColor=discipleData.llPercent>0 and"#549327"or"#f36666"
item:SetChildText(_itemCmpIndex.llVal,FMT.fmt("灵力：<color={0}>{1}%</color>",llStrColor,discipleData.llPercent))


local isHasEffect=discount>0
item:SetChildActive(_itemCmpIndex.llEffectDesc,isHasEffect)
item:SetChildActive(_itemCmpIndex.noEffectDesc,not isHasEffect)
if isHasEffect then
local desc=myzsModel:getLingLiFightDefEffectDesc(discount,"{0}\n{1}",'#c82c2c')
item:SetChildText(_itemCmpIndex.llEffectDesc,desc)
end
end

function UIMingYuanZhuSha_DiscipleTeamStateWin:freshRulePanel()
local len=#self.energy_effect+1

self.ruleScrollview:freshGridsNum(len,len,1,false)
end

local _ruleInfoCmpIndex={
info1=0,
info2=1,
info3=2,
}
function UIMingYuanZhuSha_DiscipleTeamStateWin:bindRuleScrollWidget(index,item)
local data
if index==1 then
local max=myzsModel:getBaseConfig('energy_init')
data={max,0,{}}
else
data=self.energy_effect[index-1]
end

local isShow=data~=nil
item:SetChildActive(-1,isShow)
if not isShow then return end

item:SetChildText(_ruleInfoCmpIndex.info1,string.format("%d%%",data[1]))


local defVal=string.format("%d%%",data[2])
defVal=data[2]>0 and toColorStringX("#f36666",defVal)or defVal
item:SetChildText(_ruleInfoCmpIndex.info2,defVal)

local effectDesc=myzsModel:getLingLiFightDefEffectDesc(data[2],"{0}\n{1}",'#f36666')or"暂无效果影响"

item:SetChildText(_ruleInfoCmpIndex.info3,effectDesc)
end





function UIMingYuanZhuSha_DiscipleTeamStateWin:onHighMask()
self.isShowRulePanel=false
self.rulePanel:setActive(false)
self.highMask:setActive(false)
end



function UIMingYuanZhuSha_DiscipleTeamStateWin:onRuleBtn()
self.isShowRulePanel=true
self.highMask:setActive(true)
self.rulePanel:setActive(true)
self:freshRulePanel()
end


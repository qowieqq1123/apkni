







def_class("UIMingYuanZhuSha_SelectDiscipleWin",UIWindowBase)








function UIMingYuanZhuSha_SelectDiscipleWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.discipleInfo_1=UIBaseItem.get(self,3)
self.discipleInfo_2=UIBaseItem.get(self,4)
self.discipleInfo_3=UIBaseItem.get(self,5)
self.discipleInfo_4=UIBaseItem.get(self,6)
self.discipleInfo_5=UIBaseItem.get(self,7)
self.discipleInfoPart=UIObject.get(self,8)
self.discipleScrollView=UIScrollView.get(self,9)
self.discpleInfoList=UIObject.get(self,10)
self.highMask=UIButton.get(self,11)
self.quickOpBtn=UIButton.get(self,12)
self.quickOpBtnTxt=UIText.get(self,13)
self.Root=UIObject.get(self,14)
self.ruleBtn=UIButton.get(self,15)
self.rulePanel=UIObject.get(self,16)
self.ruleScrollview=UIScrollView.get(self,17)
self.teamFightVal=UIText.get(self,18)
self.uiRoot=UIObject.get(self,19)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.highMask:setButtonClick(function()self:onHighMask()end)

self.quickOpBtn:setButtonClick(function()self:onQuickOpBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.discipleInfo={
self.discipleInfo_1,
self.discipleInfo_2,
self.discipleInfo_3,
self.discipleInfo_4,
self.discipleInfo_5,
}



end


function UIMingYuanZhuSha_SelectDiscipleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.discipleInfo_1);self.discipleInfo_1=nil;
_UIObject_release(self.discipleInfo_2);self.discipleInfo_2=nil;
_UIObject_release(self.discipleInfo_3);self.discipleInfo_3=nil;
_UIObject_release(self.discipleInfo_4);self.discipleInfo_4=nil;
_UIObject_release(self.discipleInfo_5);self.discipleInfo_5=nil;
_UIObject_release(self.discipleInfoPart);self.discipleInfoPart=nil;
_UIObject_release(self.discipleScrollView);self.discipleScrollView=nil;
_UIObject_release(self.discpleInfoList);self.discpleInfoList=nil;
_UIObject_release(self.highMask);self.highMask=nil;
_UIObject_release(self.quickOpBtn);self.quickOpBtn=nil;
_UIObject_release(self.quickOpBtnTxt);self.quickOpBtnTxt=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.rulePanel);self.rulePanel=nil;
_UIObject_release(self.ruleScrollview);self.ruleScrollview=nil;
_UIObject_release(self.teamFightVal);self.teamFightVal=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.discipleInfo=nil;
end
















local _this
local _col=2
local _selectCount=5

local _discipleItemCmpIndex={
bg=0,
select=1,
colorframe=2,
head=3,
xianmo=4,
name=5,
fighttxt=6,
infoList=7,
hpInfo=8,
hpProgress=9,
hpProgressbar=10,
hpProgressText=11,
lingLiInfo=12,
lingLiVal=13,
fightDef=14,
fightDefval=15,
voc=16,
}

local _discipleTeamItemCmpIndex={
emptyAdd=0,
hasDis=1,
discipleInfo=2,
kuangBg=3,
head=4,
voc=5,
lingli=6,
llicon=7,
llval=8,
}




function UIMingYuanZhuSha_SelectDiscipleWin:onLoaded(...)
self:bindComponents()

_this=self

local _bindScrollWidget=function(...)
if _this==nil then return end
_this:bindScrollWidget(...)
end
self.discipleScrollView:bindScrollWidget(_bindScrollWidget)

local _bindRuleScrollWidget=function(...)
if _this==nil then return end
_this:bindRuleScrollWidget(...)
end
self.ruleScrollview:bindScrollWidget(_bindRuleScrollWidget)

self.energy_effect=myzsModel:getBaseConfig('energy_effect')

end


function UIMingYuanZhuSha_SelectDiscipleWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_SelectDiscipleWin:onShow(argtable,afterOnloaded)


self:initData()
self:refreshAll()
end


function UIMingYuanZhuSha_SelectDiscipleWin:onHide()

end



function UIMingYuanZhuSha_SelectDiscipleWin:initData()
self.isShowRulePanel=false

self.discipleScrollviewItemLookup={}

self.originalDiscipleTeamList=myzsModel:getDiscipleTeamList()
self.discipleTeamList=table.weakCopy(self.originalDiscipleTeamList)

self.disciplePosLookUp={}
self:updateDisciplePosLookup()

self.discipleTeamFightVal=self:calculateDiscipleTeamFightVal()

self.discipleList=myzsModel:getDiscipleList()

if self.discipleList and#self.discipleList>1 then
local discipleSortWidgetLookUp={}

for index,data in ipairs(self.discipleList)do
local discipleGuidStr=data.discipleGuidStr
discipleSortWidgetLookUp[discipleGuidStr]=self.disciplePosLookUp[discipleGuidStr]and 1 or 0
end

table.sort(self.discipleList,function(a,b)
local aval=discipleSortWidgetLookUp[a.discipleGuidStr]
local bval=discipleSortWidgetLookUp[b.discipleGuidStr]

if aval==bval then
if a.hpPercent>0 and b.hpPercent>0 then
return a.fightVal>b.fightVal
else
return a.hpPercent>b.hpPercent
end
else
return aval>bval
end
end)
end
end

function UIMingYuanZhuSha_SelectDiscipleWin:updateDisciplePosLookup()
table.clear(self.disciplePosLookUp)

if next(self.discipleTeamList)==nil then return end

for index,discipleData in ipairs(self.discipleTeamList)do
local guidStr=tostring(discipleData.discipleGuid)
self.disciplePosLookUp[guidStr]=index
end
end

function UIMingYuanZhuSha_SelectDiscipleWin:calculateDiscipleTeamFightVal()
local discipleTeamFightVal=0

if next(self.discipleTeamList)==nil then return discipleTeamFightVal end

for index,discipleData in ipairs(self.discipleTeamList)do
local guid=discipleData.discipleGuid
local fightVal=UIDiscipleModel:getDiscipleFightValue(guid)
fightVal=myzsModel:getDiscipleFightValForLingLi2(fightVal,discipleData.llPercent)
discipleTeamFightVal=discipleTeamFightVal+fightVal
end

return discipleTeamFightVal
end





function UIMingYuanZhuSha_SelectDiscipleWin:refreshAll()
self:refreshDiscipleScrollView()
self:refreshDiscipleTeamList()
self:refreshBtns()
end

function UIMingYuanZhuSha_SelectDiscipleWin:refreshDiscipleScrollView()
table.clear(self.discipleScrollviewItemLookup)

local discipleLen=#self.discipleList
local raw=mathHelper.safe_ceil(discipleLen/_col)

self.discipleScrollView:freshGridsNum(discipleLen,raw,_col,self.discipleScrollviewZero)
self.discipleScrollviewZero=true
end

function UIMingYuanZhuSha_SelectDiscipleWin:refreshDiscipleTeamList()
for index,obj in ipairs(self.discipleInfo)do
self:refreshDiscipleItem(obj,index)
end

self:refreshDiscpleTeamFightVal()
end

function UIMingYuanZhuSha_SelectDiscipleWin:refreshDiscipleItem(obj,index)
local discipleItem=obj:getWidgetBase()

local discipleData=self.discipleTeamList[index]
local isHas=discipleData~=nil
discipleItem:SetChildActive(_discipleTeamItemCmpIndex.emptyAdd,not isHas)
discipleItem:SetChildActive(_discipleTeamItemCmpIndex.hasDis,isHas)

if isHas then
local discipleguid=discipleData.discipleGuid
comHelper.setChildModelHeadIconBG(discipleItem,_discipleTeamItemCmpIndex.kuangBg,discipleguid)

comHelper.setChildModelRawImage(discipleItem,discipleguid,_discipleTeamItemCmpIndex.head,0,eHeadCenterType.eHead)

local jobIcon=UIDiscipleModel:getJobIconNameX(discipleguid)
discipleItem:SetChildCSImageSprite(_discipleTeamItemCmpIndex.voc,globalABLookup.global,jobIcon)



end

end

function UIMingYuanZhuSha_SelectDiscipleWin:refreshDiscpleTeamFightVal()
self.discipleTeamFightVal=self:calculateDiscipleTeamFightVal()

self.teamFightVal:setText(mathHelper.formatNumber4(self.discipleTeamFightVal,2))
end

function UIMingYuanZhuSha_SelectDiscipleWin:refreshBtns()
local selectedCount=#self.discipleTeamList
self.quickOpBtnTxt:setText(selectedCount>=_selectCount and'一键下阵'or'一键上阵')
end


function UIMingYuanZhuSha_SelectDiscipleWin:bindScrollWidget(index,item)
local data=self.discipleList[index]
local isShow=data~=nil
item:SetChildActive(-1,isShow)
if not isShow then return end

local discipleGuidStr=data.discipleGuidStr
local discipleGuid=data.discipleGuid
local discipleData=UIDiscipleModel:getDiscipleData(discipleGuid)

self.discipleScrollviewItemLookup[discipleGuidStr]=item


local color=UIDiscipleModel:getDiscipleColor(discipleGuid)
item:SetChildCSImageSprite(_discipleItemCmpIndex.colorframe,globalABLookup.diciplecolorframe,discipleColorToFrame[color])


comHelper.setChildModelRawImage(item,discipleGuid,_discipleItemCmpIndex.head,0,eHeadCenterType.eHalf,nil,false)


local name=UIDiscipleModel:getDiscipleName(discipleGuid)
item:SetChildText(_discipleItemCmpIndex.name,name)

local jobIcon=UIDiscipleModel:getJobIconNameX(discipleGuid)
item:SetChildCSImageSprite(_discipleItemCmpIndex.voc,globalABLookup.global,jobIcon)

item:SetChildText(_discipleItemCmpIndex.fighttxt,mathHelper.formatNumber4(data.fightVal,2))


local xm_voc=discipleData and(discipleData.xianmo_voc or 0)or 0
if xm_voc==1 then
item:SetChildCSImageSprite(_discipleItemCmpIndex.xianmo,'ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab','image_xmdj_3')
elseif xm_voc==2 then
item:SetChildCSImageSprite(_discipleItemCmpIndex.xianmo,'ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab','image_xmdj_4')
end
item:SetChildActive(_discipleItemCmpIndex.xianmo,xm_voc==1 or xm_voc==2)


item:SetChildText(_discipleItemCmpIndex.hpProgressText,string.format("%d%%",data.hpPercent))
item:SetChildIconFillAmount(_discipleItemCmpIndex.hpProgressbar,data.hpPercent/100)


item:SetChildText(_discipleItemCmpIndex.lingLiVal,string.format("%d%%",data.llPercent))


local discount=myzsModel:getFightDiscountForLingLi(data.llPercent)
item:SetChildText(_discipleItemCmpIndex.fightDefval,string.format("%d%%",discount))


local isSelect=self.disciplePosLookUp[discipleGuidStr]~=nil
item:SetChildActive(_discipleItemCmpIndex.select,isSelect)

item:SetBaseItemClickEvent(-1,function()
if _this==nil then return end
if data.llPercent<=0 then
UIManager.info('弟子灵力不足')
return
end
if data.hpPercent<=0 then
UIManager.info('弟子已阵亡')
return
end

local mIndex=_this.disciplePosLookUp[discipleGuidStr]
local mIsSelect=mIndex~=nil
if mIsSelect then
table.remove(_this.discipleTeamList,mIndex)
_this:updateDisciplePosLookup()
else
local count=#_this.discipleTeamList
if count>=_selectCount then UIManager.info("队伍弟子已满")return end
table.insert(_this.discipleTeamList,data)
_this:updateDisciplePosLookup()
end

item:SetChildActive(_discipleItemCmpIndex.select,not mIsSelect)

_this:refreshBtns()
_this:refreshDiscipleTeamList()
end)
end


function UIMingYuanZhuSha_SelectDiscipleWin:freshRulePanel()
local len=#self.energy_effect+1

self.ruleScrollview:freshGridsNum(len,len,1,false)
end

local _ruleInfoCmpIndex={
info1=0,
info2=1,
info3=2,
}
function UIMingYuanZhuSha_SelectDiscipleWin:bindRuleScrollWidget(index,item)
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


local effectDesc=data.desc or"暂无效果影响"

item:SetChildText(_ruleInfoCmpIndex.info3,effectDesc)
end







function UIMingYuanZhuSha_SelectDiscipleWin:onCloseBtn()
self:closeSelf()
end



function UIMingYuanZhuSha_SelectDiscipleWin:onCommitBtn()
UIManager.info("选择成功")
myzsModel:setDiscipleTeamList(self.discipleTeamList)
self:onCloseBtn()
end



function UIMingYuanZhuSha_SelectDiscipleWin:onHighMask()
self.isShowRulePanel=false
self.rulePanel:setActive(false)
self.highMask:setActive(false)
end



function UIMingYuanZhuSha_SelectDiscipleWin:onQuickOpBtn()
local selectedCount=#self.discipleTeamList

if selectedCount>=_selectCount then

for index,data in ipairs(_this.discipleTeamList)do
local discipleGuidStr=data.discipleGuidStr
local item=self.discipleScrollviewItemLookup[discipleGuidStr]
item:SetChildActive(_discipleItemCmpIndex.select,false)
end
table.clear(_this.discipleTeamList)
else
for index,data in ipairs(self.discipleList)do
local discipleGuidStr=data.discipleGuidStr
local isSelect=self.disciplePosLookUp[discipleGuidStr]~=nil
if not isSelect and data.llPercent>0 and data.hpPercent>0 then
selectedCount=selectedCount+1
local item=self.discipleScrollviewItemLookup[discipleGuidStr]
item:SetChildActive(_discipleItemCmpIndex.select,true)
table.insert(_this.discipleTeamList,data)
if selectedCount>=_selectCount then
break
end
end
end
end

_this:refreshBtns()
_this:updateDisciplePosLookup()
_this:refreshDiscipleTeamList()
end

function UIMingYuanZhuSha_SelectDiscipleWin:onRuleBtn()

self.isShowRulePanel=true
self.highMask:setActive(true)
self.rulePanel:setActive(true)
self:freshRulePanel()
end



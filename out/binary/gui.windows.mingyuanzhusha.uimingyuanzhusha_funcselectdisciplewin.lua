







def_class("UIMingYuanZhuSha_FuncSelectDiscipleWin",UIWindowBase)









function UIMingYuanZhuSha_FuncSelectDiscipleWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.commitTxt=UIText.get(self,3)
self.costPart=UIObject.get(self,4)
self.costTxt=UIText.get(self,5)
self.discipleScrollView=UIScrollView.get(self,6)
self.moneyIcon=UIObject.get(self,7)
self.noDisciple=UIObject.get(self,8)
self.noDisicple=UIObject.get(self,9)
self.Root=UIObject.get(self,10)
self.uiRoot=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIMingYuanZhuSha_FuncSelectDiscipleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitTxt);self.commitTxt=nil;
_UIObject_release(self.costPart);self.costPart=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.discipleScrollView);self.discipleScrollView=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.noDisciple);self.noDisciple=nil;
_UIObject_release(self.noDisicple);self.noDisicple=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end















local _this
local _col=2

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
}





function UIMingYuanZhuSha_FuncSelectDiscipleWin:onLoaded(...)
self:bindComponents()

_this=self

local _bindScrollWidget=function(...)
if _this==nil then return end
_this:bindScrollWidget(...)
end
self.discipleScrollView:bindScrollWidget(_bindScrollWidget)
end


function UIMingYuanZhuSha_FuncSelectDiscipleWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_FuncSelectDiscipleWin:onShow(argtable,afterOnloaded)
self.funcType=argtable.funcType
self.commitBtnTxt=argtable.commitBtnTxt
self.cost=argtable.cost
self.selectDiscipleCount=argtable.selectDiscipleCount or 1
self.commitCallBack=argtable.commitCallBack

self:initData()
self:refreshAll()

end


function UIMingYuanZhuSha_FuncSelectDiscipleWin:onHide()

end

function UIMingYuanZhuSha_FuncSelectDiscipleWin:initData()
self.selectDiscipleList={}

self.disciplePosLookUp={}
self.discipleList=myzsModel:getDiscipleList()

if self.funcType==MYZSMerchantShopType.eRevival then
local temp={}

for index,data in ipairs(self.discipleList)do
if data.hpPercent==0 then
temp[#temp+1]=data
end
end
self.discipleList=temp

table.sort(self.discipleList,function(a,b)
return a.fightVal>b.fightVal
end)
elseif self.funcType==MYZSMerchantShopType.eRecovery then
local max=myzsModel:getBaseConfig('energy_init')
local temp={}

for index,data in ipairs(self.discipleList)do
if data.llPercent~=max then
temp[#temp+1]=data
end
end
self.discipleList=temp
table.sort(self.discipleList,function(a,b)
if a.llPercent==b.llPercent then
return a.fightVal>b.fightVal
else
return a.llPercent<b.llPercent
end
end)
end
end

function UIMingYuanZhuSha_FuncSelectDiscipleWin:refreshAll()
self:refreshDiscipleScrollView()
self:refreshCost()
end

function UIMingYuanZhuSha_FuncSelectDiscipleWin:refreshCost()
local moneyId=myzsModel:getBaseConfig('money_type')
local iconName=iconHelper.getIconName(moneyId)
self.moneyIcon:setChildIcon(iconName,false)

self.costTxt:setText(self.cost)
end


function UIMingYuanZhuSha_FuncSelectDiscipleWin:refreshDiscipleScrollView()

local discipleLen=#self.discipleList
local isShow=discipleLen>0
self.noDisciple:setActive(not isShow)
self.discipleScrollView:setActive(isShow)

if not isShow then return end

local raw=mathHelper.safe_ceil(discipleLen/_col)
if discipleLen>=0 then
self.noDisciple:setActive(false)
else
self.noDisciple:setActive(true)
end
self.discipleScrollView:freshGridsNum(discipleLen,raw,_col,self.discipleScrollviewZero)
self.discipleScrollviewZero=true
end

function UIMingYuanZhuSha_FuncSelectDiscipleWin:bindScrollWidget(index,item)
local data=self.discipleList[index]
local isShow=data~=nil
item:SetChildActive(-1,isShow)
if not isShow then return end

local discipleGuidStr=data.discipleGuidStr
local discipleGuid=data.discipleGuid
local discipleData=UIDiscipleModel:getDiscipleData(discipleGuid)


local color=UIDiscipleModel:getDiscipleColor(discipleGuid)
item:SetChildCSImageSprite(_discipleItemCmpIndex.colorframe,globalABLookup.diciplecolorframe,discipleColorToFrame[color])


comHelper.setChildModelRawImage(item,discipleGuid,_discipleItemCmpIndex.head,0,eHeadCenterType.eHalf,nil,false)


local name=UIDiscipleModel:getDiscipleName(discipleGuid)
item:SetChildText(_discipleItemCmpIndex.name,name)

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




item:SetChildActive(_discipleItemCmpIndex.fightDef,false)


local isSelect=self.disciplePosLookUp[discipleGuidStr]~=nil
item:SetChildActive(_discipleItemCmpIndex.select,isSelect)

item:SetBaseItemClickEvent(-1,function()
if _this==nil then return end

local mIndex=_this.disciplePosLookUp[discipleGuidStr]
local mIsSelect=mIndex~=nil
if mIsSelect then
table.remove(_this.selectDiscipleList,mIndex)
_this:updateDisciplePosLookup()
else

local smindex=next(_this.selectDiscipleList,mIndex)
if smindex~=nil then
local pindex=table.remove(_this.selectDiscipleList,mIndex)
local pitem=_this.discipleScrollView:getGridObjectByindex(pindex-1)
pitem:SetChildActive(_discipleItemCmpIndex.select,false)
end

local count=#_this.selectDiscipleList
if count>=self.selectDiscipleCount then UIManager.info("已选择弟子")return end
table.insert(_this.selectDiscipleList,index)
_this:updateDisciplePosLookup()
end

item:SetChildActive(_discipleItemCmpIndex.select,not mIsSelect)
end)
end

function UIMingYuanZhuSha_FuncSelectDiscipleWin:updateDisciplePosLookup()
table.clear(self.disciplePosLookUp)

if next(self.selectDiscipleList)==nil then return end

for index,dindex in ipairs(self.selectDiscipleList)do
local discipleData=self.discipleList[dindex]
local guidStr=tostring(discipleData.discipleGuid)
self.disciplePosLookUp[guidStr]=index
end
end




function UIMingYuanZhuSha_FuncSelectDiscipleWin:onCloseBtn()
self:closeSelf()
end



function UIMingYuanZhuSha_FuncSelectDiscipleWin:onCommitBtn()
if#self.selectDiscipleList~=self.selectDiscipleCount then
UIManager.info("请选择弟子")
return
end

if self.commitCallBack then
local guidList={}

for index,dindex in ipairs(self.selectDiscipleList)do
local data=self.discipleList[dindex]
guidList[index]=data.discipleGuid
end

self.commitCallBack(guidList)
end

self:onCloseBtn()
end










def_class("UIWorldDiscipleSelectDialog",UIWindowBase)







local itemKid={
selected=0,
lock=1,
recommend=2,
discipleIcon=3,
discipleName=4,
discipleSymbol=5,
noEffectTx=6,
effectBtn=7,
reason=8,
otherTx={9,10,11},
element={12,13,14,15,16},
}
local _this=nil
local _select=nil

function UIWorldDiscipleSelectDialog:bindComponents()

self.TitleTx=UIText.get(self,0)
self.ButtonTx=UIText.get(self,1)
self.CostTips=UIText.get(self,2)
self.CostNum=UIText.get(self,3)
self.CostIcon=UIImage.get(self,4)
self.ScrollView=UIScrollView.get(self,5)
self.Titles={}
for i=6,10 do
table.insert(self.Titles,UIText.get(self,i))
end

self.ScrollView:setClickAction(self.onClickItem)


end


function UIWorldDiscipleSelectDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.ButtonTx);self.ButtonTx=nil;
_UIObject_release(self.CostTips);self.CostTips=nil;
_UIObject_release(self.CostNum);self.CostNum=nil;
_UIObject_release(self.CostIcon);self.CostIcon=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
for i,v in ipairs(self.Titles)do
_UIObject_release(v);
end
self.Titles=nil
end



















function UIWorldDiscipleSelectDialog:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWorldDiscipleSelectDialog:__delete()
self:unbindComponents()
_this=nil
_select=nil
end




















function UIWorldDiscipleSelectDialog:onShow(argtable,afterOnloaded)
self.closeCB=argtable.closeCB
self.okCB=argtable.okCB
self.cost=argtable.cost
self.titleName=argtable.titleName
self.data=argtable.data
self.TitleTx:setText(argtable.titleTx)
self.ButtonTx:setText(argtable.buttonTx)
if self.cost then
self.CostTips:setActive(true)
self.CostNum:setText(self.cost[2])
self.CostIcon:setIcon(iconHelper.getIconName(self.cost[1]),false)
end
for i,v in ipairs(self.Titles)do
local titleName=self.titleName[i]
local show=titleName~=nil
v:setActive(show)
if show then
v:setText(titleName)
end
end
local cnt=#self.data
self.ScrollView:freshGridsNum(cnt,cnt,1,false)
for i=1,cnt do
local item=self.ScrollView:getGridObjectByindex(i-1)
local data=self.data[i]
for j,w in ipairs(itemKid.element)do
local haveRecommend=data.recommend or false
item:SetChildActive(itemKid.recommend,haveRecommend)
item:SetChildActive(itemKid.lock,data.reason~=nil)
if self.titleName[j]then
if j==1 then

local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(data.discipleguid)
item:SetChildModelCaptureImage(itemKid.discipleIcon,modelParams.body,modelParams.componets,1,0,modelParams.offset[1],modelParams.offset[2],0,0,128,128)


item:SetChildText(itemKid.discipleName,UIDiscipleModel:getDiscipleName(data.discipleguid))

local showicon=nil

local injury=UIDiscipleModel:getDiscipleInjury(data.discipleguid)
local injuryType=eInjuryType.getType(injury)
local lowloyalty=UIDiscipleModel:checkLowLoyalty(data.discipleguid)
if injuryType>eInjuryType.eHealth then
showicon=eInjuryType:getIconEx(injuryType)
end

if lowloyalty then
if injuryType~=eInjuryType.eImminent then
showicon='image_zhuangtai_4'
end
end
local isshowicon=showicon~=nil
item:SetChildActive(itemKid.discipleSymbol,isshowicon)
if isshowicon then
item:SetChildCSImageSprite(itemKid.discipleSymbol,globalABLookup.global,showicon)
end
elseif j==#itemKid.element then
item:SetChildButtonClickWithID(itemKid.effectBtn,self.onClickEffectBtn,i,true)
local haveEffect=data.effects and#data.effects>0 or false
item:SetChildActive(itemKid.effectBtn,haveEffect)
item:SetChildActive(itemKid.noEffectTx,not haveEffect)
item:SetChildText(itemKid.reason,data.reason or"")
else
local otherIdx=j-1
local otherStr=data.others and data.others[otherIdx]or""
item:SetChildText(itemKid.otherTx[otherIdx],otherStr)
end
end
end
end

self.onClickItem(0,1,nil,nil)
end


function UIWorldDiscipleSelectDialog:onHide()

end



function UIWorldDiscipleSelectDialog:onClickClose()
if self.closeCB then self.closeCB()end
self:closeSelf()
end

function UIWorldDiscipleSelectDialog:onClickButton()
if self.cost and not moneyModel.checkEnoughMoney(self.cost[1],self.cost[2])then
gainControl:showGainWin(self.cost[1])
return UIManager.error("消耗不足")
end
if self.okCB then
self.okCB(self.data[_select].discipleguid)
end
self:closeSelf()
end

function UIWorldDiscipleSelectDialog.onClickEffectBtn(index)
local data=self.data[index]
if data.effects and data.effects>0 then
UIManager:showWindow('UISpecialityScrollViewWin',{datas=data.effects,openType=nil,guid=data.discipleguid})
end
end

function UIWorldDiscipleSelectDialog.onClickItem(id,index,guid,attach)
if _select~=index then
if _select then
_this:setItemSelect(_select,false)
end
_select=index
_this:setItemSelect(_select,true)
end
end

function UIWorldDiscipleSelectDialog:setItemSelect(index,selected)
local item=self.ScrollView:getGridObjectByindex(index-1)
item:SetChildActive(itemKid.selected,selected)
end
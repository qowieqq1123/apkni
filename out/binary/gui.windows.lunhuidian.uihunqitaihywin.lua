







def_class("UIHunQiTaiHYWin",UIWindowBase)









function UIHunQiTaiHYWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.giftList=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)
self.yjynum=UIText.get(self,4)
self.yjyadd=UIText.get(self,5)
self.qxbtn=UIButton.get(self,6)
self.hybtn=UIButton.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.qxbtn:setButtonClick(function()self:onQxbtn()end)

self.hybtn:setButtonClick(function()self:onHybtn()end)



end


function UIHunQiTaiHYWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.giftList);self.giftList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.yjynum);self.yjynum=nil;
_UIObject_release(self.yjyadd);self.yjyadd=nil;
_UIObject_release(self.qxbtn);self.qxbtn=nil;
_UIObject_release(self.hybtn);self.hybtn=nil;
end
















local _this
local HQTtype=
{
[1]="筑基",
[2]="结丹",
[3]="元婴",
[4]="化神",
[5]="炼虚",
[6]="合体",
[7]="大乘",
[8]="渡劫",
[9]="天仙",
}
local _giftItemCmp={
item=0,
slider=1,
add=2,
del=3,
num=4,
handle=5,
name=6,
select=7,
max=8,
}



function UIHunQiTaiHYWin:onLoaded(...)
self:bindComponents()
_this=self

self.selectList2={}
self.selectList={}
self.selectValue=0
self.maxList={}

self.allnum=0
self.sortlist={}
end


function UIHunQiTaiHYWin:__delete()
self:unbindComponents()
_this=nil
end


function UIHunQiTaiHYWin:onQxbtn()
if yunjiayingModel:getRemainingCanMakeSoldierCount()<=0 then
UIManager.error("云甲营容纳数量已达上限")
return
end
local selectnum=self:getSelectAllNum()
local shengu=self.allnum-selectnum
if shengu>0 then
for index,data in ipairs(self.sortlist)do

if shengu>0 then
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local max=self.maxList[index]
local have=self.selectList2[index]or 0
if max<=have then

else

local cha=max-have
local temp=math.min(shengu,cha)
local getvalue=have+temp

item:SetChildSliderValue(_giftItemCmp.slider,getvalue)
self.selectList[index]=getvalue
self.selectList2[index]=getvalue
shengu=shengu-cha
end
end
end
else
UIManager.info("数量已达上限")
end
end

function UIHunQiTaiHYWin:onHybtn()
if yunjiayingModel:getRemainingCanMakeSoldierCount()<=0 then
UIManager.error("云甲营容纳数量已达上限，不能进行还阳")
return
end
if self.selectList2 and next(self.selectList2)then
local list={}
for index,num in pairs(self.selectList2)do
if num>0 then
local data=self.sortlist[index]
local id=data[1]
local guid=int64.new(tostring(num))
table.insert(list,{id,guid})
end
end
if#list>0 then
LunHuiDianController.send_6_192(#list,list)
self:closeSelf()
else
UIManager.info("请先选择修士")
end
end
end

function UIHunQiTaiHYWin:onClickAdd(index)
local allnum=self.allnum
if self.selectValue>=allnum then
return
end
local num=self.selectList[index]or 0
local max=self.maxList[index]or 0
if num+1<=max then
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
item:SetChildSliderValue(_giftItemCmp.slider,num+1)
end
end

function UIHunQiTaiHYWin:onClickDel(index)
local num=self.selectList[index]or 0
if num-1>=0 then
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
item:SetChildSliderValue(_giftItemCmp.slider,num-1)
end
end




function UIHunQiTaiHYWin:onShow(argtable,afterOnloaded)

self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)

self:freshYJYpanel()
self:freshChooseText()
self:freshpanel()
end


function UIHunQiTaiHYWin:onHide()

end
function UIHunQiTaiHYWin:onCloseBtn()
self:closeSelf()
end


function UIHunQiTaiHYWin:freshYJYpanel()
local syNum=yunjiayingModel:getRemainingCanMakeSoldierCount()
local maxCanHasCount=yunjiayingModel:getMaxCanMakeSoldierCount()
local nowNum=maxCanHasCount-syNum
self.yjynum:setText(FMT.fmt('{0}/{1}',nowNum,maxCanHasCount))
end

function UIHunQiTaiHYWin:freshChooseText()
local num=self:getSelectAllNum()
num=math.min(num,self.allnum)
if num>0 then
self.yjyadd:setText(FMT.fmt('+{0}',num))
else
self.yjyadd:setText("")
end
end

function UIHunQiTaiHYWin:freshSliderText(item,index)
local _num=self.selectList2[index]or 0
item:SetChildText(_giftItemCmp.select,_num)
end

function UIHunQiTaiHYWin:getSortlist()
local list={}
local allnum=0

local nowLHdata=LunHuiDianModel:getHQTNowLHnum()
for k,v in pairs(nowLHdata)do
local id=v.param_1
local num=v.param_2 and tonumber(tostring(v.param_2))or 0
if num>0 then
allnum=allnum+num
table.insert(list,{id,num})
end
end
if#list>1 then
table.sort(list,function(a,b)
return a[1]<b[1]
end)
end

local syNum=yunjiayingModel:getRemainingCanMakeSoldierCount()
allnum=math.min(allnum,syNum)
self.sortlist=list
self.allnum=allnum

end

function UIHunQiTaiHYWin:freshpanel()
self:getSortlist()
local len=#self.sortlist
self.giftList:setChildLayoutGroupCreateItems(len,function(index)
self:refreshSingleBtn(index)
end)
end
function UIHunQiTaiHYWin:refreshSingleBtn(index)
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local data=self.sortlist[index]
local id=data[1]
local value=data[2]
item:SetChildText(_giftItemCmp.name,HQTtype[id])

local have=value
local over=self.allnum
local count=self:getSelectAllNum()
local num=self.selectList[index]or 0

local max=0
if over then
max=over>=0 and math.min(have,over-count)or have
end
self.maxList[index]=max
num=math.min(num,max)
self.selectList[index]=num
self.selectList2[index]=num

self.selectValue=self.selectValue+num

local showSlider=true
item:SetChildActive(_giftItemCmp.slider,showSlider)
if showSlider then
item:SetChildButtonClick(_giftItemCmp.add,function(id)
if _this==nil then return end
self:onClickAdd(index)
end,nil)
item:SetChildButtonClick(_giftItemCmp.del,function(id)
if _this==nil then return end
self:onClickDel(index)
end,nil)
item:SetChildSliderInit(_giftItemCmp.slider,num,0,max,function(value)
self:onSliderChange(index,value)
end)
item:SetChildGraphicGray(_giftItemCmp.slider,max<=0,true)


item:SetChildText(_giftItemCmp.select,num)

item:SetChildText(_giftItemCmp.max,max)
end
end
function UIHunQiTaiHYWin:onSliderChange(index,value)
local oldValue=self.selectList[index]or 0
if oldValue~=value then
local addValue=1
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local allnum=self.allnum
local _delta=value-oldValue
if _delta>0 then
if self.selectValue>=allnum then
item:SetChildSliderValue(_giftItemCmp.slider,oldValue)
local cha=self.selectValue-allnum

self.selectList2[index]=oldValue-cha
self:freshSliderText(item,index)
return
end
end
self.selectList[index]=value
self.selectList2[index]=value
self.selectValue=self.selectValue+(value-oldValue)*addValue
self:freshChooseText()
self:freshSliderText(item,index)
end
end




function UIHunQiTaiHYWin:getSelectAllNum()
local num=0
for k,v in pairs(self.selectList2)do
num=num+v
end
return num
end


function UIHunQiTaiHYWin:getdatatesttt()

local list=
{
{param_1=1,param_2=1100},
{param_1=2,param_2=1200},
{param_1=3,param_2=1300},
{param_1=4,param_2=1400},
{param_1=5,param_2=1500},
{param_1=6,param_2=1600},
{param_1=7,param_2=1700},
{param_1=8,param_2=1800},
{param_1=9,param_2=1900},
}
return list
end
function UIHunQiTaiHYWin:getdatatesttt2()
local selectList=_this.selectList
local selectValue=_this.selectValue
local maxList=_this.maxList

local allnum=_this.allnum



end

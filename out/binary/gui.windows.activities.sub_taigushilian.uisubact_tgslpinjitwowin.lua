







def_class("UISubAct_tgslPinJitwoWin",UIWindowBase)









function UISubAct_tgslPinJitwoWin:bindComponents()

self.diziimg=UIObject.get(self,0)
self.fazeimg=UIObject.get(self,1)
self.fazebtn=UIButton.get(self,2)
self.dizibtn=UIButton.get(self,3)
self.fazetxt=UIText.get(self,4)
self.fazedesc=UIText.get(self,5)
self.fazeitem5=UIObject.get(self,6)
self.fazeitem4=UIObject.get(self,7)
self.fazeitem3=UIObject.get(self,8)
self.fazeitem2=UIObject.get(self,9)
self.fazeitem1=UIObject.get(self,10)
self.dizidesc3=UIText.get(self,11)
self.diziitem1=UIObject.get(self,12)
self.diziitem2=UIObject.get(self,13)
self.diziitem3=UIObject.get(self,14)
self.diziitem4=UIObject.get(self,15)
self.diziitem5=UIObject.get(self,16)
self.diziitem6=UIObject.get(self,17)
self.dizidesc2=UIText.get(self,18)
self.dizidesc1=UIText.get(self,19)
self.btnClose=UIButton.get(self,20)
self.titleText=UIText.get(self,21)
self.dizipanel=UIObject.get(self,22)
self.fazepanel=UIObject.get(self,23)
self.infoPanel=UIObject.get(self,24)
self.root=UIObject.get(self,25)
self.clickMask=UIButton.get(self,26)
self.blackBG=UIButton.get(self,27)
self.skillItem=UIButton.get(self,28)
self.pjitem=UIObject.get(self,29)
self.pjitem1=UIObject.get(self,30)
self.pjitem2=UIObject.get(self,31)
self.pjitem3=UIObject.get(self,32)
self.pjitem4=UIObject.get(self,33)
self.pjitem5=UIObject.get(self,34)
self.pjitem6=UIObject.get(self,35)
self.pjitem7=UIObject.get(self,36)
self.pjitem8=UIObject.get(self,37)
self.pjitem9=UIObject.get(self,38)
self.pjitem10=UIObject.get(self,39)
self.pjitem11=UIObject.get(self,40)
self.taskScroller=UIObject.get(self,41)
self.backspine=UIObject.get(self,42)

self.fazebtn:setButtonClick(function()self:onFazebtn()end)

self.dizibtn:setButtonClick(function()self:onDizibtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.blackBG:setButtonClick(function()self:onBlackBG()end)

self.skillItem:setButtonClick(function()self:onSkillItem()end)



end


function UISubAct_tgslPinJitwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.diziimg);self.diziimg=nil;
_UIObject_release(self.fazeimg);self.fazeimg=nil;
_UIObject_release(self.fazebtn);self.fazebtn=nil;
_UIObject_release(self.dizibtn);self.dizibtn=nil;
_UIObject_release(self.fazetxt);self.fazetxt=nil;
_UIObject_release(self.fazedesc);self.fazedesc=nil;
_UIObject_release(self.fazeitem5);self.fazeitem5=nil;
_UIObject_release(self.fazeitem4);self.fazeitem4=nil;
_UIObject_release(self.fazeitem3);self.fazeitem3=nil;
_UIObject_release(self.fazeitem2);self.fazeitem2=nil;
_UIObject_release(self.fazeitem1);self.fazeitem1=nil;
_UIObject_release(self.dizidesc3);self.dizidesc3=nil;
_UIObject_release(self.diziitem1);self.diziitem1=nil;
_UIObject_release(self.diziitem2);self.diziitem2=nil;
_UIObject_release(self.diziitem3);self.diziitem3=nil;
_UIObject_release(self.diziitem4);self.diziitem4=nil;
_UIObject_release(self.diziitem5);self.diziitem5=nil;
_UIObject_release(self.diziitem6);self.diziitem6=nil;
_UIObject_release(self.dizidesc2);self.dizidesc2=nil;
_UIObject_release(self.dizidesc1);self.dizidesc1=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dizipanel);self.dizipanel=nil;
_UIObject_release(self.fazepanel);self.fazepanel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.pjitem);self.pjitem=nil;
_UIObject_release(self.pjitem1);self.pjitem1=nil;
_UIObject_release(self.pjitem2);self.pjitem2=nil;
_UIObject_release(self.pjitem3);self.pjitem3=nil;
_UIObject_release(self.pjitem4);self.pjitem4=nil;
_UIObject_release(self.pjitem5);self.pjitem5=nil;
_UIObject_release(self.pjitem6);self.pjitem6=nil;
_UIObject_release(self.pjitem7);self.pjitem7=nil;
_UIObject_release(self.pjitem8);self.pjitem8=nil;
_UIObject_release(self.pjitem9);self.pjitem9=nil;
_UIObject_release(self.pjitem10);self.pjitem10=nil;
_UIObject_release(self.pjitem11);self.pjitem11=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.backspine);self.backspine=nil;
end
















local _this
local abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab'



function UISubAct_tgslPinJitwoWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_tgslPinJitwoWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_tgslPinJitwoWin:onShow(argtable,afterOnloaded)
if argtable then
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossid=argtable[4]or 1
self.mydata=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subid)

local cb=function()


self:refreshdata()


end
self.backspine:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
end
end


function UISubAct_tgslPinJitwoWin:refreshdata()
local cfg=cfg_taigushilianconfig_get(_this.subId).damagelevel

local monlv=activitiesHandle_taiguBoss:getMonlv(_this.actId,_this.subType,_this.subId)
local tempArry={}
for k,v in ipairs(cfg)do
if monlv<=v[1]then
tempArry=v[2]
break
end
end
local list={}
for k,v in ipairs(tempArry[_this.bossid])do
list[k]=tempArry[_this.bossid][#tempArry[_this.bossid]+1-k]
end

_this.taskScroller:setActive(true)
_this.taskScroller:setChildScrollViewCreateGrids(#list,1)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local item=grids[i-1]
if item then
local chenghaoTxt=FMT.fmt('image_shilianzhandou_dj{0}',list[i][2])
item:SetChildCSImageSprite(10,abname,chenghaoTxt)
local shvalue=mathHelper.formatNumber(list[i][1])
local str=FMT.fmt('{0}',shvalue)
item:SetChildText(7,str)
end
end
end


function UISubAct_tgslPinJitwoWin:onHide()

end





function UISubAct_tgslPinJitwoWin:onFazebtn()
end



function UISubAct_tgslPinJitwoWin:onDizibtn()
end


function UISubAct_tgslPinJitwoWin:onClickMask()
end

function UISubAct_tgslPinJitwoWin:onBtnClose()
self:closeSelf()
end

function UISubAct_tgslPinJitwoWin:onBlackBG()
self:closeSelf()
end



function UISubAct_tgslPinJitwoWin:onSkillItem()
end


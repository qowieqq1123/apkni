







def_class("UIWDCQBanDZShowWin",UIWindowBase)









function UIWDCQBanDZShowWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.Bg=UIObject.get(self,1)
self.selfBandzItem_1=UIButton.get(self,2)
self.selfBandzItem_2=UIButton.get(self,3)
self.otherBandzItem_1=UIButton.get(self,4)
self.otherBandzItem_2=UIButton.get(self,5)
self.animRoot=UIObject.get(self,6)
self.selfLayout=UIObject.get(self,7)
self.otherLayout=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.selfBandzItem_1:setButtonClick(function()self:onSelfBandzItem_1()end)

self.selfBandzItem_2:setButtonClick(function()self:onSelfBandzItem_2()end)

self.otherBandzItem_1:setButtonClick(function()self:onOtherBandzItem_1()end)

self.otherBandzItem_2:setButtonClick(function()self:onOtherBandzItem_2()end)
self.selfBandzItem={
self.selfBandzItem_1,
self.selfBandzItem_2,
}
self.otherBandzItem={
self.otherBandzItem_1,
self.otherBandzItem_2,
}



end


function UIWDCQBanDZShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Bg);self.Bg=nil;
_UIObject_release(self.selfBandzItem_1);self.selfBandzItem_1=nil;
_UIObject_release(self.selfBandzItem_2);self.selfBandzItem_2=nil;
_UIObject_release(self.otherBandzItem_1);self.otherBandzItem_1=nil;
_UIObject_release(self.otherBandzItem_2);self.otherBandzItem_2=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.selfLayout);self.selfLayout=nil;
_UIObject_release(self.otherLayout);self.otherLayout=nil;
self.selfBandzItem=nil;
self.otherBandzItem=nil;
end


















local wdcqBandzItemCmp={
wdcqBandzItem=0,
back=1,
dis_name=2,
rawImage=3,
dis_job=4,
lv_Obj=5,
dis_level=6,
dis_fight=7,
ban=8,
iocnListRoot=9,
iocnList={10,11,12,13,14},
baohu=15,
effect=16,
xianMoBg=17.
}


function UIWDCQBanDZShowWin:onLoaded(...)
self:bindComponents()
self.Bg:setChildUIModelShowTarget(5559,1,nil,eAnimationID.stand)
self.tweenerList={}
end


function UIWDCQBanDZShowWin:__delete()
self:unbindComponents()
if self.tweenerList then
for i,v in ipairs(self.tweenerList)do
v:Kill()
end
self.tweenerList=nil
end
end




function UIWDCQBanDZShowWin:onShow(argtable,afterOnloaded)
local selfBanList=argtable and argtable.selfBanList or{}
local otherBanList=argtable and argtable.otherBanList or{}


for i,v in ipairs(self.selfBandzItem)do
if selfBanList[i]then
v:setActive(true)
local item=v:getWidgetBase()
self:setBanItem(item,selfBanList[i],true)
else
v:setActive(false)
end
end
for i,v in ipairs(self.otherBandzItem)do
if otherBanList[i]then
v:setActive(true)
local item=v:getWidgetBase()
self:setBanItem(item,otherBanList[i])
else
v:setActive(false)
end
end


self.animRoot:setScale(Vector3.New(1,1,1))
table.insert(self.tweenerList,self.animRoot:setChildCanvasGroupDOFade(1,0.5))

end


function UIWDCQBanDZShowWin:onHide()

end

function UIWDCQBanDZShowWin:setBanItem(item,info,selfFlag)
local netdata=info
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)
if selfFlag then

local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)
item:SetChildCSImageSprite(wdcqBandzItemCmp.back,abname,iconname)


item:SetChildActive(wdcqBandzItemCmp.lv_Obj,true)

local lv_str=tostring(netdata.jingjielv)
item:SetChildText(wdcqBandzItemCmp.dis_level,lv_str)
UIDiscipleModel:setDiscipleXianMoBackImage(item,wdcqBandzItemCmp.xianMoBg,netdata)
end

item:SetChildText(wdcqBandzItemCmp.dis_name,netdata.disciplename)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(wdcqBandzItemCmp.rawImage,item,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(wdcqBandzItemCmp.dis_job,globalABLookup.global,jobicon)


item:SetChildActive(wdcqBandzItemCmp.dis_fight,false)


local func=function()
end
item:SetChildButtonClick(-1,func,true)
item:SetChildActive(wdcqBandzItemCmp.baohu,false)
item:SetChildActive(wdcqBandzItemCmp.ban,false)

local linggenList=self:getDzLinggenList(info)
for i,v in ipairs(wdcqBandzItemCmp.iocnList)do
if linggenList[i]then
item:SetChildActive(v,true)
local icon=ELEMENT_TYPE.getIconEx(linggenList[i].element)
item:SetChildCSImageSprite(v,globalABLookup.global,icon)
else
item:SetChildActive(v,false)
end
end
end

function UIWDCQBanDZShowWin:getDzLinggenList(discipleStruct)
local list={}
for i,v in ipairs(discipleStruct.specialityList)do
if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot and v.len>0 then
for ii,vv in ipairs(v.specialityLst)do
local cfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,vv.param_1)
table.insert(list,cfg)
end
end
end
return list
end






function UIWDCQBanDZShowWin:onCloseBtn()
local time=0.65
table.insert(self.tweenerList,self.selfLayout:setChildDOScale(0,time))
table.insert(self.tweenerList,self.selfLayout:setChildDOLocalMove(Vector3.zero,time))
table.insert(self.tweenerList,self.otherLayout:setChildDOScale(0,time))
table.insert(self.tweenerList,self.otherLayout:setChildDOLocalMove(Vector3.zero,time))
self:delayDo(0.4,function()
if not self or self.isClose then return end
table.insert(self.tweenerList,self.animRoot:setChildCanvasGroupDOFade(0,0.65,function()
if not self or self.isClose then return end
self:closeSelf()
end))
end)
end



function UIWDCQBanDZShowWin:onSelfBandzItem_1()
end



function UIWDCQBanDZShowWin:onSelfBandzItem_2()
end



function UIWDCQBanDZShowWin:onOtherBandzItem_1()
end



function UIWDCQBanDZShowWin:onOtherBandzItem_2()
end










def_class("UISettingExperienceWin",UIWindowBase)









function UISettingExperienceWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeTips=UIButton.get(self,1)
self.LoopScrollView=UIObject.get(self,2)
self.Content=UIObject.get(self,3)

self.closeTips:setButtonClick(function()self:onCloseTips()end)



end


function UISettingExperienceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.LoopScrollView);self.LoopScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
end
















local cmpIndex={
name=0,
model=1,
attrRoot=2,
attrList={3,4},
bgList={
[KUANGE_TYPE.head]=6,
[KUANGE_TYPE.headKuang]=6,
[KUANGE_TYPE.chatKuang]=7,
[KUANGE_TYPE.feijian]=5,
[KUANGE_TYPE.yunzhou]=5,
[KUANGE_TYPE.zongmen]=8,
},
chaticon=9,
heafbg=10,
headicon=11,
headKuang=12,
}



function UISettingExperienceWin:onLoaded(...)
self:bindComponents()
end


function UISettingExperienceWin:__delete()
self:unbindComponents()
end




function UISettingExperienceWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end
local list=argtable.experienceList
self.Content:setChildLayoutGroupCreateItems(#list,function(index)
local data=list[index]
local type=data[1]
local id=data[2]
local settingcfg=UISettingConfig.getCfg(type,id)
local item=self.Content:getChildLayoutGroupGridItem(index-1)
item:SetChildText(cmpIndex.name,settingcfg.name)
item:SetChildActive(cmpIndex.bgList[type],true)
if type==KUANGE_TYPE.feijian or
type==KUANGE_TYPE.yunzhou or
type==KUANGE_TYPE.zongmen then
local modelId=settingcfg.modelId
local experienceModelcfg=settingcfg.experienceModelcfg
local scale=experienceModelcfg.scale
local offset=experienceModelcfg.offset
item:SetChildUIModelShowTarget(cmpIndex.model,modelId,scale,{},eAnimationID.stand)
item:SetChildAnchoredPos(cmpIndex.model,offset[1],offset[2])
elseif type==KUANGE_TYPE.head or
type==KUANGE_TYPE.headKuang then
item:SetChildUIModelRemoveTarget(cmpIndex.model)
item:SetChildActive(cmpIndex.heafbg,type==KUANGE_TYPE.head)
local iconName
if type==KUANGE_TYPE.head then
local headIcon=settingcfg.icon
iconName=iconHelper.getHeadIcon(headIcon)
item:SetChildIcon(cmpIndex.headicon,iconName,false)
elseif type==KUANGE_TYPE.headKuang then
iconName=iconHelper.getHeadKuangIcon(settingcfg.icon)
item:SetChildIcon(cmpIndex.headKuang,iconName,false)
end
elseif type==KUANGE_TYPE.chatKuang then
local modelId=settingcfg.setmodel
if modelId then
item:SetChildUIModelShowTarget(cmpIndex.model,modelId,0.7,{},eAnimationID.stand)
else
local icon=settingcfg.icon
item:SetChildUIModelRemoveTarget(cmpIndex.model)
item:SetChildIcon(cmpIndex.chaticon,iconHelper.getChatKuangIcon(icon),false)
end
end

local attrList
local attr=settingcfg.attr
if attr then
attrList={}
for i,v in ipairs(attr)do
table.insert(attrList,v)
end
end
local jzattr=settingcfg.jzattr
if jzattr then
if not attrList then
attrList={}
end
for i,v in ipairs(jzattr)do
table.insert(attrList,v)
end
end
if attrList then
item:SetChildActive(cmpIndex.attrRoot,true)
for i,v in ipairs(cmpIndex.attrList)do
if attrList[i]then
local attr=attrList[i]
item:SetChildActive(v,true)
local name,value=equipsHelper.getAttr(attr[1],attr[2])
local nameStr=FMT.fmt("{0} +{1}",name,value)
item:SetChildText(v,nameStr)
else
item:SetChildActive(v,false)
end
end
else
item:SetChildActive(cmpIndex.attrRoot,false)
end
end)
end


function UISettingExperienceWin:onHide()

end

function UISettingExperienceWin:onFreshAction()

end


function UISettingExperienceWin:onStartAction()

end





function UISettingExperienceWin:onCloseTips()
self:closeSelf()
end
















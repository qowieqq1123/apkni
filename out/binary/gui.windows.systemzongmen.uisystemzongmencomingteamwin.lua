







def_class("UISystemZongMenComingTeamWin",UIWindowBase)









function UISystemZongMenComingTeamWin:bindComponents()

self.mask=UIButton.get(self,0)
self.bg_1=UIObject.get(self,1)
self.bg_2=UIObject.get(self,2)
self.title=UIText.get(self,3)
self.selectList=UIObject.get(self,4)
self.roleList=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.model_1=UIObject.get(self,7)
self.model_2=UIObject.get(self,8)
self.model_3=UIObject.get(self,9)
self.model_4=UIObject.get(self,10)
self.model_5=UIObject.get(self,11)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.bg={
self.bg_1,
self.bg_2,
}
self.model={
self.model_1,
self.model_2,
self.model_3,
self.model_4,
self.model_5,
}



end


function UISystemZongMenComingTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.bg_1);self.bg_1=nil;
_UIObject_release(self.bg_2);self.bg_2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.selectList);self.selectList=nil;
_UIObject_release(self.roleList);self.roleList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.model_1);self.model_1=nil;
_UIObject_release(self.model_2);self.model_2=nil;
_UIObject_release(self.model_3);self.model_3=nil;
_UIObject_release(self.model_4);self.model_4=nil;
_UIObject_release(self.model_5);self.model_5=nil;
self.bg=nil;
self.model=nil;
end















local _this=nil
local _discipleCmp={
bg=0,
head=1,
name=2,
jingjie=3,
select=4,
iconBg=5,
}
local _selectCmp={
root=-1,
notSelected=0,
selected=1,
teamName=2,
}
local _modelCmp={
root=-1,
model=0,
speak=1,
speakText=2,
jobName=3,
selectEffect=4,
jobImg=5,
}



function UISystemZongMenComingTeamWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectTeam=nil
self.discipleList={}
self.selectDisciple=nil
self.speakTweens={}
end


function UISystemZongMenComingTeamWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenComingTeamWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.teamList=argtable.teamList
self.titleStr=argtable.title
self.bgType=argtable.bgType or 1

self.title:setText(self.titleStr)
for i,v in ipairs(self.bg)do
v:setActive(i==self.bgType)
end

self.selectList:setChildLayoutGroupCreateItems(#self.teamList,function(index)
local item=self.selectList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_selectCmp.notSelected,self.selectTeam~=index)
item:SetChildActive(_selectCmp.selected,self.selectTeam==index)
item:SetChildText(_selectCmp.teamName,FMT.fmt("第 {0} 队",index))
item:SetChildButtonClick(_selectCmp.root,function()
self:onClickTeam(index)
end)
end)

if argtable.select then
self:onClickTeam(argtable.select)
elseif self.selectTeam==nil then
self:onClickTeam(1)
end
end


function UISystemZongMenComingTeamWin:onHide()

end





function UISystemZongMenComingTeamWin:onMask()
self:onCloseBtn()
end



function UISystemZongMenComingTeamWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISystemZongMenComingTeamWin:onClickTeam(index)
if self.selectTeam==index then return end
if self.selectTeam then
local item=self.selectList:getChildLayoutGroupGridItem(self.selectTeam-1)
item:SetChildActive(_selectCmp.notSelected,true)
item:SetChildActive(_selectCmp.selected,false)
end

self.selectTeam=index

local item=self.selectList:getChildLayoutGroupGridItem(self.selectTeam-1)
item:SetChildActive(_selectCmp.notSelected,false)
item:SetChildActive(_selectCmp.selected,true)

self:refreshSelectTeam()
end

function UISystemZongMenComingTeamWin:refreshSelectTeam()
local teamData=self.teamList[self.selectTeam]
local tempList=self.discipleList[self.selectTeam]
self.selectPos=nil
self.selectIndex=nil
self:killAllSpeakTween()

if tempList==nil then
tempList={}
for i=1,fightPreSelectModel.maxPosNum do
local v=teamData[i]
if v and v.disciple_id>0 then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(v.discipledata,v.discipleimage)
v.imageInfo=imageInfo
table.insert(tempList,{disciple=v,pos=i,imageInfo=imageInfo})
end
end
self.discipleList[self.selectTeam]=tempList
end

self.roleList:setChildLayoutGroupCreateItems(#tempList,function(index)
local item=self.roleList:getChildLayoutGroupGridItem(index-1)
local data=tempList[index]
local discipleData=data.disciple

item:SetChildButtonClick(_discipleCmp.bg,function()
self:onClickRoleItem(index)
end)
item:SetChildText(_discipleCmp.name,discipleData.disciplename)
item:SetChildText(_discipleCmp.jingjie,UIDiscipleModel:getJJName3(discipleData.jingjie))

local imageInfo=data.imageInfo
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildModelRawImageEx(_discipleCmp.head,item,modelParams,eHeadCenterType.eHead)
comHelper.setChildModelHeadIconBGByColor(item,_discipleCmp.iconBg,imageInfo.color or 1)
item:SetChildActive(_discipleCmp.select,self.selectDisciple==index)
end)

for i,v in ipairs(self.model)do
local widget=v:getChildWidgetBase()
local data=teamData[i]
local check=data and data.disciple_id>0 or false
widget:SetChildCanvasGroupAlpha(_modelCmp.speak,0)
widget:SetChildActive(_modelCmp.root,check)
if check then
local imageInfo=data.imageInfo
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
local weaponItemID=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,"syssectWeapon")
local weaponItemCfg=itemsConfig.getConfig(weaponItemID)
local weaponID=weaponItemCfg.imageID or 0
table_insert(modelParams.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side'))
widget:SetChildUIModelShowTarget(_modelCmp.model,modelParams.body,0.8,modelParams.componets,modelParams.anim)
widget:SetChildUIModelShowTargetOffset(_modelCmp.model,0,-50)
widget:SetChildActive(_modelCmp.selectEffect,self.selectPos==i)
widget:SetChildActive(_modelCmp.jobImg,true)
widget:SetChildText(_modelCmp.jobName,UIDiscipleModel:getJobName(imageInfo.job))
else
widget:SetChildUIModelRemoveTarget(_modelCmp.model)
widget:SetChildActive(_modelCmp.selectEffect,false)
widget:SetChildActive(_modelCmp.jobImg,false)
end
end
end

function UISystemZongMenComingTeamWin:onClickRoleItem(index)
if self.selectIndex then
local item=self.roleList:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildActive(_discipleCmp.select,false)
end
if self.selectPos then
local widget=self.model[self.selectPos]:getChildWidgetBase()
widget:SetChildActive(_modelCmp.selectEffect,false)
self:hideSpeak(self.selectPos)
end

self.selectIndex=index
local tempList=self.discipleList[self.selectTeam]
self.selectPos=tempList[self.selectIndex].pos

local item=self.roleList:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildActive(_discipleCmp.select,true)
local widget=self.model[self.selectPos]:getChildWidgetBase()
widget:SetChildActive(_modelCmp.selectEffect,true)
self:showSpeak(self.selectPos)
end

function UISystemZongMenComingTeamWin:killAllSpeakTween()
for i,v in pairs(self.speakTweens)do
if v:IsActive()then
v:Kill()
end
end
self.speakTweens={}
end

function UISystemZongMenComingTeamWin:hideSpeak(pos)
local widget=self.model[pos]:getChildWidgetBase()
widget:SetChildCanvasGroupAlpha(_modelCmp.speak,0)
end

function UISystemZongMenComingTeamWin:showSpeak(pos)
local widget=self.model[pos]:getChildWidgetBase()
widget:SetChildCanvasGroupAlpha(_modelCmp.speak,1)

local config=douFaTaiModel:getDouFaTaiBasicConfig()
local speakList=config.xiaoren_speak
local speakStr=speakList[math.random(1,#speakList)]
widget:SetChildText(_modelCmp.speakText,speakStr)

local tween=widget:SetChildCanvasGroupDOFade(_modelCmp.speak,0,0.5)
tween:SetDelay(5)
self.speakTweens[self.selectIndex]=tween
end
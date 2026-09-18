







def_class("UIDiscipleAwakeResultWin",UIWindowBase)









function UIDiscipleAwakeResultWin:bindComponents()

self.root=UIButton.get(self,0)
self.modelObj_1=UIObject.get(self,1)
self.modelObj_2=UIObject.get(self,2)
self.infoRoot_1=UIObject.get(self,3)
self.infoRoot_2=UIObject.get(self,4)
self.polygonAttrPanel=UIObject.get(self,5)
self.tipsBg=UIObject.get(self,6)
self.transition=UIObject.get(self,7)
self.effect=UIObject.get(self,8)
self.modelImage_1=UIObject.get(self,9)
self.modelImage_2=UIObject.get(self,10)
self.descListPanel=UIObject.get(self,11)
self.colorImage_2=UIImage.get(self,12)
self.sixIcon_2=UIImage.get(self,13)
self.colorImage_1=UIImage.get(self,14)
self.sixIcon_1=UIImage.get(self,15)

self.root:setButtonClick(function()self:onRoot()end)
self.modelObj={
self.modelObj_1,
self.modelObj_2,
}
self.infoRoot={
self.infoRoot_1,
self.infoRoot_2,
}
self.modelImage={
self.modelImage_1,
self.modelImage_2,
}
self.colorImage={
self.colorImage_1,
self.colorImage_2,
}
self.sixIcon={
self.sixIcon_1,
self.sixIcon_2,
}



end


function UIDiscipleAwakeResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.modelObj_1);self.modelObj_1=nil;
_UIObject_release(self.modelObj_2);self.modelObj_2=nil;
_UIObject_release(self.infoRoot_1);self.infoRoot_1=nil;
_UIObject_release(self.infoRoot_2);self.infoRoot_2=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.transition);self.transition=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.modelImage_1);self.modelImage_1=nil;
_UIObject_release(self.modelImage_2);self.modelImage_2=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.colorImage_2);self.colorImage_2=nil;
_UIObject_release(self.sixIcon_2);self.sixIcon_2=nil;
_UIObject_release(self.colorImage_1);self.colorImage_1=nil;
_UIObject_release(self.sixIcon_1);self.sixIcon_1=nil;
self.modelObj=nil;
self.infoRoot=nil;
self.modelImage=nil;
self.colorImage=nil;
self.sixIcon=nil;
end
















local _this=nil
local abName='ui/windows/world/sharedtextures/dashijie_showdisciple_altas.ab'



function UIDiscipleAwakeResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleAwakeResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleAwakeResultWin:onShow(argtable,afterOnloaded)
self.oldData=argtable.oldData
self.newData=argtable.newData
self.btParam=argtable.btParam
self.speList=self:compareSpe(self.oldData,self.newData)
self:setRole(1,self.oldData)
self:setRole(2,self.newData)

self:doAnimation()
end


function UIDiscipleAwakeResultWin:onHide()

end




function UIDiscipleAwakeResultWin:onRoot()

if not self.tween then
local param=self.btParam
UIFullStoryBoardControl:closeUI()
if param then
local bt=param[1]
local key=param[2]
if bt and key then
bt:setSharedVar(key,true)
end
end
end
end

function UIDiscipleAwakeResultWin:setRole(index,data)
local info=UIDiscipleModel:getDiscipleImageInfoEx(data)
local cmpID=self.modelImage[index]:getID()
local image=UIDiscipleModel:getDiscipleInsideModelInfoEx(data)
self.winlua:SetChildUIModelShowTarget(cmpID,image.body,image.scale,image.componets,0,false,false,0)

local insideShow=cfgHelper.get2(cfg_discipleconfig_get,data.id,"insideShow")
if insideShow and insideShow[1]then
local param=insideShow[1]
if param.offset then
self.winlua:SetChildUIModelShowTargetOffset(cmpID,param.offset[1]or 0,param.offset[2]or 0)
end
if param.scale then
self.winlua:SetChildUIModelShowScale(cmpID,param.scale)
end
end

if info.color==4 then
self.winlua:SetChildCSImageSprite(self.colorImage[index]:getID(),abName,FMT.fmt('image_huodedzui_2',info.color))
elseif info.color==5 then
self.winlua:SetChildCSImageSprite(self.colorImage[index]:getID(),abName,FMT.fmt('image_huodedzui_1',info.color))
end

local polygonIcon=FMT.fmt('image_shuxingtu_{0}',info.color)
self.winlua:SetChildCSImageSprite(self.sixIcon[index]:getID(),globalABLookup.diciplemain,polygonIcon)
end

function UIDiscipleAwakeResultWin:setSixPanel(data)
local wiget=self.polygonAttrPanel:getChildWidgetBase()
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local allnum=0

for i,v in ipairs(data.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
wiget:SetChildText(7,FMT.fmt('总值：{0}',allnum))

for i=1,6 do
local idx=i-1
local attrType=i
local v=data.attrList[attrType]==0 and 1 or data.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
wiget:SetChildUIPolygonImage(6,ratelist,0)
end

function UIDiscipleAwakeResultWin:setSpeList(list,discipleguid)
self.descListPanel:setChildLayoutGroupCreateItems(#list,function(index)
local data=list[index]
local item=self.descListPanel:getChildLayoutGroupGridItem(index-1)
local cfg=UIDiscipleModel:getSpecialityConfig(data[1],data[2])
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=discipleguid,config=cfg})
end)
end)
end

function UIDiscipleAwakeResultWin:doAnimation()











local args={
widget=self.winlua,
model1=self.modelObj_1:getID(),
model2=self.modelObj_2:getID(),
info1=self.infoRoot_1:getID(),
info2=self.infoRoot_2:getID(),
tips=self.tipsBg:getID(),
effect=self.effect:getID(),
transition=self.transition:getID(),
sixPanel=self.polygonAttrPanel:getID(),
speList=self.speList,
disciple=self.newData.discipleguid,
newData=self.newData,
oldData=self.oldData,
}
self.tween=behaviorManager:addBehaviorTree("bt_ui_dz_awake",nil,true,args,true)
end

function UIDiscipleAwakeResultWin:compareSpe(oldData,newData)
if oldData.specialitytypelookup==nil then
UIDiscipleModel.refreshDiscipleSpecialityLookup(oldData)
end
if newData.specialitytypelookup==nil then
UIDiscipleModel.refreshDiscipleSpecialityLookup(newData)
end
local list={}
for stype,temp in pairs(newData.specialitytypelookup)do
for sid,data in pairs(temp)do
if oldData.specialitytypelookup[stype]==nil or oldData.specialitytypelookup[stype][sid]==nil then
table.insert(list,{stype,sid})
end
end
end
return list
end

function UIDiscipleAwakeResultWin:onAnimationFinish()
self.tween=nil
end

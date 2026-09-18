







def_class("UIHuanJingJinDiResultWin",UIWindowBase)









function UIHuanJingJinDiResultWin:bindComponents()

self.background=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.picture=UIImage.get(self,2)
self.bottom=UIObject.get(self,3)
self.dzLv=UIText.get(self,4)
self.dzBg=UIImage.get(self,5)
self.dzName=UIText.get(self,6)
self.dzImage=UIObject.get(self,7)
self.dzJob=UIImage.get(self,8)
self.dzDesc=UIText.get(self,9)
self.dzLvBg=UIImage.get(self,10)
self.descTx=UIText.get(self,11)
self.resultList=UIObject.get(self,12)
self.spDzFlag=UIObject.get(self,13)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIHuanJingJinDiResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.dzLv);self.dzLv=nil;
_UIObject_release(self.dzBg);self.dzBg=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.dzImage);self.dzImage=nil;
_UIObject_release(self.dzJob);self.dzJob=nil;
_UIObject_release(self.dzDesc);self.dzDesc=nil;
_UIObject_release(self.dzLvBg);self.dzLvBg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.resultList);self.resultList=nil;
_UIObject_release(self.spDzFlag);self.spDzFlag=nil;
end
















local _this=nil
local _itemCmp={
attrName=0,
attrOld=1,
arrow=2,
attrNew=3,
specialBg=4,
specialName=5,
}




function UIHuanJingJinDiResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIHuanJingJinDiResultWin:__delete()
self:unbindComponents()
_this=nil
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
end
end



















function UIHuanJingJinDiResultWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
local netData=UIDiscipleModel:getDiscipleData(argtable.disciple)
local color=UIDiscipleModel:getDiscipleColor(argtable.disciple)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
local jobicon=UIDiscipleModel:getJobIconNameX(argtable.disciple)
local sixValue=UIDiscipleModel:getDiscipleBaseAttr(argtable.disciple,argtable.sixAttrType)
self.dzBg:setSprite(abname,iconname)
self.dzName:setText(netData.disciplename)
self.dzJob:setSprite(globalABLookup.global,jobicon)


self.dzDesc:setText(UIDiscipleModel:getDiscipleBaseAttrDesc(argtable.sixAttrType,sixValue,"<color=#7D3B17>{0}</color> {1}"))
comHelper.setChildModelRawImage(self.winlua,argtable.disciple,self.dzImage:getID(),0,eHeadCenterType.eHead,nil,false)

self.picture:setImageIcon(argtable.image,true)
self.descTx:setText(FMT.fmt(argtable.desc,netData.disciplename))


local isSpDz=UIDiscipleModel:isSPDiscipleEx(argtable.disciple)
self.spDzFlag:setActive(isSpDz)

local listCnt=#argtable.list
local width=math.ceil(listCnt/5)
self.resultList:setChildSizeDelta(width*250+(width-1)*10,204)
self.resultList:setChildLayoutGroupCreateItems(#argtable.list,function(index)
local data=argtable.list[index]
local item=self.resultList:getChildLayoutGroupGridItem(index-1)
item:SetChildText(_itemCmp.attrName,data.name)
if data.showType==1 then
item:SetChildActive(_itemCmp.attrNew,true)
item:SetChildActive(_itemCmp.attrOld,data.previous~=nil)
item:SetChildActive(_itemCmp.arrow,data.previous~=nil)
item:SetChildActive(_itemCmp.specialBg,false)
item:SetChildText(_itemCmp.attrNew,data.current)
item:SetChildText(_itemCmp.attrOld,data.previous or"")
elseif data.showType==2 then
item:SetChildActive(_itemCmp.attrNew,false)
item:SetChildActive(_itemCmp.attrOld,false)
item:SetChildActive(_itemCmp.arrow,false)
item:SetChildActive(_itemCmp.specialBg,true)

local speCfg=UIDiscipleModel:getSpecialityConfig(data.special[1],data.special[2])
local name=UIDiscipleModel.getSpecialityNameStr(speCfg.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(speCfg.framecolor)
item:SetChildCSImageSprite(_itemCmp.specialBg,abName,frameIcon)
item:SetChildText(_itemCmp.specialName,name)
item:SetChildButtonClick(_itemCmp.specialBg,function()
UIManager:showWindow('UISpecialityWin',{item=item,node='top',guid=argtable.disciple,config=speCfg,pivot=Vector2(0.5,0)})
end)
end
item:ForceLayoutRect(-1)
end)
self.winlua:ForceLayoutRect(self.resultList:getID())
if argtable.before then
argtable.before()
else
self:showResult()
end
end


function UIHuanJingJinDiResultWin:onHide()

end





function UIHuanJingJinDiResultWin:onBackground()
if self.showing then
UIHuanJingControl:closeWindow(self.__name)
end
end

function UIHuanJingJinDiResultWin:showResult()
self.root:setActive(true)
self.winlua:ForceLayoutRect(self.resultList:getID())
local args={
widget=self.winlua,
picIdx=self.picture:getID(),
descIdx=self.descTx:getID(),
bottomIdx=self.bottom:getID(),
}
self.bt=behaviorManager:addBehaviorTree("bt_ui_huanjingjindi_result",nil,true,args,true)





end

function UIHuanJingJinDiResultWin:showResultFinish()
self.showing=true
UIHuanJingControl:checkShowNeedSelectTeZhiDialougeById(self.id)
end
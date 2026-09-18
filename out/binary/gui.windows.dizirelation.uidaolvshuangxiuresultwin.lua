







def_class("UIDaoLvShuangXiuResultWin",UIWindowBase)









function UIDaoLvShuangXiuResultWin:bindComponents()

self.background=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.picture=UIImage.get(self,2)
self.bottom_2=UIObject.get(self,3)
self.speScrollView_1=UIObject.get(self,4)
self.speScrollView_2=UIObject.get(self,5)
self.bottom_1=UIObject.get(self,6)
self.resultList_2=UIObject.get(self,7)
self.resultList_1=UIObject.get(self,8)
self.Effect_1=UIObject.get(self,9)
self.Effect_2=UIObject.get(self,10)
self.dzLv_1=UIText.get(self,11)
self.dzLv_2=UIText.get(self,12)
self.dzLvBg_2=UIImage.get(self,13)
self.dzDesc_2=UIText.get(self,14)
self.dzJob_2=UIImage.get(self,15)
self.dzImage_2=UIObject.get(self,16)
self.dzName_2=UIText.get(self,17)
self.dzBg_2=UIImage.get(self,18)
self.dzName_1=UIText.get(self,19)
self.dzBg_1=UIImage.get(self,20)
self.dzLvBg_1=UIImage.get(self,21)
self.dzDesc_1=UIText.get(self,22)
self.dzJob_1=UIImage.get(self,23)
self.dzImage_1=UIObject.get(self,24)
self.speGrid_2=UIObject.get(self,25)
self.descTx=UIText.get(self,26)
self.speGrid_1=UIObject.get(self,27)
self.spDzFlag_1=UIObject.get(self,28)
self.spDzFlag_2=UIObject.get(self,29)

self.background:setButtonClick(function()self:onBackground()end)
self.bottom={
self.bottom_1,
self.bottom_2,
}
self.speScrollView={
self.speScrollView_1,
self.speScrollView_2,
}
self.resultList={
self.resultList_1,
self.resultList_2,
}
self.Effect={
self.Effect_1,
self.Effect_2,
}
self.dzLv={
self.dzLv_1,
self.dzLv_2,
}
self.dzLvBg={
self.dzLvBg_1,
self.dzLvBg_2,
}
self.dzDesc={
self.dzDesc_1,
self.dzDesc_2,
}
self.dzJob={
self.dzJob_1,
self.dzJob_2,
}
self.dzImage={
self.dzImage_1,
self.dzImage_2,
}
self.dzName={
self.dzName_1,
self.dzName_2,
}
self.dzBg={
self.dzBg_1,
self.dzBg_2,
}
self.speGrid={
self.speGrid_1,
self.speGrid_2,
}
self.spDzFlag={
self.spDzFlag_1,
self.spDzFlag_2,
}



end


function UIDaoLvShuangXiuResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.bottom_2);self.bottom_2=nil;
_UIObject_release(self.speScrollView_1);self.speScrollView_1=nil;
_UIObject_release(self.speScrollView_2);self.speScrollView_2=nil;
_UIObject_release(self.bottom_1);self.bottom_1=nil;
_UIObject_release(self.resultList_2);self.resultList_2=nil;
_UIObject_release(self.resultList_1);self.resultList_1=nil;
_UIObject_release(self.Effect_1);self.Effect_1=nil;
_UIObject_release(self.Effect_2);self.Effect_2=nil;
_UIObject_release(self.dzLv_1);self.dzLv_1=nil;
_UIObject_release(self.dzLv_2);self.dzLv_2=nil;
_UIObject_release(self.dzLvBg_2);self.dzLvBg_2=nil;
_UIObject_release(self.dzDesc_2);self.dzDesc_2=nil;
_UIObject_release(self.dzJob_2);self.dzJob_2=nil;
_UIObject_release(self.dzImage_2);self.dzImage_2=nil;
_UIObject_release(self.dzName_2);self.dzName_2=nil;
_UIObject_release(self.dzBg_2);self.dzBg_2=nil;
_UIObject_release(self.dzName_1);self.dzName_1=nil;
_UIObject_release(self.dzBg_1);self.dzBg_1=nil;
_UIObject_release(self.dzLvBg_1);self.dzLvBg_1=nil;
_UIObject_release(self.dzDesc_1);self.dzDesc_1=nil;
_UIObject_release(self.dzJob_1);self.dzJob_1=nil;
_UIObject_release(self.dzImage_1);self.dzImage_1=nil;
_UIObject_release(self.speGrid_2);self.speGrid_2=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.speGrid_1);self.speGrid_1=nil;
_UIObject_release(self.spDzFlag_1);self.spDzFlag_1=nil;
_UIObject_release(self.spDzFlag_2);self.spDzFlag_2=nil;
self.bottom=nil;
self.speScrollView=nil;
self.resultList=nil;
self.Effect=nil;
self.dzLv=nil;
self.dzLvBg=nil;
self.dzDesc=nil;
self.dzJob=nil;
self.dzImage=nil;
self.dzName=nil;
self.dzBg=nil;
self.speGrid=nil;
self.spDzFlag=nil;
end



















local _this=nil
local abname="ui/windows/dizirelation/disciplecouple_atlas_pak.ab"
local _itemCmp={
attrName=0,
attrOld=1,
arrow=2,
attrNew=3,
effect=4,
specialName=5,
}


function UIDaoLvShuangXiuResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDaoLvShuangXiuResultWin:__delete()
self:unbindComponents()
_this=nil
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
end
end




function UIDaoLvShuangXiuResultWin:onShow(argtable,afterOnloaded)
self.EffectFlag={}
self.EffectFlag[1]=argtable.Effect_1
self.EffectFlag[2]=argtable.Effect_2
self.index=argtable.index

self.picture:setImageIcon(argtable.image,true)
self.descTx:setText(FMT.fmt(argtable.desc,argtable.disciplename))
for i=1,2 do
local netData=UIDiscipleModel:getDiscipleData(argtable.disciple[i])
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
local jobicon=UIDiscipleModel:getJobIconNameX(argtable.disciple[i])
local sixValue=UIDiscipleModel:getDiscipleBaseAttr(argtable.disciple[i],argtable.sixAttrType[i].param_1)
self.dzBg[i]:setSprite(abname,iconname)
self.dzName[i]:setText(netData.disciplename)
self.dzJob[i]:setSprite(globalABLookup.global,jobicon)


local isSpDz=UIDiscipleModel:isSPDiscipleEx(argtable.disciple[i])
self.spDzFlag[i]:setActive(isSpDz)

if argtable.sixAttrType[i].param_1>0 then
self.dzDesc[i]:setText(UIDiscipleModel:getDiscipleBaseAttrDesc(argtable.sixAttrType[i].param_1,sixValue,"<color=#7D3B17>{0}</color> {1}"))
else
self.dzDesc[i]:setActive(false)
end
comHelper.setChildModelRawImage(self.winlua,argtable.disciple[i],self.dzImage[i]:getID(),0,eHeadCenterType.eHead,nil,false)

local listCnt=#argtable.list
local width=math.ceil(listCnt/5)
self.resultList[i]:setChildSizeDelta(width*250+(width-1)*10,204)
self.resultList[i]:setChildLayoutGroupCreateItems(#argtable.list[i],function(index)
local data=argtable.list[i][index]
local item=self.resultList[i]:getChildLayoutGroupGridItem(index-1)
if data.value>0 then
item:SetChildText(_itemCmp.attrName,data.name)
item:SetChildText(_itemCmp.attrNew,mathHelper.formatNumber(data.value,1))
end
item:SetChildActive(_itemCmp.attrName,data.value>0)
item:SetChildActive(_itemCmp.attrNew,data.value>0)



item:ForceLayoutRect(-1)
end)


local tiaits_typo=argtable.tiaitsList[i].param_1
local tiaits_id=argtable.tiaitsList[i].param_2
if tiaits_typo>0 and tiaits_id>0 then
local speCfg=UIDiscipleModel:getSpecialityConfig(tiaits_typo,tiaits_id)
self.speScrollView[i]:setActive(true)
self.speGrid[i]:setChildLayoutGroupCreateItems(1)
local speitem=self.speGrid[i]:getChildLayoutGroupGridItem(0)
UIDiscipleModel.refreshSpecialityItemExx(speitem,speCfg)
speitem:SetChildButtonClick(1,function()
UIManager:showWindow('UISpecialityWin',{item=speitem,node='top',guid=argtable.disciple[i],config=speCfg,pivot=Vector2(0.5,0)})
end)
else
self.speScrollView[i]:setActive(false)
end
self.winlua:ForceLayoutRect(self.resultList[i]:getID())
end

if argtable.before then
argtable.before()
else
self:showResult()
end
end


function UIDaoLvShuangXiuResultWin:onHide()

end





function UIDaoLvShuangXiuResultWin:onBackground()
if self.showing then
UIManager:showWindow('UITopMoneyWin')
self:closeSelf()
end
end

function UIDaoLvShuangXiuResultWin:setAplha(index)
self.speScrollView[index]:setChildCanvasGroupDOFade(1,1)
end

function UIDaoLvShuangXiuResultWin:showResult()
self.root:setActive(true)
self.winlua:ForceLayoutRect(self.resultList[1]:getID())

local args={
widget=self.winlua,
picIdx=self.picture:getID(),
descIdx=self.descTx:getID(),
bottomIdx1=self.bottom_1:getID(),
bottomIdx2=self.bottom_2:getID(),
}
self.bt=behaviorManager:addBehaviorTree("bt_ui_DLSX_result",nil,true,args,true)
end

function UIDaoLvShuangXiuResultWin:showResultFinish()
self.showing=true
end

function UIDaoLvShuangXiuResultWin:showREffect(index)
for i=1,self.index[index]do
if i>1 then
local item=self.resultList[index]:getChildLayoutGroupGridItem(i-1)
item:SetChildShowEffect(_itemCmp.effect,20211,true)
end
end
_this:delayDo(0.6,function()
if self.EffectFlag[index]then
self.Effect[index]:setChildShowEffect(20211,true)
end
end)

end
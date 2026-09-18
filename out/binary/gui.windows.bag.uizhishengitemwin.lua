







def_class("UIZhiShengItemWin",UIWindowBase)









function UIZhiShengItemWin:bindComponents()

self.changebtn=UIButton.get(self,0)
self.choosebtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.floorimg1=UIImage.get(self,3)
self.floorimg2=UIImage.get(self,4)
self.floorimg3=UIImage.get(self,5)
self.floorimg4=UIImage.get(self,6)
self.floorimg5=UIImage.get(self,7)
self.floorimg6=UIImage.get(self,8)
self.floorimg7=UIImage.get(self,9)
self.floorimg8=UIImage.get(self,10)
self.floorimg9=UIImage.get(self,11)
self.floorimgs=UIObject.get(self,12)
self.itembtn=UIButton.get(self,13)
self.itemEffect=UIObject.get(self,14)
self.name=UIText.get(self,15)
self.npcClicker=UIButton.get(self,16)
self.npcModel=UIObject.get(self,17)
self.roleEffect=UIObject.get(self,18)
self.rolepanel=UIObject.get(self,19)
self.speakObj=UIObject.get(self,20)
self.speakText=UIText.get(self,21)
self.tips1=UIText.get(self,22)
self.tips2=UIText.get(self,23)
self.tipspanel=UIObject.get(self,24)
self.usebtn=UIButton.get(self,25)

self.changebtn:setButtonClick(function()self:onChangebtn()end)

self.choosebtn:setButtonClick(function()self:onChoosebtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.itembtn:setButtonClick(function()self:onItembtn()end)

self.npcClicker:setButtonClick(function()self:onNpcClicker()end)

self.usebtn:setButtonClick(function()self:onUsebtn()end)



end


function UIZhiShengItemWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changebtn);self.changebtn=nil;
_UIObject_release(self.choosebtn);self.choosebtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.floorimg1);self.floorimg1=nil;
_UIObject_release(self.floorimg2);self.floorimg2=nil;
_UIObject_release(self.floorimg3);self.floorimg3=nil;
_UIObject_release(self.floorimg4);self.floorimg4=nil;
_UIObject_release(self.floorimg5);self.floorimg5=nil;
_UIObject_release(self.floorimg6);self.floorimg6=nil;
_UIObject_release(self.floorimg7);self.floorimg7=nil;
_UIObject_release(self.floorimg8);self.floorimg8=nil;
_UIObject_release(self.floorimg9);self.floorimg9=nil;
_UIObject_release(self.floorimgs);self.floorimgs=nil;
_UIObject_release(self.itembtn);self.itembtn=nil;
_UIObject_release(self.itemEffect);self.itemEffect=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.npcClicker);self.npcClicker=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.roleEffect);self.roleEffect=nil;
_UIObject_release(self.rolepanel);self.rolepanel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.tips1);self.tips1=nil;
_UIObject_release(self.tips2);self.tips2=nil;
_UIObject_release(self.tipspanel);self.tipspanel=nil;
_UIObject_release(self.usebtn);self.usebtn=nil;
end

















local _this
local floorffect=
{
[1]=18028,
[2]=18028,
[3]=18028,
[4]=18029,
[5]=18029,
[6]=18029,
[7]=18030,
[8]=18030,
[9]=18030,
}
local ab_name="ui/windows/bag/bag_atlas_pak.ab"


function UIZhiShengItemWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
end


function UIZhiShengItemWin:__delete()
self:unbindComponents()
self.fightStage:close()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
_this=nil
end




function UIZhiShengItemWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.fightStage=argtable.fightStage
self.itemid=argtable.itemid
self.itemConfig=itemsConfig.getConfig(self.itemid)
local funcparam=self.itemConfig.funcparam
if funcparam then
self.uplevel=funcparam.level
self.limit=funcparam.limit
end
self.select_guid=nil
self.oldlevel=nil
self.oldlevel_floor=nil
self.oldattrLookup=nil

self.itemEffect:setChildShowEffect(18027,true)

self.name:setText(self.itemConfig.name)

self:Initfreahinfo()
end


function UIZhiShengItemWin:onHide()

end


function UIZhiShengItemWin:myClose()
fullScreenUI.closeActiveUI(true)
end
function UIZhiShengItemWin:onCloseClick()
self:myClose()
end
function UIZhiShengItemWin:onCloseBtn()
self:myClose()
end


function UIZhiShengItemWin:Initfreahinfo()



self.choosebtn:setActive(true)
self.rolepanel:setActive(false)

local itemname=self.itemConfig.name or""
local n,p,pN=UIDiscipleModel:getJJNameX(self.uplevel)
local itemlvl=FMT.fmt('{0}{1}',n,pN)
local str1=FMT.fmt('使用<color=#fd8950>{0}</color>将弟子境界直接提升至<color=#fd8950>{1}</color>',itemname,itemlvl)
self.tips1:setText(str1)

local str2=FMT.fmt('弟子提升至{0}后不会返还已消耗的境界丹药',itemlvl)
self.tips2:setText(str2)

end


function UIZhiShengItemWin:onUsebtn()

if not _this.select_guid then
local itemname=self.itemConfig.name or"丹药"
UIManager.error(FMT.fmt('请选择需要服用{0}的弟子',itemname))
return
end
if _this.select_guid and _this.itemid then
local dizData=UIDiscipleModel:getDiscipleData(_this.select_guid)
local jingJieLv=dizData.jingjielv
self.oldlevel=jingJieLv
self.oldlevel_floor=UIDiscipleModel:getJJFloor(jingJieLv)
self.oldattrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(_this.select_guid,false)

bagProtocolControl.req_dizi_use_item(_this.select_guid,_this.itemid,1)
end
end


function UIZhiShengItemWin:onChoosebtn()
self:showWindow('UIZSitemDiscipleSelect',{itemid=self.itemid,select_dz=_this.select_guid})
end
function UIZhiShengItemWin:onChangebtn()
self:showWindow('UIZSitemDiscipleSelect',{itemid=self.itemid,select_dz=_this.select_guid})
end
function UIZhiShengItemWin:onNpcClicker()
self:showWindow('UIZSitemDiscipleSelect',{itemid=self.itemid,select_dz=_this.select_guid})
end

function UIZhiShengItemWin:onItembtn()
tipsManager.showTips({itemid=self.itemid,itemguid=nil})
end


function UIZhiShengItemWin:refreshrole(select_guid)
_this.select_guid=select_guid
_this.choosebtn:setActive(false)
_this.rolepanel:setActive(true)








local modelEntity=_this.fightStage:getEntity(100)

if modelEntity then
_this.fightStage:removeEntity(100)
_this.fightStage:addEntity(100,fightEntityType.diZi,_this.select_guid,fightModel.getWorldCenter(),true)
else
_this.fightStage:addEntity(100,fightEntityType.diZi,_this.select_guid,fightModel.getWorldCenter(),true)
end

_this:doSpeaking_player(1)
end


function UIZhiShengItemWin:doSpeaking_player(speakType)



local speakList={}
if speakType==1 then
speakList={"祖师要选我吗？","一步登天，就在眼前！","没想到竟能得此天大机缘"}
elseif speakType==2 then
speakList={"祖师要选我吗？","一步登天，就在眼前！","没想到竟能得此天大机缘"}
end
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
_this:doTalkAnim_player()
end
function UIZhiShengItemWin:doTalkAnim_player()
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end
_this.speakObj:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.talkTween2=_this.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.speakObj:setChildDOScale(0.9,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return _this:talkEnd()
end)
end)
end)
end
function UIZhiShengItemWin:talkEnd()
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this.speakShowTimer=_this:delayDo(3.5,function()
if _this==nil then return end
_this.speakObj:setScale(Vector3.zero)
_this.speakObj:setChildCanvasGroupAlpha(0)
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end


function UIZhiShengItemWin:closeSpeak()
_this.speakObj:setChildCanvasGroupAlpha(0)
end


function UIZhiShengItemWin:doplayAnima()
_this.changebtn:setActive(false)
_this.usebtn:setActive(false)
_this.closeBtn:setActive(false)
_this.npcClicker:setActive(false)





local dizData=UIDiscipleModel:getDiscipleData(_this.select_guid)
local jingJieLv=dizData.jingjielv
local new_floor=UIDiscipleModel:getJJFloor(jingJieLv)
local old_floor=self.oldlevel_floor
local upnum=new_floor-old_floor
if upnum==0 then
upnum=1
end

local floorwidget=_this.floorimgs:getWidgetBase()

_this.itemEffect:setChildShowEffect(18031,true)
local delay=1
for i=1,upnum do
local nextfloor=old_floor+i
if upnum==1 then
nextfloor=old_floor
end
local index=i-1
_this:delayDo(delay,function()
if _this==nil then return end

_this.roleEffect:setChildShowEffect(floorffect[nextfloor],true)
floorwidget:SetChildCSImageSprite(index,ab_name,FMT.fmt('title_zhishegnjindan_0{0}',nextfloor))
floorwidget:SetChildLocalPosY(index,85)
floorwidget:SetChildScale(index,Vector3(0.4,0.4,1))
floorwidget:SetChildCanvasGroupAlpha(index,0)


self:dotesttttttAnima(1,{0,1,0},5,5)











_this:delayDo(0.5,function()
if _this==nil then return end

floorwidget:SetChildDOScale(index,1,0.5)
floorwidget:SetChildDOLocalMoveY(index,321,0.6)
floorwidget:SetChildCanvasGroupDOFade(index,1,0.5)
if i~=upnum then
_this:delayDo(0.5,function()
floorwidget:SetChildCanvasGroupDOFade(index,0,0.2)
end)
end
end)
end)
delay=delay+1.2
end

delay=delay+1.5
_this:delayDo(delay,function()
if _this==nil then return end
_this.closeBtn:setActive(true)
self:showWindow('UIDiscipleZhiShengUpWin',{disciple_guid=_this.select_guid,oldattrLookup=_this.oldattrLookup,oldlevel=_this.oldlevel})
end)
end


function UIZhiShengItemWin.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)

if _this.itemid and _this.itemid==itemid then
_this.tipspanel:setChildCanvasGroupDOFade(0,0.2)
_this:closeSpeak()
_this:doplayAnima()
end
end

function UIZhiShengItemWin:shakeSceneCamera(duration,strength,vibrato,callback)
local transform=fightManager.getCameraTransform()

local tweener=_DOTweenProxy.DOShakePosition(transform,duration,strength,vibrato)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(callback)
return tweener
end



function UIZhiShengItemWin:dotesttttttAnima(duration,point,vibrato,randomness)

fightManager.shakePosition(duration,Vector3(point[1],point[2],point[3]),vibrato,randomness,false)
end

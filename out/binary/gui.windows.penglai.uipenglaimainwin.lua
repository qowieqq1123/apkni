







def_class("UIPengLaiMainWin",UIWindowBase)









function UIPengLaiMainWin:bindComponents()

self.bgeffect=UIObject.get(self,0)
self.bgeffect2=UIObject.get(self,1)
self.btnBangYu=UIButton.get(self,2)
self.btnBaoKu=UIButton.get(self,3)
self.btnClose=UIButton.get(self,4)
self.btnGroup=UIObject.get(self,5)
self.btnShiLi=UIButton.get(self,6)
self.btnXianGuan=UIButton.get(self,7)
self.content=UIObject.get(self,8)
self.reddotShiLi=UIObject.get(self,9)
self.reddotXianGongBangYu=UIObject.get(self,10)
self.reddotXianGuan=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.StrangeAnimalSpine1=UIObject.get(self,13)
self.StrangeAnimalSpine2=UIObject.get(self,14)
self.StrangeAnimalSpine3=UIObject.get(self,15)

self.btnBangYu:setButtonClick(function()self:onBtnBangYu()end)

self.btnBaoKu:setButtonClick(function()self:onBtnBaoKu()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnShiLi:setButtonClick(function()self:onBtnShiLi()end)

self.btnXianGuan:setButtonClick(function()self:onBtnXianGuan()end)



end


function UIPengLaiMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgeffect);self.bgeffect=nil;
_UIObject_release(self.bgeffect2);self.bgeffect2=nil;
_UIObject_release(self.btnBangYu);self.btnBangYu=nil;
_UIObject_release(self.btnBaoKu);self.btnBaoKu=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnGroup);self.btnGroup=nil;
_UIObject_release(self.btnShiLi);self.btnShiLi=nil;
_UIObject_release(self.btnXianGuan);self.btnXianGuan=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.reddotShiLi);self.reddotShiLi=nil;
_UIObject_release(self.reddotXianGongBangYu);self.reddotXianGongBangYu=nil;
_UIObject_release(self.reddotXianGuan);self.reddotXianGuan=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.StrangeAnimalSpine1);self.StrangeAnimalSpine1=nil;
_UIObject_release(self.StrangeAnimalSpine2);self.StrangeAnimalSpine2=nil;
_UIObject_release(self.StrangeAnimalSpine3);self.StrangeAnimalSpine3=nil;
end


















local _this

function UIPengLaiMainWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)

xianjieModel:closeForceResetCamera()
end


function UIPengLaiMainWin:__delete()
self:unbindComponents()
_this=nil
UIManager:closeActiveWindow("UIXianJieForceWin")
if self.btlistp and next(self.btlistp)then
for k,v in ipairs(self.btlistp)do
uiAIManager:removeUIInstance(v)
end
end

end




function UIPengLaiMainWin:onShow(argtable,afterOnloaded)
if not webGLHelper:isRunMiniGame()then
self.bgeffect:setChildShowEffect(20475,true)
end
self.bgeffect2:setChildShowEffect(20512,true)

self.nowindex=0
self:PlayStrangeAnimal()
self:setRemainingTimeTimer()

local showRoot=argtable==nil or argtable.onlyBg~=true
self:showRoot(showRoot)

local open=systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
self.btnGroup:setActive(open)

self:refreshShiLiButton()
end


function UIPengLaiMainWin:onHide()

end


function UIPengLaiMainWin:setRemainingTimeTimer()

self.nowtime=0
local func=function()
self.nowtime=self.nowtime+1
if self.nowtime>=self.alltime then
if self.btlistp and next(self.btlistp)then
for k,v in ipairs(self.btlistp)do
uiAIManager:removeUIInstance(v)
end
end
self:PlayStrangeAnimal()
self.nowtime=0
end
end

self.timer=self:setTimer(1,0,func)
end


function UIPengLaiMainWin:PlayStrangeAnimal(randtable)
self.btlistp={}

local StrangeAnimal=cfgHelper.get2(cfg_xianjieforceconfig_get,3,'StrangeAnimal')
self.max=0

for k,v in ipairs(StrangeAnimal)do
self.max=v[1]+self.max
end
if self.nowindex>0 then
self.max=self.max-StrangeAnimal[self.nowindex][1]
end


local num=math.random(1,self.max)

local index=1
for i=1,#StrangeAnimal do
if i==self.nowindex then

elseif StrangeAnimal[i][1]>=num then
index=i
break
else
num=num-StrangeAnimal[i][1]
end
end
self.nowindex=index

local randcfg=StrangeAnimal[index]
self.alltime=randcfg[2]

local allAnimal=randtable
if randtable then
allAnimal=randtable
else
allAnimal=randcfg[3]
end
self.showtable={}
self.showtableindex={}
self.scaletable={}
self.scaleindex={}
if not allAnimal then
return
end
for i=1,#allAnimal do

local singleAnimal=allAnimal[i]
local animalspine=singleAnimal[1]
local shownum=singleAnimal[7]and#singleAnimal[7]or 0
local scalenum=singleAnimal[8]and#singleAnimal[8]or 0
local initData=
{
myid=i,
scaleStateId=-1,
canvasStateId=-1,
animalspine=singleAnimal[1],
beginpos=singleAnimal[2],
endpos=singleAnimal[3],
speedtime=singleAnimal[4],
rotation=singleAnimal[5],
scale=singleAnimal[6],
shownum=shownum,
beginshow=0,
endshow=0,
changevalue=0,
scalenum=scalenum,
beginscale=0,
endscale=0,
changeScalevalue=0,
}
local cav=self:getChildCanvas(-1)

local otherdata=
{
order=cav[2]+4
}
local func=function(bt)
self.btlistp[#self.btlistp+1]=bt
self.showtable[i]=singleAnimal[7]

self.showtableindex[i]=0
self.scaletable[i]=singleAnimal[8]
self.scaleindex[i]=0


end

local tran=self.content:getCommonComponent('Transform')
local vpos=Vector2.New(singleAnimal[2][1],singleAnimal[2][2])
local modelId=animalspine
uiAIManager:createUIObject('UIPengLaiMainWin','bt_ui_xianjiePengLai',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,otherdata,func)
end
end


function UIPengLaiMainWin:ChangeCanvasGroupFade(bt,myid)
self.showtableindex[myid]=self.showtableindex[myid]+1
local nowindex=self.showtableindex[myid]
local nowshowtable=self.showtable[myid]
if nowshowtable and nowshowtable[nowindex]then
local datatb=nowshowtable[nowindex]
local begintime=datatb[1]
if nowindex>1 then
begintime=datatb[1]-nowshowtable[nowindex-1][2]
end
bt:setSharedVar('beginshow',begintime)
local usetime=datatb[2]-datatb[1]
usetime=usetime>0 and usetime or 0
bt:setSharedVar('endshow',usetime)
bt:setSharedVar('changevalue',datatb[3])

bt:setSharedVar('canvasStateId',0)
else
bt:setSharedVar('canvasStateId',-1)
end
end



function UIPengLaiMainWin:ChangeScale(bt,myid)
self.scaleindex[myid]=self.scaleindex[myid]+1
local nowindex=self.scaleindex[myid]
local nowscaletable=self.scaletable[myid]
if nowscaletable and nowscaletable[nowindex]then
local datatb=nowscaletable[nowindex]
local begintime=datatb[1]
if nowindex>1 then
begintime=datatb[1]-nowscaletable[nowindex-1][2]
end
bt:setSharedVar('beginscale',begintime)
local usetime=datatb[2]-datatb[1]
usetime=usetime>0 and usetime or 0
bt:setSharedVar('endscale',usetime)
bt:setSharedVar('changeScalevalue',datatb[3])

bt:setSharedVar('scaleStateId',0)
else
bt:setSharedVar('scaleStateId',-1)
end
end


function UIPengLaiMainWin:SetMovePengLai(widget,val,duration)
if type(val)=='table'then
val=Vector3(val[1],val[2],val[3]or 0)
end
local tweener=widget:SetChildDOLocalMove(0,val,duration,nil)
tweener:SetEase(DG.Tweening.Ease.Linear)
end




function UIPengLaiMainWin:onBtnBangYu()
end



function UIPengLaiMainWin:onBtnBaoKu()
end



function UIPengLaiMainWin:onBtnClose()
UIFullXJForceControl:closeUI()
end



function UIPengLaiMainWin:onBtnShiLi()
local args={
parentWin=UIFullXJForceControl,
select=xianjieForceType.ePengLai,
}
UIFullXJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end



function UIPengLaiMainWin:onBtnXianGuan()
end


function UIPengLaiMainWin:showRoot(show)
self.root:setActive(show)
end

function UIPengLaiMainWin:Scrollchange()
local w=self.winlua:GetChildSizeDeltaY(self.content:getID())
local localPosX=self.winlua:GetChildLocalPosition(self.content:getID()).x
UIManager:invokeUIMethod("UIXianJieForceWin","ChangeScrowview",localPosX)
end

function UIPengLaiMainWin.refreshShiLiReddot()
if _this==nil then return end
local reddot=xjFactionNPCModel:getFactionReddot(xianjieForceType.ePengLai)
_this.reddotShiLi:setActive(reddot)
end

function UIPengLaiMainWin.onXianJieFactionReddotChange(factionList)
if table.containsValue(factionList,xianjieForceType.ePengLai)then
_this.refreshShiLiReddot()
end
end

function UIPengLaiMainWin:refreshShiLiButton()
local show=systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)
self.btnShiLi:setActive(show)
if show then
self.refreshShiLiReddot()
end
end

function UIPengLaiMainWin.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXianJieShiLiJH then
_this:refreshShiLiButton()
end
end
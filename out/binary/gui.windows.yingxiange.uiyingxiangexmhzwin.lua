







def_class("UIYingXianGeXMHZWin",UIWindowBase)









function UIYingXianGeXMHZWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.gxRoot=UIObject.get(self,1)
self.helpAllBtn=UIButton.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.notLog=UIObject.get(self,4)
self.progress=UIProgress.get(self,5)
self.progressText=UIText.get(self,6)
self.root=UIObject.get(self,7)
self.tips=UIText.get(self,8)
self.yuanjunGrid=UIObject.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpAllBtn:setButtonClick(function()self:onHelpAllBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIYingXianGeXMHZWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gxRoot);self.gxRoot=nil;
_UIObject_release(self.helpAllBtn);self.helpAllBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.yuanjunGrid);self.yuanjunGrid=nil;
end


















local yjCmp={
desc=0,
helpBtn=1,
progress=2,
time=3,
head=4,
levelTx=5,
playerName=6,
item=7,
bg1=8,
me=9,
}


function UIYingXianGeXMHZWin:onLoaded(...)
self:bindComponents()
end


function UIYingXianGeXMHZWin:__delete()
self:unbindComponents()
end




function UIYingXianGeXMHZWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIYingXianGeXMHZWin:onHide()

end

function UIYingXianGeXMHZWin:refresh()
self:refreshList()
self:refreshInfo()
end

function UIYingXianGeXMHZWin:refreshList()









self.list=xianjieModel:getCooperaionList()
local len=#self.list

self.notLog:setActive(len<=0)

self.yuanjunGrid:setChildLayoutGroupCreateItems(len)
local grids=self.yuanjunGrid:getChildLayoutGroupGridList()
for idx=1,len do
local data=self.list[idx]
local itemCmp=grids[idx-1]

local addTime,maxCount=YingXianGeModel:getReduceTimesData(data.actorid)
local times=math.min(maxCount,data.times)
local isMax=times>=maxCount
local isSelfPlayer=playerModel:checkActorId(data.actorid)
local isHelp=xianjieModel:getIsHelp(data.guid)
local actorData=xianmengModel:getXMMemberData(data.actorid)
playerController:setHeadIcon(itemCmp,yjCmp.head,{iconInfo=actorData.head})

itemCmp:SetChildActive(yjCmp.helpBtn,not isHelp and not isSelfPlayer and not isMax)
itemCmp:SetChildActive(yjCmp.progress,isHelp or isSelfPlayer or isMax)
itemCmp:SetChildActive(yjCmp.bg1,isHelp or isSelfPlayer or isMax)
itemCmp:SetChildActive(yjCmp.me,isSelfPlayer)

itemCmp:SetChildText(yjCmp.levelTx,actorData.level)
itemCmp:SetChildText(yjCmp.playerName,actorData.actorname)

itemCmp:SetChildText(yjCmp.time,"")

local _params={}
if data.params and data.params~=""then
_params=jsonHelper.decode(data.params)
end
if xianjie_HuZhuTypeFunc[data.type2]then
if isSelfPlayer then
itemCmp:SetChildText(yjCmp.desc,FMT.fmt("请帮助我{0}",xianjie_HuZhuTypeFunc[data.type2].getDesc(_params)))
elseif isHelp then
itemCmp:SetChildText(yjCmp.desc,FMT.fmt("已帮助盟友{0}",xianjie_HuZhuTypeFunc[data.type2].getDesc(_params)))
else
itemCmp:SetChildText(yjCmp.desc,FMT.fmt("请盟友帮助{0}",xianjie_HuZhuTypeFunc[data.type2].getDesc(_params)))
end
else
itemCmp:SetChildText(yjCmp.desc,FMT.fmt("玩法类型{0}",data.type2))
end

itemCmp:SetChildProgressValue(yjCmp.progress,times,maxCount)
itemCmp:SetChildProgressText(yjCmp.progress,FMT.fmt("{0}/{1}",times,maxCount))

itemCmp:SetChildButtonClick(yjCmp.helpBtn,function()
xianjieController.reqCooperation(data.guid)
end)
end
end

function UIYingXianGeXMHZWin:refreshInfo()
local _,_,add,max=YingXianGeModel:getReduceTimesData()
local cur=xianmengModel:getXMCooperationEarn()
local str=FMT.fmt('{0}/{1}',cur,max)
self.progress:setProgressValue(cur,max)
self.progress:setChildProgressText(str)

self.gxRoot:setActive(cur<max)
self.tips:setText(FMT.fmt("每次帮助：+{0}",add))

local list=xianjieModel:getCooperaionList()
local isGray=true
for i,v in ipairs(list)do
local addTime,maxCount=YingXianGeModel:getReduceTimesData(v.actorid)
local isSelfPlayer=playerModel:checkActorId(v.actorid)
local isMax=v.times>=maxCount
local isHelp=xianjieModel:getIsHelp(v.guid)
if not isHelp and not isSelfPlayer and not isMax then
isGray=false
break
end
end
self.helpAllBtn:setGray(isGray)
end





function UIYingXianGeXMHZWin:onCloseBtn()
self:closeSelf()
end



function UIYingXianGeXMHZWin:onHelpAllBtn()
xianjieController:reqHelpAll()
end



function UIYingXianGeXMHZWin:onHelpBtn()
local d={}
d.title='仙盟互助规则'
d.mode=3
d.name='yxg_xmhz_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

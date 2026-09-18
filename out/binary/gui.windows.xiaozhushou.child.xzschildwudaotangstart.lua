







def_class("xzsChildWuDaoTangStart",UICloneObject)





xzsChildWuDaoTangStart.abName="ui/windows/xiaozhushou/child/xzschildwudaotangstart.ab"

xzsChildWuDaoTangStart.assetName="xzsChildWuDaoTangStart"


function xzsChildWuDaoTangStart:bindComponents()

self.doingText=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.progress=UIProgressBarAni.get(self,2)
self.rewardContent=UIObject.get(self,3)
self.rewardPanel=UIObject.get(self,4)
self.title=UIText.get(self,5)
self.wddesc=UIText.get(self,6)
self.wdicon=UIImage.get(self,7)
self.wdcost=UIText.get(self,8)
self.wdpanel=UIText.get(self,9)

end


function xzsChildWuDaoTangStart:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.wddesc);self.wddesc=nil;
_UIObject_release(self.wdicon);self.wdicon=nil;
_UIObject_release(self.wdcost);self.wdcost=nil;
_UIObject_release(self.wdpanel);self.wdpanel=nil;
end






local fangan=
{
[1]='一旬悟道',
[2]='三旬悟道',
[3]='甲子悟道',
}



function xzsChildWuDaoTangStart:onLoaded(...)
self:bindComponents()
end


function xzsChildWuDaoTangStart:__delete()
self:unbindComponents()
end




function xzsChildWuDaoTangStart:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
local min_t,max_t=detailCfg.time[1],detailCfg.time[2]
local time=math.min(argtable.time or min_t,max_t)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.progress:animateFiveParams(0,1,1,time,false)
self.doingText:setText(detailCfg.timeTxt)





self.flag=argtable.flag
self.curlist=argtable.curlist or{}
self.str=argtable.str
self.planid=argtable.planid or 1
self.cost=argtable.cost

self.wddesc:setText("")
self.wdpanel:setActive(false)

self:delayDo(time,function()
self:refreshdesc()
xiaoZhuShouController:setIdleState()
end)
end


function xzsChildWuDaoTangStart:onHide()

end


function xzsChildWuDaoTangStart:refreshdesc()
if self.flag==1 then
local name=''
if#self.curlist>0 then
local netdata=UIDiscipleModel:getDiscipleData(self.curlist[1])
if netdata then
name=UIDiscipleModel:getDiscipleName(self.curlist[1])or''
end
end
if#self.curlist>1 then
for i=2,#self.curlist do
local dzguid=self.curlist[i]
if dzguid then
local netdata=UIDiscipleModel:getDiscipleData(dzguid)
if netdata then
name=FMT.fmt("{0}、{1}",name,UIDiscipleModel:getDiscipleName(dzguid)or'')
end
end
end
end
local desc=FMT.fmt("<color=#7d3b17>{0}</color>已在悟道堂中进行<color=#7d3b17>{1}</color>",name,fangan[self.planid])
self.wddesc:setText(desc)
if self.cost then
self.wdpanel:setActive(true)
local cost2=self.cost[2]or 1
self.wdcost:setText(cost2)
end

elseif self.flag==2 then
self.wddesc:setText(self.str)
if self.cost then
self.wdpanel:setActive(false)


end

elseif self.flag==3 then
self.wddesc:setText(self.str)
if self.cost then
self.wdpanel:setActive(true)
local cost2=self.cost[2]or 1
self.wdcost:setText(FMT.fmt("<color=#c82c2c>{0}</color>",cost2))
end

elseif self.flag==4 then
self.wddesc:setText("已有弟子在悟道中")

elseif self.flag==5 then
self.wddesc:setText("暂无奖励可领取")

elseif self.flag==6 then
self.wddesc:setText("请先预选需要悟道的弟子")
end
end


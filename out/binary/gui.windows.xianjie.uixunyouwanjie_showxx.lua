







def_class("UIXunYouWanJie_showXX",UIWindowBase)









function UIXunYouWanJie_showXX:bindComponents()

self.itemlist=UIObject.get(self,0)
self.surebtn=UIButton.get(self,1)

self.surebtn:setButtonClick(function()self:onSurebtn()end)



end


function UIXunYouWanJie_showXX:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemlist);self.itemlist=nil;
_UIObject_release(self.surebtn);self.surebtn=nil;
end


















local abname='ui/windows/xianjie/xg_xunyouwanjie_atlas_pak.ab'

function UIXunYouWanJie_showXX:onLoaded(...)
self:bindComponents()
end


function UIXunYouWanJie_showXX:__delete()
self:unbindComponents()
end




function UIXunYouWanJie_showXX:onShow(argtable,afterOnloaded)
self.tqData=argtable
if not self.tqData then
return
end
if self.tqData.tqid==14 then
local len=self.tqData.len
if len<=0 then
logErr("生成互见怪物列表长度小于等于0")
return
end
local list=self.tqData.list
local infoguid=list[1].param_1
local monsterData=xianjieModel:getMonsterData(infoguid)
local monstercfg=monsterData:getCfg()
local xianguan_xianxu=monstercfg.xianguan_xianxu

local fatherwid=self.itemlist:getWidgetBase()
local cfg=cfgHelper.get1(cfg_xianguanxianxutypeconfig_get,xianguan_xianxu)
local node=fatherwid:GetChildWidgetBase(0)
local rewardlist=cfg.rewardlist
node:SetChildScrollViewCreateGrids(1,#rewardlist,#rewardlist)
local childgrids=node:GetChildScrollViewItemWidgets(1)
local childcount=childgrids.Count
for child=0,childcount-1 do
local childnode=childgrids[child]
local data=rewardlist[child+1]
local num=data[2]
widgetHelper.setNormalRewardItem(childnode,0,{data[1],num})
end
local modelSet=cfg.modelSet
node:SetChildUIModelShowTarget(2,modelSet[1],modelSet[2],nil,eAnimationID.stand)
node:SetChildUIModelShowTargetOffset(2,modelSet[3],modelSet[4])
node:SetChildText(4,(cfg.probability*100).."%")
node:SetChildCSImageSprite(5,abname,cfg.name)
node:SetChildCSImageSprite(3,abname,cfg.probability_bgimg)
end

end


function UIXunYouWanJie_showXX:onHide()

end

function UIXunYouWanJie_showXX:onSurebtn()
xianguanConfig.commonLogJump(self.tqData.xgid,self.tqData.tqid)
UIManager:closeWindow("UIXunYouWanJie_showXX")
end




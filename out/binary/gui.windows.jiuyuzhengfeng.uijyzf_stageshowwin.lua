







def_class("UIJYZF_StageShowWin",UIWindowBase)









function UIJYZF_StageShowWin:bindComponents()

self.stageScrollView=UILoopListView.new(self,0)
self.closeBtn=UIButton.get(self,1)

self.stageScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIJYZF_StageShowWin:unbindComponents()
local _UIObject_release=UIObject.release
self.stageScrollView:deleteSelf();self.stageScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local cmpIndex={
bg=0,
model=1,
name=2,
selfFlag=3,
}
local abName="ui/windows/jiuyuzhengfeng/jyzf_atlas_pak.ab"




function UIJYZF_StageShowWin:onLoaded(...)
self:bindComponents()
end


function UIJYZF_StageShowWin:__delete()
self:unbindComponents()
end




function UIJYZF_StageShowWin:onShow(argtable,afterOnloaded)
local cfg=cfg_xianyulevelcconfig()
self.stageScrollView:setChildScrollRectEnable(#cfg>4)
local list=table.deepCopy(cfg)
local namelist={}
for i,v in ipairs(list)do
namelist[i]="stageItem"
end
table.insert(list,1,{})
table.insert(namelist,1,"emptyItem")
self.stageScrollView:initDataEx(namelist,list,#list)
end


function UIJYZF_StageShowWin:onHide()

end

function UIJYZF_StageShowWin:onFreshAction(index,widget,data)
if index==1 then
return
end
local showCfg=data.showCfg
widget:SetChildCSImageSprite(cmpIndex.bg,abName,showCfg.bgName)
widget:SetChildAnchoredPos(cmpIndex.bg,showCfg.bgPos.x,showCfg.bgPos.y)
widget:SetChildText(cmpIndex.name,data.name)
widget:SetChildAnchoredPos(cmpIndex.name,showCfg.namePos.x,showCfg.namePos.y)
widget:SetChildActive(cmpIndex.selfFlag,data.id==JiuYuZhengFengModel:getData_rank_level())
widget:SetChildAnchoredPos(cmpIndex.selfFlag,showCfg.flagPos.x,showCfg.flagPos.y)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
widget:SetChildUIModelEnableInitUISpineParaEx(cmpIndex.model,true,true,true)
end
widget:SetChildUIModelShowTarget(cmpIndex.model,data.model,1,nil,eAnimationID.stand)
widget:SetChildAnchoredPos(cmpIndex.model,showCfg.modelCfg.x,showCfg.modelCfg.y)
local size=showCfg.modelCfg.size
widget:SetChildScale(cmpIndex.model,Vector3(size,size,size))
end

function UIJYZF_StageShowWin:onStartAction(index,widget,data)
end





function UIJYZF_StageShowWin:onCloseBtn()
self:closeSelf()
end


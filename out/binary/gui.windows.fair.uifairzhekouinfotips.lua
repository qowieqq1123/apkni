







def_class("UIFairZheKouInfoTips",UIWindowBase)









function UIFairZheKouInfoTips:bindComponents()

self.itemGreator=UIObject.get(self,0)



end


function UIFairZheKouInfoTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemGreator);self.itemGreator=nil;
end



















function UIFairZheKouInfoTips:onLoaded(...)
self:bindComponents()
end


function UIFairZheKouInfoTips:__delete()
self:unbindComponents()
UIManager:invokeUIMethod('UIFairWin','refreshZheKouInfoImg')
if self.moveXTween then
for i,v in pairs(self.moveXTween)do
v:Kill(false)
end
end
end




function UIFairZheKouInfoTips:onShow(argtable,afterOnloaded)
local discipleguid=argtable.guid
local haveDz=tostring(discipleguid)~='0'
local skill_id=DISCIPLE_PROSKILL_TYPE.eShangDao
local zheKouInfos=cfgHelper.get2(cfg_discipleproskillconfig_get,skill_id,'fangshi_discount_info')
local list={}
for k,v in pairs(zheKouInfos)do
table.insert(list,{level=k,zhekou=v})
end
table.sort(list,function(a,b)return a.level<b.level end)
local curIdx
if haveDz then
local proLevel=UIDiscipleModel:getDiscipleJobLevel(discipleguid,skill_id)
for i,v in ipairs(list)do
if proLevel>=v.level then
curIdx=i
end
end
end
self.itemGreator:setChildLayoutGroupCreateItems(#list)
self.moveXTween={}
local itemGrid=self.itemGreator:getChildLayoutGroupGridList()
for i=1,#list do
local item=itemGrid[i-1]
local info=list[i]
local colorStr='#CACACA'
if curIdx and curIdx==i then
colorStr='#76d81e'
end
local descStr1=FMT.fmt('<color={0}>{1}</color>',colorStr,info.level)
local descStr2=FMT.fmt('<color={0}>{1}</color>',colorStr,info.zhekou)
item:SetChildText(0,descStr1)
item:SetChildText(1,descStr2)
item:SetChildActive(2,curIdx and curIdx==i)
if curIdx==i then
self.moveXTween[i]=item:SetChildDOLocalMoveX(2,-130,1.2,nil)
self.moveXTween[i]:SetEase(_Ease.Linear)
self.moveXTween[i]:SetLoops(-1,_LoopType.Yoyo)
end
end
end


function UIFairZheKouInfoTips:onHide()

end




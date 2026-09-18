







def_class("tipsChildScrollView3",UICloneObject)





tipsChildScrollView3.abName="ui/windows/tips/child/tipschildscrollview3.ab"

tipsChildScrollView3.assetName="tipsChildScrollView3"


function tipsChildScrollView3:bindComponents()

self.nodeTopTop=UIObject.get(self,0)
self.nodeTopMiddle=UIObject.get(self,1)
self.nodeTopBottom=UIObject.get(self,2)
self.nodeMiddleTop=UIObject.get(self,3)
self.nodeMiddleMiddle=UIObject.get(self,4)
self.nodeMiddleBottom=UIObject.get(self,5)
self.nodeBottomTop=UIObject.get(self,6)
self.nodeBottomMiddle=UIObject.get(self,7)
self.nodeBottomBottom=UIObject.get(self,8)
self.creater=UIGameobjectClone.new(self,9)
self.Content=UIObject.get(self,10)
self.ScrollView=UIObject.get(self,11)

end


function tipsChildScrollView3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nodeTopTop);self.nodeTopTop=nil;
_UIObject_release(self.nodeTopMiddle);self.nodeTopMiddle=nil;
_UIObject_release(self.nodeTopBottom);self.nodeTopBottom=nil;
_UIObject_release(self.nodeMiddleTop);self.nodeMiddleTop=nil;
_UIObject_release(self.nodeMiddleMiddle);self.nodeMiddleMiddle=nil;
_UIObject_release(self.nodeMiddleBottom);self.nodeMiddleBottom=nil;
_UIObject_release(self.nodeBottomTop);self.nodeBottomTop=nil;
_UIObject_release(self.nodeBottomMiddle);self.nodeBottomMiddle=nil;
_UIObject_release(self.nodeBottomBottom);self.nodeBottomBottom=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end









function tipsChildScrollView3:onLoaded(...)
self:bindComponents()
end


function tipsChildScrollView3:__delete()
self:unbindComponents()
end

function tipsChildScrollView3:onShow(args)
local widget=self.widget
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local tipsType=data.tipsType
local addBody=data.addScrollBody
local deleteBody=data.deleteScrollBody

local groupConfig=tipsConfig.getScrollViewConfig(tipsType)
if groupConfig==nil and addBody==nil then return end
addBody=addBody or{}
deleteBody=deleteBody or{}
local config={}
local nodeArray={}
for nodeidx,childType in pairs(groupConfig or{})do
if deleteBody[childType]==nil then
local childInfo=tipsConfig.getTipsChildConfig(childType)
local temp={}
temp.name=childInfo.src
temp.parentIdx=nodeidx
temp.args=args
nodeArray[nodeidx]=true
config[#config+1]=temp
end
end

for nodeidx,childType in pairs(addBody)do
if nodeArray[nodeidx]then
logErr('{0}添加失败，{1}节点已被占用，请先删除或更换其他节点',childType,nodeidx)
else
local childInfo=tipsConfig.getTipsChildConfig(childType)
local temp={}
temp.name=childInfo.src
temp.parentIdx=nodeidx
temp.args=args
nodeArray[nodeidx]=true
config[#config+1]=temp
end
end
self.tlen=#config
self.len=0
self.creater:createObjectList(config)
end


function tipsChildScrollView3:onFinishCreate()
self.len=self.len+1
if self.len<self.tlen then return end
local widget=self.widget
widget:SetStopChildScrollRect(self.ScrollView:getID())
widget:SetChildLocalPosY(self.Content:getID(),0)
end
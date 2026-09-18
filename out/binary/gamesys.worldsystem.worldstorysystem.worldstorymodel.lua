






local _MODULENAME="worldStoryModel"




def_table(_MODULENAME)
worldStoryModel.name=_MODULENAME


worldStoryModel.data=nil

worldStoryModel.STORYTYPE={
DIALOG=1,
COMIC=2,
VIDEO=3,
DISCIPLE=4,
ACTION=5,
CREATEROLE=6,
ANIMTREE=7,
NPCTask=8,
NPCTaskFinish=9,
}






function worldStoryModel:onAppStart()

end


function worldStoryModel:onEnterState()

end


function worldStoryModel:onLeaveState()

self.data=nil

end


function worldStoryModel:onServerDataInitFinish()

end


















function worldStoryModel:startTree(treeId,callBack,other,extraStage)
self.data={treeId,1,callBack,other,extraStage}
end

function worldStoryModel:getTree()
return self.data
end

function worldStoryModel:clearTree()
self.data=nil
end

function worldStoryModel:existTree()
return self.data~=nil
end

function worldStoryModel:setOption(option)
local nextIdx=0
local info=worldStoryModel:getInfo(self.data[1],self.data[2])
local nextData=info[3]
if nextData and#nextData>0 then
nextIdx=nextData[option or 1]or 0
end
self.data[2]=nextIdx
end

function worldStoryModel:getInfo(treeId,index)
local cfg=cfgHelper.get1(cfg_storydialoguetreeconfig_get,treeId)
return cfg and cfg.treelist[index]or nil
end





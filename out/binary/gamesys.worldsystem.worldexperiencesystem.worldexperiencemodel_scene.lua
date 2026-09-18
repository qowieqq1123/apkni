local _scene=nil


function worldExperienceModel:intoScene(world,block)
_scene={world,block}
end


function worldExperienceModel:outScene()
_scene=nil
end



function worldExperienceModel:checkScene()
return _scene~=nil
end



function worldExperienceModel:sameScene(world,block)
return self:checkScene()and _scene[1]==world and _scene[2]==block
end




function worldExperienceModel:getScene()
return _scene[1],_scene[2]
end
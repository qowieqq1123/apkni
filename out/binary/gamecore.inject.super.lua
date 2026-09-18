super={}

local data={}

function super.clear()
data={}
end

function super.set(super)
data.isSuper=super
end

function super.isSuper()
return data.isSuper or false
end